Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6416E62DB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjDRMf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjDRMf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:35:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B7F1CF82
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:35:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dx24so28740447ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681821354; x=1684413354;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQZiv0UxCp4OymEbsrHftCkO5u8rlnCeM6fO8KZZ7oA=;
        b=lpIZOd1yw9OqgtEP+zkIXVQ9fudmwOeZOBngzOtwLDYvcbWmG4te+hOHcppf6MWK9t
         NAhTBcVx7hcYlMQEoPB/5zLcyB45/m9lxaeYGAxSj/gi4Nb4asRcYDHDos9LSXysI9Ie
         5ixw8nLHHPhOp8AJbKvHiNqfhlTnIMO0qLzuSFKmc7mg81nudUtmodPXf+LIM98bybnP
         fsE/SCq4CpT+F4pKGsSV0OC4jHFWZ2YrKg8ST7Ftr/xtBkETdUxXcPO92IVlMTLCNYR6
         zKesIa+pyecYdDcjvosb7jmlOGmE9agGgsV/1ZY0LjZB/L34TistmkEofPugno0igkba
         zn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681821354; x=1684413354;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQZiv0UxCp4OymEbsrHftCkO5u8rlnCeM6fO8KZZ7oA=;
        b=AH4cFRZ0+hDSJ6WpC0WCEYPypo8VQVhaJ2WN7dI4EKGTLj/QufTtKatncbebRH2CfA
         SE/Z5NB+MGf4StPNCSE5vYEbIGWCVVwzic4KQaDcTy9J9GCQrZ93jgOfau+Gg0etXlPQ
         82f5Xljaexfg1yEEkPdAqgw5L3yIMiGJVmvFx4v7YUnR5cqLa7AOVRKCUYVZ/fEZy24F
         JOF8sIwVButIh8Y8SwCxLcW4DIymnWSvvRAokRP0ylCWtMO6GoFVHSWr61MVf2i8Q9ak
         UgLIND+lViUc9LrCnq/gXTD5SRY8LhtzNY1K9OunLEH/emNqQdG+piJ4tWGFqX+R4XOB
         QWBA==
X-Gm-Message-State: AAQBX9cf/2+nlmpQyAizhJVR1cfzv8hBxXZa3POrRbHHcDTZ0UWePSID
        D78IUj9OHuWpqRfNFeBCJXQ=
X-Google-Smtp-Source: AKy350bMdk0AqUL8HRao0ebs25xi2Gb579h3WyEFVyvdamsQncTRDyYcOzgp3MUqUailsClOEe0nOA==
X-Received: by 2002:a17:906:2b41:b0:930:b130:b7b with SMTP id b1-20020a1709062b4100b00930b1300b7bmr10127624ejg.6.1681821354356;
        Tue, 18 Apr 2023 05:35:54 -0700 (PDT)
Received: from kernelhacking.kernelhacking.example.com (dslb-088-067-245-126.088.067.pools.vodafone-ip.de. [88.67.245.126])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906314600b0094a82a236cbsm7983681eje.129.2023.04.18.05.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 05:35:54 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:35:52 +0200
From:   Luke Koch <lu.ale.koch@gmail.com>
To:     error27@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: wlan-ng: replace rate macros
Message-ID: <ZD6OqBOp1ezQDgMu@kernelhacking.kernelhacking.example.com>
Reply-To: f44f44e4-25c0-4489-96e9-8ca63fa294d7@kili.mountain
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

Signed off by: Luke Koch <lu.ale.koch@gmail.com>
---
v2: - Fix array underflow and conditions with respect to the start at 0
v3: - Remove unnecessary spaces
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

