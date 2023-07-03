Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530EC746022
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjGCPwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGCPwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:52:44 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C195DE52
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:52:41 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230703155237euoutp02d97b90b9dfb23730bb809d707a3371ca~uZnPKtS-R1479714797euoutp02H
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 15:52:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230703155237euoutp02d97b90b9dfb23730bb809d707a3371ca~uZnPKtS-R1479714797euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688399557;
        bh=jpSZ740BbRpOlPH0bgMbpPV5ohMlMtS4ynvmt2Pinu0=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=dcb124aNnqSE/x5yfnJTmlZg/bOcs5Oum03YtYVOVpGC6uChadW3lKNgrlt+4nwAs
         eYRKLcpidYfL7QTZ4TtBT7DT1x2tebYcjLRtb2lyEdsvs5yavTBg4o6SnnjQlt228H
         JqW+0ZCyUZKIevLPSIyAslwUT1+5DyZj1Z3Sovhk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230703155237eucas1p13ba5e3125e5394e85d1dc577b16ddbb0~uZnO89aid2818528185eucas1p1J;
        Mon,  3 Jul 2023 15:52:37 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-6e-64a2eec59593
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 98.50.37758.5CEE2A46; Mon,  3
        Jul 2023 16:52:37 +0100 (BST)
Mime-Version: 1.0
Subject: [PATCH] trace: fix null pointer dereference in
 tracing_err_log_open()
Reply-To: m.stachyra@samsung.com
Sender: Mateusz Stachyra <m.stachyra@samsung.com>
From:   Mateusz Stachyra <m.stachyra@samsung.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024@eucms1p4>
Date:   Mon, 03 Jul 2023 17:52:37 +0200
X-CMS-MailID: 20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024
X-EPHeader: Mail
X-ConfirmMail: N,general
CMS-TYPE: 201P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djPc7pH3y1KMZjWr2BxedccNosj68+y
        WCxermaxr+MBkwOLR8u+W+wem1Z1snl83iQXwBzFZZOSmpNZllqkb5fAlTHj7V62gh2CFS9W
        XmFuYDzP18XIySEhYCKx78t+li5GLg4hgRWMEhvf3WbtYuTg4BUQlPi7QxikRlggQGLF3yVg
        YSEBBYktz9UhwoYSE3asYgax2QT0JRYv3McIMkZEoI9RYnffTkaQBLNAnMTO2cuZIXbxSsxo
        f8oCYUtLbF++lRHCFpW4ufotO4z9/th8qLiIROu9s1C9ghIPfu6GiktK3L7ZB2VXS/zfsxDK
        bmGUeLPGAsI2l/g5dyczxCu+EudvS4GEWQRUJZYcu8MKUeIiceV7GzPEmfIS29/OAStnFtCU
        WL9LH6LEUeLfvgNQ5QISa07MgbpGQmJryxNWiFY+iUnbpsN9uGPeEyYIW0XiyIHLUF9JSZx8
        1cQGYXtI7Hz/mW0Co+IsRDjPQnLELIQjFjAyr2IUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/d
        xAhMFaf/Hf+6g3HFq496hxiZOBgPMUpwMCuJ8DY/nJ8ixJuSWFmVWpQfX1Sak1p8iFGag0VJ
        nFfb9mSykEB6YklqdmpqQWoRTJaJg1OqganxM1NS1PPQa9pz5ls06nhlhbZmJC5atqZIOdDc
        k/uzw4t7YXNaU7pnsRzz/Si1P8WlVPGmi/7WA9z1LR0LpI2F7rjWpEqcyJqf9Fh/8e3NZQwz
        Cmy0Kr9oC3yVl2q/xlCv7/V4n5W6mQLrkqCAsENnQ1PaLp5e9XHuB/4dq3y2x3T2eDsefrOh
        qu7XnES1iVOnSTnrn3jyr+br389v5G5/2Pad+a9PyVN+wdn7p11P/iDzIWLj7MU3vjm0uzf8
        7d68w1Lwrt2ESy/L/nVdetV8fG7JynuJQXO1Ltn80H8Xw7LB+95qjorSj0+evplpVXZfjL11
        4tUZzqadNcueNZZszZ7pnb/Gm8VEQCFpurUSS3FGoqEWc1FxIgDJefPYhAMAAA==
X-CMS-RootMailID: 20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024
References: <CGME20230703155237eucms1p4dfb6a19caa14c79eb6c823d127b39024@eucms1p4>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d6ef949d29b884dd77fe5e628dc71318de08868c Mon Sep 17 00:00:00 2001
From: Mateusz Stachyra <m.stachyra@samsung.com>
Date: Mon, 3 Jul 2023 17:48:40 +0200
Subject: [PATCH] trace: fix null pointer dereference in tracing_err_log_open()

Fix an issue in function 'tracing_err_log_open'.
The function doesn't call 'seq_open' if file is opened only with
write permissions, which results in 'file->private_data' being left at null.
If we then use 'lseek' on that opened file, 'seq_lseek' dereferences
'file->private_data' in 'mutex_lock(&m->lock)', resulting in a Kernel panic.
Writing to this node requires root privilages, therefore this bug
has very little security impact.

Tracefs node: /sys/kernel/tracing/error_log

Example Kernel panic:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000038
Call trace:
 mutex_lock+0x30/0x110
 seq_lseek+0x34/0xb8
 __arm64_sys_lseek+0x6c/0xb8
 invoke_syscall+0x58/0x13c
 el0_svc_common+0xc4/0x10c
 do_el0_svc+0x24/0x98
 el0_svc+0x24/0x88
 el0t_64_sync_handler+0x84/0xe4
 el0t_64_sync+0x1b4/0x1b8
Code: d503201f aa0803e0 aa1f03e1 aa0103e9 (c8e97d02)
---[ end trace 561d1b49c12cf8a5 ]---
Kernel panic - not syncing: Oops: Fatal exception

Signed-off-by: Mateusz Stachyra <m.stachyra@samsung.com>
---
 kernel/trace/trace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5d2c5678b..bfa8e2d01 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8097,8 +8097,16 @@ static int tracing_err_log_open(struct inode *inode, struct file *file)
 		return ret;
 
 	/* If this file was opened for write, then erase contents */
-	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC))
+	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
 		clear_tracing_err_log(tr);
+		ret = seq_open(file, &tracing_err_log_seq_ops);
+		if (!ret) {
+			struct seq_file *m = file->private_data;
+			m->private = tr;
+		} else {
+			trace_array_put(tr);
+		}
+	}
 
 	if (file->f_mode & FMODE_READ) {
 		ret = seq_open(file, &tracing_err_log_seq_ops);

base-commit: 1ef6663a587ba3e57dc5065a477db1c64481eedd
-- 
2.25.1

