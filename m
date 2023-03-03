Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906E66A8E1C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCCAbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjCCAa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:58 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B010C5A6CD;
        Thu,  2 Mar 2023 16:30:35 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id y14so768930ljq.4;
        Thu, 02 Mar 2023 16:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmRNMe9uQhPx18OwaQPWYRc4n9FcMIRAAH4hf6qcyN4=;
        b=oAGe7w29PqXPTErtDfdmaNPd5MQYHB5PStglfY7ComjSs8N2hG7wq+5+z93xjdYJtt
         WWygJV4BFoBiUAq+HFJ0Qqq9gl0DJGOnd9ea1Ph8HrH80ejJQgI8O9RjymnIi38QjT6M
         my1+di7Z3Om8gzm+1KcoyFN37yaJiXWw/u7UYqKEeMoJTdKorBMCgY/ovUaQqLsDOnhN
         tVIs5IgFs8KnbBTYp7HdXymvTgct5dINk8X7WYxfIMZn4OzIMYBpVGzBJUeFKMOUd4NC
         urR/AbilVc54S3bZv7bj9KCR52IbYv5eoJuvBynmCsJ9nEGjppTBYUBxenBsmOXJ94Qc
         ljzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmRNMe9uQhPx18OwaQPWYRc4n9FcMIRAAH4hf6qcyN4=;
        b=AuaCybKtWmBLbuKYj7Ky52VLg2CxE6YPPEHjynRaAWgzh+Mc3Ij/L1yHkP/9Jy55Zg
         RWGcDKaPweYPTzy7nwTUjIQEEKVsl7hX/IhQRZ4Opp6PZme6NRt+FeBfXiuXRbwjEc3R
         ncAB45Bn7Jjcrk6GEMVh7T5CNvxJao2dzq2pzj6IqftlDjA/jojcCg71QZBpvkU+zGYr
         jhX3MMDgpjEAd+E8ynYqKKlfMqkU1E+3mRC6i184UShjMNMU0NClc+3eiGasUnuYBfpb
         Fs2c4KbI3utz/x2Dcwpx2Kx5ejqW480H2DDkVk3wUkU9GYriNl7GjYIYadmYZfpBpDDk
         caRA==
X-Gm-Message-State: AO0yUKUptzX1Y2lFaKLHkPNhBzFIpyGQapY1eFmnqYlKP3vaAI9eDgMP
        0ljR5QnWaIKASH1OUODxh+c=
X-Google-Smtp-Source: AK7set+q/isAOSFwsejBQ3iOOjFHAocAnLxyNF7IOw4sMbmZaOlhR0EGbJWoBis7w9Yb5i12wwb8mA==
X-Received: by 2002:a05:651c:b24:b0:295:d633:7401 with SMTP id b36-20020a05651c0b2400b00295d6337401mr3149851ljr.47.1677803435256;
        Thu, 02 Mar 2023 16:30:35 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:34 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
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
Subject: [PATCH 17/20] dt-bindings: pinctrl: mediatek: mt7986: fix patternProperties regex
Date:   Fri,  3 Mar 2023 03:28:46 +0300
Message-Id: <20230303002850.51858-18-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303002850.51858-1-arinc.unal@arinc9.com>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
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

Set second level patternProperties to '^.*mux.*$' and '^.*conf.*$' on
mediatek,mt7986-pinctrl.yaml.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
index 46b7228920ed..e937881210c5 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7986-pinctrl.yaml
@@ -72,7 +72,7 @@ patternProperties:
     additionalProperties: false
 
     patternProperties:
-      '.*mux.*':
+      '^.*mux.*$':
         type: object
         additionalProperties: false
         description: |
@@ -256,7 +256,7 @@ patternProperties:
                   items:
                     enum: [wf_2g, wf_5g, wf_dbdc]
                   maxItems: 3
-      '.*conf.*':
+      '^.*conf.*$':
         type: object
         additionalProperties: false
         description:
-- 
2.37.2

