Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9CD6DA690
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 02:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjDGAS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 20:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjDGAS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 20:18:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61D94218
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 17:18:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54bfe7a161eso55527527b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 17:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680826705; x=1683418705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3z+/NV0dPqokddCY1NlsxXvpM1kRG3zeyORz1bdClYA=;
        b=Ie+PkEdZ8NlP4tCL2e6yryjW43O3XlBR/u9iiXFJbrMgcpOc3IYxzbK4XarLY/c800
         EXG+bqUm99QO6vRxqGGm6L0NFj0Pw4CjBYbEzTau0rzhcOGvAgnM9Uo5IfqMZnQS7rm1
         keHAfSFEnykWagzbkDK1KJhuzdPGEQbG36JE6SsUX1oZF2k7fIXPYJx1wg0LP2dYC+0n
         qNK1r8WguwjJ3Et1uGsyLEP3V6c6ipuIZlxizPlgqJIKZVmfhCH7l3Xg7bHM+ZptjsfE
         f+OGQyLSDyReUxbTJGma+JqRqXVN3DAhfOeHehKH+lrI1JZJ1gBCq6eHAK0XqL+3LQw1
         yLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826705; x=1683418705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3z+/NV0dPqokddCY1NlsxXvpM1kRG3zeyORz1bdClYA=;
        b=39y3XNzuAyYNwv/TPr4bi+UnnxB0Cirj2W7t3CTbmnyJ+kWbckVwaEebrUQ9IP99sj
         ZCbtIHT3tSeYpQ0v1lgS+dZrr+/zfQRwbQa7PtYCnuYAc/y9uxC147Vllpe+sf4PlbSV
         pjBEGHhj61gKkt4tUiI5NED1/GsUnqcyLxI8BLuDEy9LFGTxzcBz46V+A8H9iwFjygeH
         lxKqqcYc4IaI3Qcc1oRKODuJ/2A6s5I+v2H+GZyHkZkHQb8kWfDsWnyg5p03V0YAT/uN
         sG/22gP/J2H2jzgOWoDEnqlpzNZwL2lm3KGx4gwJKF1ogoUe1avs/apiVcFhj9HkQV1S
         Vx9A==
X-Gm-Message-State: AAQBX9fYDWKkh/m7RseAeN+UrrVwLINYjwCtfLcZSCfNapKq/MKfwD0b
        Y51CsfUHUvcUQahQmE0eOfXwoVLV
X-Google-Smtp-Source: AKy350YirQjSwlcK32mrO8lnWvk2qTJsYhBwSukQ/GdXrsixXKlrQORwIQb2OB7EAa5VenlcolW2BFg+
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:93:4:5600:3a73:ddd5:3f6f])
 (user=brho job=sendgmr) by 2002:a25:7716:0:b0:b6a:2590:6c63 with SMTP id
 s22-20020a257716000000b00b6a25906c63mr214401ybc.2.1680826704897; Thu, 06 Apr
 2023 17:18:24 -0700 (PDT)
Date:   Thu,  6 Apr 2023 20:18:08 -0400
In-Reply-To: <20230405225246.1327344-1-brho@google.com>
Mime-Version: 1.0
References: <20230405225246.1327344-1-brho@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230407001808.1622968-1-brho@google.com>
Subject: [PATCH bpf-next] bpf: ensure all memory is initialized in bpf_get_current_comm
From:   Barret Rhoden <brho@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF helpers that take an ARG_PTR_TO_UNINIT_MEM must ensure that all of
the memory is set, including beyond the end of the string.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6be16db9f188..b6a5cda5bb59 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -258,7 +258,7 @@ BPF_CALL_2(bpf_get_current_comm, char *, buf, u32, size)
 		goto err_clear;
 
 	/* Verifier guarantees that size > 0 */
-	strscpy(buf, task->comm, size);
+	strscpy_pad(buf, task->comm, size);
 	return 0;
 err_clear:
 	memset(buf, 0, size);
-- 
2.40.0.577.gac1e443424-goog

