Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0175B7BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIMUAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiIMT7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:59:51 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D9A7437A;
        Tue, 13 Sep 2022 12:59:05 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id u28so6371503qku.2;
        Tue, 13 Sep 2022 12:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Iv6LAHuQtTXeYWyq0DEDKZbOD/1nb3ztqrePD2HtkIE=;
        b=YrAFBuuyJkwRgGb5yJxtoTNNKh/7y4BOHe54UWWbwGw/7zVyvD5YS3xh6wOizb8P5y
         WPvQ65cSNAdgAQQ5wDi83N9jAKpum/P9kqfXIHyP2JYI4r5D1linVF+pAeO7tMTGeNJd
         s10XvBpPDdlS4NQdOIfsc4Y86zu8zbnj/iRe9JIr+LJQn5lsr3jvpDq8YkHXv8CVoVQ9
         l1Y7VxuX7aqVyF4T9IwYMUdPvuZE/+WFrgImMS1687EPItdw+VwpQNOwUoolbQ3Hf9aR
         Ox2qAlcyZj/+2EVV8HvGsz7p+nWwMiSQtDYItBS1H3jfaKi/gJ7kAUpfhR4jWWYZpfwT
         Vmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Iv6LAHuQtTXeYWyq0DEDKZbOD/1nb3ztqrePD2HtkIE=;
        b=A5hoLNND822FCudX2ihAYymlfGK7yfBKgzASY9nWsW4RyOUx9pJrGxe1oWXoPLDGrn
         n9QMHEvcjkJP9QFiI602C29eEQ7zbrft1bm9ozpIUrJd+ESBvZE9urWmoZUWHru0obVd
         LvPDaBgVzdREnhNZ435dbSVOGH+KKVIWC1/iJTZPIpGLOvCdxcQ5JGtMqDnPA8Q32R3q
         ZHSoQ1m2GIItCGRBXcLNDyteTt16DL3XFybem2w2iwluVF56wVatG/rk4eHZNaKUjSi7
         V2LTSmSa/XngYdssC51zP2M4DWaqQnkrsjNq6V51CPL93IugfbBbvs5f73tBf9OyAiKU
         W4hw==
X-Gm-Message-State: ACgBeo163S6u9sLJ7xkyJuyxNzyCpJNm308cw2CT06JiXqOycO4d6eYX
        1q/wHT16vw10JdFRJS3e6KM=
X-Google-Smtp-Source: AA6agR6fK874H1rNDTk5i/hsxGcmtY4AZlr+R557N3WVBFwFecth0fyDkTeEea5ukgS/JNJqcxXZjQ==
X-Received: by 2002:a37:916:0:b0:6ce:5f1c:d5d9 with SMTP id 22-20020a370916000000b006ce5f1cd5d9mr5679706qkj.737.1663099144354;
        Tue, 13 Sep 2022 12:59:04 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:59:03 -0700 (PDT)
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
Subject: [PATCH 19/21] dt-bindings: reserved-memory: shared-dma-pool: support DMB
Date:   Tue, 13 Sep 2022 12:55:06 -0700
Message-Id: <20220913195508.3511038-20-opendmb@gmail.com>
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

The shared-dmb-pool compatible string creates a Designated Movable
Block to contain a shared pool of DMA buffers.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../bindings/reserved-memory/shared-dma-pool.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml b/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
index 618105f079be..85824fe05ac9 100644
--- a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
@@ -22,6 +22,14 @@ properties:
           operating system to instantiate the necessary pool management
           subsystem if necessary.
 
+      - const: shared-dmb-pool
+        description: >
+          This indicates a shared-dma-pool region that is located within
+          a Designated Movable Block. The operating system is free to
+          use unallocated memory for movable allocations in this region.
+          Devices need to be tolerant of allocation latency to use this
+          pool.
+
       - const: restricted-dma-pool
         description: >
           This indicates a region of memory meant to be used as a pool
-- 
2.25.1

