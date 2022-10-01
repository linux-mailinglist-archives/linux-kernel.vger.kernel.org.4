Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012875F185F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiJABXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiJABVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C57D62A88
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664587166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsWBexLFDVqUOZMqbhy+SL8q312glCS9Mla/+vP6MEc=;
        b=anabbgehR3pSIQ5Lp31FUWC0WlsHQQbeGPpT03z9mABgQ2izp/+yR9JAUJsh7Ko2wPfupR
        7zt/b23f5SSuTkeJ2ZyWscF/sDZzinzZFhY0ewe01FcO6IH0c3cmrxs0O2gAbtUx7RNp8J
        R/vHQebEgXXEiOH7bC7PotFiJr2Ecto=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-oVjPkZFvPuS1D9XrFEkFMQ-1; Fri, 30 Sep 2022 21:19:24 -0400
X-MC-Unique: oVjPkZFvPuS1D9XrFEkFMQ-1
Received: by mail-ed1-f71.google.com with SMTP id w17-20020a056402269100b0045249bc17a9so4620225edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hsWBexLFDVqUOZMqbhy+SL8q312glCS9Mla/+vP6MEc=;
        b=PRiEwNC08jd96JC83S5Qs9XHbPNVzGbZPihV3s/NtsJ8tzZijKkwQizf6SPBY2g1iL
         owcSCy3Wk6YN2kNrGi4kBLuAYSI3rm3GRe+v5X2+fS2RdQg15HiaFj3TV2ZsziPAazBK
         sUvCq+K+HZ9tdQxtRHEqD3QG3tzJYL86VI3oN2guBkpY/h7YaHBh6ti0O6cYmJb4fZe+
         FVao6PD1Y2CgQ+Pm9sr7TX2USxy59w2om+8F9p65i1OP75Rd9cIV5V5b2nn8txx4bO49
         XkT+DJPXVFIvThM1xMUoC+NEljjAfPztDzZDFH5AdaFQlCR6hkOOMNUYht9MMQw1AdZI
         uzFQ==
X-Gm-Message-State: ACrzQf2KF5m9UoJX+gymdmjmb28cyhkHc57+lwxJqGWz1Xzq6fx2Nbbl
        OKdX3W1xLZlNmZopdFRdXCb7CRCTXr+R5zGqUEIzuhx7gRjxJvtWnoGTnXO9FF0SRlZs3uRi0XV
        vqiyEfpV3Pp3/hBq8IjC5ykeK
X-Received: by 2002:a17:907:2c77:b0:77c:59aa:c011 with SMTP id ib23-20020a1709072c7700b0077c59aac011mr8480021ejc.724.1664587163740;
        Fri, 30 Sep 2022 18:19:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4zcMskX82KTUkI5E7f0f84qForNAwCdRF+W3G2xOEagDWoB9NXlhmTv0aJC4uLhVIyAmcViA==
X-Received: by 2002:a17:907:2c77:b0:77c:59aa:c011 with SMTP id ib23-20020a1709072c7700b0077c59aac011mr8480004ejc.724.1664587163596;
        Fri, 30 Sep 2022 18:19:23 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7c154000000b004582a37889csm2573958edp.16.2022.09.30.18.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:19:23 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 4/7] drm/arm/hdlcd: use drm_dev_unplug()
Date:   Sat,  1 Oct 2022 03:19:02 +0200
Message-Id: <20221001011905.433408-5-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001011905.433408-1-dakr@redhat.com>
References: <20221001011905.433408-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
 drivers/gpu/drm/arm/hdlcd_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 120c87934a91..e41def6d47cc 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -325,7 +325,7 @@ static void hdlcd_drm_unbind(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
 
-	drm_dev_unregister(drm);
+	drm_dev_unplug(drm);
 	drm_kms_helper_poll_fini(drm);
 	component_unbind_all(dev, drm);
 	of_node_put(hdlcd->crtc.port);
-- 
2.37.3

