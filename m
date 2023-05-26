Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C18712906
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243500AbjEZPAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbjEZPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:00:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB39A4
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:00:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f606e111d3so52445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685113234; x=1687705234;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KZxUKwlq0yZyclpzR1NI3cPyelUrM3AmuMG5YiylxFw=;
        b=PiL3VbXVjGq8RrPBwDW9WRRf+vJH+n19Qol2yB8Pi0pTFENufwor12HxTFrEGq5mrf
         NVaspnSG/zBL17aM+MBufhgTiW64ssJDDDyK26Jf9Oh5ooiUuVqfTjhOn91elQ9cahDj
         mW+da8q/eUHp3OcGakqOy7WhSHrsOCVjzlCZud/n0JY/UrNmjIKMAbXEylyx73rFzStF
         woVUI+PVilILRiCrR11lsRjWb+VjP80VLTnfZVcQyS454Dqb4q0hAMdzOUcpgIWEuOvY
         O+OLSaWG+iBH1HKhdoQE7s4hw+k4lUvFCKrXG6bZrvS8G9+XiYYUE2JPm/Coed6UvDeh
         //xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685113234; x=1687705234;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZxUKwlq0yZyclpzR1NI3cPyelUrM3AmuMG5YiylxFw=;
        b=Qm1tOLVFwTE1DCvuMKTX+USvF7UYzcSf3xjkMGmMwW0or1Q6Uy/n4GbabJ4jnCXpqP
         RY2ntw6OCS1SX/Aesp3MkIp2xDZZgHBSJ8/dIfOibo29uvAludadA3LrFJSwWzXp4BlU
         dlvLU9fQpa3w+cJZ20PycXG81UNaU0XKu0dKGO8xaEpI2X+fbfWF/vw74BcHqbXKbQBO
         wE/sp8reRFhhxZCjbC+AGLAiYNNcSbTX/Iu5d8H2p1xEuQsiDHRKUuAJxUQ0KRSYAmda
         NXWSn/X+np1sfVdN33vknGaQpOCcmT60C60HKhRvYvdF9ic/4/AgfD9BzOk+YCmBfElj
         ZTTg==
X-Gm-Message-State: AC+VfDx/BNH96NSSiffOpabXvJFxBadz/oBb2XvHEKICd3GGe5oEY5d4
        C1Nvuc0YD/UcSeeoRrajZ/BePYxPd+Pn/2Lix6HZlpCKQYkSwxGTw8Elgw==
X-Google-Smtp-Source: ACHHUZ7TdRT+anDyI/3z61t5hK5mam4fZnN+hM7lYIR4eZfmzDqfrK3kpP8+sDk9FqQKk6yv1mFckMZuSeIgpa4QqIw=
X-Received: by 2002:a05:600c:3c96:b0:3f4:1dce:3047 with SMTP id
 bg22-20020a05600c3c9600b003f41dce3047mr115414wmb.2.1685113234301; Fri, 26 May
 2023 08:00:34 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 May 2023 17:00:22 +0200
Message-ID: <CANn89iKUbyrJ=r2+_kK+sb2ZSSHifFZ7QkPLDpAtkJ8v4WUumA@mail.gmail.com>
Subject: x86 copy performance regression
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

While testing unrelated patches using upstream net-next kernels,
I found a big regression in sendmsg()/recvmsg() caused by a series of yours.

Tested platforms :

Intel(R) Xeon(R) Gold 6268L CPU @ 2.80GHz

We can see rep_movs_alternative() using more cycles in kernel profiles
than the previous variant (copy_user_enhanced_fast_string, which was
simply using "rep  movsb"), and we can not reach line rate (as we
could before the series)


Patch series:

commit a5624566431de76b17862383d9ae254d9606cba9
Merge: 487c20b016dc48230367a7be017f40313e53e3bd
034ff37d34071ff3f48755f728cd229e42a4f15d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Apr 24 10:39:27 2023 -0700

    Merge branch 'x86-rep-insns': x86 user copy clarifications

    Merge my x86 user copy updates branch.

IMO this patch seems to think tcp sendmsg() is using small areas.
(tcp_sendmsg() usually copy 32KB at a time, if order-3 pages
allocations are possible)

commit adfcf4231b8cbc2d9c1e7bfaa965b907e60639eb
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Apr 15 13:14:59 2023 -0700

    x86: don't use REP_GOOD or ERMS for user memory copies

    The modern target to use is FSRM (Fast Short REP MOVS), and the other
    cases should only be used for bigger areas (ie mainly things like page
    clearing).

    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>



The issue is that (some of) our platforms do have ERMS but not FSRM

Test run on 6.3 (single TCP flow, sending 32 MB of payload to a
zerocopy receiver to make sure the receiver is not the bottleneck).
100Gbit link speed.

# perf stat taskset 02 tcp_mmap -H 2002:a05:6608:295::

 Performance counter stats for 'taskset 02 ./tcp_mmap -H 2002:a05:6608:295::':

          2,815.79 msec task-clock                       #    0.936
CPUs utilized
             2,370      context-switches                 #  841.682
/sec
                 1      cpu-migrations                   #    0.355
/sec
               127      page-faults                      #   45.103
/sec
    10,106,383,352      cycles                           #    3.589
GHz
     6,936,487,168      instructions                     #    0.69
insn per cycle
     1,206,325,691      branches                         #  428.414
M/sec
        10,327,112      branch-misses                    #    0.86% of
all branches

       3.007810265 seconds time elapsed

       0.005158000 seconds user
       2.406125000 seconds sys


Same test from linux-6.4-rc1

# perf stat taskset 02 tcp_mmap -H 2002:a05:6608:295::

 Performance counter stats for 'taskset 02 ./tcp_mmap -H 2002:a05:6608:295::':

          4,039.73 msec task-clock                       #    1.000
CPUs utilized
                12      context-switches                 #    2.970
/sec
                 1      cpu-migrations                   #    0.248
/sec
               130      page-faults                      #   32.180
/sec
    14,639,828,754      cycles                           #    3.624
GHz
    19,443,379,653      instructions                     #    1.33
insn per cycle
     1,931,003,961      branches                         #  478.003
M/sec
        12,349,476      branch-misses                    #    0.64% of
all branches

       4.040825111 seconds time elapsed

       0.012496000 seconds user
       3.560336000 seconds sys

Thanks.
