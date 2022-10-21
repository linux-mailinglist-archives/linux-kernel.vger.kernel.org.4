Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF6607CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiJUQxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiJUQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:53:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C3328DC09
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:53:12 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bu30so5872731wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zia5PwPjvTpWqvNWhun5tKRspbVbRhZxzacUZUNqQiU=;
        b=xoYaAB1se0w8ASUEmK0yW36m16q6/3YuZFWOFiqSgFAt6Q+2IAr3T/myjzrkvcz8Bv
         gzKrXoFMxmuEBnG1T/Kz3GlngDReayQaAjRoHvXcIACbjnQ9qdTr9ysWh6oql/kGBEGu
         FbZ9kGFUXx8rYpIuq67r0LDS2k87GwNMtP8XC8zjnOY7bnedQqrFBml/erwBb9npWAej
         61CGnKq/VPVrPPoVymQjS43npVirCIeIDZyzYjiAf1X+G0hRSTHlc7Mly4gIQM9KS2Nq
         GJp+T0OqZx5GvUTOs0G7vJwBtVw6owITtpQA8EnfOZI6lyAx5u0uYCscpedA//6JfOj2
         UbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zia5PwPjvTpWqvNWhun5tKRspbVbRhZxzacUZUNqQiU=;
        b=S9nAaMpJ14ti1VV1Ae/MuhHAp5YhgS8wGxAoFSbDODl0dNwTVQ7O5cC10w4zsj6KSu
         6Jzi++NOpiil5I5QsMUx4bWl2wnLf/SJSTBd8NtMpOnwNHIkHwsKr9dsu1eYOlWn1+F4
         AImMwPXAn0zl+Yx+vf6ZYnHTUQHDsnpVWxD9hLHJupPDn2E8EewLXytXCxbq2gLlavy+
         Y39o0Cgt6R7iw5nDKgF7gYPR4Rba1brw7H/AJQ9cEuObHrcwsm5UYoDryLpyRx1uVdT6
         RcIEUjpqjmCzOeprE3GwhEnYOgnPWSChHTaZPPFbyI4FQMK3Po11sRmDKhtENfiSCAS/
         0oCQ==
X-Gm-Message-State: ACrzQf1/FneTQHInsttn3VZk2q/ttZljpeiDhZ4lOSsOQOsQ3EqKKs9+
        eIF3ZP8voKjy+CUuMN0W0LGyim3975hFiQ==
X-Google-Smtp-Source: AMsMyM6izeud5K4Zu2OXqrdoXRMtXTje3wxLKz2CfxolNth6XovzzV0zHh4yvAh6FFc2gPabdphjBw==
X-Received: by 2002:a05:6000:1ac7:b0:232:8c6c:6c4a with SMTP id i7-20020a0560001ac700b002328c6c6c4amr13030296wry.455.1666371187605;
        Fri, 21 Oct 2022 09:53:07 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b0022ae401e9e0sm19541773wrp.78.2022.10.21.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:53:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/9] ASoC: qdsp6: audioreach: update dapm kcontrol private data
Date:   Fri, 21 Oct 2022 17:52:01 +0100
Message-Id: <20221021165207.13220-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221021165207.13220-1-srinivas.kandagatla@linaro.org>
References: <20221021165207.13220-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update kcontrol private date to include more information like graph id
and module instance id which its connected to. Also maintain this virtual
dapm mixer widget in a list so that we could lookup while FE and BE connection
are added.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm.c    |  1 +
 sound/soc/qcom/qdsp6/q6apm.h    |  1 +
 sound/soc/qcom/qdsp6/topology.c | 19 ++++++++++++++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 794019286c70..81e2d7090fb4 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -731,6 +731,7 @@ static int apm_probe(gpr_device_t *gdev)
 	apm->gdev = gdev;
 	init_waitqueue_head(&apm->wait);
 
+	INIT_LIST_HEAD(&apm->widget_list);
 	idr_init(&apm->graph_idr);
 	idr_init(&apm->graph_info_idr);
 	idr_init(&apm->sub_graphs_idr);
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 54eadadf712c..96ad5ea2ae07 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -58,6 +58,7 @@ struct q6apm {
 	struct mutex lock;
 	uint32_t state;
 
+	struct list_head widget_list;
 	struct idr graph_idr;
 	struct idr graph_info_idr;
 	struct idr sub_graphs_idr;
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 9a3d9e0eae53..0c4886d30131 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -16,7 +16,11 @@
 #include "audioreach.h"
 
 struct snd_ar_control {
+	u32 graph_id; /* Graph ID */
 	u32 sgid; /* Sub Graph ID */
+	u32 module_instance_id; /* Connected Module Instance ID */
+	struct snd_soc_dapm_widget *w;
+	struct list_head node;
 	struct snd_soc_component *scomp;
 };
 
@@ -692,6 +696,7 @@ static int audioreach_widget_load_mixer(struct snd_soc_component *component,
 	struct snd_soc_tplg_vendor_value_elem *w_elem;
 	struct snd_soc_tplg_vendor_array *w_array;
 	struct snd_ar_control *scontrol;
+	struct q6apm *data = dev_get_drvdata(component->dev);
 	struct snd_soc_dobj *dobj;
 	int tkn_count = 0;
 
@@ -711,6 +716,9 @@ static int audioreach_widget_load_mixer(struct snd_soc_component *component,
 		case AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:
 			scontrol->sgid = le32_to_cpu(w_elem->value);
 			break;
+		case AR_TKN_DAI_INDEX:
+			scontrol->graph_id = le32_to_cpu(w_elem->value);
+			break;
 		default: /* ignore other tokens */
 			break;
 		}
@@ -718,6 +726,9 @@ static int audioreach_widget_load_mixer(struct snd_soc_component *component,
 		w_elem++;
 	}
 
+	scontrol->w = w;
+	list_add_tail(&scontrol->node, &data->widget_list);
+
 	return 0;
 }
 
@@ -819,7 +830,10 @@ static int audioreach_widget_unload(struct snd_soc_component *scomp,
 
 	if (w->id == snd_soc_dapm_mixer) {
 		/* virtual widget */
-		kfree(dobj->private);
+		struct snd_ar_control *scontrol = dobj->private;
+
+		list_del(&scontrol->node);
+		kfree(scontrol);
 		return 0;
 	}
 
@@ -998,6 +1012,9 @@ static int audioreach_control_load_mix(struct snd_soc_component *scomp,
 		case AR_TKN_U32_SUB_GRAPH_INSTANCE_ID:
 			scontrol->sgid = le32_to_cpu(c_elem->value);
 			break;
+		case AR_TKN_DAI_INDEX:
+			scontrol->graph_id = le32_to_cpu(c_elem->value);
+			break;
 		default:
 			/* Ignore other tokens */
 			break;
-- 
2.21.0

