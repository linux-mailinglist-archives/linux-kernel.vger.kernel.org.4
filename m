Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FBF695996
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjBNHFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjBNHFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:05:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB21E1FE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:05:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBDBF61467
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDABFC4339B;
        Tue, 14 Feb 2023 07:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676358329;
        bh=Sc10CG7tXnAbta++D68h+N7nf85blsyylyIw0mw0xnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEFLEbx4nxwcWJsMqPaIUh9nqh7eNtoAPjmz+Al576dvfVKbzkLGD/EmWhC3tQbBZ
         NWQH8xBt/+eXuyAlfRMSSfLywIXUt4bmK6W/FvhQ/eLK+4ysoDe1aUbNv1vAwMrGuS
         CdmHNoWXyhpxs+xBYCDjLU/479hFOoGxOLexEGqw=
Date:   Tue, 14 Feb 2023 08:05:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v3 3/6] sign-file: add support sign modules in bulk
Message-ID: <Y+sytlR0lghnRtJJ@kroah.com>
References: <20230213190034.57097-1-sshedi@vmware.com>
 <20230213190034.57097-3-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213190034.57097-3-sshedi@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:30:31AM +0530, Shreenidhi Shedi wrote:
> In the existing system, we need to invoke sign-file binary for every
> module we want to sign. This patch adds support to give modules in bulk
> and it will sign them all one by one.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  scripts/sign-file.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 4732201feb96..7ad330b47d64 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -224,6 +224,7 @@ struct cmd_opts {
>  	bool replace_orig;
>  	bool raw_sig;
>  	bool sign_only;
> +	bool bulk_sign;
>  
>  #ifndef USE_PKCS7
>  	unsigned int use_keyid;
> @@ -237,6 +238,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
>  		{"help", no_argument, 0, 'h'},
>  		{"savesig", no_argument, 0, 's'},
>  		{"signonly", no_argument, 0, 'o'},
> +		{"bulksign", no_argument, 0, 'b'},
>  #ifndef USE_PKCS7
>  		{"usekeyid", no_argument, 0, 'k'},
>  #endif
> @@ -305,6 +307,10 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
>  			opts->replace_orig = true;
>  			break;
>  
> +		case 'b':
> +			opts->bulk_sign = true;
> +			break;
> +
>  		case -1:
>  			break;
>  
> @@ -342,12 +348,13 @@ int sign_file(int argc, char **argv, struct cmd_opts *opts)
>  	bool replace_orig = opts->replace_orig;
>  	bool raw_sig = opts->raw_sig;
>  	bool sign_only = opts->sign_only;
> +	bool bulk_sign = opts->bulk_sign;
>  
>  #ifndef USE_PKCS7
>  	unsigned int use_keyid = opts->use_keyid;
>  #endif
>  
> -	if (!argv[0] || argc != 1)
> +	if ((bulk_sign && dest_name) || (!bulk_sign && argc != 1))
>  		format();
>  
>  	if (dest_name && strcmp(argv[0], dest_name)) {
> @@ -378,6 +385,16 @@ int sign_file(int argc, char **argv, struct cmd_opts *opts)
>  	use_signed_attrs = PKCS7_NOATTR;
>  #endif
>  
> +	for (i = 0; i < argc; i++) {
> +		module_name = argv[i];
> +
> +		if (bulk_sign) {
> +			ERR(asprintf(&dest_name, "%s.~signed~", module_name) < 0,
> +					"asprintf");
> +			if (!replace_orig)
> +				replace_orig = true;
> +		}
> +
>  	/* Open the module file */
>  	bm = BIO_new_file(module_name, "rb");
>  	ERR(!bm, "%s", module_name);
> @@ -486,6 +503,7 @@ int sign_file(int argc, char **argv, struct cmd_opts *opts)
>  	/* Finally, if we're signing in place, replace the original. */
>  	if (replace_orig)
>  		ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.39.1
> 


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
