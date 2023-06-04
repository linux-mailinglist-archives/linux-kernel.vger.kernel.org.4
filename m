Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E808A7217F5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjFDO4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjFDO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:56:42 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B77CD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 07:56:39 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 5p9nqXazR0h9k5p9nqRBSI; Sun, 04 Jun 2023 16:56:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685890597;
        bh=yUaA6iuQ+wEq2pR0TTwubVvItnjACHFQxAMGLNFZLXc=;
        h=From:To:Cc:Subject:Date;
        b=mMHiVsx0L/Wo7j7u0lVmTjpJqxcW22V7qqbr7+xp8MfIeWnrIvcT+whm9RpjuDHJG
         HdG8VPA7o/RzclfA+4MTBo1zyfWoBcwfB9fkfBoXAHjLmuXokxVRfY0S88LOifaOPO
         WHkw9VboJnGcypPIkYCKAeSjHi0VRhlotQrF2fdvuilcA826dmrATM8e/wNGdCKlJ8
         tY3eZaHiO/DTE+EN4LYMzr3sJjf1kfBk6A/xqdlLBYqng8TRgK+bLxu8CDDL6JVS4O
         g1qpHslIg5fF6YLg9MTAvdwJt68q4i7PKxKOcVoCLFOFSkCrWLE5K9hfI+dzOkJoMb
         D6k3cxiftJysw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 04 Jun 2023 16:56:37 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
Date:   Sun,  4 Jun 2023 16:56:34 +0200
Message-Id: <b69fa8dd68d816e7d24c88d3eda776ceb28c5dc5.1685890571.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dwc3_qcom_create_urs_usb_platdev() fails, some resources still need to
be released, as already done in the other error handling path of the
probe.

Fixes: c25c210f590e ("usb: dwc3: qcom: add URS Host support for sdm845 ACPI boot")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/dwc3/dwc3-qcom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 822735814050..aa96c473f839 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -856,9 +856,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 			if (IS_ERR_OR_NULL(qcom->urs_usb)) {
 				dev_err(dev, "failed to create URS USB platdev\n");
 				if (!qcom->urs_usb)
-					return -ENODEV;
+					ret = -ENODEV;
 				else
-					return PTR_ERR(qcom->urs_usb);
+					ret = PTR_ERR(qcom->urs_usb);
+				goto clk_disable;
 			}
 		}
 	}
-- 
2.34.1

