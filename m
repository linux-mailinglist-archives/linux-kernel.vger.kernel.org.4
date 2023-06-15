Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386D273124C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244881AbjFOIfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244962AbjFOIer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:34:47 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A152953
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:34:44 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230615083440epoutp0260ca3512ac1ddd6561cd32365ba5875c~oyBt9Ovcg0276802768epoutp02s
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:34:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230615083440epoutp0260ca3512ac1ddd6561cd32365ba5875c~oyBt9Ovcg0276802768epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686818080;
        bh=28G63YvIi7FLitcBfrYvIyJdeCWxgKdJnOj57pS63+w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gxInRjp7P1ZQ6UPmYBdRDFJfzhuH+SXqag0ricjTI1pQB1Q/iAr8BzC7iRSCpr/uk
         VpaHyghXhvpMRZIGzMS2tOpon0z9RV6xq2XVHIu7ieECz1OqPduDmE49Ix2UQnRr7T
         vfJ9JZ35XrKgISCEEBMfzpZRHyQ7xDjdccmJdBCQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230615083440epcas5p103284c537e0ed8943f2cdb5697ccd4b3~oyBtXIMdK1714017140epcas5p1z;
        Thu, 15 Jun 2023 08:34:40 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QhbFB3B2nz4x9Pt; Thu, 15 Jun
        2023 08:34:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.7C.04567.E1DCA846; Thu, 15 Jun 2023 17:34:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230615081227epcas5p40cd9cdf762fcaeedaa8cf8d92d425560~oxuUcsGE00557205572epcas5p4G;
        Thu, 15 Jun 2023 08:12:27 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230615081227epsmtrp1a7593db1d556a01f51cad6278ccd9477~oxuUbqRZ30952309523epsmtrp1T;
        Thu, 15 Jun 2023 08:12:27 +0000 (GMT)
X-AuditID: b6c32a49-943ff700000011d7-c8-648acd1edd0f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.55.28392.BE7CA846; Thu, 15 Jun 2023 17:12:27 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230615081226epsmtip2417f38e07ea705557826ebf7705fbdf5~oxuTBA5KE2260022600epsmtip25;
        Thu, 15 Jun 2023 08:12:26 +0000 (GMT)
From:   "min15.li" <min15.li@samsung.com>
To:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org, wsa@kernel.org,
        vkoul@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "min15.li" <min15.li@samsung.com>
Subject: [PATCH] block: add capacity validation in bdev_add_partition()
Date:   Thu, 15 Jun 2023 16:09:29 +0000
Message-Id: <20230615160929.9240-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmuq7c2a4Ug5NnRS1W3+1ns3iw396i
        efF6Nosbx98xW8x9fYnFYuXqo0wWe29pW1zeNYfNYvmqDiaLsxM+sFrsvHOC2eL3D6DY3f1z
        GS1urLvK4sDnsXmFlsfls6Uem1Z1snnsn7uG3WP3zQY2j74tqxg9Pm+SC2CPyrbJSE1MSS1S
        SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpXSaEsMacUKBSQWFys
        pG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8f38NJaC9ewV
        R/o2szUw/mLtYuTkkBAwkVjWfoa9i5GLQ0hgN6PE0UcvmSGcT4wSXxqOQzmfGSWWfLjICNNy
        asNnVojELkaJ10c3QvU/Z5TYsnYuC0gVm4C6xIGPR9lBbBGBDqDEUU4Qm1kgSWLGst9sILaw
        gLvEzccHwGpYBFQlpt9+DdbLK2AhMWXiFWaIbfIS+w+eZYaIC0qcnPmEBWKOvETz1tlQNa0c
        Ekev+kPYLhJzfj9lgrCFJV4d38IOYUtJvOxvA7I5gOxiiZc/wiDCNRK7v92GKreW2LZ+HRNI
        CbOApsT6XfoQYVmJqafWMUFs5ZPo/f0EqpxXYsc8GFtJ4u+Fc9DwkZBYvP8hK8QmD4k/3YIg
        YSGBWIm2tj6WCYzys5D8MgvJL7MQFi9gZF7FKJlaUJybnlpsWmCYl1oOj9bk/NxNjOBEq+W5
        g/Hugw96hxiZOBgPMUpwMCuJ8C470ZUixJuSWFmVWpQfX1Sak1p8iNEUGMATmaVEk/OBqT6v
        JN7QxNLAxMzMzMTS2MxQSZxX3fZkspBAemJJanZqakFqEUwfEwenVANTmuNpNeVSY3WjyLdr
        +q9LfCxn1fd23f7A8ETmeTX/Z7HZ9ZNWLN5rvDH5FnufUihD5nSf9R5Wu86s3nVZY+Ou2IyW
        3nbFpmcb281+9Uzav1c2jMGSR0bYv+6PscbXnquN2qEZvcv7frd6pN5U0OvjYJaxErXtsDuz
        UVt1qu7DxbyHSi7ql+vFu1ns2nJ/onnM7OOXE7I7VJTvvbiixCR9flbsz8aG/TH5vNxq22pS
        1kVp+gm+5RV9UTk97syKvDxvz5fbjFs+am94+0DmX4mp174u8xdnrkkk7KnVWOKTqPFx2i+V
        D7svKb+UKla/3Zy56fsdfV8hj0+Oeh0dE3jP2qZd+nfgofUXK5eF+5VYijMSDbWYi4oTATAB
        A7E9BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSvO7r410pBn+uaVmsvtvPZvFgv71F
        8+L1bBY3jr9jtpj7+hKLxcrVR5ks9t7Stri8aw6bxfJVHUwWZyd8YLXYeecEs8XvH0Cxu/vn
        MlrcWHeVxYHPY/MKLY/LZ0s9Nq3qZPPYP3cNu8fumw1sHn1bVjF6fN4kF8AexWWTkpqTWZZa
        pG+XwJXx/fw0loL17BVH+jazNTD+Yu1i5OSQEDCROLXhM5DNxSEksINR4uyyq1AJCYnz836x
        QdjCEiv/PWeHKHrKKPH/7gOwBJuAusSBj0fBEiICkxgl7l94DdbNLJAicWVpJzuILSzgLnHz
        8QEwm0VAVWL67dcsIDavgIXElIlXmCE2yEvsP3iWGSIuKHFy5hMWiDnyEs1bZzNPYOSbhSQ1
        C0lqASPTKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4NDX0trBuGfVB71DjEwcjIcY
        JTiYlUR4n2q0pwjxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TB
        KdXANPlpyvbrBk9YDjx6XdqyOFc7X2t/VXd9yfe85ni+NcsiLlf8/7XxZmbgptADJpec177Y
        /IStO27aur+C7GoihvGFf1g2LNw2kUcn9tafNc+XZSfbfb5z3V/qkBLD32+TKtXWfkhUvbf7
        9145VsVpCe7b63wvrl22P64uyMV2y/3A/QuvzTS4yNHX4VLoZvjgwO7Y73tfv+jcoN62Yt63
        600H6405WWuC40qOzTH/Pzs6481blmNlCtpc82Pql7qamavKrepbYDXTM7Z9koe+WcvDD8+n
        ZtxMjlJ4x7Llz58zNjo9MS/KVfTCD2U8kdkpafDLYnKBVtbnr48bLoqzTbzQZVHTyezwIOLY
        jm132JRYijMSDbWYi4oTAefION3sAgAA
X-CMS-MailID: 20230615081227epcas5p40cd9cdf762fcaeedaa8cf8d92d425560
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230615081227epcas5p40cd9cdf762fcaeedaa8cf8d92d425560
References: <CGME20230615081227epcas5p40cd9cdf762fcaeedaa8cf8d92d425560@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function bdev_add_partition(),there is no check that the start
and end sectors exceed the size of the disk before calling add_partition.
When we call the block's ioctl interface directly to add a partition,
and the capacity of the disk is set to 0 by driver,the command will
continue to execute.

Signed-off-by: min15.li <min15.li@samsung.com>
---
 block/partitions/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 49e0496ff23c..9806a804e1a4 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -445,6 +445,12 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		goto out;
 	}
 
+	if (start >= get_capacity(disk) ||
+		start + length > get_capacity(disk)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (partition_overlaps(disk, start, length, -1)) {
 		ret = -EBUSY;
 		goto out;
-- 
2.34.1

