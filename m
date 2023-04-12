Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181E66DF320
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDLLYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDLLYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:24:33 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91F72B8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:24:10 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230412112345euoutp01a4bd5189cdc466b86db6c0e5dda30a00~VLDE6OsQi2017720177euoutp01i
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:23:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230412112345euoutp01a4bd5189cdc466b86db6c0e5dda30a00~VLDE6OsQi2017720177euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681298625;
        bh=fdMxTaimtY9PGTCHo9yrggTuFyYb15asKrJ56OGTy2M=;
        h=From:To:CC:Subject:Date:References:From;
        b=U2CXHgM18lINoJOqdDtl/aF6HLrEDRylr3mO9EWQyK8lOSTDBY9j1aHj5byq+MyMZ
         fXyU4o8M24sfbTFpXjGU3rIdHxlghROOmSTqSS62aiNGANG7VrXRuWURitF2THvIGb
         EBABdcykVVWj06CeXSgPeIwLzSx9TREHSGGdBUuo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230412112345eucas1p22aeb7a28114cfcf9075d4cdb0ab230f9~VLDElUrT_2347623476eucas1p2G;
        Wed, 12 Apr 2023 11:23:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5F.B6.10014.1C496346; Wed, 12
        Apr 2023 12:23:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230412112345eucas1p10c0ab064156268c9021abe9fc6bf1fd3~VLDEMmYJU1472114721eucas1p1b;
        Wed, 12 Apr 2023 11:23:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230412112345eusmtrp187b95d9ed7ac3702ce5c23d2ca7bfb27~VLDEMJCFh0093500935eusmtrp1J;
        Wed, 12 Apr 2023 11:23:45 +0000 (GMT)
X-AuditID: cbfec7f5-ba1ff7000000271e-78-643694c1167a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 23.B2.34412.0C496346; Wed, 12
        Apr 2023 12:23:44 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230412112344eusmtip18b2d00b41d48baa46a7529cc316f61e3~VLDECS2Tv2758727587eusmtip1u;
        Wed, 12 Apr 2023 11:23:44 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 12 Apr 2023 12:23:40 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <jan.kiszka@siemens.com>, <kbingham@kernel.org>
CC:     <gost.dev@samsung.com>, <linux-kernel@vger.kernel.org>,
        <song@kernel.org>, <mcgrof@kernel.org>, <p.raghav@samsung.com>
Subject: [PATCH] scripts/gdb: use mem instead of core_layout to get the
 module address
Date:   Wed, 12 Apr 2023 13:15:08 +0200
Message-ID: <20230412111508.892296-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djP87oHp5ilGCz4JWVx7+ZNZotT3ZuZ
        LC7vmsNmcWPCU0aL48v/sjmwemxa1cnmsf3kJCaPz5vkApijuGxSUnMyy1KL9O0SuDIm31jG
        VHCPv2Li4ZfsDYxXeLoYOTkkBEwkujq+s3cxcnEICaxglNhzZzWU84VRou1mCwuE85lR4tjF
        6cwwLZtnT2WDSCxnlGi53YZQterzeqjMFkaJl42HgVo4ONgEtCQaO9lBukUEjCVeTD7GBhJm
        FqiRmHzZECQsLBAh8eHDZLAFLAKqErs//2YCsXkFrCT27F7OClIuISAvsfiBBERYUOLkzCcs
        IDYzULh562xmCFtC4uCLF1B3Kkk0bD7DAmHXSuxtPgD2mYTADg6JX8/boBIuEut62qAahCVe
        Hd/CDmHLSJye3ANVUy3x9MZvZojmFkaJ/p3r2SAOspboO5MDUeMosaptGSNEmE/ixltBiHv4
        JCZtm84MEeaV6GgTgqhWk1h97w3LBEblWUi+mYXkm1lIvlnAyLyKUTy1tDg3PbXYOC+1XK84
        Mbe4NC9dLzk/dxMjMIWc/nf86w7GFa8+6h1iZOJgPMQowcGsJML7w8U0RYg3JbGyKrUoP76o
        NCe1+BCjNAeLkjivtu3JZCGB9MSS1OzU1ILUIpgsEwenVANTznUxrkxjD3GRhwyrGRJXyDxh
        F7q7paa4+sFaoZK/t9a1Om3fckdA+slzS+7qi8/lNaYv262z5vTx1l+ffjxVP1Z2dE/keg6F
        Z7Y/hPdt/rfzsCGnW9KXvo33jbn6eBTNuLVPR9nek9198kD6rP5zhUydKW3ht603mEhNP+Uh
        5LNEUcJkD1PgmQLdjE2WbTFeL0JZel4ujpn9oNCmfsPKmotTwjheeU7f4bBGkDU18EzpPEnb
        L5uDv2btfdOjNnnpI5XFXrLfjNPrxDb1CSexvKwpjDr2OL9KtvDr5VsBUbc35h3cF/v73fPH
        PVsXWhZWt1/Ls7awT3JPmDK7+OYUuWaVq+ZL+tet+380fPM/JZbijERDLeai4kQADt5sZpAD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42I5/e/4Xd0DU8xSDG5csbG4d/Mms8Wp7s1M
        Fpd3zWGzuDHhKaPF8eV/2RxYPTat6mTz2H5yEpPH501yAcxRejZF+aUlqQoZ+cUltkrRhhZG
        eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmTbyxjKrjHXzHx8Ev2BsYrPF2MnBwS
        AiYSm2dPZeti5OIQEljKKPHp5G02iISMxMYvV1khbGGJP9e6oIo+Mko0bJ7KDJIQEtgC5Jy2
        62Lk4GAT0JJo7GQHCYsIGEu8mHwMbA6zQI3E4w2rweLCAmES26fuYwKxWQRUJXZ//g1m8wpY
        SezZvZwVZIyEgLzE4gcSEGFBiZMzn7BAjJGXaN46mxnClpA4+OIFM8RpSkDXnGGBsGslOl+d
        ZpvAKDQLSfssJO2zkLQvYGRexSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERgx24793LKDceWr
        j3qHGJk4GA8xSnAwK4nw/nAxTRHiTUmsrEotyo8vKs1JLT7EaAr0zkRmKdHkfGDM5pXEG5oZ
        mBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MAXt9d537DGjpJHcmhS+9b5p
        X3oWBz287RKyekY8q/K0z6X7p7F8sjvqlmnzrUbQ4AsHf6Ca/0YHNsEzTqtE1+0vvnQ3Y++i
        d9cqNkrPWGTwIcxuQvumhDdcLryS99Yle1/1VmKVquz5XHtAdO0G8+tf99bf11ujHzX/8+nL
        nMniH90lpidd8bviOEst6UPLMWPZ7yuEb1Q8WnBFfPHBor7tX56s7hGYFrHj/cPtSy4b/Vxo
        ukBmpd7MeUsDRf/XV/5c15474U2fle3d7oT5Dit5Vm3+1OWh+cVP4u6OTN4pTK5PHjqnBC6I
        aGpz2zUvaHfG0xl97TKqZucf/gt5WubsHrntbv7Sf4yT3wetU9ZWYinOSDTUYi4qTgQA1cl5
        QiEDAAA=
X-CMS-MailID: 20230412112345eucas1p10c0ab064156268c9021abe9fc6bf1fd3
X-Msg-Generator: CA
X-RootMTR: 20230412112345eucas1p10c0ab064156268c9021abe9fc6bf1fd3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230412112345eucas1p10c0ab064156268c9021abe9fc6bf1fd3
References: <CGME20230412112345eucas1p10c0ab064156268c9021abe9fc6bf1fd3@eucas1p1.samsung.com>
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
 scripts/gdb/linux/modules.py | 2 +-
 scripts/gdb/linux/symbols.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/modules.py b/scripts/gdb/linux/modules.py
index 441b23239896..6ec51e913070 100644
--- a/scripts/gdb/linux/modules.py
+++ b/scripts/gdb/linux/modules.py
@@ -73,7 +73,7 @@ class LxLsmod(gdb.Command):
                 "        " if utils.get_long_type().sizeof == 8 else ""))
 
         for module in module_list():
-            layout = module['core_layout']
+            layout = module['mem'][0]
             gdb.write("{address} {name:<19} {size:>8}  {ref}".format(
                 address=str(layout['base']).split()[0],
                 name=module['name'].string(),
diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index dc07b6d12e30..3a7976401e00 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -109,7 +109,7 @@ lx-symbols command."""
 
     def load_module_symbols(self, module):
         module_name = module['name'].string()
-        module_addr = str(module['core_layout']['base']).split()[0]
+        module_addr = str(module['mem'][0]['base']).split()[0]
 
         module_file = self._get_module_file(module_name)
         if not module_file and not self.module_files_updated:
-- 
2.39.2

