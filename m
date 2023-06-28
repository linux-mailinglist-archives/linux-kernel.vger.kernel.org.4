Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71A741480
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjF1PER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:04:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:32511 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231950AbjF1PEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687964648; x=1719500648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GycD9dWOzwRCqNYrIYMYjM1P7I0T3JI7OkH4Yxa/z1c=;
  b=kL1MZ12OWLrnLeNsTaIv7b8ZarKAE7u7wmYTHw6RyXDjBE8fVkjYDD6i
   D9O+NvUXUy1gRCLUU4Fde97DGvSEsUGG+b1MJ1ntcVmABnVNuuqa1fcJ0
   W/ExC/2zL701oc31OGuZFJhpiX60y49JMaRfeiX8Qbk6/ZzBHEaYPG3tb
   FsHf00KepkaBAmThkiTquu16/FlFdZyFrnjjhg1279BLxa3orr5qay4QU
   epV5NxZBrElrrVnMXxybRgE8flJ6tn7BeGw9idA/KXEiJbMDPPutUnBpv
   bSPf2gz9ta0r9Bb89CpTC2C3SvVjM8KT13Ig9uYJqje02mfiq/9aYgp5x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342206060"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="342206060"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="667159966"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="667159966"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2023 08:02:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 06DE8E1; Wed, 28 Jun 2023 18:02:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] irqdomain: Use return value of strreplace()
Date:   Wed, 28 Jun 2023 18:02:51 +0300
Message-Id: <20230628150251.17832-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since strreplace() returns the pointer to the string itself,
we may use it directly in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5bd01624e447..0bdef4fe925b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -182,9 +182,7 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 			return NULL;
 		}
 
-		strreplace(name, '/', ':');
-
-		domain->name = name;
+		domain->name = strreplace(name, '/', ':');
 		domain->fwnode = fwnode;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
-- 
2.40.0.1.gaa8946217a0b

