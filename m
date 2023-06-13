Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8000372EFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbjFMWvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbjFMWvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:51:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7581BE7;
        Tue, 13 Jun 2023 15:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686696695; x=1718232695;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BwoJZ+qJT0AouLBc/72pTtMNJ2cOhvENSYmAHBDaG1g=;
  b=FHyUXFxbVwHM/CqaaE3oD0mE4vhf0IxU8mdKbyF6jQhBn8ifqVeEMTcv
   HaAVgX2S7kUPRfsi+3IQ1KkE6fFdudFo9KftoaUCtYOEWAVjznZWLeAxq
   PiaRmEXVJY5nv+8fXQvdsrCExQvikfBsE+p9HNEslT9jn9CshR7/136mn
   cMy5MvAaMnk5gOQ528Y0LbWKTcHPhPa5OFiUnA+ylS6PKDWcD7NDigJ2j
   342HufV/CdLWKW1PtUuJ4/rt/TSw/ArBOzYSU9CkWdmcA6fOUFJXHAAim
   vs+eg8ZgPx+VxOmSM44tJQTvtMZ3/QICxD0OB7F8sElhSOsiAG2nBxkhn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444842172"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="444842172"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824589627"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="824589627"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 15:51:34 -0700
Received: from rjingar-desk5.amr.corp.intel.com (hciettox-mobl.amr.corp.intel.com [10.212.23.107])
        by linux.intel.com (Postfix) with ESMTP id EC34E580BF8;
        Tue, 13 Jun 2023 15:51:33 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     david.e.box@linux.intel.com, ilpo.jarvinen@linux.intel.com,
        irenic.rajneesh@gmail.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, hdegoede@redhat.com
Cc:     xi.pardee@intel.com, Rajvi Jingar <rajvi.jingar@linux.intel.com>
Subject: [PATCH 0/8] Add multiple PMCs support in pmc core driver
Date:   Tue, 13 Jun 2023 15:53:39 -0700
Message-Id: <20230613225347.2720665-1-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer platforms starting from Meteor Lake can have multiple PMCs.
This patch series include changes to enable pmc core driver to support
multiple PMCs for newer platforms. It adds devid and register maps to
enable IOE-P and IOE-M available on Meteor Lake platform. It also fixes
the register maps for SOC-M.

Patch includes:
platform/x86:intel/pmc: Update maps for Meteor Lake P/M platforms
platform/x86:intel/pmc: Combine core_init() and core_configure()
platform/x86:intel/pmc: Add support to handle multiple PMCs
platform/x86:intel/pmc: Enable debugfs multiple PMC support
platform/x86:intel/pmc: Discover PMC devices
platform/x86:intel/pmc: Use SSRAM to discover pwrm base address of primary PMC
platform/x86:intel/pmc: Add Meteor Lake IOE-P PMC related maps
platform/x86:intel/pmc: Add Meteor Lake IOE-M PMC related maps

 drivers/platform/x86/intel/pmc/Makefile     |   4 +-
 drivers/platform/x86/intel/pmc/adl.c        |  16 +-
 drivers/platform/x86/intel/pmc/cnp.c        |  18 +-
 drivers/platform/x86/intel/pmc/core.c       | 470 ++++++----
 drivers/platform/x86/intel/pmc/core.h       | 125 ++-
 drivers/platform/x86/intel/pmc/core_ssram.c | 133 +++
 drivers/platform/x86/intel/pmc/icl.c        |   7 +-
 drivers/platform/x86/intel/pmc/mtl.c        | 954 +++++++++++++++++++-
 drivers/platform/x86/intel/pmc/spt.c        |   7 +-
 drivers/platform/x86/intel/pmc/tgl.c        |  21 +-
 10 files changed, 1516 insertions(+), 239 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/core_ssram.c

-- 
2.25.1

