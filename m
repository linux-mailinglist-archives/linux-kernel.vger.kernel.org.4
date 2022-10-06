Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099FF5F716C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiJFWxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJFWxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:53:32 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C91B8C39
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665096811; x=1696632811;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=LQKaqBNegBAo8X2suU9JsNDN7b21cyqeO2jhqBGH0lw=;
  b=omKfVLM9J6CuwwrIhKrmmF7N/AsnUsvMfT8vzPRlYaS1KzJbt2RhDQSc
   Kv3gCLSGQuSjKEK/CWE2CLvY7TutJ8YSvOApOBMS7AHLi4udS1/iqURYp
   qzJvlIWZZV2ousYpDobRgI8vxkTQ659fUAyZSx6cuRGP/vyejYWTgu8G5
   ji/bZyZ7muUv8sfDNWunOOQFTW3L69fuY2p5cNV1qIvuJ88JBdE+mQpcK
   aoBwTJ4x21Idig08qhyckLAzO7kHhmldoZ1kt9jHsyQ/iZP20SKfUfFCF
   TOKcO8PVJ6EYrUs/Nl3yM88xEjNEprcuvzOOHoPHieEhYInltnS5dxXp+
   A==;
X-IronPort-AV: E=Sophos;i="5.95,164,1661788800"; 
   d="scan'208";a="317475865"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2022 06:53:30 +0800
IronPort-SDR: /rEYynQxONTDOnSGwp0C9aVKvw/gJDXmU2Q35SRG7rwzG8JJSknkV+P6Rajx7bid9yXJE+nKGj
 mbGrhp/JGPtmf40usCgAJe9iOo83FtBs2w6wdI3Uf2+BbyMQEXQ8eQiXIp5KZxBBb7p/amwsQz
 PrNBMUv8BG8S/cb7mkHdbWj2+ext1H4WnjAtSxKPhvEz90F8p1byVBhpGhQkp/PPCTDXVFF0Ji
 JfUP2F0zOIYi8f1N5dNJLSvY+So4YwH+S+aojARRZabCEdyPTg30QbDabr6C3fltBvdXmNEGWN
 6ufIwxGAaXWy8ukiHfKIYcBw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 15:07:40 -0700
IronPort-SDR: nXfDLG11vndXw4gsMy2FlOs5Y1oMBNiEdV4JRxpBS9xu5ZmNe3UpBI7cqOOFrdvimh6pl09tOi
 0Bret/C5KiORhdwfcTk6TFpmQSZuLxfm/c6mWHHaiN3HaajS49wAiiTGaBhBqP8hYP+y5crHCi
 5S6aWmmd/9R0KQpRgy4LzX34pLla8uwDIBSPi+KhQuQaC+T1uErD0wMbANyV7Y0d5bNwwXK17k
 om3pr+l+cqj2Mn4n95lrgTfdbKdDmC8NE37x47RthLAsqrRPkAlRoLqQRsNrwOJdDG3ic8IRhv
 VgU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Oct 2022 15:53:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mk6DT6WQFz1RvTp
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:53:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665096809; x=1667688810; bh=LQKaqBNegBAo8X2suU9JsNDN7b21cyqeO2j
        hqBGH0lw=; b=AFNvxHZF5uCjMFMv1Bp8hmeLYw7rnocL+Ga+B0Y1kT2i/vjDOWy
        ZeHyZRwcz1U3/X7FjQCgVJJUHCRT87DBrTJXaxHOOQK/tzWLHZZqmK6D8w0LQ5bp
        0ljxNFgXzD1dOyu3rTzoQUOLFFOr4EKn+t2ZVKRSd8qIzSl1CxoLrAeqWpMpnWLt
        1FXd0ck9uzfNyHK1N+92jV4ZuSCMkMsCQo/w2TZV6bzn2pJZ7dc2f+iXIZku8bh5
        ftWf5xhpiIM+ZEIAgNxDLtk98EPn9Wk5llqTADcfkJ6KWo6fwZXmUWJ8zG5kQBa3
        NiqCaV2PZAXfjWBo5tXLrM6LcDfw6ljEZwg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RJ4xvJZs3BMP for <linux-kernel@vger.kernel.org>;
        Thu,  6 Oct 2022 15:53:29 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mk6DS6NY0z1RvLy;
        Thu,  6 Oct 2022 15:53:28 -0700 (PDT)
Message-ID: <7cf5744e-78ec-79c3-98af-2a716167ea1a@opensource.wdc.com>
Date:   Fri, 7 Oct 2022 07:53:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 2/2] ata: allow enabling FUA support in Kconfig
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ed1c179cff84b49e22cf229cc69751fa4d357d9a.1664221825.git.maciej.szmigiero@oracle.com>
 <df8701f3905c1a394863e57c7a2d30c5b5dc3503.1664221825.git.maciej.szmigiero@oracle.com>
 <24a48f71-8a79-6311-1e43-494df0458a32@opensource.wdc.com>
 <7ecf20b7-794a-39d8-0b03-8f19d9167efd@maciej.szmigiero.name>
 <28712bad-8215-4246-7370-42d204488aa3@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <28712bad-8215-4246-7370-42d204488aa3@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 07:20, Damien Le Moal wrote:
> On 10/6/22 22:06, Maciej S. Szmigiero wrote:
>> On 6.10.2022 01:38, Damien Le Moal wrote:
>>> On 9/27/22 04:51, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Currently, if one wants to make use of FUA support in libata it is
>>>> necessary to provide an explicit kernel command line parameter in order to
>>>> enable it (for drives that report such support).
>>>>
>>>> In terms of Git archaeology: FUA support was enabled by default in early
>>>> libata versions but was disabled soon after.
>>>> Since then there were a few attempts to enable this support by default:
>>>> [1] (for NCQ drives only), [2] (for all drives).
>>>> However, the second change had to be reverted after a report came of
>>>> an incompatibility with the HDD in 2011 Mac Mini.
>>>>
>>>> Enabling FUA avoids having to emulate it by issuing an extra drive cache
>>>> flush for every request that have this flag set.
>>>> Since FUA support is required by the ATA/ATAPI spec for any drive that
>>>> supports LBA48 and so these days should be pretty widespread let's provide
>>>> an ability to enable it by default in Kconfig.
>>>
>>> This can be done by adding "libata.fua=1" to the CONFIG_CMDLINE option. So
>>> I do not see the need to add yet another config option.
>>
>> A specific Kconfig option is more structured than a free-form
>> CONFIG_CMDLINE (which is also technically a per-arch option, but seems
>> to be widely supported across arches).
>>
>> That's why there is a lot (100+) of similar Kconfig default-changing
>> options, a quick sample of these (in no particular order):
>> SOUND_OSS_CORE_PRECLAIM, SND_INTEL_BYT_PREFER_SOF, LSM,
>> SECURITY_SELINUX_CHECKREQPROT_VALUE, SECURITY_LOADPIN_ENFORCE,
>> SECURITY_APPARMOR_DEBUG_MESSAGES, IP_VS_TAB_BITS, IP_SET_MAX,
>> MAC80211_HAS_RC, SLUB_DEBUG_ON, KFENCE_SAMPLE_INTERVAL, PRINTK_TIME,
>> DEBUG_OBJECTS_ENABLE_DEFAULT, RCU_NOCB_CPU_DEFAULT_ALL, ...
>>
>> libata currently has only one similar option: SATA_MOBILE_LPM_POLICY,
>> so it's not like a person performing kernel configuration is
>> overloaded with questions here.
>>
>> But at the same time, I respect your decision as a maintainer of
>> this code.
> 
> I am not dead set on pushing back on this, but as usual, whenever we can
> avoid adding config options, we should. Given that libata has had fua
> disabled forever, I am not convinced yet that there is a strong need for
> that new option. But if distros prefer the config option approach, we can
> make that happen.
> 
> If anything, I would be tempted to switch fua support to on by default
> after some time if we do not get many reports of broken drives. You did
> mention that old mac minis drives did not like it, but these are not even
> blacklisted in libata-scsi. They should. Only one model of maxtor drives
> is. We should add an ATA_HORKAGE_NO_FUA flag and start a proper blacklist
> of drives not liking fua. Without that in place, switching to on by
> default as your config option allows could break many (old) systems.

To be extra clear, I think that this fua module parameter is silly. If a
drive says it supports fua, we should use it and not have a global
parameter to disable it for all drives. So no config option needed for it.

That is also why I am not keen on taking that config option. It is not
really improving anything at all and would prefer nuking the fua module
argument and have a proper blacklisting of buggy drives.

But such a change is painful as we'll be able to update the blacklist with
users getting corrupted FSes on buggy drives. The time may have come to do
this change though as the number of buggy drives out there is hopefully
small enough now.

> 
> 
>>
>>>
>>> Patch 1 looks good. I will queue it up once rc1 is out.
>>
>> Thanks,
>> Maciej
>>
>>
> 

-- 
Damien Le Moal
Western Digital Research

