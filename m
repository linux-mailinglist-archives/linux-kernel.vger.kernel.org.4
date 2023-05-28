Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C0713744
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 02:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjE1AKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 20:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjE1AKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 20:10:45 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FCDDF;
        Sat, 27 May 2023 17:10:44 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f6c6020cfbso10985771cf.2;
        Sat, 27 May 2023 17:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685232643; x=1687824643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnTseOZCoY+CK3HtI+8c2hP/MGTha5onAmFTzOp40tU=;
        b=qPT9E0edttTYNdnHFlE81rQuGTNJhwsmQPQnZ7ROVuMiV/mXzz0iptAla7rW9vcOPC
         4khy8mjXOeVCDVA41H7wzd/gCbAZe5lcCQOACSrmQDJ3ex5xM0B9VJr4G1435wCxYumn
         M7SNZd6GNh+xbi5T9vSzsYYVaquE1Nb5vIcDtSluj+2XxulMuh6x5B6OIbpG3MkzVSPH
         s0sJ+jQ3i9TWVPchZBc2JZB08rBUuMAA4moBEEcK70yzfhmBgbHKpvz6bzJbMvuzMMv4
         w9EMpjGyJBJsgGYy0ESYpzD5+PoqeRiDWpAB4HGbeZGwzahT6Of86nwJzjsJ3o4V/RBs
         yW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685232643; x=1687824643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnTseOZCoY+CK3HtI+8c2hP/MGTha5onAmFTzOp40tU=;
        b=WmY1khPCpJ3DueKy4Q+1qkZ1mTdVBjBO8dgagaSnJ0hRsLJrto7JSdhomtA/k0sEG9
         atERVuD6HBAuBh8+34f595eDf41I/+N58cYN6EQiuXqhPYYh2HT2jaOf2kq/0gMcGZy4
         wER9Ewv8GEJoNIGb44t+ASKOb8eQZD5vKjMF5bRAF7owgSuVLA05ywlwMAUZkl6v+SzA
         SdUz6F9nf5JfucU5Sai6xqyvACvxXut0URD5e5ufHVWOLWXlOpvrJcZLyfSLnvPQhZnE
         RTik4Ai9klsAsOxyuulMSgfYLE/5N2txNkJFcwvyZ2gE8mtrXp2Jmnjz8GYiDdTchZVx
         HsEg==
X-Gm-Message-State: AC+VfDyn8bcoT4pXjVryrI9dGqwgwzEmeyXSrKPkp1H41DmGA6rqfp/K
        X50ItdNeQv+w7quB+pevw/Q=
X-Google-Smtp-Source: ACHHUZ7Z5un5mSANVyiGI2lseOWl6HLDVeQL+/2M1exfjLawjBv+HeCw1oypNDyiaSBwSNJRPhrrXA==
X-Received: by 2002:ac8:5f06:0:b0:3f5:1d57:9c22 with SMTP id x6-20020ac85f06000000b003f51d579c22mr6537934qta.51.1685232643224;
        Sat, 27 May 2023 17:10:43 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:28b2:2867:6311:b7d0])
        by smtp.gmail.com with ESMTPSA id t18-20020ac865d2000000b003f6a7ab1450sm2518454qto.30.2023.05.27.17.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 17:10:42 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rudraksha Gupta <guptarud@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: arm: qcom: Add Samsung Galaxy Express
Date:   Sat, 27 May 2023 20:10:06 -0400
Message-Id: <20230528001010.47868-2-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230527040905.stmnoshkdqgiaex6@ripper>
References: <20230527040905.stmnoshkdqgiaex6@ripper>
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

Add a compatible for Samsung Galaxy Express SGH-I437.

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d9dd25695c3d..133d69b2b73d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -191,6 +191,7 @@ properties:
       - items:
           - enum:
               - qcom,msm8960-cdp
+              - samsung,expressatt
           - const: qcom,msm8960
 
       - items:
-- 
2.34.1

