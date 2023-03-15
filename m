Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE96BBBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjCOSTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjCOST2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:19:28 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBEF5C11F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:27 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id n2so1064979qtp.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YoraG+JWZgu+kk+Xa2MTR2qA9SqyCgWV2tOJOVp0+M=;
        b=LsXDP75TPp1/BeAMrrtNNlSCXEZTraBIYhcq4T8bXJIWOd+0vXrJVidQFpgB9zXDcF
         3PiRZl7gPpXYXDamtsnNcFeOnYE/9Ys+NVsjJHlohESQVA/85+T1nDqpA07cWaF/kqUy
         ymjgcXuvXl8NineaVhH7XFQWwxYRuortcgTaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YoraG+JWZgu+kk+Xa2MTR2qA9SqyCgWV2tOJOVp0+M=;
        b=OSff1WgZ38L9Xfof+OPccMtYqk1taix2ojxo9f4eRmmeV0OK165ENUOE3BmGxn83ob
         vRPlHiwjcdtXGpHBts/ZqG6JVm0Gz4PQ9UTXp8Pp68TQjbkJUTToyeibBz1uFgpiwEb8
         D73ao3Bx3UgHvGEsURl1BxLIfLm8S1movv7TnKpYf0Ccbmvbc4Nn8xXAFla5rKYYUfsR
         4hKsGuM8x9V75TE6svhjUvZM+DuN+R/XKhBqIIIbQmzL8fk4Ynhfc1LddW9c4HoN5jSi
         s0KBBnv9qsU9sMOOVL1zbG9xxLw3qlOAYP9LXbdx6vjIlYtnSwZj/Vco7tncIaqlAQoO
         O2qw==
X-Gm-Message-State: AO0yUKUwL/mmeQHSlWFuady1QlKluqBWxDh+hBIWmw3TPaikxDpI7YSG
        35Ok0PhMyo6XFxlYP/lsakEQMg==
X-Google-Smtp-Source: AK7set91JpedIzFZef8etz9HVcQPFxkxobOsIIfgsm4jeXwsZmwRhLgdqEYsIoT0npQL4Jauq2gUqA==
X-Received: by 2002:a05:622a:1109:b0:3bf:b08f:1dcd with SMTP id e9-20020a05622a110900b003bfb08f1dcdmr1397234qty.38.1678904366467;
        Wed, 15 Mar 2023 11:19:26 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/14] misc: vmw_vmci: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed, 15 Mar 2023 18:18:49 +0000
Message-Id: <20230315181902.4177819-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The kvfree_rcu() macro's single-argument form is deprecated.  Therefore
switch to the new kvfree_rcu_mightsleep() variant. The goal is to
avoid accidental use of the single-argument forms, which can introduce
functionality bugs in atomic contexts and latency bugs in non-atomic
contexts.

Cc: Bryan Tan <bryantan@vmware.com>
Cc: Vishnu Dasa <vdasa@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/misc/vmw_vmci/vmci_context.c | 2 +-
 drivers/misc/vmw_vmci/vmci_event.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
index 172696abce31..f22b44827e92 100644
--- a/drivers/misc/vmw_vmci/vmci_context.c
+++ b/drivers/misc/vmw_vmci/vmci_context.c
@@ -687,7 +687,7 @@ int vmci_ctx_remove_notification(u32 context_id, u32 remote_cid)
 	spin_unlock(&context->lock);
 
 	if (notifier)
-		kvfree_rcu(notifier);
+		kvfree_rcu_mightsleep(notifier);
 
 	vmci_ctx_put(context);
 
diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
index 2100297c94ad..5d7ac07623c2 100644
--- a/drivers/misc/vmw_vmci/vmci_event.c
+++ b/drivers/misc/vmw_vmci/vmci_event.c
@@ -209,7 +209,7 @@ int vmci_event_unsubscribe(u32 sub_id)
 	if (!s)
 		return VMCI_ERROR_NOT_FOUND;
 
-	kvfree_rcu(s);
+	kvfree_rcu_mightsleep(s);
 
 	return VMCI_SUCCESS;
 }
-- 
2.40.0.rc1.284.g88254d51c5-goog

