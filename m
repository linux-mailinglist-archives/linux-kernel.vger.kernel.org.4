Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3B65B62FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiILVq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiILVqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:46:03 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B544D15D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:46:02 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id k12-20020ab0538c000000b0039f64f6d1e2so3060479uaa.15
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=BRbgXY3xJYxM9YYiTldXX81aJSb/pUukVv6KYPaXnBg=;
        b=c/M9m3cQtWs5Pnn2DrO9HkM+4nSNPHTWCmSZ8RxTIRbxl4TQ4reaDmHt9dhCCZDvAt
         KOHpDRvuiZofWaeJnb1P0qL/9FBr3SxIHKnVvXfll3j8m+VSXT9jaDnQTgkm7We6BAwU
         97lmsYms3QxSOHIf1CocBAMA03ggAZXO86m21rrwqgpxAluJOPTDLXjumCse3e6KlGbE
         9hNowCqmyKuXvqIPv4G2OjslpKdi/cFk77Lf9nSY2/TmDhnOPFZicL0/oLzwPVRYLwmz
         vuUEqG0HAolRHc+hAtf8adosPmO4qKlP6+JS7Ez2bQJ2VJEV2Mb7+8DRKl8ecfbnhiKJ
         l2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=BRbgXY3xJYxM9YYiTldXX81aJSb/pUukVv6KYPaXnBg=;
        b=UrBCvScu0pylB/8Myl9JP/ad/ehHPNflTjNccxSS5/es1ywUhZZjvIKOln2glPZysC
         P+3mKGZf6J477axRVPLKnWtVTkiZmPnEjfpoL8g6YcGtQDtxYY4j2HZPkLVC66Ox6Hx4
         1LXOdhCBzf+uDV05/ZFjL6KQqHQtZ7Pi845qJxtVVDDZnvAp6V/q2nMbtshc21QTdUjo
         LXOHBM1vg+F+eRtxtlwqViwDeVCczZoDa+o7PIwYpkNIZIVjVTZW3IBrd4kquM6YJg0c
         xrWhIDHlRMllQ9kOOazk3FCzxbVLpiwrTbavxB3NNpJDfvvXpn8eCarjaWckeWQ4K2sU
         vmow==
X-Gm-Message-State: ACgBeo3h2wt3H+uIc8GK4w4+zOPPyjYzqzXVQOaCG4TEJrYexg4zxEsB
        AHimsG/u1figA3NJBZ6fXSEllnVTYg==
X-Google-Smtp-Source: AA6agR5xBByy/fS0NrDukCjY5rekFdT4IFKnlapx4jdlHE1l/syccKxffvQh9NQO9JdsJbFrqsl3sAd60w==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a67:ec86:0:b0:398:4db6:61d with SMTP id
 h6-20020a67ec86000000b003984db6061dmr6431963vsp.27.1663019161870; Mon, 12 Sep
 2022 14:46:01 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:45:56 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912214559.929186-1-nhuck@google.com>
Subject: [PATCH] staging: rtl8192u: Fix return type of ieee80211_xmit
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-staging@lists.linux.dev,
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

The return type of ieee80211_xmit should be changed from int to
netdev_tx_t.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
index 8602e3a6c837..e4b6454809a0 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -526,7 +526,7 @@ static void ieee80211_query_seqnum(struct ieee80211_device *ieee,
 	}
 }
 
-int ieee80211_xmit(struct sk_buff *skb, struct net_device *dev)
+netdev_tx_t ieee80211_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ieee80211_device *ieee = netdev_priv(dev);
 	struct ieee80211_txb *txb = NULL;
@@ -822,13 +822,13 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_device *dev)
 			if ((*ieee->hard_start_xmit)(txb, dev) == 0) {
 				stats->tx_packets++;
 				stats->tx_bytes += __le16_to_cpu(txb->payload_size);
-				return 0;
+				return NETDEV_TX_OK;
 			}
 			ieee80211_txb_free(txb);
 		}
 	}
 
-	return 0;
+	return NETDEV_TX_OK;
 
  failed:
 	spin_unlock_irqrestore(&ieee->lock, flags);
-- 
2.37.2.789.g6183377224-goog

