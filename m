Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884415E65B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiIVOdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiIVOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:32:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8829F687B;
        Thu, 22 Sep 2022 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663857164; x=1695393164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m0k1uCWvKD1qu8Nl1WMkEETMJOrIcUHWxejziJSkE+Y=;
  b=RGKRv8bTaf18CtnQ7QVrkV7KoHTgEPMndBdRD4vzOa1akJhXzOHqoZun
   zw2jMPS5qv1GmQfDJCz38WIyi7hg4IiAILmwtLIM2VIUlDlkCOq5PmdiQ
   yQraE+5DXts7+rrUrimzdfNXYIaREpE9D/3Lkzh9cBrIIXwK4zR/eFBkL
   ZRu8Jh67T3OSbs6opW1UPY8ezTF6ntSkGWxjTEy1DDbHKCbkcLJhy9csc
   JSDddUnwXr3NCmHxqIpoE0KJd27e8U2lA1buUA72qCzmU9hdESxGM1jjX
   zgtNCiE54/NNrpsqMgf1999X1VxMIPEMNb6ed6SQVbOiznIewGHRGzmLK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364292466"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="364292466"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 07:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="682235784"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Sep 2022 07:32:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 45ACEF7; Thu, 22 Sep 2022 17:32:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Szuying Chen <Chloe_Chen@asmedia.com.tw>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH v1 1/2] thunderbolt: Convert to use sysfs_emit()/sysfs_emit_at() APIs
Date:   Thu, 22 Sep 2022 17:32:39 +0300
Message-Id: <20220922143240.36878-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the value
to be returned to user space.

While at it, use Elvis operator in some cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thunderbolt/domain.c  | 10 ++++------
 drivers/thunderbolt/retimer.c |  8 ++++----
 drivers/thunderbolt/switch.c  | 28 ++++++++++++++--------------
 drivers/thunderbolt/xdomain.c | 26 +++++++++++++-------------
 4 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 99211f35a5cd..ec7b5f65804e 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -144,11 +144,9 @@ static ssize_t boot_acl_show(struct device *dev, struct device_attribute *attr,
 
 	for (ret = 0, i = 0; i < tb->nboot_acl; i++) {
 		if (!uuid_is_null(&uuids[i]))
-			ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%pUb",
-					&uuids[i]);
+			ret += sysfs_emit_at(buf, ret, "%pUb", &uuids[i]);
 
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s",
-			       i < tb->nboot_acl - 1 ? "," : "\n");
+		ret += sysfs_emit_at(buf, ret, "%s", i < tb->nboot_acl - 1 ? "," : "\n");
 	}
 
 out:
@@ -247,7 +245,7 @@ static ssize_t deauthorization_show(struct device *dev,
 	    tb->security_level == TB_SECURITY_SECURE)
 		deauthorization = !!tb->cm_ops->disapprove_switch;
 
-	return sprintf(buf, "%d\n", deauthorization);
+	return sysfs_emit(buf, "%d\n", deauthorization);
 }
 static DEVICE_ATTR_RO(deauthorization);
 
@@ -270,7 +268,7 @@ static ssize_t security_show(struct device *dev, struct device_attribute *attr,
 	if (tb->security_level < ARRAY_SIZE(tb_security_names))
 		name = tb_security_names[tb->security_level];
 
-	return sprintf(buf, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 static DEVICE_ATTR_RO(security);
 
diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index dd8f033b1690..81252e31014a 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -162,7 +162,7 @@ static ssize_t device_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_retimer *rt = tb_to_retimer(dev);
 
-	return sprintf(buf, "%#x\n", rt->device);
+	return sysfs_emit(buf, "%#x\n", rt->device);
 }
 static DEVICE_ATTR_RO(device);
 
@@ -180,7 +180,7 @@ static ssize_t nvm_authenticate_show(struct device *dev,
 	else if (rt->no_nvm_upgrade)
 		ret = -EOPNOTSUPP;
 	else
-		ret = sprintf(buf, "%#x\n", rt->auth_status);
+		ret = sysfs_emit(buf, "%#x\n", rt->auth_status);
 
 	mutex_unlock(&rt->tb->lock);
 
@@ -255,7 +255,7 @@ static ssize_t nvm_version_show(struct device *dev,
 	if (!rt->nvm)
 		ret = -EAGAIN;
 	else
-		ret = sprintf(buf, "%x.%x\n", rt->nvm->major, rt->nvm->minor);
+		ret = sysfs_emit(buf, "%x.%x\n", rt->nvm->major, rt->nvm->minor);
 
 	mutex_unlock(&rt->tb->lock);
 	return ret;
@@ -267,7 +267,7 @@ static ssize_t vendor_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_retimer *rt = tb_to_retimer(dev);
 
-	return sprintf(buf, "%#x\n", rt->vendor);
+	return sysfs_emit(buf, "%#x\n", rt->vendor);
 }
 static DEVICE_ATTR_RO(vendor);
 
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 23c6e00ee7b5..b666cc7f5e4e 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1694,7 +1694,7 @@ static ssize_t authorized_show(struct device *dev,
 {
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	return sprintf(buf, "%u\n", sw->authorized);
+	return sysfs_emit(buf, "%u\n", sw->authorized);
 }
 
 static int disapprove_switch(struct device *dev, void *not_used)
@@ -1804,7 +1804,7 @@ static ssize_t boot_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	return sprintf(buf, "%u\n", sw->boot);
+	return sysfs_emit(buf, "%u\n", sw->boot);
 }
 static DEVICE_ATTR_RO(boot);
 
@@ -1813,7 +1813,7 @@ static ssize_t device_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	return sprintf(buf, "%#x\n", sw->device);
+	return sysfs_emit(buf, "%#x\n", sw->device);
 }
 static DEVICE_ATTR_RO(device);
 
@@ -1822,7 +1822,7 @@ device_name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	return sprintf(buf, "%s\n", sw->device_name ? sw->device_name : "");
+	return sysfs_emit(buf, "%s\n", sw->device_name ?: "");
 }
 static DEVICE_ATTR_RO(device_name);
 
@@ -1831,7 +1831,7 @@ generation_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	return sprintf(buf, "%u\n", sw->generation);
+	return sysfs_emit(buf, "%u\n", sw->generation);
 }
 static DEVICE_ATTR_RO(generation);
 
@@ -1845,9 +1845,9 @@ static ssize_t key_show(struct device *dev, struct device_attribute *attr,
 		return restart_syscall();
 
 	if (sw->key)
-		ret = sprintf(buf, "%*phN\n", TB_SWITCH_KEY_SIZE, sw->key);
+		ret = sysfs_emit(buf, "%*phN\n", TB_SWITCH_KEY_SIZE, sw->key);
 	else
-		ret = sprintf(buf, "\n");
+		ret = sysfs_emit(buf, "\n");
 
 	mutex_unlock(&sw->tb->lock);
 	return ret;
@@ -1892,7 +1892,7 @@ static ssize_t speed_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	return sprintf(buf, "%u.0 Gb/s\n", sw->link_speed);
+	return sysfs_emit(buf, "%u.0 Gb/s\n", sw->link_speed);
 }
 
 /*
@@ -1907,7 +1907,7 @@ static ssize_t lanes_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	return sprintf(buf, "%u\n", sw->link_width);
+	return sysfs_emit(buf, "%u\n", sw->link_width);
 }
 
 /*
@@ -1924,7 +1924,7 @@ static ssize_t nvm_authenticate_show(struct device *dev,
 	u32 status;
 
 	nvm_get_auth_status(sw, &status);
-	return sprintf(buf, "%#x\n", status);
+	return sysfs_emit(buf, "%#x\n", status);
 }
 
 static ssize_t nvm_authenticate_sysfs(struct device *dev, const char *buf,
@@ -2033,7 +2033,7 @@ static ssize_t nvm_version_show(struct device *dev,
 	else if (!sw->nvm)
 		ret = -EAGAIN;
 	else
-		ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);
+		ret = sysfs_emit(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);
 
 	mutex_unlock(&sw->tb->lock);
 
@@ -2046,7 +2046,7 @@ static ssize_t vendor_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	return sprintf(buf, "%#x\n", sw->vendor);
+	return sysfs_emit(buf, "%#x\n", sw->vendor);
 }
 static DEVICE_ATTR_RO(vendor);
 
@@ -2055,7 +2055,7 @@ vendor_name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	return sprintf(buf, "%s\n", sw->vendor_name ? sw->vendor_name : "");
+	return sysfs_emit(buf, "%s\n", sw->vendor_name ?: "");
 }
 static DEVICE_ATTR_RO(vendor_name);
 
@@ -2064,7 +2064,7 @@ static ssize_t unique_id_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_switch *sw = tb_to_switch(dev);
 
-	return sprintf(buf, "%pUb\n", sw->uuid);
+	return sysfs_emit(buf, "%pUb\n", sw->uuid);
 }
 static DEVICE_ATTR_RO(unique_id);
 
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index dcee91f25075..bbb248a2686f 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -877,7 +877,7 @@ static ssize_t key_show(struct device *dev, struct device_attribute *attr,
 	 * It should be null terminated but anything else is pretty much
 	 * allowed.
 	 */
-	return sprintf(buf, "%*pE\n", (int)strlen(svc->key), svc->key);
+	return sysfs_emit(buf, "%*pE\n", (int)strlen(svc->key), svc->key);
 }
 static DEVICE_ATTR_RO(key);
 
@@ -903,7 +903,7 @@ static ssize_t prtcid_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_service *svc = container_of(dev, struct tb_service, dev);
 
-	return sprintf(buf, "%u\n", svc->prtcid);
+	return sysfs_emit(buf, "%u\n", svc->prtcid);
 }
 static DEVICE_ATTR_RO(prtcid);
 
@@ -912,7 +912,7 @@ static ssize_t prtcvers_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_service *svc = container_of(dev, struct tb_service, dev);
 
-	return sprintf(buf, "%u\n", svc->prtcvers);
+	return sysfs_emit(buf, "%u\n", svc->prtcvers);
 }
 static DEVICE_ATTR_RO(prtcvers);
 
@@ -921,7 +921,7 @@ static ssize_t prtcrevs_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_service *svc = container_of(dev, struct tb_service, dev);
 
-	return sprintf(buf, "%u\n", svc->prtcrevs);
+	return sysfs_emit(buf, "%u\n", svc->prtcrevs);
 }
 static DEVICE_ATTR_RO(prtcrevs);
 
@@ -930,7 +930,7 @@ static ssize_t prtcstns_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_service *svc = container_of(dev, struct tb_service, dev);
 
-	return sprintf(buf, "0x%08x\n", svc->prtcstns);
+	return sysfs_emit(buf, "0x%08x\n", svc->prtcstns);
 }
 static DEVICE_ATTR_RO(prtcstns);
 
@@ -1661,7 +1661,7 @@ static ssize_t device_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_xdomain *xd = container_of(dev, struct tb_xdomain, dev);
 
-	return sprintf(buf, "%#x\n", xd->device);
+	return sysfs_emit(buf, "%#x\n", xd->device);
 }
 static DEVICE_ATTR_RO(device);
 
@@ -1673,7 +1673,7 @@ device_name_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	if (mutex_lock_interruptible(&xd->lock))
 		return -ERESTARTSYS;
-	ret = sprintf(buf, "%s\n", xd->device_name ? xd->device_name : "");
+	ret = sysfs_emit(buf, "%s\n", xd->device_name ?: "");
 	mutex_unlock(&xd->lock);
 
 	return ret;
@@ -1685,7 +1685,7 @@ static ssize_t maxhopid_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_xdomain *xd = container_of(dev, struct tb_xdomain, dev);
 
-	return sprintf(buf, "%d\n", xd->remote_max_hopid);
+	return sysfs_emit(buf, "%d\n", xd->remote_max_hopid);
 }
 static DEVICE_ATTR_RO(maxhopid);
 
@@ -1694,7 +1694,7 @@ static ssize_t vendor_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_xdomain *xd = container_of(dev, struct tb_xdomain, dev);
 
-	return sprintf(buf, "%#x\n", xd->vendor);
+	return sysfs_emit(buf, "%#x\n", xd->vendor);
 }
 static DEVICE_ATTR_RO(vendor);
 
@@ -1706,7 +1706,7 @@ vendor_name_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	if (mutex_lock_interruptible(&xd->lock))
 		return -ERESTARTSYS;
-	ret = sprintf(buf, "%s\n", xd->vendor_name ? xd->vendor_name : "");
+	ret = sysfs_emit(buf, "%s\n", xd->vendor_name ?: "");
 	mutex_unlock(&xd->lock);
 
 	return ret;
@@ -1718,7 +1718,7 @@ static ssize_t unique_id_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_xdomain *xd = container_of(dev, struct tb_xdomain, dev);
 
-	return sprintf(buf, "%pUb\n", xd->remote_uuid);
+	return sysfs_emit(buf, "%pUb\n", xd->remote_uuid);
 }
 static DEVICE_ATTR_RO(unique_id);
 
@@ -1727,7 +1727,7 @@ static ssize_t speed_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_xdomain *xd = container_of(dev, struct tb_xdomain, dev);
 
-	return sprintf(buf, "%u.0 Gb/s\n", xd->link_speed);
+	return sysfs_emit(buf, "%u.0 Gb/s\n", xd->link_speed);
 }
 
 static DEVICE_ATTR(rx_speed, 0444, speed_show, NULL);
@@ -1738,7 +1738,7 @@ static ssize_t lanes_show(struct device *dev, struct device_attribute *attr,
 {
 	struct tb_xdomain *xd = container_of(dev, struct tb_xdomain, dev);
 
-	return sprintf(buf, "%u\n", xd->link_width);
+	return sysfs_emit(buf, "%u\n", xd->link_width);
 }
 
 static DEVICE_ATTR(rx_lanes, 0444, lanes_show, NULL);
-- 
2.35.1

