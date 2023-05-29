Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD877147A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjE2KDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjE2KDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:03:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2122.outbound.protection.outlook.com [40.107.113.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AD6BE;
        Mon, 29 May 2023 03:03:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgfkDtFQx2pYHz7ZHkk0NtfPpL4hYS369UvPJK5mJ2b3aOb+Gg/O02a80BTBKO7k112xWoxA2n3Xpn3wxlcvgANYcEMmbE++T2c8g8pGIlhFwEHvPkgVw1wfM1bN5Zk49LKNfZNXkPWcANwAzrldbkQPx24Fo31e6fdZ/g8u08Px0TD5MoxWM1roTEW6FSLZX0irgjKwoflrkFlH7x9L7Bdz9MmxiVP+YEa7zljSjJ3jOMSj5CtXJ3EZCCxnGtS35nJFxMtkGxMpRlsLzYaOfqlAcI44sO0q+ZvUdrYGnwCCw0cRWviHj/Z9qy3J4D5WbKf5qZJ6fcc6PnudawYtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cY/laPxZ7MCQ6+CfgQu98nS7x7KtEc25ceV8k0jjUJY=;
 b=brvEHPcyBhzEzoqqSZ+aHqpeq3Jf7C+E9dlue8t4MZNnHKqiUoyJKqi/WIgwJtI0D+VDLrhlH/SZh0LxHIBb8c3rx+0cYVdX+jlw4ruKixSofqN7ZB59LIddm3YU70DqDYZCsUL10a3gyye8UiU7TQnGhp3CRw22JWoloFNbVdP5uS/y/IiDvh5q2EUwsJlHqZyqpZ2hb9kjxoSKKsX78/UcfKrldIYOxTl9FabKtep0OoMRCpOX0DvKN2Whi9+3Z/jHrPqjyo1OT0Xk/2FSAxOkSUBCY4snJbN2d9PCxBW2g4awK51E+Tr0zFRf6Id6ZVamuTxuYeCrrE21mOIClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cY/laPxZ7MCQ6+CfgQu98nS7x7KtEc25ceV8k0jjUJY=;
 b=s2FP8PBhKJsOSHhJ+VEPnFC1ZZIFpdmUIZNK8Hnn4yiNi/ip8lCIB6NtLmEA2ETrHTHUaRfpJ1MvXNk9Z0DkwV2uGZL4h26v3X1xNY7VHUU48SKylz8hg5njSZR4kMfjSsqxYUm+PaxRoJ0HuEd551jcGWMiqtCrvRZH8hUkRqc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB7697.jpnprd01.prod.outlook.com (2603:1096:604:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 10:03:27 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 10:03:27 +0000
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
Thread-Index: AQHZj99wvrGBFYOn5Ea9mIuOTwGccK9wyqwAgAAi9sCAAA05gIAAAIqAgAAMaQCAAAEC8A==
Date:   Mon, 29 May 2023 10:03:27 +0000
Message-ID: <OS0PR01MB59227D8298776A092F024F2A864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230526143615.372338-1-biju.das.jz@bp.renesas.com>
        <20230529061714.GA25984@pendragon.ideasonboard.com>
        <OS0PR01MB592296756992262EC6D382D0864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <86bki3cxm2.wl-maz@kernel.org>
        <OS0PR01MB59227E69FF1DE67327BDEF77864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <87353flavh.wl-maz@kernel.org>
In-Reply-To: <87353flavh.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB7697:EE_
x-ms-office365-filtering-correlation-id: cef01f98-bfd4-4dfb-b5fd-08db602bf2ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MjfHP1Xwf41sehRjle3y+nIRPG8eVzUS94JNWeT/sC3T+6tll1O3bR8YBdP7djNdikGcvoJ9KuqT/knoPc1KfPMzP5IPFSrkDZXkc2Z/n9jTNOhgQTw0h4WxnRrVzfX8rgz6udU9KOZFF7rqJh0/gLIDaagBblvL3pE1UJxVSD31S/LwDlJRRU1JRJEAkDQ23vgWzE8wCrgh2Fd0Pza93lPhTOGU7ZOqJxb+mi38dB43ZkvHbD/DyWYNZWCakWBIp2T8hjkKbyG37dXcP/7yMq2UF7v3ke1ay+58gNACpfTHsIsGY5ufnt/aNejXfPOGElHCvxbISnUByqO2xWPdOSnT7y/MVahMNVFSJf2FGR3o9yhINNNOHpcZSAaYs7GKs+T6WPkE5DmHgf/Jc31xLKh/6f2SRxCc2lPv9WjypA61eLhc+1qu8nwV5qh7ZkNMSYjFv9cNczdTJumNNFwWTs73DHP58c1qxA/TZqyX+GEGTrlK07kLtAPvQB2C223ya2T0j/UkoU60J7SOA79m7pLTFAMn2QgxJfQUwUt6Mj+yuRItxDr3ZKn9wwXVtJ7GfqQ1ZR8f3ykOmZfEopv0jgB2Rix/8hH7xt9t4RKy8emYbThTUPp2chSe6qmYZrab
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(83380400001)(71200400001)(33656002)(5660300002)(316002)(66946007)(66556008)(76116006)(64756008)(66446008)(66476007)(7416002)(52536014)(4326008)(6916009)(122000001)(38100700002)(41300700001)(8676002)(8936002)(7696005)(86362001)(55016003)(54906003)(2906002)(6506007)(38070700005)(9686003)(186003)(478600001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5ycLW/pbHVmfZxhzn/PjIr/IXTOI4SLFiZOXwc9w36QhqTTyndpEcqVHC/Kh?=
 =?us-ascii?Q?VD5HOU/fWbElFlFSFUKe0n9CA/D3BDUHn2O3XDIKwC22P0njyHUIEWJtbt5H?=
 =?us-ascii?Q?px/CaKZxUL5dGK3/5mMh5LTD2suCZbZ1t3DPsrSsJKtZdTTpzxDFLNgBMHm+?=
 =?us-ascii?Q?XldjXN9vYRw4pqS18H+SDOlW5+MoxUktZso8RvZCVG0BhrMphHIdz40D7Lhs?=
 =?us-ascii?Q?sjcWcIEFhSP8vJwqcPXcre/i+Mo0x2B1J2UqmUwO2vt0LILDee2btJ/xJV2M?=
 =?us-ascii?Q?aHWndjFVXO3yQPWXSYFOr1P64PHLN771lkKA4qt24t0J9QpAxzIvVCEbg5So?=
 =?us-ascii?Q?lzoX5Tem9ode34PhjHMoSimZE0pVipzlTKNFG7uQL+pMG/jv47Q+iDum1gho?=
 =?us-ascii?Q?vuxjV+gtzl8nZ3kqVEmrxcF2NL5wWvkKfN8/PdFu/688V+4whKI9JFr9Jxzd?=
 =?us-ascii?Q?jo99MOBEDOCWE6n4qGKwzWRe5sHiYvnSOLpbqm81+QA38GFqh0AVPLob8LON?=
 =?us-ascii?Q?jWcrPhp8Waw5tYdk+sR0v4WlTzB3CDBOQpiRsRWDc2dSGJ1ag0wER87keW+7?=
 =?us-ascii?Q?mdbW+80mASGN03ZJLaRoy2VwYOLQJjDotW8hcYROtGsFwpZSZkufhal0nV+g?=
 =?us-ascii?Q?Txw8avETFQSDT09jbS5Yzz88sqY1CdXifD4N0FVGVbfBCLtl2rPX/jjXbJFY?=
 =?us-ascii?Q?o6nQ85gIW/GB4XziR4+P3xYCfHw0SGB4u5CXp8XzN+iLzs/l9aONZHelpH2L?=
 =?us-ascii?Q?Jq0yzTbsIuGRw2AJ4C/fmdo9E0Os4pA2YKWd66ubXfkkE5sDF4QIHilkm7ZH?=
 =?us-ascii?Q?410GAVUTV5ewFwTcsETz1GH7OYpe4ddQ31aft6A0R6LJyU4LFQ1BVYPXMCQj?=
 =?us-ascii?Q?8BkaP4v+LRRwuJpS0zlef/CEO4IKnMFBQ2AjeN15Rh3v2g06l3zNZcwp2XBS?=
 =?us-ascii?Q?DrCen5BBnQSwrOlES2WhXetddlAtU+c6Ie8smE0In4sJ+LWF7KSDFX7eokeX?=
 =?us-ascii?Q?NjnKTEpkqfsg7vK/4CiKnrprnze2NkacFNXYOYayElq9+nh6a6IGco3aA2BK?=
 =?us-ascii?Q?yBI1nx9gGiYqMjquGubhPQsjbLUYZFY4HZvECHbqLoYU5ueTg4j1RmXzZvhR?=
 =?us-ascii?Q?UfHRRzMJDiIsl4m5sEQp78xa64/OadKHWr+uuzXAWNAsoX+c0A1Ij66lQ8MO?=
 =?us-ascii?Q?CdtcV8geqL4pDIU7SOavaVNVONQuyaRz84dfauMPqJVxnettLJdMp6kyZMtR?=
 =?us-ascii?Q?3MpHINXYWDMQEyEFNPwRxdLNA7KrsOWdzlvi8uvcri/ClDwQM507KAmKa4xd?=
 =?us-ascii?Q?jZTOS2FeHmKtCChk1ccRjq/xFaSGO0SLc3LJgIo32RkFEFO8UaoPe25F9+k3?=
 =?us-ascii?Q?WNDatdGCp7DA6M5BPPn5wbrfQ3ov4LWGpCiQqtRH3VkO+/yO7iCOLXA6XtxA?=
 =?us-ascii?Q?J+jpivyuhxBJFIuiEpBczrxs7OSPyVSCYKXCM7pU/q2t91iAwV+6wXO0X15P?=
 =?us-ascii?Q?cnJSZxj/XZFHSB5L+2vLC582bTU/CrrgeM+xAywox8mvuvor5RjndMF2RCTi?=
 =?us-ascii?Q?RXB8rIZN80QdZtZl8FvfKt8VD6qT5GmS+FlUILXr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef01f98-bfd4-4dfb-b5fd-08db602bf2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 10:03:27.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hcIV5OMJAqHPrTnvyOtHocK4erFPpBXFyQMrFEwvCuxfxoBZqQ6r6LtHw5OgR5Ptc9PK7CWE8oagPIXrcFKGckwqThqScNmqMlPu57+YFwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7697
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
> On Mon, 29 May 2023 10:39:50 +0100,
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> >
> > Hi Marc Zyngier,
> >
> > Thanks for the feedback.
> >
> > > Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> > > {modprobe,bind} error
> > >
> > > On Mon, 29 May 2023 09:42:34 +0100,
> > > Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > >
> > > > Hi Laurent,
> > > >
> > > > Thanks for the feedback.
> > > >
> > > > > Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> > > > > {modprobe,bind} error
> > > > >
> > > > > Hi Biju,
> > > > >
> > > > > Thank you for the patch.
> > > > >
> > > > > On Fri, May 26, 2023 at 03:36:15PM +0100, Biju Das wrote:
> > > > > > Currently {modprobe, bind} after {rmmod, unbind} results in
> > > > > > probe
> > > > > failure.
> > > > > >
> > > > > > genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs.
> > > > > > 00000004 (85070400.usb3drd)
> > > > > > renesas_usb3: probe of 85070000.usb3peri failed with error -16
> > > > > >
> > > > > > Fix this issue by replacing "parent dev"->"dev" as the irq
> > > > > > resource is managed by this driver.
> > > > >
> > > > > If the dev pointer passed to devm_request_irq() is not the
> > > > > correct one, how does it work the first time the driver is
> loaded ?
> > > >
> > > > + Marc/ Kernel.org to give some feedback on this issue
> > > >
> > > > I believe there may be a bug in the genirq (kernel/irq) driver.
> > > > first time it works ok. Maybe this driver is caching on unload
> > > > with null value and comparing with actual one (irq 22) during
> reload??
> > > >
> > > > Maybe genirq expert can comment what went wrong here??
> > >
> > > You get shouted at because you are registering an interrupt handler
> > > for the same IRQ twice,
> >
> > This not true. It is registering only one IRQ, but with parent device
> handle.
>=20
> And you're doing that *TWICE*. Once per load of this driver.

I got it from Laurent's feedback.

>=20
> >
> >  and the interrupt is not configured with the SHARED
> > > flag.
> >
> > I haven't added SHARED flag as there is only one IRQ registration.
> >
> >  If, as I understand it, you only have a single device using this
> > > interrupt, then it means your driver is not freeing its interrupt on
> > > unload.
> >
> > You mean devm_request_irq(ddata->dev..)  doesn't free the resource as
> > we have unloaded only child device rather than parent.
> >
> > But while parent is active, why genirq is giving error during reload?
> > It should show same behaviour like initial probe.
>=20
> Do you understand the meaning of the "dev" parameter you pass to
> devm_request_irq()?

Yes, the resource is managed with particular device.

I should not use devm_request_irq here. rather should use
request_irq and free_irq during unload with parent device handle.

Cheers,
Biju
