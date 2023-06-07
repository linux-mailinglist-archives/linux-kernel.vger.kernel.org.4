Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B747263F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbjFGPSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbjFGPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:17:56 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B452F1BF8;
        Wed,  7 Jun 2023 08:17:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b1fe3a1a73so10759851fa.1;
        Wed, 07 Jun 2023 08:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686151073; x=1688743073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8z7m82/KC/ogG5KfzFtCE/IZsx2I1+lo+fvkMs3lVI=;
        b=KrwvjCyiuKy8NElczUTdWM72YCTiuNzc2TfkZIhtCx9OpD58l6lBL7PfxF0+3gUyn5
         EAimbPNqcKNRR9Ap/k9H1sPF3+vdNwcdaySGuch3nwmMkAXBhMy7JbQGIsL7+1jEQQDf
         wB/w286Yp0Am7V40DuFH1QFFRE2/B7CxS/2DQtKZLil7CKWULxUZNAxtVRRav5UNZgVs
         OlQ49nCEou+8ftugLgkCdfm09Pmg6J5bgYMJaprDysYEFhcD5sc7ToZjY1VO0u5FbKTh
         uE1q/yQZr86BRZuKLrSemZJ6dmv6zTnjQhymVYHWp+q3gsx1qZH38TWicV2pn277yYRT
         Jawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151073; x=1688743073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8z7m82/KC/ogG5KfzFtCE/IZsx2I1+lo+fvkMs3lVI=;
        b=Ic/HqWwn4h8iqYpP3NEMwZqDWj/OCOkFzw7DUu7r7v+DIh9RHWo7CCuOlFp7pT7cj8
         cWlDZSudv4aFDHli6961sKPaYC5lyvsZsE9LIOtauc4SKdIFUkntuJwi50b7NU9llGMw
         DHWhVfIQimmU/C9zNdPeEzNegs0MSlYKcG4NXP3y7iWCyObICBNNYfNRFHaBOCbaeszO
         mxHfQHt5yZ8N7TFvddutWkMJO3vrBLIC0slTUe5gYnXXXVVmhL1DBT0n8kJYjfKEflu/
         nAurTOvIN+d4AKmeahNuuYvaJOnusvnCg0NPJunsV3w1tc/SoAk4spUP3yRKY4BCDOVr
         pwRQ==
X-Gm-Message-State: AC+VfDz9miv26FP8fhjORhZHtGEuGiAG2iB5ui3v8JMHXKkAqRPTTBq0
        nybh1FmZIc+1zPvN3DWjekg/ANC463Ctkg==
X-Google-Smtp-Source: ACHHUZ6QGxxYUzCRHlhXMM8I3iHl94QfBfhqNXsd+jEeJhRo7X1ZrG+LPXO6l6uY8qCfI8JWJpPyAg==
X-Received: by 2002:a2e:9c55:0:b0:2ac:78d5:fd60 with SMTP id t21-20020a2e9c55000000b002ac78d5fd60mr2388472ljj.9.1686151072769;
        Wed, 07 Jun 2023 08:17:52 -0700 (PDT)
Received: from localhost.localdomain (95-31-191-227.broadband.corbina.ru. [95.31.191.227])
        by smtp.googlemail.com with ESMTPSA id v5-20020a2e87c5000000b002ad9a1bfa8esm2302014ljj.1.2023.06.07.08.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:17:52 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vijay Khemka <vijaykhemka@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Ivan Mikhaylov <fr0st61te@gmail.com>,
        stable@vger.kernel.org, Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH v3 2/2] net/ncsi: change from ndo_set_mac_address to dev_set_mac_address
Date:   Wed,  7 Jun 2023 18:17:42 +0300
Message-Id: <20230607151742.6699-3-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607151742.6699-1-fr0st61te@gmail.com>
References: <20230607151742.6699-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change ndo_set_mac_address to dev_set_mac_address because
dev_set_mac_address provides a way to notify network layer about MAC
change. In other case, services may not aware about MAC change and keep
using old one which set from network adapter driver.

As example, DHCP client from systemd do not update MAC address without
notification from net subsystem which leads to the problem with acquiring
the right address from DHCP server.

Fixes: cb10c7c0dfd9e ("net/ncsi: Add NCSI Broadcom OEM command")
Cc: stable@vger.kernel.org # v6.0+ 2f38e84 net/ncsi: make one oem_gma function for all mfr id
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 91c42253a711..069c2659074b 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -616,7 +616,6 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct net_device *ndev = ndp->ndev.dev;
-	const struct net_device_ops *ops = ndev->netdev_ops;
 	struct ncsi_rsp_oem_pkt *rsp;
 	struct sockaddr saddr;
 	u32 mac_addr_off = 0;
@@ -643,7 +642,9 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 	/* Set the flag for GMA command which should only be called once */
 	ndp->gma_flag = 1;
 
-	ret = ops->ndo_set_mac_address(ndev, &saddr);
+	rtnl_lock();
+	ret = dev_set_mac_address(ndev, &saddr, NULL);
+	rtnl_unlock();
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
 
-- 
2.40.1

