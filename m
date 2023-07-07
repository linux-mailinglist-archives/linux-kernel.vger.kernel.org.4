Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C121074AA0D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjGGErs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjGGErd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:47:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E592121
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:46:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8c81e36c0so6356815ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 21:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688705218; x=1691297218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FOcqYStjaEQ6e41x7ko6U0Q7unE1KNRPYn3wRQMvZDI=;
        b=TYgKO3N5/8AF1DSrz62f/fVEd8Ub/T0GTEjqgOc/CnmNJDa/3aQ78ZZH9tlDgabtFW
         af5rbQLq7ZJ7TK7/GQZ+8VKbXdqs5RaFnVVxmDXz77LBVugNv3nFHLyQ02pFOKH6OqFD
         Adx8qDN1gFulXupcAHzjOeG+9nbm3L8Fc33n6c8UJRUj97T5YRh2GiZXbRIN5EGPnBFj
         cfJpW3pWCwk4sco7Dxke460vunPL47JNi53q9bQAGiUUjHVoCEEW0FS7CUWgbD6iE26w
         qd7KS3hDflwBTEsSrO5vyvk0LpVLRUBfxwyjegH12S5YGMor9x3yhdjKiQi8Fu2SyyyO
         9KbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688705218; x=1691297218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOcqYStjaEQ6e41x7ko6U0Q7unE1KNRPYn3wRQMvZDI=;
        b=OhANxo1px+sXylXJ1cqi8sP4nFBEJVH4ivyvbrA/TdbpSnaPay9D9OZ/uaVap8cJrq
         ebGmxOIQz0yVmb+Ut0WWNUOVCda0S2ovyOkitHSbSbv2Z2/8B9mq9aEv4q31Mz1PwpQw
         8/RX6IUGU7JH9jNjZ7hlnlGMSFmgJn3ApDuYNz6dHiY+kO7YLIhcMkE/lPkRv3CYRhTi
         jgPMO08EEw47C7BF3jck0/rPSPsj7B6n0ygBYoL1UOM6qFML0ExsuSsy34GzKK5AfY2b
         l2l3XO68L0CLmGhXPBcMgk1V+7OEtUtwcEE6vXKeVxPesXAEG+OUwFHpJsNaUBNo87OS
         0RAA==
X-Gm-Message-State: ABy/qLaBPJdoU18HibDftmVxb1E6GHzjop6PoePp5GMtra54qD6Mdah+
        3wEiXA8RBOSetnAbQ0CqF5cu0A==
X-Google-Smtp-Source: APBJJlHb8cX+0KMLn+D06cRMztmkT8KQkZHyFAw/d3ujFt0BRPy1YxSFDgU25z1DlZoH715my6Kvhg==
X-Received: by 2002:a17:902:7c0a:b0:1b4:65c3:ca68 with SMTP id x10-20020a1709027c0a00b001b465c3ca68mr405138pll.66.1688705217824;
        Thu, 06 Jul 2023 21:46:57 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id bc8-20020a170902930800b001ac95be5081sm2193423plb.307.2023.07.06.21.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 21:46:57 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     david@redhat.com, yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH 1/2] memcg: Add support for zram object charge
Date:   Fri,  7 Jul 2023 12:46:49 +0800
Message-Id: <20230707044649.1169155-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compressed RAM is currently charged to kernel, not to
any memory cgroup, which is not satisfy our usage scenario.
if the memory of a task is limited by memcgroup, it will
swap out the memory to zram swap device when the memory
is insufficient. In that case, the memory limit will have
no effect. So, it should makes sense to charge the
compressed RAM to the page's memory cgroup.

As we know, zram can be used in two ways, direct and
indirect, this patchset can charge memory in both cases.
Direct zram usage by process within a cgroup will fail
to charge if there is no memory. Indirect zram usage by
process within a cgroup via swap in PF_MEMALLOC context,
will charge successfully.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 include/linux/memcontrol.h | 10 ++++++++++
 mm/memcontrol.c            | 23 +++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..716cc08a6527 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1819,6 +1819,8 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
+int obj_cgroup_charge_zram(struct obj_cgroup *objcg, size_t size);
+void obj_cgroup_uncharge_zram(struct obj_cgroup *objcg, size_t size);
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1880,6 +1882,14 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 {
 }
 
+int obj_cgroup_charge_zram(struct obj_cgroup *objcg, size_t size)
+{
+	return 0;
+}
+
+void obj_cgroup_uncharge_zram(struct obj_cgroup *objcg, size_t size)
+{
+}
 #endif /* CONFIG_MEMCG_KMEM */
 
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..e1d2c084c132 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3059,6 +3059,7 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
 	}
 	return objcg;
 }
+EXPORT_SYMBOL(get_obj_cgroup_from_page);
 
 static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
 {
@@ -3409,6 +3410,28 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 	refill_obj_stock(objcg, size, true);
 }
 
+int obj_cgroup_charge_zram(struct obj_cgroup *objcg, size_t size)
+{
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return 0;
+
+	/*
+	 * Indirect zram usage in PF_MEMALLOC, charging must succeed.
+	 * Direct zram usage, charging  may failed.
+	 */
+	return obj_cgroup_charge(objcg, GFP_KERNEL, size);
+}
+EXPORT_SYMBOL(obj_cgroup_charge_zram);
+
+void obj_cgroup_uncharge_zram(struct obj_cgroup *objcg, size_t size)
+{
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
+	obj_cgroup_uncharge(objcg, size);
+}
+EXPORT_SYMBOL(obj_cgroup_uncharge_zram);
+
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
-- 
2.25.1

