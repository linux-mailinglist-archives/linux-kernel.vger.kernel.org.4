Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FF8737831
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjFUAYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUAYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:24:12 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7AA173B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:24:10 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bf1359ac7b4so345908276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687307050; x=1689899050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0J2mMZpbYUuBkt1OzcmTbR37/rTM4wV7tpvx36q4k8=;
        b=HVqr71pLDZZQbrkmtZivdoVah/rfF8aPb9oAcKO6Py63otq0sDPjl78jLivt3OXOcD
         9Abd0SJDmH1rgJnPSExciXAkhBHbo6PBjkNh+cq7RSa74JRpKcJ+8YF2Pdn+yHm1Qr4M
         TNq8DdzHaC4SlraolJe308KrWDSLpaCXhgJoVlMJ6fgn+ilJh79mm4pj/wttKCTNmGDd
         S1U02hjUI/N53h34CVCITJg/dTEMd8eMDgJ/pjLwERn8kyKASOnCkXE1EyoJgra8Syf9
         S9SCyy92ooYhcFPjFgYxqpNZQE7N/wcxa5M86w0wQb+tWByycP55Jk7Z7WCMBzzlsvAr
         QGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687307050; x=1689899050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0J2mMZpbYUuBkt1OzcmTbR37/rTM4wV7tpvx36q4k8=;
        b=WLSe8ZtWvb2szlE1P5iloQ91XyoLPrf1u2b8dgTpSPnQ6mXJFXVZ3vO/EXlAtRipst
         zDMLLNSuucajH3WU0UUXGoNfzE14JvdsLju6OcarOx1O5qUGCMZVUcGgnVoRuMC/BApw
         EEyDQItI0khqDMrdEVFw2Au5jVaCq2BvkJrb7Aur+myShLuE67bDIDVhBUWEQJEur4DR
         dOKyvCLoUqhhHQ+GNUDMonRwaxutVRznKHhgLaXW3k1bJ/fEh4IHcTWNeXryt7Tj3jjF
         peuycLLrtD33W4llyTn8Fj2JcFryrDr6jyWxjDf1mF4uVOLRzLu3tc10cANiWV0hmOrw
         Aocg==
X-Gm-Message-State: AC+VfDyu3jwsTKcN4jB6V1Ur8Iwzj13KVzIN8tlqvHgWNJ3lpJx3ze3Y
        rRGBI6wfxemx+TuSFZlufBg=
X-Google-Smtp-Source: ACHHUZ5OJk6xqmZclnsH1ORnEt/f1Guny6vzADvRppKpltnMoU8YwdSxCJOvBEJCNW7GZaNHNUtsEw==
X-Received: by 2002:a81:4dc1:0:b0:569:c4be:3f6d with SMTP id a184-20020a814dc1000000b00569c4be3f6dmr7059808ywb.5.1687307050057;
        Tue, 20 Jun 2023 17:24:10 -0700 (PDT)
Received: from localhost.localdomain ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id j1-20020a0df901000000b0054f50f71834sm782701ywf.124.2023.06.20.17.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 17:24:09 -0700 (PDT)
From:   Matthew Anderson <ruinairas1992@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, luke@ljones.dev, sbinding@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Matthew Anderson <ruinairas1992@gmail.com>
Subject: [PATCH 2/2] ALSA: hda/realtek: Add quirks for Asus ROG Ally handheld using CS35L41
Date:   Tue, 20 Jun 2023 19:24:01 -0500
Message-ID: <20230621002401.38244-1-ruinairas1992@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1 > V2 Fix indentation

Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 42 +++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b918b0046144..a413bdee7f63 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8445,33 +8445,33 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC294_FIXUP_ASUS_ALLY_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-						{ 0x19, 0x03a11050 },
-						{ 0x1a, 0x03a11C30 },
-						{ 0x21, 0x03211420 },
-						{ }
-				},
+			{ 0x19, 0x03a11050 },
+			{ 0x1a, 0x03a11C30 },
+			{ 0x21, 0x03211420 },
+			{ }
+		},
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_ALLY_VERBS
 	},
 	[ALC294_FIXUP_ASUS_ALLY_VERBS] = {
 		.type = HDA_FIXUP_VERBS,
 		.v.verbs = (const struct hda_verb[]) {
-						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
-						{ 0x20, AC_VERB_SET_PROC_COEF, 0x5089 },
-						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x46 },
-						{ 0x20, AC_VERB_SET_PROC_COEF, 0x0004 },
-						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x47 },
-						{ 0x20, AC_VERB_SET_PROC_COEF, 0xA47A },
-						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x49 },
-						{ 0x20, AC_VERB_SET_PROC_COEF, 0x0049},
-						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4A },
-						{ 0x20, AC_VERB_SET_PROC_COEF, 0x201B },
-						{ 0x20, AC_VERB_SET_COEF_INDEX, 0x6B },
-						{ 0x20, AC_VERB_SET_PROC_COEF, 0x4278},
-						{ }
-				},
-				.chained = true,
-				.chain_id = ALC294_FIXUP_ASUS_ALLY_SPEAKER
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5089 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x46 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0004 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x47 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0xA47A },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x49 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x0049},
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4A },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x201B },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x6B },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x4278},
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_ALLY_SPEAKER
 		},
 	[ALC294_FIXUP_ASUS_ALLY_SPEAKER] = {
 		.type = HDA_FIXUP_FUNC,
-- 
2.41.0

