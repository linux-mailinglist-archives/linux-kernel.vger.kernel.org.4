Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4458A6A4847
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjB0Ri4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjB0RiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:38:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825BB24CAA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:39 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c6ce8d74so152377877b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/Oe5vIeahqwi5sYk+6bCjyqP36jyrRz0eAbwTkYv10=;
        b=oVVsUrq9J7ftO0x2n5rOfx5Vuu5nhzvFsm0M1/orxQW1l03nlBX1oBt9Z3PeMUwxB8
         EXB0rSNNqcp6UVy0odo1Y2qU2vLsCHExXTtZRuAA28OmedCWSwEPwJ/vb5UPfrQv5PJW
         ecTpj0oKN79TWuriZXNGVkql1JYRLuNigyKob+qED9T9sBsRaNyBmXPE+YrDxEJo7iH1
         ubKjcF24jylzmHXYDSJCXBFRNZiczfW6Yvvr4W8sLGpkz89otOdurivgyE6QG9AxV0ch
         vbIsOJhdZ8Z0YDKh5k0bAgyDf+j5LXFUYUSVRKs5nZ5bUnBRVL57+VXMgXm8R+LTRb+i
         YnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/Oe5vIeahqwi5sYk+6bCjyqP36jyrRz0eAbwTkYv10=;
        b=XdDMpHvNpTTw14Bb/zhLkkVovhkDmbHJvSuZPSYd4N4lORUvCXhFIH4EKPSZSJ48KI
         9ZdqyU+lV9lXKkasqb22SHhled5sx/Zzz6wGOLL9wgrfOIP4GRfEj9A7ytotb5tb54Rj
         ynxsMH6Om4HCauOaQXqIH1PaezgPUBko9RqCX7L+S5EhHM+5uu4aQzC7RidA6U5n52rK
         VJsOXo2pmQ82vS8lK0LMFL+4a2ioD/1qa8IgVxwmG7/19/lCClAm1PmcgQVBtujr8AQm
         SwSwJS/h4Ml05nT7OpE0Ca9b3jRZkmq86Og8lCLGmiKI3KPXF50SuenrNQPYUgmoQMMj
         dftw==
X-Gm-Message-State: AO0yUKVWB9vcEq9s1UquW+mDzgronPdkSkCabLnL5xtkGi8dVVX75er9
        JvTa8TACYJisBPkD4Ha5PM/b1xo525w=
X-Google-Smtp-Source: AK7set+K4/t0896rH5imu1aS5MRSoxg+vS9UwsZogQaAvLfU1/2OHkdV+UAhVM9dEQWx1b4yJz5LZ0tC6/0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:e1f6:21d1:eead:3897])
 (user=surenb job=sendgmr) by 2002:a81:3e21:0:b0:533:cf4e:9a80 with SMTP id
 l33-20020a813e21000000b00533cf4e9a80mr10559241ywa.6.1677519458641; Mon, 27
 Feb 2023 09:37:38 -0800 (PST)
Date:   Mon, 27 Feb 2023 09:36:25 -0800
In-Reply-To: <20230227173632.3292573-1-surenb@google.com>
Mime-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227173632.3292573-27-surenb@google.com>
Subject: [PATCH v4 26/33] mm: prevent do_swap_page from handling page faults
 under VMA lock
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
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>
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

Due to the possibility of do_swap_page dropping mmap_lock, abort fault
handling under VMA lock and retry holding mmap_lock. This can be handled
more gracefully in the future.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Laurent Dufour <laurent.dufour@fr.ibm.com>
---
 mm/memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 8855846a361b..af3c2c59cd11 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3689,6 +3689,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		ret = VM_FAULT_RETRY;
+		goto out;
+	}
+
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
-- 
2.39.2.722.g9855ee24e9-goog

