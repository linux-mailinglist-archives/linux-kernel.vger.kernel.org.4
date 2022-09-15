Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6736B5B9AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIOMjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiIOMiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:38:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4940F7E81B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bq9so30696342wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=S1Wbe703KgwRjRnGYT1UQwDcnhEdqY3xQGpBo/iRxEg=;
        b=q3+13rQMZe8hlYwv/HASxaymo9QU7p0gObvq/d5o6KQtnwUylgUQplJPjfYGffqCks
         5F8EjLkvigkbDjNM/++o1zWtG42OLmXzp5MMrrYIlwQNsHdvpqwXnTxzuOChx7YdbIF2
         fl25J3FTfrJHkdgOmt7xYOzP8q88Yk2acfQB0tgY+2zOLpS0nEI1If4HYXPZvi7zEd6X
         HnMLg7bfjO8enspJ0UONS20xGgvWOTi6Bf7Evs9FpONh7OZuLB9MCiDWcxESInWFTq2E
         TcVA11DFo8vV7r5L/1XEAB0Tt4JbgyLxvNiUiSD5VKvCtiaoeo+VhJDF/ghafdcJvrNb
         lifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=S1Wbe703KgwRjRnGYT1UQwDcnhEdqY3xQGpBo/iRxEg=;
        b=a8aXKFAfw/jElr1vT4qPfrjolnnRpXNzqXJ0p21pe3Xaay8ur9hYEkZxFEZG11uWZC
         yAXmcQRJFOWDL5Ik3t/Ci3cmhVdfOQmHQL0ih4hE1kSexD0Ui///1aGejrCxGdPXPkRa
         sAWDW3tBCcFFGtSLFYM9oc/SuP6gdL51CUTzjVlwgy01stfHh3IoGRezUanEJAUdOXgS
         V8yTtTWLARbkojfQ4ENcCcrFqsqzmGHpDL5nCR8m4dyGwklzaW1ILOYG8FrSPgMmyXhz
         95ATklpo+XHi273xB8/wBU3uVRbmAaYvh8N9TxO+Ttezy5UpCx2T4xfrXv4JHskNPWWi
         R8hQ==
X-Gm-Message-State: ACgBeo2mVUMwuveEqcW2KKQgwOwcjDBfgo0BO66xPbHh4rg4YEDjl7D8
        26GRWWvFBLmDy9c0BEYrclfFjg==
X-Google-Smtp-Source: AA6agR6FwgsGTkzftq/NA192AJGeqy4nG8K/OS7cYBnFj10qXrYUHizyklw0lCpWs5mOS0cI7s/0jw==
X-Received: by 2002:a05:6000:1689:b0:22a:a66d:1f37 with SMTP id y9-20020a056000168900b0022aa66d1f37mr10986312wrd.197.1663245529897;
        Thu, 15 Sep 2022 05:38:49 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id bg13-20020a05600c3c8d00b003a5f4fccd4asm3112559wmb.35.2022.09.15.05.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:38:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/9] ASoC: qdsp6: audioreach: topology use idr_alloc_u32
Date:   Thu, 15 Sep 2022 13:38:29 +0100
Message-Id: <20220915123837.11591-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220915123837.11591-1-srinivas.kandagatla@linaro.org>
References: <20220915123837.11591-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SubGraph and Module Instance ids take 32 bits, so use idr_alloc_u32
instead of idr_alloc to able to accomdate valid ranges.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/topology.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index bd649c232a06..9a3d9e0eae53 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -44,7 +44,7 @@ static struct audioreach_graph_info *audioreach_tplg_alloc_graph_info(struct q6a
 	INIT_LIST_HEAD(&info->sg_list);
 
 	mutex_lock(&apm->lock);
-	ret = idr_alloc(&apm->graph_info_idr, info, graph_id, graph_id + 1, GFP_KERNEL);
+	ret = idr_alloc_u32(&apm->graph_info_idr, info, &graph_id, graph_id, GFP_KERNEL);
 	mutex_unlock(&apm->lock);
 
 	if (ret < 0) {
@@ -53,7 +53,7 @@ static struct audioreach_graph_info *audioreach_tplg_alloc_graph_info(struct q6a
 		return ERR_PTR(ret);
 	}
 
-	info->id = ret;
+	info->id = graph_id;
 
 	return info;
 }
@@ -94,7 +94,7 @@ static struct audioreach_sub_graph *audioreach_tplg_alloc_sub_graph(struct q6apm
 	INIT_LIST_HEAD(&sg->container_list);
 
 	mutex_lock(&apm->lock);
-	ret = idr_alloc(&apm->sub_graphs_idr, sg, sub_graph_id, sub_graph_id + 1, GFP_KERNEL);
+	ret = idr_alloc_u32(&apm->sub_graphs_idr, sg, &sub_graph_id, sub_graph_id, GFP_KERNEL);
 	mutex_unlock(&apm->lock);
 
 	if (ret < 0) {
@@ -103,7 +103,7 @@ static struct audioreach_sub_graph *audioreach_tplg_alloc_sub_graph(struct q6apm
 		return ERR_PTR(ret);
 	}
 
-	sg->sub_graph_id = ret;
+	sg->sub_graph_id = sub_graph_id;
 
 	return sg;
 }
@@ -136,7 +136,7 @@ static struct audioreach_container *audioreach_tplg_alloc_container(struct q6apm
 	INIT_LIST_HEAD(&cont->modules_list);
 
 	mutex_lock(&apm->lock);
-	ret = idr_alloc(&apm->containers_idr, cont, container_id, container_id + 1, GFP_KERNEL);
+	ret = idr_alloc_u32(&apm->containers_idr, cont, &container_id, container_id, GFP_KERNEL);
 	mutex_unlock(&apm->lock);
 
 	if (ret < 0) {
@@ -145,7 +145,7 @@ static struct audioreach_container *audioreach_tplg_alloc_container(struct q6apm
 		return ERR_PTR(ret);
 	}
 
-	cont->container_id = ret;
+	cont->container_id = container_id;
 	cont->sub_graph = sg;
 	/* add to container list */
 	list_add_tail(&cont->node, &sg->container_list);
@@ -181,7 +181,7 @@ static struct audioreach_module *audioreach_tplg_alloc_module(struct q6apm *apm,
 				       AR_MODULE_DYNAMIC_INSTANCE_ID_START,
 				       AR_MODULE_DYNAMIC_INSTANCE_ID_END, GFP_KERNEL);
 	} else {
-		ret = idr_alloc(&apm->modules_idr, mod, module_id, module_id + 1, GFP_KERNEL);
+		ret = idr_alloc_u32(&apm->modules_idr, mod, &module_id, module_id, GFP_KERNEL);
 	}
 	mutex_unlock(&apm->lock);
 
@@ -191,7 +191,7 @@ static struct audioreach_module *audioreach_tplg_alloc_module(struct q6apm *apm,
 		return ERR_PTR(ret);
 	}
 
-	mod->instance_id = ret;
+	mod->instance_id = module_id;
 	/* add to module list */
 	list_add_tail(&mod->node, &cont->modules_list);
 	mod->container = cont;
-- 
2.21.0

