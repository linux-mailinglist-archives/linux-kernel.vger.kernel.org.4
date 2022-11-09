Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2D622BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiKIMoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKIMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:44:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C9121E2E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:43:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2D67B81E2D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C010C43470;
        Wed,  9 Nov 2022 12:43:55 +0000 (UTC)
Date:   Wed, 9 Nov 2022 12:43:51 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     will@kernel.org, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH 4/5] arm64: mm: Support ASID isolation feature
Message-ID: <Y2ughyNLh9EFw3HT@arm.com>
References: <20221017083203.3690346-1-yeyunfeng@huawei.com>
 <20221017083203.3690346-5-yeyunfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017083203.3690346-5-yeyunfeng@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:32:02PM +0800, Yunfeng Ye wrote:
> After a rollover, the global generation will be flushed, which will
> cause the process mm->context.id on all CPUs do not match the
> generation. Thus, the process will compete for the global spinlock lock
> to reallocate a new ASID and refresh the TLBs of all CPUs on context
> switch. This will lead to the increase of scheduling delay and TLB miss.
> 
> In some delay-sensitive scenarios, for example, part of CPUs are
> isolated, only a limited number of processes are deployed to run on the
> isolated CPUs. In this case, we do not want these key processes to be
> affected by the rollover of ASID.

Part of this commit log should also go in the cover letter and it would
help to back this up by some numbers, e.g. what percentage improvement
you get with this patchset by running hackbench on an isolated CPU.

In theory it looks like CPU isolation would benefit from this patchset
but we try not to touch this code often, so any modification should come
with proper justification, backed by numbers.

Note that I haven't reviewed the algorithm you are proposing in detail,
only had a brief look.

-- 
Catalin
