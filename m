Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72EA6A623C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjB1WQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1WQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575A935275
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677622538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lkbO8Zr5IWtc4/j1ncgTgHjPYcbP4Lmw69fF7SUMZRo=;
        b=DlZ01mqQ168mqt1Yb3jdjdQu1NcHf6s7Cf5lKKkRvRE6oeYa0/WfWEaXigTjVGonpYvcyN
        h0b2IW0XSR3NIPNuuFxYjSna/M51hOT2kK4p3QhlsrAhCyqZZrUBqHVnwFv6gF/9T67LB+
        o9hXzJU2eFhJ+SWg4/EVu3kVqOE4vNw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-GML5aXSTM-qUIUVOp0T3iw-1; Tue, 28 Feb 2023 17:15:37 -0500
X-MC-Unique: GML5aXSTM-qUIUVOp0T3iw-1
Received: by mail-qk1-f199.google.com with SMTP id dm13-20020a05620a1d4d00b00742a22c4239so5021100qkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677622537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkbO8Zr5IWtc4/j1ncgTgHjPYcbP4Lmw69fF7SUMZRo=;
        b=xzQi959r5yPw5r5cpUdUqxKdwc+xovgAmYGrFtcCI7jBgdBMIx1iB8OerVKbTDPTvE
         Xo0tYJnPU991b56DYZt6vO7fG6uN90cWmCGprr3lkCBePmxtHFUu2+Sx01K6+1HnYxFJ
         72haHop/X9DrwdNWrA/ZpBySsecQI8vS7/YI/HRZ7luzEwvBbG3LhCPgjQfhw/XNPMWq
         2JKEjtByJXFN3HfBoNHLBDYGp4mXph/1n0gdRAICepWm5X2F8GEJqnD0Qp3X9NzUl3kc
         WIJ6MUfNaCIudt6ATPabRSRiHwNbXABmsKqGQuSN0B+rIeYItJhzLa898B3DEkgPQwfF
         820Q==
X-Gm-Message-State: AO0yUKXnFcOdP4dThgAhySwa7Nx2D+x1gA8PNYqKU8f5rdN2X4pbTZdX
        k6vYZT78G0+2PqshV5kyAPCpMAi5kLhdSDIwrldbBPtMSIHWziYANKco6nbJOCAir2mnMk1HdYO
        VS/TH2YE/AF+Rn/mVuPAkyjBT
X-Received: by 2002:a05:6214:23cb:b0:56f:5ac:60d5 with SMTP id hr11-20020a05621423cb00b0056f05ac60d5mr7339060qvb.0.1677622536789;
        Tue, 28 Feb 2023 14:15:36 -0800 (PST)
X-Google-Smtp-Source: AK7set8pCi0CAfSgN4N2zWMoTtjUNskBs56MvcyvKZa1GWtrB5qWMiGZ9OAVs86lglXXhTKllq5kqg==
X-Received: by 2002:a05:6214:23cb:b0:56f:5ac:60d5 with SMTP id hr11-20020a05621423cb00b0056f05ac60d5mr7339030qvb.0.1677622536534;
        Tue, 28 Feb 2023 14:15:36 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x2-20020ac84a02000000b003b9a426d626sm7076554qtq.22.2023.02.28.14.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:15:36 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/fifo: set nvkm_engn_cgrp_get storage-class-specifier to static
Date:   Tue, 28 Feb 2023 17:15:33 -0500
Message-Id: <20230228221533.3240520-1-trix@redhat.com>
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

smatch reports
drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c:33:18:
  warning: symbol 'nvkm_engn_cgrp_get' was not declared. Should it be static?

nvkm_engn_cgrp_get is only used in runl.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c
index b5836cbc29aa..93d628d7d508 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c
@@ -30,7 +30,7 @@
 #include <subdev/timer.h>
 #include <subdev/top.h>
 
-struct nvkm_cgrp *
+static struct nvkm_cgrp *
 nvkm_engn_cgrp_get(struct nvkm_engn *engn, unsigned long *pirqflags)
 {
 	struct nvkm_cgrp *cgrp = NULL;
-- 
2.27.0

