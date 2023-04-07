Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D718A6DA9A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjDGH4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjDGH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:56:18 -0400
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:df01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37EA6E82;
        Fri,  7 Apr 2023 00:56:15 -0700 (PDT)
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1fa8:0:640:3b74:0])
        by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id B289C60305;
        Fri,  7 Apr 2023 10:56:13 +0300 (MSK)
Received: from den-plotnikov-w.yandex-team.ru (unknown [2a02:6b8:b081:b507::1:25])
        by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4uLCdL0Od4Y0-uxaYAqh0;
        Fri, 07 Apr 2023 10:56:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1680854172; bh=9IRxraDMMRQpsr1I0/AtgfXObZe/EMARKPhOMkXb224=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=AQ7A+3uOBUEd0Xyw+fiUlB71zePlD05ZZbCypGYm4x0vtYJabG9mSKChjUoKmq1hv
         2WuOSSIkHlGl5eNRKV5EQ4AGMwLNqxLuHWaJHgNDJXshznZesMPIRy9YdrZLHw0sR0
         bnhF+GKdsMNU3+NLCXHQUV8BXKLot1lldfKkPXoQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From:   Denis Plotnikov <den-plotnikov@yandex-team.ru>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
        martin.petersen@oracle.com, nab@linux-iscsi.org, varun@chelsio.com,
        den-plotnikov@yandex-team.ru
Subject: [PATCH] cxgbit: check skb dequeue result in cxgbit_send_tx_flowc_wr()
Date:   Fri,  7 Apr 2023 10:56:03 +0300
Message-Id: <20230407075603.311230-1-den-plotnikov@yandex-team.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skb dequeuing may end up with returning NULL if a queue is empty,
which, in turn, may end up with further null pointer dereference.

Fix it by checking the return value of skb dequeuing end returning
before the pointer dereference.

Found by Linux Verification Center(linuxtesting.org) with SVACE.

Fixes: 9730ffcb8957 ("cxgbit: add files for cxgbit.ko")
Signed-off-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index d9204c590d9ab..426a5c795fd93 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -1424,10 +1424,13 @@ u32 cxgbit_send_tx_flowc_wr(struct cxgbit_sock *csk)
 #ifdef CONFIG_CHELSIO_T4_DCB
 	u16 vlan = ((struct l2t_entry *)csk->l2t)->vlan;
 #endif
+	skb = __skb_dequeue(&csk->skbq);
+
+	if (!skb)
+		return 0;
 
 	flowclen16 = cxgbit_tx_flowc_wr_credits(csk, &nparams, &flowclen);
 
-	skb = __skb_dequeue(&csk->skbq);
 	flowc = __skb_put_zero(skb, flowclen);
 
 	flowc->op_to_nparams = cpu_to_be32(FW_WR_OP_V(FW_FLOWC_WR) |
-- 
2.25.1

