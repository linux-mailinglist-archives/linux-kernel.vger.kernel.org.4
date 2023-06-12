Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EC072D336
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbjFLVYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbjFLVYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:24:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192EC2105;
        Mon, 12 Jun 2023 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686604834; x=1718140834;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ja8YEkFV9cCcGRUkNI70fpuF3R3N3S8zwqOS2C6vvZA=;
  b=OFEGHe0kS0jmso1r9jB7YOTCFtxvew5nyWwPEPwM+yCp0mtTnt53ybcr
   vKDe3gl5ePjnoplBsQ+ZBTzu4WxGP4Pxn0FpYXPFZkI0YnD+ce/rMR4AC
   rLeD6ZWlZ6B8w4jF77lm38MPPuL0JIA0Kf7ixIdyfQwIXEeE0Iw0hikVy
   uQFRVjS5hq9OL5KMq5vvqil5+VRA88RKaXIcUvxWDUsIi+aanMZh7n3se
   vGqBT60lB5MnMNhwcHupqZJAxIjb3UT3HAVgaHRzngWHVCSVJmt+PqtNK
   LvXjGh4yRpoGvhPDJEJSacy6S3AG5LJxevGsnevkVgcQwg26wyDh1yik/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358161172"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="358161172"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:20:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="688782844"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="688782844"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Jun 2023 14:20:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1F404357; Tue, 13 Jun 2023 00:20:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] media: drxk: Use %*ph for printing hexdump of a small buffer
Date:   Tue, 13 Jun 2023 00:20:38 +0300
Message-Id: <20230612212038.3876-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel already has a helper to print a hexdump of a small
buffer via pointer extension. Use that instead of open coded
variant.

In long term it helps to kill pr_cont() or at least narrow down
its use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/dvb-frontends/drxk_hard.c | 28 ++++++-------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 3301ef75d441..14035deeb6d8 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -229,13 +229,8 @@ static int i2c_write(struct drxk_state *state, u8 adr, u8 *data, int len)
 	struct i2c_msg msg = {
 	    .addr = adr, .flags = 0, .buf = data, .len = len };
 
-	dprintk(3, ":");
-	if (debug > 2) {
-		int i;
-		for (i = 0; i < len; i++)
-			pr_cont(" %02x", data[i]);
-		pr_cont("\n");
-	}
+	dprintk(3, ": %*ph\n", len, data);
+
 	status = drxk_i2c_transfer(state, &msg, 1);
 	if (status >= 0 && status != 1)
 		status = -EIO;
@@ -268,14 +263,8 @@ static int i2c_read(struct drxk_state *state,
 		return status;
 	}
 	if (debug > 2) {
-		int i;
-		dprintk(2, ": read from");
-		for (i = 0; i < len; i++)
-			pr_cont(" %02x", msg[i]);
-		pr_cont(", value = ");
-		for (i = 0; i < alen; i++)
-			pr_cont(" %02x", answ[i]);
-		pr_cont("\n");
+		dprintk(2, ": read from %*ph, value = %*ph\n", len, msg,
+			alen, answ);
 	}
 	return 0;
 }
@@ -441,13 +430,8 @@ static int write_block(struct drxk_state *state, u32 address,
 		}
 		memcpy(&state->chunk[adr_length], p_block, chunk);
 		dprintk(2, "(0x%08x, 0x%02x)\n", address, flags);
-		if (debug > 1) {
-			int i;
-			if (p_block)
-				for (i = 0; i < chunk; i++)
-					pr_cont(" %02x", p_block[i]);
-			pr_cont("\n");
-		}
+		if (p_block)
+			dprintk(2, "%*ph\n", chunk, p_block);
 		status = i2c_write(state, state->demod_address,
 				   &state->chunk[0], chunk + adr_length);
 		if (status < 0) {
-- 
2.40.0.1.gaa8946217a0b

