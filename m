Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CCA650DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiLSOnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiLSOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:43:19 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F41625A;
        Mon, 19 Dec 2022 06:43:18 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJ9PqqA009699;
        Mon, 19 Dec 2022 06:43:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=JBiteCgpAS6oWGr9gYaWKAYcs1Cv01mxzPzcSuz3Aac=;
 b=eP0WvFyTLRGdOhKtbZ4+ydFy5jkFGrXJKF5tRUWNCaa6dbdnZWyymNN4jDyEkwKGjmQS
 F3pI5BVSl5S6f21gnZ7yjNRhyASjy1CQ0oGqsGRF8hV0/L0UPeq8gAnT4S9fvazQVuZG
 Y2MgK67S+pEVz1S1tvKR7M7MJmN6ydrUdI6VgpSaau892BMIUQJ55raX/MZ6nxvAVhZg
 G1m5rutZhU0FD5H21weC2gpdPqmgU8pmC3aa+YGLnb2+XUiUf3OWjF+lHt0O/PP+MFwk
 FKUjatv52VdILIVRa3q6nJcApB5R4AN4ok0cGH2s57UaalFbO1UUPIG4uD47vuQr4CIb 2Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mjnans4hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 06:43:11 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 06:43:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 19 Dec 2022 06:43:09 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 72CED3F7041;
        Mon, 19 Dec 2022 06:43:09 -0800 (PST)
From:   Witold Sadowski <wsadowski@marvell.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <pthombar@cadence.com>, <konrad@cadence.com>,
        <wbartczak@marvell.com>, <wzmuda@marvell.com>,
        <wsadowski@marvell.com>
Subject: [PATCH 0/7] Support for Marvell modifications for Cadence XSPI
Date:   Mon, 19 Dec 2022 06:42:47 -0800
Message-ID: <20221219144254.20883-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Uu2IyJR_vA2SzfbbWvO1MZkh-Nfoofzl
X-Proofpoint-ORIG-GUID: Uu2IyJR_vA2SzfbbWvO1MZkh-Nfoofzl
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

This patch series is fixing bugs, and adding support for
Marvell changes for Cadence XSPI IP.
It includes:
- Polling mode support
- Changes for modebyte handling
- Busycycles calculations
- Marvell specific IP changes

Witold Sadowski (7):
  spi: cadence: Fix busy cycles calculation
  spi: cadence: Change dt-bindings documentation for Cadence XSPI
    controller
  spi: cadence: Add polling mode support
  spi: cadence: Change dt-bindings documentation for Cadence XSPI
    controller
  spi: cadence: Add read access size switch
  spi: cadence: Add Marvell IP modification changes
  spi: cadence: Force single modebyte

 .../devicetree/bindings/spi/cdns,xspi.yaml    |   6 +-
 drivers/spi/Kconfig                           |  12 +
 drivers/spi/spi-cadence-xspi.c                | 360 ++++++++++++++++--
 3 files changed, 354 insertions(+), 24 deletions(-)

-- 
2.17.1

