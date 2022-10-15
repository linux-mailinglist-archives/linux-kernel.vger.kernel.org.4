Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EE25FF7A9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 02:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJOAiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 20:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJOAiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 20:38:02 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2973F311
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 17:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665794280; x=1697330280;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/QmhuhGpwxlsN1ypGljfDpvvTDeYqWgqdS1ywU2M30U=;
  b=hSvMXHpE7wLPoVOzSgbqz8QLBTMSkt00B0PlctlbAv0IHxvJ7d6ENkfu
   Kv6RjeEZpffFFkQO387L/3M5rcOXMutNpr97nswt5K6/OzufgHNOQc9RE
   pm2ReC9XcxXLbsTQxRq+QjBucCGB6Nk5cpqOUIc2YyynLlnT4LWv8Y+td
   C1uXKNb8iDHXsNls2LFc8gSTurSFpwx6/Ar2nDwbXoYhHb/6s7p1Vl2K0
   s1fkJGPlhOoi2O/QfyECXJELdw9ocPKvVtUj9K1AAcFdYgPplWkfQv4eC
   LSa3hydVCWNC5zpFisZg/Lace2CwJZgewwTSJ8grJ7kHpNTWV2WXFVXeb
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,185,1661788800"; 
   d="scan'208";a="212179257"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2022 08:37:59 +0800
IronPort-SDR: 1wn8gLPUePdrL3sp0USEFu2jkQli0VeTJ2WHlnFuIeAU/pXdqpin6nzKjWg9AAcATa4lPJ4oC1
 YHxrw6PlTHoKQGcGrPqURhSVBOVmN6oi1+qCt+b/Nv6fXWvvSoczN2uoyVUHzWdRMDRELDo4Y2
 OtMl2HqoZX0Bw9Nc3A2174zm4JGWVKvZCzJfFLXG/fKx3RPV6NPycBYtZuSYXn63CR0U9dUjAr
 J4lt8Az1PHYW/iux5opqVnBGlC9nbvLCdzm2k3YowJCqB0Nsn1FCEXNHXQtLAc50zycIX6fEbt
 R1vfd1Zgps9Q3RwxGCPQ9egu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2022 16:57:35 -0700
IronPort-SDR: 2n69qgBsYD4WDkhS4qePMVH+fh2rHIbw5EsSF4fFp4i+hCD9gC+KZ+KvE1Uol2rL+lyybOTrrp
 CdEL92nOH8Di4gvw0KEWWp9TBIXCTxmu6ukaPw/1wKwk5reaPkN7qzYsx9LY27XADOAmPDvL5E
 7wWfQmOB+7/WgI3Lzwed3ndMysKo7XREhgAF5e67fLX5hS6WkxT0xj8vZ1WrGtr/e7UrEGO5j/
 ks4w1bF/0QjslZL2n3tn+FtDQWmoAzSJeOfJthAIYFR+t0tZpGYVsWQX5Z4J5RNxRYSQ86Z6GO
 L/o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2022 17:38:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mq49M4sW5z1RvTp
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 17:37:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665794279; x=1668386280; bh=/QmhuhGpwxlsN1ypGljfDpvvTDeYqWgqdS1
        ywU2M30U=; b=Ofzb9SmEQLGz4P1oJpET9H1vEwnuojNa63vza1BBUxf+4BeTQ09
        LC8pN4hc9B/m4YotC6lKwQmhxTE8wFLwobcLHvU+z1B+cl10rOHotU+3fzMalMZa
        LdmDUMyZDJNCrQEFiaoZDIwpQEEBKLuX1GB++LfJSIZh9SuTrZC1sdYdD+ooqGDk
        EuXmxemvaGae4WN2l3xInFsyVsyVWFyUvb+at6xGJ9546SWIkuLtl8z8H+leAf0R
        SEWAZnHXZu2SCMVsg9zpTyQnrYWDV6aTMB4U0imCvrnK4Jgv/MmtMD31MdakLl8J
        zpjur6ID9bof4vbcC4tXOgFD18VjfeQAtcw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lLwADHM6h_Zb for <linux-kernel@vger.kernel.org>;
        Fri, 14 Oct 2022 17:37:59 -0700 (PDT)
Received: from [10.225.163.119] (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mq49L4Hpzz1RvLy;
        Fri, 14 Oct 2022 17:37:58 -0700 (PDT)
Message-ID: <0a130555-6a83-f158-c77c-7eb69799b5b3@opensource.wdc.com>
Date:   Sat, 15 Oct 2022 09:37:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] ata: allow enabling FUA support in Kconfig
Content-Language: en-US
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ed1c179cff84b49e22cf229cc69751fa4d357d9a.1664221825.git.maciej.szmigiero@oracle.com>
 <df8701f3905c1a394863e57c7a2d30c5b5dc3503.1664221825.git.maciej.szmigiero@oracle.com>
 <24a48f71-8a79-6311-1e43-494df0458a32@opensource.wdc.com>
 <7ecf20b7-794a-39d8-0b03-8f19d9167efd@maciej.szmigiero.name>
 <28712bad-8215-4246-7370-42d204488aa3@opensource.wdc.com>
 <7cf5744e-78ec-79c3-98af-2a716167ea1a@opensource.wdc.com>
 <31f8c4d1-1575-e64d-f42a-ce864e060975@maciej.szmigiero.name>
 <cb78be0f-633c-29ee-a3c8-cc05d8108cf9@opensource.wdc.com>
 <220d39ad-11cc-338f-806e-293ac43b5021@maciej.szmigiero.name>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <220d39ad-11cc-338f-806e-293ac43b5021@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/22 01:44, Maciej S. Szmigiero wrote:
> On 8.10.2022 00:41, Damien Le Moal wrote:
>> On 10/7/22 23:14, Maciej S. Szmigiero wrote:
>>> On 7.10.2022 00:53, Damien Le Moal wrote:
>>>> On 10/7/22 07:20, Damien Le Moal wrote:
>>>>> On 10/6/22 22:06, Maciej S. Szmigiero wrote:
>>>>>> On 6.10.2022 01:38, Damien Le Moal wrote:
>>>>>>> On 9/27/22 04:51, Maciej S. Szmigiero wrote:
>>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>>
>>>>>>>> Currently, if one wants to make use of FUA support in libata it is
>>>>>>>> necessary to provide an explicit kernel command line parameter in order to
>>>>>>>> enable it (for drives that report such support).
>>>>>>>>
>>>>>>>> In terms of Git archaeology: FUA support was enabled by default in early
>>>>>>>> libata versions but was disabled soon after.
>>>>>>>> Since then there were a few attempts to enable this support by default:
>>>>>>>> [1] (for NCQ drives only), [2] (for all drives).
>>>>>>>> However, the second change had to be reverted after a report came of
>>>>>>>> an incompatibility with the HDD in 2011 Mac Mini.
>>>>>>>>
>>>>>>>> Enabling FUA avoids having to emulate it by issuing an extra drive cache
>>>>>>>> flush for every request that have this flag set.
>>>>>>>> Since FUA support is required by the ATA/ATAPI spec for any drive that
>>>>>>>> supports LBA48 and so these days should be pretty widespread let's provide
>>>>>>>> an ability to enable it by default in Kconfig.
>>>>>>>
>>>>>>> This can be done by adding "libata.fua=1" to the CONFIG_CMDLINE option. So
>>>>>>> I do not see the need to add yet another config option.
>>>>>>
>>>>>> A specific Kconfig option is more structured than a free-form
>>>>>> CONFIG_CMDLINE (which is also technically a per-arch option, but seems
>>>>>> to be widely supported across arches).
>>>>>>
>>>>>> That's why there is a lot (100+) of similar Kconfig default-changing
>>>>>> options, a quick sample of these (in no particular order):
>>>>>> SOUND_OSS_CORE_PRECLAIM, SND_INTEL_BYT_PREFER_SOF, LSM,
>>>>>> SECURITY_SELINUX_CHECKREQPROT_VALUE, SECURITY_LOADPIN_ENFORCE,
>>>>>> SECURITY_APPARMOR_DEBUG_MESSAGES, IP_VS_TAB_BITS, IP_SET_MAX,
>>>>>> MAC80211_HAS_RC, SLUB_DEBUG_ON, KFENCE_SAMPLE_INTERVAL, PRINTK_TIME,
>>>>>> DEBUG_OBJECTS_ENABLE_DEFAULT, RCU_NOCB_CPU_DEFAULT_ALL, ...
>>>>>>
>>>>>> libata currently has only one similar option: SATA_MOBILE_LPM_POLICY,
>>>>>> so it's not like a person performing kernel configuration is
>>>>>> overloaded with questions here.
>>>>>>
>>>>>> But at the same time, I respect your decision as a maintainer of
>>>>>> this code.
>>>>>
>>>>> I am not dead set on pushing back on this, but as usual, whenever we can
>>>>> avoid adding config options, we should. Given that libata has had fua
>>>>> disabled forever, I am not convinced yet that there is a strong need for
>>>>> that new option. But if distros prefer the config option approach, we can
>>>>> make that happen.
>>>>>
>>>>> If anything, I would be tempted to switch fua support to on by default
>>>>> after some time if we do not get many reports of broken drives. You did
>>>>> mention that old mac minis drives did not like it, but these are not even
>>>>> blacklisted in libata-scsi. They should. Only one model of maxtor drives
>>>>> is. We should add an ATA_HORKAGE_NO_FUA flag and start a proper blacklist
>>>>> of drives not liking fua. Without that in place, switching to on by
>>>>> default as your config option allows could break many (old) systems.
>>>>
>>>> To be extra clear, I think that this fua module parameter is silly. If a
>>>> drive says it supports fua, we should use it and not have a global
>>>> parameter to disable it for all drives. So no config option needed for it.
>>>>
>>>> That is also why I am not keen on taking that config option. It is not
>>>> really improving anything at all and would prefer nuking the fua module
>>>> argument and have a proper blacklisting of buggy drives.
>>>>
>>>> But such a change is painful as we'll be able to update the blacklist with
>>>> users getting corrupted FSes on buggy drives. The time may have come to do
>>>> this change though as the number of buggy drives out there is hopefully
>>>> small enough now.
>>>
>>> So your proposal is basically to switch the existing fua option default
>>> to "on" and deal with the fallout (hopefully minimal) by blacklisting
>>> misbehaving drives as they get reported, right?
>>
>> Yes. The risk though is that if the fallout are not minimal and we get too
>> many bug reports, we'll likely have to revert. So this needs to be
>> attempted early at the beginning of a cycle to get plenty of testing.
>>
>>> In this case, my vote would be to still keep the "libata.fua" parameter
>>> available (at least for the time being) so people have some way of
>>> working broken drives around without having to recompile their kernel
>>> (maybe also print a kernel log message if libata.fua=0 is provided asking
>>> people to report these drive models to linux-ide@).
>>
>> If we add a proper "nofua" horkage flag to blacklist buggy drives, we need
>> to move the fua parameter to be an argument of the force parameter so that
>> disabling fua can be done per drive (port) or for all drives, similarly to
>> other tweak (noncq, nodmalog, etc)
> 
> So would you like an updated patch set or do you prefer to do the changes
> yourself?

Almost done already :) Need a lot of testing though.
Will post the patches when done.

Note that for now, I kept the fua module parameter, for compatibility with
existing setups. But I added the parameter force=[no]fua which allows
doing the same global enable/disable but also per drive enable/disable.
And known bad drives can be marked with the horkage flag.

> 
> Thanks,
> Maciej
> 

-- 
Damien Le Moal
Western Digital Research

