Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955E36BF6E7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 01:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCRAYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 20:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCRAYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB81114988
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679099014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ro4nhrJ5Zq0SySOEipia8lU7rnzpGPE36NY88ytAvP4=;
        b=LD5tbkn3wFgtb27/9xCrhzN2M64PdjALt5fgmX2kDr8LRyvk/7pRCIFJvDBYfoMcRwDCta
        rqfFwua+BJEQDTTwwqfr7LVp6LSTV8G7oygBWi1NtC9QdUItvr+MbbAjACXgbatM/3UWp6
        EJKUE7WFCVWiYzk+gCjxqZ9tLHFvUzk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-7XuVZMpTOUSGJZ9FfXbebA-1; Fri, 17 Mar 2023 20:23:33 -0400
X-MC-Unique: 7XuVZMpTOUSGJZ9FfXbebA-1
Received: by mail-qt1-f199.google.com with SMTP id x5-20020ac86b45000000b003d59e5ef484so3349120qts.15
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679099012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ro4nhrJ5Zq0SySOEipia8lU7rnzpGPE36NY88ytAvP4=;
        b=2+Iln1/QMzy1Sz86qxoR3bm3rgg9NYuFae6OIXKYr2vYuvLbBUxwGK14N+5eZ64+5F
         EjJGj0SamEfVw8xmo74+iL4wbdfilYqgmmbI3j0/A0TWBAy41ekubcLNTraB7nP/krCg
         9O8nj1lTpkoUBL9vhLC5vYxLVTVTIJULxoFO4b5W8ETvwGdeOfD+c01Daa1wX74o+xBA
         WnFhYXpy/WIzEa24sRQduJsQPNPXHSR4lL0k6S727+EXnGyBYk+1WNMe4+/ccUrqPR9F
         uGYPZ7wEz4ph1LrW6UXXyi2ox6+Y5jAJjBmDPgZql7wB63e7lj7nFqTWslc0xJHZKo2u
         gMig==
X-Gm-Message-State: AO0yUKUTYskLV2CmtEasp9m6r8sTabPXxrx+oIio1QhF8RReWezPR5Dz
        lnpQfhqLlJYcHSE+WB2vjcyUtlePP9ZU+xDLTfkOTPQbH7LRe1UOk4bg8sFl9TgK9Du1bG0sbCd
        GI7ohfx2g8i2yDX+OaRmCuyR+
X-Received: by 2002:a05:6214:e62:b0:56e:9da4:831c with SMTP id jz2-20020a0562140e6200b0056e9da4831cmr39485349qvb.46.1679099012683;
        Fri, 17 Mar 2023 17:23:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set/fL421Kfl3tq1uEh7Q2OUg4WIgPPxO43SFyqSNmCb+PH/F1uG0zi5qpejfWxe5clSOu4VLzA==
X-Received: by 2002:a05:6214:e62:b0:56e:9da4:831c with SMTP id jz2-20020a0562140e6200b0056e9da4831cmr39485337qvb.46.1679099012479;
        Fri, 17 Mar 2023 17:23:32 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a72-20020ae9e84b000000b00745a3b63569sm2623217qkg.107.2023.03.17.17.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 17:23:32 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, nathan@kernel.org, ndesaulniers@google.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] gpu: drm: bridge: sii9234: remove unused bridge_to_sii9234 function
Date:   Fri, 17 Mar 2023 20:23:21 -0400
Message-Id: <20230318002321.1675181-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/gpu/drm/bridge/sii9234.c:870:31: error:
  unused function 'bridge_to_sii9234' [-Werror,-Wunused-function]
static inline struct sii9234 *bridge_to_sii9234(struct drm_bridge *bridge)
                              ^
This static function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/bridge/sii9234.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index 099b510ff285..2d17f227867b 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -867,11 +867,6 @@ static int sii9234_init_resources(struct sii9234 *ctx,
 	return 0;
 }
 
-static inline struct sii9234 *bridge_to_sii9234(struct drm_bridge *bridge)
-{
-	return container_of(bridge, struct sii9234, bridge);
-}
-
 static enum drm_mode_status sii9234_mode_valid(struct drm_bridge *bridge,
 					 const struct drm_display_info *info,
 					 const struct drm_display_mode *mode)
-- 
2.27.0

