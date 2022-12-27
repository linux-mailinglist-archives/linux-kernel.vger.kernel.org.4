Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400366569BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiL0LF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiL0LEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F54A45F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672139027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wH+4HRZ1zZ0UoFhrYTYu15fArLuO/swgT/BBXQ1MINU=;
        b=aq50vioswAJC3WSHbmfMO9KhNY54Ec44FAsGqOrIwsYkjq2hFhAHN2K/ZDV71RTXxP1Jx0
        c5gx+F9x1TJrYv/gt0RqMzR6wqoeyCCbVhI1MxqbAt6AyvDXdxH588oFdBxVOpLpEWZkPs
        aGUBYJQUQb6tgNMHNba3zkogYxAU41M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-kwjmn8xcPp6V9NQv8UUw3A-1; Tue, 27 Dec 2022 06:03:46 -0500
X-MC-Unique: kwjmn8xcPp6V9NQv8UUw3A-1
Received: by mail-wm1-f71.google.com with SMTP id bg25-20020a05600c3c9900b003cf3ed7e27bso6769333wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH+4HRZ1zZ0UoFhrYTYu15fArLuO/swgT/BBXQ1MINU=;
        b=1DIyZongOLIO99rhWCeF8tMPw4MTWlNne1UCFKi7zz3vaua7K5KnfAq9WNaldK5nHK
         7KYHGn9h51obF9R+HyX1tVQI//lTOnnrxiICNcWQvaZraK/8pMSkZzAdjHwQo09Ki22w
         HXN+PWE5j2ebbae4fK+U3K/BnUULyzZMA9RdALw5CTsHWIxZ+bCzjyDFGAx10BR4lKsc
         adV57pYWc7NMD6Q+M+ZStXx1x44gx41ztStAspGaZ6ApF55szf4J3LzZYFEjVuBrfkws
         mDDJhWTYZrK6HLQCBHYfHEaNESjUJsVndrs5m/XNuQUNpCymgknc+QLRw8LQ6zCPWpEl
         j32Q==
X-Gm-Message-State: AFqh2krxGatgcX009lopnpU/7RTY0Ei4gNV8dGyjVvzqmj2lC1xlx1DK
        QuMhK9+eVRW2Uf+aZcqTIKDKxPUlN+1Imr/gOdhfxhP3eCCRmKV26r/uM1M+ed9QcvV1AeEamab
        yLIz+fVhabL8q5q77vWyr2Yn6Rk2kSkxlBSEfLFfS+fNyKwRxFx48gc8TtKmwkzb2Oo0ocMKgDX
        M=
X-Received: by 2002:a5d:6e0c:0:b0:27d:a1ea:dcfa with SMTP id h12-20020a5d6e0c000000b0027da1eadcfamr3905024wrz.19.1672139025171;
        Tue, 27 Dec 2022 03:03:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs8h2wHJt0LfoL/Atrfl1zO+CdP9j8AFrLksVlvhM637LO1v1b1ONi7rK7lBzsZVnsrVGLsQA==
X-Received: by 2002:a5d:6e0c:0:b0:27d:a1ea:dcfa with SMTP id h12-20020a5d6e0c000000b0027da1eadcfamr3904995wrz.19.1672139024881;
        Tue, 27 Dec 2022 03:03:44 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p18-20020a056000019200b00279d23574c4sm7374557wrx.13.2022.12.27.03.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 03:03:44 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Martijn Braam <martijn@brixit.nl>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v3 3/4] MAINTAINERS: Add entry for Himax HX8394 panel controller driver
Date:   Tue, 27 Dec 2022 12:03:34 +0100
Message-Id: <20221227110335.2923359-4-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221227110335.2923359-1-javierm@redhat.com>
References: <20221227110335.2923359-1-javierm@redhat.com>
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

(no changes since v1)

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

