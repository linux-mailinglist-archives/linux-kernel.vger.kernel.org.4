Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7F15FB893
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiJKQwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJKQwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8895AE2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665507117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IBnOwoRDbp5lIz7DyyRGWmB6mwXxMA+2lwoGkttbDwg=;
        b=UBLrDVLZfGBnrB3WMTtDoProuJ0QU/Py3ITnmN5JQPOa6FDl1FGpFv7LjvE3PfVxhQ368L
        LqqKSsRfV1wRXpY8xOzNkdunTVeNC+jVgfoT9H868GTt+YXmTEaVCWXvRk5V4RbIJaoqQ7
        MAesyuxPCuaS63jb+iLzqrj/EJID2XI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-csrbUNgFMo2bcyt6Yr-qbA-1; Tue, 11 Oct 2022 12:51:56 -0400
X-MC-Unique: csrbUNgFMo2bcyt6Yr-qbA-1
Received: by mail-wm1-f69.google.com with SMTP id n6-20020a7bc5c6000000b003c6bbe5d5cfso2991852wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBnOwoRDbp5lIz7DyyRGWmB6mwXxMA+2lwoGkttbDwg=;
        b=ldTX5bDnlxFAbCR4f4KX9MeHJ8NDdXPQn+yINNUJhukwSR03q3l+EpddkoJ9OsR74Z
         iRMzylem+Jg3rHgM58sPf3uVWXDnmftjkp7o3zJIHsMcoyM0VY9eFkhVDk1WiaSnVdi+
         zGybgwRoMYL27GKZl9/B5YmR+ssFlhQ3mxHtn5KE4A4VCHN9o3A9t+Pwq9Q/JDj/0s0E
         ETgKdCcTwsqA7BMuFtop2ZUra/uF4FBTiGMLxFZcxFetrkjPN0edfH/y7XuPTl9jLj6/
         Rw/P34haonlj7IFVCVjU8r1GG+3fegWvHpytDm8ARk0/8eOo7VT82qmUIRsxMkEzKK3L
         oSWw==
X-Gm-Message-State: ACrzQf2nodKjd1BVpiPXFwBS4ed2uVdfLdiTf1CcnHgN1F3GCsHR8Y7o
        BBlMuxrsDFaZcs9b+Ifnq9nP3NGq/e6X2hTgLps0V6amTXgrb2IjrrnohVG3JRywt5F5yVXcRCK
        8pprefjNBS86cgPEuRPC0GqPmLxk1wYAchRjntBsdUcLs63mJH1mGCg2OxrVnnetINhAT/t6W80
        o=
X-Received: by 2002:adf:f709:0:b0:22e:327d:f147 with SMTP id r9-20020adff709000000b0022e327df147mr15586640wrp.240.1665507114944;
        Tue, 11 Oct 2022 09:51:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7dY1FoQ99k7LwWCoZXgCqLmpVU8EUj6xpAdddZbJApMpnMONvuXyLssmYE8+jwEFMpfFP2QQ==
X-Received: by 2002:adf:f709:0:b0:22e:327d:f147 with SMTP id r9-20020adff709000000b0022e327df147mr15586620wrp.240.1665507114554;
        Tue, 11 Oct 2022 09:51:54 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c0a5300b003c6c76b43a1sm2025629wmq.13.2022.10.11.09.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:51:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/4] drm/ssd130x: Do not call drm_atomic_add_affected_planes()
Date:   Tue, 11 Oct 2022 18:51:35 +0200
Message-Id: <20221011165136.469750-4-javierm@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011165136.469750-1-javierm@redhat.com>
References: <20221011165136.469750-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to add planes to the atomic state. Remove the call
to drm_atomic_add_affected_planes() from ssd130x.

On full modesets, the DRM helpers already add a CRTC's planes to the
atomic state; see drm_atomic_helper_check_modeset(). There's no reason
to call drm_atomic_add_affected_planes() unconditionally in the CRTC's
atomic_check() in ssd130x. It's also too late, as the atomic_check()
of the added planes will not be called before the commit.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

 drivers/gpu/drm/solomon/ssd130x.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 57e48355c008..0d4ab65233db 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -649,17 +649,11 @@ static int ssd130x_crtc_helper_atomic_check(struct drm_crtc *crtc,
 					    struct drm_atomic_state *new_state)
 {
 	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(new_state, crtc);
-	int ret;
 
 	if (!new_crtc_state->enable)
-		goto out;
-
-	ret = drm_atomic_helper_check_crtc_primary_plane(new_crtc_state);
-	if (ret)
-		return ret;
+		return 0;
 
-out:
-	return drm_atomic_add_affected_planes(new_state, crtc);
+	return drm_atomic_helper_check_crtc_primary_plane(new_crtc_state);
 }
 
 /*
-- 
2.37.3

