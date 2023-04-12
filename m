Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7EC6DFE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDLTAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjDLTAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E495FE0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681325942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TIrahFdRAf91u6g7Hjbf+gtc3KP6J5YCSemB+yiV888=;
        b=J9613GIT4leg52bxZXPOKT+bN8B1eyPt9OJ2AQjnDaz8lNIPz6TV9PhLNM7nGKyoM6CMy0
        1+DXFyoOAkCDL4KHE+twEZhaI5OCLfdnG/OaTuzxjtB3zsNKGhjoqqKQPuoJto+iwvWeWO
        46+DhATeA22Cwq1jbEPZ0cM65hlAch0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-iI33VgwrOUe_1VTQrwv31g-1; Wed, 12 Apr 2023 14:59:01 -0400
X-MC-Unique: iI33VgwrOUe_1VTQrwv31g-1
Received: by mail-qt1-f200.google.com with SMTP id t30-20020a05622a181e00b003e37dd114e3so9417820qtc.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325940; x=1683917940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIrahFdRAf91u6g7Hjbf+gtc3KP6J5YCSemB+yiV888=;
        b=a5aDRc0zdBld1bMDPz63dZEiYG6FB+V4PYT66hM+7cR13rnrI+5tfY6gzYffuzFrRj
         5ngckRQGVNryiYKmE/j+sj3a/TQ3+pwJ52nDEhO8ErX/jLZ+3QSstIEXs6fg9q+bZle0
         WmjKqveUcmOpGtH/41MLnCVtB/9jrysmBvHH1X/w565UbjEKpNhzaURm6beorVtPll71
         8djFs1pDAk6BMCBZUkyPdwmaLwGvRpxDw1Knw3AlE1CeAa0p6M7FVDVelNw9E554Mnpl
         3E/mgnVQiI+vd7FZnPfIKPDLR058Njka3Jz2DmvH42gfIdqiO8ozs67KET18wBl3rKxC
         3V8A==
X-Gm-Message-State: AAQBX9cZE17ckl6dM9k2Jd9Ll0cKrXEplMIGM1Y9KktAeRx2yNiQypCo
        27SFQpQmRT+asaedSpf5hsdKkA71tSw+z7rg1WWu1PwJ2bAHyzW8sxosLa3rBUU+Sr69wRRtBRd
        WMyGAwTZRR7LAxj+OhK0N723i0dkIbpxn7JISIdFDhqdqNfgezZ0mB0LbP4lqEP2iOiD/bM5293
        0IV/xTLh8=
X-Received: by 2002:a05:622a:514:b0:3bf:db0a:c105 with SMTP id l20-20020a05622a051400b003bfdb0ac105mr23439013qtx.6.1681325940559;
        Wed, 12 Apr 2023 11:59:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350bYTWjXEi+fFDnEWbAazjdSJa6gJGd3ECc3dgPFcbfvhSRgqSlfUFMQwEWyKO7xDlA/oN5ySQ==
X-Received: by 2002:a05:622a:514:b0:3bf:db0a:c105 with SMTP id l20-20020a05622a051400b003bfdb0ac105mr23438976qtx.6.1681325940065;
        Wed, 12 Apr 2023 11:59:00 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id k21-20020ac86055000000b003d3a34d2eb2sm4417558qtm.41.2023.04.12.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:58:59 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/3] cacheinfo: Add arch specific early level initializer
Date:   Wed, 12 Apr 2023 14:57:57 -0400
Message-Id: <20230412185759.755408-2-rrendec@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412185759.755408-1-rrendec@redhat.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gives architecture specific code the ability to initialize
the cache level and allocate cacheinfo memory early, when cache level
initialization runs on the primary CPU for all possible CPUs.

This is part of a patch series that attempts to further the work in
commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU").
Previously, in the absence of any DT/ACPI cache info, architecture
specific cache detection and info allocation for secondary CPUs would
happen in non-preemptible context during early CPU initialization and
trigger a "BUG: sleeping function called from invalid context" splat on
an RT kernel.

More specifically, this patch adds the early_cache_level() function,
which is called by fetch_cache_info() as a fallback when the number of
cache leaves cannot be extracted from DT/ACPI. In the default generic
(weak) implementation, this new function returns -ENOENT, which
preserves the original behavior for architectures that do not implement
the function.

Since early detection can get the number of cache leaves wrong in some
cases*, additional logic is added to still call init_cache_level() later
on the secondary CPU, therefore giving the architecture specific code an
opportunity to go back and fix the initial guess. Again, the original
behavior is preserved for architectures that do not implement the new
function.

* For example, on arm64, CLIDR_EL1 detection works only when it runs on
  the current CPU. In other words, a CPU cannot detect the cache depth
  for any other CPU than itself.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/base/cacheinfo.c  | 75 +++++++++++++++++++++++++++------------
 include/linux/cacheinfo.h |  2 ++
 2 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index f3903d002819..d783896c8a1f 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -398,6 +398,11 @@ static void free_cache_attributes(unsigned int cpu)
 	cache_shared_cpu_map_remove(cpu);
 }
 
+int __weak early_cache_level(unsigned int cpu)
+{
+	return -ENOENT;
+}
+
 int __weak init_cache_level(unsigned int cpu)
 {
 	return -ENOENT;
@@ -423,56 +428,82 @@ int allocate_cache_info(int cpu)
 
 int fetch_cache_info(unsigned int cpu)
 {
-	struct cpu_cacheinfo *this_cpu_ci;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	unsigned int levels = 0, split_levels = 0;
 	int ret;
 
 	if (acpi_disabled) {
 		ret = init_of_cache_level(cpu);
-		if (ret < 0)
-			return ret;
 	} else {
 		ret = acpi_get_cache_info(cpu, &levels, &split_levels);
-		if (ret < 0)
+		if (!ret) {
+			this_cpu_ci->num_levels = levels;
+			/*
+			 * This assumes that:
+			 * - there cannot be any split caches (data/instruction)
+			 *   above a unified cache
+			 * - data/instruction caches come by pair
+			 */
+			this_cpu_ci->num_leaves = levels + split_levels;
+		}
+	}
+
+	if (ret || !cache_leaves(cpu)) {
+		ret = early_cache_level(cpu);
+		if (ret)
 			return ret;
 
-		this_cpu_ci = get_cpu_cacheinfo(cpu);
-		this_cpu_ci->num_levels = levels;
-		/*
-		 * This assumes that:
-		 * - there cannot be any split caches (data/instruction)
-		 *   above a unified cache
-		 * - data/instruction caches come by pair
-		 */
-		this_cpu_ci->num_leaves = levels + split_levels;
+		if (!cache_leaves(cpu))
+			return -ENOENT;
+
+		this_cpu_ci->early_ci_levels = true;
 	}
-	if (!cache_leaves(cpu))
-		return -ENOENT;
 
 	return allocate_cache_info(cpu);
 }
 
-int detect_cache_attributes(unsigned int cpu)
+static inline int init_level_allocate_ci(unsigned int cpu)
 {
-	int ret;
+	unsigned int early_leaves = cache_leaves(cpu);
 
 	/* Since early initialization/allocation of the cacheinfo is allowed
 	 * via fetch_cache_info() and this also gets called as CPU hotplug
 	 * callbacks via cacheinfo_cpu_online, the init/alloc can be skipped
 	 * as it will happen only once (the cacheinfo memory is never freed).
-	 * Just populate the cacheinfo.
+	 * Just populate the cacheinfo. However, if the cacheinfo has been
+	 * allocated early through the arch-specific early_cache_level() call,
+	 * there is a chance the info is wrong (this can happen on arm64). In
+	 * that case, call init_cache_level() anyway to give the arch-specific
+	 * code a chance to make things right.
 	 */
-	if (per_cpu_cacheinfo(cpu))
-		goto populate_leaves;
+	if (per_cpu_cacheinfo(cpu) && !ci_cacheinfo(cpu)->early_ci_levels)
+		return 0;
 
 	if (init_cache_level(cpu) || !cache_leaves(cpu))
 		return -ENOENT;
 
-	ret = allocate_cache_info(cpu);
+	/*
+	 * Now that we have properly initialized the cache level info, make
+	 * sure we don't try to do that again the next time we are called
+	 * (e.g. as CPU hotplug callbacks).
+	 */
+	ci_cacheinfo(cpu)->early_ci_levels = false;
+
+	if (cache_leaves(cpu) <= early_leaves)
+		return 0;
+
+	kfree(per_cpu_cacheinfo(cpu));
+	return allocate_cache_info(cpu);
+}
+
+int detect_cache_attributes(unsigned int cpu)
+{
+	int ret;
+
+	ret = init_level_allocate_ci(cpu);
 	if (ret)
 		return ret;
 
-populate_leaves:
 	/*
 	 * If LLC is valid the cache leaves were already populated so just go to
 	 * update the cpu map.
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 908e19d17f49..6147b2672555 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -76,9 +76,11 @@ struct cpu_cacheinfo {
 	unsigned int num_levels;
 	unsigned int num_leaves;
 	bool cpu_map_populated;
+	bool early_ci_levels;
 };
 
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
+int early_cache_level(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int init_of_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
-- 
2.39.2

