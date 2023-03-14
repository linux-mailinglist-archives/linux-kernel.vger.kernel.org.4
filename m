Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A476B8C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCNHyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjCNHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:53:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB0D126E7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:53:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso628433pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678780431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=REZq+KnWqonCVzM6/fMMTlvObgutUJ1WPPjvLPCRSqM=;
        b=H/MXFf2+PUHynARpD2H1uDIZ9aYybBlEXbX+FvhuS8WLF2uCJEPqMp/LZ0ADSSNGk5
         TgLnmLuj4qAmOTz6jRuRKF/paCGm/q35Y6wy/CRG+aSgmFN6ksuvUUh2/4coH7dUbNBa
         A5tc8VuyqUUVP/XYN0GGJJjDqGVzikr4VGp2HBztujUijIKzU7UhU6JDXJMsb7Ju9sE4
         GfJcaxJ5DabynjP7QbRBnUdS9RRCDgrMpj/YmEd/Oui9QBRYETXvCsGD8vkyvj7jZC1f
         7msiPelDKtvelgsGtckfuBgBqSfC1QZOvU/LLGPtaMsCGRMsT4Qut+Vedo5NDXkJUf8N
         xajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678780431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REZq+KnWqonCVzM6/fMMTlvObgutUJ1WPPjvLPCRSqM=;
        b=H9IPl8OmxhAJZld38w+VKrTVFVFEdbTWYZovbunQXjyEtE99FIdlTsjFlINjiyxgNs
         WFPbglAoqr2LvrYWWzFf9zaKGODjM/qCEyl/G77eFC+qGyxjlpiXrf1v4nu9O4JUTG8T
         ShUaSi4e2vYJNUwk91xUlNsJizKPMPGtEs3Kc8h88pEo67ETbD33wMxQN1fjnAa3wpsM
         cetIPlVo0jBZS4AdiaDSF4oRZy5gNOpO0RK5KzhvBQpHKyCC8gwyHlBCkD6O6sRWeUU2
         5OX2Fwz5T81jMpGFuUkJVb6iQZUhWqgceQh00ZbwbjcP//KpPwDYbIu1C7WTopl7cf2M
         /l4A==
X-Gm-Message-State: AO0yUKWwauRbWocjlyfUFGmKogTWaDiwg8U3ZjGF2y6WJeGrxGSf1QMr
        /QrR+uIAJOmxOuN/5dVaLQQ=
X-Google-Smtp-Source: AK7set8ffNHkTVznc4cJjspHaafZoppr6Zd1xyzg18fak7pUFarwhwuQaiJDD7xwBbwk74/Fl91OZw==
X-Received: by 2002:a05:6a21:33a2:b0:cd:97f3:25e1 with SMTP id yy34-20020a056a2133a200b000cd97f325e1mr48543299pzb.51.1678780431267;
        Tue, 14 Mar 2023 00:53:51 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7900d000000b00624f6dd2414sm975070pfo.97.2023.03.14.00.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 00:53:50 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, conor.dooley@microchip.com,
        ionela.voinescu@arm.com
Cc:     linux-kernel@vger.kernel.org, Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH V2] arch_topology: Clear LLC sibling when cacheinfo teardown
Date:   Tue, 14 Mar 2023 15:53:45 +0800
Message-Id: <20230314075345.1325187-1-suagrfillet@gmail.com>
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

Link: https://lore.kernel.org/linux-kernel/20230313102752.1134472-1-suagrfillet@gmail.com/
Fixes: 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection in the CPU hotplug path")
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
changes from V1:
 - fix implicit declaration of clear_llc_topology
---
 drivers/base/arch_topology.c  | 16 ++++++++++++++--
 drivers/base/cacheinfo.c      |  2 ++
 include/linux/arch_topology.h |  3 +++
 3 files changed, 19 insertions(+), 2 deletions(-)

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
index a07b510e7dc5..569e05607934 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -89,9 +89,12 @@ void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 const struct cpumask *cpu_clustergroup_mask(int cpu);
 void update_siblings_masks(unsigned int cpu);
+void clear_llc_topology(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+#else
+static inline void clear_llc_topology(unsigned int cpu) { }
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.20.1

