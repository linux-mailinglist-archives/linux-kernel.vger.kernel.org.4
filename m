Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4036EF146
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbjDZJhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbjDZJhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:37:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9653393
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:37:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2f86ee42669so6608520f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682501863; x=1685093863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GGzFSv98HDJv+ep2+uGlvHglFQwWd3hEUaewWLWJTeM=;
        b=FeUkYEDsMultKQCqlNuwdPzZXXJ8w3+yKweQ1IN3IxJsczSEQpi8fQFiw8xxxcRxm6
         l9Bd/Wrd3uvIUn6QdB6rS6RQ/HfbHGZMFNnCTzZpuIzTlaBC94c4lH5WcW8bQke2oSP4
         2MhLZZooI6oiAvZ//JzkgpfgDmJjJMuZU+Ih8RqbFb8gQ3rqRn3YHBclXcI8fclXPrWx
         ws1gz4pFYRpzokjUGtEa2ebrenmwvSQOrAoUn8iPoJjQTydesn2Oy0m7pT3ITUrfsAJy
         vqzklpLRaMUh9kRX57T2UdDofMCEguEo4kFFiJ5wAQojjNGDl25N784N0rco1be9/Mwa
         HfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682501863; x=1685093863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGzFSv98HDJv+ep2+uGlvHglFQwWd3hEUaewWLWJTeM=;
        b=Gz7mskptVZz9oDEp2E926bfGz2IVh8Vy/MTwPkp8K6v6PFFBRQuZJcTFYpUnp0d1Sn
         /TyenO312B9zBOq2I6F/E1IA/IjlzcPDCMQhgPJ3OhSJcT0FrIju9+OZxrchLtiL3NER
         z+lvRg/yKNLiLwT3iQsLIks92shvLPY3rXmU3lXp5Lr+j1EwG5f8nQ96ACIO5CPMwb2+
         WhXrpRCzlELjyisa+N9SdxmTXcbo1IpSEUB7M/Mn30EOZs8PTbefeesaEa6g6IQWV7iE
         x2cjRcv6gLb0ZghN1FfchEfwSf3X5b5xkL8RC7iGHjMZtu2M1ItUvHq4NqxLsN/e0Hen
         gPpg==
X-Gm-Message-State: AAQBX9fXitB/p1E/QtRJ7ZgWKmgWEbFYTjGZUpRelL7vS8X7Eh6ztQJd
        fmouAd6j4Cr/IT9MKPUA2MLTBg==
X-Google-Smtp-Source: AKy350YJ1K1zbrC6c+Kki0A/2SSZsAEfJnJYK7MMO6Is0v4g8MMDqnBoQ9d4/8EPfclfIUK0hbUwWQ==
X-Received: by 2002:adf:fc4f:0:b0:2f7:725d:e7b4 with SMTP id e15-20020adffc4f000000b002f7725de7b4mr13264555wrs.18.1682501863040;
        Wed, 26 Apr 2023 02:37:43 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4d0e000000b002efb4f2d240sm15266468wrt.87.2023.04.26.02.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:37:42 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:37:41 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        paul.walmsley@sifive.com, kito.cheng@sifive.com, jrtc27@jrtc27.com,
        conor.dooley@microchip.com, matthias.bgg@gmail.com,
        heinrich.schuchardt@canonical.com, greentime.hu@sifive.com,
        nick.knight@sifive.com, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, richard.henderson@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 2/4] RISC-V: don't parse dt isa string to get rv32/rv64
Message-ID: <m5areidrpevtl6kbdoaikrvaxhq2cttgzklncqq3uygrsduzuf@anfyqmxtge73>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <20230424194911.264850-3-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424194911.264850-3-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 09:49:09PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> When filling hwcap the kernel already expects the isa string to start with
> rv32 if CONFIG_32BIT and rv64 if CONFIG_64BIT.
> 
> So when recreating the runtime isa-string we can also just go the other way
> to get the correct starting point for it.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/kernel/cpu.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ebc478f0a16c..06c2f587a176 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -244,7 +244,7 @@ static void strcat_isa_ext(char *isa_str)
>   */
>  static const char base_riscv_exts[13] = "imafdqcbkjpvh";
>  
> -static char *riscv_create_isa_string(const char *isa)
> +static char *riscv_create_isa_string(void)
>  {
>  	int maxlen = 4;
>  	char *isa_str;
> @@ -261,7 +261,11 @@ static char *riscv_create_isa_string(const char *isa)
>  		return ERR_PTR(-ENOMEM);
>  
>  	/* Print the rv[64/32] part */
> -	strncat(isa_str, isa, 4);
> +#if IS_ENABLED(CONFIG_32BIT)
> +	strncat(isa_str, "rv32", 4);
> +#elif IS_ENABLED(CONFIG_64BIT)
> +	strncat(isa_str, "rv64", 4);
> +#endif

I see we do the validation in riscv_fill_hwcap() and we also do this
#ifdeffery there, but I can't see any reason not to do

 if (IS_ENABLED(CONFIG_32BIT))
    ...
 else
    ...

instead.


>  
>  	for (i = 0; i < sizeof(base_riscv_exts); i++) {
>  		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
> @@ -280,7 +284,7 @@ static void print_isa(struct seq_file *f, const char *isa)
>  
>  	seq_puts(f, "isa\t\t: ");
>  
> -	isa_str = riscv_create_isa_string(isa);
> +	isa_str = riscv_create_isa_string();

Why are we still passing 'isa' to print_isa()? It's now unused and
print_isa()'s single caller only fetches it from the DT for this
one purpose, so that of_property_read_string() call could now also
be dropped.

>  	if (!IS_ERR(isa_str)) {
>  		seq_write(f, isa_str, strlen(isa_str));
>  		kfree(isa_str);
> -- 
> 2.39.0
>

Thanks,
drew
