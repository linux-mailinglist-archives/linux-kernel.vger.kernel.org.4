Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524EE5FBF51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJLCrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJLCro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:47:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71D86CF7B;
        Tue, 11 Oct 2022 19:47:42 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MnH6k0zkLzpVbc;
        Wed, 12 Oct 2022 10:44:30 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 10:47:40 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 12 Oct 2022 10:47:40 +0800
Subject: Re: [PATCH v2 0/2] riscv: Support HAVE_ARCH_HUGE_VMAP and
 HAVE_ARCH_HUGE_VMALLOC
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20221008140506.1066805-1-liushixin2@huawei.com>
 <87tu4ah6un.fsf@smulpajen.i-did-not-set--mail-host-address--so-tickle-me>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <420713ca-9a77-b519-1811-9ec9815010c4@huawei.com>
Date:   Wed, 12 Oct 2022 10:47:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <87tu4ah6un.fsf@smulpajen.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/11 20:39, Björn Töpel wrote:
> Liu Shixin <liushixin2@huawei.com> writes:
>
>> Since riscv64 has already support SATP_MODE_57 by default, it is time to
>> support more hugepage-related features. These two patches will enable
>> HAVE_ARCH_HUGE_VMAP and HAVE_ARCH_HUGE_VMALLOC.
>>
> Just a note; The HP support does not require sv57. Pmd/Mega- and
> pud/gigapages work for sv39 and sv48 as well.
Yes, I didn't explain it clearly. I will rewrite it.
>> v1->v2: Fix the build error reported by kernel-test.
>>
>> Liu Shixin (2):
>>   riscv: Enable HAVE_ARCH_HUGE_VMAP for 64BIT
>>   riscv: Enable HAVE_ARCH_HUGE_VMALLOC for 64BIT
>>
>>  .../features/vm/huge-vmap/arch-support.txt    |  2 +-
>>  arch/riscv/Kconfig                            |  2 +
>>  arch/riscv/include/asm/vmalloc.h              | 18 ++++
>>  arch/riscv/mm/Makefile                        |  1 +
>>  arch/riscv/mm/pgtable.c                       | 83 +++++++++++++++++++
>>  5 files changed, 105 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/riscv/mm/pgtable.c
>>
> I've taken this series for a spin, and tested huge pud pages via
> ioremap(), and huge pmd pages via vmalloc_huge() on qemu for sv39, sv48,
> and sv57.
>
> Patch 2 have a spelling error in the commit message: "enbale" vs
> "enable".
>
> Fix up the spelling error in patch 2, and after that feel free to add
> for the whole series:
>
> Reviewed-by: Björn Töpel <bjorn@kernel.org>
> Tested-by: Björn Töpel <bjorn@kernel.org>
>
Thanks for your review and test. I will fix the above errors immediately.
> Nice work!
> Björn
>
> .
>

