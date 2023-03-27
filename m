Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F326CAD67
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjC0Snj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjC0Sn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:43:29 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8D635BC;
        Mon, 27 Mar 2023 11:43:22 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id p2-20020a056820044200b0053e5914a50fso229890oou.2;
        Mon, 27 Mar 2023 11:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679942601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mYF/p73swKVMGgtJSK6eBueBgSxph1TeoNqsitRFwA=;
        b=XjRttvbJRCUx82ASH1d5wEA5halSg15OyoYCZ9w3v3R75MM/Xh6VZWRDx3dNSpoe+E
         SoYDHw+kIeuMIdEdNYb0FXHHa3rhO/f/mQNfPD56F9NGctjcUQOE+6Rx+ArpQohLNdhB
         Oyeq9DCt/+bbL95Aqx3KogLfatZM34D2Xwcal0PAPEkzqdQCsuEP9F1KNLaMIls0HB/G
         G5ZsDXRBon4VOaFOGBHKeWXM+oXCnDlCZoMZRTPUkGwTbLr92AvTFTZUpdEWbqLbWSbR
         XMJU95fXd8S3Ud7uVtvPfus/b7U8aUD+nfrxkrCtxhcdVdndfuQf0urNzqPsXqUplPWc
         ajMQ==
X-Gm-Message-State: AO0yUKV7id96TJFijdZvZBRHL/t92VeQ7vE4gxs7F7pkg6e0XEtdA+6O
        UMPoNCT3/IiMacefM745yg==
X-Google-Smtp-Source: AK7set93rXSYxq6KWYshAjTfCfw3AeV65pKHZdMYG56Xbhfos4ATeuSH5uZ8XV3z5yG6pRXhevkRtQ==
X-Received: by 2002:a4a:2c86:0:b0:525:2b54:d6a4 with SMTP id o128-20020a4a2c86000000b005252b54d6a4mr5858648ooo.0.1679942601498;
        Mon, 27 Mar 2023 11:43:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u63-20020a4a5742000000b0051aa196ac82sm11759997ooa.14.2023.03.27.11.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:43:21 -0700 (PDT)
Received: (nullmailer pid 250779 invoked by uid 1000);
        Mon, 27 Mar 2023 18:43:19 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Mar 2023 13:43:19 -0500
Subject: [PATCH 2/3] clk: mvebu: Use of_get_cpu_hwid() to read CPU ID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-mvebu-clk-fixes-v1-2-438de1026efd@kernel.org>
References: <20230327-mvebu-clk-fixes-v1-0-438de1026efd@kernel.org>
In-Reply-To: <20230327-mvebu-clk-fixes-v1-0-438de1026efd@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_get_cpu_hwid() rather than the open coded reading of the CPU
nodes "reg" property. The existing code is in fact wrong as the "reg"
address cells size is 2 cells for arm64. The existing code happens to
work because the DTS files are wrong as well.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Note this should be marked for stable so that if/when the DTS files are
fixed, then at least stable kernels will work. This is untested, so I
didn't mark for stable.
---
 drivers/clk/mvebu/ap-cpu-clk.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-clk.c
index 71bdd7c3ff03..d8a7a4c90d54 100644
--- a/drivers/clk/mvebu/ap-cpu-clk.c
+++ b/drivers/clk/mvebu/ap-cpu-clk.c
@@ -253,12 +253,12 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 	 */
 	nclusters = 1;
 	for_each_of_cpu_node(dn) {
-		int cpu, err;
+		u64 cpu;
 
-		err = of_property_read_u32(dn, "reg", &cpu);
-		if (WARN_ON(err)) {
+		cpu = of_get_cpu_hwid(dn, 0);
+		if (WARN_ON(cpu == OF_BAD_ADDR)) {
 			of_node_put(dn);
-			return err;
+			return -EINVAL;
 		}
 
 		/* If cpu2 or cpu3 is enabled */
@@ -288,12 +288,12 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 		struct clk_init_data init;
 		const char *parent_name;
 		struct clk *parent;
-		int cpu, err;
+		u64 cpu;
 
-		err = of_property_read_u32(dn, "reg", &cpu);
-		if (WARN_ON(err)) {
+		cpu = of_get_cpu_hwid(dn, 0);
+		if (WARN_ON(cpu == OF_BAD_ADDR)) {
 			of_node_put(dn);
-			return err;
+			return -EINVAL;
 		}
 
 		cluster_index = cpu & APN806_CLUSTER_NUM_MASK;

-- 
2.39.2

