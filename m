Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D2F70EEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbjEXGzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239887AbjEXGy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:54:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250DDE5B;
        Tue, 23 May 2023 23:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8KBb13+iW5lHgISWlXzZrWpkxVTAvgdhmLhAgfS1JSE=; b=qNHrpBwvv/VP2p/XkyGUb2/5Hv
        go0ooqBYhQhfBNfGjsZXwBrFRYAJgTsUxldrXbKszvEoWKSj6T5y+RxFRNR7F3eyX7RPhulT1tIXE
        WlLvVgANXsbkGXACNMsQi9fG/rXawxmPc6n4mUMDr+FUGw+J8+tJsqgVNhGerf8BJZVy1OeFa0FfK
        9AapODxcZR/zp+P14eRsp6Yw6PAMmqYznKEzyc/U6ayZQgr0V8HFoBLE7NjrSfuqVXz84/6643zhO
        pGstaiKSy2Utlu2tW9o9ITjl3B855xR9FseGTnPcT5ZJvbtgRjacMdO13KIXLVHOlKGeiDnoPIdnx
        cMjTt6Zw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1iNv-00CXY0-1w;
        Wed, 24 May 2023 06:54:11 +0000
Date:   Tue, 23 May 2023 23:54:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        nick.alcock@oracle.com
Subject: Re: [PATCH v10 06/11] modpost: Add -b option for emitting built-in
 aliases
Message-ID: <ZG20k5ZtAnlYQiQ2@bombadil.infradead.org>
References: <20221219204619.2205248-1-allenwebb@google.com>
 <20230406190030.968972-1-allenwebb@google.com>
 <20230406190030.968972-7-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406190030.968972-7-allenwebb@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 02:00:25PM -0500, Allen Webb wrote:
> This adds a command line option for writing the match-id based 

Can you explain in your commit log and in code what is "match-id" ?
Do we not have this documeted anywhere perhaps where we can point to
what it is?

> built-in
> aliases to a file. A future patch extends file2alias.c to support this
> command.
> 
> The -b option accepts the output path as a parameter and requires
> vmlinuz.o to be one of the input files for the aliases to be found.
> 
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  scripts/mod/modpost.c | 30 ++++++++++++++++++++++++++++--
>  scripts/mod/modpost.h |  1 +
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index efff8078e395..2e452aec0fc6 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2173,6 +2173,19 @@ static void write_if_changed(struct buffer *b, const char *fname)
>  	write_buf(b, fname);
>  }
>  
> +/* Write the builtin aliases to the specified file. */
> +static void write_builtin(const char *fname)
> +{
> +	struct buffer buf = { };
> +	struct module *mod;
> +
> +	list_for_each_entry(mod, &modules, list)
> +		buf_write(&buf, mod->modalias_buf.p, mod->modalias_buf.pos);
> +
> +	write_if_changed(&buf, fname);
> +	free(buf.p);
> +}
> +
>  static void write_vmlinux_export_c_file(struct module *mod)
>  {
>  	struct buffer buf = { };
> @@ -2329,13 +2342,23 @@ int main(int argc, char **argv)
>  {
>  	struct module *mod;
>  	char *missing_namespace_deps = NULL;
> -	char *dump_write = NULL, *files_source = NULL;
> +	char *builtin_write = NULL, *dump_write = NULL, *files_source = NULL;
>  	int opt;
>  	LIST_HEAD(dump_lists);
>  	struct dump_list *dl, *dl2;
>  
> -	while ((opt = getopt(argc, argv, "ei:mnT:o:awENd:")) != -1) {
> +	while ((opt = getopt(argc, argv, "b:ei:mnT:o:awENd:")) != -1) {
>  		switch (opt) {
> +		case 'b':
> +			/*
> +			 * Writes the match-id based built-in module aliases to
> +			 * the specified path.
> +			 *
> +			 * vmlinuz.o needs to be one of the input files for the
> +			 * aliases to be found.
> +			 */
> +			builtin_write = optarg;
> +			break;
>  		case 'e':
>  			external_module = true;
>  			break;
> @@ -2398,6 +2421,9 @@ int main(int argc, char **argv)
>  			write_mod_c_file(mod);
>  	}
>  
> +	if (builtin_write)
> +		write_builtin(builtin_write);
> +
>  	if (missing_namespace_deps)
>  		write_namespace_deps_files(missing_namespace_deps);
>  
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 34fe5fc0b02c..c55a6aeb46bf 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -123,6 +123,7 @@ struct module {
>  	bool has_init;
>  	bool has_cleanup;
>  	struct buffer dev_table_buf;
> +	struct buffer modalias_buf;
>  	char	     srcversion[25];
>  	// Missing namespace dependencies
>  	struct list_head missing_namespaces;
> -- 
> 2.39.2
> 
