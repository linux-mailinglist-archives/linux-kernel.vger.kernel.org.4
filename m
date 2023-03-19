Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58456C0322
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjCSQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjCSQcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:32:46 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D6720060;
        Sun, 19 Mar 2023 09:32:24 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id d14so1590387ion.9;
        Sun, 19 Mar 2023 09:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOo8FyF7jwRP0L0/DCsqOtLfD9IQ2Dgjo9DgIapHOWc=;
        b=uXQ0h2PXFFUToEQYwe1CLRPpbenlLmvujEZ0LQLC9qtjkM9ZaNszJn3a89qYdetJrH
         HOgt4O3v6aPqyHnzsmYwv272pvOxhSmJ0cPXaOLiXR4NvdbA/1QBOy0W6+TYiEPBYUb2
         yMne02lgdA25NSk7r85jAv0bOxj1DXDR20ftlrloyI81aBT+JQk3zYBzkDFPCQjWKSsS
         AA7LG/oIcgxhowCMTFxpfAClFcOYX5U4T6v6BlXAk8FQeXpNM7/hhYrEM5sc/X5uLct4
         bwgCTv/RRjUkUDadkJAvi876TWCL+uTXILGQJ7VL/QZs104w29xSY/uc/4app8RcRAiP
         SW3Q==
X-Gm-Message-State: AO0yUKXjvLsZBrKB3etisBtXcOSYGcdbEYZ2WBdpNPtrYa1gIpn28XDT
        ZcifW4lCHfla/MJ6Jcmw5ovkuHMfQA==
X-Google-Smtp-Source: AK7set/h6vpCslX6rjxzrWpAO3XN3jPyrb7izBUOhcXggLs7QMgyyrivJJ9IlFuZ3bUgBfMkIoRvPg==
X-Received: by 2002:a6b:f01a:0:b0:743:7742:1bc2 with SMTP id w26-20020a6bf01a000000b0074377421bc2mr3523486ioc.16.1679243542321;
        Sun, 19 Mar 2023 09:32:22 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id a6-20020a5d9ec6000000b0074ca5ac5037sm2262348ioe.26.2023.03.19.09.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:32:21 -0700 (PDT)
Received: (nullmailer pid 226230 invoked by uid 1000);
        Sun, 19 Mar 2023 16:32:19 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tero Kristo <kristo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: ti: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:32:17 -0500
Message-Id: <20230319163217.226144-1-robh@kernel.org>
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
 drivers/clk/ti/clkctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index f73f402ff7de..b6fce916967c 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -512,16 +512,16 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	struct clk_hw_omap *hw;
 	struct clk *clk;
 	struct omap_clkctrl_clk *clkctrl_clk = NULL;
-	const __be32 *addrp;
 	bool legacy_naming;
 	const char *clkctrl_name;
 	u32 addr;
 	int ret;
 	char *c;
 	u16 soc_mask = 0;
+	struct resource res;
 
-	addrp = of_get_address(node, 0, NULL, NULL);
-	addr = (u32)of_translate_address(node, addrp);
+	of_address_to_resource(node, 0, &res);
+	addr = (u32)res.start;
 
 #ifdef CONFIG_ARCH_OMAP4
 	if (of_machine_is_compatible("ti,omap4"))
-- 
2.39.2

