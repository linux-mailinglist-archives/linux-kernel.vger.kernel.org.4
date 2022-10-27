Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3612D60F38A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiJ0JUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbiJ0JUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:20:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D91FFAA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:20:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R5J10Z029019;
        Thu, 27 Oct 2022 09:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=FEV68A32v+oOBg8wVp3Otkn00cWdPegP8fO0J269VmU=;
 b=kl0CZfLheEoNmxtL91PiVORGn+aYtSEPUb51CMMETYSoxZmI20ZbJeA7xXVGV6tpsT/F
 6c5cEqMPQ0o9YDVMFfWavFQnIlBQU+YphWKcPoB/s3JNzNMJ7ed1QCX19wmjX9E05oqZ
 YrMC0VW5GgGJ2Cl3Q7dHyj2I3l17J7QHGUqIfiiM5SqQrKM5JJE9mjAXwqmyRd8UDu1I
 iR6sJJgued61POzIbL0Ii073PV2/LvZMMZAsF20ba7+8bOjZ68dDPtc8xt8H5emsjMlh
 +07rwk6tfbF0khazcWz002PbJ5Xyu5ct95kcwY5LS84zt9LyYDj5DLyILdY3YlCBvlJP DQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfahca1y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 09:19:56 +0000
Received: from nasanex01c.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29R9JtoD027680
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 09:19:55 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 27 Oct 2022 02:19:52 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>, <mhiramat@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v2 1/2] f2fs: fix the assign logic of iocb
Date:   Thu, 27 Oct 2022 14:42:40 +0530
Message-ID: <1666861961-12924-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R5lVbCzdee-6cVQiQTaQ7LAAcnteaSjr
X-Proofpoint-GUID: R5lVbCzdee-6cVQiQTaQ7LAAcnteaSjr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_03,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
introduces iocb field in 'f2fs_direct_IO_enter' trace event
And it only assigns the pointer and later it accesses its field
in trace print log.

Unable to handle kernel paging request at virtual address ffffffc04cef3d30
Mem abort info:
ESR = 0x96000007
EC = 0x25: DABT (current EL), IL = 32 bits

 pc : trace_raw_output_f2fs_direct_IO_enter+0x54/0xa4
 lr : trace_raw_output_f2fs_direct_IO_enter+0x2c/0xa4
 sp : ffffffc0443cbbd0
 x29: ffffffc0443cbbf0 x28: ffffff8935b120d0 x27: ffffff8935b12108
 x26: ffffff8935b120f0 x25: ffffff8935b12100 x24: ffffff8935b110c0
 x23: ffffff8935b10000 x22: ffffff88859a936c x21: ffffff88859a936c
 x20: ffffff8935b110c0 x19: ffffff8935b10000 x18: ffffffc03b195060
 x17: ffffff8935b11e76 x16: 00000000000000cc x15: ffffffef855c4f2c
 x14: 0000000000000001 x13: 000000000000004e x12: ffff0000ffffff00
 x11: ffffffef86c350d0 x10: 00000000000010c0 x9 : 000000000fe0002c
 x8 : ffffffc04cef3d28 x7 : 7f7f7f7f7f7f7f7f x6 : 0000000002000000
 x5 : ffffff8935b11e9a x4 : 0000000000006250 x3 : ffff0a00ffffff04
 x2 : 0000000000000002 x1 : ffffffef86a0a31f x0 : ffffff8935b10000
 Call trace:
  trace_raw_output_f2fs_direct_IO_enter+0x54/0xa4
  print_trace_fmt+0x9c/0x138
  print_trace_line+0x154/0x254
  tracing_read_pipe+0x21c/0x380
  vfs_read+0x108/0x3ac
  ksys_read+0x7c/0xec
  __arm64_sys_read+0x20/0x30
  invoke_syscall+0x60/0x150
  el0_svc_common.llvm.1237943816091755067+0xb8/0xf8
  do_el0_svc+0x28/0xa0

Fix it by copying the required variables for printing and while at
it fix the similar issue at some other places in the same file.

Fixes: 18ae8d12991b ("f2fs: show more DIO information in tracepoint")
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v2:
 - Added commit text with crash information.
 - Fixed the similar issue at some other places in the file.
 - Only copy the required variables instead of memcpy.

 include/trace/events/f2fs.h | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index c6b3724..ff57e7f 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -322,7 +322,7 @@ TRACE_EVENT(f2fs_unlink_enter,
 		__field(ino_t,	ino)
 		__field(loff_t,	size)
 		__field(blkcnt_t, blocks)
-		__field(const char *,	name)
+		__string(name,  dentry->d_name.name)
 	),
 
 	TP_fast_assign(
@@ -330,7 +330,7 @@ TRACE_EVENT(f2fs_unlink_enter,
 		__entry->ino	= dir->i_ino;
 		__entry->size	= dir->i_size;
 		__entry->blocks	= dir->i_blocks;
-		__entry->name	= dentry->d_name.name;
+		__assign_str(name, dentry->d_name.name);
 	),
 
 	TP_printk("dev = (%d,%d), dir ino = %lu, i_size = %lld, "
@@ -338,7 +338,7 @@ TRACE_EVENT(f2fs_unlink_enter,
 		show_dev_ino(__entry),
 		__entry->size,
 		(unsigned long long)__entry->blocks,
-		__entry->name)
+		__get_str(name))
 );
 
 DEFINE_EVENT(f2fs__inode_exit, f2fs_unlink_exit,
@@ -940,25 +940,29 @@ TRACE_EVENT(f2fs_direct_IO_enter,
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(struct kiocb *,	iocb)
+		__field(loff_t,	ki_pos)
+		__field(int,	ki_flags)
+		__field(u16,	ki_ioprio)
 		__field(unsigned long,	len)
 		__field(int,	rw)
 	),
 
 	TP_fast_assign(
-		__entry->dev	= inode->i_sb->s_dev;
-		__entry->ino	= inode->i_ino;
-		__entry->iocb	= iocb;
-		__entry->len	= len;
-		__entry->rw	= rw;
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->ki_pos		= iocb->ki_pos;
+		__entry->ki_flags	= iocb->ki_flags;
+		__entry->ki_ioprio	= iocb->ki_ioprio;
+		__entry->len		= len;
+		__entry->rw		= rw;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu pos = %lld len = %lu ki_flags = %x ki_ioprio = %x rw = %d",
 		show_dev_ino(__entry),
-		__entry->iocb->ki_pos,
+		__entry->ki_pos,
 		__entry->len,
-		__entry->iocb->ki_flags,
-		__entry->iocb->ki_ioprio,
+		__entry->ki_flags,
+		__entry->ki_ioprio,
 		__entry->rw)
 );
 
@@ -1407,19 +1411,19 @@ TRACE_EVENT(f2fs_write_checkpoint,
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(int,	reason)
-		__field(char *,	msg)
+		__string(dest_msg, msg)
 	),
 
 	TP_fast_assign(
 		__entry->dev		= sb->s_dev;
 		__entry->reason		= reason;
-		__entry->msg		= msg;
+		__assign_str(dest_msg, msg);
 	),
 
 	TP_printk("dev = (%d,%d), checkpoint for %s, state = %s",
 		show_dev(__entry->dev),
 		show_cpreason(__entry->reason),
-		__entry->msg)
+		__get_str(dest_msg))
 );
 
 DECLARE_EVENT_CLASS(f2fs_discard,
-- 
2.7.4

