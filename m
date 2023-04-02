Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA26D3784
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 13:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjDBLNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjDBLNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 07:13:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D73AF0C
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 04:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680433980; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SYastVuLe40ctMEpBc+3EC5HSgeIB+LitNtZaGybWM39JT6okEygDcQkWXwRiuv5Hj
    ePST8azQTVjkhZNpaN08HZOPUs3PX9qQEgGjir5sBOhfuYjLuoY8BBgq+1fzrJRMkgGh
    rcg5V+KWWRsgxv75xzADt+N8KuzKsDsL7lUPjsAo4NtfIWK8+pkwHmRR8WTTvUnxEOK1
    9kw8ncONK6h+nn806oylqV5VdIH4IdJnTTdzVomAEMj9ckEdbeuJ9zyyo3CLVB48AUyD
    oV/4DberP64ZWOeLvpJ20jkG6Olasol2o0RVtUS7ztnhBvUi3+2QY4CMONa1uzr5C9+y
    iy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680433980;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=20X3HFLD0PCIwckyuLnAErqiyt22kmiUi0m0jrtysMQ=;
    b=QdsFMRDX6aki/NAkRUhqsBkanG+cQHP/HkcinRdvdr/RPJIWjdZxGu/qngOHy7wU0U
    RF9IMQO3z/ebFTWAAIPKrlhytyPa9ahmE+uMwkQ0vzF6Y2a+5LTbrRAxfvNnpZ3myb+N
    P5HZoVBtzq25IAl+xaWZz9xehItpCiTPUQDNLaCiioOVCQIdUuMPIh1Yq/8t7d2o04NY
    Sp/YyGvoyOoBvK+dqZ8JZ6uv/tPB+memyX8ThA6EwJHUDItX7EzT0k8c/ZdcAQAo1XQx
    eJmAzrooORkFvO4Q+YRhWJqgqNaO1wEVBS3/vFP6mrGJ42zAFoWNkSoByKNht0HXIDaj
    rW2Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680433980;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=20X3HFLD0PCIwckyuLnAErqiyt22kmiUi0m0jrtysMQ=;
    b=K41SYxjIzYcgic5+TD9LYCtNs90pmQleRmBY3//U/qzuhpXAjedpumWGoV3J/CNMqG
    PIdi6Vi0u5vTDhrfzw8dJVJJgNUxHrFlMkonBsjfRFzukdYRRc9zH0D5jeZSFTIkGd+N
    XpguKMszMMvUcyBlWJiXXrPM2yWgVUqh0c/5TWEmus2HXH5vGZTDGCpI/6JPyvY9jGx9
    +EJjcyRoCkMOD9lV2SFA+YSmw5cEWfmnyS3O6iSFGSLOP+lyVgqmxw8rFJTwZuv+LEtp
    7q9oOjjT7qaO8z4T8iWCDh9KE6+25Q966tY2y78kMEK5atQYDfQRnvhc0x1P/f2OzzGl
    1Opg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1iTDUhfN4hi3qVZq2PJ"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 49.3.1 DYNA|AUTH)
    with ESMTPSA id R24ce1z32BD0wL0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 2 Apr 2023 13:13:00 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        NeilBrown <neilb@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] leds: tca6507: fix error handling of using fwnode_property_read_string
Date:   Sun,  2 Apr 2023 13:12:59 +0200
Message-Id: <cbae7617db83113de726fcc423a805ebaa1bfca6.1680433978.git.hns@goldelico.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 96f524105b9c ("leds: tca6507: use fwnode API instead of OF")

changed to fwnode API but did not take into account that a missing property
"linux,default-trigger" now seems to return an error and as a side effect
sets value to -1. This seems to be different from of_get_property() which
always returned NULL in any case of error.

Neglecting this side-effect leads to

[   11.201965] Unable to handle kernel paging request at virtual address ffffffff when read

in the strcmp() of led_trigger_set_default() if there is no led-trigger
defined in the DTS.

I don't know if this was recently introduced somewhere in the fwnode lib
or if the effect was missed in initial testing. Anyways it seems to be a
bug to ignore the error return value of an optional value here in the
driver.

Fixes: 96f524105b9c ("leds: tca6507: use fwnode API instead of OF")
Cc: Marek Behún <kabel@kernel.org>
Cc: NeilBrown <neilb@suse.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/leds/leds-tca6507.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
index 07dd12686a696..634cabd5bb796 100644
--- a/drivers/leds/leds-tca6507.c
+++ b/drivers/leds/leds-tca6507.c
@@ -691,8 +691,9 @@ tca6507_led_dt_init(struct device *dev)
 		if (fwnode_property_read_string(child, "label", &led.name))
 			led.name = fwnode_get_name(child);
 
-		fwnode_property_read_string(child, "linux,default-trigger",
-					    &led.default_trigger);
+		if (fwnode_property_read_string(child, "linux,default-trigger",
+						&led.default_trigger))
+			led.default_trigger = NULL;
 
 		led.flags = 0;
 		if (fwnode_device_is_compatible(child, "gpio"))
-- 
2.38.1

