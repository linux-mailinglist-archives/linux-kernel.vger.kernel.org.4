Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A0068DFD9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjBGSWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBGSV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:21:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3140F22A1E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:21:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA2F2B81A1F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 18:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4039DC433EF;
        Tue,  7 Feb 2023 18:21:23 +0000 (UTC)
Date:   Tue, 7 Feb 2023 18:21:20 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kaihao Bai <carlo.bai@linux.alibaba.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        baolin.wang@linux.alibaba.com
Subject: Re: [RFC PATCH 1/1] arm64: mm: remove unnecessary multiple tlb flush
 of contiguous hugetlb
Message-ID: <Y+KWoDw1ppliQ5Sg@arm.com>
References: <1675768181-41518-1-git-send-email-carlo.bai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675768181-41518-1-git-send-email-carlo.bai@linux.alibaba.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 07:09:41PM +0800, Kaihao Bai wrote:
> In arm64, contiguous flag refers to the same TLB entry that shared by a
> contiguous address range. If flush one entry of the address range, it
> would cover the whole contiguous address range. Thus there's no need to
> flush all contiguous range that CONT_PMD/PTE points to.

This doesn't work. The contiguous bit is a hint, so the CPU may not
coalesce multiple PTEs into a single TLB entry.

-- 
Catalin
