Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D745FA258
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJJRCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJJRCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579156613A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665421336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8yaCP9ce66rAwzKDzbvHaA4XIfJFeHvOc66mwQOMSw=;
        b=F2frPHpCyW90FwsP99dsSePBDu2FhI4X3gSbvemTqJ/WBbaBQlbptLe9q4frYecUFlSgTO
        nH+GEfkslrI4nglfzUaI005w6/i25yU7PImt81mIX7RanSbH/a89U13urdp9a4Uhw6nu5m
        ZqMLALeNYDW3II3ePT7/vMOn5lVl0rs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-_wO5g0wlNAmRm2vCq95veA-1; Mon, 10 Oct 2022 13:02:15 -0400
X-MC-Unique: _wO5g0wlNAmRm2vCq95veA-1
Received: by mail-wr1-f72.google.com with SMTP id u20-20020adfc654000000b0022cc05e9119so2939721wrg.16
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8yaCP9ce66rAwzKDzbvHaA4XIfJFeHvOc66mwQOMSw=;
        b=Brq+3oiI5W5YcfjD3Orc8seD/cIzY0oy2UMDMGCMdjPiYFJ8W7YtdyTHW6N/5rG3/p
         q/IsCgjcH5RhPO2i/aWLX39+wo5BtAhiwyQKdJF91eJQwkkPs+UbzmDidmOgW18vVuJF
         0dI9e49DOS5KDgdRW4HjteL1t8VDeC6vN6O1rOa+DYknYP1Ih0fkLVBP11TxK2HrDhcG
         Vcn4AAFQvFc/WCLJ7iTqZkNu47mZIrNrlkypxMYHCa1QZQ7clzbJmWcFjea47hCiCgxS
         j6Ja2ePpfjw6H7Z8IkbR4ES9WlQhC0uQTzZ97vD9UGShGdIizOOkKRsWBULQRQsw/53l
         MHnA==
X-Gm-Message-State: ACrzQf3IZHAf1ganNv1yj8AHRI+3eRpcPPLAkVaNaot6s+isuMTfpXOQ
        qSQeFdbkzMifj1SENlOYzGhWOqZoKVneny0E0t3MNWFrlBmQGIh7XIJ/T3hyG3g5mZEtjDMoeoh
        8SsRm1z96aJoih4L1n7UE+lniiGdfvTiTAkmBYHKqCH+HtbegHcHr6VEJmPuYla/p+0qjC71QYH
        4=
X-Received: by 2002:a05:600c:474a:b0:3b4:cb3f:2f5f with SMTP id w10-20020a05600c474a00b003b4cb3f2f5fmr20670179wmo.8.1665421334050;
        Mon, 10 Oct 2022 10:02:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7uoZMFHRFdDBTfXNtCkF5Ow1u9w/7KAhe9C2I3BrwodOqtSA6YYTQBJx7Lw3zEPjHmeE9VwQ==
X-Received: by 2002:a05:600c:474a:b0:3b4:cb3f:2f5f with SMTP id w10-20020a05600c474a00b003b4cb3f2f5fmr20670150wmo.8.1665421333696;
        Mon, 10 Oct 2022 10:02:13 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z5-20020a056000110500b0022b11a27e39sm9160551wrw.1.2022.10.10.10.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:02:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/3] drm/ssd130x: Do not call drm_atomic_add_affected_planes()
Date:   Mon, 10 Oct 2022 19:02:02 +0200
Message-Id: <20221010170203.274949-3-javierm@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221010170203.274949-1-javierm@redhat.com>
References: <20221010170203.274949-1-javierm@redhat.com>
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
---

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

