Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F25706A19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjEQNmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjEQNmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ABD269A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684330910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wHcGhYBK2iclIlw+sklydiMn/Pjzv3gm7joUyvqgdBY=;
        b=UR9Yg27qPzfpwLo2x+ZmLXS/S6r2BAFdAUuF2NJvAqUe7IdrBmBBHmwlxaAI9E6+SpiGKw
        NzQU098BOADGJUDh4m3JE9kxalWsj/forVZ8PSyoSCTCgP1Z5kmvSPPMt5edu35b2n2FLL
        NHkqXTKx0BALNXCHAzx7AtM0K9w+Oek=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-GrCMVhKmPuyzXYeXlnjAZA-1; Wed, 17 May 2023 09:41:49 -0400
X-MC-Unique: GrCMVhKmPuyzXYeXlnjAZA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75784a27e8fso100964785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684330907; x=1686922907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHcGhYBK2iclIlw+sklydiMn/Pjzv3gm7joUyvqgdBY=;
        b=SCq3UA14+uJppu/3mceaSXYT494cMjEaBofG2WrXL83S/xeRl29GqWD2D/wG+EeSeQ
         Mp5YuM2rBGhJ9yLT49jK5UlZRjMfzPonifH1/Ahbm/985t8YamNf8mUtI0he0ElVhLi0
         KQSw1dTNa3B4rpuw8IIDI1f9FH7SkQZfq074X4ykIOS54Y94STMZGXCsuvs92kA+W3qk
         FPPjcTPznjBdrZLtNtrdJAabTgRoGB22btDwcz8gjm6Acdy+EhpyUFrI23ve/wn7ptda
         1QD2EVUKYcq7lwxMddH1kdUhB6ocmkUZ3Wqny8BqxH1fpK214/P5edOjKjxXRQobFrP9
         ay+g==
X-Gm-Message-State: AC+VfDxmcx/TntTkn6ZIDUzsCEMsnxPYq1kaEUrHxEFuAITLlqny/VZN
        yqlOBgpJMxGcn22OyPgQxn8rjcqGXhMRGSszIw0cKGNo2Q0ZUDRmRh9xCCWknIgLP7e5sPqvjpW
        NZuluV4fXzYSxgHfR/onuoWfT
X-Received: by 2002:a05:622a:202:b0:3f3:89cb:55dd with SMTP id b2-20020a05622a020200b003f389cb55ddmr59160089qtx.10.1684330906972;
        Wed, 17 May 2023 06:41:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7P9H5KEBY8S84iUF4a/3/m0k88vgicTNjlT/KZFXAkI7287aVVCJBJ+eHge4KF2P0+od8ukA==
X-Received: by 2002:a05:622a:202:b0:3f3:89cb:55dd with SMTP id b2-20020a05622a020200b003f389cb55ddmr59160055qtx.10.1684330906619;
        Wed, 17 May 2023 06:41:46 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a13-20020a05620a16cd00b007591cc41ed6sm627842qkn.25.2023.05.17.06.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:41:46 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     airlied@redhat.com, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/mgag200: set variable mgag200_modeset storage-class-specifier to static
Date:   Wed, 17 May 2023 09:41:40 -0400
Message-Id: <20230517134140.874179-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/gpu/drm/mgag200/mgag200_drv.c:23:5: warning: symbol
  'mgag200_modeset' was not declared. Should it be static?

This variable is only used in its defining file, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/mgag200/mgag200_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 976f0ab2006b..abddf37f0ea1 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -20,7 +20,7 @@
 
 #include "mgag200_drv.h"
 
-int mgag200_modeset = -1;
+static int mgag200_modeset = -1;
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, mgag200_modeset, int, 0400);
 
-- 
2.27.0

