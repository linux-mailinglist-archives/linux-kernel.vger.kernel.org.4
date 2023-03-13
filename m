Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21656B73F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCMK2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjCMK2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:28:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8EF7D99
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:28:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u5so12380508plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678703279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GA29AdmgVVjrUahWBqxyGYPCzkyatzgl3p++nYg/M4U=;
        b=NB82Mwb823V0c81X+YN4zDavq3WLbXyiyQ0YgLIkH50z0mdin8/55Zg5YsyefpRiUT
         dQ7qR4Pn4uklLpF9nrEMcor0GR0tW3PJaD9SQSvcwk8srMlIce6Uox6PTX5QD1LZqqQw
         Ww608ElS1ZajeucRl8m6QO59Z13RZ0OP+GA4uuzzC5frvUFCcaVhIyRsWOW49Fj2Q8eR
         WFPetSSxACiyuy5VCQIQNpA/2pPG4VzHQGdnlVJwXO44RC6Bf8+dO1hA/JG9SUU/3fS8
         xbx8BcRqg5+C/qG2nHbDl7cV7GFxxaWqCJU6n+sywexezYq9/wUm2VGvpBO2P8T6Lsfg
         sJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678703279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GA29AdmgVVjrUahWBqxyGYPCzkyatzgl3p++nYg/M4U=;
        b=BO1/Yu8wgsVZHRg5bENoOiSw4C1e1Z78dpJeF8WAWWkPRv91g5zhD0fn/cEzB2JiR4
         oIcqpGUJtoqW7AvMtJKQIQz/lX9beXwWz/dEC88LsfTel18/6IIa/DHiflQxszHd5xf2
         O/7me4836YY2dHmpIC3uLWKkBxlZ3TtC0PWI5P60aT7gujMLKrGfukjX6u7LkqO7oAKG
         HTFt07QNI3lejUZsbC9YgYtkpYJVH6fIIozLVgu50cTwbsTm3JP1h5F1swh2Q2zw/yuH
         cY7sN3y14iX4fXHNxlOXkpZcoZ6QOCqNX+7VNsdCgz05hS2Gq4OE5e6lg+sCsEnrHksO
         u3zg==
X-Gm-Message-State: AO0yUKWFFpqlim/n2G4PZU2LyBKKoEL0KinahUlYRyT6NtQ6jz5hHG69
        EyFD09ykZWb4rMrt0mjlfRU=
X-Google-Smtp-Source: AK7set8pytls/V11kn3aXInC3VuTmd0q1kvWbPU0OPvGDqeGytMkEH7IcYKaW2u7O8V+s/YJkuAkfA==
X-Received: by 2002:a17:90a:be04:b0:23a:177b:5bfa with SMTP id a4-20020a17090abe0400b0023a177b5bfamr33131636pjs.22.1678703279485;
        Mon, 13 Mar 2023 03:27:59 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id ki7-20020a170903068700b0019607aeda8bsm4449988plb.73.2023.03.13.03.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 03:27:59 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, conor.dooley@microchip.com,
        ionela.voinescu@arm.com
Cc:     linux-kernel@vger.kernel.org, Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] arch_topology: Clear LLC sibling when cacheinfo teardown
Date:   Mon, 13 Mar 2023 18:27:52 +0800
Message-Id: <20230313102752.1134472-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The teardown of CPUHP_AP_BASE_CACHEINFO_ONLINE now only invokes
free_cache_attributes() to clear share_cpu_map of cacheinfo list.
At the same time, clearing cpu_topology[].llc_sibling is
called quite late at the teardown code in hotplug STARTING section.

To avoid the incorrect LLC sibling masks generated, move its clearing
right after free_cache_attributes().

Fixes: 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection in the CPU hotplug path")
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 drivers/base/arch_topology.c  | 16 ++++++++++++++--
 drivers/base/cacheinfo.c      |  2 ++
 include/linux/arch_topology.h |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b1c1dd38ab01..8681654d6c07 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -769,6 +769,20 @@ void update_siblings_masks(unsigned int cpuid)
 	}
 }
 
+void clear_llc_topology(unsigned int cpu)
+{
+	int sib;
+
+	for_each_cpu(sib, topology_llc_cpumask(cpu)) {
+		if (sib == cpu)
+			continue;
+		if (last_level_cache_is_shared(cpu, sib)) {
+			cpumask_clear_cpu(cpu, topology_llc_cpumask(sib));
+			cpumask_clear_cpu(sib, topology_llc_cpumask(cpu));
+		}
+	}
+}
+
 static void clear_cpu_topology(int cpu)
 {
 	struct cpu_topology *cpu_topo = &cpu_topology[cpu];
@@ -811,8 +825,6 @@ void remove_cpu_topology(unsigned int cpu)
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
 	for_each_cpu(sibling, topology_cluster_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_cluster_cpumask(sibling));
-	for_each_cpu(sibling, topology_llc_cpumask(cpu))
-		cpumask_clear_cpu(cpu, topology_llc_cpumask(sibling));
 
 	clear_cpu_topology(cpu);
 }
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index f6573c335f4c..1c276b30fd5a 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/sysfs.h>
+#include <linux/arch_topology.h>
 
 /* pointer to per cpu cacheinfo */
 static DEFINE_PER_CPU(struct cpu_cacheinfo, ci_cpu_cacheinfo);
@@ -814,6 +815,7 @@ static int cacheinfo_cpu_pre_down(unsigned int cpu)
 		cpu_cache_sysfs_exit(cpu);
 
 	free_cache_attributes(cpu);
+	clear_llc_topology(cpu);
 	return 0;
 }
 
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index a07b510e7dc5..1279ba2eb4a4 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -89,6 +89,7 @@ void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 const struct cpumask *cpu_clustergroup_mask(int cpu);
 void update_siblings_masks(unsigned int cpu);
+void clear_llc_topology(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
-- 
2.20.1

