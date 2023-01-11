Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433FC665F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbjAKPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjAKPlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:25 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045F429C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:24 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l26so11383590wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94eajVQl3EIphKCpXXhL7CnxhOfjsXCJp+mdLyrDZk0=;
        b=f7KHQ8uU7yo7cC1q+hRAYyai9jdEOJCO8tU1UcHPeDOQzr3zT9mcNDiHKbkAh9YMdi
         PcqaMKKeizVMG9LtdqmhoiqGGOE/2lkXWI8gQheuKM7IeiU6H+0SevQsiVwVjpCuYqMs
         pIc2/KEnN2fQGSipr275BOLjvkdqRmvXH0z6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94eajVQl3EIphKCpXXhL7CnxhOfjsXCJp+mdLyrDZk0=;
        b=pWSYNCmnT2PI6rz+iStjSFdkcZD/nGkGqb7i0pEXX6tc7aZZkB3XTZyunEyCwg9e0Z
         TSAc0WU5W8ehj2Ubxf9/hLNMTlf/p25r3AB5a4XEmsyJFtndZUBD4/iaFo90tZlAXZgN
         VtTA2hte6ZOsWC2xjcRKh2wPxUhnResaoOfjL3g1G+5HjpJdtML9cGw3XtdIARFM57Qv
         GNi+U8Kq4hRfc+fwBpODFYCxL9qr9ZCqS+vj0T/k134uVu/IME2XuuWx4Xy42nJD85jU
         1Nb4jM6i/np5Id3Ia4OeSGBsXDn1TH4sjwvtv8HMeNURlwW+yBr8dRytOe0+fYOE6Fj1
         qJgw==
X-Gm-Message-State: AFqh2krUZFqAbnOjbQ1BIv8eUa3JXaTnFs9iyC39HSdYUmf2pZnjNGdJ
        9JfZrDqmPrpKzZhf58KW6Es9sA==
X-Google-Smtp-Source: AMrXdXtf8JLpJynpq+UdfDiN+hQzDfbaEU0ALxQMv3+e3jXFqbhaPY9flDL5OZP4Gg/LNzzywZZOJw==
X-Received: by 2002:a05:600c:4e4f:b0:3cf:9d32:db67 with SMTP id e15-20020a05600c4e4f00b003cf9d32db67mr52259243wmq.3.1673451682597;
        Wed, 11 Jan 2023 07:41:22 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:21 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 02/11] drm/gma500: Use drm_aperture_remove_conflicting_pci_framebuffers
Date:   Wed, 11 Jan 2023 16:41:03 +0100
Message-Id: <20230111154112.90575-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one nukes all framebuffers, which is a bit much. In reality
gma500 is igpu and never shipped with anything discrete, so there should
not be any difference.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index cd9c73f5a64a..9b0daf90dc50 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -429,7 +429,7 @@ static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * TODO: Refactor psb_driver_load() to map vdc_reg earlier. Then we
 	 *       might be able to read the framebuffer range from the device.
 	 */
-	ret = drm_aperture_remove_framebuffers(true, &driver);
+	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &driver);
 	if (ret)
 		return ret;
 
-- 
2.39.0

