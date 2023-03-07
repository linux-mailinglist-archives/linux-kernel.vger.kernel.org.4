Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8836AE00F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjCGNLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCGNLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:11:24 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DD37695;
        Tue,  7 Mar 2023 05:10:00 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u5so13943538plq.7;
        Tue, 07 Mar 2023 05:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678194542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDSasO/7mKvPMuHhaJ5dSUZlltLYrJQeoPhaTJiDZfs=;
        b=bmSSIW9KtOuI5eNLrnjoEZACB3ezrROssS5D2oU29FxEC+Rq/PHZCCckVcDHs3bLPK
         m8ZKz6PCvzZlRkhAIpwYYkr2wdRk0Ni6V3SMiz434xU0AzLdLP6FlI5F3Kz91p7Xqay1
         sFtr39ki8xM3n7OsY0BEmvQcdmIThIo0InXm6Vj5sSBisBybeBB1cdYhy6TL+jT1jgIO
         4BYIAIDC/QXhMxtIIrEECSZZK87cS4q8YNJFOqbqtgn54SbIYBkJD2c8bzStIKMiAIpF
         NMlFx9AH8ZWf/7ARyOcvmzmbcEyGI7RZ4KQ8VKGxZOmyLxtNwZs3pwr8fPUT7jmhXz2s
         x6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDSasO/7mKvPMuHhaJ5dSUZlltLYrJQeoPhaTJiDZfs=;
        b=jp4uuS8+kGnKPo1dyLzq/5/737KOIIBlMBBmixH4pVjcme3uvMa5wlvxqlWeGHsduo
         LZbiHF2Ktn9LrTYCIJ2rU8jKaAdpQvhIXYiS799v53QzHbPrH6P0AGfiLJ1hhQFTRJyi
         Q/sHRtOlXT9uiV9ipCIE65aBKXXQwyp1S3C4mnFajrwWCpSOcJJU9YeB0mMFoa3DmVSV
         eRpvUqi1L6k3xsaURbtez4hhuFryThFZoGQc+rbGIk0QI84wU1NHPKP1Y5O84CxG7b7I
         2w8EonCJKTA+TAyXaZhFVjaLGQKBR66hFH/C68MpghzsgrIQhjOcBD3ezmEBsr9Dgnn2
         fUxw==
X-Gm-Message-State: AO0yUKUE30HC4XKaCge7Y1zmUQWJfTo1VwYnwCt+YvuHKuDDFZxNAeir
        epCjWvmt7Ma8+v+I5fk0JcM=
X-Google-Smtp-Source: AK7set/JbNt04raG3T5qoVOvWKW76KyCmnFyRTKZHkRGaWCu6DgctSZ48iDM0sCCnRF/zxEwnu0qcQ==
X-Received: by 2002:a17:903:22c1:b0:19e:ba2c:27ec with SMTP id y1-20020a17090322c100b0019eba2c27ecmr10944767plg.11.1678194542116;
        Tue, 07 Mar 2023 05:09:02 -0800 (PST)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902ed4200b0019b0afc24e8sm8396190plb.250.2023.03.07.05.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:09:01 -0800 (PST)
From:   harperchen <harperchen1110@gmail.com>
To:     deller@gmx.de
Cc:     javierm@redhat.com, tzimmermann@suse.de,
        wsa+renesas@sang-engineering.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        harperchen <harperchen1110@gmail.com>
Subject: [PATCH] fbdev: tgafb: Fix potential divide by zero
Date:   Tue,  7 Mar 2023 13:08:56 +0000
Message-Id: <20230307130856.2295182-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fb_set_var would by called when user invokes ioctl with cmd
FBIOPUT_VSCREENINFO. User-provided data would finally reach
tgafb_check_var. In case var->pixclock is assigned to zero,
divide by zero would occur when checking whether reciprocal
of var->pixclock is too high.

Similar crashes have happened in other fbdev drivers. There
is no check and modification on var->pixclock along the call
chain to tgafb_check_var. We believe it could also be triggered
in driver tgafb from user site.

Signed-off-by: harperchen <harperchen1110@gmail.com>
---
 drivers/video/fbdev/tgafb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
index 14d37c49633c..b44004880f0d 100644
--- a/drivers/video/fbdev/tgafb.c
+++ b/drivers/video/fbdev/tgafb.c
@@ -173,6 +173,9 @@ tgafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct tga_par *par = (struct tga_par *)info->par;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	if (par->tga_type == TGA_TYPE_8PLANE) {
 		if (var->bits_per_pixel != 8)
 			return -EINVAL;
-- 
2.25.1

