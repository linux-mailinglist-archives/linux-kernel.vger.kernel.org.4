Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B136C96E2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCZQia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCZQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:38:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6A549EC;
        Sun, 26 Mar 2023 09:38:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a16so5615756pjs.4;
        Sun, 26 Mar 2023 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679848706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jEKgtiO8QFe7E17SjGBY63VNUT2bmgUu7j5N6GIYXa4=;
        b=MwoiDuyPxTS9Z8dOtvnvra6vBeLLn7oR2fH8IZjoeTcQs1z0Tl9EnBa3mwzanhMEgH
         w6IpWAURpAS33RH3VF5owcNxISB2+Df8RfvZxjTYuPXT2dCJnOeJTMdhV3XQUvnbhC8I
         sZo/puQWlFh9s+0/A0tq/VLZPWKAfkGsL1GTz3Dlv2ztb3BRgP0LI5W/s15gmgDPKn4o
         eHBVv+aVfKcgDUUq4NfaEkFRmXylIitg/hvLegwLJuL+iugOB03urwMFwFmB92vYLYhk
         /to8aTUxS0wFeOZKo1ByehL56LmT3+ePE6sh63X2xuLJMM2HMgEyCEq9gbcbj/vSZkvN
         rEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679848706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEKgtiO8QFe7E17SjGBY63VNUT2bmgUu7j5N6GIYXa4=;
        b=u8jUKTTjGFdtiticpxyJ5EhRb3CteE+oM+DCeJF/ffa4oFbaRg5pOfIhEuIz5JHco1
         YGXHEpbHe/wtLgLFDI/1E8NzTPEf5i0lXxYKngBaFmHmvTrxcAVrUZxKYrIVQv3WBCyP
         ND+Ub+KvV5/yFzPrGcGawkkvGp8/Fkr6VzpBLYxjKlHh17fDxnZiFFBvJiBu7pZGaUfj
         FH9CyyDtLaYVGARdzDIWqS7sx851kW7v9SpJOX3wqC2L0qSapZdkYCO17N3a08YtraIL
         3eYLo08GkV0G7IR5i6Ir3CMiGZtoWjeduNek3k5WD9TrkacgjLE7IwD1VtVVZWqRKq8N
         GGrw==
X-Gm-Message-State: AO0yUKVyuT7tJUtkDVc7Q7DSvAJ3/EFKg4zRAzupbb7G9c0IF2HaXG4Q
        cr7fetTHTKopJaRqo5XEwhw=
X-Google-Smtp-Source: AK7set+b3pKwVhLF/NmGsZhRs+HpcpdkO06/1xJ22W1zOxMr7Z7de0igJ6VrMv3LMX/PVzPeQaCPUQ==
X-Received: by 2002:a05:6a20:cc59:b0:db:9a60:a52d with SMTP id hq25-20020a056a20cc5900b000db9a60a52dmr7057696pzb.41.1679848706162;
        Sun, 26 Mar 2023 09:38:26 -0700 (PDT)
Received: from localhost (c-24-21-48-127.hsd1.or.comcast.net. [24.21.48.127])
        by smtp.gmail.com with ESMTPSA id s18-20020aa78d52000000b00627f054a3cdsm337182pfe.31.2023.03.26.09.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 09:38:25 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Danylo Piliaiev <dpiliaiev@igalia.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Rename drm_msm_gem_submit_reloc::or in C++ code
Date:   Sun, 26 Mar 2023 09:38:13 -0700
Message-Id: <20230326163813.535762-1-robdclark@gmail.com>
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

From: Danylo Piliaiev <dpiliaiev@igalia.com>

Clashes with C++ `or` keyword

Signed-off-by: Danylo Piliaiev <dpiliaiev@igalia.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
This is a port of a C++ compat fix that was made in mesa's copy of the
drm uapi headers.

 include/uapi/drm/msm_drm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index dbf0d6f43fa9..6c34272a13fd 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -186,7 +186,11 @@ struct drm_msm_gem_cpu_fini {
  */
 struct drm_msm_gem_submit_reloc {
 	__u32 submit_offset;  /* in, offset from submit_bo */
+#ifdef __cplusplus
+	__u32 _or;            /* in, value OR'd with result */
+#else
 	__u32 or;             /* in, value OR'd with result */
+#endif
 	__s32 shift;          /* in, amount of left shift (can be negative) */
 	__u32 reloc_idx;      /* in, index of reloc_bo buffer */
 	__u64 reloc_offset;   /* in, offset from start of reloc_bo */
-- 
2.39.2

