Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862AD711590
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242449AbjEYSoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242325AbjEYSnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:43:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1816173C;
        Thu, 25 May 2023 11:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4428163985;
        Thu, 25 May 2023 18:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296B2C4339C;
        Thu, 25 May 2023 18:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039909;
        bh=neEQQcwzMS4leMh2rFFk6gXw/rhv/YocNDnT7xN7yCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OE3LUJC1pMQpHeEv42T5pkQSVOUCp7A9NpN+OZpxRgY8dMIHLtLFotit9zakmxzyD
         XwqlcZL/sNrb0mzEj7HISMgjJ2HBLErfQwua8xlh7TwMRNC7DR26M9GilaHf6T/1YS
         x243PgDiz470CXU/MBepQxgmlmRMAEbboo8+cRfKREq90AnGwIiUmBQrRWVlBps8Zd
         pXIDLveSHZu9FrJYqyHVsiy+KQoR5K1RDxgJaB5A0sSiIAkoTWt4QLv/rp2cDySbzU
         QJDTwKFkD8H5HEmi/BuL6INBfjwArfnJg2kbJF2i0uTuoiRvZxlNGlg6J2YMvNnG3m
         CT3yupPFW/IHg==
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
Subject: [PATCH AUTOSEL 6.1 46/57] netfilter: conntrack: define variables exp_nat_nla_policy and any_addr with CONFIG_NF_NAT
Date:   Thu, 25 May 2023 14:35:56 -0400
Message-Id: <20230525183607.1793983-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index cb4325b8ebb11..2c21b4ed87c37 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2984,7 +2984,9 @@ static int ctnetlink_exp_dump_mask(struct sk_buff *skb,
 	return -1;
 }
 
+#if IS_ENABLED(CONFIG_NF_NAT)
 static const union nf_inet_addr any_addr;
+#endif
 
 static __be32 nf_expect_get_id(const struct nf_conntrack_expect *exp)
 {
@@ -3468,10 +3470,12 @@ ctnetlink_change_expect(struct nf_conntrack_expect *x,
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

