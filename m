Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A14B6B655C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCLLYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCLLYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455EA166E4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678620192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MHyu4+8kPd35BCnU7In3CFdj9IYOtFD0P1pEdmm81PU=;
        b=NQBsFjL//cvpBjVExqrxRH0h9KljgGxj2KvPnhHhENqXbn7TNN008bfzCVGyZHFi8PguLn
        zIN9azRH3J/b7PvxKRsF/TLto+lSpJQRsWQRtIMux8x/DZJ+05ch+/ujWfSDL/hId3KCzr
        lIOHBnB6D5Idn1QuUAWdvgVxkX5gpJk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-cIL7B1IuPtqUMcyDPZ__vQ-1; Sun, 12 Mar 2023 07:23:11 -0400
X-MC-Unique: cIL7B1IuPtqUMcyDPZ__vQ-1
Received: by mail-qv1-f72.google.com with SMTP id dl18-20020ad44e12000000b005a4d5420bc6so666153qvb.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678620191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHyu4+8kPd35BCnU7In3CFdj9IYOtFD0P1pEdmm81PU=;
        b=A6WGoXIgqMfuztn57CqIdtXOqt5As/zvVhtdBhRIG+dDH6Sh5k5p0y81gmqAL7si9e
         KUAzrKGgLmNh/v0dV6BhEyZlYptZo+JinXO131wTP7Ufg3+Tlq9H3zoNKkW9zGj5Cx4y
         8tX+wa698RG2Omy9zpkj5+N5FxR22TFmj5Jn7hMTp+pXdgi+GPs6isK/ON/D6uJanwou
         HqwYVEe9BXCQYfbOkxiTaHl8Srh80awksEwNnlqweQ7pxJmkMh4ophHihndGOwHOupyR
         54+gwBT6UpuKZPCREDa6fjvm7aHpLo0CXah9K+lUmiFENyJrQcjDtB/d5uVgnygX2PSD
         z6Eg==
X-Gm-Message-State: AO0yUKWFYAijEIsc2QFWeRvK0fTctAKb0ovF3gCQsx5Soify1R65GEy6
        SOg1TZOjYUBjouUBzEprRgPNXvlVReHF1kDNCM5NdADBe7HGgcsP7fVuqWnMEZcziXOZfBe/kZK
        I4YLMxQwdt9ijVSByN1eLCR9b
X-Received: by 2002:a05:622a:170b:b0:3b8:58d0:b4e4 with SMTP id h11-20020a05622a170b00b003b858d0b4e4mr21299707qtk.33.1678620191064;
        Sun, 12 Mar 2023 04:23:11 -0700 (PDT)
X-Google-Smtp-Source: AK7set8rU61IoSMnz2NMxT0D++jddUTjwTZvD4aI/Ne3rhoCM5YcURCxzOjOJup/d6HqF9HM1D0JKg==
X-Received: by 2002:a05:622a:170b:b0:3b8:58d0:b4e4 with SMTP id h11-20020a05622a170b00b003b858d0b4e4mr21299693qtk.33.1678620190755;
        Sun, 12 Mar 2023 04:23:10 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o10-20020ac8428a000000b003b82a07c4d6sm3507928qtl.84.2023.03.12.04.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 04:23:10 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/nouveau/mc: set ga100_mc_device storage-class-specifier to static
Date:   Sun, 12 Mar 2023 07:23:02 -0400
Message-Id: <20230312112302.466886-1-trix@redhat.com>
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

smatch reports
drivers/gpu/drm/nouveau/nvkm/subdev/mc/ga100.c:51:1:
  warning: symbol 'ga100_mc_device' was not declared. Should it be static?

ga100_mc_device is only used in ga100.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/ga100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mc/ga100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mc/ga100.c
index 1e2eabec1a76..5d28d30d09d5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mc/ga100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mc/ga100.c
@@ -47,7 +47,7 @@ ga100_mc_device_enabled(struct nvkm_mc *mc, u32 mask)
 	return (nvkm_rd32(mc->subdev.device, 0x000600) & mask) == mask;
 }
 
-const struct nvkm_mc_device_func
+static const struct nvkm_mc_device_func
 ga100_mc_device = {
 	.enabled = ga100_mc_device_enabled,
 	.enable = ga100_mc_device_enable,
-- 
2.27.0

