Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6BA6A2FCE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBZNZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBZNZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:25:07 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CBE12BF5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 05:25:06 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a7so1980856pfx.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 05:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WIdIsNJqgjcgtgkT28wQ/X13SL46siMQE4Wb+rfuVYs=;
        b=OFF+HS/j6e9XUDNsULpXyIrj1eeG0iuwwuEALp/mbz2yZYlgxUAu0sX7OPAgcKb6cc
         lLkx/0/GsRl/ZE4Mx5Op2bD8xnPCv2H1ZDl88IflWmZTgybi0Du1hHzoH4m/u+L3B9TZ
         db/pxVcUKqkMLg3yXeXZ5IJBJtwr9+cGXIlDyZ67grF2ImzdKoQOQynWvyndBp69IbIN
         DDt4sxONV10oHhm/ht+54Xq3Wwz8YjkHC/xz1X2BnQtX8f8GLVmi6ENh7ZLsK2wBZt0E
         OfUiAaNvZTYzeGf+ZG6KFDZEIY/XPLweqy2Vlb6fIKtVkMN+mobgU8sCdbk2srskg7ho
         9d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIdIsNJqgjcgtgkT28wQ/X13SL46siMQE4Wb+rfuVYs=;
        b=TuK4fNreddne60+hVnQbQ+d2SaUrM+NaciI2V6CM+vMieRG6jLFEsFRd7UOj2eAKlJ
         icyZfJ6UuoXnJJPiHONVCqQwcZHmNrry+f727PSasAFVXzeNT+Cm2v/CThMrOnPCoS8l
         aNviyMyRejdeM6dCb/Tx/gh919tSd5dDOLYlRke94F+WSYGFnI1R8refLUsYFeS67tB+
         ubGw6T7kuZbD+0e1Xd2SXH9DJ3X6QFCwkVHAAWoa7b2P6vxO3G2/lT5Pd0RyYm1JIPYE
         AlBdCNYAenr2gSZj7oDBGM0dg6O9+sqhwtcGZviGv7ikQxyCb9AZxFintQaMysShLhEv
         QfIA==
X-Gm-Message-State: AO0yUKWOjS6gCXHepsqh8cM07fPA107ax8AmIUK5qysECvk2KAlbNs7C
        ym1nWO0AzvJXbtq7wI3Jtmk=
X-Google-Smtp-Source: AK7set+cLoNNrU1K3IL3FiBj8M7xOsOAR4VcJfsntkyKZJDBUtf9dogiTalemjQAwLMS7WRPmTwRYQ==
X-Received: by 2002:a62:790f:0:b0:593:befd:848c with SMTP id u15-20020a62790f000000b00593befd848cmr20422654pfc.16.1677417905841;
        Sun, 26 Feb 2023 05:25:05 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id e13-20020aa78c4d000000b005a75d85c0c7sm2495932pfd.51.2023.02.26.05.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 05:25:05 -0800 (PST)
From:   Kang Chen <void0red@gmail.com>
To:     paskripkin@gmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kang Chen <void0red@gmail.com>
Subject: [PATCH] staging: r8188eu: add a null check of kzalloc in go_add_group_info_attr
Date:   Sun, 26 Feb 2023 21:25:00 +0800
Message-Id: <20230226132500.3933232-1-void0red@gmail.com>
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

kzalloc may fails, pdata_attr might be null and will cause
illegal address access later.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 93d3c9c43..802e1170a 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -31,6 +31,8 @@ static u32 go_add_group_info_attr(struct wifidirect_info *pwdinfo, u8 *pbuf)
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	pdata_attr = kzalloc(MAX_P2P_IE_LEN, GFP_KERNEL);
+	if (!pdata_attr)
+		return 0;
 
 	pstart = pdata_attr;
 	pcur = pdata_attr;
-- 
2.34.1

