Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF97611FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 05:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiJ2DcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 23:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2DcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 23:32:16 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358FA109D40;
        Fri, 28 Oct 2022 20:32:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id m6so6369922pfb.0;
        Fri, 28 Oct 2022 20:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHF9euNOOmuwTSh72fVwWU/hhjv7B36F6rq6GHbm0Ws=;
        b=jK5E1boC3hu8E7IKKZ6CHa/8w55eH6o4SWLIwK/DleiUhoRlRDg0nhbUtjDD76L7q5
         93OjujLRcE31fBxMQ2A0Gq0z7tfH3bVlJrRbhHYggtjqQOD3sXuqsv9rLVy3tUHpT+Yc
         VdPaxC13yA9VPuPQa1jUO32XmDCgV05Qw6tk86KFBLTLTEi1+16B2KRw/EOFxOQhUxRd
         23NpFy8Er4yVa2BlmTYeUNvzKWgQPO81xAkxWaP0kL+zrWMnGOgCmpkjnHdOb3S3ECSE
         9rmz+S8TZ8vjt7qSFnvAXDJHEa/g8fsHS8FkZdPyqZsJl1Sk4yoAL+/UVz9wjHiUBH4h
         TpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHF9euNOOmuwTSh72fVwWU/hhjv7B36F6rq6GHbm0Ws=;
        b=kA7DITuHr4/ncGOpM2w2vhY9R60L9IQQnw0z56tJkBsHt3eQ+RNBrw8yUqYDpxKmI1
         Frg6JzkYpOfiv9qwNGW2tsSlFXGR3CX0IL+1p4spxGCclnsnMPTn1eXKRyHdVXAW/v7c
         tHL3V3SRTtaVxY9/LGQHGBBfuytBePj3y2S+UqCpzda/r1ofXJ7Vhb+4UJ6qsoRheajr
         Dg2vr7PZkwCvILkL8EGNnz2e4fw3W6W8MusCN/MAGrUTc1RnprqNXIBtyoFy5rAgq3n5
         QKGFwl8QMbcP//rvP7NMOyWcE0QFqduNmu/J1g+rNfPzZFc3NdwAaFLFyd3z60w2+vQa
         MPNw==
X-Gm-Message-State: ACrzQf1bDMdiAz9lbAE1JMEp2xVOxBxDUp5MYjNfdn+XPI9vylpldjdI
        A3oMmfAFIytiDbwwpRE6EzU=
X-Google-Smtp-Source: AMsMyM4/G+OuCQ0NgmhKRELRXL1n+O5c6TyxtS8A7lOlSNpmzBFb7z6dw442d6bOx/QJA+JG8vf/tQ==
X-Received: by 2002:aa7:8b46:0:b0:56c:349f:191e with SMTP id i6-20020aa78b46000000b0056c349f191emr2663102pfd.29.1667014334674;
        Fri, 28 Oct 2022 20:32:14 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090a2e8200b002086ac07041sm166491pjd.44.2022.10.28.20.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:32:13 -0700 (PDT)
Date:   Sat, 29 Oct 2022 16:32:05 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH v2] [next] drm/radeon: Replace one-element array with
 flexible-array member
Message-ID: <Y1yetX1CHsr+fibp@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1trhRE3nK5iAY6q@mail.google.com>
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

It's worth mentioning that doing a build before/after this patch results
in no binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/239
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Changelog:

v2: no binary output differences patch; report binary changes findings
    on commit log. Res: Kees Cook.
    
    This request was made in an identical, yet different, patch but the
    same feedback applies.
    https://lore.kernel.org/lkml/Y1x3MtRJ8ckXxlJn@mail.google.com/

v1: https://lore.kernel.org/lkml/Y1trhRE3nK5iAY6q@mail.google.com/
---
 drivers/gpu/drm/radeon/atombios.h        | 2 +-
 drivers/gpu/drm/radeon/radeon_atombios.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
index da35a970fcc0..235e59b547a1 100644
--- a/drivers/gpu/drm/radeon/atombios.h
+++ b/drivers/gpu/drm/radeon/atombios.h
@@ -3615,7 +3615,7 @@ typedef struct _ATOM_FAKE_EDID_PATCH_RECORD
 {
   UCHAR ucRecordType;
   UCHAR ucFakeEDIDLength;
-  UCHAR ucFakeEDIDString[1];    // This actually has ucFakeEdidLength elements.
+  UCHAR ucFakeEDIDString[];    // This actually has ucFakeEdidLength elements.
 } ATOM_FAKE_EDID_PATCH_RECORD;
 
 typedef struct  _ATOM_PANEL_RESOLUTION_PATCH_RECORD
diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 204127bad89c..4ad5a328d920 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -1727,8 +1727,11 @@ struct radeon_encoder_atom_dig *radeon_atombios_get_lvds_info(struct
 						}
 					}
 					record += fake_edid_record->ucFakeEDIDLength ?
-						fake_edid_record->ucFakeEDIDLength + 2 :
-						sizeof(ATOM_FAKE_EDID_PATCH_RECORD);
+						  struct_size(fake_edid_record,
+							      ucFakeEDIDString,
+							      fake_edid_record->ucFakeEDIDLength) :
+						  /* empty fake edid record must be 3 bytes long */
+						  sizeof(ATOM_FAKE_EDID_PATCH_RECORD) + 1;
 					break;
 				case LCD_PANEL_RESOLUTION_RECORD_TYPE:
 					panel_res_record = (ATOM_PANEL_RESOLUTION_PATCH_RECORD *)record;
-- 
2.37.3

