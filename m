Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDC16F8244
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjEELrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjEELrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:47:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075151A130
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:47:41 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55a20a56a01so28518797b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683287260; x=1685879260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hNaee5jT4r63xvUym/C1U2MbA5Vtzx+DhpZmC3dvmCA=;
        b=v4QfazCLF2+lLYpJh/mtssXqo31dnqlCB7CcushsewE51j6qLs1mZBV2q0AGRL2wX0
         kBwRq5vgDkfVldMmVf3cc8dKYkPuyiXlv+sDLkjp4iUPLrktf4G0mpdRnIMWS5iNHYDk
         3RvaYRpGefJCXuaEQXKh5cy/SdPRm0hfOIk6tA5bpEJMD5IEhDRxx7f6DHzp2YwBiKO2
         GcqA7ssxrNwWvg+rXMfYCsCUIMX/TAnpidDx++xtNsgiTw/kx7ZTyS4H0fTd2AZsBiUL
         ITbd/w8wAb0jxxUx1NmySijFflqCZvlxsOxZ4fHvcaVODNC01/xCBUDfI/7N0D1NVPWA
         ixSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683287260; x=1685879260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNaee5jT4r63xvUym/C1U2MbA5Vtzx+DhpZmC3dvmCA=;
        b=F20GfjLkGqVtSiYiE/e450xIUFJ87ybjRoz8kxGykUjqQpHUIINlAQ0JjnOK4lhKzK
         ociFt14+jO90EDDBAxfp94bpL0+Hl7k/AdCkJ2R5L1+USsgYqgWVwlUH9Sf4aK8XQX0O
         1dXvn+zwt0fW2aNinyHPbfe67XU+MI5S9GPixWjRAKEikWh+TEYLP/raOsHTzknA+eWj
         RwDXvjMLy51Iap90bwcoj6Hh4VLUfCNYBckkFy1JCfIODBPOV2u+EU+j8EyjZYbAilzO
         cQG/Ts7rZJqiQE5xVoFPyIuCkwJBilnOcvnbAJKlZikxiwLD/bOh2O9z82karNlF44Vv
         Jl5A==
X-Gm-Message-State: AC+VfDylSchdz7PqMkEvtyL7jgKHJ978OTQlvF0c9K2E5kwtHm3QZ+Bt
        SG6RPGZNTxIsP74e/n38kg+iBEf+L/WWlbPXSOXs1jdkJMeNDSu2
X-Google-Smtp-Source: ACHHUZ56aTAz21+KFzw1C8RUNW0Ovx2Sry6kryJ9wll+mjDkHl+WBhyC71Xor18WWzdF2mdm/Rqgchw83fuG9U2stj4=
X-Received: by 2002:a81:6208:0:b0:55a:7faa:42b9 with SMTP id
 w8-20020a816208000000b0055a7faa42b9mr1175730ywb.35.1683287260166; Fri, 05 May
 2023 04:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
 <20230505064039.1630025-4-bhupesh.sharma@linaro.org> <84dd0aa0-0ee3-fc85-449d-a9509d7bb765@linaro.org>
In-Reply-To: <84dd0aa0-0ee3-fc85-449d-a9509d7bb765@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 5 May 2023 14:47:29 +0300
Message-ID: <CAA8EJprkTnJY+dybK4EE2vJgn-y8=RDi_8Cmt1yO-bRiySqcqQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] usb: misc: eud: Add driver support for SM6115 / SM4250
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 at 14:05, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 5.05.2023 08:40, Bhupesh Sharma wrote:
> > Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.
> >
> > On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
> > needs to be accessed only via the secure world (through 'scm'
> > calls).
> >
> > Also, the enable bit inside 'tcsr_check_reg' needs to be set
> > first to set the eud in 'enable' mode on these SoCs.
> >
> > Since this difference comes from how the firmware is configured, so
> > the driver now relies on the presence of an extra boolean DT property
> > to identify if secure access is needed.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  drivers/usb/misc/Kconfig    |  1 +
> >  drivers/usb/misc/qcom_eud.c | 74 +++++++++++++++++++++++++++++++++----
> >  2 files changed, 68 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > index 99b15b77dfd5..fe1b5fec1dfc 100644
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
> >  config USB_QCOM_EUD
> >       tristate "QCOM Embedded USB Debugger(EUD) Driver"
> >       depends on ARCH_QCOM || COMPILE_TEST
> > +     select QCOM_SCM
> >       select USB_ROLE_SWITCH
> >       help
> >         This module enables support for Qualcomm Technologies, Inc.
> > diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> > index b7f13df00764..18a2dee3b4b9 100644
> > --- a/drivers/usb/misc/qcom_eud.c
> > +++ b/drivers/usb/misc/qcom_eud.c
> > @@ -5,12 +5,14 @@
> >
> >  #include <linux/bitops.h>
> >  #include <linux/err.h>
> > +#include <linux/firmware/qcom/qcom_scm.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/sysfs.h>
> > @@ -22,23 +24,35 @@
> >  #define EUD_REG_VBUS_INT_CLR 0x0080
> >  #define EUD_REG_CSR_EUD_EN   0x1014
> >  #define EUD_REG_SW_ATTACH_DET        0x1018
> > -#define EUD_REG_EUD_EN2        0x0000
> > +#define EUD_REG_EUD_EN2              0x0000
> >
> >  #define EUD_ENABLE           BIT(0)
> > -#define EUD_INT_PET_EUD      BIT(0)
> > +#define EUD_INT_PET_EUD              BIT(0)
> >  #define EUD_INT_VBUS         BIT(2)
> >  #define EUD_INT_SAFE_MODE    BIT(4)
> >  #define EUD_INT_ALL          (EUD_INT_VBUS | EUD_INT_SAFE_MODE)
> >
> > +#define EUD_EN2_SECURE_EN    BIT(0)
> > +#define EUD_EN2_NONSECURE_EN (1)
> BIT(0) == 1, is that actually a separate register or does it just
> reflect whether scm_writel is used?
>
> If the latter, perhaps it'd be okay to just call it EUD_EN2_EN or
> something along those lines? Isn't that perhaps what the docs call it?
>
>
> > +#define EUD_EN2_DISABLE              (0)
> > +#define TCSR_CHECK_EN                BIT(0)
> > +
> > +struct eud_soc_cfg {
> > +     u32 tcsr_check_offset;
> > +};
> > +
> >  struct eud_chip {
> >       struct device                   *dev;
> >       struct usb_role_switch          *role_sw;
> > +     const struct eud_soc_cfg        *eud_cfg;
> >       void __iomem                    *base;
> >       void __iomem                    *mode_mgr;
> >       unsigned int                    int_status;
> >       int                             irq;
> >       bool                            enabled;
> >       bool                            usb_attached;
> > +     bool                            secure_mode_enable;
> Since it's only used in the probe function now, we can get rid
> of it!
>
> > +     phys_addr_t                     secure_mode_mgr;
> >  };
> >
> >  static int enable_eud(struct eud_chip *priv)
> > @@ -46,7 +60,11 @@ static int enable_eud(struct eud_chip *priv)
> >       writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
> >       writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
> >                       priv->base + EUD_REG_INT1_EN_MASK);
> > -     writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> > +
> > +     if (priv->secure_mode_mgr)
> > +             qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_SECURE_EN);
> > +     else
> > +             writel(EUD_EN2_NONSECURE_EN, priv->mode_mgr + EUD_REG_EUD_EN2);
> >
> >       return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
> >  }
> > @@ -54,7 +72,11 @@ static int enable_eud(struct eud_chip *priv)
> >  static void disable_eud(struct eud_chip *priv)
> >  {
> >       writel(0, priv->base + EUD_REG_CSR_EUD_EN);
> > -     writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> > +
> > +     if (priv->secure_mode_mgr)
> > +             qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_DISABLE);
> > +     else
> > +             writel(EUD_EN2_DISABLE, priv->mode_mgr + EUD_REG_EUD_EN2);
> >  }
> >
> >  static ssize_t enable_show(struct device *dev,
> > @@ -178,6 +200,8 @@ static void eud_role_switch_release(void *data)
> >  static int eud_probe(struct platform_device *pdev)
> >  {
> >       struct eud_chip *chip;
> > +     struct resource *res;
> > +     phys_addr_t tcsr_base, tcsr_check;
> >       int ret;
> >
> >       chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> > @@ -200,9 +224,40 @@ static int eud_probe(struct platform_device *pdev)
> >       if (IS_ERR(chip->base))
> >               return PTR_ERR(chip->base);
> >
> > -     chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> > -     if (IS_ERR(chip->mode_mgr))
> > -             return PTR_ERR(chip->mode_mgr);
> > +     chip->secure_mode_enable = of_property_read_bool(chip->dev->of_node,
> > +                                             "qcom,secure-mode-enable");
> > +     /*
> > +      * EUD block on a few Qualcomm SoCs need secure register access.
> > +      * Check for the same.
> > +      */
> > +     if (chip->secure_mode_enable) {
> if (of_property_read_bool...)
>
> > +             res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +             if (!res)
> > +                     return dev_err_probe(chip->dev, -ENODEV,
> > +                                          "failed to get secure_mode_mgr reg base\n");
> > +
> > +             chip->secure_mode_mgr = res->start;
> > +     } else {
> > +             chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> > +             if (IS_ERR(chip->mode_mgr))
> > +                     return PTR_ERR(chip->mode_mgr);
> > +     }
> > +
> > +     /* Check for any SoC specific config data */
> > +     chip->eud_cfg = of_device_get_match_data(&pdev->dev);
> > +     if (chip->eud_cfg) {
> > +             res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tcsr-base");
> > +             if (!res)
> > +                     return dev_err_probe(chip->dev, -ENODEV,
> > +                                          "failed to get tcsr reg base\n");
> > +
> > +             tcsr_base = res->start;
> This variable does not seem very useful, we can get rid of it.
>
> > +             tcsr_check = tcsr_base + chip->eud_cfg->tcsr_check_offset;
> > +
> > +             ret = qcom_scm_io_writel(tcsr_check, TCSR_CHECK_EN);
> > +             if (ret)
> > +                     return dev_err_probe(chip->dev, ret, "failed to write tcsr check reg\n");
> > +     }
> >
> >       chip->irq = platform_get_irq(pdev, 0);
> >       ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
> > @@ -230,8 +285,13 @@ static int eud_remove(struct platform_device *pdev)
> >       return 0;
> >  }
> >
> > +static const struct eud_soc_cfg sm6115_eud_cfg = {
> This could be marked __initconst, but I'm not sure if future
> additions won't need to be accessed after the driver has already
> gone through its probe function.. Your call!

Please no. The device can be probed later or reprobed, etc.
We had __devinit* for this kind of data/functions, but it was removed
around 3.x as the HOTPLUG also got removed.

>
>
> Konrad
> > +     .tcsr_check_offset = 0x25018,
> > +};
> > +
> >  static const struct of_device_id eud_dt_match[] = {
> >       { .compatible = "qcom,sc7280-eud" },
> > +     { .compatible = "qcom,sm6115-eud", .data = &sm6115_eud_cfg },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(of, eud_dt_match);



-- 
With best wishes
Dmitry
