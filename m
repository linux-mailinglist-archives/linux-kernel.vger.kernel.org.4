Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D052B69E5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjBURSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjBURS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:18:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1DD8A72
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:18:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 208AF6115C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EEBC433D2;
        Tue, 21 Feb 2023 17:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676999906;
        bh=jOWwYvnUv1u99ar4E3cDb23eVdnJ9cfJenGiLUt2XVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOUtyc/kSn0/E9sH9/j+kS3t7jNSuMMMr2Lkt+RouLXawbrkSk3W6XKSbWAa/9LDX
         r3NhfmuSk5i0fmGqWWZb7EV/gce59nDZTzhbq1fJXtrjsRTrAunPKpc3IivduPJQuw
         APjAFgyo1/2cylPrHrDo14DzZI0mnf6HEn7ZX8S8=
Date:   Tue, 21 Feb 2023 18:18:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
Subject: Re: [ PATCH v4 1/6] sign-file: refactor argument parsing logic
Message-ID: <Y/T833JJr13U2f1T@kroah.com>
References: <20230221170804.3267242-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221170804.3267242-1-sshedi@vmware.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:37:59PM +0530, Shreenidhi Shedi wrote:
> From: Shreenidhi Shedi <yesshedi@gmail.com>
> 
> - Use getopt_long_only for parsing input args
> - Use more easy to remember command line argument names
> 
> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
> ---
>  scripts/sign-file.c | 156 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 122 insertions(+), 34 deletions(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 598ef5465f82..dbbde1aef3d9 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -213,15 +213,111 @@ static X509 *read_x509(const char *x509_name)
>  	return x509;
>  }
>  
> +struct cmd_opts {
> +	char *hash_algo;
> +	char *dest_name;
> +	char *private_key_name;
> +	char *raw_sig_name;
> +	char *x509_name;
> +	char *module_name;
> +	bool save_sig;
> +	bool replace_orig;
> +	bool raw_sig;
> +	bool sign_only;
> +
> +#ifndef USE_PKCS7
> +	unsigned int use_keyid;
> +#endif
> +};
> +
> +static void parse_args(int argc, char **argv, struct cmd_opts *opts)
> +{
> +	struct option cmd_options[] = {
> +		/* These options set a flag. */
> +		{"help", no_argument, 0, 'h'},
> +		{"savesig", no_argument, 0, 's'},
> +		{"signonly", no_argument, 0, 'o'},
> +#ifndef USE_PKCS7
> +		{"usekeyid", no_argument, 0, 'k'},
> +#endif
> +		{"rawsig", required_argument, 0, 'r'},
> +		{"privkey", required_argument, 0, 'p'},
> +		{"hashalgo", required_argument, 0, 'a'},
> +		{"x509", required_argument, 0, 'x'},
> +		{"dest", required_argument, 0, 'd'},
> +		{"replaceorig", required_argument, 0, 'l'},
> +		{0, 0, 0, 0}
> +	};
> +
> +	int opt;
> +	int opt_index = 0;
> +
> +	do {
> +#ifndef USE_PKCS7
> +		opt = getopt_long_only(argc, argv, "hsobr:p:a:x:d:l:",
> +				cmd_options, &opt_index);
> +#else
> +		opt = getopt_long_only(argc, argv, "hsobkr:p:a:x:d:l:",
> +				cmd_options, &opt_index);
> +#endif
> +		switch (opt) {
> +		case 'h':
> +			format();
> +			break;
> +
> +		case 'r':
> +			opts->raw_sig = true;
> +			opts->raw_sig_name = optarg;
> +			break;
> +
> +		case 's':
> +			opts->save_sig = true;
> +			break;
> +
> +		case 'o':
> +			opts->sign_only = true;
> +			opts->save_sig = true;
> +			break;
> +
> +#ifndef USE_PKCS7
> +		case 'k':
> +			opts->use_keyid = CMS_USE_KEYID;
> +			break;
> +#endif
> +
> +		case 'p':
> +			opts->private_key_name = optarg;
> +			break;
> +
> +		case 'a':
> +			opts->hash_algo = optarg;
> +			break;
> +
> +		case 'x':
> +			opts->x509_name = optarg;
> +			break;
> +
> +		case 'd':
> +			opts->dest_name = optarg;
> +			break;
> +
> +		case 'l':
> +			opts->replace_orig = true;
> +			break;
> +
> +		case -1:
> +			break;
> +
> +		default:
> +			format();
> +			break;
> +		}
> +	} while (opt != -1);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
> -	char *hash_algo = NULL;
> -	char *private_key_name = NULL, *raw_sig_name = NULL;
> -	char *x509_name, *module_name, *dest_name;
> -	bool save_sig = false, replace_orig;
> -	bool sign_only = false;
> -	bool raw_sig = false;
>  	unsigned char buf[4096];
>  	unsigned long module_size, sig_size;
>  	unsigned int use_signed_attrs;
> @@ -229,13 +325,14 @@ int main(int argc, char **argv)
>  	EVP_PKEY *private_key;
>  #ifndef USE_PKCS7
>  	CMS_ContentInfo *cms = NULL;
> -	unsigned int use_keyid = 0;
>  #else
>  	PKCS7 *pkcs7 = NULL;
>  #endif
>  	X509 *x509;
>  	BIO *bd, *bm;
> -	int opt, n;
> +	int n;
> +	struct cmd_opts opts = {0};
> +
>  	OpenSSL_add_all_algorithms();
>  	ERR_load_crypto_strings();
>  	ERR_clear_error();
> @@ -247,37 +344,29 @@ int main(int argc, char **argv)
>  #else
>  	use_signed_attrs = PKCS7_NOATTR;
>  #endif
> +	parse_args(argc, argv, &opts);
> +	argc -= optind;
> +	argv += optind;
> +
> +	char *hash_algo = opts.hash_algo;
> +	char *dest_name = opts.dest_name;
> +	char *private_key_name = opts.private_key_name;
> +	char *raw_sig_name = opts.raw_sig_name;
> +	char *x509_name = opts.x509_name;
> +	char *module_name = opts.module_name;
> +	bool save_sig = opts.save_sig;
> +	bool replace_orig = opts.replace_orig;
> +	bool raw_sig = opts.raw_sig;
> +	bool sign_only = opts.sign_only;
>  
> -	do {
> -		opt = getopt(argc, argv, "sdpk");
> -		switch (opt) {
> -		case 's': raw_sig = true; break;
> -		case 'p': save_sig = true; break;
> -		case 'd': sign_only = true; save_sig = true; break;
>  #ifndef USE_PKCS7
> -		case 'k': use_keyid = CMS_USE_KEYID; break;
> +	unsigned int use_keyid = opts.use_keyid;
>  #endif
> -		case -1: break;
> -		default: format();
> -		}
> -	} while (opt != -1);
>  
> -	argc -= optind;
> -	argv += optind;
> -	if (argc < 4 || argc > 5)
> +	if (!argv[0] || argc != 1)
>  		format();
>  
> -	if (raw_sig) {
> -		raw_sig_name = argv[0];
> -		hash_algo = argv[1];
> -	} else {
> -		hash_algo = argv[0];
> -		private_key_name = argv[1];
> -	}
> -	x509_name = argv[2];
> -	module_name = argv[3];
> -	if (argc == 5 && strcmp(argv[3], argv[4]) != 0) {
> -		dest_name = argv[4];
> +	if (dest_name && strcmp(argv[0], dest_name)) {
>  		replace_orig = false;
>  	} else {
>  		ERR(asprintf(&dest_name, "%s.~signed~", module_name) < 0,
> @@ -292,7 +381,6 @@ int main(int argc, char **argv)
>  		exit(3);
>  	}
>  #endif
> -
>  	/* Open the module file */
>  	bm = BIO_new_file(module_name, "rb");
>  	ERR(!bm, "%s", module_name);
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
