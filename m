Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735586EA1E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjDUCvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjDUCvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:51:01 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF17292
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:50:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a686260adcso19604905ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045458; x=1684637458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kmxq/N/H4rwg524LDGOZfm1KVVcee8vyb3VSvQP8F5Y=;
        b=ZTCY7NIZjAIZ4DB+G2pVkVPay5EJSfc1C25/4dQzO6rEOb8dWk2a3sBo7DktdfJC97
         +6Y19aUSKlqAQ1mrHDXlyfdbr7ESauDOqjG9aJuiFMb23wcfOtuYeQVA+G4lBMt3Itl4
         6kq4kWs1IIMirSKOI61ReX5aSk44XK4NBpomNlGY1wfROaGTo9/a8jUugvs3En0+3f48
         5397J+WfVgEwnsKWZRbgoyqEYm3oXoe5EoHpItEzTyNGQREY+jYnykahtAsU5y4rRGa6
         gNqB3SLSAwLDMmLTyRyiIqfPRPjnxKP3Xg3IIu0IR58pTzBDxorMVtYBWjc2+1cxy+9W
         J2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045458; x=1684637458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kmxq/N/H4rwg524LDGOZfm1KVVcee8vyb3VSvQP8F5Y=;
        b=I//PYJUoI21dbsRBH832qzE2c/VJcfnzqZd1sTjC0TIM24FgWUlQUlVursjkd2HEVK
         4OffjUsIvG1iDn3/ipPUpV3xLh+MjqLK65C4YgW+73bDn8PzAD5evYEQMJ7qXtB1cFOu
         mEnuLMNxncOA8ClOV9KI4bD30VULAjI4J7vmKVSC4/24XDq7MoFP4QlsbU20Mx3Kd0GR
         5U1NfjHE1c12OL+YyPNI/2UtG+0lZe7DhkzuUvz/lc/LK+eheW+Hb1PbIxp3XkBlAtoM
         L/DVynthaipotjGnLEYdbuo6eQc9FGDFVrRUiZmedBsQY8MUkY0hA5heHDXnNHItmN9F
         20pg==
X-Gm-Message-State: AAQBX9dR5DFurMu0uoocMLGt1f2jT2CwVHpMic6t4Yb/yzE7HvDlToX0
        DIx+uHenQKsa1fUNjcdnzuA=
X-Google-Smtp-Source: AKy350aqDpfwIiNBxQVsj/SwKpAWaUrT+Zg1S2t7A6JKHmkdLX6vogU3qmIOHjok4Zu0N2ZogY9SQg==
X-Received: by 2002:a17:902:ceca:b0:19e:665b:2514 with SMTP id d10-20020a170902ceca00b0019e665b2514mr4741371plg.43.1682045458279;
        Thu, 20 Apr 2023 19:50:58 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q92-20020a17090a756500b00246f73a994esm1767145pjk.32.2023.04.20.19.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:50:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Subject: [PATCH 04/22] dm integrity: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:28 -1000
Message-Id: <20230421025046.4008499-5-tj@kernel.org>
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
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
---
 drivers/md/dm-integrity.c | 4 ++--
 drivers/md/dm.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index b0d5057fbdd9..6b36554f9103 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -4268,10 +4268,10 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 	}
 
 	/*
-	 * If this workqueue were percpu, it would cause bio reordering
+	 * If this workqueue weren't ordered, it would cause bio reordering
 	 * and reduced performance.
 	 */
-	ic->wait_wq = alloc_workqueue("dm-integrity-wait", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	ic->wait_wq = alloc_ordered_workqueue("dm-integrity-wait", WQ_MEM_RECLAIM);
 	if (!ic->wait_wq) {
 		ti->error = "Cannot allocate workqueue";
 		r = -ENOMEM;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index dfde0088147a..bd3342613e4c 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -207,7 +207,7 @@ static int __init local_init(void)
 	if (r)
 		return r;
 
-	deferred_remove_workqueue = alloc_workqueue("kdmremove", WQ_UNBOUND, 1);
+	deferred_remove_workqueue = alloc_ordered_workqueue("kdmremove", 0);
 	if (!deferred_remove_workqueue) {
 		r = -ENOMEM;
 		goto out_uevent_exit;
-- 
2.40.0

