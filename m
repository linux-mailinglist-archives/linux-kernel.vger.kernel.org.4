Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DDF65F363
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjAESFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbjAESEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:04:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0918759D10
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:04:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91A4BB81BA9
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B9AC433F1;
        Thu,  5 Jan 2023 18:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672941855;
        bh=RL6oAOiPenaDDp6rZZtH4O8n8lQHc98WXu6NZJShQ5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PIobjOQRMSDmnwjpOtTQx0KpGaJYIyC4RJlf2IGy6NEmxITQz5Po+kd1KaRugQV86
         3ZMKUvU0Z3EKbII25SNRXRA5oMR3nXk1QME/8pioonHsMYhBdKxOILYvFob3QMMh8i
         tz/7UPPlC3Ht5PFastTNJQP/eBz72zbxLGkmaPwKoWt3jIJANVEvvFkTnvb1eDuQnf
         XTf0+tX4yMPRl1bOR5/jSUFQuvvTSG7dOl6t1ZqzZVEB/3LN4B7LhbA0NW3Bij/ZWA
         QBpSKH2HMSkvjFYH/Xz35FxkrhMX16krtyJvly1GXCb0UwF9Chq7BL2bQDSMsxxzIj
         fvdZ7/KfO3sgQ==
From:   Will Deacon <will@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>,
        Rafael Aquini <raquini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <dhildenb@redhat.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64/mm: fix incorrect file_map_count for invalid pmd
Date:   Thu,  5 Jan 2023 18:03:59 +0000
Message-Id: <167293109023.1463092.17340880121149597305.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221121073608.4183459-1-liushixin2@huawei.com>
References: <20221121073608.4183459-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 15:36:08 +0800, Liu Shixin wrote:
> The page table check trigger BUG_ON() unexpectedly when split hugepage:
> 
>  ------------[ cut here ]------------
>  kernel BUG at mm/page_table_check.c:119!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  Dumping ftrace buffer:
>     (ftrace buffer empty)
>  Modules linked in:
>  CPU: 7 PID: 210 Comm: transhuge-stres Not tainted 6.1.0-rc3+ #748
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : page_table_check_set.isra.0+0x398/0x468
>  lr : page_table_check_set.isra.0+0x1c0/0x468
> [...]
>  Call trace:
>   page_table_check_set.isra.0+0x398/0x468
>   __page_table_check_pte_set+0x160/0x1c0
>   __split_huge_pmd_locked+0x900/0x1648
>   __split_huge_pmd+0x28c/0x3b8
>   unmap_page_range+0x428/0x858
>   unmap_single_vma+0xf4/0x1c8
>   zap_page_range+0x2b0/0x410
>   madvise_vma_behavior+0xc44/0xe78
>   do_madvise+0x280/0x698
>   __arm64_sys_madvise+0x90/0xe8
>   invoke_syscall.constprop.0+0xdc/0x1d8
>   do_el0_svc+0xf4/0x3f8
>   el0_svc+0x58/0x120
>   el0t_64_sync_handler+0xb8/0xc0
>   el0t_64_sync+0x19c/0x1a0
> [...]
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/mm: fix incorrect file_map_count for invalid pmd
      https://git.kernel.org/arm64/c/74c2f8105451

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
