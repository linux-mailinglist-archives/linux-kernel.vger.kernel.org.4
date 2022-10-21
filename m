Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF195607FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJUUkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJUUjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:39:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D698043AE1;
        Fri, 21 Oct 2022 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666384792; x=1697920792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VMx26DNuslaQcj8CoS6d3nA3KToG15PN8FrNUlzWMXs=;
  b=P0qx5tnW2fk6Dydel4pPoRIavd/iZjaM3emsi8vEzAxCm9rjIEfIqVPh
   Rd50owHd18Vt2gcQZtUxsmQgBow+fCl3vSUxIit3AUnOTEqxSEZK+zvfx
   IA3kDzPy8XqZOuah51KpehVq6NMRXtnynzaCsENridAwZi53DtNqTz0hF
   HqHSecc4M7tfnlFYAL/ww14WtOtdIjO8+uFFO5uhKjtay2ZcozHTlvote
   kSbNrmQSlDAjcUkGRQO+TkE4JVJTMTGtTRgRnhdiHXqtnupsrCOlj3BsC
   1ZSg6epTEI3RZDJ3ruuPCx4lym62MoF7gRoRqvOf7Lv9n3F3voGj39QPi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369161172"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369161172"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="735700998"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="735700998"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 13:35:33 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com
Subject: [PATCH 02/14] platform/x86/intel/ifs: Propagate load failure error code
Date:   Fri, 21 Oct 2022 13:34:01 -0700
Message-Id: <20221021203413.1220137-3-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221021203413.1220137-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Existing implementation was returning fixed error code to user space
regardless of the load failure encountered.

Modify this to propagate the actual error code to user space.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h   | 2 +-
 drivers/platform/x86/intel/ifs/load.c  | 4 +++-
 drivers/platform/x86/intel/ifs/sysfs.c | 7 +++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 73c8e91cf144..782bcc039ddb 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -225,7 +225,7 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
 	return &d->data;
 }
 
-void ifs_load_firmware(struct device *dev);
+int ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
 const struct attribute_group **ifs_get_groups(void);
 
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index d056617ddc85..ebaa1d6a2b18 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -234,7 +234,7 @@ static bool ifs_image_sanity_check(struct device *dev, const struct microcode_he
  * Load ifs image. Before loading ifs module, the ifs image must be located
  * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
  */
-void ifs_load_firmware(struct device *dev)
+int ifs_load_firmware(struct device *dev)
 {
 	struct ifs_data *ifsd = ifs_get_data(dev);
 	const struct firmware *fw;
@@ -263,4 +263,6 @@ void ifs_load_firmware(struct device *dev)
 	release_firmware(fw);
 done:
 	ifsd->loaded = (ret == 0);
+
+	return ret;
 }
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index 37d8380d6fa8..4af4e1bea98d 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -94,9 +94,8 @@ static ssize_t reload_store(struct device *dev,
 			    struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	struct ifs_data *ifsd = ifs_get_data(dev);
 	bool res;
-
+	int rc;
 
 	if (kstrtobool(buf, &res))
 		return -EINVAL;
@@ -106,11 +105,11 @@ static ssize_t reload_store(struct device *dev,
 	if (down_interruptible(&ifs_sem))
 		return -EINTR;
 
-	ifs_load_firmware(dev);
+	rc = ifs_load_firmware(dev);
 
 	up(&ifs_sem);
 
-	return ifsd->loaded ? count : -ENODEV;
+	return (rc == 0) ? count : rc;
 }
 
 static DEVICE_ATTR_WO(reload);
-- 
2.25.1

