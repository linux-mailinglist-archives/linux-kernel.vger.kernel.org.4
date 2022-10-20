Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CD3606156
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiJTNSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiJTNSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:18:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230571B2301;
        Thu, 20 Oct 2022 06:17:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk15so34347876wrb.13;
        Thu, 20 Oct 2022 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pB1ESJX/kbTXjRBj9KyRdymHjlLM30GkaaeMOBkpYiw=;
        b=ACtfuk0A0fGqABdtjv0rrhqqZFD50vnWR7DW7SsPw/XYnBiSS6PKHYTuLXjyaiaIB/
         HWh99gDIMFWZGZyzUuFF9ix2FCm0alKmHktZ2PHZ/6v62+aOL9C0vMlabzD275JsutPr
         VaD5bGlPYdoKaf4aIXA/EkVQhyy1fzFCIo2J/qeG23Hb6+1g2HXvadQnqEaPEGGUNo3z
         lDGiEY3FRCer9W98q0ARbYfN/C1D6V/4xNti+rXFxw37erTkNBObgBlNEdx1Nl+heSWm
         1eyZ4rtteQDGd/JnL7s2Y3ECr58BzFpZPDciheBoCUYr282IS8SDzDAqvqX7pUVDgNlr
         zS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pB1ESJX/kbTXjRBj9KyRdymHjlLM30GkaaeMOBkpYiw=;
        b=GN5+5XJkCbrd5yVch0HpNYqORhkwYTRQ7szDdbAdJX8miTrvdPpp7qntKMrbAjP+ee
         4Nf9j6HT4pPDHCaWzJPYUv3jeH5reXF/5oyoHDbCHvb42P1ZYnqzqzNCiiKj9KZPzfMR
         RwaV1uItDPYyvKj+1HPbBohu8vPrdvo7AejtVjoN53HF3LkO6jYfMwJ7VvEd48x6E4sH
         eOisDi32+bUYZgn285Bj7z3vhBc36Q8FpIuUxc/GhzvpQK3iVNCm237TXPxefSnqV1+s
         77IbO4nK2ySG93/TDk5e7ZiJuqjLWeHHXooDuk3OIQZx+AhqoDQakzVO+G1rtU6xj3r3
         HvHQ==
X-Gm-Message-State: ACrzQf24j/GYq5So+tjXqHfCAEMnzrFlc6U3DfOD9qi9f1APFTU0EnX1
        k2k02fnKuyH/cksHCfuapYo=
X-Google-Smtp-Source: AMsMyM6iyMTy0D2qEILjPok8dwQukw7kiGAtGVtmVPMZjrE2xyShlxHjyHV2Wpa7qGW9t5oACmGxkA==
X-Received: by 2002:a05:6000:1843:b0:22e:77b0:2e5 with SMTP id c3-20020a056000184300b0022e77b002e5mr8400914wri.215.1666271770601;
        Thu, 20 Oct 2022 06:16:10 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d554a000000b002364c77bcacsm365525wrw.38.2022.10.20.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:16:10 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: remove redundant variable total_freed
Date:   Thu, 20 Oct 2022 14:16:09 +0100
Message-Id: <20221020131609.1546667-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable total_freed is accumulating skb_to_free however it is not
being used after this. The use of total_freed is redundant and hence
the variable can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/octeon/ethernet-tx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index a36e36701c74..bbf33b88bb7c 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -73,7 +73,6 @@ static void cvm_oct_free_tx_skbs(struct net_device *dev)
 {
 	int skb_to_free;
 	int qos, queues_per_port;
-	int total_freed = 0;
 	int total_remaining = 0;
 	unsigned long flags;
 	struct octeon_ethernet *priv = netdev_priv(dev);
@@ -87,7 +86,6 @@ static void cvm_oct_free_tx_skbs(struct net_device *dev)
 						       MAX_SKB_TO_FREE);
 		skb_to_free = cvm_oct_adjust_skb_to_free(skb_to_free,
 							 priv->fau + qos * 4);
-		total_freed += skb_to_free;
 		if (skb_to_free > 0) {
 			struct sk_buff *to_free_list = NULL;
 
-- 
2.37.3

