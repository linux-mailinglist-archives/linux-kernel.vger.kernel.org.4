Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5A06D8AC9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjDEWw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjDEWw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:52:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F626BA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:52:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a253005000000b00aedd4305ff2so37295623ybw.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 15:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680735175; x=1683327175;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=69zSbXgaOWhyBbwPsZXjgkehhybiF17AZPRncmEXrvk=;
        b=rWIaZBr+k212Xdy78XkYIfWPJPTphyVHiW3AdxXktpl9dSrRH6B5uAnNmV5KE18Idf
         2UcZL+pXPrpLw0s8wPC79c2mq1OQztT4OC+7jPoqC3RYRI1Zmfut2bCFKjNNS5u1UhGX
         ckUQGl02PzTNXfWfMchaIWwiYKx741CW6nfeMU3FFoitOcMoo0srWDDV17BEKo6C2iIr
         HeLPNqqOIII0Vhv4R9Fr8d+PXyrspnznW4GH4BuerC3/5wEB3M1ni2BcW4RrK0Pqp+ve
         rtIVzUxPX3g42EihJBM8pJQ0Yxb/0Re2Keqr/7rW3MuaMgeizXiBDoD+Y2iYVv4qzYcB
         ILJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680735175; x=1683327175;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69zSbXgaOWhyBbwPsZXjgkehhybiF17AZPRncmEXrvk=;
        b=oXaXtXBtYUezHxmol/bjGlL/S9zT00noGsg2xuIuzZf+YhO6nMlrLFYfD1o1dCzyAV
         dZGFJGmFUjJmCZjF2EXnk0AcHA0Uh7vxQQET+Z8zJq9BCr4rMN2j2c2hvBda0uswOTQ4
         bZfSDDmXfpZezCTBm7CYM1IsVp532Z8wu86uKcniqfhTg/crrZRfSraecYX1XVcWnYLC
         dlU+39lPycjHhkMVcErZCHOd4eX0wzK4BNzjg2NyWnBFvBkFOU9AIMH2njsLt0ZC4yqq
         RP7yugNvmhRYMsLPUizh1QSDiY7SlOmFaxD5uX3xM876rSgUrL5kSmgjgpIRMRHEoRHh
         Tvvg==
X-Gm-Message-State: AAQBX9ep1HFD5sSWeDY7QZ5d8KnAFPrI0FV1po4DOZndSkh3IR3pXubA
        Lrr+FVbpBk9OIme+Dtp+OCqt5Xun
X-Google-Smtp-Source: AKy350buJh+ylgSt7G7Xu4/rIoDoHTOcOvT2CLgYmRVOTWHChDbW1t/UgEsVxywLGsvIg5pTvjU4odL3
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:93:4:8b:282:cd47:a9e0])
 (user=brho job=sendgmr) by 2002:a81:ae1e:0:b0:54c:bdc:ef18 with SMTP id
 m30-20020a81ae1e000000b0054c0bdcef18mr288403ywh.5.1680735175389; Wed, 05 Apr
 2023 15:52:55 -0700 (PDT)
Date:   Wed,  5 Apr 2023 18:52:46 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405225246.1327344-1-brho@google.com>
Subject: bpf: ensure all memory is initialized in bpf_get_current_comm
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
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
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
index 5b278a38ae58..adffb2f87e44 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -257,7 +257,7 @@ BPF_CALL_2(bpf_get_current_comm, char *, buf, u32, size)
 		goto err_clear;
 
 	/* Verifier guarantees that size > 0 */
-	strscpy(buf, task->comm, size);
+	strscpy_pad(buf, task->comm, size);
 	return 0;
 err_clear:
 	memset(buf, 0, size);
-- 
2.40.0.348.gf938b09366-goog

