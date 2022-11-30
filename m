Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D79E63CE26
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiK3D7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiK3D6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:58:40 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753876C72B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:30 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k18-20020a170902c41200b001896d523dc8so12460228plk.19
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bodxPEkPe4EoxkpER4J2wU9Dhfdb08+KFdFbz39L+wk=;
        b=kI/n4iRgKxKH5uxHiuPwWoa6M/EbGola0ZxRsu3axly/Gbuc+LNMywjPFOJXNyPkw3
         ADTWIa4A64GNx5SmTgzoQZi0Xsxc7CNjghGjRd2NLapRIEdHqcVwMN08uPUFiPGa/rCn
         zwbLJ5+BTnwTGwyEHTJAgjjTtQLyHp8QOayLbcFCvLIdqQ/FXkBP4QOn6JoMEYwygLo+
         rQarpLHPEEfYG4U+9UXjT+qMuWv0EgIah3SS+hjyOBhhOJ1bTxw0ioESPcuKZTNeVCno
         d+AvT5AXI6j3k9KgY1IMIav8wiGK1Fn5Zf432HCkWpAP68tnvre8Nk+ur0SjSfsnEfTd
         dqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bodxPEkPe4EoxkpER4J2wU9Dhfdb08+KFdFbz39L+wk=;
        b=ANAvaTDc/Ah0gg/8VZM/NgYxN6RXjHA0hEST0Ig1QGYSPO/u5MkD/egetxwqG9xICc
         m5ejJ0qQo/JhkXZ4XC4VBc0iQZEN7sEe1QaLw2jXYT3g4w9omE8Nl9F4Bi5XGGhC5R9Y
         ueqkRkRkQ3CbRtJM3Z+IGw0omxBeBvDvtRcCVpatgyv4rTMZnXCrxyPpNmkeUcPQBvMz
         RSysWx1OvkrstalKoEYOw7QcJi376Ph3+mIq4zawHKp2hObJPaSl0chYTRR3OWnXoRdc
         0xx5E+vJkq6dwjHc3fjknhHJ+BTb+7BtZTrkMcRyzIK/O5ZZNPbny2lcI1Hdk2V+EAZ/
         hOzA==
X-Gm-Message-State: ANoB5pmppQ1iWyZZT5lhmsSh+88lEu6HNx8dJBo0GcsPH588dyuh+Z25
        cN1x8hVw9NCXm/4V+pFICsAvT42oU4UlrA==
X-Google-Smtp-Source: AA0mqf4oOqP/dHbQlKCbQkAXhBwXW+J2JdNnASKuchZD8PJhWRKB8yudMi3B8jnl0F2vu81s27+XmYmH+O4thw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:1696:b0:571:2b7c:6693 with SMTP
 id k22-20020a056a00169600b005712b7c6693mr42366845pfc.48.1669780709932; Tue,
 29 Nov 2022 19:58:29 -0800 (PST)
Date:   Wed, 30 Nov 2022 03:58:04 +0000
In-Reply-To: <20221130035805.1823970-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20221130035805.1823970-1-cmllamas@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130035805.1823970-6-cmllamas@google.com>
Subject: [PATCH 5.10 5/6] binder: Address corner cases in deferred copy and fixup
From:   Carlos Llamas <cmllamas@google.com>
To:     stable@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Alessandro Astone <ales.astone@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alessandro Astone <ales.astone@gmail.com>

commit 2d1746e3fda0c3612143d7c06f8e1d1830c13e23 upstream.

When handling BINDER_TYPE_FDA object we are pushing a parent fixup
with a certain skip_size but no scatter-gather copy object, since
the copy is handled standalone.
If BINDER_TYPE_FDA is the last children the scatter-gather copy
loop will never stop to skip it, thus we are left with an item in
the parent fixup list. This will trigger the BUG_ON().

This is reproducible in android when playing a video.
We receive a transaction that looks like this:
    obj[0] BINDER_TYPE_PTR, parent
    obj[1] BINDER_TYPE_PTR, child
    obj[2] BINDER_TYPE_PTR, child
    obj[3] BINDER_TYPE_FDA, child

Fixes: 09184ae9b575 ("binder: defer copies of pre-patched txn data")
Acked-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Alessandro Astone <ales.astone@gmail.com>
Link: https://lore.kernel.org/r/20220415120015.52684-2-ales.astone@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 398ce65b578b..1ba8a98094b4 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2695,6 +2695,7 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
 {
 	int ret = 0;
 	struct binder_sg_copy *sgc, *tmpsgc;
+	struct binder_ptr_fixup *tmppf;
 	struct binder_ptr_fixup *pf =
 		list_first_entry_or_null(pf_head, struct binder_ptr_fixup,
 					 node);
@@ -2749,7 +2750,11 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
 		list_del(&sgc->node);
 		kfree(sgc);
 	}
-	BUG_ON(!list_empty(pf_head));
+	list_for_each_entry_safe(pf, tmppf, pf_head, node) {
+		BUG_ON(pf->skip_size == 0);
+		list_del(&pf->node);
+		kfree(pf);
+	}
 	BUG_ON(!list_empty(sgc_head));
 
 	return ret > 0 ? -EINVAL : ret;
-- 
2.38.1.584.g0f3c55d4c2-goog

