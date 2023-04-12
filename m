Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658FB6DFFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjDLUe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjDLUe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:34:27 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BED95BB5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:34:24 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230412203422euoutp02321e0a4e939b3b7223d0c0500e81d4bc~VSj0RC6gn0762407624euoutp02M
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:34:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230412203422euoutp02321e0a4e939b3b7223d0c0500e81d4bc~VSj0RC6gn0762407624euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681331662;
        bh=G7hlX/PwHSHsnQb6g7B1nnSJc0emLV9kq1u9zEYO/to=;
        h=From:To:CC:Subject:Date:References:From;
        b=UHVqsBbXJPXDWeVU+ruk78qMz0rvbcnwBWh5CZSQdYvoA1QDy9aeEF+IYy5GeJKEB
         GptLfstL5yrtkp4Vw84ZGn5JuK17h1mpVQNou2ifYGsrzXpFh/5/jYIflp2sBp5TN+
         +iJy37+74jLHcvSQ8od1uGLozcrF4xeV+OIll+GQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230412203421eucas1p10f6ed397d10bfcc7a02a2884cd0b1ca7~VSjz14N0b1494514945eucas1p1H;
        Wed, 12 Apr 2023 20:34:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 75.91.09503.DC517346; Wed, 12
        Apr 2023 21:34:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230412203420eucas1p2efd38df12efde2ca05c6b3a26f5a753b~VSjyuN-9g1224012240eucas1p2y;
        Wed, 12 Apr 2023 20:34:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230412203420eusmtrp1180226167cdbe7f4d9ef2c9c8453f242~VSjytzIY82288322883eusmtrp1x;
        Wed, 12 Apr 2023 20:34:20 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-13-643715cde0cb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2B.02.22108.CC517346; Wed, 12
        Apr 2023 21:34:20 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230412203420eusmtip10e0dcebf6291abed02c97f89e041d553~VSjyej_Wi0450104501eusmtip1p;
        Wed, 12 Apr 2023 20:34:20 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 12 Apr 2023 21:34:19 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <jan.kiszka@siemens.com>, <kbingham@kernel.org>
CC:     <gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
        <song@kernel.org>, <mcgrof@kernel.org>, <p.raghav@samsung.com>
Subject: [PATCH v2] scripts/gdb: use mem instead of core_layout to get the
 module address
Date:   Wed, 12 Apr 2023 22:25:18 +0200
Message-ID: <20230412202516.1027149-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djP87pnRc1TDGa+kLW4d/Mms8Wp7s1M
        Fpd3zWGzuDHhKaPF8eV/2RxYPTat6mTz2H5yEpPH501yAcxRXDYpqTmZZalF+nYJXBl/Lmxj
        LrglVjF/42q2BsbdQl2MnBwSAiYS/bPnsHYxcnEICaxglDh/opUJwvnCKLHm9Wko5zOjxNe+
        j2wwLZ93PmMHsYUEljNK7O4PhLCBig59roNo2MIo8bhpCVA3BwebgJZEYydYvYiAscSLycfY
        QMLMAjUSky8bgoSFBaIlGh5uZwSxWQRUJXZ8a2QBsXkFrCU+vL7GDlIuISAvsfiBBERYUOLk
        zCdgJcxA4eats5khbAmJgy9eMENcqSTRsPkMC4RdK3Fqyy2wVyQE9nBI3H+4FirhIvF81wRW
        CFtY4tXxLewQtozE6ck9UDXVEk9v/GaGaG5hlOjfuZ4N4iBrib4zORA1jhL7+g+wQIT5JG68
        FYS4h09i0rbpzBBhXomONmiYq0msvveGZQKj8iwk38xC8s0sJN8sYGRexSieWlqcm55abJiX
        Wq5XnJhbXJqXrpecn7uJEZg+Tv87/mkH49xXH/UOMTJxMB5ilOBgVhLh/eFimiLEm5JYWZVa
        lB9fVJqTWnyIUZqDRUmcV9v2ZLKQQHpiSWp2ampBahFMlomDU6qByXWm3q7Xm73c0v0apjbk
        PyycO+HQvRzh1v9H1U7sf5Hn/P+YiDvT77t/K+ZNmFYoPjk6e7ZV0irhmSn9fXm/J6U+mJSq
        uoLx9DXBU/9kltirCc+9x1eUJ2mUuMhBwdwl+smVN52HGq6ttCl8ZqhXazf3Q+b79sWvFBJW
        P3xV3vTXnVmw9ArXvbZJQqn6t5WPs18sePW8snu1xQl7JradAb75BgoXjbY7Ne98660cfUhr
        zs9D+Xu8kzJ7v6lHLOLoeXNzwvxHgjV9M9tl93OKd4ofFPJ1bMoUNXuzUrWxRdatKfqP0LNJ
        G0+zq72OrK7aJGr38kC9fTbbI/Z9Sl+TFyW8X1j69P1xRUP/r349SizFGYmGWsxFxYkALM8y
        Uo4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Xd0zouYpBn8ahCzu3bzJbHGqezOT
        xeVdc9gsbkx4ymhxfPlfNgdWj02rOtk8tp+cxOTxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWR
        nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsafC9uYC26JVczfuJqtgXG3UBcjJ4eE
        gInE553P2LsYuTiEBJYySkzcMIMJIiEjsfHLVVYIW1jiz7UuNoiij4wSf16fY4RwtjBK7N5y
        nqWLkYODTUBLorGTHaRBRMBY4sXkY2wgNrNAjcTjDavB4sICkRKr9x9nBrFZBFQldnxrZAGx
        eQWsJT68vsYOMkZCQF5i8QMJiLCgxMmZT1ggxshLNG+dzQxhS0gcfPGCGeI2JYmGzWdYIOxa
        ic9/nzFOYBSahaR9FpL2WUjaFzAyr2IUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMmW3Hfm7e
        wTjv1Ue9Q4xMHIyHGCU4mJVEeH+4mKYI8aYkVlalFuXHF5XmpBYfYjQFemcis5Rocj4wavNK
        4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpiChdVb5v/cUvGoVjLt
        xc5kK9m17nXKuzY8WtJT/y8/e53Km+mzbqwNlf4los9tfdJvjnT3/Jn3zs6znK2rsl9+7pK9
        yk+vJB+2FXUv+v4jKPRkrlOA1rzYkLrLwkIuK1/rtXo58qzey1o2g2NV9bvljk8f7wy+EK58
        9c9i/Y9XdnPzqEdPcjFe8fjPmmKF/3OtIqcWHV3w72t6xpIIy4WCwu760yUfxqd7+VV/nLPz
        8for7027xS5a+LSFneLW+33OyKxo8Y2z3itYz2/5377TT05zSZPV/G0v5E+fWSulfaNrq5H9
        6udfrxTv2HYsxSAodIdcf//+Vq2VTA1fkr/OO3uj/k7sCsMAC/E61qjVSizFGYmGWsxFxYkA
        1jU7ECIDAAA=
X-CMS-MailID: 20230412203420eucas1p2efd38df12efde2ca05c6b3a26f5a753b
X-Msg-Generator: CA
X-RootMTR: 20230412203420eucas1p2efd38df12efde2ca05c6b3a26f5a753b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230412203420eucas1p2efd38df12efde2ca05c6b3a26f5a753b
References: <CGME20230412203420eucas1p2efd38df12efde2ca05c6b3a26f5a753b@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ac3b43283923 ("module: replace module_layout with module_memory")
changed the struct module data structure from module_layout to
module_memory. The core_layout member which is used while loading
modules are not available anymore leading to the following error while
running gdb:

(gdb) lx-symbols
loading vmlinux
Python Exception <class 'gdb.error'>: There is no member named core_layout.
Error occurred in Python: There is no member named core_layout.

Replace core_layout with its new counterpart mem[MOD_TEXT].

Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 scripts/gdb/linux/constants.py.in | 3 +++
 scripts/gdb/linux/modules.py      | 4 ++--
 scripts/gdb/linux/symbols.py      | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 36fd2b145853..471300ba176c 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -62,6 +62,9 @@ LX_GDBPARSED(hrtimer_resolution)
 LX_GDBPARSED(IRQD_LEVEL)
 LX_GDBPARSED(IRQ_HIDDEN)
 
+/* linux/module.h */
+LX_GDBPARSED(MOD_TEXT)
+
 /* linux/mount.h */
 LX_VALUE(MNT_NOSUID)
 LX_VALUE(MNT_NODEV)
diff --git a/scripts/gdb/linux/modules.py b/scripts/gdb/linux/modules.py
index 441b23239896..261f28640f4c 100644
--- a/scripts/gdb/linux/modules.py
+++ b/scripts/gdb/linux/modules.py
@@ -13,7 +13,7 @@
 
 import gdb
 
-from linux import cpus, utils, lists
+from linux import cpus, utils, lists, constants
 
 
 module_type = utils.CachedType("struct module")
@@ -73,7 +73,7 @@ class LxLsmod(gdb.Command):
                 "        " if utils.get_long_type().sizeof == 8 else ""))
 
         for module in module_list():
-            layout = module['core_layout']
+            layout = module['mem'][constants.LX_MOD_TEXT]
             gdb.write("{address} {name:<19} {size:>8}  {ref}".format(
                 address=str(layout['base']).split()[0],
                 name=module['name'].string(),
diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index dc07b6d12e30..fdad3f32c747 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -15,7 +15,7 @@ import gdb
 import os
 import re
 
-from linux import modules, utils
+from linux import modules, utils, constants
 
 
 if hasattr(gdb, 'Breakpoint'):
@@ -109,7 +109,7 @@ lx-symbols command."""
 
     def load_module_symbols(self, module):
         module_name = module['name'].string()
-        module_addr = str(module['core_layout']['base']).split()[0]
+        module_addr = str(module['mem'][constants.LX_MOD_TEXT]['base']).split()[0]
 
         module_file = self._get_module_file(module_name)
         if not module_file and not self.module_files_updated:
-- 
2.39.2

