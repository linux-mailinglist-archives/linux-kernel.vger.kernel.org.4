Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E36565B815
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjABXJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjABXJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:09:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426735FF8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672700865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xEVt3NVnWgbCIhCiAs4I26hLaITp9BpaVbzzj55zI/o=;
        b=b6w9XSRg6qVbeU9rYXYz+uwoS2dHQcpMmif3x/zryTFZmeYJbGTcEs06pCYFcKHrH7Q0eT
        TNmmJFX9hLCVfsCj5P8qyS3l5wlT6dYo9meCfGhAS1pbzyxVwC8rmSMH3B/uzswtRnBgQf
        lmec653MNxH/eMRyPndlTAtqMILCdzc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-618-TbclvpejMQ6QNZzVjnRbVg-1; Mon, 02 Jan 2023 18:07:44 -0500
X-MC-Unique: TbclvpejMQ6QNZzVjnRbVg-1
Received: by mail-wm1-f71.google.com with SMTP id fm17-20020a05600c0c1100b003d96f0a7f2eso16144359wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 15:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEVt3NVnWgbCIhCiAs4I26hLaITp9BpaVbzzj55zI/o=;
        b=40O1gC36+bleP2VJUI8ju3BdTaXFeWhe0fevTXOt9UIGunqXlK2CvhABCUu3z9AGIj
         xLyyFJEF+Jwnjq7LFMiZpuWVADXanWkfInVOeExdVsJgaT3P1hY9VdgEX4+AX8jFw4Ob
         OOKAlKe/jRNxYBcA/YYHjDy9qtCjphDunux+rL4Q5kSZ+Bh05TsMuPqYxfBbDpFhg2c1
         rTLBRtuw19eBBWdR6Z4hTDU4YoaT84N+cqVjE+A5w8CmwhefLpZRa9yBkQAX5H4Y62F5
         2rbZn3Vt5nZnNFay5Xya/v/bNmixZuTMB2pMaYyuBq+9VfXRzKIZhBVAAdJwVtbISAH9
         JvIQ==
X-Gm-Message-State: AFqh2kp4kVDO0pYAwyiOUwEkpvrOvU41Tvz9DGrvmOf9BArlPDCXqW94
        LmOBKy3Z58Z4oAhk+NBe/iZA+jeyCr5w33pBCLH37oS/i2muG57doV3DCHmljay00S1nVbLz7gs
        M9ZY9Wr6NByTTn54aQlfdu0dfF8+KU4jMF/7fabeJCzwfiTEE/p3rnBVdv9WpOKcGg++4oBewU4
        s=
X-Received: by 2002:a5d:5b07:0:b0:270:f10a:b90a with SMTP id bx7-20020a5d5b07000000b00270f10ab90amr24413812wrb.6.1672700863219;
        Mon, 02 Jan 2023 15:07:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtFtxgFQDsT6Mb75iNuIlGvVyvule10jwKdBVTfDBmmmfINbIrqc/dQ/xFUISLhZBP+OpbL4Q==
X-Received: by 2002:a5d:5b07:0:b0:270:f10a:b90a with SMTP id bx7-20020a5d5b07000000b00270f10ab90amr24413791wrb.6.1672700862955;
        Mon, 02 Jan 2023 15:07:42 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d4fca000000b00281eab50380sm22746906wrw.117.2023.01.02.15.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 15:07:42 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Robert Mader <robert.mader@posteo.de>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        Martijn Braam <martijn@brixit.nl>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        dri-devel@lists.freedesktop.org,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Ondrej Jirman <megi@xff.cz>, Neal Gompa <ngompa13@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v5 3/3] MAINTAINERS: Add entry for Himax HX8394 panel controller driver
Date:   Tue,  3 Jan 2023 00:07:33 +0100
Message-Id: <20230102230733.3506624-4-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230102230733.3506624-1-javierm@redhat.com>
References: <20230102230733.3506624-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Changes in v5:
- List Ondrej Jirman as a maintainer in the driver's MAINTAINERS entry.

Changes in v4:
- Add Sam Ravnborg's Acked-by tag.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7729a30b9609..4e049faf2f51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6551,6 +6551,14 @@ S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/tiny/gm12u320.c
 
+DRM DRIVER FOR HIMAX HX8394 MIPI-DSI LCD panels
+M:	Ondrej Jirman <megi@xff.cz>
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

