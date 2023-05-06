Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060486F8D96
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjEFBcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjEFBb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:31:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BF6729B
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:31:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a829a3de0so5360467276.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683336711; x=1685928711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=noqQTFIlV1didrxBB+dE4dD4wTuWXHoC2gsWWh71mN0=;
        b=A7WrekGhFBtviUe07eASnOsEN5eQOjONln//SJzN90P0dq/7aoZYKQNWGWUb0/pxX8
         17Xgy5Y/wecQTNRhXcUpON48bqSvod+CU0oz/gJnfxSfxAdbVUwGR5WKeSHFwl8hzzjA
         n394eeN+M0Ps+XOTymCWGimyWSpPTicDSD93VueMfqQrv2zWNoFiVmObNKdYPb43tL6T
         9m+jH7+LxrlkZUdSVVoUCETsDJNG+Os7lmdcr+hp8DeXQdQ+vS9ezc1aG9yNz9Uxmk8u
         hACmUGU/oHp265pa0tBla0yZtIloMb+FNYOhmgy9PpBBjkMhF6DGYGhjSoe6LQcJnIMN
         /Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336711; x=1685928711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noqQTFIlV1didrxBB+dE4dD4wTuWXHoC2gsWWh71mN0=;
        b=TUJRlSEdUEAOQQRo2cP8gZS8TopHjP8Z7wNOUAUashI7ys4PpHSdUxZaGviuuCovfA
         KC/hy8JnaKdLMiBD3Gtx23QtZ7u5CflTyUXc2kRF8WC1Cgm3eIn58IJEMeyk6SrgbriD
         Ng54eJvR0VJcnJ+LGo0Y94TAzyx3mpef//qliCM9/TbbSQU9YZMOrEixom9otAWbORL8
         jD7a69WBwqQcPhZdQVHRw7xMUJGqgkdZOIZM3UIFKGem+hP603icnmdhBaVYKz0eYXqe
         7IAxJCYJbvoP1qz6EPjxhxgJ3bOuymWfN8x6NH9+1FVOXpR6KPXwL44HiZsK+b1piLiG
         3Bgg==
X-Gm-Message-State: AC+VfDwFSvzefdKAiU5bLM/QheswMb6/FNSsY6TC6i9fUsNtZUXkKSTd
        YcrZn0BCeSHAY9k78dT1hL2rGm6ncJI=
X-Google-Smtp-Source: ACHHUZ4jAkCfhj/0qkPe2EbJCeuk7CdnGPeEz6q0HYyq5SD351NwAI0IIHutmYZUIFwtUnZ2cgWmvwb4PdU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:6826:a1a:a426:bb4a])
 (user=drosen job=sendgmr) by 2002:a25:d8cd:0:b0:b9a:703d:e650 with SMTP id
 p196-20020a25d8cd000000b00b9a703de650mr1515459ybg.7.1683336711412; Fri, 05
 May 2023 18:31:51 -0700 (PDT)
Date:   Fri,  5 May 2023 18:31:33 -0700
In-Reply-To: <20230506013134.2492210-1-drosen@google.com>
Mime-Version: 1.0
References: <20230506013134.2492210-1-drosen@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230506013134.2492210-5-drosen@google.com>
Subject: [PATCH bpf-next v3 4/5] bpf: verifier: Accept dynptr mem as mem in helpers
From:   Daniel Rosenberg <drosen@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
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

This allows using memory retrieved from dynptrs with helper functions
that accept ARG_PTR_TO_MEM. For instance, results from bpf_dynptr_data
can be passed along to bpf_strncmp.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7e6bbae9db81..754129d41225 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7495,12 +7495,16 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	 * ARG_PTR_TO_MEM + MAYBE_NULL is compatible with PTR_TO_MEM and PTR_TO_MEM + MAYBE_NULL,
 	 * but ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM but NOT with PTR_TO_MEM + MAYBE_NULL
 	 *
+	 * ARG_PTR_TO_MEM is compatible with PTR_TO_MEM that is tagged with a dynptr type.
+	 *
 	 * Therefore we fold these flags depending on the arg_type before comparison.
 	 */
 	if (arg_type & MEM_RDONLY)
 		type &= ~MEM_RDONLY;
 	if (arg_type & PTR_MAYBE_NULL)
 		type &= ~PTR_MAYBE_NULL;
+	if (base_type(arg_type) == ARG_PTR_TO_MEM)
+		type &= ~DYNPTR_TYPE_FLAG_MASK;
 
 	if (meta->func_id == BPF_FUNC_kptr_xchg && type & MEM_ALLOC)
 		type &= ~MEM_ALLOC;
-- 
2.40.1.521.gf1e218fcd8-goog

