Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30AE739E44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjFVKSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFVKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9107FDD;
        Thu, 22 Jun 2023 03:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D8B5617C8;
        Thu, 22 Jun 2023 10:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD4DC433C8;
        Thu, 22 Jun 2023 10:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687429098;
        bh=ON66HbfJ1HJ3YKs4MkYfePaKxVL3lLiSW463cMoqJN4=;
        h=From:To:Cc:Subject:Date:From;
        b=igRdryfErkXMOmpAXCPL6+iCdcz1mTZRIYVlWMjPI8b0SqJC69hTsbH+P/YSsAHai
         XP7sqjUe/IKYNNB+3suFT2wCKtmI25VVLv5GPH/pbDbdY3W6RKGBu4AHgH3mDUB1L4
         TSlqXiW2Gbzk0kUakH7H1bF4MPnIV017QO2Mtf2ZIqJwRgu6QRYbua6Y6zNC/802uD
         Bcrlt3rKaoeT1toTidzbR8C6lSKx7br+blH7glaHq1bGY9DEd5Vzmvd1uaazGqDPJy
         otbwxq/Gs5Hg6u5WmoO+aOhtm781Nux25vjrlV9h0lfFe/GluICxaHSHrXHmfGlV+J
         geWn76zimRrxg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: nb7vpq904m: add CONFIG_DRM dependency
Date:   Thu, 22 Jun 2023 12:18:09 +0200
Message-Id: <20230622101813.3453772-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

This driver calls directly into DRM functions and fails to link if
that is disabled:

ld.lld: error: undefined symbol: devm_drm_bridge_add
ld.lld: error: undefined symbol: devm_drm_of_get_bridge
>>> referenced by nb7vpq904m.c
>>>               drivers/usb/typec/mux/nb7vpq904m.o:(nb7vpq904m_probe) in archive vmlinux.a

Fixes: 88d8f3ac9c67e ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/typec/mux/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 8c4d6b8fb75c3..f53ae24b6c048 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -37,7 +37,7 @@ config TYPEC_MUX_INTEL_PMC
 
 config TYPEC_MUX_NB7VPQ904M
 	tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
-	depends on I2C
+	depends on I2C && DRM
 	select REGMAP_I2C
 	help
 	  Say Y or M if your system has a On Semiconductor NB7VPQ904M Type-C
-- 
2.39.2

