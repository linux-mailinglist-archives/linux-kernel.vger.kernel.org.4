Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B746C391C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCUSZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjCUSZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:25:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEEA768F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679423064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1knlGgYN2VT/JtfLiS27/wQuiH/G9YJjnb0AMKUk5yM=;
        b=i29JHd1TDAsQdZUi9Lr/29ULhl6/bVhSmCeTsDRULwiM0TDF+b3MhR0V2spc7drZGInXNK
        Qsr/XwZIpCCOystNT5gqVkaBD//pofFHo//UEImFXSOO35YEM16DXzxYgNQmp2jDNhIxav
        ErudQXFc3/5J8IP7boNrGaXHbHowd4E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-P8bAg1ABNkqHzlAfFjovUA-1; Tue, 21 Mar 2023 14:24:20 -0400
X-MC-Unique: P8bAg1ABNkqHzlAfFjovUA-1
Received: by mail-qk1-f199.google.com with SMTP id pc36-20020a05620a842400b00742c715894bso7436424qkn.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679423060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1knlGgYN2VT/JtfLiS27/wQuiH/G9YJjnb0AMKUk5yM=;
        b=vwJK1WcV8Mi4C6HyIKhHzFI6AClEfaUBE4HDRrNP7nKlnP5RZv5pzvgeYtUQC470kD
         dKB+NQNWL+sd464qJkmZnpqP2/aRSAh4P4GCreQuGUoQByss1EXocXbgxhCYfv5ZM2Sa
         03K6+SoeKoqxL89w2LHZsu5GaGv549AiClr0Ez3mbKKx0R9wDZXWkuWwJ3Ba7RQ2gHiZ
         Yo+eCWi7RNmdijQx5qzFxTtkHssdB/yaE7sc2JByG656ye2FcF/z4igRF83clUVIM1rs
         MdRCcy6V4G68CSgy2dtfa+14ojhT9FYWdBpuLDOnCHgHZ5JxsU8sbDv/8+Lz+7enn2A4
         v9Lw==
X-Gm-Message-State: AO0yUKWjCZqRdt1GxX+vXRnirPTVfsyvRlB7hud0x6IB5ZlyObVekn5k
        fojPb5h1nAudXpdQxelZ+cyAj/4KY4yg8HTQQWNjU5nLyVjQv2ydTmVbThu5Ox6lEWRKnXxWiTF
        eGczZIdV/9Ezan/zABUDfIL4r
X-Received: by 2002:ac8:5a13:0:b0:3e3:8392:a20e with SMTP id n19-20020ac85a13000000b003e38392a20emr1818993qta.11.1679423059995;
        Tue, 21 Mar 2023 11:24:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set+dI/AIvwoRVUqT1YTTXfDAONNxagr+5GYbKtG20x4g1N6bckO9liMnHnzF2jPTXjsqnR44fA==
X-Received: by 2002:ac8:5a13:0:b0:3e3:8392:a20e with SMTP id n19-20020ac85a13000000b003e38392a20emr1818956qta.11.1679423059754;
        Tue, 21 Mar 2023 11:24:19 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d18-20020ac86692000000b003e386bb1566sm822618qtp.31.2023.03.21.11.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:24:19 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/vmwgfx: remove unused vmw_overlay function
Date:   Tue, 21 Mar 2023 14:24:14 -0400
Message-Id: <20230321182414.1826372-1-trix@redhat.com>
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
drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c:56:35: error:
  unused function 'vmw_overlay' [-Werror,-Wunused-function]
static inline struct vmw_overlay *vmw_overlay(struct drm_device *dev)
                                  ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index 8d171d71cb8a..7e112319a23c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -53,12 +53,6 @@ struct vmw_overlay {
 	struct vmw_stream stream[VMW_MAX_NUM_STREAMS];
 };
 
-static inline struct vmw_overlay *vmw_overlay(struct drm_device *dev)
-{
-	struct vmw_private *dev_priv = vmw_priv(dev);
-	return dev_priv ? dev_priv->overlay_priv : NULL;
-}
-
 struct vmw_escape_header {
 	uint32_t cmd;
 	SVGAFifoCmdEscape body;
-- 
2.27.0

