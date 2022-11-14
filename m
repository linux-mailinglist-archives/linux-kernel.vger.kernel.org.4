Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D318B627B94
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbiKNLHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiKNLH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:07:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF2A20BF0;
        Mon, 14 Nov 2022 03:07:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19582B80DEB;
        Mon, 14 Nov 2022 11:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E46C433C1;
        Mon, 14 Nov 2022 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668424033;
        bh=49UtItfLQZcbV45mXRG9vFVDAY6GdI89kbkn+0l94+A=;
        h=From:To:Cc:Subject:Date:From;
        b=eD9lTovwvWHP2VNP+oiRZjWXyNqlj3Ukcw8+RvDMevESCNjqWq+TVTp+yIt5n9hBm
         zMqXlJt1FHwLx8a6W7qhnegDoNjY2LwxCoK+EognPsxoE83qddkVhE4t5w7Ry2EnbD
         HK/rH70VyeSyjANLqLrvlqUEC8NE3MqnxeU8fPrRsH6WjjTyXWuFnSRbtRqr+Emqwz
         37nIhiRLydSBT8uwUViiRTF01ZsuEkA4j42OgQaCWhxSTyMwVtkxzJ8wGEbom9aQxK
         otlH6HL8ZOsyHkaJX2mgmQO6UvGWOtgtPxEfVPso8Yddz2hEwe5T9dTnd+3h7G++WY
         /55tO5mzkX8WA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouXIX-0001EP-1g; Mon, 14 Nov 2022 12:06:41 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 00/22] phy: qcom-qmp-combo: preparatory cleanups (set 2/3)
Date:   Mon, 14 Nov 2022 12:05:59 +0100
Message-Id: <20221114110621.4639-1-johan+linaro@kernel.org>
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

Here's a set of preparatory cleanups needed to fix the devicetree
binding and add (proper) support for SC8280XP to the combo driver but
that are otherwise self-contained.

The full series is over forty patches and I'll be posting these in three
parts of which this is the second. In an effort to get all of these into
6.2, I'll also be submitting all three series before waiting for the
previous ones to be applied.

This series specifically separates the USB and DP PHY ops
implementations, and merges the USB and DP driver data and
configurations.

Johan


Changes in v2
 - remove pcs_misc also from comment in DP legacy DT helper as this has
   never been part of the binding (even if some SoC dtsi got that wrong)
 - drop the lanes configuration parameter (new patch)
 - drop USB PHY init sequence cleanup (not needed after removing the
   lanes parameter)


Johan Hovold (22):
  phy: qcom-qmp-combo: sort device-id table
  phy: qcom-qmp-combo: move device-id table
  phy: qcom-qmp-combo: move pm ops
  phy: qcom-qmp-combo: rename PHY ops structures
  phy: qcom-qmp-combo: drop unused DP PHY mode op
  phy: qcom-qmp-combo: rename USB PHY ops
  phy: qcom-qmp-combo: drop unnecessary debug message
  phy: qcom-qmp-combo: separate USB and DP init ops
  phy: qcom-qmp-combo: rename DP PHY ops
  phy: qcom-qmp-combo: separate USB and DP power-on ops
  phy: qcom-qmp-combo: clean up serdes initialisation
  phy: qcom-qmp-combo: separate USB and DP devicetree parsing
  phy: qcom-qmp-combo: add dedicated DP iomem pointers
  phy: qcom-qmp-combo: clean up DP configurations
  phy: qcom-qmp-combo: rename sc8280xp config
  phy: qcom-qmp-combo: add DP configuration tables
  phy: qcom-qmp-combo: drop lanes config parameter
  phy: qcom-qmp-combo: merge USB and DP configurations
  phy: qcom-qmp-combo: merge driver data
  phy: qcom-qmp-combo: clean up device-tree parsing
  phy: qcom-qmp-combo: clean up probe initialisation
  phy: qcom-qmp-combo: clean up DP callback names

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 1344 ++++++++++-----------
 1 file changed, 608 insertions(+), 736 deletions(-)

-- 
2.37.4

