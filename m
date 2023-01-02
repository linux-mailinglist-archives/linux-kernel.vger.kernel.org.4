Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D281C65AE0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjABIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjABIVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:21:09 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CFE112A;
        Mon,  2 Jan 2023 00:20:50 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so25041224pjb.0;
        Mon, 02 Jan 2023 00:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=is3qNJJQlv75VO8zVD9j6Fa5IiqfTR1o+COwoVHzUoQ=;
        b=o/zfZCVJ3Ojd061xw+HJ9QBQxsYFmWaXST1juNnvNLMS5HCJpsAIXBLab1XYurg5kd
         q6B9JhWFpu+TPmt+Oc+AZbBCwHjoMX+0B3xqrhSUD/Lx5RB6+xQBDvLjJRwnb5+1on5l
         f0ZCH6wn2E/1BpDCOOEeSYaX68efUzh/eBaGf+yuBO8tpzpwffWYKiLsjqfHnu8geYfE
         fJea3SOt1KbWgaozcMC40biMwVw8cdtEYHPJmE+qi4FLwBuJUQAbYjjTSkTZCh7qdvTt
         Nuf9VNhpSpx3PnydlSfmDTb0UsWB9y6ezgaA6I2f5AjL8EY/suXPHvUKKIB4TnvVvFGT
         BPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=is3qNJJQlv75VO8zVD9j6Fa5IiqfTR1o+COwoVHzUoQ=;
        b=v/A9VjsN0h3MGmOmxQqXUAyPiuiIdalQXwZU31jZGtuiuPVCs45HnvCquPOCJKmjKU
         wg9oPp+K9KnEeOD/mU7uZ8snBp9R/fU8Sz1MgCrgPX1Z+dcUA+6G9CYB2MEaIvKHC3kv
         36pGfko/3ZRUAm42xF69xX9Lom7Qsvzlp1n3meNAz7oGLuOoiP3JiSOKjsMopLi43Yp1
         KhOoa082geRSFXERkcamMBuM1aAyXAQ2aVGO5n8+LMsHuHQwKwkXrxfWRdy8+oJvnEPL
         kbKUPQTybghwy6GUFWtMxCRr/8Ly3+RrXJN0YNSle3EiBgOmT/MHHhxIzLTVRdl2VTv9
         ndug==
X-Gm-Message-State: AFqh2koKd1cTZ0rC/LSJHKgO3Qdd7MQKA9iS/AFgnLzlRBd99WpaocgZ
        bUk28PQ8VWtamRv+g0qKd8s=
X-Google-Smtp-Source: AMrXdXuTioJjSG5nKrVVsW0p7wwLx3TEBU+DqZCZuboHY3rE+2uQPc2KMU1lxShJ8Bv2Rb5qin36SA==
X-Received: by 2002:a17:90a:e516:b0:225:a520:e0a2 with SMTP id t22-20020a17090ae51600b00225a520e0a2mr41049329pjy.21.1672647649778;
        Mon, 02 Jan 2023 00:20:49 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id mq18-20020a17090b381200b001df264610c4sm23491898pjb.0.2023.01.02.00.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 00:20:49 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Yash Shah <yash.shah@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] gpio: sifive: Fix refcount leak in sifive_gpio_probe
Date:   Mon,  2 Jan 2023 12:20:39 +0400
Message-Id: <20230102082039.3941790-1-linmq006@gmail.com>
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

Fixes: 96868dce644d ("gpio/sifive: Add GPIO driver for SiFive SoCs")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpio/gpio-sifive.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index 238f3210970c..bc5660f61c57 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -215,6 +215,7 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 	parent = irq_find_host(irq_parent);
+	of_node_put(irq_parent);
 	if (!parent) {
 		dev_err(dev, "no IRQ parent domain\n");
 		return -ENODEV;
-- 
2.25.1

