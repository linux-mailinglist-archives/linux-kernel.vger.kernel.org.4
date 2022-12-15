Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F7364D52B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 03:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiLOCCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 21:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiLOCCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 21:02:05 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9F933C26
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 18:02:04 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so1202185pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 18:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4lAe37d4fe+tyUc8VHnbsRTRPV2Q4pwHpZC+HfReys=;
        b=P35Nvhay6le5agNzNBEf8tekkHeu302a1sZXUJjDHaHDcC4xuOBspDQ0c6+u4Yfmmt
         CGlQgMXlPJre6tr1YVR1CoIGOj417kUiP5Q3KzTnd5UOfRfn16ny8tUjjEYR5ifJCXq9
         I7OGH7ect7bPCKpW6zc+LE11luOwJFi01LA7L+NLV2g3amhincPz8mcProN3oUMxMmvi
         zaqrSYO92XpohfzlK2pZ1GzQvikFoe6Z/1sCbNqV4h+ZAz3QpkmfawBn75Ejmrtt6u6N
         0dY2xWJqj+zxjIvTHHj2FkZVaoge+YVxBF0jgrwUpLXkApm0l4SAEBzl8n4u45iKS7OQ
         Bjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4lAe37d4fe+tyUc8VHnbsRTRPV2Q4pwHpZC+HfReys=;
        b=vLPrZgq1Hx+A3mJ0jtY8nvOrntRZ6QlSv8I04Ws3r6LSKNMB8lYOzrbFN9gVHt3mxY
         rjUDJ+oprnn9VxHrP57qPfgRvn6ZBppk0kAzMoPU+9gdfdxwBPg2O6+6dnMsZkP+4K9K
         3wKmcjJ5kebGu/cpAGI9oIuAd8gG77Zs5TT4ISQpyisB+z1wc/OjzqYVCQSFo4oxfPV9
         TmFJQ3cm+hbG1a1KfBG/g8V1xprNQzxQJ/AjzCBM5LcUOz5seECoqGHqM8YF5vgZttaT
         pz96jCbLM1jtoyN+1UAInvraRkRGGYTZ8Xo7FphDlHzBNl0xReB+taTN1k4Z0h0LvsN/
         lMEA==
X-Gm-Message-State: ANoB5pkjy8RMYALDmsX9I81Wxj0wrRtVM2n3OoVph8FFz7Xm0HaLioBI
        5by4//xTpqsw5+NFvFNpn6OwbhI+PxrLqIZPWfEK7A==
X-Google-Smtp-Source: AA0mqf5lj8c+Euh5wut1OwbP8aDqao93ETSKHYwJ3K6sefUbg3ZyS+xBinIIALWXZSKFDvNccQwaPw==
X-Received: by 2002:a17:902:8347:b0:189:4bf4:2cfc with SMTP id z7-20020a170902834700b001894bf42cfcmr26691302pln.31.1671069724116;
        Wed, 14 Dec 2022 18:02:04 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902a3c800b00174c1855cd9sm2464431plb.267.2022.12.14.18.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 18:02:02 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     brauner@kernel.org
Cc:     ebiederm@xmission.com, tglx@linutronix.de, luto@kernel.org,
        bigeasy@linutronix.de, akpm@linux-foundation.org,
        fenghua.yu@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] fork: Avoid inherit PF_IO_WORKER flag
Date:   Thu, 15 Dec 2022 02:01:22 +0000
Message-Id: <20221215020122.762684-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_process examines arguments in kernel_clone_args to see if
PF_IO_WORKER need to be set, so the flag should not inherit from
parent process.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 947eb1a6399a..50498e5d10dd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2088,6 +2088,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p->flags &= ~PF_KTHREAD;
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
+	p->flags &= ~PF_IO_WORKER;
 	if (args->io_thread) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
-- 
2.25.1

