Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B866B6EF15E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbjDZJo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbjDZJo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:44:56 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3526110EB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:44:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2f7db354092so4236664f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682502293; x=1685094293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V/IGGADZhdXqGyELkssyerkCwrvqv8FKR2wx4hOADtI=;
        b=CYPRgwN8BcHy9Hl31pPeGginXJGobHEjaCVlPgtrwZtC1xRXBLqDeGEtIhbaP6iAvw
         nTrbukMF6LiAZQn1lOMm/lIpVq4dn9dLrQAwgv6dcyhkgi7xmiP/JsF4ZYscbZ4ojzwL
         uBtP6jt3cwtwyu5nmh9QRU18oLkQ08tHCxUA4wk0SEIho4nLzZJzlrq8WHHmgha4O97L
         ULJgvCyUk2IMhvJsumEPXVFRtJ8M59krDoHvTP6/lcQUl5+VRekYNX7Mr5dTy1XRh3CQ
         32RE+xw+vdjwu5q/ESNYTpg9rUQFz0ESg54eQXyUDl53p4v8rctpiQd2wuAqkNADZ7cF
         vGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682502293; x=1685094293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/IGGADZhdXqGyELkssyerkCwrvqv8FKR2wx4hOADtI=;
        b=JDDHtnBcuG2GjCoZV3551Wdv5Pn6pZDL+5n2fOiVaYoXR2PfuBG4j6t3CIXqKWVO5D
         Nh/KPt+7di5FyjyqIm6Ojg+nwv1luHEixbu+mldVQsRRIorUg6CDpwBHLzGJ8UVeIgWj
         WXtFEewYgxA03iMC8DGRQD7jUJ7rAZj43ytzWyhug/84dGVkpf463DlljSw0ULlr3jre
         rQXr11UyL4tSJhssDw7gMLfOFm1TZWVgyekNMDR6KIJ1MdF/po7J2jY1/TaIFuDYD5Fe
         ASD0j5g9RoMDb/1S+ff5e4VPRh/S/OPdMKy1IR2XPmHIn+a6EJmgKpfBKODvBegkBgQ0
         4uGQ==
X-Gm-Message-State: AAQBX9ddSyxG1bncMXJE79tkCxVimgIPhFeb2pLPFcvNdOHcm5n0+jOp
        paycNBY07kyBL+ycB1HPP3PffA==
X-Google-Smtp-Source: AKy350YQ3srjPhGGApWandMudboVxYKZ/a0dxTAA1HsGoL3vfwXik3j+j/1ZVUYONJSQZqQEMqgJUQ==
X-Received: by 2002:adf:db09:0:b0:2fb:9995:f707 with SMTP id s9-20020adfdb09000000b002fb9995f707mr13450462wri.67.1682502293717;
        Wed, 26 Apr 2023 02:44:53 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c219a00b003f180d5b145sm17440315wme.40.2023.04.26.02.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:44:53 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:44:52 +0200
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
Subject: Re: [PATCH 1/4] RISC-V: create ISA string separately - not as part
 of cpuinfo
Message-ID: <ndutxbscghgblr2pftn4dmri42wbor5nw6vr7fhkysb6gmgyat@fwwdzcuiwfdv>
References: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
 <20230424194911.264850-2-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424194911.264850-2-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 09:49:08PM +0200, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> The isa string is a very central part of the RISC-V architecture, so will
> be needed in other places as well.
> 
> So in a first step decouple the generation of the runtime isa-string from
> /proc/cpuinfo - its current only user.
> 
> The resulting string should not differ from the previously generated one.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/kernel/cpu.c | 70 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 62 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 3df38052dcbd..ebc478f0a16c 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -193,10 +193,33 @@ static struct riscv_isa_ext_data isa_ext_arr[] = {
>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
>  
> -static void print_isa_ext(struct seq_file *f)
> +static int strlen_isa_ext(void)
>  {
>  	struct riscv_isa_ext_data *edata;
> -	int i = 0, arr_sz;
> +	int ext_len = 0, i, arr_sz;
> +
> +	arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
> +
> +	/* No extension support available */
> +	if (arr_sz <= 0)
> +		return 0;
> +
> +	for (i = 0; i <= arr_sz; i++) {
> +		edata = &isa_ext_arr[i];
> +		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
> +			continue;
> +
> +		/* string length + underscore */
> +		ext_len += strlen(edata->uprop) + 1;
> +	}
> +
> +	return ext_len;
> +}
> +
> +static void strcat_isa_ext(char *isa_str)
> +{
> +	struct riscv_isa_ext_data *edata;
> +	int i, arr_sz;
>  
>  	arr_sz = ARRAY_SIZE(isa_ext_arr) - 1;
>  
> @@ -208,7 +231,8 @@ static void print_isa_ext(struct seq_file *f)
>  		edata = &isa_ext_arr[i];
>  		if (!__riscv_isa_extension_available(NULL, edata->isa_ext_id))
>  			continue;
> -		seq_printf(f, "_%s", edata->uprop);
> +		strcat(isa_str, "_");
> +		strcat(isa_str, edata->uprop);
>  	}
>  }
>  
> @@ -220,19 +244,49 @@ static void print_isa_ext(struct seq_file *f)
>   */
>  static const char base_riscv_exts[13] = "imafdqcbkjpvh";
>  
> -static void print_isa(struct seq_file *f, const char *isa)
> +static char *riscv_create_isa_string(const char *isa)
>  {
> +	int maxlen = 4;
> +	char *isa_str;
>  	int i;
>  
> -	seq_puts(f, "isa\t\t: ");
> +	/* calculate the needed string length */
> +	for (i = 0; i < sizeof(base_riscv_exts); i++)
> +		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
> +			maxlen++;
> +	maxlen += strlen_isa_ext();
> +
> +	isa_str = kzalloc(maxlen, GFP_KERNEL);
> +	if (!isa_str)
> +		return ERR_PTR(-ENOMEM);
> +
>  	/* Print the rv[64/32] part */
> -	seq_write(f, isa, 4);
> +	strncat(isa_str, isa, 4);
> +
>  	for (i = 0; i < sizeof(base_riscv_exts); i++) {
>  		if (__riscv_isa_extension_available(NULL, base_riscv_exts[i] - 'a'))
>  			/* Print only enabled the base ISA extensions */
> -			seq_write(f, &base_riscv_exts[i], 1);
> +			strncat(isa_str, &base_riscv_exts[i], 1);
> +	}
> +
> +	strcat_isa_ext(isa_str);
> +
> +	return isa_str;
> +}
> +
> +static void print_isa(struct seq_file *f, const char *isa)
> +{
> +	char *isa_str;
> +
> +	seq_puts(f, "isa\t\t: ");
> +
> +	isa_str = riscv_create_isa_string(isa);

Shouldn't there be another patch in this series that switches this
to using the new riscv_base_platform. The allocation/regeneration/freeing
doesn't seem necessary each time we cat cpuinfo.

Thanks,
drew

> +	if (!IS_ERR(isa_str)) {
> +		seq_write(f, isa_str, strlen(isa_str));
> +		kfree(isa_str);
> +	} else {
> +		seq_puts(f, "unknown");
>  	}
> -	print_isa_ext(f);
>  	seq_puts(f, "\n");
>  }
>  
> -- 
> 2.39.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
