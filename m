Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D5466DB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbjAQKwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbjAQKvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:51:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E98301A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:51:40 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v23so28215918plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7/muQR36FzdhRlp2NSJbCS4oM2tTMQvy93n5Di6qIkk=;
        b=fHtxGEY0+0tj3Evx93ZJ+Vt1JdvQFW66gp8LIt3jLp+7B75+1BG0xXwqwjUEwLX4RR
         i/crUhbEH9L8Q6QdIoyCCstL75R1yuPhpgh0qnQpBx5Iqm0WtimbDvuArVmVT3auWQkn
         g+uklRQmWPeA068mhBKVkFiTB5eAPDVzD6FJJrT9CO0Ia3OMwgn5y6dO5kT3BiQ8r8Yt
         kNCywArK7nYSJT+9NCF/4p690eZO0aq70pOHsiYl0NOfc0U2CPB6KTCVFfb9O1pkyDh/
         idSLtFSX5FfNsTFBAbMLBVyMs5ljqphudBS1sdHfy+R/rtPclvfYdaJTDW4KtiS1YOjk
         wwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/muQR36FzdhRlp2NSJbCS4oM2tTMQvy93n5Di6qIkk=;
        b=veq+qv3BH59n5vvRtqEHM97Vliv8NMiKHxQIg4Ojpap/+wDE95iEEkC7IuM6ljmRq4
         bbR4icP8wCa5EbIbty4zb5pIqxLCHWiEubg1oF/T9X/Src0CqShPt2p4elLlNBaf7yvC
         uJPDujJNRyObF6v7HQzRiapH84xTwDJn0bjiDGelIcnKFp/b7BmnvbJ3CVdPAHwU64tk
         CNYsYgCFWnZ6ySX6A4X9KZVcGS2w6o03zl+SGaVVpYgg2Z/rSaiJzu0RYERr+9s3oPeW
         dbsNagefPd6xdfr0D03aIArG8zF6f0JBiJkNDMEiZ8Z1fu5gNOk9ez8OWx2J1tF/FwZO
         0SAw==
X-Gm-Message-State: AFqh2kp5QuweFCpIEYUB73oZwRFyyRfmDr9BBvFRSGiQkhgYY6HAPNcO
        d0+t9MYLD2U1FlDv46UhZlRPhQ==
X-Google-Smtp-Source: AMrXdXv3lg0fyC3tpeuKkIK0DZePYc9cvMgXRgMdWjgffS97LYx3HpM8ECdSTk/ea66foo9jQHhD/A==
X-Received: by 2002:a17:902:e495:b0:192:8bee:3e29 with SMTP id i21-20020a170902e49500b001928bee3e29mr2492814ple.2.1673952700115;
        Tue, 17 Jan 2023 02:51:40 -0800 (PST)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902eb8b00b00189c93ce5easm20848645plg.166.2023.01.17.02.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 02:51:39 -0800 (PST)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>
Subject: [PATCH -next v4 1/1] drivers: base: cacheinfo: fix shared_cpu_map
Date:   Tue, 17 Jan 2023 10:51:33 +0000
Message-Id: <20230117105133.4445-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117105133.4445-1-yongxuan.wang@sifive.com>
References: <20230117105133.4445-1-yongxuan.wang@sifive.com>
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
 drivers/base/cacheinfo.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 950b22cdb5f7..f05acf3c16c6 100644
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
@@ -284,11 +284,13 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 
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
+					break;
+				}
 			}
 		}
 		/* record the maximum cache line size */
@@ -302,7 +304,7 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 static void cache_shared_cpu_map_remove(unsigned int cpu)
 {
 	struct cacheinfo *this_leaf, *sib_leaf;
-	unsigned int sibling, index;
+	unsigned int sibling, index, sib_index;
 
 	for (index = 0; index < cache_leaves(cpu); index++) {
 		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
@@ -313,9 +315,14 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
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
+					break;
+				}
+			}
 		}
 	}
 }
-- 
2.17.1

