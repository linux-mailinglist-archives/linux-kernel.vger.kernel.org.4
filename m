Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933F06B4729
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjCJOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjCJOrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:39 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97A1120865;
        Fri, 10 Mar 2023 06:47:22 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-176d93cd0daso6077725fac.4;
        Fri, 10 Mar 2023 06:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpgx4CM4QTHptKDBGTPzlfwWfMWQrZb5f5lH9E1GeQQ=;
        b=QMLLmn0QUIXYo9hGoZqHPyYGGYj+VsIlSHgDoVfh/uqX8WtAikDyCCXObgOtWODnRE
         siMGCmZMmXiYD+9tK7S4f1fCqdCyokrcfK0lP6er5v0I+VBlCadD7UudhjRhWBU9MMlU
         0VCg9X+Knu308NBODnDe5fkhSWmwOkcyCOx7GcuViMUK34MdgwZ9BPJiAeJthbnSQKFC
         3X44qjGlx8B3yzRyclCRhzbcqoIVI/b0Z7en6o3u6ud122CecxVD6boFTyzqokiJO/L1
         K/fTy5p2X7gXeqDNWmpQKCx1DcKwBt+sRCb3mJZ00WhW0LfDviiEKMDxHC0oAcPIRKkx
         rzKg==
X-Gm-Message-State: AO0yUKXIgBb9qqv8JHrsAvWFUOqsJCDw6DwezuLW1LODROAn6HovdcT+
        a/XvsuPzV4OiV5yq/nrQk1TtQ4a5+w==
X-Google-Smtp-Source: AK7set+Ovw9dE9l/bcL5S3/f1hQjQMjRF9HMHKWTfj7fhcXtHDFd09AjwRONrH2sgpgOrmra4d9rwQ==
X-Received: by 2002:a05:6870:8a09:b0:176:4c90:a172 with SMTP id p9-20020a0568708a0900b001764c90a172mr14588755oaq.56.1678459642058;
        Fri, 10 Mar 2023 06:47:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o21-20020a056870e81500b0016b0369f08fsm119202oan.15.2023.03.10.06.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:21 -0800 (PST)
Received: (nullmailer pid 1543336 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] memory: atmel-ebi: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:11 -0600
Message-Id: <20230310144711.1543295-1-robh@kernel.org>
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
 drivers/memory/atmel-ebi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index e749dcb3ddea..635966d705cb 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -598,7 +598,7 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 	reg_cells += val;
 
 	for_each_available_child_of_node(np, child) {
-		if (!of_find_property(child, "reg", NULL))
+		if (!of_property_present(child, "reg"))
 			continue;
 
 		ret = atmel_ebi_dev_setup(ebi, child, reg_cells);
-- 
2.39.2

