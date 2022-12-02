Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC258640BCC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiLBRIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiLBRId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:08:33 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DCAC936B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:08:30 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ha10so13030198ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Osxc+X4hVnu15Q3eTBw5jI2KUp8vy0lxvuL8UQ3aC0=;
        b=GnS8QhSYEMv6n4jw0yFfUbZvwg5Vhq+985nBIzjutBkUlJTjAES6Qa3j4FDdFzaNhd
         xPs2ypslvirhSLt/avB43QTL/kelOxqQL6FrOFue/KgICMQvM051OhnKukuOG7/6nN1B
         mNspBDvw6GParxheS+tuiAz0fi+ztewwb1HAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Osxc+X4hVnu15Q3eTBw5jI2KUp8vy0lxvuL8UQ3aC0=;
        b=CpJk/vEd0j1/JwdmpxQxjJkf/VMOFUU6PJGS8upFjPTQaA5/el6OfH4dCUGCCj2cvM
         A6lNt4E8R/cXXlExSpd0MZ/JIQ6Z24RaTQ94di9CCvj09y7X48C3Pmt5L1+JELirbrPQ
         e4JOwKca971NWiVdjSbl/go/u8J8Q1p81Kv7jwP/aIUkPcWFqhiLALT6p2lZGlVo8xv6
         52wrQD9KEofhU04hHT0QFUXKEU9vinSxJyfN5kAqsWSWXsTzCHQe7+BHP9CjpiHDgP9p
         8upkkW4VtmAhYFImQ+iLFs0ILxp/dmx/HNgWRkUfq6czgG6smwzbMzH2LyTugzTmgKWC
         jHsg==
X-Gm-Message-State: ANoB5plDFBe6EhfVpdCbkQGEUV8uV70q9iPmizry5hfaTC/mNP/6cLCk
        BjbAkC8mCzPyrej7mpv3+NJdTA==
X-Google-Smtp-Source: AA0mqf590e54t6H3TnzsRoLmE3reCWONt4LAtXkHNH5TtEOJZa3ZkWb1dP2R5zjw1RElWBUSOtIqvg==
X-Received: by 2002:a17:906:240f:b0:7c0:9f04:1938 with SMTP id z15-20020a170906240f00b007c09f041938mr11228599eja.769.1670000909427;
        Fri, 02 Dec 2022 09:08:29 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p23-20020aa7d317000000b00461cdda400esm3168080edq.4.2022.12.02.09.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:08:29 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:08:17 +0100
Subject: [PATCH v4 1/3] media: v4l2-dev.c: Add Meta: to the name of metadata devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-meta-v4-1-3ac355b66723@chromium.org>
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
In-Reply-To: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
To:     Yunke Cao <yunkec@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=S/2IqTrS982KVl7xBqyOVIPsEn1hTfJgkOaPng55noA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijEHhwhyiGaRWIE8Uwg1apHOrqxn6xO5ElcuWngc
 RfSqvt6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4oxBwAKCRDRN9E+zzrEiCbYD/
 9zTf9/1R1mr3eyJB5lNnh0633R51L2Org2I+fBBpEAQuV0E5f+X+Wvt5fS1x9OGakxv7FMljhc7/VW
 UycA4caSUByvyMLsWh5VrwRzGe4PetwRafYyZHKMD2ltxmWKRdvf0EIzxlqJNtA2UpWqbv1/2fnZs2
 MRS9jOpFIfKv6HexUGs9W0IQqW0zCjuXesmq/UiTEKCCF2wFK76A7fDEYiO67P6BhMX2PtJO4T2l9n
 ghq7UWWV96Sdf0+zat+q2o15M5gh8vWsjJkLSIhyRCK35FKUS+LqRCdY21m747yr6c9ifbh+boyNeS
 nTmy+N+jBPCswv8MmF7XT6glJkLRRe2NGtTpDU1yGBVuK9bbIwvyckVBQm2SOVtY6cDvaEhk5AroHV
 CSMwrcqW70mLSKBLEGvGHSlLplp5Hr5xi5vCimvqZOxr0TcR1WhcXWqr3kh2I7BzjogliVIjarBQ2l
 +2rOLr8Xl5dnXbc6kWM6JkL8z0U6h3JXaGWqpBB7/VSKsu+AHXhlLLH/u/vyQ/PV+Lh/T1Qh3dwPSV
 jo06AX7OmJemmcNPTT9zVrpXfUlJZ9jtzxfasYcwM2dnOruGT4CIB/cIym/W+18ikKFQLWMk5ht+Sv
 fvl56wMlfC+MwAgBex16f0J1qTa0BsB27zxm7iC0tqooCN4/bhSTb/GubcDg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices with Metadata output (like uvc), create two video devices, one
for the data itself and another one for the metadata.

Add a "Meta: " to the beginning of the device name, as suggested by Mauro,
to avoid having multiple devices with the same name.

Fixes v4l2-compliance:
Media Controller ioctls:
     fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
   test MEDIA_IOC_G_TOPOLOGY: FAIL
     fail: v4l2-test-media.cpp(394): num_data_links != num_links
   test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL

Suggested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 397d553177fa..5c2c9ebb6b96 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -901,6 +901,15 @@ int __video_register_device(struct video_device *vdev,
 	if (WARN_ON(type != VFL_TYPE_SUBDEV && !vdev->device_caps))
 		return -EINVAL;
 
+	/* Add Meta: to metadata device names */
+	if (vdev->device_caps &
+	    (V4L2_CAP_META_CAPTURE | V4L2_CAP_META_OUTPUT)) {
+		char aux[sizeof(vdev->name)];
+
+		snprintf(aux, sizeof(aux), "Meta: %s", vdev->name);
+		strscpy(vdev->name, aux, sizeof(aux));
+	}
+
 	/* v4l2_fh support */
 	spin_lock_init(&vdev->fh_lock);
 	INIT_LIST_HEAD(&vdev->fh_list);

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
