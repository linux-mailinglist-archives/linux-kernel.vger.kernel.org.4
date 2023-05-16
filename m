Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D54570588A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjEPUQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEPUQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EFE1BE;
        Tue, 16 May 2023 13:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9BD763D86;
        Tue, 16 May 2023 20:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F241FC433D2;
        Tue, 16 May 2023 20:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268205;
        bh=TX21/LnZTnFYt/KzhqOgAcDna4xbf0dO5gIfq+6X2d0=;
        h=Date:From:To:Cc:Subject:From;
        b=CPkZpwmAyljr5hYRCZp41+IlxyJGnUUUY2PFiF8wDiKwZlCtSQKCOXwYYENGVaQOc
         kvHM0N4e7sd4jRj4SgVz4Or7IWVEZSpj3dKPvEBPPbqIRMKkapVb/VK6dVHdir8CGJ
         Tape4j6t+vE1wKyXLHUPVZaF4P574p+OSCURexJrpvkzU0lqOp6hlJ1WXcBJW4rJig
         MqsWP57fV+6O+HUmAoW5JTGb2UtsyCIXdQDqZdQY8/Q0THfo8oQj5vvCq2WmKognTY
         inkeYx7MhkBfJZYpqb1EfecGvUzuYE2cpc16bIEGu5FMyouEuCR/PZNwdrxc+TsgDf
         lXKzkYBdIN+8Q==
Date:   Tue, 16 May 2023 14:17:32 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] media: venus: Replace one-element arrays with
 flexible-array members
Message-ID: <ZGPk3PpvYzjD1+0/@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element arrays with flexible-array
members in multiple structures, and refactor the rest of the code,
accordingly.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/291
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_msgs.c |  4 ++--
 drivers/media/platform/qcom/venus/hfi_msgs.h | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index df96db3761a7..6efd78606d9b 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -233,7 +233,7 @@ static void hfi_sys_init_done(struct venus_core *core, struct venus_inst *inst,
 		goto done;
 	}
 
-	rem_bytes = pkt->hdr.size - sizeof(*pkt) + sizeof(u32);
+	rem_bytes = pkt->hdr.size - sizeof(*pkt);
 	if (rem_bytes <= 0) {
 		/* missing property data */
 		error = HFI_ERR_SYS_INSUFFICIENT_RESOURCES;
@@ -434,7 +434,7 @@ static void hfi_session_init_done(struct venus_core *core,
 	if (!IS_V1(core))
 		goto done;
 
-	rem_bytes = pkt->shdr.hdr.size - sizeof(*pkt) + sizeof(u32);
+	rem_bytes = pkt->shdr.hdr.size - sizeof(*pkt);
 	if (rem_bytes <= 0) {
 		error = HFI_ERR_SESSION_INSUFFICIENT_RESOURCES;
 		goto done;
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.h b/drivers/media/platform/qcom/venus/hfi_msgs.h
index 510513697335..8c2e17b0d36f 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.h
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.h
@@ -50,7 +50,7 @@ struct hfi_msg_event_notify_pkt {
 	u32 event_id;
 	u32 event_data1;
 	u32 event_data2;
-	u32 ext_event_data[1];
+	u32 ext_event_data[];
 };
 
 struct hfi_msg_event_release_buffer_ref_pkt {
@@ -63,7 +63,7 @@ struct hfi_msg_sys_init_done_pkt {
 	struct hfi_pkt_hdr hdr;
 	u32 error_type;
 	u32 num_properties;
-	u32 data[1];
+	u32 data[];
 };
 
 struct hfi_msg_sys_pc_prep_done_pkt {
@@ -81,7 +81,7 @@ struct hfi_msg_session_init_done_pkt {
 	struct hfi_session_hdr_pkt shdr;
 	u32 error_type;
 	u32 num_properties;
-	u32 data[1];
+	u32 data[];
 };
 
 struct hfi_msg_session_end_done_pkt {
@@ -228,7 +228,7 @@ struct hfi_msg_session_parse_sequence_header_done_pkt {
 	struct hfi_session_hdr_pkt shdr;
 	u32 error_type;
 	u32 num_properties;
-	u32 data[1];
+	u32 data[];
 };
 
 struct hfi_msg_session_property_info_pkt {
@@ -247,7 +247,7 @@ struct hfi_msg_session_release_buffers_done_pkt {
 	struct hfi_session_hdr_pkt shdr;
 	u32 error_type;
 	u32 num_buffers;
-	u32 buffer_info[1];
+	u32 buffer_info[];
 };
 
 struct hfi_msg_sys_debug_pkt {
@@ -256,7 +256,7 @@ struct hfi_msg_sys_debug_pkt {
 	u32 msg_size;
 	u32 time_stamp_hi;
 	u32 time_stamp_lo;
-	u8 msg_data[1];
+	u8 msg_data[];
 };
 
 struct hfi_msg_sys_coverage_pkt {
@@ -264,7 +264,7 @@ struct hfi_msg_sys_coverage_pkt {
 	u32 msg_size;
 	u32 time_stamp_hi;
 	u32 time_stamp_lo;
-	u8 msg_data[1];
+	u8 msg_data[];
 };
 
 struct venus_core;
-- 
2.34.1

