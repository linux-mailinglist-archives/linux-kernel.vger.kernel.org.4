Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD571233F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242881AbjEZJSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242655AbjEZJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA34019A;
        Fri, 26 May 2023 02:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4B264E68;
        Fri, 26 May 2023 09:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F503C4339C;
        Fri, 26 May 2023 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685092707;
        bh=88/uGPpiYSu2UAheS3H0lRT6u8rFAc92NcdMxP7OLEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZqHtfZ3XpqX7zg1Nt1c3/AhkTEAnxg22bAYmodSiLWrOrg8/Rfq7AVVGXRhPEiJG
         pdII0jw/+xY2LNlRXpS8K/xjEbwPjfHho3nlvPE/wsWm5wNWHi1Fw61cLU5OGf8R6E
         KoKetT5p+UQumkW8QEx8V2LYYQfmblhv90Xhk3xQVAj8cvL76Dm4CZHSBRzrMT9Jp4
         RErgqeUIFlG3MbcwgZ9j/SxJQiG8OAiPqQzQJNgNGZt2d3UNvqSgwnaktF2DCBBp93
         0pWaVDtt2+v/QkHYUOKUYtmiBwdFPNj4/gQA29fCT8ssrDQGQ6wXR9O/mcABLmbq2r
         VQJMF4qtpLu8A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q2Tap-0004Wd-7U; Fri, 26 May 2023 11:18:39 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] mfd: pm8008: drop bogus i2c module alias
Date:   Fri, 26 May 2023 11:16:46 +0200
Message-Id: <20230526091646.17318-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230526091646.17318-1-johan+linaro@kernel.org>
References: <20230526091646.17318-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit af503716ac14 ("i2c: core: report OF style module alias
for devices registered via OF") drivers using OF matching needed an i2c
module alias such as "i2c:pm8008" for module autoloading to work.

Drop the bogus i2c alias from the pm8008 driver which was merged long
after i2c core was fixed and whose alias did not match the driver name
("pm8008") to begin with.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/mfd/qcom-pm8008.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 29ec3901564b..c4cef3936ea3 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -211,4 +211,3 @@ static struct i2c_driver pm8008_mfd_driver = {
 module_i2c_driver(pm8008_mfd_driver);
 
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("i2c:qcom-pm8008");
-- 
2.39.3

