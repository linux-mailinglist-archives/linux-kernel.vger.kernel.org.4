Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B505D698250
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBORj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjBORjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:39:24 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E739B8F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:39:23 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4c24993965eso288523837b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1TegSQrWWZR8y8DXduRdcFIn2Gv2LGeDQhHy0b7yto=;
        b=WFAY+kEZ4MUdHDMej8sLvtg1NtCcTyLoaa4kCDjumgF1vPSCpCOQp0+SmPTWbbphgv
         1qdEB+3c/ZsfI94TpAHvpgnaLXkkGdTp8XwEdrQZlev5nAjGSshe5cXxUXy797Sw4ut1
         gX/ad1x9WEbuoDv795bj09rb50PEfKJOBtFgqU6rb0sLGt72Dz1sQphwKeGT21Q8+Qx8
         5cEIPSOcV2HFtdiFZ0eANnerOvXt/Em+YWCypMgOZl2VNk5VRH4w48igI78zrl0HI95T
         PTEvIHWKpPRzvi5TTuAo2VDj5vjGZ8ebBdC1U/wiQmmhOYnpLRXBS/12cTMrvERyYByi
         Kg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1TegSQrWWZR8y8DXduRdcFIn2Gv2LGeDQhHy0b7yto=;
        b=rv7V/m8mZ62a+LyS2ZYRzm1SjppQ+e7njZn1xvSi6X6vBkHjDXo1dKtUTOw1DKbPaq
         coruZU67lpHlvBycPatv1O947X5ro/Wv8CH07BprwLEYp0Hwul4e62opEhT6BtLkKzJb
         pHalPxPEvEkLv6ym1vdKO+si9KfRJnFQNYFNAa7nPMg6rdcQCKQcObBdEWKjLdHRZ9+5
         rrTBVDG1xyJRS2s9jxY3PGywzYsrzecjoiXZCqqF/XC9rFudq6XnWev3e3KXVygGMmt+
         t9zbeXAe22buLB4Uwxe/pFKjvs0lT2Vkp+C4cXgpM+CWEwJwyoy3OyfQd4d/1YnQaznn
         HpzA==
X-Gm-Message-State: AO0yUKVqkSelvmrgzzoNVf9v1QYhWuym3BNTpBeOg1Tfqx9rgzkiwsui
        KSFWrrjvgo7vtniF/5IO4GbnuZPikwyEzPehrsprnQ==
X-Google-Smtp-Source: AK7set9tj0SuaGqHnOQP442Zg1VoaONJfoFdwtf3ZUGe2VF4FOCBp2d9PHYcB5dmd1FIm9VjS1Fr8aaHX2CzwR1jECs=
X-Received: by 2002:a0d:f481:0:b0:52f:6f1:c397 with SMTP id
 d123-20020a0df481000000b0052f06f1c397mr370391ywf.321.1676482762380; Wed, 15
 Feb 2023 09:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20230127194110.533103-1-surenb@google.com> <87r0uqq1f9.fsf@stealth>
In-Reply-To: <87r0uqq1f9.fsf@stealth>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 15 Feb 2023 09:39:11 -0800
Message-ID: <CAJuCfpEtbN7ivxD_QHa+bqhr5f4SqkVUTvodcwt6Snj=d+f6qg@mail.gmail.com>
Subject: Re: [External] [PATCH v2 00/33] Per-VMA locks
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Feb 15, 2023 at 9:33 AM Punit Agrawal
<punit.agrawal@bytedance.com> wrote:
>
> Suren Baghdasaryan <surenb@google.com> writes:
>
> > Previous version:
> > v1: https://lore.kernel.org/all/20230109205336.3665937-1-surenb@google.=
com/
> > RFC: https://lore.kernel.org/all/20220901173516.702122-1-surenb@google.=
com/
> >
> > LWN article describing the feature:
> > https://lwn.net/Articles/906852/
> >
> > Per-vma locks idea that was discussed during SPF [1] discussion at LSF/=
MM
> > last year [2], which concluded with suggestion that =E2=80=9Ca reader/w=
riter
> > semaphore could be put into the VMA itself; that would have the effect =
of
> > using the VMA as a sort of range lock. There would still be contention =
at
> > the VMA level, but it would be an improvement.=E2=80=9D This patchset i=
mplements
> > this suggested approach.
>
> I took the patches for a spin on a 2-socket 32 core (64 threads) system
> with Intel 8336C (Ice Lake) and 512GB of RAM.
>
> For the initial testing, "pft-threads" from the mm-tests suite[0] was
> used. The test mmaps a memory region (~100GB on the test system) and
> triggers access by a number of threads executing in parallel. For each
> degree of parallelism, the test is repeated 10 times to get a better
> feel for the behaviour. Below is an excerpt of the harmonic mean
> reported by 'compare_kernel' script[1] included with mm-tests.
>
> The first column is results for mm-unstable as of 2023-02-10, the second
> column is the patches posted here while the third column includes
> optimizations to reclaim some of the observed regression.
>
> From the results, there is a drop in page fault/second for low number of
> CPUs but good improvement with higher CPUs.
>
>                                         6.2.0-rc4                6.2.0-rc=
4                6.2.0-rc4
>                              mm-unstable-20230210                   pvl-v=
2               pvl-v2+opt
>
> Hmean     faults/cpu-1     898792.9338 (   0.00%)   894597.0474 *  -0.47%=
*   895933.2782 *  -0.32%*
> Hmean     faults/cpu-4     751903.9803 (   0.00%)   677764.2975 *  -9.86%=
*   688643.8163 *  -8.41%*
> Hmean     faults/cpu-7     612275.5663 (   0.00%)   565363.4137 *  -7.66%=
*   597538.9396 *  -2.41%*
> Hmean     faults/cpu-12    434460.9074 (   0.00%)   410974.2708 *  -5.41%=
*   452501.4290 *   4.15%*
> Hmean     faults/cpu-21    291475.5165 (   0.00%)   293936.8460 (   0.84%=
)   308712.2434 *   5.91%*
> Hmean     faults/cpu-30    218021.3980 (   0.00%)   228265.0559 *   4.70%=
*   241897.5225 *  10.95%*
> Hmean     faults/cpu-48    141798.5030 (   0.00%)   162322.5972 *  14.47%=
*   166081.9459 *  17.13%*
> Hmean     faults/cpu-79     90060.9577 (   0.00%)   107028.7779 *  18.84%=
*   109810.4488 *  21.93%*
> Hmean     faults/cpu-110    64729.3561 (   0.00%)    80597.7246 *  24.51%=
*    83134.0679 *  28.43%*
> Hmean     faults/cpu-128    55740.1334 (   0.00%)    68395.4426 *  22.70%=
*    69248.2836 *  24.23%*
>
> Hmean     faults/sec-1     898781.7694 (   0.00%)   894247.3174 *  -0.50%=
*   894440.3118 *  -0.48%*
> Hmean     faults/sec-4    2965588.9697 (   0.00%)  2683651.5664 *  -9.51%=
*  2726450.9710 *  -8.06%*
> Hmean     faults/sec-7    4144512.3996 (   0.00%)  3891644.2128 *  -6.10%=
*  4099918.8601 (  -1.08%)
> Hmean     faults/sec-12   4969513.6934 (   0.00%)  4829731.4355 *  -2.81%=
*  5264682.7371 *   5.94%*
> Hmean     faults/sec-21   5814379.4789 (   0.00%)  5941405.3116 *   2.18%=
*  6263716.3903 *   7.73%*
> Hmean     faults/sec-30   6153685.3709 (   0.00%)  6489311.6634 *   5.45%=
*  6910843.5858 *  12.30%*
> Hmean     faults/sec-48   6197953.1327 (   0.00%)  7216320.7727 *  16.43%=
*  7412782.2927 *  19.60%*
> Hmean     faults/sec-79   6167135.3738 (   0.00%)  7425927.1022 *  20.41%=
*  7637042.2198 *  23.83%*
> Hmean     faults/sec-110  6264768.2247 (   0.00%)  7813329.3863 *  24.72%=
*  7984344.4005 *  27.45%*
> Hmean     faults/sec-128  6460727.8216 (   0.00%)  7875664.8999 *  21.90%=
*  8049910.3601 *  24.60%*

Thanks for summarizing the findings, Punit! So, looks like the latest
fixes I sent to you for testing (pvl-v2+opt) bring the regression down
quite a bit. faults/sec-4 case is still regressing but the rest look
quite good. I'll incorporate those fixes and post v3 shortly. Thanks!

>
> [0] https://github.com/gormanm/mmtests
> [1] https://github.com/gormanm/mmtests/blob/master/compare-kernels.sh
