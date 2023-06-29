Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048CE742457
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjF2KwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjF2Kvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:51:36 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF03A35A7;
        Thu, 29 Jun 2023 03:50:58 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-440954dc5fcso194125137.2;
        Thu, 29 Jun 2023 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688035858; x=1690627858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Bc1SqEnFsskSLnHHMk9CYcfhixRzxz4BpTXdjjVyoI=;
        b=H5kYKgzRi3u4fLHhcDn3/9RT2+SXXz1L45No9cl2Up2JuZim36+ixeOpcKNsRrsQpQ
         XVSk4/XTl610ymeWvNNtDYD4icqSqrKzbByxbL1rkL0Xu9li0qynzBnL4czPkzEzh2y4
         rmEnLoJ0IIcW5o64XF9zMkUPb5sMYVr66ni+1R4ryOTyEFsdcByfvUxvbHDiVbrPC57P
         O6OyT4cvRzO3wa/g7tVg2dn4YakPO61TpxpM7+ngc8z4u1dUT0Q8PaLeFUBhcfDi+fzI
         I+G7QuTQro0yQ732af8DTzF3jVE/xkThSFHf2I7bIAZVLk0F9qJt2HrDoqCGN6kvQYCm
         AKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035858; x=1690627858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Bc1SqEnFsskSLnHHMk9CYcfhixRzxz4BpTXdjjVyoI=;
        b=JCZYTyJ19noACPcVtORHI5ZRMn6S/on7uYwFxcY9ayaRLiv0eyX+lefxW/yvEyMaCZ
         dECSGPD/r/Yr6FipUWRyTiDd3cJdJ32BczudZqTu8ujc9Gin7p28IHNhR7G1GQOnmC25
         x9sd/zwoxfhjy4lK7vaJnZLNghX1kGeWKhvkoAMy94+rbbUDe+yhagfOE9320t2MJArE
         4mhf1/OQD/UyOQWeL+5LKfcWJ48295GjsMg7SV2vccUFW+4PzxYu2V+Y7+56LHwYIS3n
         LigDFv68IYUM0kUvzKAPkOEKWQLZ5uH7OsKUyVush8T5k1KCFjiUyM50WBonBQOUQTRj
         UAxA==
X-Gm-Message-State: ABy/qLYz+PS24RdoTzm3VbJ3Vm5egK0a66oc5UMV7VX6jEtpr0fHdgPi
        L4bAPJ+Krj4vtkSh3A6d3MjBOPwLKx7kK6Wk24E=
X-Google-Smtp-Source: APBJJlEI+aDMiN1O2bKvv1N1CDEkTi6TIeFcVBvKGU9Za8J9APmDK/p2ETUabeXwv1eI5gPcw/3jX6FRYrhKDg+O0Ao=
X-Received: by 2002:a05:6102:e55:b0:444:c1f6:5e3a with SMTP id
 p21-20020a0561020e5500b00444c1f65e3amr367807vst.25.1688035857761; Thu, 29 Jun
 2023 03:50:57 -0700 (PDT)
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
 <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com> <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
In-Reply-To: <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 29 Jun 2023 12:50:45 +0200
Message-ID: <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
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

On Wed, Jun 28, 2023 at 10:18=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com=
> wrote:
>
> On Wed, Jun 28, 2023 at 5:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On Wed, 2023-06-28 at 14:04 +0200, Ian Kumlien wrote:
> > > So have some hits, would it be better without your warn on? ... Thing=
s
> > > are a bit slow atm - lets just say that i noticed the stacktraces
> > > because a stream stuttered =3D)
> >
> > Sorry, I screwed-up completely a newly added check.
>
> Thats ok
>
> > If you have Kasan enabled you can simply and more safely remove my 2nd
> > patch. Kasan should be able to catch all the out-of-buffer scenarios
> > such checks were intended to prevent.
>
> I thought I'd run without any of the patches, preparing for that now,
> but i have to stop testing tomorrow and will continue on monday if i
> don't catch anything

So, KASAN caught the null pointer derefs, as expected, but it caught
two of them which i didn't expect.

Anyway, I'm off for the weekend so, I hope to be able to send
something better on Monday, fyi

> > Cheers,
> >
> > Paolo
> >
