Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC106509C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiLSKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSKKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:10:45 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C738BF6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:10:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o12so8520310pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mLbjW+qQKAVjevWhZRwoS7hAq/qYuWyXmXjZkQOvWY=;
        b=BfPnCAnU8ulgvuR+MIF+tCVSqZe0becNftAW0D1x7Kj+25g6GF//btYC5natEZooQp
         dE02ohJRNXeMAq5k6XR8avknG0s7IOaGLQUHqQiISc87ptU7x11NFtMrjRf+PLDg/55z
         x3O1coESCIjZc31XPWnPwTt2KuxaaiyhFgPEf+hlbzuQ3Kp+9r3052SD0kiEZ5GJs4Ym
         vHmEwinUUScBZEuBIWF3+OETpX3eWweL8WiCv2dRmm8Y/VBjMqFA8RiEtCTFBQCqlEKM
         UCLcJJW9P32/tii1rlVP9gCudG9/iZy7UOsr1oa83fZ5cjXzICetJSbcBeNjgukyD3hr
         MTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mLbjW+qQKAVjevWhZRwoS7hAq/qYuWyXmXjZkQOvWY=;
        b=uxUD6ncHZJgPuOwO41a6ZllU/DxYALweyb7+LmCyNu2HHFHqKAz4ZuH79+QTVbfmA7
         USevgM0jKpY3SqydgFnAcJ5TdfxdXvoR0kebMd5yMjs6jQWxZgNzjp5Q1+TTf3a/9bOa
         LUkJ8ogtDjkR/EdMRWPPpRkcnUUtj5lgeIeiBpoadxkTvbGBXxY+Op47dvmnzYlFzwO2
         kR2HOVmQnzuOGfGVkmLkw9mRyPTLQ42ux8J4svjQnVAbnu+N1x49N2qcxrbWyTMdz3nl
         ik+pfTrCHI9LMaemXFmR6HPtm2fli/wMgL6zIgpgLsPO7LM4LSjZoncoI7lm7jlp20Kk
         KNCQ==
X-Gm-Message-State: AFqh2krEoXujzRn4JL4b8vvVczM19soPuk2tsKF50hSgAdhkl/5/ZCo0
        pnY4BArUCegeIaLiRnFc/8YU/A==
X-Google-Smtp-Source: AMrXdXuR8BddjCMYU0yTHnBT2Y7U/Ro4KQ1z7sh/W2H3j/8tjqOFALrqckV32FQhhsAWcy8wDiXbYg==
X-Received: by 2002:a05:6a20:6daf:b0:b0:76a:51ab with SMTP id gl47-20020a056a206daf00b000b0076a51abmr7418559pzb.26.1671444642874;
        Mon, 19 Dec 2022 02:10:42 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00008400b0056bd1bf4243sm6234367pfj.53.2022.12.19.02.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:10:42 -0800 (PST)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH] drivers: base: cacheinfo: fix shared_cpu_map
Date:   Mon, 19 Dec 2022 10:10:36 +0000
Message-Id: <20221219101036.12804-1-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
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
 drivers/base/cacheinfo.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index dad296229161..815a1398ea16 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -219,7 +219,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf, *sib_leaf;
-	unsigned int index;
+	unsigned int index, sib_index;
 	int ret = 0;
 
 	if (this_cpu_ci->cpu_map_populated)
@@ -247,8 +247,10 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 
 			if (i == cpu || !sib_cpu_ci->info_list)
 				continue;/* skip if itself or no cacheinfo */
-			sib_leaf = sib_cpu_ci->info_list + index;
-			if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
+			for (sib_index = 0; sib_index < cache_leaves(i); sib_index++) {
+				sib_leaf = sib_cpu_ci->info_list + sib_index;
+				if (!cache_leaves_are_shared(this_leaf, sib_leaf))
+					continue;
 				cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
 				cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
 			}
@@ -265,7 +267,7 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf, *sib_leaf;
-	unsigned int sibling, index;
+	unsigned int sibling, index, sib_index;
 
 	for (index = 0; index < cache_leaves(cpu); index++) {
 		this_leaf = this_cpu_ci->info_list + index;
@@ -279,9 +281,13 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 			if (!sib_cpu_ci->info_list)
 				continue;
 
-			sib_leaf = sib_cpu_ci->info_list + index;
-			cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
-			cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
+			for (sib_index = 0; sib_index < cache_leaves(sibling); sib_index++) {
+				sib_leaf = sib_cpu_ci->info_list + sib_index;
+				if (!cache_leaves_are_shared(this_leaf, sib_leaf))
+					continue;
+				cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
+				cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
+			}
 		}
 		if (of_have_populated_dt())
 			of_node_put(this_leaf->fw_token);
-- 
2.17.1

