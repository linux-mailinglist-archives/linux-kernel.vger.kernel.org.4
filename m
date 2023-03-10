Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5859B6B42B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjCJOGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjCJOFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:05:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516C3112DDE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678457127; x=1709993127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zhuEA1E7XMHriDQ8E6NYA18+POSomu37M3uwwjoBtFc=;
  b=aQme9I63jk08tsP5Swi663qUV1+WEXtEsJzMrLjxCCy8yT85DKE/qXdR
   b3Wo5reGBxSTSuIeoB3hpAToRplB2WNL2wL1hfEyYivmxyatVlRkjOecs
   4bBJOfkONfWL5ad509mc0m0Hm3xEMZ/DRMXfN0tBl+FxOLrgAA2YmXnXT
   I68Zh4MD7CKlOH9TCEjDBMPZi+CP4IbjH4JTXtZI8AMD4s5ibC2jgVaz8
   NI5AFybbOXgFG/UZw7/MDww9LLH6l7sJOAl+xp68DH/09oXVgGmB0hfBs
   y598YdSh/w2PV1+MWeeYl/XYSxlyQBqhboQ+G64AMg/I44V/RiMxEKa5x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="399330874"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="399330874"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 06:05:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="677823873"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="677823873"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga002.jf.intel.com with ESMTP; 10 Mar 2023 06:05:24 -0800
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v4] firmware_loader: Add debug message with checksum for FW file
Date:   Fri, 10 Mar 2023 15:04:59 +0100
Message-Id: <20230310140459.2972793-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable dynamic-debug logging of firmware filenames and SHA256 checksums
to clearly identify the firmware files that are loaded by the system.

Example output:
[   34.944619] firmware_class:_request_firmware: i915 0000:00:02.0: Loaded FW: i915/kbl_dmc_ver1_04.bin, sha256: 2cde41c3e5ad181423bcc3e98ff9c49f743c88f18646af4d0b3c3a9664b831a1
[   48.155884] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/cnl/dsp_basefw.bin, sha256: 43f6ac1b066e9bd0423d914960fbbdccb391af27d2b1da1085eee3ea8df0f357
[   49.579540] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/rt274-tplg.bin, sha256: 4b3580da96dc3d2c443ba20c6728d8b665fceb3ed57223c3a57582bbad8e2413
[   49.798196] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/hda-8086280c-tplg.bin, sha256: 5653172579b2be1b51fd69f5cf46e2bac8d63f2a1327924311c13b2f1fe6e601
[   49.859627] firmware_class:_request_firmware: snd_soc_avs 0000:00:1f.3: Loaded FW: intel/avs/dmic-tplg.bin, sha256: 00fb7fbdb74683333400d7e46925dae60db448b88638efcca0b30215db9df63f

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---

Changes in v4:
 * update menuconfig prompt and help message (Russ)

Changes in v3:
 * add DYNAMIC_DEBUG and FW_LOADER as dependencies before option can be
enabled (kernel test robot)

Changes in v2:
 * allocate buffers (Greg)
 * introduce CONFIG_ option to allow for CONFIG_CRYPTO and CONFIG_CRYPTO_SHA256
dependencies without introducing circular dependency (Greg)
 * add new line between includes and function name (Cezary)

---
 drivers/base/firmware_loader/Kconfig | 13 ++++++++
 drivers/base/firmware_loader/main.c  | 48 +++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 5166b323a0f8..6520e8c9cb38 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -3,6 +3,7 @@ menu "Firmware loader"
 
 config FW_LOADER
 	tristate "Firmware loading facility" if EXPERT
+	select FW_LOADER_DEBUG if DYNAMIC_DEBUG
 	default y
 	help
 	  This enables the firmware loading facility in the kernel. The kernel
@@ -24,6 +25,18 @@ config FW_LOADER
 	  You also want to be sure to enable this built-in if you are going to
 	  enable built-in firmware (CONFIG_EXTRA_FIRMWARE).
 
+config FW_LOADER_DEBUG
+	bool "Log filenames and checksums for loaded firmware"
+	depends on DYNAMIC_DEBUG
+	depends on FW_LOADER
+	depends on CRYPTO
+	depends on CRYPTO_SHA256
+	default FW_LOADER
+	help
+	  Select this option to use dynamic debug to log firmware filenames and
+	  SHA256 checksums to the kernel log for each firmware file that is
+	  loaded.
+
 if FW_LOADER
 
 config FW_LOADER_PAGED_BUF
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 017c4cdb219e..b2c292ca95e8 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -791,6 +791,50 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 	mutex_unlock(&fw_lock);
 }
 
+#if defined(CONFIG_FW_LOADER_DEBUG)
+#include <crypto/hash.h>
+#include <crypto/sha2.h>
+
+static void fw_log_firmware_info(const struct firmware *fw, const char *name, struct device *device)
+{
+	struct shash_desc *shash;
+	struct crypto_shash *alg;
+	u8 *sha256buf;
+	char *outbuf;
+
+	alg = crypto_alloc_shash("sha256", 0, 0);
+	if (!alg)
+		return;
+
+	sha256buf = kmalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
+	outbuf = kmalloc(SHA256_BLOCK_SIZE + 1, GFP_KERNEL);
+	shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(alg), GFP_KERNEL);
+	if (!sha256buf || !outbuf || !shash)
+		goto out_free;
+
+	shash->tfm = alg;
+
+	if (crypto_shash_digest(shash, fw->data, fw->size, sha256buf) < 0)
+		goto out_shash;
+
+	for (int i = 0; i < SHA256_DIGEST_SIZE; i++)
+		sprintf(&outbuf[i * 2], "%02x", sha256buf[i]);
+	outbuf[SHA256_BLOCK_SIZE] = 0;
+	dev_dbg(device, "Loaded FW: %s, sha256: %s\n", name, outbuf);
+
+out_shash:
+	crypto_free_shash(alg);
+out_free:
+	kfree(shash);
+	kfree(outbuf);
+	kfree(sha256buf);
+}
+#else
+static void fw_log_firmware_info(const struct firmware *fw, const char *name,
+				 struct device *device)
+{}
+#endif
+
 /* called from request_firmware() and request_firmware_work_func() */
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
@@ -861,11 +905,13 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	revert_creds(old_cred);
 	put_cred(kern_cred);
 
- out:
+out:
 	if (ret < 0) {
 		fw_abort_batch_reqs(fw);
 		release_firmware(fw);
 		fw = NULL;
+	} else {
+		fw_log_firmware_info(fw, name, device);
 	}
 
 	*firmware_p = fw;
-- 
2.34.1

