Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D3E65D704
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbjADPQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239119AbjADPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:16:05 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BACE035;
        Wed,  4 Jan 2023 07:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672845359; x=1704381359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WoYPJhgn0VzeKMK+DSthce4P36Cbw4uJWhaeJQ2MS28=;
  b=lJooWq9Jb5VoDjq6pTu81XBceMdGdCzNA9nOkW+je+3Rnm5xWL8aBYV0
   x30BFqClq1WzG9yhYg/GZ7KuQ99DAL+r2Ml375HlS6a5PM1NxuxKgTEdV
   RqI5CVz4NoSQdggkEohTj4hJE2hnMV1hoTUQ4+vWZCuyOtozhd4qtDBlM
   lkJkZDAuzDOloDUdWRTErfneXbkPmC2kABJX2cOQ7X5T5ku0wevgYnNPA
   9wj6nvTtCNT2g+KyTw+izapLLuUyBP/nSXfgZwQbDE9FrOR+tlr6HT/IE
   dAU1cJBUsy084DUUs5O6dShqds7/gGgQ0YFyf/7SUJeDZiRn5XRkWy6Yz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301644338"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="301644338"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:15:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762700754"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="762700754"
Received: from msvoboda-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:15:56 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/10] tty: moxa: Make local var storing tty_port_initialized() bool
Date:   Wed,  4 Jan 2023 17:15:25 +0200
Message-Id: <20230104151531.73994-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return type of tty_port_initialized() is bool, use matching type for
the local variable.

Also reorder the local vars to reverse-xmas-tree while at it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/moxa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index bc474f3c3f8f..2d9635e14ded 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1664,8 +1664,8 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 		u16 __iomem *ip)
 {
 	struct tty_struct *tty = tty_port_tty_get(&p->port);
+	bool inited = tty_port_initialized(&p->port);
 	void __iomem *ofsAddr;
-	unsigned int inited = tty_port_initialized(&p->port);
 	u16 intr;
 
 	if (tty) {
-- 
2.30.2

