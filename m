Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C70744D46
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGBKbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 06:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGBKbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 06:31:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A751135;
        Sun,  2 Jul 2023 03:31:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d58b3efbso3821591f8f.0;
        Sun, 02 Jul 2023 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688293906; x=1690885906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9HNwsfm1QcsCZ6i0OtSLp++3UaVesUVHugZWgXamS4=;
        b=XIxUYIDaYrAcbCaZjAOJQA6qry3INr7EmhUAmmfwz7ZGkmJXBwZ389ldYtx44Fxt9E
         2CsHd48uhVy09DoBYa3O0J7jURA7Q9V0BindDZkXmr9VDg8Yawltw8Ks89Q69MIx7AO2
         t4sQsgFCAd+iUrPCyKy8ZOpwqw/JQ78AZ/+RMC88gCrkSL58CaGHgeRgORFGnjuLmYms
         g3Znk8LwmFb8aJTd5kOU2IwmB8EnWAtTsL0EVPclr0MkQEjtZWT3pKZnVNPlbM2Vskap
         qOFYX0QlMOVct8XAl+bjkUlJ09FCa7Z17yXTyFTTigR7JUVqRLpme8hjkEYMO7tiHqFg
         l4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688293906; x=1690885906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9HNwsfm1QcsCZ6i0OtSLp++3UaVesUVHugZWgXamS4=;
        b=U+f4Eu0syy2ofjUeZkAdckUDztc8fEs/opr1HBcGI89S55p1rtxQ5oKPVYNmumYo21
         bmdg2PhAbUo3yxbIougtWTtYxui6n8Bx2KEc0RS5qKOHLAqMufihegzt6v0Ct2OFY2Yz
         9woRp0D877biA0P+aGj3sk808XE9wUUYoekEpjLfsGR5tc8O1sDE5rBHfuorOtrvprhd
         ArPmr+Udz26pZofj6fLDnAdp6eYva6LHKAXA2h3KeYhMXppXtZ/iWPnv6EIRg/7eCC8y
         7x9Lokz6IBxCsgxS97bbNKVQD8VZZaArxF3jnVspdNW6BRcOanAIhGEFDF+aDE64m+44
         wV/g==
X-Gm-Message-State: ABy/qLZaVzYdY0sDV9zt11Txs+1DPsa6JEdfvniMoqmLCT30HU33eKgn
        S3G0hjQa3l+q682ILaTOjBQ=
X-Google-Smtp-Source: APBJJlFdbrMVw4b6z234EX++g7sa7brYPo9YLyT5rx35Vbecfts+aFRsmuqCwHuvCLX2q+adLIcNtg==
X-Received: by 2002:adf:e80f:0:b0:313:e20c:b8e8 with SMTP id o15-20020adfe80f000000b00313e20cb8e8mr5448993wrm.30.1688293905642;
        Sun, 02 Jul 2023 03:31:45 -0700 (PDT)
Received: from localhost ([2a01:e0a:32f:1f0:ae0b:3bc8:c743:b2d8])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003fbc2c0addbsm7265041wmg.42.2023.07.02.03.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 03:31:45 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: st: add buswidth property to stm32f429-disco
Date:   Sun,  2 Jul 2023 12:35:16 +0200
Message-ID: <20230702103516.139440-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.41.0
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

The ili9341 is left without a mandatory buswidth to properly communicate
between the SI bus and the display. Add the device-tree property.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 arch/arm/boot/dts/stm32f429-disco.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
index 3b81228d46a2..5eaf95afc8c7 100644
--- a/arch/arm/boot/dts/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -197,6 +197,7 @@ display: display@1{
 		spi-3wire;
 		spi-max-frequency = <10000000>;
 		dc-gpios = <&gpiod 13 0>;
+		buswidth = <8>;
 		port {
 			panel_in_rgb: endpoint {
 			remote-endpoint = <&ltdc_out_rgb>;
-- 
2.41.0

