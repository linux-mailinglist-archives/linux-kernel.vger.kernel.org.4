Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8521165724D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 04:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiL1DYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 22:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1DYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 22:24:31 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B14111F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:24:30 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so14865862pjj.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 19:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lg9AemSDBBtPgi+gxybZhgVqgogKaNYTLFoPq09XgqM=;
        b=cXoinuhxVaAIWNm1NatnbHHeEIpKAOuJhwy2oFubS7LfHxzUAXafkvzk4bhBbDK5LX
         EcAFTT3pvoPd+Xd9Z5gJHskrd+Wl5jIJMXHGgbKz/jQwGFclUkzrs0+dy8+sFkDyJ9Bb
         KdZx6KDJEV6pZ30c4e7EVfEMl2Tez2vbPRIhXDxa8xerCzH3rB7XUJcKUENhcv2hK+Fi
         KJMpgDVZxx9uIcx7psKeyyvQVk19opYUNMbQMsJt0daKTkrKkljH2FyRlJIA3tRQ500T
         OH9YDs7fUtbEnrh6dx08dQ5iApVoCb/rlz9+6L/K8spIveqxnOg/F9QyTYYzVoufv0eN
         E4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lg9AemSDBBtPgi+gxybZhgVqgogKaNYTLFoPq09XgqM=;
        b=21juA0L/tW0p6VUXLe1/SP3MUPcPCPx3BhzzHgcNamtbWxRUuH65sqXCq3uXPvGPDw
         1RTBIqXV0wFNUbzj8s+vuMhXOFcWtEJrJQd+0jViEdPRay6QEyAeM5cegcMo3SObv/Jw
         /c583kvBN7d+0immXA929TssE8bzW8KWN2A/HCQtcTxbaYH7BQDTTcva9TDf4BQvjAG1
         VFvxbuIUwJ3Ckl1fuMGGV+Qm3OV49oQsxtLHgdtNwnpNSJAdVdAnh3/+pZLEr/7Ja5U8
         2zO/0PTsq1Rywmq5T0/fFyyO0n5yl9maOIAFlcltJqCkvvE2wJdxn0LP1PTJGoiX/0RJ
         r1aA==
X-Gm-Message-State: AFqh2koATaG5GAQ9k4LHTrGgNODYaU29plDfGvtqpmmAaotGOKI9jvxf
        iNekNaPSeaymZZq9lAw6AiarLQ==
X-Google-Smtp-Source: AMrXdXugeM9fDEFE30iWl10TkTZUFawr14H2VtIppwlQfkQSBnDjBRp+Zdtwp/NgdKhik7EF5s5lKw==
X-Received: by 2002:a17:90a:6002:b0:216:cdc7:58bb with SMTP id y2-20020a17090a600200b00216cdc758bbmr27332222pji.34.1672197869998;
        Tue, 27 Dec 2022 19:24:29 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m7-20020a17090a668700b0020aacde1964sm7289925pjj.32.2022.12.27.19.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 19:24:29 -0800 (PST)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH -next v3] drivers: base: cacheinfo: fix shared_cpu_map
Date:   Wed, 28 Dec 2022 03:24:19 +0000
Message-Id: <20221228032419.1763-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221228032419.1763-1-yongxuan.wang@sifive.com>
References: <20221228032419.1763-1-yongxuan.wang@sifive.com>
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

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 drivers/base/cacheinfo.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 950b22cdb5f7..dfa804bcf3cc 100644
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
+				sib_leaf = per_cpu_cacheinfo_idx(i, sib_index);
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
+				sib_leaf = per_cpu_cacheinfo_idx(sibling, sib_index);
+				if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
+					cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
+					cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
+				}
+			}
 		}
 	}
 }

base-commit: c76083fac3bae1a87ae3d005b5cb1cbc761e31d5
-- 
2.17.1

