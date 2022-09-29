Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC75EEC7B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiI2Det (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiI2Den (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:34:43 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAF9CE35
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:34:38 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220929033433epoutp04904a53f1b89ed4f02ff0106c5286b9b5~ZN2vCiolH1456614566epoutp04j
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:34:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220929033433epoutp04904a53f1b89ed4f02ff0106c5286b9b5~ZN2vCiolH1456614566epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664422473;
        bh=XWhu9fPf/z4i+HXa/bFF3pUCQt6+ZI4Iir5N84tzID4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJoRyWwPzQmUfGrm8hU5WgO9wBDUOu+7o6k1rszc1c7s+//5Et4yA0obHPen1bOh0
         t3me5zSNwcHSXBBpFsrb/5Q5ykTH/YnoPnylZqEOqOhiSdkhg9OGh3Ct0Z0AJ8Z9zG
         l8ydGrr0BCuycZkAmVq/hPAxmSFN2CZv1Sm4T4Aw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220929033432epcas1p2eb9705e5c3cf2d69fe225285a17087ff~ZN2uJ_wCo2613426134epcas1p2I;
        Thu, 29 Sep 2022 03:34:32 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.242]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MdJrR6WXVz4x9Q1; Thu, 29 Sep
        2022 03:34:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.3E.64988.74215336; Thu, 29 Sep 2022 12:34:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220929033431epcas1p416e37f037fda478e524a365f0f754524~ZN2tFd_aS0586905869epcas1p4Q;
        Thu, 29 Sep 2022 03:34:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220929033431epsmtrp1a53f7c0dba688b92692dd57d13ecc25e~ZN2tEeGho3046130461epsmtrp1d;
        Thu, 29 Sep 2022 03:34:31 +0000 (GMT)
X-AuditID: b6c32a39-8d3fa7000001fddc-7f-63351247ee48
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.93.18644.64215336; Thu, 29 Sep 2022 12:34:31 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.98.109]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220929033430epsmtip17cd295128a7447e58ea5fe09409dc1dc~ZN2s144Qq1251112511epsmtip1M;
        Thu, 29 Sep 2022 03:34:30 +0000 (GMT)
From:   Manjong Lee <mj0123.lee@samsung.com>
To:     mj0123.lee@samsung.com, bvanassche@acm.org, ming.lei@redhat.com,
        hch@lst.de
Cc:     axboe@kernel.dk, jisoo2146.oh@samsung.com, junho89.kim@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nanich.lee@samsung.com, sbeom16.kim@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        yt0928.kim@samsung.com
Subject: RE:[PATCH 1/1] blk-mq: added case for cpu offline during send_ipi
 in rq_complete
Date:   Thu, 29 Sep 2022 12:34:28 +0900
Message-Id: <20220929033428.25948-1-mj0123.lee@samsung.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220826013136.16763-1-mj0123.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRmVeSWpSXmKPExsWy7bCmga67kGmywcLbRhar7/azWUz78JPZ
        YuXqo0wWPU+aWC2+Piy22HtL2+LyrjlsFocmNzNZTN88h9ni2v0z7BZz/t9jtTh38hOrxbzH
        Dhbr9/5kc+DzuHzF2+Py2VKP3Tcb2Dze77vK5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCXKimUJeaUAoUCEouLlfTtbIry
        S0tSFTLyi0tslVILUnIKzAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM9Zt6WQs6BCsWHr5FFsD
        Yy9fFyMnh4SAicSR5d9Zuxi5OIQEdjBKPF8yA8r5xChxr30OG0iVkMBnRomrvx1gOuYdPsAK
        Ed/FKHHrnihEA1DN7PYfTCAJNgEtieXPLrCD2CICgRJ7N3xhBLGZBdqYJBbNSQWxhQWiJWb9
        +gm2gEVAVaLt5SJmEJtXwFriVt9zFohl8hKnlh0Em8kpYCPx/+Q1VogaQYmTM5+wQMyUl2je
        OpsZ5AgJgZkcEgtvfgByOIAcF4kjrWkQc4QlXh3fwg5hS0m87G+DsoslttyazAJRXiHR2xUL
        ETaW+PT5MyNImFlAU2L9Ln2IsKLEzt9zoT7hk3j3tYcVopNXoqNNCKJERWJ38ze4RW9eHWCE
        sD0kzp89zwIJtX5GiYkPxSYwKsxC8sssJL/MQli8gJF5FaNYakFxbnpqsWGBKTx2k/NzNzGC
        U62W5Q7G6W8/6B1iZOJgPMQowcGsJML7+6hhshBvSmJlVWpRfnxRaU5q8SFGU2BIT2SWEk3O
        Byb7vJJ4QxNLAxMzIxMLY0tjMyVx3oYZWslCAumJJanZqakFqUUwfUwcnFINTK1Ce5b1B8ur
        RoutPMnimWcYrr423aN1Q16E1O+K+jNC1yryFla9OWTq+ac41tPy4JaE0DDzLw/KQhg5j5z8
        0rlz+tFJziJbXl5/oJWyJ77m8s47K9c93B6pIh1TntHEu+Hzvk3KN1raF4ge3GbUcnrn7TYT
        TZtVrLfnpHXOn7dgQtvyiLm5Eq9Oi8rZLH263Vv6Ed9d23bt3kkMEiu/Z16YyjRHxSX+CNe5
        I7pXXQQyHnJL9zs/al9fvbjylbhOnELbvSvbF3up1J6ct8euwm86w7vuiZlr7//j6pt5UWnL
        hVM/mz/Exz0wtw9cNvPBbNO4BPG551Vdf2w81RWQH90246nbJrmegozUpyuP7VViKc5INNRi
        LipOBACMWVj0PgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnK67kGmywfzjjBar7/azWUz78JPZ
        YuXqo0wWPU+aWC2+Piy22HtL2+LyrjlsFocmNzNZTN88h9ni2v0z7BZz/t9jtTh38hOrxbzH
        Dhbr9/5kc+DzuHzF2+Py2VKP3Tcb2Dze77vK5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZ
        67Z0MhZ0CFYsvXyKrYGxl6+LkZNDQsBEYt7hA6wgtpDADkaJ9jZ2iLiUxLy1DWxdjBxAtrDE
        4cPFXYxcQCUfGSXa3m4Gq2cT0JJY/uwCWL2IQKjErTPXGUGKmAUmMUk0LHoKViQsEClxd9o/
        RhCbRUBVou3lImYQm1fAWuJW33MWiGXyEqeWHWQCsTkFbCT+n7wGdZC1xM2b86HqBSVOznwC
        Vs8MVN+8dTbzBEaBWUhSs5CkFjAyrWKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI4N
        La0djHtWfdA7xMjEwXiIUYKDWUmE9/dRw2Qh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYL
        CaQnlqRmp6YWpBbBZJk4OKUamHoqGbe+U2Sflx+Znfi1fqOqr4l0h0jdBs/u6le9a1eISE2Z
        l/bCa9cfQ+n/X7Y1PN3xcrpp+yOvwtL2Hv7rPWy7Z0RyqZ9xKDm8OlFdWXwBg73J50zmiFcf
        i/Zrd9RHRzRlsq5bdags3jFw58K79m5fzOYWtt19euBBQGSc0G+5G9qXreIvTNTN2f3nis6+
        Bfs+LXi3pWVCCFfjqfKF7wLcb+z6qPTdUZBjGmvE2T/tlw7W8/tbXIqNUpM8Ps/Ea7Mv05GZ
        QYxr1Du51M5MO3hd8unUyRV8MRdD6+61lv7a7PXkw8QzxaFlGm6WiuK5n/3vF91f3Xr+1Nnq
        oGffmxgms+ws1Tv1b4Na9MHwc0osxRmJhlrMRcWJAOgmddv8AgAA
X-CMS-MailID: 20220929033431epcas1p416e37f037fda478e524a365f0f754524
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220929033431epcas1p416e37f037fda478e524a365f0f754524
References: <20220826013136.16763-1-mj0123.lee@samsung.com>
        <CGME20220929033431epcas1p416e37f037fda478e524a365f0f754524@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I think there seems to be a problem that the request
complete processing will be omitted due to the follow routine.
Please give me a advice or opinion if I get a mistake or missing something.
Thank you.
>
>When a request complete then send ipi to original cpu which issued request.
>If cpu offline during this process, send_ipi might fail.
>However, there is currently no code to handle this error case.
>This may cause in missing request complete.
>Therefore, if send_ipi fails due to cpu offline, the request complete
>has to be processed directly from the cpu where it is running.
>
>
>
>Signed-off-by: Manjong Lee <mj0123.lee@samsung.com>
>Signed-off-by: Changheun Lee <nanich.lee@samsung.com>
>Signed-off-by: Junho Kim <junho89.kim@samsung.com>
>---
> block/blk-mq.c | 16 ++++++++++------
> 1 file changed, 10 insertions(+), 6 deletions(-)
>
>diff --git a/block/blk-mq.c b/block/blk-mq.c
>index 3c1e6b6d991d..f2ce79708c5e 100644
>--- a/block/blk-mq.c
>+++ b/block/blk-mq.c
>@@ -1064,17 +1064,22 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
> 	return cpu_online(rq->mq_ctx->cpu);
> }
> 
>-static void blk_mq_complete_send_ipi(struct request *rq)
>+static int blk_mq_complete_send_ipi(struct request *rq)
> {
> 	struct llist_head *list;
> 	unsigned int cpu;
>+	int ret = 0;
> 
> 	cpu = rq->mq_ctx->cpu;
> 	list = &per_cpu(blk_cpu_done, cpu);
> 	if (llist_add(&rq->ipi_list, list)) {
> 		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
>-		smp_call_function_single_async(cpu, &rq->csd);
>+		ret = smp_call_function_single_async(cpu, &rq->csd);
>+		if (ret)
>+			llist_del_all(list);
> 	}
>+
>+	return ret;
> }
> 
> static void blk_mq_raise_softirq(struct request *rq)
>@@ -1099,10 +1104,9 @@ bool blk_mq_complete_request_remote(struct request *rq)
> 	if (rq->cmd_flags & REQ_POLLED)
> 		return false;
> 
>-	if (blk_mq_complete_need_ipi(rq)) {
>-		blk_mq_complete_send_ipi(rq);
>-		return true;
>-	}
>+	if (blk_mq_complete_need_ipi(rq))
>+		if (!blk_mq_complete_send_ipi(rq))
>+			return true;
> 
> 	if (rq->q->nr_hw_queues == 1) {
> 		blk_mq_raise_softirq(rq);
>-- 
>2.32.0
>
