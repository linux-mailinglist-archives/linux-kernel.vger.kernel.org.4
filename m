Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A84563086D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiKSBYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSBW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:22:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098C853ED0;
        Fri, 18 Nov 2022 16:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668817435; x=1700353435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ELa4VyMmQa46ud+bAWUmad6+rz+mYWn3kNZACRLGq+Q=;
  b=iLjcAyDR8XeDWrZVfym+9vtqAjSJxuHZyJEuuoXsF8muuTk2Bi07Y39M
   BwwtmJ+SKknhy6V6Jojs2jbtVs5tUnm8erXHGMNw6hbCsuYe/CXSFsCnF
   DUpSVhOEMd8yKpUDgce4BNIslo7jZ9qXfjKW17wqGt4+66IkIuFpUUkGx
   4xIc9dwxw3+7hh90Bpqr7XY0cs7tHYiYizABx46YAXd27cmMSLIFUiN9Z
   0Auxv3TiBhF3sTiO5656aqZ+NCc/OZY8szlLkeZKpDuiW4llMweK8FJdu
   rdC5pxC9pHwrcwqOytaFa+nRAgH/ZG1BPJ7xXEvvp8wY+UXYHu7h0jaDe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="314418975"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="314418975"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 16:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="765349184"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="765349184"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 18 Nov 2022 16:23:47 -0800
Received: from debox1-desk4.lan (unknown [10.252.138.169])
        by linux.intel.com (Postfix) with ESMTP id F3A20580A6C;
        Fri, 18 Nov 2022 16:23:46 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 9/9] tools/arch/x86: intel_sdsi: Add support for reading meter certificates
Date:   Fri, 18 Nov 2022 16:23:43 -0800
Message-Id: <20221119002343.1281885-10-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221119002343.1281885-1-david.e.box@linux.intel.com>
References: <20221119002343.1281885-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option to read and decode On Demand meter certificates.

Link: https://github.com/intel/intel-sdsi/blob/master/meter-certificate.rst

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

V2 - Use separate cases for state and meter switch options.

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 110 ++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index b42e1b6a6a1b..2cd92761f171 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -40,8 +40,10 @@
 #define GUID_V2			0xF210D9EF
 #define REGS_SIZE_GUID_V2	80
 #define STATE_CERT_MAX_SIZE	4096
+#define METER_CERT_MAX_SIZE	4096
 #define STATE_MAX_NUM_LICENSES	16
 #define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
+#define METER_MAX_NUM_BUNDLES	8
 
 #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
 #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
@@ -151,6 +153,21 @@ struct bundle_encoding {
 	uint32_t encoding_rsvd[7];
 };
 
+struct meter_certificate {
+	uint32_t block_signature;
+	uint32_t counter_unit;
+	uint64_t ppin;
+	uint32_t bundle_length;
+	uint32_t reserved;
+	uint32_t mmrc_encoding;
+	uint32_t mmrc_counter;
+};
+
+struct bundle_encoding_counter {
+	uint32_t encoding;
+	uint32_t counter;
+};
+
 struct sdsi_dev {
 	struct sdsi_regs regs;
 	struct state_certificate sc;
@@ -161,6 +178,7 @@ struct sdsi_dev {
 
 enum command {
 	CMD_SOCKET_INFO,
+	CMD_METER_CERT,
 	CMD_STATE_CERT,
 	CMD_PROV_AKC,
 	CMD_PROV_CAP,
@@ -308,6 +326,86 @@ static void get_feature(uint32_t encoding, char *feature)
 	feature[0] = name[3];
 }
 
+static int sdsi_meter_cert_show(struct sdsi_dev *s)
+{
+	char buf[METER_CERT_MAX_SIZE] = {0};
+	struct bundle_encoding_counter *bec;
+	struct meter_certificate *mc;
+	uint32_t count = 0;
+	FILE *cert_ptr;
+	int ret, size;
+
+	ret = sdsi_update_registers(s);
+	if (ret)
+		return ret;
+
+	if (!s->regs.en_features.sdsi) {
+		fprintf(stderr, "SDSi feature is present but not enabled.\n");
+		fprintf(stderr, " Unable to read meter certificate\n");
+		return -1;
+	}
+
+	if (!s->regs.en_features.metering) {
+		fprintf(stderr, "Metering not supporting on this socket.\n");
+		return -1;
+	}
+
+	ret = chdir(s->dev_path);
+	if (ret == -1) {
+		perror("chdir");
+		return ret;
+	}
+
+	cert_ptr = fopen("meter_certificate", "r");
+	if (!cert_ptr) {
+		perror("Could not open 'meter_certificate' file");
+		return -1;
+	}
+
+	size = fread(buf, 1, sizeof(buf), cert_ptr);
+	if (!size) {
+		fprintf(stderr, "Could not read 'meter_certificate' file\n");
+		fclose(cert_ptr);
+		return -1;
+	}
+	fclose(cert_ptr);
+
+	mc = (struct meter_certificate *)buf;
+
+	printf("\n");
+	printf("Meter certificate for device %s\n", s->dev_name);
+	printf("\n");
+	printf("Block Signature:       0x%x\n", mc->block_signature);
+	printf("Count Unit:            %dms\n", mc->counter_unit);
+	printf("PPIN:                  0x%lx\n", mc->ppin);
+	printf("Feature Bundle Length: %d\n", mc->bundle_length);
+	printf("MMRC encoding:         %d\n", mc->mmrc_encoding);
+	printf("MMRC counter:          %d\n", mc->mmrc_counter);
+	if (mc->bundle_length % 8) {
+		fprintf(stderr, "Invalid bundle length\n");
+		return -1;
+	}
+
+	if (mc->bundle_length > METER_MAX_NUM_BUNDLES * 8)  {
+		fprintf(stderr, "More than %d bundles: %d\n",
+			METER_MAX_NUM_BUNDLES, mc->bundle_length / 8);
+		return -1;
+	}
+
+	bec = (void *)(mc) + sizeof(mc);
+
+	printf("Number of Feature Counters:          %d\n", mc->bundle_length / 8);
+	while (count++ < mc->bundle_length / 8) {
+		char feature[5];
+
+		feature[4] = '\0';
+		get_feature(bec[count].encoding, feature);
+		printf("    %s:          %d\n", feature, bec[count].counter);
+	}
+
+	return 0;
+}
+
 static int sdsi_state_cert_show(struct sdsi_dev *s)
 {
 	char buf[STATE_CERT_MAX_SIZE] = {0};
@@ -627,7 +725,7 @@ static void sdsi_free_dev(struct sdsi_dev *s)
 
 static void usage(char *prog)
 {
-	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-a FILE] [-c FILE]]\n", prog);
+	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-m] [-a FILE] [-c FILE]]\n", prog);
 }
 
 static void show_help(void)
@@ -637,6 +735,7 @@ static void show_help(void)
 	printf("  %-18s\t%s\n", "-d, --devno DEVNO",    "On Demand device number");
 	printf("  %-18s\t%s\n", "-i, --info",           "show socket information");
 	printf("  %-18s\t%s\n", "-s, --state",          "show state certificate");
+	printf("  %-18s\t%s\n", "-m, --meter",          "show meter certificate");
 	printf("  %-18s\t%s\n", "-a, --akc FILE",       "provision socket with AKC FILE");
 	printf("  %-18s\t%s\n", "-c, --cap FILE>",      "provision socket with CAP FILE");
 }
@@ -658,6 +757,7 @@ int main(int argc, char *argv[])
 		{"help",	no_argument,		0, 'h'},
 		{"info",	no_argument,		0, 'i'},
 		{"list",	no_argument,		0, 'l'},
+		{"meter",	no_argument,		0, 'm'},
 		{"state",	no_argument,		0, 's'},
 		{0,		0,			0, 0 }
 	};
@@ -665,7 +765,7 @@ int main(int argc, char *argv[])
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+a:c:d:hils", long_options,
+	while ((opt = getopt_long_only(argc, argv, "+a:c:d:hilms", long_options,
 			&option_index)) != -1) {
 		switch (opt) {
 		case 'd':
@@ -678,6 +778,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			command = CMD_SOCKET_INFO;
 			break;
+		case 'm':
+			command = CMD_METER_CERT;
+			break;
 		case 's':
 			command = CMD_STATE_CERT;
 			break;
@@ -715,6 +818,9 @@ int main(int argc, char *argv[])
 		case CMD_SOCKET_INFO:
 			ret = sdsi_read_reg(s);
 			break;
+		case CMD_METER_CERT:
+			ret = sdsi_meter_cert_show(s);
+			break;
 		case CMD_STATE_CERT:
 			ret = sdsi_state_cert_show(s);
 			break;
-- 
2.34.1

