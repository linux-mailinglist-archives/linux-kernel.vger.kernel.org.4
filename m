Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA96562EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 14:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLZNvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 08:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLZNuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 08:50:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCEB111E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 05:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672062568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wH+4HRZ1zZ0UoFhrYTYu15fArLuO/swgT/BBXQ1MINU=;
        b=aUIleuIX0TbFIoOxpf3Rqo2HRkY6Rt5AgF54Sxuf26OJcp3uRiicMutyl8Gpdn7UNlJMlR
        CvWRvbO8sdC7cmp7qdcbq/93yaBij4OSarc/sRg/mr5oOFZ9qx1hLMK6M4VlAAeyyQzhX9
        teIGCyOEUuyH6NCpYY8dWkC9AkzMbVw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-523-xUIHL28nNE6ZigAMb7rhdw-1; Mon, 26 Dec 2022 08:49:26 -0500
X-MC-Unique: xUIHL28nNE6ZigAMb7rhdw-1
Received: by mail-wm1-f69.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so8095582wmb.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 05:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH+4HRZ1zZ0UoFhrYTYu15fArLuO/swgT/BBXQ1MINU=;
        b=PsMmEWGR6luD7BiFh7g1RqsEmUTVTPRxmmB+tuH3aGW/Y4ZkTGVjHI1o0h2a56mk3P
         zvquuM91tdnttUIK5m8C262h2HacHrjRG1jsa0NA5N8huvGmgSfTR+KM+7k0ztN2LQ6N
         qbt++2qnfV4ggpSwyuFdtjKPQiLMqmJgzYGtyv3lshHaXJ6FI+zD/i+5nL9T8X3ronwZ
         IAZn9y9gvcV2iBl/nZ7fIP//wAmJg/VC2SF0j3J+b/XWEKmGtmbOvI6hbHKdjA4H1ibJ
         BQhZR60rdFpoK0yKj9aJ3Y41PatKKSLwUTERS4m/mNuLcpPYeOMY7+r5gE3ioezFor0t
         qusg==
X-Gm-Message-State: AFqh2koybBJrR0tI7qJyJkYsF5SeB0zbXCmUjNh6Qbs4DirFIDa4/1YN
        XRzapys1gGVEHZDAyPefxxsQ1iqRLtQEu9/Aln5ps3xv65kt2/5SM/T9QUxKTZhqYQCYj7hWy8u
        gZMMxopIXehup+2pxSyUJdn2KbH65BzQBDiAIyy06sptdqOWGWcwgvyueKYZ1jt5O8kpwx+TcI5
        Q=
X-Received: by 2002:a5d:6509:0:b0:27c:73d7:775d with SMTP id x9-20020a5d6509000000b0027c73d7775dmr2659180wru.60.1672062565471;
        Mon, 26 Dec 2022 05:49:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtpHQibN8nOsFA2BcVaDhWa1Viff9G8V2BP8MQaeg1nZxmxCbYRcBtYRDmgyMhnTyv8I7rSUw==
X-Received: by 2002:a5d:6509:0:b0:27c:73d7:775d with SMTP id x9-20020a5d6509000000b0027c73d7775dmr2659166wru.60.1672062565254;
        Mon, 26 Dec 2022 05:49:25 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a18-20020adfed12000000b0027cfd9463d7sm3340947wro.110.2022.12.26.05.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 05:49:24 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Peter Robinson <pbrobinson@gmail.com>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 3/4] MAINTAINERS: Add entry for Himax HX8394 panel controller driver
Date:   Mon, 26 Dec 2022 14:49:07 +0100
Message-Id: <20221226134909.2822179-4-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221226134909.2822179-1-javierm@redhat.com>
References: <20221226134909.2822179-1-javierm@redhat.com>
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

