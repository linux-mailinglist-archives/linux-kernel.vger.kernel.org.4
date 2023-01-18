Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAB5671C98
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjARMwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjARMvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:51:50 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CC64E50C;
        Wed, 18 Jan 2023 04:13:27 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mp20so36146978ejc.7;
        Wed, 18 Jan 2023 04:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSiUjqeIhXTuZdT6eBiGLcbiQdlWY4D946T8IZEq1tM=;
        b=dKanFbSavWhQ2T04eS+23uXizOzrzix2u0Cn/8NyzbdwfmUOqEwbG0Mvvs/5qQAZYw
         E9SMCML7RNO6mwGoYvIku1ZYootIDWCeVdQy4IOV9nnp5z9QMjUlEcQnoSIKsIEx4BuJ
         ANNkfnb3q0U5o5qoR2AxxjfX55b1fjCrbA/clrv/NzXcYQ1K6icZHfFK3HCaDyb2Mzbl
         W4iwTVmvr1HjtdQwfFXUlIwRHQJI+A58LMkUrbvyzCXpWKppAklGEwHAp0xqR1jcZ+pZ
         OJGYYZxgSkoRYiN5wwame4F5h8Vyoad7PzXPCsFNSiUysNL3v82BgUkf8PgkyPZ+MqE8
         5OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zSiUjqeIhXTuZdT6eBiGLcbiQdlWY4D946T8IZEq1tM=;
        b=Wt82lhEoccIh4J4Tam9mIeJrwnBuhWghOLr1xb/8Asu7wJc00yveUtjis8WM1jY6AJ
         hOUOuewTZc0/sE5RBH0+1d2ZnR7UYFWcctwPK5/IRbFKkm3Tj/AuQj/HWKdlJjwyaaj5
         grZYOR6CMZbetteq+C49kizbpmlXFsXhwrhXgeUgNweA1BHALU3msdpRLo/sj1AROsj5
         emS70NVUOppdgc+m3k9MwyN/jXkFp93ysQYd/bOk950uyQ5zy116KrfEcANi4OAO/JFh
         uCClHZi3wBJVPV82bb/35UV8UJMKjkws1c2dnF432ABt1gjyy3NW7W7n950OOAwB4d40
         4tew==
X-Gm-Message-State: AFqh2kqAPmtd1AhQS2uVhVM2xX5dSELTAdQed2BXvoXJhyu6frJQ3d4A
        gVP6kdSwwNJF+PJe4aFp3os=
X-Google-Smtp-Source: AMrXdXuJB5h75c09Lnc02md4iwcnhiUM2jh4kDT+SpXEP089W+YmPnXFzPBoQG85j5oV/lLrbE//Iw==
X-Received: by 2002:a17:907:86a5:b0:870:d4f3:61b3 with SMTP id qa37-20020a17090786a500b00870d4f361b3mr8604731ejc.12.1674044005883;
        Wed, 18 Jan 2023 04:13:25 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r24-20020aa7da18000000b004704658abebsm14187212eds.54.2023.01.18.04.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 04:13:25 -0800 (PST)
Message-ID: <08de3f4b-e33f-95c8-3297-814ea107272a@gmail.com>
Date:   Wed, 18 Jan 2023 13:13:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/4] dt-bindings: gpio: rockchip,gpio-bank: add compatible
 string per SoC
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all Rockchip gpio nodes have the same compatible.
Replace all the compatibles in gpio nodes to be able to
give them a consistent ID independent from probe order or alias.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/gpio/rockchip,gpio-bank.yaml         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
index affd823c8..72fdfcc65 100644
--- a/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
+++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-bank.yaml
@@ -13,7 +13,22 @@ properties:
   compatible:
     enum:
       - rockchip,gpio-bank
+      - rockchip,px30-gpio-bank
+      - rockchip,rk3036-gpio-bank
+      - rockchip,rk3066a-gpio-bank
+      - rockchip,rk3128-gpio-bank
+      - rockchip,rk3188-gpio-bank
       - rockchip,rk3188-gpio-bank0
+      - rockchip,rk3228-gpio-bank
+      - rockchip,rk3288-gpio-bank
+      - rockchip,rk3328-gpio-bank
+      - rockchip,rk3308-gpio-bank
+      - rockchip,rk3368-gpio-bank
+      - rockchip,rk3399-gpio-bank
+      - rockchip,rk3568-gpio-bank
+      - rockchip,rk3588-gpio-bank
+      - rockchip,rv1108-gpio-bank
+      - rockchip,rv1126-gpio-bank

   reg:
     maxItems: 1
--
2.20.1

