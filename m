Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE62A6548A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiLVWkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiLVWkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:40:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077A627CF4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671748728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzBhvrDERZaJhFnP4rFM5wIDtYIz/HXr7dxGL5cNvkA=;
        b=aflY2c+cM+Lhy6tBIOBdZPstF/2v/oRTEsSh1y8dOpcmuHXPrmzT0rskrfP9bjiY5QP8VZ
        z63clGiPECRSNIBc07vgOLQkQpj+z6tD8QKWrOtge+bTN0e64Y4yBsUgw68u2ob8PIF6KI
        rbo77wHjfAtzRXI6CsOL36n3XH7hgQ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-XN-pBM8wM9q0VX8ncymvSQ-1; Thu, 22 Dec 2022 17:38:47 -0500
X-MC-Unique: XN-pBM8wM9q0VX8ncymvSQ-1
Received: by mail-wm1-f71.google.com with SMTP id c7-20020a1c3507000000b003d355c13ba8so1365391wma.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:38:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzBhvrDERZaJhFnP4rFM5wIDtYIz/HXr7dxGL5cNvkA=;
        b=OFKEVS/3kFOCfKokB4cwPWYFM0+KtdTzzlLMC3/UB5P3AGQY8kCe25jnJIe/neuxOt
         9pNTVvvTD+H0kR4eyT/xIOAqXW9izMn4J/eOkQ1N1CT/0j0UnfIfC4POnBrt6wKrTSIx
         DcAOlkYbF+yQCsmt9mmUCv88+q6U6qEQkobvxAhFL566Ivi+UDIPSKXZ/SXTwH8dYfJ6
         I2+NleXzdHxLIg9NVl/Z7ldUphNrVtkXkt0cx3ZWEwEAff/fixVfPsiBo6IxZZhJFyCx
         mdusImjxR7ACLZPbLGvkCwCMWr7AvGjX0Ki00CkVP3IcQ2FghTPkfuJwb4MejnETLEHd
         2hdg==
X-Gm-Message-State: AFqh2kpps3+lacDuXT0r9cXkWT/jQNQ6MwgDq6JfpAAjQZvEIudJYiwl
        iCnB/IPVcV+8vfuDoQq7xT7O7BjxXsF5bkIrYPUBNHfJGwLrakSd7clBL7s7zP3EZLIPfgtb7XS
        +voOEwcx2+aKUMj+Y8krwI69AJAgHkJW6tDfkWFeRGlznUV1QtVms4NtjNWyeFRMixZmj9dx9qt
        0=
X-Received: by 2002:a05:600c:41c2:b0:3d3:5565:3617 with SMTP id t2-20020a05600c41c200b003d355653617mr8240969wmh.24.1671748725787;
        Thu, 22 Dec 2022 14:38:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtQhlXI1+u2DPETggaCNyUf1kBA3zG1PcHtfJtXtdBCIW2W2IvTgnNznp5B9ddVDMYicwv/kQ==
X-Received: by 2002:a05:600c:41c2:b0:3d3:5565:3617 with SMTP id t2-20020a05600c41c200b003d355653617mr8240953wmh.24.1671748725549;
        Thu, 22 Dec 2022 14:38:45 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n25-20020a7bc5d9000000b003d969a595fbsm2386239wmk.10.2022.12.22.14.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 14:38:45 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>, Robert Mader <robert.mader@posteo.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 3/4] MAINTAINERS: Add entry for Himax HX8394 panel controller driver
Date:   Thu, 22 Dec 2022 23:38:29 +0100
Message-Id: <20221222223830.2494900-4-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221222223830.2494900-1-javierm@redhat.com>
References: <20221222223830.2494900-1-javierm@redhat.com>
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

Add myself as maintainer for the driver and devicetree bindings schema.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e832cf29bec..175d72203fb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6480,6 +6480,13 @@ S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/tiny/gm12u320.c
 
+DRM DRIVER FOR HIMAX HX8394 MIPI-DSI LCD panels
+M:	Javier Martinez Canillas <javierm@redhat.com>
+S:	Maintained
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
+F:	drivers/gpu/drm/panel/panel-himax-hx8394.c
+
 DRM DRIVER FOR HX8357D PANELS
 M:	Emma Anholt <emma@anholt.net>
 S:	Maintained
-- 
2.38.1

