Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9836B4788
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjCJOvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjCJOuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:50:10 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6D4AFC8;
        Fri, 10 Mar 2023 06:48:09 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-176b48a9a05so6137676fac.0;
        Fri, 10 Mar 2023 06:48:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cw44gWatMHAFXsp5Bf1XmtOCAdzF/BFR6Jh05S7SHc=;
        b=pspoFOKlw7WaDoDaeAY5OAuw255rT+bwC8Qh48Zl6WlycYKE8K+8wfVODYeqzPfY1W
         QHVEEfBeNmZMCcKGZj6S2wrcN1f+l04k/GuO/UyO1fZGdFHQGDBr8QD7KgJoZOL1xTwY
         No9w/JSw9eLEbRXQZLJ3Wg9ia93mqzjut44eeCfjYxP10LBymTI7rJhVLlhPdy1jMhvr
         YZXOzwg3cTQNIy10zwl1dXwNhh7MpMbWoZLWrmKsLE+zMpqcH2P6jorvVYvHRtwpS50H
         RU4VwrpYWHykbfRSupGBAwFdMpIcEoD5N3n35rGr0RNy49D/WxIumvF+ChJ8rJ88J6MZ
         Hl/Q==
X-Gm-Message-State: AO0yUKWjDXWE9b6H+gIlS9onItg2VDqSTMNu4YyBf7GNhQ6WcQ0h9Dre
        dkLTTTmAO8Q6b021+xvnfg==
X-Google-Smtp-Source: AK7set+Zj6vvg/AmICk7/oD81/eKSnxwP1Wq1NCl/JJzCI3tJ2URV59x6Vj6oI0pjCaRj+pBsB4pjQ==
X-Received: by 2002:a05:6870:9724:b0:176:4631:3c0d with SMTP id n36-20020a056870972400b0017646313c0dmr16556971oaq.34.1678459673974;
        Fri, 10 Mar 2023 06:47:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j21-20020a056870d45500b0017697dfc20fsm118605oag.12.2023.03.10.06.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:53 -0800 (PST)
Received: (nullmailer pid 1546147 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: hx8357: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:30 -0600
Message-Id: <20230310144730.1546101-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
 drivers/video/backlight/hx8357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 9b50bc96e00f..f76d2469d490 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -617,7 +617,7 @@ static int hx8357_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	if (of_find_property(spi->dev.of_node, "im-gpios", NULL)) {
+	if (of_property_present(spi->dev.of_node, "im-gpios")) {
 		lcd->use_im_pins = 1;
 
 		for (i = 0; i < HX8357_NUM_IM_PINS; i++) {
-- 
2.39.2

