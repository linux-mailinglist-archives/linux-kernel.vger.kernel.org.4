Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2407D6C412B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCVDk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCVDk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:40:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23705A6D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679456425; x=1710992425;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zs02unq0wlk5HvP52gaN6xg18FqyIGEgUnbPMjMReUc=;
  b=altiJhi0DLmNZrttPm78sAK/cWOk8wgm/zBbCBMXEeO3tCdN/2txHzHl
   o4KgMbqrIS3GjyheiH3XQbnlgRNANXL2Et0u56JyaDrlS5acWpjAZXa78
   oLccNGdaJ3m33KbsYkzYfVVcoWUYEkM3ti1SmRGAsGhdZhW/EYrtZiSne
   NMaYgu4yQd46vg9KUY8Qd5Gk/uNA7hlNpWa+WNTlmxjlq/RAJKLOnO3DS
   BWf+VWczhyrlSsyXHKFadtV2H3Py/yeNoWyn02TJowTN2sfBw8YSF6I9x
   516lOxvXGSPkBZReUX45lwgZ/YVG1r8BEtqhBDEJiVHH4Xx5H6ivoJQsW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="404002928"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="404002928"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 20:40:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="792377943"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="792377943"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 20:40:23 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 0/2] soundwire: stream: uniquify dev_err() logs
Date:   Wed, 22 Mar 2023 11:55:22 +0800
Message-Id: <20230322035524.1509029-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of duplicate logs which makes harder than needed to
follow the error flows. Add __func__ or make the log unique.
This series also changed some uses of "dev_err(bus->dev," where the stream
may depend on multiple managers/buses.

v2:
- Split the original patch into two patches

Pierre-Louis Bossart (2):
  soundwire: stream: remove bus->dev from logs on multiple buses
  soundwire: stream: uniquify dev_err() logs

 drivers/soundwire/stream.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.1

