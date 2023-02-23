Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C8F6A11C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBWVQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBWVQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:16:43 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D55351FA9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:16:37 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536bbe5f888so224561977b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 13:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndbjrFZ9GSZE0VRCf9RR1AX4PdczliTx2DTBUnXjBAE=;
        b=fOZe/etv+sd4bjNAksYDFrOZg/TXHF0ZFee94D/FMNLSiu1oT3zVfj9vXDPN1OXHfC
         oGpNm/0bUQSCD40wazC4yNQtwIUaBRFGc6ChZr9+zqHL5JCnTHKtfE/y1CKAytTCh8ud
         YgvLztPGCWRwHZnl00ai1khB8xrR3uwMyFgbBw9S3xWwoIbrtPJIq/IsLnmZNQ95q7Aa
         DB4GcBJakRFaW2aeyli9AXrO/MPhf8f0AXph6Di7Wamlw9ozMqaHYvh7IuVETCAVYHF2
         gu2S4EG23EVj9ag0ipdONVOC95C+FrB0EpQCzvxAEO3UkcRHV5DhFjKHRAP66CsyUt+6
         LHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndbjrFZ9GSZE0VRCf9RR1AX4PdczliTx2DTBUnXjBAE=;
        b=IVdZoBH+xh0g5ZM1DVHxZrQ4gT2UYkdRTxm8z77QkAZ/iFGF5O2qAyZl0dnr6IbrGk
         zYTN5mJK75goU3Yg9I1I5ComQjmHrIaygDy3Ca2gdDGX3usPvWwyyBCPS7/Py5p2OyTz
         C2+T7bT32mE7+/uoh21zxj9yv1YcDQrf1l3mBCa2qTyggzZN8QT4B09oQMfAZUcRqYGT
         MIDcuCO+pSl0u5QxoukX6z6G/SUJAJg9wNEu5RUU2CM4Z8dPsDs6e45OAzMU4msVaUX8
         qoCiJNFLAZq0moAf/u5gIYFrzH+R4C1gJBtBOtOWsP9b9yDtyC87t9jC1Lpkgy9DUGZZ
         yK9w==
X-Gm-Message-State: AO0yUKVbIDqyO/Evy3mS+JNhA/ZElqzJ8vaIcxLxEpnnmrIAQbQjZFM5
        sHRyYmemyL6j3VaFQyKGXIXr8j9kvLtpzOLNhfNFxQ==
X-Google-Smtp-Source: AK7set+cwRVt+nMfGVc9n+QUpRmsobXIvsJ4diFjxtv+Lveh827iF3Klb3XyKdd370ajPY2MbPYibo7hGyB9Z9jW5Oc=
X-Received: by 2002:a5b:b07:0:b0:9fe:1493:8b8 with SMTP id z7-20020a5b0b07000000b009fe149308b8mr2486525ybp.6.1677186996282;
 Thu, 23 Feb 2023 13:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-18-surenb@google.com>
 <20230223202011.dahh6cidqxhzoxne@revolver> <20230223202844.noant5suylne3dnh@revolver>
In-Reply-To: <20230223202844.noant5suylne3dnh@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 23 Feb 2023 13:16:25 -0800
Message-ID: <CAJuCfpE3YtSQuXJwOYWKe1z9O4GASS9pA_FTWGkdveHb3bcMXA@mail.gmail.com>
Subject: Re: [PATCH v3 17/35] mm/mmap: write-lock VMA before shrinking or
 expanding it
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, peterz@infradead.org, ldufour@linux.ibm.com,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
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

On Thu, Feb 23, 2023 at 12:28 PM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
>
> Wait, I figured a better place to do this.
>
> init_multi_vma_prep() should vma_start_write() on any VMA that is passed
> in.. that we we catch any modifications here & in vma_merge(), which I
> think is missed in this patch set?

Hmm. That looks like a good idea but in that case, why not do the
locking inside vma_prepare() itself? From the description of that
function it sounds like it was designed to acquire locks before VMA
modifications, so would be the ideal location for doing that. WDYT?
The only concern is vma_adjust_trans_huge() being called before
vma_prepare() but I *think* that's safe because
vma_adjust_trans_huge() does its modifications after acquiring PTL
lock, which page fault handlers also have to take. Does that sound
right?

>
>
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [230223 15:20]:
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >
> > * Suren Baghdasaryan <surenb@google.com> [230216 00:18]:
> > > vma_expand and vma_shrink change VMA boundaries. Expansion might also
> > > result in freeing of an adjacent VMA. Write-lock affected VMAs to prevent
> > > concurrent page faults.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  mm/mmap.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index ec2f8d0af280..f079e5bbcd57 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -674,6 +674,9 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > >             ret = dup_anon_vma(vma, next);
> > >             if (ret)
> > >                     return ret;
> > > +
> > > +           /* Lock the VMA  before removing it */
> > > +           vma_start_write(next);
> > >     }
> > >
> > >     init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
> > > @@ -686,6 +689,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > >     if (vma_iter_prealloc(vmi))
> > >             goto nomem;
> > >
> > > +   vma_start_write(vma);
> > >     vma_adjust_trans_huge(vma, start, end, 0);
> > >     /* VMA iterator points to previous, so set to start if necessary */
> > >     if (vma_iter_addr(vmi) != start)
> > > @@ -725,6 +729,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > >     if (vma_iter_prealloc(vmi))
> > >             return -ENOMEM;
> > >
> > > +   vma_start_write(vma);
> > >     init_vma_prep(&vp, vma);
> > >     vma_adjust_trans_huge(vma, start, end, 0);
> > >     vma_prepare(&vp);
> > > --
> > > 2.39.1
> > >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
