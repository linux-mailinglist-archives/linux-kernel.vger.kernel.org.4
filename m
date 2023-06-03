Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E60720F9E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjFCKuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 06:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbjFCKtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 06:49:49 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C6CE52;
        Sat,  3 Jun 2023 03:49:25 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bacfc573647so3234073276.1;
        Sat, 03 Jun 2023 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685789364; x=1688381364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyyoQMvpQF5PzGWt3kBFg2eNKf4guIBHfOxNLoJkZUI=;
        b=CtihXSFud5DP5Cvn+EXddv4LnaM1fVfp0KhyPH5G0u4ksfHMQwiCD0RGqBylHTliEK
         oi4HIpSJL4lGk3up6QAAK7+7XGdOyg0+ANe5GL0fHWGjzZphKR20EnIgVb++CUDfqMVB
         4uBYpm35NWw7/8+J7opD2+GaohargG7kS7EzVVlGDQGV+DtnDg7K1AqeQj/EMhf74HBQ
         1CTJXh/6HwfaA42yZe7E9FW9dGd6QpaEVpropv867yRuVH4ff3x5jkh0UjRSwf268l3Z
         j1VesDyfQktPPeSQbYFfT2Q8Px+UaH0XA9dfwvkRsz1+ziPcRBrqo+TlLWXIqBzVbNVf
         tNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685789364; x=1688381364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyyoQMvpQF5PzGWt3kBFg2eNKf4guIBHfOxNLoJkZUI=;
        b=bAg3rnDvF2XWBf1Hd9Btihh8idbyXbn91S6tON1i33VUiY7IIpxIE5an1/bC76ZKS7
         8pnWEgoiMqp97Y6O709dPQp0zALR3L8c6W3dZC8txjv+otdq1kPjTSE2/oYC8czn9Qxg
         HA0Do0uiBBtM6ntXidUJOoU2hc0LeBMQBid+PhYf83/wRM1sfq9MC9cvf8fiKPYyfQCR
         mQM9fCkCugClfMgUMyRQfj22au5ojx/rKyJYYCBHiqsw1rlcrVULzShKK40AbK1jwBBi
         09hqVfPaP3l/EGnqet0HPcPz5fk0LlF0BJzah+9hib63FkZ9Jk9jrlNqDS10SK1Jyzeh
         NJ6Q==
X-Gm-Message-State: AC+VfDx7S6J1Li+HIoBR6x7ep3u2WDPGifQnMt74xd5br5P8hdAlaA/d
        Jm7mL90OyJSAWUtnc4F/zPMPXChTYNhHjPpVC70=
X-Google-Smtp-Source: ACHHUZ7RuGP2q65LWQJrD0NF4a3jmRRWMDsV4sZmY0cN2tplT/8Bugvzo58iN/c/12WMfz1zR5iPMVnyeg73xdp4DlA=
X-Received: by 2002:a0d:dd55:0:b0:565:f0bd:edd0 with SMTP id
 g82-20020a0ddd55000000b00565f0bdedd0mr3271507ywe.29.1685789363964; Sat, 03
 Jun 2023 03:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230601031305.55901-1-akihiro.suda.cz@hco.ntt.co.jp> <6f8d3039-e8cf-2e9d-50e3-a48770f624b5@tessares.net>
In-Reply-To: <6f8d3039-e8cf-2e9d-50e3-a48770f624b5@tessares.net>
From:   Akihiro Suda <suda.kyoto@gmail.com>
Date:   Sat, 3 Jun 2023 19:49:12 +0900
Message-ID: <CAG8fp8Rrwcghyk6rHZEfAHPVUXCQgvgCFVKUEaZ-e0Kz5q=nLA@mail.gmail.com>
Subject: Re: [PATCH net v3] net/ipv4: ping_group_range: allow GID from
 2147483648 to 4294967294 - manual merge
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Akihiro Suda <suda.gitsendemail@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, segoon@openwall.com, kuniyu@amazon.com,
        Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The conflict has been resolved on our side

Thank you

2023=E5=B9=B46=E6=9C=883=E6=97=A5(=E5=9C=9F) 16:35 Matthieu Baerts <matthie=
u.baerts@tessares.net>:
>
> Hello,
>
> On 01/06/2023 05:13, Akihiro Suda wrote:
> > With this commit, all the GIDs ("0 4294967294") can be written to the
> > "net.ipv4.ping_group_range" sysctl.
> >
> > Note that 4294967295 (0xffffffff) is an invalid GID (see gid_valid() in
> > include/linux/uidgid.h), and an attempt to register this number will ca=
use
> > -EINVAL.
> >
> > Prior to this commit, only up to GID 2147483647 could be covered.
> > Documentation/networking/ip-sysctl.rst had "0 4294967295" as an example
> > value, but this example was wrong and causing -EINVAL.
>
> FYI, we got a small conflict when merging 'net' in 'net-next' in the
> MPTCP tree due to this patch applied in 'net':
>
>   e209fee4118f ("net/ipv4: ping_group_range: allow GID from 2147483648
> to 4294967294")
>
> and this one from 'net-next':
>
>   ccce324dabfe ("tcp: make the first N SYN RTO backoffs linear")
>
> ----- Generic Message -----
> The best is to avoid conflicts between 'net' and 'net-next' trees but if
> they cannot be avoided when preparing patches, a note about how to fix
> them is much appreciated.
>
> The conflict has been resolved on our side[1] and the resolution we
> suggest is attached to this email. Please report any issues linked to
> this conflict resolution as it might be used by others. If you worked on
> the mentioned patches, don't hesitate to ACK this conflict resolution.
> ---------------------------
>
> Regarding this conflict, I simply took the modifications from both sides.
>
> Cheers,
> Matt
>
> [1] https://github.com/multipath-tcp/mptcp_net-next/commit/f170c423f567
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
