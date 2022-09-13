Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E815B7D52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIMXEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiIMXEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:04:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B02319281
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:04:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b14-20020a056902030e00b006a827d81fd8so11382644ybs.17
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=VoIodNAnmmutIkoqOpnBoW0YBXYHtgCdR1yf8yeK5IQ=;
        b=keReOhtGhNji5tpwnM1NBgoLrnTcw0fB05edrdBxdXd89kfrGDmh9S+lIJO8X70vyW
         X4GjgmPzU4uLtqi9XWWUbzu8WPf/9dQ3IbCTMo7m3ENFp8NIRL5UMmVvyqLyR+6moG/C
         Trl4CnP+H+2TckeDnVWjII67+zTZFKhADz8B3t9A5yd4hinzfXWl9YlK39WEKEYdhaXu
         NHL5u+cLCQ3e6Sv+ZYYX8IoXZ+tn5ztv/RHryVg7xr7/U+i1bn2EceKQ9Qtc2S5gy11/
         QC19KAOC+I/Qxv4O8YWJxq3xB2D1U7+HSjOGGmb2C03FwQOvVg2ShEoCLcTLDf2gcVHm
         10tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=VoIodNAnmmutIkoqOpnBoW0YBXYHtgCdR1yf8yeK5IQ=;
        b=CKF6DDkG0e5JEbQjw4F5QKVqB3+L+0kaAQzfGSFYjot3NRbN3hrPOvBbl/8+w7+h49
         ytF0S7uTgIjyItxoPs4ZVVZ5C3EOrD8NJt/9AVjhkCVRRgYMTJUlS6KG2lkySmNaOL+2
         9v1UoeJ7R+rUjIq8AhyuG1un47+NAg6bxFdZYfy9TQ6IwX5Hdh8OAIWsv0tkoE/+8tWO
         VCmdt+w13uWKm6QekcCrZD1Fudx1PbHlQiP1PQQS0irhpjA+gdMdXARzfl70fdJ2a7lM
         XrzLSyjZQUoWsGM0KHgtG7Bb21r9Fx/tobskR3UqSFyq8oZy/oAjVNaCZB6LbaRygTPE
         3i6Q==
X-Gm-Message-State: ACgBeo1Ej91K+9wS2ew6ekSJFN07lW5A+YUuenC5FQDFdJNaODc80/4+
        l4dypDKIvNgHKOO973yiiZz9vCj5Ew==
X-Google-Smtp-Source: AA6agR6kRk1tNy6FLgwlWguPj9/VwK8Nu6tWQw7CkASTOM2LQwF+7naqkL6EsbmyXuuaDYitWR62XutLSQ==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:8a85:0:b0:671:715e:a1b0 with SMTP id
 h5-20020a258a85000000b00671715ea1b0mr27208374ybl.98.1663110279353; Tue, 13
 Sep 2022 16:04:39 -0700 (PDT)
Date:   Tue, 13 Sep 2022 16:04:12 -0700
In-Reply-To: <YyEFu8uzoxK64p0Y@dev-arch.thelio-3990X>
Mime-Version: 1.0
References: <YyEFu8uzoxK64p0Y@dev-arch.thelio-3990X>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220913230412.225957-1-nhuck@google.com>
Subject: [PATCH v2] staging: octeon: Fix return type of cvm_oct_xmit and cvm_oct_xmit_pow
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

Changes v1 -> v2:
 - Update function signatures in ethernet-tx.h.

---
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

