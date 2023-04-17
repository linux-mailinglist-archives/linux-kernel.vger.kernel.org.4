Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A67F6E4714
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjDQMCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDQMC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:02:27 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3007EF9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:01:35 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230417113512epoutp0143fdabf92ad082ce32839a5e251b3733~Wtbf2aywi0382403824epoutp014
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:35:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230417113512epoutp0143fdabf92ad082ce32839a5e251b3733~Wtbf2aywi0382403824epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681731312;
        bh=jYdmvWtLqh0lhE8wCsmkeA+z/9I118jtqv54oVwoz5U=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BkyU7N/Jcwdor52xItnvAEixRPEvhKwd36E4mDQ7VlADjz/fqYDO7pko+9NfXpoyE
         vkb4ecJexkYAUifzcdY+tW3IEkXxzxsjvTb8mWLhgVuwOEGN15l+jlESV5aV/5RuSJ
         Kiux0h7R+De7stuhEYC08vtPlr1EfOWr9OQHFj34=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20230417113512epcas1p45c97fb4f70e5589e503a73cd4a3a8462~WtbflApE81870218702epcas1p43;
        Mon, 17 Apr 2023 11:35:12 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.232]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Q0Q2l2XTvz4x9Pw; Mon, 17 Apr
        2023 11:35:11 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.1B.10218.FEE2D346; Mon, 17 Apr 2023 20:35:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230417113511epcas1p2990af8cc1d74ccb336410b7908b39c35~WtbeZKAYe0165401654epcas1p2Z;
        Mon, 17 Apr 2023 11:35:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230417113511epsmtrp24122417d720fdde38fa07a2eb197565f~WtbeYlh2b0160701607epsmtrp2j;
        Mon, 17 Apr 2023 11:35:11 +0000 (GMT)
X-AuditID: b6c32a38-7d3ff700000027ea-11-643d2eef49ef
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.E7.08609.EEE2D346; Mon, 17 Apr 2023 20:35:10 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.111.174]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230417113510epsmtip2d7b2df7632898c9e5e05707e15077e8b~WtbePMvQ63221932219epsmtip2S;
        Mon, 17 Apr 2023 11:35:10 +0000 (GMT)
From:   Sung-hun Kim <sfoon.kim@samsung.com>
To:     brauner@kernel.org, linux-kernel@vger.kernel.org
Cc:     sungguk.na@samsung.com, sw0312.kim@samsung.com,
        Sung-hun Kim <sfoon.kim@samsung.com>
Subject: [PATCH] pid: handle a NULL dereference error case in
 find_task_by_pid_ns
Date:   Mon, 17 Apr 2023 20:35:00 +0900
Message-Id: <20230417113500.19610-1-sfoon.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7bCmnu57PdsUg0M/hCxeH/7EaHF51xw2
        i8Zpy9ktdsw7yGgxY/JLNgdWj02rOtk8+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUzL91W
        yTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKWSQlliTilQKCCxuFhJ386mKL+0JFUh
        I7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj8/lzTAXtPBX3fzSwNzC2c3Ux
        cnJICJhIfJ52n7WLkYtDSGAHo8Tc5Y+gnE+MEls6OtkgnM+MEn92nGOCaemd0MgIkdjFKLF1
        QxtUyxdGiTVPjzGDVLEJaEls23+JEcQWAer40tvCAmIzC0RJXNjXAlYjLBAssfX7X7A4i4Cq
        xKatN8DqeQWsJGaffcUKsU1eYvWGA8wgCyQE+tklXh7/AdTAAeS4SHzbkQpRIyzx6vgWdghb
        SuLzu71sECXVElOfc0O0tjBK/Hu5H2qmscT+pZOZQGqYBTQl1u/ShwgrSuz8PZcR4kw+iXdf
        e1ghxvBKdLQJQZQoSzw+2MwCYUtKfN13HRomHhJL994Gmy4kECsx7exqxgmMsrMQFixgZFzF
        KJZaUJybnlpsWGACj6Tk/NxNjOBUpGWxg3Hu2w96hxiZOBgPMUpwMCuJ8J5xtUoR4k1JrKxK
        LcqPLyrNSS0+xGgKDK6JzFKiyfnAZJhXEm9oYmlgYmZkbGJhaGaoJM775al2ipBAemJJanZq
        akFqEUwfEwenVAOTG9er3QJR7z7FmsYe39Hq65ZaMf/Ka9a8adteL+j2/Vcb6xDzpW+hMHd+
        SoUGd8BdhUnCYXvu92v7RCQfuKYlsTE0ll8xRsfgw1+5ZcfWHg/9fmX35PXhMSItvGWPpLKj
        kk5/6Nnwdc2JljD11En3jFTL+uzOrnLqCf06lSVe7eOfPU3/1t01WmNXs+2ez+XGhuBPUrm9
        FuwHu9uqe6UZrS8za8rb3qtg072i9uJnBz+D7quHx35FTpyTNb30SoBTYGNd4fbHocb+bBEz
        T1funXJcK8eULT8674DciaLz7f7+rH1blhyy2efKxJ9gkHp+97SPQTLH01MXbZZS+2e58MHW
        fyovN3n2N/HutFdiKc5INNRiLipOBACYeLsnzgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJMWRmVeSWpSXmKPExsWy7bCSvO47PdsUg9bnVhavD39itLi8aw6b
        ReO05ewWO+YdZLSYMfklmwOrx6ZVnWwefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlbH5/Dmm
        gnaeivs/GtgbGNu5uhg5OSQETCR6JzQydjFycQgJ7GCUuL9rBStEQlJizroFQAkOIFtY4vDh
        YoiaT4wSc//fZQepYRPQkti2/xIjiC0iYCax5MQNJhCbWSBGon39bDBbWCBQ4tesfrB6FgFV
        iU1bb4DV8wpYScw++wpql7zE6g0HmCcw8ixgZFjFKJlaUJybnltsWGCUl1quV5yYW1yal66X
        nJ+7iREcHFpaOxj3rPqgd4iRiYPxEKMEB7OSCO8ZV6sUId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpimqB99t/hXhEN2WH7Z+u7yffv+XbNtmvi59ovX
        S85F7g0p15OShH3Sa1cdfPSChfFeV9rk2maPiPO8vwt+z5l5XJrha4gY68eqtpBy5zIOj1cZ
        XNsePA8/kSy1Ovndhh3uN9qOPJpSL3RrmukNtboXKS3cl9a+i7K+lTbNmvv04dRM+ROmi0tt
        ExJdi7Ocviy/ZlLUVDf5tWGc+rw1OwKttsWK/20KeliwjUds2oc7V1pWib/ouHVq989/jesY
        RFvLz6yzia678v+igNi1aY4flUIlTGYc8su+qZ0hrB10KFd+8U+u3R/Ov9orZXndU6lhz+bY
        93etAnq+PpvJO9H8j0HTsZX+/9Jf293v6lNUYinOSDTUYi4qTgQAoDMghH0CAAA=
X-CMS-MailID: 20230417113511epcas1p2990af8cc1d74ccb336410b7908b39c35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230417113511epcas1p2990af8cc1d74ccb336410b7908b39c35
References: <CGME20230417113511epcas1p2990af8cc1d74ccb336410b7908b39c35@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A NULL dereference error is occurred when find_task_by_pid_ns is
called with a 'ns' argument which value is NULL. This situation
is incurred when the kernel tries to call find_task_by_pid_ns in
the process context which is in exiting. This is because, when
the process is exiting, it detaches its struct pid from the
task_struct. The function find_task_by_vpid, one of callers of
find_task_by_pid_ns, takes the result of task_active_pid_ns(current)
as an argument. But, task_active_pid_ns returns NULL if the
current process is in exiting. So, the kernel incurs a NULL
dereference error since find_task_by_pid_ns uses the argument
without NULL check.

This patch adds a NULL check routine in find_task_by_pid_ns. The
function returns NULL when NULL is given as an argument.

Signed-off-by: Sung-hun Kim <sfoon.kim@samsung.com>
---
 kernel/pid.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 3fbc5e46b721..914aebe9fee8 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -412,9 +412,12 @@ EXPORT_SYMBOL(pid_task);
  */
 struct task_struct *find_task_by_pid_ns(pid_t nr, struct pid_namespace *ns)
 {
+	struct task_struct *task = NULL;
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
 			 "find_task_by_pid_ns() needs rcu_read_lock() protection");
-	return pid_task(find_pid_ns(nr, ns), PIDTYPE_PID);
+	if (likely(ns))
+		task = pid_task(find_pid_ns(nr, ns), PIDTYPE_PID);
+	return task;
 }
 
 struct task_struct *find_task_by_vpid(pid_t vnr)
-- 
2.17.1

