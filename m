Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FC7615658
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiKAX55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAX5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:57:44 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE7F1F9CD;
        Tue,  1 Nov 2022 16:57:43 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h206so10279097iof.10;
        Tue, 01 Nov 2022 16:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzVXHrqJ14XTilpsUgY0mAaxfUrMXnLxuuL8jKZI4/8=;
        b=AOxTvaehyqZ/x5ZQiLI+22lOUtzG8lcQ05XD5e+rWVSZkBOpAWhcMIljEcjegUlHbv
         8lb3ICAlMjWOIuRcIBTtR9g4vRuvOxegEZ1u032q4XCpRKS5y//jeUEhR+BDdWHSqSi7
         sXYLej5U934FNOWfY7SMdXhKg2T6BPKqyc2VSPEdESEHzggucI9TGX5V//120o+pZkaI
         Xb6szlbevI2J/wNwGMyAfYCnfKWjOC4Md5pIGgLC4IEQk3eAIZgalgFQ0sN4n18nu4wC
         TfFPRPHL/1khqCdwElfxIv2ErEmTmlUFY83suGWP1k1YQzr8eaSpDLscSig31XEy2W1h
         bY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzVXHrqJ14XTilpsUgY0mAaxfUrMXnLxuuL8jKZI4/8=;
        b=QuWX0Ii8ed53khQej1Le8c1RTfEf3pFFS9exvRdXPLjfJaGPAoENtCvpoxAZ11Inja
         t7hVbreMWIn68YOhhviYhs9KEciEDiPE8dBz1NuKaA8qXOOmpYjukWhfgHBa/QzU+fOA
         7sZuxj89Jyokl1TEaU2ejfI7YexY/e0ZmiVmBDlHDFZ8iZMrSdpt+cSrnFwBkYvN34hi
         IOEDeUzFtL7YGM3f847B9jhEtFh7WlUweVkAHBUG4MG33bGbl806MmLQWAfOb4JNLiKg
         SQNnVDMQXwV3Q8FGqH0HhwoMuvZUz0aQTki4R541adOqrSCWJsBWMMMcpaFUSxAUq7Gw
         z09A==
X-Gm-Message-State: ACrzQf1U5NTP1Fmlv98ymYi7L8U3ovqFqbQmPcNmrE5iv842x7KLEDsZ
        fi8SfELV45o5+GBork4apvE=
X-Google-Smtp-Source: AMsMyM70LPK3HVI/ZScVQxt8YVNguOvhP+qI/0dw9NLTLy3nZ+U6VEqE8cqiCTNsOoTAY/nAwZnPbg==
X-Received: by 2002:a05:6638:227:b0:375:806e:3158 with SMTP id f7-20020a056638022700b00375806e3158mr251821jaq.81.1667347062963;
        Tue, 01 Nov 2022 16:57:42 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id q30-20020a056638345e00b00349deda465asm4275718jav.39.2022.11.01.16.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:57:42 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: firmware: scm: add sdm670 compatible
Date:   Tue,  1 Nov 2022 19:57:21 -0400
Message-Id: <20221101235722.53955-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101235722.53955-1-mailingradian@gmail.com>
References: <20221101235722.53955-1-mailingradian@gmail.com>
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

The Snapdragon 670 uses SCM as for PSCI power management. Document the
appropriate compatible string for it.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index be1b5746eddb..25688571ee7c 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -41,6 +41,7 @@ properties:
           - qcom,scm-sc7180
           - qcom,scm-sc7280
           - qcom,scm-sc8280xp
+          - qcom,scm-sdm670
           - qcom,scm-sdm845
           - qcom,scm-sdx55
           - qcom,scm-sdx65
-- 
2.38.1

