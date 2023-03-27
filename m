Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0A6CB1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjC0WbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjC0WbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:31:02 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010A835BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:31:01 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-177b78067ffso10903159fac.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679956261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mf8YALXMAY/oSxpeLp2A058qCfNVm9+JRcuQgM0hLFA=;
        b=PPM7h1OJOmOoE/zKDg4jEwOw/TmJdTsT7pOdABBjkQCKeE+P4fTcAav3ykafyg4R35
         MlQ8E/lp3ia/RrLN5oBWJAxHpapbyH4gtEgdaG1A87GFJXBI3lU1/SbnfDFamno7E1Nt
         5f17pbel3ukL5EnaTUK5k38IaAd0YZKfg/1oIPUfis6VZjYS6CWcz1BCqeyGrVspTttW
         WUXpuWhRMyJEBvm8TamKLzupnzuSXfdydpCBTZkjlWWBnuTvjweFpfuj4vDhenCovV/C
         0Sg4kRru86czIhKqL6o9l46khkbYKlLIFC1uJKQP+7QV4K+TDpPav63CGXD+6rxo3kmi
         dJEg==
X-Gm-Message-State: AAQBX9fETdrDx0z9iMYKoYPxhqrkRGp3NtRNPOR3C+Yx12fwqQXPCZCq
        ox/cIZVqEulqBFZaww2ZnA==
X-Google-Smtp-Source: AKy350bE5sjLYYl4fEl8g5vXHWB5v2Q4qReU1rrJUv820vOzN4tyWD5SBkSrRmB3RCxgQGKUg4B5MA==
X-Received: by 2002:a05:6870:c6a1:b0:17e:b9f6:5d76 with SMTP id cv33-20020a056870c6a100b0017eb9f65d76mr8451553oab.41.1679956261279;
        Mon, 27 Mar 2023 15:31:01 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v23-20020a056870709700b0017280f7d653sm10250250oae.35.2023.03.27.15.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 15:31:00 -0700 (PDT)
Received: (nullmailer pid 820175 invoked by uid 1000);
        Mon, 27 Mar 2023 22:30:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: xics: Use of_address_count()
Date:   Mon, 27 Mar 2023 17:30:56 -0500
Message-Id: <20230327223056.820086-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

icp_native_init_one_node() only needs the number of entries in "reg".
Replace the open coded "reg" parsing with of_address_count() to get the
number of "reg" entries.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/sysdev/xics/icp-native.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index edc17b6b1cc2..f6ec6dba92dc 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -259,7 +259,7 @@ static int __init icp_native_init_one_node(struct device_node *np,
 	unsigned int ilen;
 	const __be32 *ireg;
 	int i;
-	int reg_tuple_size;
+	int num_reg;
 	int num_servers = 0;
 
 	/* This code does the theorically broken assumption that the interrupt
@@ -280,21 +280,14 @@ static int __init icp_native_init_one_node(struct device_node *np,
 			num_servers = of_read_number(ireg + 1, 1);
 	}
 
-	ireg = of_get_property(np, "reg", &ilen);
-	if (!ireg) {
-		pr_err("icp_native: Can't find interrupt reg property");
-		return -1;
-	}
-
-	reg_tuple_size = (of_n_addr_cells(np) + of_n_size_cells(np)) * 4;
-	if (((ilen % reg_tuple_size) != 0)
-	    || (num_servers && (num_servers != (ilen / reg_tuple_size)))) {
+	num_reg = of_address_count(np);
+	if (num_servers && (num_servers != num_reg)) {
 		pr_err("icp_native: ICP reg len (%d) != num servers (%d)",
-		       ilen / reg_tuple_size, num_servers);
+		       num_reg, num_servers);
 		return -1;
 	}
 
-	for (i = 0; i < (ilen / reg_tuple_size); i++) {
+	for (i = 0; i < num_reg; i++) {
 		struct resource r;
 		int err;
 
-- 
2.39.2

