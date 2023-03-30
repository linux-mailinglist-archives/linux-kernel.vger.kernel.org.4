Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDD16CFC24
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjC3HCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjC3HCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:02:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4332855B5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680159770; x=1711695770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=emsz7RuRmLOMYEXI0fF4ScGgAtHMX/rkvAuxD3N/61I=;
  b=IjgkuAjqiWWAnwxafocUi2bdesIWMloQqAssB8xDG71LwbKqyKiOtY2E
   jtHj8XLAoTNbFGTpYZl+6UwGrvKLW9e/SUroi6Ikc9xyOF/Kx3Z8QBlfJ
   CIxhadMZG1Pov31+UKjiuUBHyKIJKCGSdrFuon/kTIMvvtIIi62sjcIDP
   2yMB1aBwXDGyldHPo4POD0Ahk/qwk0iuCR298N/vFA0LOdySpJQmdOk7P
   GiNrRgXu7NJEuk10dxSftA/G3vYoEzCQBXJeaXP0LLiH4zXNOEnOsF7tF
   CT0QJ6VgYOGbHs8zg4riLCWwZzbpsCgNJgsxeKszda005PlY5Ao4kuXoD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="329580887"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="329580887"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 00:02:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="795557898"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="795557898"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by fmsmga002.fm.intel.com with ESMTP; 30 Mar 2023 00:02:48 -0700
Received: from localhost (ppgyli0109.png.intel.com [10.126.160.114])
        by pglmail07.png.intel.com (Postfix) with ESMTP id 938D34837;
        Thu, 30 Mar 2023 15:02:47 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id 8FB5C3040; Thu, 30 Mar 2023 15:02:47 +0800 (+08)
From:   Boon Khai Ng <boon.khai.ng@intel.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Tien Sung Ang <tien.sung.ang@intel.com>,
        Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v1 0/8] drivers: net: stmicro: Add VLAN support
Date:   Thu, 30 Mar 2023 15:02:27 +0800
Message-Id: <20230330070227.27173-1-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=AC_FROM_MANY_DOTS,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The Designware 10G MAC(dwxgmac) driver has lack of vlan support in term of
hardware, such as the hardware accelerated VLAN stripping, hardware filtering
and vlan fail queue. These patches are meant to enable not only the hardware
support of VLAN features but also the promiscous mode. The driver was not draft
from scratch, however it was ported from the Ethernet Quality-of-Service (dwmac4)
driver, it was tested working on ourside.

Boon Khai Ng (8):
  drivers: net: stmmac_main: Add support for HW-accelerated VLAN
    Stripping
  drivers: net: stmmac_main: fix vlan toggle option.
  drivers: net: stmmac: Add support for HW-accelerated VLAN Stripping
  drivers: net: dwmac: Add use_hw_vlan setting
  net: stmmac: Add support for VLAN Rx filtering
  net: stmmac: Add support for VLAN promiscuous mode
  net: stmmac: Add Double VLAN handling for VLAN Rx filtering
  net: stmmac: Add option for VLAN filter fail queue enable

 drivers/net/ethernet/stmicro/stmmac/common.h  |   1 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  56 +++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 328 +++++++++++++++++-
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  15 +
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  16 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  30 +-
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  13 +
 include/linux/stmmac.h                        |   1 +
 8 files changed, 452 insertions(+), 8 deletions(-)

-- 
2.25.1

