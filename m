Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A926C031D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjCSQcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjCSQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:32:42 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5011DBAE;
        Sun, 19 Mar 2023 09:32:19 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id h11so5391536ild.11;
        Sun, 19 Mar 2023 09:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZnfxLrdbXqpdX0ft3ryjeGmAE4ImDQE/rDMFgstwgA=;
        b=LZrMjQuyS/4voPDRaNLxI+Vouim1o9gs3z2Do2uBKklq0ab7v3d/Sa2Sp02LjP74PN
         Ip7L4zqTwcWAgwDxnWLDT4JlAPVjiHPvXchzHG7zOSMmCMmQIgyYVjHTfRJ6BR83/OsK
         3wwZE3DxlnpfmOvfufRO4iGDFBU4TXgzoILx5cwb6ItDEaxmPaymyvPw2bEce53BPrZw
         S01R1EZAT0gqb3h2sc5KJ2nwEo59htFQetzQaJ2FFdESl8RMxVFaTvohiQ4WmbEXg+5n
         PcxKIAXSkWFAv+p2kM3l7eVSF2wcfUnVHkekFB8lNKp6qAvfFBTpe5dlDp9ZYYpBRh4A
         rxWQ==
X-Gm-Message-State: AO0yUKXCUFPyYSvGmx8AgSoj1yCf1FgzT+y4ErUe2XiZ5B+0TIY4/Ziv
        j2BBgT1ynGFKcr1/POQZdVO4UFWt0A==
X-Google-Smtp-Source: AK7set8BLLld/Z/b4kvohDSLmveai33RDRpJFpw0QXJHWgoZ1IVdQzCuOwVTmoqGE0cZhn49K+9Udg==
X-Received: by 2002:a92:c8c6:0:b0:310:c1b3:9906 with SMTP id c6-20020a92c8c6000000b00310c1b39906mr2682144ilq.25.1679243538990;
        Sun, 19 Mar 2023 09:32:18 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id l10-20020a05663814ca00b00406237f0752sm2530091jak.1.2023.03.19.09.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:32:18 -0700 (PDT)
Received: (nullmailer pid 226101 invoked by uid 1000);
        Sun, 19 Mar 2023 16:32:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bcma: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:31:59 -0500
Message-Id: <20230319163159.225773-1-robh@kernel.org>
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

Replace of_get_address() and of_translate_address() calls with single
call to of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bcma/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 7b39f010bbb3..5e438f74ee4c 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -140,17 +140,17 @@ static struct device_node *bcma_of_find_child_device(struct device *parent,
 						     struct bcma_device *core)
 {
 	struct device_node *node;
-	u64 size;
-	const __be32 *reg;
+	int ret;
 
 	if (!parent->of_node)
 		return NULL;
 
 	for_each_child_of_node(parent->of_node, node) {
-		reg = of_get_address(node, 0, &size, NULL);
-		if (!reg)
+		struct resource res;
+		ret = of_address_to_resource(node, 0, &res);
+		if (ret)
 			continue;
-		if (of_translate_address(node, reg) == core->addr)
+		if (res.start == core->addr)
 			return node;
 	}
 	return NULL;
-- 
2.39.2

