Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB36EA20B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjDUCwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjDUCvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:51:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8437AB7;
        Thu, 20 Apr 2023 19:51:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a6862e47b1so19837785ad.0;
        Thu, 20 Apr 2023 19:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045488; x=1684637488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUw0DkZoq2nQ/bLNbKEG/cpbsutsaVMiCTIAKGrHlvQ=;
        b=fVspGee2WguejmyW9SsJEePERYXvLnqkuEJr6C3DOdX9+QMwzZgHjx45Tnd08CWhEv
         96/NJgI1wU4AZjV16sLDqCDuoewN0EZ4u/eznQMLu8vqcywZYQBrtiwri5P+JxzYSAmm
         Ulbq145l6+P+dzYJ8T9UBS7ZKcLuiUYQIJ+bjmgOqjwZL3KXz0l1NdjfuyZsVrp3/mUc
         uz2pe37gx+xMom5o4Ffo6xjNyVFQkODv98yxJS7VH80xPFWWR8x1U9gPKhzcMJLIhU4Z
         4VRcQKegQexAg/0aqGIXZEaalQPyXpSPRyfwa+wSOVV9x5KHQpZnqrOs+ZmR7CcN/Fxd
         LAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045488; x=1684637488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sUw0DkZoq2nQ/bLNbKEG/cpbsutsaVMiCTIAKGrHlvQ=;
        b=j726AK/0utIZPY3jyFCfeLH+hU9in4EgeS4n+sbBPAGtZhL5g4fAQrl4ND3iLusI3Z
         JlBkLd0EonfY5dnBtFJr5cmzhD1d/sLm33COtzy7tIdw/UeaTzxiZT1GlmquyRUtEcp6
         r39DbU4dFhb1RAoavxgnqkkdY03de1ncZg68QA4PC/u7nYp0Uibg34g3ROOgNU2eNkGQ
         Ga0NIriP69osRC9Hg9J4/R8zYaIcr6cbD73txez2iqj+SNW/wL0djb+7r/S8SKpl85+b
         z5BFjQphe75XsZSEhyUm/6hRhA2AgADLr/h9TdF7DgWyw55WVqaB80IWPpMjWQP5PMhy
         AvjQ==
X-Gm-Message-State: AAQBX9eOyDRQ2TgWOSTFWF3eJsEL5zhj/oK8lSZnsrkfZYWtrnO8TAHP
        vcFa4J1w+1BLSFnj69ZvPG0=
X-Google-Smtp-Source: AKy350bfg5iycY16+iUpXfteBKP3Fc4xgEaxKW4EkKpcbiPL/UBLjhv/N76nHHTmaju/3YT2t1S9qg==
X-Received: by 2002:a17:902:e751:b0:1a9:433e:41d5 with SMTP id p17-20020a170902e75100b001a9433e41d5mr1550826plf.56.1682045487627;
        Thu, 20 Apr 2023 19:51:27 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id hi17-20020a17090b30d100b002471deb13fcsm3676695pjb.6.2023.04.20.19.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:51:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Shijith Thotton <sthotton@marvell.com>,
        Vladis Dronov <vdronov@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 20/22] crypto: octeontx2: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:44 -1000
Message-Id: <20230421025046.4008499-21-tj@kernel.org>
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
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Arnaud Ebalard <arno@natisbad.org>
Cc: Srujana Challa <schalla@marvell.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Shijith Thotton <sthotton@marvell.com>
Cc: Vladis Dronov <vdronov@redhat.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Alexander Lobakin <alobakin@pm.me>
Cc: Minghao Chi <chi.minghao@zte.com.cn>
Cc: ye xingchen <ye.xingchen@zte.com.cn>
Cc: linux-crypto@vger.kernel.org
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c | 12 ++++++------
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index ddf6e913c1c4..30e6acfc93d9 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -357,9 +357,9 @@ static int cptpf_vfpf_mbox_init(struct otx2_cptpf_dev *cptpf, int num_vfs)
 	u64 vfpf_mbox_base;
 	int err, i;
 
-	cptpf->vfpf_mbox_wq = alloc_workqueue("cpt_vfpf_mailbox",
-					      WQ_UNBOUND | WQ_HIGHPRI |
-					      WQ_MEM_RECLAIM, 1);
+	cptpf->vfpf_mbox_wq =
+		alloc_ordered_workqueue("cpt_vfpf_mailbox",
+					WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!cptpf->vfpf_mbox_wq)
 		return -ENOMEM;
 
@@ -453,9 +453,9 @@ static int cptpf_afpf_mbox_init(struct otx2_cptpf_dev *cptpf)
 	resource_size_t offset;
 	int err;
 
-	cptpf->afpf_mbox_wq = alloc_workqueue("cpt_afpf_mailbox",
-					      WQ_UNBOUND | WQ_HIGHPRI |
-					      WQ_MEM_RECLAIM, 1);
+	cptpf->afpf_mbox_wq =
+		alloc_ordered_workqueue("cpt_afpf_mailbox",
+					WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!cptpf->afpf_mbox_wq)
 		return -ENOMEM;
 
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index 392e9fee05e8..6023a7adb70c 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -75,9 +75,9 @@ static int cptvf_pfvf_mbox_init(struct otx2_cptvf_dev *cptvf)
 	resource_size_t offset, size;
 	int ret;
 
-	cptvf->pfvf_mbox_wq = alloc_workqueue("cpt_pfvf_mailbox",
-					      WQ_UNBOUND | WQ_HIGHPRI |
-					      WQ_MEM_RECLAIM, 1);
+	cptvf->pfvf_mbox_wq =
+		alloc_ordered_workqueue("cpt_pfvf_mailbox",
+					WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!cptvf->pfvf_mbox_wq)
 		return -ENOMEM;
 
-- 
2.40.0

