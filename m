Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9A27484C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjGENSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjGENSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:18:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070771712
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:18:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso48325165e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688563126; x=1691155126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NqzFoVlqZuDwdBeJJ7onmWROcWP+Ot6gtGdl2eC6RO8=;
        b=gUabt4/ve2Donhp0sXBcgmdz/tHeUFmWmL0Lom+e1nOg5zE4ae1XOMOe0QBwxBO5wI
         1dIMgLF9R77E5ea6KSF5orZpSJOWqmxWemJTRd/bSY7hryxOMsE9QTYddZhrWPBo87D7
         Qkdpcf+FxgdEWTGteSrjaRWK78i8ZViWAzFhdmhmgxc8K90Lhl4YjBHHxsPN8/wIOecn
         gMTsB5Tr2nj9NI0vY/udOBI2380OJuGaWMPfTj+Rx6Y/OSFxx/KxzwRDS/qN/qq3btg7
         8i40il+M5P8Vbwxk8eds3tIaj3H86465/ckbZlOdD1b2nFUbmxK4YCpfak8UfIYySvg2
         oN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688563126; x=1691155126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqzFoVlqZuDwdBeJJ7onmWROcWP+Ot6gtGdl2eC6RO8=;
        b=QWlyiEHCM65XFD2Y7efFdeX5PS0Tu7ZT5YWH45eh9QBUZQy4dwN5a7dpd4Yxxf8qiy
         0dkB5iSVhybtgLUBzphSjkB9ckI7EEFy7ziBK8nxFrmn1EDhj+6Cw9RXhh74YYOOnCpn
         +YyackiqrMdgs1Ew92Q89kwN85Fc3lqw4toa8N9fne8DwR57QlsHE1TvfeHdm5GrThJW
         5KpN02B/4PxQZqsRUIob9PgtyAoSC2Qa01NFPbA21yUYfEuWArM01wVlWgsP3OjTHkhb
         QNjW29Q+H/4rJzwdHPL8LTtaMlISV8P/gInxODqF85EbfPxGjsGJ1BFrcu1n9dFGmPqi
         w2kA==
X-Gm-Message-State: ABy/qLY67Q000bBMXFdczicf/zK9bXNLiWvu2xuSETyPHrERKA+d/u8v
        X90iPPQ/p8wUTBRvJ6+rps5PRg==
X-Google-Smtp-Source: APBJJlGCd/oXUcfMR2PQ3fB8oIV+msgPR5klhkS/pC3rfwvF4Q+QaZjxFbfcCOSNSN8LYy4lTE1NMg==
X-Received: by 2002:adf:f282:0:b0:313:eb29:4436 with SMTP id k2-20020adff282000000b00313eb294436mr13789647wro.67.1688563126524;
        Wed, 05 Jul 2023 06:18:46 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id cx16-20020a056000093000b00301a351a8d6sm31230039wrb.84.2023.07.05.06.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:18:45 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: q6apm: do not close GPR port before closing graph
Date:   Wed,  5 Jul 2023 14:18:42 +0100
Message-Id: <20230705131842.41584-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Closing GPR port before graph close can result in un handled notifications
from DSP, this results in spam of errors from GPR driver as there is no
one to handle these notification at that point in time.

Fix this by closing GPR port after graph close is finished.

Fixes: 5477518b8a0e ("ASoC: qdsp6: audioreach: add q6apm support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 7bfac9492ab5..5d44d07acd69 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -511,6 +511,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 
 	switch (hdr->opcode) {
 	case DATA_CMD_RSP_WR_SH_MEM_EP_DATA_BUFFER_DONE_V2:
+		if (!graph->ar_graph)
+			break;
 		client_event = APM_CLIENT_EVENT_DATA_WRITE_DONE;
 		mutex_lock(&graph->lock);
 		token = hdr->token & APM_WRITE_TOKEN_MASK;
@@ -544,6 +546,8 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 		wake_up(&graph->cmd_wait);
 		break;
 	case DATA_CMD_RSP_RD_SH_MEM_EP_DATA_BUFFER_V2:
+		if (!graph->ar_graph)
+			break;
 		client_event = APM_CLIENT_EVENT_DATA_READ_DONE;
 		mutex_lock(&graph->lock);
 		rd_done = data->payload;
@@ -649,8 +653,9 @@ int q6apm_graph_close(struct q6apm_graph *graph)
 {
 	struct audioreach_graph *ar_graph = graph->ar_graph;
 
-	gpr_free_port(graph->port);
+	graph->ar_graph = NULL;
 	kref_put(&ar_graph->refcount, q6apm_put_audioreach_graph);
+	gpr_free_port(graph->port);
 	kfree(graph);
 
 	return 0;
-- 
2.25.1

