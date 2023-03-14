Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E211F6B87AA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCNBlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCNBlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C93733BE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758067; x=1710294067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x2HDUBm4iNL4Ux/CxNLLfqxMzPTBD5JMWpg7L8l7OyQ=;
  b=GuyVD9ja4PbeOLWgswWIJD2LzgPhLr+EfdNGzRCqSGtZk8dAnSEmqDib
   IzvjaFiYjTtDK79hGR1uxMk60eA0Nu2sZPJqZvnIUTC7QQmlevR7C9R5c
   qxY76pcNduGGhm6SVR+nTAoUt6bCIf+/kSqu003El+gzBjR2QB3mu4xVP
   h9+MSU0FL5MI2u0yb3zqJWdirTzl9gSMJfEjCl4H7Qw1g5OdbKS03d8Ed
   aXCX4W3IDlURDc4HfQpgZB2ZEj7AjrKTGxe07PSdysWeB21zWN2wBVi+V
   2GfAzQjd4AtRlVQZLGvtIKPqLxdToKyTtw+BhAsPDKTXymvyr4XcSaFYB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949197"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949197"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327315"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327315"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:05 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 00/16] soundwire: updates before LunarLake introduction
Date:   Tue, 14 Mar 2023 09:53:54 +0800
Message-Id: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides a set of cleanups and new abstractions needed for the
introduction of LunarLake support.

For now this is an iso-functionality change, with changes on the Intel and
Cadence sides. The low-level support for LunarLake will be introduced in a
follow-up series that depends on HDaudio multi-link extensions.

Pierre-Louis Bossart (16):
  soundwire: intel: move common definitions to header file
  soundwire: intel: remove stale/misleading comment
  soundwire: intel: remove PDI-level restrictions on rates and formats
  soundwire: intel: remove useless abstraction
  soundwire: intel: simplify sync_go sequence
  soundwire: intel: add sync_arm/sync_go to ops
  soundwire: intel: use indirection before moving bus start/stop
    sequences
  soundwire: intel: move bus common sequences to different file
  soundwire: intel: add abstraction for cmdsync check
  soundwire: intel: move bank switch routine to common
    intel_bus_common.c
  soundwire: cadence: remove CDNS_MCP_CONFIG_SSPMOD
  soundwire: cadence: add helpers to access IP_MCP registers
  soundwire: cadence: split access to IP_MCP_CONFIG fields
  soundwire: cadence: split access to IP_MCP_CONTROL fields
  soundwire: cadence: split access to IP_MCP_CMDCTRL fields
  soundwire: cadence: change access to IP_MCP_CMD_BASE

 drivers/soundwire/Makefile           |   3 +-
 drivers/soundwire/cadence_master.c   | 139 +++++++-----
 drivers/soundwire/cadence_master.h   |   3 +
 drivers/soundwire/intel.c            | 325 ++-------------------------
 drivers/soundwire/intel.h            |  67 ++++++
 drivers/soundwire/intel_bus_common.c | 259 +++++++++++++++++++++
 include/linux/soundwire/sdw_intel.h  |  11 +
 7 files changed, 444 insertions(+), 363 deletions(-)
 create mode 100644 drivers/soundwire/intel_bus_common.c

-- 
2.25.1

