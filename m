Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796F97155D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjE3G6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjE3G55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:57:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE16121
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 23:57:52 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f7024e66adso62005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685429871; x=1688021871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHzqIyBto1SPvM6Sh19Wri052HEnIav9D7zAToQEq6U=;
        b=URid0El3ojW4ylCNvqLwoNrZpU+BgL/QQ+JKBNCqsLMHnwp1fsr5m33Iayhuakk2AD
         hh+9mXeq0fX63a6MfMcIsUN5tjb+q8ptQadIXbmLlftm5javQeL/vYzVGdX1Y790XME9
         +UKw+Hy573uJbytxgMWNNfRKJGJYVeofKhK7blh+PsOZEuMnKDuqCmVy6uoQUCevH5el
         qtdb/5Ft7fqnpldOofQYnx+awggDy7UN1UMg3RA37J/0EsTJWJGVRBVYu3h/r3ddaO6O
         1TqsRPFrtD0wYmW/TfCkVRJzq6lthhnazSQw1USHnnGIS8CaRCJINA2bPCmEzlNYR2Rl
         zTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685429871; x=1688021871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHzqIyBto1SPvM6Sh19Wri052HEnIav9D7zAToQEq6U=;
        b=P1PPqvFtX1iTjJu1woz+SZs8BjL1DPqmQAoRWSUkg9YxXJCiMIJUGrxemo+GsS59BB
         mY4sco1K2IxnDu+0uYlAogE3iM/+2s4uMru1ozwA0NsX1EnkiypFTbOLY2T5wa8Ewr06
         63+0ukQW8kzDpNAMpk9OLFV6st8uyDGUWTJ3hocJFfASVjdKyFrrcOqEb3eQWuOwQnzf
         QqPnTNJbfvNvC6pbyEPoHAK70WrANlptZm+sodDKNS/BE9HJA/0Hc5Yt6LiuwnqGNeYB
         YQ33u5FBGC9aoFFgsvHsPJMs1IeynommQcMx2Bvc4XbMdQR+8mlNzyR9n/hBEfMmOr5d
         e/Qw==
X-Gm-Message-State: AC+VfDzxGEVpVSUCOGOFvefIZfoQRjGboDrWTz5gaBjZ0IxswDGX6GU0
        klfbjb5T062gBa8B1Qcl38Z8my9hjAEpQwLPTG+sEw==
X-Google-Smtp-Source: ACHHUZ6lCVsP/YFGrJUWEdb+4ahmdU5pcqGcGe/9YreiIxe1KLdxkXxcm+AZ0qOSJnDWoa7AUaDO268ilS/HfbAE1P0=
X-Received: by 2002:a05:600c:4f10:b0:3f4:2736:b5eb with SMTP id
 l16-20020a05600c4f1000b003f42736b5ebmr59589wmq.1.1685429870704; Mon, 29 May
 2023 23:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iLzMBJE31VBL3jtu-ojdoAYwV_KLo1Qo+L6LWZ+5UKMtg@mail.gmail.com>
 <20230530032141.2277902-1-gaoxingwang1@huawei.com>
In-Reply-To: <20230530032141.2277902-1-gaoxingwang1@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 30 May 2023 08:57:39 +0200
Message-ID: <CANn89iK05tppo0neGmKTdU-Dp8Dap6ayxda-++Z3LRp3DFrq+w@mail.gmail.com>
Subject: Re: ip6_gre: paninc in ip6gre_header
To:     gaoxingwang <gaoxingwang1@huawei.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, liaichun@huawei.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, yanan@huawei.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 30, 2023 at 5:22=E2=80=AFAM gaoxingwang <gaoxingwang1@huawei.co=
m> wrote:
>
> >> Hello:
> >>   I am doing some fuzz test for kernel, the following crash was trigge=
red.
> >>   My kernel version is 5.10.0.Have you encountered similar problems?
> >>   If there is a fix, please let me know.
> >>   Thank you very much.
> >
> >Please do not report fuzzer tests on old kernels.
> >
> >Yes, there is a fix already.
>
> I've found this commit 5796015fa968a(ipv6: allocate enough headroom in ip=
6_finish_output2()) that I didn't patch for my kernel.
> Is this the fix you have mentioned? I'm testing to see if it works, but i=
t will take a few days.I'd appreciate it if you could reply.
>
> >
> >Make sure to use at least v5.10.180
> >
> >Thanks.

As I said, please upgrade to the latest v.5.10.X if you really need to
fuzz 5.10 based kernels.

We do not support 'your kernel', there is absolutely no way we can
know what is 'your kernel', unless you use a supported upstream one.

I will not give the list of fixes that went between 5.10 and 5.10.180,
you can use git log, information is already available there.

Probably not an exhaustive list (because some authors do not include
stack traces in their changelog),
or bugs can cause different crashes.

git log v5.10..v5.10.180 --oneline --grep mld_sendpack
be59b87ee4aed81db7c10e44f603866a0ac3ca5d net: tunnels: annotate
lockless accesses to dev->needed_headroom
8208d7e56b1e579320b9ff3712739ad2e63e1f86 ipv6: avoid use-after-free in
ip6_fragment()
7aa3d623c11b9ab60f86b7833666e5d55bac4be9 net: sched: fix race
condition in qdisc_graft()
49516e6ed91434d022a800321a8bc7d8054f62ac ipv6: make ip6_rt_gc_expire an ato=
mic_t
797b380f0756354b39f7487c362ea203cf3e3e80 net: sched: limit TC_ACT_REPEAT lo=
ops
beb39adb150f8f3b516ddf7c39835a9788704d23 mld: fix panic in mld_newpack()
0414bde7796802753672700ff0c9d3909ef07bd7 net: sched: replaced invalid
qdisc tree flush helper in qdisc_replace


Thanks.
