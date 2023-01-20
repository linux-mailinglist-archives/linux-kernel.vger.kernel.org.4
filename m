Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF3467542E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjATMJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjATMJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:09:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA654A1DC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674216511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zizGqLgDtMjJvJ8Y3gxXr4ehRe41Dz0Ln+Ptew+d+Lc=;
        b=eIZiPK+wIvIMWXlBtnGsbDSRXjGB5QLJaazXA9bMNv2lf+CVC6lQqzGRWadh2c8YVWWVLA
        pgRqv6y0UYiJmo5fODVquOfBEroC3zhUuYgL1Txlv/zKU83nfhVUFCTKQTh9Gy6CY90ewJ
        sPg/gViIzY7xB2NtBFQw4v+u6Dzdl4w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-211-vSaX47mOOkmpDFkgJoN99A-1; Fri, 20 Jan 2023 07:08:30 -0500
X-MC-Unique: vSaX47mOOkmpDFkgJoN99A-1
Received: by mail-wm1-f70.google.com with SMTP id u12-20020a05600c210c00b003da1c092b83so1249866wml.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 04:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zizGqLgDtMjJvJ8Y3gxXr4ehRe41Dz0Ln+Ptew+d+Lc=;
        b=M8Dvkd1rZvoN6QJ5f108TFp/Z0DQhzkhhu9Ft8J6McVdXQls8GX9e46LNBRhiDYS9R
         TRI96SHJls3e9sqJRvJADsKNWQQAbipKTQvWIxCgwR/4eAnmip33hWISxh3QNxlQ73l3
         qPiguZ7eZ8dOpBWvyJbz/vMRAWlDJYOmyWyGEfRIRE1ejAyUg9Lxv68BnX8lWrQ5kroy
         90xtAnk/fJUo6sjHs0Njmo6EWjf7fhSCZl0oZwamJtq0kS4BXS9IrYIIqMk2Jx+mkyVy
         LEvrrmBgDYvASkoi70MingL+y6+3+XbhupPOd/VcJinypMUu+FN2Enc4eYAhwMQm2wPi
         3RPw==
X-Gm-Message-State: AFqh2kp64MFGEeIpMcWhoswrBG7qz3J6JkLWSVSWjARsFZmbIY8AboJn
        TmqagWYxSsDdjEVRyptfRRvfFsreY0Mu9T+f/QXql8BoyYCAcnKDgtp3c5I0hawVqoZ+AMPu/sf
        3k6ASjt1oR91ZvKzg5y2EM25x3j2oDl4eNpA1Ms7VW2Wzq6gSuE071+RlProLbWMEV9zt2Mt1r6
        g=
X-Received: by 2002:a05:6000:178a:b0:2be:276c:fb60 with SMTP id e10-20020a056000178a00b002be276cfb60mr15613289wrg.64.1674216509051;
        Fri, 20 Jan 2023 04:08:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXviXDLfJrvvimx9Nj+OGPkScIhm/b1eowt9jkmdc00+VtEL6f75NCTIAkwUkDVqtpQmvMRwHg==
X-Received: by 2002:a05:6000:178a:b0:2be:276c:fb60 with SMTP id e10-20020a056000178a00b002be276cfb60mr15613257wrg.64.1674216508766;
        Fri, 20 Jan 2023 04:08:28 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b002bbb2d43f65sm32766336wrx.14.2023.01.20.04.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:08:27 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Jaya Kumar <jayalk@intworks.biz>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 1/3] fbdev: Remove unused struct fb_deferred_io .first_io field
Date:   Fri, 20 Jan 2023 13:08:20 +0100
Message-Id: <20230120120822.2536032-2-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120120822.2536032-1-javierm@redhat.com>
References: <20230120120822.2536032-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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
---

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

