Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3DC71472D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjE2Jj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Jjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:39:55 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2094.outbound.protection.outlook.com [40.107.113.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EF90;
        Mon, 29 May 2023 02:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJjz5wugBx5z3izpdNoC15Thqoq6FckPApP28GCA4aJzEx8MX7vpUClGOvcqjXaHQA/l9iTiA7mZyDY1iZUfHSd4xzyp8mV4CrRN2evNFW4yci3UzH7TdgriXAXCGupVO+Ml6GR9BZfS5s/BclZg6qaMjs0nXpooArSTXwPKgCt2Dnyv50r2oCjMJXxsXpFBcZYhanD8DWEcQsZAkX2+jqEjDLp1GKwFkDFPYIF+q9LDYsKBwwwRqUFOEfgS6V7c0ftKOt35cSvWKtCDnsp+Wr3dNU6RdcZruEeSxm8NW5MoQF2/E6Sw7l/X6Ff5R7isDIID0c9sZd/ceD/C5t3dKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ykU/S7leHps0SBT24y6afbKsQVJHpxACI+Jx1rCb1c=;
 b=RawmDBODO0qRT7QcI36fXNVZEBIQPXDrVJ/9FuQmo3+gbhYVwBQTF4elWZ0EmsdCRLuk2Eaec3ZfabIcXDJ0hfJRIgT6EF8zQvKCaLOJWlFNvQbacMRJqhckcads/Yux3gTw1XiYiz9Ei3YOI4yyPZbyewlZ9+i5BEM8qtOe7qERQlH3hgFUruyjLBHqV7CLNAhMa5PPuio0sA9V/xX75OVqlstJm0bKt1Cj+B2tcaDqpH9yWgj9OJZcFF5fehtqo9PY4FZ7fcZLQP651M60uhFeyQJ9V9n5hPbvjKe2tR2zBMk5rf0Yc61NQqIufOdwUPHmu+Po7toXxiQgZAoaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ykU/S7leHps0SBT24y6afbKsQVJHpxACI+Jx1rCb1c=;
 b=klCkxglLyrUC5Bogjca7C37+er4gXt4TLA4nNsN9prF89C2y0gseghGFtODRDXnrqtcoAvzcZo4SZxJwFPEj5I8aU9XLb4pSMrp+kH5CtgtO4h7ifUO0opjcRlbRtf8T0H7ZMsUuON/oVhHjXieccighKfwxgsvuurK8KTW7X9M=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8090.jpnprd01.prod.outlook.com (2603:1096:604:170::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:39:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 09:39:50 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Wang <zyytlz.wz@163.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Index: AQHZj99wvrGBFYOn5Ea9mIuOTwGccK9wyqwAgAAi9sCAAA05gIAAAIqA
Date:   Mon, 29 May 2023 09:39:50 +0000
Message-ID: <OS0PR01MB59227E69FF1DE67327BDEF77864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230526143615.372338-1-biju.das.jz@bp.renesas.com>
        <20230529061714.GA25984@pendragon.ideasonboard.com>
        <OS0PR01MB592296756992262EC6D382D0864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <86bki3cxm2.wl-maz@kernel.org>
In-Reply-To: <86bki3cxm2.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8090:EE_
x-ms-office365-filtering-correlation-id: b8ada246-c49a-4625-1834-08db6028a601
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAVv+FsGECG76X6VIsS0p6wA21L09W/jV5WXXDqY+mAHvybLP7rYKIk7EAuePBHzwHJsW+QYq71hwZm22p9D69+oHHYwMHUX7DLkCfQhyMZY5QMdyh8dB6/QuYxr15s2lf8V54/IHCUYqHa63PPytd5RENGwG+fiIq2d2n8UljKJJIXxS62Klhjho8pyL6VU0guyB9kMJKJ+Eb8qyoiYw2H2CgSsS/L71RxMGI9uxqGzfwxu9B8QpMyobMGQP7XM2+K1MV3TPlQt7oxR/TTetxuqOxTJk8xvUI2o/IwnB3V5j5OJrkpZ/rPSrMuMFnGCfUntUg+iIO3plWfZEPz6ZtQABA7V8q8RlAsCLCglbXdwrmsk5kApBfVFfeLYw9/g0AnIW/JUx5KyDKDecSkeMYn0Xw6ZXcKfBqYWCKY9dmfhwGbiyhQcZjvcLBj4yD0pfKQVtyk+8DmVd0eBw1PFQRnAM0tOmZ5emwm+LXLcsmf+IWMInL6X0UAew/mlIfjN6M1qDAPmzw7S6prmUikvOXf6fZDpP70CS7s6ek5sQQ08T42E5uQ8LLBia9kI8LBK9mYSTh41fAzYE9wl9aPlKbOCGgVI25o/ixFMgrLK3HImemJ5y6AmF4MCtDAiQJqf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(66946007)(7416002)(76116006)(4326008)(6916009)(64756008)(66476007)(66556008)(66446008)(52536014)(83380400001)(5660300002)(86362001)(41300700001)(38100700002)(186003)(8936002)(7696005)(8676002)(2906002)(122000001)(55016003)(38070700005)(71200400001)(316002)(6506007)(26005)(33656002)(478600001)(54906003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c0/tALGwY9OZyHYDC/tHD2tJgIZjh2MhrQN2y44fr0SjVJSQWb0Fo5hNxVcb?=
 =?us-ascii?Q?TPTPnsOsStRVy4kJ52d99S1rzlhOFyFuH+Q94ODM15MVBdvE6J5tC24B9z4G?=
 =?us-ascii?Q?u+uucaSItukexv/LtrT6ZCBOaGdrqjgMN6SeMQs2t2yeqTqeB2G58ZxYUNhN?=
 =?us-ascii?Q?0KfS/Y6FBilt88aEMRgp+qTyDVEOHXAxFYA4VK96Nno37hhmkZcAi31LlO/A?=
 =?us-ascii?Q?Wcy8/oFlO9jLYf6VU/6X1OokgvSObImkWB0tKHuZ/S40gxKVhD91DAG+E7JZ?=
 =?us-ascii?Q?ksA2BIGjkd3gJYpUDPgrwAt5+B6cHNdBV0TI7DcGA3AijGnIZ8mMjifU0VVm?=
 =?us-ascii?Q?/50R70W10oZ+fkkxMcHl1tnpVPEpdHUvY/lkabD3tacYzHZWZ4V1A8i7UyhF?=
 =?us-ascii?Q?JTGQqo5b9IyvbWUgZ+XaACN5l/kPjHfqEm2d0qXODPuatpmbTUFaUCRLzDH8?=
 =?us-ascii?Q?qG7S6JtcEE4pU3tpzOkjAKsFc6v17C9k0r8IKS1519dHnn1el9FGHJynpezl?=
 =?us-ascii?Q?mPwrRiHW1BMab/Uph3k0Uez16GGAO8Y2nqZ6EoIScyGr6YAvSyaXKmgHfkTm?=
 =?us-ascii?Q?eck9cz1PfyM0PvGQK1huAtIiPaqnih0cBo8UauB6lOu4eqG74H23yBqdLeAk?=
 =?us-ascii?Q?2P0M9G0swgREkiH2Z2bMAs1WHQLv4ALYAspq23n8DoZXjrFtY6cegjuByRQi?=
 =?us-ascii?Q?QxFi7Qm7a86FgTLXqZ15Cs9MgaaO1M/Ja6vE0g1VfHQvJ6/X1X8BLFsrgsho?=
 =?us-ascii?Q?TDpNYSwZk88Mu+umsk0We+2188f73N1gWnlCMlwt4ePdwmbY2NxZdibFlvzp?=
 =?us-ascii?Q?GjxpmVLd3xafW2z7ie8uCdpTKzPinxFob+1lDBLLGLptStdhRWLcfexuRkdo?=
 =?us-ascii?Q?c6C7xOY7GRrR0Od1BbS8MH99gC8XyOOSHIXllrJuYcSKUVQMI+E3BENkkhTn?=
 =?us-ascii?Q?efcdFWUgZf58qmhK6vv0s1JDysBk+JxeYCsKaUXsU+T0schcRetWZ6W+hhxl?=
 =?us-ascii?Q?nkBmvqeEnG+nVTh5mUka+fbQfOITZ5YpXRDrg75Yt+jzS+nkGdmFP7ZmcT+b?=
 =?us-ascii?Q?2dbDSicIYyNFrqfHcNBo+hwNDPIRkK+PrxcJr6hOq/KkFQW7d12YdjwYss/9?=
 =?us-ascii?Q?jm8gKEP70EFxEN7YAGdO6ztYcY4U9T1usUDPrRox28BNFJ2xZBDiNeMpd0zM?=
 =?us-ascii?Q?MvZgrCeNFyaB7h++oQ1RSbI6y6Mird93UoYDZUCGbDsZcpcSllIaivuw5kIs?=
 =?us-ascii?Q?uhVyzReDsjgV5Z0vZDVSJF1tD/SA7KyyMIJLLKV926gc3FZ6CfwSmBlSLNFP?=
 =?us-ascii?Q?cMkiq31dquZHHxeiBjEoBYCty8cF6lHrVH/0QGlw5EJ7k77YGGDHlWNzsVp9?=
 =?us-ascii?Q?jCEceHdLqw9d72QZuZ+7BIh03lKeI+BOh2DtgXZEJAznrXA9pGwGAG49uKNG?=
 =?us-ascii?Q?aU0SkugXua34nPCVaqfD1uepzp+O+ytaoRRwHaLgWaA+7nDa4DjX8CalN/BT?=
 =?us-ascii?Q?jZckOYIdz+2t19arSyplXH5vocyz5iP/4DH31AsWo1fXuRTbmw/cf8Hn6qBH?=
 =?us-ascii?Q?CLnwOW57r7tVCLE7O5EeSmFfRY3JUJYiTPECvA+7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ada246-c49a-4625-1834-08db6028a601
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 09:39:50.2490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aY08DLDsy5DF782o2qmvak4ca+BKHdi2s9M7BmxyiHvLqcSJpfvTPpW0Ok5N3SMo+oRUEvQtqDBq28LGo32SbHOAxaGwNW0VCgCPCUqDBFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc Zyngier,

Thanks for the feedback.

> Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> {modprobe,bind} error
>=20
> On Mon, 29 May 2023 09:42:34 +0100,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > Hi Laurent,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> > > {modprobe,bind} error
> > >
> > > Hi Biju,
> > >
> > > Thank you for the patch.
> > >
> > > On Fri, May 26, 2023 at 03:36:15PM +0100, Biju Das wrote:
> > > > Currently {modprobe, bind} after {rmmod, unbind} results in probe
> > > failure.
> > > >
> > > > genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs.
> > > > 00000004 (85070400.usb3drd)
> > > > renesas_usb3: probe of 85070000.usb3peri failed with error -16
> > > >
> > > > Fix this issue by replacing "parent dev"->"dev" as the irq
> > > > resource is managed by this driver.
> > >
> > > If the dev pointer passed to devm_request_irq() is not the correct
> > > one, how does it work the first time the driver is loaded ?
> >
> > + Marc/ Kernel.org to give some feedback on this issue
> >
> > I believe there may be a bug in the genirq (kernel/irq) driver.
> > first time it works ok. Maybe this driver is caching on unload with
> > null value and comparing with actual one (irq 22) during reload??
> >
> > Maybe genirq expert can comment what went wrong here??
>=20
> You get shouted at because you are registering an interrupt handler for
> the same IRQ twice,

This not true. It is registering only one IRQ, but with parent device handl=
e.

 and the interrupt is not configured with the SHARED
> flag.

I haven't added SHARED flag as there is only one IRQ registration.

 If, as I understand it, you only have a single device using this
> interrupt, then it means your driver is not freeing its interrupt on
> unload.

You mean devm_request_irq(ddata->dev..)  doesn't free the resource as
we have unloaded only child device rather than parent.

But while parent is active, why genirq is giving error during reload?
It should show same behaviour like initial probe.

>=20
> And that's probably because the device object used when requesting the
> interrupt isn't the one you load/unload, as indicated by the message.
> On the first load of "usb3peri", you register an interrupt with
> "usb3drd" as the requester device. You then unload "usb3peri", which of
> course has no effect whatsoever on the interrupt.
>=20
> You could simply have done a "cat /proc/interrupt" and see that
> interrupt was still there after unload.

Yes, interrupt still there after unload.

With devm_request_irq(ddata->dev..), after unload
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

root@rzv2m:~# cat /proc/interrupts | grep usb
 22:          0     GICv2 274 Level     85070400.usb3drd
 28:          0     GICv2 278 Level     85070000.usb3peri
root@rzv2m:~# lsmod
Module                  Size  Used by
hd3ss3220              12288  0
typec                  73728  1 hd3ss3220
renesas_usb3           32768  1
i2c_rzv2m              12288  0
crct10dif_ce           12288  1
ipv6                  450560  16
root@rzv2m:~# rmmod hd3ss3220
root@rzv2m:~# rmmod renesas_usb3
root@rzv2m:~# cat /proc/interrupts | grep usb
 22:          0     GICv2 274 Level     85070400.usb3drd
root@rzv2m:~#

With devm_request_irq(&pdev->dev..), after unload
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

root@rzv2m:~# cat /proc/interrupts | grep usb
 22:          0     GICv2 274 Level     85070400.usb3drd
 28:          0     GICv2 278 Level     85070000.usb3peri
root@rzv2m:~# lsmod
Module                  Size  Used by
hd3ss3220              12288  0
typec                  73728  1 hd3ss3220
renesas_usb3           32768  1
crct10dif_ce           12288  1
i2c_rzv2m              12288  0
ipv6                  450560  16
root@rzv2m:~# rmmod hd3ss3220
root@rzv2m:~# rmmod renesas_usb3
root@rzv2m:~# cat /proc/interrupts | grep usb
root@rzv2m:~#

>=20
> So the only bug here is in the handling of the interrupt request. And
> that bug firmly lies in your code. My "expert" advise is to debug the
> problem rather than suspecting some random failure modes.

With devm_request_irq(&pdev->dev..) the above issue is fixed.

Or

the correct way is passing SHARED flag with devm_request_irq(ddata ->dev..)=
,=20
as the resource is owned by the parent??

Cheers,
Biju
