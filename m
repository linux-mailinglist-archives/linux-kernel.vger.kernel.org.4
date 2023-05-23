Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD5E70DD2D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbjEWNHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEWNHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:07:48 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A760DB;
        Tue, 23 May 2023 06:07:46 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id EB96F6000A;
        Tue, 23 May 2023 13:07:40 +0000 (UTC)
Message-ID: <c59f9f1f-278c-ac5e-88cd-85b8485f59e3@ghiti.fr>
Date:   Tue, 23 May 2023 15:07:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: Tree for May 15 (several RV64 build errors)
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor@kernel.org>
References: <20230515141235.0777c631@canb.auug.org.au>
 <54244db6-ff69-4cf8-894c-c3dd2f12df9c@infradead.org>
 <5d894e71-25ad-8ba0-f632-2eec6e017f46@ghiti.fr>
 <ee3bc2ce-5ebe-927e-5b6d-0b9490ef3875@ghiti.fr>
 <9f32e509-95b1-6a5a-aba2-664af4af37a8@infradead.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <9f32e509-95b1-6a5a-aba2-664af4af37a8@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/05/2023 04:28, Randy Dunlap wrote:
> Hi,
>
> On 5/19/23 03:42, Alexandre Ghiti wrote:
>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .data LMA [000000000041a000,00000000075bffd7] overlaps section .text LMA [00000000000f09d4,00000000033562ab]
>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .init.pi.text LMA [00000000033562ac,0000000003359137] overlaps section .data LMA [000000000041a000,00000000075bffd7]
>>>
>>> I'll check this one too which seems to be related to kernel/pi introduction.
>>
>> Thanks to Bjorn: this is caused by XIP_KERNEL, which is known to have limited size, hence the overlap, so no fix for this one. Is there a way to exclude this config from randconfig?
> Does this mean exclude XIP_KERNEL or something else from randconfigs?


I meant excluding XIP_KERNEL from randconfigs: it has very strict 
constraints regarding what can/can't be enabled then it needs human 
intervention to make sure the error above does not happen. So I would 
not bother testing this in randconfigs if possible.


>
> thanks.
