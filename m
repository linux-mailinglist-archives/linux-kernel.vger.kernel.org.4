Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F251C6F40D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjEBKOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjEBKOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:14:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE132121;
        Tue,  2 May 2023 03:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5SM/y0/I6vI2L48PYjqMJsUHTPdF53c9c7gRsvxrJXjOvxSQB5ZVVe/nb3482+BsfRdiUhrMmF3By6OAWAIwmmhNeRCpYQWjN7WlMPkTD7MJF5rX7DSuoRXORJ6lsbVxtqXi4QIwi940lSY3bMc5hsesF2Lv/eMu8/wB2ZgnGdZwqSLSvekiy5s3SgIVRO5dsYVQVaK6gRoOYLmDdkUX25rR0YE5fFUKBhebVyMoK2Vcz4DJTOohKymSMTw4/k2g0bXmwCAZBObcMAqjvOSmnw9WILIyJebJ1WGlHL9y1VzwehocWluTK/p364axzx351jg1WFgb4dnhRlzjn8o4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1UE4Hn3GTuwr1DhnBYCAV2x/UBjhN94JYdNrgVCUsQ=;
 b=jsdhU9GrMyspJ1Uy2hrat7GktABH/t/8FNg47OyA4kqzmIUwr42z6+jkw3dP9ejAb/qjhqwRfwW+Oiio+988UZW3Wu1Gc0eenAygkXdPPCjfpt/ltZuMIHg4qY26T0a0koIRN67pIQA6z6esQnH4hCmHT8FSmi3/R6UEjJgqVP998x/AT2/atPf8zxlY36v+py9g46y2Fe4BC/4yWrxxjZwdZburWxsh7qMT7K67BvUP2+GQ5oX9TlVGxZWAWPHM2o9Q3sLSlzmDsEydoDAQIhFKGHKpEoUoUVlpKv59ufVeYTwiqdv9wLnKxvmT+JoNp1VQoOV5N4HDTGXSFyrMNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1UE4Hn3GTuwr1DhnBYCAV2x/UBjhN94JYdNrgVCUsQ=;
 b=APVdmkSLilCAu+KHUiPMQu3FPC2eTz0BLRzfxhqN4HRFx6wYLp6lCKyt9pMixj24W2m3LvaPbguKL3i73EKCf3SlQ5Odve1yDkaOIHpRt6+4woX4adyn0wcrpnQ63Q926BYulmEP4PY0rVJNrwgw41v+ZPinEtlft/atnAPfEq4=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 10:14:06 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::209c:2728:9fa5:a78a]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::209c:2728:9fa5:a78a%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 10:14:06 +0000
From:   "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        "manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
Thread-Topic: [PATCH 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
Thread-Index: AQHZeSd22/ae6rX/PUShNE7PUXWwV69ANaUQ
Date:   Tue, 2 May 2023 10:14:06 +0000
Message-ID: <DM4PR12MB6109C2BCDFD616AE37E10B9A8C6F9@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
 <1682512187-8828-2-git-send-email-manikanta.guntupalli@amd.com>
 <20230427164351.GA3146210-robh@kernel.org>
In-Reply-To: <20230427164351.GA3146210-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|BL1PR12MB5352:EE_
x-ms-office365-filtering-correlation-id: 760096a2-9904-4874-a1c8-08db4af5f635
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: az0pczNl3sKNbg81+0jlUko1Sf4IFAphbT+OrOj/qfYCWW9IyAlt3t8UAJn3EWXy3ZDtCXNX1JEMrjv04utwy/O67hFBKZVLZ7ppcJteTfsTsYYt1ILYLbS6ucK+Cd57UhlEq6OiBJziiS7sS7DtLh39XHcgkcBDgWm5gVa6iHQPu0XR7L3+/j5g9LnRCaT4WLVsDziQ/HRWgDXFYHFx+kaYjpLEO/GcAOnLqpsgH5gSiARxvzR8RYLCy44EB6a+upxIrKil6P9LK0iyQzriGqDo/NPaVsN03kt3s+smx4asBfP0TYEa9UwpwbAM8gIdnjKSRNPz1NpZm7r0MyTA5U+CyIlu/rjlnQoTD9u1sgdjuP2JA54mOX7uUQv4ZC2ev0HuGcxpsgBeIbwf5ETsKVpqyLbgLtCpSZdeGnTMEPzu9fjdyrzgwCX5NqNMqqzJ2/ppOYlxtCE+hOpAYivUx6flU2TNCvwzcume7205Eby17Krm3oU60JHa9N/UWX6yMLiVpvgshxc3LApDJAchnE6cN5V56IESctHpu0popc6Jt1GSngilc5Pedqui2e7YTcPJ2GaDmhe4he9DKs/dMEEOHBG7zLzhufGY3FXaOrw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(38100700002)(122000001)(478600001)(8936002)(8676002)(86362001)(66946007)(64756008)(66556008)(4326008)(6916009)(76116006)(316002)(55016003)(41300700001)(66446008)(54906003)(38070700005)(66476007)(33656002)(83380400001)(7416002)(966005)(2906002)(186003)(53546011)(9686003)(6506007)(52536014)(5660300002)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hep1zZ33tY21dGEyzfbDuhBXPLLkkCpnhze3YamxyoJbNv/XOYC+NKqSOPKh?=
 =?us-ascii?Q?9zxHhpDxdrNp9D/1etI3vxOGe39fxQV8ces0YU+nfTWxGxDaJT3FSkQuRU3Y?=
 =?us-ascii?Q?KFQ7q4PWDi0Uxb4BIbtadcAmnEt+Moq/UULufuxNcSNJ+Y5A6MbYYJd0CAf/?=
 =?us-ascii?Q?EVBl3xH76nI9lz4MVWyhHv1yjyCROP3twUUcCvf62vmC4O6XloICOXQwZKse?=
 =?us-ascii?Q?ev3qJbA1WKmWOU6CE9POocH7Htx9gMoQSmfBZ7DTWL/+27OgXm5EXs85QbXV?=
 =?us-ascii?Q?7I3I7x2p7MumL8beOIj/LUXwJ2k6CnBT7oDSItnmoLlP615xZwSyxeTWOcFH?=
 =?us-ascii?Q?JEwD34MkIXzYe5TwCbRr0JiOfwrzMD5lchpbn9hQPuvxPzZs5xklw4VW5Oaw?=
 =?us-ascii?Q?C4HyKnJZkVs17HX7NOhRcz428dRW1VEblrAnt88PEG4jXk83IO6LXiT/Ul1L?=
 =?us-ascii?Q?GNH3mEoX3t0fMBK03Y5QJ5JqtgjgxEalBV/CHn3UJUjjpxtSt2UHD/POSXRx?=
 =?us-ascii?Q?M/PfT4umDcn8DR1kOFNW8sczt2d6pj4U68Xw9TzwQZD9j/JvV+gD5/UvpXN+?=
 =?us-ascii?Q?vDFUBqjshGQeXK4TeCAIvEyafMOWaOMn40btloDM2So8KKkxiQ2+A+/dJOGq?=
 =?us-ascii?Q?XYZ8mBGm2pvwO570ssXrgcH2qovRqbBQ92X+JMXp84YzoVpoIFBmfwgeH1CL?=
 =?us-ascii?Q?CgPZctRisf3XefuIvjhsRdNPfVh0+afk6VVu0BdJPVPU4aAAy0aTsZGvjeUw?=
 =?us-ascii?Q?vZE8zrx6cBeYCgNe/M/ZnXojZ6trjldCOvBGmIglku1jzdyjarShq1+z+VOx?=
 =?us-ascii?Q?p4FlLg/a6CJApn2shReQIfbabrqbLNIJ4Oh8mN0Htxk7aPBe9+8R2b9hAEW9?=
 =?us-ascii?Q?fNKp+AxdbxjjFkLPMWrkyhCtEPguXm0matWRc6YFfwlEPAnP+OCKNH+Ke34T?=
 =?us-ascii?Q?7DHJcRdnVOPUZKZ3zpb5gxjhXjhyzkWFZyE1pN+ApD3O3MwgGWeA4Q+KE76V?=
 =?us-ascii?Q?H54zLV2h0YbGmXqUv1OgY5/ZofJ+Y04huxZ2Ottpvq+qvK41Z4121aHG9rUX?=
 =?us-ascii?Q?F2zBy/Eg70Y4IjJVeiflcCRseMT4ez8d/SOD4h9O5pAImTIifNgkafDCbitv?=
 =?us-ascii?Q?KRuRDMFL5q+1GWoIoud/qHVgNkKmMpE2jTg0fWOA4S/bhY1pt9rlSZXPsMlC?=
 =?us-ascii?Q?QsSymC8ULhrOgzB6x88f98xQbDGvLCCTm3wI7/cjZcScdUVaKIoxC3ljV/Bv?=
 =?us-ascii?Q?kcU84I3qNW+TZfCxs7UQ6pBDE3HOpg3zW7CH/hoUT+wvfqCdBvnGj4N0xmKG?=
 =?us-ascii?Q?i/bs/EGAXOonR57yoI3sBaabi7zxTzPt7OskG9C65zL9buGEelsZ+lPbQ1oD?=
 =?us-ascii?Q?x8It9kNOU3247/3mIHVeNie6O++pKY/C118yL7025wKYoTVp6gxYKJfGk44m?=
 =?us-ascii?Q?n/0ZrCrWogFKcyde8e9eV4KDChGif/RtQwpLKPMmMDhxxgBsrHm5QRfhhINH?=
 =?us-ascii?Q?Lzcr3vdnkQl4yZeYSpGWhQgZw+w7poU0a1nr+zTFZNhqVFVnnS4pRSVFUw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760096a2-9904-4874-a1c8-08db4af5f635
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 10:14:06.1037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lHDA1LSX97hpE8/+4MUYb/EE0mQEVy2cox8AwFo6zmgUJ3x2lpsWzwDHhVeCvn8WP1sahmpCrF2u4n3Mo1VvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob Herring,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, April 27, 2023 10:14 PM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Cc: gregkh@linuxfoundation.org; krzysztof.kozlowski+dt@linaro.org;
> michal.simek@xilinx.com; linux-serial@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> jirislaby@kernel.org; linux-arm-kernel@lists.infradead.org; Simek, Michal
> <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Pandey,
> Radhey Shyam <radhey.shyam.pandey@amd.com>; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> manion05gk@gmail.com
> Subject: Re: [PATCH 1/2] dt-bindings: Add optional gpio property to uartp=
s
> node to support rs485
>=20
> On Wed, Apr 26, 2023 at 05:59:46PM +0530, Manikanta Guntupalli wrote:
> > Add optional gpio property to uartps node and add reference to rs485.ya=
ml
>=20
> The diff tells me that already. Why?
Please check Figure 11-3 (Page number 37) in the below mentioned data sheet=
, It shows PMOD (ISOW14x2) devices used in half duplex configuration. Drive=
r outputs Y and Z are shorted to A and B respectively. This reduces overall=
 cabling requirements. Also DE/RE are shorted to each other, and at a time,=
 any node acts as either a driver or a receiver.
Using above optional GPIO controlling driver or a receiver. This GPIO is op=
tional because it is not required for uart console node.

Here,
DE - Driver enable. If pin is floating, driver is disabled (internal pull-d=
own resistor)
RE - Receiver enable. If pin is floating, receiver buffer is disabled (inte=
rnal pull-up resistor)

Datasheet:
https://www.ti.com/lit/ds/symlink/isow1432.pdf?ts=3D1682607122706&ref_url=
=3Dhttps%253A%252F%252Fwww.ti.com%252Fproduct%252FISOW1432%252Fpart-details=
%252FISOW1432DFMR%253FkeyMatch%253DISOW1432DFMR%2526tisearch%253Dsearch-eve=
rything%2526usecase%253DOPN

>=20
> >
> > Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> > ---
> >  Documentation/devicetree/bindings/serial/cdns,uart.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> > index a8b323d7bf94..34ed0d80b923 100644
> > --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
> > @@ -46,6 +46,10 @@ properties:
> >    power-domains:
> >      maxItems: 1
> >
> > +  txrx-gpios:
> > +    description: Optional GPIO to switch transmit and receive modes vi=
a
> pmod.
>=20
> What's pmod?
Pmod is galvanically-isolated RS-485/RS-422 transceivers with a built-in is=
olated
DC-DC converter, that eliminates the need for a separate isolated power sup=
ply in
space constrained isolated designs.

>=20
> > +    maxItems: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -55,6 +59,7 @@ required:
> >
> >  allOf:
> >    - $ref: serial.yaml#
> > +  - $ref: rs485.yaml#
> >    - if:
> >        properties:
> >          compatible:
> > --
> > 2.25.1
> >
