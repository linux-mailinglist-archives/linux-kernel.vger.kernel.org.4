Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588A1635869
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiKWJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbiKWJ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:56:10 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AE911A30
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:51:13 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f9so12124739pgf.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1WTAgfKs3/0cN6Zc1ausxuW6PJkVWotfdNKd3Rj+z9U=;
        b=eAwvoglIkg7D+Ag/AtcA124l2+KVzg4521phk5lBk8qpiyEMu091NZk49uyrKvaIXb
         FpMOv9O/jiYxYheO9TMpB12ViB9mOap1Q3TE4YDZmps28aG8epm496o6TTwcnFHFO7fP
         /PGrWj9hFyjx+x1jKoVhQOMM5KoXD0CAWJOjxbN1ih8oyJXJuGpx3eVKI+ysBr4O0BkJ
         pN3xiMueC4gzeONSXHeW4Ytpcysv8wXbbBM2ftVke7X0t0vReK6amaLuM+vXPs8xbG7P
         PIwhM6Lvd6nYfI3eGRjZm9aQTxqcjHy5D49xARNzmRMSXflxBrm6X2TBNfclakJNerwm
         9fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WTAgfKs3/0cN6Zc1ausxuW6PJkVWotfdNKd3Rj+z9U=;
        b=lBSv9XBEbBxw5Yhg+RHpsh26+X7NsiAhV/MAwEr3/NOt45I+wPn7TVhobUiCFwCKth
         sZp1pALHwU7Fmn1iysmHjChwYxOnJSwyZkxcR2CFkfcOIhvInhjJBHL7IReXvFDUMULk
         bZFJEqjaq2ZqqUcb1td+zY91fHDgAdhcvSn6dk6sRbpRzOdvgVMV4lUX/hf9faBjnCP7
         EmI6Lwqr7O9kdJG1KI9IwD014BGitoIIvHNmvlaAq2h4/WD4qvs54HN/iqmdJeFTpKEh
         6eyZAr694Apww/6ZGGZgSTWYGJ4WJYGakIUExOnyIyN3lPWHfIbJ14vUjaaWsLn8bcMk
         cTkA==
X-Gm-Message-State: ANoB5pnMr8vWB/qeLKWNFQxzwFIxtiXAPqgp83YoeXmh87jbq3xPWqhw
        zsh5PzRRlY77f61c+gWLaGY=
X-Google-Smtp-Source: AA0mqf7cV+a5M4IeUaG4RfexyCp8c6sLcKj4usaBbjmHLK0srh+qU62Nm3cN1VoUq6Zuuu//awNI3A==
X-Received: by 2002:aa7:91c9:0:b0:53e:7332:709d with SMTP id z9-20020aa791c9000000b0053e7332709dmr11708111pfa.56.1669197073277;
        Wed, 23 Nov 2022 01:51:13 -0800 (PST)
Received: from den-workstation.fareast.nevint.com ([140.206.46.75])
        by smtp.gmail.com with ESMTPSA id i29-20020a63131d000000b00460ea630c1bsm10392079pgl.46.2022.11.23.01.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 01:51:12 -0800 (PST)
From:   Richard Clark <richard.xnu.clark@gmail.com>
To:     tj@kernel.org
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Richard Clark <richard.xnu.clark@gmail.com>
Subject: [PATCH] workqueue: Remove the unbound release work from the per-cpu type
Date:   Wed, 23 Nov 2022 17:50:58 +0800
Message-Id: <20221123095058.669684-1-richard.xnu.clark@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the per-cpu and unbound workqueue will call init_pwq(...) currently,
the latter will init an unbound release work for the pwq which is unnecessary
for the per-cpu type workqueue.
This commit will remove this work item from the per-cpu workqueue by checking the
wq->flags in init_pwq(...), the work is still reserved for the unbound workqueue.

Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e0a1..01bdfb74081e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3807,7 +3807,8 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 	INIT_LIST_HEAD(&pwq->inactive_works);
 	INIT_LIST_HEAD(&pwq->pwqs_node);
 	INIT_LIST_HEAD(&pwq->mayday_node);
-	INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
+	if (wq->flags & WQ_UNBOUND)
+		INIT_WORK(&pwq->unbound_release_work, pwq_unbound_release_workfn);
 }
 
 /* sync @pwq with the current state of its associated wq and link it */
-- 
2.37.2

