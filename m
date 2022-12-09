Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C927648006
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLIJTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLIJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:19:36 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3A61B9E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:19:33 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221209091928euoutp02a0598b5a05818ba61e011768329b3f7a~vFXKe7ur_2720727207euoutp02a
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:19:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221209091928euoutp02a0598b5a05818ba61e011768329b3f7a~vFXKe7ur_2720727207euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670577568;
        bh=2DOfnVS4p6K0ffcpY7IB5m4uFlugPnlFJrahC2L25aQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WcHcDYrpvrefVWojCd49cN2E1H9ykFOtNQrdQF6Xwi9AL6HG7KfF/9oM/YrajZzg5
         CYhc1In4F3iKi2UsjY3XwwgRBA/ExnbKnqlRfgq555NRVQzqxqGyi/7WQDSEcC/L1B
         4UENSp1m3h53sXqO2WwDMZvZYTBEiHJV546Bjyh8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221209091928eucas1p2bd28ffc9b96fe76e0efed761fc611cfb~vFXKPOkWK0519505195eucas1p2F;
        Fri,  9 Dec 2022 09:19:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 76.0E.09561.0ADF2936; Fri,  9
        Dec 2022 09:19:28 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20221209091928eucas1p1cfc768d888a6e6c57fcaa0fe320cfced~vFXJzQtq-2906629066eucas1p1V;
        Fri,  9 Dec 2022 09:19:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221209091928eusmtrp17f7323831c42688ce56226d2c4b269fa~vFXJyjXik2592225922eusmtrp1R;
        Fri,  9 Dec 2022 09:19:28 +0000 (GMT)
X-AuditID: cbfec7f2-0b3ff70000002559-0f-6392fda0049b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0C.09.08916.F9DF2936; Fri,  9
        Dec 2022 09:19:27 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221209091927eusmtip1dfe4667fcf2bbfff2df0c5ebf0492bea~vFXJJ0OTo3200232002eusmtip1x;
        Fri,  9 Dec 2022 09:19:27 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm8994: Fix potential deadlock
Date:   Fri,  9 Dec 2022 10:16:57 +0100
Message-Id: <20221209091657.1183-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7oL/k5KNuj5J21x5eIhJoupD5+w
        WVxp3cRo8e1KB5PF5V1z2CzWHrnLbvH5/X5Wi85d/awWG76vZXTg9NjwuYnNY+esu+wem1Z1
        snlMn/Of0WPf22VsHn1bVjF6rN9ylcXj8ya5AI4oLpuU1JzMstQifbsEroxr+06zF3TKV8xb
        9ZK9gfGmZBcjB4eEgInEusXGXYxcHEICKxgl5r77zwbhfGGU+P7iDyuE85lR4vLazcxdjJxg
        HXfOPYOqWs4o0fPnIzNcy66XMxlBqtgEDCW63naxgdgiAnESyxcvYAIpYhZ4wyjxZ8c1sFHC
        AqYSCzZOBytiEVCVuNF7GMzmFbCRuPXmMivEOnmJ34/3sUDEBSVOznwCZjMDxZu3zgbbLCFw
        gEPi9M3TTBANLhJPt19jgbCFJV4d38IOYctInJ7cwwLR0M4oseD3fSYIZwKjRMPzW4wQVdZA
        3/1iA4UNs4CmxPpd+hBhR4kva9qYIEHGJ3HjrSDEEXwSk7ZNZ4YI80p0tAlBVKtJzDq+Dm7t
        wQuXoEHnIfFr016wv4QEYiVmPOlin8CoMAvJa7OQvDYL4YYFjMyrGMVTS4tz01OLDfNSy/WK
        E3OLS/PS9ZLzczcxAhPU6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK8y5ZNTBbiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOu2JKR7KQQHpiSWp2ampBahFMlomDU6qBie91x56kjSnHefsjHv6I1v5k
        x3tNpcMu+7aOvcOE+3/7t1n1e3vyehoKPjh3Y+p1uRCxz8mba18ud/L1PWmxq/KzUvOSV+qZ
        P4yfTDoxqyH9w7TiYlUNx7aUtIuWi+qjK/9PXi/nmmd82ef/5m0u7Ifun7jcVJ6wRPb8dIkk
        HQHmu7O8F1REV3qnhJR9fnG1wy41+kKd03XLLU86YwTeeb86brSq11dcb822Los3f8L3yjd+
        iC3XmaT/L88ws2ht7uTWJzMkJzr8mZTLGmHB0f1leduRZOuK5Xsd5s269lRV2qyhonHjdcez
        HbNOWDI3yqxt/uAedumURuu/rseTy1u/mWhuOnYmd3sRu7+wEktxRqKhFnNRcSIANpbpYb8D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e/4Xd35fyclG9z6b2Fx5eIhJoupD5+w
        WVxp3cRo8e1KB5PF5V1z2CzWHrnLbvH5/X5Wi85d/awWG76vZXTg9NjwuYnNY+esu+wem1Z1
        snlMn/Of0WPf22VsHn1bVjF6rN9ylcXj8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0j
        E0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxr+06zF3TKV8xb9ZK9gfGmZBcjJ4eEgInEnXPP
        2LoYuTiEBJYySnz9+YUFIiEjcXJaAyuELSzx51oXVNEnRonHWy4zgSTYBAwlut6CJDg5RAQS
        JA4tb2EGsZkFPjBKfFuhC2ILC5hKLNg4HayGRUBV4kbvYTCbV8BG4taby1AL5CV+P97HAhEX
        lDg58wkLxBx5ieats5knMPLNQpKahSS1gJFpFaNIamlxbnpusaFecWJucWleul5yfu4mRmBc
        bDv2c/MOxnmvPuodYmTiYDzEKMHBrCTCu2zZxGQh3pTEyqrUovz4otKc1OJDjKZA901klhJN
        zgdGZl5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA1PDBS2fPbsN
        O3zvLs46LJe68UfHjN/Gp9zC5jyzUW3+dVQk8ovS9mOyzI9d1E/53ZNVSc4O1NRsXWb6X//U
        +wXno6T2Cr2Tkf1xtOf9YVGOGP+MbbHFK4ufZ/eHZpUFqJnESXLw3f51eP7cqoRtv9dd+x2Q
        l5wk5pNrVDhL8WTdpUscCZatCorxbDpWfwp32Dx+PPnXkeVnWl0+zr2yev4Cowjey1tueTjk
        bZ/7MUrDWf+pOut7j8ha8ZVBKXtllp6cxaUnldxax8X64N2FDTblXgbB0yMW3JjtrPXqpJDh
        aYF+lhVerx3j0/z/Mt4/V2zK7SB//d1Klsh3YULl18/K3VtnwGb0z/IOv3/kciWW4oxEQy3m
        ouJEALd8RIYUAwAA
X-CMS-MailID: 20221209091928eucas1p1cfc768d888a6e6c57fcaa0fe320cfced
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221209091928eucas1p1cfc768d888a6e6c57fcaa0fe320cfced
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221209091928eucas1p1cfc768d888a6e6c57fcaa0fe320cfced
References: <CGME20221209091928eucas1p1cfc768d888a6e6c57fcaa0fe320cfced@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c0feea594e05 ("workqueue: don't skip lockdep work dependency in
cancel_work_sync()") revealed the following locking issue in the wm8994
codec:

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc1-00001-gc0feea594e05-dirty #13097 Not tainted
------------------------------------------------------
kworker/1:1/32 is trying to acquire lock:
c2bd4300 (&wm8994->accdet_lock){+.+.}-{3:3}, at: wm1811_mic_work+0x38/0xdc

but task is already holding lock:
f08f5f28 ((work_completion)(&(&wm8994->mic_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1e4/0x778

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 ((work_completion)(&(&wm8994->mic_work)->work)){+.+.}-{0:0}:
       __cancel_work_timer+0x198/0x22c
       wm1811_jackdet_irq+0x124/0x238
       process_one_work+0x288/0x778
       worker_thread+0x44/0x504
       kthread+0xf0/0x124
       ret_from_fork+0x14/0x2c
       0x0

-> #0 (&wm8994->accdet_lock){+.+.}-{3:3}:
       lock_acquire+0x124/0x3e4
       __mutex_lock+0x90/0x948
       mutex_lock_nested+0x1c/0x24
       wm1811_mic_work+0x38/0xdc
       process_one_work+0x288/0x778
       worker_thread+0x44/0x504
       kthread+0xf0/0x124
       ret_from_fork+0x14/0x2c
       0x0

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&(&wm8994->mic_work)->work));
                               lock(&wm8994->accdet_lock);
                               lock((work_completion)(&(&wm8994->mic_work)->work));
  lock(&wm8994->accdet_lock);

 *** DEADLOCK ***

2 locks held by kworker/1:1/32:
 #0: c1c072a8 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x1e4/0x778
 #1: f08f5f28 ((work_completion)(&(&wm8994->mic_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1e4/0x778

stack backtrace:
CPU: 1 PID: 32 Comm: kworker/1:1 Not tainted 6.0.0-rc1-00001-gc0feea594e05-dirty #13097
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events_power_efficient wm1811_mic_work
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x58/0x70
 dump_stack_lvl from check_noncircular+0xf0/0x158
 check_noncircular from __lock_acquire+0x15e8/0x2a7c
 __lock_acquire from lock_acquire+0x124/0x3e4
 lock_acquire from __mutex_lock+0x90/0x948
 __mutex_lock from mutex_lock_nested+0x1c/0x24
 mutex_lock_nested from wm1811_mic_work+0x38/0xdc
 wm1811_mic_work from process_one_work+0x288/0x778
 process_one_work from worker_thread+0x44/0x504
 worker_thread from kthread+0xf0/0x124
 kthread from ret_from_fork+0x14/0x2c
Exception stack(0xf08f5fb0 to 0xf08f5ff8)
...
--->8---

Fix this by dropping wm8994->accdet_lock while calling
cancel_delayed_work_sync(&wm8994->mic_work) in wm1811_jackdet_irq().

Fixes: c0cc3f166525 ("ASoC: wm8994: Allow a delay between jack insertion and microphone detect")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 sound/soc/codecs/wm8994.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index d3cfd3788f2a..f810135e28d0 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3853,7 +3853,12 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 	} else {
 		dev_dbg(component->dev, "Jack not detected\n");
 
+		/* Release wm8994->accdet_lock to avoid deadlock:
+		 * cancel_delayed_work_sync() takes wm8994->mic_work internal
+		 * lock and wm1811_mic_work takes wm8994->accdet_lock */
+		mutex_unlock(&wm8994->accdet_lock);
 		cancel_delayed_work_sync(&wm8994->mic_work);
+		mutex_lock(&wm8994->accdet_lock);
 
 		snd_soc_component_update_bits(component, WM8958_MICBIAS2,
 				    WM8958_MICB2_DISCH, WM8958_MICB2_DISCH);
-- 
2.38.1

