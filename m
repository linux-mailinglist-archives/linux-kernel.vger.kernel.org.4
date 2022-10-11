Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED35FB88F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJKQv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiJKQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE1395AD8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665507112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oo5rZBNzXD8F+rhBbW8zQ7kO5o2gNkfu06ZgFe5d8yI=;
        b=eHu12QIJntX7QrAwfTIUYG0Jsffk2y0LbB7Lj4Jn3usSOViVBu4bs2AlTTeBtSAgc4S6DJ
        nPXU0Cjp2oLnnMOYUcVJWyl0qgoaMIBp+w2HiRgC8m2OXAnYvcMEvl5g16jYjnCP6BFWIb
        New6gUlBX3Uz/4tskP84MsTgHspcm1c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-567-jb44fYV6NL-15nOaANQlHA-1; Tue, 11 Oct 2022 12:51:51 -0400
X-MC-Unique: jb44fYV6NL-15nOaANQlHA-1
Received: by mail-wr1-f70.google.com with SMTP id u20-20020adfc654000000b0022cc05e9119so4059263wrg.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oo5rZBNzXD8F+rhBbW8zQ7kO5o2gNkfu06ZgFe5d8yI=;
        b=hLYsj2y0+A3/gBCAMUWaKzu1Hp1mqCKZ3AmHp80HqUwuqmlU71Ams8k8dstKvZrm+S
         uRDEzRNTU47pgVJMsU5rkr2UDh+pzWehJx2QknR8jFHuoiQAsY+EXsO+Foq9bCGoVxs9
         /dIpukiOATo6pbLyu0fIaRJuTNrSyOMz6i0bDlAzycUPP9d1PQs0V/RrDJwgu23gNJTX
         v0tzjaaA4XsZYpi2lUxRBJm+gnTfRyKkVT3Td8rkAPgMc98OARouS+p4fP8nzJZghPfH
         Tf4x61dRgFl+LE0IygkDCdM69fTLQ7uCcXtpu6WZ70KjjRD2HSyzHAUw9WhWq2fbLkHW
         U3Lg==
X-Gm-Message-State: ACrzQf18YkL7Cx+o7c/lgT79OkdS1SqqV7g+zelJBRSlLI4O2wtkHCeH
        v0R5VtD+5Cl6kxfuSc+9FvX4P0Hicaydj9TtqMus0fpE2sKt6jV5tQgi8m5uebQ3LzzF+84lU0q
        /mK2jZ4DOD91D8MBuq1DnrK3Kx7P0bAhton7ZDi2fx4moiyzjLvOA8VNypTtoVDtM/XXszCZNwh
        c=
X-Received: by 2002:a05:600c:3d96:b0:3bf:bce1:23af with SMTP id bi22-20020a05600c3d9600b003bfbce123afmr25392wmb.112.1665507109952;
        Tue, 11 Oct 2022 09:51:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Sp+jbWVAWZ7KY8c0LuNSuEk/9o2NlT3aiFrKwD3bsUTSK8yVIvyVo5tQLSyWkQagZWavvLQ==
X-Received: by 2002:a05:600c:3d96:b0:3bf:bce1:23af with SMTP id bi22-20020a05600c3d9600b003bfbce123afmr25375wmb.112.1665507109570;
        Tue, 11 Oct 2022 09:51:49 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c0a5300b003c6c76b43a1sm2025629wmq.13.2022.10.11.09.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 09:51:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/4] drm/mgag200: Do not call drm_atomic_add_affected_planes()
Date:   Tue, 11 Oct 2022 18:51:33 +0200
Message-Id: <20221011165136.469750-2-javierm@redhat.com>
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
to drm_atomic_add_affected_planes() from mgag200.

On full modesets, the DRM helpers already add a CRTC's planes to the
atomic state; see drm_atomic_helper_check_modeset(). There's no reason
to call drm_atomic_add_affected_planes() unconditionally in the CRTC's
atomic_check() in mgag200. It's also too late, as the atomic_check()
of the added planes will not be called before the commit.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/mgag200/mgag200_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 5f7eb642f0c6..758629da95d9 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -601,7 +601,7 @@ int mgag200_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_st
 		}
 	}
 
-	return drm_atomic_add_affected_planes(new_state, crtc);
+	return 0;
 }
 
 void mgag200_crtc_helper_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_state *old_state)
-- 
2.37.3

