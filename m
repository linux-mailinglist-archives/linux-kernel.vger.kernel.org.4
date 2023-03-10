Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652A86B4734
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjCJOtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjCJOrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:42 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4250E122392;
        Fri, 10 Mar 2023 06:47:25 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-176eae36feaso6061371fac.6;
        Fri, 10 Mar 2023 06:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHCQ1euji6neWKguQ9p3AqIMnxiUG20jt745c0OKai4=;
        b=wodCoVFu+/9TZWhysFok2tfZdFzeEzXut9II2voSooVM6FP747EziSzxwS5DC/snyk
         oyp8wdvBeEbcUVV5/oVMj9oO06Ck19gqJLSbqGnNBYtBDjDPMSCNrq4hz7CJ86yP4SAP
         L+qZmA24O+9+Bd27coYWp7AQQPut61TClyLEmKijnB5aRpWAeHSE09ruqGuOS98jK/L3
         ZV4KreMgE8O/rU/H5U3VhGEFDRqolPe0/oO+JC8amvOfMtUO//MMlRGnWqopB2wFni4i
         p9QvtgokpF6dk6arU8+XeqW0QM5LpQMkBMqHdUTaJu0jmiRIgv/zCFsvbHJUHoO8qanB
         3rtQ==
X-Gm-Message-State: AO0yUKVR36qhwD48jSbcDIxXBcqWWQC9GNuMTpwIr52K0/ssxlR0WoC5
        S5zomqaDuoGkV81WnmG2ivV2CjMmeg==
X-Google-Smtp-Source: AK7set9o4CLX8kOpJQGE9zCENljeMFjnify8tL7VdB1inL3cfHQaOg9FPyNnzKQZZi9F39935U5Ykg==
X-Received: by 2002:a05:6870:64a3:b0:163:2ca0:ff77 with SMTP id cz35-20020a05687064a300b001632ca0ff77mr17448914oab.8.1678459640810;
        Fri, 10 Mar 2023 06:47:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eb15-20020a056870a88f00b001723f29f6e2sm84910oab.37.2023.03.10.06.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:20 -0800 (PST)
Received: (nullmailer pid 1543570 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc/sram: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:12 -0600
Message-Id: <20230310144713.1543544-1-robh@kernel.org>
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
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/misc/sram.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index f0e7f02605eb..8796741929a5 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -218,14 +218,9 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 		block->res = child_res;
 		list_add_tail(&block->list, &reserve_list);
 
-		if (of_find_property(child, "export", NULL))
-			block->export = true;
-
-		if (of_find_property(child, "pool", NULL))
-			block->pool = true;
-
-		if (of_find_property(child, "protect-exec", NULL))
-			block->protect_exec = true;
+		block->export = of_property_read_bool(child, "export");
+		block->pool = of_property_read_bool(child, "pool");
+		block->protect_exec = of_property_read_bool(child, "protect-exec");
 
 		if ((block->export || block->pool || block->protect_exec) &&
 		    block->size) {
-- 
2.39.2

