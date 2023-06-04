Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80488721528
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 08:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjFDGa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 02:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjFDGaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 02:30:55 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4B2E1;
        Sat,  3 Jun 2023 23:30:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f767eec104so35709471cf.1;
        Sat, 03 Jun 2023 23:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685860252; x=1688452252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9dG+oN5uOmuQYXLewl1nCF0/Os/UQTTZl0+MY2RxWE=;
        b=gCJ5TP16lpl3NL9edgkLyptik5lxamQvDz9/NcrrCB5/qLi0RFhmGMOrw07lKHIXKl
         MvqiSGXAwqeddk7gJoREoOIbmNq4x1iutytGUo+XsmK60SbnHiuiW4tF/dBG6cjDXW44
         lPRJGjkDPeqL4X5xxTZAFoQketE5thpSVIdC8MPD1krE97GhIod4NaJ9ML+2i1205FAe
         /7UqDG4ncHlXQvf0ofRSM5McjxcrGoKZuUsn7sWdowWTEAAUfldA8xjq2JxrWT3CA4zx
         zciE6ybOjqCxs8jAEnN+hhmM/DMnEY/0AyE+QhOR9DM4vZ91gYxf2bfgiaHRj3bOqKpD
         HWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685860252; x=1688452252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9dG+oN5uOmuQYXLewl1nCF0/Os/UQTTZl0+MY2RxWE=;
        b=MFT4A1oVaCHB6oOs4ZUfvewFEPDCuSMauLyiBcR3FLOncUvVAGS1G8dvC47XDF9Y24
         EN7dkPM9CBCx1h6vfq3UJp+j9YWcSX8H5hLgJrr++vCndVJ8XytuVTT1O+dWUFbnd5TV
         JFKnxpj8fuMcLA8X+taBM558rBqquCNowPqhPx2iBgLE4oR8WkgqThORTjOfGKLYSycv
         BGhxzDLNEhTixaPs3/UchC77wTUloNiyzs1sZ2itdsbfXe+XwXixbaksOifXjs00GdNT
         0ATGKGzr010ustuAsBYH0owgmkOunbBjp0/n1jGG2leMWHPHpcnKqVBHzEs6GvK7ysLf
         OObg==
X-Gm-Message-State: AC+VfDxNz01Ddd4955hzvAWys5IwmwejZx9wUuVT/K/tofmqUn9iAXMr
        ULtMsdjr1YnhbnBEAILOlmw=
X-Google-Smtp-Source: ACHHUZ5iCQcREmJp1oKpaQjZpi78wA4hoUCp69qQTizw8BsmlhFgInVn73vbiI3SQZtsLLwE2MFSvw==
X-Received: by 2002:ac8:59d3:0:b0:3f6:9678:9d2a with SMTP id f19-20020ac859d3000000b003f696789d2amr3671891qtf.47.1685860252380;
        Sat, 03 Jun 2023 23:30:52 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:ab78:dd77:aea4:8d1a])
        by smtp.gmail.com with ESMTPSA id e10-20020ac85dca000000b003f018e18c35sm3044163qtx.27.2023.06.03.23.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 23:30:52 -0700 (PDT)
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
Cc:     Rudraksha Gupta <guptarud@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] dt-bindings: arm: qcom: Add Samsung Galaxy Express
Date:   Sun,  4 Jun 2023 02:30:18 -0400
Message-Id: <20230604063032.365775-2-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604063032.365775-1-guptarud@gmail.com>
References: <20230604063032.365775-1-guptarud@gmail.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

