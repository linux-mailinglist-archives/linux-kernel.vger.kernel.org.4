Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A675B54C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiILGvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiILGut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:50:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BEB2981E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:50:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x1so7683564plv.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=viUsGW+Zs7kQMJlix4q594CqGsU1OFW3HynVNHA2iG8=;
        b=QkvhKH79pmOL280s8O7XavIGY1hLPyLs7ET4C+xdDdkmp4TWr30f63pv7sXWsYeZAx
         pHcgKhkvNYwrrowng3fX7v+AX7LTGHyxr7d/E8RzFhnMJ2QaMhf3un34DFtxqfxEbw6T
         alKw1AueifAPAfnWXJj1JEeEWegHWkkPBH0aZDqw0TEMZ/daWDxKIyyxcb/0JQH7X82+
         laW34CF1YnFnmnuFcenHABv3GmSSsdxZdlJwLdQjTV5oih0wcQVYGyOb7pG7IRirfu5s
         XZf+P0TViMPLGFznKdEs5pj22lDfusMvl8pvt5Q7HxDzXhkIKP8LuSqU+l+3AZMY9Opt
         pzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=viUsGW+Zs7kQMJlix4q594CqGsU1OFW3HynVNHA2iG8=;
        b=UqNLaxpfY0DAAe1YYfSiM/zY54+SUPdZV4xuVr/OCvlh5emdgAx1PzPYHD5LqicL7Q
         EOgYVqMYT3liTZQqZs/U1ZX4WuL7oPCkklOYUFn4nqvanh4MKPbbZRhgHXAthulb2+1N
         u9huG2WU3EJZSD/WjkWXx3aj1HjOx0f+GqmX0Pk9jQMzs1CWDiLOafIESnBtrUfZw4ok
         Tcm5+DZLAj0rHlGnM6+1Ex3V97QlY1LYAPFbMiczObZv1PLh05+Npy+LknomBbwJX531
         vCFzAhAgtI2b7hhLeyl3GoVb4X7XdWSJznkVVcVnvBSHLAGoVa9K0UPuhHOip2As0PAy
         iz1A==
X-Gm-Message-State: ACgBeo20K8B+zytUXSQ23cxS3zlBf6DVakzwgAPa6AGfpDmMtSI5tr6D
        QmsYxZu62nEk9P/jAp3nDHWZCw==
X-Google-Smtp-Source: AA6agR46FsyQUdbhDGQHngJT9dV9LnmotVWxOwBLq7pmBmPETeK9eID1xeX1tu1pGs25qA6nPZf7aQ==
X-Received: by 2002:a17:90a:d149:b0:1fb:6dfb:1fb8 with SMTP id t9-20020a17090ad14900b001fb6dfb1fb8mr21732578pjw.25.1662965445303;
        Sun, 11 Sep 2022 23:50:45 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id v62-20020a632f41000000b00430c6fd7ffbsm4705716pgv.84.2022.09.11.23.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:50:44 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 3/6] soc: sifive: ccache: determine the cache level from dts
Date:   Mon, 12 Sep 2022 06:50:26 +0000
Message-Id: <20220912065029.1793-4-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220912065029.1793-1-zong.li@sifive.com>
References: <20220912065029.1793-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Composable cache could be L2 or L3 cache, use 'cache-level' property of
device node to determine the level.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/sifive/sifive_ccache.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/sifive_ccache.c
index 949b824e89ad..b361b661ea09 100644
--- a/drivers/soc/sifive/sifive_ccache.c
+++ b/drivers/soc/sifive/sifive_ccache.c
@@ -38,6 +38,7 @@
 static void __iomem *ccache_base;
 static int g_irq[SIFIVE_CCACHE_MAX_ECCINTR];
 static struct riscv_cacheinfo_ops ccache_cache_ops;
+static int level;
 
 enum {
 	DIR_CORR = 0,
@@ -144,7 +145,7 @@ static const struct attribute_group *ccache_get_priv_group(struct cacheinfo
 							   *this_leaf)
 {
 	/* We want to use private group for composable cache only */
-	if (this_leaf->level == 2)
+	if (this_leaf->level == level)
 		return &priv_attr_group;
 	else
 		return NULL;
@@ -215,6 +216,9 @@ static int __init sifive_ccache_init(void)
 	if (!ccache_base)
 		return -ENOMEM;
 
+	if (of_property_read_u32(np, "cache-level", &level))
+		return -ENOENT;
+
 	intr_num = of_property_count_u32_elems(np, "interrupts");
 	if (!intr_num) {
 		pr_err("CCACHE: no interrupts property\n");
-- 
2.17.1

