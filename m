Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B61C64DF12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiLOQzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiLOQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:55:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F107A33C15;
        Thu, 15 Dec 2022 08:55:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D2BC61E58;
        Thu, 15 Dec 2022 16:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C4BC433D2;
        Thu, 15 Dec 2022 16:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671123330;
        bh=e0u79or8elEwsfwUpsz+c2l+wQJQhYf3g9q0SWliS3o=;
        h=From:To:Cc:Subject:Date:From;
        b=ZyCSXA/j9R+dQ0abQp+TVmCEjDUd7CT1NRuxnu/QKvU1RMGpcHhDXg1nZmDSVYMoH
         xiYgapFtnTkNpnnuEzBBkJA1xCDGz64P00EseuYDIjzAD2O9Fy/AmeZw/YCsw4Vq4A
         LwpzCAd6RYAh8G8NY900KKzQVFyBRLhXjVcgU+DbZc35YxAA6w0OYQMh4PZJVI4RJn
         PsFe4KAAM8NSEk9sUwaNUd86njS4LXQeLgVVdn64pEeT4xVuSbZZuHksTJ9vImeQc8
         EeiUDOOt4QuD92+YoyWs9qpQ4EgMJOHjDFh7JnsuhGaulmo8qBSDa/LmFBD246j6NS
         s1ue4rzNpJ1UQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: apple: remove duplicate intializer
Date:   Thu, 15 Dec 2022 17:55:15 +0100
Message-Id: <20221215165523.1920672-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
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

From: Arnd Bergmann <arnd@arndb.de>

When -Woverride-init is enabled, gcc notices that the .attr
field is initialized twice:

drivers/cpufreq/apple-soc-cpufreq.c:331:27: error: initialized field overwritten [-Werror=override-init]
  331 |         .attr           = apple_soc_cpufreq_hw_attr,
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~

Remove the first one, since this is not actually used.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index d1801281cdd9..6f26395184c4 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -321,7 +321,6 @@ static struct cpufreq_driver apple_soc_cpufreq_driver = {
 	.flags		= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 			  CPUFREQ_NEED_INITIAL_FREQ_CHECK | CPUFREQ_IS_COOLING_DEV,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.attr		= cpufreq_generic_attr,
 	.get		= apple_soc_cpufreq_get_rate,
 	.init		= apple_soc_cpufreq_init,
 	.exit		= apple_soc_cpufreq_exit,
-- 
2.35.1

