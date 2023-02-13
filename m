Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E551693E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBMGIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMGI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:08:29 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3297B26BC;
        Sun, 12 Feb 2023 22:08:25 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PFYml4GX0z8R047;
        Mon, 13 Feb 2023 14:08:23 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 31D6876v026860;
        Mon, 13 Feb 2023 14:08:07 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Mon, 13 Feb 2023 14:08:08 +0800 (CST)
Date:   Mon, 13 Feb 2023 14:08:08 +0800 (CST)
X-Zmail-TransId: 2b0363e9d3c8ffffffff8d354e3d
X-Mailer: Zmail v1.0
Message-ID: <202302131408087983857@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>, <david@redhat.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <wang.yong12@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRlbGF5YWNjdDogaW1wcm92ZSB0aGUgYXZlcmFnZSBkZWxheSBwcmVjaXNpb24gb2YgZ2V0ZGVsYXkgdG9vbCB0byBtaWNyb3NlY29uZA==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31D6876v026860
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63E9D3D7.002 by FangMail milter!
X-FangMail-Envelope: 1676268503/4PFYml4GX0z8R047/63E9D3D7.002/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E9D3D7.002/4PFYml4GX0z8R047
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,CTE_8BIT_MISMATCH,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Yong <wang.yong12@zte.com.cn>

Improve the average delay precision of getdelay tool to microsecond.
When using the getdelay tool, it is sometimes found that the average
delay except CPU is not 0, but display is 0, because the precison is too
low. For example, see delay average of SWAP below when using ZRAM.

print delayacct stats ON
PID	32915
CPU             count     real total  virtual total    delay total  delay average
               339202     2793871936     9233585504        7951112          0.000ms
IO              count    delay total  delay average
                   41      419296904             10ms
SWAP            count    delay total  delay average
               242589     1045792384              0ms
This wrong display is misleading, so improve the millisecond precision
of the  average delay to microsecond just like CPU. Then user would
get more accurate information of delay time.

Signed-off-by: Wang Yong <wang.yong12@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 Documentation/accounting/delay-accounting.rst      | 14 ++++++-------
 .../zh_CN/accounting/delay-accounting.rst          | 14 ++++++-------
 tools/accounting/getdelays.c                       | 24 +++++++++++-----------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index 7103b62ba6d7..c4ac482262f8 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -109,17 +109,17 @@ Get sum of delays, since system boot, for all pids with tgid 5::
    CPU             count     real total  virtual total    delay total  delay average
                        8        7000000        6872122        3382277          0.423ms
    IO              count    delay total  delay average
-                   0              0              0ms
+                   0              0          0.000ms
    SWAP            count    delay total  delay average
-                       0              0              0ms
+                       0              0          0.000ms
    RECLAIM         count    delay total  delay average
-                   0              0              0ms
+                   0              0          0.000ms
    THRASHING       count    delay total  delay average
-                       0              0              0ms
+                       0              0          0.000ms
    COMPACT         count    delay total  delay average
-                       0              0              0ms
-        WPCOPY          count    delay total  delay average
-                            0              0              0ms
+                       0              0          0.000ms
+   WPCOPY          count    delay total  delay average
+                       0              0          0.000ms

 Get IO accounting for pid 1, it works only with -p::

diff --git a/Documentation/translations/zh_CN/accounting/delay-accounting.rst b/Documentation/translations/zh_CN/accounting/delay-accounting.rst
index a01dc3d5b0db..3c952fde09ff 100644
--- a/Documentation/translations/zh_CN/accounting/delay-accounting.rst
+++ b/Documentation/translations/zh_CN/accounting/delay-accounting.rst
@@ -92,17 +92,17 @@ getdelays命令的一般格式::
    CPU             count     real total  virtual total    delay total  delay average
                        8        7000000        6872122        3382277          0.423ms
    IO              count    delay total  delay average
-                       0              0              0ms
+                       0              0          0.000ms
    SWAP            count    delay total  delay average
-                       0              0              0ms
+                       0              0          0.000ms
    RECLAIM         count    delay total  delay average
-                       0              0              0ms
+                       0              0          0.000ms
    THRASHING       count    delay total  delay average
-                       0              0              0ms
+                       0              0          0.000ms
    COMPACT         count    delay total  delay average
-                       0              0              0ms
-    WPCOPY          count    delay total  delay average
-                       0              0              0ms
+                       0              0          0.000ms
+   WPCOPY          count    delay total  delay average
+                       0              0          0.000ms

 获取pid为1的IO计数，它只和-p一起使用::
    # ./getdelays -i -p 1
diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 938dec0dfaad..89324db33be3 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -198,17 +198,17 @@ static void print_delayacct(struct taskstats *t)
    printf("\n\nCPU   %15s%15s%15s%15s%15s\n"
           "      %15llu%15llu%15llu%15llu%15.3fms\n"
           "IO    %15s%15s%15s\n"
-          "      %15llu%15llu%15llums\n"
+          "      %15llu%15llu%15.3fms\n"
           "SWAP  %15s%15s%15s\n"
-          "      %15llu%15llu%15llums\n"
+          "      %15llu%15llu%15.3fms\n"
           "RECLAIM  %12s%15s%15s\n"
-          "      %15llu%15llu%15llums\n"
+          "      %15llu%15llu%15.3fms\n"
           "THRASHING%12s%15s%15s\n"
-          "      %15llu%15llu%15llums\n"
+          "      %15llu%15llu%15.3fms\n"
           "COMPACT  %12s%15s%15s\n"
-          "      %15llu%15llu%15llums\n"
+          "      %15llu%15llu%15.3fms\n"
           "WPCOPY   %12s%15s%15s\n"
-          "      %15llu%15llu%15llums\n",
+          "      %15llu%15llu%15.3fms\n",
           "count", "real total", "virtual total",
           "delay total", "delay average",
           (unsigned long long)t->cpu_count,
@@ -219,27 +219,27 @@ static void print_delayacct(struct taskstats *t)
           "count", "delay total", "delay average",
           (unsigned long long)t->blkio_count,
           (unsigned long long)t->blkio_delay_total,
-          average_ms(t->blkio_delay_total, t->blkio_count),
+          average_ms((double)t->blkio_delay_total, t->blkio_count),
           "count", "delay total", "delay average",
           (unsigned long long)t->swapin_count,
           (unsigned long long)t->swapin_delay_total,
-          average_ms(t->swapin_delay_total, t->swapin_count),
+          average_ms((double)t->swapin_delay_total, t->swapin_count),
           "count", "delay total", "delay average",
           (unsigned long long)t->freepages_count,
           (unsigned long long)t->freepages_delay_total,
-          average_ms(t->freepages_delay_total, t->freepages_count),
+          average_ms((double)t->freepages_delay_total, t->freepages_count),
           "count", "delay total", "delay average",
           (unsigned long long)t->thrashing_count,
           (unsigned long long)t->thrashing_delay_total,
-          average_ms(t->thrashing_delay_total, t->thrashing_count),
+          average_ms((double)t->thrashing_delay_total, t->thrashing_count),
           "count", "delay total", "delay average",
           (unsigned long long)t->compact_count,
           (unsigned long long)t->compact_delay_total,
-          average_ms(t->compact_delay_total, t->compact_count),
+          average_ms((double)t->compact_delay_total, t->compact_count),
           "count", "delay total", "delay average",
           (unsigned long long)t->wpcopy_count,
           (unsigned long long)t->wpcopy_delay_total,
-          average_ms(t->wpcopy_delay_total, t->wpcopy_count));
+          average_ms((double)t->wpcopy_delay_total, t->wpcopy_count));
 }

 static void task_context_switch_counts(struct taskstats *t)
--
2.15.2
