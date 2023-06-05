Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC17172257D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjFEMVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjFEMU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:20:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEDDED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 05:20:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso1562099e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685967652; x=1688559652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNB7ncYWiGhaeYkWNPW5gYba3J8tGI2ndLv0p6rgqUk=;
        b=T3TnB1RNh23mLRxO58rz94xagXk7eZ2jcz28ZbqINKkDKESW8OKH+cd90fbVi7Msxl
         VsPNS60PyC66G/uxayQf2rrQBA7ktGSqBLxvEBuSqKNIsLXCZBMp2NVGMBi46amGQ5Pw
         96jK7iPNTJ/Vj5Qard1kJFqppNPhJ7Vd64QdUd3UgEPGTWZwuRFZlH79nBlSks1BxhFX
         QgU5lO6KtAcWAZMGjsJowWNLFQtdz1CfgBhFZ+S8KshbaHDCLr0aHm8EJP4cSOHeau75
         wQR8pRYthfF7vgdgIBx6XxMc0Vcc4WK7cT5EvlGZ7krClhEL/irJRxEP11aVcmm+ZwSF
         igAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685967652; x=1688559652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNB7ncYWiGhaeYkWNPW5gYba3J8tGI2ndLv0p6rgqUk=;
        b=MQX2T+FSRrWFuM6JUx7mpJa8gO19OuYTJVcvzL3pTkCnq2kRRbya7KDWY19B1wwXNh
         q4J3PFH3mCwVd8ctPzAbP1Lii3t3gQfWecJ+/JmWCglC6ncvxGSEKaSlKO4T6g8X1lQU
         eaoZWZ8Vtcd8qKymIeXImTF/E3tBbJ6lXWPtdFbE70pLMWggIdJ48nUvnsBtKKa7vDh/
         1YulxvNu4j+QdBln7kea5BJhYPb25H6f7ONAIY11GaA0y8MEaVf6e3IpZWVf7ItwEspg
         bYq17nMytglsEHlgNL6qD71f6499oKN/Zomu6m3jcMVFUwEf5T+GItJcuB3OwaeSgiIB
         EGpg==
X-Gm-Message-State: AC+VfDxE1LDp0nFrLuWVZfvTJIsPiMNL5bZJ8AWHoODF8R+BHkeypCzB
        +VzHquYcYGT1IoQztczB/aoDXg==
X-Google-Smtp-Source: ACHHUZ7BkMF5vEQkJaZDDBGNUcejtqjF8Q51kKE1TNN2IlITaOodjqLy4sBDph1ag74QNghiwzuuUA==
X-Received: by 2002:ac2:51a2:0:b0:4f6:2c98:3957 with SMTP id f2-20020ac251a2000000b004f62c983957mr981309lfk.32.1685967651783;
        Mon, 05 Jun 2023 05:20:51 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id e8-20020a056512090800b004f20d0ebe50sm1106952lft.94.2023.06.05.05.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:20:51 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc:     kuba@kernel.org, simon.horman@corigine.com, joneslee@google.com,
        oliver@neukum.org, davem@davemloft.net, bay@hackerdom.ru,
        linux-usb@vger.kernel.org, netdev@vger.kernel.or,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        syzbot+9f575a1f15fc0c01ed69@syzkaller.appspotmail.com
Subject: [PATCH][stable-4.{14,19}.y 3/3] net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize
Date:   Mon,  5 Jun 2023 12:20:45 +0000
Message-ID: <20230605122045.2455888-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230605122045.2455888-1-tudor.ambarus@linaro.org>
References: <20230605122045.2455888-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7e01c7f7046efc2c7c192c3619db43292b98e997 ]

Currently in cdc_ncm_check_tx_max(), if dwNtbOutMaxSize is lower than
the calculated "min" value, but greater than zero, the logic sets
tx_max to dwNtbOutMaxSize. This is then used to allocate a new SKB in
cdc_ncm_fill_tx_frame() where all the data is handled.

For small values of dwNtbOutMaxSize the memory allocated during
alloc_skb(dwNtbOutMaxSize, GFP_ATOMIC) will have the same size, due to
how size is aligned at alloc time:
	size = SKB_DATA_ALIGN(size);
        size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
Thus we hit the same bug that we tried to squash with
commit 2be6d4d16a084 ("net: cdc_ncm: Allow for dwNtbOutMaxSize to be unset or zero")

Low values of dwNtbOutMaxSize do not cause an issue presently because at
alloc_skb() time more memory (512b) is allocated than required for the
SKB headers alone (320b), leaving some space (512b - 320b = 192b)
for CDC data (172b).

However, if more elements (for example 3 x u64 = [24b]) were added to
one of the SKB header structs, say 'struct skb_shared_info',
increasing its original size (320b [320b aligned]) to something larger
(344b [384b aligned]), then suddenly the CDC data (172b) no longer
fits in the spare SKB data area (512b - 384b = 128b).

Consequently the SKB bounds checking semantics fails and panics:

skbuff: skb_over_panic: text:ffffffff831f755b len:184 put:172 head:ffff88811f1c6c00 data:ffff88811f1c6c00 tail:0xb8 end:0x80 dev:<NULL>
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:113!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 57 Comm: kworker/0:2 Not tainted 5.15.106-syzkaller-00249-g19c0ed55a470 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: mld mld_ifc_work
RIP: 0010:skb_panic net/core/skbuff.c:113 [inline]
RIP: 0010:skb_over_panic+0x14c/0x150 net/core/skbuff.c:118
[snip]
Call Trace:
 <TASK>
 skb_put+0x151/0x210 net/core/skbuff.c:2047
 skb_put_zero include/linux/skbuff.h:2422 [inline]
 cdc_ncm_ndp16 drivers/net/usb/cdc_ncm.c:1131 [inline]
 cdc_ncm_fill_tx_frame+0x11ab/0x3da0 drivers/net/usb/cdc_ncm.c:1308
 cdc_ncm_tx_fixup+0xa3/0x100

Deal with too low values of dwNtbOutMaxSize, clamp it in the range
[USB_CDC_NCM_NTB_MIN_OUT_SIZE, CDC_NCM_NTB_MAX_SIZE_TX]. We ensure
enough data space is allocated to handle CDC data by making sure
dwNtbOutMaxSize is not smaller than USB_CDC_NCM_NTB_MIN_OUT_SIZE.

Fixes: 289507d3364f ("net: cdc_ncm: use sysfs for rx/tx aggregation tuning")
Cc: stable@vger.kernel.org
Reported-by: syzbot+9f575a1f15fc0c01ed69@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=b982f1059506db48409d
Link: https://lore.kernel.org/all/20211202143437.1411410-1-lee.jones@linaro.org/
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230517133808.1873695-2-tudor.ambarus@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/net/usb/cdc_ncm.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index ae2a44ceb23d..65dac36d8d4f 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -180,9 +180,12 @@ static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
 	else
 		min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth32);
 
-	max = min_t(u32, CDC_NCM_NTB_MAX_SIZE_TX, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize));
-	if (max == 0)
+	if (le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize) == 0)
 		max = CDC_NCM_NTB_MAX_SIZE_TX; /* dwNtbOutMaxSize not set */
+	else
+		max = clamp_t(u32, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize),
+			      USB_CDC_NCM_NTB_MIN_OUT_SIZE,
+			      CDC_NCM_NTB_MAX_SIZE_TX);
 
 	/* some devices set dwNtbOutMaxSize too low for the above default */
 	min = min(min, max);
@@ -1230,6 +1233,9 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 			 * further.
 			 */
 			if (skb_out == NULL) {
+				/* If even the smallest allocation fails, abort. */
+				if (ctx->tx_curr_size == USB_CDC_NCM_NTB_MIN_OUT_SIZE)
+					goto alloc_failed;
 				ctx->tx_low_mem_max_cnt = min(ctx->tx_low_mem_max_cnt + 1,
 							      (unsigned)CDC_NCM_LOW_MEM_MAX_CNT);
 				ctx->tx_low_mem_val = ctx->tx_low_mem_max_cnt;
@@ -1248,13 +1254,8 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 			skb_out = alloc_skb(ctx->tx_curr_size, GFP_ATOMIC);
 
 			/* No allocation possible so we will abort */
-			if (skb_out == NULL) {
-				if (skb != NULL) {
-					dev_kfree_skb_any(skb);
-					dev->net->stats.tx_dropped++;
-				}
-				goto exit_no_skb;
-			}
+			if (!skb_out)
+				goto alloc_failed;
 			ctx->tx_low_mem_val--;
 		}
 		if (ctx->is_ndp16) {
@@ -1447,6 +1448,11 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 
 	return skb_out;
 
+alloc_failed:
+	if (skb) {
+		dev_kfree_skb_any(skb);
+		dev->net->stats.tx_dropped++;
+	}
 exit_no_skb:
 	/* Start timer, if there is a remaining non-empty skb */
 	if (ctx->tx_curr_skb != NULL && n > 0)
-- 
2.41.0.rc0.172.g3f132b7071-goog

