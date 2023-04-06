Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340496D9BE2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbjDFPMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbjDFPMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85C5116
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680793932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NSn+nRCslEryVjK0HtPumS1/tOG58g41+w55ryKigfs=;
        b=La5zH/zLcGpx7HdXfbTYHkbwIbwftUVBfri1H9CHsnToCgqlI+2viSYxSVYFkxqTpp8kVL
        IXpL8D5rfX/KoA14OW1qQ7YyVfz8jwpGg0NlzjdTg3OdTS8EdProQW+OtnADLwwoZJX4RY
        OojU1SOJlU+og267IKtKBLoTnTEznaw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-7KLYOk8VMmGHten3QDb9yA-1; Thu, 06 Apr 2023 11:12:09 -0400
X-MC-Unique: 7KLYOk8VMmGHten3QDb9yA-1
Received: by mail-qt1-f200.google.com with SMTP id l13-20020a05622a174d00b003e4df699997so24695707qtk.20
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 08:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSn+nRCslEryVjK0HtPumS1/tOG58g41+w55ryKigfs=;
        b=JBE+FGAdAO10C21bd6gGs+jDte937ztoPvp7k3bYr7R6PWXKyXcUQGe5Nqjmf0eX3d
         jXkm3fe0JXQt42DK5eI/CE40Ju725oDl4491N6PHuRWayOjm6blUVmC6m2YS4A2LRY/v
         fmVlz11/NV+dHJ3MFkVbsdE1L/f24daGokk7gP9W+ehP8eZz2dMXQ4JD6tN6mAVhAkRj
         pycP/suf7Ki7sGV2EVreFKxcaCYgvsrXQLZ2jgx12AYYEPX4g1q/1WVwGFO0Ihsgb2RC
         MZdlDQ/djVqPVznND+LT6smTgXXX9/LHIjiqWdWPugI7a3Nxj1gQOzVIUvhikphaq+PL
         uUJQ==
X-Gm-Message-State: AAQBX9dCM4fdpf70RapIyALwMUq0ng57izY+/N9pu7hx+m2jT9sBupC9
        VuhwFjRCa+b/TiD0UmDiLfuOqzjaUUwzJeyNcdwq5q/Lrw89LSQ/3KQ5Gp2CZhOq9NQuVJmIAH0
        irJvG5MoByroc0oBdIsQdzIYg86+2Kpnv
X-Received: by 2002:a05:622a:1b8e:b0:3e3:9185:cb15 with SMTP id bp14-20020a05622a1b8e00b003e39185cb15mr10026994qtb.7.1680793928912;
        Thu, 06 Apr 2023 08:12:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350bJN3Jui5XS+d47ytIyV2akENug5dzstCuhxddOfSziXsi9Rpj+9r/J7pf5mpXHRWOYQwBV3Q==
X-Received: by 2002:a05:622a:1b8e:b0:3e3:9185:cb15 with SMTP id bp14-20020a05622a1b8e00b003e39185cb15mr10026966qtb.7.1680793928666;
        Thu, 06 Apr 2023 08:12:08 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p6-20020ac84606000000b003d3b9f79b4asm470296qtn.68.2023.04.06.08.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:12:08 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     emma@anholt.net, mripard@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/vc4: remove unused render_wait variable
Date:   Thu,  6 Apr 2023 11:12:03 -0400
Message-Id: <20230406151203.1953812-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/gpu/drm/vc4/vc4_irq.c:60:1: warning: symbol
  'render_wait' was not declared. Should it be static?

This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 1e6db0121ccd..563b3dfeb9b9 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -57,8 +57,6 @@
 			 V3D_INT_FLDONE | \
 			 V3D_INT_FRDONE)
 
-DECLARE_WAIT_QUEUE_HEAD(render_wait);
-
 static void
 vc4_overflow_mem_work(struct work_struct *work)
 {
-- 
2.27.0

