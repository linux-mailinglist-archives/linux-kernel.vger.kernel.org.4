Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD446DFE41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjDLTAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjDLTAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B2272AA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681325948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZuY/Ovf/uFFipzBlaz3R7sO5nsBImgJvd+bwl5YSO8=;
        b=NM3zU5Wn9PkhOixwPq3zIocxIt81Xotc0SGMeOnuuzG5svaoWhcNhYfah+HDVgFB4Ny0h6
        lyuk1XGD+uWgQUR0gcVwU4orBJh6Dt+p3L9zHWKkzXEtWH1KkgyA8lZHHmdwMCE/c9vBvJ
        hHjCstvSnOfJlSziSJVpKYHbl99ilWc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-3Wr482_jNmu5pWU4OxSlSw-1; Wed, 12 Apr 2023 14:59:07 -0400
X-MC-Unique: 3Wr482_jNmu5pWU4OxSlSw-1
Received: by mail-qt1-f197.google.com with SMTP id c21-20020a05622a025500b003e4ee70e001so3078723qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325946; x=1683917946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZuY/Ovf/uFFipzBlaz3R7sO5nsBImgJvd+bwl5YSO8=;
        b=V/TYeXG/jxxE7ZCEw5v4W1N9yDBhbewiVPOweVj1IGvU7lC1U2g38jhrxrLtSj9kDK
         iz381CnfKS4qEo6qKAaFEsAWzFUT4WKLMOi16wrvGeep++LGUA/YVVzqG+igmPkdKNtS
         1Q6H+SWm1/2rBIcvUxZG4Q0me/uvxD3CtCpAd1Nc26URMYgoSZqQmkmEceNAfBPy2Aug
         7BuAKgx5eZbTXroaVbCvn2sf9QyMZiBsLa4IyxpkKRCWpG2JbZTY+PA/42F8RBXnxxaA
         mnVutzfsEjWYRKpjXyhHetUNKls+QDlCzHhezNHw3UwgPe8IU2q5loJbuUqH+LkaA/xa
         NDPw==
X-Gm-Message-State: AAQBX9cohs4xaYiXkGHplYVE8T3S3669/N1VCVHHYXL33H84FWoEFn9I
        ItPeg8tR7WBKqh0oZTS4TjTBKs1ERbf4uPRh/Ga4ZBH8uGdquS31KqbHw9zVu/cC3pbOXo2bIPM
        f/Aotz7cuUDgpyiyT4tRwKXmabHNqO2Yxnb2uxpWqu/1HIuhlA5Oe6s2Dzb3g/kRqtqV3wo8kcV
        LtGgyiA9k=
X-Received: by 2002:a05:622a:164d:b0:3c0:3b08:2d80 with SMTP id y13-20020a05622a164d00b003c03b082d80mr29923044qtj.63.1681325946187;
        Wed, 12 Apr 2023 11:59:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350aDCy/grIrQOAg4F0cRB0KUFFgcOsjPQlMHofCh0J78aEkWstgNxNgb6dTlHJrCn3c+YElRVg==
X-Received: by 2002:a05:622a:164d:b0:3c0:3b08:2d80 with SMTP id y13-20020a05622a164d00b003c03b082d80mr29923020qtj.63.1681325945874;
        Wed, 12 Apr 2023 11:59:05 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id k21-20020ac86055000000b003d3a34d2eb2sm4417558qtm.41.2023.04.12.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:59:05 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/3] cacheinfo: Add arm64 early level initializer implementation
Date:   Wed, 12 Apr 2023 14:57:58 -0400
Message-Id: <20230412185759.755408-3-rrendec@redhat.com>
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
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/arm64/kernel/cacheinfo.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index c307f69e9b55..d9c9218fa1fd 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -38,11 +38,9 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
-int init_cache_level(unsigned int cpu)
+static void detect_cache_level(unsigned int *level_p, unsigned int *leaves_p)
 {
 	unsigned int ctype, level, leaves;
-	int fw_level, ret;
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
 	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
 		ctype = get_cache_type(level);
@@ -54,6 +52,27 @@ int init_cache_level(unsigned int cpu)
 		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
 	}
 
+	*level_p = level;
+	*leaves_p = leaves;
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
+
 	if (acpi_disabled) {
 		fw_level = of_find_last_cache_level(cpu);
 	} else {
-- 
2.39.2

