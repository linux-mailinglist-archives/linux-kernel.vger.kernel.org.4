Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC775B91BF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiIOAd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiIOAdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54158B9AE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663201982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJ+r++kfC5cLOYGbcZ2ityl6Btvuyg0jJylQkWmqY/s=;
        b=hqaWhVC3FAYexTCvNgLp2WIRqm/ZJo5/pXvlDHh6wne9CZsiQMmf8ZjWNJLZE2zDSlwgvO
        avHKuhOuPSpPHYWh2fR7b4Z4JpycjhbeWcO9CpCtt1CA36QfY4n6KMC5DoHetV2p0/1a32
        Ik1+Jz3dI9lV+mYjQNjd3kdrzrJ5EL0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-192-s9gK1FDOPQ2uuOZkGRaH-g-1; Wed, 14 Sep 2022 20:32:59 -0400
X-MC-Unique: s9gK1FDOPQ2uuOZkGRaH-g-1
Received: by mail-ej1-f69.google.com with SMTP id jg32-20020a170907972000b0077ce313a8f0so4662025ejc.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AJ+r++kfC5cLOYGbcZ2ityl6Btvuyg0jJylQkWmqY/s=;
        b=Ut82wuY9Hv6E209hCJmPx5irnyz61NUT3yBDX26Z89DEPDkng1noDq80MjiYfd7PUE
         yUG8j2VXVkaw3BjV2x2jCFRCo3MvqHxLLhScsIZUffn8zoC/C/Ah0imwpFEFEn3EKjIV
         G87lO/1cjm7eMoaGkBg/n/2Db/CZ8NseqbY70OzIhbq+28dzM+LzxCdzDpRJBdNQs7ir
         9TPd2V7zWRY09cEip/B8TB9QCBqrkk0nEjV3a6P/T/O6cOGPB80WJM2rRwpy6RV3LqgP
         aHCe6WVqn9bCf8ZgoK47+YXQVWM+yyeFRXHoiy6w9VNDNgCAjFh5S2rxGFAOOTmWsOX+
         d2/w==
X-Gm-Message-State: ACgBeo19mbsK1b7b87Tq+siDIEHgI35lg46/k2Th4PU0j6iahVYag+KG
        Cwt3dj3G8NTuvfYMGR+qgXWjJ3ea2eScuq+Fqth4kHB3+2ViXS1sRsr16ahBwBE7PXGTKXT/B4V
        igxZn38VmZXZSEsTfQLjNUtRM
X-Received: by 2002:a17:907:a05:b0:77b:b538:6476 with SMTP id bb5-20020a1709070a0500b0077bb5386476mr15229458ejc.324.1663201978450;
        Wed, 14 Sep 2022 17:32:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6aUx7J56s8B+MvIs3ZSkyOZ3rDzmk5K47Dc+uS1kdk6njw7e3KJEUrvUuZKRX+25BjZL8S0w==
X-Received: by 2002:a17:907:a05:b0:77b:b538:6476 with SMTP id bb5-20020a1709070a0500b0077bb5386476mr15229452ejc.324.1663201978310;
        Wed, 14 Sep 2022 17:32:58 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id c18-20020a17090618b200b00773f3ccd989sm8240828ejf.68.2022.09.14.17.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:32:57 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 5/8] drm/fsl-dcu: use drm_dev_unplug()
Date:   Thu, 15 Sep 2022 02:32:28 +0200
Message-Id: <20220915003231.363447-6-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915003231.363447-1-dakr@redhat.com>
References: <20220915003231.363447-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver is unbound, there might still be users in userspace
having an open fd and are calling into the driver.

While this is fine for drm managed resources, it is not for resources
bound to the device/driver lifecycle, e.g. clocks or MMIO mappings.

To prevent use-after-free issues we need to protect those resources with
drm_dev_enter() and drm_dev_exit(). This does only work if we indicate
that the drm device was unplugged, hence use drm_dev_unplug() instead of
drm_dev_unregister().

Protecting the particular resources with drm_dev_enter()/drm_dev_exit()
is handled by subsequent patches.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 4139f674c5de..3ac57516c3fe 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -340,7 +340,7 @@ static int fsl_dcu_drm_remove(struct platform_device *pdev)
 	struct fsl_dcu_drm_device *fsl_dev = platform_get_drvdata(pdev);
 	struct drm_device *drm = &fsl_dev->base;
 
-	drm_dev_unregister(drm);
+	drm_dev_unplug(drm);
 	clk_disable_unprepare(fsl_dev->clk);
 	clk_unregister(fsl_dev->pix_clk);
 
-- 
2.37.3

