Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49646BC497
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCPDXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCPDXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:23:02 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6CBA64B5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:20:58 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230316031940epoutp02ce393f504354795b3d2b1eda50b513d3~MyBs8ddUf0263402634epoutp02P
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:19:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230316031940epoutp02ce393f504354795b3d2b1eda50b513d3~MyBs8ddUf0263402634epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678936780;
        bh=LkGb9gudNokFJQy+N1Um3lBkQSilGBO0QXo/O4ejpOE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=oAK9wInLQaY4XeCBa0ZxvjGG07lSdd8ltStj4GswHm5sFaZxU2Vd6MrfTRurxUZxf
         TjGq1SCIPzsbsKuPWxoldXThEKuqgvDFE5NaZNEmWMHXqxqHxjkL0NIL1Xnv3iLJH+
         E4jpDiT3uq1tl4+t9G2bFYYSW6tM7SOsUOhCuupk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230316031940epcas1p4caa8b32f085acd38d3d98e6baa0de599~MyBsl-9vU2301623016epcas1p47;
        Thu, 16 Mar 2023 03:19:40 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.241]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PcXYl4G4Qz4x9Q5; Thu, 16 Mar
        2023 03:19:39 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.98.54823.8CA82146; Thu, 16 Mar 2023 12:19:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230316031936epcas1p1ebd93477dcf3bf9ab1640306dd1da8ff~MyBpa58kf2332323323epcas1p1c;
        Thu, 16 Mar 2023 03:19:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230316031936epsmtrp1a883352cb7166f657325f6a3b10bbcaf~MyBpaMa_20887908879epsmtrp1z;
        Thu, 16 Mar 2023 03:19:36 +0000 (GMT)
X-AuditID: b6c32a39-a97ff7000000d627-52-64128ac87ef3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.71.18071.8CA82146; Thu, 16 Mar 2023 12:19:36 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.41]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230316031936epsmtip29bbf332b78a1d49bb5febf990943fc99~MyBpQ25921011610116epsmtip2L;
        Thu, 16 Mar 2023 03:19:36 +0000 (GMT)
From:   Yeongjin Gil <youngjin.gil@samsung.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com
Cc:     totte@google.com, linux-kernel@vger.kernel.org,
        Yeongjin Gil <youngjin.gil@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: [PATCH] dm verity: fix error handling for check_at_most_once
Date:   Thu, 16 Mar 2023 12:18:42 +0900
Message-Id: <20230316031842.17295-1-youngjin.gil@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHJsWRmVeSWpSXmKPExsWy7bCmge6JLqEUg31HjS3WnzrGbLH33WxW
        i8u75rBZbPl3hNXixC1pi43PGC1m7H/K7sDusWBTqcemVZ1sHu/3XWXz6NuyitHj8ya5ANao
        BkabxKLkjMyyVIXUvOT8lMy8dFul0BA3XQslhYz84hJbpWhDQyM9QwNzPSMjIz1To1grI1Ml
        hbzE3FRbpQpdqF4lhaLkAqDa3MpioAE5qXpQcb3i1LwUh6z8UpDD9YoTc4tL89L1kvNzlRTK
        EnNKgUYo6Sd8Y8w4uv4iY8FS7op12z6zNDDu4Oxi5OSQEDCR+LnyA3MXIxeHkMAORonDy06z
        QzifGCWmPHvJCOF8Y5TYuvAsC0zLx+fvWCASexklVu+ZzQiSAGuZuc4TxGYT0JWY+vIpK4gt
        ImAt8aJpJlgDs0ALo8TaR2+YQRLCAq4Sn2edYAexWQRUJW7d7wEaxMHBK2Ar8eWwMogpISAv
        sfiBBEgFr4CgxMmZT8BuYAYKN2+dDXa2hMAldonH05uhjnOR2HJ4LTOELSzx6vgWdghbSuJl
        fxs7REM7o8SKh3MYIZwZjBJ/399nhaiyl2hubWYD2cwsoCmxfpc+RFhRYufvuYwQtqDE6Wvd
        zBBX8Em8+9rDCnEor0RHmxBEiZrElUm/oCbKSPQ9mAV1g4fExE8dTJCwipW4NH870wRGhVlI
        fpuF5LdZCEcsYGRexSiWWlCcm55abFhgihzJmxjBSVXLcgfj9Lcf9A4xMnEwHmKU4GBWEuEN
        ZxFIEeJNSaysSi3Kjy8qzUktPsSYDAzricxSosn5wLSeVxJvaGZmaWFpZGJobGZoSFjYxNLA
        xMzIxMLY0thMSZxX3PZkspBAemJJanZqakFqEcwWJg5OqQamRlunZ/4SV28yRnoyJBhfX7dS
        YJEc4/5CptCGRxyh799tEXsaE2d+wNrqtl/mzxLPR0F21qULlj+dnmtY/83N6cTKnOmG79+t
        vc3spu7J9q5o35wjF9b5aj0oZl5Yy9+uJje9/eTky7dmJ31Ub1IwMbxmqHnc6F14k+6SQyuL
        n+/+9lbjgkMi79Lfx6tvsYqUZMl7rfrkFOjz8VoDM+N87o1fbfznvTkX/PeujyIjz8tvC0/x
        O034+UH79faVr2Jdv//l+CJcp6AVVd30v/orp/Ak7SKrLd/WNMzYp2SSHOqXXM/uzu/zrXPd
        5u+9nbbLpn/r6vleLbuU+dj7QpY9SZtfuK7cZL95eu/MAtcyJZbijERDLeai4kQApGvIz2EE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO6JLqEUg3PtShbrTx1jttj7bjar
        xeVdc9gstvw7wmpx4pa0xcZnjBYz9j9ld2D3WLCp1GPTqk42j/f7rrJ59G1ZxejxeZNcAGsU
        l01Kak5mWWqRvl0CV8bR9RcZC5ZyV6zb9pmlgXEHZxcjJ4eEgInEx+fvWLoYuTiEBHYzSuzq
        WsIOkZCR+DPxPVsXIweQLSxx+HAxRM0HRokNh28ygdSwCehKTH35lBXEFhGwl3h6bSsbSBGz
        QAejRPeSlWwgCWEBV4nPs06ADWURUJW4db+HEWQor4CtxJfDyhDz5SUWP5AAqeAVEJQ4OfMJ
        C4jNDBRu3jqbeQIj3ywkqVlIUgsYmVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgQH
        p5bmDsbtqz7oHWJk4mA8xCjBwawkwhvOIpAixJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4
        IYH0xJLU7NTUgtQimCwTB6dUA1Ne5PplWhLRh9iF/Rb+6bXuje6e+sH236sPVa98yi9fiVlQ
        uzfn/omutCkRvYFtztqXH3xeVnp3jWz4ris8CyIOarr4ia9V+W6+VEfpzoW4onaro+4CClOl
        u9kuFvx4FSYUIhD462WRsL1EZfeBtDkno1y+bP/lzHTVz0T/4oIDD0TTuY/FtM8o7TU+s/v7
        6hfPWBxchCrW+eutYo2YLcqy43zvO+4Ul1uuH99k8SmyTQ9iUa1h4zh1NXvJ5wneH+Qatv1j
        mjC79ftO3edOoe59Lff2z81QuaCQMH/1YrkXN689Znuu+iy+3++Rv+uHmx9X7+s7Vh6jXrnk
        YYzF/JYHrZxFn7ZuC29KU3o556sSS3FGoqEWc1FxIgCC9DHavQIAAA==
X-CMS-MailID: 20230316031936epcas1p1ebd93477dcf3bf9ab1640306dd1da8ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230316031936epcas1p1ebd93477dcf3bf9ab1640306dd1da8ff
References: <CGME20230316031936epcas1p1ebd93477dcf3bf9ab1640306dd1da8ff@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In verity_work(), the return value of verity_verify_io() is converted to
blk_status and passed to verity_finish_io(). BTW, when a bit is set in
v->validated_blocks, verity_verify_io() skips verification regardless of
I/O error for the corresponding bio. In this case, the I/O error could
not be returned properly, and as a result, there is a problem that
abnormal data could be read for the corresponding block.

To fix this problem, when an I/O error occurs, do not skip verification
even if the bit related is set in v->validated_blocks.

Fixes: 843f38d382b1 ("dm verity: add 'check_at_most_once' option to only validate hashes once")

Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
---
 drivers/md/dm-verity-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index ade83ef3b439..9316399b920e 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -523,7 +523,7 @@ static int verity_verify_io(struct dm_verity_io *io)
 		sector_t cur_block = io->block + b;
 		struct ahash_request *req = verity_io_hash_req(v, io);
 
-		if (v->validated_blocks &&
+		if (v->validated_blocks && bio->bi_status == BLK_STS_OK &&
 		    likely(test_bit(cur_block, v->validated_blocks))) {
 			verity_bv_skip_block(v, io, iter);
 			continue;
-- 
2.39.2

