Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F049F650D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiLSOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiLSOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:24:39 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E90AFAE1;
        Mon, 19 Dec 2022 06:24:38 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ9Q1Bv010480;
        Mon, 19 Dec 2022 06:24:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=FgZDFKQIU8xvFnnPRKl/2sY9qKhqo8ZWrrqqowliSyo=;
 b=TIIkmtpBNt/P57VBRJtsBYUmHazVr4fAF2tVH2TILsFUQ/Jm+HJJPpQ56rVZoXH6DWXD
 KXNrALzQMt3IMuN9gqsTYtU6R6yvSXI7JqPIJ16Ms7gxAMZfRC+g1sQuDK2fqSVgOruy
 QLPILuaHykJEoOgY1vaCTD0Kgl5mH2MLqYUvWSZWJdbuAK/IiF1ptknrUyQG39Rf8+SN
 1aPnsm1Jt2wdrY69ov7D2wOH1SD7uUds2EIsQZkQzAwuh0N2Uk2rlBoSymCovR3rsZeW
 ZoZ3IIY9AsNSsLFKhMnmT3x0FwoS/duByYQEUbpGxVcPO4fLGOur3i84X0h3CELqCMIk iw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mjnans1rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 06:24:27 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 06:24:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 19 Dec 2022 06:24:25 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id AC2EB3F7054;
        Mon, 19 Dec 2022 06:24:25 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 0/5] drivers: mmc: sdhci-cadence: SD6 controller support
Date:   Mon, 19 Dec 2022 06:24:13 -0800
Message-ID: <20221219142418.27949-1-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SfmXkpVmD6zDf0bfWN4Vu2MQ0-1Zkmgl
X-Proofpoint-ORIG-GUID: SfmXkpVmD6zDf0bfWN4Vu2MQ0-1Zkmgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series includes the following changes:

- Added support for SD6 controller
- Support for MMC_SDHCI_IO_ACCESSORS
- Related changes done in dt bindings
- Introduce config option for sdhci timeout
- Support for debug option

Dhananjay Kangude (1):
  drivers: mmc: sdhci-cadence: SD6 controller support

Jayanthi Annadurai (4):
  drivers: mmc: sdhci-cadence: enable MMC_SDHCI_IO_ACCESSORS
  dt-bindings: mmc: sdhci-cadence: SD6 support
  drivers: mmc: sdhci: Add option to configure sdhci timeout
  drivers: mmc: sdhci-cadence: Add debug option for sdhci-cadence
    driver.

 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |   33 +-
 drivers/mmc/host/Kconfig                      |   20 +
 drivers/mmc/host/sdhci-cadence.c              | 1665 ++++++++++++++++-
 drivers/mmc/host/sdhci.c                      |    3 +-
 4 files changed, 1619 insertions(+), 102 deletions(-)

-- 
2.17.1

