Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C5B68864F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjBBSYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBBSYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:24:21 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871535EFBD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:24:20 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 74so3072669ybl.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s9NS8aTMNXwzeLlthekcCZHp7SQir7/xZefiPP7egKI=;
        b=ZPrIb7wo+lofZV5pa5YbET3hAij+R6gpmGf56bGzIiJJZm+b1Ydw+1BC5EDCg2BRow
         DbYAkHwSC6cnMronH3NtmDtuswD6tOv1DfX+TKKrEx03PJQaXqg/IZx3QuurzljeH5mJ
         Dhw7d+sAJ5ylmkLJZLxFcgRhg9vpP/91oQdt5ywhgqHdD47r4rU36XdbzTm25eOxOI1f
         TjiMYRf3uyMJrt3faPsFxTFVo25AhVanE7TU8icH+qr8A38Aii6b39F4sPLQ0rIAhjka
         bOy1FLkVCcegtisV0H4khc5iWpFJyjpX0m35PRB5Fvo9nUMDpO+FxWF5rxT5xj2++t1n
         7qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9NS8aTMNXwzeLlthekcCZHp7SQir7/xZefiPP7egKI=;
        b=Ckvx5r8Kib/qGKQ+xaa5GpR5KfEEZuT2dKKs0HDhGewW+12lkIW7qCb2Lb2IUxNqhO
         EKlqLoD1KOlMzPn28Uy9G3G6bHLX+6i5Twx8ZLsDQpehAa5a5Wc2z6rNRPp3lyQYxM1F
         o3AAEO/ImgUHvslEW0yqlSVwbY9IAsA7UXCNNUHekmeNX0cPIxbcboHlG25fVaBREMQl
         a4AoXeIGC8XM4hLSSFkfSaHB0P0jHMifyQbvw88g2tzHJIJd20UoPyJGaE133yWaYNVD
         fVYQVS9+3bSr0nEpTVd/Yr+hQ18oFlGF2593unngk64kBCfMotivcss/B4o3K88UT1T3
         U5Iw==
X-Gm-Message-State: AO0yUKW+28a7flGs5imUo7RM1wcFVxm1psOv/eaIMGoG2+TsykbpVYIA
        Hj6XTWjDF72ap3d8YA9GO3ZG5gqusIACJx52UEG1Rg==
X-Google-Smtp-Source: AK7set8AggMm56FhRMju0xnLlIqmwLNBbTYCISFZ/w6URWQ+GAck8xfnfOOCoJEKrQU2oWewAHldfm04bzdjrW+WeRA=
X-Received: by 2002:a25:ae01:0:b0:7fb:feb3:3828 with SMTP id
 a1-20020a25ae01000000b007fbfeb33828mr1066702ybj.450.1675362259617; Thu, 02
 Feb 2023 10:24:19 -0800 (PST)
MIME-Version: 1.0
References: <1675312377-4782-1-git-send-email-zhaoyang.huang@unisoc.com> <Y9tz+0J9fw+Z+O+O@dhcp22.suse.cz>
In-Reply-To: <Y9tz+0J9fw+Z+O+O@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 2 Feb 2023 10:24:08 -0800
Message-ID: <CALvZod5E0s9Vu3wq-Fuvs9z=ViMADn3aNL0f56ELGmFzxKCtkg@mail.gmail.com>
Subject: Re: [PATCH] mm: introduce entrance for root_mem_cgroup's current
To:     Michal Hocko <mhocko@suse.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 2, 2023 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 02-02-23 12:32:57, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Introducing memory.root_current for the memory charges on root_mem_cgroup.
>
> Charges are not currently accounted for the root memcg universally. See
> try_charge which is used for all user space and skmem charges. I am not
> 100% sure about objcg based accounting because there is no explicit
> check for the root memcg but this might be hidden somewhere as well.

Yes in __get_obj_cgroup_from_memcg(). However the reason to use
try_charge_memcg() to bypass root check was to avoid the race with
reparenting. More details in c5c8b16b596e ("mm: memcontrol: fix
root_mem_cgroup charging").

>
> That means that the patch as is doesn't really provide and usable value.
> The root exemption has been removed in the past but that has been
> reverted due to a regression. See ce00a967377b ("mm: memcontrol: revert
> use of root_mem_cgroup res_counter") for more.
>

One advantage I can see is if someone is looking for usage for all top
containers (alive or zombie) but I wanted to know if that was the real
motivation behind the patch.
