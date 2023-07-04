Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2117C746E9C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjGDK11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjGDK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:27:20 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC43810C3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:27:09 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230704102707euoutp020bd72045eb332c51a3f80d27180c1b4f~uo0T_95kU2384323843euoutp02o
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:27:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230704102707euoutp020bd72045eb332c51a3f80d27180c1b4f~uo0T_95kU2384323843euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1688466427;
        bh=Qzck0QtKEzSxIMcfhMtxfZL5SP5A3iUVW2odejAlnnc=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=ky4G6M1e9TKdkU67tmS9/ksaivkGy0sm8KfD9QUjOlVH9l1xtFgFTJZLOgnHehweT
         zNjw+sdtA1m4emmZ+0I1qa+sa73PAu2MrtFZZYkFwQsN/Q84LaIjor6xrnIvLk68ob
         FaNm3G56csj1oCzSF1UoSsCoXhbe3Bj+k5ImwPvE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230704102706eucas1p10be00a356a414f1f5b3fd5c3b755af29~uo0TzR2rT3271632716eucas1p1T;
        Tue,  4 Jul 2023 10:27:06 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-33-64a3f3fa9252
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DB.DF.11320.AF3F3A46; Tue,  4
        Jul 2023 11:27:06 +0100 (BST)
Mime-Version: 1.0
Subject: [PATCH v2] trace: fix null pointer dereference in
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
Message-ID: <20230704102706eucms1p30d7ecdcc287f46ad67679fc8491b2e0f@eucms1p3>
Date:   Tue, 04 Jul 2023 12:27:06 +0200
X-CMS-MailID: 20230704102706eucms1p30d7ecdcc287f46ad67679fc8491b2e0f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230704102706eucms1p30d7ecdcc287f46ad67679fc8491b2e0f
X-EPHeader: Mail
X-ConfirmMail: N,general
CMS-TYPE: 201P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djPc7q/Pi9OMdi12cDi8q45bBZH1p9l
        sVi8XM1iX8cDJgcWj5Z9t9g9Nq3qZPP4vEkugDmKyyYlNSezLLVI3y6BK+Pqk+ksBa28FfMv
        tDA1MD7g6mLk5JAQMJHY19bF1sXIxSEksIJR4uvb74xdjBwcvAKCEn93CIPUCAsES+zY954d
        JCwkoCCx5bk6RNhQYsKOVcwgNpuAvsTihfsYQcaICPQxSuzu28kIkmAWiJPYOXs5M8QuXokZ
        7U9ZIGxpie3LtzJC2KISN1e/ZYex3x+bDxUXkWi9dxaqV1Diwc/dUHFJids3+6Dsaon/exZC
        2S2MEm/WWEDY5hI/5+4E6+UV8JWYdekhWA2LgKrE76NLoXa5SGzccY4J4k55ie1v5zCD/Mgs
        oCmxfpc+RImjxKn7h6DGC0isOTEH6hwJia0tT1ghWvkkJm2bDvfijnlPmCBsFYkjBy5DrZKS
        OPmqiQ3C9pB4vPUO6wRGxVmIgJ6F5IhZCEcsYGRexSieWlqcm55abJSXWq5XnJhbXJqXrpec
        n7uJEZgsTv87/mUH4/JXH/UOMTJxMB5ilOBgVhLhbX44P0WINyWxsiq1KD++qDQntfgQozQH
        i5I4r7btyWQhgfTEktTs1NSC1CKYLBMHp1QDk8BTN6fynjh+iXXmU6YefxG+9A5f1q/Xnj2q
        92ukK40ixRNFftX39Zy1ub92md6lzJklqVzz34QXbT8Tvf0K3wuv/mksmf+PT/xU8r8pX2dR
        4ZvlD3/7SfBddjQ3YrD+9nfRBY/C0l2R/H91Hxr5Mc4O3fY9sy74fZnB1Yp1CziZ7vDcXnBh
        J+O1y/eu3XF9avLiXeiz20yiZYKsT+cKnLyq4fF2lrSMe9WdcvMHmfUfHV4+0Dl3tM55ytxA
        0aJgwT2J05fFVqYvPCT7zPBci/tEH4YmtoIjy79+LH30bo7QYT/F6z0+21lm7Dvq0nuqZd8Z
        gYpLy8x97ylkiuyqenLx6qqAD9Xr1BRnnanL+qHEUpyRaKjFXFScCABGSm/whQMAAA==
X-CMS-RootMailID: 20230704102706eucms1p30d7ecdcc287f46ad67679fc8491b2e0f
References: <CGME20230704102706eucms1p30d7ecdcc287f46ad67679fc8491b2e0f@eucms1p3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b04f52e7c..4529e264c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8146,7 +8146,7 @@ static const struct file_operations tracing_err_log_fops = {
 	.open           = tracing_err_log_open,
 	.write		= tracing_err_log_write,
 	.read           = seq_read,
-	.llseek         = seq_lseek,
+	.llseek         = tracing_lseek,
 	.release        = tracing_err_log_release,
 };
 
-- 
2.25.1
