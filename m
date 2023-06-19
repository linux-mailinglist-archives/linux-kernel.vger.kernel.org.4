Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843E97351C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjFSKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjFSKRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:17:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF7199
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d20548adso2339792f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687169818; x=1689761818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuQSolMY+GsunpVDUBYRLCP9uTfJjpPU4KcdicPOHq4=;
        b=wEV0ue9J+u2a2HLQ1CP4MMx4oGUdCkt99zwyjc1W2LXUU+UOnfNpWLbPyorE15KNuh
         U8NmkVrj022hXe0Zu+MXJ6IjR0ZDkR4U8Tdz1GjgGdFlq9wM+ChK/oftoibeGpZNb0OY
         SY8NPWh/scWhHbh/m020O0nK5HbJQbsW3lidlAwxPyxIZPAMQgJYwrpFK5YXlN8Ekg52
         H9iq0M+OJeSsxY679hBNisfWGI0R4dDLtvfAHXXne+oGRTUBfhQqitqDPcmdwG3jCoRF
         PkfQi6Qswfa7rC1TNenqhpjjWGoQSO+fM3DvX4B0SS2kSNgRqM9drcAJzS0dtGyIaWGc
         tqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169818; x=1689761818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuQSolMY+GsunpVDUBYRLCP9uTfJjpPU4KcdicPOHq4=;
        b=Jnx/CuvaUT1rEgpGdh1HgK5Iz1U6rGDOckupgkcVOMYEQ+Q4Muh8R97EcNdbpY9Yh3
         QJOoqYWcqa6ieSYXUcF5TmqTVh6XUZu/v3gWjko+AqNp7Bn5ircIXEgN/vtDCrT/1982
         s7CQEQG+bbvJzhtL210qmIuLW9HLSMZpHAxtAuZUO+KEvt0IZbe7aT3kzt2mTfsTknnr
         N5OMHeGUSt1w8mTubmNZbecTNkQVBrSPVcWclQzBQL0pRQG4Dq6gy1BjGspuGh8wiVCp
         iikSHoShfFeilpemVhUbebrY25Vfquv6pqPdhN7VsyCBmK/WclDoPnGNF9Ynq09nId2d
         qE2w==
X-Gm-Message-State: AC+VfDwfm27Oo5+8cqDCRaKZf+2CE6sR/vr5fCUs5vXJG+6m3MXnTNvW
        zuMacNqVhUO8cm9YY5DQ6sJ2sA==
X-Google-Smtp-Source: ACHHUZ7BIVHsLCveYS2BY00A5DGsfQvOZmnevUwUYrB78+bxfIPEytNYbcdcNJd1tSwKU7IpnCOegw==
X-Received: by 2002:a5d:464e:0:b0:30f:c1d6:61cf with SMTP id j14-20020a5d464e000000b0030fc1d661cfmr5503176wrs.51.1687169818587;
        Mon, 19 Jun 2023 03:16:58 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm31146922wrv.108.2023.06.19.03.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:16:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 02/11] ASoC: q6dsp: q6apm: add end of stream events
Date:   Mon, 19 Jun 2023 11:16:44 +0100
Message-Id: <20230619101653.9750-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
References: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>

EOS event from dsp is currently not sent to the dai drivers, add the
missing callback.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index a7a3f973eb6d..b07fee8ccac1 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -497,6 +497,9 @@ static int graph_callback(struct gpr_resp_pkt *data, void *priv, int op)
 		}
 		break;
 	case DATA_CMD_WR_SH_MEM_EP_EOS_RENDERED:
+		client_event = APM_CLIENT_EVENT_CMD_EOS_DONE;
+		if (graph->cb)
+			graph->cb(client_event, hdr->token, data->payload, graph->priv);
 		break;
 	case GPR_BASIC_RSP_RESULT:
 		switch (result->opcode) {
-- 
2.21.0

