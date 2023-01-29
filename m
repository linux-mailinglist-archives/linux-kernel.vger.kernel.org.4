Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D609567FF89
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjA2OcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjA2Ob6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:31:58 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D836A5DF;
        Sun, 29 Jan 2023 06:31:57 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mf7so6509962ejc.6;
        Sun, 29 Jan 2023 06:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqhRzedXTjAYBhupeTXHmy5HkP7oFM6wXur1/uCGklY=;
        b=bMAnX4NH2gBVWNMBfP5T8Ig0AvaeOIcfVbfjU9ga7Yfd7svUSS0vKBh8RC6QF70zWc
         pk8+ktReuJWrI1K8aSy2tHuXIujU0RCm6gYbpL6tO7UlmXKrMQ9ocgrGYtFjWC7rKXoK
         0n3MdHHfPH+TRwyO0RE3K4dOkI7At7MnSUZlt5QbTznbJ6HcjAr2rcYDcvuB3VB39DzF
         gApmu09u5PWt0XdEoKam87WxQdMlxLPDoJnZbyWapFMxEQxstqLK7e5z9sKxMwyGoYDd
         xXFdYIOXFK3wvxHqrACp5LKicZ0ye/amSkf2Pnzi7uyYgaitH+cECyZ9MGJByU/pvZnw
         /I9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqhRzedXTjAYBhupeTXHmy5HkP7oFM6wXur1/uCGklY=;
        b=EYA3+m0ipTbolftWRTMFTsOThYoN7krqndvBtvWvjbn28wfeBQtrLhQ1Wf9IYiGOXH
         Rf3ep0+CPIdzEHpY8mgt+AXdnhubTF5IMG5V8iKmnwAIdTxfrOruZcHyKPzVQEERRccQ
         nJNbLx43xMphPCaLfO1ltcypk37b6o4WwD4j+qDo0ZM3cGTwd2s4ctkY5T/IKgPwbpLM
         Vak53aWCs9L8fGj0NTGAohmHUlxv7Z+zmjCaEIEkzO4aSXeLWqLXDmOCSi1GjkTbnH0l
         zSZg+n/Avg9INhsfFTYgZRJ2TyeRESlhmihBlSzWYaAbgrQuSP3AKLMfZT7UKSBqAdOe
         gOmw==
X-Gm-Message-State: AO0yUKU8fRY9pGLWlm9lWljG8aSpnleSDMIXeZn8PrLomATKftdun7Sr
        YZN75rdLdJbddHp7ANi5Zhw=
X-Google-Smtp-Source: AK7set9uBH1IEdS5caA0NsadN0JraxcoEyiaqZTtiJt25gcTfJD2f4f+/jMxjc2QNlzyRT4puPTrhg==
X-Received: by 2002:a17:906:eb8b:b0:878:7f6e:38a7 with SMTP id mh11-20020a170906eb8b00b008787f6e38a7mr12114060ejb.44.1675002715769;
        Sun, 29 Jan 2023 06:31:55 -0800 (PST)
Received: from localhost.localdomain (83.6.123.74.ipv4.supernova.orange.pl. [83.6.123.74])
        by smtp.gmail.com with ESMTPSA id jr23-20020a170906515700b0086f4b8f9e42sm5410128ejc.65.2023.01.29.06.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:31:55 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: display: panel: sitronix,st7701: Add another panel
Date:   Sun, 29 Jan 2023 15:31:39 +0100
Message-Id: <20230129143141.173413-2-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129143141.173413-1-maccraft123mc@gmail.com>
References: <20230129143141.173413-1-maccraft123mc@gmail.com>
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

Add compatible for 854x480 Elida KD50T048A panel, found in Odroid Go Super and Odroid Go Ultra

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 .../devicetree/bindings/display/panel/sitronix,st7701.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
index 34d5e20c6cb3..dbc92c4e26ed 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -29,6 +29,7 @@ properties:
       - enum:
           - densitron,dmt028vghmcmi-1a
           - techstar,ts8550b
+          - elida,kd50t048a
       - const: sitronix,st7701
 
   reg:
-- 
2.39.1

