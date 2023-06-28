Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B366741969
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjF1USx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjF1USp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:18:45 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122B91FE7;
        Wed, 28 Jun 2023 13:18:41 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-4409abccbefso85207137.2;
        Wed, 28 Jun 2023 13:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687983520; x=1690575520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pge0xg3Dy7GY8NiUP6kHgHtD5RV0kGRrdoTBXD750rI=;
        b=q3gLekqcwhHtKKWm74AP9KdYwthCek5udnq1vVf4deHQ805a5/56gNVv78Yx4eXHMi
         M3973ym+uOHrteChp6z7kSpRDxm3/WVEwR7TfbUoi0LKOWrjnYhUgL4ICdWv39eMJDWo
         E1B1/vVTDyjL6yFUlO0pkZYUQOgKoF62ULE9CrBI4NPwGbpWxU7zIzjHhLW5e0edw5Ib
         hA4kVGphaCTmRS6cordf7ToLCWoBur07+8djZWTYMjc/cYCf9FJBBNYORQArgrkcP2Uz
         7Wd+XxEdzZGrz6GmM3pepZ7L4k4subE/fF/+wMiQ4onuevlEeoA+O5kL2w7KWOqpsi8/
         1qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983520; x=1690575520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pge0xg3Dy7GY8NiUP6kHgHtD5RV0kGRrdoTBXD750rI=;
        b=hCVCGP109I4M84uspqKwv5iZPK1Q5y3PK1wBOjESvUv/QA7Mgo6rs7s9LhiFSkc/Tx
         Vii7YRpYtmyrVHYa70qN+UJRb8gv+uR0nVZHog2idlyOf1op+6/Ec80knIuNzWEyDuzk
         jJV3OMy9H1ZUPi7zn43mRDOasEaIC3D6gI50m/vZx0DB5RE7vVxljhsD8nCzSTzWa8tU
         Dm5lKsk9tQE8T3nEcJUAokT4vCPL4E3PWVzQZhkZIUv99vBZ+HPCCB1Pkm/Hv328cPqX
         LOpIY/yaPPUNnccPSeSAmH38sSHJbLCq7psoQeTb08mFgwPfBYV4qlw509IGb/TfpEeH
         RcLA==
X-Gm-Message-State: ABy/qLaWsOmCT0EavP8Xup7KbK61mKSGOJE/vrz5AcL8y+00cngGzXsJ
        Ty+jqDQ0m0+rhrkQq+rZjTphheQEy9DbyDBeekY=
X-Google-Smtp-Source: APBJJlELLQ0aF3ZB6zFPZmMkPIOWyEVArGwYVTvsJ8IIHALlnCzOcRKU+2UdwRlvJ2VLxhydXqFQcBuyy+/1BeIll3g=
X-Received: by 2002:a05:6102:11ee:b0:444:230e:e1e0 with SMTP id
 e14-20020a05610211ee00b00444230ee1e0mr241936vsg.29.1687983520011; Wed, 28 Jun
 2023 13:18:40 -0700 (PDT)
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
 <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com> <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
In-Reply-To: <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 28 Jun 2023 22:18:27 +0200
Message-ID: <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
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

On Wed, Jun 28, 2023 at 5:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Wed, 2023-06-28 at 14:04 +0200, Ian Kumlien wrote:
> > So have some hits, would it be better without your warn on? ... Things
> > are a bit slow atm - lets just say that i noticed the stacktraces
> > because a stream stuttered =3D)
>
> Sorry, I screwed-up completely a newly added check.

Thats ok

> If you have Kasan enabled you can simply and more safely remove my 2nd
> patch. Kasan should be able to catch all the out-of-buffer scenarios
> such checks were intended to prevent.

I thought I'd run without any of the patches, preparing for that now,
but i have to stop testing tomorrow and will continue on monday if i
don't catch anything

> Cheers,
>
> Paolo
>
