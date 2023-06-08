Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF36C7289AD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjFHUvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjFHUvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27C1BE4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 925A66184B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 20:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0AFC433EF;
        Thu,  8 Jun 2023 20:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686257509;
        bh=x/RrRf5dGGG1fX8AYzgsquZj0sx1qcx5FUN9ejLtBOk=;
        h=Date:From:To:Cc:Subject:From;
        b=bmbrLmuh3Kf5fgbzt819VivpqbjTtgmmQTPLR0hixRexyWkI0Kuk6xDtx/q2F0PPj
         iJU/xmVZgIJwFPA/NbNf8kMufljIJgmPl9E5UTystYPdcHibDEEKPZ0eihi1Qq70We
         ZYl1SpkDZoMi0NFI0+aj2zTgIDOs+PIqfYcYLHeoRlN50HkrRTrS5tqrilnGOQ+mkC
         AoM2pGTVEByoTM+Q02naaSn6W+eJca4lccs5qBW5FkPbjX/bYTTwLc5Z705NFSHjo7
         PouQ87kbumiF3n45KqgfirUiFF3zFDtDTRIc63wzQheISwW7nkA7v3/uSBCeXBSgwy
         8lBebJZlZkAGg==
Date:   Thu, 8 Jun 2023 21:51:44 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc6
Message-ID: <20230608205144.GA2470@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these two tiny arm64 fixes for -rc6. One fixes a build
breakage when MAX_ORDER can be nonsensical if CONFIG_EXPERT=y and the
other fixes the address masking for perf's page fault software events
so that it is consistent amongst them.

Cheers,

Will

--->8

The following changes since commit c4c597f1b367433c52c531dccd6859a39b4580fb:

  arm64: mte: Do not set PG_mte_tagged if tags were not initialized (2023-05-16 14:59:16 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 0e2aba694866b451db0932a6706683c48379134c:

  arm64: mm: pass original fault address to handle_mm_fault() in PER_VMA_LOCK block (2023-06-02 13:02:44 +0100)

----------------------------------------------------------------
arm64 fixes for -rc6

- Fix build breakage due to bogus MAX_ORDER definitions on !4k pages

- Avoid masking fault address for perf software events

----------------------------------------------------------------
Catalin Marinas (1):
      arm64: Remove the ARCH_FORCE_MAX_ORDER config input prompt

Jisheng Zhang (1):
      arm64: mm: pass original fault address to handle_mm_fault() in PER_VMA_LOCK block

 arch/arm64/Kconfig    | 2 +-
 arch/arm64/mm/fault.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)
