Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC56A962D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCCL2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjCCL2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:28:16 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7185F21C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:27:46 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j2so1901033wrh.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677842859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxPuuniW5TWRFly+k8ILkMkCWp9YOR4sj0SnUtoUE4g=;
        b=HoAVB6xHxGj8IEzGpBJAaJXk504T1tN2SwCIGSoK/JwlO+aI401se+Ae+vt58AbBif
         6PYdSyy/KcxRUgKJbbYxdPtGVkrbiO8F903aEfWszhwTu7jRy9Q3RwrioQT1XjWZPN33
         pnM90l3M6is5wSOwfW78l49fZcw886KU4N4hKYm27Co+d6GQpxF/gjIEdHWQ7xJp2APD
         UEIDHMxuA2xDW2nkpiYJQtcTDzQXwj6WT14H2oi+boV01LqJ82UNWX4HwTNO2MAXZinr
         GJQzUnVgz3tSPKsPCrFLUkG+Zfo8ovCKs/Ze92M7viyFz+6A0wFSEpH0BbNPH2vaVgAv
         K9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677842859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxPuuniW5TWRFly+k8ILkMkCWp9YOR4sj0SnUtoUE4g=;
        b=l+X2URejKmNl4yonOJQJAU/hHIIxo15Z3sLxagB7FurCOZSd88na0QirORIgKRkbi+
         +uALLrBW/1++hcw55jxk4yigP5Qgby1+/I89nar/ku8YPtnkL1fqMdHNml6cuU3Dea1A
         cIQBJqUTK6LTEaJVxEWl8Jtn1xqy5ikDpCqRY2amZoVEdXJxoAJKm5CxelbeZuMNX89Z
         NpvfOeoMAlNua9GLTvLZ6Q0GI65t6UZjx6d9UYSOzvvKPlyj5pibrrOEUL5lLhNjZNac
         plO8lylp9s1OzeemV/lrpNvjFC4fuOVI5cDPHznmO+Xx12+DAuAN31MtBv1SCBjfVsqW
         Wiiw==
X-Gm-Message-State: AO0yUKUNPhXF8B5THUp4inbRtROVeuUDkmsLdczIItmxyWAl3+UgjF+U
        RpAEvbQesivnaNUFpZ/zRuEZyC7Qg26rjVwQxhAQaw==
X-Google-Smtp-Source: AK7set9IyxwsOE4zaroUwF21kh+w0ILC8LFBSifcD0HyMJaQgH9lW13dGEVOFOQif3SD7Jkyf8tceVF0WHzVmaBBqcI=
X-Received: by 2002:adf:f584:0:b0:2cb:80af:e8ab with SMTP id
 f4-20020adff584000000b002cb80afe8abmr363614wro.11.1677842858480; Fri, 03 Mar
 2023 03:27:38 -0800 (PST)
MIME-Version: 1.0
References: <6400bd699f568_20743e2082b@willemb.c.googlers.com.notmuch> <202303031900454292466@zte.com.cn>
In-Reply-To: <202303031900454292466@zte.com.cn>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 3 Mar 2023 12:27:26 +0100
Message-ID: <CANn89iK3frwxddhSbbi5cvmuSjr2TqPbD_mTgBa3k4ESDQnrHA@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] selftests: net: udpgso_bench_tx: Add test
 for IP fragmentation of UDP packets
To:     yang.yang29@zte.com.cn
Cc:     willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhang.yunkai@zte.com.cn,
        xu.xin16@zte.com.cn, jiang.xuexin@zte.com.cn
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

On Fri, Mar 3, 2023 at 12:03=E2=80=AFPM <yang.yang29@zte.com.cn> wrote:
>
> > Did you actually observe a difference in behavior with this change?
>
> The test of UDP only cares about sending, and does not much need to
> consider the problem of PMTU, we configure it to IP_PMTUDISC_DONT.
>     IP_PMTUDISC_DONT: turn off pmtu detection.
>     IP_PMTUDISC_OMIT: the same as DONT, but in some scenarios, DF will
> be ignored. I did not construct such a scene, presumably when forwarding.
> Any way, in this test, is the same as DONT.
>
> We have a question, what is the point of this test if it is not compared =
to
> UDP GSO and IP fragmentation. No user or tool will segment in user mode,
> UDP GSO should compare performance with IP fragmentation.

I think it is misleading to think the cost of IP fragmentation matters
at the sender side.

Major issue is the receiving side, with many implications of memory
and cpu costs,
not counting amplifications of potential packet losses.

So your patch would make sense if you also change
tools/testing/selftests/net/udpgso_bench_rx.c accordingly.

If you send UDP packets to a receiver, then you should not receive
ICMP errors, unless a reassembly error occured.

About ICMP packets being disruptive, you can always ignore errors at
sendmsg() time and retry the syscall.
