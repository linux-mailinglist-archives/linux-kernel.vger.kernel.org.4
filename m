Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F04678370
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjAWRjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjAWRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:39:19 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE29C29423;
        Mon, 23 Jan 2023 09:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674495557; x=1706031557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=72mROXM5bY+9TiTxvULVJ7CcWsGH/U7JStjakO0iwsI=;
  b=kSRRT1V7cZUbIySw8p/Fp9YzZIQr3RwrtlAZNMoWGIjNM6z3gmhHW+yT
   TlyRqv4QofPtKkLAz4fHTKiPaEkz09WEkhyGn/OlfgjSdQ3WPZlchli78
   ZOJeZUgZHEWzKTmUMhNPlxOOsOsVNcs/ZhtFLLzitooZJZembdqu6PMUY
   L7KMoALWHjjAoMd2UFrPrORjpGDaE293IH6tVdvpLVCfVADvSBtTD3d9A
   mBktlIJAkyn1HbjcjwEWQ1gzigYq2fB4U5LyLkyXU0NqWEqc0Cv6ffPIC
   tZkbwfUSCD0bqjCd/6yQa86FFIPLzlsJXlEyrhwhuNCSHmwqVlnnfZ7Pt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390601984"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="390601984"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:39:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="694017809"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="694017809"
Received: from giangiac-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.71])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:39:14 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH 2/2] serial: liteuart: Correct error rollback
Date:   Mon, 23 Jan 2023 19:38:57 +0200
Message-Id: <20230123173857.40695-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230123173857.40695-1-ilpo.jarvinen@linux.intel.com>
References: <20230123173857.40695-1-ilpo.jarvinen@linux.intel.com>
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

Goto to the correct rollback label instead of directly returning.

Fixes: 5602cf99dcdc ("serial: liteuart: add IRQ support for the RX path")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index ef557d59e4c8..192ad681de35 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -313,7 +313,7 @@ static int liteuart_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq_optional(pdev, 0);
 	if (ret < 0 && ret != -ENXIO)
-		return ret;
+		goto err_erase_id;
 	if (ret > 0)
 		port->irq = ret;
 
-- 
2.30.2

