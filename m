Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7F26193C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiKDJnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKDJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:43:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D48526AF7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:43:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l11so6785007edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2Rj7oXeRCyveRfch3/Fx7c6AIRiPDkNQdj+nNAZunY=;
        b=J6DehIQ+t0c6xRVWAsjD/274gbzh90pS2iMg0Nyhw5utxaEe7PO1a8JmVlqpkgqoZt
         PR3qcMo0Q5SvxqhC3esdrNoiRL7YQjyVe9mgngfwvudYc6GKHJw+huZ09Z1ChEPccshY
         WB2taB/gmU0O5JOFXuWDBJ5o53QdEQ4EDZQnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2Rj7oXeRCyveRfch3/Fx7c6AIRiPDkNQdj+nNAZunY=;
        b=F3oS27SnvxskOOhiSxd50sJQh3X+Bh5hcYvzGxWWefmc7igNBiYGiD6ZoqVn9au8BH
         ElBp8ANSMW68KfksHA6AgzziEaPDe/VJ4UzTMOfIeVIDnjvJlje2UUHmaDWagTZCXvqe
         f2m7nDA/88uiE1Up4Qbmhm9hscmDqj8CiHykaCic4FtwnXEAunlqkgFRGYZoPc2DXzfN
         4bbJdi9qFKaOcLQ3o63yQ8hUk/w/hLvtUI8G0uQ3zgM+F4Bw9S4AelKh61ASSG4oL9hq
         PRN84g1erWP2jXIxq3M2JswFNc0ngl9bRCUOnSWLOLO3JocfhGvmMqHaj4o6N8Hg3uVv
         yILw==
X-Gm-Message-State: ACrzQf0gsVcVqQFAsNm4aIFwgTxUNgEMRdHNtYyyR6aKnDPxYmzSVNjv
        pWvdqM+X2nHSSynQSWnMODyrHPfm/NhWiEK4
X-Google-Smtp-Source: AMsMyM76XLEnDCNl4o1OhzzXxknOqcX+Ro2CY517yEDpFaxw3sg3j4ubowxK7Fw7Ea+Fa01B7D8tFQ==
X-Received: by 2002:a05:6402:3223:b0:461:8635:e5c with SMTP id g35-20020a056402322300b0046186350e5cmr34923977eda.303.1667554990152;
        Fri, 04 Nov 2022 02:43:10 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:943d:d0b8:228:b5e0])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090668ce00b0078b03d57fa7sm1561653ejr.34.2022.11.04.02.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:43:09 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 04 Nov 2022 10:42:49 +0100
Subject: [PATCH v2 1/2] media: uvcvideo: Limit power line control for Acer EasyCamera
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221101-easycam-v2-1-5956414a608c@chromium.org>
References: <20221101-easycam-v2-0-5956414a608c@chromium.org>
In-Reply-To: <20221101-easycam-v2-0-5956414a608c@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=WAXYaKlS+U0BAisoNzFRqw7KfOhvLdljPgk5tEiOIao=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjZN6lWo0x/AZhYJZ6S+ONUrKArm+vMID97q/2XRSD
 mTTVNWWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2TepQAKCRDRN9E+zzrEiFTeEA
 CSAYYHN/OtETAgjViXi7g5y0eOzD6L5FmshWWgpgWZus64ShD1PKEkhS64B4EAP1zcQrPMoTosnihh
 l8P/8wJhoF+lj1ZBe12xeYki0FTzyCgF62jplS3XRBMT7hgiZzWEZOBa4qHE9gJH8RvpQaMmvUokAI
 xB3UJF1Y9iH3qbw6ox0C+C6m9fJ3N1U1EDz4qZcMcH2wqaZkVdNvmvycMzAFWJDAzNipMwp9/rupNg
 QsxxiQqoDCCURk/Qe/URwyX3v9EDgn0qV3CPJtsSQ8KXVZSnByJGibxmgY4Iz3fJ8ifyW6D2PtXPjN
 hDlEBfrwCoNRgEhmeHdXooD7ORy9k3je5mHlI3eP3mR0X6+mYxFJk5TOzi2pzoQpnoBafaMv/fWLwl
 OYq5vaoOgCMyQIdqm3ZOr5ZwhzTriXoSE++8DFQQRTl1Rv8iXmuM4KBiAsKSIrndYAzJ6IqLhmxnLk
 SglAwvG0aW1fl9oLgNgQTjqXgzzBVChGILd2R6+lINJ2FXPY+mebQIi8TePMGDLn+1Gsqb+bfYDpwe
 F4P6BEs8j1ZG4L5WS/ABRH7oWaXOs0wgcqPg3LU31z+okroHJAEubwXpAN4L9AHqFDzmWnlRPJrVpP
 T4jrt7QzOQxu4OtIwWCThXQOZPYIpVOveueKcECvS/G/otBKzZ87vKAnd1WA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

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
