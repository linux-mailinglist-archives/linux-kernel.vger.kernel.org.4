Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B6D65AE13
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjABIZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjABIZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:25:17 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C2B106;
        Mon,  2 Jan 2023 00:25:14 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n4so28973650plp.1;
        Mon, 02 Jan 2023 00:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=93nJ5Kz+BlIZ58Rw+CqZdrGFJhp2grdsPUR6i1eSHYg=;
        b=ELMrLaaNHYA60UyumkyNKPmpsHkbWZ1wp0uePUanFKJQMdmeuiPk8xrbSiw9Qv+LWD
         QpUGYakUN5IK62N8/Zugfgf2L61dVoVqkkp8ThHB8wAIqNZhArKbsOYJN5z0GRuzhLMv
         MUhhXPtAAppVWP9S9sfHMghKNjcNpXb0zsOV58owX6YhEkudX4UgXdB5EqS10aFMU55A
         EQFGS8qS7KDxfZY08122Bw6jNZ9mWxl4I8Yo+iTRFCdFuTVTHpZaoRTkzj8vg0ZN+9h/
         QyZ7Nc2/Ifub3QekUxhDpyY8OXWu2M/WM88M9z3pFwKMGp5pIfi6KcMX25Qc1CvEAEwN
         WjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=93nJ5Kz+BlIZ58Rw+CqZdrGFJhp2grdsPUR6i1eSHYg=;
        b=NFv7+Riv2cSmCMgf8G40VEx0juZE6BLSifCvwcpIgYCslVzlrKckyVkQg7VuNU/zBS
         hX1dWmvwmMfnpvZVoLHQNDEOAohnMdcBw52FkfLVd8nOrayUL8or0kdODJsm1u8fWGJS
         3tJO6kuhXb2ov90xJl7vq64TTLytpbtnLR7pS6A7hl0GMAb5WHCiA5frR20REicxuawS
         MxOhrWiw+80ApiNvM6d0dmj/+oH/vOARNzv4sriXg3kGVdwLO89GCYxGX86O68ovAeGj
         IBvWEUSlfmISg5D24atKmf8IjYEbu9hDDFhsKW0wUI/mISxd6R27H7EkKAS3MxOMuPQP
         CmBA==
X-Gm-Message-State: AFqh2kpF6jLtB178fhy6YfxB1zwwL5YTCqS/9ce1i4e1pFw5KF6w8nfg
        n8lpqFFcT3kH6BTv6FwOVXo=
X-Google-Smtp-Source: AMrXdXubgNR4C0fUl2MCMV1zJ50oUurN2jUlpFmeXREJ9xRDIHh0oonNJ3jsqTuPywljKSGeO8HlYA==
X-Received: by 2002:a17:90a:ebc6:b0:226:5900:f2f4 with SMTP id cf6-20020a17090aebc600b002265900f2f4mr8244054pjb.4.1672647913766;
        Mon, 02 Jan 2023 00:25:13 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id lr4-20020a17090b4b8400b001fde655225fsm11431028pjb.2.2023.01.02.00.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 00:25:13 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marek Vasut <marex@denx.de>, Miaoqian Lin <linmq006@gmail.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: stm32: Fix refcount leak in stm32_pctrl_get_irq_domain
Date:   Mon,  2 Jan 2023 12:24:56 +0400
Message-Id: <20230102082503.3944927-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_irq_find_parent() returns a node pointer with refcount incremented,
We should use of_node_put() on it when not needed anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: d86f4d71e42a ("pinctrl: stm32: check irq controller availability at probe")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 1cddca506ad7..cb33a23ab0c1 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1382,6 +1382,7 @@ static struct irq_domain *stm32_pctrl_get_irq_domain(struct platform_device *pde
 		return ERR_PTR(-ENXIO);
 
 	domain = irq_find_host(parent);
+	of_node_put(parent);
 	if (!domain)
 		/* domain not registered yet */
 		return ERR_PTR(-EPROBE_DEFER);
-- 
2.25.1

