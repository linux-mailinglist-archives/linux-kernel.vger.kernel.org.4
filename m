Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9469C71849C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbjEaOSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbjEaOSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCA7137
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18020634C6
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F541C433D2;
        Wed, 31 May 2023 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685542585;
        bh=6xPVFqexSIW7Z9IDBUUq4nFv5EZETSZ0A3H+jexY8Ug=;
        h=From:To:Cc:Subject:Date:From;
        b=mO68rUpe21FDD87sqVUTxkHqsjWPBsyqdMq9X0kKabvZb5rCQuye9Ls2ovHj46Esm
         toJZVU3bPGB+7TO9sKR1unvcK2cqZJgibVtbPqNtD2CxdQtJ7nCuj713Qj0a3hCj5m
         C4cHGoMroa63d+q6HIrRBBG+XGn2acHkI52BrjqwqN2jU0upMi6Rg4sHrprNQnrgFL
         +xSP8hbglakFAPuRQ1UmjU7lZLiJWAXqkPSyzGSJ62wQrnArUxbaUvG8LBu9Jsqb4z
         syWYHiynewVeLFY5S9kOMIrPdz4dNfwP0uMp1x2RV12GwAJntAmp5Iqsrcydl02Y8a
         2cj1fk/xnT+Qw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        stable@kernel.org
Subject: [PATCH 1/1] net/sched: cls_u32: Fix reference counter leak leading to overflow
Date:   Wed, 31 May 2023 15:15:56 +0100
Message-ID: <20230531141556.1637341-1-lee@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event of a failure in tcf_change_indev(), u32_set_parms() will
immediately return without decrementing the recently incremented
reference counter.  If this happens enough times, the counter will
rollover and the reference freed, leading to a double free which can be
used to do 'bad things'.

Cc: stable@kernel.org # v4.14+
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/sched/cls_u32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 4e2e269f121f8..fad61ca5e90bf 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -762,8 +762,11 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 	if (tb[TCA_U32_INDEV]) {
 		int ret;
 		ret = tcf_change_indev(net, tb[TCA_U32_INDEV], extack);
-		if (ret < 0)
+		if (ret < 0) {
+			if (tb[TCA_U32_LINK])
+				n->ht_down->refcnt--;
 			return -EINVAL;
+		}
 		n->ifindex = ret;
 	}
 	return 0;
-- 
2.41.0.rc0.172.g3f132b7071-goog

