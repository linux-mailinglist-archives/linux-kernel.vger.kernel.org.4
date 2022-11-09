Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A8E6224E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKIHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKIHtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:49:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E97101EE;
        Tue,  8 Nov 2022 23:49:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97772B81D1C;
        Wed,  9 Nov 2022 07:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1516FC433D6;
        Wed,  9 Nov 2022 07:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667980156;
        bh=fvd9odyzAADqOiCHTEDna++V29NheiQSB2khhV4Mf2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSmRNKLZqIdzwDbj/pyJ3ApOH+NVQzLRmxI39+IigSpA2AoeJhAsmwP27ctuZwliA
         z/2e0UWW+gXgBXYg/GURX3Q4ck+PHQxD0SuCK2n5zsw+QRWAMAfYcpsGyqbRYAU7Z+
         iVaTBrWkD/mjLODutUDqVxUj9KuCiCGZFZ5zq2+5QM2GGlag7xBL7cKjWkDCNr6Nai
         jDRM5gbzNgNTHJ3Qgbci7T9wl6OjLbQALGM70kI2KJHZttkdMPvxil/vdWKaBqyz7o
         BzxHnF7SsFrZ5OEFIDvKsqk+6lJUy92iSbzbZcBq7G6TdknPbE9uFKBHPeL+0pGIB9
         F9KVFZgfxAl0A==
Date:   Wed, 9 Nov 2022 13:19:08 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221109074908.GC4651@thinkpad>
References: <20221108154037.111794-1-manivannan.sadhasivam@linaro.org>
 <20221108154037.111794-4-manivannan.sadhasivam@linaro.org>
 <20221108155717.srlnabls5ze2resx@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221108155717.srlnabls5ze2resx@bogus>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 03:57:17PM +0000, Sudeep Holla wrote:
> On Tue, Nov 08, 2022 at 09:10:37PM +0530, Manivannan Sadhasivam wrote:
> > Qcom CPUFreq hardware (EPSS/OSM) controls clock and voltage to the CPU
> > cores. But this relationship is not represented with the clk framework
> > so far.
> > 
> > So, let's make the qcom-cpufreq-hw driver a clock provider. This makes the
> > clock producer/consumer relationship cleaner and is also useful for CPU
> > related frameworks like OPP to know the frequency at which the CPUs are
> > running.
> > 
> > The clock frequency provided by the driver is for each frequency domain.
> > We cannot get the frequency of each CPU core because, not all platforms
> > support per-core DCVS feature.
> > 
> > Also the frequency supplied by the driver is the actual frequency that
> > comes out of the EPSS/OSM block after the DCVS operation. This frequency is
> > not same as what the CPUFreq framework has set but it is the one that gets
> > supplied to the CPUs after throttling by LMh.
> >
> 
> OK now I see more info here. How different is this value from the one
> returned by qcom_cpufreq_hw_get() ?
> 

qcom_cpufreq_hw_get() returns the frequency that got programmed by the cpufreq
core. But that frequency is not necessarily the one that gets delivered to the
CPU cores because the EPSS/OSM hardware block may vary the frequency after the
DCVS operation.

So this frequency is the final one that gets delivered to the CPU cores.

Thanks,
Mani

> -- 
> Regards,
> Sudeep

-- 
மணிவண்ணன் சதாசிவம்
