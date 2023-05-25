Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E457116C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbjEYS7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243711AbjEYSzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:55:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB274211;
        Thu, 25 May 2023 11:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89A8161005;
        Thu, 25 May 2023 18:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73233C4339B;
        Thu, 25 May 2023 18:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040369;
        bh=aiwGZX9A1dm+W7t7RvS1joJZieCuxjIYDOH/kE+p8eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WEgsDyAUxXlNP09O1SWAzLANwBQyevzbrqKdu+1/TZy0NziDwzJzH1tmvDGFgrmaR
         o+0xRMOcvzJyMYGQvBf3dFotxE0ItHfzbf0cP7QUm16so4Mu+SCv2f6SDT+/aNsFeX
         RMdgUQkKBV++nmX+KuXJ8UJkeEw+RsTCaCAoNrIyWlRVQMtjYmxKDCxfL1Cu0jWJmF
         FXujMFUsDwHULoAXx6naXG+NqCzTEqQrKo9/oUA4jROB8LvQqwsJLHDA8lKwFx112x
         tyKbutgqsw5UY8kQXKu8DrHN6YM9gLDl+XxDfFtwoj7kAr2M5CgHIhtt6E+h6xO/i0
         wrySa9kY70WWQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tom Rix <trix@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>, pablo@netfilter.org,
        kadlec@netfilter.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 17/20] netfilter: conntrack: define variables exp_nat_nla_policy and any_addr with CONFIG_NF_NAT
Date:   Thu, 25 May 2023 14:45:13 -0400
Message-Id: <20230525184520.2004878-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184520.2004878-1-sashal@kernel.org>
References: <20230525184520.2004878-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

[ Upstream commit 224a876e37543eee111bf9b6aa4935080e619335 ]

gcc with W=1 and ! CONFIG_NF_NAT
net/netfilter/nf_conntrack_netlink.c:3463:32: error:
  ‘exp_nat_nla_policy’ defined but not used [-Werror=unused-const-variable=]
 3463 | static const struct nla_policy exp_nat_nla_policy[CTA_EXPECT_NAT_MAX+1] = {
      |                                ^~~~~~~~~~~~~~~~~~
net/netfilter/nf_conntrack_netlink.c:2979:33: error:
  ‘any_addr’ defined but not used [-Werror=unused-const-variable=]
 2979 | static const union nf_inet_addr any_addr;
      |                                 ^~~~~~~~

These variables use is controlled by CONFIG_NF_NAT, so should their definitions.

Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_netlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 733e61fc50433..1d0abd8529e62 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2531,7 +2531,9 @@ static int ctnetlink_exp_dump_mask(struct sk_buff *skb,
 	return -1;
 }
 
+#if IS_ENABLED(CONFIG_NF_NAT)
 static const union nf_inet_addr any_addr;
+#endif
 
 static __be32 nf_expect_get_id(const struct nf_conntrack_expect *exp)
 {
@@ -3031,10 +3033,12 @@ ctnetlink_change_expect(struct nf_conntrack_expect *x,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_NF_NAT)
 static const struct nla_policy exp_nat_nla_policy[CTA_EXPECT_NAT_MAX+1] = {
 	[CTA_EXPECT_NAT_DIR]	= { .type = NLA_U32 },
 	[CTA_EXPECT_NAT_TUPLE]	= { .type = NLA_NESTED },
 };
+#endif
 
 static int
 ctnetlink_parse_expect_nat(const struct nlattr *attr,
-- 
2.39.2

