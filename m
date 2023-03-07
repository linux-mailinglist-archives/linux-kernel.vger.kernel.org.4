Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F596AF6A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjCGUXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjCGUXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:23:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF3C21964
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:23:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D59B361535
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8914C433EF;
        Tue,  7 Mar 2023 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220609;
        bh=VALLXa4RfjgD9/IaizhQxdY6y9Xca49NdnfoOQ47Y+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nBr9Ztu2PNBF/a1Vij6drPfXyPlA06m7KIJsTbnWXbmOq+UrBScPikzMRIZw3qhfp
         AQ7rSrhZ1Q8/8FoV0Sw18GSufFJrL0ZKlGVCOQTaOvMwnqqMlvxGfqMyZCcvDQvWWZ
         YxG9Sp7BixBDAh7MKV8wKP2JNLlxaka50790bIIzqHd9ADjfyC64PUaMtDqnDDMxRq
         8UgUatZ7Uzy7BsSFOgXE8PMIJFum2eTkPCIEFs9Wt0jhGuTQJja6QzBKRaR5DfwpJQ
         cGGi2Ot2fBbXfTXhaQhQyWzlSkzNMSN1Ac54XMdB6Eg+ZFPz7p4lR6kBYnZl7as9Fj
         5rguI7kVgEwAg==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] mailbox: mpfs: ditch a useless busy check
Date:   Tue,  7 Mar 2023 20:22:53 +0000
Message-Id: <20230307202257.1762151-4-conor@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307202257.1762151-1-conor@kernel.org>
References: <20230307202257.1762151-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=conor.dooley@microchip.com; h=from:subject; bh=3TqNg+2iuqTO/EgEaud+uW5LomESwP/fUE4ltR1iLac=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnsc4WyHSY+Wt4RdWbzMT3OCQZ3EuTZs1ns6pn2xYSzr Dzu81iko5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABOpOsXwP9CY27mex73y3I6j TUdyE4v9GizYw29b9p/yP7F4AvvzdIZ/pkfbvrwXYU14Eihi9rE0IStHwWDL4+zprzc8Yfkj2Li cDQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

mpfs_mbox_rx_data() already checks if the system controller is busy
before attempting to do anything, so drop the second check before
reading any data.

No functional change intended.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/mailbox/mailbox-mpfs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index e0e825bdbad9..0d176aba3462 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -170,12 +170,10 @@ static void mpfs_mbox_rx_data(struct mbox_chan *chan)
 	if (response->resp_status)
 		return;
 
-	if (!mpfs_mbox_busy(mbox)) {
-		for (i = 0; i < num_words; i++) {
-			response->resp_msg[i] =
-				readl_relaxed(mbox->mbox_base
-					      + mbox->resp_offset + i * 0x4);
-		}
+	for (i = 0; i < num_words; i++) {
+		response->resp_msg[i] =
+			readl_relaxed(mbox->mbox_base
+				      + mbox->resp_offset + i * 0x4);
 	}
 
 	mbox_chan_received_data(chan, response);
-- 
2.39.2

