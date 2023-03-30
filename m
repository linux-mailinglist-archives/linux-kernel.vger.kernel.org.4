Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C758E6D0BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjC3Quc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjC3QuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:50:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D8EE05D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3pZEcPlTyiawu/gIbP6AxJHelAk/ImhwRolvPWk6aX0=; b=LP0tZ3E0kla/9xtBkx6eXAZQie
        g+T9NtEIF9djDsXIlLGKh9JHr9KOihxBGoT5vIMLOqmBuH8QOqfGOVXM/khXZM0iG+pU9k2ra1Lk+
        zLws0/cT4i93hZ7om1eDLu4zZdGve71qY6zO1kG2mxjYACJ7PpKrms5TiDY1YVlvmkRxGn8ne8iXA
        zNMM7aZISYMUZp5CI9dc5tn59tLzTJAHxTpXPNhP0/BBXpgEcmf25nGHl7iCUj22Z87J59dkPwDUE
        0AuQlFX7HZ/0BrhBytQXVPNGtqRPTUoRZsdhMk1DfqqGWoeTlf2pvmfDA+sfjhspdKq2DJIIlOkMO
        +Kst5xXQ==;
Received: from [71.59.149.187] (helo=[10.0.0.152])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phvSb-004Wz9-1I;
        Thu, 30 Mar 2023 16:49:13 +0000
Message-ID: <833203b0-aee5-eb23-afb4-ff71a3024258@infradead.org>
Date:   Thu, 30 Mar 2023 09:49:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] iommu: PGTABLE_LPAE is also for RISCV
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org
References: <20230330060105.29460-1-rdunlap@infradead.org>
 <2529dd93-2cb2-6ed8-20c0-c424e6613717@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2529dd93-2cb2-6ed8-20c0-c424e6613717@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/23 09:34, Robin Murphy wrote:
> On 2023-03-30 07:01, Randy Dunlap wrote:
>> On riscv64, linux-next-20233030 (and for several days earlier),
>> there is a kconfig warning:
>>
>> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>>    Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>>    Selected by [y]:
>>    - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>>
>> and build errors:
>>
>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L140':
>> io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_io_pgtable_ops'
>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L168':
>> io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_io_pgtable_ops'
>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
>> ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable_ops'
>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
>> ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtable_ops'
>>
>> Add RISCV as an allowed ARCH dependency to fix these problems.
>>
>> Fixes: d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
> 
> BTW that doesn't look like the right fix target - this presumably dates back as far as when ARCH_RENESAS was added to RISCV, such that it was possible to start selecting IPMMU_VMSA without COMPILE_TEST?

OK, I can go with that. Thanks for your help.

-- 
~Randy
