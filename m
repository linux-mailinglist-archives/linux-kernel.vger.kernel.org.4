Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE260719A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJUIDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJUIDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:03:03 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6777B244C5B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:03:02 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id g130so2334474oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lGX3vc2vp0tWTgj5dceXTDdECHCM1PURTK7sil/Mtbs=;
        b=nzlUGEmAjA0vepO6HV/D5CRZ8RzzVkKCwsP8VsehdS7eAzgB2CG7duh6KtmS1UEbKe
         RDZOyg78xdcLVLw5R3fDd2XMtQMeTebrhE/lVbDZOgKtUzIK0D0ZOs8WVQ4evqgA3yh5
         185+0eqPUj1zVaQDvYzRoko3SsQmxmQmUIUWyfPq63nNKDEDCTYaTDoX0VtqW2BVkBH2
         OEHy25ArgcGX+H28KP+INGcbQk4LDO+9FZJOQSANoN4J2IxL9/AVlKdZpnLft1XWMybl
         IDH5u4jqHuOvWhj1zvfB7v5rqrMCcNQAEPkULHm7qPDQaVz1iL2BYVQUc0591zSTjGZk
         hsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGX3vc2vp0tWTgj5dceXTDdECHCM1PURTK7sil/Mtbs=;
        b=NUXkQJP7JBxA2Y60r16MOfiU2U13bc1OOZUM194C8a5LMvq7Rpu573xfieTle6QTGa
         bZFdcsP+8fazcpt/TrRIJ1a1pfSd+Q/Hy55DPsMVk/T0aQenWF20v6MBQIjJyeK09gpS
         RhbXmUFnzp+z3VcQciir8TEO/OSd91Ho9xWST3omPzOgQ2eSg2rpXnQa7dZKj+BK8Qn/
         p8J9yy4fhP1cm4xDkbwwPb+6e06zfpvfB/ueRhNRosvXyG8ngAZCorSAAA1p3DtaEY84
         Uf1hGtR1IhhZnawWymtKuRbm18TQ/4Iy4Iqad5+tlbMCwsijX0W/+YfRfOcRQQ5iwakb
         155Q==
X-Gm-Message-State: ACrzQf3ngoWiQzrw1ZO45WKl5APF6dr7/z6rG31fweCxYJXRC/DgMfFT
        GrO5JxBH8TGdTU87uYpwsQjT7Z7iliW6ANdKeA==
X-Google-Smtp-Source: AMsMyM6NSY01MvaZQBA+ft+t5aG0+C3U/bjtwNTkLjLO9MWUJBeNUpY5M99WTE9iboZ2WtLGkv+4uQ==
X-Received: by 2002:a17:90b:3b8b:b0:20d:4fd9:9a0f with SMTP id pc11-20020a17090b3b8b00b0020d4fd99a0fmr53847248pjb.17.1666339370445;
        Fri, 21 Oct 2022 01:02:50 -0700 (PDT)
Received: from thinkpad ([117.193.215.105])
        by smtp.gmail.com with ESMTPSA id d4-20020a62f804000000b005628a30a500sm14597701pfh.41.2022.10.21.01.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:02:49 -0700 (PDT)
Date:   Fri, 21 Oct 2022 13:32:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221021080241.GB93287@thinkpad>
References: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
 <20221020052230.m2ndqmjxlojdm4ie@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221020052230.m2ndqmjxlojdm4ie@vireshk-i7>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:52:30AM +0530, Viresh Kumar wrote:
> + Johan,
> 
> On 19-10-22, 19:29, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds clock provider support to the Qcom CPUFreq driver for
> > supplying the clocks to the CPU cores in Qcom SoCs.
> > 
> > The Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
> > clocks to the CPU cores. But this is not represented clearly in devicetree.
> > There is no clock coming out of the CPUFreq HW node to the CPU. This created
> > an issue [1] with the OPP core when a recent enhancement series was submitted.
> > Eventhough the issue got fixed in the OPP framework in the meantime, that's
> > not a proper solution and this series aims to fix it properly.
> > 
> > There was also an attempt made by Viresh [2] to fix the issue by moving the
> > clocks supplied to the CPUFreq HW node to the CPU. But that was not accepted
> > since those clocks belong to the CPUFreq HW node only.
> > 
> > The proposal here is to add clock provider support to the Qcom CPUFreq HW
> > driver to supply clocks to the CPUs that comes out of the EPSS/OSM block.
> > This correctly reflects the hardware implementation.
> > 
> > The clock provider is a simple one that just provides the frequency of the
> > clocks supplied to each frequency domain in the SoC using .recalc_rate()
> > callback. The frequency supplied by the driver will be the actual frequency
> > that comes out of the EPSS/OSM block after the DCVS operation. This frequency
> > is not same as what the CPUFreq framework has set but it is the one that gets
> > supplied to the CPUs after throttling by LMh.
> > 
> > This series has been tested on SM8450 based dev board and hence there is a DTS
> > change only for that platform. Once this series gets accepted, rest of the
> > platform DTS can also be modified and finally the hack on the OPP core can be
> > dropped.
> 
> Thanks for working on this Mani.
> 
> Can you also test the below code over your series ? This shouldn't
> result in issues that Johan reported earlier [1][2]. Below is the hack I
> am carrying in the OPP core for Qcom SoCs at the moment.
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e87567dbe99f..b7158d33c13d 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1384,20 +1384,6 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
>         }
> 
>         if (ret == -ENOENT) {
> -               /*
> -                * There are few platforms which don't want the OPP core to
> -                * manage device's clock settings. In such cases neither the
> -                * platform provides the clks explicitly to us, nor the DT
> -                * contains a valid clk entry. The OPP nodes in DT may still
> -                * contain "opp-hz" property though, which we need to parse and
> -                * allow the platform to find an OPP based on freq later on.
> -                *
> -                * This is a simple solution to take care of such corner cases,
> -                * i.e. make the clk_count 1, which lets us allocate space for
> -                * frequency in opp->rates and also parse the entries in DT.
> -                */
> -               opp_table->clk_count = 1;
> -
>                 dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
>                 return opp_table;
>         }
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index 96a30a032c5f..402c507edac7 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -138,7 +138,7 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
>          * - For some devices rate isn't available or there are multiple, use
>          *   index instead for them.
>          */
> -       if (likely(opp_table->clk_count == 1 && opp->rates[0]))
> +       if (likely(opp_table->clk_count == 1))
>                 id = opp->rates[0];
>         else
>                 id = _get_opp_count(opp_table);
> 

With the above diffs applied, I no longer see the issues reported by Johan on
SM8450 dev board.

Thanks,
Mani

> -- 
> viresh
> 
> [1] https://lore.kernel.org/all/YsxSkswzsqgMOc0l@hovoldconsulting.com/
> [2] https://lore.kernel.org/all/Ys2FZa6YDwt7d%2FZc@hovoldconsulting.com/

-- 
மணிவண்ணன் சதாசிவம்
