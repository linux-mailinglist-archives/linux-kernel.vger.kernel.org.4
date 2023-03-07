Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8B56AF6A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjCGUXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjCGUX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:23:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFAC8699
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:23:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C4EDB81A1D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDA2C433A1;
        Tue,  7 Mar 2023 20:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220605;
        bh=x+8F7ELtsW/BQB3u+HCi4ETUUZR7Hhz1aXJMSp6UPQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtZSFRIoN3Dk9IaS71f+Vi0gbcEz/eCmHEBigAl8IcconSATVF61MN1GhhQwkCitD
         jAY7f2olbsMcii5YlQxr0YWpqHPD4jS8CFiFI7mnCRkDIh4GzVGOR+BatsULKGv8mA
         4Wc9BKdAy1ecelH2XuJoO9v8cNesJSTEa9Bf2MeeOuSBdsZdZUVKjtJ7ed1HzRHX0Q
         Q1g5o4gHW6LZpwsZQjAPwS5k9KWTMWndaYBkaU2i8p6hUbp+xxyPzp1mnTl3qgADlM
         49SwhSxnJUtPSOJmUpUna9vm2yoeTzv/n/K+YsOKZ3FxQhQXQy5Smzy94n1owWRP1D
         MdgXM/P2+3opw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] mailbox: mpfs: fix an incorrect mask width
Date:   Tue,  7 Mar 2023 20:22:51 +0000
Message-Id: <20230307202257.1762151-2-conor@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307202257.1762151-1-conor@kernel.org>
References: <20230307202257.1762151-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=conor.dooley@microchip.com; h=from:subject; bh=N+Fmo03qeVhPTJ2ouN+nX4YhvmUTQ6mGrE0sJhfEG04=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnsc4XOqS91dHS5c+zaHbc75y70ZwR90D7jPWPBYbuAJ f0ua98ZdZSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiH28w/LP80GRfqdDw5M7R GT++qmY5eUXd2nfWRmRK1uO5qVqizCUM/1Nzv7fZZxQuf6hqa2HZ0rDrf+Tyu5xXzqeo6vq357z 7zgEA
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

The system controller registers on PolarFire SoC are 32 bits wide, so
16 + 16 as the first input to GENMASK_ULL() gives a 33 bit wide mask.
It probably should have been immediately obvious when it was pointed
out during review that the width required using GENMASK_ULL() - but I
scarcely knew what I was doing at the time and missed it.
The mistake ends up being moot as it is a mask after all, but it is
incorrect and should be fixed.

No functional change intended.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/mailbox/mailbox-mpfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index 853901acaeec..d37560e91116 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -39,7 +39,7 @@
 #define SCB_CTRL_NOTIFY_MASK BIT(SCB_CTRL_NOTIFY)
 
 #define SCB_CTRL_POS (16)
-#define SCB_CTRL_MASK GENMASK_ULL(SCB_CTRL_POS + SCB_MASK_WIDTH, SCB_CTRL_POS)
+#define SCB_CTRL_MASK GENMASK(SCB_CTRL_POS + SCB_MASK_WIDTH - 1, SCB_CTRL_POS)
 
 /* SCBCTRL service status register */
 
@@ -118,6 +118,7 @@ static int mpfs_mbox_send_data(struct mbox_chan *chan, void *data)
 	}
 
 	opt_sel = ((msg->mbox_offset << 7u) | (msg->cmd_opcode & 0x7fu));
+
 	tx_trigger = (opt_sel << SCB_CTRL_POS) & SCB_CTRL_MASK;
 	tx_trigger |= SCB_CTRL_REQ_MASK | SCB_STATUS_NOTIFY_MASK;
 	writel_relaxed(tx_trigger, mbox->ctrl_base + SERVICES_CR_OFFSET);
-- 
2.39.2

