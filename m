Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE51732AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbjFPJE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244352AbjFPJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:03:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A54493
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E71262C11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EF3C433C0;
        Fri, 16 Jun 2023 09:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686906122;
        bh=cVzo/h1du6EG71YMJA69ZOvL8XUo5XXroakRB2KzZho=;
        h=From:To:Cc:Subject:Date:From;
        b=FtywWfZtgsSj9FFvkPXXwo6WbvZLGQh+2L5ouZeJCIRq8qf+btEr6ccuQbacsOeo5
         zwEcUnUrGyBg3M7mYLmj3cE9cC1xiuvjCZp7K09Tb3tPZ/LsFmp3t5T3SNEoGRhI4u
         A7Tv6H/7geI+qr66OvZ9gksTWXwg4/qycNf1TuY8IHG2a+GHYcrQBn6Yu7KYRicyuf
         svss8ubY8wrRBMqSn5QcK2POSanpEJmhtb3oE9N9i3FZAOi7EqUY+EcGNmBkB3ZfDs
         X6nfcGOd+NhgLFFkNEChAnaX2f7MdfxAX3OM/yXJOB+5EezGd6CHIao4CSb4XxqlZ+
         PNkWceMMoDYXw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ryan Lee <ryans.lee@analog.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ASoC: max98388: fix unused function warnings
Date:   Fri, 16 Jun 2023 11:00:37 +0200
Message-Id: <20230616090156.2347850-1-arnd@kernel.org>
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

The PM functions are never referenced when CONFIG_PM_SLEEP is
disabled:

sound/soc/codecs/max98388.c:854:12: error: unused function 'max98388_suspend' [-Werror,-Wunused-function]
static int max98388_suspend(struct device *dev)
           ^
sound/soc/codecs/max98388.c:864:12: error: unused function 'max98388_resume' [-Werror,-Wunused-function]
static int max98388_resume(struct device *dev)

Fix this by using the modern SYSTEM_SLEEP_PM_OPS() macro in place of
the deprecated SET_SYSTEM_SLEEP_PM_OPS() version, and use pm_sleep_ptr()
to hide the entire structure as well.

On a related note, the of_match_ptr() and ACPI_PTR() macros have the same
problem and would cause the device id table to be unused when the driver
is built-in and the respective subsystems are disabled. This does not
cause warnings unless -Wunused-const-variable is passed to the compiler,
but it's better to just not use the macros at all here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/max98388.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max98388.c b/sound/soc/codecs/max98388.c
index 8062a71150074..3d03c4bac6c55 100644
--- a/sound/soc/codecs/max98388.c
+++ b/sound/soc/codecs/max98388.c
@@ -873,7 +873,7 @@ static int max98388_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops max98388_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(max98388_suspend, max98388_resume)
+	SYSTEM_SLEEP_PM_OPS(max98388_suspend, max98388_resume)
 };
 
 static const struct regmap_config max98388_regmap = {
@@ -998,9 +998,9 @@ MODULE_DEVICE_TABLE(acpi, max98388_acpi_match);
 static struct i2c_driver max98388_i2c_driver = {
 	.driver = {
 		.name = "max98388",
-		.of_match_table = of_match_ptr(max98388_of_match),
-		.acpi_match_table = ACPI_PTR(max98388_acpi_match),
-		.pm = &max98388_pm,
+		.of_match_table = max98388_of_match,
+		.acpi_match_table = max98388_acpi_match,
+		.pm = pm_sleep_ptr(&max98388_pm),
 	},
 	.probe = max98388_i2c_probe,
 	.id_table = max98388_i2c_id,
-- 
2.39.2

