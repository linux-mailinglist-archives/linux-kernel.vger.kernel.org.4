Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB39270C568
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjEVSlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjEVSlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:41:09 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13518FE;
        Mon, 22 May 2023 11:41:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2af1ae3a21fso57827711fa.0;
        Mon, 22 May 2023 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684780866; x=1687372866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ChQvPHKY02/sq+5jFcPC0VdUg8JPBNHBqatZ3qRVvFs=;
        b=nj/dXwpD+7WpwGFnnxSTFpYeW65IM5Bl0ML639vJ/mhhJljqbZqH+oUs7COZZPW+UM
         uxvs1hzhg7QYems62LZw70e++ffxcxSJQNMh1wB33yQ60o5LGBnUjmYYFgc6KGVSN2X6
         9lOGSJY1t7gDz1AiLFX6gRhLd7jbeXAlV9keE9r0zMcYDY8z9V8NLPtb2M/H5yrIkrqP
         Br6xALOc8wOcaxjvNCyBmwpzBUNrfpmmvJ3/sRF3/vy7rtOkjq19w1+4PvEm89aJEBnJ
         WHjc45Qbg6gWowfPuO7nL8kzK9ZFTRs/lbQQnNLL9B49yg6/EPP7DiKhrBE3T7HsnNvp
         KDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780866; x=1687372866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChQvPHKY02/sq+5jFcPC0VdUg8JPBNHBqatZ3qRVvFs=;
        b=J3xLloK9E43nZSYYSBHZ1g2lmauc78gzDDiE7/rNdc0PdgKW7FPL2gJ+tSIeRPiMUW
         6H/EOai+JlmbfA/VX3XrhpaxRIPkX4ndMltjkvExJQEh2ZxyiJ/4r24zoU2eTScIKXoW
         aWP0Oh7n4n0oXfi1ScdR7VEWhC7DRYoxdjXGw9yEI5qPuQemg8JNsXQrOstf82Oij09l
         lmLPPLYz4BnXdG02yD5Z7ZUBgbhDM5BdEc8e/SidkMQl0qYfCeA0qjZcQ62B8uV6jyUc
         g5Dc7MPvKKHvjCkHAD+q9KHBEOV/phPBcHBxB9/sEe3OI85xmd9pP1zngOEudedW2xH2
         HnWA==
X-Gm-Message-State: AC+VfDxekm6Fz/4alBqLA5jeki3Uo2yVHZOY82K344zg88tKGjXIsHsE
        aTApvPhhmTWZZplEy1mDGNs=
X-Google-Smtp-Source: ACHHUZ6NoJ8Sxzlrhbi+NQtEAmqiI6/mheCqjrzh7KYvma1zxNHOHiH08RwlWfL12+hPXT+FEkzl5A==
X-Received: by 2002:a2e:8ec4:0:b0:2af:160d:888a with SMTP id e4-20020a2e8ec4000000b002af160d888amr4024465ljl.1.1684780866016;
        Mon, 22 May 2023 11:41:06 -0700 (PDT)
Received: from armor.home ([2a01:799:13ab:8700:e72a:18b2:75e3:fbcc])
        by smtp.gmail.com with ESMTPSA id b12-20020a2e894c000000b002ada0c38963sm1216543ljk.62.2023.05.22.11.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 11:41:05 -0700 (PDT)
From:   Lasse Brun <bruners@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Lasse Brun <bruners@gmail.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: apple: Option to swap only left side mod keys
Date:   Mon, 22 May 2023 20:40:12 +0200
Message-Id: <20230522184013.42621-1-bruners@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Keychron K8 keyboard, and probably others, the right side keys
should not be swapped to maintain PC layout.

Swapping the right side keys moves 'Super' before 'Alt gr' which is not
intended by the default Keychron layout or the ISO layout.

Signed-off-by: Lasse Brun <bruners@gmail.com>
---
 drivers/hid/hid-apple.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index cc535d2d6e8c..d7b932925730 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -58,7 +58,7 @@ static unsigned int swap_opt_cmd;
 module_param(swap_opt_cmd, uint, 0644);
 MODULE_PARM_DESC(swap_opt_cmd, "Swap the Option (\"Alt\") and Command (\"Flag\") keys. "
 		"(For people who want to keep Windows PC keyboard muscle memory. "
-		"[0] = as-is, Mac layout. 1 = swapped, Windows layout.)");
+		"[0] = as-is, Mac layout. 1 = swapped, Windows layout., 2 = swapped, Swap only left side)");
 
 static unsigned int swap_ctrl_cmd;
 module_param(swap_ctrl_cmd, uint, 0644);
@@ -319,6 +319,12 @@ static const struct apple_key_translation swapped_option_cmd_keys[] = {
 	{ }
 };
 
+static const struct apple_key_translation swapped_option_cmd_left_keys[] = {
+	{ KEY_LEFTALT,	KEY_LEFTMETA },
+	{ KEY_LEFTMETA,	KEY_LEFTALT },
+	{ }
+};
+
 static const struct apple_key_translation swapped_ctrl_cmd_keys[] = {
 	{ KEY_LEFTCTRL,	KEY_LEFTMETA },
 	{ KEY_LEFTMETA,	KEY_LEFTCTRL },
@@ -416,7 +422,10 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	}
 
 	if (swap_opt_cmd) {
-		trans = apple_find_translation(swapped_option_cmd_keys, code);
+		if (swap_opt_cmd == 2)
+			trans = apple_find_translation(swapped_option_cmd_left_keys, code);
+		else
+			trans = apple_find_translation(swapped_option_cmd_keys, code);
 
 		if (trans)
 			code = trans->to;
-- 
2.40.1

