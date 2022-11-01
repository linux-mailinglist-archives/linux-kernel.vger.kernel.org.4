Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48FC615202
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiKATLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKATK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:10:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E211C416;
        Tue,  1 Nov 2022 12:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667329858; x=1698865858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmV32OVHi9fb2P0Ej7w8R1hN8TMIjIqdcfI5b5Yocxo=;
  b=EoxOxxFaImcqZbbqPs4Xzk5aLUMLiSZqFqTFsMMJsfsGELJfYOydusTj
   eyAUMq+W1+sf+Ltj4lKMRuuQ9gPz5qn81IH1iIvAii1fYp/CSwUTo79yt
   np0+KlbBA0U+h9juYBjF1fL18RKV7Ibyn87+BJraG2ozn7MWqtLMsBwv1
   Coip9y5ZYktYvlru2ijBTmZMIXeadV7rnj7n7lwgYC1CVfSSGDNG7bK6y
   OT+yRV2Mv8N2rqrA1FiazyD3l092HzX0fyQ0hSMq0gC3aRq2XbOBWC4Mx
   1uwbCcufEUEDV0hIt25SzRM7HF9QKMQFKtjLu7mFj5rPOIuQAoUbuRJYo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="373440772"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="373440772"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 12:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="776605740"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="776605740"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2022 12:10:28 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.195.64])
        by linux.intel.com (Postfix) with ESMTP id 95675580C99;
        Tue,  1 Nov 2022 12:10:27 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] tools/arch/x86: intel_sdsi: Add support for reading meter certificates
Date:   Tue,  1 Nov 2022 12:10:23 -0700
Message-Id: <20221101191023.4150315-10-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101191023.4150315-1-david.e.box@linux.intel.com>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option to read and decode On Demand meter certificates.

Link: https://github.com/intel/intel-sdsi/blob/master/meter-certificate.rst

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 110 ++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 3 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 0680eda78b1a..ebf076ee6ef8 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -39,8 +39,10 @@
 #define GUID_V2			0xF210D9EF
 #define REGISTERS_MIN_SIZE	72
 #define STATE_CERT_MAX_SIZE	4096
+#define METER_CERT_MAX_SIZE	4096
 #define STATE_MAX_NUM_LICENSES	16
 #define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
+#define METER_MAX_NUM_BUNDLES	8
 
 #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
 #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
@@ -150,6 +152,21 @@ struct bundle_encoding {
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
@@ -160,6 +177,7 @@ struct sdsi_dev {
 
 enum command {
 	CMD_SOCKET_INFO,
+	CMD_METER_CERT,
 	CMD_STATE_CERT,
 	CMD_PROV_AKC,
 	CMD_PROV_CAP,
@@ -306,6 +324,86 @@ static void get_feature(uint32_t encoding, char *feature)
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
+		fprintf(stderr, "More the %d bundles: %d\n",
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
@@ -625,7 +723,7 @@ static void sdsi_free_dev(struct sdsi_dev *s)
 
 static void usage(char *prog)
 {
-	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-a FILE] [-c FILE]]\n", prog);
+	printf("Usage: %s [-l] [-d DEVNO [-i] [-s] [-m] [-a FILE] [-c FILE]]\n", prog);
 }
 
 static void show_help(void)
@@ -635,6 +733,7 @@ static void show_help(void)
 	printf("  %-18s\t%s\n", "-d, --devno DEVNO",    "On Demand device number");
 	printf("  %-18s\t%s\n", "-i, --info",           "show socket information");
 	printf("  %-18s\t%s\n", "-s, --state",          "show state certificate");
+	printf("  %-18s\t%s\n", "-m, --meter",          "show meter certificate");
 	printf("  %-18s\t%s\n", "-a, --akc FILE",       "provision socket with AKC FILE");
 	printf("  %-18s\t%s\n", "-c, --cap FILE>",      "provision socket with CAP FILE");
 }
@@ -656,6 +755,7 @@ int main(int argc, char *argv[])
 		{"help",	no_argument,		0, 'h'},
 		{"info",	no_argument,		0, 'i'},
 		{"list",	no_argument,		0, 'l'},
+		{"meter",	no_argument,		0, 'm'},
 		{"state",	no_argument,		0, 's'},
 		{0,		0,			0, 0 }
 	};
@@ -663,7 +763,7 @@ int main(int argc, char *argv[])
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+a:c:d:hils", long_options,
+	while ((opt = getopt_long_only(argc, argv, "+a:c:d:hilms", long_options,
 			&option_index)) != -1) {
 		switch (opt) {
 		case 'd':
@@ -676,8 +776,9 @@ int main(int argc, char *argv[])
 		case 'i':
 			command = CMD_SOCKET_INFO;
 			break;
+		case 'm':
 		case 's':
-			command = CMD_STATE_CERT;
+			command = (opt == 'm') ? CMD_METER_CERT : CMD_STATE_CERT;
 			break;
 		case 'a':
 		case 'c':
@@ -713,6 +814,9 @@ int main(int argc, char *argv[])
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
2.25.1

