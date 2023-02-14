Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01437695999
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjBNHGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjBNHFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:05:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D048B1EFE3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:05:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60E2561462
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646FFC433D2;
        Tue, 14 Feb 2023 07:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676358310;
        bh=hHYrJ0uFKK6pXqyqMp3fOIFR88V+e03DYPqkojXNetY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gOpIwwo8/4+79otHLjOn+vl6lu3auYwSDJSe011O/puMnGCF34goRgqvIlwnUBtV+
         OAA1dyQ/EC8NBh21YGg6o8US6apZsZdaDDahqFls8scv+VrQBMcHavnmzw4V/DWP5L
         G1QU67jmcYHGJyJLqNpZw52qHvK5N59DWTcV5H34=
Date:   Tue, 14 Feb 2023 08:05:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v3 6/6] sign-file: improve help message
Message-ID: <Y+syo8mnSgzZBAS4@kroah.com>
References: <20230213190034.57097-1-sshedi@vmware.com>
 <20230213190034.57097-6-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213190034.57097-6-sshedi@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:30:34AM +0530, Shreenidhi Shedi wrote:
> Add a proper help message with examples on how to use this tool.
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> ---
>  scripts/sign-file.c | 49 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 0729d8df5660..d9499ea5c8cc 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -74,13 +74,44 @@ struct module_signature {
>  static const char magic_number[] = "~Module signature appended~\n";
>  
>  static __attribute__((noreturn))
> -void format(void)
> +void print_usage(int retval)
>  {
> -	fprintf(stderr,
> -		"Usage: scripts/sign-file [-dp] <hash algo> <key> <x509> <module> [<dest>]\n");
> -	fprintf(stderr,
> -		"       scripts/sign-file -s <raw sig> <hash algo> <x509> <module> [<dest>]\n");
> -	exit(2);
> +	fprintf(stderr, "Usage: scripts/sign-file [OPTIONS]... [MODULE]...\n");
> +	fprintf(stderr, "Available options:\n");
> +	fprintf(stderr, "-h, --help		Print this help message and exit\n");
> +
> +	fprintf(stderr, "\nOptional args:\n");
> +	fprintf(stderr, "-s, --savesig		Save signature\n");
> +	fprintf(stderr, "-o, --signonly		Sign only\n");
> +	fprintf(stderr, "-b, --bulksign		Sign modules in bulk\n");
> +	fprintf(stderr, "-l, --replaceorig	Replace original\n");
> +#ifndef USE_PKCS7
> +	fprintf(stderr, "-k, --usekeyid		Use key ID\n");
> +#endif
> +	fprintf(stderr, "-r, --rawsig <sig>	Raw signature\n");
> +	fprintf(stderr, "-d, --dest <dest>	Destination path ");
> +	fprintf(stderr, "(Exclusive with bulk option)\n");
> +
> +	fprintf(stderr, "\nMandatory args:\n");
> +	fprintf(stderr, "-p, --privkey <key>	Private key\n");
> +	fprintf(stderr, "-a, --hashalgo <alg>	Hash algorithm\n");
> +	fprintf(stderr, "-x, --x509 <x509>	X509\n");
> +
> +	fprintf(stderr, "\nExamples:\n");
> +
> +	fprintf(stderr, "\nRegular signing:\n");
> +	fprintf(stderr, "scripts/sign-file -a sha512 -p certs/signing_key.pem ");
> +	fprintf(stderr, "-x certs/signing_key.x509 <module>\n");
> +
> +	fprintf(stderr, "\nSigning with destination path:\n");
> +	fprintf(stderr, "scripts/sign-file -a sha512 -p certs/signing_key.pem ");
> +	fprintf(stderr, "-x certs/signing_key.x509 <module> -d <path>\n");
> +
> +	fprintf(stderr, "\nSigning modules in bulk:\n");
> +	fprintf(stderr, "scripts/sign-file -a sha512 -p certs/signing_key.pem ");
> +	fprintf(stderr, "-x certs/signing_key.x509 -b <module1> <module2> ...\n");
> +
> +	exit(retval);
>  }
>  
>  static void display_openssl_errors(int l)
> @@ -264,7 +295,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
>  #endif
>  		switch (opt) {
>  		case 'h':
> -			format();
> +			print_usage(0);
>  			break;
>  
>  		case 'r':
> @@ -315,7 +346,7 @@ static void parse_args(int argc, char **argv, struct cmd_opts *opts)
>  			break;
>  
>  		default:
> -			format();
> +			print_usage(2);
>  			break;
>  		}
>  	} while (opt != -1);
> @@ -355,7 +386,7 @@ int sign_file(int argc, char **argv, struct cmd_opts *opts)
>  #endif
>  
>  	if ((bulk_sign && dest_name) || (!bulk_sign && argc != 1))
> -		format();
> +		print_usage(2);
>  
>  	if (dest_name && strcmp(argv[0], dest_name)) {
>  		replace_orig = false;
> -- 
> 2.39.1

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
