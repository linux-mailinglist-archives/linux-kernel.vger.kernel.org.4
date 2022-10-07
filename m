Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA4A5F7997
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJGOPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJGOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:15:07 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62A64E43D;
        Fri,  7 Oct 2022 07:15:04 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1ogo7w-0006YW-Ot; Fri, 07 Oct 2022 16:15:00 +0200
Message-ID: <31f8c4d1-1575-e64d-f42a-ce864e060975@maciej.szmigiero.name>
Date:   Fri, 7 Oct 2022 16:14:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, pl-PL
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ed1c179cff84b49e22cf229cc69751fa4d357d9a.1664221825.git.maciej.szmigiero@oracle.com>
 <df8701f3905c1a394863e57c7a2d30c5b5dc3503.1664221825.git.maciej.szmigiero@oracle.com>
 <24a48f71-8a79-6311-1e43-494df0458a32@opensource.wdc.com>
 <7ecf20b7-794a-39d8-0b03-8f19d9167efd@maciej.szmigiero.name>
 <28712bad-8215-4246-7370-42d204488aa3@opensource.wdc.com>
 <7cf5744e-78ec-79c3-98af-2a716167ea1a@opensource.wdc.com>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 2/2] ata: allow enabling FUA support in Kconfig
In-Reply-To: <7cf5744e-78ec-79c3-98af-2a716167ea1a@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.10.2022 00:53, Damien Le Moal wrote:
> On 10/7/22 07:20, Damien Le Moal wrote:
>> On 10/6/22 22:06, Maciej S. Szmigiero wrote:
>>> On 6.10.2022 01:38, Damien Le Moal wrote:
>>>> On 9/27/22 04:51, Maciej S. Szmigiero wrote:
>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>
>>>>> Currently, if one wants to make use of FUA support in libata it is
>>>>> necessary to provide an explicit kernel command line parameter in order to
>>>>> enable it (for drives that report such support).
>>>>>
>>>>> In terms of Git archaeology: FUA support was enabled by default in early
>>>>> libata versions but was disabled soon after.
>>>>> Since then there were a few attempts to enable this support by default:
>>>>> [1] (for NCQ drives only), [2] (for all drives).
>>>>> However, the second change had to be reverted after a report came of
>>>>> an incompatibility with the HDD in 2011 Mac Mini.
>>>>>
>>>>> Enabling FUA avoids having to emulate it by issuing an extra drive cache
>>>>> flush for every request that have this flag set.
>>>>> Since FUA support is required by the ATA/ATAPI spec for any drive that
>>>>> supports LBA48 and so these days should be pretty widespread let's provide
>>>>> an ability to enable it by default in Kconfig.
>>>>
>>>> This can be done by adding "libata.fua=1" to the CONFIG_CMDLINE option. So
>>>> I do not see the need to add yet another config option.
>>>
>>> A specific Kconfig option is more structured than a free-form
>>> CONFIG_CMDLINE (which is also technically a per-arch option, but seems
>>> to be widely supported across arches).
>>>
>>> That's why there is a lot (100+) of similar Kconfig default-changing
>>> options, a quick sample of these (in no particular order):
>>> SOUND_OSS_CORE_PRECLAIM, SND_INTEL_BYT_PREFER_SOF, LSM,
>>> SECURITY_SELINUX_CHECKREQPROT_VALUE, SECURITY_LOADPIN_ENFORCE,
>>> SECURITY_APPARMOR_DEBUG_MESSAGES, IP_VS_TAB_BITS, IP_SET_MAX,
>>> MAC80211_HAS_RC, SLUB_DEBUG_ON, KFENCE_SAMPLE_INTERVAL, PRINTK_TIME,
>>> DEBUG_OBJECTS_ENABLE_DEFAULT, RCU_NOCB_CPU_DEFAULT_ALL, ...
>>>
>>> libata currently has only one similar option: SATA_MOBILE_LPM_POLICY,
>>> so it's not like a person performing kernel configuration is
>>> overloaded with questions here.
>>>
>>> But at the same time, I respect your decision as a maintainer of
>>> this code.
>>
>> I am not dead set on pushing back on this, but as usual, whenever we can
>> avoid adding config options, we should. Given that libata has had fua
>> disabled forever, I am not convinced yet that there is a strong need for
>> that new option. But if distros prefer the config option approach, we can
>> make that happen.
>>
>> If anything, I would be tempted to switch fua support to on by default
>> after some time if we do not get many reports of broken drives. You did
>> mention that old mac minis drives did not like it, but these are not even
>> blacklisted in libata-scsi. They should. Only one model of maxtor drives
>> is. We should add an ATA_HORKAGE_NO_FUA flag and start a proper blacklist
>> of drives not liking fua. Without that in place, switching to on by
>> default as your config option allows could break many (old) systems.
> 
> To be extra clear, I think that this fua module parameter is silly. If a
> drive says it supports fua, we should use it and not have a global
> parameter to disable it for all drives. So no config option needed for it.
> 
> That is also why I am not keen on taking that config option. It is not
> really improving anything at all and would prefer nuking the fua module
> argument and have a proper blacklisting of buggy drives.
> 
> But such a change is painful as we'll be able to update the blacklist with
> users getting corrupted FSes on buggy drives. The time may have come to do
> this change though as the number of buggy drives out there is hopefully
> small enough now.

So your proposal is basically to switch the existing fua option default
to "on" and deal with the fallout (hopefully minimal) by blacklisting
misbehaving drives as they get reported, right?

In this case, my vote would be to still keep the "libata.fua" parameter
available (at least for the time being) so people have some way of
working broken drives around without having to recompile their kernel
(maybe also print a kernel log message if libata.fua=0 is provided asking
people to report these drive models to linux-ide@).

Thanks,
Maciej

