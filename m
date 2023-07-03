Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E52745E32
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGCOKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGCOKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:10:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9971C10C6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688393390; x=1719929390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pkVtFXlRR5kYwBtMS5BvxTwSslZj/ncacXtF+PbTuz0=;
  b=E5QstPWrPosXM80XRoSpT+3ebkXnXOD1iWLzAVfyohX//iifKt8/TjgW
   rCGDP1r88SxBRB0ZIN7HOFlUS1iUdlPgdfEo/6eiZ/PQrmZxi4MfFsT9X
   5Jg0ZymGDp0B940S8UqG2OyWQtd8RO7ZwnBRunkEfwcvZYx4jnbCQQYrW
   qe9zstKA5F7giM/Pqh5J7VVWYGlF8GSY+gywU6M3P80qCiaPC+z4hnixH
   V5SCmXVoGtPz5vSjjiTvHrI4qzSk74Zeow0ASmc8x8L2UGTriAadpIGYH
   FFI67VOjKr50ojhhg0ZM8pCev/ETt3+Axwzf36jDO5vaV5aG+h15zzsqA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="347678393"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="347678393"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 07:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="863097210"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="863097210"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2023 07:09:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C388013C; Mon,  3 Jul 2023 17:09:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] mfd: ipaq-micro: Add missing break for the default case
Date:   Mon,  3 Jul 2023 17:09:23 +0300
Message-Id: <20230703140923.2840-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703140923.2840-1-andriy.shevchenko@linux.intel.com>
References: <20230703140923.2840-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even default case should have a break statement to make code robust
against changes (e.g., adding a case after the default one).

Add missing break for the default case.
---
v2: new patch
 drivers/mfd/ipaq-micro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index cddfd2e808f2..57fb7874fc91 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -132,6 +132,7 @@ static void micro_rx_msg(struct ipaq_micro *micro, u8 id, int len, u8 *data)
 	default:
 		dev_err(micro->dev,
 			"unknown msg %d [%d] %*ph\n", id, len, len, data);
+		break;
 	}
 	spin_unlock(&micro->lock);
 }
-- 
2.40.0.1.gaa8946217a0b

