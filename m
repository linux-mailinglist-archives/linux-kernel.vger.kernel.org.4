Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839946FB4B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjEHQFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEHQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:05:29 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3734555B6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:05:28 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:6a18:41e7:fcfe:24c0])
        by michel.telenet-ops.be with bizsmtp
        id uG5R290062WBekD06G5Rm7; Mon, 08 May 2023 18:05:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pw3MU-001XSk-9e;
        Mon, 08 May 2023 18:05:25 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pw3Ma-00BTF8-WB;
        Mon, 08 May 2023 18:05:25 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] ARM/arm64: Mark all accessor functions inline
Date:   Mon,  8 May 2023 18:05:17 +0200
Message-Id: <cover.1683561087.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series adds missing "inline" keywords to the few perf
accessors that lack them.

BTW, I tried converting my local timing code to the new unified system.
This works fine on arm64, but broke on arm32.  Is read_pmccntr()
supposed to work on arm32? I get an undefined instruction exception on
Cortex A15 and A9.  Before, my custom code used "mrc p15, 0, %0, c9,
c13, 0" (as is also used in arch/arm/kernel/perf_event_v7.c), for which
there is no accessor yet.

Thanks for your comments!

Geert Uytterhoeven (2):
  ARM: perf: Mark all accessor functions inline
  arm64: perf: Mark all accessor functions inline

 arch/arm/include/asm/arm_pmuv3.h   | 6 +++---
 arch/arm64/include/asm/arm_pmuv3.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
