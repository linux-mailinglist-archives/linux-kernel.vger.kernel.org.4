Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723EA5BD40C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiISRuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiISRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:50:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B1040BFB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663609841; x=1695145841;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vD1pc/2OxnyeJnj8kQs4yhBwTv67WRUcJ1Mpirr7VTE=;
  b=OKLOAoV4t5cj/e20CrIazQfujv+ulFcF7nOEdx0YZ5NEsdZWCKKb0sCV
   9hg6FqVn97pqETtJl8yj6lRzRqcl9m2nlr0/6iZZIR+0jMtvO1ll+2FNY
   yiIyEUSpoXLVKr0c3TY9kWni1CJ9wksf4+jccOQ3G2oqKNMA5+YECudI8
   +6rqlxDgQxcuM8Jannrr6IEpoTtOSX5R+dCdVMW9ZWYUO9YaTm350b7dE
   wBOcArfi5RCLZ3tBclU7j/NigTN1XEa3lobL8i9gF0mcnID0/wxNQJeMG
   JW0AyaEwZ1jh3W+LdFUwVkP/op6nR4ycRZK+6l6dvA5CcTh0jJiJqjj3l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363429107"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="363429107"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="863658357"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 10:50:39 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 00/11] soundwire: intel: cleanups/fixes before code reorganization
Date:   Tue, 20 Sep 2022 01:57:10 +0800
Message-Id: <20220919175721.354679-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a really big cleanup to introduce well defined helpers, prior to
a larger code reorganization.

Pierre-Louis Bossart (11):
  soundwire: intel: fix error handling on dai registration issues
  soundwire: intel: simplify flow and use devm_ for DAI registration
  soundwire: intel: move DAI registration and debugfs init earlier
  soundwire: intel: move all PDI initialization under
    intel_register_dai()
  soundwire: intel: remove clock_stop parameter in intel_shim_init()
  soundwire: intel: move shim initialization before power up/down
  soundwire: intel: remove intel_init() wrapper
  soundwire: intel: simplify read ops assignment
  soundwire: intel: introduce intel_shim_check_wake() helper
  soundwire: intel: introduce helpers to start bus
  soundwire: intel: add helper to stop bus

 drivers/soundwire/intel.c | 775 +++++++++++++++++++-------------------
 1 file changed, 380 insertions(+), 395 deletions(-)

-- 
2.25.1

