Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C14C719295
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjFAFrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjFAFqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:46:44 -0400
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7262195;
        Wed, 31 May 2023 22:46:20 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id 3723E46CCB;
        Thu,  1 Jun 2023 08:46:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-teO2xOLG;
        Thu, 01 Jun 2023 08:46:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598379;
        bh=2bx5eqTiy8MyKGVkYQobbEojNAt3qH2KtWz3TAeN9Vk=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=EH2My4qSEhN+mUOTxtIRrGBgfv2b/WlDn8GBy1OmEOjOVB2Dw0jNHOrFdxBD2fGcu
         WeZUJjAj9B9WziS0do8tDpdLJnxESs9jdnBH01UBy/m5AY3cT9IoaeLpJCxuMRBDd6
         QAxlfN2rcho4Vt/jc0sH6u7cZq/ctOEv3wvVmB54=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 30/43] rtc: m48t86: add DT support for m48t86
Date:   Thu,  1 Jun 2023 08:45:35 +0300
Message-Id: <20230601054549.10843-12-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- get regs from device tree

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    
    - dropped CONFIG_OF, of_match_ptr
    - dropped coma in id table
    - changed compatible from "dallas,rtc-m48t86" to "st,m48t86"

 drivers/rtc/rtc-m48t86.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
index 481c9525b1dd..b114796d4326 100644
--- a/drivers/rtc/rtc-m48t86.c
+++ b/drivers/rtc/rtc-m48t86.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/bcd.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #define M48T86_SEC		0x00
 #define M48T86_SECALRM		0x01
@@ -269,9 +270,16 @@ static int m48t86_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id m48t86_rtc_of_ids[] = {
+	{ .compatible = "st,m48t86" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, m48t86_rtc_of_ids);
+
 static struct platform_driver m48t86_rtc_platform_driver = {
 	.driver		= {
 		.name	= "rtc-m48t86",
+		.of_match_table = m48t86_rtc_of_ids,
 	},
 	.probe		= m48t86_rtc_probe,
 };
-- 
2.37.4

