Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79F76D5527
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjDCXTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbjDCXTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4FC1FD7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680563908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFLHr8TD8RfqA6eplD+afVyXuh6c0xOW13sUk0OaDso=;
        b=XQ0vwKe3OvxCpKXD8eDjfoSqdESY+0ISLfc1P9jFib1rIplnPopKDtWOhbUrmPMWw8vNNV
        au58YYFA7TyCw+wlpTP0jwur/Fwpq7+zP8ZiDKwa7XwB4h/8C+bs9+3l3T5i8k5aS4f59+
        Nl7wTRTq1MFfhaPdDXo1txS2oyj0MeQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-dWMuBxMjO9mz88oi2bhARQ-1; Mon, 03 Apr 2023 19:18:27 -0400
X-MC-Unique: dWMuBxMjO9mz88oi2bhARQ-1
Received: by mail-qt1-f198.google.com with SMTP id w13-20020ac857cd000000b003e37d3e6de2so20916482qta.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 16:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680563906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFLHr8TD8RfqA6eplD+afVyXuh6c0xOW13sUk0OaDso=;
        b=rAsBOKP6kOHVkRfahG5wTAJsMgozKkCgZpXyM7+EyeqisDkvF4jXKI9fue1rWbzOSM
         1rYwM3vkpGPcR7ifxHGt264Yvsi+dBwJ1uNDZWILgutQdCr0GBbmDgZbhMEEa81AJ84u
         quxSzckvJTjFHitwKc9PIh2vTWw/G31HC9L/L8h1ePnJ48lBSic3kaDK2lL2Ichll4DG
         m65oNj5E60diLbZMleN7xBdFPUz0FFrhhv3R8kryuFw9TrsA2Wnrus7Ye+qqzHY7Oztq
         5lDHpDOaga1m7bLzEeFxzCe11y2OSmEtx81EmLFrEBlmt9VhWqe/3mBB5rrZLUch4Pgi
         jCDw==
X-Gm-Message-State: AAQBX9c/CVvPJG9QpQwgJs9SiDAfNTcVpljdRVse/SoYElKvt0cEc420
        kFH4QmPwPWMHSfRRDrnY7HspDFKxVBP+bsZYWT3pS5yVODwxgQtDjJXtgwlIU9vab0W5D9G5FfC
        B6rebnuGVoLLMWLCvZJ7l6yJzvaCgGKtqGcAqXpL1IGUGNvjAF0oocIFmJFGxm9542pKt973cBN
        M8HvwOUOo=
X-Received: by 2002:ad4:5dcb:0:b0:5b6:eef9:b8f7 with SMTP id m11-20020ad45dcb000000b005b6eef9b8f7mr778708qvh.6.1680563905878;
        Mon, 03 Apr 2023 16:18:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z6BgYgGucfGKREPBAxx1VLlrIXk8leHEc8OtAlDEGX+cpBZbJtwN4DICEvNgHx2cM+TfCeSA==
X-Received: by 2002:ad4:5dcb:0:b0:5b6:eef9:b8f7 with SMTP id m11-20020ad45dcb000000b005b6eef9b8f7mr778686qvh.6.1680563905606;
        Mon, 03 Apr 2023 16:18:25 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id v6-20020ad45346000000b005e231177992sm2670207qvs.74.2023.04.03.16.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 16:18:25 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] cacheinfo: Add arm64 early level initializer implementation
Date:   Mon,  3 Apr 2023 19:15:51 -0400
Message-Id: <20230403231551.1090704-3-rrendec@redhat.com>
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

