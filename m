Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177E773E570
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjFZQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjFZQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB466E4C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687797731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=asxiZidzTKqbTTIG034hchvV0jRmIRYObF5XRhg78do=;
        b=U/z0VYm+uo9wVwuVLgbek0RjV9Ll2T7tA0c/BtWfCtAYP9dypOvL0/1gkhd83yKvxb09TP
        s5azall2qo19T+w2e7J/afffN8LFfAe73dVm/n2APUpV2ZGD3UCrKiumdMNr9i1b1Tp99f
        Ko2fRWgXBDiLxxj+2cOpEcWpmrf42Ig=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-SI0Zlbg_MtWB_qZ2IJO5vQ-1; Mon, 26 Jun 2023 12:42:09 -0400
X-MC-Unique: SI0Zlbg_MtWB_qZ2IJO5vQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-401df9d2dc4so1419121cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687797728; x=1690389728;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asxiZidzTKqbTTIG034hchvV0jRmIRYObF5XRhg78do=;
        b=XWKXjtvWyC27V3glcLKP0AnAk3DNjfsl9QfTDiNQvy9ThYr5/61ZF5NIvteMrbyKU/
         AmI6NRuPrry4+/+OJf+KCsGkIQCn+mUzcY3fYoylr7Sc8MduGtJsNV+Ij4y/KYslqCAz
         sUo1OlovwI1CcJsV6+HoD0JBncUyZQ2zv3XFtb4I/t7eL8aBq99CyELP92fH252JwTTJ
         xczZiyp/DTh15ADCKaOVS+KaUZemZMicWP8+cyy1YGLATTd6zYxl793gkiSwo27N93Oi
         L6vWgF/nBaL8FI0h2bqj8TPqF9fOHA2h05vCudtzIw2pz5tKTRiNWEMIrAH9cL09bVej
         fr8w==
X-Gm-Message-State: AC+VfDz+9q3G+8rjaKs2TFVfzyBn+evpYNsA9wuV5664p0eTuNJagXWU
        67k4L7aMtD+E36Q+qoaRs8M1NeJMGgmuHLHFaa7tcnyx9lR1aPsZ7rkONnw4Q2wOz+3t1sH7bPP
        6SRfjluHoQbY7LMH4bhiVRX0M
X-Received: by 2002:a05:622a:130e:b0:400:9ac5:e16e with SMTP id v14-20020a05622a130e00b004009ac5e16emr8444125qtk.5.1687797728127;
        Mon, 26 Jun 2023 09:42:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5I3CAeI8ca2wi5jtMkoY6xwiJKbr/NuY1Vge9snGy8/6GCXsGn93S3NFzjf2ojjaf+RnFiRg==
X-Received: by 2002:a05:622a:130e:b0:400:9ac5:e16e with SMTP id v14-20020a05622a130e00b004009ac5e16emr8444115qtk.5.1687797727830;
        Mon, 26 Jun 2023 09:42:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id m25-20020aed27d9000000b003f364778b2bsm3296930qtg.4.2023.06.26.09.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:42:07 -0700 (PDT)
Message-ID: <a766b45e26b465224fa5f0be721af147a8599fa7.camel@redhat.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ian Kumlien <ian.kumlien@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Jun 2023 18:42:04 +0200
In-Reply-To: <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
         <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
         <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com>
         <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
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

On Mon, 2023-06-26 at 16:25 +0200, Ian Kumlien wrote:
> On Mon, Jun 26, 2023 at 4:18=E2=80=AFPM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> >=20
> > From: Ian Kumlien <ian.kumlien@gmail.com>
> > Date: Sun, 25 Jun 2023 12:59:54 +0200
> >=20
> > > It could actually be that it's related to: rx-gro-list but
> > > rx-udp-gro-forwarding makes it trigger quicker...  I have yet to
> > > trigger it on igb
> >=20
> > Hi, the rx-udp-gro-forwarding author here.
> >=20
> > (good thing this appeared on IWL, which I read time to time, but please
> >  Cc netdev next time)
> > (thus +Cc Jakub, Eric, and netdev)
>=20
> Well, two things, it seems like rx-udp-gro-forwarding accelerates it
> but the issue is actually in: rx-gro-list
>=20
> And since i've only been able to trigger it in ixgbe i thought it
> might be a driver issue =3D)
>=20
> > > On Sat, Jun 24, 2023 at 10:03=E2=80=AFPM Ian Kumlien <ian.kumlien@gma=
il.com> wrote:
> > > >=20
> > > > Hi again,
> > > >=20
> > > > I suspect that I have rounded this down to the rx-udp-gro-forwardin=
g
> > > > option... I know it's not on by default but....
> > > >=20
> > > > So, I have a machine with four nics, all using ixgbe, they are all:
> > > > 06:00.0 Ethernet controller: Intel Corporation Ethernet Connection
> > > > X553 1GbE (rev 11)
> > > > 06:00.1 Ethernet controller: Intel Corporation Ethernet Connection
> > > > X553 1GbE (rev 11)
> > > > 07:00.0 Ethernet controller: Intel Corporation Ethernet Connection
> > > > X553 1GbE (rev 11)
> > > > 07:00.1 Ethernet controller: Intel Corporation Ethernet Connection
> > > > X553 1GbE (rev 11)
> > > >=20
> > > > But I have been playing with various... currently i do:
> > > > for interface in eno1 eno2 eno3 eno4 ; do
> > > >   for offload in ntuple hw-tc-offload rx-gro-list ; do
> > > >     ethtool -K $interface $offload on > /dev/null
> > > >   done
> > > >   ethtool -G $interface rx 8192 tx 8192 > /devYnull
> > > > done
> > > >=20
> > > > And it all seems to work just fine for my little firewall
> > > >=20
> > > > However, enabling rx-udp-gro-forwarding results in the attached ooo=
ops
> > > > (sorry, can't see more, been recreating by watching shows on HBO
> > > > max... )
> >=20
> > Where's the mentioned oops? Where's the original message?
>=20
> Held by the mailing list since i can only get a screenshot of it...
> Will attach the latest one to this email

That image is not very useful/does not provide a lot of relevant
information. Could you please use kdump/crash to collect a (decoded)
full stack trace?

> (I wish that i could easily get a larger backtrace but i haven't
> looked in further atm)
>=20
> > Can't this be related to [0]?
>=20
> Don't know, my main test has been running video streams in the
> background - eventually they cause a oops (within 40 minutes or so)
> But i doubt it's counted as tunnel data ;)

I read the above as you don't have UDP tunnels in your setup. Am I
correct?

Thanks,

Paolo

