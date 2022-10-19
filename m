Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D6A6040A1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiJSKHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiJSKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:06:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E89E5E313;
        Wed, 19 Oct 2022 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666172709; x=1697708709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HCe8PEHgG9sbfAbmIqqIaUbApRLlMQaWbM79cf/MZOY=;
  b=FEtnana+ULMgR5GUOfCkGClEBcBUHuYnw7Wueg7TDzWQ1dQfRXkIU0k2
   eimC6SJBIL0jImdkoQzAKzJW80kHiSroaK2ca9VTcgFiE10dR7YWlrNVH
   a42Ou56PWjaQpvJEtbXaEcdNsf6z1jnuftjrxS0vDyV/kkxNMBee5qGoa
   U+SOgdFajsrXZlRl0Njlwyva9Rm7klLMFWpyZSHqpQrrw8sx6bjxwu+3a
   wOOHv2Abw9RHeWRdMAiSf9oh+2stvSt9xo+FwValtWksjt1i5XAP6xrbi
   goMXbM/wAVMuoD7lgGnATQJxAGK9NTG1EJYKzoScTCTsmKQQjevyjruOS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="305097167"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="305097167"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:42:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="631584401"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="631584401"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:42:52 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] tty: Cleanup tty buffer align mask
Date:   Wed, 19 Oct 2022 12:42:40 +0300
Message-Id: <20221019094241.10870-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019094241.10870-1-ilpo.jarvinen@linux.intel.com>
References: <20221019094241.10870-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use decimal for mask. Don't use literal for aligning.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index be3431575a19..7a73e8907ef6 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -21,7 +21,7 @@
 #include "tty.h"
 
 #define MIN_TTYB_SIZE	256
-#define TTYB_ALIGN_MASK	255
+#define TTYB_ALIGN_MASK	0xff
 
 /*
  * Byte threshold to limit memory consumption for flip buffers.
@@ -37,7 +37,7 @@
  * logic this must match.
  */
 
-#define TTY_BUFFER_PAGE	(((PAGE_SIZE - sizeof(struct tty_buffer)) / 2) & ~0xFF)
+#define TTY_BUFFER_PAGE	(((PAGE_SIZE - sizeof(struct tty_buffer)) / 2) & ~TTYB_ALIGN_MASK)
 
 /**
  * tty_buffer_lock_exclusive	-	gain exclusive access to buffer
-- 
2.30.2

