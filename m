Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6AE709716
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjESMJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjESMJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:09:53 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40921B5;
        Fri, 19 May 2023 05:09:51 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 52A6560009;
        Fri, 19 May 2023 12:09:46 +0000 (UTC)
Message-ID: <8cdbe96c-4d89-6f60-7afc-a7a708551f19@ghiti.fr>
Date:   Fri, 19 May 2023 14:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: Tree for May 15 (several RV64 build errors)
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor@kernel.org>
References: <20230515141235.0777c631@canb.auug.org.au>
 <54244db6-ff69-4cf8-894c-c3dd2f12df9c@infradead.org>
 <5d894e71-25ad-8ba0-f632-2eec6e017f46@ghiti.fr>
 <ee3bc2ce-5ebe-927e-5b6d-0b9490ef3875@ghiti.fr>
 <20230519-starlit-grip-ed152fb318cf@wendy>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230519-starlit-grip-ed152fb318cf@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/23 13:22, Conor Dooley wrote:
> On Fri, May 19, 2023 at 12:42:55PM +0200, Alexandre Ghiti wrote:
>
>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld:
>>>> section .data LMA [000000000041a000,00000000075bffd7] overlaps
>>>> section .text LMA [00000000000f09d4,00000000033562ab]
>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld:
>>>> section .init.pi.text LMA [00000000033562ac,0000000003359137]
>>>> overlaps section .data LMA [000000000041a000,00000000075bffd7]
>>>
>>> I'll check this one too which seems to be related to kernel/pi
>>> introduction.
>>
>> Thanks to Bjorn: this is caused by XIP_KERNEL, which is known to have
>> limited size, hence the overlap, so no fix for this one. Is there a way to
>> exclude this config from randconfig?
> What exactly is the problem? That the randconfig is too big for the max
> XIP kernel size?
> We already disable half the world for XIP, is turning off the pi stuff
> an option?


It's not related to the pi stuff, the problem has been present since 
5.13 (since the introduction of the XIP kernels :)).


>   It's already turned off for 32-bit, right?


Yes, it's only compiled with 64-bit kernels.


>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
