Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B70F7006EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbjELLgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbjELLgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:36:19 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96738DD9D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:36:18 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso14572557a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683891377; x=1686483377;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gEDwdtST97OS+wBpCtbRghzZcx+X45D0pw7XrLTdoO0=;
        b=KeszkQiGl243RBXq+9kUck6yivFXAraoqlEG1yavSWTP7nhrwyHhcWayX9wx/Lmvnq
         0xHuoAd6ENGRUivyqVVA0Qo9XKD0sf0+OiP/BrjTzvzMwYZKtNEvZv8S545O+rOkPoDd
         AkbInPDYzSnAfM2A6p4b8yEyIwrrn3X0L683bgm/ECLy8f1KTr6YwaeZGLNnRNPR+mF9
         sZHaexMDwO4vvxVv3T0HFRCS9/MQwfb0fAFcAdk4BBQ2OO3gfUWio67jE/NhAT+/eOPS
         CReFpQbXnGV89Rjz0z7z6cjrape32fDKnaNcQtQqOv6WarsdvkPRs3ei9j0W0K6/O7zD
         maow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683891377; x=1686483377;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEDwdtST97OS+wBpCtbRghzZcx+X45D0pw7XrLTdoO0=;
        b=lUtWh3g4Q2ZIGC+UZMAZNkjmS5N5AyriSpxvDPziho6qJMqNtGwlpj/+imXe1lCMRQ
         5Ydli4gvJYywhRmXRnqm2zm/ZZ1adx3BaMXSY0A1aiBCusPfEVy+JsKdkKxiZYqpR4R9
         w/SpFmznrXG6qdf3ZL7OTFmwn0fI9yBJbqUlpFoQGZ8Yy4ip7CgHscc0Gez5dDxfc6vr
         ZKTBS9+jjfG/zzBwfzQcFML9AkVWtfu465AHsKo6SSoKiHgKQHtdL3jO29EscVVeMlJL
         K9VvpRK55BKuc3s6MqJx37ms+RJDmu+PFjGXxTkayRut1fHdyemfGXgSm1m6JYgaIv95
         U4EA==
X-Gm-Message-State: AC+VfDzw5utuI03hr09Q7Eq+phWU4xjoFOouYd95EFNPHXfgdy22++Xa
        i+6bigcLsiZwHKWpikWyD0Cy3L/TdoKagg==
X-Google-Smtp-Source: ACHHUZ76BJ4MK//GHr0jhglXPEwwgjMtwhNu2TtRSZMhTUaNdkewZQvmjURqO4j2ushkBK+uxOTuPg==
X-Received: by 2002:a17:907:9810:b0:969:f677:11b4 with SMTP id ji16-20020a170907981000b00969f67711b4mr12550144ejc.37.1683891376725;
        Fri, 12 May 2023 04:36:16 -0700 (PDT)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id h15-20020a1709067ccf00b0094f23480619sm5329722ejp.172.2023.05.12.04.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 04:36:16 -0700 (PDT)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Fri, 12 May 2023 13:36:10 +0200
Subject: [PATCH v3] w1: Replace usage of found with dedicated list iterator
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-v3-1-e07c9603fd9d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKkkXmQC/62OQQ6CMBBFr2K6dgy0YIIr72FcTMtUJgFKphU0h
 LtbOIPLNz//z1tVJGGK6nZaldDMkcOYwZxPynU4vgi4zax0oU1RFw0sJQhNPTqCd8ScBw8+vMc
 WFk4dpGGCnmMCTiSYgsCMwmh7AldfTWO8L4xpVN63GAms4Oi6/cOAMVf2YBLy/DmkHs/MXd4L8
 j0cZ71f/6EzayhB1431pcWqovb+GpD7iwuDem7b9gO9CSvnGwEAAA==
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683891376; l=2996;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=+UI+tVz26PwhwuM34C+/qr/sCuLSqjgcpHP9rDufqm4=;
 b=6s5lr4qMGmUISgZVjLcPhgtSNyrT9Y3G05LumId2ILyR91ErmJzsDChvW/tMVRDCiPisHpdOom2+
 dMCz8QYfCmOMCz9AG3XFMPXglI1uSGAqtT4i9A89+69zQKZebdtD
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
Changes in v2:
  - fix checkpatch intentation issues

Changes in v3:
  - actually fix checkpatch intentation issues

Note: I've changed my email address to contributions to
jkl820.git@gmail.com, I hope that's not an issue since the v1 was still
on my old email.
---
 drivers/w1/w1.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 9d199fed9628..a5e18de7a25a 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -830,49 +830,47 @@ int w1_slave_detach(struct w1_slave *sl)
 
 struct w1_master *w1_search_master_id(u32 id)
 {
-	struct w1_master *dev;
-	int found = 0;
+	struct w1_master *dev = NULL, *iter;
 
 	mutex_lock(&w1_mlock);
-	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
-		if (dev->id == id) {
-			found = 1;
-			atomic_inc(&dev->refcnt);
+	list_for_each_entry(iter, &w1_masters, w1_master_entry) {
+		if (iter->id == id) {
+			dev = iter;
+			atomic_inc(&iter->refcnt);
 			break;
 		}
 	}
 	mutex_unlock(&w1_mlock);
 
-	return (found)?dev:NULL;
+	return dev;
 }
 
 struct w1_slave *w1_search_slave(struct w1_reg_num *id)
 {
 	struct w1_master *dev;
-	struct w1_slave *sl = NULL;
-	int found = 0;
+	struct w1_slave *sl = NULL, *iter;
 
 	mutex_lock(&w1_mlock);
 	list_for_each_entry(dev, &w1_masters, w1_master_entry) {
 		mutex_lock(&dev->list_mutex);
-		list_for_each_entry(sl, &dev->slist, w1_slave_entry) {
-			if (sl->reg_num.family == id->family &&
-					sl->reg_num.id == id->id &&
-					sl->reg_num.crc == id->crc) {
-				found = 1;
+		list_for_each_entry(iter, &dev->slist, w1_slave_entry) {
+			if (iter->reg_num.family == id->family &&
+			    iter->reg_num.id == id->id &&
+			    iter->reg_num.crc == id->crc) {
+				sl = iter;
 				atomic_inc(&dev->refcnt);
-				atomic_inc(&sl->refcnt);
+				atomic_inc(&iter->refcnt);
 				break;
 			}
 		}
 		mutex_unlock(&dev->list_mutex);
 
-		if (found)
+		if (sl)
 			break;
 	}
 	mutex_unlock(&w1_mlock);
 
-	return (found)?sl:NULL;
+	return sl;
 }
 
 void w1_reconnect_slaves(struct w1_family *f, int attach)

---
base-commit: cc3c44c9fda264c6d401be04e95449a57c1231c6
change-id: 20230509-w1-replace-usage-of-found-with-tmp-list-iterator-variable-c56393ff0339

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

