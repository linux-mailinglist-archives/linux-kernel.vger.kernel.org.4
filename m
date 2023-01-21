Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59A2676878
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjAUT02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAUT0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:26:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128FC2B2B5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674329088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5yb3FH8jX0MWRXyzAKd1yTC1HwTjMT1KOtJHzdpTmLM=;
        b=JoSuW22kD4TqqlrfuHNe42PBpjKHYTsC1g9ogMSXkOL6chSmXJuGZ8XYBNsyBPNrWiBJbT
        0XbURgn32N0X58rZpypWRPxu9EyDUG78ZYWwyoU5hq8Fio5x9gNZVufHPcc/YT9FEuqbI/
        Bte3HR08zhhdT1+7wrPcpiDMrpGv6M8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-297-0zzZs3foPFiJxjq4tFfQ7A-1; Sat, 21 Jan 2023 14:24:47 -0500
X-MC-Unique: 0zzZs3foPFiJxjq4tFfQ7A-1
Received: by mail-wr1-f69.google.com with SMTP id t4-20020adfe444000000b002be53a83610so916248wrm.15
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:24:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yb3FH8jX0MWRXyzAKd1yTC1HwTjMT1KOtJHzdpTmLM=;
        b=cOnKW5G1hD18xspsz8iMctQ4tJySQ5uspRzfrw8SrVbbF6yAdtO2dFmsPxLX6SQEpA
         GPVhE10A+TELnmcJEgFkhTszRGXjTnBgOXnX8gy/uQtDiQJuOIfvzERiYRsXexvlFvfX
         Z3ocF6SMlfpzUOR/JPGZTwjO4hk2qbkgd1J4MaQS44Lt7h8lflENmoj5TucCgnBJA8jH
         srYySI2Gy9DrDecsSmWtrXM4I6iwTmhF0pUpN/BmoToMndKXd35hKGv+sIORcQELlRsO
         qCvKVk0VlnRUIjUaehVmnzQl+Gc0QEvh8XE4FedDDP5vnlsp/oRd0ZWjEjJtgTKJn/Yo
         DsUg==
X-Gm-Message-State: AFqh2krc80rNzyUUqS1cUrck4ekuK7Y+OjSXf8hgjJhD/m2/UHmlw/Hg
        2y8B5qQrBycZ2thBaJkXD9Too5GxKAC5GKSOlV5WsPvP8ha3RWf1owhX5ODAmlOOv0RRnddIcuy
        Z+rOpFjynbzf6Qg6dEntA9xIWGc5ZndYJdkLzLYl59gtwoDkIgzM84aIpnxRMSofxPsn5oBIsKv
        Y=
X-Received: by 2002:a05:600c:2255:b0:3da:f950:8168 with SMTP id a21-20020a05600c225500b003daf9508168mr17593307wmm.35.1674329085986;
        Sat, 21 Jan 2023 11:24:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu7/XGYvbQvHdPX4KdE971lVGAfQ0ExgfrXkYtLzVOSmg7BGN71xkjtA3ao8ZGPeTndCrBicQ==
X-Received: by 2002:a05:600c:2255:b0:3da:f950:8168 with SMTP id a21-20020a05600c225500b003daf9508168mr17593290wmm.35.1674329085743;
        Sat, 21 Jan 2023 11:24:45 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm8544321wmg.27.2023.01.21.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 11:24:45 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Jaya Kumar <jayalk@intworks.biz>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 1/3] fbdev: Remove unused struct fb_deferred_io .first_io field
Date:   Sat, 21 Jan 2023 20:24:16 +0100
Message-Id: <20230121192418.2814955-2-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121192418.2814955-1-javierm@redhat.com>
References: <20230121192418.2814955-1-javierm@redhat.com>
MIME-Version: 1.0
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

This optional callback was added in the commit 1f45f9dbb392 ("fb_defio:
add first_io callback") but it was never used by a driver. Let's remove
it since it's unlikely that will be used after a decade that was added.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

 drivers/video/fbdev/core/fb_defio.c | 4 ----
 include/linux/fb.h                  | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index c730253ab85c..1b680742b7f3 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -157,10 +157,6 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
 	/* protect against the workqueue changing the page list */
 	mutex_lock(&fbdefio->lock);
 
-	/* first write in this cycle, notify the driver */
-	if (fbdefio->first_io && list_empty(&fbdefio->pagereflist))
-		fbdefio->first_io(info);
-
 	pageref = fb_deferred_io_pageref_get(info, offset, page);
 	if (WARN_ON_ONCE(!pageref)) {
 		ret = VM_FAULT_OOM;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 30183fd259ae..daf336385613 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -215,7 +215,6 @@ struct fb_deferred_io {
 	struct mutex lock; /* mutex that protects the pageref list */
 	struct list_head pagereflist; /* list of pagerefs for touched pages */
 	/* callback */
-	void (*first_io)(struct fb_info *info);
 	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
 };
 #endif
-- 
2.39.0

