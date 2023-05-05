Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD0D6F8AA3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjEEVU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjEEVUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:20:25 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8F4525D
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 14:20:23 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id v2qdp5aQuunMHv2qdp7iGj; Fri, 05 May 2023 23:20:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1683321621;
        bh=Chl4Ea7MDMRy9oRAihtzEgVAW8tW0wY55Exuo89iUjU=;
        h=From:To:Cc:Subject:Date;
        b=VDmL2/yuUszQrahjQktLhU7UmxDcIthT3Kc3BmfKrkF8v1782xc9gi1rsKzBV6Jr1
         alZVo4TUS4OSxk54mCx7g5LYdf3/Nip8dvgxVYeN6LblIQaIRlazqJTWCpio4Gl5aV
         uKqf2ARkccMFeSBGoAsCBvQxLVlZPo0NgDT2GfRfo/JlX7ztVvUKDBIqNRfkUPGIAo
         ynpOk3+EU75vOS4ct1Wr5VdIahz9RHzlIVXnclq3j0hFoVlUYHgRq2f31dvcoIIxF2
         I2qmwfpqK1fPCxlZpwvCT1oeAuQG3A+GBnuJy1IGLl8u2yzxlynYpJtXVEfPMjRxIK
         zTeb+4SWWUqOQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 May 2023 23:20:21 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH net-next] netfilter: nft_set_pipapo: Use struct_size()
Date:   Fri,  5 May 2023 23:20:14 +0200
Message-Id: <28e34aff5c8ee86411b5ebab6ff223c99935047a.1683321566.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() instead of hand writing it.
This is less verbose and more informative.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
It will also help scripts when __counted_by macro will be added.
See [1].

[1]: https://lore.kernel.org/all/6453f739.170a0220.62695.7785@mx.google.com/
---
 net/netfilter/nft_set_pipapo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 06d46d182634..bf290cb53c76 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1274,8 +1274,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	struct nft_pipapo_match *new;
 	int i;
 
-	new = kmalloc(sizeof(*new) + sizeof(*dst) * old->field_count,
-		      GFP_KERNEL);
+	new = kmalloc(struct_size(new, f, old->field_count), GFP_KERNEL);
 	if (!new)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.34.1

