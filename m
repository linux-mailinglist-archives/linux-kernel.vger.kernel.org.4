Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781416056B8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJTFWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJTFWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:22:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEE215F33E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:22:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h185so18229209pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w2MLVCopfBzHJZ9plEFQGqy/JaQDNWctRItbuh9GNoU=;
        b=y/TjnX9N1gqV2hmOmgTeuvIQNtIvpJoZX5XhRtVjeijtHHtkEY3WXtsqCt4riHHSZ4
         JzPNBaMiOtxKOKIrAI2VGXFsEcH+2yRVjL8I6ywbXROWrgy4x0RwXUwiwAF0zZ5+gBP/
         DQWU0MLoByLOUUrResGrdOAypvO0T9VuT+QiP0QBgRr6s2RKrdWXmm7M60gKiTbsD5eI
         tlCCglGf5nHLa1E3oLlBGEhETIxmOkqwMrZDLVvbA5EOQlkQCiIyWboeJbqlU/KoSHh9
         f1yMXVf3rSbhHBOP7dLGJZ9hAFd0u6m/qUBAG7EIOSRjVFGDnnbkSarK/x6Z99fmkMHq
         oTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2MLVCopfBzHJZ9plEFQGqy/JaQDNWctRItbuh9GNoU=;
        b=MuFMsn5kKEW41RSk2WOephMBXIa3tKVKd8DfCa/9OjxjghyoRYJbiVyhQZ6JuyElci
         zgh/dKcLFaSUt0F9/EB1kMCEMVZ4r+NzXYzT09AO+UiMsihEcEveilAb1U+UZGSxWVUR
         p7U6G4XyPgvSCnOWPu6tq2H51Ff/pWPsl+zvVsSwhVBElVWxYTLpNWdFeFL+C7y/IYdB
         Ted3VMWvZUUWWuT+dKu/KCMP8Q0Tpd69BM1NM7qFW1YUfXgRw5LEu5U5J1gnqgWb06li
         OalqhBJP3pF3toJWKCPGTgQxRIengWRbJhpNOaUPWTLMvbb9VAS28oF9kYCgSNg8zx/W
         V0rw==
X-Gm-Message-State: ACrzQf3RU6wyR1ivUMm0PB8xz1dckI0CCGIvBG3qnZGmODjkCUT/H/ak
        RlGCBbeN2kHgYVxt83gsRwidNw==
X-Google-Smtp-Source: AMsMyM6K+ZR1YbcbhMCxCncgDbNrN7YxB7cXwahSOQPAPTnBb3HsKJGl/Ok+xA4Sa336CYanHjc0Tw==
X-Received: by 2002:a05:6a00:705:b0:562:b9e1:d0e8 with SMTP id 5-20020a056a00070500b00562b9e1d0e8mr12432418pfl.0.1666243353385;
        Wed, 19 Oct 2022 22:22:33 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090a0e4900b00203917403ccsm881093pja.1.2022.10.19.22.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 22:22:32 -0700 (PDT)
Date:   Thu, 20 Oct 2022 10:52:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221020052230.m2ndqmjxlojdm4ie@vireshk-i7>
References: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019135925.366162-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Johan,

On 19-10-22, 19:29, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds clock provider support to the Qcom CPUFreq driver for
> supplying the clocks to the CPU cores in Qcom SoCs.
> 
> The Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
> clocks to the CPU cores. But this is not represented clearly in devicetree.
> There is no clock coming out of the CPUFreq HW node to the CPU. This created
> an issue [1] with the OPP core when a recent enhancement series was submitted.
> Eventhough the issue got fixed in the OPP framework in the meantime, that's
> not a proper solution and this series aims to fix it properly.
> 
> There was also an attempt made by Viresh [2] to fix the issue by moving the
> clocks supplied to the CPUFreq HW node to the CPU. But that was not accepted
> since those clocks belong to the CPUFreq HW node only.
> 
> The proposal here is to add clock provider support to the Qcom CPUFreq HW
> driver to supply clocks to the CPUs that comes out of the EPSS/OSM block.
> This correctly reflects the hardware implementation.
> 
> The clock provider is a simple one that just provides the frequency of the
> clocks supplied to each frequency domain in the SoC using .recalc_rate()
> callback. The frequency supplied by the driver will be the actual frequency
> that comes out of the EPSS/OSM block after the DCVS operation. This frequency
> is not same as what the CPUFreq framework has set but it is the one that gets
> supplied to the CPUs after throttling by LMh.
> 
> This series has been tested on SM8450 based dev board and hence there is a DTS
> change only for that platform. Once this series gets accepted, rest of the
> platform DTS can also be modified and finally the hack on the OPP core can be
> dropped.

Thanks for working on this Mani.

Can you also test the below code over your series ? This shouldn't
result in issues that Johan reported earlier [1][2]. Below is the hack I
am carrying in the OPP core for Qcom SoCs at the moment.

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e87567dbe99f..b7158d33c13d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1384,20 +1384,6 @@ static struct opp_table *_update_opp_table_clk(struct device *dev,
        }

        if (ret == -ENOENT) {
-               /*
-                * There are few platforms which don't want the OPP core to
-                * manage device's clock settings. In such cases neither the
-                * platform provides the clks explicitly to us, nor the DT
-                * contains a valid clk entry. The OPP nodes in DT may still
-                * contain "opp-hz" property though, which we need to parse and
-                * allow the platform to find an OPP based on freq later on.
-                *
-                * This is a simple solution to take care of such corner cases,
-                * i.e. make the clk_count 1, which lets us allocate space for
-                * frequency in opp->rates and also parse the entries in DT.
-                */
-               opp_table->clk_count = 1;
-
                dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
                return opp_table;
        }
diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 96a30a032c5f..402c507edac7 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -138,7 +138,7 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
         * - For some devices rate isn't available or there are multiple, use
         *   index instead for them.
         */
-       if (likely(opp_table->clk_count == 1 && opp->rates[0]))
+       if (likely(opp_table->clk_count == 1))
                id = opp->rates[0];
        else
                id = _get_opp_count(opp_table);

-- 
viresh

[1] https://lore.kernel.org/all/YsxSkswzsqgMOc0l@hovoldconsulting.com/
[2] https://lore.kernel.org/all/Ys2FZa6YDwt7d%2FZc@hovoldconsulting.com/
