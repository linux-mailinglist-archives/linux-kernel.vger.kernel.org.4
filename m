Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F09260148A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJQRRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJQRRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:17:36 -0400
Received: from mailout-pe-b.jellyfish.systems (mailout-pe-b.jellyfish.systems [198.54.127.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB0C6E8AD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:17:35 -0700 (PDT)
Received: from output-router-58994b6955-smsdz (unknown [10.35.5.64])
        by mailout-pe-b.jellyfish.systems (Postfix) with ESMTPA id 4MrkFn42hczGp46;
        Mon, 17 Oct 2022 17:17:33 +0000 (UTC)
Received: from MTA-07.privateemail.com (unknown [10.50.14.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by NEW-01.privateemail.com (Postfix) with ESMTPS id 7884D18000D0;
        Mon, 17 Oct 2022 13:17:33 -0400 (EDT)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
        by mta-07.privateemail.com (Postfix) with ESMTP id 59FA618000AD;
        Mon, 17 Oct 2022 13:17:33 -0400 (EDT)
Received: from bpappas-XPS-13-9310.wppl.org (unknown [131.226.25.151])
        by mta-07.privateemail.com (Postfix) with ESMTPA id 6D68D18000A4;
        Mon, 17 Oct 2022 13:17:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
        s=default; t=1666027053;
        bh=aNeyk48AOwzSbd9WzVFlb+MjlJ0dkJAtLpWqe7mkpss=;
        h=From:To:Cc:Subject:Date:From;
        b=k8p1r7CEvBrvPBRXck6Ydxzn4SAXchY6EOJ7yaODajJ9kpaWOuz2Y4voAdE4CRHLm
         lq3Tki5VFhWYVw83i7arcD9dWcyx0GRv5Xd1tDI3pc8XV5lAlLj9jQlU5l+mi4FhHv
         poeJWthiqhm5ZcdnN9GGo7vWYRGnBRMBjiN1c+ghCbFtXoWicHGjnIf4LXHA6Jc26Q
         vDrNQmwBHzoQmFI8wQg+ywOZ0GQK7tYqDL4AMgxBR4JfD4ocAfaQsz8eHvDdHFtIlJ
         9iE/9yvtcTIywCnxWZ6jeR9Zn1N6Heamn9FYLTT1ijHX+0s0YQBPjh8sjTUB4i+Fjo
         iLPrOV5qaYKmQ==
From:   Brent Pappas <bpappas@pappasbrent.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brent Pappas <pappasbrent@gmail.com>,
        Brent Pappas <bpappas@pappasbrent.com>
Subject: [PATCH] staging: rtl8723bs: core: Replace macros RotR1 through Mk16 with static inline functions
Date:   Mon, 17 Oct 2022 13:16:54 -0400
Message-Id: <20221017171653.12578-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brent Pappas <pappasbrent@gmail.com>

Replace macros "RotR1", "Lo8", "Hi8", "Lo16", "Hi16", and "Mk16" with
static inline functions to comply with Linux coding style standards.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 35 +++++++++++++++----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index ac731415f733..519e141fb82c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -253,12 +253,35 @@ void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_cod
 }
 
 /* macros for extraction/creation of unsigned char/unsigned short values  */
-#define RotR1(v16)   ((((v16) >> 1) & 0x7FFF) ^ (((v16) & 1) << 15))
-#define   Lo8(v16)   ((u8)((v16)       & 0x00FF))
-#define   Hi8(v16)   ((u8)(((v16) >> 8) & 0x00FF))
-#define  Lo16(v32)   ((u16)((v32)       & 0xFFFF))
-#define  Hi16(v32)   ((u16)(((v32) >> 16) & 0xFFFF))
-#define  Mk16(hi, lo) ((lo) ^ (((u16)(hi)) << 8))
+static inline u16 RotR1(u16 v16)
+{
+	return ((((v16) >> 1) & 0x7FFF) ^ (((v16) & 1) << 15));
+}
+
+static inline u8 Lo8(u16 v16)
+{
+	return ((u8)((v16)       & 0x00FF));
+}
+
+static inline u8 Hi8(u16 v16)
+{
+	return ((u8)(((v16) >> 8) & 0x00FF));
+}
+
+static inline u16 Lo16(u32 v32)
+{
+	return ((u16)((v32)       & 0xFFFF));
+}
+
+static inline u32 Hi16(u32 v32)
+{
+	return ((u16)(((v32) >> 16) & 0xFFFF));
+}
+
+static u16 Mk16(u8 hi, u8 lo)
+{
+	return ((lo) ^ (((u16)(hi)) << 8));
+}
 
 /* select the Nth 16-bit word of the temporal key unsigned char array TK[]   */
 #define  TK16(N)     Mk16(tk[2*(N)+1], tk[2*(N)])
-- 
2.34.1

