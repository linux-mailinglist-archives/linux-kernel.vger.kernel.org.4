Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77486E1E99
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDNInU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDNInM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:43:12 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ABD9018;
        Fri, 14 Apr 2023 01:43:01 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E7B4a4006632;
        Fri, 14 Apr 2023 10:42:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Qh0Bx0bb6Jevn+iLcjfHaGHVNgPeFj4xBdJEnAjLXeM=;
 b=wEpgyzfxwFLBaHvyxSGfLbchtuzuwn8SnU7uZYNl13pEvfPl0ev7FPdYKfC30QSStreg
 9y7Vp5lXyL49NrBWjmp2EeuTUzDJPsc2mpG43+F5BJg47V+dcpkl09R8JOLurgunHKYM
 /wCwJVzsPoYyn5evJzcZrP1i9TwQjm6/eLtqC17WF9FykwMVTmAVYj+T6QUPgAzq1bBK
 HcxQ9tjOFxXrTVQVYO8IyBGq/tnhUue/o3Tcql6Gtl5KjgHJIkk5zXUypXzD4b8gacQs
 R3SHyjTyUPmV/ZYEVOjX0pxZMMZm8PxMnsAk/vwcfMUwJmGGbPnw2/1KZO8+DG63EygL MQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pwsgpq3q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 10:42:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B751010002A;
        Fri, 14 Apr 2023 10:42:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A1D8520BE6D;
        Fri, 14 Apr 2023 10:42:10 +0200 (CEST)
Received: from localhost (10.252.1.127) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 14 Apr
 2023 10:42:08 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 0/4] usb: dwc2: add optional clock used on stm32mp15
Date:   Fri, 14 Apr 2023 10:41:33 +0200
Message-ID: <20230414084137.1050487-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.1.127]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_03,2023-04-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces an optional utmi clock that is used on stm32mp15,
in particular when using integrated full-speed PHY, managed by GGPIO
register.
A pre-cursor change improves error handling in the platform code.
---
Changes in v2:
- "utmi_clk" renamed "utmi" as per Krzysztof comment on dt-bindings

Fabrice Gasnier (4):
  usb: dwc2: improve error handling in __dwc2_lowlevel_hw_enable
  dt-bindings: usb: dwc2: add utmi optional clock
  usb: dwc2: platform: add support for utmi optional clock
  ARM: dts: stm32: add USB OTG UTMI clock on stm32mp151

 .../devicetree/bindings/usb/dwc2.yaml         |  5 ++-
 arch/arm/boot/dts/stm32mp151.dtsi             |  4 +-
 drivers/usb/dwc2/core.h                       |  2 +
 drivers/usb/dwc2/platform.c                   | 37 ++++++++++++++++++-
 4 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.25.1

