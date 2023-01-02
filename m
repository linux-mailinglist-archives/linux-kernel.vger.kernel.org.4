Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12D765B713
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjABU0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjABU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:26:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B086273
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 12:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672691150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xCNMgkWa09fEzea1HqZoR7Nx7p6LXc3d3hq975HBBf8=;
        b=bBiXFl1zUIO87sg1MMnLG3TywhGCaDr50zG/wuS6pFQBzyJ+RRY83J43MDbz5BYdUMLyYc
        4pn7WJKH8qWmvIWJ5JSMhOlZv+JHLKSTM+BsWhTlmPey54VnSiNofQcPwYM+n7OfM/CjiE
        YQtudQHQ151+iita39/C5Sd1qpvXRhA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-brcgzra-NgKh_ywH9r6iZw-1; Mon, 02 Jan 2023 15:25:49 -0500
X-MC-Unique: brcgzra-NgKh_ywH9r6iZw-1
Received: by mail-wm1-f71.google.com with SMTP id fm17-20020a05600c0c1100b003d96f0a7f2eso15976118wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 12:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCNMgkWa09fEzea1HqZoR7Nx7p6LXc3d3hq975HBBf8=;
        b=zT0mUskdQBsH+m0YXUAP51AqlL/YZmII6KoWyZh8GAy940cfKrGHXbyahGT9+xSis3
         u7b8lk8TlOZmg9eaaAgSwrEruM7gqIK3ZrA+I4siyW6v5NnVv9n1tUY2e62eWZEYU7KZ
         oMvC6OLFrfhi0ip1xOyI/oWGrNACKiX5jcxEwnXjQey87cnurl928C5q7r0F5Bo3Ye8p
         IzdmSVEM4LbfRNpwI+HXTxq1nOO5fq4xL3uu6SWm1rYcagm4oYEhkkfC8Kya477w0jVf
         2WLkLRHEhhT1DHznCeC94LrKGDRH4ieIqQieq4vLIX/npQ1Mlb0h0XR8mSqQt5KbfCZb
         O2Ow==
X-Gm-Message-State: AFqh2ko+pQIe7Sh5Uc3JO8m0hf0u6uVm9c/wynZkVS3iry6pLj+gf65c
        TnFmMBc8nJdjF5nqkkTHK5L1BYoCjAz/kH9hjt59dGKTAYytBHL0LDaDq/kr4jD3EklutG8kWko
        TkJNJ8MYOA6mOUegIJpX4IVLAyFjhTZKE/o4Wr6Quti7KdT6cKjxGn6bnG22XSr9Sst4lQOdbNT
        4=
X-Received: by 2002:a05:600c:1c85:b0:3d3:4b18:27c6 with SMTP id k5-20020a05600c1c8500b003d34b1827c6mr29159461wms.11.1672691148028;
        Mon, 02 Jan 2023 12:25:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXucLyQjV1JdUh/Oxhsrc63ax4d9VZwsRvpyJNghr8LaaYhJT1s03Mg1ltldjdSwypzvI/Jtqw==
X-Received: by 2002:a05:600c:1c85:b0:3d3:4b18:27c6 with SMTP id k5-20020a05600c1c8500b003d34b1827c6mr29159442wms.11.1672691147819;
        Mon, 02 Jan 2023 12:25:47 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b003d35c845cbbsm50061135wmq.21.2023.01.02.12.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 12:25:47 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 1/2] drm/mipi-dsi: Fix mipi_dsi_dcs_write_seq() macro definition format
Date:   Mon,  2 Jan 2023 21:25:41 +0100
Message-Id: <20230102202542.3494677-1-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
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

Change made using a `clang-format -i include/drm/drm_mipi_dsi.h` command.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v2:
- New patch in v2.

 include/drm/drm_mipi_dsi.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 20b21b577dea..e9d1e8a7fc7e 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -303,15 +303,18 @@ int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
  * @cmd: Command
  * @seq: buffer containing data to be transmitted
  */
-#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...) do {				\
-		static const u8 d[] = { cmd, seq };				\
-		struct device *dev = &dsi->dev;	\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0) {						\
-			dev_err_ratelimited(dev, "sending command %#02x failed: %d\n", cmd, ret); \
-			return ret;						\
-		}						\
+#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                           \
+	do {                                                               \
+		static const u8 d[] = { cmd, seq };                        \
+		struct device *dev = &dsi->dev;                            \
+		int ret;                                                   \
+		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));    \
+		if (ret < 0) {                                             \
+			dev_err_ratelimited(                               \
+				dev, "sending command %#02x failed: %d\n", \
+				cmd, ret);                                 \
+			return ret;                                        \
+		}                                                          \
 	} while (0)
 
 /**
-- 
2.38.1

