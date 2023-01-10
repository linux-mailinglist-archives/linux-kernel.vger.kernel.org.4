Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7947663FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbjAJMEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbjAJMDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:03:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A8958F81;
        Tue, 10 Jan 2023 04:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673352196; x=1704888196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0aHYPToS/jABucyxHBUjjp3ckI/iQBTA/kh5jyn5eAU=;
  b=cHkLED3xkaW8bBvZiskCbthBT1UVTDW//xIAlwPYerflWbeQv5XZKjcJ
   ZjP3zwrUCrt0kZWuvYInrlBgVIqjDSa4LEWK5/6sniP++G4ByRASAN/Ag
   NL23V49UnAXAhYixlKwXIhVRH26Ho+XSf0LC4uNPOPUHr92VinnefrUvF
   EKocW4vr+ay0S42whP8oolg/kKrjl0Ac4WHUWk1t127dFRy7kaFwmtUM2
   4KOzoKfXCnkW4Ob3db6v6H2HseBA/Van/GJ5qL8yLT9F9lZZ3mE21BD4r
   80DOAQALEU4Pbt583TSQqrWrtDp+5rNraYDpa7lW5EWMMZ73Wb6X8RaST
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350350042"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350350042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:03:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="799406815"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="799406815"
Received: from gbocanex-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.115])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:03:14 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 04/13] tty: moxa: Make local var storing tty_port_initialized() bool
Date:   Tue, 10 Jan 2023 14:02:17 +0200
Message-Id: <20230110120226.14972-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
References: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Return type of tty_port_initialized() is bool, use matching type for
the local variable.

Also reorder the local vars to reverse-xmas-tree while at it.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
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

