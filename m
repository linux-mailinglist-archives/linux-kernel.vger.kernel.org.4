Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089316B287C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCIPPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCIPOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:14:44 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5403144BC;
        Thu,  9 Mar 2023 07:13:05 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 5A86A240014;
        Thu,  9 Mar 2023 15:12:57 +0000 (UTC)
Message-ID: <de204b7c-7c1d-bd7b-0072-d128757258e2@ghiti.fr>
Date:   Thu, 9 Mar 2023 16:12:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: RISC-V reserved memory problems
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Conor Dooley <conor@kernel.org>,
        palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, robh+dt@kernel.org, mick@ics.forth.gr,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        Valentina.FernandezAlanis@microchip.com,
        Daire.McNamara@microchip.com
References: <8e10bf15-9fa9-fe90-1656-35bf3e87e7f8@microchip.com>
 <f8e67f82-103d-156c-deb0-d6d6e2756f5e@microchip.com> <Y9wytv5KSt1ca+td@spud>
 <ZAchb/DfbIh+qaE4@kernel.org> <8abfb680-e1dd-8d1f-dd10-0a8bf086f5c3@ghiti.fr>
 <b797bd15-ef3d-4d28-9aad-ffe0a32aa0b0@spud>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <b797bd15-ef3d-4d28-9aad-ffe0a32aa0b0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/23 13:51, Conor Dooley wrote:
> On Thu, Mar 09, 2023 at 01:45:05PM +0100, Alexandre Ghiti wrote:
>> On 3/7/23 12:35, Mike Rapoport wrote:
>>> Hi Conor,
>>>
>>> Sorry for the delay, somehow this slipped between the cracks.
>>>
>>> On Thu, Feb 02, 2023 at 10:01:26PM +0000, Conor Dooley wrote:
>>>> Hullo Palmer, Mike & whoever else may read this,
>>>>
>>>> Just reviving this thread from a little while ago as I have been in the
>>>> area again recently...
>>> TBH, I didn't really dig deep into the issues, but the thought I had was
>>> what if DT was mapped via fixmap until the setup_vm_final() and then it
>>> would be possible to call DT methods early.
>>>
>>> Could be I'm shooting in the dark :)
>>
>> I think I understand the issue now, it's because In riscv, we establish 2
>> different virtual mappings and we map the device tree at 2 different virtual
>> addresses, which is the problem.
>>
>> So to me, the solution is:
>>
>> - to revert your previous fix, that is calling
>> early_init_fdt_scan_reserved_mem() before any call to memblock_alloc()
>> (which could result in an allocation in the area you want to reserve)
>>
>> - to map the device tree at the same virtual address, because
>> early_init_fdt_scan_reserved_mem() initializes reserved_mem with the dtb
>> mapping established in setup_vm() and uses reserved_mem with the new mapping
>> from setup_vm_final (which is what Mike proposes, we should use the fixmap
>> region to have the same virtual addresses)
>>
>> Hope that makes sense: I'll come up with something this afternoon for you to
>> test!
> Sounds good. Please give me some ELI5 commit messages if you can,
> explanations for this stuff (which I found took a lot of archaeology to
> understand) would be very welcome next time we need to go back looking
> at this stuff.


Can you give it a try here: 
https://github.com/AlexGhiti/riscv-linux/commits/dev/alex/conor_dtb_fixmap_v1 
?

That works for me but I need to carefully explain and check that's 
correct though, not upstreamable as is.

Thanks,

Alex


> Thanks Alex!
> Conor.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
