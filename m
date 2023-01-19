Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB4767325B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjASHXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjASHXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:23:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1E1604A6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674113018; x=1705649018;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J+PuaT8Pd5jSfyga8q8sol2GC6waEKgBjAT0Ja2R/Sk=;
  b=UVAq9Jwb0NlZnaX6Tzm8gTUgmo2NwDqc3p1X4LPqKuGYqMsb54q4l2II
   Sqti+J1AKr6k1fnpfM+lwEuR4TcEuPIJQd+0WSAZIp/hresA7bQUMhgY2
   ByTZrLw5pMMFb/BiHA0wkYIrTVam8oUYDcugSgcA/nkFGaS7wDjKqEoll
   5EzIHtoUrYcsoZBaMwBPPU6lDixBxwXjE7TeJFChG7L+djmRkaBMRCLQb
   7V4LV1RwT3gzmfU28Hbk69aZXxGDPQM9LzF0mZ0KzE3BUKom/7Li79PwT
   J+H5+oeAirxuzyYphp3UGgIEt6K61LOYdM3EaveiVKOpkKfDzEl8MedgA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322902649"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="322902649"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 23:23:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="662027983"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="662027983"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 23:23:36 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 0/4] soundwire: better error handling in deferred transfers
Date:   Thu, 19 Jan 2023 15:32:07 +0800
Message-Id: <20230119073211.85979-1-yung-chuan.liao@linux.intel.com>
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

This is a generic cleanup series.

v2:
 - Remove the "soundwire: stream: uniquify dev_err() logs" patch

Pierre-Louis Bossart (4):
  soundwire: stream: use consistent pattern for freeing buffers
  soundwire: bus: remove sdw_defer argument in sdw_transfer_defer()
  soundwire: cadence: use directly bus sdw_defer structure
  soundwire: cadence: further simplify low-level xfer_msg_defer()
    callback

 drivers/soundwire/bus.c            | 12 +++++-------
 drivers/soundwire/bus.h            |  3 +--
 drivers/soundwire/cadence_master.c | 20 ++++++++++----------
 drivers/soundwire/cadence_master.h |  5 +----
 drivers/soundwire/stream.c         |  8 ++++----
 include/linux/soundwire/sdw.h      |  6 +++---
 6 files changed, 24 insertions(+), 30 deletions(-)

-- 
2.25.1

