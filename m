Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053B173923F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjFUWGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjFUWGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:06:50 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1C919BF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:06:43 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1a98cf01151so6400558fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687385202; x=1689977202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK9EJjesr9P3CeGnBxj7w+Jge1+/260eNRMnSd/AWFY=;
        b=UGRErG+7Xy+fBMtJKjUiBVrQF1B9cgoqrRJxs4C6fdph+vZpOxg6ZinJbIMhj+hk+5
         1xRuv0y1CCBIX+n6pt66rmQtvVPuT6xN/7NB5bBYvQAbijMvaNgWlehKCcMVxq19ECHs
         /LMZyLbnLdTavQV9zJ7JkgtAbKfiHLiP070EJlrugoIxlEhbTBzunaaphBmBL4cO5jGH
         cUVwlgTTCjdJQMhD2ShTwFy5Ata5SOnbaaAfoYkLuNPgoZS37WpGAGdkmfeQfmv0af9m
         7UgxHNP/PYdq0XzBqJW2FtOoFMBjs/sRzGAWh02z/g/rKehxFOR8LT+hDomK7l6BOj77
         BvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385202; x=1689977202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VK9EJjesr9P3CeGnBxj7w+Jge1+/260eNRMnSd/AWFY=;
        b=Zskf0lxYHu7Vnp3kQaKyMr2iX/zgM2VZleFlAnRkoDkpDuhZWo9BoQ2OEFmrsWZyqC
         wNWK3N1yXwf2lX6qgFcSuoIQ6V5BcONC/P8oPG63WFJPv2RNVRRPOjifVSwr9ctmm/7P
         /NGLxhUtG4FmhTuQLQ+0vjCiV0/ENE8jAK8Zu9y5y09/2CsaYmSMEUGL8LQYPlnONmKT
         5BbxBqXsR0wAjhIHjXCkzxGFEKBJoWHYvApUKkxIL4S81Os4G+SXkgDFBtR3KPNbt9ip
         8Gbtwj1L1TzU3Q0b2HAMJ9UIZYCxe74MW24FkrxeMHcwoapkHbagJGwn3Z6YszViW20A
         rQNw==
X-Gm-Message-State: AC+VfDwimPf7RgWvO233QoUcoq9IMqmjALgF0QjkSWeIjSLlE0smPZne
        rlh7uq+Vr+MTzL+NfTNgiJ4=
X-Google-Smtp-Source: ACHHUZ5EU0tVGQtCBM8PEcdQptblwpRNDVTB+HV2siF07Hzgj2O1eHmahk0OLXsBaOSPVV/lNLe+zg==
X-Received: by 2002:a05:6870:c806:b0:1a9:caa1:9571 with SMTP id ee6-20020a056870c80600b001a9caa19571mr12981633oab.34.1687385202229;
        Wed, 21 Jun 2023 15:06:42 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id v7-20020a9d7d07000000b006af8b60e2c3sm2288987otn.74.2023.06.21.15.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 15:06:41 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
Subject: [PATCH 3/3] drm: panel-orientation-quirks: Add quirk for AYA NEO GEEK
Date:   Wed, 21 Jun 2023 19:06:15 -0300
Message-ID: <20230621220615.1253571-4-samsagax@gmail.com>
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

Add quirk orientation for AYA NEO GEEK. One of the more recent devices by
the brand. The name appears without spaces in dmi strings. The board
name is completely different to the previous models making it difficult
to reuse their quirks despite being the same resolution and mounting.

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 962e74afa8e5..757bbeb7071c 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -194,6 +194,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AYA NEO Founder"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO GEEK */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "GEEK"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* AYA NEO NEXT */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.41.0

