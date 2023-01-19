Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23069673936
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjASNCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjASNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:02:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FC27929F;
        Thu, 19 Jan 2023 05:01:40 -0800 (PST)
Received: from [192.168.2.218] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 98A3D6600869;
        Thu, 19 Jan 2023 13:01:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674133298;
        bh=fjUaht6DPGtzehSfi1kenXnsEEFgFtJ1Jb/3qy0Vx2U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=azaiCvD3FzN4KWRBkluCI07EtjI1o7ek8bp69iHSYLlcgS/TGcLrqOYkaq74ETHRI
         gXqbe6Tu7hOU70g/PHJGzrxpDTq6p8ADIr69y8cy1C0AVGZZmcnLKA3P2A4SyhSmsn
         uH1aTmAkaZ7zmu8gynVBhNshnRBWfwK4LDiL/aSL4YNoOGN12dgpGY5639ti+EzW8Y
         apNLjR7j3/FhMNWJ5OzCDP+Nqd00yTnCcoRjKi53fB4xZRZPn3T3EnNrXeeDakF/xl
         Ulka15dWFSGGKU2Zi5XtDuNlGbRt5VxH6w2/YYf1faHldEWvkxyKjH0G6bzn3VFoDg
         eyaPjV+yZS6gQ==
Message-ID: <65e596c9-a472-d0b8-ec2f-6935d647ddb2@collabora.com>
Date:   Thu, 19 Jan 2023 16:01:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 08/10] cpufreq: tegra194: add OPP support and set
 bandwidth
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sumit Gupta <sumitg@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, treding@nvidia.com,
        krzysztof.kozlowski@linaro.org, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com, Rajkumar Kasirajan <rkasirajan@nvidia.com>
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-9-sumitg@nvidia.com>
 <4e3e4485-ba22-eb47-fb95-e8d626160bc6@gmail.com>
 <8e6d7dd3-1bdc-ee4b-0c1e-1ae9cd8e4f29@nvidia.com>
 <8bd5cf36-e1fb-305c-08c5-3bbc80204866@collabora.com> <Y8kay0/AmjqhU2jO@orome>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <Y8kay0/AmjqhU2jO@orome>
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

On 1/19/23 13:26, Thierry Reding wrote:
> On Mon, Jan 16, 2023 at 03:16:48PM +0300, Dmitry Osipenko wrote:
>> On 1/13/23 16:50, Sumit Gupta wrote:
>>>
>>>
>>> On 22/12/22 21:16, Dmitry Osipenko wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> 20.12.2022 19:02, Sumit Gupta пишет:
>>>>> Add support to use OPP table from DT in Tegra194 cpufreq driver.
>>>>> Tegra SoC's receive the frequency lookup table (LUT) from BPMP-FW.
>>>>> Cross check the OPP's present in DT against the LUT from BPMP-FW
>>>>> and enable only those DT OPP's which are present in LUT also.
>>>>>
>>>>> The OPP table in DT has CPU Frequency to bandwidth mapping where
>>>>> the bandwidth value is per MC channel. DRAM bandwidth depends on the
>>>>> number of MC channels which can vary as per the boot configuration.
>>>>> This per channel bandwidth from OPP table will be later converted by
>>>>> MC driver to final bandwidth value by multiplying with number of
>>>>> channels before sending the request to BPMP-FW.
>>>>>
>>>>> If OPP table is not present in DT, then use the LUT from BPMP-FW directy
>>>>> as the frequency table and not do the DRAM frequency scaling which is
>>>>> same as the current behavior.
>>>>>
>>>>> Now, as the CPU Frequency table is being controlling through OPP table
>>>>> in DT. Keeping fewer entries in the table will create less frequency
>>>>> steps and scale fast to high frequencies if required.
>>>>
>>>> It's not exactly clear what you're doing here. Are you going to scale
>>>> memory BW based on CPU freq? If yes, then this is wrong because CPU freq
>>>> is independent from the memory subsystem.
>>>>
>>>> All Tegra30+ SoCs have ACTMON hardware unit that monitors CPU memory
>>>> activity and CPU memory BW should be scaled based on CPU memory events
>>>> counter. We have ACTMON devfreq driver for older SoCs. I have no clue
>>>> how ACTMON can be accessed on T186+, perhaps there should be a BPMP FW
>>>> API for that.
>>>>
>>>
>>> Yes, scaling the memory BW based on CPU freq.
>>> Referred below patch set for previous generation of Tegra Soc's which
>>> you mentioned and tried to trace the history.
>>>
>>> https://patchwork.ozlabs.org/project/linux-tegra/patch/1418719298-25314-3-git-send-email-tomeu.vizoso@collabora.com/
>>>
>>> In new Tegra Soc's, actmon counter control and usage has been moved to
>>> BPMP-FW where only 'MCALL' counter is used and 'MCCPU is not being used.
>>> Using the actmon counter was a reactive way to scale the frequency which
>>> is less effective due to averaging over a time period.
>>> We are now using the proactive way where clients tell their bandwidth
>>> needs to help achieve better performance.
>>
>> You don't know what bandwidth CPU needs, you trying to guess it.
>>
>> It should be a bad decision to use cpufreq for memory bandwidth scaling.
>> You'll be wasting memory power 90% of time because cpufreq doesn't have
>> relation to the DRAM, your heuristics will be wrong and won't do
>> anything good compared to using ACTMON. The L2 CPU cache + memory
>> prefetching hides memory from CPU. And cpufreq should be less reactive
>> than ACTMON in general.
>>
>> Scaling memory freq based on cpufreq is what downstream NV kernel did
>> 10+ years ago for the oldest Tegra generations. Today upstream has all
>> the necessary infrastructure for doing memory bandwidth scaling properly
>> and we even using h/w memory counters on T20. It's strange that you want
>> to bring the downstream archaity to the modern upstream for the latest
>> Tegra generations.
>>
>> If you can skip the BPMP-FW and use ACTMON directly from kernel, then
>> that's what I suggest to do.
> 
> After talking to a few people, it turns out that BPMP is already using
> ACTMON internally to do the actual scaling of the EMC frequency (or the
> CPUs contribution to that). So BPMP will use ACTMON counters to monitor
> the effective memory load of the CPU and adjust the EMC frequency. The
> bandwidth request that we generate from the cpufreq driver is more of a
> guideline for the maximum bandwidth we might consume.

Our kernel ACTMON driver uses cpufreq for guiding the EMC freq. Driving
EMC rate solely based on cpufreq would be a not good decision. So does
it mean you're now going to extend the ACTMON driver with the BPMP support?

-- 
Best regards,
Dmitry

