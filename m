Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758AA726765
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjFGRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjFGRbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6329210B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686159025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wYhf2D6abemq4eB8JjKJoDoUTpBsFesDL05ay5uU6iQ=;
        b=L+qpu7YFJ1c38ly1/qYuKMIPql1E5Q7arMKZywO9vX5IaZatRfKjY16TiJcfMRuWbEw++c
        YbPd58VB3mge+l8diXIICnZnR3W7jE3Gek6KEsvQKYrG62AIroPIZFElOzqPxwzutdHXkz
        wfvveIUuqWLG3ZXD/9jWz4iwEshtGxw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-y84JakWEMG-VbkWJCdQJDA-1; Wed, 07 Jun 2023 13:30:23 -0400
X-MC-Unique: y84JakWEMG-VbkWJCdQJDA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b1e6258204so20863921fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 10:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686159021; x=1688751021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYhf2D6abemq4eB8JjKJoDoUTpBsFesDL05ay5uU6iQ=;
        b=aecUOQV7vu8XME071aqj5rskvDI3f8BMbdUlTfJC3fN6/9dGJ2xDe2c6Cd2m400qM+
         15AQI2q4JcXI9LKzIgmKxLhpHtIZ4SkPPR/hkfDtJuZjmKk1fzcz+Pb3foD3urEREVKV
         WyHUi90cJlKYzysUt4HJn11AxsosEyTQDCn/xpzdINJHAdyZiKne1wJr4gUihxPc8qz5
         OhcvaJyPtb2F4VS30Bw2PVl5Kp7MX2218KXJ916frPXxseTMTV3sF6K+khlPMMWmQ71m
         TZ4aT4NLjGLVx5ch/Pyef/owKVwuSKhO3uLJHYaQgXy8rDNj9i8phPZ8SPJ3S61kSZNE
         oWHw==
X-Gm-Message-State: AC+VfDyF1LViUc8ztV7T96DHlmqt0nf9t2MqLDF1x1kt9DnKle/bVmRB
        qYAW5vT+YNAWgZq/Z4Qgl7EnrMQNmkhHT/aa0D2NorCVVjPzY0+RR9M9kruI7GoNgBm75sA9jT9
        U1mbIYYnswrjjL4MlmsXIMj+9MPxOCF2ovYBcg7TMq+CRXrwgzv2T+5tCQzbSkm41t9WjSLfx1D
        KOoR/bRI4=
X-Received: by 2002:a05:651c:113:b0:2b1:eab1:e083 with SMTP id a19-20020a05651c011300b002b1eab1e083mr2654408ljb.16.1686159021726;
        Wed, 07 Jun 2023 10:30:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gYxsb+2CrIRddoITGZU6B2w46sQx8Ey+CtOc1kASJGB8EPHrFtDTw/Kp2btYnR6nNeu5KmA==
X-Received: by 2002:a05:651c:113:b0:2b1:eab1:e083 with SMTP id a19-20020a05651c011300b002b1eab1e083mr2654397ljb.16.1686159021367;
        Wed, 07 Jun 2023 10:30:21 -0700 (PDT)
Received: from mjp-Z390-AORUS-MASTER.redhat.com (62-78-130-207.bb.dnainternet.fi. [62.78.130.207])
        by smtp.gmail.com with ESMTPSA id e24-20020a2e8198000000b00295a96a0f6csm2262191ljg.102.2023.06.07.10.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 10:30:20 -0700 (PDT)
From:   mpenttil@redhat.com
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: [PATCH v4] mm/migrate_device: Try to handle swapcache pages
Date:   Wed,  7 Jun 2023 20:29:44 +0300
Message-Id: <20230607172944.11713-1-mpenttil@redhat.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Penttilä <mpenttil@redhat.com>

Migrating file pages and swapcache pages into device memory is not supported.
Try to get rid of the swap cache, and if successful, go ahead as
with other anonymous pages.

Cc: Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
---

v4:
  - fix commit log message
  - delete empty line

v3:
  - adjust comments
  - add Reviewed-bys

v2:
  - use folio_test_anon() (Huang, Ying)

 mm/migrate_device.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index d30c9de60b0d..56411b063231 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -747,13 +747,22 @@ static void __migrate_device_pages(unsigned long *src_pfns,
 
 		if (is_device_private_page(newpage) ||
 		    is_device_coherent_page(newpage)) {
-			/*
-			 * For now only support anonymous memory migrating to
-			 * device private or coherent memory.
-			 */
 			if (mapping) {
-				src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
-				continue;
+				struct folio *folio;
+
+				folio = page_folio(page);
+
+				/*
+				 * For now only support anonymous memory migrating to
+				 * device private or coherent memory.
+				 *
+				 * Try to get rid of swap cache if possible.
+				 */
+				if (!folio_test_anon(folio) ||
+				    !folio_free_swap(folio)) {
+					src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
+					continue;
+				}
 			}
 		} else if (is_zone_device_page(newpage)) {
 			/*
-- 
2.17.1

