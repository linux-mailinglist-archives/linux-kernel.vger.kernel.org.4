Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570FE69FB56
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjBVSlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBVSlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:41:02 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7067642BE1;
        Wed, 22 Feb 2023 10:40:34 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bo30so8192561wrb.0;
        Wed, 22 Feb 2023 10:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKQy0Roxug4kkR5po0rLyjUzaL22dO97ot74i0woU9E=;
        b=nNOOQ7DgV8lPHE+nfWbX3cWwCtl/7owyKvNHmLHcylpRUFHwaxcssFOmWZDMPuzzVz
         zCEmDKpncYSFJaprUGjsxDzUbPyLDYX1HmiY7tq+p/MUYd74vyCyrPLOGO1SdpZoLskP
         iZYGKS1EHhwjlmv7DTd3j7lYR2vI/493G3StlNrJnIBipXtY2ECt4nw7ZBvIXg32aJyI
         8LZBucpTIuuCVtFHfLE9uc5+Ak+hejscMtlw5IKhC7kgChN/mL5KyathBwmsqDCOWDi1
         N1wPqpM40IUXVKmT/k1UTXP5gvOkz/8CwnrA0jquzzO713stT75SYkR9Osr8pdLzMjcw
         K2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKQy0Roxug4kkR5po0rLyjUzaL22dO97ot74i0woU9E=;
        b=eWbCKbDJhEl11b1u3rySphnqI0SNEgkbSb+K940SaUtqicI/BiHS1d1akimJ9vY878
         rPdgNErkrYUk8gWVeCDK2IWyrkaVR56ehPdkpBVbPsUhGNaCLdiWWwG+/aEAD8kWDoL8
         d56cqrLmC5eSRTlcSDa+BBY/h8Zu6eIL68RMzMLkK8j1xHa2EJ4ME0ZFLnHHlWVpstmk
         g5ioUQr3qo1cyzREwimEbV2gQG1gsiXg7ewAxxYpdCmrtNqt768553jdPG0WDpzEvUsN
         g4d43Bq62+I0HunAGlQt1O5Gak8nbkdf3dxz2sk37oTa3YflRi3DOO1rTGYFyLVVkeIu
         8oMQ==
X-Gm-Message-State: AO0yUKV3L0nM9aKAAIo5btvIgrAepfXaKiscA/TROfIpR/vcjO0QnQ9D
        tqmNz9SriGj3dIqer3E441E=
X-Google-Smtp-Source: AK7set88JNw8RxRWRdD2IFAfAkRWDGKxya6LpvIZWMWrlzdQGVzUwktZKapYh/fpkyfou4aD51W42A==
X-Received: by 2002:a5d:6090:0:b0:2c5:9990:288e with SMTP id w16-20020a5d6090000000b002c59990288emr7671369wrt.18.1677091231890;
        Wed, 22 Feb 2023 10:40:31 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4112000000b002c56179d39esm9372845wrp.44.2023.02.22.10.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 10:40:31 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [RFC PATCH 12/16] dt-bindings: pinctrl: mediatek: mt6795: rename to mediatek,mt6795-pinctrl
Date:   Wed, 22 Feb 2023 21:39:28 +0300
Message-Id: <20230222183932.33267-13-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230222183932.33267-1-arinc.unal@arinc9.com>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Rename mediatek,pinctrl-mt6795.yaml to mediatek,mt6795-pinctrl.yaml to be
on par with the compatible string and other mediatek dt-binding schemas.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 ...ediatek,pinctrl-mt6795.yaml => mediatek,mt6795-pinctrl.yaml} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/pinctrl/{mediatek,pinctrl-mt6795.yaml => mediatek,mt6795-pinctrl.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
rename to Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
index 9399e0215526..c5131f053b61 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6795-pinctrl.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/mediatek,pinctrl-mt6795.yaml#
+$id: http://devicetree.org/schemas/pinctrl/mediatek,mt6795-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Mediatek MT6795 Pin Controller
-- 
2.37.2

