Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7330465D00A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjADJ4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjADJ4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:56:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A026F1A3A9;
        Wed,  4 Jan 2023 01:56:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 564D1B815DB;
        Wed,  4 Jan 2023 09:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30A6C433D2;
        Wed,  4 Jan 2023 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672826192;
        bh=3WC9ZDwXrBRhubWeQsr1033lNqa3IKzJP97No7XbvcE=;
        h=From:To:Cc:Subject:Date:From;
        b=Z7vauvSBdY+FrYMuuKdmXLP3iE7V23UHLUYRmog9XGY4m1m79w1MFvotD6z6cTNbO
         oYdzfEKplsZDibOJMfmXIeZ7mW8A6ITtZDRTRoooJN7L8ses2ns9Vw8LW8E/dEscJG
         z1H701drzkdewi9dWMj2S0LNxjdLo/25CaamBji74AmNFKgw6czi9+lUr3cqwVKaDv
         7oorK7ke64pIGJFvZ6vWD7b0hgeyArKRTrHRv87Lw2JwWGavr5gJkf17n6uyfiDuk0
         o3JySlw7bHrFxtzc8e9gg8+ObtxaJ/QG8VdmOZmv9oBM2IYoQzoQiWi68nUHpMTHcl
         gWs0mFmXUEbbQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pD0Vy-0001lF-Jo; Wed, 04 Jan 2023 10:56:54 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: rtc: qcom-pm8xxx: allow 'wakeup-source' property
Date:   Wed,  4 Jan 2023 10:56:12 +0100
Message-Id: <20230104095612.6756-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC can be used as a wakeup source on at least some platforms so
allow it to be described as such.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Since commit 30d70ec8f7fd ("arm64: dts: qcom: sa8295p-adp: Add RTC
node") this triggers a warning on DT validation so it would be nice to
get this into 6.2:

  arch/arm64/boot/dts/qcom/sa8295p-adp.dtb: rtc@6000: 'wakeup-source' does not match any of the regexes: 'pinctrl-[0-9]+'

Johan


 Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
index 0a7aa29563c1..21c8ea08ff0a 100644
--- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
@@ -40,6 +40,8 @@ properties:
     description:
       Indicates that the setting of RTC time is allowed by the host CPU.
 
+  wakeup-source: true
+
 required:
   - compatible
   - reg
-- 
2.37.4

