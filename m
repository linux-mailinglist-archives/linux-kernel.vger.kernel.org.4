Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00CB721E51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjFEGkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjFEGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:40:45 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E591A8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:40:27 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230605063947epoutp016412af0653ef499b5c008a03c07781b5~lsAjPJsa70125001250epoutp01b
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:39:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230605063947epoutp016412af0653ef499b5c008a03c07781b5~lsAjPJsa70125001250epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685947187;
        bh=OxC6IiBkP/1wJPHqMohXI0lIhCkm9lExvGDd6qgnKbo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sGR3U4cHzr4tO1qvd+pnU0RM+yKibpc3DR9khEY3owe/uoFYIXEtWBmQFINJ5eEUp
         FgokYn9EjfL7Ej1xws/2O0odaP+LqeBNkkxYMYtxcLz0VZyvQn7oAuIUF4OszuX3l1
         ZqgeRv5zUFV4lChPjHTTfxz1RUV+aehTOMrYI974=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230605063947epcas5p1607c700c3e8ad97eb82b144c59854442~lsAi6yPIA2728127281epcas5p1Z;
        Mon,  5 Jun 2023 06:39:47 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QZP9F2sW9z4x9Q2; Mon,  5 Jun
        2023 06:39:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.C4.44881.1338D746; Mon,  5 Jun 2023 15:39:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230605062713epcas5p15f43412fdef92c01567dd9c59a931d9b~lr1lK6zoR3202132021epcas5p1k;
        Mon,  5 Jun 2023 06:27:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230605062713epsmtrp2bb0b8a2d9f3937766ea60caf76d00072~lr1lKMnIH2725627256epsmtrp25;
        Mon,  5 Jun 2023 06:27:13 +0000 (GMT)
X-AuditID: b6c32a4a-ea9fa7000001af51-f4-647d833176d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.57.28392.1408D746; Mon,  5 Jun 2023 15:27:13 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605062712epsmtip25b85181936caa1d294c4f354afd6a9ac~lr1j7viKa2147721477epsmtip2F;
        Mon,  5 Jun 2023 06:27:12 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] null_blk: Fix: memory release when memory_backed=1
Date:   Mon,  5 Jun 2023 11:53:53 +0530
Message-Id: <20230605062354.24785-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmlq5hc22KwbR1whZNE/4yW6y+289m
        cfPATiaLvbe0LS7vmsNmse33fGYHNo/LZ0s9+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUz
        L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKuSQlliTilQKCCxuFhJ386mKL+0
        JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjcNtfxoIH3BXL3+1hb2C8
        zdHFyMkhIWAiseX5RMYuRi4OIYHdjBJbd55gg3A+MUpMPN0E5XxmlLiwtI0ZpqV7VStUYhej
        xPTHu6GcViaJXXvnATkcHGwC2hKn/4PtEBFQkOj5vRKshllgIaPEzlX3wSYJCzhL/H10kBXE
        ZhFQlWh98pMFxOYVsJI43PmLCWSOhIC+RP99QYiwoMTJmU/ASpgF5CWat85mBpkpIbCNXWLv
        jp1MENe5SEx/95wNwhaWeHV8CzuELSXx+d1eqHi5xMopK9ggmlsYJWZdn8UIkbCXaD3Vzwyy
        mFlAU2L9Ln2IsKzE1FPrmCAW80n0/n4CtYtXYsc8GFtZYs36BVDzJSWufW+Esj0kph47DHa0
        kECsxNLjXxknMMrPQvLPLCT/zELYvICReRWjZGpBcW56arFpgVFeajk8ZpPzczcxglOfltcO
        xocPPugdYmTiYDzEKMHBrCTCu8urOkWINyWxsiq1KD++qDQntfgQoykwjCcyS4km5wOTb15J
        vKGJpYGJmZmZiaWxmaGSOK+67clkIYH0xJLU7NTUgtQimD4mDk6pBiY1mzuN99as+pQnWJ9w
        6v+6hR+anuX2twi98tn7MIPNKGrK+aT/5cEaNg9E7dsl+S78WKUpMHu1yfduhZcONv+ed8gW
        SKs39JelbFq4pdvJPzPzX4Is/wzHlqdPNyklCixla9PPy93gu97xwuvdqssE/VTFGxUVH8vI
        Oz1Wi9VgF7uXL78ilvlTqvfE2RdX/Xq7+eAm0Zwsz/27s15r73/Ud+d1/BqRPxs+Lbdyk8rj
        6Fvi5+PIerxT8N3p+VuX1Tf23Tv7WUlNXkrGPizKe4/xTPli4fKc3ieGseLWfz+nvY7jWV0t
        7L5nzTNNhlvte/uvqnKuOlyWUWfG/jjENX7223se6hwRjjsP2fLPV2Ipzkg01GIuKk4EACzs
        U/4GBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSvK5jQ22Kwc4+WYumCX+ZLVbf7Wez
        uHlgJ5PF3lvaFpd3zWGz2PZ7PrMDm8fls6UefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlXG4
        7S9jwQPuiuXv9rA3MN7m6GLk5JAQMJHoXtXK1sXIxSEksINR4uGK72wQCUmJZX+PMEPYwhIr
        /z1nhyhqZpKY/3A1kMPBwSagLXH6P9ggEQEFiZ7fK8EGMQssZZR4e+Y1C0hCWMBZ4u+jg6wg
        NouAqkTrk59gcV4BK4nDnb+YQOZICOhL9N8XhAgLSpyc+QSshFlAXqJ562zmCYx8s5CkZiFJ
        LWBkWsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERyCWlo7GPes+qB3iJGJg/EQowQH
        s5II7y6v6hQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUa
        mMTCNCpTGIJ/mj9boP6/nWNqJu/rAutQ3SYjv9x9z47fvbXliuLSIwcyHi3aptmlUvt+9R4J
        t7pug/d7P6VynOBVZ7LrsP0ka9P5JthhouPHi/f5N9ote/E/otq0vOK9bMrOFSHcMenOYb8W
        v2z43J79vzi5YI5k8OmPN+wW7u67flOHbzLn5dxZzacK2uZss2Zb83pSGVehw4vN6+0j6yVV
        coTkj+oIfQpTT/h2aJbr4/Va27+Gztm2V9o7QcTHe1d3ILcn7zJfX9vvhaxrtn8zc2Zj3rp1
        74d9DTsep7lrPMnYKrsoSTI1Qm+PXvbM91MnN+q4Cghwcsl6lCY9uGJkscplw+J/5//fDOl3
        VmIpzkg01GIuKk4EAPcZc1qwAgAA
X-CMS-MailID: 20230605062713epcas5p15f43412fdef92c01567dd9c59a931d9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605062713epcas5p15f43412fdef92c01567dd9c59a931d9b
References: <CGME20230605062713epcas5p15f43412fdef92c01567dd9c59a931d9b@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory/pages are not freed, when unloading nullblk driver.

Steps to reproduce issue
  1.free -h
        total        used        free      shared  buff/cache   available
Mem:    7.8Gi       260Mi       7.1Gi       3.0Mi       395Mi       7.3Gi
Swap:      0B          0B          0B
  2.modprobe null_blk memory_backed=1
  3.dd if=/dev/urandom of=/dev/nullb0 oflag=direct bs=1M count=1000
  4.modprobe -r null_blk
  5.free -h
        total        used        free      shared  buff/cache   available
Mem:    7.8Gi       1.2Gi       6.1Gi       3.0Mi       398Mi       6.3Gi
Swap:      0B          0B          0B

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---

Added a blktest[1] block/034 to test the same issue.
We will raise a PR, if issue is acked and fix is pulled in kernel.

[1] https://github.com/nitesh-shetty/blktests/tree/fix/block/mem_leak
---
 drivers/block/null_blk/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index b3fedafe301e..864013019d6b 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2244,6 +2244,7 @@ static void null_destroy_dev(struct nullb *nullb)
 	struct nullb_device *dev = nullb->dev;
 
 	null_del_dev(nullb);
+	null_free_device_storage(dev, false);
 	null_free_dev(dev);
 }
 

base-commit: bc708bbd8260ee4eb3428b0109f5f3be661fae46
-- 
2.35.1.500.gb896f729e2

