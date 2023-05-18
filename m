Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD84970795F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjERE5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjERE5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:57:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6702B2733;
        Wed, 17 May 2023 21:57:36 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2533d8f4a1eso1250959a91.1;
        Wed, 17 May 2023 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684385855; x=1686977855;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbIff1DfcH4ZQO1XguTv+CpOs+a0WWSeq2A5H3P9z3E=;
        b=DPNpbTYBq9tn7P42KZKXpZzmJY+Ru8As0OG5/7/gFOQN4cRXAeyiWV8NAuJIhnellc
         2VM+rgmLYF0iXItJc5QWYQ3MohWxGy1eRDRF/7qhNsvEZoz3WksZUqiexjvQpY6I9ssl
         vV/Qr4nGIiWFznnkhjnOLb6slIW7KAZb5EXnUzF8qKG/VsnQxzkymAlbzUpTqe0pQV0j
         7eAdxs3y+v4ME5Vse4grk/VpgqwRd2VmBqyl9ZFOhf5q9FEoZfuMIvmbT8uaeHUn2flj
         pQDYiQutlqqlSmkQXtRDQ9Ngv4vJ0aKaMMU4Ze1CK56yaXHAyp1Ipk9sE5qRgdQvXuJu
         Hi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684385855; x=1686977855;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbIff1DfcH4ZQO1XguTv+CpOs+a0WWSeq2A5H3P9z3E=;
        b=IEcG+OEEbKB/m3GJWf2q0eT2qHzZ8u9UWBK6aRrEkU4LyM7uIIINrJqkxIjLrvfynN
         OmylL81vKkeQTZVC/ivckAl4fD3bvc+xO1hzoKJl1pEq2uKo6MnC6CLRnmMHeiafD5tM
         nHR0wkGHqFFK1mq90h/OXNFyna4aUaQHEXQ8ES6MgaE9wO+Y1JWPoB1KDNQcd7TX398H
         NTvcChMP0tM0574HpPcPjvDUN4Bw6KLw4u+RQnZQjSOP/nAADULRfb3nmby6ZrmOUrOz
         CK6bQQ9d9MYPT8dvDXC7raWIOQfww6Dzw21zTJeKws4kwaZE0TxvvZzNTPeGSecbyU2c
         xY1g==
X-Gm-Message-State: AC+VfDwMlpgP2taUhFHLd/XsdUErB9L6j2UM3YjIHjc6ZI51n9G6iIFW
        +RmIqTvXuivI7BDEPyyPFx5pm8eX/1jeWQ==
X-Google-Smtp-Source: ACHHUZ7Zr5Inbn1S74qaRdklnvnngbXaMEKK9Ebuy9Go6v2VaA+TSNo5hXLoJDLGmeGfUESe14PLeg==
X-Received: by 2002:a17:90b:ed3:b0:24d:f3cc:7d34 with SMTP id gz19-20020a17090b0ed300b0024df3cc7d34mr1268777pjb.32.1684385854898;
        Wed, 17 May 2023 21:57:34 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090adb8700b0023d386e4806sm422178pjv.57.2023.05.17.21.57.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 May 2023 21:57:34 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Problem running perf using Intel-PT with snapshots
Message-Id: <6325A777-706E-462A-8931-59E16D4E37A5@gmail.com>
Date:   Wed, 17 May 2023 21:26:28 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>
To:     linux-perf-users@vger.kernel.org
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello perf masters,

I am running perf with Intel PT with snapshot mode and the result makes =
no
sense. I tried to figure it out myself but failed.

Excluding the first data file, the rest seem messed up in various ways. =
The
only thing that repeatedly shows are calls to __fentry__+0x0. I would =
note
that ftrace is not enabled, and I turned off mitigations as I thought it
might somehow be related, but it did not help.

Here is an example for execution and output. In between I ran
`kill -SIGUSR2 [perf-pid]`. To dump some traces.

Any ideas what it might be?

Thanks,
Nadav

--

$ perf record -e intel_pt/noretcomp=3D1/k --kcore --timestamp -a =
--snapshot=3De262144 --switch-output -m,64
[ perf record: dump data: Woken up 2 times ]
[ perf record: Dump perf.data.2023051804132358 ]
[ perf record: dump data: Woken up 1 times ]
[ perf record: Dump perf.data.2023051804132537 ]
[ perf record: dump data: Woken up 1 times ]
[ perf record: Dump perf.data.2023051804132689 ]
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Dump perf.data.2023051804132829 ]
[ perf record: Captured and wrote 14.330 MB perf.data.<timestamp> ]


$ sudo perf script -i  perf.data.2023051804004293

             :-1    -1 [006]    78.287624:          1             =
branches:k:  ffffffff81096125 ept_page_fault+0x3f5 ([kernel.kallsyms]) =
=3D> ffffffff8108f1d0 kvm_mmu_get_child_sp+0x0 ([kernel.kallsyms])
             :-1    -1 [006]    78.287624:          1             =
branches:k:  ffffffff8108f1d0 kvm_mmu_get_child_sp+0x0 =
([kernel.kallsyms]) =3D> ffffffff81131190 __fentry__+0x0 =
([kernel.kallsyms])
 instruction trace error type 1 time 78.287624064 cpu 6 pid -1 tid -1 ip =
0xffffffff8101c4fd code 6: Trace doesn't match instruction
             :-1    -1 [006]    78.287624:          1             =
branches:k:  ffffffff81296e14 futex_unlock_pi+0x184 ([kernel.kallsyms]) =
=3D> ffffffff81294120 futex_cmpxchg_value_locked+0x0 ([kernel.kallsyms])
             :-1    -1 [006]    78.287624:          1             =
branches:k:  ffffffff81294124 futex_cmpxchg_value_locked+0x4 =
([kernel.kallsyms]) =3D> ffffffff81131190 __fentry__+0x0 =
([kernel.kallsyms])
 instruction trace error type 1 time 78.287624104 cpu 6 pid -1 tid -1 ip =
0xffffffff824c7a44 code 6: Trace doesn't match instruction
             :-1    -1 [006]    78.287624:          1             =
branches:k:  ffffffff812909c4 __tick_broadcast_oneshot_control+0x1d4 =
([kernel.kallsyms]) =3D> ffffffff8128f720 tick_broadcast_set_event+0x0 =
([kernel.kallsyms])
             :-1    -1 [006]    78.287624:          1             =
branches:k:  ffffffff8128f720 tick_broadcast_set_event+0x0 =
([kernel.kallsyms]) =3D> ffffffff81131190 __fentry__+0x0 =
([kernel.kallsyms])
             :-1    -1 [006]    78.287624:          1             =
branches:k:  ffffffff81296e8e futex_unlock_pi+0x1fe ([kernel.kallsyms]) =
=3D> ffffffff812961d0 put_pi_state+0x0 ([kernel.kallsyms])
             :-1    -1 [006]    78.287624:          1             =
branches:k:  ffffffff812961d4 put_pi_state+0x4 ([kernel.kallsyms]) =3D> =
ffffffff81131190 __fentry__+0x0 ([kernel.kallsyms])
 instruction trace error type 1 time 78.287624208 cpu 6 pid -1 tid -1 ip =
0xffffffff824c7a44 code 6: Trace doesn't match instruction

