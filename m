Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D9D6EFFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbjD0D12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjD0D10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:27:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4747335A6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:26:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64115e652eeso1948992b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 20:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682566016; x=1685158016;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6iiCwpqwg3Stg5ewDT+7eOBcuuJP6ymqF+Bhs4PVrg=;
        b=W9e3gcH6ng5a3Z/dNx32J7//XZqRbAuvPo4voLNAdwGSyz53C/xSb2Wpf31tvMMzs0
         xhj1Le/fa04Vzctf7yXesA70zbsUbiBF+kSJKFEXXjvw4+u4z/Ggv+tLN2Quq2sESoDZ
         yPQxNzMQ08ow7oZxkLG3jBsyjtR4iAWD2krb96Q8s5oGYMhRB+CnczlZA0uZDy0A2x20
         pEUPTSV3yB7Jc1C277J+9/3bQ1dBOCLCqni9LKuyGSoEnCFRy/PKkTxpIpsqqx/Qh3iB
         rlv21SGMlV9CiDfJF61mo7hcuoOIdGfv8Nwf+IeGFdnqEFgp5sArnsjDFF5s/YGoqA0z
         yV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682566016; x=1685158016;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j6iiCwpqwg3Stg5ewDT+7eOBcuuJP6ymqF+Bhs4PVrg=;
        b=fcbMTyxZSN617DJCcBSE2WrnLFtk/AE3W+JNINSJqHc7jHLjAEZIoW5MOmLwgLFPRn
         rnNw9AH3hxAkqhQ0EPNttlgAvIkg7MyqUwb1pA+eYnCakB5ll0yc1OINh8O1VFMudPh8
         n6y38j+eTXbPDeFzLLdeTfYps5EHozD0uyPg1rFCFcheb4M8+zyqN9ORwQbuieqccd5Z
         kQq0jI0zgIB+BEgg02VakICKTl+/DFNzp5USSceBb6o9/grIAcelDGARS0Inhgk4Uzwe
         xsazPtECTaj4CLC05UAnMTNY21KCHgKvXXiHbJGQ+NPvZVyZvANM2l3/Nne/BP86eyFN
         eMdg==
X-Gm-Message-State: AC+VfDzXnYOdw2fQVnuLXlKYyPS6BXOY6fdbjJ+g/73opLGcvN/mB+u4
        VBAfFKm1Oe0yI1srD1nfUcUjow==
X-Google-Smtp-Source: ACHHUZ6vSLuU1H9MGIvVSPAWipsymaOxXdPXoANqZNM2/gyZpFVsnQqt6Rlgd5Wc2mdPb4b1SRq9cA==
X-Received: by 2002:a17:902:c40c:b0:1a9:7bf4:17d8 with SMTP id k12-20020a170902c40c00b001a97bf417d8mr660672plk.18.1682566015799;
        Wed, 26 Apr 2023 20:26:55 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id ju3-20020a170903428300b001a64a335e42sm10635275plb.160.2023.04.26.20.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 20:26:55 -0700 (PDT)
Message-ID: <2eb026b8-9e13-2b60-9e14-06417b142ac9@bytedance.com>
Date:   Thu, 27 Apr 2023 11:26:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Content-Language: en-US
To:     Will Deacon <will@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@linaro.org>,
        Laura Abbott <lauraa@codeaurora.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Gang Li <ligang.bdlg@bytedance.com>
Subject: [QUESTION FOR ARM64 TLB] performance issue and implementation
 difference of TLB flush
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have encountered a performance issue on our ARM64 machine, which seems
to be caused by the flush_tlb_kernel_range.

Here is the stack on the ARM64 machine:

# ARM64:
```
     ghes_unmap
     clear_fixmap
     __set_fixmap
     flush_tlb_kernel_range
```

As we can see, the ARM64 implementation eventually calls
flush_tlb_kernel_range, which flushes the TLB on all cores. However, on
AMD64, the implementation calls flush_tlb_one_kernel instead.

# AMD64:
```
     ghes_unmap
     clear_fixmap
     __set_fixmap
     mmu.set_fixmap
     native_set_fixmap
     __native_set_fixmap
     set_pte_vaddr
     set_pte_vaddr_p4d
     __set_pte_vaddr
     flush_tlb_one_kernel
```

On our ARM64 machine, flush_tlb_kernel_range is causing a noticeable
performance degradation.

This arm64 patch said:
https://lore.kernel.org/all/20161201135112.15396-1-fu.wei@linaro.org/
(commit 9f9a35a7b654e006250530425eb1fb527f0d32e9)

```
/*
  * Despite its name, this function must still broadcast the TLB
  * invalidation in order to ensure other CPUs don't end up with junk
  * entries as a result of speculation. Unusually, its also called in
  * IRQ context (ghes_iounmap_irq) so if we ever need to use IPIs for
  * TLB broadcasting, then we're in trouble here.
  */
static inline void arch_apei_flush_tlb_one(unsigned long addr)
{
     flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
}
```

1. I am curious to know the reason behind the design choice of flushing
the TLB on all cores for ARM64's clear_fixmap, while AMD64 only flushes
the TLB on a single core. Are there any TLB design details that make a
difference here?

2. Is it possible to let the ARM64 to flush the TLB on just one core,
similar to the AMD64?

3. If so, would there be any potential drawbacks or limitations to
making such a change?

Thanks,

Gang Li
