Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3862368CE3F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjBGEgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjBGEgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:36:06 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F0315C91;
        Mon,  6 Feb 2023 20:36:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v23so14468641plo.1;
        Mon, 06 Feb 2023 20:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bup6e+WzvQ8NPU4YhZ6qzaE0CJd4EEGm6MEkaO+ZXU=;
        b=SW7gMHNWSmlc0Z+ueV4X5LXuHra+aPulCAFIwkF0UcoLBJ0RtnzybkxCDmMV59VRMD
         OReDdFaEQSW0keDu60BQrMNSY8+Psrn6hb0ySYx4vS1p3r1kSSz4PFHQ14AXxZZD+VLv
         HeXlkmZroStmEQ8m7N/DFNnyTIxx4E9K/0hNx13dYn3joTG8Z3ZXfIOBHyybkSLP+/w0
         3hgVYdMeddzP5vq6NFt2g6u5+FWGPoqNpWrVGKXGBBETdB6TZI6AC5DHPyt5rOkSyZ6C
         +b2dWOqhzaQlHUp0qlFClnf9dK+9gO4mYA6vThj9lPoF9SuFYmUT/o9zLT2X18Tr9nEh
         LjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Bup6e+WzvQ8NPU4YhZ6qzaE0CJd4EEGm6MEkaO+ZXU=;
        b=fs90inD5bEY8dXOXV5+ZsseGG20Shecc0G7Osq4exQYeEJp1G5rrSZamLTbHOxW/Lb
         jWMvdIntTkt7ZXgsH2gB+ZDPYXlNllzyIhrLMQwboKrpk9mF7Sf2IO436yA0wyN39h67
         tkMMVq5ts3Uvc3BxbF6WWzCDMOSxVHRlA4diPxiHdDW98imn1zWC8hzIJAIuqLM6sCHp
         MGsuZx2CRZ2KCidnsuQNRir8NnVdFzQwINDy7c6YYfsRjOhbTivdzngb56ocKfVPWQIu
         PyMKVJ59khRDEuhjDjN0K5hFphIeStHGTlH64BEI7dBiuBdljtW4e3kMZeAmHBbSn3s0
         OalA==
X-Gm-Message-State: AO0yUKWQPwPumowe+A6yQ4LOjifwmh5xKS/JIPaJmHOtAxWEqQWEBmDW
        cxB8iME5tHmggSnOxbv2sCE=
X-Google-Smtp-Source: AK7set+DnJ9W+XMIvyx5jNOtr+WiNkWcBJBIgWTOTHpZtoXfG97J+eLnZubUFBroWAvpLyOU0gIntw==
X-Received: by 2002:a05:6a21:789b:b0:b8:5881:5c3b with SMTP id bf27-20020a056a21789b00b000b858815c3bmr2167048pzc.58.1675744563084;
        Mon, 06 Feb 2023 20:36:03 -0800 (PST)
Received: from d.home.yangfl.dn42 ([222.69.200.222])
        by smtp.gmail.com with ESMTPSA id p4-20020a63ab04000000b00499a90cce5bsm6695310pgf.50.2023.02.06.20.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 20:36:02 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] HID: kye: Generate tablet fixup descriptors on the fly
Date:   Tue,  7 Feb 2023 12:33:15 +0800
Message-Id: <20230207043318.23842-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207043318.23842-1-mmyangfl@gmail.com>
References: <20230207043318.23842-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated descriptor structures and make it easier to discover
bugs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/hid/hid-kye.c | 590 +++++++-----------------------------------
 1 file changed, 100 insertions(+), 490 deletions(-)

diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index d8ac16bdb094..03a9ad9057b2 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -15,351 +15,75 @@
 
 #include "hid-ids.h"
 
-/* Original EasyPen i405X report descriptor size */
-#define EASYPEN_I405X_RDESC_ORIG_SIZE	476
-
-/* Fixed EasyPen i405X report descriptor */
-static __u8 easypen_i405x_rdesc_fixed[] = {
-	0x06, 0x00, 0xFF, /*  Usage Page (FF00h),             */
-	0x09, 0x01,       /*  Usage (01h),                    */
-	0xA1, 0x01,       /*  Collection (Application),       */
-	0x85, 0x05,       /*    Report ID (5),                */
-	0x09, 0x01,       /*    Usage (01h),                  */
-	0x15, 0x80,       /*    Logical Minimum (-128),       */
-	0x25, 0x7F,       /*    Logical Maximum (127),        */
-	0x75, 0x08,       /*    Report Size (8),              */
-	0x95, 0x07,       /*    Report Count (7),             */
-	0xB1, 0x02,       /*    Feature (Variable),           */
-	0xC0,             /*  End Collection,                 */
-	0x05, 0x0D,       /*  Usage Page (Digitizer),         */
-	0x09, 0x01,       /*  Usage (Digitizer),              */
-	0xA1, 0x01,       /*  Collection (Application),       */
-	0x85, 0x10,       /*    Report ID (16),               */
-	0x09, 0x20,       /*    Usage (Stylus),               */
-	0xA0,             /*    Collection (Physical),        */
-	0x14,             /*      Logical Minimum (0),        */
-	0x25, 0x01,       /*      Logical Maximum (1),        */
-	0x75, 0x01,       /*      Report Size (1),            */
-	0x09, 0x42,       /*      Usage (Tip Switch),         */
-	0x09, 0x44,       /*      Usage (Barrel Switch),      */
-	0x09, 0x46,       /*      Usage (Tablet Pick),        */
-	0x95, 0x03,       /*      Report Count (3),           */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0x95, 0x04,       /*      Report Count (4),           */
-	0x81, 0x03,       /*      Input (Constant, Variable), */
-	0x09, 0x32,       /*      Usage (In Range),           */
-	0x95, 0x01,       /*      Report Count (1),           */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0x75, 0x10,       /*      Report Size (16),           */
-	0x95, 0x01,       /*      Report Count (1),           */
-	0xA4,             /*      Push,                       */
-	0x05, 0x01,       /*      Usage Page (Desktop),       */
-	0x55, 0xFD,       /*      Unit Exponent (-3),         */
-	0x65, 0x13,       /*      Unit (Inch),                */
-	0x34,             /*      Physical Minimum (0),       */
-	0x09, 0x30,       /*      Usage (X),                  */
-	0x46, 0x7C, 0x15, /*      Physical Maximum (5500),    */
-	0x26, 0x00, 0x37, /*      Logical Maximum (14080),    */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0x09, 0x31,       /*      Usage (Y),                  */
-	0x46, 0xA0, 0x0F, /*      Physical Maximum (4000),    */
-	0x26, 0x00, 0x28, /*      Logical Maximum (10240),    */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0xB4,             /*      Pop,                        */
-	0x09, 0x30,       /*      Usage (Tip Pressure),       */
-	0x26, 0xFF, 0x03, /*      Logical Maximum (1023),     */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0xC0,             /*    End Collection,               */
-	0xC0              /*  End Collection                  */
+static const __u8 easypen_m610x_control_rdesc[] = {
+	0x05, 0x0C,        /*  Usage Page (Consumer),       */
+	0x09, 0x01,        /*  Usage (Consumer Control),    */
+	0xA1, 0x01,        /*  Collection (Application),    */
+	0x85, 0x12,        /*    Report ID (18),            */
+	0x0A, 0x1A, 0x02,  /*    Usage (AC Undo),           */
+	0x0A, 0x79, 0x02,  /*    Usage (AC Redo Or Repeat), */
+	0x0A, 0x2D, 0x02,  /*    Usage (AC Zoom In),        */
+	0x0A, 0x2E, 0x02,  /*    Usage (AC Zoom Out),       */
+	0x14,              /*    Logical Minimum (0),       */
+	0x25, 0x01,        /*    Logical Maximum (1),       */
+	0x75, 0x01,        /*    Report Size (1),           */
+	0x95, 0x04,        /*    Report Count (4),          */
+	0x81, 0x02,        /*    Input (Variable),          */
+	0x95, 0x34,        /*    Report Count (52),         */
+	0x81, 0x01,        /*    Input (Constant),          */
+	0xC0               /*  End Collection               */
 };
 
-/* Original MousePen i608X report descriptor size */
-#define MOUSEPEN_I608X_RDESC_ORIG_SIZE	476
-
-/* Fixed MousePen i608X report descriptor */
-static __u8 mousepen_i608x_rdesc_fixed[] = {
-	0x06, 0x00, 0xFF, /*  Usage Page (FF00h),             */
-	0x09, 0x01,       /*  Usage (01h),                    */
-	0xA1, 0x01,       /*  Collection (Application),       */
-	0x85, 0x05,       /*    Report ID (5),                */
-	0x09, 0x01,       /*    Usage (01h),                  */
-	0x15, 0x80,       /*    Logical Minimum (-128),       */
-	0x25, 0x7F,       /*    Logical Maximum (127),        */
-	0x75, 0x08,       /*    Report Size (8),              */
-	0x95, 0x07,       /*    Report Count (7),             */
-	0xB1, 0x02,       /*    Feature (Variable),           */
-	0xC0,             /*  End Collection,                 */
-	0x05, 0x0D,       /*  Usage Page (Digitizer),         */
-	0x09, 0x01,       /*  Usage (Digitizer),              */
-	0xA1, 0x01,       /*  Collection (Application),       */
-	0x85, 0x10,       /*    Report ID (16),               */
-	0x09, 0x20,       /*    Usage (Stylus),               */
-	0xA0,             /*    Collection (Physical),        */
-	0x14,             /*      Logical Minimum (0),        */
-	0x25, 0x01,       /*      Logical Maximum (1),        */
-	0x75, 0x01,       /*      Report Size (1),            */
-	0x09, 0x42,       /*      Usage (Tip Switch),         */
-	0x09, 0x44,       /*      Usage (Barrel Switch),      */
-	0x09, 0x46,       /*      Usage (Tablet Pick),        */
-	0x95, 0x03,       /*      Report Count (3),           */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0x95, 0x04,       /*      Report Count (4),           */
-	0x81, 0x03,       /*      Input (Constant, Variable), */
-	0x09, 0x32,       /*      Usage (In Range),           */
-	0x95, 0x01,       /*      Report Count (1),           */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0x75, 0x10,       /*      Report Size (16),           */
-	0x95, 0x01,       /*      Report Count (1),           */
-	0xA4,             /*      Push,                       */
-	0x05, 0x01,       /*      Usage Page (Desktop),       */
-	0x55, 0xFD,       /*      Unit Exponent (-3),         */
-	0x65, 0x13,       /*      Unit (Inch),                */
-	0x34,             /*      Physical Minimum (0),       */
-	0x09, 0x30,       /*      Usage (X),                  */
-	0x46, 0x40, 0x1F, /*      Physical Maximum (8000),    */
-	0x26, 0x00, 0x50, /*      Logical Maximum (20480),    */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0x09, 0x31,       /*      Usage (Y),                  */
-	0x46, 0x70, 0x17, /*      Physical Maximum (6000),    */
-	0x26, 0x00, 0x3C, /*      Logical Maximum (15360),    */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0xB4,             /*      Pop,                        */
-	0x09, 0x30,       /*      Usage (Tip Pressure),       */
-	0x26, 0xFF, 0x03, /*      Logical Maximum (1023),     */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0xC0,             /*    End Collection,               */
-	0xC0,             /*  End Collection,                 */
-	0x05, 0x01,       /*  Usage Page (Desktop),           */
-	0x09, 0x02,       /*  Usage (Mouse),                  */
-	0xA1, 0x01,       /*  Collection (Application),       */
-	0x85, 0x11,       /*    Report ID (17),               */
-	0x09, 0x01,       /*    Usage (Pointer),              */
-	0xA0,             /*    Collection (Physical),        */
-	0x14,             /*      Logical Minimum (0),        */
-	0xA4,             /*      Push,                       */
-	0x05, 0x09,       /*      Usage Page (Button),        */
-	0x75, 0x01,       /*      Report Size (1),            */
-	0x19, 0x01,       /*      Usage Minimum (01h),        */
-	0x29, 0x03,       /*      Usage Maximum (03h),        */
-	0x25, 0x01,       /*      Logical Maximum (1),        */
-	0x95, 0x03,       /*      Report Count (3),           */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0x95, 0x05,       /*      Report Count (5),           */
-	0x81, 0x01,       /*      Input (Constant),           */
-	0xB4,             /*      Pop,                        */
-	0x95, 0x01,       /*      Report Count (1),           */
-	0xA4,             /*      Push,                       */
-	0x55, 0xFD,       /*      Unit Exponent (-3),         */
-	0x65, 0x13,       /*      Unit (Inch),                */
-	0x34,             /*      Physical Minimum (0),       */
-	0x75, 0x10,       /*      Report Size (16),           */
-	0x09, 0x30,       /*      Usage (X),                  */
-	0x46, 0x40, 0x1F, /*      Physical Maximum (8000),    */
-	0x26, 0x00, 0x50, /*      Logical Maximum (20480),    */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0x09, 0x31,       /*      Usage (Y),                  */
-	0x46, 0x70, 0x17, /*      Physical Maximum (6000),    */
-	0x26, 0x00, 0x3C, /*      Logical Maximum (15360),    */
-	0x81, 0x02,       /*      Input (Variable),           */
-	0xB4,             /*      Pop,                        */
-	0x75, 0x08,       /*      Report Size (8),            */
-	0x09, 0x38,       /*      Usage (Wheel),              */
-	0x15, 0xFF,       /*      Logical Minimum (-1),       */
-	0x25, 0x01,       /*      Logical Maximum (1),        */
-	0x81, 0x06,       /*      Input (Variable, Relative), */
-	0x81, 0x01,       /*      Input (Constant),           */
-	0xC0,             /*    End Collection,               */
-	0xC0              /*  End Collection                  */
+static const __u8 pensketch_m912_control_rdesc[] = {
+	0x05, 0x0C,        /*  Usage Page (Consumer),        */
+	0x09, 0x01,        /*  Usage (Consumer Control),     */
+	0xA1, 0x01,        /*  Collection (Application),     */
+	0x85, 0x12,        /*    Report ID (18),             */
+	0x14,              /*    Logical Minimum (0),        */
+	0x25, 0x01,        /*    Logical Maximum (1),        */
+	0x75, 0x01,        /*    Report Size (1),            */
+	0x95, 0x08,        /*    Report Count (8),           */
+	0x05, 0x0C,        /*    Usage Page (Consumer),      */
+	0x0A, 0x6A, 0x02,  /*    Usage (AC Delete),          */
+	0x0A, 0x1A, 0x02,  /*    Usage (AC Undo),            */
+	0x0A, 0x01, 0x02,  /*    Usage (AC New),             */
+	0x0A, 0x2F, 0x02,  /*    Usage (AC Zoom),            */
+	0x0A, 0x25, 0x02,  /*    Usage (AC Forward),         */
+	0x0A, 0x24, 0x02,  /*    Usage (AC Back),            */
+	0x0A, 0x2D, 0x02,  /*    Usage (AC Zoom In),         */
+	0x0A, 0x2E, 0x02,  /*    Usage (AC Zoom Out),        */
+	0x81, 0x02,        /*    Input (Variable),           */
+	0x95, 0x30,        /*    Report Count (48),          */
+	0x81, 0x03,        /*    Input (Constant, Variable), */
+	0xC0               /*  End Collection                */
 };
 
-/* Original MousePen i608X v2 report descriptor size */
-#define MOUSEPEN_I608X_V2_RDESC_ORIG_SIZE	482
-
-/* Fixed MousePen i608X v2 report descriptor */
-static __u8 mousepen_i608x_v2_rdesc_fixed[] = {
-	0x06, 0x00, 0xFF,             /*  Usage Page (FF00h),             */
-	0x09, 0x01,                   /*  Usage (01h),                    */
-	0xA1, 0x01,                   /*  Collection (Application),       */
-	0x85, 0x05,                   /*    Report ID (5),                */
-	0x09, 0x01,                   /*    Usage (01h),                  */
-	0x15, 0x80,                   /*    Logical Minimum (-128),       */
-	0x25, 0x7F,                   /*    Logical Maximum (127),        */
-	0x75, 0x08,                   /*    Report Size (8),              */
-	0x95, 0x07,                   /*    Report Count (7),             */
-	0xB1, 0x02,                   /*    Feature (Variable),           */
-	0xC0,                         /*  End Collection,                 */
-	0x05, 0x0D,                   /*  Usage Page (Digitizer),         */
-	0x09, 0x01,                   /*  Usage (Digitizer),              */
-	0xA1, 0x01,                   /*  Collection (Application),       */
-	0x85, 0x10,                   /*    Report ID (16),               */
-	0x09, 0x20,                   /*    Usage (Stylus),               */
-	0xA0,                         /*    Collection (Physical),        */
-	0x14,                         /*      Logical Minimum (0),        */
-	0x25, 0x01,                   /*      Logical Maximum (1),        */
-	0x75, 0x01,                   /*      Report Size (1),            */
-	0x09, 0x42,                   /*      Usage (Tip Switch),         */
-	0x09, 0x44,                   /*      Usage (Barrel Switch),      */
-	0x09, 0x46,                   /*      Usage (Tablet Pick),        */
-	0x95, 0x03,                   /*      Report Count (3),           */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0x95, 0x04,                   /*      Report Count (4),           */
-	0x81, 0x03,                   /*      Input (Constant, Variable), */
-	0x09, 0x32,                   /*      Usage (In Range),           */
-	0x95, 0x01,                   /*      Report Count (1),           */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0x75, 0x10,                   /*      Report Size (16),           */
-	0x95, 0x01,                   /*      Report Count (1),           */
-	0xA4,                         /*      Push,                       */
-	0x05, 0x01,                   /*      Usage Page (Desktop),       */
-	0x55, 0xFD,                   /*      Unit Exponent (-3),         */
-	0x65, 0x13,                   /*      Unit (Inch),                */
-	0x34,                         /*      Physical Minimum (0),       */
-	0x09, 0x30,                   /*      Usage (X),                  */
-	0x46, 0x40, 0x1F,             /*      Physical Maximum (8000),    */
-	0x27, 0x00, 0xA0, 0x00, 0x00, /*      Logical Maximum (40960),    */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0x09, 0x31,                   /*      Usage (Y),                  */
-	0x46, 0x70, 0x17,             /*      Physical Maximum (6000),    */
-	0x26, 0x00, 0x78,             /*      Logical Maximum (30720),    */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0xB4,                         /*      Pop,                        */
-	0x09, 0x30,                   /*      Usage (Tip Pressure),       */
-	0x26, 0xFF, 0x07,             /*      Logical Maximum (2047),     */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0xC0,                         /*    End Collection,               */
-	0xC0,                         /*  End Collection,                 */
-	0x05, 0x01,                   /*  Usage Page (Desktop),           */
-	0x09, 0x02,                   /*  Usage (Mouse),                  */
-	0xA1, 0x01,                   /*  Collection (Application),       */
-	0x85, 0x11,                   /*    Report ID (17),               */
-	0x09, 0x01,                   /*    Usage (Pointer),              */
-	0xA0,                         /*    Collection (Physical),        */
-	0x14,                         /*      Logical Minimum (0),        */
-	0xA4,                         /*      Push,                       */
-	0x05, 0x09,                   /*      Usage Page (Button),        */
-	0x75, 0x01,                   /*      Report Size (1),            */
-	0x19, 0x01,                   /*      Usage Minimum (01h),        */
-	0x29, 0x03,                   /*      Usage Maximum (03h),        */
-	0x25, 0x01,                   /*      Logical Maximum (1),        */
-	0x95, 0x03,                   /*      Report Count (3),           */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0x95, 0x05,                   /*      Report Count (5),           */
-	0x81, 0x01,                   /*      Input (Constant),           */
-	0xB4,                         /*      Pop,                        */
-	0x95, 0x01,                   /*      Report Count (1),           */
-	0xA4,                         /*      Push,                       */
-	0x55, 0xFD,                   /*      Unit Exponent (-3),         */
-	0x65, 0x13,                   /*      Unit (Inch),                */
-	0x34,                         /*      Physical Minimum (0),       */
-	0x75, 0x10,                   /*      Report Size (16),           */
-	0x09, 0x30,                   /*      Usage (X),                  */
-	0x46, 0x40, 0x1F,             /*      Physical Maximum (8000),    */
-	0x27, 0x00, 0xA0, 0x00, 0x00, /*      Logical Maximum (40960),    */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0x09, 0x31,                   /*      Usage (Y),                  */
-	0x46, 0x70, 0x17,             /*      Physical Maximum (6000),    */
-	0x26, 0x00, 0x78,             /*      Logical Maximum (30720),    */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0xB4,                         /*      Pop,                        */
-	0x75, 0x08,                   /*      Report Size (8),            */
-	0x09, 0x38,                   /*      Usage (Wheel),              */
-	0x15, 0xFF,                   /*      Logical Minimum (-1),       */
-	0x25, 0x01,                   /*      Logical Maximum (1),        */
-	0x81, 0x06,                   /*      Input (Variable, Relative), */
-	0x81, 0x01,                   /*      Input (Constant),           */
-	0xC0,                         /*    End Collection,               */
-	0xC0                          /*  End Collection                  */
+static const __u8 easypen_m406xe_control_rdesc[] = {
+	0x05, 0x0C,        /*  Usage Page (Consumer),          */
+	0x09, 0x01,        /*  Usage (Consumer Control),       */
+	0xA1, 0x01,        /*  Collection (Application),       */
+	0x85, 0x12,        /*      Report ID (18),             */
+	0x14,              /*      Logical Minimum (0),        */
+	0x25, 0x01,        /*      Logical Maximum (1),        */
+	0x75, 0x01,        /*      Report Size (1),            */
+	0x95, 0x04,        /*      Report Count (4),           */
+	0x0A, 0x79, 0x02,  /*      Usage (AC Redo Or Repeat),  */
+	0x0A, 0x1A, 0x02,  /*      Usage (AC Undo),            */
+	0x0A, 0x2D, 0x02,  /*      Usage (AC Zoom In),         */
+	0x0A, 0x2E, 0x02,  /*      Usage (AC Zoom Out),        */
+	0x81, 0x02,        /*      Input (Variable),           */
+	0x95, 0x34,        /*      Report Count (52),          */
+	0x81, 0x03,        /*      Input (Constant, Variable), */
+	0xC0               /*  End Collection                  */
 };
 
-/* Original EasyPen M610X report descriptor size */
-#define EASYPEN_M610X_RDESC_ORIG_SIZE	476
-
-/* Fixed EasyPen M610X report descriptor */
-static __u8 easypen_m610x_rdesc_fixed[] = {
+/* Fix indexes in kye_tablet_report_fixup if you change this */
+static const __u8 kye_tablet_rdesc[] = {
 	0x06, 0x00, 0xFF,             /*  Usage Page (FF00h),             */
 	0x09, 0x01,                   /*  Usage (01h),                    */
 	0xA1, 0x01,                   /*  Collection (Application),       */
 	0x85, 0x05,                   /*    Report ID (5),                */
 	0x09, 0x01,                   /*    Usage (01h),                  */
-	0x15, 0x80,                   /*    Logical Minimum (-128),       */
-	0x25, 0x7F,                   /*    Logical Maximum (127),        */
-	0x75, 0x08,                   /*    Report Size (8),              */
-	0x95, 0x07,                   /*    Report Count (7),             */
-	0xB1, 0x02,                   /*    Feature (Variable),           */
-	0xC0,                         /*  End Collection,                 */
-	0x05, 0x0D,                   /*  Usage Page (Digitizer),         */
-	0x09, 0x01,                   /*  Usage (Digitizer),              */
-	0xA1, 0x01,                   /*  Collection (Application),       */
-	0x85, 0x10,                   /*    Report ID (16),               */
-	0x09, 0x20,                   /*    Usage (Stylus),               */
-	0xA0,                         /*    Collection (Physical),        */
-	0x14,                         /*      Logical Minimum (0),        */
-	0x25, 0x01,                   /*      Logical Maximum (1),        */
-	0x75, 0x01,                   /*      Report Size (1),            */
-	0x09, 0x42,                   /*      Usage (Tip Switch),         */
-	0x09, 0x44,                   /*      Usage (Barrel Switch),      */
-	0x09, 0x46,                   /*      Usage (Tablet Pick),        */
-	0x95, 0x03,                   /*      Report Count (3),           */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0x95, 0x04,                   /*      Report Count (4),           */
-	0x81, 0x03,                   /*      Input (Constant, Variable), */
-	0x09, 0x32,                   /*      Usage (In Range),           */
-	0x95, 0x01,                   /*      Report Count (1),           */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0x75, 0x10,                   /*      Report Size (16),           */
-	0x95, 0x01,                   /*      Report Count (1),           */
-	0xA4,                         /*      Push,                       */
-	0x05, 0x01,                   /*      Usage Page (Desktop),       */
-	0x55, 0xFD,                   /*      Unit Exponent (-3),         */
-	0x65, 0x13,                   /*      Unit (Inch),                */
-	0x34,                         /*      Physical Minimum (0),       */
-	0x09, 0x30,                   /*      Usage (X),                  */
-	0x46, 0x10, 0x27,             /*      Physical Maximum (10000),   */
-	0x27, 0x00, 0xA0, 0x00, 0x00, /*      Logical Maximum (40960),    */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0x09, 0x31,                   /*      Usage (Y),                  */
-	0x46, 0x6A, 0x18,             /*      Physical Maximum (6250),    */
-	0x26, 0x00, 0x64,             /*      Logical Maximum (25600),    */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0xB4,                         /*      Pop,                        */
-	0x09, 0x30,                   /*      Usage (Tip Pressure),       */
-	0x26, 0xFF, 0x03,             /*      Logical Maximum (1023),     */
-	0x81, 0x02,                   /*      Input (Variable),           */
-	0xC0,                         /*    End Collection,               */
-	0xC0,                         /*  End Collection,                 */
-	0x05, 0x0C,                   /*  Usage Page (Consumer),          */
-	0x09, 0x01,                   /*  Usage (Consumer Control),       */
-	0xA1, 0x01,                   /*  Collection (Application),       */
-	0x85, 0x12,                   /*    Report ID (18),               */
-	0x14,                         /*    Logical Minimum (0),          */
-	0x25, 0x01,                   /*    Logical Maximum (1),          */
-	0x75, 0x01,                   /*    Report Size (1),              */
-	0x95, 0x04,                   /*    Report Count (4),             */
-	0x0A, 0x1A, 0x02,             /*    Usage (AC Undo),              */
-	0x0A, 0x79, 0x02,             /*    Usage (AC Redo Or Repeat),    */
-	0x0A, 0x2D, 0x02,             /*    Usage (AC Zoom In),           */
-	0x0A, 0x2E, 0x02,             /*    Usage (AC Zoom Out),          */
-	0x81, 0x02,                   /*    Input (Variable),             */
-	0x95, 0x01,                   /*    Report Count (1),             */
-	0x75, 0x14,                   /*    Report Size (20),             */
-	0x81, 0x03,                   /*    Input (Constant, Variable),   */
-	0x75, 0x20,                   /*    Report Size (32),             */
-	0x81, 0x03,                   /*    Input (Constant, Variable),   */
-	0xC0                          /*  End Collection                  */
-};
-
-
-/* Original PenSketch M912 report descriptor size */
-#define PENSKETCH_M912_RDESC_ORIG_SIZE	482
-
-/* Fixed PenSketch M912 report descriptor */
-static __u8 pensketch_m912_rdesc_fixed[] = {
-	0x05, 0x01,                   /*  Usage Page (Desktop),           */
-	0x08,                         /*  Usage (00h),                    */
-	0xA1, 0x01,                   /*  Collection (Application),       */
-	0x85, 0x05,                   /*    Report ID (5),                */
-	0x06, 0x00, 0xFF,             /*    Usage Page (FF00h),           */
-	0x09, 0x01,                   /*    Usage (01h),                  */
 	0x15, 0x81,                   /*    Logical Minimum (-127),       */
 	0x25, 0x7F,                   /*    Logical Maximum (127),        */
 	0x75, 0x08,                   /*    Report Size (8),              */
@@ -381,30 +105,29 @@ static __u8 pensketch_m912_rdesc_fixed[] = {
 	0x95, 0x03,                   /*      Report Count (3),           */
 	0x81, 0x02,                   /*      Input (Variable),           */
 	0x95, 0x04,                   /*      Report Count (4),           */
-	0x81, 0x03,                   /*      Input (Constant, Variable), */
+	0x81, 0x01,                   /*      Input (Constant),           */
 	0x09, 0x32,                   /*      Usage (In Range),           */
 	0x95, 0x01,                   /*      Report Count (1),           */
 	0x81, 0x02,                   /*      Input (Variable),           */
 	0x75, 0x10,                   /*      Report Size (16),           */
-	0x95, 0x01,                   /*      Report Count (1),           */
 	0xA4,                         /*      Push,                       */
 	0x05, 0x01,                   /*      Usage Page (Desktop),       */
-	0x55, 0xFD,                   /*      Unit Exponent (-3),         */
-	0x65, 0x13,                   /*      Unit (Inch),                */
-	0x14,                         /*      Logical Minimum (0),        */
-	0x34,                         /*      Physical Minimum (0),       */
 	0x09, 0x30,                   /*      Usage (X),                  */
-	0x27, 0x00, 0xF0, 0x00, 0x00, /*      Logical Maximum (61440),    */
-	0x46, 0xE0, 0x2E,             /*      Physical Maximum (12000),   */
+	0x27, 0xFF, 0x7F, 0x00, 0x00, /*      Logical Maximum (32767),    */
+	0x34,                         /*      Physical Minimum (0),       */
+	0x47, 0x00, 0x00, 0x00, 0x00, /*      Physical Maximum (0),       */
+	0x65, 0x11,                   /*      Unit (Centimeter),          */
+	0x55, 0x00,                   /*      Unit Exponent (0),          */
+	0x75, 0x10,                   /*      Report Size (16),           */
 	0x81, 0x02,                   /*      Input (Variable),           */
 	0x09, 0x31,                   /*      Usage (Y),                  */
-	0x27, 0x00, 0xB4, 0x00, 0x00, /*      Logical Maximum (46080),    */
-	0x46, 0x28, 0x23,             /*      Physical Maximum (9000),    */
+	0x27, 0xFF, 0x7F, 0x00, 0x00, /*      Logical Maximum (32767),    */
+	0x47, 0x00, 0x00, 0x00, 0x00, /*      Physical Maximum (0),       */
 	0x81, 0x02,                   /*      Input (Variable),           */
 	0xB4,                         /*      Pop,                        */
+	0x05, 0x0D,                   /*      Usage Page (Digitizer),     */
 	0x09, 0x30,                   /*      Usage (Tip Pressure),       */
-	0x14,                         /*      Logical Minimum (0),        */
-	0x26, 0xFF, 0x07,             /*      Logical Maximum (2047),     */
+	0x27, 0xFF, 0x07, 0x00, 0x00, /*      Logical Maximum (2047),     */
 	0x81, 0x02,                   /*      Input (Variable),           */
 	0xC0,                         /*    End Collection,               */
 	0xC0,                         /*  End Collection,                 */
@@ -415,144 +138,44 @@ static __u8 pensketch_m912_rdesc_fixed[] = {
 	0x09, 0x21,                   /*    Usage (Puck),                 */
 	0xA0,                         /*    Collection (Physical),        */
 	0x05, 0x09,                   /*      Usage Page (Button),        */
-	0x75, 0x01,                   /*      Report Size (1),            */
 	0x19, 0x01,                   /*      Usage Minimum (01h),        */
 	0x29, 0x03,                   /*      Usage Maximum (03h),        */
 	0x14,                         /*      Logical Minimum (0),        */
 	0x25, 0x01,                   /*      Logical Maximum (1),        */
+	0x75, 0x01,                   /*      Report Size (1),            */
 	0x95, 0x03,                   /*      Report Count (3),           */
 	0x81, 0x02,                   /*      Input (Variable),           */
 	0x95, 0x04,                   /*      Report Count (4),           */
 	0x81, 0x01,                   /*      Input (Constant),           */
+	0x05, 0x0D,                   /*      Usage Page (Digitizer),     */
+	0x09, 0x32,                   /*      Usage (In Range),           */
 	0x95, 0x01,                   /*      Report Count (1),           */
-	0x0B, 0x32, 0x00, 0x0D, 0x00, /*      Usage (Digitizer In Range), */
-	0x14,                         /*      Logical Minimum (0),        */
-	0x25, 0x01,                   /*      Logical Maximum (1),        */
 	0x81, 0x02,                   /*      Input (Variable),           */
-	0xA4,                         /*      Push,                       */
 	0x05, 0x01,                   /*      Usage Page (Desktop),       */
-	0x75, 0x10,                   /*      Report Size (16),           */
-	0x95, 0x01,                   /*      Report Count (1),           */
-	0x55, 0xFD,                   /*      Unit Exponent (-3),         */
-	0x65, 0x13,                   /*      Unit (Inch),                */
-	0x14,                         /*      Logical Minimum (0),        */
-	0x34,                         /*      Physical Minimum (0),       */
+	0xA4,                         /*      Push,                       */
 	0x09, 0x30,                   /*      Usage (X),                  */
-	0x27, 0x00, 0xF0, 0x00, 0x00, /*      Logical Maximum (61440),    */
-	0x46, 0xE0, 0x2E,             /*      Physical Maximum (12000),   */
+	0x27, 0xFF, 0x7F, 0x00, 0x00, /*      Logical Maximum (32767),    */
+	0x34,                         /*      Physical Minimum (0),       */
+	0x47, 0x00, 0x00, 0x00, 0x00, /*      Physical Maximum (0),       */
+	0x65, 0x11,                   /*      Unit (Centimeter),          */
+	0x55, 0x00,                   /*      Unit Exponent (0),          */
+	0x75, 0x10,                   /*      Report Size (16),           */
 	0x81, 0x02,                   /*      Input (Variable),           */
 	0x09, 0x31,                   /*      Usage (Y),                  */
-	0x27, 0x00, 0xB4, 0x00, 0x00, /*      Logical Maximum (46080),    */
-	0x46, 0x28, 0x23,             /*      Physical Maximum (9000),    */
+	0x27, 0xFF, 0x7F, 0x00, 0x00, /*      Logical Maximum (32767),    */
+	0x47, 0x00, 0x00, 0x00, 0x00, /*      Physical Maximum (0),       */
 	0x81, 0x02,                   /*      Input (Variable),           */
+	0xB4,                         /*      Pop,                        */
 	0x09, 0x38,                   /*      Usage (Wheel),              */
+	0x15, 0xFF,                   /*      Logical Minimum (-1),       */
 	0x75, 0x08,                   /*      Report Size (8),            */
 	0x95, 0x01,                   /*      Report Count (1),           */
-	0x15, 0xFF,                   /*      Logical Minimum (-1),       */
-	0x25, 0x01,                   /*      Logical Maximum (1),        */
-	0x34,                         /*      Physical Minimum (0),       */
-	0x44,                         /*      Physical Maximum (0),       */
 	0x81, 0x06,                   /*      Input (Variable, Relative), */
-	0xB4,                         /*      Pop,                        */
+	0x81, 0x01,                   /*      Input (Constant),           */
 	0xC0,                         /*    End Collection,               */
-	0xC0,                         /*  End Collection,                 */
-	0x05, 0x0C,                   /*  Usage Page (Consumer),          */
-	0x09, 0x01,                   /*  Usage (Consumer Control),       */
-	0xA1, 0x01,                   /*  Collection (Application),       */
-	0x85, 0x12,                   /*    Report ID (18),               */
-	0x14,                         /*    Logical Minimum (0),          */
-	0x25, 0x01,                   /*    Logical Maximum (1),          */
-	0x75, 0x01,                   /*    Report Size (1),              */
-	0x95, 0x08,                   /*    Report Count (8),             */
-	0x05, 0x0C,                   /*    Usage Page (Consumer),        */
-	0x0A, 0x6A, 0x02,             /*    Usage (AC Delete),            */
-	0x0A, 0x1A, 0x02,             /*    Usage (AC Undo),              */
-	0x0A, 0x01, 0x02,             /*    Usage (AC New),               */
-	0x0A, 0x2F, 0x02,             /*    Usage (AC Zoom),              */
-	0x0A, 0x25, 0x02,             /*    Usage (AC Forward),           */
-	0x0A, 0x24, 0x02,             /*    Usage (AC Back),              */
-	0x0A, 0x2D, 0x02,             /*    Usage (AC Zoom In),           */
-	0x0A, 0x2E, 0x02,             /*    Usage (AC Zoom Out),          */
-	0x81, 0x02,                   /*    Input (Variable),             */
-	0x95, 0x30,                   /*    Report Count (48),            */
-	0x81, 0x03,                   /*    Input (Constant, Variable),   */
 	0xC0                          /*  End Collection                  */
 };
 
-/* Original EasyPen M406XE report descriptor size */
-#define EASYPEN_M406XE_RDESC_ORIG_SIZE	476
-
-/* Fixed EasyPen M406XE  report descriptor */
-static __u8 easypen_m406xe_rdesc_fixed[] = {
-	0x05, 0x01,         /*  Usage Page (Desktop),               */
-	0x09, 0x01,         /*  Usage (01h),                        */
-	0xA1, 0x01,         /*  Collection (Application),           */
-	0x85, 0x05,         /*      Report ID (5),                  */
-	0x09, 0x01,         /*      Usage (01h),                    */
-	0x15, 0x80,         /*      Logical Minimum (-128),         */
-	0x25, 0x7F,         /*      Logical Maximum (127),          */
-	0x75, 0x08,         /*      Report Size (8),                */
-	0x95, 0x07,         /*      Report Count (7),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0xC0,               /*  End Collection,                     */
-	0x05, 0x0D,         /*  Usage Page (Digitizer),             */
-	0x09, 0x01,         /*  Usage (Digitizer),                  */
-	0xA1, 0x01,         /*  Collection (Application),           */
-	0x85, 0x10,         /*      Report ID (16),                 */
-	0x09, 0x20,         /*      Usage (Stylus),                 */
-	0xA0,               /*      Collection (Physical),          */
-	0x14,               /*          Logical Minimum (0),        */
-	0x25, 0x01,         /*          Logical Maximum (1),        */
-	0x75, 0x01,         /*          Report Size (1),            */
-	0x09, 0x42,         /*          Usage (Tip Switch),         */
-	0x09, 0x44,         /*          Usage (Barrel Switch),      */
-	0x09, 0x46,         /*          Usage (Tablet Pick),        */
-	0x95, 0x03,         /*          Report Count (3),           */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x95, 0x04,         /*          Report Count (4),           */
-	0x81, 0x03,         /*          Input (Constant, Variable), */
-	0x09, 0x32,         /*          Usage (In Range),           */
-	0x95, 0x01,         /*          Report Count (1),           */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x75, 0x10,         /*          Report Size (16),           */
-	0x95, 0x01,         /*          Report Count (1),           */
-	0xA4,               /*          Push,                       */
-	0x05, 0x01,         /*          Usage Page (Desktop),       */
-	0x55, 0xFD,         /*          Unit Exponent (-3),         */
-	0x65, 0x13,         /*          Unit (Inch),                */
-	0x34,               /*          Physical Minimum (0),       */
-	0x09, 0x30,         /*          Usage (X),                  */
-	0x46, 0x70, 0x17,   /*          Physical Maximum (6000),    */
-	0x26, 0x00, 0x3C,   /*          Logical Maximum (15360),    */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0x09, 0x31,         /*          Usage (Y),                  */
-	0x46, 0xA0, 0x0F,   /*          Physical Maximum (4000),    */
-	0x26, 0x00, 0x28,   /*          Logical Maximum (10240),    */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0xB4,               /*          Pop,                        */
-	0x09, 0x30,         /*          Usage (Tip Pressure),       */
-	0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
-	0x81, 0x02,         /*          Input (Variable),           */
-	0xC0,               /*      End Collection,                 */
-	0xC0,               /*  End Collection                      */
-	0x05, 0x0C,         /*  Usage Page (Consumer),              */
-	0x09, 0x01,         /*  Usage (Consumer Control),           */
-	0xA1, 0x01,         /*  Collection (Application),           */
-	0x85, 0x12,         /*      Report ID (18),                 */
-	0x14,               /*      Logical Minimum (0),            */
-	0x25, 0x01,         /*      Logical Maximum (1),            */
-	0x75, 0x01,         /*      Report Size (1),                */
-	0x95, 0x04,         /*      Report Count (4),               */
-	0x0A, 0x79, 0x02,   /*      Usage (AC Redo Or Repeat),      */
-	0x0A, 0x1A, 0x02,   /*      Usage (AC Undo),                */
-	0x0A, 0x2D, 0x02,   /*      Usage (AC Zoom In),             */
-	0x0A, 0x2E, 0x02,   /*      Usage (AC Zoom Out),            */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x95, 0x34,         /*      Report Count (52),              */
-	0x81, 0x03,         /*      Input (Constant, Variable),     */
-	0xC0                /*  End Collection                      */
-};
-
 static const struct kye_tablet_info {
 	__u32 product;
 	__s32 x_logical_maximum;
@@ -566,6 +189,21 @@ static const struct kye_tablet_info {
 	unsigned int control_rsize;
 	const __u8 *control_rdesc;
 } kye_tablets_info[] = {
+	{USB_DEVICE_ID_KYE_EASYPEN_I405X,  /* 0x5010 */
+		14080, 10240, 1023,   55,  40, -1, 0x13, false},
+	{USB_DEVICE_ID_KYE_MOUSEPEN_I608X,  /* 0x5011 */
+		20480, 15360, 2047,    8,   6,  0, 0x13,  true},
+	{USB_DEVICE_ID_KYE_EASYPEN_M610X,  /* 0x5013 */
+		40960, 25600, 1023, 1000, 625, -2, 0x13, false,
+		sizeof(easypen_m610x_control_rdesc), easypen_m610x_control_rdesc},
+	{USB_DEVICE_ID_KYE_PENSKETCH_M912,  /* 0x5015 */
+		61440, 46080, 2047,   12,   9,  0, 0x13,  true,
+		sizeof(pensketch_m912_control_rdesc), pensketch_m912_control_rdesc},
+	{USB_DEVICE_ID_KYE_EASYPEN_M406XE,  /* 0x5019 */
+		15360, 10240, 1023,    6,   4,  0, 0x13, false,
+		sizeof(easypen_m406xe_control_rdesc), easypen_m406xe_control_rdesc},
+	{USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2,  /* 0x501A */
+		40960, 30720, 2047,    8,   6,  0, 0x13,  true},
 	{}
 };
 
@@ -692,40 +330,12 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		}
 		break;
 	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
-		if (*rsize == EASYPEN_I405X_RDESC_ORIG_SIZE) {
-			rdesc = easypen_i405x_rdesc_fixed;
-			*rsize = sizeof(easypen_i405x_rdesc_fixed);
-		}
-		break;
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
-		if (*rsize == MOUSEPEN_I608X_RDESC_ORIG_SIZE) {
-			rdesc = mousepen_i608x_rdesc_fixed;
-			*rsize = sizeof(mousepen_i608x_rdesc_fixed);
-		}
-		break;
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
-		if (*rsize == MOUSEPEN_I608X_V2_RDESC_ORIG_SIZE) {
-			rdesc = mousepen_i608x_v2_rdesc_fixed;
-			*rsize = sizeof(mousepen_i608x_v2_rdesc_fixed);
-		}
-		break;
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
-		if (*rsize == EASYPEN_M610X_RDESC_ORIG_SIZE) {
-			rdesc = easypen_m610x_rdesc_fixed;
-			*rsize = sizeof(easypen_m610x_rdesc_fixed);
-		}
-		break;
 	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
-		if (*rsize == EASYPEN_M406XE_RDESC_ORIG_SIZE) {
-			rdesc = easypen_m406xe_rdesc_fixed;
-			*rsize = sizeof(easypen_m406xe_rdesc_fixed);
-		}
-		break;
 	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
-		if (*rsize == PENSKETCH_M912_RDESC_ORIG_SIZE) {
-			rdesc = pensketch_m912_rdesc_fixed;
-			*rsize = sizeof(pensketch_m912_rdesc_fixed);
-		}
+		rdesc = kye_tablet_fixup(hdev, rdesc, rsize);
 		break;
 	case USB_DEVICE_ID_GENIUS_GILA_GAMING_MOUSE:
 		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
-- 
2.39.1

