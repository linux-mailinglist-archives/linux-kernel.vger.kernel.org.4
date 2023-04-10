Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081116DC3C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 09:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjDJHLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 03:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjDJHLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 03:11:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2049.outbound.protection.outlook.com [40.107.117.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC5D30C8;
        Mon, 10 Apr 2023 00:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuYQXDHdpsNqPlJXRPsWqyB2uQ5LODXtV5eyBxH8DkFgP4qCPJ3uBsZRkqEb9TJurarG1LFb96Ai9pH5Kj6mmR8aZIjbnyhG5xMhlP/j1lbfyqP/cqvJQjdnRyzmqxG1CS4W1OoRVHGQt3KWvL+2JnDmHSjaoaoZ/p/S7O3rYE98EZglDdTN/MMHjfkFahyDkug58yr+5w2Z8csRLXCAIstiHzd96k5r1a4ONgz1c8S4FS4HQx/lSGVoOwVzH3syjHR1YwJ+SQm9zLj4/gMKCNDVQTYB17O0PYMsP5TE0HBLyA4OSWNgTD2WY9qFbvwb8ELQCW6lFPjhxSwG7fyiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUAhVkwZrlPOMdMrh9bbMRGuXcnjTPhYSmqwv0Qvvo0=;
 b=UdpaGCeQCGtBCqrdFQ5HN7lYlqydabndvoWr80dQ22+03DtkVKDjUtUv0JqK537FjU60isGwu0bW3/kUyVpi/egdx12GM1aqquhU51mOAZKln4CyUjJU0+uIb6osqUSqENjWONavk0fGXJ3vQc2P+t3LfiyVENoXoEa1yjnUAkm3OiLdBqNlW58hLNrf3Lb5rF1rFUIpHIGCH2vxcAB+Wk9jDtfBWNefYnedPJPnrWY8z7WwwKdQm1QlVI0nJPPp94S2lUEaBZd64b8Kdwnp6yn5L5KMmUjL8l/QmMB57tCCq/dzHT2AoO8qNNUP9yxd80qnaq4U47jXQIOj3Yz0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUAhVkwZrlPOMdMrh9bbMRGuXcnjTPhYSmqwv0Qvvo0=;
 b=fT7ruVhE21XokAcN0KGRzW8G72lSyxGXDKBkT9ythAkAdxNcjwGz44BF6RNxEqswzcB8g6pC3u5EKrHoFmuDmbvqYBtH4z0C2DEo49493z9D7IaTH2nqBdMLqWpD5GZf7IdBwzu3uusSli7JILB4PrbkZk4FY1Z7lfw9EYm4Wo1zMf2OE4atwvBX5H2TjyzTHYHRXcCAdmXmLDJvF29drHYhTC8hxVyTuT1r58nwqt4ee3sqb8RgVbWib+0xlJ//gqZGN6y3jcHSvA3oUtKlYQnzXD/krj8eQqvpJJX+rhqELGzyuHQKqi1nIrNV/bhVlrs/KpEnszQLqORHWaNJMQ==
Received: from PS2PR04MB3592.apcprd04.prod.outlook.com (2603:1096:300:61::21)
 by TY0PR04MB6445.apcprd04.prod.outlook.com (2603:1096:400:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 07:11:34 +0000
Received: from PS2PR04MB3592.apcprd04.prod.outlook.com
 ([fe80::285a:4ee7:6103:61ec]) by PS2PR04MB3592.apcprd04.prod.outlook.com
 ([fe80::285a:4ee7:6103:61ec%4]) with mapi id 15.20.6277.035; Mon, 10 Apr 2023
 07:11:34 +0000
From:   Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
Thread-Topic: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
Thread-Index: AQHZYhkTutxhEWwlQkmbugxPVHPWKK8RbwYAgBLDDTA=
Date:   Mon, 10 Apr 2023 07:11:34 +0000
Message-ID: <PS2PR04MB3592E90B033CA23F47CD02F2B7959@PS2PR04MB3592.apcprd04.prod.outlook.com>
References: <20230329083235.24123-1-Delphine_CC_Chiu@Wiwynn.com>
 <20230329083235.24123-2-Delphine_CC_Chiu@Wiwynn.com>
 <b66f708c-5369-c1c9-5506-c609a245bf4c@linaro.org>
In-Reply-To: <b66f708c-5369-c1c9-5506-c609a245bf4c@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR04MB3592:EE_|TY0PR04MB6445:EE_
x-ms-office365-filtering-correlation-id: 4e2d9479-7ebc-4ae4-0d80-08db3992d14b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JPqfg2D6HYlpC6Da4IOSH+JfVJvKJ1HZevN9Wd89M5RooGwxWXh6EZEucxMm3BLqJUIXRK9fy06b6bsyILAS5YTcIC0yYcElwwFVxUkEvbISB4sj5907naYqchTPB7RXya63iIyytH11IaaYFD1IhdWD7ig/5+eVvUqsQaPjrHViXL1orzijAnWFmmXn6s3YAmzx08EPDi46zTUj3kbO7gEaqlZfTpikzX1k5LaEWcgja8IatjB6JNxx0q3nxs/fzv2l9ICitVMID+qOzGIfet/NrEhJJIuZixE6UDecRZ2B6HVyBPMrs6eu/zJNVwYJJd4bVHk13ss6YMZUMrImLeQlYm6GXyLXB3HXApzdFud8m+WqKFyrmQaOBXLMiCoYh362kYEMy+qC7KwM9lPiNs2nwEwkLfwhHT0uDaMqQmOqlIDYZLjNsp2x5TJ+9B5z8Y/nAsiB3mmX+jw6P0NzYO4377evnHhA95j6Mfhni0iU7+PuRpp9huqWE7vydz5X7bhHqvqlpGM9UEQSw3BMJdDpd9lxXKreMBqTir3n9/zMoFDxNLOS/7giw9JecqBYOWap4OmgN5dJaK4yCQ3XCjIh3VsTrnqDLijIymeIKKc1GWRjmXszjV7yu8pQ6OK3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR04MB3592.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(55016003)(83380400001)(76116006)(478600001)(7696005)(186003)(71200400001)(110136005)(316002)(26005)(9686003)(6506007)(53546011)(54906003)(2906002)(7416002)(52536014)(5660300002)(33656002)(38100700002)(122000001)(66556008)(66946007)(64756008)(4326008)(41300700001)(66476007)(66446008)(8676002)(8936002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kKVAoGl0J2qGy7JlVQQBMnbgfHYbwTgjDzPKs3gL8fyPlKFpp6TB80Lw5mpN?=
 =?us-ascii?Q?XcXTMpNA8VlK3+/0lEVxNlTfoRgwVd/BrZJIpjqxteoCc05PVm64+lBBN291?=
 =?us-ascii?Q?990ma9LtsUytKty5055QMewChQhVGsbjzASMsl5OeCaE0B5VN7DAUwxPeAVM?=
 =?us-ascii?Q?0MOuwbjEPmuPKBoFPa0Bi/wVkD9pgE0d6u2HQ1NFv+aguzW7CBF1b7NlaKQ6?=
 =?us-ascii?Q?4WqDZWllDLQ/7W9j4Dp1Zpp7PJ4N9NU5ySzqvzBdTQsYt0dNAijAf74xvH1V?=
 =?us-ascii?Q?RqlEkBmaePcKYchbsjBVC3rexaDAxJ56km7iQcGaBJlp1J8e25P2I+FqyKYX?=
 =?us-ascii?Q?AcDTwRlgnOjNjus8L+raCdnk/y5wtMzXOLxmKY3JXvS50/JBrqry8QD19xmZ?=
 =?us-ascii?Q?YS7YQg45DJiODYuJ8itk64bPVVvM5pI5wR9dfY6REJk4bPG/V6cTrk+BBlcH?=
 =?us-ascii?Q?oGO2aTAEyj/doY6iLyCYirWnZx+Vm1p++SCmP79ndPizrrlspQl6GGoZpg8F?=
 =?us-ascii?Q?/BApoVR+ysUz4ljuDWIcU+MObongbDtbSakFytLO31h1sR0di1SZiFRVbHfO?=
 =?us-ascii?Q?gMkSfc9ijgbDnbXebFkgW1D3hv7H6YoWwn87rrlpbIPJ5oEniKLD+0+KT62V?=
 =?us-ascii?Q?jt8iX0wVncp0BW0oM/W2Zzotp2O+hDSq/Kpa062vTQgjaO6QFICJ+ZSnNnYf?=
 =?us-ascii?Q?pjFyb0iD89HNHpOkeEJ6E7nRpY3VY5g9e/rZ/udB7+lhiSD5RB6B7yG+jZ3j?=
 =?us-ascii?Q?koXyjGzEPtdgeVhmpzrrhypckWUo4hUXUH3OEuuV9MfvKHYaO2tTn8ANhB18?=
 =?us-ascii?Q?+fQM2JWtGgN7yyeBvWrfupsA6fj1y5IpkTNLDuhpR6zYg4FR8ehBkX6dUmJW?=
 =?us-ascii?Q?zIzdby13XA2pbgBRJDxmsxpnEdZhdH7NWqUqfSlPBfQtjOV84S+lj5bXbLSx?=
 =?us-ascii?Q?M6h2A8lNKZFAKgKgtf6djEN4tTQqCkGoyA6neN+eLRW4aefROT9MVPSVBpEm?=
 =?us-ascii?Q?l6o460KIdmllZFAETtob2jheX2n2ObrVyvs/EjuGXU3QnvfDY6pZeY+j4KE/?=
 =?us-ascii?Q?OFcjua5RSzwbIBgnTVBiYZmambd2/NHgpWi4zMxHjRRGK+o9tGePvhH+rm3c?=
 =?us-ascii?Q?ZgIzqpKCjL/nTBHa3Sg+YTcLFPJOV88/McuFCZwF+VhjpHVQSGttcBxy+X8p?=
 =?us-ascii?Q?8DZWp/96Lb/ZryIyPLBFjcvnKcKTZG8n42phB1KYUyrMfRSOBAMFcY2Jae2C?=
 =?us-ascii?Q?z5Zuw36H0fOypq3JSgHszNfUsbJTHA3BwJSX5Frrfin57vwzdssslW4bcDc2?=
 =?us-ascii?Q?xiE1rpspcdEbLaMq97aIWvLfmt7EJe9aP8vv9tYYL7Gj6Qh7PFu5OA+ySOqA?=
 =?us-ascii?Q?Cf/3P1SCwOQnnZdQykj6nM0r6Re2rLd1jD/fMlZPsZtOaeu/Y2P8+eID04w3?=
 =?us-ascii?Q?LPWK36+6ACzbhuxVJJd/W9eAC+2BU1+ZGsRlXqOMJenKgy3xKPl5UNwWTDrs?=
 =?us-ascii?Q?aI75vYaRJDnUN0FsE878+AUJQTgRo3b6RNqEwDJGfNc1hQPiH2KpeL+mZ7jf?=
 =?us-ascii?Q?NjE98aUnVQpnYWeqiUqkepPDHt0t1gk1W268j8qq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR04MB3592.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2d9479-7ebc-4ae4-0d80-08db3992d14b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 07:11:34.2327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VICKgVs0xSPlkLw9e1YiVT3CDTnhOKMdjGXqxZlxt4aMmE2bSdt/A3Fc8rKfoLjTd5IIzNOi94SfKjcJJjrmgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6445
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,WEIRD_QUOTING autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for reviewing.

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Wednesday, March 29, 2023 4:37 PM
> To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> patrick@stwcx.xyz; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andre=
w
> Jeffery <andrew@aj.id.au>
> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v1 1/2] ARM: dts: aspeed: greatlakes: Add gpio names
>=20
>   Security Reminder: Please be aware that this email is sent by an extern=
al
> sender.
>=20
> On 29/03/2023 10:32, Delphine CC Chiu wrote:
> > From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> >
> > Add GPIO names for SOC lines.
> >
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > ---
> >  .../dts/aspeed-bmc-facebook-greatlakes.dts    | 49
> +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> > b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> > index 8c05bd56ce1e..59819115c39d 100644
> > --- a/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> > +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-greatlakes.dts
> > @@ -238,4 +238,53 @@
> >  &gpio0 {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&pinctrl_gpiu1_default &pinctrl_gpiu7_default>;
> > +     status =3D "okay";
>=20
> Was it disabled before?
>=20
Yes, we have to enable gpio status for meeting aspeed-g6 device tree settin=
g, and set net names for pulling gpio pin from application layer.
> > +     gpio-line-names =3D
> > +     /*A0-A7*/ "","","","","","","","",
> > +     /*B0-B7*/ "power-bmc-nic","presence-ocp-debug",
> > +               "power-bmc-slot1","power-bmc-slot2",
> > +               "power-bmc-slot3","power-bmc-slot4","","",
> > +     /*C0-C7*/ "presence-ocp-nic","","","reset-cause-nic-primary",
> > +               "reset-cause-nic-secondary","","","",
> > +     /*D0-D7*/ "","","","","","","","",
> > +     /*E0-E7*/ "","","","","","","","",
> > +     /*F0-F7*/ "slot1-bmc-reset-button","slot2-bmc-reset-button",
> > +               "slot3-bmc-reset-button","slot4-bmc-reset-button",
> > +               "","","","presence-emmc",
> > +     /*G0-G7*/ "","","","","","","","",
> > +     /*H0-H7*/ "","","","",
> > +               "presence-mb-slot1","presence-mb-slot2",
> > +               "presence-mb-slot3","presence-mb-slot4",
> > +     /*I0-I7*/ "","","","","","","bb-bmc-button","",
> > +     /*J0-J7*/ "","","","","","","","",
> > +     /*K0-K7*/ "","","","","","","","",
> > +     /*L0-L7*/ "","","","","","","","",
> > +     /*M0-M7*/
> "","power-nic-bmc-enable","","usb-bmc-enable","","reset-cause-usb-hub",""=
,"",
> > +     /*N0-N7*/ "","","","","bmc-ready","","","",
> > +     /*O0-O7*/
> "","","","","","","fan0-bmc-cpld-enable","fan1-bmc-cpld-enable",
> > +     /*P0-P7*/ "fan2-bmc-cpld-enable","fan3-bmc-cpld-enable",
> > +               "reset-cause-pcie-slot1","reset-cause-pcie-slot2",
> > +               "reset-cause-pcie-slot3","reset-cause-pcie-slot4","",""=
,
> > +     /*Q0-Q7*/ "","","","","","","","",
> > +     /*R0-R7*/ "","","","","","","","",
> > +     /*S0-S7*/ "","","power-p5v-usb","presence-bmc-tpm","","","","",
> > +     /*T0-T7*/ "","","","","","","","",
> > +     /*U0-U7*/ "","","","","","","","GND",
> > +     /*V0-V7*/ "bmc-slot1-ac-button","bmc-slot2-ac-button",
> > +               "bmc-slot3-ac-button","bmc-slot4-ac-button",
> > +               "","","","",
> > +     /*W0-W7*/ "","","","","","","","",
> > +     /*X0-X7*/ "","","","","","","","",
> > +     /*Y0-Y7*/ "","","","reset-cause-emmc","","","","",
> > +     /*Z0-Z7*/ "","","","","","","",""; };
> > +
> > +&gpio1 {
> > +     status =3D "okay";
>=20
> Same question...
Yes, the answer is same as above.
> Best regards,
> Krzysztof

