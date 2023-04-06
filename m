Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321DA6DA625
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbjDFXk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDFXkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C845593C5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680824407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cc6KVLkxiFkbIiP9zsTzJIOe0YheAFkwqXrNmWhCyPk=;
        b=EdabCbgq0Rzv7siPUfV5hs7ernXL3+QmED/fpgvBMxtICL6qU4RT1sT5iVEEgwoWgEps9k
        f/jyf8KoFXHYrsI6GTvr8UGc4XuTXa+pFb/4yJf0vpQEczOGXNDylFbNLy2e4K3mgMp63O
        yBY7OQt7y4eLUx9kqXI8G2VuwYSlUqY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-eJCUxOoqPveeaH-TmCh3SQ-1; Thu, 06 Apr 2023 19:40:05 -0400
X-MC-Unique: eJCUxOoqPveeaH-TmCh3SQ-1
Received: by mail-qt1-f198.google.com with SMTP id p22-20020a05622a00d600b003e38f7f800bso27483275qtw.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680824404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc6KVLkxiFkbIiP9zsTzJIOe0YheAFkwqXrNmWhCyPk=;
        b=Ptke7HircO1N6Vm5mTlMwM9cLPsT0oNAfCNzydHWgHykaKplwG1LrNHeI7Qf0ktZl0
         8mLlUdC3lyYuB+hxb/tk0JfES1o5CSW64wkiuOBHmzRoqIBR1f5D93IDMyg97yl/YOx4
         43HRzki1bRUxa9KenS2nKI0y4RoJXbp00sTK0s7AmitDyGybeWughgQ7OtQ+GnkgNFcr
         7lQ5ulhPe303Kwys6zGZg3uUdop+JO2FEVZhz6NnwaUhunh25r791dHjFYuSQJ7AwGCo
         H7f9RcAjUlJLj97O/COqDBmCkRmkCGfOnL+fdOkCt9WXj3RjSdkHd2aD31L4oBKQNo5Y
         IJ8A==
X-Gm-Message-State: AAQBX9cKCRyGenNvI1iAZ4DZI+SoAmRU0AgqHBLHv4gLr1jIy79U70SQ
        lYVUpKQKqQFTyz+Ll9yKfoQC5nDHdrWuc2U8PXRBXrhOPZ0R03lkra/wNO+/d+sQPN85QVOpVHs
        ge4EbR71UpViahLcCNVCy3/33nYW0yevN0Qxb/aGEPvt1PRdgbhg+LXFfVA0cxNVmjD7enOQqjY
        6oPhAqNbE=
X-Received: by 2002:a05:6214:258a:b0:5aa:6130:7c63 with SMTP id fq10-20020a056214258a00b005aa61307c63mr1917427qvb.46.1680824404485;
        Thu, 06 Apr 2023 16:40:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z9Dgcc6gLQTk8bLQ4IVUqeocwCx5vwYcTw5awKGExfowZ81MT28oLHi+tu3tjZv2Xx4Eyl7w==
X-Received: by 2002:a05:6214:258a:b0:5aa:6130:7c63 with SMTP id fq10-20020a056214258a00b005aa61307c63mr1917395qvb.46.1680824404082;
        Thu, 06 Apr 2023 16:40:04 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id mk21-20020a056214581500b005dd8b9345f0sm865599qvb.136.2023.04.06.16.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 16:40:03 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] cacheinfo: Add arch specific early level initializer
Date:   Thu,  6 Apr 2023 19:39:25 -0400
Message-Id: <20230406233926.1670094-2-rrendec@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406233926.1670094-1-rrendec@redhat.com>
References: <20230406233926.1670094-1-rrendec@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gives of architecture specific code the ability to initialize
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
---
 drivers/base/cacheinfo.c  | 75 +++++++++++++++++++++++++++------------
 include/linux/cacheinfo.h |  2 ++
 2 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index f6573c335f4c..30f5553d3ebb 100644
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
+		this_cpu_ci->early_arch_info = true;
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
+	if (per_cpu_cacheinfo(cpu) && !ci_cacheinfo(cpu)->early_arch_info)
+		return 0;
 
 	if (init_cache_level(cpu) || !cache_leaves(cpu))
 		return -ENOENT;
 
-	ret = allocate_cache_info(cpu);
+	/*
+	 * Now that we have properly initialized the cache level info, make
+	 * sure we don't try to do that again the next time we are called
+	 * (e.g. as CPU hotplug callbacks).
+	 */
+	ci_cacheinfo(cpu)->early_arch_info = false;
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
 	 * populate_cache_leaves() may completely setup the cache leaves and
 	 * shared_cpu_map or it may leave it partially setup.
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 908e19d17f49..c9d44308fc42 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -76,9 +76,11 @@ struct cpu_cacheinfo {
 	unsigned int num_levels;
 	unsigned int num_leaves;
 	bool cpu_map_populated;
+	bool early_arch_info;
 };
 
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
+int early_cache_level(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int init_of_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
-- 
2.39.2

