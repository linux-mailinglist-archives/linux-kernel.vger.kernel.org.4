Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382EC699038
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjBPJl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjBPJlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:41:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1BD5354D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676540320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36IspvOq5C8RXOS38qc3JuiH0YGViv6osI/6F1CJ7uY=;
        b=dgLA9gGLZpXD3ULdP7TzkUsSH2Ic+/nUdmCCplYdXr6lWUfUsloOU7YOfDP9qGiq4p22u6
        dQ/3imsRswfsWpchA4XJhSyGx1cMZuMoLojwALX9ajGh/J7bPNawblORViNy8xYWpsjGfp
        uKxwP6HzHBKR7zHDMKBVtxH8trQxcQ4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-iL0Hjr3ENRau7YwPVNzU7g-1; Thu, 16 Feb 2023 04:38:38 -0500
X-MC-Unique: iL0Hjr3ENRau7YwPVNzU7g-1
Received: by mail-qv1-f69.google.com with SMTP id f1-20020ad442c1000000b0056c228fa15cso791330qvr.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36IspvOq5C8RXOS38qc3JuiH0YGViv6osI/6F1CJ7uY=;
        b=CmMgigfVvrqcuf3FOmcWsnIq42dk39GgeAJpJ6/nqeluEKYHjlqzbBTcjcyFYMZ5UY
         gq4KEWyZFWHoU0fQ+TwWlBbSexDQD36ki2RA9ci1oH27+9b3zeIWgcas4U0Lqd0mtB74
         3tpXVNvd8082HkAsEAsfCKKnJQMRyZY37U+nQ38AGvXpZBO9ly9AvB29QXDLay00a7KL
         wAlZcapa1PxPo4FL4ABHP5osxw63ssHRE0nwaDCPYGEtQkNz+ayl0wp8C0vSJBlMmI8o
         NulyDdx1qUV+1n3OEYmq1OPpkPUYVvLJ6J2w6AxnMCzVaIykSij762x5HTO7Vo7tX6uV
         Vmeg==
X-Gm-Message-State: AO0yUKXI86FUrpjhHgPLpuuZ26gCF7WWGbJeinzz6tX6LrpCJ2t7yGyk
        TMFHV2cxfzMKbe3y/5Xl/TYWHKztI6y+u7JU2i5xiCD9NtH1cKs5SiobObx9ZtexDWxv8q70hZn
        rXkt7vA0F6IPvB5qOEgywoxWV
X-Received: by 2002:ac8:5c0a:0:b0:3b8:ea00:7020 with SMTP id i10-20020ac85c0a000000b003b8ea007020mr10583393qti.3.1676540317957;
        Thu, 16 Feb 2023 01:38:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9fkk6LQl+h44sHpB9zu9O6TvieRws0v5eZvlj0OQpL13QYqihAYz9B4yVTgv7qHTKAEf5AcA==
X-Received: by 2002:ac8:5c0a:0:b0:3b8:ea00:7020 with SMTP id i10-20020ac85c0a000000b003b8ea007020mr10583375qti.3.1676540317589;
        Thu, 16 Feb 2023 01:38:37 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id o7-20020ac80247000000b0039cc0fbdb61sm919873qtg.53.2023.02.16.01.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 01:38:36 -0800 (PST)
Message-ID: <1a5c9e46457a2c515a5d28895844b523ea8315bc.camel@redhat.com>
Subject: Re: [PATCH net-next v2 06/10] net: microchip: sparx5: Add ES0 VCAP
 model and updated KUNIT VCAP model
From:   Paolo Abeni <pabeni@redhat.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     UNGLinuxDriver@microchip.com, Randy Dunlap <rdunlap@infradead.org>,
        Casper Andersson <casper.casan@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Machon <daniel.machon@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Dan Carpenter <error27@gmail.com>,
        Michael Walle <michael@walle.cc>
Date:   Thu, 16 Feb 2023 10:38:32 +0100
In-Reply-To: <e3ab2825bcb0ae93fd26a35dcaee91224ecadc0b.camel@microchip.com>
References: <20230214104049.1553059-1-steen.hegelund@microchip.com>
         <20230214104049.1553059-7-steen.hegelund@microchip.com>
         <0b639b4294ffa61776756d33fc345e60a576d0ec.camel@redhat.com>
         <e3ab2825bcb0ae93fd26a35dcaee91224ecadc0b.camel@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-16 at 10:07 +0100, Steen Hegelund wrote:
> On Thu, 2023-02-16 at 09:09 +0100, Paolo Abeni wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the
> > content is safe
> >=20
> > On Tue, 2023-02-14 at 11:40 +0100, Steen Hegelund wrote:
> > > This provides the VCAP model for the Sparx5 ES0 (Egress Stage 0) VCAP=
.
> > >=20
> > > This VCAP provides rewriting functionality in the egress path.
> > >=20
> > > Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> > > ---
> > > =C2=A0.../microchip/sparx5/sparx5_vcap_ag_api.c=C2=A0=C2=A0=C2=A0=C2=
=A0 | 385 +++++++++++++++++-
> > > =C2=A0.../net/ethernet/microchip/vcap/vcap_ag_api.h | 174 +++++++-
> > > =C2=A0.../microchip/vcap/vcap_api_debugfs_kunit.c=C2=A0=C2=A0 |=C2=A0=
=C2=A0 4 +-
> > > =C2=A0.../microchip/vcap/vcap_model_kunit.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 270 +++++++-----
> > > =C2=A0.../microchip/vcap/vcap_model_kunit.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +-
> > > =C2=A05 files changed, 721 insertions(+), 122 deletions(-)
> > >=20
> > > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api=
.c
> > > b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.c
> > > index 561001ee0516..556d6ea0acd1 100644
> > > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.c
> > > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_ag_api.c
> > > @@ -3,8 +3,8 @@
> > > =C2=A0 * Microchip VCAP API
> > > =C2=A0 */
> > >=20
> > > -/* This file is autogenerated by cml-utils 2023-01-17 16:55:38 +0100=
.
> > > - * Commit ID: cc027a9bd71002aebf074df5ad8584fe1545e05e
> > > +/* This file is autogenerated by cml-utils 2023-02-10 11:15:56 +0100=
.
> > > + * Commit ID: c30fb4bf0281cd4a7133bdab6682f9e43c872ada
> > > =C2=A0 */
> >=20
> > If the following has been already discussed, I'm sorry for the
> > duplicates, I missed the relevant thread.
> >=20
> > Since this drivers contains quite a bit of auto-generated code, I'm
> > wondering if you could share the tool and/or the source file, too. That
> > would make reviews more accurate.
>=20
> So far we have not made the tool (CML-Utils) available online, but it is
> included as zip archive in our quarterly BSP releases which are available=
 on
> AWS.
>=20
> The BSP uses it (via Buildroot) to generate register access header files =
and
> VCAP models as well as compiling various test tools that are added to the
> rootfs.
>=20
> It is not because we want CML-Utils to be secret that it is not online, b=
ut
> rather that we want to be free to update/change/remove features as needed
> without breaking any build processes that might have been relying on thes=
e
> features with our customers.

I guess the above could be addresses with proper releases (and possibly
packetization from main distros)

> I would expect that CML-Utils will eventually have its own public repo, b=
ut it
> is probably a little too early yet.=20

Understood. Looking forward the tool maturity ;)

Cheers,

Paolo

