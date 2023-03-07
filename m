Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6756AE6B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCGQfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCGQfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:35:16 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AAC87368
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:33:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id bo22so13771859pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678206813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6pe3bFa4dtdjd19YymjjBBEUeO6qAkV6I0oGfI7oeQ=;
        b=mWKzJI5Qelz3mHOnckXG1swo5n1J1nJ5NHNNzhn+UbHdAvrWjy/ro3VYvqQ1VSTbft
         ICm7pt89UwZrvnE6jG/Gm1a2KVO+a2U9GBaheaSZfmKeNwqqBtWCKghcyL3zsxBksFej
         ArkOUR3F27v5s4djLQ9fKSX6/vjZsGMUIgY2H/fezevHrbTcCFkTqf5sNJl+zX/ebyMI
         Rf8c2u1v6+sUaO/S6sGJ2/4NFVJIjwbi0uIXUhrWx1THORT6hHLjhey4oAK/Zm/at110
         g78k09t5jlwgE6hZtV2bFK4msWFOTzN1Omy2+PMp8RJWVP4tSbl/f2Ci/KjoQfLPv9mB
         hoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6pe3bFa4dtdjd19YymjjBBEUeO6qAkV6I0oGfI7oeQ=;
        b=Vu5PvEzy1e3TTU6A0bJH5V0wuXQXVQ+5Fe81kum/bnQlFTia4jLFGCYBJUqhkxQFM+
         1uQ/5MWoD/WcCy7gtSjTLKR2AbRHE08WzA7yEq8Fi5LO0KLirk6KlG1et9IyOoIkk5iU
         L/KyrvSR03LsnN+7/VrC03U8wzmJVthQcSaOfG70N9o4vbUpnV4xv6fswoQvqMXGAuBu
         FKqy6cpckmN7ogxRndkgYbtDF+bl3qi6qHCiGZddptvLus++Uq128n7NJmoVeVZtG8D2
         ifAxqR/4RR1v+58UQkyR2eqqPM1Ew9vLnhsaY2I6FE6myKtGRoSa/Xwsf7uMFB03DfRG
         FGXQ==
X-Gm-Message-State: AO0yUKUjy2ALtRzZZpV5daWMCKAXyegmc5cJTFuKjk/YKAKKw1lRL1yk
        sw4ZU68kWYnOcL3lnA8WLEg=
X-Google-Smtp-Source: AK7set8Eav0yqRkAndYPJUYgK9rU+iloFq5BX+jt6Cx/GayRhRPGX+xaSZ4trXl4zA8fQG+L5lu2Mg==
X-Received: by 2002:a17:902:dac1:b0:19c:13d2:44c1 with SMTP id q1-20020a170902dac100b0019c13d244c1mr19533010plx.15.1678206813024;
        Tue, 07 Mar 2023 08:33:33 -0800 (PST)
Received: from DESKTOP-HHR6EMI.localdomain ([143.244.50.165])
        by smtp.gmail.com with ESMTPSA id kp8-20020a170903280800b00198dd432329sm8660951plb.51.2023.03.07.08.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 08:33:32 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     void0red@gmail.com
Cc:     allenbh@gmail.com, dave.jiang@intel.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [PATCH v3] ntb_tool: check null return of devm_kcalloc in tool_init_mws
Date:   Wed,  8 Mar 2023 00:33:07 +0800
Message-Id: <20230307163307.132-1-void0red@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANE+tVo98AZuRGcAshv5W6v2+fKjTruDVRRdgjfyAVk93cC3_g@mail.gmail.com>
References: <CANE+tVo98AZuRGcAshv5W6v2+fKjTruDVRRdgjfyAVk93cC3_g@mail.gmail.com>
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

From: Kang Chen <void0red@gmail.com>

devm_kcalloc may fails, tc->peers[pidx].outmws might be null
and will cause null pointer dereference later.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Kang Chen <void0red@gmail.com>
---
v3 -> v2: add Reviewed-by tag
v2 -> v1: add Fixes and Reviewed-by tags

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

