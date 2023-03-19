Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE26C0263
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCSOYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCSOYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A015FF9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679235805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T/hIkiUkQpnPgtTLze7otKxFbigf/WOsrX7aDGKl4Xk=;
        b=KkUtUpdHXO+7h2eBPf4+EP3z7q5C3kTdJp6XlMJjmTD8ynbn5XbpDlum79DKB3MRAN2z1b
        F2ldkMFnTwCTi3MrjGS45/iwjZZE1SWhaIVcN5Sow8mOjZWIp87Tb+uTRX7tsrMprEkZtd
        CvbBwR9bn1IDMRJ7PQ21YgZnV7ad9/M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-siGBLCgvPWqFEptQfvYPgw-1; Sun, 19 Mar 2023 10:23:24 -0400
X-MC-Unique: siGBLCgvPWqFEptQfvYPgw-1
Received: by mail-qt1-f197.google.com with SMTP id f36-20020a05622a1a2400b003deb2fa544bso1428618qtb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679235804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/hIkiUkQpnPgtTLze7otKxFbigf/WOsrX7aDGKl4Xk=;
        b=ayLvNYPyJNf4iUhpCLtlkH0OWDqy/lIONIVqri8Krz/uwnpwMWh4T0O8jkIw8tbv8o
         VHXfrOK7NuE0v21VfsWCn9pCgA4XsXyNKk9bBTzQoQ2AMaYKQqHPZj63mjpMY7cPGI+h
         V/2JD9PMhAdTsZqcayJAQKAqJCaoXZdCZ7O2GzffHMLZ9dpEA1xl1VvqTCC8Cc6aevoR
         0m4J4KTUnQ+sjodnSYu0Q9evJ5ekiglf6PPMW7D3IcU2GwN03oUn4k7PxbV3LdLnyqeH
         zqoJYk9Ka40z/JHzHZrOVoEhf1wpYoqx80Tm04ir4DvIxNYF3/lGXutS7wnqj/BqVzfV
         m1pg==
X-Gm-Message-State: AO0yUKU2CESkWiF7CmfqVP7UyeZIv8ohvnaEXwWDjd8g1mGmTf374wYR
        qMWTYe02/R001ir3YhTkhcXwB2jBa5KvDYQlTgB9GggmDkY6ARIhuPH64KtQAO0C2QKxAnhOvs+
        ViB8wUfNDI1x17ZMcop47bSw6
X-Received: by 2002:ac8:5c81:0:b0:3b8:2504:e90a with SMTP id r1-20020ac85c81000000b003b82504e90amr14481139qta.3.1679235803805;
        Sun, 19 Mar 2023 07:23:23 -0700 (PDT)
X-Google-Smtp-Source: AK7set+VdKmYQdrgrfLXblYozKf6KZb4B0tCRITCJXTgRYRA6AKoIA4AB44uaiwX/F6ze/obzO3pzQ==
X-Received: by 2002:ac8:5c81:0:b0:3b8:2504:e90a with SMTP id r1-20020ac85c81000000b003b82504e90amr14481124qta.3.1679235803572;
        Sun, 19 Mar 2023 07:23:23 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o8-20020ac841c8000000b003de4e646d63sm2103047qtm.32.2023.03.19.07.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 07:23:23 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     patrik.r.jakobsson@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/gma500: remove unused gma_pipe_event function
Date:   Sun, 19 Mar 2023 10:23:20 -0400
Message-Id: <20230319142320.1704336-1-trix@redhat.com>
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
drivers/gpu/drm/gma500/psb_irq.c:35:19: error: unused function
  'gma_pipe_event' [-Werror,-Wunused-function]
static inline u32 gma_pipe_event(int pipe)
                  ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/gma500/psb_irq.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
index d421031462df..343c51250207 100644
--- a/drivers/gpu/drm/gma500/psb_irq.c
+++ b/drivers/gpu/drm/gma500/psb_irq.c
@@ -32,17 +32,6 @@ static inline u32 gma_pipestat(int pipe)
 	BUG();
 }
 
-static inline u32 gma_pipe_event(int pipe)
-{
-	if (pipe == 0)
-		return _PSB_PIPEA_EVENT_FLAG;
-	if (pipe == 1)
-		return _MDFLD_PIPEB_EVENT_FLAG;
-	if (pipe == 2)
-		return _MDFLD_PIPEC_EVENT_FLAG;
-	BUG();
-}
-
 static inline u32 gma_pipeconf(int pipe)
 {
 	if (pipe == 0)
-- 
2.27.0

