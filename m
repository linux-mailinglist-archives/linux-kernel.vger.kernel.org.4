Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CCB73923A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjFUWGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFUWGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:06:36 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709B719A2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:06:35 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b5ef64bca6so110244a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687385195; x=1689977195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jApRl3G0nkzGeB1EhFPefA764c2ImCkJh8aeW4stjc=;
        b=qWwGDjfx/htff5ZCQv4bhJl6qVZ402as0zi+GPq9gnH0tcm3OvYV90ONqlxZrY0wqy
         KMIgpP7b8ssia5OOWn1HNNUP8x1ksfG43NnEVF5nbYpQzaAaPjkqeElaWgPKiC+hWJzs
         Ppm8iyCBiF6vwq+DcTHZB+iCA8G2nDsZzdcirC64lqp48EN8juYbC3upMlAQiEYB3hg2
         hT8URX4OmWSGkJ38pfCJMsRX3lp1ZwBRhuBVLNJHauuoH0KlxWVN7xmuYG1nSR19rbEl
         VEO4Z1/5onet7qUHGx3/725+F7/KbXQqYEit2k6IR7dPd8tNwORTVkTgnYvLCsJ03CGn
         cTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385195; x=1689977195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jApRl3G0nkzGeB1EhFPefA764c2ImCkJh8aeW4stjc=;
        b=Ifw20jdTnlR6My9z+oAINNUuff7KpTg91mP3/20+RxQvjf9slgxG9mML2p6wM8k0fg
         wzQKlvxNg4HZl0Xa7j2hqLiquKKLeIrpW01nc7qzjVjR6WYM9VQXMpC5OeuEPuDjPQ0v
         iXkfbGAX7EPyy7LHbqx1RPDWBJpJXzSgBucA2piC4eyYVByFIU5vax15Ln913FEaaHmx
         5uhBWVruzUhiJvDVwRiScWWDISAae0YP6LbjE2qTaL2UW9TsU84CfYMeFe5ILBb93mKx
         K3B8ZjvXjK3T7PvafmwzXOvfRkKwEJ944jT3qR6D9mUPN2hJ7y5N6i2IhsPXaiJ2mKDM
         CTlg==
X-Gm-Message-State: AC+VfDy89i8CqPL8rzaqO+yvZ5oRAy502F2zdZvCQVpLNwFVUi5xjhT7
        tW3mHQfwYG+OYmZICrnPd2U3LPj08bw=
X-Google-Smtp-Source: ACHHUZ4m/2C8LBVVKAkNrxewirUwQ9FLO5rveJ/sCX6cxuIGS+SuiwZe95rXFzQfq65EFjOR1oslNQ==
X-Received: by 2002:a05:6830:18f8:b0:6af:78cc:e489 with SMTP id d24-20020a05683018f800b006af78cce489mr17541148otf.26.1687385194647;
        Wed, 21 Jun 2023 15:06:34 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id v7-20020a9d7d07000000b006af8b60e2c3sm2288987otn.74.2023.06.21.15.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 15:06:33 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
Subject: [PATCH 1/3] drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model
Date:   Wed, 21 Jun 2023 19:06:13 -0300
Message-ID: <20230621220615.1253571-2-samsagax@gmail.com>
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

Add quirk orientation for AYA NEO 2. The name appears without spaces in
dmi strings. That made it difficult to reuse the 2021 match and the
display is greater in resolution.

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 0cb646cb04ee..4b428792a3b6 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -170,6 +170,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO AYANEO 2 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* AYA NEO 2021 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYADEVICE"),
-- 
2.41.0

