Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462BE702C77
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbjEOMPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241472AbjEOMPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:15:51 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76572E50
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:15:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3063891d61aso12109809f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1684152932; x=1686744932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hkn6mSovc/K1pH6h+KL/Wzc9ziC0vdY0VDmvPstdlpM=;
        b=WfFDoYhhJSIxsKm86atquxQkExEUAlF2lWLGkB6M5XpnF9+qV3zqTmkx8yqvgqutrn
         UGck/66ojJzpKrryFpkm54O5jhoJzEXmooUIBUot7U9T/yg4WjyTHaWq+ErZQ2r9+8yS
         QPY73bNRqUdBt07i2rIE5U8+iH9665J+YbcOCBOk3o0jz9TpZ5BM3aDzyZGlLubcTlJ+
         IKmJN6K9yUEJKWul13vDx3GIxhlEermCJB3GNSKLiAL9kJsGEbp9/JGeIf9abXgpGDDK
         3O/1CRGvSQy8LWjinGNXaXEMKP/HDkPZM4+SEsIxUO9Vm4pIAMKmvjcGDEXoGpqjj/z+
         OnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684152932; x=1686744932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hkn6mSovc/K1pH6h+KL/Wzc9ziC0vdY0VDmvPstdlpM=;
        b=WtXheTnTY0Z5vFuOtnMl8FZmNhqFXancUFtedMPeI8MCaoGHN5VkqXcKO45H8acwQQ
         a8IPkQJ0nMg7nzJXYZvG2WunE2Hh20ltbQfBKqjj1E8Yz5//rYhBsMgtu1W6QquFvN33
         runiyCmXu8mfP9B//wmkklTQ+stwKIo1Y3/YzGHWNPq9T4ptuNPWYkgVV+bFkrahLhJV
         7HB2tcQ/33RM1awsDUlclKnlDKmH3Kcx/UScKj41jE2mNlbtPt9suFDEjfzVkszxmiq8
         2rd+Olw6bkbBJ4kwK67PMJTNlhfLpt0X5qNbN0z6bMfBOqMBfutFI29ia8DfNkaWs3kv
         qP7g==
X-Gm-Message-State: AC+VfDwPKvnhOPeOnudisXjvX+YVPteopKGrMSiZxwj3RjBENPiQUwm1
        T4BBJzGBLmAK0LTScexB2ktJAA==
X-Google-Smtp-Source: ACHHUZ6OB3eB3dnn14YkpgAlvyUgceuoxspKw45M/qxxlBx9woTaQHM6AQVrdjx82uuJtlUmR3ciFQ==
X-Received: by 2002:a5d:468d:0:b0:306:c524:7428 with SMTP id u13-20020a5d468d000000b00306c5247428mr21426374wrq.17.1684152931877;
        Mon, 15 May 2023 05:15:31 -0700 (PDT)
Received: from tpx1.lan (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id t17-20020adfeb91000000b00307bbbecd29sm16297032wrn.62.2023.05.15.05.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 05:15:31 -0700 (PDT)
From:   Lorenz Bauer <lmb@isovalent.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Lorenz Bauer <lmb@isovalent.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: btf: restore resolve_mode when popping the resolve stack
Date:   Mon, 15 May 2023 13:15:21 +0100
Message-Id: <20230515121521.30569-1-lmb@isovalent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 9b459804ff99 ("btf: fix resolving BTF_KIND_VAR after ARRAY, STRUCT, UNION, PTR")
I fixed a bug that occurred during resolving of a DATASEC by strategically resetting
resolve_mode. This fixes the immediate bug but leaves us open to future bugs where
nested types have to be resolved.

The problem is that env_stack_pop_resolved never restores the previously active
resolve mode when discarding a stack item. Fix this by adding the previous resolve
mode to each resolve_vertex and updating env->resolve_mode during pop.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 kernel/bpf/btf.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6b682b8e4b50..4d6c1d0e8b7c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -264,10 +264,19 @@ enum verifier_phase {
 	CHECK_TYPE,
 };
 
+enum resolve_mode {
+	RESOLVE_TBD,	/* To Be Determined */
+	RESOLVE_PTR,	/* Resolving for Pointer */
+	RESOLVE_STRUCT_OR_ARRAY,	/* Resolving for struct/union
+					 * or array
+					 */
+};
+
 struct resolve_vertex {
 	const struct btf_type *t;
 	u32 type_id;
 	u16 next_member;
+	enum resolve_mode parent_mode;
 };
 
 enum visit_state {
@@ -276,13 +285,6 @@ enum visit_state {
 	RESOLVED,
 };
 
-enum resolve_mode {
-	RESOLVE_TBD,	/* To Be Determined */
-	RESOLVE_PTR,	/* Resolving for Pointer */
-	RESOLVE_STRUCT_OR_ARRAY,	/* Resolving for struct/union
-					 * or array
-					 */
-};
 
 #define MAX_RESOLVE_DEPTH 32
 
@@ -1811,6 +1813,7 @@ static int env_stack_push(struct btf_verifier_env *env,
 	v->t = t;
 	v->type_id = type_id;
 	v->next_member = 0;
+	v->parent_mode = env->resolve_mode;
 
 	if (env->resolve_mode == RESOLVE_TBD) {
 		if (btf_type_is_ptr(t))
@@ -1832,13 +1835,15 @@ static void env_stack_pop_resolved(struct btf_verifier_env *env,
 				   u32 resolved_type_id,
 				   u32 resolved_size)
 {
-	u32 type_id = env->stack[--(env->top_stack)].type_id;
+	struct resolve_vertex *v = &env->stack[--(env->top_stack)];
+	u32 type_id = v->type_id;
 	struct btf *btf = env->btf;
 
 	type_id -= btf->start_id; /* adjust to local type id */
 	btf->resolved_sizes[type_id] = resolved_size;
 	btf->resolved_ids[type_id] = resolved_type_id;
 	env->visit_states[type_id] = RESOLVED;
+	env->resolve_mode = v->parent_mode;
 }
 
 static const struct resolve_vertex *env_stack_peak(struct btf_verifier_env *env)
@@ -4541,7 +4546,6 @@ static int btf_datasec_resolve(struct btf_verifier_env *env,
 	struct btf *btf = env->btf;
 	u16 i;
 
-	env->resolve_mode = RESOLVE_TBD;
 	for_each_vsi_from(i, v->next_member, v->t, vsi) {
 		u32 var_type_id = vsi->type, type_id, type_size = 0;
 		const struct btf_type *var_type = btf_type_by_id(env->btf,
-- 
2.40.1

