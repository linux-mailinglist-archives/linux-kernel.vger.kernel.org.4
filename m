Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C7B744AAB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjGARQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGARQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 13:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9961FE8;
        Sat,  1 Jul 2023 10:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618EB60B61;
        Sat,  1 Jul 2023 17:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B676C433C7;
        Sat,  1 Jul 2023 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688231788;
        bh=iuoEM5TLrGLiGT/miHKKQ7Yf7kCvrkAytDld5d1Z1KU=;
        h=Date:From:To:Cc:Subject:From;
        b=M7Iw+flUPp5hBxYi22CSg15Dxk6sCTfNhi1Ns6UslhVnTxV4UJfAMk31AKcEHYV+W
         gXP9A2EBaHyUNyEct6lAIu6NHMAqA0CTnWGdGlLciu+G3AEVzqsfWknSCFzYlfx1YH
         iDIeM+4DxecrcPM/L+6eBNJd38syWpf0dQm6ELaupvuY5Hc/SmLl6Q0pDpA5/TyUlT
         ZoULBheBxc/Od+xgkwuKkFv5XXeQwVlMu8ZcT7emKCbK+lkC0a/KIhlCd2go1MUVAN
         okDt0+zkNRAxxw4lXiaLKvNPPp7OjEyMtIt5CAm7Ij4Thqdwa9adScgjEqk8bh7S+z
         fxiVbjJvQFn2Q==
Date:   Sat, 1 Jul 2023 11:17:22 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] media: venus: Use struct_size_t() helper in
 pkt_session_unset_buffers()
Message-ID: <ZKBfoqSl61jfpO2r@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer struct_size_t() over struct_size() when no pointer instance
of the structure type is present.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 7f0802a5518c..3418d2dd9371 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -251,8 +251,8 @@ int pkt_session_unset_buffers(struct hfi_session_release_buffer_pkt *pkt,
 
 		pkt->extradata_size = 0;
 		pkt->shdr.hdr.size =
-			struct_size((struct hfi_session_set_buffers_pkt *)0,
-				    buffer_info, bd->num_buffers);
+			struct_size_t(struct hfi_session_set_buffers_pkt,
+				      buffer_info, bd->num_buffers);
 	}
 
 	pkt->response_req = bd->response_required;
-- 
2.34.1

