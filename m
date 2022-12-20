Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C78665290E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLTW3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLTW3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:29:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE32DD4;
        Tue, 20 Dec 2022 14:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671575371; x=1703111371;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HvkRqojfi6ClONQSzxg0z+qJIiMeSeXELz4Q5owrY9g=;
  b=GSfrMCwox83nT3VvqTQ3XoeDXj+bqpdX5s22cfYyOfuQWute01hDfOKq
   Qf3uhMBnB5wCIAZqynVx4zmB24FGUdTqBcDl62KdfMvt5djMDV8kVQV+A
   j5WcbajbbiHPBLtA6oeHFKwLlsoXUhLFu/C+0fgGUIpwprIxF0ADUE5c/
   eZKPME8t3kz55Dcb5bo6IPVUhlZPsrApgDQ0lxTS0tsqRYGHFmgVRBVaL
   PeJL+2gkmrixDyJzwr6knQzOEIxoTWhSASYBNpkecBchdOdDrzv9J1v2/
   1KHFdyt1WpPAA40CN55TjALjGhCyQ1oazhwVB2/ukaZQVVN0celiaTlR2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="317369079"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="317369079"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 14:29:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="683566946"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="683566946"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.157])
  by orsmga001.jf.intel.com with ESMTP; 20 Dec 2022 14:29:30 -0800
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     rajmohan.mani@intel.com, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH] thunderbolt: Do not report errors if on-board retimers are found
Date:   Tue, 20 Dec 2022 14:30:06 -0800
Message-Id: <20221220223006.3145568-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tb_retimer_scan() returns error even when on-board retimers are found.

Fixes: 1e56c88adecc ("thunderbolt: Runtime resume USB4 port when retimers are scanned")

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
 drivers/thunderbolt/retimer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 81252e31014a..6ebe7a2886ec 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -471,10 +471,9 @@ int tb_retimer_scan(struct tb_port *port, bool add)
 			break;
 	}
 
-	if (!last_idx) {
-		ret = 0;
+	ret = 0;
+	if (!last_idx)
 		goto out;
-	}
 
 	/* Add on-board retimers if they do not exist already */
 	for (i = 1; i <= last_idx; i++) {
-- 
2.25.1

