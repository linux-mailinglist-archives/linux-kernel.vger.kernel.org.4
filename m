Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22079737957
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjFUCse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjFUCsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:48:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9DA1B4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687315712; x=1718851712;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7m8z7mWq2BnwpWpsh01lUKzyCo8hIR3o0QJmQkvnU/I=;
  b=Wy7MgA5GHR1i6dFKjrL2yA6sTfdEpVAgOG2r4CU8P//z6QbM5RSHPmbv
   Ma+XvytBuMcrk+VWEmoU4Sg+RqRxEkF1dHxBd/e1pHVoTGnrerFa7Qddl
   2CDrvj6Nar0C9DFiri4uWqCpdFyT41wArdQ2EKom+Gi5xbbcPfPF+G+ZI
   8madUv+owNk9XkV8np+m8hrhf8B+gCcWnqOvQfI96ZDgKVHI8L8tmXOlQ
   RnogCq7/LtgelSfO8N7bI/XYIQ5ksIDTVeMfpzn7SkKV6fdCeZIJkhE7T
   868BGRX6j7iretfWh0JvM7a5V2DkfHzOOhoH7GjF3Rnv7NepzWt15+SVH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357541149"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="357541149"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 19:48:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804182854"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="804182854"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2023 19:48:27 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v1 0/2] firmware: stratix10-svc: support N clients
Date:   Wed, 21 Jun 2023 10:47:54 +0800
Message-Id: <20230621024754.1392193-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

changelog from V1:
- Added "Fixes:" tag to the 2nd patch to detail the fix location.

Ang Tien Sung (2):
  firmware: stratix10-svc: Support up to N SVC clients
  firmware: stratix10-svc: fix bug in saving controller data

 drivers/firmware/stratix10-svc.c | 188 ++++++++++++++++++++-----------
 1 file changed, 123 insertions(+), 65 deletions(-)

-- 
2.25.1

