Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68026C4944
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjCVLdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjCVLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:32:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E15D5ADEF;
        Wed, 22 Mar 2023 04:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9C8CB81C3E;
        Wed, 22 Mar 2023 11:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D1AC4339C;
        Wed, 22 Mar 2023 11:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679484768;
        bh=IZcR7VbPx0Tx0pso6mqWcUyAf59S4FfidLrhx5r/GKk=;
        h=From:To:Cc:Subject:Date:From;
        b=AsVamaJMiGF5BAYBN0nlSB3spR+Tay+u8SoGhWKfCLUQly4f1mbsijySWM5fhjM+m
         eJ5U9NA+2umIzkle0vf8kK4Y/LQH9IulYvZaEBItIN4ysFl++emH8DYI1eo/wWtHD6
         TJ7mbAXfKDIMfWof5IMTc6zmOVciUaLQHEfPWc+I/+FdXyE61MTPqJPf8iz99RSqDC
         oMm+5/5NM48qSu9ftMkmELAMJTVkSY+JcyL/uIAk3P4tP9U//2IHkpiml82d1987oy
         2R3G1w2ZCgAvrNG+RXk/a58CcSm4vPHQ25QXEuaBDvIyA36eLCCDpxbT4YniCKLCRd
         2W/hAfgLrYXjw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pewjN-0004fL-UP; Wed, 22 Mar 2023 12:34:14 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/6] arm64: dts: qcom: sc8280xp-x13s: regulator fixes
Date:   Wed, 22 Mar 2023 12:33:12 +0100
Message-Id: <20230322113318.17908-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series marks four of the regulators which have consumers not yet
(fully) described in the devicetree as always-on to avoid the supply
going away while the device is still in use.

The last two patches adds the missing description of the pmic regulator
and hid supplies, which is needed to eventually be able to disable the
regulators in question.

At least the first four patches should go into 6.3-rc, but it may
simplify things to take also the pmic supply patch as a fix.

Note that the pmic patch is adding the missing s1c supply, which is also
needed by the pending bluetooth series.

Johan


Johan Hovold (6):
  arm64: dts: qcom: sc8280xp-x13s: mark s11b regulator as always-on
  arm64: dts: qcom: sc8280xp-x13s: mark s10b regulator as always-on
  arm64: dts: qcom: sc8280xp-x13s: mark s12b regulator as always-on
  arm64: dts: qcom: sc8280xp-x13s: mark bob regulator as always-on
  arm64: dts: qcom: sc8280xp-x13s: add pmic regulator supplies
  arm64: dts: qcom: sc8280xp-x13s: add hid 1.8V supplies

 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

-- 
2.39.2

