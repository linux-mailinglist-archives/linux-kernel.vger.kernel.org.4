Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5517B6DA3A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbjDFUlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbjDFUlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:41:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7CB449;
        Thu,  6 Apr 2023 13:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B5963F57;
        Thu,  6 Apr 2023 20:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DAEC4339C;
        Thu,  6 Apr 2023 20:37:14 +0000 (UTC)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oded Gabbay <ogabbay@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marius Zachmann <mail@mariuszachmann.de>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Rudolf Marek <r.marek@assembler.cz>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonas Malaco <jonas@protocubo.io>,
        Aleksandr Mezin <mezin.alexander@gmail.com>,
        Derek John Clark <derekjohn.clark@gmail.com>,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, Iwona Winiarska <iwona.winiarska@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Walle <michael@walle.cc>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Agathe Porte <agathe.porte@nokia.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        patches@opensource.cirrus.com, openbmc@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 48/68] hwmon: nzxt: constify pointers to hwmon_channel_info
Date:   Thu,  6 Apr 2023 22:35:29 +0200
Message-Id: <20230406203530.3012191-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406203103.3011503-1-krzysztof.kozlowski@linaro.org>
References: <20230406203103.3011503-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Statically allocated array of pointed to hwmon_channel_info can be made
const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/nzxt-kraken2.c | 2 +-
 drivers/hwmon/nzxt-smart2.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nzxt-kraken2.c b/drivers/hwmon/nzxt-kraken2.c
index 89f7ea4f42d4..428c77b5fce5 100644
--- a/drivers/hwmon/nzxt-kraken2.c
+++ b/drivers/hwmon/nzxt-kraken2.c
@@ -86,7 +86,7 @@ static const struct hwmon_ops kraken2_hwmon_ops = {
 	.read_string = kraken2_read_string,
 };
 
-static const struct hwmon_channel_info *kraken2_info[] = {
+static const struct hwmon_channel_info * const kraken2_info[] = {
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	HWMON_CHANNEL_INFO(fan,
diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
index e5edf8071f39..7aa586eb74be 100644
--- a/drivers/hwmon/nzxt-smart2.c
+++ b/drivers/hwmon/nzxt-smart2.c
@@ -663,7 +663,7 @@ static const struct hwmon_ops nzxt_smart2_hwmon_ops = {
 	.write = nzxt_smart2_hwmon_write,
 };
 
-static const struct hwmon_channel_info *nzxt_smart2_channel_info[] = {
+static const struct hwmon_channel_info * const nzxt_smart2_channel_info[] = {
 	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL),
-- 
2.34.1

