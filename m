Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE76B46E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjCJOrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjCJOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:20 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C0212209C;
        Fri, 10 Mar 2023 06:47:01 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so3035308otp.6;
        Fri, 10 Mar 2023 06:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/C+fNk0w1+varw1acVN8y8bRrPEeVF6o0QOP6xK1xI=;
        b=NIm5rz1654l7tq0u8e0tXblLDdEDycuV5A8+eGAn5g0NdVJtn1LTpx7B4igeiAcFf9
         UD9+Tz30AB0HHPN0vxgu5UjKnoPiNe73vPxypvbbuxrCYECno+WxSLzqGydG9h6bidac
         fuchPzBYWq+jmkz6FjnpyYTlSF6DN9Id2oeaYuLbEr5CdWlgkHD5prjCP1NWHc1vfUL4
         qC+grmQD2CRysQ0XGGYbKEHZ8JIDvGCNz/LnnLgjDExu8rgdENHy6HGfBptuoKKNhxkH
         OeLwbUsA2R5kKD4eWX6mRc9/MIG1fWrhaTTeN2k2MuUyHWvSbQTwOnff/H/QAQVu6A54
         RLtw==
X-Gm-Message-State: AO0yUKVYm4AaIhHL/4KH5H9YNhMFiqESCTBkTgqxXMcXkCOoWdBGCs8h
        x6pLjPkDlqwXYLCgwJxxhg==
X-Google-Smtp-Source: AK7set+iPlqLxAvKsse9T3A1If3SSfJcDQ+1VRuqO8QNi+liEvMsbJZYegEvu161cbJrX1iKvRa4XA==
X-Received: by 2002:a05:6830:4423:b0:690:ef1f:6191 with SMTP id q35-20020a056830442300b00690ef1f6191mr14947003otv.32.1678459615767;
        Fri, 10 Mar 2023 06:46:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z12-20020a9d468c000000b0069436b64bb1sm90153ote.79.2023.03.10.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:46:55 -0800 (PST)
Received: (nullmailer pid 1540587 invoked by uid 1000);
        Fri, 10 Mar 2023 14:46:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mxs: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:46:54 -0600
Message-Id: <20230310144654.1540561-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-mxs/mach-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 0129b7c514d7..51e47053c816 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -174,7 +174,7 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
 
 		from = np;
 
-		if (of_get_property(np, "local-mac-address", NULL))
+		if (of_property_present(np, "local-mac-address"))
 			continue;
 
 		newmac = kzalloc(sizeof(*newmac) + 6, GFP_KERNEL);
-- 
2.39.2

