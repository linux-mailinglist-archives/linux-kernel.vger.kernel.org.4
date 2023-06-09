Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2678872A18F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjFIRpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFIRpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:45:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF2C3AB2;
        Fri,  9 Jun 2023 10:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 163E365A73;
        Fri,  9 Jun 2023 17:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46451C433EF;
        Fri,  9 Jun 2023 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686332720;
        bh=2cy6PKEVcmuzDkAPELPaiRev57qISGf9x+X3RciK78k=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=MoWebUYeoUC5T73d90G6PstZSZ99Lmy4S8raptrtuRF7HJYKvPo6jum//+Z1DuHMF
         /ZMLKgfAFmceFXm6tEf8ztDf5Jri9Cm9PNet+D4S+2KRuikxh7VKwk41c/Ng3GnNRO
         m1KNzlFsjizmHbL1rBQnTBD0xJYqP1qv4IGOK8PM0ecWPMcnZ36jsOGDgiD25BVokL
         7rZ9qP2MbhMw7DLbhha7zCObD6f9uEx9pf/Riq3XWk+rxafO5wds2+vjAFFn3MeBqM
         A74TecbQjp8+KUca5QUgTB/fKaCO1GMa/JiWDUXVrkvFFMAmzxVh4NNfnL/lMZtpzr
         1gtKnH7DCEY2Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 20:45:17 +0300
Message-Id: <CT8B23KI5MSP.2RS13WHU6LH7J@suppilovahvero>
Subject: Re: [PATCH] sign-file: fix memory leak
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Tianjia Zhang" <tianjia.zhang@linux.alibaba.com>,
        "David Howells" <dhowells@redhat.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230525084324.56718-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20230525084324.56718-1-tianjia.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu May 25, 2023 at 11:43 AM EEST, Tianjia Zhang wrote:
> The buffer allocated by asprintf() must be freeed.

... and it is freed by do_exit().

Short summary should really be

"sign-file: Explicitly call free(sig_file_name)"

David, what do you think of this patch is general?

Again, as an independent patch it is not really doing much at all.
Since freeing resources is a good practice, it would make sense as
a step toward doing something functionally interesting.

> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  scripts/sign-file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index b90fc9f7437f..94267cf72197 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -369,6 +369,7 @@ int main(int argc, char **argv)
>  			    "%s", sig_file_name);
>  #endif
>  			BIO_free(b);
> +			free(sig_file_name);
>  		}
> =20
>  		if (sign_only) {
> @@ -420,8 +421,10 @@ int main(int argc, char **argv)
>  	ERR(BIO_free(bd) < 0, "%s", dest_name);
> =20
>  	/* Finally, if we're signing in place, replace the original. */
> -	if (replace_orig)
> +	if (replace_orig) {
>  		ERR(rename(dest_name, module_name) < 0, "%s", dest_name);
> +		free(dest_name);
> +	}
> =20
>  	return 0;
>  }
> --=20
> 2.24.3 (Apple Git-128)

BR, Jarkko
