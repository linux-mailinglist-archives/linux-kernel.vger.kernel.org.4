Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2636410B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiLBWeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiLBWdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:33:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA7FF81B5;
        Fri,  2 Dec 2022 14:33:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id e13so8205981edj.7;
        Fri, 02 Dec 2022 14:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4RJx9RRdpMAE8kiYEvU6NCFJlSYb1Rttu5ZW2+HQ2Q=;
        b=aemu7vqZtiB00kfnuBczj8M5Jjt6opfkZZiQURopS8WTh114XJm+FB1JHceAShBaLB
         ZgkdiGRyKQJ7NG/+ABojtF6sHjopjfHz0hqlqVEz0Ha71rcdNwSGh96VcEL/hhplEwaj
         q6bb2yWb+i2mQ0Am2ALMVma3hb62djZuahu1oTM7LugrcvTBjhyAzH0pwHImNuzCRnzN
         gBkfnFW10oLo6tUDpxsoyhaFC5ZTbf3l8lP0j3TnZeU6x+eGrNWuCiiboFgLN/up/GTY
         j09AG3V7u/HWVLNvGCFstqSpqDcfzJiwktht/1ckQOXGSoqs1Cbbi90tVh7P2B2EDcHy
         f7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4RJx9RRdpMAE8kiYEvU6NCFJlSYb1Rttu5ZW2+HQ2Q=;
        b=My/4YTbkufUYN9kIMlNtKTPV6FDwJ3ZaEZ1Md+Ljv4I80Odmm8ndbzpmkdxMrlbAf5
         YcyztF55l76srjrMVY0eTlMqaCkwb+N1H1Xw1MjLmV26en2F2OHh35MIJ88PPR8g6/XH
         MvkHZpDIz9TY/2TBfYWX8fIh/q+DrvcJaHYughl9lEzX555CwILQ2vEAhdxBMKOLCgof
         BshQKAwbg5ktYNflLzePesOV81oS7zJBUvaMTI6ktZsOwp07UFsUYroR6B6nr1Tw0FTH
         RBOvnQWaKIkEle49jiXROZxGfhLuQONbQew89I94pJaoZX03Jit/NysUVDvCr7cFlT08
         2Oiw==
X-Gm-Message-State: ANoB5pkdyGCeeis1ZfaCiIwk5EH2eJuXjNuUClf852IwsFmP5wAkxy20
        s/KX2BydJ6hGiqfbLVvVdHA=
X-Google-Smtp-Source: AA0mqf7wXaMMfGRLuwREOFjkgkFZ6IZXzOPzfj9OQ11nAL5J6EfNgWPJ2KqQCzwzbJkwkKfBRQb0ww==
X-Received: by 2002:aa7:cd04:0:b0:46b:34c:5574 with SMTP id b4-20020aa7cd04000000b0046b034c5574mr27293913edw.175.1670020424225;
        Fri, 02 Dec 2022 14:33:44 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b007c0d0dad9c6sm575340ejg.108.2022.12.02.14.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:33:43 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] platform/surface: dtx: Use target-ID enum instead of hard-coding values
Date:   Fri,  2 Dec 2022 23:33:24 +0100
Message-Id: <20221202223327.690880-7-luzmaximilian@gmail.com>
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
 drivers/platform/surface/surface_dtx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/surface/surface_dtx.c b/drivers/platform/surface/surface_dtx.c
index ed36944467f9..0de76a784a35 100644
--- a/drivers/platform/surface/surface_dtx.c
+++ b/drivers/platform/surface/surface_dtx.c
@@ -71,63 +71,63 @@ static_assert(sizeof(struct ssam_bas_base_info) == 2);
 
 SSAM_DEFINE_SYNC_REQUEST_N(ssam_bas_latch_lock, {
 	.target_category = SSAM_SSH_TC_BAS,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x06,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_N(ssam_bas_latch_unlock, {
 	.target_category = SSAM_SSH_TC_BAS,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x07,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_N(ssam_bas_latch_request, {
 	.target_category = SSAM_SSH_TC_BAS,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x08,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_N(ssam_bas_latch_confirm, {
 	.target_category = SSAM_SSH_TC_BAS,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x09,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_N(ssam_bas_latch_heartbeat, {
 	.target_category = SSAM_SSH_TC_BAS,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x0a,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_N(ssam_bas_latch_cancel, {
 	.target_category = SSAM_SSH_TC_BAS,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x0b,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_R(ssam_bas_get_base, struct ssam_bas_base_info, {
 	.target_category = SSAM_SSH_TC_BAS,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x0c,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_R(ssam_bas_get_device_mode, u8, {
 	.target_category = SSAM_SSH_TC_BAS,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x0d,
 	.instance_id     = 0x00,
 });
 
 SSAM_DEFINE_SYNC_REQUEST_R(ssam_bas_get_latch_status, u8, {
 	.target_category = SSAM_SSH_TC_BAS,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x11,
 	.instance_id     = 0x00,
 });
-- 
2.38.1

