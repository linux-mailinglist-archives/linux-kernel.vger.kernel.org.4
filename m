Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252166C2A55
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCUGTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjCUGTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:19:40 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2061.outbound.protection.outlook.com [40.92.98.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643BE37B66
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKXC3zc8aTaO6VHKHvGiXwTxQ7a1wM1ehAG3Yr93a+JwFdXFSqXbAj4fTcsZSPgc/iCW5EkDjGerN0Xvz0O2m1CC6sMeLsgf5IkW6G4rIbemr50QkclKXma2SwGHJR5ehBozIuW3MbIWedxX7xfWkI7Gt2Mvcg8Zsp1/CWEZi9S1GO8E0B7996PBVIqERCS/iJXnNhhhgPpNxQUm69jWgmSzPxMjkZVY4glBLuc7le8I+m68a5YpKY16H/lvzXYeG8s3cmKduy0iV05/QoAjdrACHZdBptIoiO5yZAHfElV75Ftws0v/DIwmMSUey3RO5OUGbtlFkgP2m+8MB9i2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03Js5Xsq/zfSFzpJQDD3z/XUs21ZYVOAwV11NAUOQHo=;
 b=UYaJ/ropfEy3+Rpo1ynNRvXtFl6ThWjHiYhlff01JTy9askJs02/+JmHAYlWfDfqXjsTvmNtSvOBoN7Q5IMYVkIGGczlrqj27cSl64QudGGrv6WS1TekvglRzCdk9E8724ULzPNPnDEkNlfk4h9ernnTn326MJ/zXaa2vTxykWBZt9sGrYbOzgNN6IKvQX5f/hDrL0+jYEfIOofzHC0lsWgeqzSRy/63SwlpRSd/EX+klXysDB98FgS4CiOfu3MgYtzYzEUsq2kA9h+2uBVrrJ+UhwPW7LZa5spaHQdKFttvxxztYzLsckuf0Wx0d5kxhEopmiJSxGgttCeSjsQ1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03Js5Xsq/zfSFzpJQDD3z/XUs21ZYVOAwV11NAUOQHo=;
 b=QnlTladHIh8BQAxQgrdCECHNG/0/+t4dffBeYQBg4LyVOcVUEOYB0ObY36r6BTEhbiBV/Feftl+xuG72CzXwNHwvgfUh0Gf0MN+iO4Yes4giUCll4yC6oakVnjRYXaUYeeB3DPx35HkyQRYkl5h4nsjRgm6LQ4OvOe36nmCb6WG5NAm+IjPWxilplWjlonlNnil5PQmT9u+G/qGaePQQ/ADWPgVBb25snkBzDPckNTIvuMKuWFzkStkNaSXwQFk3D5FUljNlAv4RRvxXKxDG07C/ofhytxG4uzfBcadkuPDCLe+eXcNq68xEoizrriGw0ZSBtzQlR38cupIctoERlw==
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
 by TYCP286MB3341.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 06:19:34 +0000
Received: from TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3682:6425:a009:405f]) by TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
 ([fe80::3682:6425:a009:405f%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 06:19:34 +0000
From:   Peng Liu <pngliu@hotmail.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        liupeng17@lenovo.com
Subject: [PATCH 2/3] scripts/gdb: fix lx-timerlist for Python3
Date:   Tue, 21 Mar 2023 14:19:29 +0800
Message-ID: <TYCP286MB2146EE1180A4D5176CBA8AB2C6819@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [/ygakIPTJSu3dfhYXLfXgb3lqlnth3+a]
X-ClientProxiedBy: SGAP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::35)
 To TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:158::13)
X-Microsoft-Original-Message-ID: <20230321061929.4500-1-pngliu@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2146:EE_|TYCP286MB3341:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc6a293-035f-4f99-e946-08db29d43d66
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ywdgoySLPFVeHjicd7AIGD+28yYBBnBrKV6EXySkk9/MGdZ6YsAQWf5FsiGVXr3kFjpm9y3ZnbBb/D14+EbBu7POeOit03KbAySWAz3PAxmstPFrgH6zWMYvsw3PcPLccEeEiKDU0mWhPXBRPPm0DmgVgcEsFJc28o2IRTphF+DGZ8Oq2oy+1Fv64qMOuugB9dBkHxex63PIT1P0z4C40GqKQoUw2hJqbHodUAKBE2OnXTSTqCJsUxzxRE7uxB4TamUXU7FBkzq4pIpz9y8SUffL0546MTJOnUxK2RJHb9wwPhIkmjXzxqrpneJ0x7gf2FGsxw78UZfpNn9xAdyM5gzzZoHBt0V8g9G/q1V2qK1WMv7Q0o7QGu2BfWvgyNGN+9YsHk0pKF1XegdZGHKT4smlLFgtV86smurWtkgl1g0kB5P4d3FoKBsVdnEXc15lpU5616caGcGREh6RfA0HcRviXMFBgJn93al3oMP6W34jjwurPzkhtmWTTqS7uE4f9QWMMa3US5g47JlEKQm/Dl63GVbxkrAkCjCpYzhfPHgrytPbsFGF9xF5aLOoZpYwOepFHNFTklpcaVSxPW7xzKgjaPH2VbgOC3JEBrdw8U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QE6B/zrP1WIijxeWst02RhHWDszBnYZ5TS1iYXRC3wWclJ95D7651duLtVJQ?=
 =?us-ascii?Q?pOOUz6RoPhJGCYQRRrZ9EHRMUKg7XJ+RLFiX2tfkkXJ63/Y3OTQidcaKsEnm?=
 =?us-ascii?Q?aij7RAMcr6J1EZhObhRX6pAeQXylPhe4D+pBz7cVEpOzXinr8qoU4j5V68Mb?=
 =?us-ascii?Q?NDGHD3u8PTyyYyDlrR9U8AdZhUrlYb8pNMxrmLkEQjTbxikYrV7/7/hIAyR7?=
 =?us-ascii?Q?+0CY0i7FxsEAkTutOdg60fzPuiexIHN+MArxp7qP6my1TTDEp4VUsU6NmLU+?=
 =?us-ascii?Q?HED58atGlgUZI472OWB3nMv4T6p3oU1hB1XKrVyspwnvYFw7Fa7q4++pqcQJ?=
 =?us-ascii?Q?B8sBL6vF8COGRy6ct6IUMWOqqRCyZfmYVLH667mrc41ffpzA5L8uDqehAI9B?=
 =?us-ascii?Q?lslzOt+oxgnuTHgzua9czuJ9pZr5248PCBdhCRYxPxonk+4tzWX1wEvEYdLA?=
 =?us-ascii?Q?rz3ppWhhP6eb8sbS4QfCUw3sbwG+DDM0lbphhBDPTTUSJWt9dGW0yE4eqEBM?=
 =?us-ascii?Q?+lty9FudDBGlezWC3GuUIqgqeKOtAstSEg5qjyhRLOD1X5sRGHG9ER46UpBs?=
 =?us-ascii?Q?qarFM1zCqJ8dmo3n3hniTb4C74YGnAtLoCqIbwI8aItkASJDWHHA2Nuq1sIl?=
 =?us-ascii?Q?PGu6vPftwkeHnkMHyGnJzJovUlGPGOjdHL/n0Ym2Pbc03ny/zxPWis7aTe2O?=
 =?us-ascii?Q?izdNgcs/bRPSoFy+KAsXov6s+RXLKW9gaALosEQPt5QhpNxpDb/1yyC/t3D1?=
 =?us-ascii?Q?a+eDtc+JFwrHg3o4b3hK5WAyNAOBtlwtny0dDH9gjzvmU6f08njHixuqNIwa?=
 =?us-ascii?Q?1L8oqDCE63nhkLbHtKbQ0GhDf3Czx2yIpCwiKrLAtWFRiJ9/v/xigqlg7ZpL?=
 =?us-ascii?Q?HvcJGq7/b8are/HpKQVL1llcIsbEp6KELAC2C9cp6aL1usggU9s/rljt5bUl?=
 =?us-ascii?Q?/tro4p76rVL2HsQvAZhgkruZ6rfeHbAKxETQ0y8g9JszNAmkyWeyXGE6fT2B?=
 =?us-ascii?Q?QuGTwyn/TmvIpVPFllpCNAOQX37z8QtgWUE75PlqL0DPPbYQZTw6VK8n4GLj?=
 =?us-ascii?Q?BuKzl8i8iDx0RFtdBPAFAeFAO34Dx0Wo7DnPV9Sg4mh8TYEnYkQ0SAKhRDxN?=
 =?us-ascii?Q?AdLFivAPv5HFVl2MjbZnWc6ch5WCE0TwdklT7wZyePM/sZiTlp2Sc0Bt9Sqb?=
 =?us-ascii?Q?+ymLcjTxttA/0igOv8xvioXU/z6WovXYrUqDCuoqyUoJAh9LtAPR/rgzzIl2?=
 =?us-ascii?Q?lIuaGOnOeZt8x2oC2pKs?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc6a293-035f-4f99-e946-08db29d43d66
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 06:19:34.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3341
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Liu <liupeng17@lenovo.com>

Below incompatibilities between Python2 and Python3 made lx-timerlist
fail to run under Python3.

o xrange() is replaced by range() in Python3
o bytes and str are different types in Python3
o the return value of Inferior.read_memory() is memoryview object in
  Python3

Signed-off-by: Peng Liu <liupeng17@lenovo.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/gdb/linux/timerlist.py | 4 +++-
 scripts/gdb/linux/utils.py     | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/timerlist.py b/scripts/gdb/linux/timerlist.py
index 44e39dc3eb64..8281da068c5b 100644
--- a/scripts/gdb/linux/timerlist.py
+++ b/scripts/gdb/linux/timerlist.py
@@ -72,7 +72,7 @@ def print_cpu(hrtimer_bases, cpu, max_clock_bases):
     ts = cpus.per_cpu(tick_sched_ptr, cpu)
 
     text = "cpu: {}\n".format(cpu)
-    for i in xrange(max_clock_bases):
+    for i in range(max_clock_bases):
         text += " clock {}:\n".format(i)
         text += print_base(cpu_base['clock_base'][i])
 
@@ -157,6 +157,8 @@ def pr_cpumask(mask):
     num_bytes = (nr_cpu_ids + 7) / 8
     buf = utils.read_memoryview(inf, bits, num_bytes).tobytes()
     buf = binascii.b2a_hex(buf)
+    if type(buf) is not str:
+        buf=buf.decode()
 
     chunks = []
     i = num_bytes
diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index 1553f68716cc..7f36aee32ac6 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -88,7 +88,10 @@ def get_target_endianness():
 
 
 def read_memoryview(inf, start, length):
-    return memoryview(inf.read_memory(start, length))
+    m = inf.read_memory(start, length)
+    if type(m) is memoryview:
+        return m
+    return memoryview(m)
 
 
 def read_u16(buffer, offset):
-- 
2.34.1

