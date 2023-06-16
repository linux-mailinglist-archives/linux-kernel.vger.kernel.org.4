Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E61732C62
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjFPJny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbjFPJnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:43:17 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7D23A8C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:42:53 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230616094228epoutp02f7f00e7a32764bc4813cddf0d00b5658~pGmMhG8Lr0507605076epoutp02R
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:42:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230616094228epoutp02f7f00e7a32764bc4813cddf0d00b5658~pGmMhG8Lr0507605076epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686908548;
        bh=oWIj79E/6JkqBTQXFwgb0y29I1jook9TSDLjz17j/Ro=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VKb4aXSVZc9k3hJBzqeYBeG7+XKOFSN5N/eVoqfediswF8ecOHmqax5OJ5nOeGWms
         JdCzREtPdGaQFnlfOip+6iS4u3BFt4xY1UBEq44yqypQ9PGi6sb9FiR2OSZ/1AUGVd
         0+UA+M7xlvCS2/a0bXeL24H9Xl3cksCaqGMOzo9o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230616094227epcas5p1217672b323c59851039ba2dfe2d8f871~pGmL4qk_91222412224epcas5p10;
        Fri, 16 Jun 2023 09:42:27 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QjDhy06FCz4x9Q1; Fri, 16 Jun
        2023 09:42:26 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BB.6B.44881.18E2C846; Fri, 16 Jun 2023 18:42:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230616092054epcas5p340e977377808d2df7210dc4a7d6c1d8e~pGTW82UBX1047010470epcas5p3F;
        Fri, 16 Jun 2023 09:20:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230616092054epsmtrp26644f7cb738c71b1ed4143127792c838~pGTW79WFv2884728847epsmtrp25;
        Fri, 16 Jun 2023 09:20:54 +0000 (GMT)
X-AuditID: b6c32a4a-c47ff7000001af51-3c-648c2e8129e4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.DF.27706.5792C846; Fri, 16 Jun 2023 18:20:53 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230616092052epsmtip1d15b5cc6acbbdd82906312bf2bf4a6d1~pGTVi4F7l2879828798epsmtip1k;
        Fri, 16 Jun 2023 09:20:52 +0000 (GMT)
From:   "min.li" <min15.li@samsung.com>
To:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org, wsa@kernel.org,
        vkoul@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "min.li" <min15.li@samsung.com>
Subject: [PATCH v3] block: add capacity validation in bdev_add_partition()
Date:   Fri, 16 Jun 2023 17:19:13 +0000
Message-Id: <20230616171913.13045-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmum6jXk+KwcdXphar7/azWTzYb2/R
        vHg9m8WN4++YLea+vsRisXL1USaLvbe0LS7vmsNmsXxVB5PF2QkfWC123jnBbPH7B1Ds7v65
        jBY31l1lceDz2LxCy+Py2VKPTas62Tz2z13D7rH7ZgObR9+WVYwenzfJBbBHZdtkpCampBYp
        pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAN2rpFCWmFMKFApILC5W
        0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOaOycwFhwibvi
        wOyNzA2Mazi7GDk5JARMJLbcvczYxcjFISSwm1Fi6fLtUM4nRom7faegnG+MEvPnvGTvYuQA
        a3m6rQikW0hgL6PE8oteEDXPgeyPixhBEmwCqhLTn85gBrFFBDoYJbYcBVvHLJAgsfr8G0aQ
        OcICXhInW01BwixA5b97VrKA2LwClhJvrx5ihrhOXmL/wbPMEHFBiZMzn7BAjJGXaN46mxlk
        r4RAL4fEm6f3WCEaXCTOPlnDDmELS7w6vgXKlpL4/G4vG8T9xRIvf4RBhGskdn+7zQRhW0ts
        W7+OCaSEWUBTYv0ufYiwrMTUU+uYINbySfT+fgJVziuxYx6MrSTx98I5RghbQmLx/oesEJs8
        JDr2aENCKlbi0ZdPzBMY5WcheWYWkmdmISxewMi8ilEytaA4Nz212LTAKC+1HB6pyfm5mxjB
        SVbLawfjwwcf9A4xMnEwHmKU4GBWEuFddqIrRYg3JbGyKrUoP76oNCe1+BCjKTCEJzJLiSbn
        A9N8Xkm8oYmlgYmZmZmJpbGZoZI4r7rtyWQhgfTEktTs1NSC1CKYPiYOTqkGpprPX1Y1aLwv
        nsWhnyzwaGeJ+YQYudidvtdcPRyLL3+tiqjh/6FqdG2hkqX0ETa1I3M7Ak7MbVubkbNlu6HL
        Cb6+DTIL1cL1fh33bpX4xzBthm/8pWMvPgoFKVrGqoUaTL0lWLezwPdvZ82DmL4cEb6tQtw8
        GffOVF/Z8LvmNG/VK/niTR9V+n1vlCYvdDlvKXFqUuKGd27/jM5azpdil7fL7rZ4tmuZ5p0j
        dp4fD3S/2/C9ZMaEC3UX63Q5Hl7/+7B63n5D9sywx07134L3Swv7fX52hbMgQ//zlkyT6Sln
        TWfu842fInNBalJAjcQ7wxrTdaqzhXc6b7V/6FZ2weCQkmLGpfks03aGPV8er8RSnJFoqMVc
        VJwIACmf7ns7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSnG6pZk+Kwd8eC4vVd/vZLB7st7do
        XryezeLG8XfMFnNfX2KxWLn6KJPF3lvaFpd3zWGzWL6qg8ni7IQPrBY775xgtvj9Ayh2d/9c
        Rosb666yOPB5bF6h5XH5bKnHplWdbB77565h99h9s4HNo2/LKkaPz5vkAtijuGxSUnMyy1KL
        9O0SuDIaOycwFlzirjgweyNzA+Mazi5GDg4JAROJp9uKuhi5OIQEdjNKrPjzkrmLkRMoLiFx
        ft4vNghbWGLlv+fsILaQwFNGiS2LxEBsNgFVielPZzCDNIsITGKUuH/hNSvIUGaBJIn+mdYg
        prCAl8TJVlOQchag8t89K1lAbF4BS4m3Vw9BrZKX2H/wLDNEXFDi5MwnYDXMQPHmrbOZJzDy
        zUKSmoUktYCRaRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnDIa2nuYNy+6oPeIUYm
        DsZDjBIczEoivMtOdKUI8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUI
        JsvEwSnVwHQm8tXP0L4bphNmJ7UF3pySovPcbWfVZy+XH4yp87xDbv+8mtm1sOXVwxUv8qd9
        Co26mNx3X3vy+/Ifon7s5UJzr69f923f3enu+ZO3BqdlGDzl7BcILu778/DEKVFNq78LueYu
        PDNLkTOr6xi7/qJWb/8NW9+XV8w/finGwuBD7EF513T5Z3cOe/jasHvFbUnumzxxb8Gj6pX7
        3kRembftW+fx043CHTc23vz32G75Ok0rj3MHC6etTohlWnVwq7vTg/574q+C/2t7pgetNLoS
        Wvsl4WKop9DkgJVLldcsX3Nu9TaRZ9NTLyz58/JWm8KL2VlXi3YLS2vNlhc74N8WMZszjk3G
        awG7zIJL6skHlViKMxINtZiLihMB9JJBaOgCAAA=
X-CMS-MailID: 20230616092054epcas5p340e977377808d2df7210dc4a7d6c1d8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230616092054epcas5p340e977377808d2df7210dc4a7d6c1d8e
References: <CGME20230616092054epcas5p340e977377808d2df7210dc4a7d6c1d8e@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: min.li <min15.li@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
Changes from v1:

- Check for overflows of the start + length value.
- Place the capacity check at the beginning of the function.

Changes from v2:

- Place the assignment on the first line and merge the two lines into one.
- Modify the singed name.
---
 block/partitions/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 49e0496ff23c..b511f88bf558 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -436,10 +436,21 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
 int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length)
 {
+	sector_t capacity = get_capacity(disk), end;
 	struct block_device *part;
 	int ret;
 
 	mutex_lock(&disk->open_mutex);
+	if (check_add_overflow(start, length, &end)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (start >= capacity || end > capacity) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (!disk_live(disk)) {
 		ret = -ENXIO;
 		goto out;
-- 
2.34.1

