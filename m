Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C9C623423
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKIUBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiKIUA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:00:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED23E13D4B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:00:55 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2948273pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5tPw3hkeTB324+bIPHjvhZ9LhWv7TTl0XHczdtESK4=;
        b=I1GTcHYtB8YdG9fl2OaQqVeKR34nKD1YdPrA64q7FsG6q2E6ffr69kJwfJMMOkJ/Sr
         odbQT5/HnpjggIyr9lMyFcumFpexhjb75nlj49y0dOhZmmrVi8y1b7uZXbpqcg4Su2oy
         nGrJzVFszBPQAQCAgRJRuuX+U+mRLq4h+Zkgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5tPw3hkeTB324+bIPHjvhZ9LhWv7TTl0XHczdtESK4=;
        b=zZ3e+N5oG7Tyj5N3Urdb9ujs//cE1Xtg8hiFNaNYlZx/ktnU9KdxnaeqoUTLvo7rcr
         eBX2YoNjX2Meh08fhDcdNyXnTuIMyVt4gon/V714zyFTjAPp3KY297BXieaAAZyoeEeg
         dz3wjyZTGkaKdUjcyQKeWzVbZUiDQivmjrgA3YvwI3xGhC8jOACK8++9CpxKSIDo5/hP
         tK5ZRfavBlXYs+1l3e7w4L8c6qEGW7l24U4ubc5zOyLDytyZ7wN/FjZf1I4de3wpIg6Y
         W6iDX14RWr23ljbUS1wCTLQBWySUtugmADn1II7eeG+sM2iVpSzHQIarbak7nXI4oFLV
         /HJg==
X-Gm-Message-State: ACrzQf0lOG2ORTYi+RDfJTzanEPJ+ZCaI+h4E3YjZNT+waS/rzMAQzPR
        +hh2QDgzobdHnyfs8cADALkljQ==
X-Google-Smtp-Source: AMsMyM5SANqY078orgX6dY68ZUWThz6OawQG+ENCYzuNrVVACjjBb7dQsTuNuerSN/q+uZVcLFc7gQ==
X-Received: by 2002:a17:903:40d2:b0:186:6f1d:608c with SMTP id t18-20020a17090340d200b001866f1d608cmr63246987pld.52.1668024055366;
        Wed, 09 Nov 2022 12:00:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l5-20020a622505000000b0056be1581126sm8965936pfl.143.2022.11.09.12.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:00:54 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-doc@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
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
        Anton Vorontsov <anton@enomsg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 5/6] panic: Introduce warn_limit
Date:   Wed,  9 Nov 2022 12:00:48 -0800
Message-Id: <20221109200050.3400857-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109194404.gonna.558-kees@kernel.org>
References: <20221109194404.gonna.558-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2660; h=from:subject; bh=Rm+lJ6u++jsmLEQkzPRQ5ICHP8+KAUDhfRVS5zjHPJE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjbAbwcHBlBplI6+7kNyZcKwP+Sml/277Z4LaSTf0u 9eRZjBiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY2wG8AAKCRCJcvTf3G3AJh1aD/ 9xflRviDrYBqPld0yVa3h4GYZgnj9k/BudvGLDeZgQ06918EaiTlebzGcxbEnFK/Au8S4maFKSwALy TFXCJWRYa99rQHPpbupXdfXoEa5jCKoNbrmLRQfssWJeQK8sCfP2uSAsDa7MVpgHm3DdjJrDhPsGcj IKq2X6+Bp8tvNslJm2CGJGLmdxv8catsbbA4u3nnxUyVoC4TSGDGnT/0qgrcmjnzD7FgJ/0zzWkS/z JO9QWa92/1FFddRhRdTYL4i/Zb8DcTUf1Zs/FFAPPy2YVN5nDMdBZmnRfHu8MRnhCV6EvaIATcF1mv hzaDeqIB5a6IHWQt1o3fkIhnTClQpvKn5KGSbt3WdCQL3UIvDQyDPPb7SkleOAHv7JUtDilQwn0CI/ ITPXTBIFuT9wcUQISWWb5hK2LsGhlqoIVigQx1I35f+TLjd13Jb9Kw8BuOuFKWyY9jxsBKl0t7g5VQ 7RpZubqS/13Dn6lCOtASVrfQ4hBlefUop5zVkeIOa1td6YoKFEgu0wNjV19haFm/xfZLZkEbIkafel yZHFuA5KEjrUh9vxzO6KXOhJv9bya2JKJ37BPoZCdFEPtjynjSfxcICwraUUOg8KX06Yz/OVFnktJa GgDhFRMJXgvpB4ir9DCwhcXC2BmPk900nMHvxiJUihERg0jE+/9VpX8wHjIg==
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

Like oops_limit, add warn_limit for limiting the number of warnings when
panic_on_warn is not set.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: tangmeng <tangmeng@uniontech.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/sysctl/kernel.rst |  9 +++++++++
 kernel/panic.c                              | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 09f3fb2f8585..c385d5319cdf 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1508,6 +1508,15 @@ entry will default to 2 instead of 0.
 2 Unprivileged calls to ``bpf()`` are disabled
 = =============================================================
 
+
+warn_limit
+==========
+
+Number of kernel warnings after which the kernel should panic when
+``panic_on_warn`` is not set. Setting this to 0 or 1 has the same effect
+as setting ``panic_on_warn=1``.
+
+
 watchdog
 ========
 
diff --git a/kernel/panic.c b/kernel/panic.c
index 3afd234767bc..b235fa4a6fc8 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -58,6 +58,7 @@ bool crash_kexec_post_notifiers;
 int panic_on_warn __read_mostly;
 unsigned long panic_on_taint;
 bool panic_on_taint_nousertaint = false;
+static unsigned int warn_limit __read_mostly = 10000;
 
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
@@ -88,6 +89,13 @@ static struct ctl_table kern_panic_table[] = {
 		.extra2         = SYSCTL_ONE,
 	},
 #endif
+	{
+		.procname       = "warn_limit",
+		.data           = &warn_limit,
+		.maxlen         = sizeof(warn_limit),
+		.mode           = 0644,
+		.proc_handler   = proc_douintvec,
+	},
 	{ }
 };
 
@@ -203,8 +211,13 @@ static void panic_print_sys_info(bool console_flush)
 
 void check_panic_on_warn(const char *reason)
 {
+	static atomic_t warn_count = ATOMIC_INIT(0);
+
 	if (panic_on_warn)
 		panic("%s: panic_on_warn set ...\n", reason);
+
+	if (atomic_inc_return(&warn_count) >= READ_ONCE(warn_limit))
+		panic("Warned too often (warn_limit is %d)", warn_limit);
 }
 
 /**
-- 
2.34.1

