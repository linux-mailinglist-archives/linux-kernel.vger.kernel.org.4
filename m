Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABAA6A49C4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjB0ScQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjB0ScO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:32:14 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D32128E;
        Mon, 27 Feb 2023 10:32:12 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R9tVQm013708;
        Mon, 27 Feb 2023 10:32:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=bs6HtfivYcfDfYf+aM4nf9Z30SsUvpyNNdqsmXdmkpo=;
 b=LafiWXkImykNW9xH0L7FnLppzKEWTwekAzcQRvp/+K/rWgCK5anaVwaGtl89CKfx2r2v
 IydvYFP9C8HCQKMaDfFUVgifl6tlMwm6gRZcDUlstPw4uv1ZdQnOkmIPgTENKpiRLKZQ
 vAMHxw2Y7aFvqWclBIXiDgyBFVESz74g4if5s2cC/+5U+xP/5BweRd2P1eXIbU7/FfTb
 COKYSmTRz/N+rnoDDKV788cFIAr50U5/nzi9suLSMN0dCBEoY9TVHOEOtrLAFMxUiff3
 PUckyhL5UwWI8kbbSPWGyS5167bNgms7zMSSZFoYA+Bi7Yx25z7XlDIeqVb8dEXmQmLJ Tw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nyjqtsbjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:32:02 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 10:32:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 27 Feb 2023 10:32:00 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 686893F7058;
        Mon, 27 Feb 2023 10:32:00 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v3 0/6] mmc: sdhci-cadence: SD6 controller support
Date:   Mon, 27 Feb 2023 10:31:45 -0800
Message-ID: <20230227183151.27912-1-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jDK4LiLnitJuR7NVsvU-Y5Vyr4RRqZPa
X-Proofpoint-GUID: jDK4LiLnitJuR7NVsvU-Y5Vyr4RRqZPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_15,2023-02-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added changes to support SD6 controller
- Restructure and reformat the code.
- Add SD6 related operations.
- Support added for MMC_SDHCI_IO_ACCESSORS.
- Related changes done in dt bindings.
- Support for debug option.

Changes since V2:
- Added separate patches for renaming of functions and 
  restructuring, adding new structures to support SD4/SD6 operations.
- Added proper suffixes to properties in dt binding.
- Removed unreachable code.
- Handled sdhci_cdns_uniphier_pltfm_data similar to sdhci_cdns_sd4_of_data
  as per the added structured design.
- Used dev_dbg instead of DEBUG_DRV in debug patch.

Changes since V1:
- Added separate patch for reformat/rename changes.
- Enabled MMC_SDHCI_IO_ACCESSORS in config MMC_SDHCI_CADENCE.
- Used proper properties in dt binding.
- Removed patch of config option to change default for sdhci timeout.
- Resolved issues reported by:
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>

Dhananjay Kangude (3):
  mmc: sdhci-cadence: Rename functions to SD4 specific
  mmc: sdhci-cadence: Restructure the code
  mmc: sdhci-cadence: SD6 controller support

Jayanthi Annadurai (3):
  mmc: sdhci-cadence: enable MMC_SDHCI_IO_ACCESSORS
  dt-bindings: mmc: sdhci-cadence: SD6 support
  mmc: sdhci-cadence: Add debug option for sdhci-cadence driver

 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |   24 +-
 drivers/mmc/host/Kconfig                      |    1 +
 drivers/mmc/host/sdhci-cadence.c              | 1651 ++++++++++++++++-
 3 files changed, 1612 insertions(+), 64 deletions(-)

-- 
2.17.1

