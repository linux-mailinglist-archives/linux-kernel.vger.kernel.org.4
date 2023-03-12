Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7386B63B3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 08:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCLHdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 03:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCLHc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 03:32:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6873F1A2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:32:54 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y4so7417900edo.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678606373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqixGIH6dUSPWHgAy8PJhWrG354k6op6O7lKYsRXNZk=;
        b=jOA6wgpbss8RrRhWQyTSJC8ekJaIHjG+xSIiq0tEuSBkRhDhch4EwPyKjxmSVwXFlB
         kjz/Ly1Wd0auj9C85IBRMBlzuHL/xnnD8mZDgnHb5mphUfN3b/OSwmhp8KZ/nL8JHd3P
         eGggXDkBdm4Bn+upcNXQ5sglziK6U8V2okfnjXgrMOCvXYeB6Pi6i6kimqAL8AfA+Fpy
         dpUF4T6aAkP/HdbeAj1/CczvMPvyVZdsvpCAe2cXvPS0BOpDP2LWXwM5MX1BE81x0dqB
         NFmYi+NvBXKAAbHwIsxeocsFUppHGAcJsmBFmhFij01ABqy9cJeMXMPFPXKXlhjPvg/S
         MW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678606373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqixGIH6dUSPWHgAy8PJhWrG354k6op6O7lKYsRXNZk=;
        b=mV9AMXIslApJUf8f8SLv5K0KtKwUCxHzjVpbO9icVcdQzT3mal2yfhvETFVLP4Ndns
         eqVWyZRAwQKxjko4fqvRk1RKlZFbACqLgOuqhFeJf9uAM/H5THZFfmZ/ITELRM5WuOdi
         WAIJ6J+F+fSdNA7Rdk9pZNaWJEy+gfpDb7stQn/0P0Ted5k/3U5c+tE+km9+vjqBT1xy
         zJ8TrLAURB/eh1Cas1pfJBxWHQH/BoOpLdApLHJCTQKW7znFgUXObhrDHv+Wz2iZB20f
         rYsYLvToyg9tA+nIdd6tjFTGF3XT1SgmtYTiuw9ckGL3VkxVqLzRxh8yDmOggMfuVbkS
         62ow==
X-Gm-Message-State: AO0yUKVKYnhcZ35lQZJdUVr65/zEfMNCPV0QbOAuL/Ktq9WjFgtcqI6T
        ePmW4cP7lTik8OTn5/cdugY=
X-Google-Smtp-Source: AK7set/+pEOPJ/iBNBwobhh2O0o6I57oaix6+c25P1XNSlRonBQaIJSn/IP6QsT5b/5eDoBWOphBcQ==
X-Received: by 2002:a17:907:728e:b0:8b1:807e:d4d2 with SMTP id dt14-20020a170907728e00b008b1807ed4d2mr40826053ejc.34.1678606372830;
        Sat, 11 Mar 2023 23:32:52 -0800 (PST)
Received: from localhost.localdomain (ip5f5abbfa.dynamic.kabel-deutschland.de. [95.90.187.250])
        by smtp.gmail.com with ESMTPSA id dc8-20020a170906c7c800b008d1dc5f5692sm1928841ejb.76.2023.03.11.23.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 23:32:52 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8192u: dm_shadow_init() is not used
Date:   Sun, 12 Mar 2023 08:32:47 +0100
Message-Id: <20230312073247.9822-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312073247.9822-1-straube.linux@gmail.com>
References: <20230312073247.9822-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function dm_shadow_init() is not used anywhere, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.c | 38 ----------------------------
 drivers/staging/rtl8192u/r8192U_dm.h |  1 -
 2 files changed, 39 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 00fc8fd344db..6a33ca02c3dc 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2859,44 +2859,6 @@ void dm_check_fsync(struct net_device *dev)
 	}
 }
 
-/*-----------------------------------------------------------------------------
- * Function:	dm_shadow_init()
- *
- * Overview:	Store all NIC MAC/BB register content.
- *
- * Input:		NONE
- *
- * Output:		NONE
- *
- * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	05/29/2008	amy		Create Version 0 porting from windows code.
- *
- *---------------------------------------------------------------------------
- */
-void dm_shadow_init(struct net_device *dev)
-{
-	u8	page;
-	u16	offset;
-
-	for (page = 0; page < 5; page++)
-		for (offset = 0; offset < 256; offset++) {
-			read_nic_byte(dev, offset + page * 256, &dm_shadow[page][offset]);
-			/*DbgPrint("P-%d/O-%02x=%02x\r\n", page, offset, DM_Shadow[page][offset]);*/
-		}
-
-	for (page = 8; page < 11; page++)
-		for (offset = 0; offset < 256; offset++)
-			read_nic_byte(dev, offset + page * 256, &dm_shadow[page][offset]);
-
-	for (page = 12; page < 15; page++)
-		for (offset = 0; offset < 256; offset++)
-			read_nic_byte(dev, offset + page * 256, &dm_shadow[page][offset]);
-
-}   /* dm_shadow_init */
-
 /*---------------------------Define function prototype------------------------*/
 /*-----------------------------------------------------------------------------
  * Function:	DM_DynamicTxPower()
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 2159018b4e38..f4eb18216677 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -168,7 +168,6 @@ void dm_rf_operation_test_callback(unsigned long data);
 void dm_rf_pathcheck_workitemcallback(struct work_struct *work);
 void dm_fsync_work_callback(struct work_struct *work);
 void dm_cck_txpower_adjust(struct net_device *dev, bool  binch14);
-void dm_shadow_init(struct net_device *dev);
 void dm_initialize_txpower_tracking(struct net_device *dev);
 /*--------------------------Exported Function prototype---------------------*/
 
-- 
2.39.2

