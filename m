Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E446F55ED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjECKUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjECKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE38549E4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59B3B62AA4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593B1C4339B;
        Wed,  3 May 2023 10:20:43 +0000 (UTC)
Date:   Wed, 3 May 2023 11:20:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Justin Forbes <jforbes@fedoraproject.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jmforbes@linuxtx.org, Andrew Morton <akpm@linux-foundation.org>,
        lkp@intel.com
Subject: Re: [PATCH] Revert arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZFI1eK5JmwIdL1eq@arm.com>
References: <20230428153646.823736-1-jforbes@fedoraproject.org>
 <ZEv76qfIiJcUvdql@arm.com>
 <ZE1pcwi95nPdlKzN@kernel.org>
 <CAFbkSA3SzjWZ_Q8XC6-_Kzc+jmUN6sG7vzbSD5X1bRvPUaJg3Q@mail.gmail.com>
 <ZE3mdYajdFnvl1by@kernel.org>
 <CAFbkSA0O-4YgNt-7KPhvx+vhvRNc38PO8E--GVAWKVgHK-_9Mw@mail.gmail.com>
 <ZFEZLZHBosQK9xaH@arm.com>
 <ZFE3GDjmUWpMpmqu@kernel.org>
 <ZFFK/qPTCIpGE2Tu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFFK/qPTCIpGE2Tu@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 06:40:14PM +0100, Catalin Marinas wrote:
> On Tue, May 02, 2023 at 07:15:20PM +0300, Mike Rapoport wrote:
> > On Tue, May 02, 2023 at 03:07:41PM +0100, Catalin Marinas wrote:
> > > On Mon, May 01, 2023 at 04:24:38PM -0500, Justin Forbes wrote:
> > > 
> > > Regarding EXPERT, we could drop it and do like the other architectures
> > > but we'll have randconfig occasionally hitting weird values that won't
> > > build (like -1). Not sure EXPERT helps here.
> > 
> > AFAIU, randconfig does not randomize int values, it's probably random
> > people that do ;-)
> 
> https://lore.kernel.org/r/202303232149.Chh6KhiI-lkp@intel.com
> 
> with the randconfig here:
> 
> https://download.01.org/0day-ci/archive/20230323/202303232149.Chh6KhiI-lkp@intel.com/config

You may be right, I can't get my randconfig to set ARCH_FORCE_MAX_ORDER
to anything other than the default. Maybe the kernel test robot has its
own config randomisation (cc'ing lkp@intel.com).

If we don't care about about this randconfig, I'm fine do drop EXPERT
from current mainline, together with the 4K/16K pages condition. The
condition only made sense if we kept the ranges in since these were
configurable (no range for 64K).

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b1201d25a8a4..1867aba83ba3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1516,7 +1516,7 @@ config XEN
 # 16K |       27          |      14      |       13        |         11         |
 # 64K |       29          |      16      |       13        |         13         |
 config ARCH_FORCE_MAX_ORDER
-	int "Order of maximal physically contiguous allocations" if EXPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
+	int "Order of maximal physically contiguous allocations"
 	default "13" if ARM64_64K_PAGES
 	default "11" if ARM64_16K_PAGES
 	default "10"

-- 
Catalin
