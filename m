Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604C463BE45
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiK2Kxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiK2Kx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:53:27 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D9C5F87C;
        Tue, 29 Nov 2022 02:53:24 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id c14so5399781qvq.0;
        Tue, 29 Nov 2022 02:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byCqNO9wNjp3bMa2bdQ4RMa3BFEO/vUEjR67iUdLdSk=;
        b=Zr9w5CXNPza4SXy4/wnvS0hynIMja0EhHkNKP1HpBDPhCmfhi7nSL1lG2Iub0w/vnf
         +Ma0/Ej/R5G2fns31DnwdCuGTJY8BVZ7QGWxtaHGdkH4S9TipAid68aoXZog6tXNF9pH
         Ci27nOEOres2BCMeSJRWJf+NcwKxKd4WkGvJImkTC/4a+n6/pMhQGBe0HgPzKq7QPDpE
         PtygfjANsr+Mrtjw59pokbU3bZyInAI67PVVJysJcdnRevs8dKiWN3lD8OJsX6vYsBju
         pjQj6U5kasLgO/fol4hJmmV1G5LVconDICD61Xm9E/NeQYmEK/K1FNFEPbEG44Kuw/DU
         twdg==
X-Gm-Message-State: ANoB5plfNkY+buDrQppwoOW1XyoAnf45jPjp3EHFHD5qNwPlMfRlfhoe
        aVINsdkszb6iqTdrUvAHrGHOKeJReVrjfg==
X-Google-Smtp-Source: AA0mqf4T4HwW/qrOTYVVjX1M1jxfRCBkXN5GVrTmzffjzY38wXuxrhTgEl/mjRQobDW6EyuSIh+mxQ==
X-Received: by 2002:a0c:edd0:0:b0:4b1:8d88:1982 with SMTP id i16-20020a0cedd0000000b004b18d881982mr36484357qvr.33.1669719203657;
        Tue, 29 Nov 2022 02:53:23 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id x26-20020ac8539a000000b00398df095cf5sm8316486qtp.34.2022.11.29.02.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 02:53:23 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3b56782b3f6so134072637b3.13;
        Tue, 29 Nov 2022 02:53:22 -0800 (PST)
X-Received: by 2002:a05:690c:b81:b0:37e:6806:a5f9 with SMTP id
 ck1-20020a05690c0b8100b0037e6806a5f9mr36739244ywb.47.1669719202235; Tue, 29
 Nov 2022 02:53:22 -0800 (PST)
MIME-Version: 1.0
References: <1669621742-28524-1-git-send-email-quic_srivasam@quicinc.com>
 <CAMuHMdUBojHkaAPsjOEadfaikth+L0R_NrKzvqXrmZS9Kc5zHw@mail.gmail.com> <3b00c04c-cb6d-9e9a-ba0c-0ce093b4a3fb@quicinc.com>
In-Reply-To: <3b00c04c-cb6d-9e9a-ba0c-0ce093b4a3fb@quicinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Nov 2022 11:53:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUfRJmy56eO=ET-Togg-EOgxSjnTgAUYWmixD_zVonipA@mail.gmail.com>
Message-ID: <CAMuHMdUfRJmy56eO=ET-Togg-EOgxSjnTgAUYWmixD_zVonipA@mail.gmail.com>
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

On Tue, Nov 29, 2022 at 11:36 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
> On 11/29/2022 1:23 PM, Geert Uytterhoeven wrote:
> > On Mon, Nov 28, 2022 at 8:50 AM Srinivasa Rao Mandadapu
> > <quic_srivasam@quicinc.com> wrote:
> >> Update lpass sc7180 platform driver with PM ops, such as
> >> system supend and resume callbacks.
> >> This update is required to disable clocks during supend and
> >> avoid XO shutdown issue.
> >>
> >> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> >> Tested-by: Rahul Ajmeriya <quic_rajmeriy@quicinc.com>
> > Thanks for your patch, which is now commit 2d68148f8f85ca5a ("ASoC:
> > qcom: lpass-sc7180: Add system suspend/resume PM ops") in next-20221129.
> >
> >> --- a/sound/soc/qcom/lpass-sc7180.c
> >> +++ b/sound/soc/qcom/lpass-sc7180.c
> >> @@ -12,6 +12,7 @@
> >>   #include <linux/module.h>
> >>   #include <linux/of.h>
> >>   #include <linux/platform_device.h>
> >> +#include <linux/pm_runtime.h>
> >>   #include <dt-bindings/sound/sc7180-lpass.h>
> >>   #include <sound/pcm.h>
> >>   #include <sound/soc.h>
> >> @@ -156,10 +157,34 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
> >>          struct lpass_data *drvdata = platform_get_drvdata(pdev);
> >>
> >>          clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
> >> +       return 0;
> >> +}
> >> +
> >> +static int sc7180_lpass_dev_resume(struct device *dev)
> >> +{
> >> +       int ret = 0;
> >> +       struct lpass_data *drvdata = dev_get_drvdata(dev);
> >>
> >> +       ret = clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
> >> +       if (ret) {
> >> +               dev_err(dev, "sc7180 clk prepare and enable failed\n");
> >> +               return ret;
> >> +       }
> >> +       return ret;
> >> +}
> >> +
> >> +static int sc7180_lpass_dev_suspend(struct device *dev)
> >> +{
> >> +       struct lpass_data *drvdata = dev_get_drvdata(dev);
> >> +
> >> +       clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
> >>          return 0;
> >>   }
> > noreply@ellerman.id.au reports for e.g. m68k-allmodconfig:
> >
> >      sound/soc/qcom/lpass-sc7180.c:179:12: error:
> > 'sc7180_lpass_dev_suspend' defined but not used
> > [-Werror=unused-function]
> >      sound/soc/qcom/lpass-sc7180.c:166:12: error:
> > 'sc7180_lpass_dev_resume' defined but not used
> > [-Werror=unused-function]
> >
> >> +static const struct dev_pm_ops sc7180_lpass_pm_ops = {
> >> +       SET_SYSTEM_SLEEP_PM_OPS(sc7180_lpass_dev_suspend, sc7180_lpass_dev_resume)
> >> +};
> > Please use DEFINE_SIMPLE_DEV_PM_OPS()...
> Actually, we need to use this patch in in previous kernels 5.4 and 5.15.
> I think these changes won't apply on previous kernel.
> Hence ignoring for now and will take care next time.

In that case you should add __maybe_unused tags to
sc7180_lpass_dev_suspend() and sc7180_lpass_dev_resume() first, so it
can be backported to 5.4 and 5.15, and do the DEFINE_SIMPLE_DEV_PM_OPS()
conversion later.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
