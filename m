Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C45F0214
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 03:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiI3BC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 21:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiI3BCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 21:02:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D01F9C83;
        Thu, 29 Sep 2022 18:02:24 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MdsKd5c8hzWh8H;
        Fri, 30 Sep 2022 08:58:13 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 09:02:21 +0800
Message-ID: <c301bfbe-afa8-ab1a-9062-56e4612fdf2c@huawei.com>
Date:   Fri, 30 Sep 2022 09:02:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] arm64/kprobe: Optimize the performance of patching
 single-step slot
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <guoren@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>, <maz@kernel.org>,
        <alexandru.elisei@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20220927022435.129965-1-liaochang1@huawei.com>
 <20220927022435.129965-4-liaochang1@huawei.com> <YzXM4qMZlNWh/JJy@arm.com>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <YzXM4qMZlNWh/JJy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/30 0:50, Catalin Marinas 写道:
> On Tue, Sep 27, 2022 at 10:24:35AM +0800, Liao Chang wrote:
>> Single-step slot would not be used until kprobe is enabled, that means
>> no race condition occurs on it under SMP, hence it is safe to pacth ss
>> slot without stopping machine.
>>
>> Since I and D caches are coherent within single-step slot from
>> aarch64_insn_patch_text_nosync(), hence no need to do it again via
>> flush_icache_range().
>>
>> Acked-by: Will Deacon <will@kernel.org>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  arch/arm64/kernel/probes/kprobes.c | 27 +++++++++++++++++++++------
>>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> What's your expectation with this series, should the arch maintainers
> just pick the individual patches?

Yes, or should i split this series into individual patch?

Thanks.

> 

-- 
BR,
Liao, Chang
