Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E843603FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiJSJjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiJSJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:34:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82783BC6B;
        Wed, 19 Oct 2022 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170907; x=1697706907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GyL/mkBnWw9BwSgBpj4b43K3+WPQ3jqn+0KpOYzRE0M=;
  b=XP0UX+Ei2CkvB4C19RJtrduq8F6tE3lCoiIxOIltmADxJtlLFqyc2hES
   TZVazlw41PYIbg0n+ZURc8zPClk3j9czRoC3e8W5Mk+BPX/163AMNKgwc
   1SwXp0Z3sEPZ8htQmcyn6gZjukzSWbyeeESZE2RQOnEn7edEhhF+HlZJK
   iNt8ZgtrxI/icsOUuNGAhAY+rcr0cq1GwN7WllK55uE9O+7eIgw0fD9Zy
   q3WMjn8XYG08wJdPpVUzEiZkgj07kJTzrXKTAii+y3Uu3J2wonu31P9Mn
   If2orn0Tz1aFrV49oGP+js0ncasVhSuHBwqvutkHfe0wK7tAxdkWF5oNB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332911244"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332911244"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734119160"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734119160"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:14:03 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 31/44] serial: tegra: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:38 +0300
Message-Id: <20221019091151.6692-32-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take advantage of the new uart_xmit_advance() helper.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial-tegra.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index b7170cb9a544..4304e3f9307d 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -496,8 +496,7 @@ static void tegra_uart_fill_tx_fifo(struct tegra_uart_port *tup, int max_bytes)
 				break;
 		}
 		tegra_uart_write(tup, xmit->buf[xmit->tail], UART_TX);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		tup->uport.icount.tx++;
+		uart_xmit_advance(&tup->uport, 1);
 	}
 }
 
-- 
2.30.2

