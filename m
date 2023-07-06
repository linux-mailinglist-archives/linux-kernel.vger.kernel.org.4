Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA5E74A372
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjGFRuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjGFRt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:49:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7982B1BFF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 10:49:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3143493728dso956564f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1688665796; x=1691257796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XRkFcwJRK/x4r+MSOM1c1VR2Wm5TvBqzCvPrAnmjbk=;
        b=IwdNMCwAxYDS1HbHHhVnhPiCdVx7RJWpgqOsBbSXejQ8CclpupmQha3b/ZDWfYf+QO
         Lpl8we91703QuCL/RMmCnEImYnPAM2S2PwUKvOVI6k5Z5sDPJVJ9JRRSGBs17Q6Zd7ba
         C77ys8UXNa684WDUTWYno9iy7EaP4mHnBdN2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665796; x=1691257796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XRkFcwJRK/x4r+MSOM1c1VR2Wm5TvBqzCvPrAnmjbk=;
        b=Zxf6wtmHRyAWDCo2HfVa7IDXVBk5KYOYOZKIaFHCINs8dgztei4bHy6aJtCL+KjFGu
         bJCH2X3e7557PoQurH4h/lhIl5C+RDKOoL88sN3ZNoQ0/LkDq6Iy85UAGA+gbgSswrr2
         R3R0KRJMbKfTHTgxcMS6yiI5/6Ihtyg9JDrUX2A5jc/IDOBXdopVswVLKdzTmdm8xeqP
         qcZuGJDzwbqlHE0XVlbjlBSVq15DTSiCSRrkGyrOFIdM8vwqn+YcDXArY4hJmpyOZXlT
         EOTqDYRnNXeaPpF6xSBNEcqRsF3dQAbMIFo6cTwexqhHijM4ldBOVGqwIbrKRJdbERXc
         12Tg==
X-Gm-Message-State: ABy/qLbmRXBHGqlAupifWUKGpUD9Iry4NIpbdbAozfukseAdOfOLUWo/
        O76KiCQDkIkE65zN0HF+Hk/tlYKeMdnS4iWZTyPAHA==
X-Google-Smtp-Source: APBJJlFirfeky1cKQjNc9KvvUcKnJEfTjS8fdAo0zsBD21t2+h6CRLEeqKAAkeddNJyfSEWgjXfpx5KpVFa4p8u0xcQ=
X-Received: by 2002:a5d:490b:0:b0:314:4db:e0b2 with SMTP id
 x11-20020a5d490b000000b0031404dbe0b2mr2077392wrq.15.1688665795799; Thu, 06
 Jul 2023 10:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230706172237.28341-1-ivan@cloudflare.com> <f10c5eb17d6598def7ba17886e4e2e6e4aea07e0.camel@redhat.com>
In-Reply-To: <f10c5eb17d6598def7ba17886e4e2e6e4aea07e0.camel@redhat.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 6 Jul 2023 10:49:44 -0700
Message-ID: <CABWYdi3DVex0wq2kM72QTZkhNzkh_Vjb4+T8mj8U7t06Na=5kA@mail.gmail.com>
Subject: Re: [PATCH] udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        Satoru Moriya <satoru.moriya@hds.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 10:39=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On Thu, 2023-07-06 at 10:22 -0700, Ivan Babrou wrote:
> > The tracepoint has existed for 12 years, but it only covered udp
> > over the legacy IPv4 protocol. Having it enabled for udp6 removes
> > the unnecessary difference in error visibility.
> >
> > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")
> > ---
> >  net/ipv6/udp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> > index e5a337e6b970..debb98fb23c0 100644
> > --- a/net/ipv6/udp.c
> > +++ b/net/ipv6/udp.c
> > @@ -45,6 +45,7 @@
> >  #include <net/tcp_states.h>
> >  #include <net/ip6_checksum.h>
> >  #include <net/ip6_tunnel.h>
> > +#include <trace/events/udp.h>
> >  #include <net/xfrm.h>
> >  #include <net/inet_hashtables.h>
> >  #include <net/inet6_hashtables.h>
> > @@ -680,6 +681,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, s=
truct sk_buff *skb)
> >               }
> >               UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite=
);
> >               kfree_skb_reason(skb, drop_reason);
> > +             trace_udp_fail_queue_rcv_skb(rc, sk);
> >               return -1;
> >       }
>
> The patch looks correct and consistency is a nice thing, but I'm
> wondering if we should instead remove the tracepoint from the UDP v4
> code? We already have drop reason and MIBs to pin-point quite
> accurately UDP drops, and the trace point does not cover a few UDPv4
> spots (e.g. mcast). WDYT?

We are using this tracepoint in production monitoring:

* https://github.com/cloudflare/ebpf_exporter/blob/master/examples/udp-drop=
s.bpf.c

It gives us a metric with a port and through internal port ownership
we can automatically notify the responsible people to address the
issue. It is not possible with MIB, as it lacks the port information.

As for kfree_skb, it is much higher frequency (literally infinitely
more frequent in a happy state):

$ sudo perf stat -a -e skb:kfree_skb,udp:udp_fail_queue_rcv_skb -- sleep 10
            70,546      skb:kfree_skb
                 0      udp:udp_fail_queue_rcv_skb

It would be a lot more expensive to use kfree_skb to drive the metric
we have today. It would be even more expensive for machines that have
high bandwidth traffic, since they would see a lot more skbs (the one
above is not that busy).

As a matter of fact, I have a local patch to introduce a tracepoint
for tcp listen drops with the similar reasoning, waiting for net-next
to open.
