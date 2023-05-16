Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A9F7058B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjEPUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEPUXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:23:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB8D132;
        Tue, 16 May 2023 13:23:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4360635A2;
        Tue, 16 May 2023 20:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D50C433EF;
        Tue, 16 May 2023 20:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268619;
        bh=pqehcCkjyDBJ2mQ+/BvHGhafgHlU9rCc7eAl+CgbqNE=;
        h=From:To:Cc:Subject:Date:From;
        b=BXL5iFvw0eO0Gt26tpEq15A89OIxyqVuD49h3yjSppz8T98vw8hiSig1lZYLOe9YD
         PMeKQOOQv/sufdyRPXIvEq+y8Ni5+uLZQMp7y/SuO1idzcQ7uLSjoZLBy8lyezYHHV
         Ju+JwxbInRqWfnmexnOc5ewPa80pZweTDf6tWSy+GQ4fs2XRg+02omAp8OrMKlO8UP
         y+mz/gpqNTMpbnb6nBMEhof97q+VcDkEKoXuv06ePkJ15xzhTIBP7oS92DRYbiqj5x
         ooCVBFIb1Rh0/DydJEU2Q3AQVJ2TxHfte2gso3cU1I1j1NtnOhyIANzK7BrOwL9LmE
         qLvOfm7EukRYQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Yogesh Lal <quic_ylal@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: qcom: pas: mark adsp_segment_dump() static
Date:   Tue, 16 May 2023 22:23:17 +0200
Message-Id: <20230516202332.560123-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The function has no other callers and should not be globally defined.
Making it static avoids this warning:

drivers/remoteproc/qcom_q6v5_pas.c:108:6: error: no previous prototype for 'adsp_segment_dump'

Fixes: a376c10d45a8 ("remoteproc: qcom: pas: Adjust the phys addr wrt the mem region")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index e34d82b18a67..a1d69721a0e7 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -105,8 +105,9 @@ struct qcom_adsp {
 	struct qcom_scm_pas_metadata dtb_pas_metadata;
 };
 
-void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
-		       void *dest, size_t offset, size_t size)
+static void adsp_segment_dump(struct rproc *rproc,
+			      struct rproc_dump_segment *segment,
+			      void *dest, size_t offset, size_t size)
 {
 	struct qcom_adsp *adsp = rproc->priv;
 	int total_offset;
-- 
2.39.2

