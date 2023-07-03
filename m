Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9924F746617
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGCXKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGCXKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAD4BB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688425754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKwSmrhTaDUuj6nOeH5v86nAPSbYWAm2divbLmIUh94=;
        b=gPVa/zqRPtGomRZdzkzuRbPY0eBZzaj5eOFidF7dqiYFBHf/eStkA5U4DQY1Eq5ac4M7te
        JbvNEV+Vs6g71Ju/NuMBn6nLQU0M7N2dPa+U3wcvxdOssccFtV5ntwwajLk+w832aQtdZD
        aOnqWhIiNMpfDBRKCai1+uwRIDt2bRA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-S3u021cQNiaIRk1EPIyitQ-1; Mon, 03 Jul 2023 19:05:48 -0400
X-MC-Unique: S3u021cQNiaIRk1EPIyitQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3141a98a29aso2124851f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 16:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688425546; x=1691017546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKwSmrhTaDUuj6nOeH5v86nAPSbYWAm2divbLmIUh94=;
        b=K6O6mGsC1VaYTrE/YNmUUbYpGj8JWlc9SPBlbclb2qpfScXPD+27/uwTTsnnyAEhgk
         elpUxkiQm3qp4tgtjPghaU5xirUQ0Xrcwktre1xTdMo2TWOthXD3Bik/yNRz/wpPg6hB
         bJvsywpvGncU5Iw0czk4oSLK0MUceRIQz40hLED7UQtzZ9EK+e5TMsBj8NAfStTyKbAC
         2k4xUMXIL3WbzAiVWUdsB1JELrJendN+SJIeysLWz1ovMCPoO4fps+YadR8/g8ZRU48q
         7xI86BTDAF+PYWuDf0+/AliFmQDxsHOX57zHzwvi+dMt+wxTUjbFhz4jHS1k8BISA4TE
         VVTg==
X-Gm-Message-State: ABy/qLb5Wmyv7FlYTI0xAE5+zb3DnlkdgZUiSNE00Y+ePIul0MZoFoTi
        r51g0OpmpQtbDG1CEpMnzx72JEE6KfaOyu/CNplfFk9Yy27T/VwZi/vcp9G5N+rx+hUMCY8rdHp
        vqAFrfQySbt7dtJLfs3DsaYR71feOjnFDJ6QxbgAJg8pWqM/zWWOb1RVZ0YjJ5o3y1+u1LS4ooK
        RlDPc5AyQ=
X-Received: by 2002:adf:f8c8:0:b0:314:23e:c8fc with SMTP id f8-20020adff8c8000000b00314023ec8fcmr9734654wrq.33.1688425545237;
        Mon, 03 Jul 2023 16:05:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGm9A12oMGIbB0eiER252jgpMh8fddozs5Y4ECUnCr8I5AQbLu2lRDz7vnx11yA2VHlZ5L4zQ==
X-Received: by 2002:adf:f8c8:0:b0:314:23e:c8fc with SMTP id f8-20020adff8c8000000b00314023ec8fcmr9734638wrq.33.1688425545007;
        Mon, 03 Jul 2023 16:05:45 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056000090d00b003112f836d4esm26504465wrb.85.2023.07.03.16.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 16:05:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 3/5] drm/arm: Make ARM devices menu depend on DRM
Date:   Tue,  4 Jul 2023 01:05:27 +0200
Message-ID: <20230703230534.997525-4-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703230534.997525-1-javierm@redhat.com>
References: <20230703230534.997525-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise if CONFIG_DRM is disabled, menuconfig will show an empty menu.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
index c1b89274d2a4..ddf20708370f 100644
--- a/drivers/gpu/drm/arm/Kconfig
+++ b/drivers/gpu/drm/arm/Kconfig
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 menu "ARM devices"
+	depends on DRM
 
 config DRM_HDLCD
 	tristate "ARM HDLCD"
-- 
2.41.0

