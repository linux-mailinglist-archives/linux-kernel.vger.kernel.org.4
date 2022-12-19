Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EB8650A62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiLSKvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiLSKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:51:42 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEC16274
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:51:41 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id t2so8651996ply.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aoXKo5gwMfMTDXoktkXWsb7tmACKeS9eN3NNawuDzcc=;
        b=fSqrFYTIFneXH9rhfOBI25A8wop6zZtewwBI+s9dJnKdxjszasiJVS+STLfysMPcsv
         xZG7A/mTdSjL1+bdNmj6eocGcy9C6O+mlOQtZuzt+LrdDDHJjZL0GCRA44T4KmOk9FKO
         TDTVsdgiUnoUoK0NjbOzTF/1+4ezzM3me6l/Ico7nb7RNGRucoA56UMoZgGP265jlOOK
         9wSsJiFNvPxbi9Z1OqgB4bkTj4sLEGiEssBP2E++CpyVhWNI+/XtQvQ+ZxF/scXYI46p
         WKj/UyXDSdYyo8KBI3r/utEMDaTje2KHV0Q0RI3QylTcv626NCIpDVjth4azq1QpvMBb
         USBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoXKo5gwMfMTDXoktkXWsb7tmACKeS9eN3NNawuDzcc=;
        b=uicf0RpWt0EC+oNE4tnYwYoklsETWCQlYskXFanYJJdrUVgopwHgYvb42aQXNMSY/G
         uwt2uGyKFz3CrWQpvicYt10qJGR5W/HxQdb/PztjjCC2kaLKDxcz/h/sB+oGHyed2Es5
         f4i4dNGkF2RAt6pZk9ZPXMQnaOwxhVu6zTGccVZUUTkyM8vuSeLPfpRzm3g1dWgk7Evr
         RyM0c8oylFE4iroaKkiUoe4fcXytfTZcjrYfdK+j0SVaJ2976bffkgJqqv2FJVSt2nDf
         DoutZKYKyDdmpnSBa0Xl3jGyTxzobUX6FDQzsgmcveyym6dMoeOKQfnIIlzNQxkbkXnB
         RZ3w==
X-Gm-Message-State: AFqh2kr4vEO6dyOU6uoJKSBGAWZWJhpIXAaMLAiA6kvzsQ/vQaS03Ulg
        IQaUqZm14fE9Otltu+kF/hWzyA==
X-Google-Smtp-Source: AMrXdXtdq2NVO1CzQr/N+Gy8ZtuXLCuqbqswlxNq4XaQzJVn6lm50WlCbxA1lnThxon8z0iVUzZJPw==
X-Received: by 2002:a17:902:8343:b0:191:2b76:612c with SMTP id z3-20020a170902834300b001912b76612cmr604800pln.62.1671447101336;
        Mon, 19 Dec 2022 02:51:41 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id s24-20020a63f058000000b00473c36ea150sm6016407pgj.92.2022.12.19.02.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:51:41 -0800 (PST)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH v2 1/1] drivers: base: cacheinfo: fix shared_cpu_map
Date:   Mon, 19 Dec 2022 10:51:32 +0000
Message-Id: <20221219105132.27690-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219105132.27690-1-yongxuan.wang@sifive.com>
References: <20221219105132.27690-1-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cacheinfo sets up the shared_cpu_map by checking whether the caches
with the same index are shared between CPUs. However, this will trigger
slab-out-of-bounds access if the CPUs do not have the same cache hierarchy.
Another problem is the mismatched shared_cpu_map when the shared cache does
not have the same index between CPUs.

CPU0	I	D	L3
index	0	1	2	x
	^	^	^	^
index	0	1	2	3
CPU1	I	D	L2	L3

This patch checks each cache is shared with all caches on other CPUs.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 drivers/base/cacheinfo.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 950b22cdb5f7..d38f80f6fff1 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -256,7 +256,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf, *sib_leaf;
-	unsigned int index;
+	unsigned int index, sib_index;
 	int ret = 0;
 
 	if (this_cpu_ci->cpu_map_populated)
@@ -284,11 +284,12 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 
 			if (i == cpu || !sib_cpu_ci->info_list)
 				continue;/* skip if itself or no cacheinfo */
-
-			sib_leaf = per_cpu_cacheinfo_idx(i, index);
-			if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
-				cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
-				cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
+			for (sib_index = 0; sib_index < cache_leaves(i); sib_index++) {
+				sib_leaf = per_cpu_cacheinfo_idx(i, sib_index);;
+				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
+					cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
+					cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
+				}
 			}
 		}
 		/* record the maximum cache line size */
@@ -302,7 +303,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 static void cache_shared_cpu_map_remove(unsigned int cpu)
 {
 	struct cacheinfo *this_leaf, *sib_leaf;
-	unsigned int sibling, index;
+	unsigned int sibling, index, sib_index;
 
 	for (index = 0; index < cache_leaves(cpu); index++) {
 		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
@@ -313,9 +314,13 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 			if (sibling == cpu || !sib_cpu_ci->info_list)
 				continue;/* skip if itself or no cacheinfo */
 
-			sib_leaf = per_cpu_cacheinfo_idx(sibling, index);
-			cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
-			cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
+			for (sib_index = 0; sib_index < cache_leaves(sibling); sib_index++) {
+				sib_leaf = per_cpu_cacheinfo_idx(sibling, sib_index);;
+				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
+					cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
+					cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
+				}
+			}
 		}
 	}
 }
-- 
2.17.1

