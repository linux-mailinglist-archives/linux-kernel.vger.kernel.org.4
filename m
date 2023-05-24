Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6CF70EA31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbjEXAWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbjEXAWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:22:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCB3B5;
        Tue, 23 May 2023 17:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2t51EpPSkSfdV7Or5z92c4Otgu+QY2DAdl7GPBfnDHM=; b=UEQPNOXxLqLc/MxXbymjcWHTql
        R8upb9r74csrDh8xLSIbC7nqBZAwlKxSUVJok4dr7kSSUpGkDGaByL+oN9g91cTuccmxc8GNM/xdi
        zS5odL7nRZ4/KOuc/HonLwKxiM9t7Fz9D9d8ocU8wqg51pbloZ6fjyzBgI5lJbGxBDMPzw4NuvnUz
        qHIwp/WgL2r32sCih7Z/rrK7iO+uCPvWw6vKCHrGHj8zEs6rl8ncA2TENvtF7yNw1jaIdqEvq4DmF
        HjJ3NXrmX4YeDpYk/+aW78oIXQD2fJW9j9BzvJ3wl+E97xc8xyq94rmxCbIq+IESOI6Ni2I6eOoDj
        4uxEhadg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1cGl-00Btme-1j;
        Wed, 24 May 2023 00:22:23 +0000
Message-ID: <e2279988-03b4-9670-6f1c-c360c478b38e@infradead.org>
Date:   Tue, 23 May 2023 17:22:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: linux-next: Tree for May 15 (several RV64 build errors)
Content-Language: en-US
To:     Alexandre Ghiti <alex@ghiti.fr>,
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
 <c59f9f1f-278c-ac5e-88cd-85b8485f59e3@ghiti.fr>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c59f9f1f-278c-ac5e-88cd-85b8485f59e3@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 06:07, Alexandre Ghiti wrote:
> 
> On 23/05/2023 04:28, Randy Dunlap wrote:
>> Hi,
>>
>> On 5/19/23 03:42, Alexandre Ghiti wrote:
>>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .data LMA [000000000041a000,00000000075bffd7] overlaps section .text LMA [00000000000f09d4,00000000033562ab]
>>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .init.pi.text LMA [00000000033562ac,0000000003359137] overlaps section .data LMA [000000000041a000,00000000075bffd7]
>>>>
>>>> I'll check this one too which seems to be related to kernel/pi introduction.
>>>
>>> Thanks to Bjorn: this is caused by XIP_KERNEL, which is known to have limited size, hence the overlap, so no fix for this one. Is there a way to exclude this config from randconfig?
>> Does this mean exclude XIP_KERNEL or something else from randconfigs?
> 
> 
> I meant excluding XIP_KERNEL from randconfigs: it has very strict constraints regarding what can/can't be enabled then it needs human intervention to make sure the error above does not happen. So I would not bother testing this in randconfigs if possible.

I can exclude it from my randconfig builds, but I don't know of a way to exclude it from randconfig builds in general (i.e., for everyone).

-- 
~Randy
