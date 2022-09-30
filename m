Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE615F064C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiI3IP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiI3IP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:15:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B1810CA40;
        Fri, 30 Sep 2022 01:15:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65BDB62266;
        Fri, 30 Sep 2022 08:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24966C433D7;
        Fri, 30 Sep 2022 08:15:51 +0000 (UTC)
Date:   Fri, 30 Sep 2022 09:15:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "liaochang (A)" <liaochang1@huawei.com>
Cc:     will@kernel.org, guoren@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, mhiramat@kernel.org,
        rostedt@goodmis.org, maz@kernel.org, alexandru.elisei@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64/kprobe: Optimize the performance of patching
 single-step slot
Message-ID: <YzaltNF5PqYq4x4O@arm.com>
References: <20220927022435.129965-1-liaochang1@huawei.com>
 <20220927022435.129965-4-liaochang1@huawei.com>
 <YzXM4qMZlNWh/JJy@arm.com>
 <c301bfbe-afa8-ab1a-9062-56e4612fdf2c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c301bfbe-afa8-ab1a-9062-56e4612fdf2c@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:02:20AM +0800, liaochang (A) wrote:
> 
> 
> 在 2022/9/30 0:50, Catalin Marinas 写道:
> > On Tue, Sep 27, 2022 at 10:24:35AM +0800, Liao Chang wrote:
> >> Single-step slot would not be used until kprobe is enabled, that means
> >> no race condition occurs on it under SMP, hence it is safe to pacth ss
> >> slot without stopping machine.
> >>
> >> Since I and D caches are coherent within single-step slot from
> >> aarch64_insn_patch_text_nosync(), hence no need to do it again via
> >> flush_icache_range().
> >>
> >> Acked-by: Will Deacon <will@kernel.org>
> >> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> >> ---
> >>  arch/arm64/kernel/probes/kprobes.c | 27 +++++++++++++++++++++------
> >>  1 file changed, 21 insertions(+), 6 deletions(-)
> > 
> > What's your expectation with this series, should the arch maintainers
> > just pick the individual patches?
> 
> Yes, or should i split this series into individual patch?

No need to, I can pick the arm64 patch. If the other maintainers don't
merge the patches, you might want to post them again individually as to
avoid confusion.

-- 
Catalin
