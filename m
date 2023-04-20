Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF846E9B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDTSX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDTSX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:23:58 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBF12736;
        Thu, 20 Apr 2023 11:23:55 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Q2Qyw0dxNz9sqP;
        Thu, 20 Apr 2023 20:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1682015032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z6KrI80HGjpMqg/Xqk5pK9EZJ5/5XGSUY1Wcsv35Fwk=;
        b=JeHaUjF3vu4c+GFSPnHJ2zFyQewrl4Nb50uajlIKYauaM+1mOd2kkieKI6ew8flRsizBuv
        xuJQEvO6JEz9u4tbgJr7qXjdFzzwQXx+g1mXPJmEj/NsTCIM6xADkwvaeL2ljd/do3FUdc
        ararKzI7C5ovAYJLLPzr9y6EddpkeoejQspN9ex3QYaMzRlQJi5Ew5K6lL9ENKnvIc/DFC
        xf2frYXbNwyZeidvZuhmRG2bkkH57cahf8NENv4+pwjRIWy6Vk2HyOFPoDRzFgHi93UVjl
        tULfrxmIn2kT5xVmHEggwPuyL9BHXi5szoZtX3ASW8T9qZZHSEHkhi2F0+5rJw==
From:   Marius Hoch <mail@mariushoch.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH] iio: light: al3320a: Handle ACPI device CALS0001
Date:   Thu, 20 Apr 2023 20:23:14 +0200
Message-Id: <20230420182314.53796-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sensor can be found as CALS0001 on the Lenovo Yoga
Tablet 2 series.

Tested on a Lenovo Yoga Tablet 2 1051-F.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/iio/light/al3320a.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 9ff28bbf34bb..ffcb65cbc125 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -247,11 +247,18 @@ static const struct of_device_id al3320a_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, al3320a_of_match);
 
+static const struct acpi_device_id al3320a_acpi_match[] = {
+	{"CALS0001"},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, al3320a_acpi_match);
+
 static struct i2c_driver al3320a_driver = {
 	.driver = {
 		.name = AL3320A_DRV_NAME,
 		.of_match_table = al3320a_of_match,
 		.pm = pm_sleep_ptr(&al3320a_pm_ops),
+		.acpi_match_table = al3320a_acpi_match,
 	},
 	.probe_new	= al3320a_probe,
 	.id_table	= al3320a_id,

base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f
-- 
2.39.2

