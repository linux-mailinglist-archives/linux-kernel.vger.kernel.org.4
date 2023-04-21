Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54F66EA1FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjDUCwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjDUCvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:51:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F057292;
        Thu, 20 Apr 2023 19:51:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a92513abebso19694875ad.2;
        Thu, 20 Apr 2023 19:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045477; x=1684637477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dorQ2qlHIQqiNBUoiQdfsVbgm5wQDWFtkN4YHEiGiW0=;
        b=qcJ3g04qdI5nJnF0RwVis4v7EzX0fPL613I0miXb8OBRVtnPZi9rsPKFiOjvtxzM9D
         k4Lc3kzcMkqM07Gz7lPfr65+OH1ShvUvlu3vKZQ0fksXbAXYpykFjcdCl1ksoIWsEFYw
         rlrADdfGdmznF4OYk1+zclIZmpe23JU/7PO2So1p+ZwS90tZHUeLdizz1m7pulXEmZhP
         JGKQXVuxT0LKxJS228sfpj/zMqKIox+ydHEQeloOIjfeqjSuZ8kOkXhW9pxOklPjfL00
         93syjdjXSPpvWDcKqeuDfLzjyTy/SCOqiAy9ukPDb2LF4fKF1DQoMLXT/IpOgRa9GTEE
         ZPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045477; x=1684637477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dorQ2qlHIQqiNBUoiQdfsVbgm5wQDWFtkN4YHEiGiW0=;
        b=Z1AzSHRfN+nxvvhvI5oyr2CNGwfYyBndxOq7C9SVHs5YalzuNgEjTTUGHFFn5aFMQb
         F4iIKSLvBJ6dzDc8D7G7th0Ue+kTOEwxu10WMObZfaRN6SewWIxtnXtc65HqQZiCiBHM
         P9/VvrhzIR2AoK8E/2xdU/b3Jt6IA834RDdvJNJurfkp8p62tU6K7KZ28aH+9EJdq+5x
         mMgzX1pqtWVLsR0HTvh5/J1frGjoJAx49kF7s5bKvemcNehNyobwwMlK4XY5Q8tUzloH
         /FqTAXBW1WfvUs/lCkRM+Wkqy6N0CHvz2IrNvsUuGnOW8dBK9flCdN8I6whkOTdBQ2T/
         ypJw==
X-Gm-Message-State: AAQBX9cIRvImqgRtXtcU+8SMJq1857xxBswCuoWNn2J/T0yZOVHBMz13
        kEY2a+8HpRuuNAFdVEhKaX2+h+rUlTY=
X-Google-Smtp-Source: AKy350brCnllqVIbTvbVAizAFvwU8LbM/ZVhCoz2xu5/RFCnO/Uyv0+3NE55K22qXrDnqJDgSkgCvg==
X-Received: by 2002:a17:902:748c:b0:1a6:be37:22e1 with SMTP id h12-20020a170902748c00b001a6be3722e1mr3102959pll.15.1682045476738;
        Thu, 20 Apr 2023 19:51:16 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902760100b001a1adbe215asm1741130pll.142.2023.04.20.19.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:51:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 14/22] soc: qcom: qmi: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:38 -1000
Message-Id: <20230421025046.4008499-15-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421025046.4008499-1-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

WHAT TO LOOK FOR
================

The conversions are from

  alloc_workqueue(WQ_UNBOUND | flags, 1, args..)

to

  alloc_ordered_workqueue(flags, args...)

which don't cause any functional changes. If you know that fully ordered
execution is not ncessary, please let me know. I'll drop the conversion and
instead add a comment noting the fact to reduce confusion while conversion
is in progress.

If you aren't fully sure, it's completely fine to let the conversion
through. The behavior will stay exactly the same and we can always
reconsider later.

As there are follow-up workqueue core changes, I'd really appreciate if the
patch can be routed through the workqueue tree w/ your acks. Thanks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/soc/qcom/qmi_interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index 820bdd9f8e46..78d7361fdcf2 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -650,7 +650,7 @@ int qmi_handle_init(struct qmi_handle *qmi, size_t recv_buf_size,
 	if (!qmi->recv_buf)
 		return -ENOMEM;
 
-	qmi->wq = alloc_workqueue("qmi_msg_handler", WQ_UNBOUND, 1);
+	qmi->wq = alloc_ordered_workqueue("qmi_msg_handler", 0);
 	if (!qmi->wq) {
 		ret = -ENOMEM;
 		goto err_free_recv_buf;
-- 
2.40.0

