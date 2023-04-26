Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2C6EF125
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbjDZJ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbjDZJ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:26:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F759DB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:26:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f27a9c7970so6176550f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682501181; x=1685093181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2o8Rym9HE9WsYI/KEsx3tF42jIFXLUlZvQ+TcxxaAas=;
        b=nZtWi2ZDxJ6CHxhBq3HsN39pcXVI2ltvAS1EQ7bjdLypg+/m9XvP82QTz5cPl6jfef
         NJI81BFB/SIeko3w2xbjrypx2RoLLGZeWBkp+qqjwvXsBl9TjIdDvukcKT1ThFdnV0Em
         SpD1foMMKQpRG9wR/NoEXBbROnRsecIXq0WVxIYkRbTYxP34+S0G9FIJBwXGf2EOnwp1
         GwAvGSf58jeS+Ol2+urreyUH/GbnCeDJHU+CJESS23YSn4hH4VJwboYlrpZbM2XZVJvl
         KAzO30bnZi2GsHWey+5WAzM6zl7Y58BPbrJ+xykWKwc5xAKMzLphQ5e8lqEqXJ5GsQwr
         W0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682501181; x=1685093181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o8Rym9HE9WsYI/KEsx3tF42jIFXLUlZvQ+TcxxaAas=;
        b=W0ZZPZ5zRy882k6ec9KmUMb2CyggnT06gtJCknUGc85dQh9aolHVUsR+WdT16pSeRa
         dqfMX6hdYt7WqrTAM9NwpOZOYwNh/w3skWFVsQMSmlSvGWNGH+FeKxypUpiLQT7eQXi8
         QDleRCiP0VBPT4EdIjBie8LbqTnP87/yKr1Hy8r0RIjRKfuRX2/zNqACvJegBPMMiviI
         DMVroA7VTF9R9y8G1HP1EFl16r6BWLAixmlzDNdrKNaqxCp2VAkXG+WGP8HV5GmGYX7b
         YyelgMru2si0wD5feYY1TkifQW5w82huKx6QezodfyiAXGy0DzBdgOFtEwXmiCN2cEhm
         GhKw==
X-Gm-Message-State: AAQBX9c2FxErBuq18+9fF1GW0bGndjU0bMhBt0j88FwTeALqB3w57Ne6
        Y8agkYoSoVO8UwqxoUizdaTRJw==
X-Google-Smtp-Source: AKy350bbUOr6rWD5f5Ho0C942Q+JOmVTmLWm7KFaHxLxJfCHNN81F6RAI7lRhT+zJCa8SPcrYazm/w==
X-Received: by 2002:adf:e952:0:b0:2cf:e74f:2957 with SMTP id m18-20020adfe952000000b002cfe74f2957mr14770856wrn.33.1682501181276;
        Wed, 26 Apr 2023 02:26:21 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b002fda1b12a0bsm15341879wrx.2.2023.04.26.02.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 02:26:20 -0700 (PDT)
Date:   Wed, 26 Apr 2023 11:26:19 +0200
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
Message-ID: <lv4pqquqf4zpzijewmiglzqb4smbi5gwxgymgzu3keeuvzv7j6@meua3tfpwjs3>
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

I see this subtracting of 1 here and then using <= below comes from
the current print_isa_ext(), but it seems odd. How about just

static int strlen_isa_ext(void)
{
   int ext_len = 0;

   for (int i = 0; i < ARRAY_SIZE(isa_ext_arr); ++i) {
      struct riscv_isa_ext_data *edata = &isa_ext_arr[i];
      ...
   }

   return ext_len;
}

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

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

