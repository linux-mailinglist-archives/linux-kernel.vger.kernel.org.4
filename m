Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46AA6EA1E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjDUCvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjDUCu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:50:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A058E75
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:50:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b62d2f729so1525812b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682045455; x=1684637455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZd1f2A/dHMRVFWDYKTVlcM/K09Kp/NZDEzNt1pICiQ=;
        b=JjUnbLxt1gWtb1QGpTKbuG9EbQaQbfiV1lE2b9kWYLdkgiKRAQlLXv/MlBL38U2wRb
         mBGgmlt+dD/c6WSgRZFG2bcSK6CvQ3/oO4UoB6f8TfRZyPKcb3tc1LHQUAr3puB9TpkQ
         rfVwglC+yLSTxnSj9AH/RfNxy3RMR0J08NTMiE5Pecdr10VBHBvSIzUTXC0/FK5a4B9P
         cppn3vl/c5qH8w0RDslEkXuvgEjsLbFiFCf6McyoknkZgZTRH0ib+0nQMUBnbNKuuDpM
         Njeu075OowgSpTzoifm4E5WTbkrHaWa4sR2SbaiuXIXOTpipzsgh+R9jwYK1IETsIatN
         APFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682045455; x=1684637455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iZd1f2A/dHMRVFWDYKTVlcM/K09Kp/NZDEzNt1pICiQ=;
        b=FrZ5kzgo646Z2pQbQbTp6/eGF7vngx+VTpdkQBjuoHK/G6xF1kOGVULO5EgMQ3U4hD
         vSNctp/DBjH5jWbmty68vkW4GsBQcwleRP5mGg5PxU5+JtPBCYgsekvyzx+i10C3shdp
         Cq2ISnaILfxrifAtW4oHkLrJaG6mjp1M7gtyD0yZLQ81XdD//EJoKcMPW/X/6TkJjSP8
         +UdCc0zRmeZV/QlhOne3HeFQ5DtIabV+7M/8ISNim7CpIJPCFqW6nTun96l2LrYro0u3
         i0BpqE8JLgTIn4v6Oij/N4HIvnzaMJk1riNhUVk20cQVz+YdWHanNh+nBGS518CgjXgK
         FDIA==
X-Gm-Message-State: AAQBX9cl6KlIGYZBj0UDVETQZoV9tY2nQVOz388AWOzLA/lFristSkWK
        7A4MGauR+524A7cZKCowGbo=
X-Google-Smtp-Source: AKy350YpYE5/bzDyZU8nyoNtqlL5ZKpi+ul4SY/Wh6L+xmh0jK+re7sRldnhJFEBy6jH2H8UGlC6hA==
X-Received: by 2002:a05:6a20:e619:b0:f0:4664:ad53 with SMTP id my25-20020a056a20e61900b000f04664ad53mr4774783pzb.48.1682045454474;
        Thu, 20 Apr 2023 19:50:54 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a22-20020a056a000c9600b00628e9871c24sm1886589pfv.183.2023.04.20.19.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 19:50:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org
Subject: [PATCH 02/22] greybus: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Thu, 20 Apr 2023 16:50:26 -1000
Message-Id: <20230421025046.4008499-3-tj@kernel.org>
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
Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org
---
 drivers/greybus/connection.c | 4 ++--
 drivers/greybus/svc.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/greybus/connection.c b/drivers/greybus/connection.c
index e3799a53a193..9c88861986c8 100644
--- a/drivers/greybus/connection.c
+++ b/drivers/greybus/connection.c
@@ -187,8 +187,8 @@ _gb_connection_create(struct gb_host_device *hd, int hd_cport_id,
 	spin_lock_init(&connection->lock);
 	INIT_LIST_HEAD(&connection->operations);
 
-	connection->wq = alloc_workqueue("%s:%d", WQ_UNBOUND, 1,
-					 dev_name(&hd->dev), hd_cport_id);
+	connection->wq = alloc_ordered_workqueue("%s:%d", 0, dev_name(&hd->dev),
+						 hd_cport_id);
 	if (!connection->wq) {
 		ret = -ENOMEM;
 		goto err_free_connection;
diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
index 16cced80867a..0d7e749174a4 100644
--- a/drivers/greybus/svc.c
+++ b/drivers/greybus/svc.c
@@ -1318,7 +1318,7 @@ struct gb_svc *gb_svc_create(struct gb_host_device *hd)
 	if (!svc)
 		return NULL;
 
-	svc->wq = alloc_workqueue("%s:svc", WQ_UNBOUND, 1, dev_name(&hd->dev));
+	svc->wq = alloc_ordered_workqueue("%s:svc", 0, dev_name(&hd->dev));
 	if (!svc->wq) {
 		kfree(svc);
 		return NULL;
-- 
2.40.0

