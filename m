Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CF55B3CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiIIQML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiIIQMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:12:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F2811E6C7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:12:00 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id iw17so2282873plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=eDrfYVwDQC+B+QpEvQ41UIS7OrQEnld5CNSxZdpZPgA=;
        b=F0wkqBGJL1xYRFxmN2T75z4AIhNt1UbmivRoZwZ3KboiF5oDQtO7ium3Kzq9dCV+3L
         RP2ICzUpgzxqrq8hUXPMY0eGLmRwA+zAdDYSuZh9GUeWrGuwZqUh08H8pA77P9iEsPGp
         b6pnj6Rb9wFZ+c+JdoNtMdcrNCB7NeeWChdxumtbo3jnTMvn/m+9Yh9o+8/jqU14NYlo
         Uq/uY6XTV/gnfIa8IZ92OH+bqS6ePdD+EGQoRQq+nYue9IGW4Px3jClughrHNWAxX7uT
         XPnuvp8oyCH45KSg9104v6Oi+FYeivUUTm11neuKW+KDrm0old9h/hl2dytqCvmymdak
         rzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eDrfYVwDQC+B+QpEvQ41UIS7OrQEnld5CNSxZdpZPgA=;
        b=lKPUrpNPQ8lao1ATlrcQeW6CazEPoPv0PHg1ubK1/ZGiPcK9XwtemSXrBBkPdm8CPX
         /pRUnDv0I7flU8ErnZdL93ivUlYedhoPgue75L4p+cUJY2LzBh/9rW+r0Roi6TlLsAw4
         vMhvnZHCXqrH5OYRQFd9p8yr9YdVBFzJOviz+aghcyypjNbGMIhVYMYF2+QVJ0dsXVuq
         5/V43Zt3mTf3a/qW9hpgma2GR0N7fLAq9fpfuVHrJ0KxP9a1WMFGFhiNcW/PcgOtK09Q
         aKs6j1Y9Eyh4h25uH95Zl5uAj9aR1IPl/ZcCJqoTVDUKPog5PKzi0f3DLiKNc2BlJof2
         MrHA==
X-Gm-Message-State: ACgBeo0AJ27u2gGnp7bLD76i6xfnKG+o9nN4/gFLOLpc+VX+Mkx4Z35O
        sDa3gLWJ56YWAR2NGVgkrBsFTVEHIwwa1eFwf4G6tQ==
X-Google-Smtp-Source: AA6agR6o1k8OYU6c3VZsjtmoi4GU+j620+63W9MswFegv3cf067xiW0Q2ntmP7g7tJsYUNwDAHlv3rflaFDJncKmQIQ=
X-Received: by 2002:a17:902:b410:b0:172:c9d1:7501 with SMTP id
 x16-20020a170902b41000b00172c9d17501mr14547983plr.106.1662739919860; Fri, 09
 Sep 2022 09:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220907043537.3457014-1-shakeelb@google.com> <20220907043537.3457014-2-shakeelb@google.com>
 <YxqIQOWzrsrPnff3@blackbook>
In-Reply-To: <YxqIQOWzrsrPnff3@blackbook>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 9 Sep 2022 09:11:48 -0700
Message-ID: <CALvZod77qUb0XRJh3y3-GQevoKjcwdt-Gtq0u0Tp6zTxBe-4CA@mail.gmail.com>
Subject: Re: [PATCH 1/3] memcg: extract memcg_vmstats from struct mem_cgroup
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 5:26 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hi.
>
> On Wed, Sep 07, 2022 at 04:35:35AM +0000, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > This is a preparatory patch to reduce the memory overhead of memory
> > cgroup. The struct memcg_vmstats is the largest object embedded into th=
e
> > struct mem_cgroup.
> > This patch extracts struct memcg_vmstats from struct
> > mem_cgroup to ease the following patches in reducing the size of struct
> > memcg_vmstats.
>
> Is the reason for the extraction just moving things away from the header
> file?
> Or is the separate allocation+indirection somehow beneficial wrt, e.g.
> fragmentation?
>

The main reason was to move away from the head file. I have not yet
measured the performance impact of these changes. I am planning to
rearrange struct mem_cgroup and will do some performance tests after
that.
