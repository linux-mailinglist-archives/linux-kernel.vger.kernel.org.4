Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867AF5F3B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJDCnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJDCmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:44 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B52F64A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:42:29 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id h10so6326696qvq.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qdhlIj+6HcqRKTVWPc10GaEiGeAKWAIvBWIoYXYLCMk=;
        b=bF6d+BQqT21uSDzoEmgc6ltXLVsiSH0flXr0a66hmvq7zz6s2Dq02XIGUNiWasBO6l
         IB2p/eCTJGTdDIETKvUDIb/jDWWkCWTUpUQAOYk3rdCu//nizylNlM/r8n0CT5bZvGRX
         BW5DpSVU8CvCLezoUFGMJGleu6LL+2N8zGzBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qdhlIj+6HcqRKTVWPc10GaEiGeAKWAIvBWIoYXYLCMk=;
        b=oadB5iUV+060+TJQz4y6FfLO7ctzTP8YRjra52j9kT+v5YJ/oFDBCPzTj6Bkp6pIZ4
         zHMFHJUNaPoVELb+XiKX2hwmuLzM4pISanSv9fyOUGDHXKGtu4O4833MumS2Y4L8UuVB
         fnAWU12M0VTb3dhBxVP/fb62SdlUK3hXDzvoZ449iqt+mqYNIUydcQT7wd859g7WKb06
         y9fDgTbJxlKlppA2N+Q3n6/a/Ifd1p+Dk9hN54zCCT5hIXq0XkBw3WntvR2Z0K8g70T8
         5jt+8aHpt6GsbVqC6m+anTeYR+2Z6uUl/FwvvkXEdV/o6xmlsK9lWnT81PKsGezB4pft
         1Jbw==
X-Gm-Message-State: ACrzQf0G4ArgFpX+uLDg12d7NRs67SGt8J9BAGhKxmr8PLyTXYD5jq4/
        yVnTrnf/uqDsHJ64ZDUZN/qQ2w==
X-Google-Smtp-Source: AMsMyM64lAZaufUU71QItbF95H8BI+H5w0uqK+zf53+ZrJbgoNrUAe7L8FKb0CryPiGGH8u8KpnGtg==
X-Received: by 2002:ad4:5d6f:0:b0:4b1:93a4:8f1f with SMTP id fn15-20020ad45d6f000000b004b193a48f1fmr5307099qvb.50.1664851348212;
        Mon, 03 Oct 2022 19:42:28 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:27 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com, Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v7 11/11] workqueue: Make queue_rcu_work() use call_rcu_flush()
Date:   Tue,  4 Oct 2022 02:41:57 +0000
Message-Id: <20221004024157.2470238-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uladzislau Rezki <urezki@gmail.com>

call_rcu() changes to save power will slow down RCU workqueue items
queued via queue_rcu_work(). This may not be an issue, however we cannot
assume that workqueue users are OK with long delays. Use
call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index aeea9731ef80..fe1146d97f1a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		rwork->wq = wq;
-		call_rcu(&rwork->rcu, rcu_work_rcufn);
+		call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
 		return true;
 	}
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

