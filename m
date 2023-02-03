Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B2689283
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjBCInM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBCInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:43:10 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F5EC126E6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 00:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2/Kzq
        scKzGfSW5bIOswCBQ7pZPgpX1NYp6RGAiZBDks=; b=j3Hfi+TFwZ1Vomk6cshx8
        i50+Jcq9XTnwEZP7eB2CbcSeOHxVGkYfpbNt8uLhlr8RTP9PTCk73OyDKGy55DBN
        6+RJZWrQE5EifU7seUaDPHL1WQnhvs+wxUpuiSnDoAYc/FEocoRsf7fkMCJ6Zh+p
        Q3a2psgcMI8yzOIlcc/dC0=
Received: from leanderwang-LC2.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g2-3 (Coremail) with SMTP id _____wCHiLIXydxjUofKCg--.60360S2;
        Fri, 03 Feb 2023 16:43:03 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     tianjia.zhang@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        alex000young@gmail.com, Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH] lib/mpi: Fix poential NULL pointer dereference in mpi_fdiv_q
Date:   Fri,  3 Feb 2023 16:43:02 +0800
Message-Id: <20230203084302.589017-1-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHiLIXydxjUofKCg--.60360S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW5Zw1DZry8ur15Gr4xtFb_yoWkurbEkF
        yIqr1UAr1Uur109w15CF40gr4DA3Z8ur42kF42gw12grWDWFZ3WFWqg393tFZrCF4ak3yU
        Cr1rZrW5Xw42vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtl1kDUUUUU==
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/1tbiXBgLU1Xl5gbdbgAAs-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in lib/mpi, there is multiple function that not check the return
value of mpi_alloc. One case is mpi_fdiv_q, if tmp == NULL,
tmp->nlimbs in mpi_fdiv_qr will cause NULL pointer dereference.
As the code is too much, here I only fix one of them. Other
function like mpi_barrett_init mpi_copy mpi_alloc_like mpi_set
mpi_set_ui mpi_alloc_set_ui has the same problem.

Please let me know if there is a better way to fix the
problem.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger.

Fixes: a8ea8bdd9df9 ("lib/mpi: Extend the MPI library")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
---
 lib/mpi/mpi-div.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/mpi/mpi-div.c b/lib/mpi/mpi-div.c
index 45beab8b9e9e..e8642265d7d4 100644
--- a/lib/mpi/mpi-div.c
+++ b/lib/mpi/mpi-div.c
@@ -43,7 +43,8 @@ void mpi_fdiv_r(MPI rem, MPI dividend, MPI divisor)
 void mpi_fdiv_q(MPI quot, MPI dividend, MPI divisor)
 {
 	MPI tmp = mpi_alloc(mpi_get_nlimbs(quot));
-	mpi_fdiv_qr(quot, tmp, dividend, divisor);
+	if (tmp)
+		mpi_fdiv_qr(quot, tmp, dividend, divisor);
 	mpi_free(tmp);
 }
 
-- 
2.25.1

