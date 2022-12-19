Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921D665090C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiLSJGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiLSJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:06:12 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3701B7CD;
        Mon, 19 Dec 2022 01:06:10 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id f189so8021530vsc.11;
        Mon, 19 Dec 2022 01:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h/eKdzskSLkdb/WTlAr0Z8SBGaY7mnwABJ1S9BsYBDk=;
        b=a4TGtSvLMzEkTjJ58sDcWPjbzQp0HbaCdEhA/fBGZwlk2XLWVzfBjQ/irAHozUqaSR
         ZptyV2SF5lxs19MUsDq416y/FI8fN+4WpXyAJ2eGSekKBfQbD6qsD2GjfgGKTxMxw/bL
         5E73ZMr7N+WAla/ELsh87UbufIpzgkbZ6Hn1BPASsoRGrmBw+0w2FRhUpRh0vRPoq3fS
         6koSAfiRPPmmlYrWJkcDCjhrEa6NCqtQwyfzDXyXLO3vJbmx5mTDPDXEgzDpy2KVSr6w
         jlUXRoICDOhOS6N8DMGSY2E90FssMOBBFxr35bMJci+lZEiJ/GE0CIYUb9cxhoUPvDCP
         6++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/eKdzskSLkdb/WTlAr0Z8SBGaY7mnwABJ1S9BsYBDk=;
        b=VM6x0qihyb+Syqj2yFihC3atfG4NXgR3ywOce5T8CMGwIJB/b0ohHxvbHw+tmjNLyp
         HFYuiJ+ENofuGQizh9SguDhrE0Z66ZBDLbzeG/amtDreIG8dR9IKOtueQsKvFrJdYUXA
         Aff7BMn3qOZi0dQ/2gUysIcGoZHjnjTFZSHZEDIb9vDGNV9IJI5KGk0H4ccKRk9zXqRb
         JpmgSz/LF+WleWO9kUjgtpvS4nG6cSvQ4cQpMzSrVaPK1SMG4ruj30EEvmCddia5wLV1
         fccrIFdoeBE9lhkeebJxtkB9fSf30DExHT99ON6wr0XRSyL0YBvXe8vfrMKxVTK8i8Bl
         WmhQ==
X-Gm-Message-State: ANoB5plnpmIkI9/CoO3u8duWOc3XrFCg7x9e4wSpt+FlGCXzC5zo7jCt
        JWQKm/DgjhKe438FdOrmSNqx5+sAI28ZGJxw9ME=
X-Google-Smtp-Source: AA0mqf4SRAwUuTX38+ttDJu/1wWAfpI2VN++vQcBAr3i9/Ir0PtfihMVLYDcXPELdJG9qD7yxeQwkwvwQk8Ggut0Ut0=
X-Received: by 2002:a05:6102:232b:b0:3b2:fb62:6535 with SMTP id
 b11-20020a056102232b00b003b2fb626535mr8904887vsa.63.1671440769980; Mon, 19
 Dec 2022 01:06:09 -0800 (PST)
MIME-Version: 1.0
References: <20221215150214.1109074-1-hugo@hugovil.com> <20221215150214.1109074-2-hugo@hugovil.com>
In-Reply-To: <20221215150214.1109074-2-hugo@hugovil.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Mon, 19 Dec 2022 10:05:53 +0100
Message-ID: <CAH+2xPDW04NKD34RjcLO=HP1_KDxe9dvbLC9B4Rv+i3O8S58qQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] rtc: pcf2127: add variant-specific configuration structure
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den tor. 15. dec. 2022 kl. 16.19 skrev Hugo Villeneuve <hugo@hugovil.com>:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Create variant-specific configuration structures to simplify the
> implementation of new variants into this driver. It will also avoid
> to have too many tests for a specific variant, or a list of variants
> for new devices, inside the code itself.
>
> Add configuration options for the support of the NVMEM, bit CD0 in
> register WD_CTL as well as the maximum number of registers for each
> variant, instead of hardcoding the variant (PCF2127) inside the
> i2c_device_id and spi_device_id structures.
>
> Also specify a different maximum number of registers (max_register)
> for the PCF2129.
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 95 +++++++++++++++++++++++++++++++--------
>  1 file changed, 76 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 87f4fc9df68b..b9a5d47a439f 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_device.h>
>  #include <linux/regmap.h>
>  #include <linux/watchdog.h>
>
> @@ -101,10 +102,17 @@
>                 PCF2127_BIT_CTRL2_WDTF | \
>                 PCF2127_BIT_CTRL2_TSF2)
>
> +struct pcf21xx_config {
> +       int max_register;
> +       unsigned int has_nvmem:1;
> +       unsigned int has_bit_wd_ctl_cd0:1;
> +};
> +
>  struct pcf2127 {
>         struct rtc_device *rtc;
>         struct watchdog_device wdd;
>         struct regmap *regmap;
> +       const struct pcf21xx_config *cfg;
>         time64_t ts;
>         bool ts_valid;
>         bool irq_enabled;
> @@ -631,8 +639,27 @@ static const struct attribute_group pcf2127_attr_group = {
>         .attrs  = pcf2127_attrs,
>  };
>
> +enum pcf21xx_type {
> +       PCF2127,
> +       PCF2129,
> +       PCF21XX_LAST_ID
> +};
> +
> +static struct pcf21xx_config pcf21xx_cfg[] = {
> +       [PCF2127] = {
> +               .max_register = 0x1d,
> +               .has_nvmem = 1,
> +               .has_bit_wd_ctl_cd0 = 1,
> +       },
> +       [PCF2129] = {
> +               .max_register = 0x19,
> +               .has_nvmem = 0,
> +               .has_bit_wd_ctl_cd0 = 0,
> +       },
> +};
> +
>  static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> -                        int alarm_irq, const char *name, bool is_pcf2127)
> +                        int alarm_irq, const char *name, const struct pcf21xx_config *config)
>  {
>         struct pcf2127 *pcf2127;
>         int ret = 0;
> @@ -645,6 +672,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>                 return -ENOMEM;
>
>         pcf2127->regmap = regmap;
> +       pcf2127->cfg = config;
>
>         dev_set_drvdata(dev, pcf2127);
>
> @@ -688,7 +716,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>                 set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
>         }
>
> -       if (is_pcf2127) {
> +       if (pcf2127->cfg->has_nvmem) {
>                 struct nvmem_config nvmem_cfg = {
>                         .priv = pcf2127,
>                         .reg_read = pcf2127_nvmem_read,
> @@ -734,7 +762,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>                                  PCF2127_BIT_WD_CTL_TF1 |
>                                  PCF2127_BIT_WD_CTL_TF0,
>                                  PCF2127_BIT_WD_CTL_CD1 |
> -                                (is_pcf2127 ? PCF2127_BIT_WD_CTL_CD0 : 0) |
> +                                (pcf2127->cfg->has_bit_wd_ctl_cd0 ? PCF2127_BIT_WD_CTL_CD0 : 0) |
>                                  PCF2127_BIT_WD_CTL_TF1);
>         if (ret) {
>                 dev_err(dev, "%s: watchdog config (wd_ctl) failed\n", __func__);
> @@ -799,9 +827,9 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>
>  #ifdef CONFIG_OF
>  static const struct of_device_id pcf2127_of_match[] = {
> -       { .compatible = "nxp,pcf2127" },
> -       { .compatible = "nxp,pcf2129" },
> -       { .compatible = "nxp,pca2129" },
> +       { .compatible = "nxp,pcf2127", .data = &pcf21xx_cfg[PCF2127] },
> +       { .compatible = "nxp,pcf2129", .data = &pcf21xx_cfg[PCF2129] },
> +       { .compatible = "nxp,pca2129", .data = &pcf21xx_cfg[PCF2129] },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, pcf2127_of_match);
> @@ -886,26 +914,40 @@ static const struct regmap_bus pcf2127_i2c_regmap = {
>  static struct i2c_driver pcf2127_i2c_driver;
>
>  static const struct i2c_device_id pcf2127_i2c_id[] = {
> -       { "pcf2127", 1 },
> -       { "pcf2129", 0 },
> -       { "pca2129", 0 },
> +       { "pcf2127", PCF2127 },
> +       { "pcf2129", PCF2129 },
> +       { "pca2129", PCF2129 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, pcf2127_i2c_id);
>
>  static int pcf2127_i2c_probe(struct i2c_client *client)
>  {
> -       const struct i2c_device_id *id = i2c_match_id(pcf2127_i2c_id, client);
>         struct regmap *regmap;
> -       static const struct regmap_config config = {
> +       static struct regmap_config config = {
>                 .reg_bits = 8,
>                 .val_bits = 8,
> -               .max_register = 0x1d,
>         };
> +       const struct pcf21xx_config *variant;

Hi Hugo,

Patch series does not apply on 6.1 tree as pcf2127_i2c_probe() call
signature does not match[1].

static int pcf2127_i2c_probe(struct i2c_client *client,
      const struct i2c_device_id *id)


[1] https://elixir.bootlin.com/linux/v6.1/source/drivers/rtc/rtc-pcf2127.c#L888

/Bruno

>
>         if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>                 return -ENODEV;
>
> +       if (client->dev.of_node) {
> +               variant = of_device_get_match_data(&client->dev);
> +               if (!variant)
> +                       return -ENODEV;
> +       } else {
> +               enum pcf21xx_type type =
> +                       i2c_match_id(pcf2127_i2c_id, client)->driver_data;
> +
> +               if (type >= PCF21XX_LAST_ID)
> +                       return -ENODEV;
> +               variant = &pcf21xx_cfg[type];
> +       }
> +
> +       config.max_register = variant->max_register,
> +
>         regmap = devm_regmap_init(&client->dev, &pcf2127_i2c_regmap,
>                                         &client->dev, &config);
>         if (IS_ERR(regmap)) {
> @@ -915,7 +957,7 @@ static int pcf2127_i2c_probe(struct i2c_client *client)
>         }
>
>         return pcf2127_probe(&client->dev, regmap, client->irq,
> -                            pcf2127_i2c_driver.driver.name, id->driver_data);
> +                            pcf2127_i2c_driver.driver.name, variant);
>  }
>
>  static struct i2c_driver pcf2127_i2c_driver = {
> @@ -953,17 +995,32 @@ static void pcf2127_i2c_unregister_driver(void)
>  #if IS_ENABLED(CONFIG_SPI_MASTER)
>
>  static struct spi_driver pcf2127_spi_driver;
> +static const struct spi_device_id pcf2127_spi_id[];
>
>  static int pcf2127_spi_probe(struct spi_device *spi)
>  {
> -       static const struct regmap_config config = {
> +       static struct regmap_config config = {
>                 .reg_bits = 8,
>                 .val_bits = 8,
>                 .read_flag_mask = 0xa0,
>                 .write_flag_mask = 0x20,
> -               .max_register = 0x1d,
>         };
>         struct regmap *regmap;
> +       const struct pcf21xx_config *variant;
> +
> +       if (spi->dev.of_node) {
> +               variant = of_device_get_match_data(&spi->dev);
> +               if (!variant)
> +                       return -ENODEV;
> +       } else {
> +               enum pcf21xx_type type = spi_get_device_id(spi)->driver_data;
> +
> +               if (type >= PCF21XX_LAST_ID)
> +                       return -ENODEV;
> +               variant = &pcf21xx_cfg[type];
> +       }
> +
> +       config.max_register = variant->max_register,
>
>         regmap = devm_regmap_init_spi(spi, &config);
>         if (IS_ERR(regmap)) {
> @@ -974,13 +1031,13 @@ static int pcf2127_spi_probe(struct spi_device *spi)
>
>         return pcf2127_probe(&spi->dev, regmap, spi->irq,
>                              pcf2127_spi_driver.driver.name,
> -                            spi_get_device_id(spi)->driver_data);
> +                            variant);
>  }
>
>  static const struct spi_device_id pcf2127_spi_id[] = {
> -       { "pcf2127", 1 },
> -       { "pcf2129", 0 },
> -       { "pca2129", 0 },
> +       { "pcf2127", PCF2127 },
> +       { "pcf2129", PCF2129 },
> +       { "pca2129", PCF2129 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(spi, pcf2127_spi_id);
> --
> 2.30.2
>
