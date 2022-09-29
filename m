Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6685EFD04
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiI2S1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiI2S1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:27:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7D913EE87
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:27:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so1840434ybr.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=TCNjSWh2khixhi5M5S96BCZPDyWIajI7MNk5y1CP4tQ=;
        b=Yo13DwjTXnaoeS0y6g7A4ryURj7HmjxBjY1CIx8TA8YG0TkQeid3iS0nI73l52wOPY
         OG7zCxcPiuHhWJBN1wbHSYfw7cwCn5I35So62E5eR1kE8BK1SFxRmn3B89ABq5Lb0XCA
         c17V4jSFwNhveOL7+DoIvuf/GoktBvkCGTAZ6+BGzXcKPIcD7H4cYGGgvXGK7mjY9qT3
         Ok5lfnDgUNuXR8dXwGPndNvqxGPJSya/3tbK7N7qzE50pusBYGqq4fr9UJq1WdhrOaC5
         2yroxqPOSJx3ghVVkZkHFKDy/eVWAZdhB57BpYvOzbIwfAkbQaqOZGbYVChXyDnJex8Q
         WObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=TCNjSWh2khixhi5M5S96BCZPDyWIajI7MNk5y1CP4tQ=;
        b=d4KMyLIhDsUACae5YtQoHz299go/+cBPSqsLaTD+fLdCujmq/tFS3yt6obdlhpmctV
         UoH+FOIdH/0cAuk4VCom4gR7W/FftoFEqdV6cGv25E9roeq9iYzMXx5jn9r1kCf6yuBR
         Q16Xz9G9SIivggZkUGp7IFadIZy69tx1PG+jQtO6iKGlmVz60EpCdxf1jsDfgXb8Oyxx
         G3Dn10ENHgrF42rHpKQfjVxmN30+4T/2quloNsBDvFxTlxAnjIVvZPhSNq+HEG7CO1Gu
         0aFOZ53BBvXfHCvDDVrYg8Ro0bsviP0QK8MksevI/ShlsrKpm3dFZ6UukwoEXCKl+Fn/
         LLiQ==
X-Gm-Message-State: ACrzQf08ckai+RHQ+3V419FPGFzwpY1P3DA3PvCgZ54rLgvuKmhSHsNk
        DJEDmeww7Uzj9vdAgX/VDK4fjco2Hw==
X-Google-Smtp-Source: AMsMyM7izNOHKJTh4Ttf/2FZTV0VPOoAFMNNllUoSw1AaASTnPFHL4tWGLHJ4a22FeLFfd2iILIYokFOUg==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a0d:d708:0:b0:354:b610:fd3d with SMTP id
 z8-20020a0dd708000000b00354b610fd3dmr4693272ywd.28.1664476033986; Thu, 29 Sep
 2022 11:27:13 -0700 (PDT)
Date:   Thu, 29 Sep 2022 11:27:03 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220929182704.64438-1-nhuck@google.com>
Subject: [PATCH] net: lan966x: Fix return type of lan966x_port_xmit
From:   Nathan Huckleberry <nhuck@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
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

The return type of lan966x_port_xmit should be changed from int to
netdev_tx_t.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1703
Cc: llvm@lists.linux.dev
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index b98d37c76edb..be2fd030cccb 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -344,7 +344,8 @@ static void lan966x_ifh_set_timestamp(void *ifh, u64 timestamp)
 		IFH_POS_TIMESTAMP, IFH_LEN * 4, PACK, 0);
 }
 
-static int lan966x_port_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t lan966x_port_xmit(struct sk_buff *skb,
+				     struct net_device *dev)
 {
 	struct lan966x_port *port = netdev_priv(dev);
 	struct lan966x *lan966x = port->lan966x;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

