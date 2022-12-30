Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A026597BC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 12:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiL3LeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 06:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbiL3Ldw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:33:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1151AD9D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 03:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672399944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DeKDJrYbaI3FJ2VBUiO/cu0OzoKbMQjQcsgl6QH5j8A=;
        b=FPdX9UbYnFGizEMtUZCD5w92z/YN4Otg4Re5fWgY5Dvye9252wD//BJXuzaO6TvZbUksWD
        kwT8qGn0Ng1ZO+YOSOcdcwZ+vxYLRuhrRATYu+e8eCpYVTQAIc+ekIjPS/NuflX5wnFxYy
        2i+LGNrm11GM3h2RbcC/bVhPRJf01MQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-378-t_1TQDRsPEiLK3_p8r4P5g-1; Fri, 30 Dec 2022 06:32:23 -0500
X-MC-Unique: t_1TQDRsPEiLK3_p8r4P5g-1
Received: by mail-wm1-f69.google.com with SMTP id j1-20020a05600c1c0100b003d99070f529so4872771wms.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 03:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeKDJrYbaI3FJ2VBUiO/cu0OzoKbMQjQcsgl6QH5j8A=;
        b=xmr9VkmqA6+WibhXafm2TleSRQ0xY/+yLe5C8Hll+TVZKAI29MiXoSPGBj3lGa5wEl
         Y0MtakgQDtI9X4EMUHG5DYnlu5vYU3gyC6f/6GaxzEAtjK/N7LKbE3/tf0fSnv3AIncW
         BuYwj1fTJw63KrJPuU/CsZj87mpUvPRvIyUm0NPIMANMLpJW2548BrFHjYlJMPtdiO/H
         f1fMi25mI8ST8EfGYqZk6auBm5bGJG78HIBmB1TEVi5rEKDAH/9pryr7NgV1fUINHLfS
         thNyV7Yf5NM6/u5/1+fYtVunbvGZyAhcfEu/DJNMSwVNwS9jFwkAS1hGWfuV8PknceHr
         8qOA==
X-Gm-Message-State: AFqh2krGzyaod0iDMFxyochZtuShbsAN+qjoiGv5dPXx0d7d5rnRzYBe
        FL5T1vUB8fK4Cal/Pj023viUvHb/yf+raU/1oFYp4MPWZVzCAPAHht5j2Ojs54lZwaxGwUGcrzT
        RgV3T/BCveyIT41Cl5LoDNPUPH2OJwdAWvd57P1Mgc2EqfvoUw6BeJOUQntrSjTCZsm1AsmF9LN
        Y=
X-Received: by 2002:a1c:6a16:0:b0:3c6:f732:bf6f with SMTP id f22-20020a1c6a16000000b003c6f732bf6fmr22090644wmc.13.1672399942186;
        Fri, 30 Dec 2022 03:32:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu4pyxfhlGvCd1zlNQ63SGCuE+NA4gykrf2HL60jTWIIVNrlVJdt+Gohmi3iVF7sNJhzVRlsw==
X-Received: by 2002:a1c:6a16:0:b0:3c6:f732:bf6f with SMTP id f22-20020a1c6a16000000b003c6f732bf6fmr22090618wmc.13.1672399941956;
        Fri, 30 Dec 2022 03:32:21 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y22-20020a1c4b16000000b003d01b84e9b2sm27638432wma.27.2022.12.30.03.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 03:32:21 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Mader <robert.mader@posteo.de>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Peter Robinson <pbrobinson@gmail.com>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        dri-devel@lists.freedesktop.org, Ondrej Jirman <megi@xff.cz>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v4 3/4] MAINTAINERS: Add entry for Himax HX8394 panel controller driver
Date:   Fri, 30 Dec 2022 12:31:53 +0100
Message-Id: <20221230113155.3430142-4-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230113155.3430142-1-javierm@redhat.com>
References: <20221230113155.3430142-1-javierm@redhat.com>
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
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v4:
- Add Sam Ravnborg's Acked-by tag.

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7729a30b9609..c901e536303b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6551,6 +6551,13 @@ S:	Maintained
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

