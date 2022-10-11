Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC22D5FA8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 01:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJJX6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 19:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJJX6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 19:58:14 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E637FE6D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:58:13 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x13-20020a170902ec8d00b00177f0fa642cso8774252plg.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=32G3k93Ulqw+bBT8wloqCvMkNp9uoyXmylHiGN2Ypxc=;
        b=LcWt5IjwCcy3rAad+wx5DSEJeu4bbnR1UwRvydSMhWPJLCVVIhiV3sdwaiTUIjBUbt
         AwITg2e81qFFFEtOCWDrKdow2ER0lA/l4S/JNM2JP+v0ZWrdG39lvd8rPH1dfn6TZQQu
         76My+esp98qhz7FQrF8bxlLcyRAHtUNelF+oJHIqMQ7/1JlULihRngFRjGq+CsdrC7JL
         pyc2BCkq7cxAxQCd3YlkgYqYXYOKvydwutn/bGtBWCJYKOCmNo8ywgrQenJoHqDDJrLW
         ciqwgnPm2h+kpnsB/B33ihE6QHIppIccsEQAkr1f8JnZ/6aJ28iETmFw9Ei0RjxuUfiF
         e5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=32G3k93Ulqw+bBT8wloqCvMkNp9uoyXmylHiGN2Ypxc=;
        b=K731FZL0/DGQVpq7PMbfekN3yfbJWMKNFQj0Y3mSgM8dKJc2e05m7Q6bi4jj+8Z+wA
         zWZdV6DRtE8kyYShUxj8GJ9Up2xjh9Z1uo8ap4GrMuFXsbEV6c0yVB0X7Wfh+9Nf56Ea
         jiE+dAk+pCU3gOdWZi1VGaKzVxVMBWYIqLUm4Sz1g0OqoqfjAlBbe8FG3fQ+2QAMB82a
         vmdWK3yp8XodTjXb4PVfDRnSYaeBDmmqzILL6uzv32d8f/VqI+cidmNUZ/55bmjd8UEE
         /GoePJ+7zGPnxL9r1bCfrrm+CFUuW23jbjL3XHkXZj/ENVaUukCsy85r+KooZGu8jdNr
         8Zdg==
X-Gm-Message-State: ACrzQf2iO0db07Gk0umI6eCAlQ8STD2fHiGzgWr4e3NgzqPqGMwwcDvY
        nxhn8ovSn4DX+aMZY4uZfPogIqjiRK0SZnay
X-Google-Smtp-Source: AMsMyM6Jw40l0u70IlwQVdch68V4JzwL6jSidvy3rtHMdUOo0co1MMkUBYniXw4/pl9AI7Fy/6+g0Wd38ANIIk53
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:cd06:b0:203:ae0e:6a21 with SMTP
 id d6-20020a17090acd0600b00203ae0e6a21mr1888481pju.0.1665446292568; Mon, 10
 Oct 2022 16:58:12 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:58:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010235802.3378436-1-yosryahmed@google.com>
Subject: [PATCH v1 0/3] Fix cgroup1 support in get from fd/file interfaces
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

commit f3a2aebdd6fb ("cgroup: enable cgroup_get_from_file() on cgroup1")
enabled using cgroup_get_from_file() and cgroup_get_from_fd() on
cgroup1, to enable bpf cgroup_iter to attach to cgroup1.

Apparently, other callers depended on these functions only supporting
cgroup2. Revert f3a2aebdd6 and add new separate interfaces that support
both cgroup1 and cgroup2.

Yosry Ahmed (3):
  Revert "cgroup: enable cgroup_get_from_file() on cgroup1"
  cgroup: add cgroup_all_get_from_[fd/file]()
  bpf: cgroup_iter: support cgroup1 using cgroup fd

 include/linux/cgroup.h   |  1 +
 kernel/bpf/cgroup_iter.c |  2 +-
 kernel/cgroup/cgroup.c   | 55 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 51 insertions(+), 7 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

