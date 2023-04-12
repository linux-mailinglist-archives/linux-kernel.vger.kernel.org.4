Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6A76DF9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjDLPTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjDLPTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:19:11 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3492C4202;
        Wed, 12 Apr 2023 08:19:06 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CCPPG2006667;
        Wed, 12 Apr 2023 17:18:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=PX57JNcwvp07eFhn2E9eab0nHyYZ1zoB73DVeo39Wco=;
 b=6kI8daGNHE5u1uhKBja5dnhTUWFUkF+zO94YG4KZaPqIZNFTJq1hKHlF+ZHb3nwqfzge
 n9wZ9LGbwMwx9K9fegjfhL2IeeVrGEeITlPaoZ+z0lY9FhqyfDassAx4YZGzCDgck9tz
 7MK4NWIbT66CAmS3kUHHUYKun42IjUKLaZ1C+fW9EffbA5yGsGHVQkJoUJACC+XJM19I
 qBu724jm4MPst/c7/nxt08eZMQZbcAt9hLBeWL2F8Xt47uhKFSdD6lqG/8LjL7/ZGE3l
 qIddrLOALxSPp2VQQE5DNzdwJYnKgymRQ+gcTRf57dr/jUFs9+CIVJfhfWgdksD6Qegb 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pwsgpak2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 17:18:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B8F03100034;
        Wed, 12 Apr 2023 17:18:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B1662218612;
        Wed, 12 Apr 2023 17:18:37 +0200 (CEST)
Received: from localhost (10.48.1.102) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 12 Apr
 2023 17:18:37 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH 0/4] usb: dwc2: add optional clock used on stm32mp15
Date:   Wed, 12 Apr 2023 17:18:27 +0200
Message-ID: <20230412151831.3069211-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_07,2023-04-12_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces an optional utmi clock that is used on stm32mp15,
in particular when using integrated full-speed PHY, managed by GGPIO
register.
A pre-cursor change improves error handling in the platform code.

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

