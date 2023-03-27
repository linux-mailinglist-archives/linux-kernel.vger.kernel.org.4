Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FDB6CACB8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjC0SIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjC0SIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:08:14 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B058D2D69;
        Mon, 27 Mar 2023 11:08:02 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RB12WI019001;
        Mon, 27 Mar 2023 11:08:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=5/J+ExtaDQpQ8NP1wIMINsOViHcgzoeTRd//pn5Ikkg=;
 b=KRixRFaBvdqmjDQzFpJ+38AyqCOUJGwYEgqWzhzCumpNJfIjAv5F+XHW9ut0fC7b2kBi
 SMn7dzjex8rnJY+3T6mI9rIIbDDltMoogqVcnxOjXNFFB5XOaMM5I2vonG32OtlVWlr0
 c++RFdnKj60ULbNT+gAREHPXQLdVdVrM5bksyd9NGSicJror/JTBiWQPIhir4w47MREH
 7cLKnX9JaMGJYa11BE3nHEbT5UDCk+s7B+QwsJgrB7xJlQ3GOa93kH3QOffnac3r/hho
 zObxNtU125d+LYiqb1G5FpvRrslvGh82DCUAsk7T/r11liqVvGLiDfv7yqylmZFAuZlr dA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3phxas85t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 11:08:00 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 27 Mar
 2023 11:07:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 27 Mar 2023 11:07:58 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id C14793F7088;
        Mon, 27 Mar 2023 11:07:58 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 0/2] spi: octeontx2: Add spi driver for OcteonTX2 SOC
Date:   Mon, 27 Mar 2023 11:07:51 -0700
Message-ID: <20230327180753.2279-1-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7UMLWC3my9ApyPfHIM3LvA0wrjrEOxPM
X-Proofpoint-ORIG-GUID: 7UMLWC3my9ApyPfHIM3LvA0wrjrEOxPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for spi controller on Marvell OcteonTX2 SOC. This driver
supports 1KB data buffer and 4-bit bus width.
It also supports ACPI and reads tx(rx)-bus-width which is used to set
the SPI mode - DUAL, QUAD, OCTAL.

Piyush Malgujar (1):
  spi: octeontx2: Add ACPI support

Suneel Garapati (1):
  spi: octeontx2: Add support for octeontx2 spi controller

 drivers/spi/Kconfig         |   8 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-octeontx2.c | 467 ++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-octeontx2.h | 152 ++++++++++++
 4 files changed, 628 insertions(+)
 create mode 100644 drivers/spi/spi-octeontx2.c
 create mode 100644 drivers/spi/spi-octeontx2.h

-- 
2.17.1

