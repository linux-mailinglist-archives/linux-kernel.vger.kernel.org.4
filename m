Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB70614441
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKAF3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKAF25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:28:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95F25C4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:28:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y69so20339933ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4nRfPUFH4kRVISRtuRHDVjH66/Est6HwL+PfPdOnJw=;
        b=gHsVqSSXbjlfgoXdIUngrHxYLJiDMWrgDU8eRfrsl9olc2PPXsQSKZxrUid+Jg0yse
         JyPJxnCf+r3nh7bt9neMyolBdj71sMEJ8wCKt5svEZ+1JCUCSYXRq/fWpBZ0OdPOlxD7
         POAslB5zxfsreOUhymZtQHX7IhhorIA1nAeKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4nRfPUFH4kRVISRtuRHDVjH66/Est6HwL+PfPdOnJw=;
        b=Z5q5cSQvlKKo9yIBaglrV8DKOleKL4xGxRu6ZNyRB2h0dTwTe+NoTNsSRtxJqb36Ip
         7uCEk2JfrpJdeRPT6aRQgdlcGenD5eSFiezwyTx30x0e+a5dr0p04zkAwT1pYszRKVr2
         5XKJAp5plTT/s/QqO3oihS342RK0ZTir4+uVkuidrPBWa1/dnFXDcp6F8FMCNCunKy/m
         nCtXKa/Ag1p2ShD7JelBUN4OSl2FH1R8epNKJwReyMtMGi4EXdEjEsQJqMG15BJslnac
         SrbSXOYZxUlrd9G+Wp+mweflYkCIQWN5lGVI1vaJZUJHKWkn1fouEHbCMTNH2CclqFXU
         KPeQ==
X-Gm-Message-State: ACrzQf2h+z/BV+9dRlabW7UdE+YUX1NXoJB6Fy1ZHqW8D+I8ScA/uvDi
        4ObI4rkc3WvylMeWRq5+u7t+7g==
X-Google-Smtp-Source: AMsMyM6PYFG0XOM1w5cDima8wlXSsT9qCj5+c6xJQsms50vzslJLn24hxhNEfiecg4AYNGljc0pWhQ==
X-Received: by 2002:a50:ec0a:0:b0:461:c0ca:a0bc with SMTP id g10-20020a50ec0a000000b00461c0caa0bcmr17301489edr.306.1667280534869;
        Mon, 31 Oct 2022 22:28:54 -0700 (PDT)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id qo14-20020a170907874e00b0078d3f96d293sm3797074ejc.30.2022.10.31.22.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 22:28:54 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 01 Nov 2022 06:28:41 +0100
Subject: [PATCH v1 1/1] media: uvcvideo: Limit power line control for Acer EasyCamera
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221101-easycam-v1-1-71d6409963da@chromium.org>
References: <20221101-easycam-v1-0-71d6409963da@chromium.org>
In-Reply-To: <20221101-easycam-v1-0-71d6409963da@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=IWHoN9NcN24qlf5Cq+y5YFKN7LwR/YB5HAIbEBiKT4E=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjYK6UwGhjegFV+GvO9lFpwxBZQH3gR3z6dq2J+6M8
 c6PFtoeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2CulAAKCRDRN9E+zzrEiKA9D/
 9rMhOTvKgnupcqeU24qBBLnI3lRXrp4RMDJPLcWdb4MHNHbo8a5ukBkw6PYR9Ef0h4sGcLDF2e2Bg5
 iZ8VIxjK/zZxWChS5TYya33kSDW/MjCjslQnaiAu4118f0kzt55V4fThyMuvTuBRYSWRWEClCzvBdq
 9ajNGIjaMo8M6r0oI1S1cmNXNqB8h8oKBkWMEVY+Pz8ek8AhrQURzHROqHWPQz0NmzKWIES06jmioo
 m/kUQSjZgZkt+k8cIbTQD/L9abxGNzbRHRF7opZYUu5bTuHGx9OYY8Bfqu4m8QFe7s1akli/E1qxXm
 US8JHHM3sFg82+Gk7HCnUlr1Pg90Gq9Gs7yM/0pkQX6vbpsjgFdURzN87YdLYM+S+AkmfulySFJUTm
 pthn2O+gxkTOQ8U5I938uhwBrcLTVyutYza5tLYqMZDiqN5xuFh+Z5TCZ498jgLC1Hg1nclJt8ogf5
 KxIxKZhGmvMMeSiSnSrBCddm2g1/jtTXhMmLiAmYolw3zeIAvJ/sN8MOwLjnJVSIjP6Q3QZXIYj5CE
 zjFL3p0lFcfHfrLiX6S0ATvkQEB6+ntkeISO2GL1uHumbmvoZh2JkafXdRzArTRCIg6uCkDaRHE/mT
 HW+tssGHeIwEmPsT0Bo874k7AEKi/iwQXLfqMnw04dLyieI4KjLyrSMWIRQA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device does not implement the power line control correctly. Add a
corresponding control mapping override.

Bus 003 Device 002: ID 5986:1180 Acer, Inc EasyCamera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x5986 Acer, Inc
  idProduct          0x1180
  bcdDevice           56.04
  iManufacturer           3 Bison
  iProduct                1 EasyCamera
  iSerial                 2
  bNumConfigurations      1

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 215fb483efb0..cca3012c8912 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2994,6 +2994,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
+	/* Acer EasyCamera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x5986,
+	  .idProduct		= 0x1180,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_limited },
 	/* Intel RealSense D4M */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,

-- 
b4 0.11.0-dev-d93f8
