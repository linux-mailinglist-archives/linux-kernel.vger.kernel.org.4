Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050D6622204
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiKICmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKICmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:42:20 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404DE1A221
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 18:42:20 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id om10-20020a17090b3a8a00b002108b078ab1so430873pjb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 18:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Mz4zEcIKBrlDyAmKkP8D55UhnpWD1j4J0ZUJ0geBMw=;
        b=JhcYXGD2COekAUcZzHL8U9BIh7stDBFD7YenyGw4kjTwzCbPWYUbVkDexYLlSQBXN5
         bJT/6/x+DHJY7IRVw4FCcb4ZmLORBnMo6V6FJpc2BnaU8kYwKO5IZmJuRKVwG+9n7ULS
         pk1WClMef+rhKaEf+wtDtwIz/Pa2lH643l7E+gUnJn4iC1waoHqWkFzIJ5X3w+TMeDoX
         dpaGqib14Den7EzSKBSSlJ7ikjcvCd8ymDqxpfgDuDhoEH11OnBbbhLJd3kWdb+sJfI1
         nPA1qi02HFS5VHxaSMdVApxfsemedy/mSyn4Vh7L1PEfrP4eja5/0z6oZQ9xSLgxUwXs
         zrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Mz4zEcIKBrlDyAmKkP8D55UhnpWD1j4J0ZUJ0geBMw=;
        b=spUaCZwSYgeoaHUE/I82swC0bWEtekUY2DyVb4D9KDPBa1XaRpGRvwKCU2Sm6BIqST
         Jmrs3H3kqjinbMw/+qbTenL2r9TwltTGEv82hhNHMf6/jCU2+WRtJ9LAB2o5j8G4QjDc
         tXlPD0/whaP0FfGaWXoRqovh8FPdHX2jZQTbd+XA6XUhe5mm3DxoKO+Nl0ez2WZf4cwt
         XXw5Dc1HAlwWuSpTqs35HY1hOWQFwmEkKwbBMXT3tGIBPi5+vxXi0SCZd/bJblGI1TiJ
         +8g2tj8DC+79uJfK/Djc1dBLoCiDkIBWyYIrZUQpEB4s+nDHUAbTZe7AbgD9iqcG58h+
         Tg0Q==
X-Gm-Message-State: ACrzQf2f6pY14QMq+Yo7sEdro1mbQsZQVcU/MEEZ7FC4oMMyMFAjvhM9
        jN0iAmtHdfbfKmsicazzaz1Aag3vSEtL
X-Google-Smtp-Source: AMsMyM47HuLO5TgBNWTp7jQWcJrJ68COM+oS3++tmtUkWz28Cdhx1sZHVJKmHynm5AGq2rCNdfY1639MXAXk
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:aa7:820f:0:b0:562:83c1:59e0 with SMTP id
 k15-20020aa7820f000000b0056283c159e0mr1116355pfi.34.1667961739606; Tue, 08
 Nov 2022 18:42:19 -0800 (PST)
Date:   Wed,  9 Nov 2022 02:41:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109024155.2810410-1-connoro@google.com>
Subject: [PATCH bpf-next] bpf: btf: don't log ignored BTF mismatches
From:   "Connor O'Brien" <connoro@google.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, "Connor O'Brien" <connoro@google.com>
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

Enabling CONFIG_MODULE_ALLOW_BTF_MISMATCH is an indication that BTF
mismatches are expected and module loading should proceed
anyway. Logging with pr_warn() on every one of these "benign"
mismatches creates unnecessary noise when many such modules are
loaded. Instead, limit logging to the case where a BTF mismatch
actually prevents a module form loading.

Signed-off-by: Connor O'Brien <connoro@google.com>
---
 kernel/bpf/btf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5579ff3a5b54..406370487413 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7190,11 +7190,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		}
 		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
 		if (IS_ERR(btf)) {
-			pr_warn("failed to validate module [%s] BTF: %ld\n",
-				mod->name, PTR_ERR(btf));
 			kfree(btf_mod);
-			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
+			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
+				pr_warn("failed to validate module [%s] BTF: %ld\n",
+					mod->name, PTR_ERR(btf));
 				err = PTR_ERR(btf);
+			}
 			goto out;
 		}
 		err = btf_alloc_id(btf);
-- 
2.38.1.431.g37b22c650d-goog

