Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF6B7484F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjGENaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjGEN37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE91723
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688563752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHqdHGePpqC3yYNk2DL1SaWLPtx1MBYVuRSI4Gok9W4=;
        b=Dcvolg7DB53+aZAlRmZ4jB9TqCNCAEZn2pKssxqdq59u3p5bfTblpGxTf+y1qMl0mr9XU1
        82ybmLoiq406wsElt6OY7TOqNJMFTk6OPHj34lABkjHLN81B0d8FQvAVFxk+Zasfk4tpU/
        Fghis490bJRG1B4T0cToOs75FhrZO8U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-SVzJCDveN4OW8BQlIzDTTw-1; Wed, 05 Jul 2023 09:29:08 -0400
X-MC-Unique: SVzJCDveN4OW8BQlIzDTTw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-401df9d2dc4so16273221cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 06:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688563748; x=1691155748;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHqdHGePpqC3yYNk2DL1SaWLPtx1MBYVuRSI4Gok9W4=;
        b=PEIiJ9SIb8Ayw+LfOoeHLkHIS4rIK3m9Kq0WpgQBKboyvlGXjZEs06wuXfamlKmEmN
         nIiSiwnZhycQSnOCzSHkzdGsGv0tqYkfGSVaOFCaFo11TWz9oqOBqK5wP4PtHdU/akZm
         o0cDo3KmLTOFvSThRKhXBJr5OaYOsOGwzMDhG6LrEaf4pB5SdnKT1exVxutbEF02Aje/
         uuQt7C7vKbY40OV7dYuLDbJDY+haAZrhkITShE2hKbtJa05iH9C9sd4sT0H5vH10F89S
         5ssGw/OVY22zcvRJvYk2ybAe0TnGLPMMJ+bCyyPeQNfbKVqxNmxc4DMMt7cpkKT+Yudv
         HbsA==
X-Gm-Message-State: AC+VfDzNRm0x25feiIzgCty3nlcTdSDVzQEsSwee5kFmKvRPIjG0ewtL
        NSKks/LV2H678mCEUyCnipsePJ9ycHt0BvZYKdqo0vp6wCR/ns44Tjrq5pJaV6nILtiztojs2Sm
        6rXx7gnEeJ/mqdmN2scyUQlq0UWyPkZCa
X-Received: by 2002:a05:622a:1895:b0:400:990c:8f7c with SMTP id v21-20020a05622a189500b00400990c8f7cmr22392523qtc.0.1688563748030;
        Wed, 05 Jul 2023 06:29:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62X9JsHoZCveZYUGcPACw/zB7DgpgPHX+6wLVD50UWEY3v0qArBGtMNDzVyNqun53gA+yjpA==
X-Received: by 2002:a05:622a:1895:b0:400:990c:8f7c with SMTP id v21-20020a05622a189500b00400990c8f7cmr22392507qtc.0.1688563747762;
        Wed, 05 Jul 2023 06:29:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-75.dyn.eolo.it. [146.241.249.75])
        by smtp.gmail.com with ESMTPSA id f3-20020ac80683000000b003ef189ffa82sm2961740qth.90.2023.07.05.06.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:29:07 -0700 (PDT)
Message-ID: <14cd6a50bd5de13825017b75c98cb3115e84acc1.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Jul 2023 15:29:04 +0200
In-Reply-To: <CAA85sZsidN4ig=RaQ34PYFjnZGU-=zqR=r-5za=G4oeAtxDA7g@mail.gmail.com>
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
         <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
         <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com>
         <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
         <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com>
         <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
         <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
         <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
         <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com>
         <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
         <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
         <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
         <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
         <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
         <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
         <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
         <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
         <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
         <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
         <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
         <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com>
         <92a4d42491a2c219192ae86fa04b579ea3676d8c.camel@redhat.com>
         <CAA85sZvtspqfep+6rH8re98-A6rHNNWECvwqVaM=r=0NSSsGzA@mail.gmail.com>
         <dfbbe91a9c0abe8aba2c00afd3b7f7d6af801d8e.camel@redhat.com>
         <CAA85sZuQh0FMoGDFVyOad6G1UB9keodd3OCZ4d4r+xgXDArcVA@mail.gmail.com>
         <062061fc4d4d3476e3b0255803b726956686eb19.camel@redhat.com>
         <CAA85sZv9KCmw8mAzK4T-ORXB48wuLF+YXTYSWxkBhv3k_-wzcA@mail.gmail.com>
         <CAA85sZt6ssXRaZyq4awM0yTLFk62Gxbgw-0+bTKWsHwQvVzZXQ@mail.gmail.com>
         <d9bf21296a4691ac5aca11ccd832765b262f7088.camel@redhat.com>
         <CAA85sZsidN4ig=RaQ34PYFjnZGU-=zqR=r-5za=G4oeAtxDA7g@mail.gmail.com>
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

On Wed, 2023-07-05 at 13:32 +0200, Ian Kumlien wrote:
> On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> > > More stacktraces.. =3D)
> > >=20
> > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > [  411.413767] ------------[ cut here ]------------
> > > [  411.413792] WARNING: CPU: 9 PID: 942 at include/net/ud     p.h:509
> > > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/udp.c:800
> > > net/ipv6/udp.c:787)
> >=20
> > I'm really running out of ideas here...
> >=20
> > This is:
> >=20
> >         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
> >=20
> > sort of hint skb being shared (skb->users > 1) while enqueued in
> > multiple places (bridge local input and br forward/flood to tun
> > device). I audited the bridge mc flooding code, and I could not find
> > how a shared skb could land into the local input path.
> >=20
> > Anyway the other splats reported here and in later emails are
> > compatible with shared skbs.
> >=20
> > The above leads to another bunch of questions:
> > * can you reproduce the issue after disabling 'rx-gro-list' on the
> > ingress device? (while keeping 'rx-udp-gro-forwarding' on).
>=20
> With rx-gro-list off, as in never turned on, everything seems to run fine
>=20
> > * do you have by chance qdiscs on top of the VM tun devices?
>=20
> default qdisc is fq

IIRC libvirt could reset the qdisc to noqueue for the owned tun
devices.

Could you please report the output of:

tc -d -s qdisc show dev <tun dev name>

Thanks!

/P

