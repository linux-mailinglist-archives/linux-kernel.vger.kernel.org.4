Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A00866BD94
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAPMRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjAPMQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:16:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA951E288;
        Mon, 16 Jan 2023 04:16:53 -0800 (PST)
Received: from [192.168.2.131] (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 877BE6601ACF;
        Mon, 16 Jan 2023 12:16:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673871412;
        bh=DBPrqVIX0FkXdk29cXAhbSyKQJoqHM21fjclrZVPmYg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O+iauYzlKCNj7yGhonfleUevaKod2TXyW+fN0XihMUOHtRjAjiAlIzdaGmo164C2B
         /McP217ZQdZM+KKzy1H0bAeV15tIwXuwN1c9zI4uNGCv6+CkhaKbz688gdlmKxigFq
         kIfadDHUAS/lg0RG99oe7D+b94XEXsrCMmJrtctXmjBZh8zN+tB5naC5798Sm3nAUs
         ItNS+fEM6uYUWYZicGMjpPgdvTqqHfAf9uBteSD1SYiSvlaYjG7Aai0ohx2D49jZ2y
         +fKdl6Af7Q6We8+FroExhZCEeg0CbzUWWfMb8n95b426PAGNqyoF+n59AMg4gMFADc
         5NUSD6n0ebTuA==
Message-ID: <8bd5cf36-e1fb-305c-08c5-3bbc80204866@collabora.com>
Date:   Mon, 16 Jan 2023 15:16:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 08/10] cpufreq: tegra194: add OPP support and set
 bandwidth
To:     Sumit Gupta <sumitg@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, treding@nvidia.com,
        krzysztof.kozlowski@linaro.org, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com, Rajkumar Kasirajan <rkasirajan@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-9-sumitg@nvidia.com>
 <4e3e4485-ba22-eb47-fb95-e8d626160bc6@gmail.com>
 <8e6d7dd3-1bdc-ee4b-0c1e-1ae9cd8e4f29@nvidia.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <8e6d7dd3-1bdc-ee4b-0c1e-1ae9cd8e4f29@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 16:50, Sumit Gupta wrote:
> 
> 
> On 22/12/22 21:16, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 20.12.2022 19:02, Sumit Gupta пишет:
>>> Add support to use OPP table from DT in Tegra194 cpufreq driver.
>>> Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
>>> Cross check the OPP's present in DT against the LUT from BPMP-FW
>>> and enable only those DT OPP's which are present in LUT also.
>>>
>>> The OPP table in DT has CPU Frequency to bandwidth mapping where
>>> the bandwidth value is per MC channel. DRAM bandwidth depends on the
>>> number of MC channels which can vary as per the boot configuration.
>>> This per channel bandwidth from OPP table will be later converted by
>>> MC driver to final bandwidth value by multiplying with number of
>>> channels before sending the request to BPMP-FW.
>>>
>>> If OPP table is not present in DT, then use the LUT from BPMP-FW directy
>>> as the frequency table and not do the DRAM frequency scaling which is
>>> same as the current behavior.
>>>
>>> Now, as the CPU Frequency table is being controlling through OPP table
>>> in DT. Keeping fewer entries in the table will create less frequency
>>> steps and scale fast to high frequencies if required.
>>
>> It's not exactly clear what you're doing here. Are you going to scale
>> memory BW based on CPU freq? If yes, then this is wrong because CPU freq
>> is independent from the memory subsystem.
>>
>> All Tegra30+ SoCs have ACTMON hardware unit that monitors CPU memory
>> activity and CPU memory BW should be scaled based on CPU memory events
>> counter. We have ACTMON devfreq driver for older SoCs. I have no clue
>> how ACTMON can be accessed on T186+, perhaps there should be a BPMP FW
>> API for that.
>>
> 
> Yes, scaling the memory BW based on CPU freq.
> Referred below patch set for previous generation of Tegra Soc's which
> you mentioned and tried to trace the history.
> 
> https://patchwork.ozlabs.org/project/linux-tegra/patch/1418719298-25314-3-git-send-email-tomeu.vizoso@collabora.com/
> 
> In new Tegra Soc's, actmon counter control and usage has been moved to
> BPMP-FW where only 'MCALL' counter is used and 'MCCPU is not being used.
> Using the actmon counter was a reactive way to scale the frequency which
> is less effective due to averaging over a time period.
> We are now using the proactive way where clients tell their bandwidth
> needs to help achieve better performance.

You don't know what bandwidth CPU needs, you trying to guess it.

It should be a bad decision to use cpufreq for memory bandwidth scaling.
You'll be wasting memory power 90% of time because cpufreq doesn't have
relation to the DRAM, your heuristics will be wrong and won't do
anything good compared to using ACTMON. The L2 CPU cache + memory
prefetching hides memory from CPU. And cpufreq should be less reactive
than ACTMON in general.

Scaling memory freq based on cpufreq is what downstream NV kernel did
10+ years ago for the oldest Tegra generations. Today upstream has all
the necessary infrastructure for doing memory bandwidth scaling properly
and we even using h/w memory counters on T20. It's strange that you want
to bring the downstream archaity to the modern upstream for the latest
Tegra generations.

If you can skip the BPMP-FW and use ACTMON directly from kernel, then
that's what I suggest to do.

-- 
Best regards,
Dmitry

