Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4762B6DCE03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjDJX07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDJX04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:26:56 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C922700
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 16:26:53 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id m2so3867181oiw.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 16:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169213; x=1683761213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+lsRPR514idYMKUtLslcoXrNYCKeBOjYwsL0KuiBuc=;
        b=vx3GfdAsrKxPjcBtcP3AGDaINWmZtde0j27y1SdONlsgxsr0jBu6BXjsBVajQdSS8+
         dK1b9ZZyjAMsxCLOydtYVCljm4IUQHXu6DOnFG7ahYP0k/GuK3efIM0BGySRbH/ma0UN
         ztIdp9Zn2fdvW930poKI4mbAajFNBaJVTqW6cvT7Hk0WiA+We/DCjHV1Quc0QGtDhXFG
         aj3qsk24EWtmlVCSj0EIcdKPdkGOUgDXiQ1kR4t/IXNXJak9a0N+QtQIGZ6Ho6fg4/T6
         A8d4t2BPNVhQ9GyUCKlwDVw3f4CuRSxxlBTtGXG5xalDYZ47uAxeFYqPMpisbo5szllz
         OiXw==
X-Gm-Message-State: AAQBX9eUJWfB0jsG3C/TL6HWVW/rXL4JkWZj9WjbuqdOoz26nzN3zixo
        6rqNrMCdItBt6TwPt9Kejg==
X-Google-Smtp-Source: AKy350bMRODLWiHG8M3XGvsdW3OXsPmqZaFRg21HJ4+qq9Le0+B1ipqYChCPdF/n1NeqoBs7wmg3XQ==
X-Received: by 2002:aca:220b:0:b0:387:2075:59b with SMTP id b11-20020aca220b000000b003872075059bmr4660945oic.24.1681169212605;
        Mon, 10 Apr 2023 16:26:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 17-20020a544191000000b00383ece4c29bsm4930513oiy.6.2023.04.10.16.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:26:52 -0700 (PDT)
Received: (nullmailer pid 1561407 invoked by uid 1000);
        Mon, 10 Apr 2023 23:26:51 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm: etnaviv: Replace of_platform.h with explicit includes
Date:   Mon, 10 Apr 2023 18:26:47 -0500
Message-Id: <20230410232647.1561308-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Etnaviv doesn't use anything from of_platform.h, but depends on
of.h, of_device.h, and platform_device.h which are all implicitly
included, but that is going to be removed soon.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 44ca803237a5..c68e83ed5a23 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -6,7 +6,9 @@
 #include <linux/component.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/uaccess.h>
 
 #include <drm/drm_debugfs.h>
-- 
2.39.2

