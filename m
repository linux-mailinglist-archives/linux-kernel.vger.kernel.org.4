Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0391F73923C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjFUWGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFUWGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:06:39 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF44CE57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:06:38 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1aa0d354a8aso3988775fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687385198; x=1689977198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQMestEn/hdlzpB5zrBs/mLTvQ8FPA3kTSATXYwATVw=;
        b=ON+QySyTk+k1EmIF4cKflvdxh0hEKrIBQj/d93hLrwCL5QG8j2LlbkC8Sjp6PJjgP/
         sXwIYop426LtO2UjNY18rsxmKIi5o3KPE0hokl0nxLr56jnAcM/p8IwNy/+gkhHzipLc
         yxoDS85YOJQDH2LqTpZbPiaV1o+frqoHGm9l7BPgd5PMjaLKPTZ5p4z+r3cC+ppVFW38
         amfVcMuogKrivP5Kl4ZhQsPAxJAJaJSEb5GJuIzi0CdAcbg3JRGitbdML8N8Uwm/VcOJ
         Erv1WuPB6hk+k8W/Fsv/155/+o0dr7enufiHQwcprDBSfHAjxfP5P7+LvEbc/da3XiLF
         lHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385198; x=1689977198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQMestEn/hdlzpB5zrBs/mLTvQ8FPA3kTSATXYwATVw=;
        b=OAouVoSuF9LWW7sFYpJFZ1tYtNgtfmeuWJ/w3fSlxlG+mPSgKrrBNXvbe3lXk95ssO
         CDP4nlPhrXpXuwaBcvxFj6jUxC/5h4n1k2hDnjsq6V2oD+UOsTmfapArt+/GxfA4ANe6
         673k9IEfZo4HJdwgIAvNkMzzEYvr7pLa5+gfDzXDbDVhNcC6KZNAFfmGWagyBTtkoe+Q
         9UbqXANxpTvNm+ZQaIxyds9LiirP04mh+VjuaUgXDHf/n7l0BZlrZi7kE2C91SONjQ8q
         Ryt0NWB8QGroybyn+uBbGU98WfpQ9K7MnSIkHs4YgcQ6Smkf0OZktKt3gz3HLwBlPfMp
         v9JA==
X-Gm-Message-State: AC+VfDy4MiY7PkcHWqTRsnB/njelLN/oHo/Goh8ZnMaRCKjajIrBm3yf
        C+7y5eIdbCpkzD+uSeoSBiU=
X-Google-Smtp-Source: ACHHUZ5mcVIug7DfzVDfAYuIUvMjJZGQYEYybZq0mCyfRAZVLgdmN9aS2VO7k+HsYU9TbgZj2uvUBA==
X-Received: by 2002:a05:6870:4350:b0:1a3:1962:9123 with SMTP id x16-20020a056870435000b001a319629123mr11058534oah.31.1687385197942;
        Wed, 21 Jun 2023 15:06:37 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id v7-20020a9d7d07000000b006af8b60e2c3sm2288987otn.74.2023.06.21.15.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 15:06:37 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
Subject: [PATCH 2/3] drm: panel-orientation-quirks: Add quirk for AYA NEO Founder edition
Date:   Wed, 21 Jun 2023 19:06:14 -0300
Message-ID: <20230621220615.1253571-3-samsagax@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621220615.1253571-1-samsagax@gmail.com>
References: <20230621220615.1253571-1-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirk orientation for AYA NEO Founder. The name appears with spaces in
dmi strings as other devices of the brand. The panel is the same as the
NEXT and 2021 models. Those could not be reused as the former has VENDOR
name as "AYANEO" without spaces and the latter has "AYADEVICE".

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 4b428792a3b6..962e74afa8e5 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -188,6 +188,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {	/* AYA NEO Founder */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYA NEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AYA NEO Founder"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* AYA NEO NEXT */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.41.0

