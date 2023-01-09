Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89C662229
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237105AbjAIJxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbjAIJv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:51:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5CA13CD5;
        Mon,  9 Jan 2023 01:51:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o13so4678773pjg.2;
        Mon, 09 Jan 2023 01:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDAjGpBu3Mnl4g0tMS5u5lzX5r4z+rhxODMUKPpJsN4=;
        b=g8LYcUCLHIw7IAyBhMBR3ffj/tozrM5o3Xa7ad/J9UbghcfeTX62GnsN53Tv+BpG8B
         HSqaB4f4vd5HKKZ+B+BcAyV2ibzEBeAlAh+M6JyhAchfCB0LFvxxebKUH4BTpNxwTtkz
         ZvAfP6JEBRy8wyeJLoilKDxLe3ePk0drFxwZhvuR3KH+q13Z6yi/UGuO4vkQKTXIXdZn
         aBhG23cG42VW0WwOeHBLZCrUJKcI+05tXFQQCL7aCqVHs20D5Ycr4NF4n2ZnuUqQyHYb
         p91XfR1VuLmMBwRkwhr2xXBD03q+oejqpZ6DHeotbKS3Osxk+/6vsD62GCrlsov7Tu3i
         hU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDAjGpBu3Mnl4g0tMS5u5lzX5r4z+rhxODMUKPpJsN4=;
        b=vyv7flM/J5Gc4S94AxjnjTI2jPE07/Qv1qpsbfca4R/mtOfWlQoHhx8GoFAK1YAmef
         ZCjroAlrhudtU/MP24z7ZqqRt6lBLM4eeUp6uFr1REdQnXqUnjleCt56sjuytjCUCs7Z
         OEO5a2hJOft+pU1TEFj9qRZ5bXpD+TN6uqDA18RRB+Y55ZLj7/78P+ilSzoHZwzMP6Zy
         0hXzcQju8jEeryo9VjNBiF19Gu69DNBrgSsnvo0P+IcTphNnB02/mRjjdeZ5sUruRiCr
         AmlBLU8AVxzCDPU/x3uzJgPX6jEiYB7xUfxGY4h3H1EXtov8wpq6/WmdDRjZztYofgiO
         Qx2Q==
X-Gm-Message-State: AFqh2kph9xTFrRUk782dDyEQP51gKo8cbYXaE1rFvTALkwYrXPmKNMc0
        fnuaRKeUBhv/zzCJ5NshgYY=
X-Google-Smtp-Source: AMrXdXu7X4gau8yqHDDsz43HDbv4qzl4J43k8U1FBoBWhy+LPqahRvWnatB2TarVCjtd2M3S0pfseQ==
X-Received: by 2002:a17:902:b60e:b0:189:89a4:3954 with SMTP id b14-20020a170902b60e00b0018989a43954mr67721404pls.41.1673257879828;
        Mon, 09 Jan 2023 01:51:19 -0800 (PST)
Received: from debian.me (subs03-180-214-233-26.three.co.id. [180.214.233.26])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027d8800b00188c5f0f9e9sm5651917plm.199.2023.01.09.01.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:51:18 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 41B2D104B84; Mon,  9 Jan 2023 16:51:10 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yann Sionneau <ysionneau@kalray.eu>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 4/8] Documentation: kvx: kvx-iommu: Use reST syntax for subsections
Date:   Mon,  9 Jan 2023 16:51:04 +0700
Message-Id: <20230109095108.21229-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109095108.21229-1-bagasdotme@gmail.com>
References: <874jt7fqxt.fsf@meer.lwn.net>
 <20230109095108.21229-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376; i=bagasdotme@gmail.com; h=from:subject; bh=NnxGT4jFPKBlpOHWRr7hAjGyC9a1TxJWHwHlgdJT4c4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDMm7H3d5Wrta+S5fz6P6tEtKNM1tYWN74I09K+udZPed6Uqb JHm1o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABPZ3sjwP/CdDHe7mvOd3gaZuVuyhc zm7d+nx7T8ak+X9fukffs+5zIy/FVcuvdfkEpnv5TijvBN3+ZkBPY+KTLpihUrm6fxe8F9fgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsection headings of "IOMMU implementation" is written using
triple-hash syntax, which is valid only for Markdown. Since the
documentation is written in reST, use appropriate syntax instead
(tilde underline).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/kvx/kvx-iommu.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/kvx/kvx-iommu.rst b/Documentation/kvx/kvx-iommu.rst
index f7f61777eee21e..5ed34463b8bb1f 100644
--- a/Documentation/kvx/kvx-iommu.rst
+++ b/Documentation/kvx/kvx-iommu.rst
@@ -110,7 +110,8 @@ the cluster.
 IOMMU is related to a specific bus like PCIe we will be able to specify that
 all peripherals will go through this IOMMU.
 
-### IOMMU Page table
+IOMMU Page table
+~~~~~~~~~~~~~~~~
 
 We need to be able to know which IO virtual addresses (IOVA) are mapped in the
 TLB in order to be able to remove entries when a device finishes a transfer and
@@ -137,7 +138,8 @@ huge page table for a given IOMMU (typically the PCIe IOMMU).
 As we won't refill the TLB we know that we won't have more than 128*16 entries.
 In this case we can simply keep a table with all possible entries.
 
-### Maintenance interface
+Maintenance interface
+~~~~~~~~~~~~~~~~~~~~~
 
 It is possible to have several "maintainers" for the same IOMMU. The driver is
 using two of them. One that writes the TLB and another interface reads TLB. For
@@ -149,7 +151,8 @@ following command in gdb:
 Since different management interface are used for read and write it is safe to
 execute the above command at any moment.
 
-### Interrupts
+Interrupts
+~~~~~~~~~~
 
 IOMMU can have 3 kind of interrupts that corresponds to 3 different types of
 errors (no mapping. protection, parity). When the IOMMU is shared between
@@ -163,7 +166,8 @@ stall one. So when an interrupt occurs it is managed by the driver. All others
 interrupts that occurs are stored and the IOMMU is stalled. When driver cleans
 the first interrupt others will be managed one by one.
 
-### ASN (Address Space Number)
+ASN (Address Space Number)
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 This is also know as ASID in some other architecture. Each device will have a
 given ASN that will be given through the device tree. As address space is
-- 
An old man doll... just what I always wanted! - Clara

