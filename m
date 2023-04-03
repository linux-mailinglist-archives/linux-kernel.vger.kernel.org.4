Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E4D6D4F35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjDCRm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjDCRm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:42:57 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2038B6;
        Mon,  3 Apr 2023 10:42:54 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 333HgiLa046618;
        Mon, 3 Apr 2023 12:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680543764;
        bh=XfoKgm34yi7EcuWz+guJWMl3DaCNizDpw0v1uHmtqvE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Hglzdi8tLwwheheGNtyz2MPdtHjH1xQFdpfAFqHu7j6VVz7eLyTq+oneSJZENe8mj
         9+MB7cn8A98TGdm4Zfze9+7PDEtELPZIjrFcz7dvstdrpKbYO0pksOOc6ZeFI6eW16
         BpoUrG4aSLZNCA39qi0KW8Y9rMjfibIkQvz5N7vc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 333Hgi1M017206
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Apr 2023 12:42:44 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 3
 Apr 2023 12:42:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 3 Apr 2023 12:42:44 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 333HggDK089387;
        Mon, 3 Apr 2023 12:42:43 -0500
Message-ID: <9029896f-d6fb-e341-9544-1104ecfa9f8a@ti.com>
Date:   Mon, 3 Apr 2023 23:12:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] mmc: sdhci_am654: Add support for PM suspend/resume
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230331101619.4117312-1-vigneshr@ti.com>
 <CAPDyKFqQZgmd_ydbjKJ+5-Dte9i2=DqWwZNgVHi2MnH+q7pZ1g@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <CAPDyKFqQZgmd_ydbjKJ+5-Dte9i2=DqWwZNgVHi2MnH+q7pZ1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/03/23 20:01, Ulf Hansson wrote:
> On Fri, 31 Mar 2023 at 12:17, Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>
>> From: Aswath Govindraju <a-govindraju@ti.com>
>>
>> Add support for suspend/resume and pm_runtime resume/suspend.
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>
>> Since RFC v2:
>> Address all comments around sdhci_am654_remove()
>> Set autosuspend_delay to -1 as SDHCI will host rootfs via SD/eMMC and
>> autosuspend can cause long latency for user interactive applications
> 
> I am curious about the "long" latency. Do you have some data that you
> can share for how long it takes to runtime-resume the device?
> 

As part of wider teting, I discovered that on certain boards (J721e EVM
for example), there is a latency of ~500ms for controller to start up
(HW limitation around card detect debounce timer [0]). This results in
momentary (but noticeable) lag when playing a video for example.


[0[
https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/sdhci_am654.c#L361


> Using -1 as the default value for the autosuspend_delay seems fine to
> me, but did you consider using a longer timeout than the common 100ms?
> Could that perhaps be a better default option?

Its more of the startup delay than how long controller should remain
active. So tuning autosuspend_delay does not seem to help.

> 
> Of course, in the end this is a choice of performance in favor of
> wasting energy.

Yes, this is choice of opt-in vs opt-out. Users can tune the delay via
sysfs as needed.

I am setting it to -1 to avoid regressing any userspace apps (vs
enabling autosuspend and then asking impacted users to set to -1)

One solution is to use -1 on platforms where latency is significant
based on compatible / SoC detection?

Regards
Vignesh

> 
> Kind regards
> Uffe
> 
>>
>> RFC v2:
>> https://lore.kernel.org/all/20220408124338.27090-1-a-govindraju@ti.com/
>>
>>  drivers/mmc/host/sdhci_am654.c | 147 +++++++++++++++++++++++++++++----
>>  1 file changed, 131 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index 672d37ea98d0..7cdf0f54e3a5 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -85,6 +85,7 @@
>>  #define DRIVER_STRENGTH_40_OHM 0x4
>>
>>  #define CLOCK_TOO_SLOW_HZ      50000000
>> +#define SDHCI_AM654_AUTOSUSPEND_DELAY  -1
>>
>>  /* Command Queue Host Controller Interface Base address */
>>  #define SDHCI_AM654_CQE_BASE_ADDR 0x200
>> @@ -808,16 +809,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>
>>         pltfm_host->clk = clk_xin;
>>
>> -       /* Clocks are enabled using pm_runtime */
>> -       pm_runtime_enable(dev);
>> -       ret = pm_runtime_resume_and_get(dev);
>> -       if (ret)
>> -               goto pm_runtime_disable;
>> -
>>         base = devm_platform_ioremap_resource(pdev, 1);
>>         if (IS_ERR(base)) {
>>                 ret = PTR_ERR(base);
>> -               goto pm_runtime_put;
>> +               goto err_pltfm_free;
>>         }
>>
>>         sdhci_am654->base = devm_regmap_init_mmio(dev, base,
>> @@ -825,31 +820,47 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>         if (IS_ERR(sdhci_am654->base)) {
>>                 dev_err(dev, "Failed to initialize regmap\n");
>>                 ret = PTR_ERR(sdhci_am654->base);
>> -               goto pm_runtime_put;
>> +               goto err_pltfm_free;
>>         }
>>
>>         ret = sdhci_am654_get_of_property(pdev, sdhci_am654);
>>         if (ret)
>> -               goto pm_runtime_put;
>> +               goto err_pltfm_free;
>>
>>         ret = mmc_of_parse(host->mmc);
>>         if (ret) {
>>                 dev_err_probe(dev, ret, "parsing dt failed\n");
>> -               goto pm_runtime_put;
>> +               goto err_pltfm_free;
>>         }
>>
>>         host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>>
>> +       pm_runtime_get_noresume(dev);
>> +       ret = pm_runtime_set_active(dev);
>> +       if (ret)
>> +               goto pm_put;
>> +       pm_runtime_enable(dev);
>> +       ret = clk_prepare_enable(pltfm_host->clk);
>> +       if (ret)
>> +               goto pm_disable;
>> +
>>         ret = sdhci_am654_init(host);
>>         if (ret)
>> -               goto pm_runtime_put;
>> +               goto clk_disable;
>>
>> +       /* Setting up autosuspend */
>> +       pm_runtime_set_autosuspend_delay(dev, SDHCI_AM654_AUTOSUSPEND_DELAY);
>> +       pm_runtime_use_autosuspend(dev);
>> +       pm_runtime_mark_last_busy(dev);
>> +       pm_runtime_put_autosuspend(dev);
>>         return 0;
>>
>> -pm_runtime_put:
>> -       pm_runtime_put_sync(dev);
>> -pm_runtime_disable:
>> +clk_disable:
>> +       clk_disable_unprepare(pltfm_host->clk);
>> +pm_disable:
>>         pm_runtime_disable(dev);
>> +pm_put:
>> +       pm_runtime_put_noidle(dev);
>>  err_pltfm_free:
>>         sdhci_pltfm_free(pdev);
>>         return ret;
>> @@ -858,23 +869,127 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>  static int sdhci_am654_remove(struct platform_device *pdev)
>>  {
>>         struct sdhci_host *host = platform_get_drvdata(pdev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>         int ret;
>>
>> -       sdhci_remove_host(host, true);
>> -       ret = pm_runtime_put_sync(&pdev->dev);
>> +       ret = pm_runtime_resume_and_get(&pdev->dev);
>>         if (ret < 0)
>>                 return ret;
>>
>> +       sdhci_remove_host(host, true);
>> +       clk_disable_unprepare(pltfm_host->clk);
>>         pm_runtime_disable(&pdev->dev);
>> +       pm_runtime_put_noidle(&pdev->dev);
>>         sdhci_pltfm_free(pdev);
>> +       return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int sdhci_am654_restore(struct sdhci_host *host)
>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>> +       u32 ctl_cfg_2 = 0;
>> +       u32 val;
>> +       int ret;
>> +
>> +       if (sdhci_am654->flags & DLL_CALIB) {
>> +               regmap_read(sdhci_am654->base, PHY_STAT1, &val);
>> +               if (~val & CALDONE_MASK) {
>> +                       /* Calibrate IO lines */
>> +                       regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
>> +                                          PDB_MASK, PDB_MASK);
>> +                       ret = regmap_read_poll_timeout(sdhci_am654->base,
>> +                                                      PHY_STAT1, val,
>> +                                                      val & CALDONE_MASK,
>> +                                                      1, 20);
>> +                       if (ret)
>> +                               return ret;
>> +               }
>> +       }
>> +
>> +       /* Enable pins by setting IO mux to 0 */
>> +       if (sdhci_am654->flags & IOMUX_PRESENT)
>> +               regmap_update_bits(sdhci_am654->base, PHY_CTRL1,
>> +                                  IOMUX_ENABLE_MASK, 0);
>>
>> +       /* Set slot type based on SD or eMMC */
>> +       if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>> +               ctl_cfg_2 = SLOTTYPE_EMBEDDED;
>> +
>> +       regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
>> +                          ctl_cfg_2);
>> +
>> +       regmap_read(sdhci_am654->base, CTL_CFG_3, &val);
>> +       if (~val & TUNINGFORSDR50_MASK)
>> +               /* Enable tuning for SDR50 */
>> +               regmap_update_bits(sdhci_am654->base, CTL_CFG_3, TUNINGFORSDR50_MASK,
>> +                                  TUNINGFORSDR50_MASK);
>> +
>> +       return 0;
>> +}
>> +
>> +static int sdhci_am654_runtime_suspend(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       int ret;
>> +
>> +       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>> +               mmc_retune_needed(host->mmc);
>> +
>> +       ret = cqhci_suspend(host->mmc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = sdhci_runtime_suspend_host(host);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* disable the clock */
>> +       clk_disable_unprepare(pltfm_host->clk);
>>         return 0;
>>  }
>>
>> +static int sdhci_am654_runtime_resume(struct device *dev)
>> +{
>> +       struct sdhci_host *host = dev_get_drvdata(dev);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       int ret;
>> +
>> +       /* Enable the clock */
>> +       ret = clk_prepare_enable(pltfm_host->clk);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = sdhci_am654_restore(host);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = sdhci_runtime_resume_host(host, 0);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = cqhci_resume(host->mmc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return 0;
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops sdhci_am654_dev_pm_ops = {
>> +       SET_RUNTIME_PM_OPS(sdhci_am654_runtime_suspend,
>> +                          sdhci_am654_runtime_resume, NULL)
>> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +                               pm_runtime_force_resume)
>> +};
>> +
>>  static struct platform_driver sdhci_am654_driver = {
>>         .driver = {
>>                 .name = "sdhci-am654",
>>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +               .pm = &sdhci_am654_dev_pm_ops,
>>                 .of_match_table = sdhci_am654_of_match,
>>         },
>>         .probe = sdhci_am654_probe,
>> --
>> 2.40.0
>>

-- 
Regards
Vignesh
