Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860B768F1BD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjBHPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjBHPO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:14:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21FCC25;
        Wed,  8 Feb 2023 07:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675869295; x=1707405295;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4lZOumIf897gikgiSSe/yOHSYio/WTFflUsJ9z+Lexk=;
  b=JH1hTxDkbfK3A3k4dJ8XGai3/NoP3AZbSjsDx/FWg8ifLNalbq9DRkki
   Js/1iVUYl75L7D7eN1kDGREShZgSmr3dX0q/0Af2GKQlhPdav9rPP+NT2
   kop3a3fewIJKZZ5R9N6lBoJAryjtAzEDy/KRJB+OWgqQG6kWo/GvCMTSu
   ajPeX3/bYFT7oF+eqDUNyBnH4y0v7DiRI0GONYrguGUrybzF95pj/WXQ/
   2MW6oeE+hWrYZrvdPmbxgYr84wo5i9KDLs1jcbY4QIDRPGjgIJhjgy42x
   XsNr5dimnHhVOLspjPVcCQLAdityqQOK135dU5rVOa6YSdiAtUvjpYsN2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="357218213"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="357218213"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 07:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="730898817"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="730898817"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Feb 2023 07:10:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C92651C5; Wed,  8 Feb 2023 17:11:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/7] xhci: mem: Short cleanup series
Date:   Wed,  8 Feb 2023 17:11:22 +0200
Message-Id: <20230208151129.28987-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up xhci-mem.c a bit using latest and greatest Linux kernel
features.

Changelog v2:
- used dma_pool_zalloc() instead of open coding it (Mathias)

Andy Shevchenko (7):
  xhci: mem: Carefully calculate size for memory allocations
  xhci: mem: Use dma_poll_zalloc() instead of explicit memset()
  xhci: mem: Get rid of redundant 'else'
  xhci: mem: Drop useless return:s
  xhci: mem: Use while (i--) pattern to clean up
  xhci: mem: Replace explicit castings with appropriate specifiers
  xhci: mem: Join string literals back

 drivers/usb/host/xhci-mem.c | 83 +++++++++++++++----------------------
 1 file changed, 33 insertions(+), 50 deletions(-)

-- 
2.39.1

