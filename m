Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A8263F5C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiLAQ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiLAQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:56:24 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D6A13DB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:56:18 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B18g9ee020005;
        Thu, 1 Dec 2022 10:56:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=d+Oa9nDhGcm5y4BLMBlA2ieLmPpImKRoxVHj17jQNJc=;
 b=llJVeNF0JPCFg3Jw8sFU011Ln+SxdVP3Za+IIHd/hplNjZWgqcuMZJCoVTTDLDOeEsU5
 LenCr7WpZ8ybH0tDLdc11PuVTIEqqSaZA55h/1ES+SzO6ilan9nxEzESfdsdSI94Ia4d
 0IBt4FSPiAbkDJm/w3gaE7eenRidUKSDFqzc+IUVG2qro1clND9Q5lvhAJXSPtGsm2WV
 cRGRKKb/QDs7mPqcSIFowMg94J47gBzOUAUt6uV3SOXj6bxf0cQIrq9PMyTGjefRoCZF
 d3tiHP3upwa2lNl1bXXrB26bEtk5gbcNt+6A+0VcFCz4ydWu7Gx7AHyAILjnuR5nuxOZ tw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3m6k75rsyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 10:56:09 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 1 Dec
 2022 10:55:40 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 1 Dec 2022 10:55:40 -0600
Received: from [198.90.251.111] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 61121B10;
        Thu,  1 Dec 2022 16:55:40 +0000 (UTC)
Message-ID: <4e6cdce8-60b3-1bf5-604d-5dbe95ef3ec4@opensource.cirrus.com>
Date:   Thu, 1 Dec 2022 16:55:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] soundwire: bus_type: Avoid lockdep assert in
 sdw_drv_probe()
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <vkoul@kernel.org>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20221121162453.1834170-1-rf@opensource.cirrus.com>
 <2d207a51-d415-726b-3bc1-8788df2f06fd@linux.intel.com>
 <ea8c3ce8-b625-d70a-07f9-4470aec2cb17@opensource.cirrus.com>
 <0984eae3-438c-b382-6681-cddcc37dd47a@linux.intel.com>
 <34319214-5641-a99c-aea1-4c604a18c7eb@opensource.cirrus.com>
In-Reply-To: <34319214-5641-a99c-aea1-4c604a18c7eb@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pKXVAoiCgQ86CyGRKj4S9OKyKsUWL93R
X-Proofpoint-GUID: pKXVAoiCgQ86CyGRKj4S9OKyKsUWL93R
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 14:32, Richard Fitzgerald wrote:
> On 29/11/2022 15:44, Pierre-Louis Bossart wrote:
>>
>>
>>>>> Don't hold sdw_dev_lock while calling the peripheral driver
>>>>> probe() and remove() callbacks.
>>>>>
>>>>> Holding sdw_dev_lock around the probe() and remove() calls
>>>>> causes a theoretical mutex inversion which lockdep will
>>>>> assert on. The peripheral driver probe will probably register
>>>>> a soundcard, which will take ALSA and ASoC locks. During
>>>>
>>>> It's extremely unlikely that a peripheral driver would register a sound
>>>> card, this is what machine drivers do.
>>>>
>>>> Which leads me to the question: is this a real problem?
>>>>
>>>
>>> Yes, try turning on lockdep checking and you will get an assert.
>>> During probe the existing code takes sdw_dev_lock and then calls the
>>> codec driver probe, so you will get a mutex sequence like:
>>>
>>> sdw_dev_lock -> controls_rw_sem -> pcm_mutex
>>>
>>> but in normal operation the ALSA/ASoC code will take its mutexes first
>>> and call runtime_resume which then takes the sdw_dev_lock, so you get
>>>
>>> pcm_mutex -> sdw_dev_lock
>>>
>>> and lockdep will assert on that opposite ordering.
>>> The full assert is at the end of this email.
>>
>> Humm, you lost me with the reference to runtime_resume. I don't fully
>> understand how it's possible to invoke pm_runtime during probe.
>> pm_runtime should only enabled during the codec update_status() which
>> can only be done once the probe completes.
>>
>> I am fine with the changes that you are suggesting, the introduction of
>> the sdw_dev_lock was probably too conservative and it'd be fine to only
>> protect what is required.
>>
>> However we do have lockdep enabled
>>
> 
> I wonder whether this is because the Cirrus devices use full DP prepare,
> so there will be a DP prepare interrupt during the attempt to prepare
> the dailink. The lockdep assert was when sdw_update_slave_status() tried
> to take sdw_dev_lock.
> 
> If the Realtek codecs only use Soundwire interrupts for jack detect you
> probably won't see a sdw_dev_lock inside a pcm_mutex.

Ok, I think I understand this now.
lockdep tries to prove locking correctness without requiring that a bad
lock order actually happened. This makes sense, because some deadlocks
might be extremely difficult to reproduce and lockdep wouldn't help much
if you had to reproduce it to get an assert.

There's a lot of detail in Documentation/locking/lockdep-design.rst, but
in summary it is looking for a relationship between three locks that is
theoretically incompatible. So if it sees:
a) L1->L2
b) L2->L3
c) L3->L1
this will assert because the relationship of L1 and L2 on L3 is opposite
to the relationship of L1 to L2. IOW lockdep is assuming the possibility
of L2->L3->L1. You could look at that another way and say that lockdep
is telling you that even though you didn't intend L2->L3->L1 could ever 
happen there is a risk lurking in the code.

What we've seen is three normal call chains that give these orderings:

a) pcm_mutex -> sdw_dev_lock (when starting up a playback)
b) controls_rwsem -> pcm_mutex (a write to a DAPM MUX control
      re-evaluates DAPM power states of the DPCM links)
c) sdw_dev_lock -> controls_rwsem (when snd_soc_register_component()
      adds ALSA controls)

controls_rwsem is the "L3" here, the lock that has a relationship to two
other locks that is incompatible to those two locks' relationship to
each other in (a).

The theoretical case sdw_dev_lock->controls_rwsem->pcm_mutex should be
impossible, but it's always nicer to fix the problem that try to make
it a special case "safe to ignore".

The only places sdw_dev_lock can be taken before the ALSA/ASoC locks is
during probe() and remove(). At other times it would only be taken as a
result of an ALSA/ASoC activity so the ALSA/ASoC locks would be taken
first.
