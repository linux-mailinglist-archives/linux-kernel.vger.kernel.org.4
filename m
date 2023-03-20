Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7B96C2577
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCTXNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCTXND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D6B34008
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679353935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8OXg4VI8cm6vRN/hId3npmgyDD4BW9c8No9p4EZybmM=;
        b=L4zSnDCMUYQAY40Hrih5mRwlizyvJRgT90kfHwx7fIs+a/QVxWSnp6TRHexEqgsNVUOJzH
        HGN/on9bQe/L1PAsCE/OBdpIiquQpcm88vxtjG0fCzwRMhGN4mEXxdyS08hqqz4ml9myNx
        VFGIaHMK9sUep6bFcZtoMeaPeAua95g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-_BmeWqlQNwuGXuGWA0CFow-1; Mon, 20 Mar 2023 19:12:13 -0400
X-MC-Unique: _BmeWqlQNwuGXuGWA0CFow-1
Received: by mail-qk1-f198.google.com with SMTP id 72-20020a37044b000000b0074694114c09so1231909qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OXg4VI8cm6vRN/hId3npmgyDD4BW9c8No9p4EZybmM=;
        b=CVpLoNF9RdpkDrtaw0zpnS1J7mPsU0HHVbP8Xxt8oBD8N7VvSNQmeGV453O7Wj7cuv
         FaXiYoghM8a/gbZQrunRXn6DpNPmbl3OhPhUtP9cXZNBLwnXMlr4pJmKCPcO29fODsso
         OUc94KzX+e380/g2q4ho3MebOrfN1kHUu289xPxD9MYoA/OeP9DyLELWYzcYdDdGt6RP
         9mQNs/Q1IwRUwv4rKVeS86zC8eMrI7CLp+RsWH9rO5lM/YQRFr0IcccDQhjVpVCVFdJs
         e+UJVT3iUKsw6wWOfyDfWYXLQKb22upbsYEvVJR1XxO/iM0QtaksszXpwtSZZWAu0o+X
         Qd+Q==
X-Gm-Message-State: AO0yUKWPrvLi1WUB90hepJTYoJsjlfLtofCnqAYBeIzHu9Lv3tZudX90
        mUi5xm6bcefry1V2wV3Yq28TW6aCQITnKoBxpjkEg7KWsB0c0wBW/7508ulCwDA7vuhwivjp8M0
        03MV0YwVZAGLeNPyfPlgLmJac
X-Received: by 2002:a05:6214:e6a:b0:5b3:4b99:7af8 with SMTP id jz10-20020a0562140e6a00b005b34b997af8mr998492qvb.21.1679353933197;
        Mon, 20 Mar 2023 16:12:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set+WMLf2/hC3NpULLTuNzWukCaLGaPzgM3n1zv6eFgYYW5UjHVNHtsaQFRkKcay04SkrmfZlyQ==
X-Received: by 2002:a05:6214:e6a:b0:5b3:4b99:7af8 with SMTP id jz10-20020a0562140e6a00b005b34b997af8mr998476qvb.21.1679353932932;
        Mon, 20 Mar 2023 16:12:12 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a0d4a00b0074281812276sm1755579qkl.97.2023.03.20.16.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:12:12 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     peter.ujfalusi@gmail.com, vkoul@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] dmaengine: ti: edma: remove unused edma_and function
Date:   Mon, 20 Mar 2023 19:12:09 -0400
Message-Id: <20230320231209.1728940-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
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

clang with W=1 reports
drivers/dma/ti/edma.c:321:20: error: unused function
  'edma_and' [-Werror,-Wunused-function]
static inline void edma_and(struct edma_cc *ecc, int offset, unsigned and)
                   ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/dma/ti/edma.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index fa06d7e6d8e3..9ea91c640c32 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -318,14 +318,6 @@ static inline void edma_modify(struct edma_cc *ecc, int offset, unsigned and,
 	edma_write(ecc, offset, val);
 }
 
-static inline void edma_and(struct edma_cc *ecc, int offset, unsigned and)
-{
-	unsigned val = edma_read(ecc, offset);
-
-	val &= and;
-	edma_write(ecc, offset, val);
-}
-
 static inline void edma_or(struct edma_cc *ecc, int offset, unsigned or)
 {
 	unsigned val = edma_read(ecc, offset);
-- 
2.27.0

