Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40A66869BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjBAPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjBAPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:09:41 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3149F66F8B;
        Wed,  1 Feb 2023 07:08:22 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id m2so51835346ejb.8;
        Wed, 01 Feb 2023 07:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1f2sZTLCh+6MjnBo1NM4qx8aN8UK3+QyFktme+HJb1M=;
        b=dKmAu0GxbikreE6kPJmqHkddGR4hdJEwSy/Hyn9dorAla/AcEyCzBi0e0E5WKnnadE
         ZOoGHTpyuGBvNdYpaYDYcvhdpuYyY32EQuFRAWIhvBFh5vTxfR1pld3Ab6ScfSKARDAM
         sc2UMjZv2Pc+Fz5wbQlfV16JlBQkDyrYomHAkpzegrg7Jcwi5hSg3voaTAqOK7f84SP6
         9T7cGzELd1jUt2G622d2YjrOKECc9MFeZ1qCKxQALvy/15evIShrh1+HKkkrn1/eRv+N
         NzUTzuo0yZ07hHQCVYZf4cxu/9+TaJ7wfNNg5s3LCxsCjX0IvX/o3RSYThcDvihaSgp7
         N25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1f2sZTLCh+6MjnBo1NM4qx8aN8UK3+QyFktme+HJb1M=;
        b=a+6ffcdrTbl+BddaUPsrX9kO2q58MlUEN9D+xb67k8X3PruIeGYrQkhAVR6sKLluQr
         4WIKDYDaZd37VYv+EBRWIpqSFkH8QMHraFMoghiYRbPsUsqr3AGMu68IbzZGE9rk44T7
         pxNJJiFHgG73Sr5IiPQmFfHRo8q4k0z2BP5KKjaGNy8G65qHv0o3ydFjekJeR9VbWmsd
         0Sflf1NcQOmVdzNCTnEU1sci+pkjKFdn0iGCEh27WneqHsoLaOvHOe+d2ye8La6EC2p+
         FH58yRv20QKF1E0v4n4TzB2AWkmT2EWjfQRE27a/QfRvSFILOUtI/hmKcNYmQNApNcY8
         UmhQ==
X-Gm-Message-State: AO0yUKVtgXmCd1vIZhsyGb2HIZgi/RCx/dKRk7EXLoFh8ZYqBLSwkgrG
        iODeC7q64TE6PsTa8PB+zf52WFJAf6CCLA==
X-Google-Smtp-Source: AK7set97wGmJcPMtT1Vrg2FbfLmw1oPPmZCQAOt149jYSK9E/tj08/FAxVMeqSvRhMDYKFxZsXw3og==
X-Received: by 2002:a17:907:2ce7:b0:886:7eae:26c4 with SMTP id hz7-20020a1709072ce700b008867eae26c4mr2498160ejc.5.1675264100689;
        Wed, 01 Feb 2023 07:08:20 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id qc26-20020a170906d8ba00b008787e94c5ccsm9585774ejb.184.2023.02.01.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:08:20 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH 03/13] misc: vmw_vmci: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:08:09 +0100
Message-Id: <20230201150815.409582-4-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201150815.409582-1-urezki@gmail.com>
References: <20230201150815.409582-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvfree_rcu()'s single argument name is deprecated therefore
rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
underline that it is for sleepable contexts.

Cc: Bryan Tan <bryantan@vmware.com>
Cc: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
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
2.30.2

