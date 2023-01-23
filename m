Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7DA678648
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjAWT2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjAWT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:27:59 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EE3A241;
        Mon, 23 Jan 2023 11:27:58 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NG93M1006200;
        Mon, 23 Jan 2023 11:27:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=aCRdwEfHlocYIHEg308z173gAgMrqI1AZ075iLLPyJ8=;
 b=gXfJInI2ZtZyH1HQdbEsQa5Hj1wkeERp1p2oViToVMq7h40YncEUeo1x+LsPKBb386WI
 6+XHXYqo7sl56q+4J2ysx0GcpFeI/wi6Vrcq/Bq8OiNdhyk2IYX6JfYYj+ieNYBU7XEB
 9HZaBhJIaFIBcYB6KNLk+TESxelYGV/AeAXBj+BkgTZZLPcLqgmxr9V0O4Y+aHp2nC+G
 56+LukYA43j5p3Tox1Z2h68OsiZDla5cqUv7DEfx/SIJDonuDjV7lT3n+bqYDwgyIbB/
 g9UmzfzyevJzp21CZ82hytYmO7TDO3qgvGbCDf0bLGW6wqXpvME+dgbdskNll0IUnLvE dA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3n8gerbe6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 11:27:42 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 23 Jan
 2023 11:27:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 23 Jan 2023 11:27:40 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 8FE7F3F7050;
        Mon, 23 Jan 2023 11:27:40 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v2 0/5] drivers: mmc: sdhci-cadence: SD6 controller support
Date:   Mon, 23 Jan 2023 11:27:30 -0800
Message-ID: <20230123192735.21136-1-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kZaagjSbQyx2anzdUtR0mK6RlRRoY8Bv
X-Proofpoint-ORIG-GUID: kZaagjSbQyx2anzdUtR0mK6RlRRoY8Bv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added changes to support SD6 controller
- Reformat and separate out changes of SD4/SD6.
- Support added for MMC_SDHCI_IO_ACCESSORS.
- Related changes done in dt bindings.
- Support for debug option.

Changes since V1:
- Added separate patch for reformat/rename changes.
- Enabled MMC_SDHCI_IO_ACCESSORS in config MMC_SDHCI_CADENCE.
- Used proper properties in dt binding.
- Removed patch of config option to change default for sdhci timeout.
- Resolved issues reported by:
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>

Dhananjay Kangude (2):
  drivers: mmc: sdhci-cadence: Reformat the code
  drivers: mmc: sdhci-cadence: SD6 controller support

Jayanthi Annadurai (3):
  drivers: mmc: sdhci-cadence: enable MMC_SDHCI_IO_ACCESSORS
  dt-bindings: mmc: sdhci-cadence: SD6 support
  drivers: mmc: sdhci-cadence: Add debug option for sdhci-cadence
    driver.

 .../devicetree/bindings/mmc/cdns,sdhci.yaml   |   34 +-
 drivers/mmc/host/Kconfig                      |    1 +
 drivers/mmc/host/sdhci-cadence.c              | 1669 ++++++++++++++++-
 3 files changed, 1603 insertions(+), 101 deletions(-)

-- 
2.17.1

