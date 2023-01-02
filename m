Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FE965AE19
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjABI2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjABI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:28:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1392186
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:28:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so27642257pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 00:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWYzTA7raDtUxD/VqUrbyJ284rX1lgj8dyWdOkvF1/E=;
        b=NYz9nZkWD8n7Y+KSMqiNTxN+6FhHH3GXtAGRsxrjjih7ndCEXFdM0rMvMEySOwDxA+
         xLqAKs8/8C+3uIu3WtNB+TCcHonmimcA2f/gaJAfiM/o+UQJqULcllRH2j5x6uzkHuE+
         zi9stt2ateVWUyHyovEc8o+r6aK+n9fO8Gtui/6sTy97uwfctvBGAeiySoOVgtzFrZ7r
         UXbZWKKKQc8nm/FjDKa3hwczLw3X6cthv3U1qN1VeNoRyVc4g7U7ivYqFWYec66nYCPm
         oqEmqO6U2QYkouRMyzxijwLYxDbjTxWITCxbmd3eE4kXcyeQEbDNR3K9TonsB4XLjABS
         k8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWYzTA7raDtUxD/VqUrbyJ284rX1lgj8dyWdOkvF1/E=;
        b=HGldbAa3dmOsEnsGtyJwEJYRtSLKqCKGdA3GcHKMC4rcGdrlWJA299H/Ln6JwpNx0x
         biNLeMRDSXOAJ5dNNXMBeX1PwveCuT80cfvybgiFjxvjD9upiPG6Hk9fyDXgG7AMFGI8
         LlMFIfln+q1TGgw6sbSDCV7/802Saejb3DayuimCZVpN/yCfc0/ic5VIfKha/JF4Fw/T
         HsjF7y93jy+N/Es7VGlqEfZGgvaxK4XV+4HMamvqGp1DuY1QB2DCgLyfbxP7ca9e4TFe
         Kuj10EhTlpaS8cF0peyCXxqkd9BMsuW/k4WH4oT1YLL4nPNXPNghuWh+0Il6skeT4EWz
         Y1ig==
X-Gm-Message-State: AFqh2kobRmKInL0t3Fy655KnZp7fDVw49SQMn5sL5H2anyXc3Gq9vDKD
        3xgq/Ba2vuddu/rSZOgRl5Y8O2sCyuxgAaSb
X-Google-Smtp-Source: AMrXdXuCvB4Q/rCA0blb/+/pytP9qgF48OIE+yOs+ZahyOcj0vAEeerV/ZscDpOywoT65AXgLJwZjg==
X-Received: by 2002:a05:6a20:13a6:b0:af:9c75:6699 with SMTP id w38-20020a056a2013a600b000af9c756699mr67051926pzh.1.1672648099525;
        Mon, 02 Jan 2023 00:28:19 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id q6-20020a655246000000b004468cb97c01sm16697724pgp.56.2023.01.02.00.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 00:28:18 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] irqchip/alpine-msi: Fix refcount leak in alpine_msix_init_domains
Date:   Mon,  2 Jan 2023 12:28:10 +0400
Message-Id: <20230102082811.3947760-1-linmq006@gmail.com>
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

Fixes: e6b78f2c3e14 ("irqchip: Add the Alpine MSIX interrupt controller")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irq-alpine-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 5ddb8e578ac6..fc1ef7de3797 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -199,6 +199,7 @@ static int alpine_msix_init_domains(struct alpine_msix_data *priv,
 	}
 
 	gic_domain = irq_find_host(gic_node);
+	of_node_put(gic_node);
 	if (!gic_domain) {
 		pr_err("Failed to find the GIC domain\n");
 		return -ENXIO;
-- 
2.25.1

