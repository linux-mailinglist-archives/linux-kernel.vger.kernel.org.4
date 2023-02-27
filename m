Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E486A3FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjB0K6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjB0K6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:15 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5E615CAB;
        Mon, 27 Feb 2023 02:58:14 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id az36so3966357wmb.1;
        Mon, 27 Feb 2023 02:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9SGqf47sYexP4KDD8i5u1pt87QH5U1h+xP3iiJeOMw=;
        b=HFIqa8q05zIgTCCwkryZi+hCLVkH/xf9Bxogc+r4MkJyv6T8wLfUNv3ZcQOMpLJEfk
         H3fi+mzu3ucuJVmW23xRnYXtVXcAScE0Lzw6lYf8SfyT4stI7Y9XSVqFV8rX3Zxg/OH8
         tdskHzTbWkd1BT5mBKyRLe7d0vrBC8JZxMvbJUzE6Hv51G/6Cq22azMocNVT/V2IL9ji
         Inr/4zvbec/ZP90nqZ3SqoTjb8nhjSpgpBwMG4m5KHCP2CS9XYWAch7Nu0wYhQT2gkH8
         La6eibI2m+HtjawvSRgMhET+dGB+UL7yx6pfsys/E2nAbGX/C7aAkQKHMHdQFcqh5XhL
         MzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9SGqf47sYexP4KDD8i5u1pt87QH5U1h+xP3iiJeOMw=;
        b=xJoquucfLW/yhdf+oz2c2Jm+TQi/3KvO+IkjvfMGJSn5jaC7fyBP4wtvpSEJsgdW0S
         VGNjiavUXWrx2VHbw6e9IZ3QCDOu9uQW3Qujl0PBxhQ783G20D0D83cCqft/IEHH6pDU
         0RIX36tHDCrFD/lfdErpO8REvIeYsO77JHjP9VmJKIrJAst5MkcHMqra+syKwcEnAuZz
         bMdFeqAsLvChv4NCaGHyY5KBLeHvCO+gcfdHajy+w33ItIm1wr3Sy/8YEmEUb8UDlEVF
         5pEda5JcKnHowuZ78aNmrIKejPqml+JHNmUlpm7a97qbJ9XPfZ7V/d9vcaR9BNidzc+g
         CpPQ==
X-Gm-Message-State: AO0yUKU6LtB25u/G6QZUcALsQQZjoKoKPIXoc+jZmJCm/oexJ7rkEhCR
        JWl5W5vUi5AsAlpgt0bmoyxE+aIxSuQ=
X-Google-Smtp-Source: AK7set+oYRbWSTwvKo+nrUvfnVrD0G8X4blNmedmw1BBYNPEMarlzxAVjFSjnPMIQAMaBbwdWyAZSg==
X-Received: by 2002:a05:600c:44d3:b0:3da:fc30:bfc5 with SMTP id f19-20020a05600c44d300b003dafc30bfc5mr17749497wmo.13.1677495493031;
        Mon, 27 Feb 2023 02:58:13 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:12 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 05/12]  mips: ralink: rt3883: soc queries and tests as functions
Date:   Mon, 27 Feb 2023 11:57:59 +0100
Message-Id: <20230227105806.2394101-6-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230227105806.2394101-1-sergio.paracuellos@gmail.com>
References: <20230227105806.2394101-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Move the SoC register value queries and tests to specific functions,
 to remove repetition of logic. No functional changes intended

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/rt3883.c | 64 +++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index fa215c07558d..6f8541a4bc8e 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -70,29 +70,61 @@ void __init ralink_of_remap(void)
 		panic("Failed to remap core resources");
 }
 
-void __init prom_soc_init(struct ralink_soc_info *soc_info)
+static unsigned int __init rt3883_get_soc_name0(void)
+{
+	return __raw_readl(RT3883_SYSC_BASE + RT3883_SYSC_REG_CHIPID0_3);
+}
+
+static unsigned int __init rt3883_get_soc_name1(void)
+{
+	return __raw_readl(RT3883_SYSC_BASE + RT3883_SYSC_REG_CHIPID4_7);
+}
+
+static bool __init rt3883_soc_valid(void)
+{
+	if (rt3883_get_soc_name0() == RT3883_CHIP_NAME0 &&
+	    rt3883_get_soc_name1() == RT3883_CHIP_NAME1)
+		return true;
+	else
+		return false;
+}
+
+static const char __init *rt3883_get_soc_name(void)
+{
+	if (rt3883_soc_valid())
+		return "RT3883";
+	else
+		return "invalid";
+}
+
+static unsigned int __init rt3883_get_soc_id(void)
 {
-	const char *name;
-	u32 n0;
-	u32 n1;
-	u32 id;
+	return __raw_readl(RT3883_SYSC_BASE + RT3883_SYSC_REG_REVID);
+}
 
-	n0 = __raw_readl(RT3883_SYSC_BASE + RT3883_SYSC_REG_CHIPID0_3);
-	n1 = __raw_readl(RT3883_SYSC_BASE + RT3883_SYSC_REG_CHIPID4_7);
-	id = __raw_readl(RT3883_SYSC_BASE + RT3883_SYSC_REG_REVID);
+static unsigned int __init rt3883_get_soc_ver(void)
+{
+	return (rt3883_get_soc_id() >> RT3883_REVID_VER_ID_SHIFT) & RT3883_REVID_VER_ID_MASK;
+}
 
-	if (n0 == RT3883_CHIP_NAME0 && n1 == RT3883_CHIP_NAME1) {
+static unsigned int __init rt3883_get_soc_rev(void)
+{
+	return (rt3883_get_soc_id() & RT3883_REVID_ECO_ID_MASK);
+}
+
+void __init prom_soc_init(struct ralink_soc_info *soc_info)
+{
+	if (rt3883_soc_valid())
 		soc_info->compatible = "ralink,rt3883-soc";
-		name = "RT3883";
-	} else {
-		panic("rt3883: unknown SoC, n0:%08x n1:%08x", n0, n1);
-	}
+	else
+		panic("rt3883: unknown SoC, n0:%08x n1:%08x",
+		      rt3883_get_soc_name0(), rt3883_get_soc_name1());
 
 	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
 		"Ralink %s ver:%u eco:%u",
-		name,
-		(id >> RT3883_REVID_VER_ID_SHIFT) & RT3883_REVID_VER_ID_MASK,
-		(id & RT3883_REVID_ECO_ID_MASK));
+		rt3883_get_soc_name(),
+		rt3883_get_soc_ver(),
+		rt3883_get_soc_rev());
 
 	soc_info->mem_base = RT3883_SDRAM_BASE;
 	soc_info->mem_size_min = RT3883_MEM_SIZE_MIN;
-- 
2.25.1

