Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424B272A1E5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjFISO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjFISO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:14:26 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499513586;
        Fri,  9 Jun 2023 11:14:25 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-77a1cad6532so91157539f.1;
        Fri, 09 Jun 2023 11:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334464; x=1688926464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+YPUEMI65QN7DU7S8/VjzArfzenyEsCNlHNh4xFonc=;
        b=WCuHvgcB1pGjMUMc/tgd5no+qzpJuonJwDhaQtwmtzTbDxOOWoclq1IRawh19h6wQC
         qxBfyPwgWwace9UsPicPc5Hz5oOtEMlots3NiiTZ2UmkrAcK6WLAK26DYznzAbdvwiCV
         DhSy2Ru9pUkS6C9BM4EH5t+KoqT1A4eEEm1x06qhjQu/6SMhs15KlR+5RsFgRm1ArokZ
         VQY6PVZEubH1dXNUdnHAONgIuX2/1IzAP8iOnFfAm+iK0AHM34dZKTE3RkjoXgN0K9EX
         SwFNfYMPJuHyzeX+WRKmYNFOanaRQsHQEfex5pWCY2Dn6YlDUnrrb6MkJUjNPcZ7h2NF
         +iLg==
X-Gm-Message-State: AC+VfDxZC3Z/egnJm/TEvOrhZzsQhV2/30d4fSwIwmQc09vHf/nhaFe6
        bjOP8ccbrN/q71G9g0QNgA==
X-Google-Smtp-Source: ACHHUZ4C+IBXDQp4zLtR7Kw9J1XTAY9/7wVyOEfDxyKbxhtoAD7TsbOxGxnTy5ECj4+2dLIaDXCTig==
X-Received: by 2002:a05:6602:184b:b0:76c:898c:9b10 with SMTP id d11-20020a056602184b00b0076c898c9b10mr2485982ioi.0.1686334464556;
        Fri, 09 Jun 2023 11:14:24 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x5-20020a6bda05000000b0077024f8772esm1216735iob.51.2023.06.09.11.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:14:23 -0700 (PDT)
Received: (nullmailer pid 1681131 invoked by uid 1000);
        Fri, 09 Jun 2023 18:14:15 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 09 Jun 2023 12:13:46 -0600
Subject: [PATCH v2 2/4] clk: mvebu: Use of_get_cpu_hwid() to read CPU ID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-mvebu-clk-fixes-v2-2-8333729ee45d@kernel.org>
References: <20230327-mvebu-clk-fixes-v2-0-8333729ee45d@kernel.org>
In-Reply-To: <20230327-mvebu-clk-fixes-v2-0-8333729ee45d@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
X-Mailer: b4 0.13-dev
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

Use of_get_cpu_hwid() rather than the open coded reading of the CPU
nodes "reg" property. The existing code is in fact wrong as the "reg"
address cells size is 2 cells for arm64. The existing code happens to
work because the DTS files are wrong as well.

Signed-off-by: Rob Herring <robh@kernel.org>
---
If the DTS files are fixed, then they will not work with the
existing code. This change should work for both existing and fixed DTS
files.

Therefore, this should be marked for stable so that if/when the DTS
files are fixed, then at least stable kernels will work. This is
untested, so I didn't mark for stable.
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

