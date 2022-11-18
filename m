Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0447C62FE0B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiKRTfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiKRTfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:35:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359791A22A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 11:35:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C633F62716
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE61C433C1;
        Fri, 18 Nov 2022 19:35:05 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <dhildenb@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Rafael Aquini <raquini@redhat.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/2] arm64: fix two bug about page table check
Date:   Fri, 18 Nov 2022 19:35:02 +0000
Message-Id: <166879995436.2970319.8402648264263746100.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117075602.2904324-1-liushixin2@huawei.com>
References: <20221117075602.2904324-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 15:56:00 +0800, Liu Shixin wrote:
> Denys Vlasenko has reported two bug about page table check on arm64.
> On arm64, pmd_present() contains non-leaf pmd and invalid pmd too.
> 
> When collapse hugepage, the pmd is non-leaf and should skip the check.
> Use pmd_leaf() instead of pmd_present().
> 
> When split hugepage, the pmd will be marked as invalid and then populate.
> So we should decrease file_map_count when invalid pmd and then increase
> when populate the pmd. Add pmd_valid() check.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64/mm: fix incorrect file_map_count for non-leaf pmd/pud
      https://git.kernel.org/arm64/c/5b47348fc0b1

I only merged the first patch in this series as Will had some questions
on the second patch (it does seem weird that the pud and pmd functions
are different w.r.t. the p*d_user() checks).

-- 
Catalin

