Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25E16072CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJUIsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJUIsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:48:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367BB141399
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:47:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1559840wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8M+2HNwl7XWGItcQCTiwBk4Uc5IZqpHpGl3TOzAlGns=;
        b=c6b8NGePdJZgI5zUn5CGAcV7JSaPVOUZ5eGZIO32zysb2gg4Gq2jYEA4/0zJAIq/xA
         caON2UGCcujNP4oVN/7GnoNUHxfLnjYiTUANOrfbRL32OvhjvV9Hz059fZbvMvnkAfe4
         pIUCjwBUyhGknBLtKXXK+UhsiwA3bBXkei0uw+y1x1n+8wex2FimMYlStj0HVgwf0qHP
         Y7h/DbhbmJtIJMbEHSrnEX82UnoRRvRQGpkycEcodeuCM7W8RGt/t2AsiZaUVckaBwKf
         pMjzNNjvALGEea705fgPe1uqEFAfYcPgWW9QqvNTEaPdqdZUHNCbvNiumPs00tsfma3j
         LuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8M+2HNwl7XWGItcQCTiwBk4Uc5IZqpHpGl3TOzAlGns=;
        b=u2QisjtNTJNDb+Fi7Jz3STP9cZNfAKy/7MWvPmKnaeDAGfUFfzKYVHs6fk2tfGl/RL
         KuIv/3L0CVTBfvsZ5eE1gxTrIpqaZtIaDM3fL8IdGgdyucDYJ0yDXVJL2bH9SARUDhLa
         /ktN1lxZlfKCaCRb0eDp48qr6xybXJ7hho/MeGKw4ic1lCB5NvVCDdT2FOl4RDEeQj0q
         z2vsC7kq9gxMG8C97SPBTm1QVglOGabejIxNiJYq6IrgzOqLTO431ks02PPxqh7M8Dm+
         Pw4Y/mJ0+R2yUmoMDQ9EfIM9E2V3+eM3wG+ZMt1nNOHGWvivGfWd4oddn1MfVYPMSDiN
         mUfA==
X-Gm-Message-State: ACrzQf3ffuPXReppY3SU4FhN3eFz/tsgbVkrZ1+4MPejSBSvYKgwVqTC
        MyjLWIE103Q1ptf6iXLSo1JVHg==
X-Google-Smtp-Source: AMsMyM4HSa3Zf2uqrt5mLvlsW1iSF834rjWiLDz0FCPhMsK555F9yMiVW5PDWzaMbU/lTMgeMLnvsg==
X-Received: by 2002:a1c:f20e:0:b0:3c2:5062:4017 with SMTP id s14-20020a1cf20e000000b003c250624017mr32194144wmc.175.1666342076033;
        Fri, 21 Oct 2022 01:47:56 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c0b4500b003c41144b3cfsm2040233wmr.20.2022.10.21.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:47:55 -0700 (PDT)
From:   bchihi@baylibre.com
To:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v2, 0/2] Fix broken SET/CLR mode of a certain number of pins for MediaTek MT8385 SoC
Date:   Fri, 21 Oct 2022 10:47:06 +0200
Message-Id: <20221021084708.1109986-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

On MT8365, the SET/CLR of the mode is broken and some pins won't set or clear the modes correctly.
To fix this issue, we add a specific callback mt8365_set_clr_mode() for this specific SoC.
This callback uses the main R/W register to read/update/write the modes instead of using the SET/CLR register.

This is the original patch series proposed by Fabien Parent <fparent@baylibre.com>.
"https://lore.kernel.org/linux-arm-kernel/20220530123425.689459-1-fparent@baylibre.com/"

Changelog:
Changes in v2 :
        - Rebase on top of 6.1.0-rc1-next-20221020
        - Delete MTK_PINCTRL_MODE_SET_CLR_BROKEN quirk
        - Add mt8365_set_clr_mode() callback

Changes in v1 :
        - "https://lore.kernel.org/linux-arm-kernel/20220530123425.689459-1-fparent@baylibre.com/"

Balsam CHIHI (2):
  pinctrl: mediatek: common: add mt8365_set_clr_mode() callback for
    broken SET/CLR modes
  pinctrl: mediatek: mt8365: use mt8365_set_clr_mode() callback

 drivers/pinctrl/mediatek/pinctrl-mt8365.c     | 18 ++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 15 +++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  8 +++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.34.1

