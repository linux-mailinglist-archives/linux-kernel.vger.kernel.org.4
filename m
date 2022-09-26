Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54D5E96AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 00:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiIYWbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 18:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiIYWbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 18:31:16 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C5829816
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vRsNOKCZLAwYgoti4qQiXscdBfoEDPjv/FY10PWzEqk=; b=JhgD0Cq5GtG9CVwLznNQmi1Szf
        a5jrPrOFmcEZPFY3VxCn2QFgj4dlmctz2ugM3AkHFsXedhkhwxPPUu1IHxmDFyJv46hkaXd2cI7xM
        QokPPRas/DtjR9ShgKsKH/5yp0EXOKo6Xs3mx4TsyOgYrTwCmHSH6diquyHFeeszqnkJD6njj1PDi
        qHXvQ9TcZw1ddVyMInI8KqtLAtINzV4BDJ3jldbkocBKpNcRRQW+sGqcrYPLqhVBtbX+bw+r1sFF8
        +f4wmpvtlz3BK2TOldZhZUyvkI4DTK1Jbp8KvEXYxHLalylAkoYm1N1fMQWZtgdgVcEUuW7aJaTTq
        wliJmm7Q==;
Received: from [177.34.169.227] (helo=bowie..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oca9A-008M6i-15; Mon, 26 Sep 2022 00:30:48 +0200
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Melissa Wen <mwen@igalia.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Cc:     Arthur Grillo <arthur.grillo@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 2/2] drm/tests: Split drm_test_dp_mst_sideband_msg_req_decode into parameterized tests
Date:   Sun, 25 Sep 2022 19:27:19 -0300
Message-Id: <20220925222719.345424-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220925222719.345424-1-mcanal@igalia.com>
References: <20220925222719.345424-1-mcanal@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_test_dp_mst_sideband_msg_req_decode repeats the same test
structure with different parameters. This could be better represented
by parameterized tests, provided by KUnit.

So, convert drm_test_dp_mst_sideband_msg_req_decode into parameterized
tests and make the test's allocations and prints completly managed by KUnit.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 .../gpu/drm/tests/drm_dp_mst_helper_test.c    | 370 ++++++++++++------
 1 file changed, 243 insertions(+), 127 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c b/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
index 12f41881db6b..545beea33e8c 100644
--- a/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_dp_mst_helper_test.c
@@ -5,12 +5,8 @@
  * Copyright (c) 2022 Maíra Canal <mairacanal@riseup.net>
  */
 
-#define PREFIX_STR "[drm_dp_mst_helper]"
-
 #include <kunit/test.h>
 
-#include <linux/random.h>
-
 #include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_print.h>
 
@@ -72,6 +68,217 @@ static void dp_mst_calc_pbn_mode_desc(const struct drm_dp_mst_calc_pbn_mode_test
 KUNIT_ARRAY_PARAM(drm_dp_mst_calc_pbn_mode, drm_dp_mst_calc_pbn_mode_cases,
 		  dp_mst_calc_pbn_mode_desc);
 
+static u8 data[] = { 0xff, 0x00, 0xdd };
+
+struct drm_dp_mst_sideband_msg_req_test {
+	const char *desc;
+	const struct drm_dp_sideband_msg_req_body in;
+};
+
+static const struct drm_dp_mst_sideband_msg_req_test drm_dp_mst_sideband_msg_req_cases[] = {
+	{
+		.desc = "DP_ENUM_PATH_RESOURCES with port number",
+		.in = {
+			.req_type = DP_ENUM_PATH_RESOURCES,
+			.u.port_num.port_number = 5,
+		},
+	},
+	{
+		.desc = "DP_POWER_UP_PHY with port number",
+		.in = {
+			.req_type = DP_POWER_UP_PHY,
+			.u.port_num.port_number = 5,
+		},
+	},
+	{
+		.desc = "DP_POWER_DOWN_PHY with port number",
+		.in = {
+			.req_type = DP_POWER_DOWN_PHY,
+			.u.port_num.port_number = 5,
+		},
+	},
+	{
+		.desc = "DP_ALLOCATE_PAYLOAD with SDP stream sinks",
+		.in = {
+			.req_type = DP_ALLOCATE_PAYLOAD,
+			.u.allocate_payload.number_sdp_streams = 3,
+			.u.allocate_payload.sdp_stream_sink = { 1, 2, 3 },
+		},
+	},
+	{
+		.desc = "DP_ALLOCATE_PAYLOAD with port number",
+		.in = {
+			.req_type = DP_ALLOCATE_PAYLOAD,
+			.u.allocate_payload.port_number = 0xf,
+		},
+	},
+	{
+		.desc = "DP_ALLOCATE_PAYLOAD with VCPI",
+		.in = {
+			.req_type = DP_ALLOCATE_PAYLOAD,
+			.u.allocate_payload.vcpi = 0x7f,
+		},
+	},
+	{
+		.desc = "DP_ALLOCATE_PAYLOAD with PBN",
+		.in = {
+			.req_type = DP_ALLOCATE_PAYLOAD,
+			.u.allocate_payload.pbn = U16_MAX,
+		},
+	},
+	{
+		.desc = "DP_QUERY_PAYLOAD with port number",
+		.in = {
+			.req_type = DP_QUERY_PAYLOAD,
+			.u.query_payload.port_number = 0xf,
+		},
+	},
+	{
+		.desc = "DP_QUERY_PAYLOAD with VCPI",
+		.in = {
+			.req_type = DP_QUERY_PAYLOAD,
+			.u.query_payload.vcpi = 0x7f,
+		},
+	},
+	{
+		.desc = "DP_REMOTE_DPCD_READ with port number",
+		.in = {
+			.req_type = DP_REMOTE_DPCD_READ,
+			.u.dpcd_read.port_number = 0xf,
+		},
+	},
+	{
+		.desc = "DP_REMOTE_DPCD_READ with DPCD address",
+		.in = {
+			.req_type = DP_REMOTE_DPCD_READ,
+			.u.dpcd_read.dpcd_address = 0xfedcb,
+		},
+	},
+	{
+		.desc = "DP_REMOTE_DPCD_READ with max number of bytes",
+		.in = {
+			.req_type = DP_REMOTE_DPCD_READ,
+			.u.dpcd_read.num_bytes = U8_MAX,
+		},
+	},
+	{
+		.desc = "DP_REMOTE_DPCD_WRITE with port number",
+		.in = {
+			.req_type = DP_REMOTE_DPCD_WRITE,
+			.u.dpcd_write.port_number = 0xf,
+		},
+	},
+	{
+		.desc = "DP_REMOTE_DPCD_WRITE with DPCD address",
+		.in = {
+			.req_type = DP_REMOTE_DPCD_WRITE,
+			.u.dpcd_write.dpcd_address = 0xfedcb,
+		},
+	},
+	{
+		.desc = "DP_REMOTE_DPCD_WRITE with data array",
+		.in = {
+			.req_type = DP_REMOTE_DPCD_WRITE,
+			.u.dpcd_write.num_bytes = ARRAY_SIZE(data),
+			.u.dpcd_write.bytes = data,
+		},
+	},
+	{
+		.desc = "DP_REMOTE_I2C_READ with port number",
+		.in = {
+			.req_type = DP_REMOTE_I2C_READ,
+			.u.i2c_read.port_number = 0xf,
+		},
+	},
+	{
+		.desc = "DP_REMOTE_I2C_READ with I2C device ID",
+		.in = {
+			.req_type = DP_REMOTE_I2C_READ,
+			.u.i2c_read.read_i2c_device_id = 0x7f,
+		},
+	},
+	{
+		.desc = "DP_REMOTE_I2C_READ with transactions array",
+		.in = {
+			.req_type = DP_REMOTE_I2C_READ,
+			.u.i2c_read.num_transactions = 3,
+			.u.i2c_read.num_bytes_read = ARRAY_SIZE(data) * 3,
+			.u.i2c_read.transactions = {
+				{ .bytes = data, .num_bytes = ARRAY_SIZE(data), .i2c_dev_id = 0x7f,
+				  .i2c_transaction_delay = 0xf, },
+				{ .bytes = data, .num_bytes = ARRAY_SIZE(data), .i2c_dev_id = 0x7e,
+				  .i2c_transaction_delay = 0xe, },
+				{ .bytes = data, .num_bytes = ARRAY_SIZE(data), .i2c_dev_id = 0x7d,
+				  .i2c_transaction_delay = 0xd, },
+			},
+		},
+	},
+	{
+		.desc = "DP_REMOTE_I2C_WRITE with port number",
+		.in = {
+			.req_type = DP_REMOTE_I2C_WRITE,
+			.u.i2c_write.port_number = 0xf,
+		},
+	},
+	{
+		.desc = "DP_REMOTE_I2C_WRITE with I2C device ID",
+		.in = {
+			.req_type = DP_REMOTE_I2C_WRITE,
+			.u.i2c_write.write_i2c_device_id = 0x7f,
+		},
+	},
+	{
+		.desc = "DP_REMOTE_I2C_WRITE with data array",
+		.in = {
+			.req_type = DP_REMOTE_I2C_WRITE,
+			.u.i2c_write.num_bytes = ARRAY_SIZE(data),
+			.u.i2c_write.bytes = data,
+		},
+	},
+	{
+		.desc = "DP_QUERY_STREAM_ENC_STATUS with stream ID",
+		.in = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+			.u.enc_status.stream_id = 1,
+		},
+	},
+	{
+		.desc = "DP_QUERY_STREAM_ENC_STATUS with client ID",
+		.in = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+			.u.enc_status.client_id = { 0x4f, 0x7f, 0xb4, 0x00, 0x8c, 0x0d, 0x67 },
+		},
+	},
+	{
+		.desc = "DP_QUERY_STREAM_ENC_STATUS with stream event",
+		.in = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+			.u.enc_status.stream_event = 3,
+		},
+	},
+	{
+		.desc = "DP_QUERY_STREAM_ENC_STATUS with valid stream event",
+		.in = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+			.u.enc_status.valid_stream_event = 0,
+		},
+	},
+	{
+		.desc = "DP_QUERY_STREAM_ENC_STATUS with stream behavior",
+		.in = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+			.u.enc_status.stream_behavior = 3,
+		},
+	},
+	{
+		.desc = "DP_QUERY_STREAM_ENC_STATUS with a valid stream behavior",
+		.in = {
+			.req_type = DP_QUERY_STREAM_ENC_STATUS,
+			.u.enc_status.valid_stream_behavior = 1,
+		}
+	},
+};
+
 static bool
 sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
 		       const struct drm_dp_sideband_msg_req_body *out)
@@ -147,41 +354,41 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
 	return true;
 }
 
-static bool
-sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
+static void drm_test_dp_mst_msg_printf(struct drm_printer *p, struct va_format *vaf)
+{
+	struct kunit *test = p->arg;
+
+	kunit_err(test, "%pV", vaf);
+}
+
+static void drm_test_dp_mst_sideband_msg_req_decode(struct kunit *test)
 {
+	const struct drm_dp_mst_sideband_msg_req_test *params = test->param_value;
+	const struct drm_dp_sideband_msg_req_body *in = &params->in;
 	struct drm_dp_sideband_msg_req_body *out;
-	struct drm_printer p = drm_err_printer(PREFIX_STR);
 	struct drm_dp_sideband_msg_tx *txmsg;
-	int i, ret;
-	bool result = true;
+	struct drm_printer p = {
+		.printfn = drm_test_dp_mst_msg_printf,
+		.arg = test
+	};
+	int i;
 
-	out = kzalloc(sizeof(*out), GFP_KERNEL);
-	if (!out)
-		return false;
+	out = kunit_kzalloc(test, sizeof(*out), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, out);
 
-	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
-	if (!txmsg) {
-		kfree(out);
-		return false;
-	}
+	txmsg = kunit_kzalloc(test, sizeof(*txmsg), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, txmsg);
 
 	drm_dp_encode_sideband_req(in, txmsg);
-	ret = drm_dp_decode_sideband_req(txmsg, out);
-	if (ret < 0) {
-		drm_printf(&p, "Failed to decode sideband request: %d\n",
-			   ret);
-		result = false;
-		goto out;
-	}
+	KUNIT_EXPECT_GE_MSG(test, drm_dp_decode_sideband_req(txmsg, out), 0,
+			    "Failed to decode sideband request");
 
 	if (!sideband_msg_req_equal(in, out)) {
-		drm_printf(&p, "Encode/decode failed, expected:\n");
+		KUNIT_FAIL(test, "Encode/decode failed");
+		kunit_err(test, "Expected:");
 		drm_dp_dump_sideband_msg_req_body(in, 1, &p);
-		drm_printf(&p, "Got:\n");
+		kunit_err(test, "Got:");
 		drm_dp_dump_sideband_msg_req_body(out, 1, &p);
-		result = false;
-		goto out;
 	}
 
 	switch (in->req_type) {
@@ -196,112 +403,21 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 		kfree(out->u.i2c_write.bytes);
 		break;
 	}
-
-	/* Clear everything but the req_type for the input */
-	memset(&in->u, 0, sizeof(in->u));
-
-out:
-	kfree(out);
-	kfree(txmsg);
-	return result;
 }
 
-static void drm_test_dp_mst_sideband_msg_req_decode(struct kunit *test)
+static void
+drm_dp_mst_sideband_msg_req_desc(const struct drm_dp_mst_sideband_msg_req_test *t, char *desc)
 {
-	struct drm_dp_sideband_msg_req_body in = { 0 };
-	u8 data[] = { 0xff, 0x0, 0xdd };
-	int i;
-
-	in.req_type = DP_ENUM_PATH_RESOURCES;
-	in.u.port_num.port_number = 5;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-
-	in.req_type = DP_POWER_UP_PHY;
-	in.u.port_num.port_number = 5;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-
-	in.req_type = DP_POWER_DOWN_PHY;
-	in.u.port_num.port_number = 5;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-
-	in.req_type = DP_ALLOCATE_PAYLOAD;
-	in.u.allocate_payload.number_sdp_streams = 3;
-	for (i = 0; i < in.u.allocate_payload.number_sdp_streams; i++)
-		in.u.allocate_payload.sdp_stream_sink[i] = i + 1;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.allocate_payload.port_number = 0xf;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.allocate_payload.vcpi = 0x7f;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.allocate_payload.pbn = U16_MAX;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-
-	in.req_type = DP_QUERY_PAYLOAD;
-	in.u.query_payload.port_number = 0xf;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.query_payload.vcpi = 0x7f;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-
-	in.req_type = DP_REMOTE_DPCD_READ;
-	in.u.dpcd_read.port_number = 0xf;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.dpcd_read.dpcd_address = 0xfedcb;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.dpcd_read.num_bytes = U8_MAX;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-
-	in.req_type = DP_REMOTE_DPCD_WRITE;
-	in.u.dpcd_write.port_number = 0xf;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.dpcd_write.dpcd_address = 0xfedcb;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.dpcd_write.num_bytes = ARRAY_SIZE(data);
-	in.u.dpcd_write.bytes = data;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-
-	in.req_type = DP_REMOTE_I2C_READ;
-	in.u.i2c_read.port_number = 0xf;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.i2c_read.read_i2c_device_id = 0x7f;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.i2c_read.num_transactions = 3;
-	in.u.i2c_read.num_bytes_read = ARRAY_SIZE(data) * 3;
-	for (i = 0; i < in.u.i2c_read.num_transactions; i++) {
-		in.u.i2c_read.transactions[i].bytes = data;
-		in.u.i2c_read.transactions[i].num_bytes = ARRAY_SIZE(data);
-		in.u.i2c_read.transactions[i].i2c_dev_id = 0x7f & ~i;
-		in.u.i2c_read.transactions[i].i2c_transaction_delay = 0xf & ~i;
-	}
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-
-	in.req_type = DP_REMOTE_I2C_WRITE;
-	in.u.i2c_write.port_number = 0xf;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.i2c_write.write_i2c_device_id = 0x7f;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.i2c_write.num_bytes = ARRAY_SIZE(data);
-	in.u.i2c_write.bytes = data;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-
-	in.req_type = DP_QUERY_STREAM_ENC_STATUS;
-	in.u.enc_status.stream_id = 1;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	get_random_bytes(in.u.enc_status.client_id,
-			 sizeof(in.u.enc_status.client_id));
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.enc_status.stream_event = 3;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.enc_status.valid_stream_event = 0;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.enc_status.stream_behavior = 3;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
-	in.u.enc_status.valid_stream_behavior = 1;
-	KUNIT_EXPECT_TRUE(test, sideband_msg_req_encode_decode(&in));
+	strcpy(desc, t->desc);
 }
 
+KUNIT_ARRAY_PARAM(drm_dp_mst_sideband_msg_req, drm_dp_mst_sideband_msg_req_cases,
+		  drm_dp_mst_sideband_msg_req_desc);
+
 static struct kunit_case drm_dp_mst_helper_tests[] = {
 	KUNIT_CASE_PARAM(drm_test_dp_mst_calc_pbn_mode, drm_dp_mst_calc_pbn_mode_gen_params),
-	KUNIT_CASE(drm_test_dp_mst_sideband_msg_req_decode),
+	KUNIT_CASE_PARAM(drm_test_dp_mst_sideband_msg_req_decode,
+			 drm_dp_mst_sideband_msg_req_gen_params),
 	{ }
 };
 
-- 
2.37.3

