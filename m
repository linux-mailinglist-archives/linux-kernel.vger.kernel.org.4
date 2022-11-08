Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040F562103E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiKHMUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiKHMUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:20:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDFE2339E;
        Tue,  8 Nov 2022 04:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667910005; x=1699446005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8hUlbs0/W+4ojg69yIxFxx8Q+BRRsHAxyz+t3mWTkFM=;
  b=mP7NGAFmsB/rt1gDZw5yfnuoNevtn5trk7kW+74FIsT6etXSxplqQNA4
   TGCPCvfznQzvRsIEbMuhDGMKVQmzTFf+pRPc43OP9eDbv5XGabPg/YdBH
   TIYWbZUvNHrPpBx3lpeVnKIIi4XAUstIGgb6IxAcQPk32AxRUzB13CziF
   W/2laWQxRzFj90Zm2J2aH1u4RSriOM1a/tGLgzrIZp284nRtlyjyjo/r1
   NHSDVrLun3Alyy6ClgiCLZtkJMfG2ihOCzmi1mFeax8U+VpEMjEveSk3Q
   G/kyGFzWVINFOHiJDbJdp2GAYGIK5WfSWAJhNTR/uUaM/Sj5V+dhGhYYW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="291066064"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="291066064"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:20:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="741932166"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="741932166"
Received: from ppkrause-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.73])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:20:03 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles BULOZ <gilles.buloz@kontron.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/4] 8250: DMA Fixes
Date:   Tue,  8 Nov 2022 14:19:48 +0200
Message-Id: <20221108121952.5497-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a number of 8250 DMA related fixes. The last one seems the
most serious problem able to corrupt the payload ordering.

v2:
- Tweak configure logic to match Andy's suggestion
- Cleaned up the tags from the oneliner patch

Ilpo Järvinen (4):
  serial: 8250: Fall back to non-DMA Rx if IIR_RDI occurs
  serial: 8250_lpss: Configure DMA also w/o DMA filter
  serial: 8250_lpss: Use 16B DMA burst with Elkhart Lake
  serial: 8250: Flush DMA Rx on RLSI

 drivers/tty/serial/8250/8250_lpss.c | 17 +++++++++++++----
 drivers/tty/serial/8250/8250_port.c |  7 +++++--
 2 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.30.2

