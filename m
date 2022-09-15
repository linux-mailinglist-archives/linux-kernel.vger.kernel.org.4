Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0C5B9B04
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiIOMjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIOMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:38:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8821983F24
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:57 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso12919163wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Sr1UfmKo/5TRBZLXzJD4DkSvxdVH2UE4dAA9W8/Rm7A=;
        b=LNyn9+DedkSAToLvnrmjcql1/S8NkLjO237hXw6w1zKKGlOvLTOrya5b9etSFFiK5a
         a2IIZDxLWWfmN6gGpPRe4O8czWW4MAUj1SNVfzfSQrnUtVNTyzNs5lskjd7PRyLxS9up
         uHJJZlLYjmV15Gf1gRYT4Xd4/EY68prTPyi+QIJQHQwQXt4a8W3GHFnooq6+yIbknbWf
         SCP6cI1nVSbhZObQlHFB/glvq72I5D6lkY54rhkCjbeHP68HjxpH4O4TqpkjwcKpQvSm
         n6lYbe8TzKVjHpXZKyzuyM96lC590CARoBR/M1/8B6iOD0PZTRLImprsjxkSsL4JV2De
         cbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Sr1UfmKo/5TRBZLXzJD4DkSvxdVH2UE4dAA9W8/Rm7A=;
        b=fMGRkNw+UQ25zqzoQ/kTYhrAwdFKKFuW6M8peocUEr22SeFcNJ78DuSraCaFCVIb/z
         dvkL48jTWL9GbANIc/n1QXSzS7DcOk6aLxfexwMJ+gqBOqNGwLrTEKNSGsXFMgLq0GKJ
         UuaibeXeYztPOuC4waAAUd//fJMBMA9VBoLsEX7W9kTtbIEnRd3BFk+LwBeYE7bFFXsv
         fuQ4ZS6EZWdoc3rYI0qNYnjp5FrtaFCkPkelL6YdcXJNYo8teXXorOZXzpglhErJYZb/
         RzjAGO7o3TQ29wNxDwsaC49UdCvbItE5FQW3JBs934badW5xFA/ArGGnPOFId22pBtoK
         b6/A==
X-Gm-Message-State: ACgBeo1b5D5/6AYhEnLaG75uwl6mYTPX3Ev656SQaEWYZmuDyBIC0IZU
        2tTlhQ0LyPgQVVc0/c8XC+ndBg==
X-Google-Smtp-Source: AA6agR5Y5Tg5yO67Rm0vAjfIHvHG/133jBAHaRJ1ZsbyyWLUrzJn1JVpCiUVBeXD1C3AYA+KIkj65w==
X-Received: by 2002:a05:600c:a43:b0:3b4:9250:781f with SMTP id c3-20020a05600c0a4300b003b49250781fmr6757885wmq.110.1663245535995;
        Thu, 15 Sep 2022 05:38:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id bg13-20020a05600c3c8d00b003a5f4fccd4asm3112559wmb.35.2022.09.15.05.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:38:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/9] ASoC: qdsp6: audioreach: simplify module_list sz calculation
Date:   Thu, 15 Sep 2022 13:38:33 +0100
Message-Id: <20220915123837.11591-6-srinivas.kandagatla@linaro.org>
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

Simplify module_list size calcuation by doing inside modules loop.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/audioreach.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index 783211fc0d87..bae0b7f67e0b 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -430,7 +430,6 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info
 	struct audioreach_sub_graph *sgs;
 	struct apm_mod_list_obj *mlobj;
 	struct list_head *sg_list;
-	int num_modules_per_list;
 	int num_connections = 0;
 	int num_containers = 0;
 	int num_sub_graphs = 0;
@@ -453,6 +452,9 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info
 		list_for_each_entry(container, &sgs->container_list, node) {
 			num_containers++;
 			num_modules += container->num_modules;
+			ml_sz = ml_sz + sizeof(struct apm_module_list_params) +
+				APM_MOD_LIST_OBJ_PSIZE(mlobj, container->num_modules);
+
 			list_for_each_entry(module, &container->modules_list, node) {
 				if (module->src_mod_inst_id)
 					num_connections++;
@@ -461,11 +463,11 @@ void *audioreach_alloc_graph_pkt(struct q6apm *apm, struct audioreach_graph_info
 	}
 
 	num_modules_list = num_containers;
-	num_modules_per_list = num_modules/num_containers;
 	sg_sz = APM_SUB_GRAPH_PSIZE(sg_params, num_sub_graphs);
 	cont_sz = APM_CONTAINER_PSIZE(cont_params, num_containers);
-	ml_sz =	ALIGN(sizeof(struct apm_module_list_params) +
-		num_modules_list * APM_MOD_LIST_OBJ_PSIZE(mlobj,  num_modules_per_list), 8);
+
+	ml_sz = ALIGN(ml_sz, 8);
+
 	mp_sz = APM_MOD_PROP_PSIZE(mprop, num_modules);
 	mc_sz =	APM_MOD_CONN_PSIZE(mcon, num_connections);
 
-- 
2.21.0

