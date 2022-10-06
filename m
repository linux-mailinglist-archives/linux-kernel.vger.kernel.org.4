Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CA15F6745
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiJFNGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJFNGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:06:44 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C53A5732;
        Thu,  6 Oct 2022 06:06:38 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1ogQaA-0003JS-Sk; Thu, 06 Oct 2022 15:06:34 +0200
Message-ID: <7ecf20b7-794a-39d8-0b03-8f19d9167efd@maciej.szmigiero.name>
Date:   Thu, 6 Oct 2022 15:06:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US, pl-PL
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ed1c179cff84b49e22cf229cc69751fa4d357d9a.1664221825.git.maciej.szmigiero@oracle.com>
 <df8701f3905c1a394863e57c7a2d30c5b5dc3503.1664221825.git.maciej.szmigiero@oracle.com>
 <24a48f71-8a79-6311-1e43-494df0458a32@opensource.wdc.com>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 2/2] ata: allow enabling FUA support in Kconfig
In-Reply-To: <24a48f71-8a79-6311-1e43-494df0458a32@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.10.2022 01:38, Damien Le Moal wrote:
> On 9/27/22 04:51, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Currently, if one wants to make use of FUA support in libata it is
>> necessary to provide an explicit kernel command line parameter in order to
>> enable it (for drives that report such support).
>>
>> In terms of Git archaeology: FUA support was enabled by default in early
>> libata versions but was disabled soon after.
>> Since then there were a few attempts to enable this support by default:
>> [1] (for NCQ drives only), [2] (for all drives).
>> However, the second change had to be reverted after a report came of
>> an incompatibility with the HDD in 2011 Mac Mini.
>>
>> Enabling FUA avoids having to emulate it by issuing an extra drive cache
>> flush for every request that have this flag set.
>> Since FUA support is required by the ATA/ATAPI spec for any drive that
>> supports LBA48 and so these days should be pretty widespread let's provide
>> an ability to enable it by default in Kconfig.
> 
> This can be done by adding "libata.fua=1" to the CONFIG_CMDLINE option. So
> I do not see the need to add yet another config option.

A specific Kconfig option is more structured than a free-form
CONFIG_CMDLINE (which is also technically a per-arch option, but seems
to be widely supported across arches).

That's why there is a lot (100+) of similar Kconfig default-changing
options, a quick sample of these (in no particular order):
SOUND_OSS_CORE_PRECLAIM, SND_INTEL_BYT_PREFER_SOF, LSM,
SECURITY_SELINUX_CHECKREQPROT_VALUE, SECURITY_LOADPIN_ENFORCE,
SECURITY_APPARMOR_DEBUG_MESSAGES, IP_VS_TAB_BITS, IP_SET_MAX,
MAC80211_HAS_RC, SLUB_DEBUG_ON, KFENCE_SAMPLE_INTERVAL, PRINTK_TIME,
DEBUG_OBJECTS_ENABLE_DEFAULT, RCU_NOCB_CPU_DEFAULT_ALL, ...

libata currently has only one similar option: SATA_MOBILE_LPM_POLICY,
so it's not like a person performing kernel configuration is
overloaded with questions here.

But at the same time, I respect your decision as a maintainer of
this code.

> 
> Patch 1 looks good. I will queue it up once rc1 is out.

Thanks,
Maciej


