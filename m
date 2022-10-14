Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC0B5FF3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiJNSf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiJNSfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:35:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85509A3ABA;
        Fri, 14 Oct 2022 11:35:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f11so8863244wrm.6;
        Fri, 14 Oct 2022 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJOMeXQc0Af23KUB04em2P8Wb6t/cXjCGBlz5qX5m2I=;
        b=Blx6n6pTCzYuF2uFy4alGGau4/NnYP0o4vNBhGXWQRNsNrieWBhNlU5sXvUlt36deY
         Up8KjVElZ9eJzp09elNQ7ohGy95b7beEFL6gq8JioodbGPmNNnOCtMFrOw2TaKWZ72tT
         H/1engiV+OY1rQ8QZkPRYgS//0kuDuEofrv1CGegAelLJpjADbY4HaTAW5Mz8Rird3X1
         Vqjr9eYKml6aC6FfmoIyiH4uC7zX4p0MKAh4CLZrj9vCTxA58QYUM7gfoy5blJe2AcBA
         6vX2JBjEYXjXWDmnW3NHkAzOAmNYa76E0ILDhJHY2sXQy5Nr342NhIISTi82YMv0Di33
         gajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJOMeXQc0Af23KUB04em2P8Wb6t/cXjCGBlz5qX5m2I=;
        b=NXNVpnFPXwD5XM4IN+Alm+70IdmAC216ULv0bR1G/dmiYOt1vVKsWtjh/Aeh78Mdqb
         SfVsRCSHvnwac1B5oBuMSZ21E7V8/Nr3p/WiHe/vytiemHgisqzM2NPoTF1TenTp2295
         /0apgnO7UY2vlr17o7W0WTeC6gqJSqTv+BDU0419bo/8It29BJ3+30asoT/xLqAkRuXH
         Rm+0xexiDK0W7RVndeCe7LXPHdhSxXRgTxf4cpX1stviZq8gsiJ4RFN2U+e2jWF37M6N
         jSVa989WNvaLpMY5STL7qW1UU394sUrXBHH45OGxdhiWubaBRe0ojNrnk3DJS/GwLh5R
         vBtA==
X-Gm-Message-State: ACrzQf0tm8v0LCGqU1lH0B6RNmcRg7SlC6hXdXc0cSCm4OFfTi/juABz
        K5XBCLHyEt3IVKxalQ/vTfQ=
X-Google-Smtp-Source: AMsMyM43W+6KucZ5pur5Y1vLY5wYeI4dvbIHXeyeR9lh5PeK8unsRnN2JgiYFN+dFo+cLtG1SorOog==
X-Received: by 2002:a5d:674f:0:b0:22e:3d59:cf0f with SMTP id l15-20020a5d674f000000b0022e3d59cf0fmr4267687wrw.304.1665772520556;
        Fri, 14 Oct 2022 11:35:20 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc4d:6548:d8bd:5bd])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a403954c3sm2485410wrt.42.2022.10.14.11.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 11:35:19 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Tu <shawnx.tu@intel.com>, Jacopo Mondi <jacopo@jmondi.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 3/5] media: i2c: ov5645: Drop empty comment
Date:   Fri, 14 Oct 2022 19:34:57 +0100
Message-Id: <20221014183459.181567-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Drop empty multiline comment.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* No change
---
 drivers/media/i2c/ov5645.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 1551690a94e0..a0b9d0c43b78 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -14,9 +14,6 @@
  *   https://www.mail-archive.com/linux-media%40vger.kernel.org/msg92671.html
  */
 
-/*
- */
-
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.25.1

