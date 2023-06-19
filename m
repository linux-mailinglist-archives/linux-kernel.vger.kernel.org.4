Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84037351CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjFSKRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjFSKRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:17:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2822D1A6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-311167ba376so2970924f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687169822; x=1689761822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhDOcyfRIoE2cQHMZGlVdvXCRT+HvU3JTOnhcjqd13I=;
        b=K545tCci1GTfmEnyjn8i0zeEnnQq4kD+wGaUowMiGIfPnKKKsG9iwdbHcYM72jk4km
         NbUsDIGv4z1zDUspYUkKMHYkPtwgVVcYGJ2JPQtUFrwuoumHhBianHSJjjbt9QIQ8Gv3
         ENkUz2UJVAnxCf9rjWxMcmtkdXfgQoUCdwZpEZRAIVLfJ4y3a8cXZi+NF8FFc9F70C8U
         K2+vhil7gSDTWz9yA+ph0NRd5lXuWj9bMc+/HYP30aKZotMvOVCbqfu0Oqh1qGHbxj92
         NczQSKq/3Ns0iil16NlNKQj3wjS4QUbcm1wbK4T8kLixtSir8nVaQAqhDtXWl9rU6gv/
         uxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169822; x=1689761822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhDOcyfRIoE2cQHMZGlVdvXCRT+HvU3JTOnhcjqd13I=;
        b=Le8XMo9j3SdN0cpdv/zjnjuVQJQgNxikD5vfW6IIOcBsUv9FURHEiCmqUhidnMKpDb
         2GlspbYmftP0d1JEr7vwldIYbfwkxGbQFbwxhdQ8NTgvjCvdWWZ+09MO7XxkrjzDExfo
         UG5D8773/9oxWm/7BeG4Twjb1RdLP4QnRY6C3DRZVqnMh5Jdoo9Bcbw+ziO8PkGctheQ
         ejMvzyUgfosiDkOxw31Qj59s4cNBM3JT+jShK6wqHLlCInxB/2UVr7eIoJBbqjpNLQaP
         8DMl5t481g4e35GyMD14X8PbNCZif+TmgumdquyQ8uF7ikM/yNxUkCSTivtpqQ8WICPM
         3AEQ==
X-Gm-Message-State: AC+VfDxwYhSrlR7ZGHXb3+ps9hKAfN1L/iKYvrJ2bw8S+L3N8dR9c6tz
        RToOsyIAGTfHMhnUtB5wKLPvPQ==
X-Google-Smtp-Source: ACHHUZ6rFD9Xi0ixsLMYlGX+5AcwRfcQFbE58cljPfYsn+BKzSAKfColuB0CUTsPpZlELzAvg2dhRw==
X-Received: by 2002:a5d:6711:0:b0:30f:c298:601d with SMTP id o17-20020a5d6711000000b0030fc298601dmr6654075wru.5.1687169822717;
        Mon, 19 Jun 2023 03:17:02 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm31146922wrv.108.2023.06.19.03.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:17:02 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 06/11] ASoC: q6dsp: audioreach: Add gapless feature support
Date:   Mon, 19 Jun 2023 11:16:48 +0100
Message-Id: <20230619101653.9750-7-srinivas.kandagatla@linaro.org>
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

Add support for setting EOS delay command and receive the
EOS response from ADSP, for seamless compress offload
playback feature.

Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 11 +++++++++++
 sound/soc/qcom/qdsp6/audioreach.h |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index ba262408b27a..5974c7929dd3 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -787,6 +787,14 @@ static int audioreach_module_enable(struct q6apm_graph *graph,
 	return audioreach_send_u32_param(graph, module, PARAM_ID_MODULE_ENABLE, enable);
 }
 
+static int audioreach_gapless_set_media_format(struct q6apm_graph *graph,
+					       struct audioreach_module *module,
+					       struct audioreach_module_config *cfg)
+{
+	return audioreach_send_u32_param(graph, module, PARAM_ID_EARLY_EOS_DELAY,
+					 EARLY_EOS_DELAY_MS);
+}
+
 static int audioreach_mfc_set_media_format(struct q6apm_graph *graph,
 					   struct audioreach_module *module,
 					   struct audioreach_module_config *cfg)
@@ -1270,6 +1278,9 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
 	case MODULE_ID_MFC:
 		rc = audioreach_mfc_set_media_format(graph, module, cfg);
 		break;
+	case MODULE_ID_GAPLESS:
+		rc = audioreach_gapless_set_media_format(graph, module, cfg);
+		break;
 	default:
 		rc = 0;
 	}
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index dc089879b501..e38111ffd7b9 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -27,6 +27,7 @@ struct q6apm_graph;
 #define MODULE_ID_AAC_DEC		0x0700101F
 #define MODULE_ID_FLAC_DEC		0x0700102F
 #define MODULE_ID_MP3_DECODE		0x0700103B
+#define MODULE_ID_GAPLESS		0x0700104D
 #define MODULE_ID_DISPLAY_PORT_SINK	0x07001069
 
 #define APM_CMD_GET_SPF_STATE		0x01001021
@@ -552,6 +553,8 @@ struct param_id_sal_limiter_enable {
 } __packed;
 
 #define PARAM_ID_MFC_OUTPUT_MEDIA_FORMAT	0x08001024
+#define PARAM_ID_EARLY_EOS_DELAY		0x0800114C
+#define EARLY_EOS_DELAY_MS			150
 
 struct param_id_mfc_media_format {
 	uint32_t sample_rate;
@@ -560,6 +563,10 @@ struct param_id_mfc_media_format {
 	uint16_t channel_mapping[];
 } __packed;
 
+struct param_id_gapless_early_eos_delay_t {
+	uint32_t early_eos_delay_ms;
+} __packed;
+
 struct media_format {
 	uint32_t data_format;
 	uint32_t fmt_id;
-- 
2.21.0

