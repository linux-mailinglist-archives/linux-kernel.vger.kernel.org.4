Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA974F03A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjGKNdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGKNdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:33:36 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F253E74;
        Tue, 11 Jul 2023 06:33:35 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BCDhnh007024;
        Tue, 11 Jul 2023 14:33:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=SKaScz94yf4PfXG20hUmoKKPt3qD8ElC55nnnr/MTkY=;
 b=LNVkDtI3EIJwv8+VZU80lUHnFhI31zqpX7xvuKRZnytL+wMxW6ZUOI0OeZAXywrdhMJK
 S6OAGSCZKwgocFD2oTtbCwzvNb/fOxvseubteqNQe3AuW53x3amkPlivrhJnttniyssL
 d9J3JCc2GVHxiVbjMqvRWBHwPoMM/X/BrGFd9+k3rWRw8Y6fWmNvdii3TSKcU6XjkkZx
 GMCtcoHDqFP1V0DnjzLRfLtUnp5+bvRJQFk8+jqYefS7cTTG0rZbZuWfuA6RgtSbx1Vi
 C+TNfEAAHJfO6E9Qa9HsUFvPaqVTSvcZyTEnftz26T8/BoAjF6EZDq95835zanc8z/MI lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rs6wb8401-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 14:33:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 07BD5100058;
        Tue, 11 Jul 2023 14:33:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 83998222CB6;
        Tue, 11 Jul 2023 14:33:08 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 11 Jul
 2023 14:33:08 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <alain.volmat@foss.st.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] media: stm32: correct s_stream calls in dcmi & st-mipid02
Date:   Tue, 11 Jul 2023 14:32:08 +0200
Message-ID: <20230711123211.794838-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_06,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the stm32 dcmi driver is calling s_stream to all subdevs until
reaching the sensor subdev.  This serie corrects this by having a subdev
only calling s_stream on its source subdev.

Alain Volmat (2):
  media: i2c: st_mipid02: cascade s_stream call to the source subdev
  media: stm32: dcmi: only call s_stream on the source subdev

 drivers/media/i2c/st-mipid02.c               | 11 ++++
 drivers/media/platform/st/stm32/stm32-dcmi.c | 63 +++++---------------
 2 files changed, 25 insertions(+), 49 deletions(-)

-- 
2.25.1

