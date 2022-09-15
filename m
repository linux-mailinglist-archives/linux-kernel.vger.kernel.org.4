Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053085B9B02
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIOMjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiIOMi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:38:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328B82FA1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o5so9749839wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XnvKFYYKXcSrDml2+Zs9IIxXB5gFcGZQDx89p5yTLgY=;
        b=yntXbuZxm0FgsIaciAXKsgkT5M4eRAhhoz1TRvvFWBkI7yKB4BubnUYiym6AZfVrrk
         iVbcS7psA3bIbJq3h0fLuRk5AgnnrjBDelae42rnSc/MKcqd1UfbAANAwxkhdqROFZxV
         jmn1bPuJWNocPVlLS4oaJRCXy250snFTRp4E7z54qokXHNJgZ1H2FM7408Xyq80HL2Hl
         3FWICGUUkrfX3J75L4LxNEmnEBGP/XVRe4ZfSFhhKPgYuqom2crrXnWO2/IXiN/kisM0
         NFjADHxqS7tXVQGHG6OLqJFqgSTQuTqVLFk8SIgPozIqEaMDo8bIgY8l8rOtcRlkOYL8
         ua2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XnvKFYYKXcSrDml2+Zs9IIxXB5gFcGZQDx89p5yTLgY=;
        b=v1U0LdC8+Rx304wB6H19inhyLOyp6qXAOysXxSwAw0Aib7e1Qeug4HQoa6TS6M1yxZ
         /zIBTJce45Dy4yib9IS8Aug06xo1vexyMZPXc8GBUna0/jmak8WX1IRiPNMpIARb+Zd9
         8B1Y8TnRGKZQQ0043/M0Bobvv17KGrLo88sUsmvUTw+FzBTRzLsbFXYa6rcDBtDHoFH4
         nAYXzePT/p4ins8qdOrj+gLVa8Zgw+HFEoyLgAJ12j3K/I66Z/yrYcfWGxbKDVeROyR1
         7aGhgI9yEUphOL4yLLOUjbwItkNloqGMd4kT92gliaLDxKMEfEzfliCG6sX0bF2EYRMc
         HrUA==
X-Gm-Message-State: ACgBeo1obLZ4yvqW141cNY64oEQan+MV2sJsERCUdQ5d/o6YBB+0Ftwf
        r1gqcZc3VzxtLwCzAqXGele1YA==
X-Google-Smtp-Source: AA6agR6sg6efNFIq/i03biaCsxeZiJeUog6M9uC6LLkh13EMQQ+8/jvc+R9TG81K4P2XelUGyh1/fw==
X-Received: by 2002:a05:600c:1694:b0:3b4:6205:1f95 with SMTP id k20-20020a05600c169400b003b462051f95mr6790418wmn.151.1663245534494;
        Thu, 15 Sep 2022 05:38:54 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id bg13-20020a05600c3c8d00b003a5f4fccd4asm3112559wmb.35.2022.09.15.05.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:38:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/9] ASoC: qdsp6: audioreach: Simplify handing FE and BE graph connections
Date:   Thu, 15 Sep 2022 13:38:32 +0100
Message-Id: <20220915123837.11591-5-srinivas.kandagatla@linaro.org>
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

Current AudioReach design of connecting FE and BE graph is very complicated
and not reliable. Instead used the virtual damp widgets private data to help
identify the modules that needs connection at runtime. Also maintain a
inter-graph connection info in the graph info, which can be used to both
determine if the graphs are connected and at graph build time.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c |  90 ++++++++-----------------
 sound/soc/qcom/qdsp6/audioreach.h |  20 ++----
 sound/soc/qcom/qdsp6/q6apm.c      |  83 +----------------------
 sound/soc/qcom/qdsp6/q6apm.h      |   5 --
 sound/soc/qcom/qdsp6/topology.c   | 105 ++++++++++++++++++++++++++----
 5 files changed, 129 insertions(+), 174 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 01dac32c50fd..783211fc0d87 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -332,63 +332,6 @@ static void apm_populate_module_prop_obj(struct apm_mod_prop_obj *obj,
 	obj->prop_id_port.max_op_port = module->max_op_port;
 }
 
-struct audioreach_module *audioreach_get_container_last_module(
-							struct audioreach_container *container)
-{
-	struct audioreach_module *module;
-
-	list_for_each_entry(module, &container->modules_list, node) {
-		if (module->dst_mod_inst_id == 0)
-			return module;
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(audioreach_get_container_last_module);
-
-static bool is_module_in_container(struct audioreach_container *container, int module_iid)
-{
-	struct audioreach_module *module;
-
-	list_for_each_entry(module, &container->modules_list, node) {
-		if (module->instance_id == module_iid)
-			return true;
-	}
-
-	return false;
-}
-
-struct audioreach_module *audioreach_get_container_first_module(
-							struct audioreach_container *container)
-{
-	struct audioreach_module *module;
-
-	/* get the first module from both connected or un-connected containers */
-	list_for_each_entry(module, &container->modules_list, node) {
-		if (module->src_mod_inst_id == 0 ||
-		    !is_module_in_container(container, module->src_mod_inst_id))
-			return module;
-	}
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(audioreach_get_container_first_module);
-
-struct audioreach_module *audioreach_get_container_next_module(
-						struct audioreach_container *container,
-						struct audioreach_module *module)
-{
-	int nmodule_iid = module->dst_mod_inst_id;
-	struct audioreach_module *nmodule;
-
-	list_for_each_entry(nmodule, &container->modules_list, node) {
-		if (nmodule->instance_id == nmodule_iid)
-			return nmodule;
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(audioreach_get_container_next_module);
-
 static void apm_populate_module_list_obj(struct apm_mod_list_obj *obj,
 					 struct audioreach_container *container,
 					 int sub_graph_id)
@@ -400,14 +343,15 @@ static void apm_populate_module_list_obj(struct apm_mod_list_obj *obj,
 	obj->container_id = container->container_id;
 	obj->num_modules = container->num_modules;
 	i = 0;
-	list_for_each_container_module(module, container) {
+	list_for_each_entry(module, &container->modules_list, node) {
 		obj->mod_cfg[i].module_id = module->module_id;
 		obj->mod_cfg[i].instance_id = module->instance_id;
 		i++;
 	}
 }
 
-static void audioreach_populate_graph(struct apm_graph_open_params *open,
+static void audioreach_populate_graph(struct q6apm *apm, struct audioreach_graph_info *info,
+				      struct apm_graph_open_params *open,
 				      struct list_head *sg_list,
 				      int num_sub_graphs)
 {
@@ -428,6 +372,16 @@ static void audioreach_populate_graph(struct apm_graph_open_params *open,
 
 	mlobj = &ml_data->mod_list_obj[0];
 
+
+	if (info->dst_mod_inst_id && info->src_mod_inst_id) {
+		conn_obj = &mc_data->conn_obj[nconn];
+		conn_obj->src_mod_inst_id = info->src_mod_inst_id;
+		conn_obj->src_mod_op_port_id = info->src_mod_op_port_id;
+		conn_obj->dst_mod_inst_id = info->dst_mod_inst_id;
+		conn_obj->dst_mod_ip_port_id = info->dst_mod_ip_port_id;
+		nconn++;
+	}
+
 	list_for_each_entry(sg, sg_list, node) {
 		struct apm_sub_graph_data *sg_cfg = &sg_data->sg_cfg[i++];
 
@@ -439,7 +393,7 @@ static void audioreach_populate_graph(struct apm_graph_open_params *open,
 			apm_populate_container_config(cobj, container);
 			apm_populate_module_list_obj(mlobj, container, sg->sub_graph_id);
 
-			list_for_each_container_module(module, container) {
+			list_for_each_entry(module, &container->modules_list, node) {
 				uint32_t src_mod_inst_id;
 
 				src_mod_inst_id = module->src_mod_inst_id;
@@ -462,7 +416,7 @@ static void audioreach_populate_graph(struct apm_graph_open_params *open,
 	}
 }
 
-void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct list_head *sg_list, int graph_id)
+void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info *info)
 {
 	int payload_size, sg_sz, cont_sz, ml_sz, mp_sz, mc_sz;
 	struct apm_module_param_data  *param_data;
@@ -475,6 +429,7 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct list_head *sg_list, i
 	struct audioreach_module *module;
 	struct audioreach_sub_graph *sgs;
 	struct apm_mod_list_obj *mlobj;
+	struct list_head *sg_list;
 	int num_modules_per_list;
 	int num_connections = 0;
 	int num_containers = 0;
@@ -482,14 +437,23 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct list_head *sg_list, i
 	int num_modules = 0;
 	int num_modules_list;
 	struct gpr_pkt *pkt;
+	int graph_id;
 	void *p;
 
+	graph_id = info->id;
+	sg_list = &info->sg_list;
+	ml_sz = 0;
+
+	/* add FE-BE connections */
+	if (info->dst_mod_inst_id && info->src_mod_inst_id)
+		num_connections++;
+
 	list_for_each_entry(sgs, sg_list, node) {
 		num_sub_graphs++;
 		list_for_each_entry(container, &sgs->container_list, node) {
 			num_containers++;
 			num_modules += container->num_modules;
-			list_for_each_container_module(module, container) {
+			list_for_each_entry(module, &container->modules_list, node) {
 				if (module->src_mod_inst_id)
 					num_connections++;
 			}
@@ -557,7 +521,7 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct list_head *sg_list, i
 	params.mod_conn_list_data->num_connections = num_connections;
 	p += mc_sz;
 
-	audioreach_populate_graph(&params, sg_list, num_sub_graphs);
+	audioreach_populate_graph(apm, info, &params, sg_list, num_sub_graphs);
 
 	return pkt;
 }
diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 36779ad1952d..1dc6ffcb3362 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -595,6 +595,11 @@ struct audioreach_graph_info {
 	int id;
 	uint32_t num_sub_graphs;
 	struct list_head sg_list;
+	/* DPCM connection from FE Graph to BE graph */
+	uint32_t src_mod_inst_id;
+	uint32_t src_mod_op_port_id;
+	uint32_t dst_mod_inst_id;
+	uint32_t dst_mod_ip_port_id;
 };
 
 struct audioreach_sub_graph {
@@ -693,9 +698,8 @@ void *audioreach_alloc_apm_pkt(int pkt_size, uint32_t opcode, uint32_t token,
 void *audioreach_alloc_pkt(int payload_size, uint32_t opcode,
 			   uint32_t token, uint32_t src_port,
 			   uint32_t dest_port);
-void *audioreach_alloc_graph_pkt(struct q6apm *apm,
-				 struct list_head *sg_list,
-				  int graph_id);
+void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info
+				 *info);
 /* Topology specific */
 int audioreach_tplg_init(struct snd_soc_component *component);
 
@@ -716,14 +720,4 @@ int audioreach_set_media_format(struct q6apm_graph *graph,
 int audioreach_shared_memory_send_eos(struct q6apm_graph *graph);
 int audioreach_gain_set_vol_ctrl(struct q6apm *apm,
 				 struct audioreach_module *module, int vol);
-struct audioreach_module *audioreach_get_container_last_module(
-				struct audioreach_container *container);
-struct audioreach_module *audioreach_get_container_first_module(
-				struct audioreach_container *container);
-struct audioreach_module *audioreach_get_container_next_module(
-				struct audioreach_container *container,
-				struct audioreach_module *module);
-#define list_for_each_container_module(mod, cont) \
-	for (mod = audioreach_get_container_first_module(cont); mod != NULL; \
-	     mod = audioreach_get_container_next_module(cont, mod))
 #endif /* __AUDIOREACH_H__ */
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 81e2d7090fb4..5beb898f28f5 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -63,7 +63,7 @@ static struct audioreach_graph *q6apm_get_audioreach_graph(struct q6apm *apm, ui
 	graph->info = info;
 	graph->id = graph_id;
 
-	graph->graph = audioreach_alloc_graph_pkt(apm, &info->sg_list, graph_id);
+	graph->graph = audioreach_alloc_graph_pkt(apm, info);
 	if (IS_ERR(graph->graph)) {
 		void *err = graph->graph;
 
@@ -178,87 +178,6 @@ static struct audioreach_module *__q6apm_find_module_by_mid(struct q6apm *apm,
 	return NULL;
 }
 
-static struct audioreach_module *q6apm_graph_get_last_module(struct q6apm *apm, u32 sgid)
-{
-	struct audioreach_container *container;
-	struct audioreach_module *module;
-	struct audioreach_sub_graph *sg;
-
-	mutex_lock(&apm->lock);
-	sg = idr_find(&apm->sub_graphs_idr, sgid);
-	mutex_unlock(&apm->lock);
-	if (!sg)
-		return NULL;
-
-	container = list_last_entry(&sg->container_list, struct audioreach_container, node);
-	module = audioreach_get_container_last_module(container);
-
-	return module;
-}
-
-static struct audioreach_module *q6apm_graph_get_first_module(struct q6apm *apm, u32 sgid)
-{
-	struct audioreach_container *container;
-	struct audioreach_module *module;
-	struct audioreach_sub_graph *sg;
-
-	mutex_lock(&apm->lock);
-	sg = idr_find(&apm->sub_graphs_idr, sgid);
-	mutex_unlock(&apm->lock);
-	if (!sg)
-		return NULL;
-
-	container = list_first_entry(&sg->container_list, struct audioreach_container, node);
-	module = audioreach_get_container_first_module(container);
-
-	return module;
-}
-
-bool q6apm_is_sub_graphs_connected(struct q6apm *apm, u32 src_sgid, u32 dst_sgid)
-{
-	struct audioreach_module *module;
-	u32 iid;
-
-	module = q6apm_graph_get_last_module(apm, src_sgid);
-	if (!module)
-		return false;
-
-	iid = module->instance_id;
-	module = q6apm_graph_get_first_module(apm, dst_sgid);
-	if (!module)
-		return false;
-
-	if (module->src_mod_inst_id == iid)
-		return true;
-
-	return false;
-}
-
-int q6apm_connect_sub_graphs(struct q6apm *apm, u32 src_sgid, u32 dst_sgid, bool connect)
-{
-	struct audioreach_module *module;
-	u32 iid;
-
-	if (connect) {
-		module = q6apm_graph_get_last_module(apm, src_sgid);
-		if (!module)
-			return -ENODEV;
-
-		iid = module->instance_id;
-	} else {
-		iid = 0;
-	}
-
-	module = q6apm_graph_get_first_module(apm, dst_sgid);
-	if (!module)
-		return -ENODEV;
-
-	/* set src module in dst subgraph first module */
-	module->src_mod_inst_id = iid;
-
-	return 0;
-}
-
 int q6apm_graph_media_format_shmem(struct q6apm_graph *graph,
 				   struct audioreach_module_config *cfg)
 {
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 96ad5ea2ae07..273f97812741 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -142,12 +142,7 @@ int q6apm_send_cmd_sync(struct q6apm *apm, struct gpr_pkt *pkt,
 /* Callback for graph specific */
 struct audioreach_module *q6apm_find_module_by_mid(struct q6apm_graph *graph,
 						    uint32_t mid);
-
 void q6apm_set_fe_dai_ops(struct snd_soc_dai_driver *dai_drv);
-int q6apm_connect_sub_graphs(struct q6apm *apm, u32 src_sgid, u32 dst_sgid,
-			     bool connect);
-bool q6apm_is_sub_graphs_connected(struct q6apm *apm, u32 src_sgid,
-				   u32 dst_sgid);
 int q6apm_graph_get_rx_shmem_module_iid(struct q6apm_graph *graph);
 
 #endif /* __APM_GRAPH_ */
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 0c4886d30131..f66d7054177c 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -872,7 +872,21 @@ static int audioreach_widget_unload(struct snd_soc_component *scomp,
 	return 0;
 }
 
-static struct audioreach_module *audioreach_find_widget(struct snd_soc_component *comp,
+static struct snd_ar_control *audioreach_find_widget(struct snd_soc_component *comp,
+						     const char *name)
+{
+	struct q6apm *apm = dev_get_drvdata(comp->dev);
+	struct snd_ar_control *control;
+
+	list_for_each_entry(control, &apm->widget_list, node) {
+		if (control->w && !strcmp(name, control->w->name))
+			return control;
+	}
+
+	return NULL;
+}
+
+static struct audioreach_module *audioreach_find_module(struct snd_soc_component *comp,
 							const char *name)
 {
 	struct q6apm *apm = dev_get_drvdata(comp->dev);
@@ -890,14 +904,41 @@ static struct audioreach_module *audioreach_find_widget(struct snd_soc_component
 static int audioreach_route_load(struct snd_soc_component *scomp, int index,
 				 struct snd_soc_dapm_route *route)
 {
-	struct audioreach_module *src, *sink;
-
-	src = audioreach_find_widget(scomp, route->source);
-	sink = audioreach_find_widget(scomp, route->sink);
+	struct audioreach_module *src_module, *sink_module;
+	struct snd_ar_control *control;
+	struct snd_soc_dapm_widget *w;
+	int i;
+
+	/* check if these are actual modules */
+	src_module = audioreach_find_module(scomp, route->source);
+	sink_module = audioreach_find_module(scomp, route->sink);
+
+	if (sink_module && !src_module) {
+		control = audioreach_find_widget(scomp, route->source);
+		if (control)
+			control->module_instance_id = sink_module->instance_id;
+
+	} else if (!sink_module && src_module && route->control) {
+		/* check if this is a virtual mixer */
+		control = audioreach_find_widget(scomp, route->sink);
+		if (!control || !control->w)
+			return 0;
+
+		w = control->w;
+
+		for (i = 0; i < w->num_kcontrols; i++) {
+			if (!strcmp(route->control, w->kcontrol_news[i].name)) {
+				struct soc_mixer_control *sm;
+				struct snd_soc_dobj *dobj;
+				struct snd_ar_control *scontrol;
+
+				sm = (struct soc_mixer_control *)w->kcontrol_news[i].private_value;
+				dobj = &sm->dobj;
+				scontrol = dobj->private;
+				scontrol->module_instance_id = src_module->instance_id;
+			}
+		}
 
-	if (src && sink) {
-		src->dst_mod_inst_id = sink->instance_id;
-		sink->src_mod_inst_id = src->instance_id;
 	}
 
 	return 0;
@@ -928,6 +969,48 @@ static int audioreach_link_load(struct snd_soc_component *component, int index,
 	return 0;
 }
 
+static void audioreach_connect_sub_graphs(struct q6apm *apm,
+					  struct snd_ar_control *m1,
+					  struct snd_ar_control *m2,
+					  bool connect)
+{
+	struct audioreach_graph_info *info;
+
+	mutex_lock(&apm->lock);
+	info = idr_find(&apm->graph_info_idr, m2->graph_id);
+	mutex_unlock(&apm->lock);
+
+	if (connect) {
+		info->src_mod_inst_id = m1->module_instance_id;
+		info->src_mod_op_port_id = 1;
+		info->dst_mod_inst_id = m2->module_instance_id;
+		info->dst_mod_ip_port_id = 2;
+
+	} else {
+		info->src_mod_inst_id = 0;
+		info->src_mod_op_port_id = 0;
+		info->dst_mod_inst_id = 0;
+		info->dst_mod_ip_port_id = 0;
+	}
+}
+
+static bool audioreach_is_vmixer_connected(struct q6apm *apm,
+					   struct snd_ar_control *m1,
+					   struct snd_ar_control *m2)
+{
+	struct audioreach_graph_info *info;
+
+	mutex_lock(&apm->lock);
+	info = idr_find(&apm->graph_info_idr, m2->graph_id);
+	mutex_unlock(&apm->lock);
+
+	if (info->dst_mod_inst_id == m2->module_instance_id &&
+	    info->src_mod_inst_id == m1->module_instance_id)
+		return true;
+
+	return false;
+}
+
 static int audioreach_get_audio_mixer(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
@@ -940,7 +1023,7 @@ static int audioreach_get_audio_mixer(struct snd_kcontrol *kcontrol,
 	struct q6apm *data = dev_get_drvdata(c->dev);
 	bool connected;
 
-	connected = q6apm_is_sub_graphs_connected(data, scontrol->sgid, dapm_scontrol->sgid);
+	connected = audioreach_is_vmixer_connected(data, scontrol, dapm_scontrol);
 	if (connected)
 		ucontrol->value.integer.value[0] = 1;
 	else
@@ -961,10 +1044,10 @@ static int audioreach_put_audio_mixer(struct snd_kcontrol *kcontrol,
 	struct q6apm *data = dev_get_drvdata(c->dev);
 
 	if (ucontrol->value.integer.value[0]) {
-		q6apm_connect_sub_graphs(data, scontrol->sgid, dapm_scontrol->sgid, true);
+		audioreach_connect_sub_graphs(data, scontrol, dapm_scontrol, true);
 		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 1, NULL);
 	} else {
-		q6apm_connect_sub_graphs(data, scontrol->sgid, dapm_scontrol->sgid, false);
+		audioreach_connect_sub_graphs(data, scontrol, dapm_scontrol, false);
 		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 0, NULL);
 	}
 	return 0;
-- 
2.21.0

