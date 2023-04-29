Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B90F6F2588
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjD2R64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 13:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD2R6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 13:58:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B85710D1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=5JjXxgLkLL0pHvUvZrSvplr1aCV276TDtcLpzXHPldY=; b=pBar9IHJDcTgidAdIqsDIBgfJp
        ZEu5bBY3D14TNlnrVPQDnIFlaB+nyeYwxYQh/ygVdQZMRSuUTPtQD2ZiDGONip8+XS20VAqslo/+r
        ymttnXs+dOPDq/l0QjLCelkkQ7W8H4f3LVRDqptcg2rIxgvvljEIMw8rNcfXoH6NKvbnry7MW3xl/
        syiFWEFelDV1sCtsK/fYUyz8eMlbrzhtCwypPtdE6T7WPVa9oQmNjAcHv2NVvYUsXEfLeSRzLOWWK
        4Io1WtF3UDFkpfIyMjbeBhtcj6Y+kA+lwPN+qavzfc5AjHGHtikXMfz/eAfvujTmHNF2wk/OnpCzR
        E99Cy8xA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psoqP-00CyJM-1F;
        Sat, 29 Apr 2023 17:58:49 +0000
Message-ID: <37e6b325-44e4-8e65-68e3-eab2943018ac@infradead.org>
Date:   Sat, 29 Apr 2023 10:58:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] RISC-V: fix sifive and thead section mismatches in
 errata
Content-Language: en-US
To:     Evan Green <evan@rivosinc.com>, Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
References: <20230429155247.12131-1-rdunlap@infradead.org>
 <CALs-HsuG3EFBs60sgiMcPHoE1dF7mhi3GKt=AWvRPaUHAfA88Q@mail.gmail.com>
 <20230429-outboard-hypocrite-983e977103d2@spud>
 <CALs-HstrR3Cm3jQKt6dmfYiRRVkAVibAZDtFo0wmXz4LEvRf_A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CALs-HstrR3Cm3jQKt6dmfYiRRVkAVibAZDtFo0wmXz4LEvRf_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/23 10:48, Evan Green wrote:
> On Sat, Apr 29, 2023 at 10:24 AM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Sat, Apr 29, 2023 at 10:21:39AM -0700, Evan Green wrote:
>>> On Sat, Apr 29, 2023 at 8:52 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>
>>>> When CONFIG_MODULES is set, __init_or_module becomes <empty>, but when
>>>> CONFIG_MODULES is not set, __init_or_module becomes __init.
>>>> In the latter case, it causes section mismatch warnings:
>>>>
>>>> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cpu_mfr_info (section: .text) -> sifive_errata_patch_func (section: .init.text)
>>>> WARNING: modpost: vmlinux.o: section mismatch in reference: riscv_fill_cpu_mfr_info (section: .text) -> thead_errata_patch_func (section: .init.text)
>>>>
>>>> Fixes: bb3f89487fd9 ("RISC-V: hwprobe: Remove __init on probe_vendor_features()")
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>>>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>>>> Cc: linux-riscv@lists.infradead.org
>>>> Cc: Conor Dooley <conor@kernel.org>
>>>> Cc: Evan Green <evan@rivosinc.com>
>>>> ---
>>>
>>> Thanks, Randy. I'm confused at how I didn't see that when I made the
>>> original fix. I feel like repro of these section mismatch errors
>>> depend on some other factor I'm not understanding. In any case:
>>
>> Perhaps you had a cut-down config that did not enable either of the
>> relevant ARCH_ options to get those errata compiled?
> 
> It was weird, my original "fix" (the one listed in this Fixes tag) was
> needed because while the hwprobe series was clean on Palmer's branch,
> it generated a "section mismatch" on linux-next. As noted here, it was
> only with !CONFIG_MODULES, so I explicitly remember generating that
> config and checking it on linux-next to generate this "fix", and it
> came out clean. It's like the robots are getting smarter.
> -Evan

I observed the problem in 8 out of 20 randconfig builds,
using linux-next 20230427.

-- 
~Randy
