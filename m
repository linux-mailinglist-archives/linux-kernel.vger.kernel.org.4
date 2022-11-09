Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7305C623418
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiKIUA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKIUAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:00:54 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD4E13D32
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:00:52 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r18so17110807pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOl6z/umIA2dhnmGMIG6cWX9VY1K0BEEK1Uosuato8Y=;
        b=Gka6JzDygIJ+DxhGOwp9S4RRCCCas04VGzIVik8QVniYT/h00GDqtbUPtAuiwLyLSo
         IcgRZX8xWzDMOfRAL0zquC3Ofpvb2fxZp/na3w0ujskXq0kO/9uZJwY68rl9BDhrkX2l
         86vacPYObXCyQOmEyb8omdqyh55iUH4MV+7/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOl6z/umIA2dhnmGMIG6cWX9VY1K0BEEK1Uosuato8Y=;
        b=Gs+D9Y4iLYrmCzwwDGPtRlLch1mLDcds6bSFD2yHkbMJOwDTJ3Smyr3xFR+/62pNem
         27s3dhPJrEFZ7CMXWToekL8W2D3A6aYk4lfpKKA4fITBrCYzVKhPRzuVA0NDKE5r3W+b
         wZ7x8Nmms5cd80MzZeNnM6GeRGQbu117dtN4/ibz/iKaDoB7SvtaLhzdTdrGRpb4tSWr
         Uz3cvxNla/0Q74E92+bpGRcpUnnjafiycsLpKQcCAbz4EuWdSP25AjBsvZd+T4+fBGOL
         GkdLIIftE37KpNAm5HK0A9ZILvsK6U8lUkSEerTew1UFH+uj/lhiz3kJGCzjzxgHfx9P
         saXQ==
X-Gm-Message-State: ACrzQf0PZEK+Ns8PDQ84W88fKzmoo3OLCfMdf9laJ0X8CAKR7Gch0cg3
        msuKLEKFuamB5r48R1/oVarrhQ==
X-Google-Smtp-Source: AMsMyM4yF1PgLzGEhlLvREfoGwRGCLaCp4b09MgHR3ZbYDeWI2E6+jguZ+DVChze5gOOKmIr3sL0wA==
X-Received: by 2002:a63:5150:0:b0:46f:be60:d1eb with SMTP id r16-20020a635150000000b0046fbe60d1ebmr45016359pgl.82.1668024052025;
        Wed, 09 Nov 2022 12:00:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a17-20020aa794b1000000b0056eaa577eb0sm8654375pfl.215.2022.11.09.12.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:00:51 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/6] panic: Separate sysctl logic from CONFIG_SMP
Date:   Wed,  9 Nov 2022 12:00:44 -0800
Message-Id: <20221109200050.3400857-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109194404.gonna.558-kees@kernel.org>
References: <20221109194404.gonna.558-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; h=from:subject; bh=IoW4clR1Z0l0tOPQKCaXz5ByKX5rPTSXg36TIGSUe64=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjbAbv1LOBj/eV9FJ9roBnkkNtYxaBPhV1cL6wlgbR D9gETvCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2wG7wAKCRCJcvTf3G3AJlUtD/ 97OgZ7IMn3jz6bT9vmc/YgFyUCFPLVBPbEk8QBykQqQITpRvaIn71jcxvGnQ6p0uGNEiQuoxc7AhU1 ah6MKCbYMay02cZ0WqCIGOnGcoH30Chbhu1peQ1QPCY24ArACK+DU5g1FSe2/rMFXFDBh7omd2GKVR jA30ciu1aIlQ//Lo8ZE5yW3VVKAGBhuohwQ04R/CawrVz/qXjSl/RqgyiXkINJNOCcytNkFPPcJBhQ 889xaIIzfX5NijRPr8S8tmJcGnNbLAuSV+ejNRUMQAWnbtbHZNBFUJyL2w3GPFqGOy5polHHUb6EQG Z7Cvlc4eOt4GP5drNlw+1smVVa68Oj+DTzuTkUEYpUpc0ajYX63hOFn2eMC1e25/l+5Sl2jfjT58ZZ 5aZrHCGfBHK7mrz+AL+7NkF9PHD1iLGqXT4tMG0mNbpftOn/h93mg8RKDi6vusCqKUwgQsYY4Q6B2l Mg9AP9hEjp0dtI2NCekNW23wvTElrzNMqldUgwJjvGnft7gCT4wsIqR/rzl92YKChzX3P9e0jfoSco nPPCFRMXOhY100moOq2KtKG49g/Ms4RvvyFP1Gmo+m3ppsvsqeBp7apapgTsE6pKtVzWkcgAlBArGI /0UUIHG03P7pOXIEOq/Ec7ouKxipBwYsM8AvUGRA9D9IDd7bcKz5j/VoZbBg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding more sysctls directly in kernel/panic.c, split
CONFIG_SMP from the logic that adds sysctls.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: tangmeng <tangmeng@uniontech.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/panic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index da323209f583..129936511380 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -75,8 +75,9 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
 
-#if defined(CONFIG_SMP) && defined(CONFIG_SYSCTL)
+#if CONFIG_SYSCTL
 static struct ctl_table kern_panic_table[] = {
+#if defined(CONFIG_SMP)
 	{
 		.procname       = "oops_all_cpu_backtrace",
 		.data           = &sysctl_oops_all_cpu_backtrace,
@@ -86,6 +87,7 @@ static struct ctl_table kern_panic_table[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
+#endif
 	{ }
 };
 
-- 
2.34.1

