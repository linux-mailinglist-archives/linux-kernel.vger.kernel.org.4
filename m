Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6F6F8D8C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 03:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjEFBbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 21:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEFBbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 21:31:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DE72A6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:31:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9963a72fd9so4754096276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 18:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683336702; x=1685928702;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6hp0Ifesb79HPJK/KIKzPfPQWNmnCC9SBcN/OAlybow=;
        b=wn934bIjSlyYsjqUN/3i+nRgeyQ79+B1hcBs3GqYpWaJGFZXQA53NXLvputweRHFGw
         LMfhnju5v1AaMaoz9f4P0qQIYb5kkxJLnRgq6S2mToWYINn6YFZSntYoHigHqeEq6SRH
         41UinaAMctI7sBvB3z8E9//uz0Rbp52e9gIrDjgSBr6yw4JTzlIHjeObPY/CjBcsKX6O
         3i3syYMHoqqPrAapT7KfPo6h+KYOWD/FKhXk0yctt6mi/6o53LfT6gF6XfKNQuYTu6Cy
         wvc+4/7hWx1xbkRJOTC+2uMbg8jSKXBsY2oQ/eH/QSsFZs2JHRcIbHx9VIAXj/LEoAcy
         Oy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336702; x=1685928702;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hp0Ifesb79HPJK/KIKzPfPQWNmnCC9SBcN/OAlybow=;
        b=Ngu0j13kyjOOW9+T8KWXhr74N5fKrNlJuVbjXH3RR/3THaqxlDqvyHPxBbMsnxV2Je
         iRb4BU8lDx5ZzYm9UsOlbIak+Ab8mKJq9ecSDD0e7ZfUe69QNg7Q2qSW1vi+X1FF0bCg
         pI1MKaknxoAMItRmL7zauyPZ7Ak3boIukZK3VJheus7WSaW8G9NupvjjZiTVDP68VL7H
         FJO9fe1m4I2rO7zgCzqHb1DN7Lw3nF+k8Nc4QfOQqXC3iuKYj7JyVpD1CEsOoSu50Xi+
         H7eIs0KElWpLg2/BrZesy+UF9oap6FVTIvn81AVWm+KG645OP+HYBhhvN33X4OUOTrfR
         TUyA==
X-Gm-Message-State: AC+VfDwu55/KTXXvH/CSmi7yBDdW3ayuS7Fl+ph7E3zg6Xm50AI760mG
        Ea7Fl6AiXDDvSm1u61WieyeR8Sc2TOE=
X-Google-Smtp-Source: ACHHUZ41f8Sy+cWp32D8Fr5R8k9F7ETQDqrRG/yHewH0fB/t2EnZKA0kLgCgnG1g9wuRjbqZzUYo9wR+6UA=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:6826:a1a:a426:bb4a])
 (user=drosen job=sendgmr) by 2002:a05:6902:1021:b0:ba1:b908:364c with SMTP id
 x1-20020a056902102100b00ba1b908364cmr2063343ybt.12.1683336702159; Fri, 05 May
 2023 18:31:42 -0700 (PDT)
Date:   Fri,  5 May 2023 18:31:29 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230506013134.2492210-1-drosen@google.com>
Subject: [PATCH bpf-next v3 0/5] Dynptr Verifier Adjustments
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

These patches relax a few verifier requirements around dynptrs.
Patches 1-3 are unchanged from v2, apart from rebasing
Patch 4 is the same as in v1, see
https://lore.kernel.org/bpf/CA+PiJmST4WUH061KaxJ4kRL=fqy3X6+Wgb2E2rrLT5OYjUzxfQ@mail.gmail.com/
Patch 5 adds a test for the change in Patch 4

Daniel Rosenberg (5):
  bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
  selftests/bpf: Test allowing NULL buffer in dynptr slice
  selftests/bpf: Check overflow in optional buffer
  bpf: verifier: Accept dynptr mem as mem in helpers
  selftests/bpf: Accept mem from dynptr in helper funcs

 Documentation/bpf/kfuncs.rst                  | 23 ++++++++++-
 include/linux/skbuff.h                        |  2 +-
 kernel/bpf/helpers.c                          | 30 +++++++++------
 kernel/bpf/verifier.c                         | 21 ++++++++--
 .../testing/selftests/bpf/prog_tests/dynptr.c |  2 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 20 ++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 38 +++++++++++++++++++
 7 files changed, 118 insertions(+), 18 deletions(-)


base-commit: f4dea9689c5fea3d07170c2cb0703e216f1a0922
-- 
2.40.1.521.gf1e218fcd8-goog

