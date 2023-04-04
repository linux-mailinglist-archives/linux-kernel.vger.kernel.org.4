Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387946D6CAC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbjDDSy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDDSyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:54:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BEB1713
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680634418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=j0M5QDGBellEBnHKe7QL0tgh7mmOP32p1W0jTZXhVvA=;
        b=MsnmTpfSjhqKXOqu7MoM7xz8/EzOfKu45myJmAV1izx5A1LlNGbUlVMSK4qYjAIp6RE4vJ
        QKhs7LxrlFJUcyO1k0edGgoVnglrGcLIo/Ng81Jk56yr/aXTybs5iSpU3XSqxTq0JMe80E
        M3+fUWbF4dhXepWNulkL0h0EiFp2E5A=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-mvoJtV77Pta6GA5BkIKq5Q-1; Tue, 04 Apr 2023 14:53:37 -0400
X-MC-Unique: mvoJtV77Pta6GA5BkIKq5Q-1
Received: by mail-qv1-f71.google.com with SMTP id e1-20020a0cd641000000b005b47df84f6eso15181914qvj.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680634413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0M5QDGBellEBnHKe7QL0tgh7mmOP32p1W0jTZXhVvA=;
        b=MysbOyeUQJfPQcQAOFtQv8iOSLOP3jyFYWZFQWpUVHGYl3m8Tj5VPOG1OjTEc9gTAc
         BY4WlaoV3NFbJKdzhREo4q71pzQfV9f0bC4Ps2fXtfHQlGl95l4Xq2U8xAW0+sXOue1+
         wZ62njiGNDzrPVGngiQdewGGg2dH7rQMz7p3rK1mI1JfP9AYGn4egBuVNzceD4PZX4h2
         fk5q4TYhtbjW2IAwjh3wRyiMlSJs7UIZIa3fFg0zLIGUc4Z9AA47OhTDApLIMuKZYgc3
         oeZSfzChYZeRyeGQRxfkXLAksuKJwKU2puLLB+eHHSNjeuy9uqLiPx3rCX2qzeEQ83OX
         t+aw==
X-Gm-Message-State: AAQBX9eSzypW/QRTy8fQGBq2Jcmprj/tE+rmuICdPNCE8bFz5gbIw61n
        BVabd2ihOOV8WD7Rh5aBfVcP9yiUk+TdjOCEE0xrK2TWlYXNQVeSNw61yb27Fg1e9H+Bj6oXD67
        5UdmafTBqaghrrR55+F4ONGYZ
X-Received: by 2002:a05:622a:138b:b0:3e4:e8be:c3a4 with SMTP id o11-20020a05622a138b00b003e4e8bec3a4mr741061qtk.56.1680634412936;
        Tue, 04 Apr 2023 11:53:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350aHha48xVckQMZBBBOfNL67WaM8+Vk8RyO27WZmOEbqXBCe+GmWfP76gbamBPcNYhZvXnXLKA==
X-Received: by 2002:a05:622a:138b:b0:3e4:e8be:c3a4 with SMTP id o11-20020a05622a138b00b003e4e8bec3a4mr741035qtk.56.1680634412694;
        Tue, 04 Apr 2023 11:53:32 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f9-20020ac84989000000b003e38f7e4562sm3400800qtq.69.2023.04.04.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:53:32 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, vladimir.lypak@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/msm/mdp5: set varaiable msm8x76_config storage-class-specifier to static
Date:   Tue,  4 Apr 2023 14:53:29 -0400
Message-Id: <20230404185329.1925964-1-trix@redhat.com>
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
drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c:658:26: warning: symbol
  'msm8x76_config' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
index 1f1555aa02d2..2eec2d78f32a 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
@@ -655,7 +655,7 @@ static const struct mdp5_cfg_hw msm8x96_config = {
 	.max_clk = 412500000,
 };
 
-const struct mdp5_cfg_hw msm8x76_config = {
+static const struct mdp5_cfg_hw msm8x76_config = {
 	.name = "msm8x76",
 	.mdp = {
 		.count = 1,
-- 
2.27.0

