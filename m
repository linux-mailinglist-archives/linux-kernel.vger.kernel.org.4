Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54DD736256
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjFTDwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFTDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:52:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6025319A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687233122; x=1718769122;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oJTWJQVVZUP4PDOwjMBif2MLSxUzr0E4nCNevbHznuw=;
  b=Smc9xmwiw6Be4okx61bXioauoKG85hqxOmpmZRFv8DSA9NR2IoeqiikV
   2adYcyCorAt2icDJa5uAw38JHqMIJaWDyOI4Enoi9RR3Iy542fp7eix5L
   OElMi9p6D1TaKVhw4cFj9VAmIP6UPj1rnHkMrDXF81xDego+hrxwPMpDy
   FER7LGU+ERbuAZxNqf6fiLuAyhI97GTvAAa3L3cUkJjE7AKQZj6n9bRWt
   Jk9dyAe2KBDGBtc4jcvWNIWTdy4M9o7ErHo1emoHoV+36ao9r22xcAKQu
   t17urktFySi8SDBxDj0+mIh5jnqWWCMESAVN4MbTSFO8iIAJ6oi+R1qAC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="362299124"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="362299124"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 20:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="960617989"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="960617989"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2023 20:52:00 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 0/2] firmware: stratix10-svc: support N clients
Date:   Tue, 20 Jun 2023 11:51:24 +0800
Message-Id: <20230620035124.1157931-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

hi,
In order to support N clients sending concurrent messages to svc driver,
we need to have all clients owning up to their individual threads.
And, to cater for the limitation of the mailbox device driver in 
secure monitor firmware that only permits a single message at a time,
a mutex is used to prevent the multiple clients from sending a message
to SDM. 
Also, added a fix on the removal of the driver that resulted in a 
kernel panic due to badly used drv_set_drvdata.

Ang Tien Sung (2):
  firmware: stratix10-svc: Support up to N SVC clients
  firmware: stratix10-svc: fix bug in saving controller data

 drivers/firmware/stratix10-svc.c | 188 ++++++++++++++++++++-----------
 1 file changed, 123 insertions(+), 65 deletions(-)

-- 
2.25.1

