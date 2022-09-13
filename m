Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6662C5B7BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIMUAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiIMT7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:59:19 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E71792D0;
        Tue, 13 Sep 2022 12:58:57 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i3so4616430qkl.3;
        Tue, 13 Sep 2022 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=U4jOrSu6bqJBytWJghR6t0ljWrrZGLSB9ph/v+e9V8I=;
        b=D/mTJk6kZw64eyUhHPaSFfxR9Msa5UBxyOTlcsmCwhUVjiAhTk7oqnxftuemkUJs0o
         e/3ecILYiDZtf1ZduEhchjc87lM/UzBWANhyHjDCeSCCZZ+OsXTubHr/HBHsItOzKdH7
         p/GQO/8nQMFRqeejgZsBOVzCwSXLRfYO2jhkP7CDsujDhgqd9989s5l2qAcx+CNYHM2D
         3FzlZrQmr76F2aSmz5wNYnpRQxzHx962ONlutGAvPr/+dXcOvxUiHsk1k1ee7yaWbHVI
         2LCJzHzqV9IGkV4gb1i+myYCzvATpnUG8sQPbUiE3I3lJUeSHhrVFH3mITfi1tyJU0b1
         X7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=U4jOrSu6bqJBytWJghR6t0ljWrrZGLSB9ph/v+e9V8I=;
        b=6tGerPA+8CLTaSTurXxfHH11caWZcpKkMd0d7u6ZQznwAYm2Lqstgix8JAC9XY2Ias
         PjBfiEnd2F57RC8cTQvztOyRLGzn+KN25OIc5glV8l8sZ8aCuSXM1z+3FOLa/rVNr8Z2
         ZQ4MUlcCZoEf8JbHCUi+QirGDEZppS3zHNO/x7BcodkzQ+Of+5hOZONZxILgYLq14eOU
         Nhle7ekgTmWIP57OvyhCMkVxLVhoouA+fbxnT68XH9yll0MK7Lr+BRC9os5aDaCGrNpe
         QnkIi9LK8nZPqffy6uKUYMa7+l6fn8Q4roBC3aqYDbb4+ZDet5EPhm6DibH1EgAJoQCL
         bsGw==
X-Gm-Message-State: ACgBeo0u1sLYwclovlWZGsAQhjYhUGpEZ5wc506+TDJwKe4CSJ8D2sva
        2jos7PqMzIl8gLZjY6e3pRo=
X-Google-Smtp-Source: AA6agR42tNhbqU65weBklFefGDPSfeY7AMPrK26FTuyeT6UMnlp5fPm7LJh/3FGN4dhzcFbZNJ8Esw==
X-Received: by 2002:a05:620a:2452:b0:6bb:d8ba:ca65 with SMTP id h18-20020a05620a245200b006bbd8baca65mr24199159qkn.263.1663099136924;
        Tue, 13 Sep 2022 12:58:56 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:56 -0700 (PDT)
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
Subject: [PATCH 17/21] mm/dmb: introduce rmem designated-movable-block
Date:   Tue, 13 Sep 2022 12:55:04 -0700
Message-Id: <20220913195508.3511038-18-opendmb@gmail.com>
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

This commit allows Designated Movable Blocks to be created by
including reserved-memory child nodes in the device tree with
the "designated-movable-block" compatible string.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/of/of_reserved_mem.c | 15 ++++++---
 mm/dmb.c                     | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 65f3b02a0e4e..0eb9e8898d7b 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -23,6 +23,7 @@
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
 #include <linux/cma.h>
+#include <linux/dmb.h>
 
 #include "of_private.h"
 
@@ -113,12 +114,16 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 
-	/* Need adjust the alignment to satisfy the CMA requirement */
-	if (IS_ENABLED(CONFIG_CMA)
-	    && of_flat_dt_is_compatible(node, "shared-dma-pool")
-	    && of_get_flat_dt_prop(node, "reusable", NULL)
-	    && !nomap)
+	if (of_flat_dt_is_compatible(node, "designated-movable-block")) {
+		/* Need adjust the alignment to satisfy the DMB requirement */
+		align = max_t(phys_addr_t, align, DMB_MIN_ALIGNMENT_BYTES);
+	} else if (IS_ENABLED(CONFIG_CMA)
+		   && of_flat_dt_is_compatible(node, "shared-dma-pool")
+		   && of_get_flat_dt_prop(node, "reusable", NULL)
+		   && !nomap) {
+		/* Need adjust the alignment to satisfy the CMA requirement */
 		align = max_t(phys_addr_t, align, CMA_MIN_ALIGNMENT_BYTES);
+	}
 
 	prop = of_get_flat_dt_prop(node, "alloc-ranges", &len);
 	if (prop) {
diff --git a/mm/dmb.c b/mm/dmb.c
index 9d9fd31089d2..8132d18542a0 100644
--- a/mm/dmb.c
+++ b/mm/dmb.c
@@ -90,3 +90,67 @@ void __init dmb_init_region(struct memblock_region *region)
 		init_reserved_pageblock(page);
 	}
 }
+
+/*
+ * Support for reserved memory regions defined in device tree
+ */
+#ifdef CONFIG_OF_RESERVED_MEM
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) fmt
+
+static int rmem_dmb_device_init(struct reserved_mem *rmem, struct device *dev)
+{
+	struct dmb *dmb;
+
+	dmb = (struct dmb *)rmem->priv;
+	if (dmb->owner)
+		return -EBUSY;
+
+	dmb->owner = dev;
+	return 0;
+}
+
+static void rmem_dmb_device_release(struct reserved_mem *rmem,
+				    struct device *dev)
+{
+	struct dmb *dmb;
+
+	dmb = (struct dmb *)rmem->priv;
+	if (dmb->owner == (void *)dev)
+		dmb->owner = NULL;
+}
+
+static const struct reserved_mem_ops rmem_dmb_ops = {
+	.device_init	= rmem_dmb_device_init,
+	.device_release = rmem_dmb_device_release,
+};
+
+static int __init rmem_dmb_setup(struct reserved_mem *rmem)
+{
+	unsigned long node = rmem->fdt_node;
+	struct dmb *dmb;
+	int err;
+
+	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
+	    of_get_flat_dt_prop(node, "no-map", NULL))
+		return -EINVAL;
+
+	err = dmb_reserve(rmem->base, rmem->size, &dmb);
+	if (err) {
+		pr_err("Reserved memory: unable to setup DMB region\n");
+		return err;
+	}
+
+	rmem->priv = dmb;
+	rmem->ops = &rmem_dmb_ops;
+	pr_info("Reserved memory: created DMB at %pa, size %ld MiB\n",
+		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+
+	return 0;
+}
+RESERVEDMEM_OF_DECLARE(dmb, "designated-movable-block", rmem_dmb_setup);
+#endif
-- 
2.25.1

