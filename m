Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40117734B04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjFSEKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjFSEJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:09:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEA21BB;
        Sun, 18 Jun 2023 21:09:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f8c65020dfso32383915e9.2;
        Sun, 18 Jun 2023 21:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687147796; x=1689739796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENURxkCD4SFoaP6aebwo/q0vo0bcMItJOR8Kmmrb9B8=;
        b=Xfbxjls8wm85QQ3/r8rf8RzliMqjlRA64shuv5fwEdcS0R1dw60mIHbIM2NTR6hf4H
         rvc6fjMn1YXgyzA8im2503IKtib9FcbdI9EQ/mvejrBOj3+tW+pp3fQxwoOkjR3Nk49c
         3BNIw1PTs1MNM9w4YllPirKmvW97/MU9bBmoV9XIPfIL1lWedIjGz2brM0DQJRrEaBnB
         pFwLBPrrk8iPMi8xrr4iO4t+1SVI2B4r5zQo3ZmabWLH3QbjoXTthbEiJ718jr8WlpoO
         7ntT8lPyNhs3jgCVQ8W7C2ze8C5bMmS4pjvJ8HTauEnFWcdCk53nFukqZD3WsHwx/29J
         C5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687147796; x=1689739796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENURxkCD4SFoaP6aebwo/q0vo0bcMItJOR8Kmmrb9B8=;
        b=K3DSgFW3o+8rnxGRWHA4Omr6pDMBL92V2G5mHy8MqD9cKIzcOiDXLJyltrFB35ASme
         J8QK7xtQ2nYucnYzNrwDDcgeXGDmCA491CP2h+D7LL4KToJC444ByX8pscJ1ufW+sC7X
         smF9H1Hg98/1gWKDkfqeWjD9vICXG6n9CreydjLRV+nUHXMvTabbpVQUJrSGNaOJyqS7
         4lT8dD97nSJUsGedTc8ZEhv2T8t7J9Qo+vz7uv2X5CJZpVN6HimfBkGFyJ7IrZrVaBWN
         vJ5MTgGauSI1F9SKb0HrsZT52XzoP7sQj4iUEqZqO1hjWMvKX46IueA4yBftfPhwJGs1
         mKEw==
X-Gm-Message-State: AC+VfDw/HVjLBml44xQONSC8wRctd32d+05e+p/wUS+8E2oZjJKuYNfw
        xTQh+hMSpgQQklzc7JB7lHB+wkl+v34=
X-Google-Smtp-Source: ACHHUZ7gOc0JMkTkxFKrUAnzeYdEINTe3b1GEWmx2vMfJVJYE2iAirsYUch8KPmf4/weRwqWMfklYQ==
X-Received: by 2002:adf:fc4e:0:b0:30f:cf52:9194 with SMTP id e14-20020adffc4e000000b0030fcf529194mr6901172wrs.58.1687147796184;
        Sun, 18 Jun 2023 21:09:56 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d6e0e000000b003078354f774sm30004052wrz.36.2023.06.18.21.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 21:09:55 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com, yangshiji66@outlook.com
Subject: [PATCH v5 9/9] MAINTAINERS: add Mediatek MTMIPS Clock maintainer
Date:   Mon, 19 Jun 2023 06:09:41 +0200
Message-Id: <20230619040941.1340372-10-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
References: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding myself as maintainer for Mediatek MTMIPS clock driver.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..581234dfa735 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13137,6 +13137,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
 F:	drivers/phy/ralink/phy-mt7621-pci.c
 
+MEDIATEK MTMIPS CLOCK DRIVER
+M:	Sergio Paracuellos <sergio.paracuellos@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/mediatek,mtmips-sysc.yaml
+F:	drivers/clk/ralink/clk-mtmips.c
+
 MEDIATEK NAND CONTROLLER DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.25.1

