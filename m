Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423F76B8FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjCNKW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCNKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:22:09 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E03B9BA45
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1678788717; bh=s9AuweVQFMLEp8XZ8yJzWtozlov3OCN5cadbwDqHu/Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EBmxopkhKWc0hYH3jjtUOi+3Nc4taiqiM1cvxNdQmVlFSKDkeUqtqc2yj46OtjwsN
         w5CyRySUQd/3zpO3yBKZlFZMuI/GREu94aGO4dhx8LZBO2/1r//EWD0aS16Z7SYuzL
         LZDR988DckELBD9Asxgrg+513PcIr7rVkXqKqWX8=
Received: from [100.100.33.167] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id B8027600DA;
        Tue, 14 Mar 2023 18:11:56 +0800 (CST)
Message-ID: <939c8d17-6166-0c9b-6c58-6d49fd89841f@xen0n.name>
Date:   Tue, 14 Mar 2023 18:11:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] LoongArch: Make WriteCombine configurable for ioremap()
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230314085433.4078119-1-chenhuacai@loongson.cn>
 <21f5aba50b7732b48d2610a5015186adf6bdfb38.camel@xry111.site>
 <CAAhV-H4TpQuq9sE2H=zbO8cvwn3Aer_pu1a-DU9L9OSR1bQX=g@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H4TpQuq9sE2H=zbO8cvwn3Aer_pu1a-DU9L9OSR1bQX=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/14 18:02, Huacai Chen wrote:
> Hi, Ruoyao,
> 
> On Tue, Mar 14, 2023 at 5:41 PM Xi Ruoyao <xry111@xry111.site> wrote:
>>
>> On Tue, 2023-03-14 at 16:54 +0800, Huacai Chen wrote:
>>> LoongArch maintains cache coherency in hardware, but when works with
>>> LS7A chipsets the WUC attribute (Weak-ordered UnCached, which is similar
>>> to WriteCombine) is out of the scope of cache coherency machanism for
>>> PCIe devices (this is a PCIe protocol violation, may be fixed in newer
>>> chipsets).
>>
>> IIUC all launched LS7A models (7A1000 and 7A2000) suffers this issue?
> Yes, very unfortunately, but this issue is only observed in the amdgpu
> driver now.

It's PCIe protocol violation after all, and we can never be sure about 
the vast amount of hardware untested on loongarch after all. Miserable 
as the performance hit may get, we don't really have another choice, 
unfortunately. Someone needs to lecture the LS7A team real hard!

>>
>>> This means WUC can only used for write-only memory regions now, so this
>>> option is disabled by default (means WUC falls back to SUC for ioremap).
>>> You can enable this option if the kernel is ensured to run on bug-free
>>> hardwares.
>>
>> Hmm, is it possible to make a PCI quirk so SUC/WUC will be decided
>> automatically from the vendor:device ID of the PCI root controller?
>> Then we don't need to rely on the user or distro maintainer to select an
>> option.  I see there is already many architecture-dependant #if
>> directives in drivers/pci/quirks.c so I guess such a quirk is acceptable
>> in PCI tree...
> Not a good idea, pci quirks need too long a time to review, and we
> don't know when this issue can be fixed in hardware.
> 
>>
>> If a PCI quirk is not possible, then is it possible to make a kernel
>> command line option, leaving this CONFIG as the default value of the
>> option?  I guess in the future many LoongArch users will just install a
>> binary distro, then it would be much easier to edit grub.cfg than
>> rebuilding the kernel when they finally buy a compliant PCIe controller.
> If we use command line parameter, we can remove this Kconfig option.

An option is still useful as specifying the compile-time default for 
such a kernel parameter, IMO.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

