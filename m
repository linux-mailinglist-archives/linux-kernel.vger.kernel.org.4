Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656AF686634
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBAMqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBAMqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:46:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73A161D6E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675255549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=P5+/TE6LzKC07Kx1pXnv9JC6SnXItOhhp/p3/pfSlio=;
        b=FHqGSunL74FMC4V3tur1d7C2fe1/pOobIPUYnDG3HwVf8CrU0gY98D5D8cKS9yceMX70D5
        qh7eGpan9endCW76jFMvT7gQgjwySarN7sZriQHkF+xSDjY0+WF6vLKdzQqdQsEWhlCsig
        /C6lpRA/ySRaITan/zfXpr7FKUbJUgM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-Qb6o1VyANv6KILMRZS5MEA-1; Wed, 01 Feb 2023 07:45:45 -0500
X-MC-Unique: Qb6o1VyANv6KILMRZS5MEA-1
Received: by mail-wm1-f72.google.com with SMTP id o42-20020a05600c512a00b003dc5341afbaso928612wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 04:45:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5+/TE6LzKC07Kx1pXnv9JC6SnXItOhhp/p3/pfSlio=;
        b=hNXZ5F5zW7L6ok1ditPiI+EHt0rrYiSF9tlLgvIWuQo2MVb4Rzk5kEyviS5yPH2UOp
         224411vSnXj+HXyMGyrcNFGg8Ycsi7BWV7rcinwvZz5vMLTViec4kjX+VJtHlwYdOPJM
         VoAduf/AFOrgHIwZyKDBBnNrXB2EMMzfsAjzsD4uh6tM/bLS87ybNphy8VXKFxXcBe7l
         pN0vH68nn6zFjzhk3YPZ72Qe6EsJsxxiALUCjDZnqn4HhjCovh0BYOgXjn30/xQ3u4eb
         OBxud5GvtXsDCR+7QJjrVgLH2sq38k5IA48v9qbbQbPorokOjM9SzeMhn5brAuCaw8vB
         HmRg==
X-Gm-Message-State: AO0yUKW0idd1nsSOYYmqXnPmankeVHn6NQdoAkcEqrdGzNdaE85SvVNZ
        nzEBChftXfl07sskibPvs5KCaQ2zJC348tIufLFlGH9UBIWZS7tB3Odc7xs8rxMum2aunEDlyBU
        teer3UfPvY7vzceb6VjUDVT4B
X-Received: by 2002:a05:600c:314d:b0:3dc:5bd7:62ec with SMTP id h13-20020a05600c314d00b003dc5bd762ecmr1867365wmo.32.1675255544924;
        Wed, 01 Feb 2023 04:45:44 -0800 (PST)
X-Google-Smtp-Source: AK7set8X93HL3Pr+6m4ySC12znD+8GoeAtT14ExdjxV3jscGlmPBNCPHqUqxLTGT8qb1RFXrdrgjLw==
X-Received: by 2002:a05:600c:314d:b0:3dc:5bd7:62ec with SMTP id h13-20020a05600c314d00b003dc5bd762ecmr1867352wmo.32.1675255544695;
        Wed, 01 Feb 2023 04:45:44 -0800 (PST)
Received: from localhost.localdomain ([2001:bb6:963d:9e00:7585:fe90:1658:512f])
        by smtp.gmail.com with ESMTPSA id k27-20020a05600c081b00b003de77597f16sm1626333wmp.21.2023.02.01.04.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 04:45:44 -0800 (PST)
From:   Eric Curtin <ecurtin@redhat.com>
To:     asahi@lists.linux.dev
Cc:     Eric Curtin <ecurtin@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/APPLE MACHINE
        SUPPORT), iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iommu: dart: DART_T8110_ERROR range should be 0 to 5
Date:   Wed,  1 Feb 2023 12:42:58 +0000
Message-Id: <20230201124257.7801-1-ecurtin@redhat.com>
X-Mailer: git-send-email 2.39.1
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

This was detected by smatch as one "else if" statement could never be
reached. Confirmed bit order by comparing with python implementation [1].

drivers/iommu/apple-dart.c:991 apple_dart_t8110_irq()
warn: duplicate check 'error_code == ((((1))) << (3))'
  (previous on line 989)

Link: https://github.com/AsahiLinux/m1n1/commit/96b2d584feec1e3f7bfa [1]

Fixes: d8bcc870d99d ("iommu: dart: Add t8110 DART support")
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Eric Curtin <ecurtin@redhat.com
---
Changes in v2: Remove DART_T8110_ERROR_ADDR_HI change
---
 drivers/iommu/apple-dart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 42666617803d..fd09abe8d29e 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -111,8 +111,8 @@
 
 #define DART_T8110_ERROR_MASK 0x104
 
-#define DART_T8110_ERROR_READ_FAULT BIT(4)
-#define DART_T8110_ERROR_WRITE_FAULT BIT(3)
+#define DART_T8110_ERROR_READ_FAULT BIT(5)
+#define DART_T8110_ERROR_WRITE_FAULT BIT(4)
 #define DART_T8110_ERROR_NO_PTE BIT(3)
 #define DART_T8110_ERROR_NO_PMD BIT(2)
 #define DART_T8110_ERROR_NO_PGD BIT(1)
-- 
2.39.1

