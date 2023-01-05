Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0557D65E2FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 03:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjAECkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 21:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAECkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:40:06 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21DA33D61
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 18:40:04 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id t15so38707095ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 18:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jivoQc2woQPramQotU+YPnz3UFl237gizCTwDukUUbs=;
        b=ry6suVAFcuV/DnG/4idnIZfAPuKPQ814PqIiXu4P9Dc0MqkOjn0AKKk820/uGfrUa4
         lYwBTXdKbMtJyJeF8Ansqm8CL+ioyemnqP7I0HIMJDMeNNvW5OkB/7csT/ZisXRX+hSG
         +xaYAICRVp8lGySMbU1YrmfONyu/oWVeM0g2dEjdj2EJ0vtoWtZ+dBlHHW+ovYV5+A/4
         u/+n5dwUWeC7ny6NKjanbvD9uZqm1WFbbKtRzlbOAluksAH8C1eNjA6bkLInkPF4dzur
         4P4KjPGT4iFWD4jOYbwIUtKhb5uTakvk3xr0SD9BWQKSxh3lg5fnOsZPBMgMoJii2E4P
         qTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jivoQc2woQPramQotU+YPnz3UFl237gizCTwDukUUbs=;
        b=3h6tgxfT2IbQMK9OhmFvlSjkAOWtacxDmWM6AmqTGC3qQPg+IMCvaRm4YgWyvXCZte
         JO/zEDI9kpXNpYE9BL6SIbJRaEEx8sbnIFeNvyXiyFl5zGA1TjhQ8C+MkO+M17TiJti4
         7P+segZncVlHEmjxVyMdeRwwRTdnt9MJI+5pyJbSUoj9Dn1bi9REct5/levEKDCxu3x4
         YCgNcYKoJPmD0aTIgq7mr5SoNsju7Kk9c0bpuZCnxf/j0xTWG9P5SjOrDJUBZm0GgYZo
         nydbvRX/nbjtfR3x/1SpSLcFL+xwft4KVU7/g6lsv664DzgQ74EfsFGMFKRbNL9dLXLb
         XJLw==
X-Gm-Message-State: AFqh2kqrW55F98LVsRB4EQgmSig3hyH/VlJGGTbvcryII8HHlkiQ8FQt
        uh1D2XlweW5FurYS7cGSxDXbxvsManFPHMhOIu0/kQ==
X-Google-Smtp-Source: AMrXdXtGu2OExyoviE5XN80kc7xrpXydmX05/zdQc8IHa1Nqz9/qzpMXh6LqML/0BnJ5IO2liAQbKdowK5tGlGPIrnE=
X-Received: by 2002:a25:abb1:0:b0:701:c58:f01e with SMTP id
 v46-20020a25abb1000000b007010c58f01emr4405036ybi.59.1672886403930; Wed, 04
 Jan 2023 18:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20230105000241.1450843-1-surenb@google.com> <20230104173855.48e8734a25c08d7d7587d508@linux-foundation.org>
In-Reply-To: <20230104173855.48e8734a25c08d7d7587d508@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 4 Jan 2023 18:39:52 -0800
Message-ID: <CAJuCfpGHMeWSSp+ge3pPppLrQ5BpGiga=fjKmDk65GTjFDV=3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hughd@google.com, hannes@cmpxchg.org, david@redhat.com,
        vincent.whitchurch@axis.com, seanjc@google.com, rppt@kernel.org,
        shy828301@gmail.com, pasha.tatashin@soleen.com,
        paul.gortmaker@windriver.com, peterx@redhat.com, vbabka@suse.cz,
        Liam.Howlett@oracle.com, ccross@google.com, willy@infradead.org,
        arnd@arndb.de, cgel.zte@gmail.com, yuzhao@google.com,
        bagasdotme@gmail.com, suleiman@google.com, steven@liquorix.net,
        heftig@archlinux.org, cuigaosheng1@huawei.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
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

On Wed, Jan 4, 2023 at 5:38 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  4 Jan 2023 16:02:40 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > free_anon_vma_name() is missing a check for anonymous shmem VMA which
> > leads to a memory leak due to refcount not being dropped.  Fix this by
> > calling anon_vma_name_put() unconditionally. It will free vma->anon_name
> > whenever it's non-NULL.
> >
> > Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
>
> A cc:stable is appropriate here, yes?

Hmm. The patch we are fixing here was merged in 6.2-rc1. Should I CC
stable to fix the previous -rc branch?
