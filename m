Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2817F635102
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbiKWHQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiKWHQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:16:49 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A956DCF5;
        Tue, 22 Nov 2022 23:16:48 -0800 (PST)
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 576808517E;
        Wed, 23 Nov 2022 08:16:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669187805;
        bh=OIYyALv6fQ3JaJSDccGn0Zm5VKzxXieKgqBDhfmERf8=;
        h=From:To:Cc:Subject:Date:From;
        b=RZcr20f3rmxjLNXy72K3I1ssAqLpDp6cuc8zAiMNGampKqrIt2jqQTE168nJylOvu
         Q2rSgDvnbv7tp3Txcs7ZCgfhnwg9W+TstMJNFYlME1LzdTDuwPFCXc94hLasPbnIz6
         0vWoCW0bbGfNJXQr1DorIsRIoG9n8bgvKL8+ul3JTxNKfqjPUup9Ql41EtDZSsRh3p
         gr2r8e2zhi0Khsmci6gQ8s+QNuJSw01zvlOIb3Y7zMXK0vJwOKeithboB50eEPotN3
         vccv7+M1C5nM5N1S3oq8V0I2tUVEo8U+P/N5sMgs5rWh0ruoqzKES08WU0Mrf1bqBy
         vWDcPFED6STog==
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTPS id E3031180523;
        Wed, 23 Nov 2022 08:16:38 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id A8CD41A86FB; Wed, 23 Nov 2022 08:16:38 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     linux-can@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] can: sja1000: fix size of OCR_MODE_MASK define
Date:   Wed, 23 Nov 2022 08:16:36 +0100
Message-Id: <20221123071636.2407823-1-hs@denx.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bitfield mode in ocr register has only 2 bits not 3, so correct
the OCR_MODE_MASK define.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 include/linux/can/platform/sja1000.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/can/platform/sja1000.h b/include/linux/can/platform/sja1000.h
index 5755ae5a4712..6a869682c120 100644
--- a/include/linux/can/platform/sja1000.h
+++ b/include/linux/can/platform/sja1000.h
@@ -14,7 +14,7 @@
 #define OCR_MODE_TEST     0x01
 #define OCR_MODE_NORMAL   0x02
 #define OCR_MODE_CLOCK    0x03
-#define OCR_MODE_MASK     0x07
+#define OCR_MODE_MASK     0x03
 #define OCR_TX0_INVERT    0x04
 #define OCR_TX0_PULLDOWN  0x08
 #define OCR_TX0_PULLUP    0x10
-- 
2.37.3

