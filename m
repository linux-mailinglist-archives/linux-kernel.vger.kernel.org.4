Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4332D681703
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjA3Qy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjA3Qyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:54:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA33D0A4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675097642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kkgm+GawpEMj0/b8bomXaQOPdUfNkg30jmt/yNSamL8=;
        b=gxfCEfelJYttzTDwKYcr9oLndeowUI3Nyy6eHe0dR7dZGMRNi5Ld5QyP5rZwxaxwAwpEzH
        +yWm/t4+V25oPzsfN0b2QrWYjKIQ+miYsig96xbXGhxqhp1iEaDuXEI4cm4YCnbDcLgL+8
        60VjfVTgNOuD7bMu5LwygHXp/izuk1E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-gBqYfPvaPYWf0LOucDsunA-1; Mon, 30 Jan 2023 11:53:55 -0500
X-MC-Unique: gBqYfPvaPYWf0LOucDsunA-1
Received: by mail-wm1-f72.google.com with SMTP id l5-20020a1ced05000000b003db300f2e1cso4630856wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkgm+GawpEMj0/b8bomXaQOPdUfNkg30jmt/yNSamL8=;
        b=ZjJfq3od+aIN1SZrFJytLWG7H0sOgicyimDbEP0fnpYvJ3NKuzIroPWii/Tmh7VXCD
         EQRIQaTnlTqrdGB7rw5JZsi9YtXJI7eiWsqdMFEj9xW3Dd4epkomhI8RJWfpZPLzhpRC
         HDGUysVjzMpTIUSrsbdPN924YwoA71zo2OyRWshX9hUCZ6lvBbIbC8SybfeapPWCYUnY
         1iQEjZ28U7VDZdJs3yUAbQo3hlCVnw4efwiPvIhyBqFs9uKC9t5lOzMic8YLzKXVNfjB
         RJb+0GC2F98KcCWf+RalhwrDB6xgNKK9y3Zma5cER+V7JvUjhJlYMPvduJ9O44jfwbc5
         YZYw==
X-Gm-Message-State: AFqh2krzppWkv7ZIQKxU0oydUP5/4i/R+NGsKkfwf47lUYG9awSL2hF/
        qZn0fmZVTSlOjhCPWipcwSYc1UUzxwR2xojt/rf3d8HddEX/tPnks2OEZaIm6aBUXlXwzwv+t1z
        by/Qt4BfJzTDzRKTzUzO4F6g6
X-Received: by 2002:a05:600c:3586:b0:3da:fb3c:c1ab with SMTP id p6-20020a05600c358600b003dafb3cc1abmr48909708wmq.0.1675097634459;
        Mon, 30 Jan 2023 08:53:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtAfoRcm7NT4ZYC0o5cofJixnO/hgW2tQbP0lBvYL7zDDtE7psgWTMQUvqDIedKwjr+ouHdog==
X-Received: by 2002:a05:600c:3586:b0:3da:fb3c:c1ab with SMTP id p6-20020a05600c358600b003dafb3cc1abmr48909693wmq.0.1675097634291;
        Mon, 30 Jan 2023 08:53:54 -0800 (PST)
Received: from p1.. ([77.75.244.146])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c465400b003dc43a10fa5sm8677422wmo.13.2023.01.30.08.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:53:53 -0800 (PST)
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
Subject: [PATCH] iommu: dart: DART_T8110_ERROR range should be 0 to 5
Date:   Mon, 30 Jan 2023 16:53:50 +0000
Message-Id: <20230130165350.58533-1-ecurtin@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
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
Signed-off-by: Eric Curtin <ecurtin@redhat.com>
---
 drivers/iommu/apple-dart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index efe877842f72..3adacf4094d7 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -112,15 +112,15 @@
 
 #define DART_T8110_ERROR_MASK 0x104
 
-#define DART_T8110_ERROR_READ_FAULT BIT(4)
-#define DART_T8110_ERROR_WRITE_FAULT BIT(3)
+#define DART_T8110_ERROR_READ_FAULT BIT(5)
+#define DART_T8110_ERROR_WRITE_FAULT BIT(4)
 #define DART_T8110_ERROR_NO_PTE BIT(3)
 #define DART_T8110_ERROR_NO_PMD BIT(2)
 #define DART_T8110_ERROR_NO_PGD BIT(1)
 #define DART_T8110_ERROR_NO_TTBR BIT(0)
 
 #define DART_T8110_ERROR_ADDR_LO 0x170
-#define DART_T8110_ERROR_ADDR_HI 0x174
+#define DART_T8110_ERROR_ADDR_HI 0x175
 
 #define DART_T8110_PROTECT 0x200
 #define DART_T8110_UNPROTECT 0x204
-- 
2.39.1

