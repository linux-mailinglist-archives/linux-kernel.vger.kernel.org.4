Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233B26D7AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjDELFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbjDELFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:05:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5E546B2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680692704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D1iQ5cfXUobOUC8Rzy8Kki+uzPzlUU+kbKGwGQ+L2M4=;
        b=NkaWCH+i3mgLiDPrGBCMbVTMO0O/DRWHQLihXYx1gLacFaMiiDmM4mgjbH6Z3cBYRPcEHi
        xKaOvyfjas31WYuPd34JPXZ0clNzm5IY4j070rL/98UniY4rMwHj3H2/9BLRiyD5Cfkg24
        v8aPOXgJf9STDqvfXaLDcF32c4nK9sw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-j6DJbQDjNNqJvLKgRpW6sg-1; Wed, 05 Apr 2023 07:05:03 -0400
X-MC-Unique: j6DJbQDjNNqJvLKgRpW6sg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3e03178131bso1280201cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 04:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680692701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1iQ5cfXUobOUC8Rzy8Kki+uzPzlUU+kbKGwGQ+L2M4=;
        b=1yVF/JngJ+R9jswYkxzgslMWXzLY8mirWkKQ1D0fdJt32a0iX66XK+idLf6huMOKEl
         YGLSmzmulayutcRk3nAuJRuMi1irwmCsoMg0IWtMsUmy3BspXZjw16GTkdu3VHD1S4PQ
         HN2v5Et53/RgX5wTQfjLXTpJg8FbSGLmqhSi5nkQXKsTE6EdWAWq0C8K4ANh4/4D9bG/
         LZ0mcrORSEbGkr1uuumW+7wt2fAIY/LAZpUdicSTWJG4J4/PH2ErCF+P8pQ5FrrPzOKq
         MsfU9yMAKbIad4ix0DQqC+o3MT7VWRqPdj8xncjg+ztTMZGOT0N/aoy52aWMHm21FXIo
         CJ9w==
X-Gm-Message-State: AAQBX9ean0aQMYBrwAfyPICtfNAzDHL1Zf2UogAyM0S79UGfb7qYp/Ia
        N9ZM+lcKmsZMNpJEThf5GrHkfraXdr+/e3l40IMOlU/F8L1AFVJRW0LC68POyooG5Zom5bdMZhf
        r6g873MtWixdHEhhApjdyfKGfCvcdMHROiYc1DbA8IeY/r2ILEjn2VRl+CA7M+fW+rYtXz0Blwk
        kUih9JqDE=
X-Received: by 2002:a05:622a:188e:b0:3e4:d3cc:4211 with SMTP id v14-20020a05622a188e00b003e4d3cc4211mr2771883qtc.3.1680692701498;
        Wed, 05 Apr 2023 04:05:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350aIXirj4rP1VlnrQftjsVcsEyJPTmnJjGaVkizUa1zfyv4BxeuGC8+LxXlqfSDIGNjW5Ljgig==
X-Received: by 2002:a05:622a:188e:b0:3e4:d3cc:4211 with SMTP id v14-20020a05622a188e00b003e4d3cc4211mr2771837qtc.3.1680692701001;
        Wed, 05 Apr 2023 04:05:01 -0700 (PDT)
Received: from kherbst.pingu.com (ip1f113ce7.dynamic.kabel-deutschland.de. [31.17.60.231])
        by smtp.gmail.com with ESMTPSA id j3-20020a05620a146300b0074876c013f9sm4317207qkl.123.2023.04.05.04.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:04:58 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>
Subject: [PATCH] drm/nouveau/fb: add missing sysmen flush callbacks
Date:   Wed,  5 Apr 2023 13:04:55 +0200
Message-Id: <20230405110455.1368428-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.39.2
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

Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/203
Fixes: 5728d064190e1 ("drm/nouveau/fb: handle sysmem flush page from common code")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c | 1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c | 1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c | 1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c
index 76678dd60f93f..c4c6f67af7ccc 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c
@@ -31,6 +31,7 @@ gf108_fb = {
 	.init = gf100_fb_init,
 	.init_page = gf100_fb_init_page,
 	.intr = gf100_fb_intr,
+	.sysmem.flush_page_init = gf100_fb_sysmem_flush_page_init,
 	.ram_new = gf108_ram_new,
 	.default_bigpage = 17,
 };
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c
index f73442ccb424b..433fa966ba231 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c
@@ -77,6 +77,7 @@ gk104_fb = {
 	.init = gf100_fb_init,
 	.init_page = gf100_fb_init_page,
 	.intr = gf100_fb_intr,
+	.sysmem.flush_page_init = gf100_fb_sysmem_flush_page_init,
 	.ram_new = gk104_ram_new,
 	.default_bigpage = 17,
 	.clkgate_pack = gk104_fb_clkgate_pack,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
index 45d6cdffafeed..4dc283dedf8b5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
@@ -59,6 +59,7 @@ gk110_fb = {
 	.init = gf100_fb_init,
 	.init_page = gf100_fb_init_page,
 	.intr = gf100_fb_intr,
+	.sysmem.flush_page_init = gf100_fb_sysmem_flush_page_init,
 	.ram_new = gk104_ram_new,
 	.default_bigpage = 17,
 	.clkgate_pack = gk110_fb_clkgate_pack,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c
index de52462a92bf0..90bfff616d35b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c
@@ -31,6 +31,7 @@ gm107_fb = {
 	.init = gf100_fb_init,
 	.init_page = gf100_fb_init_page,
 	.intr = gf100_fb_intr,
+	.sysmem.flush_page_init = gf100_fb_sysmem_flush_page_init,
 	.ram_new = gm107_ram_new,
 	.default_bigpage = 17,
 };
-- 
2.39.2

