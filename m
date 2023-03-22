Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844AD6C414A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCVDuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCVDut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:50:49 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F1366BD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:50:48 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z83so19641986ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 20:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679457047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0VhsPPpparLUNdAbe0j6h80lVgFzUm7YaynPl05M0Y=;
        b=nKYq8dWuPfnWtGwtat/C+wgBZTbS19b8glC8jBbV0VqStowtRRf+QEWssa96OamjmH
         hTNuozEcTYFz+0SlnnEUTCPdZYRnwfporxdPl55CvAI5td2Bwv52J+XxmFDSX44hyVy/
         ddUs2jswSP6ztRzIojmxKA6Gbd12DoJ4dmetX6++rEmOQJP7DlBmFfUImddgoj4fpupS
         l13pir9HtjvOcjHxM7R1UltJbPZQ6oVQgMYuyqXGN/hgsA1+8Y0o7PMItv3iDosTRytP
         I+u/QFrLedODJvoqsDFgVYLCgSsOhXUkFfNli/1uSweBK5MTcXfvyPGMvGNa1CzMwh54
         BMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679457047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0VhsPPpparLUNdAbe0j6h80lVgFzUm7YaynPl05M0Y=;
        b=o5pnTUMGLA3Rnk0oQtUhevdnmOUXZVZmZyWxaet7cy3XleF6fAFzbblgslbmLFCAyV
         TwYVt1zn1BUP0bWMVHbOzRNK4Z2576R8+FELfG0++eMpeIhDChl9q/obrINFDLlHGLIL
         Thl8nuKQm7dC7wXzA5kaLJQ7hHmq2qfy8fzV24MxzbaiHCLJj6mFh1kngng33necflnO
         XAN6uR/Hv0JosQK4K/DKmmVSGCfblDTW06cpx4thfHBa15unAG9aQiBoWsm+SIWUQQe5
         bAmf0QMGb/hutKyvACCa2UPj/6zF8U/9qdjddPRwXpRAIqZ6jPwD7cVsEcT1lcKjpF+a
         VaLA==
X-Gm-Message-State: AAQBX9cH35ceee5MdDxheVRC433aMPrsMXS8Viq1NDa2zkK5LGB1puxA
        R9hR/2MMsUOfvo6irMwcFwitlTcwtTfDDnziiIvsSD4MmA24C7fcBmS2
X-Google-Smtp-Source: AKy350b53zG/5QAQ5I/YqLKtRbtkfqZAKp748OqC6MN+2F+jWaJOYucp9LrzLrPeTgTMflajIql700MYWPpyzuqRfgg=
X-Received: by 2002:a25:e90f:0:b0:b3d:c59:4d26 with SMTP id
 n15-20020a25e90f000000b00b3d0c594d26mr3091540ybd.5.1679457047185; Tue, 21 Mar
 2023 20:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230320233720.3488453-8-jstultz@google.com> <202303211827.IXnKJ5rO-lkp@intel.com>
In-Reply-To: <202303211827.IXnKJ5rO-lkp@intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 21 Mar 2023 20:50:36 -0700
Message-ID: <CANDhNConSPK78JXv5=Jok6T7y7F8APERYsCFD6h7J+ULRjzasA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] sched: Replace rq->curr access w/ rq_curr(rq)
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, oe-kbuild-all@lists.linux.dev,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 4:12=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi John,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on tip/sched/core]
> [also build test ERROR on tip/locking/core tip/master tip/auto-latest lin=
us/master v6.3-rc3 next-20230321]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/John-Stultz/lockin=
g-ww_mutex-Remove-wakeups-from-under-mutex-wait_lock/20230321-074149
> patch link:    https://lore.kernel.org/r/20230320233720.3488453-8-jstultz=
%40google.com
> patch subject: [PATCH v2 07/12] sched: Replace rq->curr access w/ rq_curr=
(rq)
> config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20230321=
/202303211827.IXnKJ5rO-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=3D1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/77507c3a77e09cdc6=
27a73364246f252d918de41
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review John-Stultz/locking-ww_mutex-Rem=
ove-wakeups-from-under-mutex-wait_lock/20230321-074149
>         git checkout 77507c3a77e09cdc627a73364246f252d918de41
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 olddefconfig
>         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303211827.IXnKJ5rO-lkp@i=
ntel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/rculist.h:11,
>                     from include/linux/sched/signal.h:5,
>                     from include/linux/sched/cputime.h:5,
>                     from kernel/sched/build_policy.c:17:
>    kernel/sched/cputime.c: In function 'kcpustat_field':
> >> kernel/sched/cputime.c:997:42: error: 'struct rq' has no member named =
'curr'
>      997 |                 curr =3D rcu_dereference(rq->curr);
>          |                                          ^~


Ah! Thanks for catching this. I've fixed it up for the next revision.
-john
