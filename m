Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5962A5FA257
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJJRC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJJRCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634D36D9EF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665421335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qk5ghpsK8PDbqTdW6PF39RiS96AoGnZ+OQsYu95yzaM=;
        b=ZUYbpr7BxYtwTMHX7RdgB5bTVxz3n/uqGeO/QtCtlELOluLcXavKJ21hyPlWOse7A7PRAh
        XTKVOlMgDBOaS3ElqW5Ts1tPwXNn0CiTSo8gXnYWvjTNaf1kjLhPaNM8yfMlTNwmRlEZu5
        2rkd6OAQamrK6zWquOdy3MeMx8KwErQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-228-R2Nz8OsBOTuVGYvKPD3hpw-1; Mon, 10 Oct 2022 13:02:13 -0400
X-MC-Unique: R2Nz8OsBOTuVGYvKPD3hpw-1
Received: by mail-wr1-f70.google.com with SMTP id h4-20020adfa4c4000000b0022ec3966c3aso1979446wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk5ghpsK8PDbqTdW6PF39RiS96AoGnZ+OQsYu95yzaM=;
        b=qvNL68zLfBYT954yg/rftm2bxPc6Nxi+ofuQ2KugI+mj+43zQc71pUeRRUHrSUX+sX
         IDV1i0MLx6/uPKvApS8jvwjDeYDuYbdox0xsBJL7a6sCEBZR8Hzsi84eyLeQQfowHj9X
         YlP3SqbqpCS+QH0yjJGnrbpLHJy9ND1cg9/VD/vMAHWsNMvP73919Osclyd/+6lq/iI/
         brWkP0MOD4FL5Mw+mzaP2tbpp42e1xHJYexyXFWJUXrlqrNMpJHpNxXXZnoAGfMwaGvz
         3xFNcZzSbp9TVKyqBYAyLCN1GpLns9n+/kX3d3Lc6z3aPbrat1L8NLvLdJQb5nPmKwBB
         rPsg==
X-Gm-Message-State: ACrzQf38pQM6yfBXr9h832j1a9KwfsyZgpJFc46IwrJ0AfYqCABLCzCI
        ErESFZkClyF6Q5nbUcs/wYty+eocs5B/kWOSIHYL78Zj0eyen5Lr2pdZTWK4ufKhVCUhAlMTs5f
        95+ZdxGMPcmLHRrl666dHRYKlcys5t9X1hxHI2xTMpUYAUUwYoRDX5hc9Nwiv0FCGZd1vHO8hQq
        8=
X-Received: by 2002:adf:f40e:0:b0:22e:2ce4:e6a2 with SMTP id g14-20020adff40e000000b0022e2ce4e6a2mr13064938wro.30.1665421332449;
        Mon, 10 Oct 2022 10:02:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6wesICMOp8cUSjDeGz35jt9FwoGQdTtaZeMl/ecyL4tTVqGmDsyFU6F3dnEkiGT8nn8IDAsQ==
X-Received: by 2002:adf:f40e:0:b0:22e:2ce4:e6a2 with SMTP id g14-20020adff40e000000b0022e2ce4e6a2mr13064918wro.30.1665421332153;
        Mon, 10 Oct 2022 10:02:12 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z5-20020a056000110500b0022b11a27e39sm9160551wrw.1.2022.10.10.10.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:02:11 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] drm/simpledrm: Do not call drm_atomic_add_affected_planes()
Date:   Mon, 10 Oct 2022 19:02:01 +0200
Message-Id: <20221010170203.274949-2-javierm@redhat.com>
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
to drm_atomic_add_affected_planes() from simpledrm.

On full modesets, the DRM helpers already add a CRTC's planes to the
atomic state; see drm_atomic_helper_check_modeset(). There's no reason
to call drm_atomic_add_affected_planes() unconditionally in the CRTC's
atomic_check() in simpledrm. It's also too late, as the atomic_check()
of the added planes will not be called before the commit.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/tiny/simpledrm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index ecd49a8f3334..f03f17f62a56 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -549,17 +549,11 @@ static int simpledrm_crtc_helper_atomic_check(struct drm_crtc *crtc,
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

