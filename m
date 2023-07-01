Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1919744A5F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGAPv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 11:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGAPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:51:54 -0400
X-Greylist: delayed 4891 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Jul 2023 08:51:52 PDT
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253B82683;
        Sat,  1 Jul 2023 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688226707;
        bh=Ou1vBhUK87QUl5Q7dSsJPlf9T8VgS2NFf1k7CSQDkDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=InzfP/PjalXsy1+062ZbHDH7LNSpAlZb/OGrkFlT6ZDcVxJ4s6E21Y0Jh5QIZW12E
         8Q6ikCFwk6a7xFshJF2ClUrLspmGWaAzCwUa7DR26CeBpg0R82CYdvizzsxYzyHwiD
         EroHbCc8jD++VaWGfM/AMg/i+2aX4+bzXi2cjbQE=
Received: from localhost.localdomain ([116.132.239.178])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id CEC3EC5C; Sat, 01 Jul 2023 23:51:44 +0800
X-QQ-mid: xmsmtpt1688226704te5jbpodh
Message-ID: <tencent_62EE5604188B87B14220EA91C4CD8D4C2D06@qq.com>
X-QQ-XMAILINFO: MBf0q8AysQnB9O7sZj5jgSNUnizJ7WyO6idPxUw5LGBRfADxCatimjS8frcO53
         OYG4ZoWqWzofoy5ziRmfTupTo+9SoOjDeAa2XX9YKT/v6+RqbSpF9nfPC/dGXC4N5shyi5gUCwOT
         onoHlWGeP9TLE3B6807xVCxkhTgd3gCIDZMm2wgDX5qq7cBSJjjDTJD+DhgAIWj3ijzYA8OazRjZ
         hCcsv3ngIQWuWZ0JSLmHwZ0UTSQCQ+9gatNz0ByQexx5wiifL6/U5IQ7aBk3ePXUrbKuGItZ/hth
         J0HU4mV5UX8OkRfpsjypjuHOye9svDBiMghR4ItEpq2kZmcX/kuf80ic6deCMBP6ElKiIBP9ff1M
         4lOyjJfPUA9x/gXw+ENR6TGd92i29BwXM/DgZkKAqY8DUCD/yZ3yW2123KA9L3yVAbe94o2uKMzD
         OMRE+Re8ojaYsncs3JXQn+bYECgh2lMahvq6+QCkbEuT7Xp8xqlQ5jQgmTO2RvZWIJaOSknu1Jnr
         9zgUDCBhqd0kM0AVy2PG2RsWQYFXmpk/nTTyhbSMz0mcugnZurXaV+Zalva/b+Z1rWGRSlmaHFG5
         Nt4yPNg2xE5TQM5F0EOzRFkYY3z/EX45mBDeOQOayUqoRYNAr1XMUUeLW/1K4uMQ5vyErjZktHTT
         W5/dU7km1Hhw9eV1NMOvr6ebUdby4tj5Cre0paw+bqbVT+FxVEZ10nqTEPGgnPFF7CU7dg6ldQ+N
         BSVtP0u4M1PgcSaSx9O3vGFeCPowRXKZFUVilSO/Kg+reSKEHWpHGSvM931iETynrTcFIgaMb5sV
         uNWHwK/TtGkrB72YjZYAaZ4s/r91k4vXQb4o3gxi1hfa9DP4mGcVtTTZHXL2ujyaM38vMmB8EbF9
         Ys7lowKPVSCv27wAE8K5uFPml5MLKQ+1/R2VHsVSEI06yNT6ndWmX2YHu27XEtRV/qRxg7QRs8mF
         29XvdMS3b9UjAGJ9Pz/mO2TCWkoQvKZvrnJAhicjk1Ja1cW6BfCg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jgross@suse.com, xen-devel@lists.xenproject.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen: fix potential shift out-of-bounds in xenhcd_hub_control()
Date:   Sat, 01 Jul 2023 23:51:43 +0800
X-OQ-MSGID: <4825193.GXAFRqVoOG@localhost.localdomain>
In-Reply-To: <2023062628-shame-ebook-56f2@gregkh>
References: <tencent_15DD79B42AD8A0D64A7CDC24D4FE6C85800A@qq.com>
 <1c8ff405-2bfe-37ff-42ba-aa4f81853475@suse.com>
 <2023062628-shame-ebook-56f2@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023=E5=B9=B46=E6=9C=8826=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=80 CST=
 =E4=B8=8B=E5=8D=881:52:02=EF=BC=8C=E6=82=A8=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, Jun 26, 2023 at 07:48:05AM +0200, Jan Beulich wrote:
> > On 25.06.2023 18:42, Zhang Shurong wrote:
> > > --- a/drivers/usb/host/xen-hcd.c
> > > +++ b/drivers/usb/host/xen-hcd.c
> > > @@ -456,6 +456,8 @@ static int xenhcd_hub_control(struct usb_hcd *hcd,
> > > __u16 typeReq, __u16 wValue,> >=20
> > >  			info->ports[wIndex - 1].c_connection =3D=20
false;
> > >  			fallthrough;
> > >  	=09
> > >  		default:
> > > +			if (wValue >=3D 32)
> > > +				goto error;
> > >=20
> > >  			info->ports[wIndex - 1].status &=3D ~(1=20
<< wValue);
> >=20
> > Even 31 is out of bounds (as in: UB) as long as it's 1 here rather
> > than 1u.
>=20
> Why isn't the caller fixed so this type of value could never be passed
> to the hub_control callback?
>=20
> thanks,
>=20
> greg k-h
Although I'm not knowledgeable about the USB subsystem, I've observed that =
not=20
all driver code that implements hub_control callback performs a shift=20
operation on wValue, and not all shift operations among them cause problems=
=2E=20
Therefore, I've decided to fix this issue within each driver itself.

=46or example, in r8a66597_hub_control, it will first check whether wValue =
is=20
valid (always < 31) before the shift operation. In case of an invalid numbe=
r,=20
the code would execute the error branch instead of the shift operation.

switch (wValue) {
case USB_PORT_FEAT_ENABLE:
	rh->port &=3D ~USB_PORT_STAT_POWER;
	break;
case USB_PORT_FEAT_SUSPEND:
	break;
case USB_PORT_FEAT_POWER:
	r8a66597_port_power(r8a66597, port, 0);
	break;
case USB_PORT_FEAT_C_ENABLE:
case USB_PORT_FEAT_C_SUSPEND:
case USB_PORT_FEAT_C_CONNECTION:
case USB_PORT_FEAT_C_OVER_CURRENT:
case USB_PORT_FEAT_C_RESET:
	break;
default:
	goto error;
}
rh->port &=3D ~(1 << wValue);





