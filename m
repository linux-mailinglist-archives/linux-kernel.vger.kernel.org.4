Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED36767C435
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 06:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbjAZFRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 00:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjAZFRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 00:17:20 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A339B94
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 21:17:17 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230126051714epoutp024ee8b2d0fd23b9808f57ee7d7609ac60~9xBXe0wpx1433914339epoutp02I
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:17:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230126051714epoutp024ee8b2d0fd23b9808f57ee7d7609ac60~9xBXe0wpx1433914339epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674710234;
        bh=tf47z4WkEzIq8ucn2BQHkI5enJGJBrM1Pg/KrVuZF8E=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bPEwFNVXjY7q5lqGrIPoMm2CArZ0LcZlrfPXDdZpBrTiElGLiVqHLaDKKBE4PP+YB
         v+clWVnNAWVglDaFYMgkD0XMTyg7WdB0ixz160G9dBzT7YR8uWA8fTDAztTz3CZsXa
         DD5WOgiGGO0pRoQlY56G6hCAEIypAcpm9f5MVNpc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230126051714epcas1p39001e95eed4de08843e9c2e357600e8f~9xBXCg4Tu2675926759epcas1p3f;
        Thu, 26 Jan 2023 05:17:14 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.225]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4P2TV15jWqz4x9QC; Thu, 26 Jan
        2023 05:17:13 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.22.37890.9DC02D36; Thu, 26 Jan 2023 14:17:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230126051713epcas1p10a9005ad21887893a486100cbbd376e5~9xBWBHD_Z3046130461epcas1p1Z;
        Thu, 26 Jan 2023 05:17:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230126051713epsmtrp29ef211aaf6049ac09c8c004a60e32bed~9xBV-ff9B0640206402epsmtrp2B;
        Thu, 26 Jan 2023 05:17:12 +0000 (GMT)
X-AuditID: b6c32a38-5fbfa70000029402-cd-63d20cd9145c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.49.05839.8DC02D36; Thu, 26 Jan 2023 14:17:12 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.98.193]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230126051712epsmtip11db06bc5c3a7856d664ffbc5c3c40efa~9xBVsnohH1081310813epsmtip1C;
        Thu, 26 Jan 2023 05:17:12 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     Ming Lei <ming.lei@canonical.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, huijin.park@samsung.com,
        bbanghj.park@gmail.com
Subject: [PATCH] loop: change fsync to fdatasync when update dio
Date:   Thu, 26 Jan 2023 14:16:57 +0900
Message-Id: <20230126051657.163497-1-huijin.park@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmru5NnkvJBkd7tS1W3+1ns3i59xCz
        xcrVR5ksOi66WDy9OovJYu8tbYvLu+awWex6+J3dgcNjVkMvm8fOWXfZPS6fLfXYfbOBzaO3
        +R2bR9+WVYwenzfJBbBHNTDaJBYlZ2SWpSqk5iXnp2TmpdsqhYa46VooKWTkF5fYKkUbGhrp
        GRqY6xkZGemZGsVaGZkqKeQl5qbaKlXoQvUqKRQlFwDV5lYWAw3ISdWDiusVp+alOGTll4L8
        oVecmFtcmpeul5yfq6RQlphTCjRCST/hG2PGxPXt7AX7WSvWH2tlamDcx9LFyMkhIWAi0X73
        BWMXIxeHkMAORokdu68zQzifGCV2/zvPCFIlJPCNUeLlogSYjp5919ggivYySizfdYgFruPI
        uwVsIFVsAtoS19duBesWEUiXOPhnPdgOZoGpjBILZ+4HKxIWcJDY8PA5K4jNIqAq8f7xZ7Cj
        eAVsJbY2zmWEWCcvMfPSd3aIuKDEyZlPwGqYgeLNW2czQ9TcY5fo+5fUxcgBZLtIrL+QCxEW
        lnh1fAs7hC0l8fndXjYIO11iw+SjUP8XSKyYuwYqbizx7u1aZpAxzAKaEut36UOEFSV2/oa5
        RlDi9LVuZogL+CTefe1hhdjKK9HRJgRRoiqx+OpHVghbWuLQg7tQrR4SLU//s4OUCwnESjT8
        FZ3AqDALyVuzkLw1C+GGBYzMqxjFUguKc9NTiw0LTJBjeBMjONlqWexgnPv2g94hRiYOxkOM
        EhzMSiK8PbPPJwvxpiRWVqUW5ccXleakFh9iTAYG9ERmKdHkfGC6zyuJNzQzs7SwNDIxNDYz
        NCQsbGJpYGJmZGJhbGlspiTOK257MllIID2xJDU7NbUgtQhmCxMHp1QD0wwmnsvbD06wqsq6
        wlf4Ncg3u2K6UNf2R+dj4p0S9Z0tGeckzq7bacuvfpBBdk1o9YkjFz6Jat/vypmhcLLHpa5c
        O4J/L9PBtsxL6h73Jk8V3ReXlCWf0rI6+Vkx/6cie+XCRQ+jDjEenhrxs8vWK/hgzF7uTwcF
        P599257E6fW66fv+I5fSvmdkGy9r80iczHLv/j6R9rjFb87Ir3oXkrr29+6jXZf2T8hrk+n/
        WrHV/4DQxkCdvBS3I7MuHfz3Szjrb6byN/dfO/YXmS3JXhJhx5x36Pjqd367mnvf2Efu5lyi
        a1Of72HWtSUyI9Lgxf7Olqx/DmetmJb0vv0puUj+1TedBKEN1s1LytcwKbEUZyQaajEXFScC
        AG5zCyhtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO4NnkvJBhvbjS1W3+1ns3i59xCz
        xcrVR5ksOi66WDy9OovJYu8tbYvLu+awWex6+J3dgcNjVkMvm8fOWXfZPS6fLfXYfbOBzaO3
        +R2bR9+WVYwenzfJBbBHcdmkpOZklqUW6dslcGVMXN/OXrCftWL9sVamBsZ9LF2MnBwSAiYS
        PfuusXUxcnEICexmlDj46x5UQlri3c7rrF2MHEC2sMThw8UQNR8YJXqPrAGrYRPQlri+disj
        iC0ikCnRtfcgI0gRs8BMRon3E7+wgiSEBRwkNjx8DmazCKhKvH/8GayZV8BWYmvjXEaIZfIS
        My99Z4eIC0qcnPkErIYZKN68dTbzBEa+WUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxLLdcrTswt
        Ls1L10vOz93ECA5fLc0djNtXfdA7xMjEwXiIUYKDWUmEt2f2+WQh3pTEyqrUovz4otKc1OJD
        jNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamA5XyuziKdjxqzRyabjVsjf1D3+tK1cW
        s/r/XOWBwC8rb2utY/yMr16yy0d2tBqrTJpgtEFD8+YVmV2P5h4QXlTe/Udn8dvqs0/2Bxon
        LHmjN6Nw7vaFzBFb33W5re1taXzey75rv1OkccTla3qTMrKUFu7lagvXyIs8X3hiwTvmK+yf
        OR7UXI91+GLsvHCJHeP+FQ9frJjj3qimfWzSoX895Zs0HFkuxGYfOBZ348ALo+urucWm1Sye
        38h34JVZxuRuTsP01bdKFKRiku5LSOguWmjWcZ775uuDc3I+F6dPDNzLbdeo+2RSdZeJ/s68
        aI6tt3632O494rEoxI0tJ+r0X139uPfJ37xTZJmjK5VYijMSDbWYi4oTAenrUo/OAgAA
X-CMS-MailID: 20230126051713epcas1p10a9005ad21887893a486100cbbd376e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230126051713epcas1p10a9005ad21887893a486100cbbd376e5
References: <CGME20230126051713epcas1p10a9005ad21887893a486100cbbd376e5@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, fsync has a larger overhead than fdatasync. And since the
dio option is for data, it seems like fdatasync is enough.
So this patch changes it to fdatasync which has little load relatively.

Signed-off-by: Huijin Park <huijin.park@samsung.com>

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1518a6423279..6c7ce8be8c0c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -203,7 +203,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		return;
 
 	/* flush dirty pages before changing direct IO */
-	vfs_fsync(file, 0);
+	vfs_fsync(file, 1);
 
 	/*
 	 * The flag of LO_FLAGS_DIRECT_IO is handled similarly with
-- 
2.17.1

