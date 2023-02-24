Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B526A1C04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjBXMST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBXMSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:18:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9055D45C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677241097; x=1708777097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qcqcS60w/GcK63CF6bpBLMPCivlaNmvCj1bpX8DfmdY=;
  b=c6wrX2ykj6Kc7mOTlAbJ7WKIxMW24nXIfb9K+ocs23OlV3PInFEx2Rd8
   w/saxJ5pkWOayypRrcbZq4gDiZHYKlfS1DQ5qUoj589VlBjSM1EsVOnL6
   3HAS9ytIL8FuMpmOOPUN+CxAVXlXxv4ftKLgaUVfd+oFvO+h0wloHfXhG
   KhakumzY28K6owFf0ZIcoHZL/4b66O/R7cNQYJgyLY0lEx01f2LerXjPd
   RbEYYCfuEG2LXkTXDJ5E0viwYy7yMeffU2rqomrnZaxLQwiH8dvco8V0+
   qK4YACixexTrHLDyNLO4S8u/xjW6dfMsVKzJVcXtsDPo+BKFBkIGx2VBe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="332148342"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="332148342"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 04:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="761766565"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="761766565"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Feb 2023 04:18:15 -0800
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH] firmware_loader: Add debug message with checksum for FW file
Date:   Fri, 24 Feb 2023 21:19:18 +0100
Message-Id: <20230224201918.411492-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 drivers/base/firmware_loader/main.c | 45 ++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 017c4cdb219e..a6e1fb10763d 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -791,6 +791,47 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 	mutex_unlock(&fw_lock);
 }
 
+#if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
+#include <crypto/hash.h>
+#include <crypto/sha2.h>
+#define SHA256_STRING_SIZE (SHA256_DIGEST_SIZE * 2)
+static void fw_log_firmware_info(const struct firmware *fw, const char *name, struct device *device)
+{
+	char outbuf[SHA256_STRING_SIZE + 1];
+	u8 sha256buf[SHA256_DIGEST_SIZE];
+	struct shash_desc *shash;
+	struct crypto_shash *alg;
+
+	alg = crypto_alloc_shash("sha256", 0, 0);
+	if (!alg)
+		return;
+
+	shash = kmalloc(sizeof(*shash) + crypto_shash_descsize(alg), GFP_KERNEL);
+	if (!shash)
+		goto out_alg;
+
+	shash->tfm = alg;
+
+	if (crypto_shash_digest(shash, fw->data, fw->size, sha256buf) < 0)
+		goto out_shash;
+
+	for (int i = 0; i < SHA256_DIGEST_SIZE; i++)
+		sprintf(&outbuf[i * 2], "%02x", sha256buf[i]);
+	outbuf[SHA256_STRING_SIZE] = 0;
+	dev_dbg(device, "Loaded FW: %s, sha256: %s\n", name, outbuf);
+
+out_shash:
+	kfree(shash);
+out_alg:
+	crypto_free_shash(alg);
+
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
@@ -861,11 +902,13 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
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

