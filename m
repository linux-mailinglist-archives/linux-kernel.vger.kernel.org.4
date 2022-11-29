Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FA063C6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiK2Rtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbiK2Rti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:49:38 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E1168C5C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:49:37 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b21so14145137plc.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hl3DPINmZ1T1XtdjVjeWIBcpMDsqsxiqkNjkViEje6g=;
        b=S2O6hUY5rTSZmVMXYryt5ZPXz7UTn/t8d0ZpVZ/P7PSEnElhd2Gb9JCwr5oRUL2n+b
         eska0zL51J7KzNay8y03JpZRAT4X7FXicBAu1rV9/El1Pln8vAnHHisgagi3GkOYDrOA
         VqptbHTlmJZjIIlwNMkVe/Alh1rHgNBu+d0LdvJ8LKsk+CQvitgJRwyXy4RylfE2zY4T
         EYifWdhLXJQ+2K90zbyogJcbW4QeKTkk/ekQz6cjXY6yWzU6wpuOaGyzKq+zVG4+0AvJ
         XYDeopFJoNC9Zc8whw59rhzseZ8CTkW6iwj6kCqvwURac6yuFPZJBbwR5Z7WDPSGWey1
         vIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hl3DPINmZ1T1XtdjVjeWIBcpMDsqsxiqkNjkViEje6g=;
        b=gKE94CVLPvyWfcTW5Rub6jCvdPJwvUHiem6LVIZauCTX7QfXndmL91x5UNkT1oBupi
         mxsA9ymVZguYahTiQaRSKNGWXBugMm9JqsumoOu4GZFJ5BHkLFTZWAovPLKfLgL/saFI
         H6Bs3gdVmlxhHs/P9l1XEus5L1gjW/NkTxMfB8dypeVS5aBke60c0QuuQwc/PIE4A3oq
         rBbcmreV7vC+F2pOdVLBoveMYiLXBz9xPvj15hDVSgbQMNBgTJy1YwgRMrTA45TYFmUH
         Uu7x7AlPj2vlBCz+HkHzW1lCbrsi0vt7UQ1qoyaMpQACNhy3I4I+l7ch2qemtjHcuivJ
         ZMkA==
X-Gm-Message-State: ANoB5pmEsdE19EtqlvC3Ty1Iy5jtdyQIM4TwgUmxBU6jaW1FnYYBDbvz
        c9ZgcOV/37ZOcE83gWNIooE6dUePW+qMYQTGsqY=
X-Google-Smtp-Source: AA0mqf7wCQceOB0kuyg1U5MwVqL/zsBXkVIhotZcQN/YuYIJXc0ZmSPqoVm5XCdXCWf8N24AFml7WGTsl0ArZBjEgPM=
X-Received: by 2002:a17:90a:4889:b0:20d:d531:97cc with SMTP id
 b9-20020a17090a488900b0020dd53197ccmr62168749pjh.164.1669744177387; Tue, 29
 Nov 2022 09:49:37 -0800 (PST)
MIME-Version: 1.0
References: <8a2f2644-71d0-05d7-49d8-878aafa99652@huawei.com>
 <CAHbLzkr-eXk8gateN=EmMoBuW3wxoQKTCfJcTRQsQX3QxD+CmA@mail.gmail.com> <Y4W+joR1rIug0ydA@dhcp22.suse.cz>
In-Reply-To: <Y4W+joR1rIug0ydA@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 29 Nov 2022 09:49:25 -0800
Message-ID: <CAHbLzkpZWp4-XfSpXw86UokPuXSMPRg1UWfgpjL=FixjBr6sFw@mail.gmail.com>
Subject: Re: [QUESTION] memcg page_counter seems broken in MADV_DONTNEED with
 THP enabled
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yongqiang Liu <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        aarcange@redhat.com, hughd@google.com, mgorman@suse.de,
        cl@gentwo.org, zokeefe@google.com, rientjes@google.com,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>,
        kirill.shutemov@linux.intel.com, Lu Jialin <lujialin4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 12:10 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 28-11-22 12:01:37, Yang Shi wrote:
> > On Sat, Nov 26, 2022 at 5:10 AM Yongqiang Liu <liuyongqiang13@huawei.com> wrote:
> > >
> > > Hi,
> > >
> > > We use mm_counter to how much a process physical memory used. Meanwhile,
> > > page_counter of a memcg is used to count how much a cgroup physical
> > > memory used.
> > > If a cgroup only contains a process, they looks almost the same. But with
> > > THP enabled, sometimes memory.usage_in_bytes in memcg may be twice or
> > > more than rss
> > > in proc/[pid]/smaps_rollup as follow:
> [...]
> > > node_page_stat which shows in meminfo was also decreased. the
> > > __split_huge_pmd
> > > seems free no physical memory unless the total THP was free.I am
> > > confused which
> > > one is the true physical memory used of a process.
> >
> > This should be caused by the deferred split of THP. When MADV_DONTNEED
> > is called on the partial of the map, the huge PMD is split, but the
> > THP itself will not be split until the memory pressure is hit (global
> > or memcg limit). So the unmapped sub pages are actually not freed
> > until that point. So the mm counter is decreased due to the zapping
> > but the physical pages are not actually freed then uncharged from
> > memcg.
>
> Yes, and this is not really bound to THP. Consider a page cache. It can
> be accessed via syscalls when it doesn't correspondent to rss at all
> while it is still charged to a memcg. Or it can be mapped and then later
> unmapped so it disappear from rss while it is still charged until it
> gets reclaimed by the memory pressure. Or it can be an in-memory object
> that is not bound to any process life time (e.g. tmpfs). Or it can be a
> kernel memory charged to a memcg which is not covered by rss because it
> is either not mapped or it is unknown to rss counters.

Yes, good points. Thanks, Michal. And one more thing worth mentioning
is that the RSS shown by ps or smaps is different from the RSS shown
by memcg.

> --
> Michal Hocko
> SUSE Labs
