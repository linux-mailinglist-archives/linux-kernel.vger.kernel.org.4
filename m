Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D162360267A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJRIJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJRIJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:09:33 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4675A11813
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1666080568; bh=qdvFsQ/lCWl0sUbt75T+DP3VwTt8nZuoicBEZ3m6IBc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Oe6D8dWNwzZes1JZTzieYLLrmx6jyC1gICh0elTn+Kupq1hl47is6BnlOHPbgm5cF
         HOUI+baX1le6HsjVaydsvI/o3xo6piPMlIU5qA5QIQzI4phNQzu+ThqsWUUPuJmVeg
         t02b5hRgBP59KvDv6COVMYVGOwQmm1lW97hvdQk8=
Received: from [100.100.57.122] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id D4856600A9;
        Tue, 18 Oct 2022 16:09:27 +0800 (CST)
Message-ID: <e58d7c6d-cf8a-017b-7e72-6ae579ce6be2@xen0n.name>
Date:   Tue, 18 Oct 2022 16:09:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:107.0)
 Gecko/20100101 Thunderbird/107.0a1
Subject: Re: [PATCH V2] LoongArch: Add unaligned access support
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Huacai Chen' <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221017022330.2383060-1-chenhuacai@loongson.cn>
 <b8792b1a71754d6eb88debe4d6c2c419@AcuMS.aculab.com>
 <CAAhV-H5WM97+Um9ULjv7gT3i5pJ3GfQ8ex6NRNr6uzmMgdVY_Q@mail.gmail.com>
 <c34a277a-1735-65e6-c97d-fcc2ac3d57e6@xen0n.name>
 <CAAhV-H5y5wz0VzFEHrkDpap4wczWXBn_ibL3LW_JQyYkMzjDXQ@mail.gmail.com>
 <cbbc32d4bb0f445197eb5d84d796595c@AcuMS.aculab.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <cbbc32d4bb0f445197eb5d84d796595c@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/18 15:48, David Laight wrote:
> From: Huacai Chen
>> Sent: 18 October 2022 08:33
> ...
>>> What about my more structured approach in another reply that avoids the
>>> huge else-if conditions? Both the terrible line wraps and codegen could
>>> be avoided.
> ...
>> OK, let me try.
> 
> I suspect you can mask out some 'operand size' bits from the
> instructions - instead of checking each opcode.

Technically LoongArch instruction formats don't contain any "operand 
size bit", because most current opcodes seem to be simply sequentially 
allocated. While there seem to exist a certain pattern in e.g. encodings 
of {LD,ST,FLD,FST}.{B,H,W,D}, I believe it's just coincidence (e.g. bits 
23:22 of those instructions seem to represent "B/H/W/D"; but other 
instructions clearly don't follow such a pattern, not even the 
{LD,ST}.{BU,HU,WU} ones).

For now I'd personally prefer readability and maintainability over 
performance, because traps are already expensive enough that 
optimizations like this don't really matter.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

