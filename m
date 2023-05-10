Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD6D6FE275
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjEJQ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbjEJQ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:27:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2BA8A72;
        Wed, 10 May 2023 09:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2GTmkpQQO6+8JqOXYpBpV7K0Pqe7R1yPpwM0m4BButIv2nmYRjvRqxvp7yJCGq4h/rnrlcQDcgOg/uLhXF5OZo8UZatA9q/OEHNHtHC5ObU0PIIMBlK6NdY9oVY9HXpNmMRotiJ5BBCGcsG8++g1wE7/QNHBAbJNk/4o3ztv8fD/niA9LqFNUtpIYlBXcpljn1KMKPTc/j6j7RP5VlX+sWW7TzCdltRS5eQEdip8ePlLASRw+cFhXhriB3nQ3ESRJzFWUu/yKSoThM3aTr5w87IJEX+1TjVDfJpNDC6a2ZEcY5k8NJ35RAEmA1o8pf5je/r4ldbltdsdRII5C35Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOEtRSq4RO4MgU26PsYnEg30GrscVDwby04JFTOIbZo=;
 b=iXCAaXsJfLtjBoITzwEENvKlTDT6PGVk850OUH3vMrX2FiZdyLj2zwbt7Mi54hf8N115cNMSN4YK7r60cHtCMfO4YacZtXlqMn682DWtUOYExtE8Te3ulU83sRd5+zhjvcK0wV97gEzgW4WlD/GghN14l4bEsSOXRq7n+hmihLWNCk2fPnwgaIhjiS99+HJq3fRiAnFkSqy3naiyAWbigbsQp8QBtprmvt0IBdnPFwhDjzFHum7YzO9fpeDxCEL2CETsqN9ZN1+4hqldsOQ3xRaKUjNHMT2IgzwG+MNNg01pNrSWTgDmoZoaIc9mN0WLIpyNwvrmDO4GMtGBT6q3Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOEtRSq4RO4MgU26PsYnEg30GrscVDwby04JFTOIbZo=;
 b=XC6C5ovFm5k3bIh0ciMVqj6BoW+LL0wJ7cDPxQrvudnSJpYl6WE1m1PWAAus2JxPabpytppdXg+N+yDoSwVym+4IW1imS1NIVM2GRqVkVTYsvkObYY852s6eXrx8qGLcgi8TbsYP5te8WTagsHDBjJpUcIAS2g97xKLzk9KeroY=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.30; Wed, 10 May
 2023 16:26:05 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::209c:2728:9fa5:a78a]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::209c:2728:9fa5:a78a%4]) with mapi id 15.20.6387.019; Wed, 10 May 2023
 16:26:05 +0000
From:   "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To:     "m.brock@vanmierlo.com" <m.brock@vanmierlo.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: RE: [PATCH 0/2] Add rs485 support to uartps driver
Thread-Topic: [PATCH 0/2] Add rs485 support to uartps driver
Thread-Index: AQHZfoMOVvbvY/C9EUCU2o5qmO6xr69Tub0g
Date:   Wed, 10 May 2023 16:26:05 +0000
Message-ID: <DM4PR12MB61098014775DE9950A0E2E588C779@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
 <6b72c56e79a44fec348de26d14d9dce0@vanmierlo.com>
In-Reply-To: <6b72c56e79a44fec348de26d14d9dce0@vanmierlo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|SN7PR12MB7370:EE_
x-ms-office365-filtering-correlation-id: 85816334-cecd-4cbc-3a44-08db517340dc
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CNf8ETN/FEcRnIetHTbKp+k9W6YzI6fxf7FTfr9dEu9wE8DDrmaX9HOLwOJp8FAjaUiQZzfj8X+VovD3fE/B6Fc6prS1Gw5/ixKZO22JiHfNkXoWpmfZL5GeSoX6j3fyU+nYOUKLNVmreVz4TnDWK/E42Lec3561GhSweCMUuhH84pYG8fU/4mfRRFR3FHaSvYevzJ87IjkuKe2A9+dM6KetVTckiNS3W0RqlEcALN+bjuQkqWd/p1iBJNsCwpJGFoUiTrquOnvdIvMhkoYKUUO1T9xuTEwC9+3oISzBFPPHP+utwHZ55T2ekWj1tkKZ7k6KR44jDy5EfReWU/IMneEUaa5VFWFmIRLxV40zmcPxH+XpjmIwzMHMGCiK6Ps1ZIVw1t6l154agWI9XGVFegAohTN0h7FprcSPkYQHmApxYMCPUIHqxOqXn8wl0o93Mky2UsYwHOceNJbPfxOpW1xwK5IMrR4Bk14UiLkCHDnedQw7vLBxphWw9Jt910Mtbl1E52l1zUuOl6dxq3Lfw8ni/e7FF+Nd/QltH71Go1lY6yPq9RKY+Ctt491fYSfCAHbwo0ZDvoTrJ/VUUl/afSS+ZM6uc+sWSZcWp9nkjlWCdZNxT6kR0t6IgPzhmxPf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(33656002)(4326008)(86362001)(316002)(54906003)(478600001)(64756008)(6916009)(66556008)(66946007)(66476007)(66446008)(7696005)(76116006)(83380400001)(55016003)(5660300002)(2906002)(7416002)(52536014)(8936002)(41300700001)(38100700002)(38070700005)(122000001)(6506007)(53546011)(26005)(71200400001)(186003)(9686003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iz19szwkg8UoER17Wa6i87N7CiFAKbieZDOBjh1jhy+mTj9jFDMxaLwE4iDI?=
 =?us-ascii?Q?RaNTz5e33+jin/W7QK+btkI0rL8qu1vKSiuWUyTuEl4SgX5LT8e3RAOywNM7?=
 =?us-ascii?Q?D1jzUjY9pM/wWdWaJHAGHesWEAxpYbz9EPKTvWNc4fSDTu3WgB8IH+F8jr+x?=
 =?us-ascii?Q?LvegnsrMTG5zGGsob5aBHw6PtrTK5mrs28CA9K7Ipc6Mh4qLNFiSQTfEtpWg?=
 =?us-ascii?Q?jtOXMDcagIWCuIMUldTpJfGjZlC0O42vSQlRrlQePDEnej2/P0uLUYBfH3MJ?=
 =?us-ascii?Q?vCqGk4X5ftGffvIIkr7jFtPXGvpSadbnfPHrmp9Dx+lovoate37kmNN9bOg8?=
 =?us-ascii?Q?KQsiFWl2DUWyhp8Sfx5seZn3vzkJjf+lmnKo6o2y/nJSc7QHlhuNtAuY1pf7?=
 =?us-ascii?Q?SdCxPVHOd5s8ZPKnaaLAk86RznNdV6NO2Vt6PATmOYPvVYDTTI62MgqoFfP2?=
 =?us-ascii?Q?KA87G/4c7vgBQArRxcJ0YrKxLvOHQgajIHrVBfEOFqvPxa4YjjLRpRam/w96?=
 =?us-ascii?Q?16drBcounrkBN9iz4IKruEUwnMsxlIvaBrwQ5fF7FJKKLkHuFzQMLYTK362S?=
 =?us-ascii?Q?ivq+fYRBG2GwFMJ81JZabTbj+DlSXL0s+od2J1wb1YIEEmcvXYCZW3FA7oW+?=
 =?us-ascii?Q?Mk3b+8y8wGVpE7zz9PoQSeYDJhY4VGlVLlPCLGbJO2SaMeEoFurvl5cGx5cY?=
 =?us-ascii?Q?mjna3CaKSFQP5FaHmwRVgLy5U3N1sDxmm4xj9xlfvJkhUUFvcqqVTc0UfGhC?=
 =?us-ascii?Q?ByKPZeoH0i2iJc/raiQ/opWE1Jp2dbUNGLU7V3/y3uD5cPkcioJc0YSjTlPx?=
 =?us-ascii?Q?g2zSGv9UzFjoEa7ADl+hQWsLnsL/uZGpIYNLX3D2rDkjVSabeuQj2UW3WVpU?=
 =?us-ascii?Q?7iC0zIoTiwcHz8rUWuTheQrqgq9T8u9jJNyMRHHeLrJ7igs69yEuaswnQ+Mg?=
 =?us-ascii?Q?Fp8r1GZcCjuUMJSB43Z3kkbPhKwFLavwGfYHTb1IbTqcYYLk+PrRmVgvlU6H?=
 =?us-ascii?Q?DSGrzbkEg+QjB9r0MHhstjKjX8ViVe1Vf7qcxTCcn2zirHkzGBEAaR+6IvXq?=
 =?us-ascii?Q?LA8CpUnDEZJA56inhShaQFkFxare5Q0Nuv5OuUT+2t60yX+ulQRYlY182lh3?=
 =?us-ascii?Q?6wMD/9gG6a0CHWO8Y6lnwBoPEYI5GupVbvvQx3F3O47Ty3v5V9IoSVPmwIMO?=
 =?us-ascii?Q?6skiV1FDrV6O8oHgZMxBep+NEaWTpP3AZQeAS+Ql5FMCZHCZWwqDCb/Z827D?=
 =?us-ascii?Q?G8R1fcoJMMs5wCzCDNCN+1YHFpiDf28IuJMLjvODOJ9BhPqDF+MeogGZSVPo?=
 =?us-ascii?Q?p6v1Yl3zVis/6f8Loq0APicn0NILDLJyLj7H1QGrnnECmf52qR8yLObGzED9?=
 =?us-ascii?Q?cYU3PDgBbvny5pzub4iSiTUvA2ghBLFM1ga82NEmjGbmp2PwXxyPB9jK2KBj?=
 =?us-ascii?Q?EfQmk92cbHoi1sq2jJUpkZokBmYPaoMVvp90wXdy8VERRs5O8e0BaO+7J0/u?=
 =?us-ascii?Q?iWIy8jdNm2kGAEPPDJ9QPJfD6mOQWk0Yo33Oqo32Kn5GUPphvjnSkQELpe86?=
 =?us-ascii?Q?2XzmwBvQGHO1QFwe65w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85816334-cecd-4cbc-3a44-08db517340dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 16:26:05.3900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90qE0RWVcTr3jd95wAzqxvaPhhzIYeBHi5BKz5aT23YTHptVI7KEGJxrv5eYCLCn3vMj5dyMzCgwqZg2hg58rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maarten,

> -----Original Message-----
> From: m.brock@vanmierlo.com <m.brock@vanmierlo.com>
> Sent: Thursday, May 4, 2023 5:52 PM
> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com; linux-
> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; jirislaby@kernel.org; linux-arm-
> kernel@lists.infradead.org; Simek, Michal <michal.simek@amd.com>; git
> (AMD-Xilinx) <git@amd.com>; Pandey, Radhey Shyam
> <radhey.shyam.pandey@amd.com>; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> manion05gk@gmail.com
> Subject: Re: [PATCH 0/2] Add rs485 support to uartps driver
>=20
> Manikanta Guntupalli wrote 2023-04-26 14:29:
> > Add optional gpio property to uartps node to support rs485 Add rs485
> > support to uartps driver
> >
> > Manikanta Guntupalli (2):
> >   dt-bindings: Add optional gpio property to uartps node to support
> >     rs485
> >   tty: serial: uartps: Add rs485 support to uartps driver
> >
> >  .../devicetree/bindings/serial/cdns,uart.yaml |  5 +
> >  drivers/tty/serial/xilinx_uartps.c            | 96 ++++++++++++++++++-
> >  2 files changed, 100 insertions(+), 1 deletion(-)
>=20
> Why would you want to use a GPIO and not RTS for choosing the direction a=
s
> is more common in this case?
In ZynqMp platform Cadence UART Controller RTS signal routed to external th=
rough the PL(Programmable Logic) design not through Multiplexed IO.

> And have you thought about configuring the polarity?
GPIO polarity configured through device tree property.

&uart0 {
        ...
        txrx-gpios =3D <&gpio 72 GPIO_ACTIVE_LOW>;
        linux,rs485-enabled-at-boot-time;
};

> How long will the signal be active before the real transmission begins so=
 the
> driver can settle?
Default is RE(GPIO LOW) and while sending we drive the pin to HIGH. We wait=
 for transmission completion, for that we check Transmitter state machine a=
ctive status to ZERO and TX FIFO EMPTY.=20

Thanks,
Manikanta.

