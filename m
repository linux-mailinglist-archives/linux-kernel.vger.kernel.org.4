Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAA76D7C13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbjDEL5j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 07:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbjDEL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:57:37 -0400
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DE03C0E;
        Wed,  5 Apr 2023 04:57:35 -0700 (PDT)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id D295E22293F;
        Wed,  5 Apr 2023 13:57:33 +0200 (CEST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id C766B221887;
        Wed,  5 Apr 2023 13:57:33 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.103-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgxLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx1.dmz.swissbit.com (mx.dmz.swissbit.com [10.181.10.103])
        by mail6.swissbit.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 13:57:33 +0200 (CEST)
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/3] mmc: block: ioctl: define rpmb reliable flag
Thread-Topic: [PATCH 1/3] mmc: block: ioctl: define rpmb reliable flag
Thread-Index: AdlntW2uE8YL5x37Rg65HliP9l7Uww==
Date:   Wed, 5 Apr 2023 11:57:21 +0000
Message-ID: <e41fbab65e164b3788818bae83f0061a@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27546.007
X-TMASE-Result: 10-2.026600-10.000000
X-TMASE-MatchedRID: mIinBA9F1pztpeQ2em9csrnHu4BcYSmtwTlc9CcHMZerwqxtE531VIPc
        XuILVCba7MOQ+kboAnB3ZVcbJy0H7nHPBvSspzfj9k0tWBWiOf+24zimxRfEgXhPzhoND77Mo8W
        MkQWv6iUJjITObGXoFY2j49Ftap9EOwBXM346/+zDqHd5lJWkyh6aBHx46AYmYHW0KadjRP75im
        mUIX9zfjmjCzRUNNaJ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 7719b2d5-1bf5-432a-931e-2742bcde89a9-0-0-200-0
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give a proper name to BIT 31 which is used as reliable write
for RPMB.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c       | 5 ++++-
 include/uapi/linux/mmc/ioctl.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 672ab90c4b2d..16e262ddc954 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -49,6 +49,8 @@
 
 #include <linux/uaccess.h>
 
+#include <uapi/linux/mmc/ioctl.h>
+
 #include "queue.h"
 #include "block.h"
 #include "core.h"
@@ -538,7 +540,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		 * may be increased by a future standard. We just copy the
 		 * 'Reliable Write' bit here.
 		 */
-		sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));
+		sbc.arg = data.blocks |
+			(idata->ic.write_flag & MMC_RPMB_RELIABLE_WRITE);
 		sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
 		mrq.sbc = &sbc;
 	}
diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h
index e7401ade6822..b2ff7f5be87b 100644
--- a/include/uapi/linux/mmc/ioctl.h
+++ b/include/uapi/linux/mmc/ioctl.h
@@ -11,6 +11,7 @@ struct mmc_ioc_cmd {
 	 * Bit 31 selects 'Reliable Write' for RPMB.
 	 */
 	int write_flag;
+#define MMC_RPMB_RELIABLE_WRITE (1 << 31)
 
 	/* Application-specific command.  true = precede with CMD55 */
 	int is_acmd;
-- 
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

