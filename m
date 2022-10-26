Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9022060E525
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiJZQAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiJZQAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E97165B4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666800002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itig1DysDm1r5HC5ecqxAlDsypjxBSfKhMXt70+uPpQ=;
        b=AiGnBsF6b2h2pkK1fzvvUkc31r+uNTzcSquim+2RBLBKbm1m7kltGHvyDNVwJANCJVO6CN
        z38QXLHez/OkH4VtY0C94WJt5RyFMGc+KPgnpwt6D3k8Xbl7TghgEceurW5GCtflIFoDwx
        hItzxBu3wsnYKr367Fcp9uuIIo0Idlo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-354-aRldX_DWPiaHUSySuefjCg-1; Wed, 26 Oct 2022 12:00:00 -0400
X-MC-Unique: aRldX_DWPiaHUSySuefjCg-1
Received: by mail-ej1-f71.google.com with SMTP id gn34-20020a1709070d2200b0079330e196c8so4814479ejc.16
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itig1DysDm1r5HC5ecqxAlDsypjxBSfKhMXt70+uPpQ=;
        b=pg7W0BDD6cka4w7PYjcGNMS6fndIPmQFccJw5I0FQJc2PwhP2ttEcg9WsJVb5EaBkH
         yu+6Mvi1sLIMjorcUABCWhHhmnCi64kFztADSz0B7Vh+N+wkZxpk5BpBonWzhVpOo2wd
         7NGzzU0W4LnGOvfWFwfLcdweCE5itNRw/g9g4Tcoa4RopwboCbK9PWtqT/95LryiM2gd
         r5d3lk8PyN8qwnEVH1urTw8dTbYWXSgZVoyHb4ta/TaAo1iR8bwIFmo/niSlTRbxYmKV
         ZwUKzDd73fx1e6wE2dd/0VPDNPWSqV0A1aGMSYLIrz9xS7YTFhbffHDOklu6Jr12C8Le
         egcw==
X-Gm-Message-State: ACrzQf3jAlAfcvJ1Xj2SeyQCGONd0tnsXXO6v4VNTn7bCZQW0y7gqNG3
        utPHCqk27hELjUWdwwHHOKtDX0o11cD4dqWgWKagvIWrlsRF1kMzx//XaCOL1kD8suZ3q4H45Hr
        BkuzjHit6AcyF3ONHAqzFO9nN
X-Received: by 2002:a17:906:7304:b0:6ff:a76:5b09 with SMTP id di4-20020a170906730400b006ff0a765b09mr37544941ejc.193.1666799999558;
        Wed, 26 Oct 2022 08:59:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6RAzeOky+aWicOwm978Au2a0Q8a4f3wMcSfD0JMt2cDzwU3i4EMkYFttEdSS0oSo40LYFJEA==
X-Received: by 2002:a17:906:7304:b0:6ff:a76:5b09 with SMTP id di4-20020a170906730400b006ff0a765b09mr37544925ejc.193.1666799999427;
        Wed, 26 Oct 2022 08:59:59 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090685d100b00773f3ccd989sm3211326ejy.68.2022.10.26.08.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:59:58 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 5/5] drm/arm/malidp: remove calls to drm_mode_config_cleanup()
Date:   Wed, 26 Oct 2022 17:59:34 +0200
Message-Id: <20221026155934.125294-6-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221026155934.125294-1-dakr@redhat.com>
References: <20221026155934.125294-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_mode_config_init() simply calls drmm_mode_config_init(), hence
cleanup is automatically handled through registering
drm_mode_config_cleanup() with drmm_add_action_or_reset().

While at it, get rid of the deprecated drm_mode_config_init() and
replace it with drmm_mode_config_init() directly.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 678c5b0d8014..bebaa5a07e27 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -396,7 +396,9 @@ static int malidp_init(struct drm_device *drm)
 	struct malidp_drm *malidp = drm_to_malidp(drm);
 	struct malidp_hw_device *hwdev = malidp->dev;
 
-	drm_mode_config_init(drm);
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		goto out;
 
 	drm->mode_config.min_width = hwdev->min_line_size;
 	drm->mode_config.min_height = hwdev->min_line_size;
@@ -407,24 +409,16 @@ static int malidp_init(struct drm_device *drm)
 
 	ret = malidp_crtc_init(drm);
 	if (ret)
-		goto crtc_fail;
+		goto out;
 
 	ret = malidp_mw_connector_init(drm);
 	if (ret)
-		goto crtc_fail;
-
-	return 0;
+		goto out;
 
-crtc_fail:
-	drm_mode_config_cleanup(drm);
+out:
 	return ret;
 }
 
-static void malidp_fini(struct drm_device *drm)
-{
-	drm_mode_config_cleanup(drm);
-}
-
 static int malidp_irq_init(struct platform_device *pdev)
 {
 	int irq_de, irq_se, ret = 0;
@@ -874,7 +868,6 @@ static int malidp_bind(struct device *dev)
 bind_fail:
 	of_node_put(malidp->crtc.port);
 	malidp->crtc.port = NULL;
-	malidp_fini(drm);
 query_hw_fail:
 	pm_runtime_put(dev);
 	if (pm_runtime_enabled(dev))
@@ -902,7 +895,6 @@ static void malidp_unbind(struct device *dev)
 	component_unbind_all(dev, drm);
 	of_node_put(malidp->crtc.port);
 	malidp->crtc.port = NULL;
-	malidp_fini(drm);
 	pm_runtime_put(dev);
 	if (pm_runtime_enabled(dev))
 		pm_runtime_disable(dev);
-- 
2.37.3

