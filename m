Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA746FE4DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjEJUMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjEJUMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:12:14 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D0EE6B;
        Wed, 10 May 2023 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=u2CIbnDR2mlWnb5GGVQtIzdYj1rfoIFL22kSR9dz4nw=;
        t=1683749533; x=1684959133; b=x7Dt9lq/aYk/y2FjQxCO3TbBlarht37dXcpGS+rtHYAYLm+
        R7BlcEhaOgEk4AeeQwo6tATQ6nrV8GMWJ+ft0ug/7le/5OEQyf8bqsmbIoBhDl7ZcK+CX2iw3vbNj
        dOu64P+XpNFVJpjyJBe4iZaWVGF1CLd9XSaD111kp5t67NDc2KsACthaxA89WfLJ8HapqHhrg8Pc0
        Ka7WmEPm7PxBFOlr4RRj3viwHQCP2OZgFZ4tbjh0+ah5JhF76sz1KJsEDohmKRivNnX2fkFlUh60K
        t08LwkN7mkQbMRCvO02qMBAyYY8/5fpYPfeKKg9pIP9S4Dmielkw9FYThKjFZdEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwqAT-005aH5-25;
        Wed, 10 May 2023 22:12:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 3/3] wifi: cfg80211: move scan done work to cfg80211 workqueue
Date:   Wed, 10 May 2023 22:12:05 +0200
Message-Id: <20230510220918.dceb0eba07bb.I0490b5768769e62db2448e3f439cdf8a3c2df892@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510201205.308542-1-johannes@sipsolutions.net>
References: <20230510201205.308542-1-johannes@sipsolutions.net>
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
v2:
 - use the new version of the cfg80211 patch
---
 net/wireless/core.c |  3 +--
 net/wireless/core.h |  4 ++--
 net/wireless/scan.c | 14 ++++----------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 357fd5425bff..3671a50796c2 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -517,7 +517,7 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	spin_lock_init(&rdev->bss_lock);
 	INIT_LIST_HEAD(&rdev->bss_list);
 	INIT_LIST_HEAD(&rdev->sched_scan_req_list);
-	INIT_WORK(&rdev->scan_done_wk, __cfg80211_scan_done);
+	wiphy_work_init(&rdev->scan_done_wk, __cfg80211_scan_done);
 	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
 			  cfg80211_dfs_channels_update_work);
 #ifdef CONFIG_CFG80211_WEXT
@@ -1106,7 +1106,6 @@ void wiphy_unregister(struct wiphy *wiphy)
 	 */
 	flush_workqueue(rdev->wq);
 
-	flush_work(&rdev->scan_done_wk);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index adb45fa38acb..cbd864224856 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -75,7 +75,7 @@ struct cfg80211_registered_device {
 	struct sk_buff *scan_msg;
 	struct list_head sched_scan_req_list;
 	time64_t suspend_at;
-	struct work_struct scan_done_wk;
+	struct wiphy_work scan_done_wk;
 
 	struct genl_info *cur_cmd_info;
 
@@ -441,7 +441,7 @@ bool cfg80211_valid_key_idx(struct cfg80211_registered_device *rdev,
 int cfg80211_validate_key_settings(struct cfg80211_registered_device *rdev,
 				   struct key_params *params, int key_idx,
 				   bool pairwise, const u8 *mac_addr);
-void __cfg80211_scan_done(struct work_struct *wk);
+void __cfg80211_scan_done(struct wiphy *wiphy, struct wiphy_work *wk);
 void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 			   bool send_message);
 void cfg80211_add_sched_scan_req(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 790bc31cf82e..752eae5e0a00 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1000,16 +1000,9 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 		nl80211_send_scan_msg(rdev, msg);
 }
 
-void __cfg80211_scan_done(struct work_struct *wk)
+void __cfg80211_scan_done(struct wiphy *wiphy, struct wiphy_work *wk)
 {
-	struct cfg80211_registered_device *rdev;
-
-	rdev = container_of(wk, struct cfg80211_registered_device,
-			    scan_done_wk);
-
-	wiphy_lock(&rdev->wiphy);
-	___cfg80211_scan_done(rdev, true);
-	wiphy_unlock(&rdev->wiphy);
+	___cfg80211_scan_done(wiphy_to_rdev(wiphy), true);
 }
 
 void cfg80211_scan_done(struct cfg80211_scan_request *request,
@@ -1035,7 +1028,8 @@ void cfg80211_scan_done(struct cfg80211_scan_request *request,
 	}
 
 	request->notified = true;
-	queue_work(cfg80211_wq, &wiphy_to_rdev(request->wiphy)->scan_done_wk);
+	wiphy_work_queue(request->wiphy,
+			 &wiphy_to_rdev(request->wiphy)->scan_done_wk);
 }
 EXPORT_SYMBOL(cfg80211_scan_done);
 
-- 
2.40.1

