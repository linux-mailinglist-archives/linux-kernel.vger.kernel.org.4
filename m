Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9949261EF13
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKGJdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiKGJdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:33:02 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F657167FB;
        Mon,  7 Nov 2022 01:33:01 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s196so9960871pgs.3;
        Mon, 07 Nov 2022 01:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HyF0E2uS8X0XmlEoNWDzlwWSu7iz2vHvvgzUM/YnP+A=;
        b=CoSZl3HBAWY7ETrvTdR5S7+/MmJmuqylZeECCz9wlPJT+OIEeoDq009df1e+5/csjW
         rx8+mP8rUTmBT88nDvqZCEnQF3Zh1qesZN5TDb47yft5nJx6V0SEPpg4uf93sRBVPwc4
         R2ju+NpUXsrXpu5IXVYKruw/6TMl2hSxJsbNv/0xx4ymRqb5SDPWdkmXoV8U7CIrp5Xa
         8ux57lPMa4NT+ctiVfq/Sf1EuliuFnjiO7+JhlL0byaECuR0a2HaMnFKKK8Po5F4lOZb
         UryIBc1oJi/HPwu8ISeMI65d8Oa1uOd6toUbydYIYctLpmpMOvQDaeywxveMCslUQMdN
         8AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyF0E2uS8X0XmlEoNWDzlwWSu7iz2vHvvgzUM/YnP+A=;
        b=tafENdFCTVKLO38FQYCFCXZ7TSYURJyFzUkUxn+JSW0kzmFODIsaDV3OhAEQC5RVRK
         8c6wS/GFsSyW5MbUXWZKYIno//9tOmoGQV6NHhj+aJXyytA+3zwFWpf99rtsytm6w4qB
         MzcNpZi8DV2uaFVsVZ3J+Eo+Sgg5TWqXBWJpXHlZcrYK4eIl0IZ5GwW9vSOTzmmBtJh5
         ENKhn9uSXd808HCOo0s7iYtW05e+kGCmYKD+MwD2hRm6MLOxTdl1EIrQXIt72GrM30Um
         YsUZh3cQ9m00dfcr0iOKh5BwI5x+OZtfc/5VuZwcQ4J16F79YN6wteVPoOUxJJIoBwjx
         LMAA==
X-Gm-Message-State: ACrzQf2tdQFmWGZ/Ov/5OkaiDKoNkwAUxCDmvAU1RaSYOTnMGq+8CyXi
        Qv2ej2+tE7UzUCv8KBv/4fg=
X-Google-Smtp-Source: AMsMyM5Awr0jJbRUWHXZ5qyYgIfGaxsEijvpVNZMKUQ+4/4fy+co78DyrzE+K9CCq9kjgWxVM8rnTw==
X-Received: by 2002:a63:2bd4:0:b0:451:5df1:4b15 with SMTP id r203-20020a632bd4000000b004515df14b15mr42870684pgr.518.1667813580875;
        Mon, 07 Nov 2022 01:33:00 -0800 (PST)
Received: from mail.google.com (125-237-50-34-fibre.sparkbb.co.nz. [125.237.50.34])
        by smtp.gmail.com with ESMTPSA id e24-20020a63db18000000b00460fbe0d75esm3768526pgg.31.2022.11.07.01.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:33:00 -0800 (PST)
Date:   Mon, 7 Nov 2022 22:32:51 +1300
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
        Slark Xiao <slark_xiao@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] drm/amdgpu: Replace 1-element array with
 flexible-array member
Message-ID: <Y2jQw6ve83Bvb/D9@mail.google.com>
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
flexible-array member in structs _ATOM_GPIO_PIN_ASSIGNMENT,
_ATOM_DISPLAY_OBJECT_PATH, _ATOM_DISPLAY_OBJECT_PATH_TABLE,
_ATOM_OBJECT_TABLE and refactor the rest of the code accordingly.

Important to mention is that doing a build before/after this patch results
in no functional binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/238
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---

Binary difference findings:

	Some changes took more than a single line which changed the line
	number parameter passed to the drm_dbg function (which leverages
	kernel's dynamic debugging). Functionally-wise, nothing changed
	after doing a before/after patch build.

Additional one-element arrays to be changed:

	There are more instances of one-element arrays to be changed but
	I will keep patches small so they are easy to review. [and I can
	only dedicate a few hours per day on this :-) ]

---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 23 ++++++++++++-------
 drivers/gpu/drm/amd/include/atombios.h        |  8 +++----
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 9b8ea6e9a2b9..39dd8b2dc254 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -138,7 +138,9 @@ static uint8_t get_number_of_objects(struct bios_parser *bp, uint32_t offset)
 
 	uint32_t object_table_offset = bp->object_info_tbl_offset + offset;
 
-	table = GET_IMAGE(ATOM_OBJECT_TABLE, object_table_offset);
+	table = ((ATOM_OBJECT_TABLE *) bios_get_image(&bp->base,
+				object_table_offset,
+				struct_size(table, asObjects, 1)));
 
 	if (!table)
 		return 0;
@@ -166,8 +168,9 @@ static struct graphics_object_id bios_parser_get_connector_id(
 	uint32_t connector_table_offset = bp->object_info_tbl_offset
 		+ le16_to_cpu(bp->object_info_tbl.v1_1->usConnectorObjectTableOffset);
 
-	ATOM_OBJECT_TABLE *tbl =
-		GET_IMAGE(ATOM_OBJECT_TABLE, connector_table_offset);
+	ATOM_OBJECT_TABLE *tbl = ((ATOM_OBJECT_TABLE *) bios_get_image(&bp->base,
+				connector_table_offset,
+				struct_size(tbl, asObjects, 1)));
 
 	if (!tbl) {
 		dm_error("Can't get connector table from atom bios.\n");
@@ -1789,11 +1792,13 @@ static enum bp_result bios_parser_get_gpio_pin_info(
 	if (!DATA_TABLES(GPIO_Pin_LUT))
 		return BP_RESULT_BADBIOSTABLE;
 
-	header = GET_IMAGE(ATOM_GPIO_PIN_LUT, DATA_TABLES(GPIO_Pin_LUT));
+	header = ((ATOM_GPIO_PIN_LUT *) bios_get_image(&bp->base,
+				DATA_TABLES(GPIO_Pin_LUT),
+				struct_size(header, asGPIO_Pin, 1)));
 	if (!header)
 		return BP_RESULT_BADBIOSTABLE;
 
-	if (sizeof(ATOM_COMMON_TABLE_HEADER) + sizeof(ATOM_GPIO_PIN_LUT)
+	if (sizeof(ATOM_COMMON_TABLE_HEADER) + struct_size(header, asGPIO_Pin, 1)
 			> le16_to_cpu(header->sHeader.usStructureSize))
 		return BP_RESULT_BADBIOSTABLE;
 
@@ -1978,7 +1983,8 @@ static ATOM_OBJECT *get_bios_object(struct bios_parser *bp,
 
 	offset += bp->object_info_tbl_offset;
 
-	tbl = GET_IMAGE(ATOM_OBJECT_TABLE, offset);
+	tbl = ((ATOM_OBJECT_TABLE *) bios_get_image(&bp->base, offset,
+				struct_size(tbl, asObjects, 1)));
 	if (!tbl)
 		return NULL;
 
@@ -2709,8 +2715,9 @@ static enum bp_result get_bracket_layout_record(
 
 	genericTableOffset = bp->object_info_tbl_offset +
 		bp->object_info_tbl.v1_3->usMiscObjectTableOffset;
-	object_table = (ATOM_OBJECT_TABLE *)
-		GET_IMAGE(ATOM_OBJECT_TABLE, genericTableOffset);
+	object_table = ((ATOM_OBJECT_TABLE *) bios_get_image(&bp->base,
+				genericTableOffset,
+				struct_size(object_table, asObjects, 1)));
 	if (!object_table)
 		return BP_RESULT_FAILURE;
 
diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index b5b1d073f8e2..55ae93c1e365 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -4386,7 +4386,7 @@ typedef struct _ATOM_GPIO_PIN_ASSIGNMENT
 typedef struct _ATOM_GPIO_PIN_LUT
 {
   ATOM_COMMON_TABLE_HEADER  sHeader;
-  ATOM_GPIO_PIN_ASSIGNMENT   asGPIO_Pin[1];
+  ATOM_GPIO_PIN_ASSIGNMENT   asGPIO_Pin[];
 }ATOM_GPIO_PIN_LUT;
 
 /****************************************************************************/
@@ -4513,7 +4513,7 @@ typedef struct  _ATOM_DISPLAY_OBJECT_PATH
   USHORT    usSize;                                        //the size of ATOM_DISPLAY_OBJECT_PATH
   USHORT    usConnObjectId;                                //Connector Object ID
   USHORT    usGPUObjectId;                                 //GPU ID
-  USHORT    usGraphicObjIds[1];                            //1st Encoder Obj source from GPU to last Graphic Obj destinate to connector.
+  USHORT    usGraphicObjIds[];                            //1st Encoder Obj source from GPU to last Graphic Obj destinate to connector.
 }ATOM_DISPLAY_OBJECT_PATH;
 
 typedef struct  _ATOM_DISPLAY_EXTERNAL_OBJECT_PATH
@@ -4530,7 +4530,7 @@ typedef struct _ATOM_DISPLAY_OBJECT_PATH_TABLE
   UCHAR                           ucNumOfDispPath;
   UCHAR                           ucVersion;
   UCHAR                           ucPadding[2];
-  ATOM_DISPLAY_OBJECT_PATH        asDispPath[1];
+  ATOM_DISPLAY_OBJECT_PATH        asDispPath[];
 }ATOM_DISPLAY_OBJECT_PATH_TABLE;
 
 typedef struct _ATOM_OBJECT                                //each object has this structure
@@ -4545,7 +4545,7 @@ typedef struct _ATOM_OBJECT_TABLE                         //Above 4 object table
 {
   UCHAR               ucNumberOfObjects;
   UCHAR               ucPadding[3];
-  ATOM_OBJECT         asObjects[1];
+  ATOM_OBJECT         asObjects[];
 }ATOM_OBJECT_TABLE;
 
 typedef struct _ATOM_SRC_DST_TABLE_FOR_ONE_OBJECT         //usSrcDstTableOffset pointing to this structure
-- 
2.37.3

