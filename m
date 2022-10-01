Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868685F1864
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiJABXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJABWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A71110
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664587173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IDL/AgTFWdm+PP/N7/EovNn2CFq5LCV9poLaDqClvoQ=;
        b=FVkx7Pr4QJZre7vkhoYsIU3kCsNK+ONERx9BkHuVS4zEuGZpIZlWeTArHC2KfnVF7AyvQu
        ZO8ZmD+fMOc2u8TTwkQr4YJJozxmx2gi0kVZ03cNaS4xKl5PtUK52qk4CmvDYFPGzCBuyI
        b+wuj1vR9wLaraCcqwzRkIlNiVhph8E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-369-fDxz7-gXP0yITLD4Fy3f0Q-1; Fri, 30 Sep 2022 21:19:32 -0400
X-MC-Unique: fDxz7-gXP0yITLD4Fy3f0Q-1
Received: by mail-ed1-f71.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so4618970eda.19
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IDL/AgTFWdm+PP/N7/EovNn2CFq5LCV9poLaDqClvoQ=;
        b=cQcqSviRv2mj85wbQKQ0np5OPACL2zu0ERnik03oCDpKhT3TNkDLTrp6PWeh0Iyxjb
         S10H+ZRadeRg+DkT9IqfRzhcZG3vL52UcSv6oxphXmrcFNK+2+jlY0HsJ6EfmHk+Zaxa
         F7eS7idUnTrg7kerP1jyU1QbgRmlktvRG+ucBHI4p2uF7fzU4ziZ/sfHP+QyFv8iWmXS
         m94rwM9sFO77bknEcsjF353CTxWsDn7mAzxW26FDy1fYSJ3K/aAV+oDUw88+VHWD7PFC
         DzeflDQpHHmotZt40UG/2p3fkAGOJH1O+CvUu14sQYTTqoftXlknsYpYJAJWReZGE35C
         KrtA==
X-Gm-Message-State: ACrzQf27v4SIMnNJ6ONSLSrMDdyfa5RC1v6JtE8YWz29Q8ltxQ73sA73
        t1qp0r43k3Wkoc52LP93/Za2A+jPTDAT4Ev4S90tgOsvL+rcXlbuwiDtKOYdqpecP4JinJRXsKC
        SuE8BtU5jJz/Chv7n/qGcUhxr
X-Received: by 2002:a17:907:7f13:b0:783:6227:b939 with SMTP id qf19-20020a1709077f1300b007836227b939mr7826775ejc.416.1664587171148;
        Fri, 30 Sep 2022 18:19:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7wyZtxUwtQbZgS2YO5wic9h7BmWOQ9xCf4l19faoKnOUNoHKq43TyHpezKHLZZwq7kSKONgA==
X-Received: by 2002:a17:907:7f13:b0:783:6227:b939 with SMTP id qf19-20020a1709077f1300b007836227b939mr7826762ejc.416.1664587170962;
        Fri, 30 Sep 2022 18:19:30 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id oz23-20020a170906cd1700b007724b8e6576sm1931950ejb.32.2022.09.30.18.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:19:30 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 6/7] drm/arm/hdlcd: debugfs: protect device resources after removal
Date:   Sat,  1 Oct 2022 03:19:04 +0200
Message-Id: <20221001011905.433408-7-dakr@redhat.com>
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

(Hardware) resources which are bound to the driver and device lifecycle
must not be accessed after the device and driver are unbound.

However, the DRM device isn't freed as long as the last user didn't
close it, hence userspace can still call into the driver.

Therefore protect the critical sections which are accessing those
resources with drm_dev_enter() and drm_dev_exit().

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index e41def6d47cc..020c7d0c70a5 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -204,11 +204,19 @@ static int hdlcd_show_pxlclock(struct seq_file *m, void *arg)
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
 	struct drm_device *drm = node->minor->dev;
 	struct hdlcd_drm_private *hdlcd = drm_to_hdlcd_priv(drm);
-	unsigned long clkrate = clk_get_rate(hdlcd->clk);
-	unsigned long mode_clock = hdlcd->crtc.mode.crtc_clock * 1000;
+	unsigned long clkrate, mode_clock;
+	int idx;
+
+	if (!drm_dev_enter(drm, &idx))
+		return -ENODEV;
+
+	clkrate = clk_get_rate(hdlcd->clk);
+	mode_clock = hdlcd->crtc.mode.crtc_clock * 1000;
 
 	seq_printf(m, "hw  : %lu\n", clkrate);
 	seq_printf(m, "mode: %lu\n", mode_clock);
+
+	drm_dev_exit(idx);
 	return 0;
 }
 
-- 
2.37.3

