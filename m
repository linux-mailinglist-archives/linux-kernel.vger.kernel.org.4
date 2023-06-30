Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15983743F75
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjF3QIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjF3QIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1620313D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688141238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zDzqJbvPB3+ncS0JVgMogsHg0szcNxLVo0nvRHNMeoA=;
        b=DCxNDeECERtRBsGltnefAcVn1nyJ9pct59M5ZJaXLGSW/gRSgq1PgiFhUbF7inxMuRW7Dq
        ZEO8bC7AwknncUKPruAp5AYgupHyy0iGRQUlTpDHH9J73bx0LftYiJbO8fQ2Vo3CtaJt9f
        Kn/LfR2ehw4RXL/k/9AEIR6w+oNv/c0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-jyQOjxFzNf-nv9Ec36B7xQ-1; Fri, 30 Jun 2023 12:07:15 -0400
X-MC-Unique: jyQOjxFzNf-nv9Ec36B7xQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-313e57dfb2eso234785f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688141230; x=1690733230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDzqJbvPB3+ncS0JVgMogsHg0szcNxLVo0nvRHNMeoA=;
        b=lmhERwE6VAw3TUsWioeFogd7r5luBFXTUdvclVnb0srplRv6C74IjfxMhNmvRwvPIs
         vmtuIBQoB+qe3wW6fZx5TcGMtREjsP2qmjNHzEnR3Nxh/wfVJPwZOz8qgjehAU86AgTT
         +6CRRZmCTZQ9mudkqJHB3+n2UWKxmBN08IpasrEAeRds7Bsnv7DDeaIi1bhjYFq97jH3
         87hQEP/y1a8ckPKnyBXSzyDT/wg1TIc1QwOea/Ey3D/baI9KA6TP9YPqPgpQB/BqG6jz
         X/rk9+uR2urMJTaLJp08T5HDGZhbhtxmyi/75GnZUl4hbBrmOYnChKG2JPRp276A103b
         HWkQ==
X-Gm-Message-State: ABy/qLZx2hQQOkj3NMow9FVf74fG9s+9pw/ja8APRu471HHhdgiBb3l3
        Dr9MGBqF9DbrE9wx3fkQWi6IxIDSPBVZ5d9oGqE5DQpd9I5VGfZUwCJc3dZ3J3as9VTYj1Gmv2V
        270O+uo/Utotj8r4b/AMtKxEL7pSJSbavzxJFutqjgJTgSjV1rVvUSceYTd5fmoMPwJyqv4SxOR
        RhkQ1A8U4=
X-Received: by 2002:a5d:4a91:0:b0:313:ed10:7f53 with SMTP id o17-20020a5d4a91000000b00313ed107f53mr2728001wrq.6.1688141219221;
        Fri, 30 Jun 2023 09:06:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHboVEA9uwXPyVU1Q8VvIf0AXphxjPZ6dsb08b1Lb3IKDCnNo6XzcKAR3OcUmRaH9Lq3IFlhA==
X-Received: by 2002:a5d:4a91:0:b0:313:ed10:7f53 with SMTP id o17-20020a5d4a91000000b00313ed107f53mr2727668wrq.6.1688141208961;
        Fri, 30 Jun 2023 09:06:48 -0700 (PDT)
Received: from kherbst.pingu (ip5f5a301e.dynamic.kabel-deutschland.de. [95.90.48.30])
        by smtp.gmail.com with ESMTPSA id cw8-20020a056000090800b00311d8c2561bsm18551755wrb.60.2023.06.30.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:06:47 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH] drm/nouveau/disp/g94: enable HDMI
Date:   Fri, 30 Jun 2023 18:06:45 +0200
Message-ID: <20230630160645.3984596-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Fixes: f530bc60a30b ("drm/nouveau/disp: move HDMI config into acquire + infoframe methods")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c
index a4853c4e5ee3..67ef889a0c5f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c
@@ -295,6 +295,7 @@ g94_sor = {
 	.clock = nv50_sor_clock,
 	.war_2 = g94_sor_war_2,
 	.war_3 = g94_sor_war_3,
+	.hdmi = &g84_sor_hdmi,
 	.dp = &g94_sor_dp,
 };
 
-- 
2.41.0

