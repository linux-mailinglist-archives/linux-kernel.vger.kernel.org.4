Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5DE640B4F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiLBQyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiLBQyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:54:32 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A28AD2908
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:54:32 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id m9-20020a63ed49000000b00477f449365fso5017146pgk.15
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4be2lHBFg2WCV6qZhgqwvxIUVEumxynCQKUkXCdxvk=;
        b=Px9L2aZyxN7M0m1j6cdE9wvoe9DlFFr6V9pBMfV6Qe74oU94DfmBzQjiJmFm/Z7NdA
         Se2GV/J+ZGJU5J3AHKBzHWHYPyKtEVTHW7xJHtfxhcuT3vj4NMuZx+1ysp687XHlqYP7
         supnwsh3llnyikXrpRbKZN8wVwla+4zgByrdGSg2mkBwwuuBP0N9o/hTZwf/nK1+f67A
         54GJE/cPumSBO4Tw18cFvAf8DHpNKpGQQzCjhSoLPb+M4VpMT4xlXI2arVfCcpVaX0mI
         Q4Lm3DoIJ1cUfPVJVF4AWRMpB/bhrO0Ia5NvbQWj4Gb4hvv/AxNACUS4v38qXx6I9cvg
         0sWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4be2lHBFg2WCV6qZhgqwvxIUVEumxynCQKUkXCdxvk=;
        b=dJ2FPqgP1mOSUjTnZDdCv9OyiL4EEl9JW+EH8+IgWKiJpr6ZUeW6cwD9shyR5Pa4Y2
         6eV+Dy3QVnh/zI5X/4ptw4814U6YGjgIIZ31v/bhi5PKPFn06IxGB/PxgOxBbsP6wZGf
         aq361+TiBJqssasNyFnAsWUwKq98OfMHgRsYwjTRXRS4yxpREFFlvs30OikqcL6TA3jw
         nomYAul0ajWOGUpPA0Z1eAsTWw3mYo8VLACV1U/lsovGVWazl+x+n6FSyl/Vk4gwzgT7
         sSTyJa11NYtS7e3cT7q0ejUaFbPLspmgSWW3KCH54TDcCT2Dn7b+INWhnWt+Fvu1Ha3h
         8ocQ==
X-Gm-Message-State: ANoB5pn96MaNLXNIpTPbqrqa0RWYk1WFKcUSCR1YspN2gYglkUdvRqq4
        r4i7D4nuwzoVh3Vq3LweqggFffb44rvs5Q==
X-Google-Smtp-Source: AA0mqf6c1yIvU/EpzrCsHwOdXo3r7WkG7BPirYqhfsBkw5h+T5ol09HKzMFFE8uOis8dykdyKCnHE3oVns74yw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:d086:b0:219:227d:d91f with SMTP
 id k6-20020a17090ad08600b00219227dd91fmr3265907pju.0.1670000071361; Fri, 02
 Dec 2022 08:54:31 -0800 (PST)
Date:   Fri, 2 Dec 2022 16:54:29 +0000
In-Reply-To: <Y4m8Unt6FhWKC6IH@dhcp22.suse.cz>
Mime-Version: 1.0
References: <202212010958.c1053bd3-yujie.liu@intel.com> <Y4m8Unt6FhWKC6IH@dhcp22.suse.cz>
Message-ID: <20221202165429.wapfvrgw5mp7cz5h@google.com>
Subject: Re: [PATCH] kselftests: cgroup: update kmem test precision tolerance
From:   Shakeel Butt <shakeelb@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     kernel test robot <yujie.liu@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Eric Dumazet <edumazet@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 09:50:26AM +0100, Michal Hocko wrote:
> OK, so this is a full patch to fix this
> --- 
> From 7f338ed952ba4a100822004bc8399bf720b42899 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Fri, 2 Dec 2022 09:45:29 +0100
> Subject: [PATCH] kselftests: cgroup: update kmem test precision tolerance
> 
> 1813e51eece0 ("memcg: increase MEMCG_CHARGE_BATCH to 64") has changed
> the batch size while this test case has been left behind. This has led
> to a test failure reported by test bot:
> not ok 2 selftests: cgroup: test_kmem # exit=1
> 
> Update the tolerance for the pcp charges to reflect the
> MEMCG_CHARGE_BATCH change to fix this.
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202212010958.c1053bd3-yujie.liu@intel.com
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
