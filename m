Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59FB63F6B0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiLARr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiLARrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:47:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1477BB007
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:45:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61867B81FC8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38626C433D6;
        Thu,  1 Dec 2022 17:45:46 +0000 (UTC)
Date:   Thu, 1 Dec 2022 17:45:43 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, amit.pundir@linaro.org,
        andersson@kernel.org, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <Y4joR2sQMMjIt+yE@arm.com>
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <20221114141109.GG30263@willie-the-truck>
 <1659929b-1372-cea6-5840-c58369a4252d@arm.com>
 <Y3J8+O7Y3f3onH0P@arm.com>
 <20221118105402.GA184726@thinkpad>
 <20221118123349.GC3697@willie-the-truck>
 <20221121064224.GB11945@thinkpad>
 <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com>
 <Y39blgEueyegkz6C@arm.com>
 <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 10:29:39AM +0100, Thorsten Leemhuis wrote:
> Has any progress been made to fix this regression? It afaics is not a
> release critical issue, but well, it still would be nice to get this
> fixed before 6.1 is released.

The only (nearly) risk-free "fix" for 6.1 would be to revert the commit
that exposed the driver bug. It doesn't fix the actual bug, it only
makes it less likely to happen.

I like the original commit removing the cache invalidation as it shows
drivers not behaving properly but, as a workaround, we could add a
command line option to force back the old behaviour (defaulting to the
new one) until the driver is fixed.

-- 
Catalin
