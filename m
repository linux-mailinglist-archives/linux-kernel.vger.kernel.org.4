Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B056F998A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjEGPzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjEGPzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:55:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573DD6A5B;
        Sun,  7 May 2023 08:55:17 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115eef620so29325663b3a.1;
        Sun, 07 May 2023 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683474917; x=1686066917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GYb3dk460XgtsVCvhsWMRMsftl/DXZ2mh7rVvkm2EDw=;
        b=k7CifHgNsCWx5LvdF7fIHaYUiiTtEulUmBd6XZrJknUjjn9gzQN56bL4M435r+xkMl
         7Yt8MHg/JaTgzNMCV+lz1ELsQYjd49CRYEKKVe9vOEex0DnO/VaYVcdtRt/Iw3j6QwDn
         0waaqU1MtlaJkvTS9RvbFJEZxngjIqnvlpuhfjazqsq948lSgvrGNMSkIWxi75d1mVZr
         CV3nvxtJ27sEBAVqxFlP6UGkO2huCjmsP1foSNdsysFbKizFLU0X1aHJ9DI4uLJsojuu
         sJ0jUHkxAlfbmUF5++5TTfO/Pyy1ODG/jh9WzpPDgiBA4r2ay23mwY8zbWWIshHXuRXI
         Pq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683474917; x=1686066917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYb3dk460XgtsVCvhsWMRMsftl/DXZ2mh7rVvkm2EDw=;
        b=Ip9m4hFq+Ny0GimrYuM5nZq2RQhhowJwZyGz6Ywz4suLcpLw2NeAY2JC6Oat9lQDZe
         uI+aa5eY7g7tA4fEkSw31wCzCUcUTi3yjVgKEYWREQCg5SnHqYbfS/DUk7u/oNzqdNtL
         KC4gt26w/OmdHtuSIPoJnUgeg10u8fa3AqzB27izekd2mspOSApPLCk4PX4Z0qc+w3Ot
         FU+axNUnEUjGYqZdmu7DVUpxn7ayJ4psqLGb0emBfHCs0OvgkMDBqHSNmVqGZTZ1BFHI
         4Id/DQaX5SZSw8wyA3fjF0NBgtkbeOzErMPOLA1N1kR3jCwACRngqr/CgWjpF0Dqm2B9
         hc3A==
X-Gm-Message-State: AC+VfDwymy9lWglVJ+Ko43kq4lWlkd/IXy5ZbMV8vBr+qdpI1wlsvXgC
        jOAPkaZwFzDvJJ2Y7S0QVBE=
X-Google-Smtp-Source: ACHHUZ6gBz4FXcclZPm+RTBXlHXIsHpELQy7700mjt1mMbOqWvrSVyTfrE1uE5Cp9knWG/+eauqCAA==
X-Received: by 2002:a17:902:f685:b0:1ac:731b:bc9a with SMTP id l5-20020a170902f68500b001ac731bbc9amr1448873plg.27.1683474916488;
        Sun, 07 May 2023 08:55:16 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001a3d041ca71sm5338360plg.275.2023.05.07.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 08:55:16 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Marek Vasut <marex@denx.de>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: length: add definitions for frame lengths in bits
Date:   Mon,  8 May 2023 00:55:06 +0900
Message-Id: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When created in [1], frames length definitions were added to implement
byte queue limits (bql). Because bql expects lengths in bytes, bit
length definitions were not considered back then.

Recently, a need to refer to the exact frame length in bits, with CAN
bit stuffing, appeared in [2].

Add 9 frames length definitions:

 - CAN_FRAME_OVERHEAD_SFF_BITS:
 - CAN_FRAME_OVERHEAD_EFF_BITS
 - CANFD_FRAME_OVERHEAD_SFF_BITS
 - CANFD_FRAME_OVERHEAD_EFF_BITS
 - CAN_BIT_STUFFING_OVERHEAD
 - CAN_FRAME_LEN_MAX_BITS_NO_STUFFING
 - CAN_FRAME_LEN_MAX_BITS_STUFFING
 - CANFD_FRAME_LEN_MAX_BITS_NO_STUFFING
 - CANFD_FRAME_LEN_MAX_BITS_STUFFING

CAN_FRAME_LEN_MAX_BITS_STUFFING and CANFD_FRAME_LEN_MAX_BITS_STUFFING
define respectively the maximum number of bits in a classical CAN and
CAN-FD frame including bit stuffing. The other definitions are
intermediate values.

In addition to the above:

 - Include linux/bits.h and then replace the value 8 by BITS_PER_BYTE
   whenever relevant.
 - Include linux/math.h because of DIV_ROUND_UP(). N.B: the use of
   DIV_ROUND_UP() is not new to this patch, but the include was
   previously omitted.
 - Update the existing length definitions to use the newly defined values.
 - Add myself as copyright owner for 2020 (as coauthor of the initial
   version, c.f. [1]) and for 2023 (this patch).

[1] commit 85d99c3e2a13 ("can: length: can_skb_get_frame_len(): introduce
    function to get data length of frame in data link layer")
Link: https://git.kernel.org/torvalds/c/85d99c3e2a13

[2] RE: [PATCH] can: mcp251xfd: Increase poll timeout
Link: https://lore.kernel.org/linux-can/BL3PR11MB64846C83ACD04E9330B0FE66FB729@BL3PR11MB6484.namprd11.prod.outlook.com/

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
As always, let me know if you have better inspiration than me for the
naming.
---
 include/linux/can/length.h | 84 ++++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/include/linux/can/length.h b/include/linux/can/length.h
index 6995092b774e..60492fcbe34d 100644
--- a/include/linux/can/length.h
+++ b/include/linux/can/length.h
@@ -1,13 +1,17 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (C) 2020 Oliver Hartkopp <socketcan@hartkopp.net>
  * Copyright (C) 2020 Marc Kleine-Budde <kernel@pengutronix.de>
+ * Copyright (C) 2020, 2023 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #ifndef _CAN_LENGTH_H
 #define _CAN_LENGTH_H
 
+#include <linux/bits.h>
+#include <linux/math.h>
+
 /*
- * Size of a Classical CAN Standard Frame
+ * Size of a Classical CAN Standard Frame in bits
  *
  * Name of Field			Bits
  * ---------------------------------------------------------
@@ -25,12 +29,19 @@
  * End-of-frame (EOF)			7
  * Inter frame spacing			3
  *
- * rounded up and ignoring bitstuffing
+ * ignoring bitstuffing
  */
-#define CAN_FRAME_OVERHEAD_SFF DIV_ROUND_UP(47, 8)
+#define CAN_FRAME_OVERHEAD_SFF_BITS 47
 
 /*
- * Size of a Classical CAN Extended Frame
+ * Size of a Classical CAN Standard Frame
+ * (rounded up and ignoring bitstuffing)
+ */
+#define CAN_FRAME_OVERHEAD_SFF \
+	DIV_ROUND_UP(CAN_FRAME_OVERHEAD_SFF_BITS, BITS_PER_BYTE)
+
+/*
+ * Size of a Classical CAN Extended Frame in bits
  *
  * Name of Field			Bits
  * ---------------------------------------------------------
@@ -50,12 +61,19 @@
  * End-of-frame (EOF)			7
  * Inter frame spacing			3
  *
- * rounded up and ignoring bitstuffing
+ * ignoring bitstuffing
  */
-#define CAN_FRAME_OVERHEAD_EFF DIV_ROUND_UP(67, 8)
+#define CAN_FRAME_OVERHEAD_EFF_BITS 67
 
 /*
- * Size of a CAN-FD Standard Frame
+ * Size of a Classical CAN Extended Frame
+ * (rounded up and ignoring bitstuffing)
+ */
+#define CAN_FRAME_OVERHEAD_EFF \
+	DIV_ROUND_UP(CAN_FRAME_OVERHEAD_EFF_BITS, BITS_PER_BYTE)
+
+/*
+ * Size of a CAN-FD Standard Frame in bits
  *
  * Name of Field			Bits
  * ---------------------------------------------------------
@@ -77,12 +95,19 @@
  * End-of-frame (EOF)			7
  * Inter frame spacing			3
  *
- * assuming CRC21, rounded up and ignoring bitstuffing
+ * assuming CRC21 and ignoring bitstuffing
  */
-#define CANFD_FRAME_OVERHEAD_SFF DIV_ROUND_UP(61, 8)
+#define CANFD_FRAME_OVERHEAD_SFF_BITS 61
 
 /*
- * Size of a CAN-FD Extended Frame
+ * Size of a CAN-FD Standard Frame
+ * (assuming CRC21, rounded up and ignoring bitstuffing)
+ */
+#define CANFD_FRAME_OVERHEAD_SFF \
+	DIV_ROUND_UP(CANFD_FRAME_OVERHEAD_SFF_BITS, BITS_PER_BYTE)
+
+/*
+ * Size of a CAN-FD Extended Frame in bits
  *
  * Name of Field			Bits
  * ---------------------------------------------------------
@@ -106,9 +131,32 @@
  * End-of-frame (EOF)			7
  * Inter frame spacing			3
  *
- * assuming CRC21, rounded up and ignoring bitstuffing
+ * assuming CRC21 and ignoring bitstuffing
+ */
+#define CANFD_FRAME_OVERHEAD_EFF_BITS 80
+
+/*
+ * Size of a CAN-FD Extended Frame
+ * (assuming CRC21, rounded up and ignoring bitstuffing)
+ */
+#define CANFD_FRAME_OVERHEAD_EFF \
+	DIV_ROUND_UP(CANFD_FRAME_OVERHEAD_EFF_BITS, BITS_PER_BYTE)
+
+/* CAN bit stuffing overhead multiplication factor */
+#define CAN_BIT_STUFFING_OVERHEAD 1.2
+
+/*
+ * Maximum size of a Classical CAN frame in bits, ignoring bitstuffing
  */
-#define CANFD_FRAME_OVERHEAD_EFF DIV_ROUND_UP(80, 8)
+#define CAN_FRAME_LEN_MAX_BITS_NO_STUFFING \
+	(CAN_FRAME_OVERHEAD_EFF_BITS + CAN_MAX_DLEN * BITS_PER_BYTE)
+
+/*
+ * Maximum size of a Classical CAN frame in bits, including bitstuffing
+ */
+#define CAN_FRAME_LEN_MAX_BITS_STUFFING				\
+	((unsigned int)(CAN_FRAME_LEN_MAX_BITS_NO_STUFFING *	\
+			CAN_BIT_STUFFING_OVERHEAD))
 
 /*
  * Maximum size of a Classical CAN frame
@@ -116,6 +164,18 @@
  */
 #define CAN_FRAME_LEN_MAX (CAN_FRAME_OVERHEAD_EFF + CAN_MAX_DLEN)
 
+/*
+ * Maximum size of a CAN-FD frame in bits, ignoring bitstuffing
+ */
+#define CANFD_FRAME_LEN_MAX_BITS_NO_STUFFING \
+	(CANFD_FRAME_OVERHEAD_EFF_BITS + CANFD_MAX_DLEN * BITS_PER_BYTE)
+
+/*
+ * Maximum size of a CAN-FD frame in bits, ignoring bitstuffing
+ */
+#define CANFD_FRAME_LEN_MAX_BITS_STUFFING			\
+	((unsigned int)(CANFD_FRAME_LEN_MAX_BITS_NO_STUFFING *	\
+			CAN_BIT_STUFFING_OVERHEAD))
 /*
  * Maximum size of a CAN-FD frame
  * (rounded up and ignoring bitstuffing)
-- 
2.39.3

