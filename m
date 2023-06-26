Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3945C73DB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjFZJVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjFZJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:20:56 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7040010C1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:19:07 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230626091903epoutp02708f2f5e33e6d988e12276a3d54e388d~sKummxRvQ0705207052epoutp02r
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:19:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230626091903epoutp02708f2f5e33e6d988e12276a3d54e388d~sKummxRvQ0705207052epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687771143;
        bh=gq5nfwHqHVfoRrgySJa7rfffjXc4wl5G348+fsTE7ww=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dBlK4GhYAw/2JrmilOCzU+0GCRYVLQ4N74UDdT9rxM/R8jlaZHwaAMj9IJ83D+Mmp
         /f9fk/ehC/F/f7C+bG3FJCvdcstMVsHQJEmrQDfE1UBf1w2bmPPCh8ScI2Yahuql3V
         LVrK74HDN4pBXngITgEaMhrfXXJV0X+Y9zB6Kvws=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230626091902epcas5p3ca62c27bd08175dfa32226e202b10b1a~sKuluxEpZ0386803868epcas5p3M;
        Mon, 26 Jun 2023 09:19:02 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QqMjJ4TnDz4x9Q7; Mon, 26 Jun
        2023 09:19:00 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.D8.44250.40859946; Mon, 26 Jun 2023 18:19:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230626091207epcas5p2a2957dfe97c4d82e39defa557d7ffd0e~sKojSL2p72645526455epcas5p2z;
        Mon, 26 Jun 2023 09:12:07 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230626091207epsmtrp1d6a2e428c956d80e379ec357b2aacb82~sKojQqVHQ1964119641epsmtrp1A;
        Mon, 26 Jun 2023 09:12:07 +0000 (GMT)
X-AuditID: b6c32a4a-ec1fd7000000acda-16-649958041bbb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.1D.64355.76659946; Mon, 26 Jun 2023 18:12:07 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230626091206epsmtip178709a4d491b84066820b57c472a7f6f~sKoiFI-Us0137101371epsmtip1B;
        Mon, 26 Jun 2023 09:12:06 +0000 (GMT)
From:   Min Li <min15.li@samsung.com>
To:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min Li <min15.li@samsung.com>
Subject: [PATCH] block: add check that partition length needs to be aligned
 with block size
Date:   Mon, 26 Jun 2023 17:10:21 +0000
Message-Id: <20230626171021.5895-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmpi5LxMwUg0kvlCxW3+1ns3iw396i
        efF6Nosbx98xW8x9fYnFYuXqo0wWe29pW1zeNYfNYvmqDiaLsxM+sFr8/gHk3lh3lcWBx2Pz
        Ci2Py2dLPTat6mTz2D93DbvH7psNbB59W1YxenzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvk
        HRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0pZJCWWJOKVAoILG4WEnfzqYov7QkVSEj
        v7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PXFLOCzxwVZ3evZG1gnMPexcjB
        ISFgIrFoJ5DJxSEksJtR4trZXhYI5xOjxNm9d1i7GDkhnO+Ly2AaFp/KhKjZySjxY81uZgjn
        OaPEr0NHwaayCShLbFvqA9IrIpAmsbTjJxuIzSwQJ3Gpq5MdxBYWiJVYM+ML2HwWAVWJyb/W
        g9XwClhIbF7yjAXElhCQl9h/8CwzRFxQ4uTMJywQc+QlmrfOBtsrIfCVXeLt5MmMEA0uEmde
        /oSyhSVeHd/CDmFLSbzsb4P6uFji5Y8wiHCNxO5vt5kgbGuJbevXMYGUMAtoSqzfpQ8RlpWY
        emodE8RaPone30+gynkldsyDsZUk/l44B7VVQmLx/oesELaHxI7Oz2wgI4WA3r0zy3wCo/ws
        JM/MQvLMLITFCxiZVzFKphYU56anFpsWGOWllsOjNDk/dxMjOJlqee1gfPjgg94hRiYOxkOM
        EhzMSiK8Yj+mpwjxpiRWVqUW5ccXleakFh9iNAWG8ERmKdHkfGA6zyuJNzSxNDAxMzMzsTQ2
        M1QS5112pTdFSCA9sSQ1OzW1ILUIpo+Jg1OqgSn1oNniBwfPKjO57RQ5GnGybt+ZePZJJrP8
        Tp0V5Zkc8PhA8boC9bip7Ip1zLPPHpr14QPzjftlXU9n/5sZMj/q2JSzM2J0ilzm7EvklHth
        vPym2ua6a/frLj9I3DL37ud649TavSacTy+HcVyyPG993vX+Z69d30+tcpvZ8Spuj0U2l2NW
        xx2/9v8h3ae++DxNvNKZfnt7+pxTz2cqS0c/vvxktkOc9Jrw+BfbWqdll23gO51h+f2qQptL
        qIBc4tx7zZZGQm+/Ce84lflrvmbQIgGR6Pqmlfb7HrDE27GKHf14ZaZi4R3mf+LrLnR5rq+c
        Vui3MnFFrqPxxjkBlyLnn/VYIntnHWcU3/+gxa1CSizFGYmGWsxFxYkAuzP7/S8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsWy7bCSnG562MwUg9szxS1W3+1ns3iw396i
        efF6Nosbx98xW8x9fYnFYuXqo0wWe29pW1zeNYfNYvmqDiaLsxM+sFr8/gHk3lh3lcWBx2Pz
        Ci2Py2dLPTat6mTz2D93DbvH7psNbB59W1YxenzeJBfAHsVlk5Kak1mWWqRvl8CV8WuKWcFn
        joqzu1eyNjDOYe9i5OCQEDCRWHwqs4uRi0NIYDujxPNZV1m6GDmB4hIS5+f9YoOwhSVW/nvO
        DlH0lFFi8+n3LCDNbALKEtuW+oCYIgI5Eiu++4OUMwskSHT8OMQOYgsLREs82HgGzGYRUJWY
        /Gs92EheAQuJzUueQa2Sl9h/8CwzRFxQ4uTMJywQc+QlmrfOZp7AyDcLSWoWktQCRqZVjKKp
        BcW56bnJBYZ6xYm5xaV56XrJ+bmbGMFBrRW0g3HZ+r96hxiZOBgPMUpwMCuJ8Ir9mJ4ixJuS
        WFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwDRVulBz74w5hkI3
        Py9s/zJv7cmUTSsrL4YuFmUunf1yJffUtjiL77uPxht+99zN6WTIf/hRVltv348elrAnPNxq
        fgKbKxqfRE7l6LsxIUJSTqT0X8Pryl3SMWvy7il+9ntuJqgb9ntXuPzTdRfzrJ9oXKr5qngz
        Lm3u23Jj1bw5rTes2xsNVL9fzwtec6XE7vCVp2HPG/+YnL2kteHz1436qzOSi9I8WCrk+FmL
        jmZvs1tlf1Lg4dEd5sw/zDMWyIoVrOpR9BCK/V9m/KWy8cuLZ/uDF4quXNrNMdNv3pLU3Zxd
        KRIX9r5lUA/u23xv0uz8abuzojgnTy9t+uR1UG673qMVYrcbalfMcJ9vU6DEUpyRaKjFXFSc
        CADZ7Fh52QIAAA==
X-CMS-MailID: 20230626091207epcas5p2a2957dfe97c4d82e39defa557d7ffd0e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230626091207epcas5p2a2957dfe97c4d82e39defa557d7ffd0e
References: <CGME20230626091207epcas5p2a2957dfe97c4d82e39defa557d7ffd0e@epcas5p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before calling add partition or resize partition, there is no check
on whether the length is aligned with the logical block size.
If the logical block size of the disk is larger than 512 bytes,
then the partition size maybe not the multiple of the logical block size,
and when the last sector is read, bio_truncate() will adjust the bio size,
resulting in an IO error if the size of the read command is smaller than
the logical block size.If integrity data is supported, this will also
result in a null pointer dereference when calling bio_integrity_free.

Signed-off-by: Min Li <min15.li@samsung.com>
---
 block/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 9c5f637ff153..aa95b5561169 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -35,6 +35,9 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 
 	start = p.start >> SECTOR_SHIFT;
 	length = p.length >> SECTOR_SHIFT;
+	/*check if length is aligned to blocksize*/
+	if (p.length & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
 
 	switch (op) {
 	case BLKPG_ADD_PARTITION:
-- 
2.34.1

