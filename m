Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3338D67EBC0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjA0Q6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjA0Q6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:58:36 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEC1213D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LmAjr1m6mk9w4CR9BTxCtj0rtt8UM2HbzWPMIlH+lLM=; b=uPRHoMTVafrgBjE17tVUp0eFqw
        ZzAAUlVzuRkForbcfDYgbB85IPnDFa9RlWRIYMN9fvBLPFa3ymfkI/ycIc6VEjeG2+jIas8KT5Dw1
        cywnCKnIHiIcxI9CjWBwqlToZHTQdI46PZ2fQCc3HdFzaxoHXUx4jTsafO2eJ0k4TGagSxL4V5g1p
        IjubC5aeSr6idZ1VagIktx01JOYNhNtlMOWd0DiKmyHwDQjXU2fBClpO4KLUDxyu3poyD9a8hyqB/
        ln+2UuVII+G8e/y9fzKVyDNSeaYTu7oaPbCz9sn49uZDbgFbzWPsrg74sig9NSzfjdXDyuc1wQOn3
        cjW8loPQ==;
Received: from p200300ccff0829001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:2900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pLS3b-0004ov-Bc; Fri, 27 Jan 2023 17:58:31 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pLS3a-00Df5f-N5; Fri, 27 Jan 2023 17:58:30 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     j.neuschaefer@gmx.net, lee@kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] mfd: ntxec: Add version number for EC in Tolino Vision
Date:   Fri, 27 Jan 2023 17:58:28 +0100
Message-Id: <20230127165828.3256170-1-andreas@kemnade.info>
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
Changes in V2:
 use the same formatting as the other version numbers

 drivers/mfd/ntxec.c       | 1 +
 include/linux/mfd/ntxec.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

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
index cc6f07bfa2b3..e5880c346da9 100644
--- a/include/linux/mfd/ntxec.h
+++ b/include/linux/mfd/ntxec.h
@@ -34,5 +34,5 @@ static inline u16 ntxec_reg8(u8 value)
 /* Known firmware versions */
 #define NTXEC_VERSION_KOBO_AURA	0xd726	/* found in Kobo Aura */
 #define NTXEC_VERSION_TOLINO_SHINE2 0xf110 /* found in Tolino Shine 2 HD */
-
+#define NTXEC_VERSION_TOLINO_VISION 0xe135 /* found in Tolino Vision, contains RTC, ADC, PWM, home pad */
 #endif
-- 
2.30.2

