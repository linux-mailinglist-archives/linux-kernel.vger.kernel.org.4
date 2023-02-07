Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B087E68D3CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjBGKMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjBGKLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:11:53 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683D07689
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:11:51 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gr7so41820518ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+yniRi0vL0jtulkcpPba003O3or0uEtpgoqwm7lDS7g=;
        b=Z7Fx1JI4k/6dH5JjLN2sre7oFeJzzXEs3o2qTuC8/T2riLMscduZbzntrzBz+x3jsT
         8LfY2VSGoo19MhSy0wFkuLyx1M0L59cEDWN3wXE6bro0nb9BlJgYiRMPDdKMe207xuqZ
         WU+dnD0u9s6lNG6avsIzjMlIBK9z3yvy1F/3SHdN/5DWE5x3QftrtetAQolMfz1WsqUM
         VwkhCDpVqkduIlx1G+HmC/tEXnl2vQ+/4BnIz6EFIE67qFg3XjkPXhqHJla5n5xurjl4
         8CH2iX9mVEDDPvQDyXrlE+bVKaEstbUJBHj/jydKrByvTLnN7dvEC+X5nQB8ZvDg1lmv
         9R9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yniRi0vL0jtulkcpPba003O3or0uEtpgoqwm7lDS7g=;
        b=xPlNQSxTetsCYjSpNgr2rOqifE2125LaHJLDgCNKenxG+mB4GA+BoiJqxN+Eqfll3n
         PbOP0i6tuWQoc6wcJiJvMXmiTfd1N3VZW3fyaP4WvraEMwNW4MQy51wJgCRHIDOvWpFz
         Ag/MKWYStqQAXRJ0/S+ofnRrP60w/rNI/N3wP9C8ktafxD/xdw9d3+sSXndd0L1LXOHs
         HTdZpWYwzOPHPqtp5QgudAdBn2jmGEiBKBe/gtuprTLLhRxnmthKViQAG1tSmiFopTQx
         U5D4+0UlZBB2GdEOgRF1vQlaYm3xMK3vW0GYMfphWMMuMIg+XJaxMSc6XKKslSvyne5F
         fVNw==
X-Gm-Message-State: AO0yUKWjHq2FYoyjbK8leIv5CxYF9Dxv1yPH4Z443IZIkmanUCVgqtaR
        zE04xPfawxyZlV7VM4jolKSDUR85zFPHgXDWjl8=
X-Google-Smtp-Source: AK7set/K5SMvb4S1lbnkdoDzIVhnlr/DiOIxWGTw8CRUSatfke1VwgvN8tpd7inzKlXjvn2c5yZnkHS6XDVCgAGU2T8=
X-Received: by 2002:a17:906:3e88:b0:880:b580:d93 with SMTP id
 a8-20020a1709063e8800b00880b5800d93mr713023ejj.276.1675764709933; Tue, 07 Feb
 2023 02:11:49 -0800 (PST)
MIME-Version: 1.0
From:   JaeJoon Jung <rgbi3307@gmail.com>
Date:   Tue, 7 Feb 2023 19:11:38 +0900
Message-ID: <CAHOvCC4JU-f0-H=x1uWLjpCn4yeHr1Ze1DrXXoTmsGqW6-fYSw@mail.gmail.com>
Subject: [kernel/workqueue.c] Unnecessary WORK_OFFQ_POOL_NONE in the
 worker_pool_assign_id(), idr_alloc().
To:     Tejun Heo <tj@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When determining worker_pool->id using idr_alloc() in the
worker_pool_assign_id() function,
I think You need not to pass WORK_OFFQ_POOL_NONE to the idr_alloc() function.
This is because the idr_alloc() function checks the maximum value of
id as INT_MAX.
WORK_OFFQ_POOL_NONE is equivalent to INT_MAX.
So, I think Any code related to WORK_OFFQ_POOL_NONE is not needed.


diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a0143dd24430..ac65e66f8fc3 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -79,7 +79,6 @@ enum {
        WORK_OFFQ_POOL_SHIFT    = WORK_OFFQ_FLAG_BASE + WORK_OFFQ_FLAG_BITS,
        WORK_OFFQ_LEFT          = BITS_PER_LONG - WORK_OFFQ_POOL_SHIFT,
        WORK_OFFQ_POOL_BITS     = WORK_OFFQ_LEFT <= 31 ? WORK_OFFQ_LEFT : 31,
-       WORK_OFFQ_POOL_NONE     = (1LU << WORK_OFFQ_POOL_BITS) - 1,

        /* convenience constants */
        WORK_STRUCT_FLAG_MASK   = (1UL << WORK_STRUCT_FLAG_BITS) - 1,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7cd5f5e7e0a1..c38e93266987 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -546,7 +546,7 @@ static inline void debug_work_deactivate(struct
work_struct *work) { }
  * worker_pool_assign_id - allocate ID and assign it to @pool
  * @pool: the pool pointer of interest
  *
- * Returns 0 if ID in [0, WORK_OFFQ_POOL_NONE) is allocated and assigned
+ * Returns 0 if ID in [0, INT_MAX) is allocated and assigned
  * successfully, -errno on failure.
  */
 static int worker_pool_assign_id(struct worker_pool *pool)
@@ -555,8 +555,7 @@ static int worker_pool_assign_id(struct worker_pool *pool)

        lockdep_assert_held(&wq_pool_mutex);

-       ret = idr_alloc(&worker_pool_idr, pool, 0, WORK_OFFQ_POOL_NONE,
-                       GFP_KERNEL);
+       ret = idr_alloc(&worker_pool_idr, pool, 0, 0, GFP_KERNEL);
        if (ret >= 0) {
                pool->id = ret;
                return 0;
@@ -735,8 +734,6 @@ static struct worker_pool *get_work_pool(struct
work_struct *work)
                        (data & WORK_STRUCT_WQ_DATA_MASK))->pool;

        pool_id = data >> WORK_OFFQ_POOL_SHIFT;
-       if (pool_id == WORK_OFFQ_POOL_NONE)
-               return NULL;

        return idr_find(&worker_pool_idr, pool_id);
 }

Please check the above.
Thanks,
From JaeJoon Jung.
