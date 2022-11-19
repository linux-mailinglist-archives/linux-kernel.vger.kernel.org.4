Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739AB630AD9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 03:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiKSCvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 21:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiKSCun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 21:50:43 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1D8BC5602
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 18:37:07 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxLLdSQXhj9skIAA--.13310S3;
        Sat, 19 Nov 2022 10:37:06 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxV1dQQXhj+sIWAA--.41565S2;
        Sat, 19 Nov 2022 10:37:04 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tools/vm/slabinfo-gnuplot: Use "grep -E" instead of "egrep"
Date:   Sat, 19 Nov 2022 10:36:59 +0800
Message-Id: <1668825419-30584-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8BxV1dQQXhj+sIWAA--.41565S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFWUCFy3Gw17uw1rAr48Xrb_yoW8Xr4Upa
        4rur9rXr43KFyIyanrCF4xGF17KF9xCay8JryfX3yjqFy3X3W7WFyfXF4UZF17XayrJr4k
        Ca4qgry7CF4kAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUcyxRUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version of grep claims the egrep is now obsolete so the build
now contains warnings that look like:
	egrep: warning: egrep is obsolescent; using grep -E
fix this up by moving the related file to use "grep -E" instead.

  sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/vm`

Here are the steps to install the latest grep:

  wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
  tar xf grep-3.8.tar.gz
  cd grep-3.8 && ./configure && make
  sudo make install
  export PATH=/usr/local/bin:$PATH

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/vm/slabinfo-gnuplot.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/vm/slabinfo-gnuplot.sh b/tools/vm/slabinfo-gnuplot.sh
index 26e193f..873a892 100644
--- a/tools/vm/slabinfo-gnuplot.sh
+++ b/tools/vm/slabinfo-gnuplot.sh
@@ -150,7 +150,7 @@ do_preprocess()
 	let lines=3
 	out=`basename "$in"`"-slabs-by-loss"
 	`cat "$in" | grep -A "$lines" 'Slabs sorted by loss' |\
-		egrep -iv '\-\-|Name|Slabs'\
+		grep -E -iv '\-\-|Name|Slabs'\
 		| awk '{print $1" "$4+$2*$3" "$4}' > "$out"`
 	if [ $? -eq 0 ]; then
 		do_slabs_plotting "$out"
@@ -159,7 +159,7 @@ do_preprocess()
 	let lines=3
 	out=`basename "$in"`"-slabs-by-size"
 	`cat "$in" | grep -A "$lines" 'Slabs sorted by size' |\
-		egrep -iv '\-\-|Name|Slabs'\
+		grep -E -iv '\-\-|Name|Slabs'\
 		| awk '{print $1" "$4" "$4-$2*$3}' > "$out"`
 	if [ $? -eq 0 ]; then
 		do_slabs_plotting "$out"
-- 
2.1.0

