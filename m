Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DF5B7BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiIMUAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiIMT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:59:17 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D55678BF6;
        Tue, 13 Sep 2022 12:58:54 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d17so8539481qko.13;
        Tue, 13 Sep 2022 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0ytqVsMPjuVvTMmUHQDgw++YWpDMZOL8Z97lPlE2FVY=;
        b=io9Nt4/RcZ2YZMphnT4cANVUYCQB6U7tpDHWWA0ymeRAMaiACQe59CDdxV3fKa+Hsn
         xNls20lsFyfw6rNS33zM5vtcFodTEOrCxgBbNhbWX8T1mEeMX+VwfC33CIm+xfP758LM
         zM7bYSmAZtJOGaBc2/pCs2H6YwEWsP5kO079m4wM+f6s/zfDbHxnmlkNGrxVR7sLq2J2
         vi+KzltoxbcgQVb6NYjPdS8rs20FudQRcZ6AiEV/jd58a8RhxFomEIPJSEoUVrySG9CU
         fGCpRyRxdV4msiy4sXSvtH2LCG/1JOnoJrLiDkFSx8Zr9e7tZ4S5+YfhjAOUxZaXHtxy
         O3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0ytqVsMPjuVvTMmUHQDgw++YWpDMZOL8Z97lPlE2FVY=;
        b=ZQs7vf9Islv6Wbory1SqXuxXCb2rDP4tYv2q0p7RXJaDcwPblba2PqaDF/QkC5Q5aU
         ldZ5JsmPRWL6PEprxVb/gLa6nE498IBUU6Qy58fFSQLaNbINQ7ljgyOUQCUbTKg5QPaL
         felKmzP9PAglUrKUOryFmpnkAkmy+YzGZuoV4P5KIEBngbVlRnQIiz6QAERn6b3u6Gnb
         TLZdWOHhXga0Zr8DC3MQU1sU9x5wpscl6nRKM619Hq5SdPZ33kK0xEy0+ykBSFtlRZHJ
         6SZdkDzwx3ve0qHpmSyuQ1Bp1xd5zvSaXf0tpz4N2n26ReYN7Cje8U1Zq8kdcua/EXis
         rCIA==
X-Gm-Message-State: ACgBeo2kxXrTsxSI/YzgtnPtx8AJIce6cBZkX9Ct4xJvGQslSpRVRQl0
        b7gB1WqYbHMBxwXgvXn3o9k=
X-Google-Smtp-Source: AA6agR6d/FiwNOHoDQ8OKNxH916Sryp0qXJllILzqqegobMzkZRMGgPUcF2Qjw5zlXSo5I0Sdx+6eA==
X-Received: by 2002:a05:620a:4407:b0:6cb:e111:32c2 with SMTP id v7-20020a05620a440700b006cbe11132c2mr18923399qkp.415.1663099133214;
        Tue, 13 Sep 2022 12:58:53 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a29cb00b006b8e049cf08sm276305qkp.2.2022.09.13.12.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:58:52 -0700 (PDT)
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
Subject: [PATCH 16/21] dt-bindings: reserved-memory: introduce designated-movable-block
Date:   Tue, 13 Sep 2022 12:55:03 -0700
Message-Id: <20220913195508.3511038-17-opendmb@gmail.com>
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

Introduce designated-movable-block.yaml to document the
devicetree binding for Designated Movable Block children of the
reserved-memory node.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 .../designated-movable-block.yaml             | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
new file mode 100644
index 000000000000..42f846069a2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/designated-movable-block.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/designated-movable-block.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: /reserved-memory Designated Movable Block node binding
+
+maintainers:
+  - devicetree-spec@vger.kernel.org
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+
+properties:
+  compatible:
+    const: designated-movable-block
+    description:
+      This indicates a region of memory meant to be placed into
+      ZONE_MOVABLE.
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reusable
+
+examples:
+  - |
+      reserved-memory {
+          #address-cells = <0x2>;
+          #size-cells = <0x2>;
+
+          DMB0@10800000 {
+               compatible = "designated-movable-block";
+               reusable;
+               reg = <0x0 0x10800000 0x0 0x2d800000>;
+          };
+
+          DMB1@40000000 {
+               compatible = "designated-movable-block";
+               reusable;
+               reg = <0x0 0x40000000 0x0 0x30000000>;
+          };
+
+          DMB2@80000000 {
+               compatible = "designated-movable-block";
+               reusable;
+               reg = <0x0 0x80000000 0x0 0x2fc00000>;
+          };
+      };
-- 
2.25.1

