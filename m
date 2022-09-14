Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6A35B8ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiINOmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiINOl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:41:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5A25C9C7;
        Wed, 14 Sep 2022 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663166516; x=1694702516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9fFnn5TSiqBWPXmJkmIUeGCehKJxMYPcteHI9sy/mA0=;
  b=Op+LSFJQQJMF1ksYjXitXrmSkdap+y+mSTM7duGUYLOSKGZUhYpOALIi
   2d6L91LBcgNwKzgDCjsyHlvFrwISJok+7aMj09cXzvc+codnWeJNE89Em
   PaLAs/qorCO1pxXqNCKfAmjMQp3pT5FwbPsGxRxEcVJtR3AO6TS+loemj
   bpcCwVbgXpgeCqu3/B1LmqAhzqAAFzs5xMhxA8YaYNOcHndONlXTf0RBV
   CiPQHYdvhyrTnYnIEq+bqTIiLq3jx8zSftFLyx+ehTFk3XMnMEIPgRWS3
   4NgSppLYHTSK6jZocoi1jLUEhyN8MoXKdpCtTz0jh4/aqQWddMasvzd5c
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="384739190"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="384739190"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="720608026"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2022 07:41:53 -0700
From:   wen.ping.teh@intel.com
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org
Cc:     dinguyen@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Teh Wen Ping <wen.ping.teh@intel.com>
Subject: [PATCH 0/2] crypto: intel-fcs: Add crypto service driver for Intel SoCFPGA
Date:   Wed, 14 Sep 2022 22:41:37 +0800
Message-Id: <20220914144137.605279-1-wen.ping.teh@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Teh Wen Ping <wen.ping.teh@intel.com>

This patch introduces a crypto service driver for Intel SoCFPGA
family. The FPGA Crypto Service (FCS) includes a large set of security
features that are provided by the Secure Device Manager(SDM) in FPGA.
The driver provide IOCTL interface for user to call the crypto services
and send them to SDM's mailbox.

Teh Wen Ping (2):
  crypto: intel-fcs: crypto service driver for Intel SoCFPGA family
  arm64: defconfig: add CRYPTO_DEV_INTEL_FCS

 arch/arm64/configs/defconfig         |   1 +
 drivers/crypto/Kconfig               |  11 +
 drivers/crypto/Makefile              |   1 +
 drivers/crypto/intel_fcs.c           | 726 +++++++++++++++++++++++++++
 include/uapi/linux/intel_fcs-ioctl.h | 211 ++++++++
 5 files changed, 950 insertions(+)
 create mode 100644 drivers/crypto/intel_fcs.c
 create mode 100644 include/uapi/linux/intel_fcs-ioctl.h

-- 
2.25.1

