Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA950670DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjAQXfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjAQXeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:34:31 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A1A22782
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:22:00 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4d0f843c417so327708217b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xtczcpnEdrb6Lo/I50tBUUcvRCWBMIoMko6b3VfQkh8=;
        b=AcMcOiO2z6ozFh44VpqFr7ezkcbEZnhi09Dbp343HQiIrdSXkgI50tblBtSXc4Qkbr
         Dm0aJ5OWtPIPe1vN3owVIfQugxfobInM08+GWcQC0Wl/sGleOffZOyKeiGBU66WnPH9X
         yGh7HPsaf3D37qff2nHLKSk9GB5gXj4/bJSoqoPygqkBfp0n5aCUJW1R2r1cGv48MYT9
         AF0QYZ+3MvoaJhRFmZkp/7b87hU6GOckZwAwfWDK+vU6aqzT+gjcR5kQJuyq+Vt1cTTM
         SPO3L3JDVl95dXMuhHrtNaPJurOeiaEkl6ib7er/Q0Jv+k3LnRbtNLzrD3OvrfjKSDHz
         HteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtczcpnEdrb6Lo/I50tBUUcvRCWBMIoMko6b3VfQkh8=;
        b=NYx4CjOABkOChRufeEVNXZEe1cUkPZCrIME8i3aNKSZXM4cNMSrby7HC/DBtkW2YFU
         g0jDEe8K45RMpqljwmSGfGUV/xgZM2O3kUP4Mr6h+sv889KjQqosS/7suR3/cj+iRVYr
         8cl17C3aCMJhMCA0N7D46smTV+t9l1YGNEw+TBoow7k1az/ka3Bxk094qig2J9PH/Vfw
         av901gdBUdKYwpdrSYrzl+BjixdtA1fwozvAsLsWSJAbses4P24MVhQ+gxUSAOB7Z3xA
         c8InycSHWPQ6vPHLtYVsRigqFSFgPog4SDl7zE+zMKbdTGy4fRYE9kzO86EPHYD2Za8g
         HSwQ==
X-Gm-Message-State: AFqh2kp/uPL85s8DcWU05IIRycUBMWh3MiK7H2Q64gupcOBvcmkb7WHp
        xMBc852ZAV8Oh/mpnTnRyIbX35ZCy9w1GoVOurqU5A==
X-Google-Smtp-Source: AMrXdXtePqeFLTDxDaGD0SiAwIlsFIJGXklyX1m/MZjPOlYrdLeSS6NZFiXQQ8abRq5qEH0JCgU5ZQh27jLTDLKC0bU=
X-Received: by 2002:a81:1d2:0:b0:433:f1c0:3f1c with SMTP id
 201-20020a8101d2000000b00433f1c03f1cmr623569ywb.438.1673990519331; Tue, 17
 Jan 2023 13:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-13-surenb@google.com>
 <Y8a4+bV1dYNAiUkD@dhcp22.suse.cz> <Y8a66gshQkkhC1cT@dhcp22.suse.cz>
In-Reply-To: <Y8a66gshQkkhC1cT@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 13:21:47 -0800
Message-ID: <CAJuCfpF2ciMbMFgqa4GqYqg8zjpnmBoNZDG23V0+w017LXeU3w@mail.gmail.com>
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Tue, Jan 17, 2023 at 7:12 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 17-01-23 16:04:26, Michal Hocko wrote:
> > On Mon 09-01-23 12:53:07, Suren Baghdasaryan wrote:
> > > Introduce a per-VMA rw_semaphore to be used during page fault handling
> > > instead of mmap_lock. Because there are cases when multiple VMAs need
> > > to be exclusively locked during VMA tree modifications, instead of the
> > > usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> > > exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> > > mmap_write_lock holder is done with all modifications and drops mmap_lock,
> > > it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> > > locked.
> >
> > I have to say I was struggling a bit with the above and only understood
> > what you mean by reading the patch several times. I would phrase it like
> > this (feel free to use if you consider this to be an improvement).
> >
> > Introduce a per-VMA rw_semaphore. The lock implementation relies on a
> > per-vma and per-mm sequence counters to note exclusive locking:
> >         - read lock - (implemented by vma_read_trylock) requires the the
> >           vma (vm_lock_seq) and mm (mm_lock_seq) sequence counters to
> >           differ. If they match then there must be a vma exclusive lock
> >           held somewhere.
> >         - read unlock - (implemented by vma_read_unlock) is a trivial
> >           vma->lock unlock.
> >         - write lock - (vma_write_lock) requires the mmap_lock to be
> >           held exclusively and the current mm counter is noted to the vma
> >           side. This will allow multiple vmas to be locked under a single
> >           mmap_lock write lock (e.g. during vma merging). The vma counter
> >           is modified under exclusive vma lock.
>
> Didn't realize one more thing.
>             Unlike standard write lock this implementation allows to be
>             called multiple times under a single mmap_lock. In a sense
>             it is more of mark_vma_potentially_modified than a lock.

In the RFC it was called vma_mark_locked() originally and renames were
discussed in the email thread ending here:
https://lore.kernel.org/all/621612d7-c537-3971-9520-a3dec7b43cb4@suse.cz/.
If other names are preferable I'm open to changing them.

>
> >         - write unlock - (vma_write_unlock_mm) is a batch release of all
> >           vma locks held. It doesn't pair with a specific
> >           vma_write_lock! It is done before exclusive mmap_lock is
> >           released by incrementing mm sequence counter (mm_lock_seq).
> >       - write downgrade - if the mmap_lock is downgraded to the read
> >         lock all vma write locks are released as well (effectivelly
> >         same as write unlock).
> --
> Michal Hocko
> SUSE Labs
