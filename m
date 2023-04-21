Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C066EA201
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjDUCwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjDUCvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:51:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11013769B;
        Thu, 20 Apr 2023 19:51:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24b3451b2fcso1230404a91.3;
        Thu, 20 Apr 2023 19:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045482; x=1684637482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akTWRPzzBJ0wdmeG4+QDU8Yy42VUO1hiVrnvCUyERAQ=;
        b=EygXMbRMlcMPeJ20d4+Tkyht4zHzW+SkyJpVIWTlQyx71Cwsz2OY+unwD9T5JAydrD
         T6KMsfIN4B8EPW8iytzfJnaBRbHq4HHGXitYTxBANO7ekg0TmwXgnlsu7gMbycoc4zLj
         kIVpqIAP6C2mhgzLGKVBnxOU+dyM82smGgFhXOH3vERe2GNc+hKACo1HzQcmZXk2V6iz
         GD9l4zn8XR0lumYvsiZUcOcxLJlysZhVaz+EVzwts3iObxQ4HwvyNbwGIxux3gEC/5zC
         pcWDbYX9KYXykYpEY7iNY4+8Ls9dGaw54xrvCOK7BTs8I5C1h+lZe/sAeiD9tCLH2Dj/
         bQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045482; x=1684637482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=akTWRPzzBJ0wdmeG4+QDU8Yy42VUO1hiVrnvCUyERAQ=;
        b=ZABb3fD18osOCzPHcClRebDXbrOEJi3z1hL9piKu2+uYwRFCq+IJOskmxN24I0KKos
         9cBn4z03UvxX3lcBfCeKKeylJFppdevpWLFVgPXuk2Hcvb7WgbyVZIQaVCSX6yersq7x
         M4d+NNwoGf48FDlMz0FJYK1c+45xwqUFj3HsXErcvlkFP93JH9/ap+/pS3JbZsAJzGtB
         qurMSZt+MFqJbynZl+KWxnbB4XOEJeZ4mf/ig+LrjVrdqZlN0cAJR49zxbB8r+o40zWa
         RTIFyUHxOsFsD7gCcj5XDNPx2nK/TMRIzADgu3QJZ7ctRXLvVlZn3o4rV92tWldBf+ZD
         q+0w==
X-Gm-Message-State: AAQBX9eCCny4AcEByHHYIT79BvDONiiSUsclJwLgGraiybIOiCDqbbT+
        iH2VRvgxlMYAoo67d/tNPOw=
X-Google-Smtp-Source: AKy350ZeN7cItyvRbQDp96ext1pT7LnT8Kp2/aMd8xBTWr6Sc3SQBLXwbA5ayehlZA1RxHQCC91yaw==
X-Received: by 2002:a17:90a:880b:b0:240:3dc7:4939 with SMTP id s11-20020a17090a880b00b002403dc74939mr3682529pjn.27.1682045482177;
        Thu, 20 Apr 2023 19:51:22 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090a638900b00246fbf416dasm1787580pjj.14.2023.04.20.19.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:51:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [PATCH 17/22] cifs: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:41 -1000
Message-Id: <20230421025046.4008499-18-tj@kernel.org>
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
Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@cjr.nz>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
---
 fs/cifs/dfs_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 30cbdf8514a5..aece6d51bce7 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -290,7 +290,7 @@ int dfs_cache_init(void)
 	int rc;
 	int i;
 
-	dfscache_wq = alloc_workqueue("cifs-dfscache", WQ_FREEZABLE | WQ_UNBOUND, 1);
+	dfscache_wq = alloc_ordered_workqueue("cifs-dfscache", WQ_FREEZABLE);
 	if (!dfscache_wq)
 		return -ENOMEM;
 
-- 
2.40.0

