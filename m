Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72070705C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjEQBRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjEQBRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:17:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5844C469A;
        Tue, 16 May 2023 18:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E137460B7A;
        Wed, 17 May 2023 01:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CC1C433D2;
        Wed, 17 May 2023 01:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684286233;
        bh=biYz7ct5sU3QISD2vSXIgOyTlRasPXZBZtOwjhRjsrM=;
        h=Date:From:To:Cc:Subject:From;
        b=saHRChJIGfsafUmuXO023PW74V+JkbgAGVwicIQaN2miLZvt+AmbCh7M8Kwg9wJv6
         LkXO/9sUIb1nGw518+w0XwIqKt/5dbDBS2sXLQ+SUoBKaAeCibJ2zF+DUyOBzJtiqH
         sEC80+Ne2COWpqad3YGPM82fVOlW/8O34MZ8t46YA1LnKzVpnuDhgWL5DpkR+4GiNf
         257i2IutbuZiOSr3YLmvoPH16nRbdhQE/02kPabwwEGXagA9+0HA/AcC36r6d9LE6f
         /Oz2RbaexwN7xK4rllq8MQ9qXdJ6aZtcX81igf6555qO0F1oL2cPpfnHMFQNCzjX78
         CtwFE6/lnp04Q==
Date:   Tue, 16 May 2023 19:18:01 -0600
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
Subject: [PATCH][next] media: venus: hfi_cmds: Replace fake flex-arrays with
 flexible-array members
Message-ID: <ZGQrSQ/zHu+pk7WU@work>
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
members in multiple structures.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/294
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index dd9c5066442d..55dd73ff073b 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -82,7 +82,7 @@ struct hfi_sys_set_buffers_pkt {
 	u32 buffer_type;
 	u32 buffer_size;
 	u32 num_buffers;
-	u32 buffer_addr[1];
+	u32 buffer_addr[];
 };
 
 struct hfi_sys_ping_pkt {
@@ -177,7 +177,7 @@ struct hfi_session_empty_buffer_uncompressed_plane1_pkt {
 	u32 filled_len;
 	u32 offset;
 	u32 packet_buffer2;
-	u32 data[1];
+	u32 data[];
 };
 
 struct hfi_session_empty_buffer_uncompressed_plane2_pkt {
@@ -186,7 +186,7 @@ struct hfi_session_empty_buffer_uncompressed_plane2_pkt {
 	u32 filled_len;
 	u32 offset;
 	u32 packet_buffer3;
-	u32 data[1];
+	u32 data[];
 };
 
 struct hfi_session_fill_buffer_pkt {
@@ -227,7 +227,7 @@ struct hfi_session_release_buffer_pkt {
 	u32 extradata_size;
 	u32 response_req;
 	u32 num_buffers;
-	u32 buffer_info[1];
+	u32 buffer_info[];
 };
 
 struct hfi_session_release_resources_pkt {
-- 
2.34.1

