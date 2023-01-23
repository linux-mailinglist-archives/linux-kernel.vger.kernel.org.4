Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE35678B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjAWXCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjAWXCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:02:05 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD494ED8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 15:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e/fxNQstuZOWCkHt90b95Dh3VhhuJBbKuO0AtP6Xtsk=; b=XCNx1/blJw43MPW0E2sXa4EFxW
        2mfHYWtmPQPTF+SSv5JHyZNfDGgu0azz9BxqNk0B01KabEytEUEBddK6naB16LxJobo+6mc+yik9y
        R7LQCAGd5PvEhMfOVaLjvjhLWVtn0arILNakkCIRhsUWnFk6AuGcBd/Hl3Mo9yr7FglZ6BkQrNhNT
        1/tN0RJ2iOIMjMIfuojOAzDdZxaYle3t/Jc/NtnzU4JfbVYfgwVQRYr5rKJibgDX15Y5MfdYZfd7V
        QprVyaPdqvbktAjxp3J6mf5J2ZtfXZjiasNiN9s2vKYY1/2YwNYBq3wFhJsr3YkSjRr/68h9Z2vC3
        xSM/t8aw==;
Received: from p200300ccff0608001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff06:800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pK5oX-0001Z2-3R; Tue, 24 Jan 2023 00:01:21 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pK5oW-00D9Pe-FA; Tue, 24 Jan 2023 00:01:20 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     j.neuschaefer@gmx.net, lee@kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] mfd: ntxec: Add version number for EC in Tolino Vision
Date:   Tue, 24 Jan 2023 00:01:14 +0100
Message-Id: <20230123230114.3134400-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC firmware has a different version number than anything
defined until now.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/ntxec.c       | 1 +
 include/linux/mfd/ntxec.h | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
index e16a7a82a929..b02785b10d48 100644
--- a/drivers/mfd/ntxec.c
+++ b/drivers/mfd/ntxec.c
@@ -175,6 +175,7 @@ static int ntxec_probe(struct i2c_client *client)
 	/* Bail out if we encounter an unknown firmware version */
 	switch (version) {
 	case NTXEC_VERSION_KOBO_AURA:
+	case NTXEC_VERSION_TOLINO_VISION:
 		subdevs = ntxec_subdev;
 		n_subdevs = ARRAY_SIZE(ntxec_subdev);
 		break;
diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
index cc6f07bfa2b3..562895eb9a31 100644
--- a/include/linux/mfd/ntxec.h
+++ b/include/linux/mfd/ntxec.h
@@ -35,4 +35,8 @@ static inline u16 ntxec_reg8(u8 value)
 #define NTXEC_VERSION_KOBO_AURA	0xd726	/* found in Kobo Aura */
 #define NTXEC_VERSION_TOLINO_SHINE2 0xf110 /* found in Tolino Shine 2 HD */
 
+/*
+ * found in Tolino Vision, contains RTC, ADC, PWM, home pad
+ */
+#define NTXEC_VERSION_TOLINO_VISION 0xe135
 #endif
-- 
2.30.2

