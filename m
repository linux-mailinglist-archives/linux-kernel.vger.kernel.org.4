Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA52742D27
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjF2TRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjF2TRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:17:38 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD27618522
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:09:10 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b2e1023f30so913211a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688065750; x=1690657750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCd0ZqRIeqSfHypcZSJT9sdEc2KUqKzeoFloOSN5wUU=;
        b=gj+Rqltr8TMqzRNLZwkI0jF5Qk+z1DvnSy2HVmWU7tWGU9a1t+fqdCCSk3RrCOZ9Hn
         2c1S9c+RCtdqm2t3HwfbGKxOuBMpyhkW5GlhacTVJP7YROT6XF8OacQZqpjUTEUzPxEy
         ENqwStGp8tYCaLRCz28oQ/1Y8c448G3qipDKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688065750; x=1690657750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCd0ZqRIeqSfHypcZSJT9sdEc2KUqKzeoFloOSN5wUU=;
        b=MQ6RMSfV63Pxr4NlPdhNDGRwYc7SD4+nhn8dURB5my9jRXSVRht+6oDtWTqGZ3IaCQ
         oFCnvTP4P1FjGBxx0x4hL29MMPn1gVd1lP8SxnMNmOvt9BiwUITOtP5RgkdjRyQ9MIGX
         uIA0ph6U3Bvg/5Ea0ZkvtaUchkZvo+2+XlZYhA/nNBIjrkS+oz5p68MHNFXfG0wXCTDz
         Q/BwdcjJm2VtOiepuDHcGVqfDgCTicYgKxdQRgHuy8ypF2q2pp050MLp42xSS83AfyBy
         ctnsNO4XjrWSbYicmMkOUQlq3pO/j4izeOn+DT5Q2KBdaqGVV0Hvoq9dUgoJZycjoMYG
         4n5Q==
X-Gm-Message-State: AC+VfDwaLD9xKV+DP88JRGmGESYeeF4I+xx7PPgHV1J484Xn2EfgGYv8
        QWg00QMq7WBP4eA0IfWY58eYTQ==
X-Google-Smtp-Source: ACHHUZ6CEmx7u36kLT975Pivf2ZP9DGnCLcU7MTQcaNOh5YCzeld46GR+e5ZE+788N3ZC2z3j/70cA==
X-Received: by 2002:aca:d12:0:b0:39b:5968:deb9 with SMTP id 18-20020aca0d12000000b0039b5968deb9mr251865oin.39.1688065750145;
        Thu, 29 Jun 2023 12:09:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f4-20020a655504000000b0055af87fbb2fsm4874588pgr.27.2023.06.29.12.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:09:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?q?J=C3=B3=20=C3=81gila=20Bitsch?= <jgilab@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] usb: ch9: Replace bmSublinkSpeedAttr 1-element array with flexible array
Date:   Thu, 29 Jun 2023 12:09:00 -0700
Message-Id: <20230629190900.never.787-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"),
UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
bmSublinkSpeedAttr will trigger a warning, so make it a proper flexible
array. Add a union to keep the struct size identical for userspace in
case anything was depending on the old size.

False positive warning was:

UBSAN: array-index-out-of-bounds in drivers/usb/host/xhci-hub.c:231:31 index 1 is out of range for type '__le32 [1]'

for this line of code:

	ssp_cap->bmSublinkSpeedAttr[offset++] = cpu_to_le32(attr);

Reported-by: Borislav Petkov <bp@alien8.de>
Closes: https://lore.kernel.org/lkml/2023062945-fencing-pebble-0411@gregkh/
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/usb/ch9.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index b17e3a21b15f..3ff98c7ba7e3 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -981,7 +981,11 @@ struct usb_ssp_cap_descriptor {
 #define USB_SSP_MIN_RX_LANE_COUNT		(0xf << 8)
 #define USB_SSP_MIN_TX_LANE_COUNT		(0xf << 12)
 	__le16 wReserved;
-	__le32 bmSublinkSpeedAttr[1]; /* list of sublink speed attrib entries */
+	union {
+		__le32 legacy_padding;
+		/* list of sublink speed attrib entries */
+		__DECLARE_FLEX_ARRAY(__le32, bmSublinkSpeedAttr);
+	};
 #define USB_SSP_SUBLINK_SPEED_SSID	(0xf)		/* sublink speed ID */
 #define USB_SSP_SUBLINK_SPEED_LSE	(0x3 << 4)	/* Lanespeed exponent */
 #define USB_SSP_SUBLINK_SPEED_LSE_BPS		0
-- 
2.34.1

