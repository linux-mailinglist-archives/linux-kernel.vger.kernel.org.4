Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0536748AD5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjGERoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGERoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:44:11 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B798E18E;
        Wed,  5 Jul 2023 10:44:10 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365F3qX0010377;
        Wed, 5 Jul 2023 19:44:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=YUgd+kLtuoT6+D/S4yEnkLsPb3DToCAxmS/mQp6zeO4=;
 b=MjoeysbdbysRFmNCxDSaMrC6hSVYitjPEn+kF9lp9LLlRKt97BaJ+/AWH2rM7weXYp5d
 lopm3QCUUl7U4/wwU3hTTYEDoZrkgyNhVcynqsff/ahfZc6E21RuPxTDjX1NtI2/XM7+
 Ygt7LbIbe40QzwJAKqRZJFRkJIJeQ5Q1aA63mopnAl1eEN1KAG/FOqBEr035v9jtUM4P
 n+cVACaL8Iq29TUgr/KpiNzCMP56G7hNKtNCEuMQZri+3Qtb4WrimCUK+09X3aOEQmm/
 GSC/8Pg17UQGzs8XC70VAPLV/Q4exR4DPW63otLEbJCaP21MBnXpI597SOplhRQnS3W2 5Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rn7wp2bsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 19:44:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D8FDE10005E;
        Wed,  5 Jul 2023 19:44:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0558252250;
        Wed,  5 Jul 2023 19:44:02 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 5 Jul
 2023 19:44:02 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <linux-rtc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2 0/7] rtc: stm32: multiple bug fixes and improvements
Date:   Wed, 5 Jul 2023 19:43:50 +0200
Message-ID: <20230705174357.353616-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_09,2023-07-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements some bug fixes for theses issues:
- typo issues
- register read sequence issue
- irq during pm callbacks issue

This series implements also some improvements:
- don't switch to INIT mode uselessly
- improve error printing during probe
- improve rtc precision on stm32mp1

Since v1:
- Exchange "fix issues of stm32_rtc_valid_alrm" and
  "fix unnecessary parentheses" patches to optimize this series.

Antonio Borneo (2):
  rtc: stm32: use the proper register sequence to read date/time
  rtc: stm32: don't stop time counter if not needed

Christophe Guibout (1):
  rtc: stm32: improve rtc precision

Gabriel Fernandez (1):
  rtc: stm32: change PM callbacks to "_noirq()"

Valentin Caron (3):
  rtc: stm32: don't print an error on probe deferral
  rtc: stm32: fix issues of stm32_rtc_valid_alrm function
  rtc: stm32: fix unnecessary parentheses

 drivers/rtc/rtc-stm32.c | 138 +++++++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 53 deletions(-)

-- 
2.25.1

