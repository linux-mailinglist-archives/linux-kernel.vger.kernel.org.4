Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561D97426A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjF2Mjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjF2Mja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9C2703
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688042321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eyjed+n6vJ2GKQu5IWKEiyVp5EbB8rMW7EJ9oglJpcs=;
        b=etpxNrBrZBhhGHQfWW/TMYf5x+o3hooFdC0ebqSa8vv4KDymaCaX/bzHn+N1RxkNarGR7Z
        tqXrhtqBdj+PgyZSUt700qx3CSGiLZrYLL8jK2PHexgPw5HGjDa8bPo/cxaH/jVH/jTWPi
        so0OO5/LDwsJEBJU7W3MLbSY/0qvKLg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-qtx276piNWGFvAK5hacX4Q-1; Thu, 29 Jun 2023 08:38:40 -0400
X-MC-Unique: qtx276piNWGFvAK5hacX4Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76721ad9ed7so13672485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042320; x=1690634320;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eyjed+n6vJ2GKQu5IWKEiyVp5EbB8rMW7EJ9oglJpcs=;
        b=LXMeqAB2aMkypOjqp58y1bxcR1F8BlhoD7VHPWyhNf5pu5mHMxzmLc8VdSsPqomoPW
         2bhYIJjtLd3Cw8Zuj8HI7Jwz58O+wMx76ZnXx6X5MH6BBnPgJko5RXimlx8BzINsRHzE
         zdTT83oQWqartxqhM3oevFOaQsmZwkfVrrQKtA8WAcaTAgVkCOwNzouh+FXbT9ywbKgg
         yBZiJGjQEv3L0yOdXxMlw4TdFgjD2ByaqChLPMjfo5Ki1jUpGJ18iIoaCyn0Rw/lnTlo
         GB8Vev7kAs6F8Q6uvI/pG2JyHLdX6Vftp5kjE6LQtbSLsBNjisXoWBD4Gj1YUhHLD2F/
         lM8A==
X-Gm-Message-State: AC+VfDyuc6G68WCfMLQ4Ovmwx9Qa2/aZy3iDt5cBjVNPk0+0jKBItxWr
        cLLRZ7P3x9/SoP3c9HkT6W4xsbQqKr6Xa8/5mf6a2Re+1E2BXi40kj2gyYksoFxSxXaKPXNxq8/
        R5s/ivKNk75yyqwxC+AjdRCua
X-Received: by 2002:a05:620a:2a13:b0:762:41d6:c3dc with SMTP id o19-20020a05620a2a1300b0076241d6c3dcmr50289606qkp.0.1688042319848;
        Thu, 29 Jun 2023 05:38:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ThMNPYxWx8urdYfE3Ljj3ILrdnC9+Z11L9FWiMBmDEx49tx+y0HEXiZETIiDlQyjMoZwwiw==
X-Received: by 2002:a05:620a:2a13:b0:762:41d6:c3dc with SMTP id o19-20020a05620a2a1300b0076241d6c3dcmr50289573qkp.0.1688042319516;
        Thu, 29 Jun 2023 05:38:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-196.dyn.eolo.it. [146.241.231.196])
        by smtp.gmail.com with ESMTPSA id 20-20020a05620a071400b007671cafbf5csm1940570qkc.85.2023.06.29.05.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:38:38 -0700 (PDT)
Message-ID: <756bda986e5b9946e2035926dc0370d14138fd20.camel@redhat.com>
Subject: Re: [PATCH v2 net 1/2] net: dsa: sja1105: always enable the
 INCL_SRCPT option
From:   Paolo Abeni <pabeni@redhat.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Date:   Thu, 29 Jun 2023 14:38:35 +0200
In-Reply-To: <20230629101950.7s3kagwvkzlnu7ao@skbuf>
References: <20230627094207.3385231-1-vladimir.oltean@nxp.com>
         <20230627094207.3385231-2-vladimir.oltean@nxp.com>
         <f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com>
         <20230629101950.7s3kagwvkzlnu7ao@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-29 at 13:19 +0300, Vladimir Oltean wrote:
> On Thu, Jun 29, 2023 at 11:36:38AM +0200, Paolo Abeni wrote:
> > > The big drawback with INCL_SRCPT is that it makes it impossible to
> > > distinguish between an original MAC DA of 01:80:C2:XX:YY:ZZ and
> > > 01:80:C2:AA:BB:ZZ, because the tagger just patches MAC DA bytes 3 and=
 4
> > > with zeroes. Only if PTP RX timestamping is enabled, the switch will
> > > generate a META follow-up frame containing the RX timestamp and the
> > > original bytes 3 and 4 of the MAC DA. Those will be used to patch up =
the
> > > original packet. Nonetheless, in the absence of PTP RX timestamping, =
we
> > > have to live with this limitation, since it is more important to have
> > > the more precise source port information for link-local traffic.
> >=20
> > What if 2 different DSA are under the same linux bridge, so that the
> > host has to forward in S/W the received frames? (and DA is incomplete)
> >=20
> > It looks like that such frames will never reach the relevant
> > destination?
> >=20
> > Is such setup possible/relevant?
> >=20
> > Thanks,
> >=20
> > Paolo
> >=20
>=20
> They will have an incorrect MAC DA, with all the consequences of that.
>=20
> Given the fact that the incl_srcpt was enabled up until now for the
> vlan_filtering=3D1 bridge case only, this was already possible to see.
> However it was never reported to me as being a problem, unlike what
> is being fixed here.

Ok, the above sounds like a good enough reply to me.

> I see no other escape than to unconditionally enable the send_meta
> options as well, so that the overwritten MAC DA bytes can always be
> reconstructed from the upcoming meta frames, even though the RX
> timestamp (main payload of those meta frames) may or may not be useful.
> Doing that might also have the benefit that it simplifies the code,
> removing the need for tagger_data->rxtstamp_set_state() and
> tagger_data->rxtstamp_get_state(), because with that simplification,
> the tagger will always expect meta frames.
>=20
> Because of the lack of complaints, I was considering that as net-next
> material though.

[I'm mixing replies to your 2 emails here, I hope overall this is still
human parsable ;) ]

Quickly skimming over the patch you shared I *think* it could be -net
material, too. Given the mentioned lack of complains for the potential
issue, I think it could be a follow-up to this series.

I'm applying it right now.

Thanks!

Paolo

