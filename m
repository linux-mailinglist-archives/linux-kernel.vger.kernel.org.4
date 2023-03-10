Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E96B477D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbjCJOvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjCJOt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:49:59 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BB27AB3;
        Fri, 10 Mar 2023 06:47:58 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-17638494edbso6033996fac.10;
        Fri, 10 Mar 2023 06:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72GZ6tt+NtMByXBprOsf1R5lfkGwkm3Xw8kwN9b+yWo=;
        b=SiDk5jt8IfZuX3rcDwUnB+PEETUIdU3Oo8Mqwx/KGIIgCvmnI9y542bRQerZum9fFL
         ixp1e27K6lSt53s3yVi2EPOLwUuNVvelP48ZyQkSkEvWSXyRSx3I4PVsu42Umrws3jvq
         Ge+BOQjpwv8RZINjYCYgQfUwRY5Mrzfk/6ywYQ8noV6ZUzdQRDTkXy/T1huJ3pBIXELE
         n6wa8sxpCj4tKWrd5WAsTZBN0+0eLgEe3LueoybqRZA8iDUnrL2fBhHnFKUpTiKT759r
         GwXt3ObY3LExaD8mJkc+rYetn6MYLDcxFHdtFYmvhTMc3PbCbVqix3YOV4jYkXU/YuYV
         rOTg==
X-Gm-Message-State: AO0yUKWyQAD9EuaSh3rJdAZ4TB0v9nNV5pD27T1WE5IQgGJzoR/WpeJc
        MlWLvDQKVpo5gWviXz2xfw==
X-Google-Smtp-Source: AK7set9JuJayVFavWfSPxdB9MZVNOuRYl8Z6r6VhwjgRJ6ZHv32dVupXnUJFExVxqSPdm4Mkjz4oFw==
X-Received: by 2002:a05:6870:e886:b0:15e:c4e1:c9fb with SMTP id q6-20020a056870e88600b0015ec4e1c9fbmr5624135oan.31.1678459670465;
        Fri, 10 Mar 2023 06:47:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o20-20020a9d7194000000b0068657984c22sm124712otj.32.2023.03.10.06.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:50 -0800 (PST)
Received: (nullmailer pid 1547067 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: sun6i: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:36 -0600
Message-Id: <20230310144736.1547041-1-robh@kernel.org>
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
 drivers/rtc/rtc-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 7038f47d77ff..dc76537f1b62 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -260,7 +260,7 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	}
 
 	/* Switch to the external, more precise, oscillator, if present */
-	if (of_get_property(node, "clocks", NULL)) {
+	if (of_property_present(node, "clocks")) {
 		reg |= SUN6I_LOSC_CTRL_EXT_OSC;
 		if (rtc->data->has_losc_en)
 			reg |= SUN6I_LOSC_CTRL_EXT_LOSC_EN;
-- 
2.39.2

