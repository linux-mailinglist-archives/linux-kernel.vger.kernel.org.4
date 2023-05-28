Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015E57138DD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjE1JZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 05:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE1JZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 05:25:07 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1998EC7
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 02:25:01 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so24215875e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685265899; x=1687857899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iiEslLL64RBO43MiV0R4+I0MrrKQz6lOoOv9fg6did0=;
        b=W8gAym3I1irxLRIWv00pizBnzh1vfsIdek2HnwnJc7FKh9U0xsVQ1ZKxHZoStlvuhC
         Gsb+T/yG6k8ZA+gUtQ7sceEyG0du/p0qwAi6SOSGr14hNPVyzRV3eLtGRy6/7dsRIM3d
         hoM/tOVz7qdi4nzgRIae99LV/by81gM6dTBtmU9xDb0Cf2QnZaYMvtrfpUQ8+lm9KiV8
         u8INp/tniDyPYOz3XgkLMeRX0LPPPaZ0LjIR9kkJxHatDFcAsl8wYKM6PMICTUfoDPQ4
         ohjkTraDFsA+B6QK65PyDfc32KLS7ikdcUf5Iliq5qxnfSCrWC0ANtksnE6njfu8FO1b
         q0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685265899; x=1687857899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iiEslLL64RBO43MiV0R4+I0MrrKQz6lOoOv9fg6did0=;
        b=bE+Tt4A938EUkkgHpz+xhknSGbhQq3bYmKkA/LDaIvbZVeBEnFmeArj+N3orYjbMrH
         qwsYMqHLzLyFBHDTgIccsUstZgZVbzSeIwjSs8nG9HttRpPg35GNtl26iA4w4v1yiWuX
         8Jym1S4j7Q1/ychi0lOqih3cPX+R0E+E/U9D6ZeadbGUisPOhcyzVNM/THcfh/0zHXkU
         Y4kDbBerANHlMpSALfvl+CyIJIepfqhbbZNDf3lkp02I1IuNIGUYWRXoUQAJgHUPrbDG
         QoFTsT3WAxv0mwqa/sDBtH1vbLhbNrcnYgfhOoKPs7eCUgJRL7b4zUsK8QbJZnMB9WBH
         5I8w==
X-Gm-Message-State: AC+VfDxDkwjgBjtb+NMi1obhJUoYR/eW3LwHMX5j7Sp68CQQr1rI8aDO
        2+OBY0CpF8zb3lf4JV7ntY/vyg==
X-Google-Smtp-Source: ACHHUZ6fiG6D6sHkEiXYVmDNmnnl0HVvEWboqx1ZtPFmELOt4gM02nR3WLeXTmY76MSPpaGeLKmj3Q==
X-Received: by 2002:a1c:7c17:0:b0:3f6:1430:7e71 with SMTP id x23-20020a1c7c17000000b003f614307e71mr6717162wmc.31.1685265899280;
        Sun, 28 May 2023 02:24:59 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003f605566610sm14220527wmi.13.2023.05.28.02.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 02:24:58 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sensor-hub: Allow multi-function sensor devices
Date:   Sun, 28 May 2023 10:24:27 +0100
Message-Id: <20230528092427.42332-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo Yoga C630 has a combined keyboard and accelerometer that
interfaces via i2c-hid. Currently this laptop either has a working
keyboard (if CONFIG_HID_SENSOR_HUB is disabled) or a working accelerometer.
only works on kernels. Put another way, most distro kernels enable
CONFIG_HID_SENSOR_HUB and therefore cannot work on this device since the
keyboard doesn't work!

Fix this by providing a richer connect mask during the probe. With this
change both keyboard and screen orientation sensors work correctly.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    If I am honest, this patch owes a good deal more to trial and error
    than diligent understanding of the HID specs.
=20=20=20=20
    It works well on C630 but has an obvious risk of regressions: the
    connect flags have been zero since the hub sensor code was first
    introduced.  It is possible this could be better as an opt-in or
    opt-out quirk (or a even custom driver) but I figure trying a
    no-quirk approach might be a good starting point!
=20=20=20=20
    For the record, hid-decode tells us this about the device:
=20=20=20=20
    # device 0:0
    # 0x05, 0x01,                    // Usage Page (Generic Desktop)       =
 0
    # 0x09, 0x06,                    // Usage (Keyboard)                   =
 2
    # 0xa1, 0x01,                    // Collection (Application)           =
 4
    # 0x85, 0x01,                    //  Report ID (1)                     =
 6
    # 0x05, 0x07,                    //  Usage Page (Keyboard)             =
 8
    # 0x19, 0xe0,                    //  Usage Minimum (224)               =
 10
    # 0x29, 0xe7,                    //  Usage Maximum (231)               =
 12
    # 0x15, 0x00,                    //  Logical Minimum (0)               =
 14
    # 0x25, 0x01,                    //  Logical Maximum (1)               =
 16
    # 0x75, 0x01,                    //  Report Size (1)                   =
 18
    # 0x95, 0x08,                    //  Report Count (8)                  =
 20
    # 0x81, 0x02,                    //  Input (Data,Var,Abs)              =
 22
    # 0x95, 0x01,                    //  Report Count (1)                  =
 24
    # 0x75, 0x08,                    //  Report Size (8)                   =
 26
    # 0x81, 0x03,                    //  Input (Cnst,Var,Abs)              =
 28
    # 0x95, 0x05,                    //  Report Count (5)                  =
 30
    # 0x75, 0x01,                    //  Report Size (1)                   =
 32
    # 0x05, 0x08,                    //  Usage Page (LEDs)                 =
 34
    # 0x19, 0x01,                    //  Usage Minimum (1)                 =
 36
    # 0x29, 0x05,                    //  Usage Maximum (5)                 =
 38
    # 0x91, 0x02,                    //  Output (Data,Var,Abs)             =
 40
    # 0x95, 0x01,                    //  Report Count (1)                  =
 42
    # 0x75, 0x03,                    //  Report Size (3)                   =
 44
    # 0x91, 0x03,                    //  Output (Cnst,Var,Abs)             =
 46
    # 0x95, 0x06,                    //  Report Count (6)                  =
 48
    # 0x75, 0x08,                    //  Report Size (8)                   =
 50
    # 0x15, 0x00,                    //  Logical Minimum (0)               =
 52
    # 0x25, 0xff,                    //  Logical Maximum (255)             =
 54
    # 0x05, 0x07,                    //  Usage Page (Keyboard)             =
 56
    # 0x19, 0x00,                    //  Usage Minimum (0)                 =
 58
    # 0x29, 0xff,                    //  Usage Maximum (255)               =
 60
    # 0x81, 0x00,                    //  Input (Data,Arr,Abs)              =
 62
    # 0xc0,                          // End Collection                     =
 64
    # 0x05, 0x0c,                    // Usage Page (Consumer Devices)      =
 65
    # 0x09, 0x01,                    // Usage (Consumer Control)           =
 67
    # 0xa1, 0x01,                    // Collection (Application)           =
 69
    # 0x85, 0x03,                    //  Report ID (3)                     =
 71
    # 0x95, 0x01,                    //  Report Count (1)                  =
 73
    # 0x75, 0x10,                    //  Report Size (16)                  =
 75
    # 0x15, 0x00,                    //  Logical Minimum (0)               =
 77
    # 0x26, 0xff, 0x03,              //  Logical Maximum (1023)            =
 79
    # 0x19, 0x00,                    //  Usage Minimum (0)                 =
 82
    # 0x2a, 0xff, 0x03,              //  Usage Maximum (1023)              =
 84
    # 0x81, 0x00,                    //  Input (Data,Arr,Abs)              =
 87
    # 0xc0,                          // End Collection                     =
 89
    # 0x06, 0x00, 0xff,              // Usage Page (Vendor Defined Page 1) =
 90
    # 0x09, 0x01,                    // Usage (Vendor Usage 1)             =
 93
    # 0xa1, 0x01,                    // Collection (Application)           =
 95
    # 0x85, 0x05,                    //  Report ID (5)                     =
 97
    # 0x19, 0x00,                    //  Usage Minimum (0)                 =
 99
    # 0x29, 0xff,                    //  Usage Maximum (255)               =
 101
    # 0x15, 0x00,                    //  Logical Minimum (0)               =
 103
    # 0x25, 0xff,                    //  Logical Maximum (255)             =
 105
    # 0x75, 0x08,                    //  Report Size (8)                   =
 107
    # 0x95, 0x08,                    //  Report Count (8)                  =
 109
    # 0x81, 0x00,                    //  Input (Data,Arr,Abs)              =
 111
    # 0xc0,                          // End Collection                     =
 113
    # 0x05, 0x01,                    // Usage Page (Generic Desktop)       =
 114
    # 0x09, 0x0c,                    // Usage (Wireless Radio Controls)    =
 116
    # 0xa1, 0x01,                    // Collection (Application)           =
 118
    # 0x85, 0x06,                    //  Report ID (6)                     =
 120
    # 0x15, 0x00,                    //  Logical Minimum (0)               =
 122
    # 0x25, 0x01,                    //  Logical Maximum (1)               =
 124
    # 0x09, 0xc6,                    //  Usage (Wireless Radio Button)     =
 126
    # 0x95, 0x01,                    //  Report Count (1)                  =
 128
    # 0x75, 0x01,                    //  Report Size (1)                   =
 130
    # 0x81, 0x06,                    //  Input (Data,Var,Rel)              =
 132
    # 0x75, 0x07,                    //  Report Size (7)                   =
 134
    # 0x81, 0x03,                    //  Input (Cnst,Var,Abs)              =
 136
    # 0xc0,                          // End Collection                     =
 138
    # 0x05, 0x20,                    // Usage Page (Sensor)                =
 139
    # 0x09, 0x01,                    // Usage (Sensor)                     =
 141
    # 0xa1, 0x00,                    // Collection (Physical)              =
 143
    # 0x05, 0x20,                    //  Usage Page (Sensor)               =
 145
    # 0x09, 0x73,                    //  Usage (Motion: Accelerometer 3D)  =
 147
    # 0xa1, 0x00,                    //  Collection (Physical)             =
 149
    # 0x85, 0x07,                    //   Report ID (7)                    =
 151
    # 0x05, 0x20,                    //   Usage Page (Sensor)              =
 153
    # 0x0a, 0x09, 0x03,              //   Usage (Property: Sensor Connectio=
n Type) 155
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 158
    # 0x25, 0x02,                    //   Logical Maximum (2)              =
 160
    # 0x75, 0x08,                    //   Report Size (8)                  =
 162
    # 0x95, 0x01,                    //   Report Count (1)                 =
 164
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 166
    # 0x0a, 0x30, 0x08,              //    Usage (Connection Type: PC Integ=
rated) 168
    # 0x0a, 0x31, 0x08,              //    Usage (Connection Type: PC Attac=
hed) 171
    # 0x0a, 0x32, 0x08,              //    Usage (Connection Type: PC Exter=
nal) 174
    # 0xb1, 0x00,                    //    Feature (Data,Arr,Abs)          =
 177
    # 0xc0,                          //   End Collection                   =
 179
    # 0x0a, 0x16, 0x03,              //   Usage (Property: Reporting State)=
 180
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 183
    # 0x25, 0x05,                    //   Logical Maximum (5)              =
 185
    # 0x75, 0x08,                    //   Report Size (8)                  =
 187
    # 0x95, 0x01,                    //   Report Count (1)                 =
 189
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 191
    # 0x0a, 0x40, 0x08,              //    Usage (Reporting State: Report N=
o Events) 193
    # 0x0a, 0x41, 0x08,              //    Usage (Reporting State: Report A=
ll Events) 196
    # 0x0a, 0x42, 0x08,              //    Usage (Reporting State: Report T=
hreshold Events) 199
    # 0x0a, 0x43, 0x08,              //    Usage (Reporting State: Wake On =
No Events) 202
    # 0x0a, 0x44, 0x08,              //    Usage (Reporting State: Wake On =
All Events) 205
    # 0x0a, 0x45, 0x08,              //    Usage (Reporting State: Wake On =
Threshold Events) 208
    # 0xb1, 0x00,                    //    Feature (Data,Arr,Abs)          =
 211
    # 0xc0,                          //   End Collection                   =
 213
    # 0x0a, 0x19, 0x03,              //   Usage (Property: Power State)    =
 214
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 217
    # 0x25, 0x05,                    //   Logical Maximum (5)              =
 219
    # 0x75, 0x08,                    //   Report Size (8)                  =
 221
    # 0x95, 0x01,                    //   Report Count (1)                 =
 223
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 225
    # 0x0a, 0x50, 0x08,              //    Usage (Power State: Undefined)  =
 227
    # 0x0a, 0x51, 0x08,              //    Usage (Power State: D0 Full Powe=
r) 230
    # 0x0a, 0x52, 0x08,              //    Usage (Power State: D1 Low Power=
) 233
    # 0x0a, 0x53, 0x08,              //    Usage (Power State: D2 Standby P=
ower with Wakeup) 236
    # 0x0a, 0x54, 0x08,              //    Usage (Power State: D3 Sleep wit=
h Wakeup) 239
    # 0x0a, 0x55, 0x08,              //    Usage (Power State: D4 Power Off=
) 242
    # 0xb1, 0x00,                    //    Feature (Data,Arr,Abs)          =
 245
    # 0xc0,                          //   End Collection                   =
 247
    # 0x0a, 0x01, 0x02,              //   Usage (Event: Sensor State)      =
 248
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 251
    # 0x25, 0x06,                    //   Logical Maximum (6)              =
 253
    # 0x75, 0x08,                    //   Report Size (8)                  =
 255
    # 0x95, 0x01,                    //   Report Count (1)                 =
 257
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 259
    # 0x0a, 0x00, 0x08,              //    Usage (Sensor State: Undefined) =
 261
    # 0x0a, 0x01, 0x08,              //    Usage (Sensor State: Ready)     =
 264
    # 0x0a, 0x02, 0x08,              //    Usage (Sensor State: Not Availab=
le) 267
    # 0x0a, 0x03, 0x08,              //    Usage (Sensor State: No Data Sel=
) 270
    # 0x0a, 0x04, 0x08,              //    Usage (Sensor State: Initializin=
g) 273
    # 0x0a, 0x05, 0x08,              //    Usage (Sensor State: Access Deni=
ed) 276
    # 0x0a, 0x06, 0x08,              //    Usage (Sensor State: Error)     =
 279
    # 0xb1, 0x00,                    //    Feature (Data,Arr,Abs)          =
 282
    # 0xc0,                          //   End Collection                   =
 284
    # 0x0a, 0x0e, 0x03,              //   Usage (Property: Report Interval)=
 285
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 288
    # 0x27, 0xff, 0xff, 0xff, 0xff,  //   Logical Maximum (4294967295)     =
 290
    # 0x75, 0x20,                    //   Report Size (32)                 =
 295
    # 0x95, 0x01,                    //   Report Count (1)                 =
 297
    # 0x55, 0x00,                    //   Unit Exponent (0)                =
 299
    # 0xb1, 0x02,                    //   Feature (Data,Var,Abs)           =
 301
    # 0x0a, 0x52, 0x14,              //   Usage (Unknown Usage 0x1452)     =
 303
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 306
    # 0x26, 0xff, 0xff,              //   Logical Maximum (65535)          =
 308
    # 0x75, 0x10,                    //   Report Size (16)                 =
 311
    # 0x95, 0x01,                    //   Report Count (1)                 =
 313
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 315
    # 0xb1, 0x02,                    //   Feature (Data,Var,Abs)           =
 317
    # 0x0a, 0x52, 0x24,              //   Usage (Unknown Usage 0x2452)     =
 319
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 322
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 325
    # 0x75, 0x10,                    //   Report Size (16)                 =
 328
    # 0x95, 0x01,                    //   Report Count (1)                 =
 330
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 332
    # 0xb1, 0x02,                    //   Feature (Data,Var,Abs)           =
 334
    # 0x0a, 0x52, 0x34,              //   Usage (Unknown Usage 0x3452)     =
 336
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 339
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 342
    # 0x75, 0x10,                    //   Report Size (16)                 =
 345
    # 0x95, 0x01,                    //   Report Count (1)                 =
 347
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 349
    # 0xb1, 0x02,                    //   Feature (Data,Var,Abs)           =
 351
    # 0x05, 0x20,                    //   Usage Page (Sensor)              =
 353
    # 0x0a, 0x01, 0x02,              //   Usage (Event: Sensor State)      =
 355
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 358
    # 0x25, 0x06,                    //   Logical Maximum (6)              =
 360
    # 0x75, 0x08,                    //   Report Size (8)                  =
 362
    # 0x95, 0x01,                    //   Report Count (1)                 =
 364
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 366
    # 0x0a, 0x00, 0x08,              //    Usage (Sensor State: Undefined) =
 368
    # 0x0a, 0x01, 0x08,              //    Usage (Sensor State: Ready)     =
 371
    # 0x0a, 0x02, 0x08,              //    Usage (Sensor State: Not Availab=
le) 374
    # 0x0a, 0x03, 0x08,              //    Usage (Sensor State: No Data Sel=
) 377
    # 0x0a, 0x04, 0x08,              //    Usage (Sensor State: Initializin=
g) 380
    # 0x0a, 0x05, 0x08,              //    Usage (Sensor State: Access Deni=
ed) 383
    # 0x0a, 0x06, 0x08,              //    Usage (Sensor State: Error)     =
 386
    # 0x81, 0x00,                    //    Input (Data,Arr,Abs)            =
 389
    # 0xc0,                          //   End Collection                   =
 391
    # 0x0a, 0x02, 0x02,              //   Usage (Event: Sensor Event)      =
 392
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 395
    # 0x25, 0x05,                    //   Logical Maximum (5)              =
 397
    # 0x75, 0x08,                    //   Report Size (8)                  =
 399
    # 0x95, 0x01,                    //   Report Count (1)                 =
 401
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 403
    # 0x0a, 0x10, 0x08,              //    Usage (Sensor Event: Unknown)   =
 405
    # 0x0a, 0x11, 0x08,              //    Usage (Sensor Event: State Chang=
ed) 408
    # 0x0a, 0x12, 0x08,              //    Usage (Sensor Event: Property Ch=
anged) 411
    # 0x0a, 0x13, 0x08,              //    Usage (Sensor Event: Data Update=
d) 414
    # 0x0a, 0x14, 0x08,              //    Usage (Sensor Event: Poll Respon=
se) 417
    # 0x0a, 0x15, 0x08,              //    Usage (Sensor Event: Change Sens=
itivity) 420
    # 0x81, 0x00,                    //    Input (Data,Arr,Abs)            =
 423
    # 0xc0,                          //   End Collection                   =
 425
    # 0x0a, 0x53, 0x04,              //   Usage (Data Field: Acceleration A=
xis X) 426
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 429
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 432
    # 0x75, 0x10,                    //   Report Size (16)                 =
 435
    # 0x95, 0x01,                    //   Report Count (1)                 =
 437
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 439
    # 0x81, 0x02,                    //   Input (Data,Var,Abs)             =
 441
    # 0x0a, 0x54, 0x04,              //   Usage (Data Field: Acceleration A=
xis Y) 443
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 446
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 449
    # 0x75, 0x10,                    //   Report Size (16)                 =
 452
    # 0x95, 0x01,                    //   Report Count (1)                 =
 454
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 456
    # 0x81, 0x02,                    //   Input (Data,Var,Abs)             =
 458
    # 0x0a, 0x55, 0x04,              //   Usage (Data Field: Acceleration A=
xis Z) 460
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 463
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 466
    # 0x75, 0x10,                    //   Report Size (16)                 =
 469
    # 0x95, 0x01,                    //   Report Count (1)                 =
 471
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 473
    # 0x81, 0x02,                    //   Input (Data,Var,Abs)             =
 475
    # 0x0a, 0x51, 0x04,              //   Usage (Data Field: Motion State) =
 477
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 480
    # 0x25, 0x01,                    //   Logical Maximum (1)              =
 482
    # 0x75, 0x08,                    //   Report Size (8)                  =
 484
    # 0x95, 0x01,                    //   Report Count (1)                 =
 486
    # 0x81, 0x02,                    //   Input (Data,Var,Abs)             =
 488
    # 0xc0,                          //  End Collection                    =
 490
    # 0x05, 0x20,                    //  Usage Page (Sensor)               =
 491
    # 0x09, 0xe1,                    //  Usage (Other: Custom)             =
 493
    # 0xa1, 0x00,                    //  Collection (Physical)             =
 495
    # 0x85, 0x0a,                    //   Report ID (10)                   =
 497
    # 0x05, 0x20,                    //   Usage Page (Sensor)              =
 499
    # 0x0a, 0x09, 0x03,              //   Usage (Property: Sensor Connectio=
n Type) 501
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 504
    # 0x25, 0x02,                    //   Logical Maximum (2)              =
 506
    # 0x75, 0x08,                    //   Report Size (8)                  =
 508
    # 0x95, 0x01,                    //   Report Count (1)                 =
 510
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 512
    # 0x0a, 0x30, 0x08,              //    Usage (Connection Type: PC Integ=
rated) 514
    # 0x0a, 0x31, 0x08,              //    Usage (Connection Type: PC Attac=
hed) 517
    # 0x0a, 0x32, 0x08,              //    Usage (Connection Type: PC Exter=
nal) 520
    # 0xb1, 0x00,                    //    Feature (Data,Arr,Abs)          =
 523
    # 0xc0,                          //   End Collection                   =
 525
    # 0x0a, 0x16, 0x03,              //   Usage (Property: Reporting State)=
 526
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 529
    # 0x25, 0x05,                    //   Logical Maximum (5)              =
 531
    # 0x75, 0x08,                    //   Report Size (8)                  =
 533
    # 0x95, 0x01,                    //   Report Count (1)                 =
 535
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 537
    # 0x0a, 0x40, 0x08,              //    Usage (Reporting State: Report N=
o Events) 539
    # 0x0a, 0x41, 0x08,              //    Usage (Reporting State: Report A=
ll Events) 542
    # 0x0a, 0x42, 0x08,              //    Usage (Reporting State: Report T=
hreshold Events) 545
    # 0x0a, 0x43, 0x08,              //    Usage (Reporting State: Wake On =
No Events) 548
    # 0x0a, 0x44, 0x08,              //    Usage (Reporting State: Wake On =
All Events) 551
    # 0x0a, 0x45, 0x08,              //    Usage (Reporting State: Wake On =
Threshold Events) 554
    # 0xb1, 0x00,                    //    Feature (Data,Arr,Abs)          =
 557
    # 0xc0,                          //   End Collection                   =
 559
    # 0x0a, 0x19, 0x03,              //   Usage (Property: Power State)    =
 560
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 563
    # 0x25, 0x05,                    //   Logical Maximum (5)              =
 565
    # 0x75, 0x08,                    //   Report Size (8)                  =
 567
    # 0x95, 0x01,                    //   Report Count (1)                 =
 569
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 571
    # 0x0a, 0x50, 0x08,              //    Usage (Power State: Undefined)  =
 573
    # 0x0a, 0x51, 0x08,              //    Usage (Power State: D0 Full Powe=
r) 576
    # 0x0a, 0x52, 0x08,              //    Usage (Power State: D1 Low Power=
) 579
    # 0x0a, 0x53, 0x08,              //    Usage (Power State: D2 Standby P=
ower with Wakeup) 582
    # 0x0a, 0x54, 0x08,              //    Usage (Power State: D3 Sleep wit=
h Wakeup) 585
    # 0x0a, 0x55, 0x08,              //    Usage (Power State: D4 Power Off=
) 588
    # 0xb1, 0x00,                    //    Feature (Data,Arr,Abs)          =
 591
    # 0xc0,                          //   End Collection                   =
 593
    # 0x0a, 0x01, 0x02,              //   Usage (Event: Sensor State)      =
 594
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 597
    # 0x25, 0x06,                    //   Logical Maximum (6)              =
 599
    # 0x75, 0x08,                    //   Report Size (8)                  =
 601
    # 0x95, 0x01,                    //   Report Count (1)                 =
 603
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 605
    # 0x0a, 0x00, 0x08,              //    Usage (Sensor State: Undefined) =
 607
    # 0x0a, 0x01, 0x08,              //    Usage (Sensor State: Ready)     =
 610
    # 0x0a, 0x02, 0x08,              //    Usage (Sensor State: Not Availab=
le) 613
    # 0x0a, 0x03, 0x08,              //    Usage (Sensor State: No Data Sel=
) 616
    # 0x0a, 0x04, 0x08,              //    Usage (Sensor State: Initializin=
g) 619
    # 0x0a, 0x05, 0x08,              //    Usage (Sensor State: Access Deni=
ed) 622
    # 0x0a, 0x06, 0x08,              //    Usage (Sensor State: Error)     =
 625
    # 0xb1, 0x00,                    //    Feature (Data,Arr,Abs)          =
 628
    # 0xc0,                          //   End Collection                   =
 630
    # 0x0a, 0x0e, 0x03,              //   Usage (Property: Report Interval)=
 631
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 634
    # 0x27, 0xff, 0xff, 0xff, 0xff,  //   Logical Maximum (4294967295)     =
 636
    # 0x75, 0x20,                    //   Report Size (32)                 =
 641
    # 0x95, 0x01,                    //   Report Count (1)                 =
 643
    # 0x55, 0x00,                    //   Unit Exponent (0)                =
 645
    # 0xb1, 0x02,                    //   Feature (Data,Var,Abs)           =
 647
    # 0x0a, 0x06, 0x03,              //   Usage (Property: Sensor Model)   =
 649
    # 0x75, 0x08,                    //   Report Size (8)                  =
 652
    # 0x95, 0x18,                    //   Report Count (24)                =
 654
    # 0xb1, 0x03,                    //   Feature (Cnst,Var,Abs)           =
 656
    # 0x0a, 0x40, 0x15,              //   Usage (Unknown Usage 0x1540)     =
 658
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 661
    # 0x26, 0xff, 0xff,              //   Logical Maximum (65535)          =
 663
    # 0x75, 0x10,                    //   Report Size (16)                 =
 666
    # 0x95, 0x01,                    //   Report Count (1)                 =
 668
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 670
    # 0xb1, 0x02,                    //   Feature (Data,Var,Abs)           =
 672
    # 0x0a, 0x40, 0x25,              //   Usage (Unknown Usage 0x2540)     =
 674
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 677
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 680
    # 0x75, 0x10,                    //   Report Size (16)                 =
 683
    # 0x95, 0x01,                    //   Report Count (1)                 =
 685
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 687
    # 0xb1, 0x02,                    //   Feature (Data,Var,Abs)           =
 689
    # 0x0a, 0x40, 0x35,              //   Usage (Unknown Usage 0x3540)     =
 691
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 694
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 697
    # 0x75, 0x10,                    //   Report Size (16)                 =
 700
    # 0x95, 0x01,                    //   Report Count (1)                 =
 702
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 704
    # 0xb1, 0x02,                    //   Feature (Data,Var,Abs)           =
 706
    # 0x05, 0x20,                    //   Usage Page (Sensor)              =
 708
    # 0x0a, 0x01, 0x02,              //   Usage (Event: Sensor State)      =
 710
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 713
    # 0x25, 0x06,                    //   Logical Maximum (6)              =
 715
    # 0x75, 0x08,                    //   Report Size (8)                  =
 717
    # 0x95, 0x01,                    //   Report Count (1)                 =
 719
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 721
    # 0x0a, 0x00, 0x08,              //    Usage (Sensor State: Undefined) =
 723
    # 0x0a, 0x01, 0x08,              //    Usage (Sensor State: Ready)     =
 726
    # 0x0a, 0x02, 0x08,              //    Usage (Sensor State: Not Availab=
le) 729
    # 0x0a, 0x03, 0x08,              //    Usage (Sensor State: No Data Sel=
) 732
    # 0x0a, 0x04, 0x08,              //    Usage (Sensor State: Initializin=
g) 735
    # 0x0a, 0x05, 0x08,              //    Usage (Sensor State: Access Deni=
ed) 738
    # 0x0a, 0x06, 0x08,              //    Usage (Sensor State: Error)     =
 741
    # 0x81, 0x00,                    //    Input (Data,Arr,Abs)            =
 744
    # 0xc0,                          //   End Collection                   =
 746
    # 0x0a, 0x02, 0x02,              //   Usage (Event: Sensor Event)      =
 747
    # 0x15, 0x00,                    //   Logical Minimum (0)              =
 750
    # 0x25, 0x05,                    //   Logical Maximum (5)              =
 752
    # 0x75, 0x08,                    //   Report Size (8)                  =
 754
    # 0x95, 0x01,                    //   Report Count (1)                 =
 756
    # 0xa1, 0x02,                    //   Collection (Logical)             =
 758
    # 0x0a, 0x10, 0x08,              //    Usage (Sensor Event: Unknown)   =
 760
    # 0x0a, 0x11, 0x08,              //    Usage (Sensor Event: State Chang=
ed) 763
    # 0x0a, 0x12, 0x08,              //    Usage (Sensor Event: Property Ch=
anged) 766
    # 0x0a, 0x13, 0x08,              //    Usage (Sensor Event: Data Update=
d) 769
    # 0x0a, 0x14, 0x08,              //    Usage (Sensor Event: Poll Respon=
se) 772
    # 0x0a, 0x15, 0x08,              //    Usage (Sensor Event: Change Sens=
itivity) 775
    # 0x81, 0x00,                    //    Input (Data,Arr,Abs)            =
 778
    # 0xc0,                          //   End Collection                   =
 780
    # 0x0a, 0x44, 0x05,              //   Usage (Data Field: Custom Value 1=
) 781
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 784
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 787
    # 0x75, 0x10,                    //   Report Size (16)                 =
 790
    # 0x95, 0x01,                    //   Report Count (1)                 =
 792
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 794
    # 0x81, 0x02,                    //   Input (Data,Var,Abs)             =
 796
    # 0x0a, 0x45, 0x05,              //   Usage (Data Field: Custom Value 2=
) 798
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 801
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 804
    # 0x75, 0x10,                    //   Report Size (16)                 =
 807
    # 0x95, 0x01,                    //   Report Count (1)                 =
 809
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 811
    # 0x81, 0x02,                    //   Input (Data,Var,Abs)             =
 813
    # 0x0a, 0x46, 0x05,              //   Usage (Data Field: Custom Value 3=
) 815
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 818
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 821
    # 0x75, 0x10,                    //   Report Size (16)                 =
 824
    # 0x95, 0x01,                    //   Report Count (1)                 =
 826
    # 0x55, 0x0d,                    //   Unit Exponent (-3)               =
 828
    # 0x81, 0x02,                    //   Input (Data,Var,Abs)             =
 830
    # 0x0a, 0x47, 0x05,              //   Usage (Data Field: Custom Value 4=
) 832
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 835
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 838
    # 0x75, 0x10,                    //   Report Size (16)                 =
 841
    # 0x95, 0x01,                    //   Report Count (1)                 =
 843
    # 0x55, 0x00,                    //   Unit Exponent (0)                =
 845
    # 0x81, 0x02,                    //   Input (Data,Var,Abs)             =
 847
    # 0x0a, 0x48, 0x05,              //   Usage (Data Field: Custom Value 5=
) 849
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 852
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 855
    # 0x75, 0x10,                    //   Report Size (16)                 =
 858
    # 0x95, 0x01,                    //   Report Count (1)                 =
 860
    # 0x55, 0x00,                    //   Unit Exponent (0)                =
 862
    # 0x81, 0x02,                    //   Input (Data,Var,Abs)             =
 864
    # 0x0a, 0x49, 0x05,              //   Usage (Data Field: Custom Value 6=
) 866
    # 0x16, 0x01, 0x80,              //   Logical Minimum (-32767)         =
 869
    # 0x26, 0xff, 0x7f,              //   Logical Maximum (32767)          =
 872
    # 0x75, 0x10,                    //   Report Size (16)                 =
 875
    # 0x95, 0x01,                    //   Report Count (1)                 =
 877
    # 0x55, 0x00,                    //   Unit Exponent (0)                =
 879
    # 0x81, 0x02,                    //   Input (Data,Var,Abs)             =
 881
    # 0xc0,                          //  End Collection                    =
 883
    # 0xc0,                          // End Collection                     =
 884
    #
    R: 885 05 01 09 06 a1 01 85 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 0=
8 81 02 95 01 75 08 81 03 95 05 75 01 05 08 19 01 29 05 91 02 95 01 75 03 9=
1 03 95 06 75 08 15 00 25 ff 05 07 19 00 29 ff 81 00 c0 05 0c 09 01 a1 01 8=
5 03 95 01 75 10 15 00 26 ff 03 19 00 2a ff 03 81 00 c0 06 00 ff 09 01 a1 0=
1 85 05 19 00 29 ff 15 00 25 ff 75 08 95 08 81 00 c0 05 01 09 0c a1 01 85 0=
6 15 00 25 01 09 c6 95 01 75 01 81 06 75 07 81 03 c0 05 20 09 01 a1 00 05 2=
0 09 73 a1 00 85 07 05 20 0a 09 03 15 00 25 02 75 08 95 01 a1 02 0a 30 08 0=
a 31 08 0a 32 08 b1 00 c0 0a 16 03 15 00 25 05 75 08 95 01 a1 02 0a 40 08 0=
a 41 08 0a 42 08 0a 43 08 0a 44 08 0a 45 08 b1 00 c0 0a 19 03 15 00 25 05 7=
5 08 95 01 a1 02 0a 50 08 0a 51 08 0a 52 08 0a 53 08 0a 54 08 0a 55 08 b1 0=
0 c0 0a 01 02 15 00 25 06 75 08 95 01 a1 02 0a 00 08 0a 01 08 0a 02 08 0a 0=
3 08 0a 04 08 0a 05 08 0a 06 08 b1 00 c0 0a 0e 03 15 00 27 ff ff ff ff 75 2=
0 95 01 55 00 b1 02 0a 52 14 15 00 26 ff ff 75 10 95 01 55 0d b1 02 0a 52 2=
4 16 01 80 26 ff 7f 75 10 95 01 55 0d b1 02 0a 52 34 16 01 80 26 ff 7f 75 1=
0 95 01 55 0d b1 02 05 20 0a 01 02 15 00 25 06 75 08 95 01 a1 02 0a 00 08 0=
a 01 08 0a 02 08 0a 03 08 0a 04 08 0a 05 08 0a 06 08 81 00 c0 0a 02 02 15 0=
0 25 05 75 08 95 01 a1 02 0a 10 08 0a 11 08 0a 12 08 0a 13 08 0a 14 08 0a 1=
5 08 81 00 c0 0a 53 04 16 01 80 26 ff 7f 75 10 95 01 55 0d 81 02 0a 54 04 1=
6 01 80 26 ff 7f 75 10 95 01 55 0d 81 02 0a 55 04 16 01 80 26 ff 7f 75 10 9=
5 01 55 0d 81 02 0a 51 04 15 00 25 01 75 08 95 01 81 02 c0 05 20 09 e1 a1 0=
0 85 0a 05 20 0a 09 03 15 00 25 02 75 08 95 01 a1 02 0a 30 08 0a 31 08 0a 3=
2 08 b1 00 c0 0a 16 03 15 00 25 05 75 08 95 01 a1 02 0a 40 08 0a 41 08 0a 4=
2 08 0a 43 08 0a 44 08 0a 45 08 b1 00 c0 0a 19 03 15 00 25 05 75 08 95 01 a=
1 02 0a 50 08 0a 51 08 0a 52 08 0a 53 08 0a 54 08 0a 55 08 b1 00 c0 0a 01 0=
2 15 00 25 06 75 08 95 01 a1 02 0a 00 08 0a 01 08 0a 02 08 0a 03 08 0a 04 0=
8 0a 05 08 0a 06 08 b1 00 c0 0a 0e 03 15 00 27 ff ff ff ff 75 20 95 01 55 0=
0 b1 02 0a 06 03 75 08 95 18 b1 03 0a 40 15 15 00 26 ff ff 75 10 95 01 55 0=
d b1 02 0a 40 25 16 01 80 26 ff 7f 75 10 95 01 55 0d b1 02 0a 40 35 16 01 8=
0 26 ff 7f 75 10 95 01 55 0d b1 02 05 20 0a 01 02 15 00 25 06 75 08 95 01 a=
1 02 0a 00 08 0a 01 08 0a 02 08 0a 03 08 0a 04 08 0a 05 08 0a 06 08 81 00 c=
0 0a 02 02 15 00 25 05 75 08 95 01 a1 02 0a 10 08 0a 11 08 0a 12 08 0a 13 0=
8 0a 14 08 0a 15 08 81 00 c0 0a 44 05 16 01 80 26 ff 7f 75 10 95 01 55 0d 8=
1 02 0a 45 05 16 01 80 26 ff 7f 75 10 95 01 55 0d 81 02 0a 46 05 16 01 80 2=
6 ff 7f 75 10 95 01 55 0d 81 02 0a 47 05 16 01 80 26 ff 7f 75 10 95 01 55 0=
0 81 02 0a 48 05 16 01 80 26 ff 7f 75 10 95 01 55 00 81 02 0a 49 05 16 01 8=
0 26 ff 7f 75 10 95 01 55 00 81 02 c0 c0
    N: device 0:0
    I: 3 0001 0001

 drivers/hid/hid-sensor-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 83237b86c8ff4..2eba152e8b905 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -632,7 +632,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	}
 	INIT_LIST_HEAD(&hdev->inputs);

-	ret =3D hid_hw_start(hdev, 0);
+	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
 		return ret;

base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
--
2.39.2

