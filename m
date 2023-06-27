Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D7373FC2D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjF0MwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0MwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25D826BA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687870281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VBXBjZTvnK2Wk6THBLyuE1SAvZbYMw379uCbCug7dM=;
        b=O8vtjDCjg03k5zsEaLLRvFyFpiXq4dRTLpvZucAfyIC+JyeSX3YW7offcFa68E8q3OoewL
        JLtarMRsQk/MaVgRRJKTQyrq08z1Mj7xgCc+r27eDftiH1G4eay2z3b0O7XlKwwkuI8L7X
        ENDJqAqTt33nmoFptipkAxh6tDwYk6Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-PhUMrcKyO0GB2VKrbaM43g-1; Tue, 27 Jun 2023 08:51:16 -0400
X-MC-Unique: PhUMrcKyO0GB2VKrbaM43g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635e2618aaeso3217796d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687870276; x=1690462276;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VBXBjZTvnK2Wk6THBLyuE1SAvZbYMw379uCbCug7dM=;
        b=LjDwLI9U0bf2uE53ByQln/V1q9aUxh+03E0iY4kcaglfRdWGzJTD4xCKDkUfYQVSNn
         ErIF1AtRQYwrcxMEU6nCruRI6lbi+eBKxjwMX7IQ2NWZ5sJ6/XGfjJzDrTKig2rpdc1L
         M8muPcQl4w7fTdqnzhkYLFZz3Gb4CL0QOp6pTsE60zFGFdHmnAda5f7R9MZ9fYQclBsy
         S4fpYqqRurRPEjb7NfumBI6qAzQTnxV9Cd+ya3gt4l3piD7YIG3dZsj2SyXa4Up4it+i
         pMTwSl/1OiHTeDKO4ir+QwELePHXj7XqZRUG6/iz/UYC3zBrsiWWR5D6zC6rneu4PwxB
         LJbw==
X-Gm-Message-State: AC+VfDwOGZG3BoT1FQxif2Ys3nQYZtNEDeICErGSZT0bJ5GZnJix4gmq
        XL11mIN1DPozKjYrbqg9gAW/gPoexgDaaV7JqlBQqUwHr6dXsqsg947Jk24+cS0nacvtSLgLG/v
        13uxkRLElWcy3xmFgfEBX7Ecm
X-Received: by 2002:ad4:4eec:0:b0:635:ec47:bfa4 with SMTP id dv12-20020ad44eec000000b00635ec47bfa4mr2878237qvb.4.1687870276523;
        Tue, 27 Jun 2023 05:51:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gTWjIfL+wjZmdsUf7JwLTLQZrg6rwPJR/TQXtOCe/Cf6jCLoU+HW/e0eIxubgQP4k7rQzpg==
X-Received: by 2002:ad4:4eec:0:b0:635:ec47:bfa4 with SMTP id dv12-20020ad44eec000000b00635ec47bfa4mr2878221qvb.4.1687870276281;
        Tue, 27 Jun 2023 05:51:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-6.dyn.eolo.it. [146.241.239.6])
        by smtp.gmail.com with ESMTPSA id mz14-20020a0562142d0e00b006300e92ea02sm4478170qvb.121.2023.06.27.05.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:51:15 -0700 (PDT)
Message-ID: <b0a0cb0fac4ebdc23f01d183a9de10731dc90093.camel@redhat.com>
Subject: Re: Is ->sendmsg() allowed to change the msghdr struct it is given?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 27 Jun 2023 14:51:12 +0200
In-Reply-To: <20230626142257.6e14a801@kernel.org>
References: <3112097.1687814081@warthog.procyon.org.uk>
         <20230626142257.6e14a801@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-26 at 14:22 -0700, Jakub Kicinski wrote:
> On Mon, 26 Jun 2023 22:14:41 +0100 David Howells wrote:
> > Do you know if ->sendmsg() might alter the msghdr struct it is passed a=
s an
> > argument? Certainly it can alter msg_iter, but can it also modify,
> > say, msg_flags?
>=20
> I'm not aware of a precedent either way.
> Eric or Paolo would know better than me, tho.

udp_sendmsg() can set the MSG_TRUNC bit in msg->msg_flags, so I guess
that kind of actions are sort of allowed. Still, AFAICS, the kernel
based msghdr is not copied back to the user-space, so such change
should be almost a no-op in practice.

@David: which would be the end goal for such action?

Cheers,

Paolo

