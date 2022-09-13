Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39D45B7BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiIMUAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiIMT77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:59:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE15792DE;
        Tue, 13 Sep 2022 12:59:09 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id k12so9304691qkj.8;
        Tue, 13 Sep 2022 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lc6C5FZ3R6bpGdrTQfUMqHUthTTami+g742/pfBsTic=;
        b=RlsLmEiP3JVWhyXjCMSzF7A4AVjyq1jRjWCW9x5GNVTee31Y+zsIXxNeUFqHaiWHyg
         8J6hP8RFMjTeETwSHV9ENC6pqQalmeYj6JweS9Tsv7OxuqvPlsMarmRSfwGBaWF+XcBE
         la0+kyQTMUqV4xn7LwqYCphDGQkUMF9O3ZqeG7FJEIlcBtt95RRsh5UONSCeySm6f9no
         qWos+YkhM9jVDPaT5oAH5RbFh07TQsfPjWCoTiWZNYZktg0UxgNqKCsIm4np7G5/9pqK
         Gqu0dk9U2X717zjfg5WZXwdvFki/e2iGeK+mAGJNsof/XN1i9elvjnIO7qYgQkqpgSuo
         A90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lc6C5FZ3R6bpGdrTQfUMqHUthTTami+g742/pfBsTic=;
        b=EmoYVb/xHZp2zy8lEHzJh8jE83PJfTP69p41jXm4mQpEDZu1WdoiK5qFFFbYi45VI+
         sPg9vh+z8TFR8Cs1Qs3VKLxl4T6+9Xul6fWbBFGYctSSQKWcSOaZBpOZtCl7+0TcGfGU
         9Wt9+iBw2FMZ7eGECxd/CjcsgkUtVJ3pt6JK79GfpmV3f0HhTQPem8UxPHG/eMvRxlaD
         xFjxzy4pWvw5yBa6F289yTFh9yrAkHfE24pGzDeu0Xl57BKbqV8jrYYeSrbWs3tqrAMa
         YNF/iqg+6WuLHtCLPPWq74cPnjdiCZ/JrQyRWWpWOVrieS/Vg9vqR4GsVx/aXlAUSNAk
         EOew==
X-Gm-Message-State: ACgBeo1EIKsfjIHRTQTk9VOrHIRJiDUq0u0hzp5q5n9+B6QdEWzWARKc
        QdlaVa+5Cc9whLgv2B0zcpc=
X-Google-Smtp-Source: AA6agR4JgnZFDc4dYiN2cHvYsrY/zIDRf84OViiKl4IHPDPBj/qqA4B2wHLv+IBu33IWNCFBvl5WRQ==
X-Received: by 2002:a05:620a:22b0:b0:6cd:f06a:7978 with SMTP id p16-20020a05620a22b000b006cdf06a7978mr13621240qkh.106.1663099148142;
        Tue, 13 Sep 2022 12:59:08 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:59:07 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: [PATCH 20/21] mm/cma: introduce rmem shared-dmb-pool
Date:   Tue, 13 Sep 2022 12:55:07 -0700
Message-Id: <20220913195508.3511038-21-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913195508.3511038-1-opendmb@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 'shared-dmb-pool' reserved-memory device tree node defines a
Designated Movable Block for use by an associated Contiguous
Memory Allocator.

Devices access the CMA region in the same manner as a 'shared-
dma-pool', but the kernel page allocator is free to use the
memory like any other ZONE_MOVABLE memory.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/of/of_reserved_mem.c |  5 +++++
 kernel/dma/contiguous.c      | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 0eb9e8898d7b..700c0dc0d3b6 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -123,6 +123,11 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 		   && !nomap) {
 		/* Need adjust the alignment to satisfy the CMA requirement */
 		align = max_t(phys_addr_t, align, CMA_MIN_ALIGNMENT_BYTES);
+	} else if (IS_ENABLED(CONFIG_CMA)
+		   && of_flat_dt_is_compatible(node, "shared-dmb-pool")) {
+		/* Need adjust the alignment to satisfy CMA/DMB requirements */
+		align = max_t(phys_addr_t, align, CMA_MIN_ALIGNMENT_BYTES);
+		align = max_t(phys_addr_t, align, DMB_MIN_ALIGNMENT_BYTES);
 	}
 
 	prop = of_get_flat_dt_prop(node, "alloc-ranges", &len);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 6ea80ae42622..65dda12752a7 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -50,6 +50,7 @@
 #include <linux/sizes.h>
 #include <linux/dma-map-ops.h>
 #include <linux/cma.h>
+#include <linux/dmb.h>
 
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
@@ -397,10 +398,11 @@ static const struct reserved_mem_ops rmem_cma_ops = {
 	.device_release = rmem_cma_device_release,
 };
 
-static int __init rmem_cma_setup(struct reserved_mem *rmem)
+static int __init _rmem_cma_setup(struct reserved_mem *rmem, bool in_dmb)
 {
 	unsigned long node = rmem->fdt_node;
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
+	phys_addr_t align = CMA_MIN_ALIGNMENT_BYTES;
 	struct cma *cma;
 	int err;
 
@@ -414,16 +416,25 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
-	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
+	if (in_dmb) {
+		if (default_cma) {
+			pr_err("Reserved memory: cma-default cannot be DMB\n");
+			return -EINVAL;
+		}
+		align = max_t(phys_addr_t, align, DMB_MIN_ALIGNMENT_BYTES);
+	}
+	if (!IS_ALIGNED(rmem->base | rmem->size, align)) {
 		pr_err("Reserved memory: incorrect alignment of CMA region\n");
 		return -EINVAL;
 	}
 
-	err = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &cma);
+	err = __cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name,
+				      &cma, in_dmb);
 	if (err) {
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
 	}
+
 	/* Architecture specific contiguous memory fixup. */
 	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
@@ -433,10 +444,22 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	rmem->ops = &rmem_cma_ops;
 	rmem->priv = cma;
 
-	pr_info("Reserved memory: created CMA memory pool at %pa, size %ld MiB\n",
-		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	pr_info("Reserved memory: created %s memory pool at %pa, size %ld MiB\n",
+		in_dmb ? "DMB" : "CMA", &rmem->base,
+		(unsigned long)rmem->size / SZ_1M);
 
 	return 0;
 }
+
+static int __init rmem_cma_setup(struct reserved_mem *rmem)
+{
+	return _rmem_cma_setup(rmem, false);
+}
 RESERVEDMEM_OF_DECLARE(cma, "shared-dma-pool", rmem_cma_setup);
+
+static int __init rmem_cma_in_dmb_setup(struct reserved_mem *rmem)
+{
+	return _rmem_cma_setup(rmem, true);
+}
+RESERVEDMEM_OF_DECLARE(cma_in_dmb, "shared-dmb-pool", rmem_cma_in_dmb_setup);
 #endif
-- 
2.25.1

