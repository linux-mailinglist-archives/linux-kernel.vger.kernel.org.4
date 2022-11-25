Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C0F638636
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKYJ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiKYJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:28:29 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA12E13DDF;
        Fri, 25 Nov 2022 01:28:24 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id w79so3673991pfc.2;
        Fri, 25 Nov 2022 01:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn2sizkMrneWFfSzYUQB5soJBl7mIdJiiFc0egNz5Zs=;
        b=QsTVAa7JRtaXuFowmwy5i2eav7QNbidAg4ZI2AN96P8LbSM4r2EfZXICcTcTxDck4k
         I/hJyMUfenMhrqYcQPe7meZL4ofu5fiQi2uKLEByWzGapBX2qmKAAns1gFdKtT50EhCo
         Wh9jyVqg2pCPgLWMIJUbVLIHqrS9byxmd70vGoPmJMfqFRcgx9JbmCc4gqGEMSYnOx2s
         HwynLvXlDqZMwQ28co+B7rA7cdAz034cs7o+bNsSUG1p9sBBYEslvTh/XgC/1KhDDj1m
         Ly/ZaLGi68XMNvutGcYYPN1xJaIZgdCq67soSvO7yTr46HYdCaler8fmYqrEEl0cOdmb
         6oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn2sizkMrneWFfSzYUQB5soJBl7mIdJiiFc0egNz5Zs=;
        b=zPz84kR1TfHRJaQ50q18WJ5okueOsmofTVi96C6c1V0y2cwdI/++3f3CYuH5XwvKMt
         a9sNojXDJ3yKlONWp2EsD45FbwniHUlLiWfjT1Hc8PGCO0At48kqlS+/gIQ2BEtc3giV
         tccew0x93wkXPFjA93tDu45tqXDIsPlWDaol/hI6+LKkBMLeduCiqGiZpl/k+VSzTOQi
         PSMm9ejhIdNfR+2PrRnlJVr+7Aj5+FOLyOY4jdUtiXCkl63HI/Fhxb5jZsaLRqd/1pNx
         TBB3BNHUz8yGnlBT5xI3uiz8DG+Rldwk2vfsleVY6veN6mfg0DwAmnxGoyvL2Vf4EohH
         22Lg==
X-Gm-Message-State: ANoB5plr1qsrFuUnKC4cNCaFeSz2EvLNtkjZQpjhEMhKxk3Kr6Foep41
        Wr48lpwZw9UdWCYELWko8cTC8kyyRLg=
X-Google-Smtp-Source: AA0mqf50XZZ/soTHPNQbIvNJjXewcisXyQHI/CqiFiR3XoL8yz75ToMOhowDWc1u8gJaj5AMsJ+EbQ==
X-Received: by 2002:a63:194f:0:b0:477:7db6:6d96 with SMTP id 15-20020a63194f000000b004777db66d96mr15349353pgz.458.1669368503761;
        Fri, 25 Nov 2022 01:28:23 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d2-0afd-e841-8cc0-6431-915a.emome-ip6.hinet.net. [2001:b400:e2d2:afd:e841:8cc0:6431:915a])
        by smtp.gmail.com with ESMTPSA id f68-20020a623847000000b0056c702a370dsm2613526pfa.117.2022.11.25.01.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:28:22 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Gavin Lee <gavin.lee@ecs.corp-partner.google.com>,
        Bob Moragues <moragues@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Abner Yen <abner.yen@ecs.corp-partner.google.com>,
        Harvey <hunge@google.com>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Fri, 25 Nov 2022 17:28:13 +0800
Message-Id: <20221125172726.v2.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry in the device tree binding for sc7280-zombie.

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

(no changes since v1)

 Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1b5ac6b02bc5..46ec61e3dec3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -595,6 +595,16 @@ properties:
           - const: google,villager-sku512
           - const: qcom,sc7280
 
+      - description: Google Zombie (newest rev)
+        items:
+          - const: google,zombie
+          - const: qcom,sc7280
+
+      - description: Google Zombie with LTE (newest rev)
+        items:
+          - const: google,zombie-sku512
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.17.1

