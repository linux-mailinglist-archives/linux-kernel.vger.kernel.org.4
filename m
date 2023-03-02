Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E08E6A829A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCBMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCBMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:49:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AD01259F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677761313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qWubdolcTPcYZMWRbItbBs4vyBxRKmavcU+qlGC7gI4=;
        b=eUvQLSgB4lvqePnLEFQZ2ozTi8sM5Y2G5USsHBAQ7dfRi+atOurZ6D6G7OIkfTTDqMzWul
        benvq65FrMeJwjFAu+2QCxN0SEBU5r5OJMCrjl9IlF8Tsg0TQHmd0G+ittgq7xudrx2RHj
        ZS0lQmo69ccVfdWUIyVyTS/4KhIXVNY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-IK3w7Zd7NkSPDNNgeDYctQ-1; Thu, 02 Mar 2023 07:48:31 -0500
X-MC-Unique: IK3w7Zd7NkSPDNNgeDYctQ-1
Received: by mail-qk1-f200.google.com with SMTP id z23-20020a376517000000b00731b7a45b7fso10018369qkb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 04:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677761311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWubdolcTPcYZMWRbItbBs4vyBxRKmavcU+qlGC7gI4=;
        b=3x7khO5sMQ3nbobOjg8WJVV8A8920JITVrC7jzJJ4D7B+kkk0hnbQOTCqnaDUMSzD7
         Y4YYVvQPhl20Aj8RXPUgDx81yZV7rvdH/Cjs55XZmMZxiZ8y0KCadNYF8Ukwdnybsj0t
         jTj4+se9VI+myjeV6vbwa5TRxGrViIybZ0chcLsn1iU6uR1FBZWGKqbVO7zdXTjH7O4+
         OaxzgM8qmsjFB1rYn0m7Gba+Yk731vJI3Cw4cXx3sCf+OKpuplsw+oxJWyF9vsuatZfh
         OgTJL3YVrjbG3uOZ+ZOpd6rhWwfeV0mJVVkQtQlYNn6l9+qQHLZ6jNogN9GheFPENTcb
         xgzg==
X-Gm-Message-State: AO0yUKUUweZJ1lLKThyBbjGWnC2t1M/840b0mMJENptxBQZi6Cb97X5X
        QGxkrH7U8D/5eJgINFMRKieSI7OKRrQiEP26KUC7Czksn6DLziE8KZw+XIm5Ml55h1RU5FjE6rF
        TKFWgkiyddp/ydR3zMYGsNwgtcg3KyA==
X-Received: by 2002:a05:622a:5cf:b0:3bf:db54:b622 with SMTP id d15-20020a05622a05cf00b003bfdb54b622mr17085758qtb.30.1677761311190;
        Thu, 02 Mar 2023 04:48:31 -0800 (PST)
X-Google-Smtp-Source: AK7set9I+TSl84uLi9L/hA047N42TNQ2RbkOPTsi+FcB8UwVS5/djJiPNP8Zc/AXLoClAtyGqLq6XA==
X-Received: by 2002:a05:622a:5cf:b0:3bf:db54:b622 with SMTP id d15-20020a05622a05cf00b003bfdb54b622mr17085737qtb.30.1677761310938;
        Thu, 02 Mar 2023 04:48:30 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b9-20020ac801c9000000b003bfd8e2ab40sm7585267qtg.16.2023.03.02.04.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:48:30 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch, gsamaiya@nvidia.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/nvfw/acr: set wpr_generic_header_dump storage-class-specifier to static
Date:   Thu,  2 Mar 2023 07:48:19 -0500
Message-Id: <20230302124819.686469-1-trix@redhat.com>
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
drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c:49:1: error: no previous
  prototype for ‘wpr_generic_header_dump’ [-Werror=missing-prototypes]
   49 | wpr_generic_header_dump(struct nvkm_subdev *subdev,
      | ^~~~~~~~~~~~~~~~~~~~~~~

wpr_generic_header_dump is only used in acr.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c b/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
index 83a9c48bc58c..7ac90c495737 100644
--- a/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
+++ b/drivers/gpu/drm/nouveau/nvkm/nvfw/acr.c
@@ -45,7 +45,7 @@ wpr_header_v1_dump(struct nvkm_subdev *subdev, const struct wpr_header_v1 *hdr)
 	nvkm_debug(subdev, "\tstatus        : %d\n", hdr->status);
 }
 
-void
+static void
 wpr_generic_header_dump(struct nvkm_subdev *subdev, const struct wpr_generic_header *hdr)
 {
 	nvkm_debug(subdev, "wprGenericHeader\n");
-- 
2.27.0

