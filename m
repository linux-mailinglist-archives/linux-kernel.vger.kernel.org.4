Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6054568FC8D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBIBQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjBIBQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:16:42 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1257CA5E3;
        Wed,  8 Feb 2023 17:16:39 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 1522B421;
        Wed,  8 Feb 2023 17:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1675905399;
        bh=4fufzuT0XEbDZ7/n77MQbHSDfZq8tIFpOdmjNWCtVwQ=;
        h=From:To:Cc:Subject:Date:From;
        b=bNYvWYkTG2kGbLjCcdyN2z5G03oOqNy+AHJ19gIAfThi5LU04zPqeggpnoDZrSDUz
         rQEK0g43zCkLA4INkrcHcMGM4WqQ1HZpaCSNl+g6Tgo553srH54WlYD1yvUX1UEDxS
         IXKOBmmAxJS6TjHMW8C60M8yLGdYkA3A6iyCMWAQ=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Guenter Roeck <linux@roeck-us.net>, openbmc@lists.ozlabs.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] hwmon: (peci/cputemp) Number cores as seen by host system
Date:   Wed,  8 Feb 2023 17:16:32 -0800
Message-Id: <20230209011632.32668-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        SUBJ_AS_SEEN autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While porting OpenBMC to a new platform with a Xeon Gold 6314U CPU
(Ice Lake, 32 cores), I discovered that the core numbering used by the
PECI interface appears to correspond to the cores that are present in
the physical silicon, rather than those that are actually enabled and
usable by the host OS (i.e. it includes cores that the chip was
manufactured with but later had fused off).

Thus far the cputemp driver has transparently exposed that numbering
to userspace in its 'tempX_label' sysfs files, making the core numbers
it reported not align with the core numbering used by the host system,
which seems like an unfortunate source of confusion.

We can instead use a separate counter to label the cores in a
contiguous fashion (0 through numcores-1) so that the core numbering
reported by the PECI cputemp driver matches the numbering seen by the
host.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---

Offhand I can't think of any other examples of side effects of that
manufacturing detail (fused-off cores) leaking out in
externally-visible ways, so I'd think it's probably not something we
really want to propagate further.

I've verified that at least on the system I'm working on the numbering
provided by this patch aligns with the host's CPU numbering (loaded
each core individually one by one and saw a corresponding temperature
increase visible via PECI), but I'm not sure if that relationship is
guaranteed to hold on all parts -- Iwona, do you know if that's
something we can rely on?

This patch also leaves the driver's internal core tracking with the
"physical" numbering the PECI interface uses, and hence it's still
sort of visible to userspace in the form of the hwmon channel numbers
used in the names of the sysfs attribute files.  If desired we could
also change that to keep the tempX_* file numbers contiguous as well,
though it would necessitate a bit of additional remapping in the
driver to translate between the two.

 drivers/hwmon/peci/cputemp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
index 30850a479f61..6b4010cbbfdf 100644
--- a/drivers/hwmon/peci/cputemp.c
+++ b/drivers/hwmon/peci/cputemp.c
@@ -400,14 +400,15 @@ static int init_core_mask(struct peci_cputemp *priv)
 static int create_temp_label(struct peci_cputemp *priv)
 {
 	unsigned long core_max = find_last_bit(priv->core_mask, CORE_NUMS_MAX);
-	int i;
+	int i, corenum = 0;
 
 	priv->coretemp_label = devm_kzalloc(priv->dev, (core_max + 1) * sizeof(char *), GFP_KERNEL);
 	if (!priv->coretemp_label)
 		return -ENOMEM;
 
 	for_each_set_bit(i, priv->core_mask, CORE_NUMS_MAX) {
-		priv->coretemp_label[i] = devm_kasprintf(priv->dev, GFP_KERNEL, "Core %d", i);
+		priv->coretemp_label[i] = devm_kasprintf(priv->dev, GFP_KERNEL,
+							 "Core %d", corenum++);
 		if (!priv->coretemp_label[i])
 			return -ENOMEM;
 	}
-- 
2.39.1.236.ga8a28b9eace8

