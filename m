Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F32D74A724
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGFWle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGFWlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:41:31 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1C21723;
        Thu,  6 Jul 2023 15:41:29 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-440b54708f2so516692137.0;
        Thu, 06 Jul 2023 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688683289; x=1691275289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTdMw3U8BFFOt8MvAKiw/gzh8jNiphNZNfXymWqvTuk=;
        b=ILPQtduyeC9q2XK3+eksLVJDW/FwkgBS06MwLrr02VqB+BM4pm1jrcYvFASCd84UrV
         xbHm7SkMPgt35Vm6Z/OBsTK/NwM0reX6XJKIRIJjqrQy/E2ysBCzBto4EN62gUi+QnzV
         Sk9DeMslwnoIOMy3DNGnxd6LezTrF7QrJWTn3I0w6guIowqJ7yeDjMJra6gwTK9Lwzl0
         XkoWcL5BFZiOkcmnvUigP45I29zcDJhJ7MznVHuJL8TOJshTeJLhsg8IhSd6VCTNoC2I
         4aJy5vP6gbHp4KDzcuqlUm2zbv4S77xD275RicrabKMThqly8DlHafbdD458yiJu/LRT
         VrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688683289; x=1691275289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTdMw3U8BFFOt8MvAKiw/gzh8jNiphNZNfXymWqvTuk=;
        b=ZTi07JslytGQvwtyTBu0kDjXyfRlG8aiE1sVFRau9ZoRfJQS3sGpRunHVgkkEbrFW7
         NUiN2a3gKsMzTE71Gjvsgq2H5xKOxXLm6rMf/8Hg9Ryx/p6wvngzobyz4oQnANUYxDTT
         MBY23IYdx85RJxsaFc/rRCP1AuA05kTy3o7l/qnKZNDXMFkLTuxS9YffidpUXYSyArzy
         1RKf17OFTsbTGX8L1KpH6GBOTDcPKlYD5OOpWXPVkRfcAoGT43YHV05xTFa0CPJkLAM4
         b7ht1euDHWsvVR+fyBQgLMFSmFXP8q4VwPxi06JmuET6h7lm5BUf0X/E0TUeO62sd/fo
         bS0w==
X-Gm-Message-State: ABy/qLYDnw0ElnLmidUrnJw3IC/Bqsf7hHdUouLULgQ15BA6FMtLfDoS
        l1QdQn3yQYI3uBSjj7NrcHbDzGlqZF+kRLmBB/w=
X-Google-Smtp-Source: APBJJlFWJdnvIGxW1yz69F4Wz6zWB/6GqSmKeTa56imfQj63pHpVZUTVNV+VjYTOZq/SMs6YSRSQpB/Z68pv8seWOwI=
X-Received: by 2002:a67:e21a:0:b0:440:ab90:7c95 with SMTP id
 g26-20020a67e21a000000b00440ab907c95mr2813497vsa.9.1688683288738; Thu, 06 Jul
 2023 15:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com> <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com> <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
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
 <14cd6a50bd5de13825017b75c98cb3115e84acc1.camel@redhat.com>
 <CAA85sZuZLg+L7Sr51PPaOkPKbbiywXbbKzhTyjaw12_S6CsZHQ@mail.gmail.com>
 <c6cf7b4c0a561700d2015c970d52fc9d92b114c7.camel@redhat.com>
 <CAA85sZvZ_X=TqCXaPui0PDLq2pp5dw_uhga+wcXgBqudrLP9bQ@mail.gmail.com>
 <67ff0f7901e66d1c0d418c48c9a071068b32a77d.camel@redhat.com>
 <CANn89i+F=R71refT8K_8hPaP+uWn15GeHz+FTMYU=VPTG24WFA@mail.gmail.com>
 <c4e40b45b41d0476afd8989d31e6bab74c51a72a.camel@redhat.com>
 <CAA85sZs_R3W42m8YmXO-k08bPow7zKj_eOxceEB_3MJveGMZ7A@mail.gmail.com>
 <a46bb3de011002c2446a6d836aaddc9f6bce71bc.camel@redhat.com> <CAA85sZsHKb3Wtsa5ktSAPJsjLrcmahtgaemPhN5dTeTxEBWaqw@mail.gmail.com>
In-Reply-To: <CAA85sZsHKb3Wtsa5ktSAPJsjLrcmahtgaemPhN5dTeTxEBWaqw@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Fri, 7 Jul 2023 00:41:17 +0200
Message-ID: <CAA85sZtAixvRQnzs5+nad_pFsN9VZ67a2_CLCPFrHfieijn18A@mail.gmail.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
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

On Fri, Jul 7, 2023 at 12:32=E2=80=AFAM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
> On Thu, Jul 6, 2023 at 7:10=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> > Let me try to clarify: I hope/think that this chunk alone:
> >
> > +       /* later code will clear the gso area in the shared info */
> > +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> > +       if (err)
> > +               goto err_linearize;
> > +
> >         skb_shinfo(skb)->frag_list =3D NULL;
> >
> >         while (list_skb) {
> >
> > does the magic/avoids the skb corruptions -> it everything goes well,
> > you should not see any warnings at all. Running 'nstat' in the DUT
> > should give some hints about reaching the relevant code paths.

Ah yeah... I'm a bit tired atm - I see your point -  with moving it up a bi=
t.

So anyway, Tested-by: ian.kumlien@gmail.com etc =3D)
