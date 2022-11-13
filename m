Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518A62717D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiKMSJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiKMSJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:09:52 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6927BDEB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:09:51 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f7so14286107edc.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4byRwPo02lvkmaR0NL7PCXZ/wh86nqqJqs0NF0iJNN4=;
        b=Klr8dittMggHZPqmUvNZDK5ZpTzudeRXL4AUHJzqU43nDT49Nb42aUWtHpvU8hn7ew
         m7B76kJn2mJMXEq/4/z2R3bf4MhcbKmVMmKdCanyADpkYqwQwS4VoZckP2z36zXJykVI
         aeRtqs7bLNLq6WSXm7nMqymtnj7RXCZfz5n+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4byRwPo02lvkmaR0NL7PCXZ/wh86nqqJqs0NF0iJNN4=;
        b=5lHfl80p+YQcByKu+WAOyfhcYl3QY9b/n2YnWQFCkaB/tm20EwbEhkDBACDD8SCOug
         oyaYmhqw1P3635Zukrfsl9ubbay/RHuNMLcWEjXLUTsjTY8R3nzR4zNJHVHOw0v5E/44
         DZOXwc8BpGLRPZ5sAhFqpIlgifV3wMtpNY3Yw4caVOoc6MYeazo+VbSrhv9bTt/slh9C
         Moaz991WXSB41WuvdN8Z0feBA8TrB2XEBTs//lbkzyJjPu6Z+68cxAnSS+/otpWSN1U0
         7TXlCGIw5+5bCwDYg6xeUCX9+uuc5Y7E8CAUVZg2oaIXNsrW4D8AEU9CfugLQQ+aJw4L
         SZPA==
X-Gm-Message-State: ANoB5pnSJp8cD8MUei8QS5RYoyAV0zE70QROSWbHYuuDHCfsR5E7sO+j
        t/Pc80ocEc5EXaDHEdh1+5P80txL1Yurnw==
X-Google-Smtp-Source: AA0mqf6H21J6diShQQYxKQGIY8g5aS8KmPOgRzb+xXR0+ifRlHAqqYHzJCMGFFEw00ZwBfVaoEijNA==
X-Received: by 2002:a05:6402:381b:b0:456:d9f9:8f3a with SMTP id es27-20020a056402381b00b00456d9f98f3amr8801725edb.258.1668362989724;
        Sun, 13 Nov 2022 10:09:49 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-103-33.business.telecomitalia.it. [79.40.103.33])
        by smtp.gmail.com with ESMTPSA id n23-20020a170906701700b0078db18d7972sm3197502ejj.117.2022.11.13.10.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 10:09:49 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: imx: DRY cleanup of imx_obtain_fixed_clock_hw()
Date:   Sun, 13 Nov 2022 19:09:44 +0100
Message-Id: <20221113180945.1626061-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx_obtain_fixed_clock() and imx_obtain_fixed_clock_hw() functions
behave pretty similarly, DRY and call one from another.

No functional changes intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/clk/imx/clk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 5582f18dd632..573b1a6ca1dc 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -104,9 +104,7 @@ struct clk_hw *imx_obtain_fixed_clock_hw(
 {
 	struct clk *clk;
 
-	clk = imx_obtain_fixed_clock_from_dt(name);
-	if (IS_ERR(clk))
-		clk = imx_clk_fixed(name, rate);
+	clk = imx_obtain_fixed_clock(name, rate);
 	return __clk_get_hw(clk);
 }
 
-- 
2.32.0

