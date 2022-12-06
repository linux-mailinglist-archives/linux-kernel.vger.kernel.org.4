Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47859644A00
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiLFRLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiLFRLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:11:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C9F2FA79
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:11:14 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u12so23473026wrr.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isZl4Ib1GW4IZeJsKLQaicOT0yx6KllCfAA6o2HK4Yo=;
        b=dEPxQkXmaa3Wz4HA8Yfy4fjbqIBuD8Ml8aDTOT+KBrwUbxD+kTSbbJTMFiCypHQQy0
         EdWFSrsW0nLMoZS9mdzEuuPi3t0rCF2jSEWf661q7y6nP9OosPtcKIxPFfr2X2iiPdMZ
         isoMpp4rHtsiKXLJ7En2CQMGDu3H0HQlGE5as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isZl4Ib1GW4IZeJsKLQaicOT0yx6KllCfAA6o2HK4Yo=;
        b=AG5cPkRdsFLGtKe+bvyJL3nUAAwnAo2bkWZgH/aFhbylwyHnQGAwmka+9KBvgM9mFP
         dUaHq6sLDamp6budJF6bhfXdQm1KpuM4gC6NAEFnGbHdsq3P18wucXjlxlpWXOllaVWf
         fNSoVEyAqVCWgPYyP7UNKOPYMIfZPkRRzYjzJ7iEsiy8XX1i5fa1iqbOLZNRGQkMJQbz
         uRJAHQkAxCdQ/41Su6lcH5/rVRAnw+XWRhHFC8bH1SQIMJr7QcYHH8tIb+6nFJ13rh5N
         gicdhdAQby7sOoex+rtgoV/rW9McQw2AkOano4RpoUjB5uixbof08F4/hCu30rkus2J1
         pmYA==
X-Gm-Message-State: ANoB5pkZ43BkiGDC9Lb4M8y4CmREOi3AnT9O+NK6Rlg72vf2FtX5QJvd
        hyRlIQZB/Ptc9A8BWDCt93Lm0SkNmqAThTCw
X-Google-Smtp-Source: AA0mqf5HkhTdPQ7nLSvemacCYX845ggXLdSFFWJJy2A++pl3KnIlWOQwnMoPoDxTURKlIWKDNu6RrQ==
X-Received: by 2002:adf:d1ca:0:b0:242:fce:543b with SMTP id b10-20020adfd1ca000000b002420fce543bmr28536302wrd.244.1670346673302;
        Tue, 06 Dec 2022 09:11:13 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-82-54-95-136.retail.telecomitalia.it. [82.54.95.136])
        by smtp.gmail.com with ESMTPSA id k10-20020a056000004a00b002365730eae8sm17298534wrx.55.2022.12.06.09.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:11:13 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] ARM: imx5: add missing of_node_put()
Date:   Tue,  6 Dec 2022 18:10:49 +0100
Message-Id: <20221206171049.3316611-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221206171049.3316611-1-dario.binacchi@amarulasolutions.com>
References: <20221206171049.3316611-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In imx5_read_srev_reg(), of_find_compatible_node() returns a node pointer
with refcount incremented. Use of_node_put() on it when done.

Fixes: ee18a7154ee08 ("ARM: imx5: retrieve iim base from device tree")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/mach-imx/cpu-imx5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu-imx5.c b/arch/arm/mach-imx/cpu-imx5.c
index ad56263778f9..a67c89bf155d 100644
--- a/arch/arm/mach-imx/cpu-imx5.c
+++ b/arch/arm/mach-imx/cpu-imx5.c
@@ -28,6 +28,7 @@ static u32 imx5_read_srev_reg(const char *compat)
 
 	np = of_find_compatible_node(NULL, NULL, compat);
 	iim_base = of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!iim_base);
 
 	srev = readl(iim_base + IIM_SREV) & 0xff;
-- 
2.32.0

