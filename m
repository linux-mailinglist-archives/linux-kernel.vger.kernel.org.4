Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2701F69F332
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjBVLJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBVLJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:09:10 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F8D39287
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:08:40 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230222110834epoutp0124c14877ee388095aa049fe7031c4ee6~GIO1R73Iu2444324443epoutp01K
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:08:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230222110834epoutp0124c14877ee388095aa049fe7031c4ee6~GIO1R73Iu2444324443epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677064114;
        bh=EJ1ONzg4Ake5LMmRVtzSRvFY+LqShBVIqPKICBhvGWc=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=FksyZb7ZmejD0S4+tmVDXkxnwqBOoNmXbyHWUurf9Z5KTev8Y+cDtzdJ5Xf5Ah+bB
         FJdnN9HzYr7QcrB5kdRS0HqiEWDfrojHgd9ZjDk0Q2htbDvCrXQcBRTcHw7Vf+vRu2
         5MfYLRn68gflunRwVAPKdB5sjOiz5MJJp2qWdJKs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230222110834epcas2p4da3f3b9c75e732e684460d8638cdecdd~GIO00Lf2V0449404494epcas2p49;
        Wed, 22 Feb 2023 11:08:34 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PMD0x4xdQz4x9Q5; Wed, 22 Feb
        2023 11:08:33 +0000 (GMT)
X-AuditID: b6c32a47-777ff7000000222e-04-63f5f7b1f932
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.86.08750.1B7F5F36; Wed, 22 Feb 2023 20:08:33 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [f2fs-dev] [RFC PATCH] f2fs: preserve direct write semantics
 when buffering is forced
Reply-To: yonggil.song@samsung.com
Sender: Yonggil Song <yonggil.song@samsung.com>
From:   Yonggil Song <yonggil.song@samsung.com>
To:     "hans.holmberg@wdc.com" <hans.holmberg@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230220122004.26555-1-hans.holmberg@wdc.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230222110833epcms2p8906f628cfa52910867e4c5ed649f791d@epcms2p8>
Date:   Wed, 22 Feb 2023 20:08:33 +0900
X-CMS-MailID: 20230222110833epcms2p8906f628cfa52910867e4c5ed649f791d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmhe7G71+TDZZeULU4PfUsk0Vr+zcm
        iwlvjrJbPFk/i9ni0iJ3i8u75rA5sHlsWtXJ5rF7wWcmj8+b5DzaD3QzBbBEZdtkpCampBYp
        pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
        6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn3Pm8kr3giUzF
        3bbfbA2M38S6GDk5JARMJFbP62LtYuTiEBLYwSjx+dpvli5GDg5eAUGJvzuEQWqEBVIklp98
        wg5iCwkoSVw70MsCEdeX2Lx4GVicTUBX4u+G5WC2iECRxIsZl9hAZjILnGaUuP7iCRvEMl6J
        Ge1PWSBsaYnty7cygticAtYSXddeQtVoSPxY1ssMYYtK3Fz9lh3Gfn9sPiOELSLReu8sVI2g
        xIOfu6HikhKLDp1ngrDzJf6uuA41s0Zia0MbVFxf4lrHRrAbeAV8JU727mYFsVkEVCW6J96G
        muMisWvDW7D5zALyEtvfzmEGhQmzgKbE+l36IKaEgLLEkVssEBV8Eh2H/7LDfLhj3hOoTWoS
        mzdtZoWwZSQuPG6Dmu4h0XP2HdMERsVZiICehWTXLIRdCxiZVzGKpRYU56anFhsVGMPjNjk/
        dxMjOBVque9gnPH2g94hRiYOxkOMEhzMSiK8/3k/JwvxpiRWVqUW5ccXleakFh9iNAX6ciKz
        lGhyPjAZ55XEG5pYGpiYmRmaG5kamCuJ80rbnkwWEkhPLEnNTk0tSC2C6WPi4JRqYOq88Vb0
        prRaWd/aF+ujrW29p9vWXIpe8qn08Aupk/vWzPGtMxBdduki2+xIxiurjBRPnGsQDjK5qeN9
        pLG895yHuOVXSXEdY4P0JzLn0/Uib26YIMnD6eSc1xL9d9PxNpPIBxWzwxZ364Tf+3019+Fl
        qz9Xj4tVFLy+1Lz1rlrJ69387jJzZ/3ZXplU4sK5X0nEOPpaY/i63WUz1/JtkjW1NXk2LUet
        Zml3OevUGwdWn8y78efDAUc9zaW2YnPzbAq5nrlOuXhyztmGmZHRNg1r9lwzkZBM+tZW5J62
        +Lrv7ZdWLayeklz2VxYy/HovfUynz1NoZvOUUMecVRn33G8H3raf+/yfevP2QzosJ5VYijMS
        DbWYi4oTAXzOghIOBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220123747epcas2p4c72ace14d10031df7aa116999ad5fe25
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
        <CGME20230220123747epcas2p4c72ace14d10031df7aa116999ad5fe25@epcms2p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>In some cases, e.g. for zoned block devices, direct writes are
>forced into buffered writes that will populate the page cache
>and be written out just like buffered io.
>
>Direct reads, on the other hand, is supported for the zoned
>block device case. This has the effect that applications
>built for direct io will fill up the page cache with data
>that will never be read, and that is a waste of resources.
>
>If we agree that this is a problem, how do we fix it?

I agree

thanks

>
>A) Supporting proper direct writes for zoned block devices would
>be the best, but it is currently not supported (probably for
>a good but non-obvious reason). Would it be feasible to
>implement proper direct IO?
>
>B) Avoid the cost of keeping unwanted data by syncing and throwing
>out the cached pages for buffered O_DIRECT writes before completion.
>
>This patch implements B) by reusing the code for how partial
>block writes are flushed out on the "normal" direct write path.
>
>Note that this changes the performance characteristics of f2fs
>quite a bit.
>
>Direct IO performance for zoned block devices is lower for
>small writes after this patch, but this should be expected
>with direct IO and in line with how f2fs behaves on top of
>conventional block devices.
>
>Another open question is if the flushing should be done for
>all cases where buffered writes are forced.
>
>Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
Reviewed-by: Yonggil Song <yonggil.song@samsung.com>
>---
> fs/f2fs/file.c | 38 ++++++++++++++++++++++++++++++--------
> 1 file changed, 30 insertions(+), 8 deletions(-)
>
>diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>index ecbc8c135b49..4e57c37bce35 100644
>--- a/fs/f2fs/file.c
>+++ b/fs/f2fs/file.c
>@@ -4513,6 +4513,19 @@ static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
> 	.end_io = f2fs_dio_write_end_io,
> };
> 
>+static void f2fs_flush_buffered_write(struct address_space *mapping,
>+				      loff_t start_pos, loff_t end_pos)
>+{
>+	int ret;
>+
>+	ret = filemap_write_and_wait_range(mapping, start_pos, end_pos);
>+	if (ret < 0)
>+		return;
>+	invalidate_mapping_pages(mapping,
>+				 start_pos >> PAGE_SHIFT,
>+				 end_pos >> PAGE_SHIFT);
>+}
>+
> static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
> 				   bool *may_need_sync)
> {
>@@ -4612,14 +4625,9 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
> 
> 			ret += ret2;
> 
>-			ret2 = filemap_write_and_wait_range(file->f_mapping,
>-							    bufio_start_pos,
>-							    bufio_end_pos);
>-			if (ret2 < 0)
>-				goto out;
>-			invalidate_mapping_pages(file->f_mapping,
>-						 bufio_start_pos >> PAGE_SHIFT,
>-						 bufio_end_pos >> PAGE_SHIFT);
>+			f2fs_flush_buffered_write(file->f_mapping,
>+						  bufio_start_pos,
>+						  bufio_end_pos);
> 		}
> 	} else {
> 		/* iomap_dio_rw() already handled the generic_write_sync(). */
>@@ -4717,8 +4725,22 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> 	inode_unlock(inode);
> out:
> 	trace_f2fs_file_write_iter(inode, orig_pos, orig_count, ret);
>+
> 	if (ret > 0 && may_need_sync)
> 		ret = generic_write_sync(iocb, ret);
>+
>+	/* If buffered IO was forced, flush and drop the data from
>+	 * the page cache to preserve O_DIRECT semantics
>+	 */
>+	if (ret > 0 && !dio && (iocb->ki_flags & IOCB_DIRECT)) {
>+		struct file *file = iocb->ki_filp;
>+		loff_t end_pos = orig_pos + ret - 1;
>+
>+		f2fs_flush_buffered_write(file->f_mapping,
>+					  orig_pos,
>+					  end_pos);
>+	}
>+
> 	return ret;
> }
> 
>-- 
>2.25.1
