Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F75371017C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbjEXXF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjEXXFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:05:23 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C987C0;
        Wed, 24 May 2023 16:05:22 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-623feecfa42so1884066d6.0;
        Wed, 24 May 2023 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684969521; x=1687561521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW2CrKLGtfK3/WozE3DOZxbIsLBJxAAhWX283Uru4C8=;
        b=OzNx7BVeM42NjPViQcoCO4ICFUvFxS8vMB21jAxRG2W5JwuxVVI7ap1HWuosq1zOz0
         G1bhODzV8OGn3ywWzEkvkbifK4T077CxlPBfwZyZ1GRHwIGb8sKf+MMnlTPVHYSIiXG3
         xToIo9MwCZgpirGggJnD+hlK1vCirnbuQEeWuFguy85I2l5S2tqONJKzfv3oZica+6Vk
         zTZFUOZyAIpiAPWTuTePI9oqifI3Pu8RdFzxpxR/XJurou0l0kYG3+5An4DiDJoROeAZ
         5xEd6H+m7d/HiA9MONbYJ5L265zOgzMMtv0NDBaE6SF4V1dxgMeNE6q9s+Lhu5mpq2ew
         a+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684969521; x=1687561521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rW2CrKLGtfK3/WozE3DOZxbIsLBJxAAhWX283Uru4C8=;
        b=BxQct8JjGdZqe9yjn3I/88h5erIYpJWSdE81MghbDUyT6igwJBGS7B/sS/yE+ZeE45
         K7CdNlB994q1AGb88Exacw1Gw5We6C66MLfVMuUEUoM7IZl/NKPqWG7NyweHZjd8EgKu
         vPwrrOKg8D/4UrBrxcqG+Mzp0AQHIxoQgUE63F/Yfo3EgwfwVdH2+jksQ2eGClWOtOCb
         DeNTKO2iTk/OSt/ZbNPUfW9VKUh5reekT06sybgc2vsRb819csabdfFLWWO1He2M3kxO
         OgaVZupz7y1u2xLh37yasUHP08bZxLmmyG3Kdm74+5OWC0krycVgk8CIGYEpzRDSyu4a
         j09Q==
X-Gm-Message-State: AC+VfDxvRMJXfGhM/5Qck3UoNUtccbCOkjKl3AgCCF90hGT/eNMkJs+t
        HibSpiZypHKa/UgYBEAVvoI=
X-Google-Smtp-Source: ACHHUZ4dLJsDB4W6zfZKOc22p48blzwNXfAkn0aNu8ORrhXHwjJEBD0PsEXK0LHYM45YzHExiKNt6Q==
X-Received: by 2002:a05:6214:c2d:b0:56e:c066:3cd2 with SMTP id a13-20020a0562140c2d00b0056ec0663cd2mr1112188qvd.2.1684969521170;
        Wed, 24 May 2023 16:05:21 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:650f:ad8b:38f6:d091])
        by smtp.gmail.com with ESMTPSA id ea15-20020ad458af000000b0062075f40f61sm3914019qvb.73.2023.05.24.16.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 16:05:20 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     david@ixit.cz, Rudraksha Gupta <guptarud@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ARM: Add qcom,usb-hs-phy-msm8960 to qcom,usb-hs-phy.yaml
Date:   Wed, 24 May 2023 19:04:56 -0400
Message-Id: <20230524230459.120681-3-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524230459.120681-1-guptarud@gmail.com>
References: <20230524230459.120681-1-guptarud@gmail.com>
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

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
index aa97478dd016..6309c8e9d0b0 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -40,6 +40,7 @@ properties:
           - qcom,usb-hs-phy-apq8064
           - qcom,usb-hs-phy-msm8226
           - qcom,usb-hs-phy-msm8916
+          - qcom,usb-hs-phy-msm8960
           - qcom,usb-hs-phy-msm8974
       - const: qcom,usb-hs-phy
 
-- 
2.34.1

