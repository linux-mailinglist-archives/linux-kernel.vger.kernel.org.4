Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F79969CAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjBTMUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBTMUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:20:39 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C611B166CE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676895626; x=1708431626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r2t9/+0mPyYRoKhemlejneFLZV/XH/8xS8WW3RqGIus=;
  b=q5Cpa5zLi2XgtSYBPuyVcDupPHDr7/5LIpKDtjXecg9LYxPmIWL1+Y8g
   gFyCCYCBJ5ILRpi5CdDxnLiya7Z2PmohWPy/0Ry6rXBzEnuBQW0spLd7G
   sMowb6HcAdTC4JBzqEBUFBtVH6CoMHLPxAQdVg9ag8X6WUY+p8JZ/Kn1L
   H4pwDy11Hmg6VauDDPzLYmixOYegSG91he5D8yXywqFG2nxXBzv1jsemc
   nfuwWHHYlAKGyUnvXSjBb26P2r2IWepn3GSA1p7AhXASzudYm1xdoP1be
   gl233SAj5ULzsv/Hv31razIRH+bzFIzZVRquWdfFr/LHPGqpBp+//xYEd
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669046400"; 
   d="scan'208";a="328032386"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 20:20:25 +0800
IronPort-SDR: milIDzsvmwqMCZ8qKbevEBoyIWqVpuywvftMBfq+HUtKR7sar51CmBtpX7XpJpEYQ22B1UASDe
 7p8SalOg/3cZ9MZZaukYdca0dO9464jAyz1PlsPkpuKbMbsOvJXnTXc7IYY+UCXuAfc0y/RDW1
 cZjU8FV92wUey2Lid3f7gOBlHCD8XTnTvJ1xygIelYdOgXkH7rIm9hcnhqXoTlMdrvNIOBtJMQ
 Fn5Oi6RYwx6VOUjpwhVT6WxraOS/cQeIA2egacikR+7oEI709B4S42pwtzvTDjjDwMDCkPEvCc
 VAQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2023 03:31:42 -0800
IronPort-SDR: J4bt4eoSnMDc5GaXdqcwwNCKpVEtitq4fR5WlvKXEZ2TaGvSMXrxLeiUyAS52bOrIp8K3bqlJE
 N7JcGIWpCQvf2NNzWMvpNRD325rj9cP39CfyF9JEVQ6qmyUXsxYjKYyZJM0QvAxbN9zyPk/pE0
 M0zIv76/w1I2UxlDz67Zan3p2tWclBArpQ2JKvDZBfk1Ta/WFmD+cMXXQisp9IAhO+8lIxjWPH
 MVjolckdK2Z89pj8OJ71Zcy2qqsrv/v8vc7hLnSb17N89jeQ4LOKFGE4P7yqxk2qT+qRtwFhUT
 314=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO gsv.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Feb 2023 04:20:23 -0800
From:   Hans Holmberg <hans.holmberg@wdc.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net, damien.lemoal@wdc.com,
        aravind.ramesh@wdc.com, hans@owltronix.com,
        linux-kernel@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>
Subject: [RFC PATCH] f2fs: preserve direct write semantics when buffering is forced
Date:   Mon, 20 Feb 2023 13:20:04 +0100
Message-Id: <20230220122004.26555-1-hans.holmberg@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, e.g. for zoned block devices, direct writes are
forced into buffered writes that will populate the page cache
and be written out just like buffered io.

Direct reads, on the other hand, is supported for the zoned
block device case. This has the effect that applications
built for direct io will fill up the page cache with data
that will never be read, and that is a waste of resources.

If we agree that this is a problem, how do we fix it?

A) Supporting proper direct writes for zoned block devices would
be the best, but it is currently not supported (probably for
a good but non-obvious reason). Would it be feasible to
implement proper direct IO?

B) Avoid the cost of keeping unwanted data by syncing and throwing
out the cached pages for buffered O_DIRECT writes before completion.

This patch implements B) by reusing the code for how partial
block writes are flushed out on the "normal" direct write path.

Note that this changes the performance characteristics of f2fs
quite a bit.

Direct IO performance for zoned block devices is lower for
small writes after this patch, but this should be expected
with direct IO and in line with how f2fs behaves on top of
conventional block devices.

Another open question is if the flushing should be done for
all cases where buffered writes are forced.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---
 fs/f2fs/file.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ecbc8c135b49..4e57c37bce35 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4513,6 +4513,19 @@ static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
 	.end_io = f2fs_dio_write_end_io,
 };
 
+static void f2fs_flush_buffered_write(struct address_space *mapping,
+				      loff_t start_pos, loff_t end_pos)
+{
+	int ret;
+
+	ret = filemap_write_and_wait_range(mapping, start_pos, end_pos);
+	if (ret < 0)
+		return;
+	invalidate_mapping_pages(mapping,
+				 start_pos >> PAGE_SHIFT,
+				 end_pos >> PAGE_SHIFT);
+}
+
 static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 				   bool *may_need_sync)
 {
@@ -4612,14 +4625,9 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 
 			ret += ret2;
 
-			ret2 = filemap_write_and_wait_range(file->f_mapping,
-							    bufio_start_pos,
-							    bufio_end_pos);
-			if (ret2 < 0)
-				goto out;
-			invalidate_mapping_pages(file->f_mapping,
-						 bufio_start_pos >> PAGE_SHIFT,
-						 bufio_end_pos >> PAGE_SHIFT);
+			f2fs_flush_buffered_write(file->f_mapping,
+						  bufio_start_pos,
+						  bufio_end_pos);
 		}
 	} else {
 		/* iomap_dio_rw() already handled the generic_write_sync(). */
@@ -4717,8 +4725,22 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	inode_unlock(inode);
 out:
 	trace_f2fs_file_write_iter(inode, orig_pos, orig_count, ret);
+
 	if (ret > 0 && may_need_sync)
 		ret = generic_write_sync(iocb, ret);
+
+	/* If buffered IO was forced, flush and drop the data from
+	 * the page cache to preserve O_DIRECT semantics
+	 */
+	if (ret > 0 && !dio && (iocb->ki_flags & IOCB_DIRECT)) {
+		struct file *file = iocb->ki_filp;
+		loff_t end_pos = orig_pos + ret - 1;
+
+		f2fs_flush_buffered_write(file->f_mapping,
+					  orig_pos,
+					  end_pos);
+	}
+
 	return ret;
 }
 
-- 
2.25.1

