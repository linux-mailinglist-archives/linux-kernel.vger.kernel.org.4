Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3121D6A2E82
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBZF5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBZF5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:57:49 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7EEF941
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 21:57:48 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id i3so3627231plg.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 21:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7mel5hZ+WwOyr4vFQ+1SxGc09bvkF0xtIqhHxXgg+8=;
        b=cy3YKdEpKKdjVbRlotje9TmHKwGBjeZjFKwVWpuM+wUWvU0ls9rMH9lgPo8lKsng8m
         t0RWE24bIh/HvG+DC02UxdcraLbEbBdaHzVWQjF1Vd0KviXCUipZijtrQguIv+S0Zcph
         7ATgbptRfoMG1Jk/8FjDQvWT32ee4AhPKXkNwAULZwKrd8hDJ6F7x1PL48oKhtm582wW
         fDmkVz1OQfJdexvtBCcndLdq9axujJJcpGcKaWokHd/It6vrWCK0+/BgrCnv+amRMyJ4
         q00WyudL7xaWJAkxLUB/ZZpX+B5wHxM1vQuH9qPq6CShUNFFBbpy+zQ/2VYYrvVetRRa
         rR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7mel5hZ+WwOyr4vFQ+1SxGc09bvkF0xtIqhHxXgg+8=;
        b=VkuI1hvL9lmezbkiUfiV+gijBsDjC/iPGECvw3J+7SGwZUPgQZO8AVB7ZLuuY66TEM
         hcIo58m2M2zHJ/4TuabvgGDOZcCr0w1HnbGml0UGjD2pbSrkMHoXIlMB5TkP6jh/7G5E
         HQr8ufw0vG75qZ8NoCfWAHkJcgxXc+HMTaqMoG6KuWa7FlMo+KIdnQus1tVPFX0sEy+o
         0ECvn1WevkhDRoTjoqG/KnPbLnNbOSgn4E6CndWEYJwPzdBtUd3HLEFuviYgMktuu4de
         yYKDCxg9P67k1qDep/RkltB0bXF9nmQJIsfOn1mfO07/q6Q391tELCrRGmPWhlJN00zj
         xM5w==
X-Gm-Message-State: AO0yUKXXDSIgYfAU8085eTPPeqXzdROU/RcRYEz53CajEyPkmeCBLuag
        16ludrxdFth8Aw8oprhQR1o=
X-Google-Smtp-Source: AK7set+upKe0U+VxsPpgDIQR2qLhjTHVJnCdOEGJbTvXjNIuTF7U0zM5e8ONFQVdGhKVSJ4SFMBuww==
X-Received: by 2002:a17:90b:1bc7:b0:237:b5d4:c0e3 with SMTP id oa7-20020a17090b1bc700b00237b5d4c0e3mr5521011pjb.33.1677391068338;
        Sat, 25 Feb 2023 21:57:48 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id hg3-20020a17090b300300b00233afe09177sm3854872pjb.8.2023.02.25.21.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 21:57:47 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     jdmason@kudzu.us
Cc:     dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH] ntb_tool: check null return of devm_kcalloc in tool_init_mws
Date:   Sun, 26 Feb 2023 13:57:43 +0800
Message-Id: <20230226055743.2522819-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
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

devm_kcalloc may fails, tc->peers[pidx].outmws might be null
and will cause null pointer dereference later.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/ntb/test/ntb_tool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 5ee0afa62..eeeb4b1c9 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
 		tc->peers[pidx].outmws =
 			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
 				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
+		if (tc->peers[pidx].outmws == NULL)
+			return -ENOMEM;
 
 		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
 			tc->peers[pidx].outmws[widx].pidx = pidx;
-- 
2.34.1

