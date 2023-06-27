Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A941C73FC04
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjF0Mbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjF0Mb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:31:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC561999;
        Tue, 27 Jun 2023 05:31:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-313e09a5b19so2833656f8f.0;
        Tue, 27 Jun 2023 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687869086; x=1690461086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa+nTJijQ9ASf8WlLQeUdpa+dFZwTDrfcItHW2kOSS0=;
        b=jnG7SEBoHpt9OdYmEA6qDYlvUKAwVDw+SJrYRqe8s0FxpIpSYsd/DVnBjYvk2of1p5
         7sYxzJDZyCHya9HeGhYKtx6+1CLYCTXv6pT+JJi8uGxPklu/fbeDK6H20KqJAed9Pk+F
         sryVJ/yBE9BwE1wzNQp3pgFYxVUmvUVmO+FgSLXZnSg/0rovfigd0IeGZGKcpgweD+gQ
         LEz40yMexBlrFrdBZEPDisLtSmQdeb11gm461PqFQ70j1sRoHJAeS17TnX9rQJm7UmJc
         NrUax+uYKfCLZaNwxZbix/FbM1GUU4v9DWyAtfFuSp/spCD3zLyZ52SR+VUWW/i53MSU
         o6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687869086; x=1690461086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xa+nTJijQ9ASf8WlLQeUdpa+dFZwTDrfcItHW2kOSS0=;
        b=GYbsk5XEmve9zNdVzbFA3syZyqnh7fCbg+e4bU6pMMkgMnNDbLEXxNnpWCvF5h6J+y
         8vUMREejIC165gKddwJOKk76puAMY4Rt8p0cCJpwVIrsBxaCx1xr3Rb/MUu1gkLRBMy/
         5UjzTcNAGerp7NYKje5HlYM/k4F9U0d+TAEMUUGHt7Lpq77dTjCFSl8vZQ9LggRlTGSa
         JjOBkiNP1Kg+dj6KL65amxiQPMJP5TxTbKU+L5Lo+V81CW3YVV7FDuzikHz6b0OWOmhy
         4F/Kr0vE+ur7i1cPDSTYcq2vVYlfYxM/Z4VByydefUhmDm1g0ZVy7MSq3jtbxyM8BSB/
         tVUw==
X-Gm-Message-State: AC+VfDzu0Wo12hGcmydZhXJNp0Y4HqSrX/gv4UWSkewJffV+BtFnWk/A
        QftevCGJQc0MDDP8D8Pb9Vsl0tkglmnySy5LAQ0=
X-Google-Smtp-Source: ACHHUZ7kd/kr3QaWqRB+9uv4Csc7z6jMqSymlgLD4iVmB8s7xd+Bx54w8K5LrFWX3fsARyqRx8XVs1/32cbASE/Ft4k=
X-Received: by 2002:a5d:6dce:0:b0:30a:e63b:950 with SMTP id
 d14-20020a5d6dce000000b0030ae63b0950mr33833828wrz.31.1687869086050; Tue, 27
 Jun 2023 05:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com> <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com> <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
 <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
 <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
 <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com>
 <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
 <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com> <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
In-Reply-To: <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Tue, 27 Jun 2023 14:31:13 +0200
Message-ID: <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 11:19=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Mon, 2023-06-26 at 20:59 +0200, Ian Kumlien wrote:
> > On Mon, Jun 26, 2023 at 8:20=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.=
com> wrote:
> > >
> > > Nevermind, I think I found it, I will loop this thing until I have a
> > > proper trace....
> >
> > Still some question marks, but much better
>
> Thanks!
> >
> > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > [   62.624003] BUG: kernel NULL pointer dereference, address: 000000000=
00000c0
> > [   62.631083] #PF: supervisor read access in kernel mode
> > [   62.636312] #PF: error_code(0x0000) - not-present page
> > [   62.641541] PGD 0 P4D 0
> > [   62.644174] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [   62.648629] CPU: 1 PID: 913 Comm: napi/eno2-79 Not tainted 6.4.0 #36=
4
> > [   62.655162] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
> > BIOS 1.7a 10/13/2022
> > [   62.663344] RIP: 0010:__udp_gso_segment
> > (./include/linux/skbuff.h:2858 ./include/linux/udp.h:23
> > net/ipv4/udp_offload.c:228 net/ipv4/udp_offload.c:261
> > net/ipv4/udp_offload.c:277)
>
> So it's faulting here:
>
> static struct sk_buff *__udpv4_gso_segment_list_csum(struct sk_buff *segs=
)
> {
>         struct sk_buff *seg;
>         struct udphdr *uh, *uh2;
>         struct iphdr *iph, *iph2;
>
>         seg =3D segs;
>         uh =3D udp_hdr(seg);
>         iph =3D ip_hdr(seg);
>
>         if ((udp_hdr(seg)->dest =3D=3D udp_hdr(seg->next)->dest) &&
>         // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> The GSO segment has been assembled by skb_gro_receive_list()
> I guess seg->next is NULL, which is somewhat unexpected as
> napi_gro_complete() clears the gso_size when sending up the stack a
> single frame.
>
> On the flip side, AFAICS, nothing prevents the stack from changing the
> aggregated packet layout (e.g. pulling data and/or linearizing the
> skb).
>
> In any case this looks more related to rx-gro-list then rx-udp-gro-
> forwarding. I understand you have both feature enabled in your env?
>
> Side questions: do you have any non trivial nf/br filter rule?
>
> The following could possibly validate the above and avoid the issue,
> but it's a bit papering over it. Could you please try it in your env?

Will do as soon as i get home =3D)

> Thanks!
>
> Paolo
> ---
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6c5915efbc17..75531686bfdf 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4319,6 +4319,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *sk=
b,
>
>         skb->prev =3D tail;
>
> +       if (WARN_ON_ONCE(!skb->next))
> +               goto err_linearize;
> +
>         if (skb_needs_linearize(skb, features) &&
>             __skb_linearize(skb))
>                 goto err_linearize;
>
