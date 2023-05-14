Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC0701CA2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjENJfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjENJfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:35:34 -0400
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119CC1FFE;
        Sun, 14 May 2023 02:35:32 -0700 (PDT)
Received: by air.basealt.ru (Postfix, from userid 490)
        id 51F532F2022E; Sun, 14 May 2023 09:35:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from localhost.localdomain (unknown [176.59.56.94])
        by air.basealt.ru (Postfix) with ESMTPSA id 484C52F20227;
        Sun, 14 May 2023 09:35:27 +0000 (UTC)
From:   kovalev@altlinux.org
To:     kovalev@altlinux.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org,
        sasha.neftin@intel.com, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] e1000e: Add "cnp" PCH boards to the packet loss fixing workaround
Date:   Sun, 14 May 2023 12:34:28 +0300
Message-Id: <20230514093428.113471-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasiliy Kovalev <kovalev@altlinux.org>

Add CannonLake and some Comet Lake Client Platform into the range
of workaround for packet loss issue.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=217436
Fixes: 639e298f432fb0 ("e1000e: Fix packet loss on Tiger Lake and later")
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 9466f65a6da77..e233a0b93bcf1 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4875,7 +4875,7 @@ static s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
 	/* Enable workaround for packet loss issue on TGP PCH
 	 * Do not gate DMA clock from the modPHY block
 	 */
-	if (mac->type >= e1000_pch_tgp) {
+	if (mac->type >= e1000_pch_cnp) {
 		fflt_dbg = er32(FFLT_DBG);
 		fflt_dbg |= E1000_FFLT_DBG_DONT_GATE_WAKE_DMA_CLK;
 		ew32(FFLT_DBG, fflt_dbg);
-- 
2.33.6

