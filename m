Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BB96410AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 23:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiLBWeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 17:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiLBWdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 17:33:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7811AECA1B;
        Fri,  2 Dec 2022 14:33:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d20so8324568edn.0;
        Fri, 02 Dec 2022 14:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJBRCJuPeD4sVOppZ4nKmrCrzkzn8rXvXzlwDq8fCmI=;
        b=GGe+iTwGyOOaFKNTDlCAjR6dKR8wb5gMcZ/dMjIhA46ZT6K3stZiPKFn9fWRmgFGb3
         FLAJj/dwDbeywMhmpk36ITl9i7nP2/mPrUuzzQwlTfFwcWJkE0X9G0nJRyGa+DzvIkY1
         pqBYLiaXsGTGJ1X+RcZnEmnYsyF5e4Nphz2CpKT1zcLyvGlAoqJEwBryRTiZDJDfccH2
         wvbdTjZNf29D6bae/165/3v0hU39Xw6nlBi0y+wm/yD9Fl1lqKBNOJDMRZoa7L7vpB+5
         lP/wMW2xkGOADRNqRu6nf0IiwYg+Cm1C0xqV5DdKnmpTxk3TP/gsdre3tfwJ67wCePai
         Q8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJBRCJuPeD4sVOppZ4nKmrCrzkzn8rXvXzlwDq8fCmI=;
        b=7/SOencGnXoZm2TI246WLw1Bg3vgNfzNZOR9XpYn405safYP48ssmqqE/nDZzlooS1
         7xMBuzuj7ipNYDo4Zkaka+OTrkL0dLfO9deK2RIaA1NBYRl3YK2n29ngyXUOpbYzf0ar
         khWPAE9da0d5zTCnwlwe5g2cc6y5NCnnCAEWERoML9uZtJzWYjw48lw2bb+Oq/i0zrq0
         j/QPw7Qdp6bL+4Zkzv3Bwq4bHN6frR+zBcNkFIYyq8OtHWTTmm3RCvgSMKJ10RE7a0Ug
         sv7hUvnaHx+nHwKISz3NnWEmzc0bY+u4AM4L+0gOaifHCqk2y7lXCfHiXRWn0OUJo3vP
         q1uA==
X-Gm-Message-State: ANoB5plOLDXRPKlAkwkvEXsx3effW2+MwqOBESKDZJexeM8pMYGVgbsz
        fbfTawXzS3glPVrTroaWqFs=
X-Google-Smtp-Source: AA0mqf6bUwpCibxdfNg2Qs6jac/cuNOb/Eb0NpNvR+lvblsUC5blc8pJCASp7sxHiFwcgkapDtGiXQ==
X-Received: by 2002:a05:6402:144f:b0:46b:51e5:832a with SMTP id d15-20020a056402144f00b0046b51e5832amr21328502edx.331.1670020423103;
        Fri, 02 Dec 2022 14:33:43 -0800 (PST)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b007c0d0dad9c6sm575340ejg.108.2022.12.02.14.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 14:33:42 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] platform/surface: aggregator_tabletsw: Use target-ID enum instead of hard-coding values
Date:   Fri,  2 Dec 2022 23:33:23 +0100
Message-Id: <20221202223327.690880-6-luzmaximilian@gmail.com>
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
 drivers/platform/surface/surface_aggregator_tabletsw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_tabletsw.c b/drivers/platform/surface/surface_aggregator_tabletsw.c
index 27d95a6a7851..bd8cd453c393 100644
--- a/drivers/platform/surface/surface_aggregator_tabletsw.c
+++ b/drivers/platform/surface/surface_aggregator_tabletsw.c
@@ -247,7 +247,7 @@ static bool ssam_kip_cover_state_is_tablet_mode(struct ssam_tablet_sw *sw, u32 s
 
 SSAM_DEFINE_SYNC_REQUEST_R(__ssam_kip_get_cover_state, u8, {
 	.target_category = SSAM_SSH_TC_KIP,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x1d,
 	.instance_id     = 0x00,
 });
@@ -371,7 +371,7 @@ static int ssam_pos_get_sources_list(struct ssam_tablet_sw *sw, struct ssam_sour
 	int status;
 
 	rqst.target_category = SSAM_SSH_TC_POS;
-	rqst.target_id = 0x01;
+	rqst.target_id = SSAM_SSH_TID_SAM;
 	rqst.command_id = 0x01;
 	rqst.instance_id = 0x00;
 	rqst.flags = SSAM_REQUEST_HAS_RESPONSE;
@@ -430,7 +430,7 @@ static int ssam_pos_get_source(struct ssam_tablet_sw *sw, u32 *source_id)
 
 SSAM_DEFINE_SYNC_REQUEST_WR(__ssam_pos_get_posture_for_source, __le32, __le32, {
 	.target_category = SSAM_SSH_TC_POS,
-	.target_id       = 0x01,
+	.target_id       = SSAM_SSH_TID_SAM,
 	.command_id      = 0x02,
 	.instance_id     = 0x00,
 });
-- 
2.38.1

