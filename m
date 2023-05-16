Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9F7705B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjEPXN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjEPXNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB1776AC;
        Tue, 16 May 2023 16:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E22976353D;
        Tue, 16 May 2023 23:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEBDC433EF;
        Tue, 16 May 2023 23:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684278819;
        bh=ojFglRzZiKwXiqGnsWelyrmIMH1NnaD8AsZ7Wnf3niE=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=t5U7Yyk6479dQQEpLnOeyQ6rFAMBTkM4YJjSvLR0anyUjoJQm24IHqLG3DM+kJ5LM
         XbPKttG8ckt06eFvVEfm1cSTN98GHa15hI373WCRI3kImxceyyJEj82gr2cPUqjx7V
         wsh+Mc4CXX8KVxXM9BAFBTQfJ3x3ZhSrQ8SMUYOOysnZlQ5C/T4ru4Xk1zFGB80l5f
         srkPfZJNx9vfrUZpPeWOiw4MdavVd56SPxXG3z0PFcpQt0whDGXIMb9g1OuEeVaId5
         ooR4LE1b/ldaSbNtI1KSuuayFXN33aziOOzLnO/p1qvxQgjeUv2tDJltn8z5F4YR06
         d4NaIcfPoYIYQ==
Date:   Tue, 16 May 2023 17:14:27 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/2][next] media: venus: hfi_cmds: Replace one-element array
 with flexible-array member
Message-ID: <e4b13d7b79d1477e775c6d4564f7b23c4cf967f2.1684278538.git.gustavoars@kernel.org>
References: <cover.1684278538.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684278538.git.gustavoars@kernel.org>
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
members in struct hfi_session_set_buffers_pkt, and refactor the rest of
the code, accordingly.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/292
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 12 ++++++------
 drivers/media/platform/qcom/venus/hfi_cmds.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index bc3f8ff05840..21d1b3c90dc0 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -200,8 +200,8 @@ int pkt_session_set_buffers(struct hfi_session_set_buffers_pkt *pkt,
 		struct hfi_buffer_info *bi;
 
 		pkt->extradata_size = bd->extradata_size;
-		pkt->shdr.hdr.size = sizeof(*pkt) - sizeof(u32) +
-			(bd->num_buffers * sizeof(*bi));
+		pkt->shdr.hdr.size = sizeof(*pkt) +
+			bd->num_buffers * sizeof(*bi);
 		bi = (struct hfi_buffer_info *)pkt->buffer_info;
 		for (i = 0; i < pkt->num_buffers; i++) {
 			bi->buffer_addr = bd->device_addr;
@@ -210,7 +210,7 @@ int pkt_session_set_buffers(struct hfi_session_set_buffers_pkt *pkt,
 	} else {
 		pkt->extradata_size = 0;
 		pkt->shdr.hdr.size = sizeof(*pkt) +
-			((bd->num_buffers - 1) * sizeof(u32));
+			bd->num_buffers * sizeof(u32);
 		for (i = 0; i < pkt->num_buffers; i++)
 			pkt->buffer_info[i] = bd->device_addr;
 	}
@@ -243,8 +243,8 @@ int pkt_session_unset_buffers(struct hfi_session_release_buffer_pkt *pkt,
 			bi->extradata_addr = bd->extradata_addr;
 		}
 		pkt->shdr.hdr.size =
-				sizeof(struct hfi_session_set_buffers_pkt) -
-				sizeof(u32) + (bd->num_buffers * sizeof(*bi));
+				sizeof(struct hfi_session_set_buffers_pkt) +
+				bd->num_buffers * sizeof(*bi);
 	} else {
 		for (i = 0; i < pkt->num_buffers; i++)
 			pkt->buffer_info[i] = bd->device_addr;
@@ -252,7 +252,7 @@ int pkt_session_unset_buffers(struct hfi_session_release_buffer_pkt *pkt,
 		pkt->extradata_size = 0;
 		pkt->shdr.hdr.size =
 				sizeof(struct hfi_session_set_buffers_pkt) +
-				((bd->num_buffers - 1) * sizeof(u32));
+				bd->num_buffers * sizeof(u32);
 	}
 
 	pkt->response_req = bd->response_required;
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 99bc0b6db67c..ba74d03eb9cd 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -117,7 +117,7 @@ struct hfi_session_set_buffers_pkt {
 	u32 extradata_size;
 	u32 min_buffer_size;
 	u32 num_buffers;
-	u32 buffer_info[1];
+	u32 buffer_info[];
 };
 
 struct hfi_session_get_sequence_header_pkt {
-- 
2.34.1

