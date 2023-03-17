Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE26BED91
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCQQCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCQQCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:02:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6530DE4C48
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 207EDB8262D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 16:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C151C433EF;
        Fri, 17 Mar 2023 16:02:09 +0000 (UTC)
Date:   Fri, 17 Mar 2023 16:02:06 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] arm64: mops: handle single stepping after MOPS
 exception
Message-ID: <ZBSO/sWK1IGkoOxj@arm.com>
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-9-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216160012.272345-9-kristina.martsenko@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:00:10PM +0000, Kristina Martsenko wrote:
> When a MOPS main or epilogue instruction is being executed, the task may
> get scheduled on a different CPU and restart execution from the prologue
> instruction. If the main or epilogue instruction is being single stepped
> then it makes sense to finish the step and take the step exception
> before starting to execute the next (prologue) instruction. So
> fast-forward the single step state machine when taking a MOPS exception.
> 
> This means that if a main or epilogue instruction is single stepped with
> ptrace, the debugger will sometimes observe the PC moving back to the
> prologue instruction. (As already mentioned, this should be rare as it
> only happens when the task is scheduled to another CPU during the step.)
> 
> This also ensures that perf breakpoints count prologue instructions
> consistently (i.e. every time they are executed), rather than skipping
> them when there also happens to be a breakpoint on a main or epilogue
> instruction.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
