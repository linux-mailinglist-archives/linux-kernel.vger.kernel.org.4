Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1167CC3C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbjAZNck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjAZNcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:32:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF5A6A57;
        Thu, 26 Jan 2023 05:32:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91D5D617E8;
        Thu, 26 Jan 2023 13:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B4DC4339E;
        Thu, 26 Jan 2023 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674739953;
        bh=cdNLMB2rZ4rnBWr3OLqzMglKfyiP3lv+egE4gKxG97I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7UEr3ULHzc9Ny5bGEc9BSFwje4IIdaVZv8q8faWKEHtafv8nLQHORkoq/ltNflgq
         uR/ikpZv/FVLwd8BTUHP/MqJyyV4Ofc46nQLwX177CKpJnnddnpgyItJezzTloW0m9
         D4RA74ngVihRHIvqMdLWEnmwbEcC8j5r6Dg4ZCKkwuQi+sOdUAWqq+Ke8u2WR8GuHt
         uUFF6rw6K6FjvLSwpwKaxv9fg81fPHeJ4jcJrWq4UMXINA1+Re4Q+humshUMj+ARVr
         IZ92vOxuTr+ewuIduHdeAACggjAsLSPYYFx2jBL3wVMHyNW0//aY1HaFJFWJsoLb31
         3Ne8AKr5KUXzg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL2Mq-0007Am-Iy; Thu, 26 Jan 2023 14:32:40 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] nvmem: qcom-spmi-sdam: register at device init time
Date:   Thu, 26 Jan 2023 14:30:34 +0100
Message-Id: <20230126133034.27491-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126133034.27491-1-johan+linaro@kernel.org>
References: <20230126133034.27491-1-johan+linaro@kernel.org>
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

There are currently no in-tree users of the Qualcomm SDAM nvmem driver
and there is generally no point in registering a driver that can be
built as a module at subsys init time.

Register the driver at the normal device init time instead and let
driver core sort out the probe order.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/nvmem/qcom-spmi-sdam.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 8499892044b7..f822790db49e 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -175,18 +175,7 @@ static struct platform_driver sdam_driver = {
 	},
 	.probe		= sdam_probe,
 };
-
-static int __init sdam_init(void)
-{
-	return platform_driver_register(&sdam_driver);
-}
-subsys_initcall(sdam_init);
-
-static void __exit sdam_exit(void)
-{
-	return platform_driver_unregister(&sdam_driver);
-}
-module_exit(sdam_exit);
+module_platform_driver(sdam_driver);
 
 MODULE_DESCRIPTION("QCOM SPMI SDAM driver");
 MODULE_LICENSE("GPL v2");
-- 
2.39.1

