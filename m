Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B359D74660A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 01:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGCXGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 19:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjGCXGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 19:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEB6E6E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688425544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PPkOUuxZ5llhFetMPklJdNaHUXTC+DjeRtC4vPngfEk=;
        b=fibYtvyQhuBNPrqUUcKVV7MLilskapsiIzz4A1B6yZLJ4oYCruyWdf4gOmkdjuGXRkiZoZ
        tfMwaRO5lO16QnxV+8axLHJaEsTBda/rgRjjzBAsv2J4usAtayEySl7yNqp5TO4FYSWKa0
        fljidcHLJwAX0nC7P80IbDo47atnJV0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-DDpYmeOyOfa3TfcvDCv7Pg-1; Mon, 03 Jul 2023 19:05:44 -0400
X-MC-Unique: DDpYmeOyOfa3TfcvDCv7Pg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa9a282fffso28518385e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 16:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688425542; x=1691017542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPkOUuxZ5llhFetMPklJdNaHUXTC+DjeRtC4vPngfEk=;
        b=cw/nF9xkFxRt1tnkeA7v+DE/MuTlb3x3rCcidG90kmGZHORHOu1c4oaVXZg5gMdKYb
         Y1jb9vh8zSQs08dEvV7GGOyvcmdhoTF5QyX6kvJEAx9BA1jLtLZ0/ak3z7CV4Ac//7Qy
         cu1vXXRzPj8whc7wTBvEeEgekd2wNQVsb2MklFX9XICatDJmLN4gWnGrH84iOXLDcuHy
         /P4lw5EUppGvKom6hcRAc4lcP5+omBrTeSmxu2DDFMMLmR9KqMKLA1h/RTHCMJWZBrKM
         pKUPXsFr5S57BnYmx1DrhSGM29MWMlW2iswvB1wCz+pV5pIU9rcykSQv5cN+Pv1sPVoT
         CPfQ==
X-Gm-Message-State: ABy/qLYVPUyKNhc1ASiPAvgw1/Ybch74fPM/6V/oyN4mDyY7yFAnWS9w
        XffvGzET5eNL+k2PTditmkmaPndJc04zVez9jLRzOi7xamre7cZAzUHy+CrQEq9z8Brvklc8bgr
        xEFsT/ivVgOKvHGsZvX+fmkHfUXMJPow8p/v9T1Sw6iiPnvLkMRSr5Ut65SY6up46/imjdQut3b
        Sc3etTLjs=
X-Received: by 2002:a5d:4f83:0:b0:314:182a:3d96 with SMTP id d3-20020a5d4f83000000b00314182a3d96mr9283430wru.28.1688425542719;
        Mon, 03 Jul 2023 16:05:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHkY3/kaMZbldsi47jF351XP7Kg1e0/Oy/YC+TGYzIxm3l+o77EQsFnIcbHI+uDkatYVGxuOg==
X-Received: by 2002:a5d:4f83:0:b0:314:182a:3d96 with SMTP id d3-20020a5d4f83000000b00314182a3d96mr9283411wru.28.1688425542423;
        Mon, 03 Jul 2023 16:05:42 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056000090d00b003112f836d4esm26504465wrb.85.2023.07.03.16.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 16:05:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v4 1/5] video: Add auxiliary display drivers to Graphics support menu
Date:   Tue,  4 Jul 2023 01:05:25 +0200
Message-ID: <20230703230534.997525-2-javierm@redhat.com>
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

The drivers in this subsystem are for character-based LCD displays, which
can fall into the same category of the DRM/KMS and fbdev drivers that are
located under the "Graphics support" menu. Add auxdisplay there as well.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/Kconfig       | 2 --
 drivers/video/Kconfig | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 514ae6b24cb2..496ca02ee18f 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -129,8 +129,6 @@ source "drivers/dma-buf/Kconfig"
 
 source "drivers/dca/Kconfig"
 
-source "drivers/auxdisplay/Kconfig"
-
 source "drivers/uio/Kconfig"
 
 source "drivers/vfio/Kconfig"
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 8b2b9ac37c3d..acf02863ac7d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -30,6 +30,8 @@ if HAS_IOMEM
 config HAVE_FB_ATMEL
 	bool
 
+source "drivers/auxdisplay/Kconfig"
+
 source "drivers/char/agp/Kconfig"
 
 source "drivers/gpu/vga/Kconfig"
-- 
2.41.0

