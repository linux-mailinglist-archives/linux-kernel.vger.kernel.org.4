Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43546DA627
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 01:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjDFXlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 19:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjDFXk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 19:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3317193EB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 16:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680824412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFLHr8TD8RfqA6eplD+afVyXuh6c0xOW13sUk0OaDso=;
        b=P273AJw5FTB9qAqKG0pa38geA240LKBN8+guNr/k9DvExwNjkekGzuR3Z+sA6+y4b0ZbL7
        /2MDL/qgUd6bONXNTupXKCiVVGdM49a23v8kv8kWWVHJwVQfHx17ZRQ170l7qOXYRRDVK8
        OAHN5nwl9U+WzHRO79n+uDlNOrYM870=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-FBCenDZ9MLWfoGqFll8hHA-1; Thu, 06 Apr 2023 19:40:10 -0400
X-MC-Unique: FBCenDZ9MLWfoGqFll8hHA-1
Received: by mail-qt1-f199.google.com with SMTP id m7-20020a05622a118700b003e4e203bc30so25441358qtk.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 16:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680824410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFLHr8TD8RfqA6eplD+afVyXuh6c0xOW13sUk0OaDso=;
        b=Gk5Dfoc4EkPHOaBzXNKxH8yyBC/u5p3wdpitWwKb2iccrEkJIm0KHehkzrqwugrHux
         TuQzBedB2t6w8wObohaK8gGGLZ6TFYRJ8T36DKIXTNiULowMLXEYlYicZuhnGSeJv+c9
         m9tUHv/YRlxiRwbjK9tWHqyA/LTNzs/1wq10UYGxWwuVa+Wg0g8rvKFRzKv22VTyNgjK
         1dIFd+B6yt5i7su5OhMDlCND7nWHMATcvD/soucww7ZLZ7dCnMwtvg87kk+jSMEWSsEI
         FZz/OAkuqOxS+Lk9O0a0X5gMxeCUHKEOGC4uVHQCX6y8+8zzAWovVbyGaRYuxUkB8oa5
         lEnQ==
X-Gm-Message-State: AAQBX9eZqGHOTl9iT075bn8eBupaOWTcXwWkPj0XcuZQ+IPgz2LfR9Xx
        MNOZeFue7E604o7QiHuhk91Qr6XKxfFScEt7mVmupugpkBajKKZ6h22xWilO83aifS8kb/WMj3E
        PQFV8MVbywE2Lc/tbyUZOqlpoZga09cqXovnfROyFgPOT9Rxx0D29hDZ7ezgjBw0D1LYB01LNuN
        +ke8bd7Xs=
X-Received: by 2002:a05:6214:2a87:b0:537:6416:fc2b with SMTP id jr7-20020a0562142a8700b005376416fc2bmr758100qvb.52.1680824409751;
        Thu, 06 Apr 2023 16:40:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350aTZWTs4QSNMHkYA2K7OeW1qBjRzYrUyinDc/jKPjqpu8gsXnfpGGgDYWwYR/lquRY5QeMyYA==
X-Received: by 2002:a05:6214:2a87:b0:537:6416:fc2b with SMTP id jr7-20020a0562142a8700b005376416fc2bmr758083qvb.52.1680824409459;
        Thu, 06 Apr 2023 16:40:09 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id mk21-20020a056214581500b005dd8b9345f0sm865599qvb.136.2023.04.06.16.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 16:40:09 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] cacheinfo: Add arm64 early level initializer implementation
Date:   Thu,  6 Apr 2023 19:39:26 -0400
Message-Id: <20230406233926.1670094-3-rrendec@redhat.com>
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

This patch adds an architecture specific early cache level detection
handler for arm64. This is basically the CLIDR_EL1 based detection that
was previously done (only) in init_cache_level().

This is part of a patch series that attempts to further the work in
commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU").
Previously, in the absence of any DT/ACPI cache info, architecture
specific cache detection and info allocation for secondary CPUs would
happen in non-preemptible context during early CPU initialization and
trigger a "BUG: sleeping function called from invalid context" splat on
an RT kernel.

This patch does not solve the problem completely for RT kernels. It
relies on the assumption that on most systems, the CPUs are symmetrical
and therefore have the same number of cache leaves. The cacheinfo memory
is allocated early (on the primary CPU), relying on the new handler. If
later (when CLIDR_EL1 based detection runs again on the secondary CPU)
the initial assumption proves to be wrong and the CPU has in fact more
leaves, the cacheinfo memory is reallocated, and that still triggers a
splat on an RT kernel.

In other words, asymmetrical CPU systems *must* still provide cacheinfo
data in DT/ACPI to avoid the splat on RT kernels (unless secondary CPUs
happen to have less leaves than the primary CPU). But symmetrical CPU
systems (the majority) can now get away without the additional DT/ACPI
data and rely on CLIDR_EL1 based detection.

Signed-off-by: Radu Rendec <rrendec@redhat.com>
---
 arch/arm64/kernel/cacheinfo.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index c307f69e9b55..520d17e4ebe9 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -38,21 +38,37 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
-int init_cache_level(unsigned int cpu)
+static void detect_cache_level(unsigned int *level, unsigned int *leaves)
 {
-	unsigned int ctype, level, leaves;
-	int fw_level, ret;
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	unsigned int ctype;
 
-	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
-		ctype = get_cache_type(level);
+	for (*level = 1, *leaves = 0; *level <= MAX_CACHE_LEVEL; (*level)++) {
+		ctype = get_cache_type(*level);
 		if (ctype == CACHE_TYPE_NOCACHE) {
-			level--;
+			(*level)--;
 			break;
 		}
 		/* Separate instruction and data caches */
-		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
+		*leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
 	}
+}
+
+int early_cache_level(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+
+	detect_cache_level(&this_cpu_ci->num_levels, &this_cpu_ci->num_leaves);
+
+	return 0;
+}
+
+int init_cache_level(unsigned int cpu)
+{
+	unsigned int level, leaves;
+	int fw_level, ret;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+
+	detect_cache_level(&level, &leaves);
 
 	if (acpi_disabled) {
 		fw_level = of_find_last_cache_level(cpu);
-- 
2.39.2

