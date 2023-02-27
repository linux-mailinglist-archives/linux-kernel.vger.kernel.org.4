Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66936A3FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjB0K6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjB0K6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:58:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7881BDE7;
        Mon, 27 Feb 2023 02:58:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bt28so5724382wrb.8;
        Mon, 27 Feb 2023 02:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyFswsU5blBWB3R8zkCeMIKub72woh5mwnj70Smv9S8=;
        b=WrKoEYCRoiuoijz+5EgwT0GCDCgA7OStrdV3smFUHQPZHv89J9KydYSzFCcjbWc3ST
         rWKZNxQ9M8HXJ/7V4vjSou7rLCtQB3oK+u+I+Eszd4VmqmpfrmIMYnYe0Y5VZOP5sPqS
         N/m774P7238e0xWhOp7Oys5nMIc3HGnCla9xlYT2MDb0NFcfEWApHmLF7knEPSmizOtO
         BFd9KoeDqhFkzWmNmlEKvpWr82nbI+5RhDPGvaTm+/O9qA4j06K+GQ6YkP3ulflPART/
         p+MNtPZt6cH70sca6IszV+jkXWftMpacM15tQSW/S6sSODBevCcBnQ1B9jqlxW6srYrD
         TFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyFswsU5blBWB3R8zkCeMIKub72woh5mwnj70Smv9S8=;
        b=vfnNAfpHhbkp87viNB8GPAerV3nYV1Evt2QcLo4bVdPaCUoDMg7OkvjMyTF/xn1aRv
         Pmq8d/TDPD+/1X9bOK/12gAJvSXBEjDY5XFHC3EKS51QaG91zSsbdTpPFU3vt29Xccp2
         Kmk94Eru44Uz1JCaYdWXHTWZ7fNYliaAEhPyrD4Zb/kDXur9MpzeLwWnRbcaWgrWDY0L
         4/d1Rh6e/+qHT1Gvksv2vDG2gepZBAomH2SSssbDzuyyVWugJj5PYJ5YXPF0CTesVSCu
         aW+RK+iTzXRBgoyhsxnFO5f8jONjVC1wSwuyPb/BVJCl/mv9Q75Sp9Go3VRdTTODm2GG
         GYbg==
X-Gm-Message-State: AO0yUKUOGAjMyWjLcxbD5qO6cKFn0tHbBeEtn7zB4rkdEd4c29kdAia2
        pE2GTOejlmxUhaIhdRoJo4dEmUWMseg=
X-Google-Smtp-Source: AK7set8W+WXc2c87wsDTU/HXsC15zg5hCg8ENARRT4BNpGiiUHo3pe+POJV3qnHoycIS8E2ogV0srQ==
X-Received: by 2002:adf:dd4e:0:b0:2c7:148c:b054 with SMTP id u14-20020adfdd4e000000b002c7148cb054mr12471021wrm.29.1677495495851;
        Mon, 27 Feb 2023 02:58:15 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6806122wrv.10.2023.02.27.02.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 02:58:15 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: [PATCH 08/12]  mips: ralink: rt288x: soc queries and tests as functions
Date:   Mon, 27 Feb 2023 11:58:02 +0100
Message-Id: <20230227105806.2394101-9-sergio.paracuellos@gmail.com>
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
 arch/mips/ralink/rt288x.c | 63 +++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 12f339138c4c..a417b8b89b94 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -57,29 +57,60 @@ void __init ralink_of_remap(void)
 		panic("Failed to remap core resources");
 }
 
-void __init prom_soc_init(struct ralink_soc_info *soc_info)
+static unsigned int __init rt2880_get_soc_name0(void)
 {
-	const char *name;
-	u32 n0;
-	u32 n1;
-	u32 id;
+	return __raw_readl(RT2880_SYSC_BASE + SYSC_REG_CHIP_NAME0);
+}
 
-	n0 = __raw_readl(RT2880_SYSC_BASE + SYSC_REG_CHIP_NAME0);
-	n1 = __raw_readl(RT2880_SYSC_BASE + SYSC_REG_CHIP_NAME1);
-	id = __raw_readl(RT2880_SYSC_BASE + SYSC_REG_CHIP_ID);
+static unsigned int __init rt2880_get_soc_name1(void)
+{
+	return __raw_readl(RT2880_SYSC_BASE + SYSC_REG_CHIP_NAME1);
+}
 
-	if (n0 == RT2880_CHIP_NAME0 && n1 == RT2880_CHIP_NAME1) {
+static bool __init rt2880_soc_valid(void)
+{
+	if (rt2880_get_soc_name0() == RT2880_CHIP_NAME0 &&
+	    rt2880_get_soc_name1() == RT2880_CHIP_NAME1)
+		return true;
+	else
+		return false;
+}
+
+static const char __init *rt2880_get_soc_name(void)
+{
+	if (rt2880_soc_valid())
+		return "RT2880";
+	else
+		return "invalid";
+}
+
+static unsigned int __init rt2880_get_soc_id(void)
+{
+	return __raw_readl(RT2880_SYSC_BASE + SYSC_REG_CHIP_ID);
+}
+
+static unsigned int __init rt2880_get_soc_ver(void)
+{
+	return (rt2880_get_soc_id() >> CHIP_ID_ID_SHIFT) & CHIP_ID_ID_MASK;
+}
+
+static unsigned int __init rt2880_get_soc_rev(void)
+{
+	return (rt2880_get_soc_id() & CHIP_ID_REV_MASK);
+}
+void __init prom_soc_init(struct ralink_soc_info *soc_info)
+{
+	if (rt2880_soc_valid())
 		soc_info->compatible = "ralink,r2880-soc";
-		name = "RT2880";
-	} else {
-		panic("rt288x: unknown SoC, n0:%08x n1:%08x", n0, n1);
-	}
+	else
+		panic("rt288x: unknown SoC, n0:%08x n1:%08x",
+		      rt2880_get_soc_name0(), rt2880_get_soc_name1());
 
 	snprintf(soc_info->sys_type, RAMIPS_SYS_TYPE_LEN,
 		"Ralink %s id:%u rev:%u",
-		name,
-		(id >> CHIP_ID_ID_SHIFT) & CHIP_ID_ID_MASK,
-		(id & CHIP_ID_REV_MASK));
+		rt2880_get_soc_name(),
+		rt2880_get_soc_ver(),
+		rt2880_get_soc_rev());
 
 	soc_info->mem_base = RT2880_SDRAM_BASE;
 	soc_info->mem_size_min = RT2880_MEM_SIZE_MIN;
-- 
2.25.1

