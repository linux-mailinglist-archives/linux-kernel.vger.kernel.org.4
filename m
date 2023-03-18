Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2517D6BFA4C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCRNku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCRNkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB9716898
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679146799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GsfqRJutAPaYkw+mcXHB2f4v7VoNn3nM+/TXvQ7dbeI=;
        b=UdBG39cFcsrZXA+Ol2DWJD+hXGapzwqPbDtGWH+wdJGtwEMCbtKhWpZWiQqn38/o0YJJt2
        0sSeRx2flpB1+x41/Ys55+Y35vLoFcrqAjy0lwPlLW6p+sL/PCESnTwR1UP4YWgE0Ksvpz
        d8VXkamJQDIfacuGBGad5S9wVkD/IFg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-jXQDHVlEMHmc1LXhWeUk0w-1; Sat, 18 Mar 2023 09:39:56 -0400
X-MC-Unique: jXQDHVlEMHmc1LXhWeUk0w-1
Received: by mail-qk1-f199.google.com with SMTP id l27-20020a05620a211b00b00745b3e62004so3675510qkl.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 06:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679146796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsfqRJutAPaYkw+mcXHB2f4v7VoNn3nM+/TXvQ7dbeI=;
        b=VqiQdXdNL8DpgQTa/u1hQ3NA/UBxvw6ZuN0TKSUpmXwJMCmNTd2Qn9LjlHmafV3l/3
         gO1pyeBFU99xNkEa9fkXb2oYvb5CHLmosoNA8TMwUAwOiRb4P5Iru2r+fvImQtgdAElc
         0fR7Zum+UKj8j4yV4a66Eri7wbmhuNtvd20MHAcH9w6oh08KZNzsjuQsJHiA3uah4Z+X
         snMrNwavjTpWd1GkN1irHQ5WCmpYeHnJ7V95JBnLPyGw00v1B6v0m+V9PXSs5VjLs3ng
         We3UrZijxYnP7F9EDPWoEl6Kb/GKTRsISWBG8izVI2nT0JnUZAxXlH8PvGdby1aMgq7t
         jlNA==
X-Gm-Message-State: AO0yUKWRkWRrYFrnlQOlaQx154X0JKSkb+T4OypJZqoDwy6KrTyJlNJz
        7XVr13gfHfguSMdDAzqCmLiFOqzAQUTSli/BIW74EzILU35vG6bX/A8XR90Ho2siHAdFPXqJBT7
        8Il67qO0SZ+ZucxcmbSfTzZ6I
X-Received: by 2002:ac8:570d:0:b0:3b8:58d0:b4e4 with SMTP id 13-20020ac8570d000000b003b858d0b4e4mr18584480qtw.33.1679146795814;
        Sat, 18 Mar 2023 06:39:55 -0700 (PDT)
X-Google-Smtp-Source: AK7set+8QQWnniMY6gnEIBdfGqTMXXT0qbM1AvQtynJRRUJeJmWSu8y4ycgxOaezT+v9XSCpBKj4WQ==
X-Received: by 2002:ac8:570d:0:b0:3b8:58d0:b4e4 with SMTP id 13-20020ac8570d000000b003b858d0b4e4mr18584464qtw.33.1679146795558;
        Sat, 18 Mar 2023 06:39:55 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o16-20020ac86990000000b003bf9f9f1844sm2999664qtq.71.2023.03.18.06.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 06:39:55 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     anitha.chrisanthus@intel.com, edmund.j.dea@intel.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/kmb: remove unused set_test_mode_src_osc_freq_target_low,hi_bits functions
Date:   Sat, 18 Mar 2023 09:39:52 -0400
Message-Id: <20230318133952.1684907-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
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

clang with W=1 reports
drivers/gpu/drm/kmb/kmb_dsi.c:822:2: error: unused function
  'set_test_mode_src_osc_freq_target_low_bits' [-Werror,-Wunused-function]
        set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi *kmb_dsi,
        ^
drivers/gpu/drm/kmb/kmb_dsi.c:834:2: error: unused function
  'set_test_mode_src_osc_freq_target_hi_bits' [-Werror,-Wunused-function]
        set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi *kmb_dsi,
        ^
These static functions are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/kmb/kmb_dsi.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index cf7cf0b07541..ed99b14375aa 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -818,34 +818,6 @@ static void test_mode_send(struct kmb_dsi *kmb_dsi, u32 dphy_no,
 	}
 }
 
-static inline void
-	set_test_mode_src_osc_freq_target_low_bits(struct kmb_dsi *kmb_dsi,
-						   u32 dphy_no,
-						   u32 freq)
-{
-	/* Typical rise/fall time=166, refer Table 1207 databook,
-	 * sr_osc_freq_target[7:0]
-	 */
-	test_mode_send(kmb_dsi, dphy_no, TEST_CODE_SLEW_RATE_DDL_CYCLES,
-		       (freq & 0x7f));
-}
-
-static inline void
-	set_test_mode_src_osc_freq_target_hi_bits(struct kmb_dsi *kmb_dsi,
-						  u32 dphy_no,
-						  u32 freq)
-{
-	u32 data;
-
-	/* Flag this as high nibble */
-	data = ((freq >> 6) & 0x1f) | (1 << 7);
-
-	/* Typical rise/fall time=166, refer Table 1207 databook,
-	 * sr_osc_freq_target[11:7]
-	 */
-	test_mode_send(kmb_dsi, dphy_no, TEST_CODE_SLEW_RATE_DDL_CYCLES, data);
-}
-
 static void mipi_tx_get_vco_params(struct vco_params *vco)
 {
 	int i;
-- 
2.27.0

