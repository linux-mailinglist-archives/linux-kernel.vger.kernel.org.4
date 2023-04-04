Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C856D5620
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjDDBab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjDDB3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AD130EE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680571720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=teftSvf3j+oDEfh9blmwCCDYEJcHPfUL8pF7dJUM03o=;
        b=IncNm1fPDxHBDTUELu/sHXIWEwspSdv/EaKKkxpT9CS5QXTJt4g+VS6y0t54gXRbFOA2MF
        KHYsGFvypRtVS29pLJyOwsheid6xdUUEGSacjkINck9N+MH0srovKQ1Em6B9RO+WuqZBiT
        DFGGaqpE4DGuXfjG/uk/X9rD9FfCZ6c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-FLija7F_OSm2WcHZT87vNg-1; Mon, 03 Apr 2023 21:28:39 -0400
X-MC-Unique: FLija7F_OSm2WcHZT87vNg-1
Received: by mail-qk1-f200.google.com with SMTP id 72-20020a37044b000000b0074694114c09so13902500qke.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 18:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teftSvf3j+oDEfh9blmwCCDYEJcHPfUL8pF7dJUM03o=;
        b=R1S1atXb00wPyKfxYgwJbBCPqqqf6rxm2H3zewp4VSggbCjRBeWRg38O8rDCRXb/yD
         9J5C5o3wyX1X+RbiD8b+D3jn2ZKVPR4hYrq+xk2egBR0u5G7VQwEgLKIsXM+msNs0E6z
         Hg9u1J/55RaWKtv7rlXcc4+hlcmXo7J6ssPFBjDaciZpk0z4b6bi7mtN5Y3BSeeO9n2d
         KqSTBaT4KIIni/xKjGdOIg2+zKAowU7YQma1vzAu90QqIPoCHH/xQz09Js2rKeBFmf2k
         qHxJF93diPYOEO8AUdEYh/GE/7bXEMm71tLuyf4BmtftLh8Jg9MmdOvyPT1hAOCCU3Iz
         rrtA==
X-Gm-Message-State: AAQBX9c0syVkcJs6SIs9eZyvI59ztBA0rqW3a9HMemK3TpQqX9f3g5VP
        whKNkNZqWIcO0gswwoW5T6c3xhpcZvP6jgWXdiGIHnWJMb/PAV0o4N1VDc83wHDbBftXQnIt5cU
        isYPlj2CCKxjTFiE+gIrcJnh8wQqZ3CgF
X-Received: by 2002:a05:622a:198f:b0:3b9:b70c:9697 with SMTP id u15-20020a05622a198f00b003b9b70c9697mr1012258qtc.5.1680571718500;
        Mon, 03 Apr 2023 18:28:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350bbiryGVTITqdtIsbZB0xVNKw9hfnyjZ3IusPT9JnYkHi5X/4j9GN4kCg0GViAYb2/AR5XwFA==
X-Received: by 2002:a05:622a:198f:b0:3b9:b70c:9697 with SMTP id u15-20020a05622a198f00b003b9b70c9697mr1012244qtc.5.1680571718299;
        Mon, 03 Apr 2023 18:28:38 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id de27-20020a05620a371b00b007486d9fa1d7sm3185102qkb.95.2023.04.03.18.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:28:38 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, airlied@redhat.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/disp: set varaiable gv100_disp_core_mthd_base storage-class-specifier to static
Date:   Mon,  3 Apr 2023 21:28:34 -0400
Message-Id: <20230404012834.1914225-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c:610:1: warning: symbol
  'gv100_disp_core_mthd_base' was not declared. Should it be static?

This variable is only used in one file so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
index 115d0997fd62..4ebc030e40d1 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
@@ -606,7 +606,7 @@ gv100_disp_curs = {
 	.user = 73,
 };
 
-const struct nvkm_disp_mthd_list
+static const struct nvkm_disp_mthd_list
 gv100_disp_core_mthd_base = {
 	.mthd = 0x0000,
 	.addr = 0x000000,
-- 
2.27.0

