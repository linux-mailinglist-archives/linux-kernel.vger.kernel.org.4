Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAC76072B6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiJUIpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJUIpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:45:19 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C155A168;
        Fri, 21 Oct 2022 01:45:14 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L6HQFj014461;
        Fri, 21 Oct 2022 10:44:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=nN+eZrxubuUpxtvA/HEiuz0ghp0wsel2bTnX1jUh+Mg=;
 b=rpnShfZowOwph9MLX1pAC7sSejMuGfhtta50et9sEhcUX1Uv1XsSenHCPriiu0ngpN+5
 r5EnoQjrK39JkeYHlBAYryo5JDXmdYDlUF+TBlSaPHgbi9edz1wgofhac4v2WMAo36op
 MLiRfJ0H/MpVfM+h2mm5WUOdSOxO+1WEMirBz50ZrmekMHicvo+sj+u0071tqZtMEHHI
 5P1QOaICAqqBXbvLHgGNqSwZzFrKySbnITdL+68wfeBOaAB1Nl/ll0ymy3iiJDVk7SjC
 G9FKSiI0wPe/9s9IcwhOsgckwbdqBZl1qe14SC0JWPWpO8sXxgGhPl3BT/t0rpILJHrG kQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k9tfpy660-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 10:44:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 34DB7100034;
        Fri, 21 Oct 2022 10:44:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1EC5F21B525;
        Fri, 21 Oct 2022 10:44:48 +0200 (CEST)
Received: from localhost (10.201.21.93) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:44:47 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@foss.st.com>
Subject: [PATCH] scripts: dtc: only show unique unit address warning for enabled nodes
Date:   Fri, 21 Oct 2022 10:44:47 +0200
Message-ID: <20221021084447.5550-1-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_03,2022-10-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases an hardware peripheral can be used for two exclusive usages.
For example, on STM32MP15 we have the same peripheral for I2S and SPI. We
have dedicated driver for each usage and so a dedicated device node in
devicetree.
To avoid to get useless warnings running "make W=1 dtbs", this patch adds
the "-Wunique_unit_address_if_enabled" flag for a make with W=1. In this
case we will detect a duplicate address only if both devices are
enabled in the devicetree, which is a real error case.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3aa384cec76b..6f077200b967 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -344,6 +344,9 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-graph_child_address \
 	-Wno-simple_bus_reg \
 	-Wno-unique_unit_address
+else
+DTC_FLAGS += -Wno-unique_unit_address \
+        -Wunique_unit_address_if_enabled
 endif
 
 ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
-- 
2.17.1

