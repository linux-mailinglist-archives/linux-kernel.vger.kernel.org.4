Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0099A5EBF06
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiI0JxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiI0JxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1DB82D2B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664272380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mSdBTkmqZZlWAR7myYRSEj++3MrEkDDkR2XxSoPV9dE=;
        b=NsEeELfacDwmEaaw2n7TdPxgjBWlqLmNEYX8vDk7JKwjwJYxIzqIZ1A/AKWG32tlyXfxKW
        EmX0XUzVHUx19DCwjg2IfgvRqfrmOS4PQV0CNoblyCN+9jvpVmrl16iCRGB9F/REfzSxPD
        FWuQK7Zu30770jC3SMPNM2H/BwNrrPo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-186-94bZ6JscOTu6z9zB2nrUzg-1; Tue, 27 Sep 2022 05:52:54 -0400
X-MC-Unique: 94bZ6JscOTu6z9zB2nrUzg-1
Received: by mail-wr1-f69.google.com with SMTP id f9-20020adfc989000000b0022b3bbc7a7eso1988429wrh.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=mSdBTkmqZZlWAR7myYRSEj++3MrEkDDkR2XxSoPV9dE=;
        b=Iax4pmXGyKXiPysX9+1b04KjoEuarfxm6trxAMBaK7S0FcXADIjRuYjkeyLyRIxZx9
         2JA7GeJPBR3zI4HoB3/dcZC2QZ381m1k3lUfdINODHQOF6uJ2t8gd0wpTm1eOpwemT1N
         ibR38lrm6hL9jmioAvnq6K80H/8OZOPRtZ2W6hYDy0CprZFK8BKcwIqF6yN/+oRf8aYL
         zUYVpJO5loW9e8o7qoqhBlSRLhu829FVIuBecDu3JlBQi/BN1HEgElcDPm474SzvnQ7l
         CwDbR8cQYpJ6JvtxtbeHDTXN/nZgfqYfX9kFywUyHbzs/olpUNsEfnJ+sGvNDX10t2bD
         +d3w==
X-Gm-Message-State: ACrzQf0dKnazjwNDKfRgdy1pc99br36ioHnxq7SqsySIYJ8w4z9kzSZG
        6IsN/vj5YCj0y7ZZawTFC1J+GSOfFTjRtwxvmPW7NNxLRjRojGoNtpBsqCW14ft+zSbM5G+JZN6
        z+Sf3ZcbuuRoeXywEcx55z+aVoJVZzbHWkH3HsQ6lrM54VAsCLTByOTHCmr5TRFq6uN90Z2QtPV
        o=
X-Received: by 2002:a05:600c:1c89:b0:3b4:a612:c3e0 with SMTP id k9-20020a05600c1c8900b003b4a612c3e0mr1970306wms.20.1664272372506;
        Tue, 27 Sep 2022 02:52:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM595Bu/Ews3SXu+nOmdl/+BdfnQzam5EqMHzyQaFMWmgo+FxoMVIJ4gj0G61udQ5LcRDsB4Pw==
X-Received: by 2002:a05:600c:1c89:b0:3b4:a612:c3e0 with SMTP id k9-20020a05600c1c8900b003b4a612c3e0mr1970289wms.20.1664272372264;
        Tue, 27 Sep 2022 02:52:52 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003b4c979e6bcsm14258886wmn.10.2022.09.27.02.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:52:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Synchronize access to dma-buf imported GEM BOs
Date:   Tue, 27 Sep 2022 11:52:49 +0200
Message-Id: <20220927095249.1919385-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synchronize CPU access to GEM BOs with other drivers when updating the
screen buffer. Imported DMA buffers might otherwise contain stale data.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index a537692100d1..bc41a5ae810a 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -555,11 +555,18 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_m
 	if (!buf)
 		return -ENOMEM;
 
+	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
+	if (ret)
+		goto out_free;
+
 	iosys_map_set_vaddr(&dst, buf);
 	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect);
 
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+
 	ssd130x_update_rect(ssd130x, buf, rect);
 
+out_free:
 	kfree(buf);
 
 	return ret;
-- 
2.37.3

