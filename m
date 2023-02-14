Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB969695997
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjBNHFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjBNHFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:05:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4E41E2BD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:05:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57C8DB81BD5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2D9C433D2;
        Tue, 14 Feb 2023 07:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676358333;
        bh=uiHruZ9aySPrOVTRn3cMwf20Ah3LiWPmzH79C4IxF4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQ1UPw9upSV4rk7qE1qSww3LdbVwV2+C50rxsXS9ilL/100bPITBef9Bw3jHWtbPL
         uyEVnDGMSXOu+x6dNgByxt+aDfSQsbD7RHRuS5PSF0PzQJJ2Tj+f5Qw3B1f9WijWR0
         RR/CfAQCgysoQ8SxcLyrAqi/VHLwcK4AqUYm0YYs=
Date:   Tue, 14 Feb 2023 08:05:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v3 2/6] sign-file: move file signing logic to its own
 function
Message-ID: <Y+syuuHH5fTTJDbE@kroah.com>
References: <20230213190034.57097-1-sshedi@vmware.com>
 <20230213190034.57097-2-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213190034.57097-2-sshedi@vmware.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:30:30AM +0530, Shreenidhi Shedi wrote:
> Keep the main function bare minimal and do less in main function.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  scripts/sign-file.c | 69 +++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 30 deletions(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index cf3acbb13013..4732201feb96 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -230,7 +230,7 @@ struct cmd_opts {
>  #endif
>  };
>  
> -void parse_args(int argc, char **argv, struct cmd_opts *opts)
> +static void parse_args(int argc, char **argv, struct cmd_opts *opts)
>  {
>  	struct option cmd_options[] = {
>  		/* These options set a flag. */
> @@ -315,10 +315,10 @@ void parse_args(int argc, char **argv, struct cmd_opts *opts)
>  	} while (opt != -1);
>  }
>  
> -int main(int argc, char **argv)
> +int sign_file(int argc, char **argv, struct cmd_opts *opts)
>  {
>  	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
> -	unsigned char buf[4096];
> +	unsigned char buf[4096] = {0};
>  	unsigned long module_size, sig_size;
>  	unsigned int use_signed_attrs;
>  	const EVP_MD *digest_algo;
> @@ -331,36 +331,20 @@ int main(int argc, char **argv)
>  	X509 *x509;
>  	BIO *bd, *bm;
>  	int i, n;
> -	struct cmd_opts opts = {0};
>  
> -	OpenSSL_add_all_algorithms();
> -	ERR_load_crypto_strings();
> -	ERR_clear_error();
> -
> -	key_pass = getenv("KBUILD_SIGN_PIN");
> +	char *hash_algo = opts->hash_algo;
> +	char *dest_name = opts->dest_name;
> +	char *private_key_name = opts->private_key_name;
> +	char *raw_sig_name = opts->raw_sig_name;
> +	char *x509_name = opts->x509_name;
> +	char *module_name = opts->module_name;
> +	bool save_sig = opts->save_sig;
> +	bool replace_orig = opts->replace_orig;
> +	bool raw_sig = opts->raw_sig;
> +	bool sign_only = opts->sign_only;
>  
>  #ifndef USE_PKCS7
> -	use_signed_attrs = CMS_NOATTR;
> -#else
> -	use_signed_attrs = PKCS7_NOATTR;
> -#endif
> -	parse_args(argc, argv, &opts);
> -	argc -= optind;
> -	argv += optind;
> -
> -	char *hash_algo = opts.hash_algo;
> -	char *dest_name = opts.dest_name;
> -	char *private_key_name = opts.private_key_name;
> -	char *raw_sig_name = opts.raw_sig_name;
> -	char *x509_name = opts.x509_name;
> -	char *module_name = opts.module_name;
> -	bool save_sig = opts.save_sig;
> -	bool replace_orig = opts.replace_orig;
> -	bool raw_sig = opts.raw_sig;
> -	bool sign_only = opts.sign_only;
> -
> -#ifndef USE_PKCS7
> -	unsigned int use_keyid = opts.use_keyid;
> +	unsigned int use_keyid = opts->use_keyid;
>  #endif
>  
>  	if (!argv[0] || argc != 1)
> @@ -381,6 +365,19 @@ int main(int argc, char **argv)
>  		exit(3);
>  	}
>  #endif
> +
> +	OpenSSL_add_all_algorithms();
> +	ERR_load_crypto_strings();
> +	ERR_clear_error();
> +
> +	key_pass = getenv("KBUILD_SIGN_PIN");
> +
> +#ifndef USE_PKCS7
> +	use_signed_attrs = CMS_NOATTR;
> +#else
> +	use_signed_attrs = PKCS7_NOATTR;
> +#endif
> +
>  	/* Open the module file */
>  	bm = BIO_new_file(module_name, "rb");
>  	ERR(!bm, "%s", module_name);
> @@ -492,3 +489,15 @@ int main(int argc, char **argv)
>  
>  	return 0;
>  }
> +
> +int main(int argc, char **argv)
> +{
> +	struct cmd_opts opts = {0};
> +
> +	parse_args(argc, argv, &opts);
> +
> +	argc -= optind;
> +	argv += optind;
> +
> +	return sign_file(argc, argv, &opts);
> +}
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
