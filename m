Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603B5665F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbjAKPlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjAKPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D089D43
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so14682005wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJcVjf8pDC4yO+skqSU0XKC89Tk1zxOfzlV0lRIff7c=;
        b=aZrY9NQHD2THbetIXlgCj7dIm+IHrmHhq7F17hc477mP1n6APHub6Ck2CJ3DzdinLT
         ElgTJWC47fGty6V4ACS9w2xVnnEuSz4Z9Kz+uIPLYWQdsKohf8UMi7KQUG29Hent2GEo
         Jqem0opQMtn8iekTGOrnsTul/w0T9hALDGZaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJcVjf8pDC4yO+skqSU0XKC89Tk1zxOfzlV0lRIff7c=;
        b=UN75pwRTYBhm9beKyiQ/H5jrUB0QjdcmojEaFLmNKnc6s5x5XwrCvflECq0J23PzTw
         5vGYtU3ADpwpbtwHLCOPpcNLVad4ruPEYfFWixFkeg4Nvz+bVj/TTyNNZ7mGT6YLcToA
         6xatWVeAaAkgFBewP43AWr+udLvzE4iTp22av31WVYmbDcvPvdF1eNWSAxqDvxghWViL
         Abiyd3sBcXPNXle5JvNXe+/b93ycE109F+TPn2+0IGqIUdBAQXJBcjcpAO29weY4GQGj
         K5EkBIuvPWjdPut95rNb+IUrW0n6FRSh+t+pzemFg0V5AvzW4xTPfLHD47dbvi6BbInC
         ILhQ==
X-Gm-Message-State: AFqh2koPMJxHstywZ4M7WfYTDj2J/aomg5V80GyIsTyHEUCKt7CLMrT1
        KZIeBGahfL+Y9mwd9+ByATqqpg==
X-Google-Smtp-Source: AMrXdXtLjz41DgbsTgGEKg48S+bFLaYgDm0CS1oQOQdxAw8CZ2RXHl0aiRV2ZxkGGAbOj+J7AcqZ2Q==
X-Received: by 2002:a05:600c:1d8a:b0:3d9:ebab:ccff with SMTP id p10-20020a05600c1d8a00b003d9ebabccffmr10800367wms.33.1673451687083;
        Wed, 11 Jan 2023 07:41:27 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:26 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: [PATCH 05/11] video/aperture: Only kick vgacon when the pdev is decoding vga
Date:   Wed, 11 Jan 2023 16:41:06 +0100
Message-Id: <20230111154112.90575-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise it's bit silly, and we might throw out the driver for the
screen the user is actually looking at. I haven't found a bug report
for this case yet, but we did get bug reports for the analog case
where we're throwing out the efifb driver.

References: https://bugzilla.kernel.org/show_bug.cgi?id=216303
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/aperture.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 3d8c925c7365..6f351a58f6c6 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -341,6 +341,9 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 			return ret;
 	}
 
+	if (!primary)
+		return 0;
+
 	/*
 	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
 	 * otherwise the vga fbdev driver falls over.
-- 
2.39.0

