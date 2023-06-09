Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C01C729D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbjFIO4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240274AbjFIO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:56:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942E535A7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:55:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f735259fa0so18463205e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322541; x=1688914541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHdZfsXP57Mm/02dFH23BtlU4BZ6K+unFALB3eZT2XI=;
        b=hECgauk1lv9bUI/qzxcc7onysVmt8iROVx6nXi/YCoc83NhbFoD/4qrdkus6CWQeow
         17XOJnERd4wS2pC9Jtj5Z0LvbO36dq8e7vFaP8wMVLS3ZksVs2+8vlHqAfHCdsM8IeYb
         kWxbAUioeWrEo98dX43/VwdaqSD/KMsyqBIJ1SVJ9PQSOP0qflDSJtl3ytD+0abDkaM8
         dDW/IHhRlRiYvQ0fhPJA/JfbyB5nqsKeBHDju8yUK/ttUrUZ4XiCAAIad3mORYijf6Bw
         4NUfuoHOHGUS5tN3dkeIk3q/SjCML4ET/V5bL3+tddwKzcaJaMDWjfdNwDA78wiPIFPT
         Z9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322541; x=1688914541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHdZfsXP57Mm/02dFH23BtlU4BZ6K+unFALB3eZT2XI=;
        b=kNwfNFBPYugOWJGt76SLs+8NjwfHnwpN3VyamoCL8LevNyoaqvh9k9DaU5lBLBlKLz
         aHbZcqejkt7NUCNuhZ4TKrUV+ifPSg0Wa4jITBlkoUO3SAqXuQ5oxYZ6gR9cnuERYq7G
         fhFlmtVvZJ8y1d4zFZVC4tiyFWx1/pazP9UYJIuECwUsjSNjpaw3i3x2oYEdSdWwZJ9L
         Bu1pgQgpwZAa1ne93XWlwACPS6cXkxU1iCAP92CEmSfOhxXJN1uhPgqfgHWVpI0HaEIz
         P6HtQKTsl+MjFW67wCI7jVA0GvMGKHYPLYOcyy559WbpgEVI4OKSKj6ys5+rI69RPgLY
         BwAA==
X-Gm-Message-State: AC+VfDyNvMBf3KtMbeAIA/aaaDWZTlXcm8WZwgTuUneFajxYgvoYifAX
        GrzSALxPw/LIVVIfMoarUnKIuQ==
X-Google-Smtp-Source: ACHHUZ5DrewvI0+n2J+g2WI68Cm64oCnaD/7RuLUe7THX5lmRHb6ogXTyKEQqJRdaPOPKIZ/0Vk9Dg==
X-Received: by 2002:a05:600c:2901:b0:3f7:39ed:c9a4 with SMTP id i1-20020a05600c290100b003f739edc9a4mr1475841wmd.30.1686322541228;
        Fri, 09 Jun 2023 07:55:41 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm2946632wmr.2.2023.06.09.07.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:54:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 06/11] ASoC: q6dsp: audioreach: Add gapless feature support
Date:   Fri,  9 Jun 2023 15:54:02 +0100
Message-Id: <20230609145407.18774-7-srinivas.kandagatla@linaro.org>
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

Add support for setting EOS delay command and receive the
EOS response from ADSP, for seamless compress offload
playback feature.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/qcom/qdsp6/audioreach.c | 11 +++++++++++
 sound/soc/qcom/qdsp6/audioreach.h |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 6d0f4c8505f1..fefab20aaf1c 100644
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
@@ -1268,6 +1276,9 @@ int audioreach_set_media_format(struct q6apm_graph *graph, struct audioreach_mod
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

