Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7DC71119B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbjEYREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbjEYREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73B8189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF4161489
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 17:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1ABC433EF;
        Thu, 25 May 2023 17:04:02 +0000 (UTC)
Date:   Thu, 25 May 2023 18:03:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] arm64: mm: pass original fault address to
 handle_mm_fault() in PER_VMA_LOCK block
Message-ID: <ZG+U/70SxgfaM6sl@arm.com>
References: <20230524131305.2808-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524131305.2808-1-jszhang@kernel.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 09:13:05PM +0800, Jisheng Zhang wrote:
> When reading the arm64's PER_VMA_LOCK support code, I found a bit
> difference between arm64 and other arch when calling handle_mm_fault()
> during VMA lock-based page fault handling: the fault address is masked
> before passing to handle_mm_fault(). This is also different from the
> usage in mmap_lock-based handling. I think we need to pass the
> original fault address to handle_mm_fault() as we did in
> commit 84c5e23edecd ("arm64: mm: Pass original fault address to
> handle_mm_fault()").
> 
> If we go through the code path further, we can find that the "masked"
> fault address can cause mismatched fault address between perf sw
> major/minor page fault sw event and perf page fault sw event:
> 
> do_page_fault
>   perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, ..., addr)   // orig addr
>   handle_mm_fault
>     mm_account_fault
>       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, ...) // masked addr
> 
> Fixes: cd7f176aea5f ("arm64/mm: try VMA lock-based page fault handling first")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
