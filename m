Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B4363BFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiK2MO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiK2MO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:14:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6F459868;
        Tue, 29 Nov 2022 04:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669724095; x=1701260095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VB01RoMecb1fnZrCwPJYgm/ivTMxFqaFVHgPsPPtEQU=;
  b=OOmZ36t9vnqCMW+yM6gJFH5SburRiIEHqeQaXLJHUuy4WNPOmhKUshwE
   3AsKM5FB488Z2/Fnz0urVI2Xq5F0l/KroI+r8akr9vopuh3Zw32M13vVA
   UnyFeWqSPaZCutnysHlXsq9pCzuHubmZcJdN1FvC2/dfSEUx3MpNAYUnu
   nw28p17GuX5YKX+uDn7yQhQmTp/QsMScbeTeHtTUNZL3iGNYlTFCNU8pI
   X2nT8nPHHLu4/UZb3eoSAbJfEI5E/l50e/nIanpbOmL4W8hMjubQtOtS1
   QASpDbjHICwmajmZCpoTDJXd1iafaxWZVXpMcuaGQhIYbFSeU5IeHtcIM
   w==;
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="201836035"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Nov 2022 05:14:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 29 Nov 2022 05:14:54 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 29 Nov 2022 05:14:51 -0700
Date:   Tue, 29 Nov 2022 12:14:32 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] ASoC: qcom: lpass-sc7180: Add system suspend/resume PM
 ops
Message-ID: <Y4X3qKIaSx3lYlsr@wendy>
References: <1669621742-28524-1-git-send-email-quic_srivasam@quicinc.com>
 <CAMuHMdUBojHkaAPsjOEadfaikth+L0R_NrKzvqXrmZS9Kc5zHw@mail.gmail.com>
 <3b00c04c-cb6d-9e9a-ba0c-0ce093b4a3fb@quicinc.com>
 <CAMuHMdUfRJmy56eO=ET-Togg-EOgxSjnTgAUYWmixD_zVonipA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUfRJmy56eO=ET-Togg-EOgxSjnTgAUYWmixD_zVonipA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:53:10AM +0100, Geert Uytterhoeven wrote:
> Hi Srinivasa,
> 
> On Tue, Nov 29, 2022 at 11:36 AM Srinivasa Rao Mandadapu
> <quic_srivasam@quicinc.com> wrote:
> > On 11/29/2022 1:23 PM, Geert Uytterhoeven wrote:
> > > On Mon, Nov 28, 2022 at 8:50 AM Srinivasa Rao Mandadapu
> > > <quic_srivasam@quicinc.com> wrote:
> > >> Update lpass sc7180 platform driver with PM ops, such as
> > >> system supend and resume callbacks.
> > >> This update is required to disable clocks during supend and
> > >> avoid XO shutdown issue.
> > >>
> > >> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > >> Tested-by: Rahul Ajmeriya <quic_rajmeriy@quicinc.com>
> > > Thanks for your patch, which is now commit 2d68148f8f85ca5a ("ASoC:
> > > qcom: lpass-sc7180: Add system suspend/resume PM ops") in next-20221129.
> > >
> > >> --- a/sound/soc/qcom/lpass-sc7180.c
> > >> +++ b/sound/soc/qcom/lpass-sc7180.c
> > >> @@ -12,6 +12,7 @@
> > >>   #include <linux/module.h>
> > >>   #include <linux/of.h>
> > >>   #include <linux/platform_device.h>
> > >> +#include <linux/pm_runtime.h>
> > >>   #include <dt-bindings/sound/sc7180-lpass.h>
> > >>   #include <sound/pcm.h>
> > >>   #include <sound/soc.h>
> > >> @@ -156,10 +157,34 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
> > >>          struct lpass_data *drvdata = platform_get_drvdata(pdev);
> > >>
> > >>          clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
> > >> +       return 0;
> > >> +}
> > >> +
> > >> +static int sc7180_lpass_dev_resume(struct device *dev)
> > >> +{
> > >> +       int ret = 0;
> > >> +       struct lpass_data *drvdata = dev_get_drvdata(dev);
> > >>
> > >> +       ret = clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
> > >> +       if (ret) {
> > >> +               dev_err(dev, "sc7180 clk prepare and enable failed\n");
> > >> +               return ret;
> > >> +       }
> > >> +       return ret;
> > >> +}
> > >> +
> > >> +static int sc7180_lpass_dev_suspend(struct device *dev)
> > >> +{
> > >> +       struct lpass_data *drvdata = dev_get_drvdata(dev);
> > >> +
> > >> +       clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
> > >>          return 0;
> > >>   }
> > > noreply@ellerman.id.au reports for e.g. m68k-allmodconfig:
> > >
> > >      sound/soc/qcom/lpass-sc7180.c:179:12: error:
> > > 'sc7180_lpass_dev_suspend' defined but not used
> > > [-Werror=unused-function]
> > >      sound/soc/qcom/lpass-sc7180.c:166:12: error:
> > > 'sc7180_lpass_dev_resume' defined but not used
> > > [-Werror=unused-function]
> > >
> > >> +static const struct dev_pm_ops sc7180_lpass_pm_ops = {
> > >> +       SET_SYSTEM_SLEEP_PM_OPS(sc7180_lpass_dev_suspend, sc7180_lpass_dev_resume)
> > >> +};
> > > Please use DEFINE_SIMPLE_DEV_PM_OPS()...
> > Actually, we need to use this patch in in previous kernels 5.4 and 5.15.
> > I think these changes won't apply on previous kernel.
> > Hence ignoring for now and will take care next time.
> 
> In that case you should add __maybe_unused tags to
> sc7180_lpass_dev_suspend() and sc7180_lpass_dev_resume() first, so it
> can be backported to 5.4 and 5.15, and do the DEFINE_SIMPLE_DEV_PM_OPS()
> conversion later.

FWIW, this is now breaking allmodconfig on RISC-V for this reason:

make[2]: *** [../scripts/Makefile.build:504: lib] Error 2
../sound/soc/qcom/lpass-sc7180.c:179:12: error: 'sc7180_lpass_dev_suspend' defined but not used [-Werror=unused-function]
  179 | static int sc7180_lpass_dev_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~
../sound/soc/qcom/lpass-sc7180.c:166:12: error: 'sc7180_lpass_dev_resume' defined but not used [-Werror=unused-function]
  166 | static int sc7180_lpass_dev_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Thanks,
Conor.

