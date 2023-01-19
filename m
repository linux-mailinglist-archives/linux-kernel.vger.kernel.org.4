Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF920674149
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjASSwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjASSwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:52:19 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A194315
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:52:16 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 203so3738150yby.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ToHyrSNIoPykkmHjpmy+AXA0uDswLz8tCL1AkqWK5E4=;
        b=mo0ihRCw6Y3aWSIWf6n6XXsp3Czez4pmBoLn4xxcvfC7MIJwMGncIVEoR+KlAAsFdZ
         X+KL3ImyMm7CDvgKDNaitAKtQYJmfDiQS5wzretGPDK1Mi1wi1p+dYAlWVDWQ7EB8COm
         73VnlegayZ9CXqL1k0bgORj7azfFIJkz0+xJkhEfX5/5LxFj6WaWcB6V5foMDa3ZSoca
         mTUKfpVRCQYGi2+eL0D4ZMiEMZnLqo9cHtAvJNd2hYyr8+pslpkuYm69SorYbX73aFGZ
         KE1jn5AwD+MqZBLCrvWROTxITII/UL5w0qzHVSzaDoEabOI+otr/5WNJbNSN6S8nkrsZ
         TpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToHyrSNIoPykkmHjpmy+AXA0uDswLz8tCL1AkqWK5E4=;
        b=P76m3i8UdGv5Y+lvwbRBxVY4fd+VRcDUafDaYsJw5vxe3rmRSYT/C5luPApcP29+kL
         txuYrd0IS1fHjQe1RHmnr41OTPNjW8yxMYtpnPECHFTJi8qXWsWEVLU4NbsXt5vgLUuO
         nO7YP2NAkpLRfOWytSi7n+QCK0t1+ux/e9BPNjFT1Uzd+8L6h/bAXwnYhO3ZkFH3c05h
         jwbGvGdYtqtGfQmSdxC3RSM4ONZ+Xe5A0b5oKVjrFMS58sCvktL9LpHmeLSBtJd4xc9Q
         pAV+pig60FiqaZHZkY4repA2UAmZnhQXWjdd3YGgM4gDA0c8T0Um+NJ1r3MtnwBNggsm
         SbZw==
X-Gm-Message-State: AFqh2kqk2d1MfVF59Drv+RMSMtukefW7XnSF4/ATHKlh9IydjMsuk2zT
        tkBetExS11i/La2wpEh1hW+P//iAdVfYTvW8TFC2lQ==
X-Google-Smtp-Source: AMrXdXv4wX6M2y+O+IjiMg3HAJdiZYlyaI74hGgkr4eEujY3dQUI2lPzn402SgrjGkBzZXopyxNC269/MaskvyV/RAQ=
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr1116250ybo.380.1674154334935; Thu, 19
 Jan 2023 10:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-40-surenb@google.com>
 <Y8k+syJu7elWAjRj@dhcp22.suse.cz>
In-Reply-To: <Y8k+syJu7elWAjRj@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 Jan 2023 10:52:03 -0800
Message-ID: <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
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

On Thu, Jan 19, 2023 at 4:59 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > call_rcu() can take a long time when callback offloading is enabled.
> > Its use in the vm_area_free can cause regressions in the exit path when
> > multiple VMAs are being freed. To minimize that impact, place VMAs into
> > a list and free them in groups using one call_rcu() call per group.
>
> After some more clarification I can understand how call_rcu might not be
> super happy about thousands of callbacks to be invoked and I do agree
> that this is not really optimal.
>
> On the other hand I do not like this solution much either.
> VM_AREA_FREE_LIST_MAX is arbitrary and it won't really help all that
> much with processes with a huge number of vmas either. It would still be
> in housands of callbacks to be scheduled without a good reason.
>
> Instead, are there any other cases than remove_vma that need this
> batching? We could easily just link all the vmas into linked list and
> use a single call_rcu instead, no? This would both simplify the
> implementation, remove the scaling issue as well and we do not have to
> argue whether VM_AREA_FREE_LIST_MAX should be epsilon or epsilon + 1.

Yes, I agree the solution is not stellar. I wanted something simple
but this is probably too simple. OTOH keeping all dead vm_area_structs
on the list without hooking up a shrinker (additional complexity) does
not sound too appealing either. WDYT about time domain throttling to
limit draining the list to say once per second like this:

void vm_area_free(struct vm_area_struct *vma)
{
       struct mm_struct *mm = vma->vm_mm;
       bool drain;

       free_anon_vma_name(vma);

       spin_lock(&mm->vma_free_list.lock);
       list_add(&vma->vm_free_list, &mm->vma_free_list.head);
       mm->vma_free_list.size++;
-       drain = mm->vma_free_list.size > VM_AREA_FREE_LIST_MAX;
+       drain = jiffies > mm->last_drain_tm + HZ;

       spin_unlock(&mm->vma_free_list.lock);

-       if (drain)
+       if (drain) {
              drain_free_vmas(mm);
+             mm->last_drain_tm = jiffies;
+       }
}

Ultimately we want to prevent very frequent call_rcu() calls, so
throttling in the time domain seems appropriate. That's the simplest
way I can think of to address your concern about a quick spike in VMA
freeing. It does not place any restriction on the list size and we
might have excessive dead vm_area_structs if after a large spike there
are no vm_area_free() calls but I don't know if that's a real problem,
so not sure we should be addressing it at this time. WDYT?


>
> --
> Michal Hocko
> SUSE Labs
