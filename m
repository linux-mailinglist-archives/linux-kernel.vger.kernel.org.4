Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7267B04A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbjAYKtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbjAYKsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:48:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49418577C9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:48:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j17so13442303wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXq3Avj7Ia8STiRseUvkMdz+nkGFrD8MDyDhjItUgZ8=;
        b=Wur4C2zWjCI8Asl5c9hZMTT3sZn9cjfsd/imODr8jiIbWg2utFuKle7NCMyqROPvCg
         KOtHVC3thoZsYqOUe5p+cL2vr09XxgnjsFI0zPki+QNPZPqJUNbrKj8wReonZO6gp0m+
         Dsf+iFk4nCPHeH+eEkJK+s1Zbh+p1rYEv8kTHvODVdnL6jFQGVFnbzjeiRSkcpyt+B+U
         QVjYPjQijYkWd13c7oZ7Mpqv+I57Te2nn5bjx0f28CYqS1ma0+clOA0cX0+sAyPylkit
         r59ch+f9QuDRd3NoRBiVaS4/sXNfkzcHDu2lZYmaCJBZ0140IMWu6g3N7WUS8YOqW2pT
         /9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXq3Avj7Ia8STiRseUvkMdz+nkGFrD8MDyDhjItUgZ8=;
        b=oAh2+EnAmSdFV26bYhd9eMUHyxIrobGDBNbPwyGd2P5EDNE9WEDC1pYZ8qlJt+UJE7
         3dLS/4zRXry24lPk2HVm3x2iIX6h8KZ3fOLSj31zvODQdCaiswqL7FKosvVekLIgKosp
         qMOmP9ICUSODwMm4JD69vIEZSo3jf2iGF2djLZMyBHCNAG+fQvlevlj362UoEXmrYQ8Q
         wY3EU6s7nFolh4S1TtOw8QO6YcZYqkHDopGFSiCJa6zmoj+HnDHigrqQvZTkYl2lAp+o
         S4XnGfxR4QsF4Fd4bC+w1RqiOEigio7jOqyJLyyjlSXZ4bR24A5H1qpeHWobY0zbKJ7I
         Os6A==
X-Gm-Message-State: AFqh2krOFXe/K4BnlfSetbeTThvRhSBtXmOGlBof764PA9m/3PgnTCg4
        MzQcpolxKhL1Y5tmoX7SAmjsrA==
X-Google-Smtp-Source: AMrXdXvn0HACeS8LJ/C2jvP/y57b5wioOgNRDiLdlZnr54wRNnVsnWwx5JQQUzoKyMJ9Ps9wUypvWA==
X-Received: by 2002:a05:600c:995:b0:3da:f4f5:ad0e with SMTP id w21-20020a05600c099500b003daf4f5ad0emr30563030wmp.9.1674643683112;
        Wed, 25 Jan 2023 02:48:03 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c424100b003d9a86a13bfsm1423692wmm.28.2023.01.25.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 02:48:02 -0800 (PST)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Wed, 25 Jan 2023 11:47:24 +0100
Subject: [PATCH net-next 4/8] mptcp: userspace pm: use a single point of
 exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230123-upstream-net-next-pm-v4-v6-v1-4-43fac502bfbf@tessares.net>
References: <20230123-upstream-net-next-pm-v4-v6-v1-0-43fac502bfbf@tessares.net>
In-Reply-To: <20230123-upstream-net-next-pm-v4-v6-v1-0-43fac502bfbf@tessares.net>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=dfU/VzhUn11O3qEpjl/vqz1Tgffa83ykPXnKKZNhRsI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj0QjdSynCqBueplEAutVxF8XpEvKj6AH25SGaDR3Z
 VpY4GTOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY9EI3QAKCRD2t4JPQmmgc5ixEA
 CiGP0kDzZIj0bLp9ngOjBvEPvfF9YM8bXqPIcY8jWVvF4fYVDH4r6xt01AUeffQ9sxPIjZop0mfrmM
 IrLc4aJ0xJTbct88AjPMZ3aUVLw86f2kkqsdwJlDTHmtSLYQajARUE0sAleD+w/L5sCHPFlMz8MGaE
 7gC4Aqha0tNoOKA0yTHqB8sQH9y0in6G8qJYUCXbIlBGFsfkK1quqyo8LSVzIlw8WsFvt1LJmRxhlt
 pumUAC9rNWh0cgL7DVaYiajL5FpduyVfj6NrMCN1lQWXLSeUq38eJswGkzIG7upaoE5i9W+lN8dDHC
 6IBV744XVoViuyxUP0ftPpHsFJWnc7AR+TGjsGHGJwwaV5SuDV7ZX7hRsb35bFMEvr6zSgBYM88tdF
 75TKxe4Xvs/t2YGBS9jzbSFPGJYM8Xx5oNob33G6RL8A4r6lgLEj1zKlbdEOhea6cWpNn8dHXud6N3
 ws93sn6Donfu2euV3zCxVrEj/fkCTKxLE+lDEQOZQpQuTrN2tWMza94s/zMVKW4Ty9oJZQsVL3P032
 ZhOm7obdLJqpWKx3g991D+CRYIHTWbBtAf925Fbj4EZVxdFCEv++k2k/1oqy980ymkNLDtjHsPswOf
 oA4bqSm1A3eCycjEFmp1hWOUOa15lxgD3mVQfATAwxRo6Iw3PuyjxvaFTQ5w==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like in all other functions in this file, a single point of exit is used
when extra operations are needed: unlock, decrement refcount, etc.

There is no functional change for the moment but it is better to do the
same here to make sure all cleanups are done in case of intermediate
errors.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_userspace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ea6ad9da7493..a02d3cbf2a1b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -59,8 +59,8 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		 */
 		e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
 		if (!e) {
-			spin_unlock_bh(&msk->pm.lock);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto append_err;
 		}
 
 		*e = *entry;
@@ -74,6 +74,7 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		ret = entry->addr.id;
 	}
 
+append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
 }

-- 
2.38.1

