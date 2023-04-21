Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA06EAB99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjDUN2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 09:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjDUN21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 09:28:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10781258A;
        Fri, 21 Apr 2023 06:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxNC7wAf0AulZ6a/lGb7U1ip3Q9Z1BlOrxTcGfS49wunN5DxSxbYguX2UDITka00caxWMmHtlCQ8/oxPaluXM7CLFLgpQk6d556G+6ZTTFwKaqDpEPeOAowKZLuaRDKWjboIDQ108g081adA0SambYMqNjaz1zI7DTG0jVBfF86Ny61QF6NUWwbe49P0ZDmw43bFBU56R5bkQz8pInkvZD1z4v+KEFonoKvNN3rBT/CBmHkfaJt024u7aFuUW0mzLLKpFE1L30pVzVUUSZQk6sBGhfvb4/zaDOvSooaZhDJ/i1VGB9T8lvASIp7GhnGX+ZtiRhv+VwtPlDiCA38t9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vW47UN/vh/G+N87F7Y8wqtXEzR+PWSef1azKjLRw7mU=;
 b=iD7mblZWoOo5ksl2WGPWqiL+qEv7CVkoXFTjRlPxGmeAmY8cBOhEI3xX5MINYwPipIFzmmyTV6QYKI/uwiOauwOTNLTElYrTK5JqU68l6KwLrmBzgUYk7Ns8H6PDnneRveHKDUm5j/ceQ5HSdS6Y2Fk/CWV++J7Aov54nuOu5oKCh3DUxn6cBHWh5lvvspcWeZDKvbtgCckzoi1Is6jTXRVJF7d5BUYnMGXs1QOyJ8oNrOOJElEBe7EYcQH7VBNl5/r/G1mW6XIkUj6FlntwzC0cSju7wUgNNlFQ/W4EGmYGp5ytK+hzX1caqwakEqzXQ3ndBSn6BooSm/hvlpN+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW47UN/vh/G+N87F7Y8wqtXEzR+PWSef1azKjLRw7mU=;
 b=2krrEtMgwCMnuz1ExtLatFl36n1BNi1pwQGE6GPqbqxzRsCWqSG24UJVRrf4xQC6ofcQTcqQXRAl1+AlMJO9x/4LmGpAxPYkqVATssXl4vHi6DBSJ3Z+rgkLgJRth21EdKB8msR8hzDxScJx0s7GhlKRHDj0GMSOkXV8H2COyG8=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 21 Apr
 2023 13:28:04 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::82c1:97bc:de0:7bf6]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::82c1:97bc:de0:7bf6%5]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 13:28:03 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] dt-bindings: usb: dwc3: xilinx: Add interrupt-names to
 include hibernation interrupt
Thread-Topic: [PATCH] dt-bindings: usb: dwc3: xilinx: Add interrupt-names to
 include hibernation interrupt
Thread-Index: AQHZbQWTnoxb1Gh2F0KbBkWHL5rgVq8xcHAAgAQebNA=
Date:   Fri, 21 Apr 2023 13:28:03 +0000
Message-ID: <MN2PR12MB4333134E60DC454D29BFE2F588609@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20230412060843.149283-1-piyush.mehta@amd.com>
 <20230418184026.GA2099329-robh@kernel.org>
In-Reply-To: <20230418184026.GA2099329-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|PH8PR12MB7424:EE_
x-ms-office365-filtering-correlation-id: 045037dd-c1c6-4c35-30b0-08db426c3c4c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +QZvp+5tv+OILLGAXCTBXAuNdn8sA2rK3Ux5uXJLP2jzmSK6n6ZqDPdn1fPUN8bKAiilYLtasabTTT6bw7ADqsF7WgQdXHyqsR6En5uGjUM3DVr9tExgTsi0DrrZv8A7Gl7jWNtN+n9lAYL1iwrrjsv9j/Hbjmw2EaA8pjememi15zjJibUWjtprdnoU693E8/GJJq5cbYe6uNdioNXvjd/UCec0O3Ak9CoDwQuKVGQjJg9HiccWKCreZalceHTw7xlR1Ud7wpJwrlYY8I65sLniLqkUZOEDQVNaxEDeHC+WOevjtanf+WHVB1sgOorv4qfnCSeJnNpanw3dAOBNKcETNNDnNn1ntJsWhphD4FKoEHP7Yj82NGghV+0J1V6EZ2hhSQdtsRzC50kEGEfOpCcSSRTNTBnFmCK6qDyAjh06qhBK7NZZKFExQ/l6bFQm2Hqv+KhsuujK1bHSjWCmLZ2sid59vXB85ly5VNZ90TrwDGJ9aiEvMhsWOsLmiZzxmpI/N3aqLXF1mWCG/dxZxb8Cpc/JNHaDFfdfc9Fp4DKsMoTYsMyxVnkjUwzBIo8MXbUtTOcCBmfNKHpdttIg//I7pm39IE34MBZqBZaSYefUj4ISgFTT6RYBKa6bdzWNU7JKeUN4jQ7mAb26RzeAAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(86362001)(33656002)(55016003)(2906002)(83380400001)(26005)(66556008)(66946007)(186003)(53546011)(6916009)(478600001)(66476007)(76116006)(66446008)(8676002)(54906003)(7696005)(41300700001)(71200400001)(8936002)(52536014)(316002)(64756008)(4326008)(5660300002)(38100700002)(9686003)(6506007)(966005)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e2fL7lG6pkw0DmI9e707HkwqXtD8uu+ZHjJZt0OEcJiAQJeIiVxU4hLrgex5?=
 =?us-ascii?Q?yERMOWJ2wQZxduX5OwMgN6ZtMkgw1DZPLKK2pd6qDEpm6MI27gpvRvyGe0JP?=
 =?us-ascii?Q?jqHjMh6+GsDJ6QXnDZS2co09QJz9kZi8k04NoQ32Kq7cAqOGpyt1/kvNSabC?=
 =?us-ascii?Q?IfdnSXH6+BQNrPrQLI3eRU+R667e6ze8tE4IVDCzo2q2ptOzJo9pg3dOD7p9?=
 =?us-ascii?Q?ZljYe1A4+rm9c7DQ283rZybqVtIbPGfrq26lEzNsRw6k6blBVneqGiYgpuMH?=
 =?us-ascii?Q?AkbhAatQaD2w5V6AX8b3iTX9pc6WmeTpGz0uyWLTAzCtXm5eGdHAh8Sh+9oX?=
 =?us-ascii?Q?747GXrwXqiQ5Hx2Zf8gUpmv23WOakCBKKLSjqHbSVoKxfw244P04A05S60Tn?=
 =?us-ascii?Q?NctcbE35D57WgBra1cUFjzR39KELJOXj+sYqnegmAkqpoG0Rps3YDpQtOlvS?=
 =?us-ascii?Q?a3OAwXbSealNU/PS+VBgOlYSRsx7bP+boltYvPTxMQVof0GsNc0z83F5xtXs?=
 =?us-ascii?Q?DpJHWnyQ6yWijCUVhYiwQXIceUiojJoCduOx6DcxfSoy3C0ufUvAdyeWMLVl?=
 =?us-ascii?Q?wIUZrQ8fMsyFnUPf9fpctSX4zqsyhCARsqmYJIx3JTax86t0PYMM2IuIqNGj?=
 =?us-ascii?Q?npn+eB+8dGnsHqsdJ3kAjAv0JL0xRkZRLpnPY7Hqn7Sp4Z3/miEixpl+USrl?=
 =?us-ascii?Q?UvisZ1V19yECHmDPtyohMj5V5M3kX2xgDj/9uGPS2hEtZkAHBz66twp/22l4?=
 =?us-ascii?Q?u19HdyD6JK0bz5wqK6l/I41QjtBiR/yCV7Xf5h7AL5xFyj/Qz4MiP6f6cXa2?=
 =?us-ascii?Q?sqEyL8zdWP56zQZPutgzUacn5ump/y3lhzmInROVbceIIBwib4u1khfIYyng?=
 =?us-ascii?Q?ZiqPpecmVd63Sc5v0ZK+N0mWz1ReD8IbZbipFZ2sJwwcLY18GWZUzJm3PQZ4?=
 =?us-ascii?Q?eiJtlJlg3IYiSZb37MvYlkXBwlrjh3JbBO+oHuYKfMOHaQrD7ow5v90Y5ZbM?=
 =?us-ascii?Q?pIpBkE4dJbRjpO8Pzi2dOb9XBHHXNHQMIEbnGY3Xl00NUvh3Hpd752n5Wlko?=
 =?us-ascii?Q?cOL9K5Ws538XmJCYj0oRqsVvB3uleLXTH/Ca2PdAzQt3ATz2UuV+oPk+oJHJ?=
 =?us-ascii?Q?vjmnbYrC7BVY/DUW55c7rPjhyau0INGfS5NzsjCckrU/1XqDuT1px121LZ7i?=
 =?us-ascii?Q?p8rJklk8SYzrtfnZxJ1K3MvqEt7BeAYmndgBOpZ9g4YEdsy5/xTJd0ThUY3X?=
 =?us-ascii?Q?hTP6wlOp1jLctM3oRlC/AyTMf1qtt1H8+o+8GtW76qfQpthC+EKGVib2RMKY?=
 =?us-ascii?Q?Ndkqibdm0hQ/9FfA26sIH++CVA67k2+JdUV24HJBUjJqO/2qzNgjcrAas1E+?=
 =?us-ascii?Q?SKyEkwxspKXwIkWJHIxqTI3NrkTDZC4mNf7UAszlLZR34Rg7b78rOsqc5w1Q?=
 =?us-ascii?Q?gn5r7RErPSyaKsd6adZ6pZJGZSvZ0fbnbhxQep1YUxrKq3HuvQKZiGmRGaYf?=
 =?us-ascii?Q?pzEW65FQkMpclZXxQvVy/PhQlg5m/yEc25GvSm/19wVZLlXbvdzezHFyK3BO?=
 =?us-ascii?Q?J/Iq8b+RX6D84jVkahM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045037dd-c1c6-4c35-30b0-08db426c3c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 13:28:03.8321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UjQEWLyhK3QmAC9A4nWvJlLABdTcoB0GtS1Zu++pMHkc0T0RJGXXmQ3Xer42O/Nb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424
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

Hi

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, April 19, 2023 12:10 AM
> To: Mehta, Piyush <piyush.mehta@amd.com>
> Cc: gregkh@linuxfoundation.org; krzysztof.kozlowski+dt@linaro.org;
> michal.simek@xilinx.com; linux-usb@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>; Paladugu, Siva Durga Prasad
> <siva.durga.prasad.paladugu@amd.com>; linux-arm-
> kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH] dt-bindings: usb: dwc3: xilinx: Add interrupt-names =
to
> include hibernation interrupt
>=20
> On Wed, Apr 12, 2023 at 11:38:43AM +0530, Piyush Mehta wrote:
> > The hibernation feature enabled for Xilinx Versal NET SoC in DWC3 IP.
> > Added host mode interrupts and "usb-wakeup" interrupt-names optional
> > property in the binding schema to capture remote-wakeup and connect/
> > disconnect event in the hibernation state.
> >
> > Xilinx dwc3-core uses "host" and "otg" interrupts interrupt-names DT
> > properties from dwc3-core.
>=20
> Is wakeup really not implemented in the DWC3 core, but outside it?

Wakeup is implemented inside the dwc3-core.

Initially we planned to implement wakeup interrupt name/interrupt optional =
property in the dwc3-core.
However, looking at other vendor wakeup interrupt implementation (Commit: d=
d566faebe9f dt-bindings: usb: qcom,dwc3: refine interrupt requirements)
we moved wakeup property to xilinx USB binding.

>=20
> >
> > Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> > ---
> > Note:
> > - Xilinx uses dwc3-cores interrupt-names DT property.
> >   Link:
> >   Xilinx-dwc3 core:
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bi
> ndings/usb/dwc3-xilinx.yaml#L129
> >   dwc3-core:
> > https://github.com/torvalds/linux/blob/master/Documentation/devicetree
> > /bindings/usb/snps%2Cdwc3.yaml#L42
> > ---
> >  Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> > b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> > index 098b73134a1b..abc32db2448a 100644
> > --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> > +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
> > @@ -44,6 +44,15 @@ properties:
> >        - const: bus_clk
> >        - const: ref_clk
> >
> > +  interrupts:
> > +    items:
> > +      - description: Handle to the line usb-wakeup used to wake
> > +          up the host processor.
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: usb-wakeup
>=20
> 'wakeup' is the standard name. And you also need 'wakeup-source'
> property.
>=20
> > +
> >    resets:
> >      description:
> >        A list of phandles for resets listed in reset-names.
> > --
> > 2.25.1
> >
