Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1568ABE4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 19:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjBDSgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 13:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjBDSgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 13:36:20 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B81C2B61C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 10:36:19 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o13so8048916pjg.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 10:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrHJHK8Zdr16TcwGn3TwxX32NNdTPxwjyBFCNkXFEFU=;
        b=T2rWVBItpU47X8KVDOYWy36VPeE8IN9Cw7nRArDPo+juz8mKl6hu6SZ2c6M2QwmJY/
         4eGPJqMXbDGIDOcYrkPI9d+NEIuq+8oFmyMvAitT0Sl5Ov+gx77jiJ5AGWCNGxYbsAAt
         5St8U9TqiHzJc8M2CLyvpREbYxnfYYQk7NMrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrHJHK8Zdr16TcwGn3TwxX32NNdTPxwjyBFCNkXFEFU=;
        b=HuoC27LTnCK3SZHuD6FAixOmpwNr1O2+OXMzeIHzxqbW6A4ENKzK+bTpN4szdSxNao
         Jy8pHgSYZgZEugOmQWgGSvDqRKzgchBIDZAV557X40FSUEV9e567x+qcinVWE3Mx6o57
         sH/+BfPfMJAkRC4nP7T8rpomPGvKpEzLeTRMA+wseujZRBOcPHxcIZstaU3mXRevt7bz
         ZtdIcJJmAaHOoyO5delBe8RBenAildWTCe5tYrw3bgIIXliPsH0bIXL9BbOcTTHvb5cN
         bSvjasd95IrOJkXBFX1sn3Z8P/SOVMXu8v9qoMDfwDJy5Zg0or7/Da3qbH/b+FHQck3P
         ADQA==
X-Gm-Message-State: AO0yUKWB8bI12r1nbY4NqClmgQm1LvqSGiBgS2FHZAnxFA7O6/VX1eUo
        nvWmTF7MpsN+CuG3//yctEEaKA==
X-Google-Smtp-Source: AK7set+zuQU4i0ckVZwCwCE4lGA97XzQkQ+jgWOSFhT+yQAMii+uU3uZ4SkOiHrIyr2pPxNUXRDVdg==
X-Received: by 2002:a17:902:e40d:b0:198:e708:5630 with SMTP id m13-20020a170902e40d00b00198e7085630mr4092807ple.64.1675535779004;
        Sat, 04 Feb 2023 10:36:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902c38d00b00189e7cb8b89sm3766311plg.127.2023.02.04.10.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 10:36:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] media: mxl5005s: Bounds check size used for max array index
Date:   Sat,  4 Feb 2023 10:36:17 -0800
Message-Id: <20230204183616.never.935-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; h=from:subject:message-id; bh=OztmXbHTMvY41JWA/q+8obbISW/JrOGcwHQDDyl2xnk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3qWh1AkCyDMk+bLR0UHyb14JFBgP+qp2gHZU+2dw KopLPn6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY96loQAKCRCJcvTf3G3AJr+QEA CDM10FT/B7x5+g49ATXm3tfEIbQ0oKk0grSU1JlyxG6Ghj++NbSM4KgWCsS3rAlHtYgD/ELqgN14sB ssQDlnYC/WK1uQ/qVOP5mKLgXc8oQ9Nni4rMo/CZ062s7PU28suk2c0h2zik4ky5+01SVFETROB9bX Q7/AI0FyKI3KeDS6hcGMiatowqXQuj6p4ia95HI3vMXwP/Ptie+nJd5HsK2GA2YeCPSn9RyrlSOicL dxKAAtxGQbTAaUcN/+OpWPBmwiXylgFvzrwUZt2RO+lu/J2mGiT45D0HXAYrOY6fcFfL9n3wGoC5Kl EpNHZ57I0Te48LT0f6IHUq7NLUx6LBDRSBtnWWqKT8E48l3bSIQIThwBj2RWVm4+EQtx4BExx/gAx6 nLAxLRWCXhxde/8+XOSdMrXGlKyqLAMhfF2wOvPIaRUAe1rGar2xZJ1nEVED/VyjW7d9ED80UbhxY0 s1Feuo/AwBrOYOfAS3Tagi5oHpShM+GcMEHPoQxpTR3sS5J+WSBkUF6puU+SBMBPe3foC1H4XqDwN6 YvAE2Rr8asmeD3SME63CbChoHL0fOJm387L9+DuRuO5JukwyNewTS99PqwtAbmDcqNF0Agv5kGHhyl MGK/b907BrhneKJPrI71FA/ErxDsWQPJCyRr7iwUQTcriI/9lTyX7lo99Y0g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of state->CH_Ctrl[i].size in a shift operation implies that its
value can be as much as 32, but the state->CH_Ctrl[i].val array is only
25 in size. Bounds check the size before shifting and looping. Fixes
warnings seen with GCC 13:

../drivers/media/tuners/mxl5005s.c: In function 'MXL_ControlWrite_Group.isra':
../drivers/media/tuners/mxl5005s.c:3450:70: warning: array subscript 32 is above array bounds of 'u16[25]' {aka 'short unsigned int[25]'} [-Warray-bounds=]
 3450 | state->CH_Ctrl[i].val[j] = (u8)((value >> j) & 0x01);
      |  ~~~~~~~~~~~~~~~~~~~~~^~~
../drivers/media/tuners/mxl5005s.c:238:13: note: while referencing 'val'
  238 |         u16 val[25];    /* Binary representation of Value */
      |             ^~~

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: linux-media@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/media/tuners/mxl5005s.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/tuners/mxl5005s.c b/drivers/media/tuners/mxl5005s.c
index 3a509038c8df..06dfab9fb8cb 100644
--- a/drivers/media/tuners/mxl5005s.c
+++ b/drivers/media/tuners/mxl5005s.c
@@ -3423,9 +3423,11 @@ static u16 MXL_ControlWrite_Group(struct dvb_frontend *fe, u16 controlNum,
 
 			if (controlNum == state->Init_Ctrl[i].Ctrl_Num) {
 
-				highLimit = 1 << state->Init_Ctrl[i].size;
+				u16 size = min_t(u16, state->Init_Ctrl[i].size,
+					       ARRAY_SIZE(state->Init_Ctrl[i].val));
+				highLimit = 1 << size;
 				if (value < highLimit) {
-					for (j = 0; j < state->Init_Ctrl[i].size; j++) {
+					for (j = 0; j < size; j++) {
 						state->Init_Ctrl[i].val[j] = (u8)((value >> j) & 0x01);
 						MXL_RegWriteBit(fe, (u8)(state->Init_Ctrl[i].addr[j]),
 							(u8)(state->Init_Ctrl[i].bit[j]),
@@ -3442,9 +3444,11 @@ static u16 MXL_ControlWrite_Group(struct dvb_frontend *fe, u16 controlNum,
 
 			if (controlNum == state->CH_Ctrl[i].Ctrl_Num) {
 
-				highLimit = 1 << state->CH_Ctrl[i].size;
+				u16 size = min_t(u16, state->CH_Ctrl[i].size,
+					       ARRAY_SIZE(state->CH_Ctrl[i].val));
+				highLimit = 1 << size;
 				if (value < highLimit) {
-					for (j = 0; j < state->CH_Ctrl[i].size; j++) {
+					for (j = 0; j < size; j++) {
 						state->CH_Ctrl[i].val[j] = (u8)((value >> j) & 0x01);
 						MXL_RegWriteBit(fe, (u8)(state->CH_Ctrl[i].addr[j]),
 							(u8)(state->CH_Ctrl[i].bit[j]),
-- 
2.34.1

