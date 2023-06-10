Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DAC72A8E9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjFJDvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjFJDvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:51:05 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDE13ABF;
        Fri,  9 Jun 2023 20:51:03 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-75d4b85b3ccso234266585a.2;
        Fri, 09 Jun 2023 20:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686369062; x=1688961062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgbyKA8QC3K+q2sl72LDjL4RrY6kZndZm/jjqQ5iNdY=;
        b=Kz/ll/HtF6io3i0ST43NPilEmeUA2gTDSy1uJmmLyLpxAvunien8SETITsDk+z6jJX
         B2m/abMZob+okJItLFa8kHLFyDQwYFOW0ov/FneFP8JkF1SadiHzjZYZVBCzIa0kvRXX
         MFSEoVcLW0RGmE2Yf/6bq6Dmu4uzF3l1lkiQNcuEHIn4X5MEpJtuEyvU4PuZDnUv9MZN
         U2t15v7a1gn8Vl+XhVLbQY1bIB+lz+aPLFn85MPi5Lo49PUVF/wNZOIqOc6CK31uAEw2
         jzQt3oC8yZLAJ5ZQB6HBjgcGtlq00ED4aXsszXtK55qDcm612E64rXKzB+LzXWUOy4bW
         vYgg==
X-Gm-Message-State: AC+VfDz0ni/MMnkx0mwG/gDFgUPsJf95xuinZ++QMPwk2XWa8+RQAsnx
        jYcbJZ+FKW9jrFXkfDFfjaspDgcM+DlmQ3sF
X-Google-Smtp-Source: ACHHUZ7ARsRdT03avwV2EndKwbE42zpszYJoElKijFbVsOiOw9rik82Mkp41SMkbY9QE8y62Q0JfXw==
X-Received: by 2002:a05:620a:45a9:b0:75e:d2d2:26c with SMTP id bp41-20020a05620a45a900b0075ed2d2026cmr3901966qkb.47.1686369062120;
        Fri, 09 Jun 2023 20:51:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:81d3])
        by smtp.gmail.com with ESMTPSA id x14-20020ae9f80e000000b0074d60b697a6sm1469315qkh.12.2023.06.09.20.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 20:51:01 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next 5/5] bpf/docs: Update documentation for new cpumask kfuncs
Date:   Fri,  9 Jun 2023 22:50:53 -0500
Message-Id: <20230610035053.117605-5-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610035053.117605-1-void@manifault.com>
References: <20230610035053.117605-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently added the bpf_cpumask_first_and() kfunc, and changed
bpf_cpumask_any() / bpf_cpumask_any_and() to
bpf_cpumask_any_distribute() and bpf_cpumask_any_distribute_and()
respectively. This patch adds an entry for the bpf_cpumask_first_and()
kfunc, and updates the documentation for the *any* kfuncs to the new
names.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/cpumasks.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/cpumasks.rst b/Documentation/bpf/cpumasks.rst
index 41efd8874eeb..3139c7c02e79 100644
--- a/Documentation/bpf/cpumasks.rst
+++ b/Documentation/bpf/cpumasks.rst
@@ -351,14 +351,15 @@ In addition to the above kfuncs, there is also a set of read-only kfuncs that
 can be used to query the contents of cpumasks.
 
 .. kernel-doc:: kernel/bpf/cpumask.c
-   :identifiers: bpf_cpumask_first bpf_cpumask_first_zero bpf_cpumask_test_cpu
+   :identifiers: bpf_cpumask_first bpf_cpumask_first_zero bpf_cpumask_first_and
+                 bpf_cpumask_test_cpu
 
 .. kernel-doc:: kernel/bpf/cpumask.c
    :identifiers: bpf_cpumask_equal bpf_cpumask_intersects bpf_cpumask_subset
                  bpf_cpumask_empty bpf_cpumask_full
 
 .. kernel-doc:: kernel/bpf/cpumask.c
-   :identifiers: bpf_cpumask_any bpf_cpumask_any_and
+   :identifiers: bpf_cpumask_any_distribute bpf_cpumask_any_and_distribute
 
 ----
 
-- 
2.40.1

