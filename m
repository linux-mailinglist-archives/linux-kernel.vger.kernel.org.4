Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FCA67EE97
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjA0Tnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjA0TnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F67173C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o1-20020a252801000000b0080b8600bdc9so6361211ybo.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq20e7KS4f4C48PKmYYknVSNimtVVHYzyV8VwmVTJ0Y=;
        b=SD5yhaj9WNDyBmH2zVXxIQSAPvkdOOdT/eZZRKlGP77z2J9nVnn6Obfbxv5sauUEV/
         LCtaz+vX4qip57892cEocWjVTNmQS4/TdyxbxT8xLbIWgkt6lFG5ZxopwUuxBJEnTkjr
         vQID9RMKTIQGW2sRQmcGmPfXjoMh0D1eDPyuL/b6rqwKxYdkfEYgEgHjQL0Tw8ZlMbjX
         ZH2/uoF+k+VRzud7oIym//RQdtO+lmKAHdfjocpDVWhkn9piFYOBRbFkKQo8sM+osjEQ
         FxFQ0vmeBJ9JfrQeSA2WMn51BintgFmdPrgL1EZjLw25vLNDWAlkic6I+BYJ/3xqK9CW
         +GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq20e7KS4f4C48PKmYYknVSNimtVVHYzyV8VwmVTJ0Y=;
        b=xbMAK4Bn4uhVjDHVf3YtwlIXPk0dxw7s513AIEBLb/aFdW7jNTCRS10jOkysBvTZ/v
         zyIvnaPSx51ikrXwyY16sr6Liz1jwjLJnZRgpXNeWA4QrVBEn3dO0i3Ej3MC9Khp7Q7X
         JXpuZx87/lVqa0CzO70z3eFtzmoGGl3e503liZJGHU6CfvibO5yussLexm5ekpS/iHlB
         OLH3sMjTvW7MOQIKOJF1IotNa9YRiURGaXezzFvJBr9tbqpotzJ2v0m+H8BllzcDYbrM
         KSO/M+5aLYPmp0Oxhz5a7QnoU12smiE2p+yKc6oxiEQqEPO3lDsIs6tR0goNULUH3wCN
         UgJQ==
X-Gm-Message-State: AO0yUKUI+KrJtqbbROnssNiZErS0gVFaBf5G47r63UyqAzpdzpGZOUtP
        pcfFXwUkPXNXvMtaWOlGIDOT5nxB8Hc=
X-Google-Smtp-Source: AK7set9CI7/3kZjfJSWqixfLkcUok8XHsx1YNSreUFU581ZlI+jbpFxEiZ86BfATPj+NjPN8bnYvtim468k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:4e19:be9:c5d0:8483])
 (user=surenb job=sendgmr) by 2002:a25:b283:0:b0:80b:c7cb:6d1f with SMTP id
 k3-20020a25b283000000b0080bc7cb6d1fmr1156521ybj.298.1674848502930; Fri, 27
 Jan 2023 11:41:42 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:40:49 -0800
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
Mime-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230127194110.533103-13-surenb@google.com>
Subject: [PATCH v2 12/33] mm: mark VMA as being written when changing vm_flags
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

Updates to vm_flags have to be done with VMA marked as being written for
preventing concurrent page faults or other modifications.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fee08e8fdce7..66dca140695e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -720,21 +720,21 @@ static inline void vm_flags_init(struct vm_area_struct *vma,
 static inline void vm_flags_reset(struct vm_area_struct *vma,
 				  vm_flags_t flags)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	vm_flags_init(vma, flags);
 }
 
 static inline void vm_flags_set(struct vm_area_struct *vma,
 				vm_flags_t flags)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	ACCESS_PRIVATE(vma, __vm_flags) |= flags;
 }
 
 static inline void vm_flags_clear(struct vm_area_struct *vma,
 				  vm_flags_t flags)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	ACCESS_PRIVATE(vma, __vm_flags) &= ~flags;
 }
 
@@ -755,7 +755,7 @@ static inline void __vm_flags_mod(struct vm_area_struct *vma,
 static inline void vm_flags_mod(struct vm_area_struct *vma,
 				vm_flags_t set, vm_flags_t clear)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	vma_start_write(vma);
 	__vm_flags_mod(vma, set, clear);
 }
 
-- 
2.39.1

