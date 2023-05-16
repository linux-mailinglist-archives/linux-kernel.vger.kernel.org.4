Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0DF705B11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjEPXOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjEPXOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:14:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D0776B7;
        Tue, 16 May 2023 16:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 779596353D;
        Tue, 16 May 2023 23:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E049C433D2;
        Tue, 16 May 2023 23:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684278840;
        bh=qaUrBJYyxwwKBd2OY03a0I58URs2kzWjK7mA8MAbaNs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=We6kEj/iS+wYQuFQ6YbadjiFGSz9PNkVtATeks2aNWZ4b/s0nHpOeYGVdeB+QoMv/
         ZEgm8y7BP/0iYJeGUlWyGq9RkwgpL2eyi/1Pzd6+Q5g+AQIZRV77yQCv+kibn+wEFo
         YOYe6qZacSRxylsteDg3/DS5GFbuoUFdVjl9x9ptW44T1yxoSuJaKXnViTFzJq4sTP
         vcC5B/qvpuUMLdEPw4rgt8YyRuzN2I2hxgbwseyaoU1XpgMYO5FJaqsWF0BzDiljXp
         kK77kxVG0irXdy1iDpoKix2jzzE8awrzLmQM2o9nvVVZXL5htSBVBr2RKhwcqnOk4Q
         G4zGPIQHjJdnw==
Date:   Tue, 16 May 2023 17:14:49 -0600
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
Subject: [PATCH 2/2][next] media: venus: hfi_cmds: Use struct_size() helper
Message-ID: <fd52d6ddce285474615e4bd96931ab12a0da8199.1684278538.git.gustavoars@kernel.org>
References: <cover.1684278538.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684278538.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer struct_size() over open-coded versions of idiom:

sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count

where count is the max number of items the flexible array is supposed to
contain.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 21d1b3c90dc0..3f74d518ad08 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -209,8 +209,8 @@ int pkt_session_set_buffers(struct hfi_session_set_buffers_pkt *pkt,
 		}
 	} else {
 		pkt->extradata_size = 0;
-		pkt->shdr.hdr.size = sizeof(*pkt) +
-			bd->num_buffers * sizeof(u32);
+		pkt->shdr.hdr.size = struct_size(pkt, buffer_info,
+						 bd->num_buffers);
 		for (i = 0; i < pkt->num_buffers; i++)
 			pkt->buffer_info[i] = bd->device_addr;
 	}
@@ -251,8 +251,8 @@ int pkt_session_unset_buffers(struct hfi_session_release_buffer_pkt *pkt,
 
 		pkt->extradata_size = 0;
 		pkt->shdr.hdr.size =
-				sizeof(struct hfi_session_set_buffers_pkt) +
-				bd->num_buffers * sizeof(u32);
+			struct_size((struct hfi_session_set_buffers_pkt *)0,
+				    buffer_info, bd->num_buffers);
 	}
 
 	pkt->response_req = bd->response_required;
-- 
2.34.1

