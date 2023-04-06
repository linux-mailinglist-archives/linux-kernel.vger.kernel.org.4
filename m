Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DAF6D8C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjDFAkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjDFAko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:40:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCD57687
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:40:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f66-20020a255145000000b00b714602d43fso37770091ybb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680741638;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f8wJOETfMk5LbkAt5hTIIj7SEycwbAoJf/W25gr+5f8=;
        b=X/Cr1dJYDVkTN7ZvVGGMWTGTPtx3tU0OJHVzAf+vzbi5Ai/vsm2qgnCLrIgHDlYgFY
         Nxy8ZU/49Bz9yxHGc+Dj5IqZ1g8DRbmgUUaqUs+uW+gHXqmWIcqYmcmx44zAzS/G7Nmt
         0xcUbqZPWofWsTH8IIkTL70sXGu2k6KPvZOzapVGTI8s0Dss1lnxrlfXgsICZL5AURrl
         TMm4m/R8RSFUbb8ZbaEIpuWxFz4ns/RpD4gIzMATa8MSLzhc6cWsUNDhM5YLxp6WoZvj
         +gIbhUhacuZ60SXdzI7qwxYCEYrhtSGchiQ5hGFlK9eFrpVRcExBjmKQITlJkI4EbGRR
         bPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680741638;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8wJOETfMk5LbkAt5hTIIj7SEycwbAoJf/W25gr+5f8=;
        b=uKZanKfKA8jDGM/XYdrgzuYYrebHyZgLY7ofmOkl5FmJ/tshEhL6yk6xX0rqgadf5E
         G8U7U2iJBJCphBBUVc3KzG0FMDRdCdEvr4PEmmHpi/jTdkHe3C43tncwJL6kk8RhtnJt
         JEh7eNFQNiLgIpRWSXOEIaJztTd7TfhVPdds4818ZvZ509BbFC/hnh0mdDrmwphkK9zz
         BDp7akpMcryVimH+mqSqR3rmoanSrD4y/yykbXjUs34xdqS5h9rJFh/S5w8KpMdJbbFc
         IV56lX+olyN9GkfeXpNJlCk3HnViPm1EgjnI5iF21V7R2SWyQadd8/luH2PDAVJQtlfk
         tDFg==
X-Gm-Message-State: AAQBX9eUTiKYEZE6fDzaHkcH8DGeUigU2I1wGuPsu0TLsOMNRI1Of7yB
        yXaxwhpImep0CSQ3FmSWNGGw0o7TS4s=
X-Google-Smtp-Source: AKy350Y5s7wagCr2uOBka7VpOa5phS+wwbaNaXpFuChbYAP5L74Oi6tc7dDQxdsiKbYC5BJLLm9qAExTIvw=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:694f:f21b:c6de:aead])
 (user=drosen job=sendgmr) by 2002:a81:af42:0:b0:546:8e4:703f with SMTP id
 x2-20020a81af42000000b0054608e4703fmr4898774ywj.8.1680741638313; Wed, 05 Apr
 2023 17:40:38 -0700 (PDT)
Date:   Wed,  5 Apr 2023 17:40:15 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406004018.1439952-1-drosen@google.com>
Subject: [PATCH 0/3] Dynptr Verifier Adjustments
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches relax a few verifier requirements around dynptrs.

I was unable to test the patch in 0003 due to unrelated issues compiling the
bpf selftests, but did run an equivalent local test program.

This is the issue I was running into:
progs/cgrp_ls_attach_cgroup.c:17:15: error: use of undeclared identifier 'BPF_MAP_TYPE_CGRP_STORAGE'; did you mean 'BPF_MAP_TYPE_CGROUP_STORAGE'?
        __uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~
                     BPF_MAP_TYPE_CGROUP_STORAGE
/ssd/kernel/fuse-bpf/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
#define __uint(name, val) int (*name)[val]
                                      ^
/ssd/kernel/fuse-bpf/tools/testing/selftests/bpf/tools/include/vmlinux.h:27892:2: note: 'BPF_MAP_TYPE_CGROUP_STORAGE' declared here
        BPF_MAP_TYPE_CGROUP_STORAGE = 19,
        ^
1 error generated.

Daniel Rosenberg (3):
  bpf: verifier: Accept dynptr mem as mem in helpers
  bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
  selftests/bpf: Test allowing NULL buffer in dynptr slice

 Documentation/bpf/kfuncs.rst                  | 23 ++++++++++++-
 kernel/bpf/helpers.c                          | 32 ++++++++++++-------
 kernel/bpf/verifier.c                         | 21 ++++++++++++
 .../testing/selftests/bpf/prog_tests/dynptr.c |  1 +
 .../selftests/bpf/progs/dynptr_success.c      | 21 ++++++++++++
 5 files changed, 85 insertions(+), 13 deletions(-)


base-commit: 5af607a861d43ffff830fc1890033e579ec44799
-- 
2.40.0.577.gac1e443424-goog

