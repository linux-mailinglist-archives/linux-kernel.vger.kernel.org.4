Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC31A74A33E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGFRkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGFRkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA91FE1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688665145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHHbMtv2Yw061BT7CmjmxQ5Xv9gcyC1gSAWRuva95Fw=;
        b=R9vkiv5tbCq4ATPBRFAHCZj5tKbr5x0PQGOZd3NU5L9CpyvWrLWKpSATWCsQw5o1jTbj8C
        kjD/NmRCcuu/3jLsVS0urmp2N0Kqtd92gYiJYEaTqUL9aHks9Fsuj7H/D+27WYM8Ybi7/k
        2Vomdje6I0slkQ01+TO54p7/QGe4eQ8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-jhYuKPg7NZqvwhLOSpnDlg-1; Thu, 06 Jul 2023 13:39:03 -0400
X-MC-Unique: jhYuKPg7NZqvwhLOSpnDlg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-402fa256023so1930471cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 10:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665143; x=1691257143;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QHHbMtv2Yw061BT7CmjmxQ5Xv9gcyC1gSAWRuva95Fw=;
        b=J4+pGq5/7Sl8W7BUnO1kQwy/4D6OJyeE53S5VlmhnhDLQttK+945kiMBbQmyNTo85/
         mYOvSJk5bEde0KWpANIQ/87rQsR1F5GhuZuAQKCOurVGzdUJAbKUKLHrn3g2M+HRy4OV
         +ttrC7TICq4b5EtXIjQ/UJKVHGmt4OSGdcKa9cdWCXfQc23AxzTvTik8UiwMVI519ET7
         dCiMrBLvb8OF393v9zHkxy3OqaBir3JBeJa673A23OTKpfQpRtT5WaW7RAmka8XSdzlc
         z7SUBULdIgCqOHXiOqYlGeDP/pKA9+8Vsm8lHCppf5t+SBd9YDsKq84aV/ZNTY+4Bor7
         9veQ==
X-Gm-Message-State: ABy/qLafzq1ZNyi7F/uWisYcrwQc1jjZAqiTqmk/Y4Dr9XF+uVkm8d2P
        p7WHPcVOpYpMyRWl27mWtPiyFhdFChFhuTaNGfGLvNwuiL4TENrVmO5uBrL0A75t+ybvzlikZ6U
        bfRezTJwGEWQ9DdiIyym1BsEv
X-Received: by 2002:a05:622a:251:b0:403:2c71:3ac with SMTP id c17-20020a05622a025100b004032c7103acmr3215763qtx.0.1688665143468;
        Thu, 06 Jul 2023 10:39:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGIrVwBwkUyIKxW2YU5c9N4y7BwKpqmVhgcwOSLYf+V82LWVN/+E31wgze/mdwPbvyZ2mLIvg==
X-Received: by 2002:a05:622a:251:b0:403:2c71:3ac with SMTP id c17-20020a05622a025100b004032c7103acmr3215738qtx.0.1688665143225;
        Thu, 06 Jul 2023 10:39:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-43.dyn.eolo.it. [146.241.240.43])
        by smtp.gmail.com with ESMTPSA id s15-20020ac85ccf000000b00402913ecba3sm817639qta.34.2023.07.06.10.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 10:37:54 -0700 (PDT)
Message-ID: <f10c5eb17d6598def7ba17886e4e2e6e4aea07e0.camel@redhat.com>
Subject: Re: [PATCH] udp6: add a missing call into udp_fail_queue_rcv_skb
 tracepoint
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ivan Babrou <ivan@cloudflare.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        Satoru Moriya <satoru.moriya@hds.com>
Date:   Thu, 06 Jul 2023 19:37:50 +0200
In-Reply-To: <20230706172237.28341-1-ivan@cloudflare.com>
References: <20230706172237.28341-1-ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2023-07-06 at 10:22 -0700, Ivan Babrou wrote:
> The tracepoint has existed for 12 years, but it only covered udp
> over the legacy IPv4 protocol. Having it enabled for udp6 removes
> the unnecessary difference in error visibility.
>=20
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")
> ---
>  net/ipv6/udp.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index e5a337e6b970..debb98fb23c0 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -45,6 +45,7 @@
>  #include <net/tcp_states.h>
>  #include <net/ip6_checksum.h>
>  #include <net/ip6_tunnel.h>
> +#include <trace/events/udp.h>
>  #include <net/xfrm.h>
>  #include <net/inet_hashtables.h>
>  #include <net/inet6_hashtables.h>
> @@ -680,6 +681,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, str=
uct sk_buff *skb)
>  		}
>  		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
>  		kfree_skb_reason(skb, drop_reason);
> +		trace_udp_fail_queue_rcv_skb(rc, sk);
>  		return -1;
>  	}

The patch looks correct and consistency is a nice thing, but I'm
wondering if we should instead remove the tracepoint from the UDP v4
code? We already have drop reason and MIBs to pin-point quite
accurately UDP drops, and the trace point does not cover a few UDPv4
spots (e.g. mcast). WDYT?

Thanks!

Paolo

