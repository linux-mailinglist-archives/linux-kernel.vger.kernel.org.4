Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3766F20BA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346678AbjD1WNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjD1WNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:13:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1553144AE
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682719965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4SoSIPzR5rKJuvsqRvAsre6hhkg4OyDHoRlHAIoohdY=;
        b=QQ0td0puVWBteFZ2bKvDUyTj07Db7q20MvmgQOVF1HbC2XykDdo4przXYn4u5wjaw3M/gE
        CuPVHJAZoRvRK6vr9fRgJLQEgm6MNB3MDuI55mxmw9QEt7Fz0+f9NxaSLQ3hbAaxCqYj6v
        HJWgG6MuEYjmsdBdmeQWQHjJP46mvHA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-invdo9CnPmC5M6OhTy3GtQ-1; Fri, 28 Apr 2023 18:12:44 -0400
X-MC-Unique: invdo9CnPmC5M6OhTy3GtQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ef4314d9e5so6919196d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682719963; x=1685311963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SoSIPzR5rKJuvsqRvAsre6hhkg4OyDHoRlHAIoohdY=;
        b=dtKOuosHZLTSl3aF8fHcROKKCOebScZ2/JzHV8K2TpfUpEiQuvhtK6cqrWJUtmGws+
         I213Su5qbVWTPp0XVy34oItxP8bElYQS+k0mf3RxauIXAKnbH6/STqP9c8zhPxUZas0L
         gGo1DAq7jXwLSYq9goG7DFahLzYzJ2t31HiOVOqISqOXifTj3LwlqqBHmacc38ihEI4K
         urq9FkG6Kp7Z1CrdlKvt6SpdbWFR9/vIlkoMNYvbSXBZAP+vSN00luh94RKHITbD8Uy2
         ZPJWsli586sgPGvmYKMsSZcu6h3gO1MvhSg2ynt8q6gFAF2yLxi1ybxhinysoVWNDbyS
         jFOw==
X-Gm-Message-State: AC+VfDzfm02OkB30FVVnti6y0o1eAs92SMXYeFKNW6USyEVlX5MO3OA9
        b+S1Q0uGM5cQdlH4yoxgVmmmlu/pLUFLFYQuSurRA+zb5bCoPysNbbyTei6J7/zTzz0vsyu0cfS
        LEF7MMqTmsSR9ehVF7EvBtXDY
X-Received: by 2002:a05:6214:5015:b0:5f1:5cf1:b4c0 with SMTP id jo21-20020a056214501500b005f15cf1b4c0mr11992743qvb.38.1682719963545;
        Fri, 28 Apr 2023 15:12:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ68wQ60YLfWK41nYriImzutStd+XuFNGZ3TB+rrfiw7k7lQMX+A0ewHmTHgEP7TF2v1ef0Bwg==
X-Received: by 2002:a05:6214:5015:b0:5f1:5cf1:b4c0 with SMTP id jo21-20020a056214501500b005f15cf1b4c0mr11992721qvb.38.1682719963287;
        Fri, 28 Apr 2023 15:12:43 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j13-20020a0cf50d000000b005eee5c22f30sm6731089qvm.139.2023.04.28.15.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 15:12:42 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     arnd@arndb.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] powerpc: remove unneeded if-checks
Date:   Fri, 28 Apr 2023 18:12:40 -0400
Message-Id: <20230428221240.2679194-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ppc64, gcc with W=1 reports
arch/powerpc/platforms/cell/spu_base.c:330:17: error:
  suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  330 |                 ;
      |                 ^
arch/powerpc/platforms/cell/spu_base.c:333:17: error:
  suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  333 |                 ;
      |                 ^

These if-checks do not do anything so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/powerpc/platforms/cell/spu_base.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 7bd0b563e163..dea6f0f25897 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -326,12 +326,6 @@ spu_irq_class_1(int irq, void *data)
 	if (stat & CLASS1_STORAGE_FAULT_INTR)
 		__spu_trap_data_map(spu, dar, dsisr);
 
-	if (stat & CLASS1_LS_COMPARE_SUSPEND_ON_GET_INTR)
-		;
-
-	if (stat & CLASS1_LS_COMPARE_SUSPEND_ON_PUT_INTR)
-		;
-
 	spu->class_1_dsisr = 0;
 	spu->class_1_dar = 0;
 
-- 
2.27.0

