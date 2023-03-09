Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D2C6B1D7A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCIIKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCIIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:09:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E7480922;
        Thu,  9 Mar 2023 00:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349375; x=1709885375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RK695QH/y82SbaTTSnPKZdcNJwX827c00O+m1L7g7qE=;
  b=S7iMbP/eCPROpH3jQZPd2/55QhgpBmv749/IHj7tszQuvRnvQa920H9c
   0s4Lsp7v+bV9EcUSibBucP4BJvElyzfMfrT3BaqgFFsldNB8fIt8NdB3z
   RgDS40wAI//M/Uv6gX89F1dTjE8nfmZlW7Jb+lqrjmv99pK5AcYcXVT3H
   sgN1f4n+U829+20sN7rbCzyffnGS9ePHQhrOyRPIXGiH9sxNGrIMrugjS
   90qU3jJ2lCqzdsY430FFKpUmntdBwzFvVCsEMI46fVjjGjUAM2NBcyUvj
   TN8M1fulrVeXJyvTUZiPdfdhBtOT3P46SzfJqfD/UQPKWkkNRuPgxX3xk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333853545"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="333853545"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746227955"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746227955"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:34 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/8] serial: Use ARRAY_SIZE() with iso7816 reserved array
Date:   Thu,  9 Mar 2023 10:09:16 +0200
Message-Id: <20230309080923.11778-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230309080923.11778-1-ilpo.jarvinen@linux.intel.com>
References: <20230309080923.11778-1-ilpo.jarvinen@linux.intel.com>
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

Instead of a literal, size the for loop iteration based on the actual
array using ARRAY_SIZE().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2bd32c8ece39..ee2aabcc8943 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -1491,7 +1492,7 @@ static int uart_set_iso7816_config(struct uart_port *port,
 	 * There are 5 words reserved for future use. Check that userspace
 	 * doesn't put stuff in there to prevent breakages in the future.
 	 */
-	for (i = 0; i < 5; i++)
+	for (i = 0; i < ARRAY_SIZE(iso7816.reserved); i++)
 		if (iso7816.reserved[i])
 			return -EINVAL;
 
-- 
2.30.2

