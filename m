Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0187762CFE4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbiKQAoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiKQAoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:44:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8C468C70
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:44:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f71-20020a25384a000000b006dd7876e98eso80892yba.15
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tqqMFjGDF/0cl1fPr35xPtWce5bPWD89nj4+3GOb1z4=;
        b=BFYjUhrsDiR1+BxbHULASwYMDNbqySno6XJl0aiTiABXUBnXPaMKnRra8Xn2tB/vhG
         jwylMf1HaJ/jPdg2FmJhihpjsA6XyMGO6XqUUo+ktUjqB3GEhXa8oSSravhLvpFnbg8P
         2LN5y6b6JmYVtshl+UWhqtKkZyZRpsAAVLLJwGRJ4pvVBlpzyIZCOWRBoCtHLAxNGHoY
         Yqy+R3vPjSKjuJgt5SDd9Gd5LaAUz6QR/NekqSteMG4OohazKWRQ4sFKXCwtO2xBVur7
         qP+KVfvU0P/b7vt/D9GaanDxbVFnW6IvtrhxroXv3vKRcS59NJV489LlKf/fzN2EZxXm
         xAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqqMFjGDF/0cl1fPr35xPtWce5bPWD89nj4+3GOb1z4=;
        b=EfPpcX9u5bybVD1zqq8pCx3bqbLfuraReh5G3nb3DLK8MiPi4e++AiCM7SIQFu9gBN
         mwFLWiHMXIrF2hSp3gs11og+stP9B7t/Z5+9z9ES4nrMC2OUV9i4r23cUgSzzVKqmf2s
         7FshP3V2ZrUIinfqe3aEV5HucpxCZsY6NjAalZ44ldB3lsq3Zk+ZP9L07UiK+ksetDkj
         ND0rYi5Oir5p3rsz/9EQlYjKQ5ggz/2Ss4HagvRJIcgIv6g/6S0Ag6XNFvt766YpBo8X
         6cpGAA4DgGHDVP4rbNaOuMI7pILG/a6F3tkK2ztGX/KDwZPQDcjkWn1WjA8RJpG+9TgF
         vv6Q==
X-Gm-Message-State: ACrzQf1EUftJcNOhnVy7jEwqylGnWP/SMHM3nT5hR14yp/nIqe6olA9d
        2D2EiRKArlIXrX2VN38wvO1ZLTcGUkl/
X-Google-Smtp-Source: AMsMyM52Xjlx1f8M0J7+q4w+9/Kw25ejm+KUg3bd5OUgPQMdu8d/1Ve0ifOKYVqHDvGrR6H3yLtaRPDnttPh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c14c:6035:5882:8faa])
 (user=irogers job=sendgmr) by 2002:a05:6902:14e:b0:6cb:e2cd:af57 with SMTP id
 p14-20020a056902014e00b006cbe2cdaf57mr66209539ybh.284.1668645846447; Wed, 16
 Nov 2022 16:44:06 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:43:50 -0800
Message-Id: <20221117004356.279422-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 0/6] Build output clean up
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce build spam from commands not prefixed with @. Make
install_headers targets distinguishable by adding in the library name
so:
INSTALL headers
becomes:
INSTALL libapi_headers

Ian Rogers (6):
  tools lib api: clean up install_headers
  tools lib bpf: Avoid install_headers make warning
  tools lib symbol: clean up build output
  tools lib perf: Make install_headers clearer
  tools lib subcmd: Make install_headers clearer
  tools lib traceevent: Make install_headers clearer

 tools/lib/api/Makefile        | 4 ++--
 tools/lib/bpf/Makefile        | 1 +
 tools/lib/perf/Makefile       | 2 +-
 tools/lib/subcmd/Makefile     | 2 +-
 tools/lib/symbol/Makefile     | 4 ++--
 tools/lib/traceevent/Makefile | 4 ++--
 6 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

