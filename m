Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218876E99E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDTQuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDTQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:50:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E6B3A90
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:50:05 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dx24so7726243ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682009403; x=1684601403;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaW8BKnB9AXdJCUm0/4rCDbhYef/y3Ah2np3hfcySj0=;
        b=Phv0EpTIwpZsOfHWQIfO87oCQOymqo1XJxF4sIrfftuwLteJkfNul8LhyYePIGonX6
         KY1ElWxJq6xoLxwtJc2o62yrQtmAl7ADKtnNTkl7gNBZWtKLg+Bwxdt1bR8YtEfcJ0gu
         pTspADy8HzxmS/gGIf0X1JWveEZnvAbj4yTyceyn4lqaV1jvamGmyTu7xrHh0AtxqqQ6
         qoAzpKoNSTUotgb/xit3f/G7NdMHqwdzG06dSgsHZdZ3rzLok+ELGcwy+Zsef2hem7kj
         2RCf7duqMDeYvyapWbsXqOMz0VYE3PCHnAm/S11JAuOxGm28mZpa7N3YeTbDhZOn1h6G
         34uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009403; x=1684601403;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaW8BKnB9AXdJCUm0/4rCDbhYef/y3Ah2np3hfcySj0=;
        b=fpfC+cqh4Zt8fr1Igh5opCa4Scy99JsnCxJ+AamjJKK6QVoeb6etVHqH59XckGgKVF
         s9On24Z7WEXSvjSVekTJE+0JFZgf5M3q/MEdilKb0wAfeLqGyKC5OA/ztcoem/ebIaLu
         Dehp8fE/vIczk0SepI7x2L3EyJrN1zuOWnOGwcgKvZukePwvysm6QINWm/cZ6Ms9f58j
         5vo8OcA43TgUeoQNsrFpzu4OMaOdtkWjcbrkGPAZy00wnmQWVUHhQLjngoPg3pEfOw5l
         f6DmIKN6XYHi/bfkcwCeEF8IsQ1Y58hOJlHYTaZh4H68Ntv2+EYAFYQd0f0arYDNSkCV
         ny4g==
X-Gm-Message-State: AAQBX9fa9fRO7QzSx6PDJyeA09EhPG66ZYvwd3F9PkpWWNQdC2XEcw7K
        n5bOAU56UnY2sAdTT/fMypFLbqomykw=
X-Google-Smtp-Source: AKy350ZLBskg9wFRTTxQZ7ZvJQ14ISyGVukmHxIwnJqVW9I2lLHySE8zwE2noxFNYAAic8dVvDLjLQ==
X-Received: by 2002:a17:907:1ca7:b0:92b:e1ff:be30 with SMTP id nb39-20020a1709071ca700b0092be1ffbe30mr2574322ejc.4.1682009403542;
        Thu, 20 Apr 2023 09:50:03 -0700 (PDT)
Received: from kernelhacking.kernelhacking.example.com (dslb-088-067-245-126.088.067.pools.vodafone-ip.de. [88.67.245.126])
        by smtp.gmail.com with ESMTPSA id og38-20020a1709071de600b0095365e61e9fsm938653ejc.2.2023.04.20.09.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:50:02 -0700 (PDT)
Date:   Thu, 20 Apr 2023 18:50:00 +0200
From:   Luke Koch <lu.ale.koch@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     error27@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: wlan-ng: replace rate macros
Message-ID: <ZEFtOH83frrrireN@kernelhacking.kernelhacking.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change p80211msg_dot11req_scan_results rate members to struct arrays
instead of individually numbered member structs.
Replace macros to set rates with loops to avoid checkpatch warning
and adhere to linux coding style.

Reported by checkpatch:

CHECK: Macro argument reuse 'N' - possible side-effects?

Signed-off-by: Luke Koch <lu.ale.koch@gmail.com>
---
v2: - Fix array underflow and conditions with respect to the start at 0
v3: - Remove unnecessary spaces
v4: - Fix patch formatting
---
 drivers/staging/wlan-ng/p80211metastruct.h | 18 +-------
 drivers/staging/wlan-ng/prism2mgmt.c       | 52 +++++++---------------
 2 files changed, 18 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211metastruct.h b/drivers/staging/wlan-ng/p80211metastruct.h
index 4adc64580185..e963227f797c 100644
--- a/drivers/staging/wlan-ng/p80211metastruct.h
+++ b/drivers/staging/wlan-ng/p80211metastruct.h
@@ -114,22 +114,8 @@ struct p80211msg_dot11req_scan_results {
 	struct p80211item_uint32 cfpollreq;
 	struct p80211item_uint32 privacy;
 	struct p80211item_uint32 capinfo;
-	struct p80211item_uint32 basicrate1;
-	struct p80211item_uint32 basicrate2;
-	struct p80211item_uint32 basicrate3;
-	struct p80211item_uint32 basicrate4;
-	struct p80211item_uint32 basicrate5;
-	struct p80211item_uint32 basicrate6;
-	struct p80211item_uint32 basicrate7;
-	struct p80211item_uint32 basicrate8;
-	struct p80211item_uint32 supprate1;
-	struct p80211item_uint32 supprate2;
-	struct p80211item_uint32 supprate3;
-	struct p80211item_uint32 supprate4;
-	struct p80211item_uint32 supprate5;
-	struct p80211item_uint32 supprate6;
-	struct p80211item_uint32 supprate7;
-	struct p80211item_uint32 supprate8;
+	struct p80211item_uint32 basicrate[8];
+	struct p80211item_uint32 supprate[8];
 } __packed;
 
 struct p80211msg_dot11req_start {
diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index 9030a8939a9b..fc465261baa1 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -437,42 +437,22 @@ int prism2mgmt_scan_results(struct wlandevice *wlandev, void *msgp)
 		if (item->supprates[count] == 0)
 			break;
 
-#define REQBASICRATE(N) \
-	do { \
-		if ((count >= (N)) && DOT11_RATE5_ISBASIC_GET(	\
-			item->supprates[(N) - 1])) { \
-			req->basicrate ## N .data = item->supprates[(N) - 1]; \
-			req->basicrate ## N .status = \
-				P80211ENUM_msgitem_status_data_ok; \
-		} \
-	} while (0)
-
-	REQBASICRATE(1);
-	REQBASICRATE(2);
-	REQBASICRATE(3);
-	REQBASICRATE(4);
-	REQBASICRATE(5);
-	REQBASICRATE(6);
-	REQBASICRATE(7);
-	REQBASICRATE(8);
-
-#define REQSUPPRATE(N) \
-	do { \
-		if (count >= (N)) {					\
-			req->supprate ## N .data = item->supprates[(N) - 1]; \
-			req->supprate ## N .status = \
-				P80211ENUM_msgitem_status_data_ok; \
-		} \
-	} while (0)
-
-	REQSUPPRATE(1);
-	REQSUPPRATE(2);
-	REQSUPPRATE(3);
-	REQSUPPRATE(4);
-	REQSUPPRATE(5);
-	REQSUPPRATE(6);
-	REQSUPPRATE(7);
-	REQSUPPRATE(8);
+	for (int i = 0; i < 8; i++) {
+		if (count > i &&
+		    DOT11_RATE5_ISBASIC_GET(item->supprates[i])) {
+			req->basicrate[i].data = item->supprates[i];
+			req->basicrate[i].status =
+				P80211ENUM_msgitem_status_data_ok;
+		}
+	}
+
+	for (int i = 0; i < 8; i++) {
+		if (count > i) {
+			req->supprate[i].data = item->supprates[i];
+			req->supprate[i].status =
+				P80211ENUM_msgitem_status_data_ok;
+		}
+	}
 
 	/* beacon period */
 	req->beaconperiod.status = P80211ENUM_msgitem_status_data_ok;
-- 
2.34.1

