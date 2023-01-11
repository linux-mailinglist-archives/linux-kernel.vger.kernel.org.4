Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB17665DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbjAKOYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbjAKOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:24:17 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DEF1A066;
        Wed, 11 Jan 2023 06:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673447048; x=1704983048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0aHYPToS/jABucyxHBUjjp3ckI/iQBTA/kh5jyn5eAU=;
  b=bQ92uKsOT37n8E6obUNT7noQVBMmrfewEHoPtgCgg3o1ZP6zL4kRbFkC
   aJSkzKnn3cZDbNeNKi5fncyoTWPeR7b3Wpo0ls62kaXVhpoQZRMNB6a3k
   ikmUbD1tRfM0T91yvAE+dke7jRaPnOdSEZopw9BEHEKRxP/dnbiSastIK
   zrBRE90neL0n0HheVxFYB6lxQLMeUQRgnKXsPyE+3eFJxzN+PY/k/3OM5
   8VrMvSakJTlZ8fthGxpMUDDWhamTRHuwEz0CVA9gSXPKKnMI/uxcnAfQb
   O/4YG9rLpnn4FWVjB/905avP/UZ1HaosJvT9NuLBzdUGXUfg4GjInRL6F
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303793524"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303793524"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:24:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607381853"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607381853"
Received: from mihaiana-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.222.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:24:04 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 04/13] tty: moxa: Make local var storing tty_port_initialized() bool
Date:   Wed, 11 Jan 2023 16:23:22 +0200
Message-Id: <20230111142331.34518-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
References: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
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

