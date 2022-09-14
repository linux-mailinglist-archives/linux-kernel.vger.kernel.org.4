Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CEA5B8FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiINVLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiINVLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:11:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0701482F8F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 14:11:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u12-20020a25094c000000b006a9ad6b2cebso14044249ybm.15
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=zaO32I0S7SQDvPMoMQFHJs6rEVWhhR1lhuEV3EVwoJQ=;
        b=srJs7ojePy/2F+EGwVPFW2Xg0p2htwMb7M/FUOue3qyJ60PKNMhCYFIwHxlTIEpyuU
         MQniu6tX64ZacV5YW8siBdEUSgNk9uHsN/mCsqQ7DXT1lXl7acz83KcBDlYuJYrVj1PN
         /vLpcUjsxOlwLVuZU7TQ2jbueY3Q3q8nSQYy2kZi3OEmM8HtSImTM9l4STcDt5/VQGmb
         i4pgFMexJqllHS2JkWrpYy8i3R7H7gXLlrzudNzpKGZEYoMPTKrZla+36YC+gPqbUrsT
         9Do9oDt34in+jFy869xC+kMlRYXEk6CoMoSS7cnH31Z0hXKRemrZHxSusvMmRnzVF4KY
         MZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=zaO32I0S7SQDvPMoMQFHJs6rEVWhhR1lhuEV3EVwoJQ=;
        b=FXzn49ltlgUWz9zbVObuX/bvqDx9QvQ5UlUKxuDdqS+NmVCl8PfZSw2ot5kbW4Q5T5
         g4Ic3rX+WKk1kZ+nTM8mjiixzMiqVBTP/YuH0zD+hIPp7X0OWDd06QYbSbVYu/blYqEF
         LhIk3jwqL9toIg9F0TTwvfHsOwnzMtLNHrbIPCgmMeGO6o16V6g7gorLZ/68q0w8hkbu
         eoJx+LT3A4lUuLCaezJlwa0yMq1nnnmkNt1dac3KT3krrwYVcKbmyomLgjwiqBw/+z0j
         hjhdIrsWNET21bMOe3pTALBBT4ksnEco1qEYqmfzw/+W+GYABiJ8GtuXN4RHWG6UvQBI
         hjWA==
X-Gm-Message-State: ACgBeo0RKf1UIiW+4FuSQA8Vku+h/HcCICfzxacDY2gRUHabHzPok8hT
        xOJ0c/qlho2SlLQQNaKCTrsh2IMhiw==
X-Google-Smtp-Source: AA6agR40trucsCxmeeqkHH598e41TopB2iE2aXOQN08JKcFE5YwuwOiaXPG/I/56gfefW7lNSGjICDPVyg==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:da82:0:b0:6a9:27d8:a671 with SMTP id
 n124-20020a25da82000000b006a927d8a671mr30748921ybf.142.1663189902345; Wed, 14
 Sep 2022 14:11:42 -0700 (PDT)
Date:   Wed, 14 Sep 2022 14:10:57 -0700
In-Reply-To: <YyEQr//Iq7bautrm@dev-arch.thelio-3990X>
Mime-Version: 1.0
References: <YyEQr//Iq7bautrm@dev-arch.thelio-3990X>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220914211057.423617-1-nhuck@google.com>
Subject: [PATCH v3] staging: octeon: Fix return type of cvm_oct_xmit and cvm_oct_xmit_pow
From:   Nathan Huckleberry <nhuck@google.com>
To:     nathan@kernel.org
Cc:     error27@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        llvm@lists.linux.dev, ndesaulniers@google.com, nhuck@google.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Nathan Chancellor <nathan@kernel.org>

---

Changes v1 -> v2:
- Update function signatures in ethernet-tx.h.

Changes v2 -> v3:
- Move changes below the scissors --- so they don't show in commit msg
- Add reviewed-by tag

 drivers/staging/octeon/ethernet-tx.c | 4 ++--
 drivers/staging/octeon/ethernet-tx.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/drivers/staging/octeon/ethernet-tx.h b/drivers/staging/octeon/ethernet-tx.h
index 78936e9b33b0..6c524668f65a 100644
--- a/drivers/staging/octeon/ethernet-tx.h
+++ b/drivers/staging/octeon/ethernet-tx.h
@@ -5,8 +5,8 @@
  * Copyright (c) 2003-2007 Cavium Networks
  */
 
-int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev);
-int cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev);
+netdev_tx_t cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev);
+netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, struct net_device *dev);
 int cvm_oct_transmit_qos(struct net_device *dev, void *work_queue_entry,
 			 int do_free, int qos);
 void cvm_oct_tx_initialize(void);
-- 
2.37.2.789.g6183377224-goog

