Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB174A066
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjGFPFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjGFPFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:05:44 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5511732
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:05:40 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401d1d967beso343911cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688655939; x=1691247939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msEvTjDikrgnhkRF3xJHOMkj86YrSM0qTZJUNmF80v4=;
        b=X4BDECg3HA6xRYn5CdWL0nOgUUnK1bioxo6zmKYJTvqxEdQ9U8HIOZAa/2QiMzqiXC
         xgkPTQI5EcaHvb7gM8hdCN/sMNjuacB1CVFdVGw/1MJqOehOMJiHNnj9hLWg5U535ncM
         bC/q2cccDX7zSEKUo0QrXGKfBfV62JbSEIBMggcxbxg+2nqsgeotkvzfWi4j8TdqR87Y
         9oJxlSt0M6moa98ZDo9hyIqaTzB5VbrVtnpn/y39iprMCaMXrHb292SyAsNDNmc3drPi
         JnFQA97PUbDF1Gh+Whn/PYp/9Z6mu/SeMfxTGtvekIIuLVJlTIyHpyMaj/jrBWQ2Myx9
         XbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655939; x=1691247939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msEvTjDikrgnhkRF3xJHOMkj86YrSM0qTZJUNmF80v4=;
        b=DY+8SIaYw5z8GmWExBmhIpWYk0yrbIXBFJ/K/K9PkEKtT9oW04ROandp8GWHy7Ajql
         E0seIT3BpiAaATFVEkF7ChVdw2b2bMYQYwb2BymzZ5g1mtsk0zfQypzUt5a0edsytO1E
         cGOcIGJdhwvItCJigp2rGeCxD6ERlxU502vXaeUHoR8wn2Bm+mGpd9Y5Gx2e+N7cUbiD
         7g8kxLFFyFVNuMXR8CngGktmScg6CcZdC1aJp6rPRahmxqLf9bw8cEcrD6I3w43KTcJG
         y9iP0sWr+cOdeM4UUbps15ib8Y0IFMl2UvKZRSCaKvsr9ZOhhiOt4uez6fsK/SfW56RS
         4qEA==
X-Gm-Message-State: ABy/qLbVLFYNafXiPeHDNQbmWqdC7mHfuO7bqh4i0KiqFJPqJS4znyEF
        De7iwG9U+Kfu+kHPN8UaRg5HSfJt7mcLcg8SHL0+Aw==
X-Google-Smtp-Source: APBJJlGOPYnRx4voPuHx8soGZwPPsIqGhSC2eDD71kFlff+Kq85+Ni5Sa25sG/PtaOHU+0UvpsZkC6JEc630C2fkX8Y=
X-Received: by 2002:ac8:5994:0:b0:3f8:5b2:aeed with SMTP id
 e20-20020ac85994000000b003f805b2aeedmr146287qte.21.1688655939226; Thu, 06 Jul
 2023 08:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230706130800.85963-1-squirrel.prog@gmail.com>
 <CANn89iKxGVDQba1UCbpYKhNo=rZXuN2j=610DbJx0z=kWa7N3w@mail.gmail.com> <CAJfyFi3OEz2Dz9gopigkVJRa4qCToJ+ob952O_qkOFiNn08LwA@mail.gmail.com>
In-Reply-To: <CAJfyFi3OEz2Dz9gopigkVJRa4qCToJ+ob952O_qkOFiNn08LwA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 6 Jul 2023 17:05:28 +0200
Message-ID: <CANn89iLBO7U40gNDysTD0wCPMAsgUQV3u_T1yzv1oaa=sLKyfQ@mail.gmail.com>
Subject: Re: [PATCH] gro: check returned skb of napi_frags_skb() against NULL
To:     Kaiyu Zhang <squirrel.prog@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jul 6, 2023 at 4:35=E2=80=AFPM Kaiyu Zhang <squirrel.prog@gmail.com=
> wrote:
>
> Yes the network adapter needs to be fixed for passing invalid packets to =
GRO. And a message like "dropping impossible skb" should be indicative enou=
gh for developers to do so.
>
> And yet I propose this patch because an immediate system crash caused by =
NULL pointer access after the above warning message is a bit more difficult=
 to analyse on some test bed where developers have to restore kernel messag=
es after a reboot .
>
> Furthermore, the adapter I'm working with is capable of receiving very sm=
all packets (1 or 2 bytes). They insist this is a feature rather than a bug=
. I can, and I will check packet length before passing them to GRO, for thi=
s particular adapter. But maybe a non-crash warning in general might be hel=
pful to other developers who will face the same problem and spare them some=
 effort on debugging.

1 or 2 bytes would still be stored in an skb, right ?

GRO is already very slow, we do not want to make it even slower so
that some developers can save time.
A kernel crash would point to the NULL deref just fine.

If we continue this path, we will soon add "if (!skb) be_kind" to all
functions accepting an skb as a parameter,
then everything else...
