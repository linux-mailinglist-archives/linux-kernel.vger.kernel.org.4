Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5EC74DCA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGJRkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGJRkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:40:20 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBA8135;
        Mon, 10 Jul 2023 10:40:17 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-78362f57500so243177639f.3;
        Mon, 10 Jul 2023 10:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689010816; x=1691602816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJ0X7LH8Y32+25vFKtVfefQZ8VxfYOg+I+aDeHwgaRg=;
        b=ea8pNLA3H378zc+JylHhCzz6ZFAycmOCxxiA3R46VYh9UVYdBjav9B7keAQbvCsXbK
         ynSNLKnHOMpgvb429xybA/nVdXVeu79Ok+Ln7iLybDTmtJlYIhZlDGUAl9FawZINC+8u
         C+lyPZrriz/I1KEKRIkUiYBSFY1D+oZjdhClZBOnD8N+g+IbwoyAcZjl4kwBH0A9QpOV
         HUIc7clL0+nBdrjGOvEUDx+0V97Z/jluph3uANqCwCs0muSCe6l9u3lwkE2CN0e5bGDN
         kJQdDrffWnwo2b3XjPfzseM8ruUmxz7WrdYfGyY5B4i+anzA0jBNt04xykLEIbLfzNPd
         GrlA==
X-Gm-Message-State: ABy/qLZIe+XDfVCE/NQLsr9B+A3I03tv38TKIVYSoaQJ38gkSAGpFAa5
        tTByAbXOH5x8T2OnZwsETg==
X-Google-Smtp-Source: APBJJlE0oA73gYUIwMelcM8z0408U22yjSo8RUGJb2rqGjtGdswxkKCC9nABPtEoktryHkXAAacu7A==
X-Received: by 2002:a92:4b08:0:b0:33b:dcbf:e711 with SMTP id m8-20020a924b08000000b0033bdcbfe711mr15060887ilg.8.1689010816389;
        Mon, 10 Jul 2023 10:40:16 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w18-20020a029692000000b0042036f06b24sm3449146jai.163.2023.07.10.10.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 10:40:15 -0700 (PDT)
Received: (nullmailer pid 2291150 invoked by uid 1000);
        Mon, 10 Jul 2023 17:40:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        stable@vger.kernel.org, Cyril Brulebois <cyril@debamax.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: Preserve "of-display" device name for compatibility
Date:   Mon, 10 Jul 2023 11:40:07 -0600
Message-Id: <20230710174007.2291013-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 241d2fb56a18 ("of: Make OF framebuffer device names unique"),
as spotted by Frédéric Bonnard, the historical "of-display" device is
gone: the updated logic creates "of-display.0" instead, then as many
"of-display.N" as required.

This means that offb no longer finds the expected device, which prevents
the Debian Installer from setting up its interface, at least on ppc64el.

Fix this by keeping "of-display" for the first device and "of-display.N"
for subsequent devices.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217328
Link: https://bugs.debian.org/1033058
Fixes: 241d2fb56a18 ("of: Make OF framebuffer device names unique")
Cc: stable@vger.kernel.org
Cc: Cyril Brulebois <cyril@debamax.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 051e29b7ad2b..0c3475e7d2ff 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -552,7 +552,7 @@ static int __init of_platform_default_populate_init(void)
 			if (!of_get_property(node, "linux,opened", NULL) ||
 			    !of_get_property(node, "linux,boot-display", NULL))
 				continue;
-			dev = of_platform_device_create(node, "of-display.0", NULL);
+			dev = of_platform_device_create(node, "of-display", NULL);
 			of_node_put(node);
 			if (WARN_ON(!dev))
 				return -ENOMEM;
-- 
2.40.1

