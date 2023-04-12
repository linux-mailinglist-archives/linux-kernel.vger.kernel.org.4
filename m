Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459AF6DEAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDLFVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDLFVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:21:42 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6784488
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:21:39 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230412052134epoutp04fa11ce5a343d2962567504ea2fb9d70e~VGG2ZbWOe0827008270epoutp04U
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:21:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230412052134epoutp04fa11ce5a343d2962567504ea2fb9d70e~VGG2ZbWOe0827008270epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681276894;
        bh=aNhC7QgnkngZrBQwpepZoZRAyKAMmfM+xJos3NSZASU=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=hokU7jzj6KJtzU/WUKGvk3ETsM/a0gBTe6sasBdWUMv4VZrgq8OOgpGM/oGfhmRHz
         +IHOPQzdGVrAW9TY0SqtX9DFpFQCbRe0Anjm1ByhLWB59btdzwF5vOsLVJ3mydki1f
         AFfwT3w+vJziAnCgQpxFDVP9aBvQ/Dw/y9Kjjv+I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230412052134epcas2p183245c04730dfddc3f909a75412557b3~VGG16l4Bd0181001810epcas2p1C;
        Wed, 12 Apr 2023 05:21:34 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Px9zy0RnHz4x9Q1; Wed, 12 Apr
        2023 05:21:34 +0000 (GMT)
X-AuditID: b6c32a48-023fa700000025b2-89-64363fddc6c5
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.2F.09650.DDF36346; Wed, 12 Apr 2023 14:21:33 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 1/2] blk-integrity: add rq_integrity_payload_size helper
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4>
Date:   Wed, 12 Apr 2023 14:21:33 +0900
X-CMS-MailID: 20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmme5de7MUg2eTrC3+7znGZjHr9msW
        i5eHNC1Wrj7KZNHbv5XNYtKha4wWl3fNYbOYv+wpu8W61+9ZHDg9Jja/Y/c4f28ji8emVZ1s
        HpuX1HvsvtnA5tG3ZRWjx+dNch7tB7qZAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0M
        DHUNLS3MlRTyEnNTbZVcfAJ03TJzgK5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak
        5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn/D52lrHgHnvFu41nWRsYj7B1MXJySAiYSLze
        2s/excjFISSwg1FiQecfxi5GDg5eAUGJvzuEQWqEBTwkehccYQSxhQSUJM6tmQVWIixgIHGr
        1xwkzCagJ/FzyQw2kDEiAheZJNq6XjBDzOeVmNH+lAXClpbYvnwrI4StIfFjWS9UjajEzdVv
        2WHs98fmQ9WISLTeOwtVIyjx4OduqLikxKFDX9lAbpAQyJfYcCAQIlwj8Xb5AagSfYlrHRvB
        1vIK+Er8enyLCcRmEVCVeHjzHNRIF4mebe1g9cwC8hLb385hBhnJLKApsX6XPsR0ZYkjt1gg
        KvgkOg7/ZYd5qmHjb6zsHfOeMEG0qkksajKCCMtIfD08H6rEQ+L8hAlsExgVZyFCeRaSE2Yh
        nLCAkXkVo1hqQXFuemqxUYEJPGKT83M3MYITqZbHDsbZbz/oHWJk4mA8xCjBwawkwvvDxTRF
        iDclsbIqtSg/vqg0J7X4EKMp0PMTmaVEk/OBqTyvJN7QxNLAxMzM0NzI1MBcSZz3Y4dyipBA
        emJJanZqakFqEUwfEwenVAPTfuNla5bsmZnmWXI57EBdMpvzxAWuxhZCT0vftLVdTbA8yf/h
        g3mN+JyIL8cvZU1LC/oYukXeXFfm8fSFyvq7hXKMH+wN2McR9MzDM1Yw7fDNz25qb6JzHVpe
        J16NvbPuyxVXYUHnHWv6JUPbu8w0HL06j57123XSSUchdEGUyOlZUosPnNS/tywj0ONFdbXz
        6kQLw38dAs/W/9ibZJz+x62Sd1uN/uQ5FgdZO3c/4G5YLDwt8JzSRDvrLldm8d8lggH2C3gV
        9nG2NhlumJbzmHeTZjCHfFOkdMwq7x1TI75ODZnz8ipD4RKNg0d0lxryn3D8Vrrl0n+PHy5i
        zF9u2/6adPim8PRjYes6ahYqsRRnJBpqMRcVJwIAp3nV4i0EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce
References: <CGME20230412052133epcms2p4d52e78b4fc1bc6ac1cc9d399a0378fce@epcms2p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a nice shortcut to get the size of the integrity data
for the driver like NVMe that only support a single integrity segment.

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 include/linux/blk-integrity.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 378b2459efe2..abf1923f4aa5 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -114,6 +114,13 @@ static inline struct bio_vec *rq_integrity_vec(struct request *rq)
 		return NULL;
 	return rq->bio->bi_integrity->bip_vec;
 }
+
+static inline unsigned int rq_integrity_payload_size(struct request *rq)
+{
+	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
+		return 0;
+	return rq->bio->bi_integrity->bip_iter.bi_size;
+}
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline int blk_rq_count_integrity_sg(struct request_queue *q,
 					    struct bio *b)
-- 
2.34.1
