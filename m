Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2F659574
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 07:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiL3GgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 01:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiL3GgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 01:36:07 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9BAAE43;
        Thu, 29 Dec 2022 22:36:02 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1447c7aa004so23918735fac.11;
        Thu, 29 Dec 2022 22:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAvkJUoPDYmWRhAwgSj95u5byto+2nWkIpy69HcVzzA=;
        b=chmxPcmZDfrqDkOb6grw5n9WABwC7AWm9NlE1JDaiZZVXSjJ0sTBOCA65G6ANggrp4
         vZhXEMQwEMhw1TnKRlDtIz2+9kmySb60qBl9lliQwjy225K7qGxeKyjp17ocxLHj21F1
         WjWW/Keir209f60myxHUh3MLgunDT8F4a6B3p7bRkTPDvWCyBqQMOovUxaJ3B/fIg1/x
         QwTtfarB29BSW6+WY9me3g666RVfvCG3JXyF4K3VOZPdLEX85petPfRFz7tcAy9WXG6G
         kz6aEl4nTZwiwAMyjwk6erNtMiqGF4ANOl62eqOcqxiaxWTaz2bhHAZ8gjLkhsiz+bnN
         E9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAvkJUoPDYmWRhAwgSj95u5byto+2nWkIpy69HcVzzA=;
        b=fx3cvADoaD+8dLtmpBsSjekjwN2FhmLngO6MVDa7n0vhIW7DleMxSUjZuEKjunDfxE
         d6Xev1L0EwP+qvcZb1JFelIm/5VzsXEIUMbOx7NqUODxfp20OKB3eWuBILvwZAqCpkAB
         meUcBkYGRryde3/B+8ww8nnUxf+kwEdlkfIxAE8RIqI6ukA7JzBgCzxfjiy2sC/6W4XK
         za9t7934cdSX4sUcsIjRSh0Vs540keeJyzoaZhGRn1lknukIY8qfr90ajqW2HxzSz2h4
         1/ylsD2VGzuaOv6eM8FhPLwCFYyI1V802HSEMouvEP5Z1yifP+qYssztuEOtQvJPgX5t
         GZ7A==
X-Gm-Message-State: AFqh2krRxhee2i468+HBtK8ZptzrEC3bWLinL4nEk0Lk8r6GCr1MK/Mo
        S29SRTJEiLd/IsyUwmUlMF4=
X-Google-Smtp-Source: AMrXdXu8tuII+NQ94TSjxHteZaU5UKVhWyRIdtPSP8n4vzqiJe3EBkB9K95dp/oEC/QKGMbL8PYeng==
X-Received: by 2002:a05:6870:be85:b0:144:4c04:4b73 with SMTP id nx5-20020a056870be8500b001444c044b73mr15306401oab.50.1672382161887;
        Thu, 29 Dec 2022 22:36:01 -0800 (PST)
Received: from protoss.cs.ucr.edu (protoss.cs.ucr.edu. [169.235.26.60])
        by smtp.gmail.com with ESMTPSA id o10-20020a4abe8a000000b004a0ad937ccdsm8281508oop.1.2022.12.29.22.36.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Dec 2022 22:36:01 -0800 (PST)
From:   Hang Zhang <zh.nvgt@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hang Zhang <zh.nvgt@gmail.com>
Subject: [PATCH] fbmem: prevent potential use-after-free issues with console_lock()
Date:   Thu, 29 Dec 2022 22:35:28 -0800
Message-Id: <20221230063528.41037-1-zh.nvgt@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In do_fb_ioctl(), user specified "fb_info" can be freed in the callee
fbcon_get_con2fb_map_ioctl() -> set_con2fb_map() ->
con2fb_release_oldinfo(), this free operation is protected by
console_lock() in fbcon_set_con2fb_map_ioctl(), it also results in
the change of certain states such as "minfo->dead" in matroxfb_remove(),
so that it can be checked to avoid use-after-free before the use sites
(e.g., the check at the beginning of matroxfb_ioctl()). However,
the problem is that the use site is not protected by the same locks
as for the free operation, e.g., "default" case in do_fb_ioctl()
can lead to "matroxfb_ioctl()" but it's not protected by console_lock(),
which can invalidate the aforementioned state set and check in a
concurrent setting.

Prevent the potential use-after-free issues by protecting the "default"
case in do_fb_ioctl() with console_lock(), similarly as for many other
cases like "case FBIOBLANK" and "case FBIOPAN_DISPLAY".

Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
---
 drivers/video/fbdev/core/fbmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 1e70d8c67653..8b1a1527d18a 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1182,6 +1182,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		console_unlock();
 		break;
 	default:
+		console_lock();
 		lock_fb_info(info);
 		fb = info->fbops;
 		if (fb->fb_ioctl)
@@ -1189,6 +1190,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		else
 			ret = -ENOTTY;
 		unlock_fb_info(info);
+		console_unlock();
 	}
 	return ret;
 }
-- 
2.39.0

