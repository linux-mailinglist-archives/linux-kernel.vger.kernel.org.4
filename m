Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF8166B460
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 23:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjAOWrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjAOWrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 17:47:33 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014471B57D
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 14:47:32 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id n190so23569342vsc.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 14:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g9a9lt8imHWrU+aXyiCvzH9wJ7qwkvw7ijcrlz3p08E=;
        b=L8op4Oh3wmW7ZO1rKWQ+9oiUo2ArZN5aVXCeZ+J1MeT0cUpNaG8QshC1aYRCHaJJNV
         kF1lJOk0q5CzNuoTHP0QGJfrmiDH4t6lc5xbcCpOvc2WsCSTcZ87zXjgT2MRhPPY1Isl
         G2js3JIo5HBwSU0gCfyjjZHO0tThNK/l2pk63ggbL24wvyd/yHiYVTuCrm/y12atEbrA
         f3rISqiZ0oQadioZZXRn2NeS7P+frMkBiojt8iOoJl5ba6X3rUD2smXK1kDYSl5vsZ4u
         tB7AE7YKt/xWQUXi/eqGJ5raiyQzPPAwwij1Be/g4uRVClbzg8J/b8ehfWW0TBlFo0e+
         /Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9a9lt8imHWrU+aXyiCvzH9wJ7qwkvw7ijcrlz3p08E=;
        b=yvzzMaFTytCL7w2Ks3Sd2hMOgjvyZmY1X2SzcH8zyiJrqzady2mB4eSxR15tcVj+Wf
         Vg/5HuOcihXhtLv7vEGcaNUNpyDqajeuStFHk0R7dBvmrxbLOdvIeoXEsiAwJmhvBQYO
         acCZuOd/gqn7jjHlVdMgPUMReXLsZYWey3RBqvVTnvAGcZlmDD1lDOaqA0QpHOxzSN/1
         UzzoXwPVK/ZWCuaSQewmiMjanaRKgfbg1Ot3zWe3qVeS9IWuLAHwbxnMwe3rFlLIIwli
         JarzfKnyaY8tHyZyozQSd/8B2WFTgpYVMhOf2FTv7HZ2Fn8yEHf+EJuapyNP/ybGNiGY
         IkTA==
X-Gm-Message-State: AFqh2krfw5OPMgV04H67oETNdWdXjl63+ikgLFtY8V2hLZv27XF3q8cV
        jWLocmWNMiw1OxlCvakYHO3ldoBlH9iF+Y6yGglnPnaxgqq3F/1Y
X-Google-Smtp-Source: AMrXdXs9tpPi/AiQ6QDHqwZXQfSgKKuD571+YoEAfOfDUgjKp3YXxjxdt0+d3eXQA6dJXIBaxWnX23laTjOzSZoO8aQ=
X-Received: by 2002:a05:6102:40b:b0:3d3:db6b:e761 with SMTP id
 d11-20020a056102040b00b003d3db6be761mr79727vsq.46.1673822851026; Sun, 15 Jan
 2023 14:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20230115125721.3553-1-tjytimi@163.com>
In-Reply-To: <20230115125721.3553-1-tjytimi@163.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 15 Jan 2023 15:46:54 -0700
Message-ID: <CAOUHufaSajkrrkZKx+htAA3gORhB1dEO98=jOT_tzQ9HjUxvhw@mail.gmail.com>
Subject: Re: [PATCH v1] mm: multi-gen LRU: reduce repeated scans in rmap
To:     Jinyu Tang <tjytimi@163.com>
Cc:     yuanchu@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, falcon@tinylab.org,
        ttjjyystupid@163.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 5:57 AM Jinyu Tang <tjytimi@163.com> wrote:
>
> The folio is physically and virtually contiguous. If a folio have
> more than one pages, lru_gen_look_around() will run several times in
> the while loop in folio_referenced_one(), but most of times is
> unnecessary. Because these pages always belong to the same pmd and
> vma, lru_gen_look_around() will scan the same range.

Thanks -- the commit message is quite clear, so I think I understand
what you're thinking.

Let me clarify:
1. First of all, there are no repeated scans, because after
lru_gen_look_around() clears the A-bit in a range, the pte_young()
test stops it from going into the same range again.
2. Of course, pte_young() can become true later, but this is not a
problem because it's cache hot.
3. Physically and virtually contiguous mapping existed before folios:
a THP can be mapped by 512 PTEs.

>         while (page_vma_mapped_walk(&pvmw)) {
>                 address = pvmw.address;
> @@ -825,7 +826,13 @@ static bool folio_referenced_one(struct folio *folio,
>                 if (pvmw.pte) {
>                         if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
>                             !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
> -                               lru_gen_look_around(&pvmw);
> +                               unsigned long pmd_now = pvmw.address & PMD_MASK;
> +                               unsigned long pmd_former = former_address & PMD_MASK;
> +
> +                               if ((!former_address) || (pmd_now != pmd_former)) {
> +                                       lru_gen_look_around(&pvmw);
> +                                       former_address = pvmw.address;
> +                               }
>                                 referenced++;
>                         }
