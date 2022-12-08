Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1788D6474B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiLHQy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiLHQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:54:24 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EECA11F1F1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:54:14 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n21so5431644ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq1a9PrKropORiAw8IakgtWWUEsJvqErJ35MtODjIuE=;
        b=g7oFIWq2uaNa9TzrRToFOa1nuiEU+0zAVHfRvE1Paq4YDO+BoVxlJTZLcOmcn+AwYz
         b0seCYuha+E/Et1TET+zZS+b5INoXdkQDVXpocPaoN1uWDpcTB4JiOBcfsk/KhGpKbu7
         GfgOlMkzBBje1givOJy6pvxchP7uQfv3B2y8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xq1a9PrKropORiAw8IakgtWWUEsJvqErJ35MtODjIuE=;
        b=fo8u1jBgWk+4TFQYWth3h/e4y8LBcpG3oKrzmlD7HjrHwJsErOCWjsbmI4b1LPWedn
         WOC+w5GdXZTluXzk1OE3f3rfC1bWHZYm4mpdfF1ajBZ+Kt6nJwN8yMpqB39Hbml2esia
         5gexqYqcV6Fdr1iUEYVq0VljS4iAoAPPre4Y6pQoUv7XfOrn5nUZbiroBNK/V9esoUro
         YROfgVWhLhFelderKhz7uF/r3JcP1ecbkzQeTYf3r/+RBoAhMPb+EcZtBatymOqtBOTm
         QMv8zisIP58gUGy0RONHmhG0Mv7RLiny1jQMpRw93jtTxRNF2Nrmpu9eorxw3zPlqAst
         FG1A==
X-Gm-Message-State: ANoB5pklAm3TpKd6Ur7OgK37rN8ZO8d7E69wjI+JyDfA0mY3KysHJulY
        DxauYJVKfX/MtAy0Ug7T6OWMfXajfJ7jrTmS
X-Google-Smtp-Source: AA0mqf7Lfr2wJbQAwGxVFaYSDrTiPSdUjZs0yo/uiK2XmPND5K4Whtg+d5Bazq6KEEEFJzGeKiZLPQ==
X-Received: by 2002:a17:906:7243:b0:78d:f455:b609 with SMTP id n3-20020a170906724300b0078df455b609mr2372755ejk.73.1670518452632;
        Thu, 08 Dec 2022 08:54:12 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-95-136.retail.telecomitalia.it. [82.54.95.136])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906118b00b007be696512ecsm9780614eja.187.2022.12.08.08.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:54:12 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/1] ARM: imx: add missing of_node_put()
Date:   Thu,  8 Dec 2022 17:54:02 +0100
Message-Id: <20221208165404.1512014-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
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

The patch fixes the same problem on different platforms.

Changes in v2:
- Combine the 5 patches (one for each platform) into one patch as
  suggested by Arnd Bergmann.

Dario Binacchi (1):
  ARM: imx: add missing of_node_put()

 arch/arm/mach-imx/cpu-imx25.c | 1 +
 arch/arm/mach-imx/cpu-imx27.c | 1 +
 arch/arm/mach-imx/cpu-imx31.c | 1 +
 arch/arm/mach-imx/cpu-imx35.c | 1 +
 arch/arm/mach-imx/cpu-imx5.c  | 1 +
 5 files changed, 5 insertions(+)

-- 
2.32.0

