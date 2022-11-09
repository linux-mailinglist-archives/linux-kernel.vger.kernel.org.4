Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CC46224AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKIHdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIHdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:33:45 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156D13D30;
        Tue,  8 Nov 2022 23:33:44 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d20so15266075plr.10;
        Tue, 08 Nov 2022 23:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfaZWHmp3/7/i2FUcNx0O07NB6LAM0d+BKVvnY3XIXQ=;
        b=OxH7ylJeFIRsKDTt8VIrBbStjYgYgrC93Tuq1Ce85J8FaMUb331253zbKb/d+gz2CV
         S3BHwSUR9VEt/01g5dj7YZvuAZyPadh8mQRXt6IM8M0FB4G2uVQ7qoZw3iH3XWAnOMWk
         DR5iA9VuGZC1f56rYHWLX6xWDjZq0/JK2LIs+FCPyYGkK/OtTq0nYFxiKJfEiKvunL/J
         +0W5RS7MzpoxZFXoRFjpBhZNk9anROYWmyI1+3e6wg9wijWiEJQoTE9A95pVtTFzp2Qb
         wsG00051zMCpPfTU8PyVl8OwPpk4vd7I2d4Y8Pp33cQjQTNVa7kNQhySRgzRzq6w6Vhr
         mlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfaZWHmp3/7/i2FUcNx0O07NB6LAM0d+BKVvnY3XIXQ=;
        b=PWExWd0RXUQpm6kJyFpIMKBjQCmpJ6hCIjmPlvcTaZO86hdH7Vf0oO1M4GS+0mIEEc
         9dEvaZKgq3mUMDOYXtoHv/qVmEYc6tkPVOWoN94uvYy2DFhJ8zsTDzdZ+ts5zZ5GFKSZ
         +8dHEdNYiFpR5brJxUhkVBNjwAW00HkVc2x47LdGiQTJbrzNUnkYruk+BBs/1gq+jjUm
         F7EqB8F8nV0RPob16WH/T3kEgDSpvLtK4xZZCK1HN/IAQqR21eIi9SlJ4k8tt9LzJQ0f
         f2kvXd7ybHh9VZUQyW5X8wrV6uvfrP1Pc3GqgUYX5wUrJ3OUG8/7lQIkWMtYB77ULAne
         MUxg==
X-Gm-Message-State: ACrzQf2f5s69vZv1IdYm0P4VHQsN1DVawUt8eShFeIeQ/fdMQ/aA3j0j
        gcbyJRpxO7lMtrQdxtH1gJU=
X-Google-Smtp-Source: AMsMyM6iyKbmrHTGvEYKCrZ50oQgQv0Ff9njXJS1jo3Tv6lFn+hlfJwcat4xY6pODaaQZDQI2KIO6A==
X-Received: by 2002:a17:90b:19d1:b0:213:7030:6bd9 with SMTP id nm17-20020a17090b19d100b0021370306bd9mr61643441pjb.43.1667979223474;
        Tue, 08 Nov 2022 23:33:43 -0800 (PST)
Received: from mail.google.com (125-237-50-34-fibre.sparkbb.co.nz. [125.237.50.34])
        by smtp.gmail.com with ESMTPSA id h14-20020a056a00000e00b0056bc9294e1asm7579920pfk.24.2022.11.08.23.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 23:33:43 -0800 (PST)
Date:   Wed, 9 Nov 2022 20:33:34 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        Slark Xiao <slark_xiao@163.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] drm/amdgpu: Replace one-element array with flex-array
 member
Message-ID: <Y2tXzlBDxgg9WMl7@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with
flexible array members instead. So, replace one-element array with
flexible-array member in structs _ATOM_CONNECTOR_DEVICE_TAG_RECORD,
_ATOM_OBJECT_GPIO_CNTL_RECORD, _ATOM_BRACKET_LAYOUT_RECORD,
_ATOM_BRACKET_LAYOUT_RECORD, _ATOM_LEAKAGE_VOLTAGE_OBJECT_V3,
_ATOM_FUSION_SYSTEM_INFO_V3, _ATOM_I2C_DATA_RECORD,
_ATOM_I2C_DEVICE_SETUP_INFO, _ATOM_ASIC_MVDD_INFO and refactor the
rest of the code accordingly. While at it, removed a redundant casting.

Important to mention is that doing a build before/after this patch results
in no binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/238
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---

Alex, I noticed a few structs in atombios.h that were not referenced. Is
there any appetite for removing them? Or is that one of those cases
where the structs are there should one driver ever need it?

Ex.:
	struct _ATOM_I2C_DATA_RECORD
	struct _ATOM_I2C_DEVICE_SETUP_INFO
	struct _ATOM_ASIC_MVDD_INFO
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c    |  5 ++---
 drivers/gpu/drm/amd/include/atombios.h           | 16 ++++++++--------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 39dd8b2dc254..6b9e64cd4379 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2606,8 +2606,7 @@ static enum bp_result update_slot_layout_info(
 
 	for (;;) {
 
-		record_header = (ATOM_COMMON_RECORD_HEADER *)
-			GET_IMAGE(ATOM_COMMON_RECORD_HEADER, record_offset);
+		record_header = GET_IMAGE(ATOM_COMMON_RECORD_HEADER, record_offset);
 		if (record_header == NULL) {
 			result = BP_RESULT_BADBIOSTABLE;
 			break;
@@ -2621,7 +2620,7 @@ static enum bp_result update_slot_layout_info(
 
 		if (record_header->ucRecordType ==
 			ATOM_BRACKET_LAYOUT_RECORD_TYPE &&
-			sizeof(ATOM_BRACKET_LAYOUT_RECORD)
+			struct_size(record, asConnInfo, 1)
 			<= record_header->ucRecordSize) {
 			record = (ATOM_BRACKET_LAYOUT_RECORD *)
 				(record_header);
diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index 55ae93c1e365..60c44a8a067f 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -4733,7 +4733,7 @@ typedef struct  _ATOM_CONNECTOR_DEVICE_TAG_RECORD
   ATOM_COMMON_RECORD_HEADER   sheader;
   UCHAR                       ucNumberOfDevice;
   UCHAR                       ucReserved;
-  ATOM_CONNECTOR_DEVICE_TAG   asDeviceTag[1];         //This Id is same as "ATOM_DEVICE_XXX_SUPPORT", 1 is only for allocation
+  ATOM_CONNECTOR_DEVICE_TAG   asDeviceTag[];	       //This Id is same as "ATOM_DEVICE_XXX_SUPPORT"
 }ATOM_CONNECTOR_DEVICE_TAG_RECORD;
 
 
@@ -4793,7 +4793,7 @@ typedef struct  _ATOM_OBJECT_GPIO_CNTL_RECORD
   ATOM_COMMON_RECORD_HEADER   sheader;
   UCHAR                       ucFlags;                // Future expnadibility
   UCHAR                       ucNumberOfPins;         // Number of GPIO pins used to control the object
-  ATOM_GPIO_PIN_CONTROL_PAIR  asGpio[1];              // the real gpio pin pair determined by number of pins ucNumberOfPins
+  ATOM_GPIO_PIN_CONTROL_PAIR  asGpio[];               // the real gpio pin pair determined by number of pins ucNumberOfPins
 }ATOM_OBJECT_GPIO_CNTL_RECORD;
 
 //Definitions for GPIO pin state
@@ -4982,7 +4982,7 @@ typedef struct  _ATOM_BRACKET_LAYOUT_RECORD
   UCHAR                       ucWidth;
   UCHAR                       ucConnNum;
   UCHAR                       ucReserved;
-  ATOM_CONNECTOR_LAYOUT_INFO  asConnInfo[1];
+  ATOM_CONNECTOR_LAYOUT_INFO  asConnInfo[];
 }ATOM_BRACKET_LAYOUT_RECORD;
 
 
@@ -5161,7 +5161,7 @@ typedef struct  _ATOM_GPIO_VOLTAGE_OBJECT_V3
    UCHAR  ucPhaseDelay;                      // phase delay in unit of micro second
    UCHAR  ucReserved;
    ULONG  ulGpioMaskVal;                     // GPIO Mask value
-   VOLTAGE_LUT_ENTRY_V2 asVolGpioLut[1];
+   VOLTAGE_LUT_ENTRY_V2 asVolGpioLut[];
 }ATOM_GPIO_VOLTAGE_OBJECT_V3;
 
 typedef struct  _ATOM_LEAKAGE_VOLTAGE_OBJECT_V3
@@ -5171,7 +5171,7 @@ typedef struct  _ATOM_LEAKAGE_VOLTAGE_OBJECT_V3
    UCHAR    ucLeakageEntryNum;               // indicate the entry number of LeakageId/Voltage Lut table
    UCHAR    ucReserved[2];
    ULONG    ulMaxVoltageLevel;
-   LEAKAGE_VOLTAGE_LUT_ENTRY_V2 asLeakageIdLut[1];
+   LEAKAGE_VOLTAGE_LUT_ENTRY_V2 asLeakageIdLut[];
 }ATOM_LEAKAGE_VOLTAGE_OBJECT_V3;
 
 
@@ -6599,7 +6599,7 @@ typedef struct _ATOM_FUSION_SYSTEM_INFO_V3
 typedef struct _ATOM_I2C_DATA_RECORD
 {
   UCHAR         ucNunberOfBytes;                                              //Indicates how many bytes SW needs to write to the external ASIC for one block, besides to "Start" and "Stop"
-  UCHAR         ucI2CData[1];                                                 //I2C data in bytes, should be less than 16 bytes usually
+  UCHAR         ucI2CData[];                                                  //I2C data in bytes, should be less than 16 bytes usually
 }ATOM_I2C_DATA_RECORD;
 
 
@@ -6610,14 +6610,14 @@ typedef struct _ATOM_I2C_DEVICE_SETUP_INFO
   UCHAR                              ucSSChipID;             //SS chip being used
   UCHAR                              ucSSChipSlaveAddr;      //Slave Address to set up this SS chip
   UCHAR                           ucNumOfI2CDataRecords;  //number of data block
-  ATOM_I2C_DATA_RECORD            asI2CData[1];
+  ATOM_I2C_DATA_RECORD            asI2CData[];
 }ATOM_I2C_DEVICE_SETUP_INFO;
 
 //==========================================================================================
 typedef struct  _ATOM_ASIC_MVDD_INFO
 {
   ATOM_COMMON_TABLE_HEADER         sHeader;
-  ATOM_I2C_DEVICE_SETUP_INFO      asI2CSetup[1];
+  ATOM_I2C_DEVICE_SETUP_INFO      asI2CSetup[];
 }ATOM_ASIC_MVDD_INFO;
 
 //==========================================================================================
-- 
2.37.3

