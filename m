Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFB35FA95D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJKAeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJKAeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:34:09 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F197E018
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:34:07 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 88-20020a17090a09e100b00208c35d9452so4589255pjo.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbGsK3zRIBgwO+yeL9iNdWAuCYqQNstAHk5QocJBrw0=;
        b=HlswPq1vxu4CahK3K4qytrglcfUaCIEln3TR+ZaOeKULDkAK1aqKQSdLX6eVGYAWQV
         1YXwY5Yypslv441L2zV7UTIw3m7naY0rZWu+z+IxjaLZCz09HM29UwTgE7uFvLdoIy6H
         SYG7rPGunn+5Y4b8pIi5ZvGNguDNlWO9iqX+60jtpWrAEMWcFdWzG7iZrYGZy0/pI57t
         aboRfOJjSmvh1loG6tkJG8t7kek1kBVlhY1i/m3YSnZkRST1i25gfU8Iu1OMg9ak/9yu
         cpnrqG2zBTIbNcsCF7b0l0HnYDAucO2pgNJ88wz9TssQO/7wDN6vGFPyzXUU81+lAaP0
         /hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbGsK3zRIBgwO+yeL9iNdWAuCYqQNstAHk5QocJBrw0=;
        b=SrVjbApgd4kuwm/7BwkKOpZkz7uoWlmshRMFlMr1GpnccP+umRoRFNRhhKaVSaroLU
         lL1xGDaPPebQ4H8MBiHH1iNBgt93xYH4kPwKm87VH4gs4Ymd+9ymhQGezXBtkfOGBWqA
         Q9uVP5IPRpJUKIhRSZXqTy1YgWZILB3hkNHDal5018NULBnxOdQunGZd0WrpBeNyV5AO
         ykY2l9OzM9ldAOKCmTZnNUfyHRSMVxFhHiXo3GlvDS6iKwE2cB/RFWjxV+V0kIHIE9V9
         3vY+xHW4DeG1moJXi/U43Mzqn7LSusmI/FY3BzF++Nl2TMuHuDdoFonGcqUlxvtNeCNi
         Rd7g==
X-Gm-Message-State: ACrzQf3vN4C7tb9ibNSuiVPxsI9VBwr4Ez+HKpZPujVsZZKL8BV/oowi
        wenqQjwup9fo8z6IXn1QrDVKjb7qMA1y1ePj
X-Google-Smtp-Source: AMsMyM5RpVD7Dd6rxihjpP7o5A7T9y2fA+/yaJ7434+S9lNfE5OmV2Sq4MXL5kIx5M8cCZG7qsQV3it3RijX/V/8
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:f7c4:b0:182:25d6:fc4b with SMTP
 id h4-20020a170902f7c400b0018225d6fc4bmr9159160plw.63.1665448446858; Mon, 10
 Oct 2022 17:34:06 -0700 (PDT)
Date:   Tue, 11 Oct 2022 00:33:59 +0000
In-Reply-To: <20221011003359.3475263-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20221011003359.3475263-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011003359.3475263-3-yosryahmed@google.com>
Subject: [PATCH v2 2/2] bpf: cgroup_iter: support cgroup1 using cgroup fd
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use cgroup_v1v2_get_from_fd() in cgroup_iter to support attaching to
both cgroup v1 and v2 using fds.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/bpf/cgroup_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 0d200a993489..9fcf09f2ef00 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -196,7 +196,7 @@ static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
 		return -EINVAL;
 
 	if (fd)
-		cgrp = cgroup_get_from_fd(fd);
+		cgrp = cgroup_v1v2_get_from_fd(fd);
 	else if (id)
 		cgrp = cgroup_get_from_id(id);
 	else /* walk the entire hierarchy by default. */
-- 
2.38.0.rc1.362.ged0d419d3c-goog

