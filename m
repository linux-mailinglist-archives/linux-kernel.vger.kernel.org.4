Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8BC745FD3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjGCP1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjGCP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:27:22 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F776E58
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:27:21 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-57026f4bccaso55471757b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 08:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688398040; x=1690990040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB8k7kzs7pjh91ZHMLl100x28+Nou3C86dk3f4fXFw8=;
        b=FbRPMlnUUQ0KJlxPTp1Akvy0wGc+FN2SBdB/wkaqk1dL2eUdwA5Ks9merWRmm6t4eU
         YzJXoaMuDUeccl4n7fULsEtJ/MdFyTvYmpbeY9sGQYSPhLcZ1eMRLkGJvECDoZorSiVG
         pz1pDjrSCl7NtgobNEPhL1buvimKffGF5y/tnO+H66sln4C22AOL8blHMFLl1wTle58F
         j+YL1xktM/NJtvYYWYq195AJ6jqN3veWIGuL5gA3V0g8lv3Hnlfy4yJDUTjQigcmGvPZ
         b+DQRMxLO9aFvzgyohuo033dVk5gsbyUHGGjFOkWb2TYlP43zIW8rmQJ364g7PfDY4qV
         zQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688398040; x=1690990040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vB8k7kzs7pjh91ZHMLl100x28+Nou3C86dk3f4fXFw8=;
        b=bidKpJAa3unMsS6xIXZ+nKagCl/ZtgzP70q6I7a/5/JqoukRTRWA0aCzDwtMyKG50I
         qRGqJG2oQ+B9P8WOaLUflppuCtJd0u7o3H019ZfPflETpnVUQGK2wCR+uhnd2lNLsHSC
         dnUD/TaqrSoUEpxogcfXPG2Xxwm2ajkrcbjc2txxbbqVqpNBJSaNUE2IrCcVVoeFRK4I
         3OJ5z/ZgiteOy13AIchZIplBRAAObQfr3kg7qqK2fAY1LcbPrN1XfuFj4nU1GqD6Halj
         fP0EBeppXMfQie6weQ/Nt7LEJ7ND1yuK3j5EJC7s5belCV4XIpclwpSfnaj0LSbH8Lnt
         zN7Q==
X-Gm-Message-State: ABy/qLZlLfuKR4tDGmye9P8+HZt8Pds5x62vLsnKIY/jlJG8Pi9Gbw5n
        VXVNotWyF+ajc4fzC/LcphfWNgeOXTGv4ZZSukHgrw==
X-Google-Smtp-Source: APBJJlEm3pwO1G8LhaV06AkpzQLVkMoXEfWuwosTjW1Qlp15+LHR8XDJVWoHyyqjaffw3LoZM9R1mjBUJMqWyDO++Eg=
X-Received: by 2002:a81:7c8b:0:b0:577:3adb:cf08 with SMTP id
 x133-20020a817c8b000000b005773adbcf08mr10119135ywc.27.1688398040554; Mon, 03
 Jul 2023 08:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com> <20230702105038.5d0f729109d329013af4caa3@linux-foundation.org>
In-Reply-To: <20230702105038.5d0f729109d329013af4caa3@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 3 Jul 2023 15:27:09 +0000
Message-ID: <CAJuCfpH0ki9ftJzn1fTXYJWc6pwv0Mi-QW4X56HruGAJp0V5Bw@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Sun, Jul 2, 2023 at 5:50=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri, 30 Jun 2023 14:19:51 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > When per-VMA locks were introduced in [1] several types of page faults
> > would still fall back to mmap_lock to keep the patchset simple. Among t=
hem
> > are swap and userfault pages. The main reason for skipping those cases =
was
> > the fact that mmap_lock could be dropped while handling these faults an=
d
> > that required additional logic to be implemented.
> > Implement the mechanism to allow per-VMA locks to be dropped for these
> > cases.
> > First, change handle_mm_fault to drop per-VMA locks when returning
> > VM_FAULT_RETRY or VM_FAULT_COMPLETED to be consistent with the way
> > mmap_lock is handled. Then change folio_lock_or_retry to accept vm_faul=
t
> > and return vm_fault_t which simplifies later patches. Finally allow swa=
p
> > and uffd page faults to be handled under per-VMA locks by dropping per-=
VMA
> > and retrying, the same way it's done under mmap_lock.
> > Naturally, once VMA lock is dropped that VMA should be assumed unstable
> > and can't be used.
>
> Is there any measurable performance benefit from this?

Good point. I haven't measured it but assume it will have the same
effect as for other page fault cases handled under per-VMA locks
(mmap_lock contention reduction). I'll try to create a test to measure
the effects.
Thanks,
Suren.
