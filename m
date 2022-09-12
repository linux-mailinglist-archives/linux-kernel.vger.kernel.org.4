Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CD75B62F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiILVpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiILVpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:45:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96151A806
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:45:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-34577a9799dso84615347b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=UPrLPANI270ughyuxViugAgaASicl0Pl0QAaTiYiZSU=;
        b=R1Le7k+VwrXVecUa6OZKaJ79w//eIJLti1Jyw+PUIhDm0w+ec3Z4KpM08qMUq4J4Ih
         X1dA2kBrdB748En0e3hNxPuYHE4gpDmIgmyCX0efxNdXvhAZ0x0q+plG9EP6I+HfGq/x
         DzRvhIM0lYe93sfYf2e9aJIe/JUODjYK7PUBI+vbg86M4eNF0mdH/eOJlyKQwre7tVo7
         ywKdDiMqiOsdv7qoLguoncmJY0TwP++H3CeoYv6FSBwVnGk5HLFKuI4aofaU5cfJtHXg
         k/fYJVUKlDh4EFjmieSJ2Tcw/Z1uNnFkggPx0ncAl/XPANWG26uBgcB7S1b12vCwe4XO
         EbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=UPrLPANI270ughyuxViugAgaASicl0Pl0QAaTiYiZSU=;
        b=uDztj8oO3P/WTtk0CPDfHGCrdq0Ie4SnEovLiXXjCU/+mjUC1hKD1zGj43KF9zzVfc
         ftVAm+Lm35LtqRbKXiT6j5KVCQic3NqHzL8vLkMlGLjUtJ1yTFsw2T0UiiXBtulwRXXT
         vJDtuWSk25QUmPGbgjnp/szl4/DNsIJAlLeZLlUuz0pcQWV9lJiullaKaSx9oKeO3jsQ
         xXAtkdDO8FKDEhVAtsEp0RIW3hqQR+QQBdWx/J4ZN0byBfickTJzhdtS3mQaKpjb7duS
         Z+7oVO30MbJOX/sDaobhqTKHznLbGJEo7mrKMj0GtXJr9y9jGQLewLh9iDZ5IzB5TQe/
         LazQ==
X-Gm-Message-State: ACgBeo0dUcgEd9HEwDcga+QFIDtyoHubtGl4M8goRixhROuDclRTg1BL
        xs39ZXATL8riRszwi3X0Ki1vcgSWxQ==
X-Google-Smtp-Source: AA6agR7wl8T56FQKposQuML7IiGJlnt7l5akwYku8eHDk4YWCMC49E42ZZfegTNAPb5Nml37R59A5ESsEA==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a81:a093:0:b0:345:c52:945c with SMTP id
 x141-20020a81a093000000b003450c52945cmr23447907ywg.341.1663019128940; Mon, 12
 Sep 2022 14:45:28 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:45:20 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912214523.929094-1-nhuck@google.com>
Subject: [PATCH] staging: octeon: Fix return type of cvm_oct_xmit and cvm_oct_xmit_pow
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

The return type of cvm_oct_xmit and cvm_oct_xmit_pow should be changed
from int to netdev_tx_t.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/staging/octeon/ethernet-tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index 1ad94c5060b5..a36e36701c74 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -125,7 +125,7 @@ static void cvm_oct_free_tx_skbs(struct net_device *dev)
  *
  * Returns Always returns NETDEV_TX_OK
  */
-int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
+netdev_tx_t cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	union cvmx_pko_command_word0 pko_command;
 	union cvmx_buf_ptr hw_buffer;
@@ -506,7 +506,7 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
  * @dev:    Device info structure
  * Returns Always returns zero
  */
-int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
+netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev)
 {
 	struct octeon_ethernet *priv = netdev_priv(dev);
 	void *packet_buffer;
-- 
2.37.2.789.g6183377224-goog

