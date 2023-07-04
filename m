Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C176746AE8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjGDHnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjGDHnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:43:39 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9B3E73;
        Tue,  4 Jul 2023 00:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688456612;
  x=1719992612;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=fSDO3rrBra1awm9kf+KLRv/kWybe/6y7zQStYPKcuJE=;
  b=PlI8YPbsUZPf8lQcW/lE5uR9+rbGO5Iu3Fq+IU+obsG70Gn1mMRUUtK+
   o/Yuz5qcOW6J/BglKElPRCnk7iLF+h46Cz8Jl8esbeCfW51E8l8pxkApj
   D6Efne75hS1XdB8zqt6sIdEuDPccGp/aIEGS3Qtqx+F5bI9hj3TaJQHV1
   kio0rkbB5WZhucnv1YcMRhzHcxk/tHIknnrRS7gg0ZN6YSayVzG4sJMn+
   d9ku7msHD8V8YlpdM8+/QocjezLbnO6h8rRU5m8qIJOR9Du8rvnKNQ6HN
   AraErZt+0po4UyuOV7M8mV3fC5FRiATOwJP/ur5lTMHhyawOnetx9pUUB
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Tue, 4 Jul 2023 09:43:29 +0200
Subject: [PATCH] power: supply: Propagate of_node to child device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230704-power-of-v1-1-cc82d2eda65b@axis.com>
X-B4-Tracking: v=1; b=H4sIAKDNo2QC/x2NQQrDMAwEvxJ0rsB1DQn9SunBStaNLlaQoS2E/
 L1Oj7PMMjs1uKLRfdjJ8damVjtcLwPNa64vsC6dKYZ4C2NIvNkHzlY4IWYJIkjTQl2X3MDiuc7
 reShm6Zw3R9Hvv/B4HscPzuYD0nEAAAA=
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the dynamically created power supply device sets its
->of_node if the parent device has one.  This brings it in line with
several other subsystems (see git grep 'of_node =.*parent.*of_node') and
allows easier identification of the device from udev rules and similar.

Before this patch:

 /sys/class/power_supply# ls -l bq256xx-battery/of_node
 ls: cannot access 'bq256xx-battery/of_node': No such file or directory
 # ls -l bq256xx-battery/hwmon1/of_node
 ls: cannot access 'bq256xx-battery/hwmon1/of_node': No such file or directory

After:

 /sys/class/power_supply# ls -l bq256xx-battery/of_node
 lrwxrwxrwx 1 root root 0 May 17 09:14 bq256xx-battery/of_node ->
 ../../../../../../../../firmware/devicetree/base/virtio@1/i2c/bq25619@09
 # ls -l bq256xx-battery/hwmon1/of_node
 lrwxrwxrwx 1 root root 0 May 17 09:14 bq256xx-battery/hwmon1/of_node ->
 ../../../../../../../../../firmware/devicetree/base/virtio@1/i2c/bq25619@09

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/power/supply/power_supply_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 3791aec69ddc6..8769d82dd9c3d 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1368,6 +1368,7 @@ __power_supply_register(struct device *parent,
 	dev->class = power_supply_class;
 	dev->type = &power_supply_dev_type;
 	dev->parent = parent;
+	dev->of_node = parent->of_node;
 	dev->release = power_supply_dev_release;
 	dev_set_drvdata(dev, psy);
 	psy->desc = desc;

---
base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
change-id: 20230704-power-of-4e2ab0bbe48d

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

