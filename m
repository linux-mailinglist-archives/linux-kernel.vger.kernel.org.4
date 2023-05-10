Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A5F6FE214
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjEJQEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEJQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:04:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64CD2716;
        Wed, 10 May 2023 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KDPa8btsl2NOG9VQc/thfEj5XH4yR+8CNCHayydE5dw=;
        t=1683734677; x=1684944277; b=vzvuPsdKd71KZQYeElVzaApivw2Kfpl5RaWrEZFPRODjOM0
        2p7cV95+yg89ZmSRdOL/N7C6y/MejksEm4OkwROs6j7D3PIWQjUqXF4rC4+DUpfL0WJl8fN0iDzTk
        sx+oPxdR+YXEqH9uz3P9i9SXwCB5cnZ7YUHPhtuSNI3IbsV4wMSX78wQd2DvDNytHZehb3mqgxsyk
        2rjeke0gd7JG1peXDzOoc+QXBW00Ne0jAonqfxnttmOiYaRUWt0PhwIkTUpF5MvzpoGTMU3DmSQhV
        J5wekvOixoQjtr1TK8M8qag1zdZ5Eaf10+5SpGm8UvHocYwoGEovCkimCC6nwHVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwmIs-005Uq9-0e;
        Wed, 10 May 2023 18:04:34 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 4/4] wifi: cfg80211: move scan done work to cfg80211 workqueue
Date:   Wed, 10 May 2023 18:04:28 +0200
Message-Id: <20230510175846.d92b96f05f12.I0490b5768769e62db2448e3f439cdf8a3c2df892@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510160428.175409-1-johannes@sipsolutions.net>
References: <20230510160428.175409-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Now that we have the cfg80211 workqueue, move the scan_done work
to it as an example.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 1 -
 net/wireless/scan.c | 5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 11e600c71fb6..2908cc4f102e 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1082,7 +1082,6 @@ void wiphy_unregister(struct wiphy *wiphy)
 	 */
 	flush_workqueue(rdev->wq);
 
-	flush_work(&rdev->scan_done_wk);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 790bc31cf82e..6bd919352f55 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1007,9 +1007,7 @@ void __cfg80211_scan_done(struct work_struct *wk)
 	rdev = container_of(wk, struct cfg80211_registered_device,
 			    scan_done_wk);
 
-	wiphy_lock(&rdev->wiphy);
 	___cfg80211_scan_done(rdev, true);
-	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_scan_done(struct cfg80211_scan_request *request,
@@ -1035,7 +1033,8 @@ void cfg80211_scan_done(struct cfg80211_scan_request *request,
 	}
 
 	request->notified = true;
-	queue_work(cfg80211_wq, &wiphy_to_rdev(request->wiphy)->scan_done_wk);
+	wiphy_queue_work(request->wiphy,
+			 &wiphy_to_rdev(request->wiphy)->scan_done_wk);
 }
 EXPORT_SYMBOL(cfg80211_scan_done);
 
-- 
2.40.1

