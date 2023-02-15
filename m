Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9CE698227
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBORd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBORdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:33:54 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AEEA5D4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:33:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k3so12310680wrv.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0t94xwbIE7oAhUJFQ2BQHFhw0oZE0qnNECyAb2ZFKHQ=;
        b=wTYzp+HLVi+lx88ricSM/4zA8JGJ0VYAUK8sP1YwmHt5MGHWabBceqwlwxcEPxzMvc
         magXOb6suv1DXlOStB5PZvc2zBV9hlnvnH4H50+kYlzyuV0Uu06GW3ZzJsNjP1wjmEm/
         /g6mWpsZrj7fTLUZSrzvfBri7ZHgBO27wAq3dbmuY1x4ZZ0PkgpMBAjk0VwNa34aASAE
         A6rGzpy27hnSGLZSLkcS6pi1DiFjFqnQuJ3Rc47jhXlM2nYrZ2UnOXk5csTd2qgzNdtr
         43SrIB3xEnsd/MLqrCKN/npLj7g40d4R1m+2AC2+7QkNOt17ZlxEe1FozUu7SHAncT2A
         rrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0t94xwbIE7oAhUJFQ2BQHFhw0oZE0qnNECyAb2ZFKHQ=;
        b=f20zv+C5lm6UqWHr7JD2gYrMaZehoYXKO0dDGRn5lqEzYYTv+XkCd3ZsHn9vdv918s
         Z2+6ao8PctF3FxuKF0FmRg5PzdD1VUFnGxjsoygFm61eAqLm2GV5/FfLTjI6m4O5TvtB
         7zm38JkQG1THb+qZsIf7TschEfxv1gczxK9juafOe8zhQNXDO5GOi8vgpKyx9FDIXIeB
         7y8fcjqQ8rtV2RT1q0XamDXVbIcmzkwO22dfkdNbbt81LTpFLAndDKo70TfhJoi+g98L
         rU3l1jmPososkt0oPg9bf7/EChKgNuXuk7SYvoXDuGryoYBPqYObvre6Vi5vz2kXDhdB
         715w==
X-Gm-Message-State: AO0yUKU62d85q9leOgwVH7LPuEfcVaCex+3rW3SnU53Y3thhDoJiTpIp
        mIMMAjQd1mZ8iK2jmQ4IA3AYFg==
X-Google-Smtp-Source: AK7set9kT9H6NMj2/S3WBxDWHmAmNxq0wUR9ec7mDgnR1zjNhxV91JrWyeNEVDzBJm76EQ32XvPpCg==
X-Received: by 2002:a5d:4b03:0:b0:2c5:644c:3e89 with SMTP id v3-20020a5d4b03000000b002c5644c3e89mr2357955wrq.67.1676482380110;
        Wed, 15 Feb 2023 09:33:00 -0800 (PST)
Received: from localhost ([95.148.15.48])
        by smtp.gmail.com with ESMTPSA id f26-20020a5d58fa000000b002c5526680cbsm10288128wrd.92.2023.02.15.09.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 09:32:59 -0800 (PST)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [External] [PATCH v2 00/33] Per-VMA locks
References: <20230127194110.533103-1-surenb@google.com>
Date:   Wed, 15 Feb 2023 17:32:58 +0000
In-Reply-To: <20230127194110.533103-1-surenb@google.com> (Suren Baghdasaryan's
        message of "Fri, 27 Jan 2023 11:40:37 -0800")
Message-ID: <87r0uqq1f9.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suren Baghdasaryan <surenb@google.com> writes:

> Previous version:
> v1: https://lore.kernel.org/all/20230109205336.3665937-1-surenb@google.co=
m/
> RFC: https://lore.kernel.org/all/20220901173516.702122-1-surenb@google.co=
m/
>
> LWN article describing the feature:
> https://lwn.net/Articles/906852/
>
> Per-vma locks idea that was discussed during SPF [1] discussion at LSF/MM
> last year [2], which concluded with suggestion that =E2=80=9Ca reader/wri=
ter
> semaphore could be put into the VMA itself; that would have the effect of
> using the VMA as a sort of range lock. There would still be contention at
> the VMA level, but it would be an improvement.=E2=80=9D This patchset imp=
lements
> this suggested approach.

I took the patches for a spin on a 2-socket 32 core (64 threads) system
with Intel 8336C (Ice Lake) and 512GB of RAM.

For the initial testing, "pft-threads" from the mm-tests suite[0] was
used. The test mmaps a memory region (~100GB on the test system) and
triggers access by a number of threads executing in parallel. For each
degree of parallelism, the test is repeated 10 times to get a better
feel for the behaviour. Below is an excerpt of the harmonic mean
reported by 'compare_kernel' script[1] included with mm-tests.

The first column is results for mm-unstable as of 2023-02-10, the second
column is the patches posted here while the third column includes
optimizations to reclaim some of the observed regression.

From the results, there is a drop in page fault/second for low number of
CPUs but good improvement with higher CPUs.

                                        6.2.0-rc4                6.2.0-rc4 =
               6.2.0-rc4
                             mm-unstable-20230210                   pvl-v2 =
              pvl-v2+opt

Hmean     faults/cpu-1     898792.9338 (   0.00%)   894597.0474 *  -0.47%* =
  895933.2782 *  -0.32%*
Hmean     faults/cpu-4     751903.9803 (   0.00%)   677764.2975 *  -9.86%* =
  688643.8163 *  -8.41%*
Hmean     faults/cpu-7     612275.5663 (   0.00%)   565363.4137 *  -7.66%* =
  597538.9396 *  -2.41%*
Hmean     faults/cpu-12    434460.9074 (   0.00%)   410974.2708 *  -5.41%* =
  452501.4290 *   4.15%*
Hmean     faults/cpu-21    291475.5165 (   0.00%)   293936.8460 (   0.84%) =
  308712.2434 *   5.91%*
Hmean     faults/cpu-30    218021.3980 (   0.00%)   228265.0559 *   4.70%* =
  241897.5225 *  10.95%*
Hmean     faults/cpu-48    141798.5030 (   0.00%)   162322.5972 *  14.47%* =
  166081.9459 *  17.13%*
Hmean     faults/cpu-79     90060.9577 (   0.00%)   107028.7779 *  18.84%* =
  109810.4488 *  21.93%*
Hmean     faults/cpu-110    64729.3561 (   0.00%)    80597.7246 *  24.51%* =
   83134.0679 *  28.43%*
Hmean     faults/cpu-128    55740.1334 (   0.00%)    68395.4426 *  22.70%* =
   69248.2836 *  24.23%*

Hmean     faults/sec-1     898781.7694 (   0.00%)   894247.3174 *  -0.50%* =
  894440.3118 *  -0.48%*
Hmean     faults/sec-4    2965588.9697 (   0.00%)  2683651.5664 *  -9.51%* =
 2726450.9710 *  -8.06%*
Hmean     faults/sec-7    4144512.3996 (   0.00%)  3891644.2128 *  -6.10%* =
 4099918.8601 (  -1.08%)
Hmean     faults/sec-12   4969513.6934 (   0.00%)  4829731.4355 *  -2.81%* =
 5264682.7371 *   5.94%*
Hmean     faults/sec-21   5814379.4789 (   0.00%)  5941405.3116 *   2.18%* =
 6263716.3903 *   7.73%*
Hmean     faults/sec-30   6153685.3709 (   0.00%)  6489311.6634 *   5.45%* =
 6910843.5858 *  12.30%*
Hmean     faults/sec-48   6197953.1327 (   0.00%)  7216320.7727 *  16.43%* =
 7412782.2927 *  19.60%*
Hmean     faults/sec-79   6167135.3738 (   0.00%)  7425927.1022 *  20.41%* =
 7637042.2198 *  23.83%*
Hmean     faults/sec-110  6264768.2247 (   0.00%)  7813329.3863 *  24.72%* =
 7984344.4005 *  27.45%*
Hmean     faults/sec-128  6460727.8216 (   0.00%)  7875664.8999 *  21.90%* =
 8049910.3601 *  24.60%*

[0] https://github.com/gormanm/mmtests
[1] https://github.com/gormanm/mmtests/blob/master/compare-kernels.sh
