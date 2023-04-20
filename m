Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C746E9BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjDTShr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjDTShk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F0524B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682015798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4qwGp/6dgqHFxVBe4E5Tv6rcAaAWlfJIcD3N6fbbtpE=;
        b=Zo2n5DBDd1CvabF9Vhgqr26ZUIyuLhLmwSdRBJID4g0a3TrMT3NJL/XtA1qISTY5b0UuRg
        m7BQw2qpZ/Go5vcjHeEDAm+PpXifLY8azzjQz8QdObkZq3SrNvVcGnIwDJl4uM1YUGXUFf
        Fbe/z7gqREZU3lIdfE7rOK64DdZmChg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-eEGeaDn7NISQPTdTicEhKQ-1; Thu, 20 Apr 2023 14:36:37 -0400
X-MC-Unique: eEGeaDn7NISQPTdTicEhKQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FD621C0898B;
        Thu, 20 Apr 2023 18:36:36 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.226.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C48D6492C3E;
        Thu, 20 Apr 2023 18:36:34 +0000 (UTC)
From:   Ivan Vecera <ivecera@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net/sched: cls_api: Initialize miss_cookie_node when action miss is not used
Date:   Thu, 20 Apr 2023 20:36:33 +0200
Message-Id: <20230420183634.1139391-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function tcf_exts_init_ex() sets exts->miss_cookie_node ptr only
when use_action_miss is true so it assumes in other case that
the field is set to NULL by the caller. If not then the field
contains garbage and subsequent tcf_exts_destroy() call results
in a crash.
Ensure that the field .miss_cookie_node pointer is NULL when
use_action_miss parameter is false to avoid this potential scenario.

Fixes: 80cd22c35c90 ("net/sched: cls_api: Support hardware miss to tc action")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 net/sched/cls_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 35785a36c80298..3c3629c9e7b65c 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3211,6 +3211,7 @@ int tcf_exts_init_ex(struct tcf_exts *exts, struct net *net, int action,
 #ifdef CONFIG_NET_CLS_ACT
 	exts->type = 0;
 	exts->nr_actions = 0;
+	exts->miss_cookie_node = NULL;
 	/* Note: we do not own yet a reference on net.
 	 * This reference might be taken later from tcf_exts_get_net().
 	 */
-- 
2.39.2

