Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8923071233E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbjEZJSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242982AbjEZJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4199199;
        Fri, 26 May 2023 02:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C2ED64E6C;
        Fri, 26 May 2023 09:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C00CC4339B;
        Fri, 26 May 2023 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685092707;
        bh=yplqz7LFwT3BPxWbIqpL9l8Y9WXsW7gyYbieMHFZ63M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTWcsq76uyaQnoYgyHHoExt5aJ9l71WeMSYJqjA+Nea9FCu+BNfMv3onXzEBlgm5m
         iM17yUp+/Pgm8SvDzV1+78+4a1UO53i3+dLhog7OPo74JVdR1/Np6OqfMu5i4iBi3g
         SN4iMUnqMx89sKl3wPDjpsFhGTDOXsMvhcnHcrjtaaYhUBvFhXE/y/cQposGdRG0i2
         4R5B5aj8d91WhY+nHy0OndbyiGtvbrgRKSNy7TKbLJ/sk2pAX+7yCbNwKE+vyavdxQ
         XSAFsBfieJN1dwyGbD9mASHU1PzdZA2O4mmsanPq+CTDwms9MWwCoQrhK5vXWUe+ra
         fMsjAOHKQY9cg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q2Tap-0004Wb-4y; Fri, 26 May 2023 11:18:39 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] mfd: pm8008: fix module autoloading
Date:   Fri, 26 May 2023 11:16:45 +0200
Message-Id: <20230526091646.17318-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230526091646.17318-1-johan+linaro@kernel.org>
References: <20230526091646.17318-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing module device table alias to that the driver can be
autoloaded when built as a module.

Fixes: 6b149f3310a4 ("mfd: pm8008: Add driver for QCOM PM8008 PMIC")
Cc: stable@vger.kernel.org      # 5.14
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/mfd/qcom-pm8008.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 837246aab4ac..29ec3901564b 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -199,6 +199,7 @@ static const struct of_device_id pm8008_match[] = {
 	{ .compatible = "qcom,pm8008", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, pm8008_match);
 
 static struct i2c_driver pm8008_mfd_driver = {
 	.driver = {
-- 
2.39.3

