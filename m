Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172E25EB1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiIZUAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIZUAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:00:07 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F2218B39
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:00:06 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k11-20020aa792cb000000b00558674e8e7fso1478771pfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date;
        bh=u8rmArpPmicN7r7IqqfOH58XS1KpMBR85FAb+1BiVJU=;
        b=C6QG8W0A2jE6D9CQn2zjFYStoqzefhTb8kQ0+ijebpJ1iSqL6VRR47hdRXsQpQZRVi
         ZOj5ZWqu7FVHPGLKRJAWVuGzZn23oT10mF9H0WOIU0KpWTD8WN80nUS552n8T4H/yEBZ
         rMhciPLFY9Je4vstINLc/UQ/85IuMlR7kYYAymiC0v4Hao/DMK81RACr0ZE4nAzyFP9V
         aD++IHQNCyi0epayDNuUvnT/hxLpafzq+rCUieYLFH+PgLPrllui+HqgROCEF4rQJUne
         rtqFcIJMzjUQ9VpxXKNRzWBxH1E1W/migdx00pRZO5ak5EfRPMTN54xKK0uC98ljG4IJ
         g71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date;
        bh=u8rmArpPmicN7r7IqqfOH58XS1KpMBR85FAb+1BiVJU=;
        b=EBMGH1BFCk0zkI4oDFNF83H20lEMKKJZ2xY3eSCc6Tf7ninJfT1ggBYPnHfgfjnSvO
         JCGJ2iR61nx3r3SC0qtXxQF2gQebO/q6FrIHBX6uztwJF6v8rdDaU/Dy8Ow57ysm2hQi
         EYxcdyXsF4wm+0pWmo1Ic1UiR/A5jM7wCHFYmgjKXGwLnO81XzEEpPwtxTcbbbEUV840
         Wi/r7V1C7EgPHiX15nS202E6PObAoMXJ+UY+G4xWSTFSqWnv69dYXSzx9u21avVAQH2C
         FWhJtA3q12wEs1BY45szXBPr/z7nTvkLrRZqusm9Du+UjLWZdFkBoomDZH9ozyqDXwk4
         PjBA==
X-Gm-Message-State: ACrzQf0TTzapWwuxmxpYSyFmOMcxd3SZL9GGRBckBeXENkeChCwtkl9J
        ZvmGAQ1yxX2pFT/wO0J5dnLGHrubOihGmA==
X-Google-Smtp-Source: AMsMyM72e61Isv3ASb63QLAzd7GvOLG+tEJK6e7CFKXgBs5ZWj9r2NR1UKykIJb3sCI21UgLY3T5MyF00bC9xw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:9a9:b0:541:787f:f2c with SMTP id
 u41-20020a056a0009a900b00541787f0f2cmr25633816pfg.12.1664222405512; Mon, 26
 Sep 2022 13:00:05 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:59:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926195931.2497968-1-shakeelb@google.com>
Subject: [PATCH] Revert "net: set proper memcg for net_init hooks allocations"
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Anatoly Pugachev <matorola@gmail.com>,
        Vasily Averin <vvs@openvz.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9.

Anatoly Pugachev reported that the commit 1d0403d20f6c ("net: set proper
memcg for net_init hooks allocations") is somehow causing the sparc64
VMs failed to boot and the VMs boot fine with that patch reverted. So,
revert the patch for now and later we can debug the issue.

Reported-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Cc: Vasily Averin <vvs@openvz.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/memcontrol.h | 45 --------------------------------------
 net/core/net_namespace.c   |  7 ------
 2 files changed, 52 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ef479e554253..e1644a24009c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1787,42 +1787,6 @@ static inline void count_objcg_event(struct obj_cgro=
up *objcg,
 	rcu_read_unlock();
 }
=20
-/**
- * get_mem_cgroup_from_obj - get a memcg associated with passed kernel obj=
ect.
- * @p: pointer to object from which memcg should be extracted. It can be N=
ULL.
- *
- * Retrieves the memory group into which the memory of the pointed kernel
- * object is accounted. If memcg is found, its reference is taken.
- * If a passed kernel object is uncharged, or if proper memcg cannot be fo=
und,
- * as well as if mem_cgroup is disabled, NULL is returned.
- *
- * Return: valid memcg pointer with taken reference or NULL.
- */
-static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
-{
-	struct mem_cgroup *memcg;
-
-	rcu_read_lock();
-	do {
-		memcg =3D mem_cgroup_from_obj(p);
-	} while (memcg && !css_tryget(&memcg->css));
-	rcu_read_unlock();
-	return memcg;
-}
-
-/**
- * mem_cgroup_or_root - always returns a pointer to a valid memory cgroup.
- * @memcg: pointer to a valid memory cgroup or NULL.
- *
- * If passed argument is not NULL, returns it without any additional check=
s
- * and changes. Otherwise, root_mem_cgroup is returned.
- *
- * NOTE: root_mem_cgroup can be NULL during early boot.
- */
-static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *mem=
cg)
-{
-	return memcg ? memcg : root_mem_cgroup;
-}
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1879,15 +1843,6 @@ static inline void count_objcg_event(struct obj_cgro=
up *objcg,
 {
 }
=20
-static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
-{
-	return NULL;
-}
-
-static inline struct mem_cgroup *mem_cgroup_or_root(struct mem_cgroup *mem=
cg)
-{
-	return NULL;
-}
 #endif /* CONFIG_MEMCG_KMEM */
=20
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 6b9f19122ec1..0ec2f5906a27 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -18,7 +18,6 @@
 #include <linux/user_namespace.h>
 #include <linux/net_namespace.h>
 #include <linux/sched/task.h>
-#include <linux/sched/mm.h>
 #include <linux/uidgid.h>
 #include <linux/cookie.h>
=20
@@ -1144,13 +1143,7 @@ static int __register_pernet_operations(struct list_=
head *list,
 		 * setup_net() and cleanup_net() are not possible.
 		 */
 		for_each_net(net) {
-			struct mem_cgroup *old, *memcg;
-
-			memcg =3D mem_cgroup_or_root(get_mem_cgroup_from_obj(net));
-			old =3D set_active_memcg(memcg);
 			error =3D ops_init(ops, net);
-			set_active_memcg(old);
-			mem_cgroup_put(memcg);
 			if (error)
 				goto out_undo;
 			list_add_tail(&net->exit_list, &net_exit_list);
--=20
2.37.3.998.g577e59143f-goog

