Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9754172E3E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbjFMNQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbjFMNQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:16:48 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2331AA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 06:16:46 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230613131644euoutp0132402f1a8e71662ceacd72cd9c4c9294~oOla8kNAt0759807598euoutp01d
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:16:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230613131644euoutp0132402f1a8e71662ceacd72cd9c4c9294~oOla8kNAt0759807598euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686662204;
        bh=tdJ26CzwUNtoD1F5zxf6fVxgrheMECD4aIoiMBnelJM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=u5Gjj5z1GnZv+zBc+EEayj9fISS21pe+g9wqJUlsiOrW5htT3IdJurtQBO/gm0SU/
         MrNF4CioShxSQqDlyElvBhr3sZOiM4Jd+8xrRcGIgO436BDIXe2qhbKS85TpmgP4+Z
         pnjd74PnsQDGEVu4Z2FccLV5AcvBNgpXceOuZJBI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230613131644eucas1p10eabc3b227115c7d80625c2d78b9482b~oOlaxHLos1967419674eucas1p1o;
        Tue, 13 Jun 2023 13:16:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7A.96.42423.C3C68846; Tue, 13
        Jun 2023 14:16:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230613131644eucas1p2b232fef36f6ae621827674c775a6e070~oOlaZeNy80170301703eucas1p2E;
        Tue, 13 Jun 2023 13:16:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230613131644eusmtrp2bf8463164bda1557e77a55eee42cf0ca~oOlaY1gWj1442014420eusmtrp2a;
        Tue, 13 Jun 2023 13:16:44 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-9d-64886c3ce4d2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 96.BD.14344.B3C68846; Tue, 13
        Jun 2023 14:16:43 +0100 (BST)
Received: from AMDC4653.eu.corp.samsungelectronics.net (unknown
        [106.120.51.32]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230613131643eusmtip2e64783492535fa8b12338b59a703f93d~oOlZ_lxzT0942009420eusmtip2s;
        Tue, 13 Jun 2023 13:16:43 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: Fix best_parent_rate after moving code into a separate
 function
Date:   Tue, 13 Jun 2023 15:16:31 +0200
Message-Id: <20230613131631.270192-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOV2bnI4UgwNbxS0+9txjtbi8aw6b
        xdojd9kt2jqXsVpcPOVq8e/aRhYHNo/3N1rZPTat6mTz6NuyitHj8ya5AJYoLpuU1JzMstQi
        fbsErownQNmCnawVp+/8YG9gPMDSxcjJISFgIrH38iq2LkYuDiGBFYwS5998YodwvjBKTLg+
        iwXC+cwoMfnIfLiWaeuOQrUsZ5S4dqAJqqqVSeLouwawKjYBQ4mut11sILaIQJnErUMXmUFs
        ZoEsiW0/PgLt4OAQFgiXuHVbECTMIqAq8XD7R1YQm1fATmLvuzZmiGXyEvsPnmWGiAtKnJz5
        hAVijLxE89bZzCB7JQR6OSTaJ/xihWhwkZj7cjcbhC0s8er4FnYIW0bi/875TBAN7YwSC37f
        h3ImMEo0PL/FCFFlLXHn3C82kOuYBTQl1u/Shwg7Siy/Oh0sLCHAJ3HjrSDEEXwSk7ZNZ4YI
        80p0tAlBVKtJzDq+Dm7twQuXoH7xkHh4aydYXEggVuLxh7NMExgVZiF5bRaS12Yh3LCAkXkV
        o3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYFo5/e/4px2Mc1991DvEyMTBeIhRgoNZSYT3
        qUZ7ihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6YklqdmpqQWpRTBZJg5OqQYm82/d
        /cbiO2LlfnV3uU9+VBuw/Pkpsz9TjgZYpOwNFEitl/GoMueorrhStdYuvWOG1XpLRZMbDons
        anueJW9/t3q547WS6UaxxQoTl3EtPNI04/ws7WlcSjW2azhv6D62Xn+mjFvIr3C6jtbbkoS3
        2975CRtt2CFSPWdrsNJXoRWcEd+cJEuW6x9g3hnqwBMwk+eY7t3XeWcisxLe1gVtPSu/Nta4
        gk0q6ckerZ076pgfbbu6XoD77VKm4pP/3uwLZpme2nb7rf+rCxU9Tq3txS1ZU+cKFF4va+pJ
        WmDgvO5ohFJqS/HkV1r5Yiu3PTnyyLyxI5Hv9cvw/S2NJz46X/i5MPd8IKN20+a9wTxKLMUZ
        iYZazEXFiQBqfVvnmgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t/xe7rWOR0pBhN2W1t87LnHanF51xw2
        i7VH7rJbtHUuY7W4eMrV4t+1jSwObB7vb7Sye2xa1cnm0bdlFaPH501yASxRejZF+aUlqQoZ
        +cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlPgCYU7GStOH3nB3sD
        4wGWLkZODgkBE4lp646ydTFycQgJLGWUuPnlJSNEQkbi5LQGVghbWOLPtS6oomYmicMzpoJ1
        swkYSnS9BUlwcogIVEhcXXoQKM7BwSyQI/HxhCdIWFggVOLV3TlgJSwCqhIPt38Em8krYCex
        910bM8R8eYn9B88yQ8QFJU7OfAI2nhko3rx1NvMERr5ZSFKzkKQWMDKtYhRJLS3OTc8tNtIr
        TswtLs1L10vOz93ECAzmbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4n2q0pwjxpiRWVqUW5ccX
        leakFh9iNAW6byKzlGhyPjCe8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg
        +pg4OKUamATE7NV5/S/kdIYv5GCrqU95eXyl7InTM/MPPkg+GV7ipfJnzbKvjrrv5xtO3b/0
        hJPSn+UmrbyPA3mlH7OrWwbyrnp7U4RN0jV6b4vXTrlDPWXqO6qvbj509F9An5OPVJ3YZMPL
        EvwX52485Hzv1ptH/xwFr14VNb/c8P/zfYkVCzSnrAluC9jF5P96eVDSE5FP2wsfhExNUf4l
        FRd572PLqbZ5H9lDlz24KfhDXmnitD3LcpLe9TVETV5zJt4+Q+eNZmuD6MZvGdNeLe49kslm
        E167QeD7gZoKoVfL7hQ/+6q5xrA7ZsLVlZc/PJSUN+LKWHmbq4OzhTm7Pnz6nYjs7g+8/OkL
        fk7cfP6lobcSS3FGoqEWc1FxIgAbjHQL7wIAAA==
X-CMS-MailID: 20230613131644eucas1p2b232fef36f6ae621827674c775a6e070
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230613131644eucas1p2b232fef36f6ae621827674c775a6e070
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230613131644eucas1p2b232fef36f6ae621827674c775a6e070
References: <CGME20230613131644eucas1p2b232fef36f6ae621827674c775a6e070@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

best_parent_rate entry is still being used in the code and needs to be
always updated regardless of the CLK_SET_RATE_NO_REPARENT flag.

Fixes: 1b4e99fda73f ("clk: Move no reparent case into a separate function")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ffc9f03840b7..7ac9f7a8cb84 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -629,6 +629,7 @@ clk_core_determine_rate_no_reparent(struct clk_hw *hw,
 		best = clk_core_get_rate_nolock(core);
 	}
 
+	req->best_parent_rate = best;
 	req->rate = best;
 
 	return 0;
-- 
2.34.1

