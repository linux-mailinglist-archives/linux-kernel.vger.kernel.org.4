Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7986C6F22F7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 06:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjD2EpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 00:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347214AbjD2EpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:45:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D046B2D7F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 21:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3MmkiiZNk9+wb8Klw3jzPi8fh73m62AVfCNe2hPNLUU=; b=3OCkz1YgKtsppB85cXDdCi2F3q
        fQUvS0lN1/beLdci4WMpPWxc5l1L68XpvPJN5Fy11nojc16aVxNsy2lEhnKQoBuKfxYfHqQOZtlpD
        nEC9+DbaV+/oNNRL7P2kzCfAxKFgGEJO88aoFwioU4df6F63Jn346rm7U2Zjyts/b4gCrsT75DNNP
        4PGve5JHfmgWC5UJxzQj0RxqMUMwW2xF2trmEuLCD1GMZ2ELuqxGwA3M4Mla9Clld4OxL/2jgEL+O
        SVvPBAhHZnjljqh7BK27Nf+GEv7246ivJ5HjCgr4HkhN/wfdpDz9Zao2RPwWf3QHk37ko+6qoGzQy
        fzX4g7MA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pscSJ-00CEcL-1M;
        Sat, 29 Apr 2023 04:45:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC PATCH] workqueue: fix cast warnings on i386
Date:   Fri, 28 Apr 2023 21:45:06 -0700
Message-Id: <20230429044506.24843-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add casts to avoid int-to-pointer-cast warings on i386 or UML for i386:

../kernel/workqueue.c: In function ‘get_work_pwq’:
../kernel/workqueue.c:713:24: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  713 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
      |                        ^
../kernel/workqueue.c: In function ‘get_work_pool’:
../kernel/workqueue.c:741:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  741 |                 return ((struct pool_workqueue *)
      |                         ^
../kernel/workqueue.c: In function ‘get_work_pool_id’:
../kernel/workqueue.c:763:25: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  763 |                 return ((struct pool_workqueue *)
      |                         ^

Fixes: e120153ddf86 ("workqueue: fix how cpu number is stored in work->data")
Fixes: 112202d9098a ("workqueue: rename cpu_workqueue to pool_workqueue")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/kernel/workqueue.c b/kernel/workqueue.c
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -710,7 +710,7 @@ static struct pool_workqueue *get_work_p
 	unsigned long data = atomic_long_read(&work->data);
 
 	if (data & WORK_STRUCT_PWQ)
-		return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
+		return (void *)(unsigned long)(data & WORK_STRUCT_WQ_DATA_MASK);
 	else
 		return NULL;
 }
@@ -739,7 +739,7 @@ static struct worker_pool *get_work_pool
 
 	if (data & WORK_STRUCT_PWQ)
 		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool;
+			(unsigned long)(data & WORK_STRUCT_WQ_DATA_MASK))->pool;
 
 	pool_id = data >> WORK_OFFQ_POOL_SHIFT;
 	if (pool_id == WORK_OFFQ_POOL_NONE)
@@ -761,7 +761,7 @@ static int get_work_pool_id(struct work_
 
 	if (data & WORK_STRUCT_PWQ)
 		return ((struct pool_workqueue *)
-			(data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
+			(unsigned long)(data & WORK_STRUCT_WQ_DATA_MASK))->pool->id;
 
 	return data >> WORK_OFFQ_POOL_SHIFT;
 }
