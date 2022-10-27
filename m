Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0B960F505
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiJ0K2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbiJ0K1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:27:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7472F65C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t4so625684wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKQTPRFu++JOzaQvPKM6EY88nyYcpwHVj06ax0yzQAI=;
        b=r1XOWKOprkHaO8FuW0u5IWId2lIgt3Vo1/lrOuUOcyBn9+EuFrRE8LSNux6ADaZRum
         VLi9zUsaL6CHZHxysp6vPtsxPRP6VXtjyYGXSDunjjjbcsML0DBQaqMykQumfXasesdI
         anr5cPryy9/WlbFYZU1ZHLyD8qh27kqGcXwcQ9016DQoyuPmOMfdjk9gfq7SIfNoPYzr
         oHhac+jl4qBAM1IoTS55RdoX5YW4BAyLN9qPpmq7uk546+slO19MKEsN1diDNBwUzLsE
         sP7oNAsBk/jdqqGXb1SLPu+xG1Yc2c914mgbtuAE12jSxS5U7pJ/rNV/mHttyaPS36Sm
         EJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKQTPRFu++JOzaQvPKM6EY88nyYcpwHVj06ax0yzQAI=;
        b=KHCR/99T1cGZQcy86ad6Up0KvOWWrEC+ztpJvSurJKdtIsJeCocTG5OZ2Gr4TQt8Cd
         WavSvnoawvCjVsStZKzDWa8zSylB1GCh24x1bWcqEltkhWt/Gv0eLjfAlSGtYhXuFF45
         Sl9iF9Ooa1mWjTKCTwULuXCnXBd1RZ6JIbcQ5bfrMSACzVxCyAfELpsO3K0gEwh2AiOk
         cPtXER9+bA6OOGBNgo0F8NkpF+3w098Iw80toTl9cGDwMDFItc3DVJEyiLclyMnpFtXU
         c4KYu9svxhXvuwsooHCn1StocXFe5qCJqSZ8zTboqdeQGw8Q4zuxkUkc1KfGi8NHqw/S
         /fqQ==
X-Gm-Message-State: ACrzQf1reIxB4VItS3+BAupDzWL2kVbaarFjXqRS0a3vCbe9piNgRAxN
        7m6Hj2v8tTK2gmxW7ZUQHqH2/A==
X-Google-Smtp-Source: AMsMyM4sgq73+xWA9Uv5bD23xURnCE6/2JnkcYrZovykm9jGyUOIYV+TPTyNnGDjyOO4hdNUCHgX5A==
X-Received: by 2002:a05:600c:5563:b0:3cf:503c:c759 with SMTP id ja3-20020a05600c556300b003cf503cc759mr2107969wmb.30.1666866460613;
        Thu, 27 Oct 2022 03:27:40 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b003b505d26776sm5088674wmb.5.2022.10.27.03.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 03:27:40 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/9] ASoC: qdsp6: audioreach: topology use idr_alloc_u32
Date:   Thu, 27 Oct 2022 11:27:02 +0100
Message-Id: <20221027102710.21407-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221027102710.21407-1-srinivas.kandagatla@linaro.org>
References: <20221027102710.21407-1-srinivas.kandagatla@linaro.org>
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
instead of idr_alloc to able to accommodate valid ranges.

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

