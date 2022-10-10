Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31295FA8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJJX7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJJX67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:58:59 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE19D7FF9E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:58:57 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 88-20020a17090a09e100b00208c35d9452so4552535pjo.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTUrIJaSpVElDApPbK9Ogfa6jeq4HshVrEJbru1RJcM=;
        b=p+6H8bBZwkvXjYGvxdxhky+agm9qBDmK8LpqI+MkL1oZLYiZQD/o23pMHVwj4xGRhx
         bf9ODEqigYJc6RVWntTsxsj0pOopw1I4WXYAqnonPx4QdbV7S0LHfp0tSEcFoxWUhHn7
         30AMO8eq8jME46yURzfELTkWz8aJr1Iodvfc+7axAwaUAU9UZlkhgR/UF3T9F/wmVjMP
         D8ZLPnEocCn5U6yJ/FyDHNXxbO5lRS9rakU22g2FgjaFEDTsUJ6JSO4Ec9gKycc5Li4A
         1IXJT6f4tjJcpYLEoTuzvQ6FWwPINyF/jj3Ix9q80CwMjA2kZiLMx/JhHsIe2U1VkyLP
         Jchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTUrIJaSpVElDApPbK9Ogfa6jeq4HshVrEJbru1RJcM=;
        b=eeW3B5JSy+MQzzX/DOh8h4vf5mQzlPmnxDpkXMy7T2htfGapZV3AXN9yFynEvm18IB
         A1F05wLAr/O/aYt95G4h2tj8vvSJYhJzNf93QBAUpY4Jo/6/w3MhvPBuHOTGO4HX7TVB
         jt++o5/zvDw9bOqvOWsVsDfSArOnWk+/Xq1lqiSOTFCWLsIzae47NBqzkgO6Ddu1nFWR
         N1yJBo8YVHY2RzwOk7ssILw1o+pZxOXSacSERQhn/cz+P1UbhrYRu6sJ1TrWr6h7ZzTi
         wTWp0FY6e+k0A0z+px7l5vfJADQrgi9h/DQFo0rjBwc+tb/v/WefdK24RbU6dbXea2AH
         fhNQ==
X-Gm-Message-State: ACrzQf2FRH285KrclPDPpkQ1YHh2qO4vbCMBm+DuOTIHUVNMOyVrgfib
        AJAMK1Ypj/pdTROP49Nj5D1uVuWVN629JDD7
X-Google-Smtp-Source: AMsMyM7Lto5Xlv8xKu7VE669vgBYORrets5oSwZzF6NLsybuXw+F8Qy++IDKLe70lX6fUeg2cGtIEv+gwQzD/swm
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:248e:b0:563:7910:29b9 with
 SMTP id c14-20020a056a00248e00b00563791029b9mr5599812pfv.43.1665446337253;
 Mon, 10 Oct 2022 16:58:57 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:58:45 +0000
In-Reply-To: <20221010235845.3379019-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20221010235845.3379019-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010235845.3379019-4-yosryahmed@google.com>
Subject: [PATCH v1 3/3] bpf: cgroup_iter: support cgroup1 using cgroup fd
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
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

Use cgroup_all_get_from_fd() to support attaching to cgroup1 using fds.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/bpf/cgroup_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 0d200a993489..8bb307139748 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -196,7 +196,7 @@ static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
 		return -EINVAL;
 
 	if (fd)
-		cgrp = cgroup_get_from_fd(fd);
+		cgrp = cgroup_all_get_from_fd(fd);
 	else if (id)
 		cgrp = cgroup_get_from_id(id);
 	else /* walk the entire hierarchy by default. */
-- 
2.38.0.rc1.362.ged0d419d3c-goog

