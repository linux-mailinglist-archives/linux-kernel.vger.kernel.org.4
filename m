Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EEF63BB08
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiK2Hxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK2Hxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:53:51 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC731EED9;
        Mon, 28 Nov 2022 23:53:50 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id c2so9157772qko.1;
        Mon, 28 Nov 2022 23:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDVov8d4BN3qgelRFS6S1eSfJ2eIIEzv+2+tNAw/t+c=;
        b=7FTXIK68tUlTABOWleAlYd2i3G2HUybsiu+Frorzn0oNKMZsKDfFE19gsAeGGpN4UP
         9ExmOYGY59GV/j+8VUKYFeknryGubylakie2Fb3ZFGobDdYDW4/nWq7JbbpSiPiYteUt
         PC8Bej6aoxXNRCocj4JSfXTNuE6UklZxgXY4/V7E9iDDXNbFEDyedpleaBJLu+mRB9j2
         4/y1nGAT9gHirlCS2Q6Mq7dHq3lPlZ6rHzAxA6IpefEbtq3KP8aGBEB9GaTLBbrfa26p
         2iJBilemgz6TmVzCkHYwZNJk0qc9NGzIvDN1LACts+GA9Amee7451UN+zihFlvGyoCqP
         QqPw==
X-Gm-Message-State: ANoB5plSk34hv4JSrPmsafT/3MI9AaQxJyfWRytFjoQ+j9H9uQa0lMY/
        BncPYHdA0OjOkC42ljNnh3Kx63kXCqziwA==
X-Google-Smtp-Source: AA0mqf7+rtiLdTjkbS/2iR7m6rqYNZOLtWMGhgL/9Mcyrio4seMXah7qFFMUeQlF91oLFS7gp75/EQ==
X-Received: by 2002:a37:ae42:0:b0:6fc:3fa1:bcd1 with SMTP id x63-20020a37ae42000000b006fc3fa1bcd1mr22397966qke.609.1669708428974;
        Mon, 28 Nov 2022 23:53:48 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id k2-20020ac81402000000b0039467aadeb8sm8152903qtj.13.2022.11.28.23.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 23:53:47 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id e141so16424103ybh.3;
        Mon, 28 Nov 2022 23:53:46 -0800 (PST)
X-Received: by 2002:a25:bcc6:0:b0:6dd:1c5c:5602 with SMTP id
 l6-20020a25bcc6000000b006dd1c5c5602mr54295291ybm.36.1669708426532; Mon, 28
 Nov 2022 23:53:46 -0800 (PST)
MIME-Version: 1.0
References: <1669621742-28524-1-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1669621742-28524-1-git-send-email-quic_srivasam@quicinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Nov 2022 08:53:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBojHkaAPsjOEadfaikth+L0R_NrKzvqXrmZS9Kc5zHw@mail.gmail.com>
Message-ID: <CAMuHMdUBojHkaAPsjOEadfaikth+L0R_NrKzvqXrmZS9Kc5zHw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add system suspend/resume PM ops
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasa,

On Mon, Nov 28, 2022 at 8:50 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
> Update lpass sc7180 platform driver with PM ops, such as
> system supend and resume callbacks.
> This update is required to disable clocks during supend and
> avoid XO shutdown issue.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Rahul Ajmeriya <quic_rajmeriy@quicinc.com>

Thanks for your patch, which is now commit 2d68148f8f85ca5a ("ASoC:
qcom: lpass-sc7180: Add system suspend/resume PM ops") in next-20221129.

> --- a/sound/soc/qcom/lpass-sc7180.c
> +++ b/sound/soc/qcom/lpass-sc7180.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <dt-bindings/sound/sc7180-lpass.h>
>  #include <sound/pcm.h>
>  #include <sound/soc.h>
> @@ -156,10 +157,34 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
>         struct lpass_data *drvdata = platform_get_drvdata(pdev);
>
>         clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
> +       return 0;
> +}
> +
> +static int sc7180_lpass_dev_resume(struct device *dev)
> +{
> +       int ret = 0;
> +       struct lpass_data *drvdata = dev_get_drvdata(dev);
>
> +       ret = clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
> +       if (ret) {
> +               dev_err(dev, "sc7180 clk prepare and enable failed\n");
> +               return ret;
> +       }
> +       return ret;
> +}
> +
> +static int sc7180_lpass_dev_suspend(struct device *dev)
> +{
> +       struct lpass_data *drvdata = dev_get_drvdata(dev);
> +
> +       clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
>         return 0;
>  }

noreply@ellerman.id.au reports for e.g. m68k-allmodconfig:

    sound/soc/qcom/lpass-sc7180.c:179:12: error:
'sc7180_lpass_dev_suspend' defined but not used
[-Werror=unused-function]
    sound/soc/qcom/lpass-sc7180.c:166:12: error:
'sc7180_lpass_dev_resume' defined but not used
[-Werror=unused-function]

>
> +static const struct dev_pm_ops sc7180_lpass_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(sc7180_lpass_dev_suspend, sc7180_lpass_dev_resume)
> +};

Please use DEFINE_SIMPLE_DEV_PM_OPS()...

> +
>  static struct lpass_variant sc7180_data = {
>         .i2sctrl_reg_base       = 0x1000,
>         .i2sctrl_reg_stride     = 0x1000,
> @@ -293,6 +318,7 @@ static struct platform_driver sc7180_lpass_cpu_platform_driver = {
>         .driver = {
>                 .name = "sc7180-lpass-cpu",
>                 .of_match_table = of_match_ptr(sc7180_lpass_cpu_device_id),
> +               .pm = &sc7180_lpass_pm_ops,

... and pm_sleep_ptr().

>         },
>         .probe = asoc_qcom_lpass_cpu_platform_probe,
>         .remove = asoc_qcom_lpass_cpu_platform_remove,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
