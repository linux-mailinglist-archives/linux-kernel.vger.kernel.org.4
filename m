Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C056FDD9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 14:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjEJMVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 08:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjEJMVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 08:21:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224122718;
        Wed, 10 May 2023 05:21:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ab01bf474aso54704435ad.1;
        Wed, 10 May 2023 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683721278; x=1686313278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7dp685KgRykaIBOrjfOnIF3gqnjlqK+bB6pT5rHUIE=;
        b=nJYye+IyZSqyEJZf0XcSmzkOb+mvnJ9kc2rwai8v1Xs6/Vj5YtVplF9Sv73GVGFNqq
         h5tfDTH0UdDzcyBEcChdqATnKiYl/5q/ZPZXnx08e5MdGP4vvxHJ3OY5Q/pjH+YiEAfL
         HeZVrnYUHCYqta9CY9HriS2cQLQXph/7sqDz1UuF2F1UD3hRl2LLwfZPCxQ7Km3DaxsY
         LBIlOXw1t+Xi/ywqPKYWTZehhVRBP/qfaJh7OKZUrsOBeUNe1lz6Lsq5b1cyxMaQODgk
         mHPzzq3weV9J5cQPzczQSwis3qM2TzPzN7wHuvMXDiR+M00b/bkuqzGqOj8dRt9/sdbS
         WQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683721278; x=1686313278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7dp685KgRykaIBOrjfOnIF3gqnjlqK+bB6pT5rHUIE=;
        b=DUQaC6AWI+udn0/kk2tMHdx9DdYOvGKOcg0W3sEN5Cn2OKd7oJztJxb3C9O7CZIRrZ
         aFfnB8tGBqO9PWlskypFZtgboE9sl34Ai6YY+391ltbyytl8hXo0aybfdtFgNIoMoCYa
         FOU6qf7w3KkOaRZ14VQBrwxEmINldj/mjMnFZqcLC88/+DV9lvrSvoO17+bxpRfYt1ut
         AhOwTzd5mdgwJmLRqmYxToEzuXGqjD8VbKLIvHRjDw12juCny7AlaqBmL+3IeJ/TQp4d
         s7WN8GOOaAIWVjuLnU/ifSFSyYlnZmKPIUjg5ixP/2lSMT62Vvz1xi7qMCwSdH9zzEgj
         JTEA==
X-Gm-Message-State: AC+VfDxH1b1zwU5U5TVKFqzHKzDNRsX4xmP4da27dzXqbjzQHnK6+u3J
        1W2aMHI4/gRFUPrZrtVTzZU=
X-Google-Smtp-Source: ACHHUZ4z1uChmZuHVVB3lthpwvEKSZb15jUYFo0cDDVYKim1g/NM2Lpyadx+i9D6RwXtxSzowr8PiA==
X-Received: by 2002:a17:903:185:b0:1a9:6bd4:236a with SMTP id z5-20020a170903018500b001a96bd4236amr22043323plg.69.1683721278561;
        Wed, 10 May 2023 05:21:18 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.15])
        by smtp.googlemail.com with ESMTPSA id u1-20020a170902e80100b001a95680eecesm3611395plg.297.2023.05.10.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 05:21:18 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ze Gao <zegao@tencent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid recursive trap
Date:   Wed, 10 May 2023 20:20:45 +0800
Message-Id: <20230510122045.2259-1-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
however it does not takes those kprobe blacklisted into consideration,
which likely introduce recursive traps and blows up stacks.

this patch adds simple check and remove those are in kprobe_blacklist
from one fprobe during bpf_kprobe_multi_link_attach. And also
check_kprobe_address_safe is open for more future checks.

note that ftrace provides recursion detection mechanism, but for kprobe
only, we can directly reject those cases early without turning to ftrace.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9a050e36dc6c..44c68bc06bbd 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 	return arr.mods_cnt;
 }
 
+static inline int check_kprobe_address_safe(unsigned long addr)
+{
+	if (within_kprobe_blacklist(addr))
+		return -EINVAL;
+	else
+		return 0;
+}
+
+static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num)
+{
+	int i, cnt;
+	char symname[KSYM_NAME_LEN];
+
+	for (i = 0; i < num; ++i) {
+		if (check_kprobe_address_safe((unsigned long)addrs[i])) {
+			lookup_symbol_name(addrs[i], symname);
+			pr_warn("bpf_kprobe: %s at %lx is blacklisted\n", symname, addrs[i]);
+			/* mark blacklisted symbol for remove */
+			addrs[i] = 0;
+		}
+	}
+
+	/* remove blacklisted symbol from addrs */
+	for (i = 0, cnt = 0; i < num; ++i) {
+		if (addrs[i])
+			addrs[cnt++]  = addrs[i];
+	}
+
+	return cnt;
+}
+
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct bpf_kprobe_multi_link *link = NULL;
@@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	else
 		link->fp.entry_handler = kprobe_multi_link_handler;
 
+	cnt = check_bpf_kprobe_addrs_safe(addrs, cnt);
+	if (!cnt) {
+		err = -EINVAL;
+		goto error;
+	}
+
 	link->addrs = addrs;
 	link->cookies = cookies;
 	link->cnt = cnt;
-- 
2.40.1

