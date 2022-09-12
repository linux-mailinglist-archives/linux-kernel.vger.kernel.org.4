Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A495B61F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiILTx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiILTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:53:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A852148E9E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:53:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3495facb225so20790827b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=8sTMVM1/pnPvLF7fhqDPDLdOpTI5ZpSq4c3KVwZi7B8=;
        b=JrlBaDs0ZkKcl3Uk56oah+oPXYV2ZheDwVBv9jrNVxtlz2FH6mnmY94iYZRLTpQvUj
         7z4vpjmWLtQ9sp9dMaKpR+9vgB/3Bs0vVXtV2zBtxtv0UXBzmxSixyyqsOKBePffgeF+
         gco1M7LQLkIka0idwtLB3M/+4YJJBODTdHUC/nPD1Rk1xwISEXv/1c4VREAg+paaRPd8
         xg7KQ5ck7FlWg4rall0Gfbr9I+UVotJKbbsyfPSw6LW18TaAks1aH7FXbKLEXvuKW1I5
         vz+S69zmoF5F7yWO3/pOiUsk/rC1dSeGL1RL5pFgFvMKtVsG2aAMYzVTyD0e11Avzo5Q
         K9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=8sTMVM1/pnPvLF7fhqDPDLdOpTI5ZpSq4c3KVwZi7B8=;
        b=0mW+4tApQXs1+cVD8h6QOsQbAKrxKujJ1yd0Q23Whh5yOBf1pMfNrAvWKbKqlWBfgr
         C76ZV/sVTxD7I83jyxakO1WjnE4UZBGVCp1tkQXT0x9EBHer+qsWC8qEGb7vfH4GjGMW
         1QNITTCI2IUuiVBhfU9h3lzfaEKkkfP9aedYTBUHc7O/w969lkgHyEL3wg/CbHiTk7LQ
         JajyCDE17+MkXapvKwE3tUmF0Qjm3XwOFAbMqR8vSuU3q0AKCtKNGGf4T5Hp2xnfzzga
         8x0iall76QKL+YmhMZ9mdRK4XUkpos6zKCG4PS1935uJoSg5VgFc+I6EdKJuTj29Fb09
         MV9w==
X-Gm-Message-State: ACgBeo2UQut3tC2Rw19JJfJQordMV3IpnM0rLW3XJOmCBr9medRRtmjG
        HQ5RjX5KCY/WzQZNStoC/V5CUaoLIQ==
X-Google-Smtp-Source: AA6agR5d/Z544jZbE1LJyu1uNB6Y1C9nJRr/wEWCLOd9x2ozjDBcAgqEPSE4cPer2KDWhrbbquOwyiMjSw==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6902:1507:b0:6af:9e7:f947 with SMTP id
 q7-20020a056902150700b006af09e7f947mr6155067ybu.649.1663012399165; Mon, 12
 Sep 2022 12:53:19 -0700 (PDT)
Date:   Mon, 12 Sep 2022 12:53:07 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912195307.812229-1-nhuck@google.com>
Subject: [PATCH] net: ethernet: litex: Fix return type of liteeth_start_xmit
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ndo_start_xmit field in net_device_ops is expected to be of type
netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).

The mismatched return type breaks forward edge kCFI since the underlying
function definition does not match the function hook definition.

The return type of liteeth_start_xmit should be changed from int to
netdev_tx_t.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/net/ethernet/litex/litex_liteeth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index fdd99f0de424..35f24e0f0934 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -152,7 +152,8 @@ static int liteeth_stop(struct net_device *netdev)
 	return 0;
 }
 
-static int liteeth_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t liteeth_start_xmit(struct sk_buff *skb,
+				      struct net_device *netdev)
 {
 	struct liteeth *priv = netdev_priv(netdev);
 	void __iomem *txbuffer;
-- 
2.37.2.789.g6183377224-goog

