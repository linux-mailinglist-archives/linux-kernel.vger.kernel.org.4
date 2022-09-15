Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D285B9E77
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiIOPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiIOPKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:10:25 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F67A515
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:06:31 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id e15-20020a056402190f00b0044f41e776a0so13141586edz.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=63Lbiss0mCSaP/JatuEwb7Qda7JVHXONR7b7gS/f0zw=;
        b=ldGNVPhue592Z38Ppx+dvuU/+jjZ3WM5nm+z0BSSu9h8ezP13vV/Wl1kx9FDE2kM00
         8hlbbp5debq2zMwyccXnSok/EFGYS9mlFPQu03BoXGKQ1tNoqAxco9vd+gOKziowlAx1
         960aMn5I15aiY7e/E9EZ/LgBtgV+tt97K0u4asdoScfhlsL/hbGWoqJyRe6AmibNWTiq
         J5lFB1m0MSx5XYBhZJDDB1ZWprW7OT9cPgi73vgc4CYvrUnMokBrBHdVIT4OYBHWdzX6
         Wx/pz4G0JRiQM/VifFqL0HQwwn8gpGYoshZYX49Ahm0NtbyPpOr/BuoO7lm2mFArdxjX
         g3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=63Lbiss0mCSaP/JatuEwb7Qda7JVHXONR7b7gS/f0zw=;
        b=bSY4v3uEhhmVwVkmzHEzrQVfXdhVN1dMjqu+ZpZTRtow80EUPRq23roP0s7Qm8/Gx0
         vqKA3w0NFA/kti/rUNiIYAEoMLmkFIHAAnMuXTmC7jhMHv8z1zMEbJu3GL/8o6tbZwuB
         mqqYjWDC09Jf9J5REEqVa80D0Uw1kB1EWkMlct/OUDH84a4zC+y/pBVPOajxqbVuG5a7
         GCgWzUyWbx4CC0rJgSQSwFrnIBBZUaxRiWZSOMkWercpXMzRzlhldrLtGAhyojYk/QKl
         94uIV5+wxlb3CqVBDqW81H+AdIMwWL18UWEd+yAgKhFwg59hC15Dt+gxmrILNYiMmxe4
         HRUg==
X-Gm-Message-State: ACrzQf1NJomge0J678xsHfWFfW97WFTqTAY5FrfEqmLFZomFzjg/nV1q
        XpSSO5bPVXjdsJHCaSgjz/z+WmSY1RA=
X-Google-Smtp-Source: AMsMyM7rMyupFoo64/C2rdfMBkqr7i79dpaceIzsK7wAJRHKNpXAyoVQnsUTDRv/eo0QEd57U+v7OZRoLF0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:686d:27b5:495:85b7])
 (user=glider job=sendgmr) by 2002:aa7:c1c4:0:b0:44e:b39e:2a54 with SMTP id
 d4-20020aa7c1c4000000b0044eb39e2a54mr259911edp.139.1663254390559; Thu, 15 Sep
 2022 08:06:30 -0700 (PDT)
Date:   Thu, 15 Sep 2022 17:04:15 +0200
In-Reply-To: <20220915150417.722975-1-glider@google.com>
Mime-Version: 1.0
References: <20220915150417.722975-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220915150417.722975-42-glider@google.com>
Subject: [PATCH v7 41/43] bpf: kmsan: initialize BPF registers with zeroes
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

When executing BPF programs, certain registers may get passed
uninitialized to helper functions. E.g. when performing a JMP_CALL,
registers BPF_R1-BPF_R5 are always passed to the helper, no matter how
many of them are actually used.

Passing uninitialized values as function parameters is technically
undefined behavior, so we work around it by always initializing the
registers.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I8ef9dbe94724cee5ad1e3a162f2b805345bc0586
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3d9eb3ae334ce..21c74fac5131c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2002,7 +2002,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
 static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct bpf_insn *insn) \
 { \
 	u64 stack[stack_size / sizeof(u64)]; \
-	u64 regs[MAX_BPF_EXT_REG]; \
+	u64 regs[MAX_BPF_EXT_REG] = {}; \
 \
 	FP = (u64) (unsigned long) &stack[ARRAY_SIZE(stack)]; \
 	ARG1 = (u64) (unsigned long) ctx; \
-- 
2.37.2.789.g6183377224-goog

