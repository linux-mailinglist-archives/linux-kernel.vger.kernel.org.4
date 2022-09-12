Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62395B61D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiILTr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 15:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiILTrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 15:47:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F1481C3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:47:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p12-20020a259e8c000000b006958480b858so8165442ybq.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=GgY4PD0XdGxMhCUuq3XqhucmQpNzXv+vjyVGjdIJj2M=;
        b=V6C+VfKk/2QPgJkI01g/ulQ507A+EpfDlY95WsN1ZobPp77HMgvmJE1SJ63ZqKEqjm
         O6wHz+82hTeMs+E5hAFLuFtGh0rpPXzVTzY3apHgwavbbEwmrPYjnYhr9XTnPkSoMXBM
         x34E87UW41lC+Hevg6hT3L2/VuyRcpSH0bPrBPNKSmP9T92dWjQsQ5ts6WxPO5WSEgk8
         8lxUULlr2f8AM+kLOdkjCnicwASkSWX/ShO7fJbyiklvH47HGWqUnX3ztRTW0ZyXUPUN
         IV0YbiFzwztjTe2vya12UKYFWxWvfZQjf++rU9noncjlCfrkqp16oEM1XZJ2sxrWNLIh
         u+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=GgY4PD0XdGxMhCUuq3XqhucmQpNzXv+vjyVGjdIJj2M=;
        b=7NbgKaLxi3120Ju3jfMMKbKYtmrxKdf2xr5nel0mPqIG8AJ8vhtVIWiDRf3DO9PP2e
         VaHFQ0j9/QUaZ8r6B5cvGtwvumj4jnC7/j+lYME9JjL9nKsMHNfdv1c+IRLDwNeleUGk
         02Tnxh4Ct4xLk8WzKiyrhpTRmYKEBM7CUlH/kol3KKXfnbHwV0evfdsswsf5fDIOQ4fC
         U6OOHuSCO3/7auMmGG/2RyAjOV9bLdZcIh8VSiPDnaOZv6OHYniwauprEpoDMR0+mDh7
         NVBCtrvhxlqFxbkluIyQsZ6X/NZvhNZ8ce7P3GIjouS3AGuJ52/bBnXMRRQ3eUjEDJhm
         8mfw==
X-Gm-Message-State: ACgBeo2zpjERA0d/tn0q81BvoMQWdHdi5C0Qig8JQ8BRiB3I4c7sopXi
        7ErAj1cCtyPSF0TNcvEA4adzZ+7nkQ==
X-Google-Smtp-Source: AA6agR5GPQr1uNUFoyJ5ver00tftXGD7aWRLmNZklbPxaADwNWwe0WJWzmPX/omhMP3EjY1GkbnBhuIDlg==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6902:512:b0:6a8:24a1:5daf with SMTP id
 x18-20020a056902051200b006a824a15dafmr22863793ybs.592.1663012070252; Mon, 12
 Sep 2022 12:47:50 -0700 (PDT)
Date:   Mon, 12 Sep 2022 12:47:19 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912194722.809525-1-nhuck@google.com>
Subject: [PATCH] net: davicom: Fix return type of dm9000_start_xmit
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
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

The return type of dm9000_start_xmit should be changed from int to
netdev_tx_t.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/net/ethernet/davicom/dm9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 0985ab216566..186a5e0a7862 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1012,7 +1012,7 @@ static void dm9000_send_packet(struct net_device *dev,
  *  Hardware start transmission.
  *  Send a packet to media from the upper layer.
  */
-static int
+static netdev_tx_t
 dm9000_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned long flags;
-- 
2.37.2.789.g6183377224-goog

