Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285CF6FBCAD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjEIBuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjEIBum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:50:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A41A279;
        Mon,  8 May 2023 18:50:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaec9ad820so49939085ad.0;
        Mon, 08 May 2023 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597040; x=1686189040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmncjnYD0YCdbiAl0XbmIMAaaEtLkUY+JzhiUY0+yqE=;
        b=mv4gwcbyAom9v/ntOCrdkUNTBnkSLE3OOiSUtx6dQ8HkLqT/mVu7JDDB5Le9seWEEd
         WG1G4VJ0jXB9J4Gh+9NGBPHBHN69z4cLU71mMesa1qSIVoz4SAMd5D43GgBYcr4/eOF5
         z6veea5w9lhlE+i9g77L6ZJ8nWrjS5pMA6yALEGdzh++U2t92996kBHuNNOdRTgdUBTH
         x6+7yeuDY1yYej+NZcqwW2g8m4jLfcpGYadW1uPpfO734plAo3mo81gjPbQPWthmt+sk
         Go/DSTsxb+NKYc9TfxS0hn6CkVutlx1YNvj/QSPebwnWbntwuyFhZaatY5iguhCP7hNz
         gKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597040; x=1686189040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmncjnYD0YCdbiAl0XbmIMAaaEtLkUY+JzhiUY0+yqE=;
        b=dztFFMGVcBGKZGr+o3EmJRYl79qclNkBOjAN8yMdXAAN3Q+wrkY3EEvd1vhwhNsIUE
         yddBNqxSF93Gp3XyxvQER+O/zD/nfGautuRsAqW8sNnOFQRBJd+HXWfgTaYpdbmE5mzq
         EckKY2LQ5DbCbuYar3vX1OU3NMI6IBHVWz0y8le79rMM1skyKrYCbrJAM5SuCYhduyGL
         rma8KAVI15EjPDFDZ6oXivRTXY8iFwk4IyxmgkmOO3U6eYSFxHEKeNqF5SD5LIQtUR6U
         QqbPobN4Vg9629+b1RSNIP5b+8ocGNpz74IBtvfwap9g63zf8zp23NtQ2HVa8ObRVDYY
         mVPQ==
X-Gm-Message-State: AC+VfDxMSFrevwhEwyPn27tDoIafAmA4bnrw548ThoNpgVqBcC2fR7p6
        JtcYgBN3vxpPCBZETnLB1Xc=
X-Google-Smtp-Source: ACHHUZ4sn+rHmNnAd7dRWLEd4zXW1JdTWXWI0Hd1JVnCAs9S0NZvu0ksCDUYgOdsqVDUFH5uxxyKVQ==
X-Received: by 2002:a17:902:efc5:b0:19c:f096:bbef with SMTP id ja5-20020a170902efc500b0019cf096bbefmr11597712plb.49.1683597039617;
        Mon, 08 May 2023 18:50:39 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e5c900b001ab12545508sm160050plf.67.2023.05.08.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:50:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 02/13] wifi: mwifiex: Use default @max_active for workqueues
Date:   Mon,  8 May 2023 15:50:21 -1000
Message-Id: <20230509015032.3768622-3-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509015032.3768622-1-tj@kernel.org>
References: <20230509015032.3768622-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These workqueues only host a single work item and thus doen't need explicit
concurrency limit. Let's use the default @max_active. This doesn't cost
anything and clearly expresses that @max_active doesn't matter.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Ganapathi Bhat <ganapathi017@gmail.com>
Cc: Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc: Xinming Hu <huxinming820@gmail.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++--
 drivers/net/wireless/marvell/mwifiex/main.c     | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index bcd564dc3554..5337ee4b6f10 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3127,7 +3127,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 	priv->dfs_cac_workqueue = alloc_workqueue("MWIFIEX_DFS_CAC%s",
 						  WQ_HIGHPRI |
 						  WQ_MEM_RECLAIM |
-						  WQ_UNBOUND, 1, name);
+						  WQ_UNBOUND, 0, name);
 	if (!priv->dfs_cac_workqueue) {
 		mwifiex_dbg(adapter, ERROR, "cannot alloc DFS CAC queue\n");
 		ret = -ENOMEM;
@@ -3138,7 +3138,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 
 	priv->dfs_chan_sw_workqueue = alloc_workqueue("MWIFIEX_DFS_CHSW%s",
 						      WQ_HIGHPRI | WQ_UNBOUND |
-						      WQ_MEM_RECLAIM, 1, name);
+						      WQ_MEM_RECLAIM, 0, name);
 	if (!priv->dfs_chan_sw_workqueue) {
 		mwifiex_dbg(adapter, ERROR, "cannot alloc DFS channel sw queue\n");
 		ret = -ENOMEM;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index ea22a08e6c08..1cd9d20cca16 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -1547,7 +1547,7 @@ mwifiex_reinit_sw(struct mwifiex_adapter *adapter)
 
 	adapter->workqueue =
 		alloc_workqueue("MWIFIEX_WORK_QUEUE",
-				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!adapter->workqueue)
 		goto err_kmalloc;
 
@@ -1557,7 +1557,7 @@ mwifiex_reinit_sw(struct mwifiex_adapter *adapter)
 		adapter->rx_workqueue = alloc_workqueue("MWIFIEX_RX_WORK_QUEUE",
 							WQ_HIGHPRI |
 							WQ_MEM_RECLAIM |
-							WQ_UNBOUND, 1);
+							WQ_UNBOUND, 0);
 		if (!adapter->rx_workqueue)
 			goto err_kmalloc;
 		INIT_WORK(&adapter->rx_work, mwifiex_rx_work_queue);
@@ -1702,7 +1702,7 @@ mwifiex_add_card(void *card, struct completion *fw_done,
 
 	adapter->workqueue =
 		alloc_workqueue("MWIFIEX_WORK_QUEUE",
-				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+				WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (!adapter->workqueue)
 		goto err_kmalloc;
 
@@ -1712,7 +1712,7 @@ mwifiex_add_card(void *card, struct completion *fw_done,
 		adapter->rx_workqueue = alloc_workqueue("MWIFIEX_RX_WORK_QUEUE",
 							WQ_HIGHPRI |
 							WQ_MEM_RECLAIM |
-							WQ_UNBOUND, 1);
+							WQ_UNBOUND, 0);
 		if (!adapter->rx_workqueue)
 			goto err_kmalloc;
 
-- 
2.40.1

