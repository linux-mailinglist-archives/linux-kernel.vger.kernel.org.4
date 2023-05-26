Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22C7125E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjEZLtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243374AbjEZLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:49:11 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AA919A;
        Fri, 26 May 2023 04:49:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VjWOl8M_1685101744;
Received: from h68b04305.sqa.eu95.tbsite.net(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VjWOl8M_1685101744)
          by smtp.aliyun-inc.com;
          Fri, 26 May 2023 19:49:04 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net/smc: Scan from current RMB list when no position specified
Date:   Fri, 26 May 2023 19:49:00 +0800
Message-Id: <1685101741-74826-2-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1685101741-74826-1-git-send-email-guwen@linux.alibaba.com>
References: <1685101741-74826-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When finding the first RMB of link group, it should start from the
current RMB list whose index is 0. So fix it.

Fixes: b4ba4652b3f8 ("net/smc: extend LLC layer for SMC-Rv2")
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_llc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index a0840b8..8423e8e 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -578,7 +578,10 @@ static struct smc_buf_desc *smc_llc_get_next_rmb(struct smc_link_group *lgr,
 {
 	struct smc_buf_desc *buf_next;
 
-	if (!buf_pos || list_is_last(&buf_pos->list, &lgr->rmbs[*buf_lst])) {
+	if (!buf_pos)
+		return _smc_llc_get_next_rmb(lgr, buf_lst);
+
+	if (list_is_last(&buf_pos->list, &lgr->rmbs[*buf_lst])) {
 		(*buf_lst)++;
 		return _smc_llc_get_next_rmb(lgr, buf_lst);
 	}
-- 
1.8.3.1

