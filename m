Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D318B62E9C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 00:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiKQXni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 18:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiKQXnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 18:43:32 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D2F60C0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p12so3084915plq.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 15:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZAyTYmNqDqjhiVXCbn/iUUPGOe7A4x1iLp5SSq3M+Y=;
        b=dLZRKPT5/7kx0TlEiZlNB+Bsy9MykCBzKuYvbf+8/d1f6JvHA95KD9yWjQ7NUiaK9U
         ltEsZgLLEbUiTwbrbPyy6lXrjWCmu0gC3RhGlwHRH0yyW/HaeOrAZGhMncVoFTbs5K1S
         u/OTX3D96+lxdOUPshdERc3h+34GJk/uYpU9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZAyTYmNqDqjhiVXCbn/iUUPGOe7A4x1iLp5SSq3M+Y=;
        b=hx8JbeQkcGLKOaRmwYioo9tq11Pbd3m5UsJ1t+YhfTPqhOu4kgiAG+CmhtuJmcMhZ+
         jbq9vo22iF/lyLSPJT0xJYe7/Zt9LgRXXTsHKlebI+QC4M7Mfs+ZlwEyJdOktAndh86S
         sRIUTQrUhyGn+rGBPH0fgE/bC0Bc1ClGReFJPTrLZFaiE/8yRjr5X5KXZZdmImzUXjUm
         B8jarHZO+1soNSY0NLcO0VTGRWK1J6256LS1aXcpLdp9p1Q60ufYhB40BaXhsnggXhGc
         ay7ifmIeI3VuVxp4LHP+U5oqVBygAwyqksDA5MszXKB74YOUqKAX6Of/ZZRt1PEm5we/
         TyYg==
X-Gm-Message-State: ANoB5pkXxLcFlBukj4mq0WF+HLzCEmEccoHo4Z9qmfhbNkkAZLlXgGqy
        ei0v0xjz/+OqAN7NKqLY+5ypCQ==
X-Google-Smtp-Source: AA0mqf7bGaPbQBrK6tbmbhHYb+m32ki2iXpenM8TbT/Nda2AQsswz2Zx8KwCbvhgBsQ3yTreZUvBTA==
X-Received: by 2002:a17:903:1c2:b0:182:631a:ef28 with SMTP id e2-20020a17090301c200b00182631aef28mr4854752plh.46.1668728609730;
        Thu, 17 Nov 2022 15:43:29 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709027fcf00b00186a8085382sm777889plb.43.2022.11.17.15.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 15:43:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        tangmeng <tangmeng@uniontech.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Seth Jenkins <sethjenkins@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
Subject: [PATCH v3 1/6] panic: Separate sysctl logic from CONFIG_SMP
Date:   Thu, 17 Nov 2022 15:43:21 -0800
Message-Id: <20221117234328.594699-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117233838.give.484-kees@kernel.org>
References: <20221117233838.give.484-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; h=from:subject; bh=MYCrkHw9R8LxDYIRQQdTTq6YEsTSsq26SRgNezbmUEc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjdsccw0YheOkdHY6sLAGx2i/EwJzpirGYe5KFf1J2 O3NKspCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3bHHAAKCRCJcvTf3G3AJjQmD/ 9UudpK/LjYQqgT+uDSinOff7b8X/IOatcfoEVeqxjwXnW5g1w8/uvDchyE3AXUMKMSqUL9wlcA2YXY 9FsQwXAM9SiZxvpzbNCULf1J9dLOyGZpct/rt6MSKpGwRSboVh0q5IKCPpt527XqaY7ei1zE4MGiam 4eFnNJQKnOeU1nSKPj5C9V3FwStWVScAeP+eeWYhLytRpj+AVZ65/N4hdvCBK+rdV6a4k8uvS2o1bc VPNDgNxBbJIEn99M4tO00reM1b8JeS0x3kiCpL01KE2rYCeYC3Y5qFbAz1yj7TQZuDivhvVAgEXYTZ NDMeu733A70XHkm9eLHey8Sxdt+a59iiTDijcBqgOsjqMI67Xdt+mVA4MezxNn8c7TDJMukp7vYHgX 7w30Ut4mulgDUtaSbDBIDC4K8BJ8oInCdVm95U2j9U02tg0CltGRlNZXtdr66ydcPFz+lJUS53O9w4 bwCG83c270M7bk/bmJBKGbtETZLb2agP21esArCedrmGjWFHD9oKCEguHLI18J99mQ0kXvsA7yGkjq /Shb8v/SxobU3/gQ+OIl1a/paUZr1PmFr9F9y6PQ5NUfzucIpmrys6aUhc29wrFnuH1aiuyTroVlhx BkC9tCUjIlr2fuDrSQdTWWKaCmXp0MpZ8IUofmDmVX3pbG53VF2v2STqkKTA==
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
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/panic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index da323209f583..d843d036651e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -75,8 +75,9 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
 
 EXPORT_SYMBOL(panic_notifier_list);
 
-#if defined(CONFIG_SMP) && defined(CONFIG_SYSCTL)
+#ifdef CONFIG_SYSCTL
 static struct ctl_table kern_panic_table[] = {
+#ifdef CONFIG_SMP
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

