Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945E86F3245
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjEAOuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjEAOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:49:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55141A4
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 07:49:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f32588c13so443281366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682952595; x=1685544595;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rvvhU8wWlyXvX59GJzXDd4SAhcp0R40600A2WSsjQCU=;
        b=DdMPcLyorEFlovOJpl9fLMRLN9wfxR8lsYvity7/6D7eIRi4YxTopDnQmocELkI9r4
         kAvL758HqOAVf9nIzwKKTpFJP7CU5RR/L9Y+8fs3s3uY0Xw/DlliNe32xxtiwRZnJo5b
         zzAnlvYd08drp6X+dIGOTvQ2MsKZeBfl30idw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682952595; x=1685544595;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rvvhU8wWlyXvX59GJzXDd4SAhcp0R40600A2WSsjQCU=;
        b=ka7I3XIDfhcnb5v2oSf0z8iLaXdGaZMvhA5tr/R5xhnBbJ0t3g3VGsbsdh71Qw1hQX
         3auHWaJGlqCqRySZwhc37BQCuOnrwZxah3t0aLemJRMmk/27eScGTDugkqqcjmBV7qUT
         jdhvULmjAxHRLdpjuHMj5xUn13nXCepwoyPkdAwBYDz3n448ZjSE/V+KfDSF1ovI2gdO
         3vpUcEfCq2UMTrJP0qnMkiPOYdXSO6Fij6dB3avA4tVe7neLcHNryEKDAwwrar7ANYeF
         9zcrU+XOM8EAItz1ls08I0MV3+6oQuIEv5ziDYxhgJyB0TuZxSpYzfgFces/cv+rOpWg
         pFpw==
X-Gm-Message-State: AC+VfDwEyjY1Xtjuq5Np/lED6v5BrDbPMgdkEdhQl9bamnHiLn6RaXCb
        T70W44aw4YD54IzTP/kHj72mdQ==
X-Google-Smtp-Source: ACHHUZ7zicWpZbqz3u/RVnTpio+1L48c7cRrgsyirUbhFxhvsY3vAK7FoM0EH/TWOtEDUjFFQJd3eA==
X-Received: by 2002:a17:906:db0b:b0:961:a67:296 with SMTP id xj11-20020a170906db0b00b009610a670296mr10458525ejb.11.1682952595431;
        Mon, 01 May 2023 07:49:55 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c573:159e:712e:688b])
        by smtp.gmail.com with ESMTPSA id h26-20020a1709070b1a00b00960681949cbsm5606686ejl.134.2023.05.01.07.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 07:49:55 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 01 May 2023 16:49:31 +0200
Subject: [PATCH] media: uvcvideo: Explicit alignment of uvc_frame and
 uvc_format
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230501-uvc-align-v1-1-0f713e4b84c3@chromium.org>
X-B4-Tracking: v=1; b=H4sIAHrRT2QC/x2N0QqDMAxFf0XyvEB1WGS/MvaQ1rQGSjZaFKH47
 4Y9nsM93A6Nq3CD19Ch8iFNvmowPgaIG2lmlNUYJjc93exG3I+IVCQr+pTMBr+sFMD2gRpjqKR
 xs0L3Ukz+Kic5/wfvz3XdcCN7P3AAAAA=
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Vxpk13BEkb45v/Y9lLJttKAMg3eyx7qSZM/zW12+rYo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkT9GGfmhNniu6baplutKWVfxMaVpR4+3/2O/pi
 WMJ9jtReh+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZE/RhgAKCRDRN9E+zzrE
 iIS7EACa1Q01B002rY4CA0fSEPeiQf5cgieVsgSViNs8BMHJ0HP/0yS44oHcQ5NkNJ+tKparhHp
 5T3yxb+uxX6lHUpU9/wll6hLsQHDQeHRbcwi3vIP7g8haZke0VKxyeIfLxSK7pHjA3FABtY7md7
 Ckz1RYlorVJ1+0kKrcIIEGZ55vdPussmY+3F5VSG0elPT777CJRt4T7GJTvDK1SAT/pPWCW9WIV
 SX0iEO9nuXEO9VaLNnOnO3f/pitAp4BizmvT/j5XPjRvinr9wQu2+1lQVk3rV15h5NcW5Kuj+OY
 Ccc7HXZWc/whytJLiSyie0Wp5/ulgzb3+ZlFcF++AC9XBZEn7YF849TfrIjnevgjPaH+sb3rAIJ
 ooJHgD0j+AqBHBUdnJ5D0//yrskN25nhBbD4FiZYZZmVwUjcUU7S1sPMrRp7dacf1Pdi/pSAgXB
 HQFUq0Q8VJlcyLVPcE0ShkNz/AqTrP0rdNwhJauCK+0WJrK3DtNXbdGnyt2nADmJifVRLpAFmNo
 DPl+29PIwd1TqfX0s3lSFJvi7zvHkSy5xAq3Tjk9NLcw4x1O5dGIGWzQGpDdhC/aIXsEUAyhOO/
 nR+EgutMTHUJ2QG2L/rSTb7DQ2bHgilv7MIwAB9v7va4TNwCozf6Xr8YQ01WV7qrqO7UfObwj7N
 9UhTfDPG72tUg3Q==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct uvc_frame and uvc_format are packaged together on
streaming->formats on a sigle allocation.

This is working fine because both structures have a field with a
pointer, but it will stop working when the sizeof() of any of those
structs is not a muliple of the sizeof(void*).

Make that aligment contract explicit.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
This is better than 3 allocations, and do not have any performance
penalty.
---
 drivers/media/usb/uvc/uvcvideo.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 9a596c8d894a..03e8a543c8e6 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -252,7 +252,7 @@ struct uvc_frame {
 	u8  bFrameIntervalType;
 	u32 dwDefaultFrameInterval;
 	u32 *dwFrameInterval;
-};
+} __aligned(sizeof(void *)); /* uvc_frame is packed on streaming->formats. */
 
 struct uvc_format {
 	u8 type;
@@ -266,7 +266,7 @@ struct uvc_format {
 
 	unsigned int nframes;
 	struct uvc_frame *frame;
-};
+} __aligned(sizeof(void *)); /* uvc_format is packed on streaming->formats. */
 
 struct uvc_streaming_header {
 	u8 bNumFormats;

---
base-commit: 58390c8ce1bddb6c623f62e7ed36383e7fa5c02f
change-id: 20230501-uvc-align-6ff202b68dab

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

