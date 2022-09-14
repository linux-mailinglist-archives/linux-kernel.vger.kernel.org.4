Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B299E5B7F06
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiINCdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiINCdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:33:38 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F9426555C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 19:33:35 -0700 (PDT)
Received: from loongson.. (unknown [111.207.111.194])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72txPSFjXrMYAA--.27807S2;
        Wed, 14 Sep 2022 10:33:28 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hongchen Zhang <zhanghongchen@loongson.cn>
Subject: [PATCH] mm/vmscan: don't scan adjust too much if current is not kswapd
Date:   Wed, 14 Sep 2022 10:33:18 +0800
Message-Id: <20220914023318.549118-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx72txPSFjXrMYAA--.27807S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtFy7tr45Ar1kWrWUWFy5twb_yoW8Jr1fpa
        yfGw1jqFs5GrnIkas8JF409w1fCry5GFy7GrWfW3WxCw47Gr48Jry3urW5XFy2ya1xuF43
        Zr98Ka45WF1agaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUvoGQUUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when a process falls into page fault and there is not enough free
memory,it will do direct reclaim. At the same time,it is holding
mmap_lock.So in case of multi-thread,it should exit from page fault
ASAP.
When reclaim memory,we do scan adjust between anon and file lru which
may cost too much time and trigger hung task for other thread.So for a
process which is not kswapd,it should just do a little scan adjust.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 mm/vmscan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2b1431352dc..07fb58db812b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3042,11 +3042,17 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		nr[lru] = targets[lru] * (100 - percentage) / 100;
 		nr[lru] -= min(nr[lru], nr_scanned);
 
+		if (!current_is_kswapd())
+			nr[lru] = min(nr[lru], nr_to_reclaim);
+
 		lru += LRU_ACTIVE;
 		nr_scanned = targets[lru] - nr[lru];
 		nr[lru] = targets[lru] * (100 - percentage) / 100;
 		nr[lru] -= min(nr[lru], nr_scanned);
 
+		if (!current_is_kswapd())
+			nr[lru] = min(nr[lru], nr_to_reclaim);
+
 		scan_adjusted = true;
 	}
 	blk_finish_plug(&plug);
-- 
2.34.1

