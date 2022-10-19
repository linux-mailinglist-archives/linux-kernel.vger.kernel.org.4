Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B62C603FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiJSJey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiJSJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:29:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A2CEB75E;
        Wed, 19 Oct 2022 02:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170788; x=1697706788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dp4IHVx98V/WVUXsszi1UUqLShoGIXwdHa728DHztS8=;
  b=XXbf/XZ3xwslhU5RtPAE4h03uob49paNDlBvqodSzc6sxAJb6o6SPamp
   MnX6qrSdfQmLWwFDHmyNkEf3lIa68YhFXhXIdfFVIaJIoSzSU7c3Me2Gb
   y9qkdLn5shhr+CxhVrcgW5O4Ori2Dhmfk3zUcFsRBdG1o9pXJeGgDxsTa
   yzd7hGINtU9RFWK4DPu75Xy9UJJFSihEbAiAU2Jf/qpF4wawLZ1MdHRZh
   li4q1C2DjWFL0sqNjsanUUdffa3B1z0ps4OKOhNPFAuVASZBQJeoM7uKW
   sKNIUaN17bOnOSkNdO1EKyrChS0v+5p8kTHamBQ6U2MTa1J/8OolJEWc4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="332910778"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="332910778"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734118439"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734118439"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:12:21 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 01/44] serial: dz: Use uart_xmit_advance()
Date:   Wed, 19 Oct 2022 12:11:08 +0300
Message-Id: <20221019091151.6692-2-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/dz.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 829b452daee9..6b7ed7f2f3ca 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -279,9 +279,8 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
 	 * so we go one char at a time) :-<
 	 */
 	tmp = xmit->buf[xmit->tail];
-	xmit->tail = (xmit->tail + 1) & (DZ_XMIT_SIZE - 1);
 	dz_out(dport, DZ_TDR, tmp);
-	dport->port.icount.tx++;
+	uart_xmit_advance(&dport->port, 1);
 
 	if (uart_circ_chars_pending(xmit) < DZ_WAKEUP_CHARS)
 		uart_write_wakeup(&dport->port);
-- 
2.30.2

