Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBD45F1DBE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJAQkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJAQkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:40:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471142F00F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664642410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7y8Kg9mwa0vUvwm8PGHbH7MwQR+LJsA0v4Hu5SumJhk=;
        b=JjONB6bwt0KxJQWlVLZaO5np3cm6Il9+/Djm8/mtBl2K7t3FCQrhuhPf33SuNuSRlSS3ap
        Ix+0PowIW5BxvGbejZTzV+GyNTj+zBOFEGbYjx8v0OxLvG1ZYEP03GGLMnIV3gPkatkBsC
        IXyNIwAnxHBWHS+Pl5yqPmd2gWABviM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-OVsv31N9PbqzNUBtUn8z-Q-1; Sat, 01 Oct 2022 12:40:09 -0400
X-MC-Unique: OVsv31N9PbqzNUBtUn8z-Q-1
Received: by mail-ed1-f71.google.com with SMTP id i17-20020a05640242d100b0044f18a5379aso5843989edc.21
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 09:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7y8Kg9mwa0vUvwm8PGHbH7MwQR+LJsA0v4Hu5SumJhk=;
        b=wSAadHfRhFO6D7qCmy4sNtbhP+rswQg+skw1HyxQDhNgeM5EeaeVxyZlrX7ooXeddu
         MD5VW5ed9JVt0fk9MbispfSZmcpJoijv9evSjp6zBHB1lYHpgeZACscUU99Z5hIqCXWE
         5gY8f0NrujZf9CwnA/jgHI/UHU+P9wCgFQxitL5szI1e2IkAAcf/NiurQFlX1c147gNw
         43Giunrcx1IEOclJE8uGgO5zBs+ZDEuVNOmrOlb6oxVX4ZwucOrLjVduRHnRYb8NX5d4
         ZS8H/XtCSdxPJGE69vrmWw698NQZx/imTzwXkwjFdP/4X1ecXSrWhl9MLGK9sKewfMhb
         PAlw==
X-Gm-Message-State: ACrzQf0Ea+KCW2rUTm2toHQsrx1nQUvz7XrbgWPy0tpv+fp8wnbRHSRn
        RtVeQudLXXyikS4JwBDccytwXHjuXqsGS2VphPn12b2C6jmJ9meoy5UF7GOS4m9sjxeONjZ3B6V
        1BI1Yxv3aPO5nrJG6zmOHXQ0O
X-Received: by 2002:a05:6402:4441:b0:454:8a74:5459 with SMTP id o1-20020a056402444100b004548a745459mr11944337edb.155.1664642408034;
        Sat, 01 Oct 2022 09:40:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4DTCDeA0KWBh6kSo2zm+j4Tg0+Kb8tU2UeueTgZVbg3102O9jUVRVuOw8bgSS/D1ZVeC8EAw==
X-Received: by 2002:a05:6402:4441:b0:454:8a74:5459 with SMTP id o1-20020a056402444100b004548a745459mr11944325edb.155.1664642407879;
        Sat, 01 Oct 2022 09:40:07 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id o25-20020a1709062e9900b0077f15e98256sm2865110eji.203.2022.10.01.09.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:40:07 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 5/9] drm/arm/malidp: use drm_dev_unplug()
Date:   Sat,  1 Oct 2022 18:39:42 +0200
Message-Id: <20221001163946.534067-6-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001163946.534067-1-dakr@redhat.com>
References: <20221001163946.534067-1-dakr@redhat.com>
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
 drivers/gpu/drm/arm/malidp_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 678c5b0d8014..aedd30f5f451 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -893,7 +893,7 @@ static void malidp_unbind(struct device *dev)
 	struct malidp_drm *malidp = drm_to_malidp(drm);
 	struct malidp_hw_device *hwdev = malidp->dev;
 
-	drm_dev_unregister(drm);
+	drm_dev_unplug(drm);
 	drm_kms_helper_poll_fini(drm);
 	pm_runtime_get_sync(dev);
 	drm_atomic_helper_shutdown(drm);
-- 
2.37.3

