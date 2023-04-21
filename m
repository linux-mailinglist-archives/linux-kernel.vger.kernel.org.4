Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264F36EA1FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjDUCwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjDUCvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:51:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F827692
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:51:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso1496380b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045479; x=1684637479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCPjQIn4S0PQfuCNwvELUc3S8eh+s9mUvwJw7/d5uLU=;
        b=XMLFtb9wYP9gqpPSKTS7T/p74xQvZs2nOgKFEigpBUk7eM6Kb8bvSh/sAWoXK1dcSj
         KWvLP7zD7yOkPXgcobpT2jsCaQldUniFt2NYg1yoc43TcDmS4stE8W3P1iJVksjOSFgn
         jFjMkwjkXmYgdw0wK5uHCXH21wcr+eFz6d3UdFMZxRfvvPHtseSbL2d8RWYeNIn0heuJ
         FLmKIh3j/9iUx4YIIjpr7XgLkSBxR4PUF5gMWpa5OT7mIXmR9L4DowA/AYb/EeXijmVO
         hy4tJiy1od2XsdGkrSh8kcquhPEtsLG9Z6cwResFqBkNejkqYJI+lXHC9L6wZvRHe583
         m/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045479; x=1684637479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCPjQIn4S0PQfuCNwvELUc3S8eh+s9mUvwJw7/d5uLU=;
        b=HxsX7UzHRoMmP6ltvzBzL7/BGtdpNQWoCNiw3nEwb8YewtJAiQvpZxyIFfe+C4ijW0
         nsk12f+1SQrqvro+D9Dfgbc7IayAVNqT55eCtBz3ZYEdRSJEJkDMJyBjSV7jQxyfK5BD
         OnPI/CY9HmcuSzt/KaVCEEGWQtKQUqQMSlUEZP3kbZjekt3ejePAx2E3nMTWsxUbZfMF
         fOcE7zRkaeIbWrK/+Iv60V0/Zlw4ENJz+ygeCe7sJfKX5k8786Qn3BTA/5za19U2A6Yy
         TwiY5S8fDJWgPxvRnZ6l/tgPN7ZNrRUzJGPbCl2F8tW4gmtMME2Kkqi8yTpbo3EnNhaY
         vwmQ==
X-Gm-Message-State: AAQBX9coJbHwaV0L6b+LgZnJ01AsGimwwMOZrt/wGwH+WM4g6mrQ8zCx
        VCkerv8VGmII16ihWzVKveJqS+gCCUE=
X-Google-Smtp-Source: AKy350ZqQdhTADBSG8sDswV21AqHVDTdbtktu2O/S0Hkg5un6hH0viAxUI3uMxO9h5GAesNZA/ePlA==
X-Received: by 2002:a05:6a00:15ce:b0:63d:3411:f9e3 with SMTP id o14-20020a056a0015ce00b0063d3411f9e3mr5061818pfu.19.1682045478499;
        Thu, 20 Apr 2023 19:51:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n11-20020a056a00212b00b0063f167b41bdsm366523pfj.38.2023.04.20.19.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:51:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 15/22] xen/pvcalls: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:39 -1000
Message-Id: <20230421025046.4008499-16-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421025046.4008499-1-tj@kernel.org>
References: <20230421025046.4008499-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/pvcalls-back.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index 1f5219e12cc3..b41516f3f84a 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -361,7 +361,7 @@ static struct sock_mapping *pvcalls_new_active_socket(
 	map->data.in = map->bytes;
 	map->data.out = map->bytes + XEN_FLEX_RING_SIZE(map->ring_order);
 
-	map->ioworker.wq = alloc_workqueue("pvcalls_io", WQ_UNBOUND, 1);
+	map->ioworker.wq = alloc_ordered_workqueue("pvcalls_io", 0);
 	if (!map->ioworker.wq)
 		goto out;
 	atomic_set(&map->io, 1);
@@ -637,7 +637,7 @@ static int pvcalls_back_bind(struct xenbus_device *dev,
 
 	INIT_WORK(&map->register_work, __pvcalls_back_accept);
 	spin_lock_init(&map->copy_lock);
-	map->wq = alloc_workqueue("pvcalls_wq", WQ_UNBOUND, 1);
+	map->wq = alloc_ordered_workqueue("pvcalls_wq", 0);
 	if (!map->wq) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.40.0

