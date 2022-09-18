Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276385BBC07
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 07:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIRFfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 01:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRFfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 01:35:16 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EF4F1F601
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 22:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9jmLn
        AQGQj431zPZBKBz9FpincMQ/bzVP8lGuYEZmNI=; b=i+WF53MgRJC4iYrIirrS+
        8W9O6M4TxEPnx6nFDx6MliHc1blymL8PLzhAHs33kEEHCKRDizjMsyJVHPXIkPMo
        u5hGNMJpf+zk5JiK5tRFvwX81xSNh4u9n7AsZCCmsmFj1QyhYW39YO1dJWa8rvZU
        kAQbp/YykFKArfB0XCWXsk=
Received: from whoami-VirtualBox.. (unknown [223.72.42.150])
        by smtp9 (Coremail) with SMTP id DcCowAA3TcLIrSZjjTfifA--.59008S2;
        Sun, 18 Sep 2022 13:34:00 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     geomatsi@gmail.com
Cc:     akpm@linux-foundation.org, alexandre.ghiti@canonical.com,
        anshuman.khandual@arm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, atishp@rivosinc.com, falcon@tinylab.org,
        guoren@kernel.org, heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        panqinglin2020@iscas.ac.cn, paul.walmsley@sifive.com,
        sunnanyong@huawei.com, tjytimi@163.com, tongtiangen@huawei.com
Subject: Re:Re: [PATCH v2] riscv: make update_mmu_cache to support asid
Date:   Sun, 18 Sep 2022 13:33:32 +0800
Message-Id: <20220918053332.22189-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Yx7fCL3rMgT4Uh96@curiosity>
References: <Yx7fCL3rMgT4Uh96@curiosity>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAA3TcLIrSZjjTfifA--.59008S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1UtF45AF4rZF4rAw1rCrg_yoW8XrWfpF
        Z2krs5KrykGw13CFy7Xw4vgr4rJw4vgr1avw1fCr9rJ39xZrnFk393tr18ZryDGF9akF4x
        urWj93Z8ua4kA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUnXowUUUUU=
X-Originating-IP: [223.72.42.150]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbiVgiAeFqzt7laWwAAsA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At 2022-09-12 15:26:00, "Sergey Matyukevich" <geomatsi@gmail.com> wrote:
>Hi Jinyu,
>
>> The `update_mmu_cache` function in riscv flush tlb cache without asid
>> information now, which will flush tlbs in other tasks' address space
>> even if processor supports asid. So add a new function
>> `flush_tlb_local_one_page` to flush local one page whether processor
>> supports asid or not,for cases that need to flush local one page like
>> function `update_mmu_cache`.
>> 
>> Signed-off-by: Jinyu Tang <tjytimi@163.com>
>> ---
>> RFC V1 -> V2 : 
>> 1.Rebased on PATCH9 of IPI imporvement series as Anup Patel
>> suggestion. 
>> 2.Make commit log more clear.
>> 
>>  arch/riscv/include/asm/pgtable.h  |  2 +-
>>  arch/riscv/include/asm/tlbflush.h |  2 ++
>>  arch/riscv/mm/tlbflush.c          | 11 +++++++++++
>>  3 files changed, 14 insertions(+), 1 deletion(-)
>
>Just FYI: I have been looking into the same function w.r.t. to its
>ASID/SMP handling. In addition to what your patch is doing with ASID,
>I posted experimental change following flush_icache_mm approach. That
>patch takes into account other concurrently running harts as well as
>possible migration to other harts later on, see:
>
>https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gmail.com/
>
>Regards,
>Sergey
Maybe local flush is enough for this function,because others may not use the pte forever.
And if another hart use this pte later, it may trap in pagefault to survive.

Yours,

Jinyu

