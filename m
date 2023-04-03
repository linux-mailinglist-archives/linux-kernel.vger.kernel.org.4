Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBD36D5526
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjDCXTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjDCXS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E9110FF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680563896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YH3UKoR8rYIu0iuQWuLZX3jQHhACfQOBf+mSwnXGA0E=;
        b=R5nryTfJD5Uutt5zjDoToNrLf8YYe8vDfs9f0o0scIW0TDUciiNn1LU1CJJoq3K6FrDGTA
        jMiMRbIzXz85U5YeXBk3XdT0/0GOlrMck5E1/E43inGvcHXuq3qXcU+Lnm7PbcE8KPlmjX
        ABH+6yypEkZzCX0dZPLq5hMEtwKc/Sk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-zpWPhDGcMXGGXDaHhM7i1A-1; Mon, 03 Apr 2023 19:18:15 -0400
X-MC-Unique: zpWPhDGcMXGGXDaHhM7i1A-1
Received: by mail-qv1-f70.google.com with SMTP id e1-20020a0cd641000000b005b47df84f6eso13929734qvj.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 16:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680563894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YH3UKoR8rYIu0iuQWuLZX3jQHhACfQOBf+mSwnXGA0E=;
        b=5D+P/SqR76rBPZYWbEMTISoMv2wSg0z5v6PcwofnVKsrkfIeNQ2HzXl/KqUy2JhApA
         fgDhYArfuJ5RWPSk+fazeqp39VgoCqheO08Ft9pK6sOIeFEh/gjH6qnX9YKnvHJJon/R
         G86q3qnOOKF4QIHv7e4X3JZrkVmpYvoObI8Ix8KjqdOrmtupBMZwMaaaFpBVxEHAadC/
         jmejAC230oLmD31OTS5vdzP95WORNFWklHYQsG2XrjJmtNgppt07UPXXcbcUB4LDSMdw
         oWuI6V0yJ7C6zVmzKocbwu9FsZetcI3MMAa96FO2oUAL2lXa58bSu2mVhSQVzmWj/acU
         q81w==
X-Gm-Message-State: AAQBX9dcjIJvVI1aiZET27JIVX+KMzv6kAksA1DE0zawBHrPsXg6s24q
        wPsfXySChHJqLuOCcjG4PDCZoBXEGL+Jsdn1rllr+LiaMLF8Pvb/rKwN5Wzdhus/1CEsAMILABC
        3mPayY03SJldKuwnv0Ih+u9vWeNY9zvCY6tF6rvAMwVKM9LsMVkW819TT2XgibQrbUtfmThB0qt
        8BCo1doGU=
X-Received: by 2002:a05:6214:5081:b0:5bf:ba9d:8726 with SMTP id kk1-20020a056214508100b005bfba9d8726mr833600qvb.10.1680563894021;
        Mon, 03 Apr 2023 16:18:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350bvulUg4Ye6CyGProp/t+paS7VYN/rG4/aQjokPDKzNvBopwtBgayhPoP6XkvhqPTIPssBQdw==
X-Received: by 2002:a05:6214:5081:b0:5bf:ba9d:8726 with SMTP id kk1-20020a056214508100b005bfba9d8726mr833571qvb.10.1680563893700;
        Mon, 03 Apr 2023 16:18:13 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id v6-20020ad45346000000b005e231177992sm2670207qvs.74.2023.04.03.16.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 16:18:13 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] cacheinfo: Add arch specific early level initializer
Date:   Mon,  3 Apr 2023 19:15:50 -0400
Message-Id: <20230403231551.1090704-2-rrendec@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403231551.1090704-1-rrendec@redhat.com>
References: <20230403231551.1090704-1-rrendec@redhat.com>
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
 drivers/base/cacheinfo.c  | 57 ++++++++++++++++++++++++++-------------
 include/linux/cacheinfo.h |  2 ++
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index f6573c335f4c..7f8ac0cb549f 100644
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
@@ -423,51 +428,65 @@ int allocate_cache_info(int cpu)
 
 int fetch_cache_info(unsigned int cpu)
 {
-	struct cpu_cacheinfo *this_cpu_ci;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	unsigned int levels = 0, split_levels = 0;
 	int ret;
 
-	if (acpi_disabled) {
+	if (acpi_disabled)
 		ret = init_of_cache_level(cpu);
-		if (ret < 0)
-			return ret;
-	} else {
+	else {
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
 
 int detect_cache_attributes(unsigned int cpu)
 {
+	unsigned int early_leaves = cache_leaves(cpu);
 	int ret;
 
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
+	if (per_cpu_cacheinfo(cpu) && !ci_cacheinfo(cpu)->early_arch_info)
 		goto populate_leaves;
 
 	if (init_cache_level(cpu) || !cache_leaves(cpu))
 		return -ENOENT;
 
+	if (cache_leaves(cpu) <= early_leaves)
+		goto populate_leaves;
+
+	kfree(per_cpu_cacheinfo(cpu));
 	ret = allocate_cache_info(cpu);
 	if (ret)
 		return ret;
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

