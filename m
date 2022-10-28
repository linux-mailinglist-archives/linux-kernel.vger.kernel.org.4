Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900C26109A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJ1FLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJ1FLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:11:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FB9DAC46;
        Thu, 27 Oct 2022 22:10:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so8851290pji.1;
        Thu, 27 Oct 2022 22:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EW5mS+GWU1SupYaIIjSXlUc0IhtqJK+50Uo45NdbWBY=;
        b=q6yImUxFLTMfanG+izGED95xKf3LufN3J34sg6wfjnz9NMfpaYj8F4MEKJ7vWziSNY
         37S4Gra4Kr3oQNfnmI7g6yZIwJyrIj3kgEXO5xxhpMKXRde+8/x8VdNxmtEyPPwlnFad
         Qi+G6D00gt+jSvM4/n2MeS2L2HLch255epOJ2r/83DrmquuGt2UTgZW+6ma/nLnHX0KO
         Vgjr14CKLyOenoWatMLS4VBRmwz8GpabUezC+w/LZgxkQKeaj/py+3bo6nlvDW2aIp97
         ZNZ1zkT9kcQEy/DSvXKWzTAV73ZFeSvRR48bPpY/7C5UlAtlkJ2KIBqFYwKJDUJVu6OH
         KhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EW5mS+GWU1SupYaIIjSXlUc0IhtqJK+50Uo45NdbWBY=;
        b=YBN+Ti9Qc7duuAXwa9A2fXV/WdFJE1nOw7Au3BTrPM4OBHkfR/pSok5Nn0osrsJllr
         CLx+bIoKODlaA5vcH9YrNmN+DBqH6a3UdiYzpMNJuF9vIvoXJ+FNGNXTuEA/Z/oX0l02
         LT6hngTTKZxjYgy2lnM2XxhVesXYzqLoDjNfWpCPqxcI7niLfbiIgbVy/cjFBrnYy3sP
         J3FVwAcyxnnVcq3T5oC8PpAy6OH4yGfiLl+hU8b55DiQJNuXW5LnqiHOCVl7zTFc82hS
         iEWY0+EoteMMegiyZVRKEBH1jVToKzvOUYS0hlKaZd3mnrBAxxeY4Wz7q1Fb3NKRB/W9
         1M2g==
X-Gm-Message-State: ACrzQf38B+huRaAogahorRTgODVchbjZ5DtLr0jta+z3EEvhrB4HUatO
        baYDLM/7IVODHSgZLNpuq/4=
X-Google-Smtp-Source: AMsMyM5GM/3tLFRJYxepSO/XFCIBgVeZFKsq4TMsmUupAFVXO71DeS3BNZM+MP1OT/kUE34Oyew6lg==
X-Received: by 2002:a17:902:ef43:b0:186:99be:2ee9 with SMTP id e3-20020a170902ef4300b0018699be2ee9mr12142176plx.148.1666933859072;
        Thu, 27 Oct 2022 22:10:59 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b0018691ce1696sm2075367plk.131.2022.10.27.22.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 22:10:58 -0700 (PDT)
Date:   Fri, 28 Oct 2022 18:10:49 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Grigory Vasilyev <h0tc0d3@gmail.com>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Claudio Suarez <cssk@net-c.es>,
        Slark Xiao <slark_xiao@163.com>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] [next] drm/amdgpu: Replace one-element array with
 flexible-array member
Message-ID: <Y1tkWdwPUp+UdpM0@mail.google.com>
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
flexible-array member in struct _ATOM_FAKE_EDID_PATCH_RECORD and
refactor the rest of the code accordingly.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/238
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 10 +++++++---
 drivers/gpu/drm/amd/include/atombios.h         |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index 6be9ac2b9c5b..6b5abf1249db 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -2079,10 +2079,14 @@ amdgpu_atombios_encoder_get_lcd_info(struct amdgpu_encoder *encoder)
 							} else
 								kfree(edid);
 						}
+
+						record += struct_size(fake_edid_record,
+								      ucFakeEDIDString,
+								      fake_edid_record->ucFakeEDIDLength);
+					} else {
+						/* empty fake edid record must be 3 bytes long */
+						record += sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
 					}
-					record += fake_edid_record->ucFakeEDIDLength ?
-						fake_edid_record->ucFakeEDIDLength + 2 :
-						sizeof(ATOM_FAKE_EDID_PATCH_RECORD);
 					break;
 				case LCD_PANEL_RESOLUTION_RECORD_TYPE:
 					panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
diff --git a/drivers/gpu/drm/amd/include/atombios.h b/drivers/gpu/drm/amd/include/atombios.h
index 15943bc21bc5..b5b1d073f8e2 100644
--- a/drivers/gpu/drm/amd/include/atombios.h
+++ b/drivers/gpu/drm/amd/include/atombios.h
@@ -4107,7 +4107,7 @@ typedef struct _ATOM_FAKE_EDID_PATCH_RECORD
 {
   UCHAR ucRecordType;
   UCHAR ucFakeEDIDLength;       // = 128 means EDID length is 128 bytes, otherwise the EDID length = ucFakeEDIDLength*128
-  UCHAR ucFakeEDIDString[1];    // This actually has ucFakeEdidLength elements.
+  UCHAR ucFakeEDIDString[];     // This actually has ucFakeEdidLength elements.
 } ATOM_FAKE_EDID_PATCH_RECORD;
 
 typedef struct  _ATOM_PANEL_RESOLUTION_PATCH_RECORD
-- 
2.37.3

