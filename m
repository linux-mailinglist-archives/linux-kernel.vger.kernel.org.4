Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C715EF9F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiI2QON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiI2QOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:14:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCF11D929A;
        Thu, 29 Sep 2022 09:14:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id b5so1858178pgb.6;
        Thu, 29 Sep 2022 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vOkUW7MJ8/7Rwwrghxwplno9BIDga3iCPCaKB4/B+FU=;
        b=VfUwk4stmlVUWGySZzO/lxmvw7oWW7BwskBGCDqha4lJ1BpYt4mELcvRb6FuSpyrP/
         3sqtAxrMrlCI3tuS5xoNLSTBH57R3WWvIJE7XwLuwHFEU8/FGJQ8HURGTQtcXSwuwcMP
         Pv6vN4qq8J8BDJJeVZZoTf54zmD4vxzk9hXrrTxWPgLo73aZ3R2GPXC91wn483uHicaC
         qZE4+FyoLA/w6fASZIiG9E+uIl8p6EAJ8+8i8KrzP5CmVwXsVOe+A0PvhyjTQ2ztmN/W
         kwnBxxdh0XXjEqi/XR55CY3BSO34eA0FXPfgrg5Ugc4MEkYqvZtYtVnDObBbCfUibToo
         4GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vOkUW7MJ8/7Rwwrghxwplno9BIDga3iCPCaKB4/B+FU=;
        b=W8xiavNKIs9Pi5M9LnBXVjbvunf7X6xhnFX+0XvYxTgRejZFwBI0GvP5Uvgf/4dBiy
         08TKcm3wB+P6z7kRwwwwqq/uQhX9ku6A5toUH4ncMQjKZ/YBvNw9Z0C4DIgRPkFje8pQ
         JNON/yuUEFAbW8q+8vq+KbINkm6UpzA9HjjxiWp0AJpo5MeV9UAiV/kM1N7H4U4VG1UT
         uob1o7t/Ib9z2emY3CjtCl5LKj5hBfzxP+vfBgNU97ix0dbnDW+shNsN9CMFQ/FesteI
         w/qIOvFPcTU+/feMGaxiBbu63xKmgLOiusIGywq3Rmrs26GolNcARQdYqvkKZ1tPCtcx
         BlvA==
X-Gm-Message-State: ACrzQf2GNILGS7hrTwtsQkc8EjHH+gh648mzcjUi5jtpOfMx6//tZpJc
        zXJoBnt+RE6CJPo2G9bqR5I=
X-Google-Smtp-Source: AMsMyM5amldVaXPN9Z05f++c7BLsLXiBctbKghsSeOA9pPHmgribXjiC6YCiy3jT6WLTJpm3YlFvNA==
X-Received: by 2002:a63:8942:0:b0:43b:e87e:3fc0 with SMTP id v63-20020a638942000000b0043be87e3fc0mr3577693pgd.531.1664468042016;
        Thu, 29 Sep 2022 09:14:02 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id l6-20020a6542c6000000b004277f43b736sm29618pgp.92.2022.09.29.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:14:01 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dave Airlie <airlied@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix build break with recent mm tree
Date:   Thu, 29 Sep 2022 09:14:04 -0700
Message-Id: <20220929161404.2769414-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

9178e3dcb121 ("mm: discard __GFP_ATOMIC") removed __GFP_ATOMIC,
replacing it with a check for not __GFP_DIRECT_RECLAIM.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Sorry, this was reported by Stephen earlier in the month, while
I was on the other side of the globe and jetlagged.  Unfortunately
I forgot about it by the time I got back home.  Applying this patch
after 025d27239a2f ("drm/msm/gem: Evict active GEM objects when necessary")
but before or after 9178e3dcb121 ("mm: discard __GFP_ATOMIC") should
resolve the build breakage.

 drivers/gpu/drm/msm/msm_gem_shrinker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 473ced14e520..8f83454ceedf 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -27,7 +27,7 @@ static bool can_swap(void)
 
 static bool can_block(struct shrink_control *sc)
 {
-	if (sc->gfp_mask & __GFP_ATOMIC)
+	if (!(sc->gfp_mask & __GFP_DIRECT_RECLAIM))
 		return false;
 	return current_is_kswapd() || (sc->gfp_mask & __GFP_RECLAIM);
 }
-- 
2.37.2

