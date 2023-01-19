Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DEF67426F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjASTMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjASTLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:11:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D134951A5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:10:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E43A61D64
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A388DC4339C;
        Thu, 19 Jan 2023 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674155370;
        bh=8Cn0FcPGO99DRyV5BMetrgkrR1IPC83hOdnJBiluyg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLbtv/pq5LhkcUCCds/LdW93PejmIky0uIn7iFT8KGKrQTnvSm7lcwmRq9BKyKeMw
         pnlILg6L0szlOzXq4N+MHosNrWk1VX69aqdHzlKsQPVR1PI/QAmGsBidrwnOx7JyYY
         xZ25VbBZlTer9WiDhpNChODd38w9q4yojdsAVFlWyIWEkeGrXAQuyUmsJHSxEC5KAY
         ej8GLQy/4oaf9XAVjkoPRyZQxjEjQQYNhm+PQan6IVkZVoWOHQSMRniSno4aS9cMD6
         XUehSXSbsP0ACyvA0lcgCYwlFSAcGM0r1ccjOphhtG7HnNKyFoXGSR8x46+j9H/ovk
         cMXJ/xXyeIzvw==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf/arm-cmn: Reset DTM_PMU_CONFIG at probe
Date:   Thu, 19 Jan 2023 19:08:43 +0000
Message-Id: <167415190277.3429004.658905197029681030.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <ba5f38b3dc733cd06bfb5e659b697e76d18c2183.1670269572.git.robin.murphy@arm.com>
References: <ba5f38b3dc733cd06bfb5e659b697e76d18c2183.1670269572.git.robin.murphy@arm.com>
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

On Mon, 5 Dec 2022 19:46:13 +0000, Robin Murphy wrote:
> Although we treat the DTM counters as free-running such that we're not
> too concerned about the initial DTM state, it's possible for a previous
> user to have left DTM counters enabled and paired with DTC counters.
> Thus if the first events are scheduled using some, but not all, DTMs,
> the as-yet-unused ones could end up adding spurious increments to the
> event counts at the DTC. Make sure we sync our initial DTM_PMU_CONFIG
> state to all the DTMs at probe time to avoid that possibility.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Reset DTM_PMU_CONFIG at probe
      https://git.kernel.org/will/c/bb21ef19a3d8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
