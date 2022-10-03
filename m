Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EFE5F35F4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJCSzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJCSz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:55:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0703E1D0FA;
        Mon,  3 Oct 2022 11:55:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nb11so24167094ejc.5;
        Mon, 03 Oct 2022 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=OgLAkfQPoHBM9UwPCuZquxrKVstYZZfWhfyI2h4+/yE=;
        b=L8b4uWRyracDM/qWEbL5m4tYSr5LnVDzfEd4ncVKSLbs7nZN3ZlblntcwBrWiAN3h2
         7BJJX3hQzGD69x81BjQLLa6Wra8smeQsxTYfkFDPtC8cH7YNcHLDM6JSsIuXMlE1NxEp
         jBgV1LUMZPFefskATlB1GLgarruSO5O7qzqEzohY2u9iTVz1ZeOca5AAqsaPHNkYC3NW
         8fzV3LzsBzqjAwC4Aoidil2d7tF6rTBc4NeNrSvk49JFPbUZNpXwRcQJWGWEtP/fl78X
         Zgi/F1/N/9rQvy+LaqJGboGd76qfAHnP/DRB/+aCrGal6dcP4y1AR49ojut2egddtJOW
         uCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OgLAkfQPoHBM9UwPCuZquxrKVstYZZfWhfyI2h4+/yE=;
        b=eTl8MH2Gl9C95YoPFeCEbfDymgAbKYlowPDY7tePLrd8yXducSSxn8Vl6BuI5+ysHj
         tsju9Tgl9uf4b3pioGPN32UuH5iNDI/0LetcqCgGYLi/ALIjxFXO3v74+b7jISqRcBgN
         qLwfrhYfGaCzeC73dceXaZOIc6NUj0EkugNBuR21Qx3lhEq+B88xdsBS5zXUaar21rY7
         Z/tywmLrhK4w7iVKQG5kMrqZVWQrx+fH9SJu+FurWd58lCzfzWGxxpV8En2Oo4d3g+Vo
         f3GQmtb5lRI9winRWsU0bb9qV+fdbBUQO6EA5bGaq4V5bm2P0Ko7LHD9YwzmBFv2eflW
         ynkA==
X-Gm-Message-State: ACrzQf24a8WcSgb6+EjVmLGr9GS9lgwSGGGMsevWpK485NR0mFiTntYP
        HShpAJy1s7CplHd13fwWkamTc9VrFAQ=
X-Google-Smtp-Source: AMsMyM50xmiAXJvPSPj8QoFZWUoHSTkY/VRHO1/DxdEdEJciqqlJNXjMZjy1l6UWeQgqfU7mHLbLMw==
X-Received: by 2002:a17:907:7805:b0:780:24fd:c4e8 with SMTP id la5-20020a170907780500b0078024fdc4e8mr16438074ejc.78.1664823317997;
        Mon, 03 Oct 2022 11:55:17 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id a11-20020a05640213cb00b00459091c44b3sm144559edx.3.2022.10.03.11.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:55:17 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v3 2/2] dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
Date:   Mon,  3 Oct 2022 21:55:00 +0300
Message-Id: <20221003185500.928608-3-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221003185500.928608-1-dsankouski@gmail.com>
References: <20221003185500.928608-1-dsankouski@gmail.com>
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

add xiaomi,sagit board (Xiaomi Mi 6) binding

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes for v3:
- remove unused 'sagit' compatible line

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..294075bafb97 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -239,6 +239,7 @@ properties:
               - sony,xperia-lilac
               - sony,xperia-maple
               - sony,xperia-poplar
+              - xiaomi,sagit
           - const: qcom,msm8998
 
       - items:
-- 
2.30.2

