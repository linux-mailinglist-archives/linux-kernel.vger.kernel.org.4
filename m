Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB92607F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJUThO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJUThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA10262069;
        Fri, 21 Oct 2022 12:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AD5F61F38;
        Fri, 21 Oct 2022 19:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AE0C433C1;
        Fri, 21 Oct 2022 19:37:10 +0000 (UTC)
Subject: [PATCH v2 0/4] sh: remove unused SLOW_DOWN_IO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIANb0UmMC/xXMQQoCMQwF0KsMWfuhjaDobdJOcCKaSAt2Mczdrcu3eTt1baad7stOTb/WLXyCTw
 vVTfyhsHWaODHnxBnDPijPaA5m5IT+ioE1hsMCRc/XJDe5VGWaRZGuKE28bv/kLeZ0HD8BSaZFdQAA AA==
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 21 Oct 2022 14:36:54 -0500
Message-Id: <20221021-wip-bjorn-22-10-slow-down-io-v2-0-8b3692d12ea7@google.com>
To:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666381029; l=1416;
 i=bhelgaas@google.com; s=20221014; h=from:subject:message-id;
 bh=F5ysg3ldlbKVWIufAKYnGUzGdS+WYBZ+rEXTdXPLz3s=;
 b=rJYm7NY2fmFY3WCMYPv/d7hCg228Cz8NG5BDvQqitw73zMGxB4g7gnfNnBxfa7YSLiTJUYF0R48M
 OxXmj6VlDayOhNzbpYRR3XnpZ7a12DItOpnsQsXqDb2uxwI6tU7y
X-Developer-Key: i=bhelgaas@google.com; a=ed25519;
 pk=bFjaHnNobtkUv3f7ErkQcm+PpbyCUUBlIfqMtNRJwQs=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only alpha and sh define SLOW_DOWN_IO, and there are no uses of it.  Remove
it from sh and clean up some nearby macros.

These were previously posted 4/15/2022 at
  https://lore.kernel.org/all/20220415190817.842864-1-helgaas@kernel.org/
and reposted 10/13/2022 at
  https://lore.kernel.org/all/20221014001911.3342485-1-helgaas@kernel.org/

Changes from v1 to v2:
  - Drop the ia64 patch because Andrew applied it
      https://lore.kernel.org/all/20221021045245.99636C433C1@smtp.kernel.org/

  - Fix the sh build issues reported by the kernel test robot:
      https://lore.kernel.org/all/202210181211.ItV2YuJI-lkp@intel.com/

  - Add minor sh cleanup patches to __BUILD_IOPORT_SINGLE(),
    __BUILD_IOPORT_PFX(), and __BUILD_MEMORY_STRING()

  - Split sh and alpha to separate series

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
Bjorn Helgaas (4):
      sh: remove unused SLOW_DOWN_IO
      sh: remove unused __BUILD_IOPORT_SINGLE 'pfx' parameter
      sh: remove unnecessary __BUILD_IOPORT_PFX()
      sh: remove unnecessary __BUILD_MEMORY_STRING() 'pfx' parameter

 arch/sh/include/asm/io.h | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)
---
base-commit: f1947d7c8a61db1cb0ef909a6512ede0b1f2115b
change-id: 20221021-wip-bjorn-22-10-slow-down-io-be370a9a6ce2

Best regards,
-- 
Bjorn Helgaas <bhelgaas@google.com>
