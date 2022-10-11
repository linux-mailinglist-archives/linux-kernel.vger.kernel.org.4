Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1703E5FA956
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJKAeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJKAeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:34:05 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27385E654
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:34:03 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id j3-20020a170902da8300b001782a6fbc87so8688534plx.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5MPkIEvXfnmsvTKOk4MDlNi99CiZEm9rCw/f8+9aBJE=;
        b=mWfPotsftp8geA/L8mN84Y3UjYw9VeNIycJIvsZyy5yDxqJzmCwGBb9gaWdJV61voB
         JNWi/dHUJ/RKSzdweI2aUtBeEA+hnuFilAe+ELgKi/1CDGO4GXwIWUgcOkpdDmSZmgYl
         S+X4BhUfpqX/yE7TDRp17TnlXuDPRpO6dv2MjS/WXn/JvLIhp+pYDO3Nxx0fz/B6YiMB
         EhiVkK0IGiVr8h1wl1gyzrcd9vj2+d1meBbENrZruSwWxcfYRDhbE+atKn/PT9AUkTHS
         SexkE8P88iGSv/ALoOaI5BRuHiTcO+mFd2hM7eBBwp+Ciop7u/rpi8M7PIC1eIMl8mx3
         Rc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5MPkIEvXfnmsvTKOk4MDlNi99CiZEm9rCw/f8+9aBJE=;
        b=35oxouLbKU528C53J6l3rxC55/Jxrpr3hBueUmZCUmQ3QSh5zhKvTvSn3HFXBq3h4L
         9Jha+4bW8jdbDk502kd5l+iQrcVzcXDEzuFfqloqKaEHecd6X3B8hVVU/RFsQcCcyods
         sxa8NBfXmOAGVkAXOSVhYouXcyKkIZSDB8VNRzIZUn0MWEqCl8sKGqD6zmknimIIkCDX
         IMmmU3l/Vd7qZO47H903EDYLspajXlJJqjNUSUgGIuDC0x/rNMWGlTzokrucMkBCLPoi
         ADNHY/jUDAYB1gSm8R2wfiI9Ejqgh+P921RHNy1vzJL640ioWRESYP3N2J+jfEmZ9ge3
         HABg==
X-Gm-Message-State: ACrzQf0OriIG+r3Hj4XZSZQcTC/sX6Sc+98eFTTzSSYe8X5Jwz1i70Px
        5ZTHq8u4dYyPXQcxCKuDlkOpuh4QhQsQEbeF
X-Google-Smtp-Source: AMsMyM4QFBGQgUznaQr2S32wyYd+1Hsenx4QK/4WsS26ZTXlJavII8lp5J2j9Pml6McLrp59PKOfLg4eheXjYocB
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:3d85:b0:20c:8f6a:8298 with SMTP
 id pq5-20020a17090b3d8500b0020c8f6a8298mr17153378pjb.242.1665448443479; Mon,
 10 Oct 2022 17:34:03 -0700 (PDT)
Date:   Tue, 11 Oct 2022 00:33:57 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221011003359.3475263-1-yosryahmed@google.com>
Subject: [PATCH v2 0/2] Support cgroup1 in get from fd/file interfaces
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

commit f3a2aebdd6fb ("cgroup: enable cgroup_get_from_file() on cgroup1")
enabled using cgroup_get_from_file() and cgroup_get_from_fd() on
cgroup1, to enable bpf cgroup_iter to attach to cgroup1.

Apparently, other callers depended on these functions only supporting
cgroup2, so f3a2aebdd6 was reverted. Instead, add new separate interfaces
that support both cgroup1 and cgroup2 and use them in bpf cgroup_iter.

Yosry Ahmed (2):
  cgroup: add cgroup_v1v2_get_from_[fd/file]()
  bpf: cgroup_iter: support cgroup1 using cgroup fd

 include/linux/cgroup.h   |  1 +
 kernel/bpf/cgroup_iter.c |  2 +-
 kernel/cgroup/cgroup.c   | 50 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 46 insertions(+), 7 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

