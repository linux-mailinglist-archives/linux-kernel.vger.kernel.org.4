Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF96C87E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCXWAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjCXWAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:00:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B660A15899;
        Fri, 24 Mar 2023 15:00:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z19so3125288plo.2;
        Fri, 24 Mar 2023 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679695220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TwSVZpLUzRmiKPBTqz2xkUjjibhOLesM/D7QB066vDY=;
        b=MzzWglGqjxWYLJ5m0oOhSLE8/AUlI9bSF/LPOlD7NAvgKgilVhKJrTyXk0zveHQ6qb
         YC/rJ5lphx2bNt7p81GmTWdTTWAf/HifT+tF5GwgQO0tcg57jipY7bral9bwxSrPWvzC
         t/SarjzE8fMpdaiLFmOiO22fwq4U721ebyBbzJvA4AUlse0y0R+oAqKSjenK/5IV5Jya
         QdssZ7RXOHqlbsPBfDBEHbOXNGYHaax75s48wmivRLqrdCCgN4YBtb5xz5+H76WF5OMt
         Hbvr7aJNSTR19MEZznTmkxPA57RsbJ/FW/vfM4XrdaD4+yis7IporewAm9+uWJLyWuwt
         1fYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679695220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwSVZpLUzRmiKPBTqz2xkUjjibhOLesM/D7QB066vDY=;
        b=bp1iLynZXAy6nH8uTi1PEv+xDtrzhrBqMH6kjOrvAuQbesjTdrbajEAJ1p0rPCQWOX
         N6UEndTnDWs6lLVcSMJGcMNVC3aZ+chUsRGG/b/BpXW1G/PsoXfsVpGLlPmRWl7z6rwf
         wF0sA4n8otX369VZb37/YA9SARjA3q1vJqZu2t2Ia8gMoOc0h6TaUeubeVz/7vbDF6oh
         c04imV7L4yqwhOptS0ffGciH2VUjNNwkfiMZoOp84HXdLLO+/hiZQRfk2P0Y4Vf5Svv5
         fqGDT2cU0QFL+sCSjUoRjV3/l8fnMxE+ctJtn3F/mpIZWOXIM1NWDB+tiH5+/k0ghbtl
         YGrg==
X-Gm-Message-State: AO0yUKVwcDZZk6LDfbFv5CrEs+H4NrHJxRZZdZbiuRbmZVooTI0IzRUY
        EPR7m/ZoaaszZxowwqIjFI0=
X-Google-Smtp-Source: AK7set+PGtDOTkfzZJx37x4Pz4RQeFFcdSqmH6QQdA7Wb4n1Bcs/q3h6z5bxt6vTpwuaw2fVQ90ZjA==
X-Received: by 2002:a05:6a20:c28a:b0:c7:770a:557f with SMTP id bs10-20020a056a20c28a00b000c7770a557fmr3861341pzb.50.1679695220121;
        Fri, 24 Mar 2023 15:00:20 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id k23-20020aa790d7000000b006247123adf1sm14773685pfk.143.2023.03.24.15.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:00:19 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Avoid rounding down to zero jiffies
Date:   Fri, 24 Mar 2023 15:00:13 -0700
Message-Id: <20230324220013.191795-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

If userspace asked for a timeout greater than zero, but less than a
jiffy, they clearly weren't planning on spinning.  So it is better
to round up to one.

This fixes an issue with supertuxkart that was (for some reason)
spinning on a gl sync with 1ms timeout.  CPU time for a demo lap
drops from:

  15.83user 20.98system 0:47.46elapsed 77%CPU

to:

  8.84user 2.30system 0:46.67elapsed 23%CPU

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 9f0c184b02a0..7936aa6cad03 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -548,7 +548,7 @@ static inline unsigned long timeout_to_jiffies(const ktime_t *timeout)
 		remaining_jiffies = ktime_divns(rem, NSEC_PER_SEC / HZ);
 	}
 
-	return clamp(remaining_jiffies, 0LL, (s64)INT_MAX);
+	return clamp(remaining_jiffies, 1LL, (s64)INT_MAX);
 }
 
 /* Driver helpers */
-- 
2.39.2

