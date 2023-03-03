Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B6C6A985D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjCCN21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCCN2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC70259416
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677850058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xZViEbKSFytDEA7BQHkIqtpOmiHcpYWTt+g+Ou0aIyc=;
        b=ZX+9IjTEimLAVNmOgi58M1EnAxh9xhie3wyEtiBAOWf7we0Sz7b0XSIDhaQftBflXmmTUY
        2YBD3hPX3OdCJQYG73RX4m5PehJzfmi0Z3TTq4cXg47LhKRAQaAdrw83nocIb/XwxokqsM
        Rsvxk+kxFBCtfihVjcbpHlD2ZhLDs04=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-D9dw7lnHM82vCXbh4kTrjA-1; Fri, 03 Mar 2023 08:27:37 -0500
X-MC-Unique: D9dw7lnHM82vCXbh4kTrjA-1
Received: by mail-qk1-f200.google.com with SMTP id d4-20020a05620a166400b00742859d0d4fso1354844qko.15
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZViEbKSFytDEA7BQHkIqtpOmiHcpYWTt+g+Ou0aIyc=;
        b=XwUUyiWOE2zlFFZLVp5MpRza1PoEqx1zBi+WZK32lD09atIXkVWXpQFVdcTqxgLt+1
         ymP9fvodFimefMBBdEZNA5Rgt2eJRNA/yqudYVUpWGpllskmFqShP1DvO6ZZl0g7Cr95
         C4iQL1Zq2B6+JqrxG97u0Li7HvAgUC6L2P7SSWiidD4KPj3EdlmkAddonza8Q34XZYr7
         Ky7Sw06AvjNaDZkwOx8sQt0ogPmGAajQDaMGeTnG6EfkfNOtfrMDWirpEnwa589qBspk
         D+4WrXlc+cn0DQbKptL4VuFozUlffLypGMoWPKqPWNC0ClOj8vPLoyRuOCgJu71qGrGq
         npvg==
X-Gm-Message-State: AO0yUKUEgELkZRo5hcOBJ2N+COktYIvG1M8c1iDUvobYSD7tUV8n3WTK
        s4fxYZgvDREyVnF63FvluL5gALtr5CAtCltiDkwhqiZi6jIUrDbdgjL93BvcCK7cbTJD6MWoZNG
        E07/7+v4rgfOb0j7AXE9guJJPrSDLww==
X-Received: by 2002:a05:6214:d02:b0:56e:a07b:f4d1 with SMTP id 2-20020a0562140d0200b0056ea07bf4d1mr2488040qvh.2.1677850057315;
        Fri, 03 Mar 2023 05:27:37 -0800 (PST)
X-Google-Smtp-Source: AK7set8dveykfGBVt70UyNuMYBmxTxxZX4pm0Ls634+/jDN5mktxgyqaetnfSuCm+FshuDVD566LrA==
X-Received: by 2002:a05:6214:d02:b0:56e:a07b:f4d1 with SMTP id 2-20020a0562140d0200b0056ea07bf4d1mr2488014qvh.2.1677850057060;
        Fri, 03 Mar 2023 05:27:37 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d11-20020a05620a158b00b0073b8745fd39sm1682277qkk.110.2023.03.03.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:27:36 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/fifo: set gf100_fifo_nonstall_block_dump storage-class-specifier to static
Date:   Fri,  3 Mar 2023 08:27:31 -0500
Message-Id: <20230303132731.1919329-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

gcc with W=1 reports
drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c:451:1: error:
  no previous prototype for ‘gf100_fifo_nonstall_block’ [-Werror=missing-prototypes]
  451 | gf100_fifo_nonstall_block(struct nvkm_event *event, int type, int index)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~

gf100_fifo_nonstall_block is only used in gf100.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
index 5bb65258c36d..6c94451d0faa 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c
@@ -447,7 +447,7 @@ gf100_fifo_nonstall_allow(struct nvkm_event *event, int type, int index)
 	spin_unlock_irqrestore(&fifo->lock, flags);
 }
 
-void
+static void
 gf100_fifo_nonstall_block(struct nvkm_event *event, int type, int index)
 {
 	struct nvkm_fifo *fifo = container_of(event, typeof(*fifo), nonstall.event);
-- 
2.27.0

