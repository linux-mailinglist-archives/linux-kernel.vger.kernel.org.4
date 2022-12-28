Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236956571C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiL1BtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiL1Bs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:48:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D82B25FB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sg6FOfZxQPsgBuL2lCxZX6+6aSPYMIBPuFtBP5Cei48=;
        b=Ldaz6UQRRA6gafF0iERuSFZpwveHTLH11VI3lUoFBIBGl/chBnpiITbqCGqWlcRW6hoH4S
        HRvNBzKjf1aTr25UIcBq4d3D03xZ5b2Uh8bSTEqbMtBizixIR+ykmi4DbIqDsCXQNUsshF
        CUpOOP34snKkrwKniRXwnc06Ui9Hp+U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-fYW1-vMyN_O7Ws76Pc0ihw-1; Tue, 27 Dec 2022 20:48:07 -0500
X-MC-Unique: fYW1-vMyN_O7Ws76Pc0ihw-1
Received: by mail-wr1-f71.google.com with SMTP id c21-20020adfa315000000b002425bf67a87so1897588wrb.19
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sg6FOfZxQPsgBuL2lCxZX6+6aSPYMIBPuFtBP5Cei48=;
        b=1cb6X6lb6RFUpFNQhOzAUReVt3J0fr39QOZFs0n2J0HTeq8xcBHh1/iCYd5006vhkt
         AzGUFpbV34leANoNDpjaobzR7KVb343omD1oKY5OVAIus/HmGsl86UQD0A2PwRxkYRnz
         Nw/wknDfqcbmYtaSp66aeLJUuZIgbdTS0K01aG+B/7WXoA2jDOVkGhViHYaRRkl1/fZV
         Y89R1nqQv567H8JBTN20/iBpkJpPsGHOqRCtXu+0Qk65EgW++bSkGnyTQiyn01v8SGUb
         uxR064sz91llFIOaMG5fqhlPYQjHhzhxIfwRmcEkKJ0MJfb9TlrsiFzLG1Z/ja99wQzT
         zAKw==
X-Gm-Message-State: AFqh2kpr8McJGk2GAzKs7tJax89ioFTF/ztcdO1AoDJpska4PZ8i5m+1
        9kztJMzQEq9qV5pOkiDaL5ZNX8qfYo+0MW52eJToydRYK7bDkb0r4rhqIJbArrlvCRZ/55gxPd1
        IDCcXPlE++8bHlpZpy03YBXlYw0OncS39ZysCdI1Slo7V5wGfavwaaYl6sT4UNHVq1gYcUEXGbC
        I=
X-Received: by 2002:a5d:4e83:0:b0:242:5a9e:4568 with SMTP id e3-20020a5d4e83000000b002425a9e4568mr12991624wru.45.1672192086107;
        Tue, 27 Dec 2022 17:48:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuXz9A+09CakdtdwfU4SPOdpy8fb8wQkkl6VF14wcUIysAKCYyZAYMYn7pcI8WMR07nGId45w==
X-Received: by 2002:a5d:4e83:0:b0:242:5a9e:4568 with SMTP id e3-20020a5d4e83000000b002425a9e4568mr12991610wru.45.1672192085901;
        Tue, 27 Dec 2022 17:48:05 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:05 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/14] drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro
Date:   Wed, 28 Dec 2022 02:47:44 +0100
Message-Id: <20221228014757.3170486-2-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228014757.3170486-1-javierm@redhat.com>
References: <20221228014757.3170486-1-javierm@redhat.com>
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

Many panel drivers define dsi_dcs_write_seq() and dsi_generic_write_seq()
macros to send DCS commands and generic write packets respectively, with
the payload specified as a list of parameters instead of using arrays.

There's already a macro for the former, introduced by commit 2a9e9daf75231
("drm/mipi-dsi: Introduce mipi_dsi_dcs_write_seq macro") so drivers can be
changed to use that. But there isn't one yet for the latter, let's add it.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 include/drm/drm_mipi_dsi.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 20b21b577dea..c7c458131ba1 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -297,6 +297,22 @@ int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
 int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
 					u16 *brightness);
 
+/**
+ * mipi_dsi_generic_write - transmit data using a generic write packet
+ * @dsi: DSI peripheral device
+ * @seq: buffer containing the payload
+ */
+#define mipi_dsi_generic_write_seq(dsi, seq...) do {				\
+		static const u8 d[] = { seq };					\
+		struct device *dev = &dsi->dev;	\
+		int ret;						\
+		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
+		if (ret < 0) {						\
+			dev_err_ratelimited(dev, "transmit data failed: %d\n", ret); \
+			return ret;						\
+		}						\
+	} while (0)
+
 /**
  * mipi_dsi_dcs_write_seq - transmit a DCS command with payload
  * @dsi: DSI peripheral device
-- 
2.38.1

