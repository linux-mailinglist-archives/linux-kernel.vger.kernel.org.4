Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67AD729D6C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbjFIOyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbjFIOyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:54:31 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2420D30F1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:54:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7a8089709so19235525e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322460; x=1688914460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuQSolMY+GsunpVDUBYRLCP9uTfJjpPU4KcdicPOHq4=;
        b=ONwJl09/bsLQmdUzwtjnMWbC7fFCwIu40+1GGEzwNKYAYTImxjdf80WVJenHhV6SZE
         l4hyaIQb9uouf0Knk+bgqUpA18RhoQmWzHa7wGTm5DaL1kfmpeIfSfRyW1UzLp3TNe5M
         gND5CHZmr7t5WkwjRCPDvGuC0Edq6WoaG+VBGf4QjCiqRI+E3F9BC/91d2r+CdYGCS6i
         G17IodWT7T+WZtjs6mV8Dg2r0gO3rHNyRe2cAdPYHdyQ2n9s5t89eyCv0FdZ2gTN3MRX
         GqPUaqQnWTqHRyJZ/jEBAx1d8jxCsWZ7kSYgZXoGyrwXvIHOkOCROW+CL57a6XTPXRqX
         l03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322460; x=1688914460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuQSolMY+GsunpVDUBYRLCP9uTfJjpPU4KcdicPOHq4=;
        b=f2u59xMfTKVLfyMcwbPATBvMZ4cBYeY6P9jmuI1XnyixGGZGEqMMXD+NYcyWxlNezq
         1eemcVnP828RYzQYImwnIDyQugqBWP4A6Xa+VDd69Ct/WUjJPuw8MX5CEuFGfmoxC99m
         MlyxW+qlHrAk+vr3b23xtFpNed4iWOt8F0tTn1Oe0XbEuOqlmnTT3A/vQmfTKV5rRdOW
         BMzyELewYFJzb8WFwwJ6zbhLAG0Q56XLE1aGEFimdHel8wN6d808Y5oLwTMInuU+SLtO
         K/UoOgb3fxVMwtzNMy+w8aDf8SO6OVNi0cdMpUngzfl7Pd6HSIqolkUMaP5mgPxFN3dy
         qcmA==
X-Gm-Message-State: AC+VfDzYCXhFo+h/PH7++a5FST0OPGRGjnnkaEb5hqIW8rYpJkcw9BHI
        Gs3aazs6L64OzJbCe0FFCyw6jQ==
X-Google-Smtp-Source: ACHHUZ5jmIwMMsS6bJUifZ1z8l17raD0V7Vbgzz65Isey3BWjeSbT6ZHcqCta3q3QBlg09+h3SCrMw==
X-Received: by 2002:a1c:6a18:0:b0:3f7:e536:8f06 with SMTP id f24-20020a1c6a18000000b003f7e5368f06mr1341409wmc.26.1686322460491;
        Fri, 09 Jun 2023 07:54:20 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm2946632wmr.2.2023.06.09.07.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:54:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 02/11] ASoC: q6dsp: q6apm: add end of stream events
Date:   Fri,  9 Jun 2023 15:53:58 +0100
Message-Id: <20230609145407.18774-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
References: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
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

