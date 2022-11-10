Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978CA623F73
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiKJKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKJKIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:08:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C45D6B39C;
        Thu, 10 Nov 2022 02:08:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AA9EB8213F;
        Thu, 10 Nov 2022 10:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1E4C433C1;
        Thu, 10 Nov 2022 10:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668074885;
        bh=MiaY7DJhi+fcXaSNy1/u+xMsWvH1dSzjh8nCFQMgDng=;
        h=From:To:Cc:Subject:Date:From;
        b=e6Yo7Cq07iOgyiB/oZmTK9Yzne+iLx+rSTZVJ+rmB4f1dtu6AVQpPjyw7vwgnUQ+I
         sZb58YF11URMWkh3BYlr4GPVCrMB7W0gyAJfP1fwMebFrAGaa8kWyV6vo7iRx+0odH
         DtbEt3lHojvD+4+g+h7cq/gCBiC60HDllQJ4WaiZXGqAWoLiBxflHIpzOQeZ2joQeM
         7q/+3ule+QAIxwdhtBWQkCnxcjweLwBUUJKf4u0257ZcSXp4kXrlBL5D02QR1BAcyv
         XGipVSqjcEyU37+jrEksgiv0Bqa1Uy94bI+7bW7gjNarQQTci1N/BBqMYwWfmTBSht
         jVdioyIniWohw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v6 0/2] spmi: pmic-arb: Add support for PMIC v7
Date:   Thu, 10 Nov 2022 15:37:53 +0530
Message-Id: <20221110100755.4032505-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.37.3
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

Hello Greg,

Since Stephen has not been responding [1] or applying these patches, I would
like to request you to review and apply them to char-misc (thru which spmi
tree anyway merges). I have been trying to get this in since last
Decemeber!

The is version 6 of support for PMIC v7. I have added a new property
qcom,bus-id for supporting v7 and then add driver changes for v7 of PMIC

[1]:
v5: https://lore.kernel.org/all/20220914165212.3705892-1-vkoul@kernel.org/
v4: https://lore.kernel.org/all/20220914112139.3680354-1-vkoul@kernel.org/
v3: https://lore.kernel.org/all/20220201134108.2677578-1-vkoul@kernel.org/
v2: https://lore.kernel.org/all/20220131172450.2528065-1-vkoul@kernel.org/
v1: https://lore.kernel.org/all/20211201072718.3969011-1-vkoul@kernel.org/

Changes since v5:
 - rebase on linux-next

Changes since v4:
 - Fix David name and email
 - remove trailing line in binding

Changes since v3:
 - rebase on spmi/next

David Collins (1):
  spmi: pmic-arb: Add support for PMIC v7

Vinod Koul (1):
  dt-bindings: spmi: Add qcom,bus-id

 .../bindings/spmi/qcom,spmi-pmic-arb.yaml     |  10 +
 drivers/spmi/spmi-pmic-arb.c                  | 242 ++++++++++++++++--
 2 files changed, 231 insertions(+), 21 deletions(-)

-- 
2.37.3

