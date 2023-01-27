Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A526667F0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjA0WDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA0WDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:03:47 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C1468F;
        Fri, 27 Jan 2023 14:03:46 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id r132so5279335oif.10;
        Fri, 27 Jan 2023 14:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/teSsHNsavWnDNNgrX8hnWHGmHQHrqvMQrKQ04UHE64=;
        b=mMcFkhfo8wlJqADF5B4YKovplIFCJPWL2GQKW8L37yMHxyX4YnaCSwc7m5IeU7eJgS
         sr8oTnT8DM+SiXiVnk0E+B/1HB/kldyB/Fln95gLRh2HBKzHyJ5ji5K9FFWefgRahy84
         qA6OpQCcEp2HNe+RMVYc77bsUFipcUng92FhvrtPoYDhx+JLO9zSSxy16yPpAhkrqSl9
         H2qrP/5awD9KFuo/B13innvcnq1qUuLM+gebqXYwo4zAHDxIdSSu5fF3nO83fwqlFAlW
         M8A7/w8VZMmdZBllOJHIqsmZU8dCtKMI8kSEmsQ50aq2vN9Eu3HA/eXSwFaSpeAfy2CQ
         02vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/teSsHNsavWnDNNgrX8hnWHGmHQHrqvMQrKQ04UHE64=;
        b=WSvD/SmUUhXE5ZkiaiVYClYVy2t31XQIc59DVtdgqVIPCAs2EoK24xJOTU69gv1lp2
         6ReKkkS05dA5Uxhm97HOQxDcJdzqLAvNLiBcwjYquGDh3FyaAUvJugYmV/aXb6E7659L
         OF2L31BQkqZz+X3si/K3fUAGHj2UNSiZvv4JPbFrpeyOzW14tT6M9M1Vj6rUVi/jDl6H
         vnh/h5Q4TAfOOypKoM/+9j6EypBEtVmB4+NXw+079HC/kt9zTbT6yFoV6aJ60uhrwnmY
         F95s9ruWKPaxam7UgAi5lr460+HtMuEVm2QaSbvA5UFfqnGSN9NKiFoTTbBW7FHtzldK
         avmw==
X-Gm-Message-State: AFqh2krFFl1ogC5qQJgzyyeDXfLKA4NnfId4z7NxN4MwqVqTfzKQMOK7
        o4iI01LDYRfWt/z/OhEkkFdZ3NB+lRAKrQ==
X-Google-Smtp-Source: AMrXdXtatznKE2NBRCLTJIYPSg8EopSKD6q+WFE/TgXqjhFMAAurBezK5jYrg7ph23cz7kL2XgQDLA==
X-Received: by 2002:aca:d80a:0:b0:368:8773:5fd3 with SMTP id p10-20020acad80a000000b0036887735fd3mr20242191oig.16.1674857024748;
        Fri, 27 Jan 2023 14:03:44 -0800 (PST)
Received: from [192.168.50.134] (99-176-3-182.lightspeed.brhmal.sbcglobal.net. [99.176.3.182])
        by smtp.gmail.com with ESMTPSA id r131-20020acada89000000b0035aa617156bsm2058229oig.17.2023.01.27.14.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 14:03:44 -0800 (PST)
Message-ID: <823df262-aa1d-4340-666f-07b991fce64b@gmail.com>
Date:   Fri, 27 Jan 2023 16:03:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Walt Holman <waltholman09@gmail.com>
Subject: [PATCH] HID: quirks: Add quirk for Logitech G923 Xbox steering wheel
To:     linux-input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch adds support for the Logitech G923 Xbox edition steering
wheel.

-Walt

diff -uprN linux-master-source/drivers/hid/hid-ids.h linux-master-target/drivers/hid/hid-ids.h
--- linux-master-source/drivers/hid/hid-ids.h	2023-01-27 15:18:14.000000000 -0600
+++ linux-master-target/drivers/hid/hid-ids.h	2023-01-27 15:50:24.077639994 -0600
@@ -819,6 +819,7 @@
  #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO	0xc22e
  #define USB_DEVICE_ID_LOGITECH_G29_WHEEL	0xc24f
  #define USB_DEVICE_ID_LOGITECH_G920_WHEEL	0xc262
+#define USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL	0xc26e
  #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
  #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
  #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
diff -uprN linux-master-source/drivers/hid/hid-logitech-hidpp.c linux-master-target/drivers/hid/hid-logitech-hidpp.c
--- linux-master-source/drivers/hid/hid-logitech-hidpp.c	2023-01-27 15:18:14.000000000 -0600
+++ linux-master-target/drivers/hid/hid-logitech-hidpp.c	2023-01-27 15:50:24.077639994 -0600
@@ -4347,6 +4347,9 @@ static const struct hid_device_id hidpp_
  	{ /* Logitech G920 Wheel over USB */
  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
  		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
+	{ /* Logitech G923 Wheel (Xbox version) over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL),
+		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS },
  	{ /* Logitech G Pro Gaming Mouse over USB */
  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
  
