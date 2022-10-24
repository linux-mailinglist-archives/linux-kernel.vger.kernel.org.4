Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2D4609DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJXJQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJXJQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:16:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D5E6A49B;
        Mon, 24 Oct 2022 02:15:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50F0DB81015;
        Mon, 24 Oct 2022 09:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75ABC433B5;
        Mon, 24 Oct 2022 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666602941;
        bh=6VuJyOuXrZYfUSFkV45f4BbgcLburovNmgn2tZqTBTI=;
        h=From:To:Cc:Subject:Date:From;
        b=E8lAWlEhi5sKFKYNnEmDJVI0OX2i0rEiVh6zlgt7bnUglUHRfeIBQ4pcJAP5iTJ85
         yUZ91T4Sm24hj8gHjtVL2WtbVNmfpAD9FFEU1m3loRRoeTSZF545ShVjDDhSb9RzY3
         +NwcX5vAizTMbo3sPXyCRl0dVDCJTsbBV35JfCnhP09/ySORR1Yyo5d/RQWv0ug2au
         wL6Vl0JnF0xpxs3jgRlDVkJ0KgEW04lhw7ywTIvJNRtguCIFei36YFBT58PHl4CqD6
         pSo2ZdLB8OCNnHwU5MxrWmw2AUamBNwZDH2fB9I3WXLyBKfs4nHeJSBsk7BlWkfB4x
         +ZTPhMK2C7mPg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omtYJ-0005Iw-G5; Mon, 24 Oct 2022 11:15:24 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/4] arm64: dts: qcom: fix UFS PHY registers
Date:   Mon, 24 Oct 2022 11:15:03 +0200
Message-Id: <20221024091507.20342-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When working on the updated QMP binding for SC8280XP, I noticed that the
UFS PHY register definitions for most platforms are wrong. Apparently
the register region sizes have just been copied verbatim from the
original SDM845.

As Linux maps these regions as full pages this is currently not an issue
on Linux, but let's update the sizes to match the vendor drivers.

Note that SC8280XP also suffers from this, but that problem will soon go
away when the UFS nodes are updated to match the new binding:

	https://lore.kernel.org/lkml/20221024090041.19574-1-johan+linaro@kernel.org/

Johan


Johan Hovold (4):
  arm64: dts: qcom: sm8150: fix UFS PHY registers
  arm64: dts: qcom: sm8250: fix UFS PHY registers
  arm64: dts: qcom: sm8350: fix UFS PHY registers
  arm64: dts: qcom: sm8450: fix UFS PHY registers

 arch/arm64/boot/dts/qcom/sm8150.dtsi | 10 +++++-----
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 10 +++++-----
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 10 +++++-----
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 10 +++++-----
 4 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.37.3

