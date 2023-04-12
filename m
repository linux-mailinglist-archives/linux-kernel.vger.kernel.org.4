Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A788A6DF946
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDLPDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLPDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D706E7EDD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681311774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fOTqvY719R4jZzP4ns7YSiBLEN7m3bKNAvtcXsEuWyw=;
        b=LXSZiBdXZnJ+wHfNzNUFxNwv5jxz6MSFNCTxEC2A31/ZpxMN8ZsK2PGaTDfrckerdXv5P8
        nzzWZ/URbqKZd6YlHO6vpojaOoxHBxMeKa+vig5NhcNA+Y88pl7gf61POnun3jNkgSU5fq
        /fWuQC5ySeSQMGlvJrwQyCSVdw03LYE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-h75HzmqYPN-vw8m_MbpyNg-1; Wed, 12 Apr 2023 11:02:47 -0400
X-MC-Unique: h75HzmqYPN-vw8m_MbpyNg-1
Received: by mail-wm1-f69.google.com with SMTP id k24-20020a05600c1c9800b003ef6ed5f645so2398964wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681311765; x=1683903765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOTqvY719R4jZzP4ns7YSiBLEN7m3bKNAvtcXsEuWyw=;
        b=4HCyVeoMX6TyB4e9gjOAl487FRJLOzL0WG38YyQxJKkPjm8Do5GHWnTAiZW8wErGRD
         e81v6hPCfJA/1iwdntITf4M0QqAt+VuIVwcFZSeJHwz2M74G5rN9amYM/vzjdjgkKUpJ
         ngTxDUFFsp5sRwL1RLF6YnRkQk/9Tx5W42MZ4X8ogXfeFtrqgoVUByVoGynvav+tYzER
         1pp5XY5IoNhqTz5FdnbUMKVDr4aqNLAM12Z3wnGpCLHIkSsS1rJ4j2IbncYrNwK2B6PN
         JmrReX2l2YYCRLHAb6+noEswhlL4scd6chsNL+l2+1UFpyvlBlnyY12Dl+buN3Fxkvqa
         glcQ==
X-Gm-Message-State: AAQBX9cGMFTB/iCt/9ju74x9wD70SOgiqSSYjDtwwQ8paKSY2WS3ANKn
        /VgraEkLK0scMLGPHneZmmnJ1VfLWNTzjCak8r/w6bxLtv66Lx7TPqJO9+en7svwfvFKrN+tE/m
        cAIv3bNHdAHibkf+mCC1BJrkdfiQxsJIeeTfmUEYTN5KPtplxCW8Rm8i12tpRpBY00Z/AwGkqte
        Bue/ts7Rs=
X-Received: by 2002:a7b:c406:0:b0:3ed:ca62:418e with SMTP id k6-20020a7bc406000000b003edca62418emr12888236wmi.9.1681311765095;
        Wed, 12 Apr 2023 08:02:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zs3sEW6ZK/haeqlD0EesehbH1qFxifoinpDruNHzuIvT1CjAWb8Wn3A32owwiWpevsufxCtA==
X-Received: by 2002:a7b:c406:0:b0:3ed:ca62:418e with SMTP id k6-20020a7bc406000000b003edca62418emr12888200wmi.9.1681311764728;
        Wed, 12 Apr 2023 08:02:44 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s5-20020a7bc385000000b003edcc2223c6sm2620876wmj.28.2023.04.12.08.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 08:02:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Asselin <pa@panix.com>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] firmware/sysfb: Fix wrong stride when bits-per-pixel is calculated
Date:   Wed, 12 Apr 2023 17:02:25 +0200
Message-Id: <20230412150225.3757223-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit f35cd3fa7729 ("firmware/sysfb: Fix EFI/VESA format selection")
fixed format selection, by calculating the bits-per-pixel instead of just
using the reported color depth.

But unfortunately this broke some modes because the stride is always set
to the reported line length (in bytes), which could not match the actual
stride if the calculated bits-per-pixel doesn't match the reported depth.

Fixes: f35cd3fa7729 ("firmware/sysfb: Fix EFI/VESA format selection")
Reported-by: Pierre Asselin <pa@panix.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/firmware/sysfb_simplefb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index 82c64cb9f531..5dc23e57089f 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -28,7 +28,7 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 			     struct simplefb_platform_data *mode)
 {
 	__u8 type;
-	u32 bits_per_pixel;
+	u32 bits_per_pixel, stride;
 	unsigned int i;
 
 	type = si->orig_video_isVGA;
@@ -54,14 +54,19 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 	 * bits_per_pixel here and ignore lfb_depth. In the loop below,
 	 * ignore simplefb formats with alpha bits, as EFI and VESA
 	 * don't specify alpha channels.
+	 *
+	 * If a calculated bits_per_pixel is used instead of lfb_depth,
+	 * then also ignore lfb_linelength and calculate the stride.
 	 */
 	if (si->lfb_depth > 8) {
 		bits_per_pixel = max(max3(si->red_size + si->red_pos,
 					  si->green_size + si->green_pos,
 					  si->blue_size + si->blue_pos),
 				     si->rsvd_size + si->rsvd_pos);
+		stride = DIV_ROUND_UP(si->lfb_width * bits_per_pixel, 8);
 	} else {
 		bits_per_pixel = si->lfb_depth;
+		stride = si->lfb_linelength;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(formats); ++i) {
@@ -80,7 +85,7 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 			mode->format = f->name;
 			mode->width = si->lfb_width;
 			mode->height = si->lfb_height;
-			mode->stride = si->lfb_linelength;
+			mode->stride = stride;
 			return true;
 		}
 	}

base-commit: e62252bc55b6d4eddc6c2bdbf95a448180d6a08d
-- 
2.40.0

