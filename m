Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6CC7444C5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjF3WTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjF3WS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:18:58 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C131BC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:18:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso1409202b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688163536; x=1690755536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4o3ZFseb13xRGcd/vSc40J69/E/2IGFhPuLqlwM6WM=;
        b=dKmcBva0OfXgsyn4nQpgyo+dwwZZeAnKPUA9crG7kZIxfR7ngBVv3Vysn6FqjqTuKO
         D0egZDk+Y/RXo/h3c3qJZ7pkO7BYLkTiEx1xqfrRBsq9rYXgFhQ0dGrLbbO3ei1PVsUi
         0YuKesC1cB2chTzjq87WlDtVOK7bVmVQ/XJkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688163536; x=1690755536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4o3ZFseb13xRGcd/vSc40J69/E/2IGFhPuLqlwM6WM=;
        b=j0w+OVMjGeCkMEtz4wq1CzCIsgil+fnYbp9FWp9T/ErJ2JKGebaIxG5h+RBXgtdrcd
         0hPm+8ZKsne/aq8QZ2wnPi1OoEjeucnR/O9stxWjgQWU1hGYYSabmgRiEwi7lmPfFuNI
         7qV9RqixvrTXvedbA+X0l0CgKir4EnaKo68UOu4IIER6jQmZSDtrRk506pZKtceTG2sK
         WgmfNpU26veKKHsU8nv7kmQ/Pgz9rVLe38oUk96juDVJjayyT4Msx0QTpVKwBSdcYz8d
         a1nX55Py7t/kkxoMk1Yo6T1aeYPitVIz88PVSu78LJYL+WmmP6t7k6mreRQUV9lUI//n
         3ybw==
X-Gm-Message-State: AC+VfDwNJlxXInjx1fMXQcGuTgGQgLQjNXKz3Yi4J+I3X6TElak0d4jw
        cJaFrHyrgpEj4hMMCR2T0jTjSA==
X-Google-Smtp-Source: ACHHUZ4E9KsvcvrdsLT2UhvwmcJ8MWz5jYHXp+x6WBZkfvJjVbi0TNr0D8qwKq+4v/R/D8uhAvC9+A==
X-Received: by 2002:a05:6a20:948a:b0:12b:de8:929d with SMTP id hs10-20020a056a20948a00b0012b0de8929dmr2662683pzb.16.1688163536499;
        Fri, 30 Jun 2023 15:18:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e9c4:8375:7234:e6c2])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e5c900b001b67a2896bdsm9653480plf.274.2023.06.30.15.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:18:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     ath10k@lists.infradead.org
Cc:     Abhishek Kumar <kuabhs@chromium.org>,
        Youghandhar Chintala <quic_youghand@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: Don't touch the CE interrupt registers after power up
Date:   Fri, 30 Jun 2023 15:18:43 -0700
Message-ID: <20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As talked about in commit d66d24ac300c ("ath10k: Keep track of which
interrupts fired, don't poll them"), if we access the copy engine
register at a bad time then ath10k can go boom. However, it's not
necessarily easy to know when it's safe to access them.

The ChromeOS test labs saw a crash that looked like this at
shutdown/reboot time (on a chromeos-5.15 kernel, but likely the
problem could also reproduce upstream):

Internal error: synchronous external abort: 96000010 [#1] PREEMPT SMP
...
CPU: 4 PID: 6168 Comm: reboot Not tainted 5.15.111-lockdep-19350-g1d624fe6758f #1 010b9b233ab055c27c6dc88efb0be2f4e9e86f51
Hardware name: Google Kingoftown (DT)
...
pc : ath10k_snoc_read32+0x50/0x74 [ath10k_snoc]
lr : ath10k_snoc_read32+0x24/0x74 [ath10k_snoc]
...
Call trace:
ath10k_snoc_read32+0x50/0x74 [ath10k_snoc ...]
ath10k_ce_disable_interrupt+0x190/0x65c [ath10k_core ...]
ath10k_ce_disable_interrupts+0x8c/0x120 [ath10k_core ...]
ath10k_snoc_hif_stop+0x78/0x660 [ath10k_snoc ...]
ath10k_core_stop+0x13c/0x1ec [ath10k_core ...]
ath10k_halt+0x398/0x5b0 [ath10k_core ...]
ath10k_stop+0xfc/0x1a8 [ath10k_core ...]
drv_stop+0x148/0x6b4 [mac80211 ...]
ieee80211_stop_device+0x70/0x80 [mac80211 ...]
ieee80211_do_stop+0x10d8/0x15b0 [mac80211 ...]
ieee80211_stop+0x144/0x1a0 [mac80211 ...]
__dev_close_many+0x1e8/0x2c0
dev_close_many+0x198/0x33c
dev_close+0x140/0x210
cfg80211_shutdown_all_interfaces+0xc8/0x1e0 [cfg80211 ...]
ieee80211_remove_interfaces+0x118/0x5c4 [mac80211 ...]
ieee80211_unregister_hw+0x64/0x1f4 [mac80211 ...]
ath10k_mac_unregister+0x4c/0xf0 [ath10k_core ...]
ath10k_core_unregister+0x80/0xb0 [ath10k_core ...]
ath10k_snoc_free_resources+0xb8/0x1ec [ath10k_snoc ...]
ath10k_snoc_shutdown+0x98/0xd0 [ath10k_snoc ...]
platform_shutdown+0x7c/0xa0
device_shutdown+0x3e0/0x58c
kernel_restart_prepare+0x68/0xa0
kernel_restart+0x28/0x7c

Though there's no known way to reproduce the problem, it makes sense
that it would be the same issue where we're trying to access copy
engine registers when it's not allowed.

Let's fix this by changing how we "disable" the interrupts. Instead of
tweaking the copy engine registers we'll just use disable_irq() and
enable_irq(). Then we'll configure the interrupts once at power up
time.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/net/wireless/ath/ath10k/snoc.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 26214c00cd0d..2c39bad7ebfb 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -828,12 +828,20 @@ static void ath10k_snoc_hif_get_default_pipe(struct ath10k *ar,
 
 static inline void ath10k_snoc_irq_disable(struct ath10k *ar)
 {
-	ath10k_ce_disable_interrupts(ar);
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	int id;
+
+	for (id = 0; id < CE_COUNT_MAX; id++)
+		disable_irq(ar_snoc->ce_irqs[id].irq_line);
 }
 
 static inline void ath10k_snoc_irq_enable(struct ath10k *ar)
 {
-	ath10k_ce_enable_interrupts(ar);
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	int id;
+
+	for (id = 0; id < CE_COUNT_MAX; id++)
+		enable_irq(ar_snoc->ce_irqs[id].irq_line);
 }
 
 static void ath10k_snoc_rx_pipe_cleanup(struct ath10k_snoc_pipe *snoc_pipe)
@@ -1090,6 +1098,8 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 		goto err_free_rri;
 	}
 
+	ath10k_ce_enable_interrupts(ar);
+
 	return 0;
 
 err_free_rri:
@@ -1253,8 +1263,8 @@ static int ath10k_snoc_request_irq(struct ath10k *ar)
 
 	for (id = 0; id < CE_COUNT_MAX; id++) {
 		ret = request_irq(ar_snoc->ce_irqs[id].irq_line,
-				  ath10k_snoc_per_engine_handler, 0,
-				  ce_name[id], ar);
+				  ath10k_snoc_per_engine_handler,
+				  IRQF_NO_AUTOEN, ce_name[id], ar);
 		if (ret) {
 			ath10k_err(ar,
 				   "failed to register IRQ handler for CE %d: %d\n",
-- 
2.41.0.255.g8b1d071c50-goog

