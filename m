Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399DD67D575
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjAZTiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjAZTil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:38:41 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4894367FF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:38:13 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-507aac99fdfso31295167b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4H2JbtyBCb+lt3BMZ9RAgqYMO7ps4l+zp9I9WxDZLg0=;
        b=GvhfT8HlBz8p1gZ280ovX9/6GB7ujyE0mC33XR4z1GFfE3I8rBROHcdRdAX/8UI7kA
         /F+C+c1VR8F/5pty6DCqVVruDJ+FaYTiv9UsQ8bkabW2bhFFn7ZL+2G4uHgbOUn5krhJ
         fiQ850rSEV9tTLdVi2NHnmwUiLmCH4I/Z4cZ3D16EzW0BLVVV/iXdAF/eWZsuUqdKoqi
         9eZJA3h4Rjp/9quiM/byi/qogeVI4BWZVX0aIFHJr1GCq2CPbuY3nPW4saofEcd9+PYA
         /BJraP5tfjgrTZGsc41WIPGTxAmsx46xM/4Aci0nkz69PkDLsJDEuVCiUF4lTsZCuGWJ
         Nacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4H2JbtyBCb+lt3BMZ9RAgqYMO7ps4l+zp9I9WxDZLg0=;
        b=163ffUit8Xb15D5JDh7kY8EwPkpCymc0ciQdJ2Mjyw15+JNEsaIqHyq3qiTzmIpv+G
         06SDMkZrTyCnNvmh8s4diiZAszXSwDJkJtSE5bXUrGbMVXbsIK0rUGAGvmwmi36+6rgc
         vkHXgBYzI47FuBKWKbxEKPzL2wbHmW2AjgrK6IRGXLUinoshElXn4fjQhWcqGyUYlf8Z
         DtXGru7cdzjArrqXjIS7kXQ7umcOxzajJ/vfruoIBSNnmPb+taaDRKXiLsckhuq2A76R
         LTN+Q1USdurlAyU6cO8aTUdune75w8zKKN6V5lnmQOc3wb1b2USchbnuzvNayaKLt7qz
         c8KA==
X-Gm-Message-State: AO0yUKVQ/f3Jo9QlrcKqL1qmJFhLrTXiILKBQ3SEezjgeLcDVyCtR2td
        NT9YTzlP9MDMft2RRxD+4sS/dIwjco4=
X-Google-Smtp-Source: AK7set+emSOKq5kkIvzyTkfP4w6nIHmsUvmKyEJhxxnr9YfY72gnD2n+vNuYrEo9G5j6nG6EWinfQw9nh2Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:d774:88af:bab3:648d])
 (user=surenb job=sendgmr) by 2002:a25:37d4:0:b0:80b:8602:f3fe with SMTP id
 e203-20020a2537d4000000b0080b8602f3femr1304845yba.36.1674761892878; Thu, 26
 Jan 2023 11:38:12 -0800 (PST)
Date:   Thu, 26 Jan 2023 11:37:52 -0800
In-Reply-To: <20230126193752.297968-1-surenb@google.com>
Mime-Version: 1.0
References: <20230126193752.297968-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126193752.297968-8-surenb@google.com>
Subject: [PATCH v4 7/7] mm: export dump_mm()
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
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

mmap_assert_write_locked() is used in vm_flags modifiers. Because
mmap_assert_write_locked() uses dump_mm() and vm_flags are sometimes
modified from inside a module, it's necessary to export dump_mm()
function.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 mm/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/debug.c b/mm/debug.c
index 9d3d893dc7f4..96d594e16292 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -215,6 +215,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm->def_flags, &mm->def_flags
 	);
 }
+EXPORT_SYMBOL(dump_mm);
 
 static bool page_init_poisoning __read_mostly = true;
 
-- 
2.39.1

