Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9701B623733
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiKIXBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiKIXAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:00:50 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED727DFF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 15:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668034849; x=1699570849;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+OovEAf12y9Fz1WE3tu8W4ZvEc94J8OydV/Ckp1pyWo=;
  b=fIntjugyH1g3FMb08iv9LohbyeTH8ffrERXc2LN60nh3hoz4UAy4+Jgl
   dWOh3DUqOKECvimNEBodfuUzGGXZ1+QIfJcv1viBUohVosNQ1dn+/Of3Z
   EQ6TwM0MHRc3mJyVDAHk9/i3He0omhavrDObVbzWgTAzWWL3YCYNQUdrD
   TByT+TYbFNmHnHNi2sXSH5RtRB+ccQPbCFDD4U/ewvBbdrfxK5tcG512T
   h0ElTg4sy5mYXWvqCsmtFZ8O3UNfuATuhYSWvboryFsH5EK1OzoOeXb51
   to4niqWx5LsbvTkStirzJqFXwdYkDLAbhio43vbwMoey2Ig3eNKm0cZD4
   A==;
X-IronPort-AV: E=Sophos;i="5.96,152,1665417600"; 
   d="scan'208";a="327999930"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2022 07:00:48 +0800
IronPort-SDR: KZIbGiY63GxQZ0IDcNppQLEo/5apYaCOd6OkPU4AxXT98vhN5b+XmOP2ItYp0TU4g+zMRa7NJs
 iU5NVYXSgI34hMzh6vjZrSAOz8Q895GkKw1bdCTzK6JuGOuQaCO/WVWQU4o9MKrlTYVxm4eJmQ
 aMul/XDp6KtpIKUSmKPzkYJszxK6oLXtfm/CvpMAbU/nGrODr0cgJRGE1E/JZTM0pZMA6kDqBb
 2z2WNlHpOUnya9FMNcI+g6qhPGOn7qSfi+ylKtDNtN9I6rRf0NaSi/bBgm3Vfs7SByK055Vh+q
 ChU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2022 14:14:07 -0800
IronPort-SDR: /xRo8HgcPor/gwuPI1PYoCVEL5uzl6rpq6C6OcgaYOPq0OxxFuoS/vdWHUtdcKVNc+ADPYr6gB
 S1D5eNDTjhFF+CLS3mvSkeL2vpQi8Zv3AdAUlbzIaB/Rx7M5rMNifq65R67mO6SJA+NtCX/lGp
 Lsm2+G4cTV66D+DhJcaQD+6PNwDfBHS17XgrwqvzR/swYA1Zqgine5M4553K4Bvb/vKo32wh+A
 HqidWqEGtxvaA04lgKmWNoVwS1TwUorpQ4dOjHyoxik7Mjw/AFtCRECWA+r2c58B6pCgz27dwP
 okw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2022 15:00:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N70nC35qDz1Rwrq
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 15:00:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668034845; x=1670626846; bh=+OovEAf12y9Fz1WE3tu8W4ZvEc94J8OydV/
        Ckp1pyWo=; b=d5LVMefkImhlC6X1M33kgnqUOVSy4OyuwgPnKssoBInc+jvQcn4
        mRRuo+n6+xCwto2lCdhHGgn9/yE1IHd5m/mJCMy6AFepyMSmjVXDYGgTZMIVFXGS
        VnebvtXnT509frqgR5o5RXtTO65PqKMKMnNszxNhGD1yK/zDmt347VPSVP8+HPpT
        QlyBCEbm29bzelLyj59zv9D7RO9FSUZTVKQ5JyfjnJtOXxm6lhPKIRLEFSG9m65h
        h/D5FTPTb3a2PEhrIRZcz0k9S37N5XgX4y/WaiyV1tcjEDeX4xPJ2WFW2el5q+Ut
        CQgDEdrJAHxx+n8C3SJTFg280Co5py7YdGw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8fIyKAhj8v1K for <linux-kernel@vger.kernel.org>;
        Wed,  9 Nov 2022 15:00:45 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N70n70Mkrz1RvLy;
        Wed,  9 Nov 2022 15:00:42 -0800 (PST)
Message-ID: <a0201035-8cd3-f8bc-7db3-4d011cd2c35c@opensource.wdc.com>
Date:   Thu, 10 Nov 2022 08:00:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To:     Conor.Dooley@microchip.com
Cc:     cl@linux.com, rientjes@google.com, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, 42.hyeyoo@gmail.com, willy@infradead.org,
        roman.gushchin@linux.dev, pasha.tatashin@soleen.com,
        torvalds@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        rkovhaev@gmail.com, akpm@linux-foundation.org
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <efa623fb-686f-072e-df0d-9f5727ae1b1f@microchip.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <efa623fb-686f-072e-df0d-9f5727ae1b1f@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/22 02:57, Conor.Dooley@microchip.com wrote:
> +CC Damien
> 
>> There are some devices with configs where SLOB is enabled by default.
>> Perhaps, the owners/maintainers of those devices/configs should be
>> included into this thread:
>>
>> tatashin@soleen:~/x/linux$ git grep SLOB=y
> 
>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
> 
> Saw you were not added to the CC Damien & I know you don't want your
> baby broken!

:)

I set SLOB=y for the K210 as the config help mentions it is a bit more
efficient in low memory cases. I did run a few times with SLAB and it
was OK, so removing slob should not be a problem. Can check again.

Cheers.

> 
> 
> On 08/11/2022 21:44, Pasha Tatashin wrote:
>> On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>>
>>> Hi,
>>>
>>> as we all know, we currently have three slab allocators. As we discussed
>>> at LPC [1], it is my hope that one of these allocators has a future, and
>>> two of them do not.
>>>
>>> The unsurprising reasons include code maintenance burden, other features
>>> compatible with only a subset of allocators (or more effort spent on the
>>> features), blocking API improvements (more on that below), and my
>>> inability to pronounce SLAB and SLUB in a properly distinguishable way,
>>> without resorting to spelling out the letters.
>>>
>>> I think (but may be proven wrong) that SLOB is the easier target of the
>>> two to be removed, so I'd like to focus on it first.
>>>
>>> I believe SLOB can be removed because:
>>>
>>> - AFAIK nobody really uses it? It strives for minimal memory footprint
>>> by putting all objects together, which has its CPU performance costs
>>> (locking, lack of percpu caching, searching for free space...). I'm not
>>> aware of any "tiny linux" deployment that opts for this. For example,
>>> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
>>> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
>>> SLOB impact is too much for those who tried. Googling for
>>> "CONFIG_SLOB=y" yielded nothing useful.
>>
>> I am all for removing SLOB.
>>
>> There are some devices with configs where SLOB is enabled by default.
>> Perhaps, the owners/maintainers of those devices/configs should be
>> included into this thread:
>>
>> tatashin@soleen:~/x/linux$ git grep SLOB=y
>> arch/arm/configs/clps711x_defconfig:CONFIG_SLOB=y
>> arch/arm/configs/collie_defconfig:CONFIG_SLOB=y
>> arch/arm/configs/multi_v4t_defconfig:CONFIG_SLOB=y
>> arch/arm/configs/omap1_defconfig:CONFIG_SLOB=y
>> arch/arm/configs/pxa_defconfig:CONFIG_SLOB=y
>> arch/arm/configs/tct_hammer_defconfig:CONFIG_SLOB=y
>> arch/arm/configs/xcep_defconfig:CONFIG_SLOB=y
>> arch/openrisc/configs/or1ksim_defconfig:CONFIG_SLOB=y
>> arch/openrisc/configs/simple_smp_defconfig:CONFIG_SLOB=y
>> arch/riscv/configs/nommu_k210_defconfig:CONFIG_SLOB=y
>> arch/riscv/configs/nommu_k210_sdcard_defconfig:CONFIG_SLOB=y
>> arch/riscv/configs/nommu_virt_defconfig:CONFIG_SLOB=y
>> arch/sh/configs/rsk7201_defconfig:CONFIG_SLOB=y
>> arch/sh/configs/rsk7203_defconfig:CONFIG_SLOB=y
>> arch/sh/configs/se7206_defconfig:CONFIG_SLOB=y
>> arch/sh/configs/shmin_defconfig:CONFIG_SLOB=y
>> arch/sh/configs/shx3_defconfig:CONFIG_SLOB=y
>> kernel/configs/tiny.config:CONFIG_SLOB=y
>>
>>>
>>> - Last time we discussed it [2], it seemed SLUB memory requirements can
>>> be brought very close to SLOB's if needed. Of course it can never have
>>> as small footprint as SLOB due to separate kmem_caches, but the
>>> difference is not that significant, unless somebody still tries to use
>>> Linux on very tiny systems (goes back to the previous point).
>>>
>>> Besides the smaller maintenance burden, removing SLOB would allow us to
>>> do a useful API improvement - the ability to use kfree() for both
>>> objects allocated by kmalloc() and kmem_cache_alloc(). Currently the
>>> latter has to be freed by kmem_cache_free(), passing a kmem_cache
>>> pointer in addition to the object pointer. With SLUB and SLAB, it is
>>> however possible to use kfree() instead, as the kmalloc caches and the
>>> rest of kmem_caches are the same and kfree() can lookup the kmem_cache
>>> from object pointer easily for any of those. XFS has apparently did that
>>> for years without anyone noticing it's broken on SLOB [3], and
>>> legitimizing and expanding this would help some use cases beside XFS
>>> (IIRC Matthew mentioned rcu-based freeing for example).
>>>
>>> However for SLOB to support kfree() on all allocations, it would need to
>>> store object size of allocated objects (which it currently does only for
>>> kmalloc() objects, prepending a size header to the object), but for
>>> kmem_cache_alloc() allocations as well. This has been attempted in the
>>> thread [3] but it bloats the memory usage, especially on architectures
>>> with large ARCH_KMALLOC_MINALIGN, where the prepended header basically
>>> has to occupy the whole ARCH_KMALLOC_MINALIGN block to be DMA safe.
>>> There are ongoing efforts to reduce this minalign, but the memory
>>> footprint would still increase, going against the purpose of SLOB, so
>>> again it would be easier if we could just remove it.
>>>
>>> So with this thread I'm interested in hearing arguments/use cases for
>>> keeping SLOB. There might be obviously users of SLOB whom this
>>> conversation will not reach, so I assume the eventual next step would be
>>> to deprecate it in a way that those users are notified when building a
>>> new kernel and can raise their voice then. Is there a good proven way
>>> how to do that for a config option like this one?
>>>
>>> Thanks,
>>> Vlastimil
>>>
>>> [1] https://lpc.events/event/16/contributions/1272/ - slides in the
>>> slabs.pdf linked there
>>> [2]
>>> https://lore.kernel.org/all/20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal/#t
>>> [3]
>>> https://lore.kernel.org/all/20210930044202.GP2361455@dread.disaster.area/
>>>
>>>
>>>

-- 
Damien Le Moal
Western Digital Research

