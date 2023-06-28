Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD76740C23
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbjF1I7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjF1IZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:25:59 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C5330E6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:18:17 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id a1e0cc1a2514c-78f20071722so484634241.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687940297; x=1690532297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83rYaWFW6QNQhfB0rTt9RkG69OVxHHwKFqolT0xWQu0=;
        b=uD34f5+45avyvmcS0k/5rnqVFo+WNeLXDsL0ws/AxcFc6PxLPSOXrY7jDDkmLxMElT
         V2FL7xgbTE0NToHobzgopb6GxkHGQ//tBnqmD0MiCuPRG3aDLc//hl2OyRuIk4H8lHJE
         +6pPPV44KtQXrjX6ZVo2r9zBIhpwlJc9sds65PGOP08GBdzbncaGXJNky16yK+cnnYsg
         3M2N4bHVRXrl7Z8b4dUDmJC2oL9UK5OtRKxABYx2h5fqgQUoocY8QnTvSxSr79ypVwLG
         GYydFooO/JH6RINQLIFfX+Zdk43NQVRq9znQcroyPs6Lt8a79BG75aKR3YnJmbw4Hpar
         w2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940297; x=1690532297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83rYaWFW6QNQhfB0rTt9RkG69OVxHHwKFqolT0xWQu0=;
        b=AJoS6sFfZLupFpFnCkwFZlTffTR92iIyJYvX1JiiPajv8Qxw8c4LCKwwY808rSbcC/
         DhvFBR9D4bbHPsA26L05zpjPJs+BqOgDMnurQjYFmL0Wi6cPWlwA0P7RMY4YkaBkgVib
         FBfnUbQJkD5Ac2GMtVrdZmPMqWM7HzVjnLCq8EIH66/GagZ3GugmGeC782YVazp6AAUx
         CIGpUCWbz7pAzXRoco8jxnvwCQxE45RFCy8Wpti4KrhZWGTRHxn0dHkiPlp+MNUfE2zR
         U6lnC5qV2TXuQIK/B96YMPC6U8LygSp73bllOIwH3KhEjQJkxtb+JprGZfGHpM2Fv0UZ
         Jhuw==
X-Gm-Message-State: AC+VfDy+F6Q9NR3DsIeOvXOvaOwIe01auOntRDLloJYFPf23nQyI36si
        iRBbSJzDdbEbqJPFB1zfC2Hbl7HcBpE=
X-Google-Smtp-Source: APBJJlEw1+A/dz6nNLU/xIoq936J+gnmtGHgb4WKOZkDIT7PH8urmhAvh0DMqKPzkAG85bCaYotcRGxUtQE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6664:8bd3:57fd:c83a])
 (user=surenb job=sendgmr) by 2002:a5b:512:0:b0:c38:993b:3be5 with SMTP id
 o18-20020a5b0512000000b00c38993b3be5mr245ybp.0.1687936689805; Wed, 28 Jun
 2023 00:18:09 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:17:56 -0700
In-Reply-To: <20230628071800.544800-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628071800.544800-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628071800.544800-3-surenb@google.com>
Subject: [PATCH v4 2/6] mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM_FAULT_RESULT_TRACE should contain an element for every vm_fault_reason
to be used as flag_array inside trace_print_flags_seq(). The element
for VM_FAULT_COMPLETED is missing, add it.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 306a3d1a0fa6..79765e3dd8f3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1070,7 +1070,8 @@ enum vm_fault_reason {
 	{ VM_FAULT_RETRY,               "RETRY" },	\
 	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
 	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
-	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
+	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
+	{ VM_FAULT_COMPLETED,           "COMPLETED" }
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
-- 
2.41.0.162.gfafddb0af9-goog

