Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218E962F2D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbiKRKoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbiKRKn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:43:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EF111A23;
        Fri, 18 Nov 2022 02:43:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g12so7587257lfh.3;
        Fri, 18 Nov 2022 02:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M54rSFxQLijO3j26nQU0jB0r1Bnt0dCKzsYSgimLrI4=;
        b=KMvnRwY0L3d/A/JoE/GXTUQz3sVPfvFmvGZpaOggwoHMG6wnO+7CkXqhK7Q7RJI7sK
         WfR74K9m6eZtlWz+JZxVHEICLP4OT//621qOZhBu2Tn5k35N3yYUwesIA9mDw4uLFE4W
         4JK4Yr3psUhtsKmVuJNkgIhBQTZ5eg4xmgGVGsEgl4njX5METYg97AT+Byxfaou20Mg5
         uzsCERH0AZpX+8LAzQ/2CC8ScUhF5Uwu30RlWuNpIY9X3gb5K6WyrSdQSoTfRsPmhoHb
         NL1sGo6t0gtxPXc65aEsxspqq5QAfl+gMQgASAuNG5fNJGtDvTbsOM68Z3uB/xOQk8T8
         FD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M54rSFxQLijO3j26nQU0jB0r1Bnt0dCKzsYSgimLrI4=;
        b=gMw2yel/DbddWShEycCRp1KUPRti2gF3BM5v8UdIs7Wd3h3+zkhW2D6ksutjf76mDU
         NeLjkSO+6eZt+G9Y1F1/nL0DEEnayZtrYQU/lN74/o9HxEPtWGdFPA6ecdO/J/6RuYu/
         znAlyXRH4OC9dCy0RgO2pX2fpxOLuyJpNffEwcQDsKpIYZE0UTfldTlu15FYyxgbeLwA
         j7K8Hoe/fxMP/m7YWLfrrtVz9zk+wwjimLkF5RBkIXhYwsSBdzbA6CdmoI8CzACS3SNJ
         0CX+8YEwLASRlv2EfCioWN9ooZKQMPRtsQBHzH3LwotvSrESIzA9WEkDeyyuMgIQcFA8
         r+EQ==
X-Gm-Message-State: ANoB5pndm94Ft0nQ83EBqKOw+WSA2T3kxtkiERVnRbjDNHuwk9wqXkve
        0nndVMblJgBkWaR8WSHeupw=
X-Google-Smtp-Source: AA0mqf5UbfQ4/CHQXYMvIKq/kso9soqgxgLcSAnHR3LCuoNPh4obki+ZWElYMSb07O6pDWTFEjJqfw==
X-Received: by 2002:a05:6512:324c:b0:4a2:2e51:85c1 with SMTP id c12-20020a056512324c00b004a22e5185c1mr2134919lfr.658.1668768235135;
        Fri, 18 Nov 2022 02:43:55 -0800 (PST)
Received: from mkor.rasu.local ([212.22.67.162])
        by smtp.gmail.com with ESMTPSA id v26-20020a056512049a00b0048b365176d9sm606174lfq.286.2022.11.18.02.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 02:43:54 -0800 (PST)
From:   Maxim Korotkov <korotkov.maxim.s@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Maxim Korotkov <korotkov.maxim.s@gmail.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] pinctrl: single: fix potential NULL dereference
Date:   Fri, 18 Nov 2022 13:43:32 +0300
Message-Id: <20221118104332.943-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added checking of pointer "function" in pcs_set_mux().
pinmux_generic_get_function() can return NULL and the pointer
"function" was dereferenced without checking against NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 571aec4df5b7 ("pinctrl: single: Use generic pinmux helpers for managing functions")
Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
---
 drivers/pinctrl/pinctrl-single.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 67bec7ea0f8b..5655a2da5413 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -372,6 +372,8 @@ static int pcs_set_mux(struct pinctrl_dev *pctldev, unsigned fselector,
 	if (!pcs->fmask)
 		return 0;
 	function = pinmux_generic_get_function(pctldev, fselector);
+	if (!function)
+		return -EINVAL;
 	func = function->data;
 	if (!func)
 		return -EINVAL;
-- 
2.17.1

