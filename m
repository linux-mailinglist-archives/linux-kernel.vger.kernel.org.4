Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1639D6A50CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjB1BqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1BqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:46:08 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B918D227B1;
        Mon, 27 Feb 2023 17:46:00 -0800 (PST)
Date:   Tue, 28 Feb 2023 01:45:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1677548758;
        bh=8/EFcJCCy/peFfEzcKOj3xKL6933yQzHMr3Gdvjoyf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLseIwqUEjxOjC+oZQl/JQQ/IRio837y85YUCgosk+X4V2YNYAoXZ9Qn5ggdb+mKQ
         gcVkp5tS4iDAsi8kfqrDMBSJmTzqi4yVVcs0uc9U6OIkBk8kg/WC2FW+O+1goBmXZI
         8vtPVno0yj14a7v8dvgytCujO2LH9QSdyuxJLMYM=
From:   linux@weissschuh.net
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     jirislaby@kernel.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2] vc_screen: modify vcs_size() handling in vcs_read()
Message-ID: <face2b1b-0f2e-4a79-a71b-79681fc56273@t-8ch.de>
References: <1677529301-19530-1-git-send-email-george.kennedy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1677529301-19530-1-git-send-email-george.kennedy@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 27, 2023 at 03:21:41PM -0500, George Kennedy wrote:
> Restore the vcs_size() handling in vcs_read() to what
> it had been in previous version.

This still seems to be broken for me.

Testcase:

# cat /dev/vcsa1
[.. data, looks complete ..]
cat: /dev/vcsa1: No such device or address

"ret" is still unconditionally overwritten with -ENXIO at the beginning
of the loop.
And when we break the loop because everything has been read in
`if (pos >= size)` then this error is returned to userspace instead of
just `0`.

I still need the patch from 

https://lore.kernel.org/lkml/20230220064612.1783-1-linux@weissschuh.net/

> Fixes: 226fae124b2d ("vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF")
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
> v2: added Fixes
> 
>  drivers/tty/vt/vc_screen.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index f566eb1839dc..c0a2273bb998 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -414,10 +414,8 @@ vcs_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  		 */
>  		size = vcs_size(vc, attr, uni_mode);
>  		if (size < 0) {
> -			if (read)
> -				break;
>  			ret = size;
> -			goto unlock_out;
> +			break;
>  		}
>  		if (pos >= size)
>  			break;
> -- 
> 2.31.1
> 
