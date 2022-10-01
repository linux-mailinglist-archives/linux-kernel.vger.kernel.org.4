Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55055F1D0D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJAO6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJAO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3776A9C7F6
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664636308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJ+r++kfC5cLOYGbcZ2ityl6Btvuyg0jJylQkWmqY/s=;
        b=TMd0s6h1NJMCxlh0BQdQ+98pGnrkjR2itHYk8K51O4Dc5Tt/TqsjgzM7S++IRWhz11svBx
        tm0J0vSPCL11BWR7JvjOvljJgl40HWEebSySO5Z42qmWvmc8dGBLVlwerZIgS/o8rz9UE5
        vNuJKzvaris5o+henvXj5O7FwqudWW0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-532-j_ihxcmzPC6OesEF_CUH5Q-1; Sat, 01 Oct 2022 10:58:27 -0400
X-MC-Unique: j_ihxcmzPC6OesEF_CUH5Q-1
Received: by mail-ed1-f72.google.com with SMTP id f18-20020a056402355200b0045115517911so5606533edd.14
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AJ+r++kfC5cLOYGbcZ2ityl6Btvuyg0jJylQkWmqY/s=;
        b=UJYVzNEiWRjv1k4ATIMXZbqPwjryqExVqJKv1o8aKRs5Z+Sksx5aMW+XAsLcHswJsi
         AKm9oNbabB27K2rijdo+T+0M14Y28xXgUkrMXf/E1SlVKSmV3rUxIWGF3uhNk5eX6sml
         6fM8wYXu7KICE6AcM9KYrffiLrbp+4kXLFOM9HYsPRiRonqEhHV4ey42+5h7bZle5EiO
         L6oZQo2VzBOCqhXH2xLkJVtQw17z2IaxFBliLJrGlJtKqdG7+p66IllA4D4dqSsmGbP/
         hMtYlNNmnBIkAmyCINxQpvBYtGuo3JvSj/1Jp5BGFI/iFWeU2qsuAeZUSqAjiyoGBR/C
         kLWQ==
X-Gm-Message-State: ACrzQf13D8nC8rofUsQ3Is1qjvW3YDYo/sdnV7DMS6cXdBQc3TPYkKY5
        XqZXoWqOH+61KLpjxttF1aiyCv6Dq+xR9fpZ+1wtZShDefc8XR8dkWKOwJX6QOeAy1V+1Gs3UEs
        zgps3xIWic54mbZRdiJR0UNwx
X-Received: by 2002:a05:6402:d58:b0:458:5eca:a2c9 with SMTP id ec24-20020a0564020d5800b004585ecaa2c9mr8666626edb.306.1664636306052;
        Sat, 01 Oct 2022 07:58:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4syfsKXsxvYYfn7fvRiEa9nCMbGy+JIuRGwK9SSQu/V4k3YaMKliTq0OSkaegLlpeFXpoyig==
X-Received: by 2002:a05:6402:d58:b0:458:5eca:a2c9 with SMTP id ec24-20020a0564020d5800b004585ecaa2c9mr8666615edb.306.1664636305905;
        Sat, 01 Oct 2022 07:58:25 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906301100b00731582babcasm2832561ejz.71.2022.10.01.07.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 07:58:25 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 5/9] drm/fsl-dcu: use drm_dev_unplug()
Date:   Sat,  1 Oct 2022 16:57:58 +0200
Message-Id: <20221001145802.515916-6-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001145802.515916-1-dakr@redhat.com>
References: <20221001145802.515916-1-dakr@redhat.com>
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

