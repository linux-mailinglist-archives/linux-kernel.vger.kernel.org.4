Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DCA709FA4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 21:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjESTHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 15:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjESTG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 15:06:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A97E1701;
        Fri, 19 May 2023 12:06:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-969f90d71d4so557660566b.3;
        Fri, 19 May 2023 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684523195; x=1687115195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sHXSbIKdfshz1V6foSnWEWxmThmgfpmjEr9QV7k1Bc=;
        b=Ft/HR3zNwgMLErc6912kyk65SQscjqq8Y2yWukqUVjdEPZ8KGZWoABpqXLH0oqacIP
         UIqFh426YuUT76J8ZFtjTclHnt+yiWf1W6Gi6JVlAd2DDk0sqHfeHNNhc2lNZKfrY6oh
         3niCkdC9KiUQ29sTIc4DukXdU18mXkDjpuNfoezs5F/DDnaTmjMHoddoaFeI3p7tubMg
         FcRiAxA/td5iz2yw2cv/YyWOqNFvpopGOsgTd1vkv1jCV6uGrGN4sLDAydYJgI/wFF3m
         hi2hb56k39sIa2mDhE2sIuJxLOaMOViM1I+L+Lqbj2oW+Mk4ehPm4mtfxzRskKC5xG5S
         LASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523195; x=1687115195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sHXSbIKdfshz1V6foSnWEWxmThmgfpmjEr9QV7k1Bc=;
        b=iZASbRcBBHuUojz1X+11oVB7uHMx7qeeecHQUEla2NZFnDv/iDV/rI8FCjCnOU8hlm
         MyGtiA1zb/GHHFMC1o4Is/QnwNrvFgkG1Az2qiE1bL1acabQoWsgoGOJMEILwQTldR0P
         Ce4bCzTRAyq76+mcVx3sfDFLv3Rw20N9k3eyydcxPcac7tDbN/jh5UWT1U7vVdwOrP0k
         XvvcqVFp3NDj9eOOHaO54e0LqZM92K/1fDaw/cJy/dqwnxDeaLDNLZ3Gbz+wgqEdGcB9
         FneYAY5YE0w5FSG5XoOSMybiB25heqwWJPWnnOQVSpiF31RMV8+A/OwpzfrTDPEOzVyq
         Xoog==
X-Gm-Message-State: AC+VfDyUuFUrH9NRyPuY+kW+EgAercWZm5KHt/HGSCJg8YjS0jIQSyzq
        ETHEenundaYFakwSHhRXTuE=
X-Google-Smtp-Source: ACHHUZ5jUZdQLQ6WiM0xcsH+UQoF75HnX/irh5/vWgMg93AEobv/xDrUcyksVqXXqfD3/adHK8NioQ==
X-Received: by 2002:a17:907:a4b:b0:96f:4ee4:10d4 with SMTP id be11-20020a1709070a4b00b0096f4ee410d4mr2440529ejc.43.1684523195500;
        Fri, 19 May 2023 12:06:35 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090609a100b0094f1b8901e1sm2624244eje.68.2023.05.19.12.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:06:35 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 3/3] ARM: dts: s5pv210: Fix typo in comments, fix pinctrl header
Date:   Fri, 19 May 2023 21:06:25 +0200
Message-Id: <20230519190625.7844-4-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519190625.7844-1-aweber.kernel@gmail.com>
References: <20230519190625.7844-1-aweber.kernel@gmail.com>
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

Change 'specfic' to 'specific' and make the pinctrl DTSI header
more like the s3c64xx pinctrl DTSI (previously it was copied from
the main s5pv210 DTSI, and not changed to match the new contents).

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi | 12 ++++--------
 arch/arm/boot/dts/s5pv210.dtsi         |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index ae0b4a423746..af740abd9e0f 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -1,19 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Samsung's S5PV210 SoC device tree source
+ * Samsung's S5PV210 SoC device tree source - pin control-related
+ * definitions
  *
  * Copyright (c) 2013-2014 Samsung Electronics, Co. Ltd.
  *
  * Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
  * Tomasz Figa <t.figa@samsung.com>
  *
- * Samsung's S5PV210 SoC device nodes are listed in this file. S5PV210
- * based board files can include this file and provide values for board specfic
- * bindings.
- *
- * Note: This file does not include device nodes for all the controllers in
- * S5PV210 SoC. As device tree coverage for S5PV210 increases, additional
- * nodes can be added to this file.
+ * Samsung's S5PV210 SoC pin banks, pin-mux and pin-config options are
+ * listed as device tree nodes in this file.
  */
 
 #include "s5pv210-pinctrl.h"
diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index faa3682ab5dd..f7de5b5f2f38 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -8,7 +8,7 @@
  * Tomasz Figa <t.figa@samsung.com>
  *
  * Samsung's S5PV210 SoC device nodes are listed in this file. S5PV210
- * based board files can include this file and provide values for board specfic
+ * based board files can include this file and provide values for board specific
  * bindings.
  *
  * Note: This file does not include device nodes for all the controllers in
-- 
2.40.1

