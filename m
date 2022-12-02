Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4E6410AD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiLBWeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiLBWdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:33:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9B2EC82D;
        Fri,  2 Dec 2022 14:33:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id vp12so14654930ejc.8;
        Fri, 02 Dec 2022 14:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdlZUggfG0fxjaA+cqLRw4yaCZJ4vPfUgkLv65iJoHU=;
        b=oGnPuMFhCjREozXvRwStzRjpcDIQs+PMnHa51gR1gSJYj7pA/g87px7M4nfB4DCtDU
         OMke+Z0vozViBGsAWra8YSGnMPG5fEQ8NGV14Ey9x1ujsiro85Mc5zIvNkA/h9HD+iY5
         hBbxpJpLF+XLBgE0o3gxpa11FFWBIsd40Hay3CN+931h4vNN8G6+9iDcsC/RxqTxiXXM
         2in6t9NlQtHV0WG2k/jH7PB0R2Vczcly5Zhfj7tcSC0QmDqwvmr7E/mBZxzXOGrK8AcC
         Y/bjMdanpuGfOcIkUIvFJwUs/O26pPROERCETFj3wX1u1azcsr/vxZWrrO7uEUjc3nNo
         ewig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdlZUggfG0fxjaA+cqLRw4yaCZJ4vPfUgkLv65iJoHU=;
        b=eF3kK0y3PXWGH4Gt2Yj2ge5lvnJb0+E8JO8LBNYMbqUUFzu8lScoNiCyKhmN++X+xs
         HiXOw3zeoICDqk/ZnGf68cu5vPPVqeLTLN6zFWKzQvoF2CdQQ8u3m9dOcezSV+QvPOKO
         aXMfVoQA2fy3xkEJsk0zAsjPKLgJ0xgkAaXbYOMbpTGdqoBMlHls9/Y8gnVMADKFnJEb
         re05aS7bvNxizZXoYXg8uvlCCaCsFDOBaaFdFMd37+QBl+BtivRQOL47g3qfdHmDhjFG
         Oacci1CGBWhUu5skdpYn5+GjGHEn8yQJjNH3sA8+TLHI8olOxo+mMB/xDk1H9yD2C6QT
         2XDg==
X-Gm-Message-State: ANoB5pk8840jjsrB4kKEBk4XAMtehzN2nYZsc+1rzI7ttuC+j8md+2yO
        ci64bWLk9EFdtN8jAE/IKWo=
X-Google-Smtp-Source: AA0mqf7oVj5Tzan7hDAArp8ppgwaqMIH/ppYemke4pGVSSA7fobds/2HHUXzy4mdcCa4SzBrQYLU4g==
X-Received: by 2002:a17:907:a06f:b0:7ad:948f:11bb with SMTP id ia15-20020a170907a06f00b007ad948f11bbmr45884701ejc.354.1670020421905;
        Fri, 02 Dec 2022 14:33:41 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b007c0d0dad9c6sm575340ejg.108.2022.12.02.14.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:33:41 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] platform/surface: aggregator_hub: Use target-ID enum instead of hard-coding values
Date:   Fri,  2 Dec 2022 23:33:22 +0100
Message-Id: <20221202223327.690880-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202223327.690880-1-luzmaximilian@gmail.com>
References: <20221202223327.690880-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of hard-coding the target ID, use the respective enum
ssam_ssh_tid value.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_hub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_hub.c b/drivers/platform/surface/surface_aggregator_hub.c
index 43061514be38..62f27cdb6ca8 100644
--- a/drivers/platform/surface/surface_aggregator_hub.c
+++ b/drivers/platform/surface/surface_aggregator_hub.c
@@ -214,7 +214,7 @@ static void ssam_hub_remove(struct ssam_device *sdev)
 
 SSAM_DEFINE_SYNC_REQUEST_R(ssam_bas_query_opmode, u8, {
 	.target_category = SSAM_SSH_TC_BAS,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x0d,
 	.instance_id     = 0x00,
 });
@@ -292,7 +292,7 @@ static const struct ssam_hub_desc base_hub = {
 
 SSAM_DEFINE_SYNC_REQUEST_R(__ssam_kip_query_state, u8, {
 	.target_category = SSAM_SSH_TC_KIP,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x2c,
 	.instance_id     = 0x00,
 });
-- 
2.38.1

