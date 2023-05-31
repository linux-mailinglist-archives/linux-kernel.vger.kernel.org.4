Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C82C71833D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbjEaNs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjEaNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF3C268F;
        Wed, 31 May 2023 06:44:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B7BA63B51;
        Wed, 31 May 2023 13:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FBEC4339B;
        Wed, 31 May 2023 13:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540663;
        bh=zZz1jc8ubBpVgvTtyr6lb67hGIGys3B+2ipic9l6JS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VLvHfeKivB1YjH2k051KNNVMejUzZHv6M3hNQFt0jBXDb93yclRt5aZVcMdVzT20B
         nKxjEQfgXYwrVe8807X61iqtuKywkUBxiz9jmBMqdbGXDh+rHYjo98kBkIh7ORsOg4
         CvGbCzswB1PJkl2PdLd94G0SGG8rou0YBqCBF08/b54xy4rFmh0pN78xWp6e4yXLB8
         lukvv21sQWCw1JY1dCzCLGe9ZL5imjeayGqMVI7VCz1jnlPquUVUKcQ0+AzsV1ve+h
         +CsjK0Wrzxtez3BoJoh6u4SDiyaADj76/RiiZH8dj9gcs559hu5YVlp9Gjv/YfNwz9
         Fprfk5gVX05EQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Milo Spadacini <milo.spadacini@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/21] tools: gpio: fix debounce_period_us output of lsgpio
Date:   Wed, 31 May 2023 09:43:58 -0400
Message-Id: <20230531134415.3384458-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134415.3384458-1-sashal@kernel.org>
References: <20230531134415.3384458-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milo Spadacini <milo.spadacini@gmail.com>

[ Upstream commit eb4b8eca1bad98f4b8574558a74f041f9acb5a54 ]

Fix incorrect output that could occur when more attributes are used and
GPIO_V2_LINE_ATTR_ID_DEBOUNCE is not the first one.

Signed-off-by: Milo Spadacini <milo.spadacini@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/gpio/lsgpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/gpio/lsgpio.c b/tools/gpio/lsgpio.c
index 5a05a454d0c97..85a2aa292f5d5 100644
--- a/tools/gpio/lsgpio.c
+++ b/tools/gpio/lsgpio.c
@@ -90,7 +90,7 @@ static void print_attributes(struct gpio_v2_line_info *info)
 	for (i = 0; i < info->num_attrs; i++) {
 		if (info->attrs[i].id == GPIO_V2_LINE_ATTR_ID_DEBOUNCE)
 			fprintf(stdout, ", debounce_period=%dusec",
-				info->attrs[0].debounce_period_us);
+				info->attrs[i].debounce_period_us);
 	}
 }
 
-- 
2.39.2

