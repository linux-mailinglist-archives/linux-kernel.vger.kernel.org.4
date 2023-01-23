Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28766786EE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjAWT5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjAWT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:57:46 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4598D3C19
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:57:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k16so9921261wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N9qQteWUwJAybu5GRF/Inp+dulaE16FE+nFFa5cXdiw=;
        b=Bv35EwZqB5nxyfqZxvO4lwvh8MLjmXwaCbA2/qy9aRspOZWssKSLZNy1CJi6P2Rn5q
         VaGw+yN1V50UWyKMeGwynQOb7hF/ZfbIbdFR/lGzcA4C0YsDCysKaI2Ew5+2SN28SRpS
         PQuQZzuOA3GgIkkhuZcapOi/l72TfgcIr0qYhGtVxiq+Kj/ID+igXXq3jaRMNCPG8Cxo
         yACXNWWYQMHT0KGLp70yDEhiaTqlaLgAavvJ/N1MumrXfgP3vD+NpWfzIjr5Wv/tMw4k
         Sr1NzETlMhnsm/5FEcYy2eMKInOQVf1b21OlIhiA0e+wg58EJ5dEOix4XJTLI1MLHahp
         s1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9qQteWUwJAybu5GRF/Inp+dulaE16FE+nFFa5cXdiw=;
        b=n1l7q9qzXo1lRA4xIYhPN+iTbxInpRMtEvHYbj3SQo8T+5uRSvowpAT9fgeMBNthc1
         +a1wkBSGwHkZO4bjem93aWxv0LS3dqnfpcsU62fNghfTBMz2ACR+nPiYVbx3PJz7gIvq
         MXWcUZqGEt+JDkg/R8IL2q0d010U0S4EGgtZfFINNNSbnLrsVWuLA1sb+T5+zb46vcV7
         Bey/PSNX3ESU8kzmvtuTo1Eayg0x4zbmHNN5MOPlsvTpf2MJyaBeh6vwcDugLM9L0VOE
         pOBPFPDJyJDy9g8pjP2eu+Pj+PI26ZK2zlu31C85AySNozeHIHKbivRx3YBWqWJ4Wo43
         SUKw==
X-Gm-Message-State: AFqh2kpqPLjANG9uez3SvNIPjmiKqCr5C6nnrrWsQ59cqkR0TEY6YNmi
        SgMCTct3uR5O4GnTGWpmqMTIPT4q7/i0Qb0E7100OQ==
X-Google-Smtp-Source: AMrXdXtrPcaRXutaoPRaMiUkuyZPEFxjJaJdQAYs4KPWXWBZrMYZ3+R/eUUgMejXYArVmp3bLK0Z+Cqc/V9/bckA/ko=
X-Received: by 2002:a05:600c:d1:b0:3d9:f629:9043 with SMTP id
 u17-20020a05600c00d100b003d9f6299043mr1458123wmm.122.1674503862640; Mon, 23
 Jan 2023 11:57:42 -0800 (PST)
MIME-Version: 1.0
References: <Y8rQNj5dVyuxRBOf@casper.infradead.org> <CAJuCfpG3YaExGkzsSSm0tXjMiSoM6rVf0JQgfrWu4UY5gsw=-w@mail.gmail.com>
 <Y85Z0Ovl68o4cz2j@dhcp22.suse.cz> <CAJuCfpG86qc4odkpUbzuROb+jThQgXGWjcFXb0e-c2i0wEGg4g@mail.gmail.com>
 <Y868Fadajv27QMXh@dhcp22.suse.cz> <CAJuCfpGSCHpnZwwVV_922fmMBpFPZL0HAHMABuDzMfuURF2sWg@mail.gmail.com>
 <Y87A2CEKAugfgfHC@dhcp22.suse.cz> <CAJuCfpGJRZATfc8eUurvV5kGkSNkG=vK=sfwJbU72PESOyATSw@mail.gmail.com>
 <Y87QjHH2aDG5XCGv@casper.infradead.org> <Y87djZwQpXazRd00@dhcp22.suse.cz> <Y87gY7fhi5OJ35WQ@casper.infradead.org>
In-Reply-To: <Y87gY7fhi5OJ35WQ@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Jan 2023 11:57:30 -0800
Message-ID: <CAJuCfpFmQb=adyRWJJkSZ8h6qk1G7HiUm2U8VPLdCXatCLVJXA@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
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

On Mon, Jan 23, 2023 at 11:31 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 23, 2023 at 08:18:37PM +0100, Michal Hocko wrote:
> > On Mon 23-01-23 18:23:08, Matthew Wilcox wrote:
> > > On Mon, Jan 23, 2023 at 09:46:20AM -0800, Suren Baghdasaryan wrote:
> > [...]
> > > > Yes, batching the vmas into a list and draining it in remove_mt() and
> > > > exit_mmap() as you suggested makes sense to me and is quite simple.
> > > > Let's do that if nobody has objections.
> > >
> > > I object.  We *know* nobody has a reference to any of the VMAs because
> > > you have to have a refcount on the mm before you can get a reference
> > > to a VMA.  If Michal is saying that somebody could do:
> > >
> > >     mmget(mm);
> > >     vma = find_vma(mm);
> > >     lock_vma(vma);
> > >     mmput(mm);
> > >     vma->a = b;
> > >     unlock_vma(mm, vma);
> > >
> > > then that's something we'd catch in review -- you obviously can't use
> > > the mm after you've dropped your reference to it.
> >
> > I am not claiming this is possible now. I do not think we want to have
> > something like that in the future either but that is really hard to
> > envision. I am claiming that it is subtle and potentially error prone to
> > have two different ways of mass vma freeing wrt. locking. Also, don't we
> > have a very similar situation during last munmaps?
>
> We shouldn't have two ways of mass VMA freeing.  Nobody's suggesting that.
> There are two cases; there's munmap(), which typically frees a single
> VMA (yes, theoretically, you can free hundreds of VMAs with a single
> call which spans multiple VMAs, but in practice that doesn't happen),
> and there's exit_mmap() which happens on exec() and exit().
>
> For the munmap() case, just RCU-free each one individually.  For the
> exit_mmap() case, there's no need to use RCU because nobody should still
> have a VMA pointer after calling mmdrop() [1]
>
> [1] Sorry, the above example should have been mmgrab()/mmdrop(), not
> mmget()/mmput(); you're not allowed to look at the VMA list with an
> mmget(), you need to have grabbed.

I think it's clear that this would work with the current code and that
the concern is about any future possible misuse. So, it would be
preferable to proactively prevent such misuse.

vma_write_lock() and vma_write_unlock_mm() both have
mmap_assert_write_locked(), so they always happen under mmap_lock
protection and therefore do not pose any danger. The only issue we
need to be careful with is calling
vma_read_trylock()/vma_read_unlock() outside of mmap_lock protection
while mm is unstable. I don't think doing mmget/mmput inside these
functions is called for but maybe some assertions would prevent future
misuse?
