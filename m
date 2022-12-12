Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B67164A95E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiLLVPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiLLVPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:15:21 -0500
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81AE1B1CB;
        Mon, 12 Dec 2022 13:13:30 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id EB248403; Mon, 12 Dec 2022 15:13:19 -0600 (CST)
Date:   Mon, 12 Dec 2022 15:13:19 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] LoadPin: Ignore the "contents" argument of the LSM hooks
Message-ID: <20221212211319.GA15511@mail.hallyn.com>
References: <20221209195453.never.494-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209195453.never.494-kees@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 11:54:57AM -0800, Kees Cook wrote:
> LoadPin only enforces the read-only origin of kernel file reads. Whether
> or not it was a partial read isn't important. Remove the overly
> conservative checks so that things like partial firmware reads will
> succeed (i.e. reading a firmware header).
> 
> Fixes: 2039bda1fa8d ("LSM: Add "contents" flag to kernel_read_file hook")
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

Seems reasonable.

So the patch which introduced this was
2039bda1f: LSM: Add "contents" flag to kernel_read_file hook
It sounds like the usage of @contents which it added to ima still
makes sense.  But what about the selinux_kernel_read_file() one?

> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/loadpin/loadpin.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index de41621f4998..110a5ab2b46b 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -122,21 +122,11 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
>  	}
>  }
>  
> -static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
> -			     bool contents)
> +static int loadpin_check(struct file *file, enum kernel_read_file_id id)
>  {
>  	struct super_block *load_root;
>  	const char *origin = kernel_read_file_id_str(id);
>  
> -	/*
> -	 * If we will not know that we'll be seeing the full contents
> -	 * then we cannot trust a load will be complete and unchanged
> -	 * off disk. Treat all contents=false hooks as if there were
> -	 * no associated file struct.
> -	 */
> -	if (!contents)
> -		file = NULL;
> -
>  	/* If the file id is excluded, ignore the pinning. */
>  	if ((unsigned int)id < ARRAY_SIZE(ignore_read_file_id) &&
>  	    ignore_read_file_id[id]) {
> @@ -192,9 +182,25 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
>  	return 0;
>  }
>  
> +static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
> +			     bool contents)
> +{
> +	/*
> +	 * LoadPin only cares about the _origin_ of a file, not its
> +	 * contents, so we can ignore the "are full contents available"
> +	 * argument here.
> +	 */
> +	return loadpin_check(file, id);
> +}
> +
>  static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
>  {
> -	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
> +	/*
> +	 * LoadPin only cares about the _origin_ of a file, not its
> +	 * contents, so a NULL file is passed, and we can ignore the
> +	 * state of "contents".
> +	 */
> +	return loadpin_check(NULL, (enum kernel_read_file_id) id);
>  }
>  
>  static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
> -- 
> 2.34.1
