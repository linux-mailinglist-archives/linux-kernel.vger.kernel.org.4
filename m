Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CAE61F173
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiKGLHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiKGLHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:07:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F53218383;
        Mon,  7 Nov 2022 03:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667819238; x=1699355238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sm+yS9utvJpJAQMRMEurAzuv8xjSarjiRadqA2mVG6E=;
  b=AETYgtV4N1Y1K+7ai16LtBN46J8bJe4dtbsyr7iwBjOPBPMg5SYmxuhS
   6QSSA+PYoi+3npDZBjCe2WzLQFkLNCzA2WXrWr94hRoBHFj2pLi10oDYm
   ges6cJqy3bJdS8g0eKPAIgG48HoS/4LhA2t3+cog4CFA7FMmy8Fvvxljq
   fN3vrrqNXoWSlEoqJLExKWGmm6Ergj2aut5XcdZlFm/ItX/F3Q7UyqlQ2
   XrX0l65hRg6L9E+sJPmP+t9OolyrA2FDbELODFQvtP1pGUoIYWFjG0plo
   O5tmXu5mlxwbyixuSciN4dyzmWUO8K9y+tIu+eO5+mvq2DKcYpZsK8c+t
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="290773000"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="290773000"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:07:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="586932308"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="586932308"
Received: from gschoede-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.46.211])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:07:15 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/4] 8250: DMA Fixes
Date:   Mon,  7 Nov 2022 13:07:04 +0200
Message-Id: <20221107110708.58223-1-ilpo.jarvinen@linux.intel.com>
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

Ilpo Järvinen (4):
  serial: 8250: Fall back to non-DMA Rx if IIR_RDI occurs
  serial: 8250_lpss: Configure DMA also w/o DMA filter
  serial: 8250_lpss: Use 16B DMA burst with Elkhart Lake
  serial: 8250: Flush DMA Rx on RLSI

 drivers/tty/serial/8250/8250_lpss.c | 18 +++++++++++++-----
 drivers/tty/serial/8250/8250_port.c |  7 +++++--
 2 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.30.2

