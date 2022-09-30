Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4D95F0494
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiI3GN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiI3GNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:13:54 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2107.outbound.protection.outlook.com [40.107.114.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C22EBD48;
        Thu, 29 Sep 2022 23:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7Mb5pY0ij6kwxHPyAMulx0YCAkseRcJBs2rfwP3Up/xKk9ZO6Bt65W4hUy1ZSEo2/pT3uEtz1sW0/yeswkQpGnyu30ZSwbxomjBX8nHQP20baiAkm8DezHqOpogi2qhec6NxhSSESgNEo2WImIuJpTcxJ7qAgGJuyfFEKulpCUNK/Na49bnImkGdg/qj/ZkRjL12AqxjNTF7vrSvx38wl1it257q0QVJQMPux5o345GSgN/rSmPmFbXUEYvTElmB5HFM40hssM6Ppl9cFk2vQ5ssX+mzfxIovvHth/oiU4tKPYb4674MCbG6DnhRwyH1OajY7zMrD3/3e4qCdEYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6L2urzYeYTvkxOi91XsOQMcXIFp4cmHggDSnYkxVao=;
 b=USeRv1FanYVubQf8CfcJK18Ik0yR6EAnOLmQH3F47571OiDc6MuKT3SE/V2OlQqyZviw5NkbOXD93xROOj8jrpE0oV36UL8nOKtGTkHJUcluv3np5XiozMvvJ6MH+Aii6P0jK6gCNvhy/gqgciUHHKUH2yxxlaRZW3VIWdnwXBcoPEdTzw6xp9ag4HylGhI7sZX5H6qUdjkoCjnmPRVcUGWR/kGZDmN1MrNx0Lf/h9W74FPqfX8y4e2Xmmbk6u6TBcy5p6jmL7uSwwIhFS6g3InldwzRh1LQFUS8E1UUthJtkFdMbUsHD91W5k4RSiqbYfY1rl95xKSzhUJ9PxfNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6L2urzYeYTvkxOi91XsOQMcXIFp4cmHggDSnYkxVao=;
 b=JJidqJc8y0W0O/WCYP95/ZhTZ9Dqpqz/R0peJInMmftQjVg3cj4TfwBU6ZKyvIejkwDwbzBT9fXWJGGx6jbzHTexYZ4wIb9HrRsptjj8zSCLUosJnfNHqxLm0LFecIccFnLpGpnNgocIIuhfBv/AINe8iROQbcZ4r7W7/DBkRpk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB7968.jpnprd01.prod.outlook.com (2603:1096:400:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 06:13:49 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 06:13:49 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
        "zhangqing@rock-chips.com" <zhangqing@rock-chips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [PATCH v1 03/11] dt-bindings: pwm: rockchip: add
 rockchip,rk3128-pwm
Thread-Topic: [PATCH v1 03/11] dt-bindings: pwm: rockchip: add
 rockchip,rk3128-pwm
Thread-Index: AQHYxJoFJRxl0VNTjEqBljMFY9Zfzq3YwRiAgABSLwCAAusVgIABdW4AgBdmg4CAAsE6kA==
Date:   Fri, 30 Sep 2022 06:13:49 +0000
Message-ID: <OS0PR01MB592218C1636537D396A8E08E86569@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220909212543.17428-1-jbx6244@gmail.com>
 <f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com>
 <1662821635.180247.34700.nullmailer@robh.at.kernel.org>
 <1c13181b-8421-69d8-21ee-9742dd5f55dd@gmail.com>
 <20220912162159.GA1397560-robh@kernel.org>
 <37fd8d4b-3a66-bc51-c2dc-76c9e756fed8@gmail.com> <YzQ3He2wyD2bgxz1@orome>
In-Reply-To: <YzQ3He2wyD2bgxz1@orome>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB7968:EE_
x-ms-office365-filtering-correlation-id: e7315491-2eb9-4b3b-1829-08daa2aaf0e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FzKBTP7o08lCSsuOfI9qUrr9KmYgnKHXdbHSAPK809UBJactyWS/gKYjXNjXsBg9tX7gDx+Jb96WqbhjJtEjtDYmmbfGmOi1edZWaTSxJdFK86db162TCdftdjEwwBMlWVlLAAGHU6uAiX45w1/7mzNKJ+7ZWUWkoLeqxPdTkVLz2Yd80PFAcbQZmpAnzRzE/opb70XCFGhIgYRrDQF9MNjlXSvSY0398BAmKWNkul6cx/MMMWwzquvgpx5ZOJFpejxi/l/Nf2JkApbtfB4WJtQf6b8598CWghMCt6mXWsNorAw4rV67pr5vDpvo2bapn5Ys7y7cZ/QE+ZMPY98meQtJpteNa1kiFidrjBSqz7AtjXUWbu2VTsT1pSFY8rIYgnJUYlcRVbGgt3VzZBWvJftPVUFcD9SM/RpZ/+/4ruPTQcS4g2K4v+Omt0DxpBpUg1JqQdjx7eZmYWF9YGD7kk4EpfQCHpCoJe3iQLB56iRBbc2ofA0el61wufwc24qgD4wPwdASWSkBr0w1r57ah9OYlbVdvjUfGsO9Bnm9RWQRM9ricgDfBZh9jHH8KYsDkFSHEhgRdEYYoNC3eKcZQoyL86R642mgaji7pnAnlgJqccNMnqSyJR+PcS7pQlgYuNTzp/1sX1VYqk9Hrze1jZvHEfEqHJzHjNEgYD3lOM27IplNCoqwwIKOBlYUx/WUqC+eqoxMdXqdluBALSIIKI5zkTYsmhFcnCOrmY7LqiRtLvRbv6tdciV3E5ZaMQML7GHoIkuYkw1Jx1bxERcV8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(71200400001)(38070700005)(8676002)(122000001)(38100700002)(110136005)(316002)(54906003)(66476007)(64756008)(66556008)(66446008)(86362001)(76116006)(66946007)(55016003)(4326008)(478600001)(83380400001)(6506007)(7416002)(5660300002)(53546011)(26005)(2906002)(9686003)(52536014)(7696005)(8936002)(33656002)(41300700001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IDAjVpeqv0FNRfrhruJDBQNXw9kn2+EhNEfs7MIV5hT5VV54+zLArpBYg+Mp?=
 =?us-ascii?Q?lNjRPSk4knal+8U3xfkcIqgnKZJWOSDFqvxjeC/MRPmxlxXXK9hMep5UnVuE?=
 =?us-ascii?Q?VzbXOK7yhxNYDgxnCuqRoBFU7fW9cL4i5i+EgZ+Ia/Vs3z2/F5n6H2qEO8sk?=
 =?us-ascii?Q?8VXoUOwf3n03uNFDAJD5I3FkB1bXQxiAZ4juuGHl+R2un/25KHpzzBMmYGA+?=
 =?us-ascii?Q?vH1so/taCnh/hzXXO4uqctvtdM0GnWe2HJ+h5vSvI6Mptf09ik6I0LlWhKpq?=
 =?us-ascii?Q?Yr2LPh/7X4PeZYd6GKk5pwSWaj5vmCRuBuHxHJ1VlxTL9GdlX1KP5WvHx2zL?=
 =?us-ascii?Q?/a/dCM8bLqdcPlr+KBRuTcBBRdwNJi8Q8/JjnaV6G86mexcdzEXR4wlqG3Hc?=
 =?us-ascii?Q?2R513nwV7y1I7Fu3g73qb1z/hFMZJhUr/uUdiHbu/CbSgYCylQJjLujmxf2n?=
 =?us-ascii?Q?dtyVdfBM6vlYVIMf5GEVXzhx+ngCxg5jrbl6WKw13IhUH9YXHAvzZbDkjJFo?=
 =?us-ascii?Q?0wFodh2wNkIYFzBWEP7ACGcUc2RYLIioWy7/V5k+aG/k6AYFrwNi2HoCQlGk?=
 =?us-ascii?Q?sNXwlRgfsuHjxKz4gbp3atDXISUsA3NwF/90+RZvmbHLrLVEWa3ysEUi/fUa?=
 =?us-ascii?Q?sllieTXnBWUWdnZpQ2DlzOLpjisT2gZbZhE3xGJLrfG3qPWy4Qp7G6QVaoE7?=
 =?us-ascii?Q?4p+uUQgLB0v7ODSbgMRwUVRYe5tdqkwawv+PpLWgTzZImSY7IsXfAuBU4S3U?=
 =?us-ascii?Q?X76BeCt51wRMyhp6v5ndP3mb9xhHKhGG6nfEaHkHVxrMYdi8nFj8FXVxFIqB?=
 =?us-ascii?Q?rgg2YV5djPBjr6V8Z/e1p/WG3eSqn05dkKY4cdBeVPwSOqNrq4qbeCMR1G4s?=
 =?us-ascii?Q?8tVBLXIx7tqOChgcP2ihqv7+TrilhdH5gDmKXsJae41OD6Nvk5fN9ScpvATH?=
 =?us-ascii?Q?7RaIbfByjrxyPRkJlGF1hEg1teQI/AsGcV4op13pCXMLliSw0CWLLPpKz1xH?=
 =?us-ascii?Q?72wCqynzDShr3nJ2w5c1/3ru1kuHpm3CumpE8dOOqYdxKjKG4wfUGFOkXN3T?=
 =?us-ascii?Q?QHxntne7qqj2kp82drvmpSOAKjG8IjNSib30iQ3hr2oVJP6aED6lXVqtuD4E?=
 =?us-ascii?Q?jiHf0m7wl7NZ/qVzAHECOzZkgtY6V9oo+e8Xav1v3iGcl9MW5kzJZ96X0qCZ?=
 =?us-ascii?Q?T+IHijmCVKAWcOWL8+d1dfbb+C+sOhymj05jgZN/4hrMNI9wb7uXco7INS+X?=
 =?us-ascii?Q?PRzt9yz3j71b9zW+LbD0hXv+a4yCJxzNqBHG2oGcyJoXhrkOrjFVRRI8se1B?=
 =?us-ascii?Q?KDUT8x4liPIUbvuZI7dozBW5ff9m3jZXKxSkCejn73dlWUMqCX/0z0Zkjc/S?=
 =?us-ascii?Q?XrPHId2Qpzvfa9cOYvjYG2urAloVmAUjSbvq1YpDyW0NcRCg2EDsItk/EpfE?=
 =?us-ascii?Q?t6sYZoX66i7bAgAB1cstUPFgeBoHnsG07hjTiFViKyExC58I7rQfGbyW9Wbs?=
 =?us-ascii?Q?eHEsswOJVtvz8Ohnxl6qZpJDs3y2FZ5tOKT6WefFZeu54mlvhlQk9O7MbXbZ?=
 =?us-ascii?Q?z6KKfnkc0KLJ8emYY69YgputFsoScbM53IhHpB0lCtMpl/mCBSL2/1a7wVfE?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7315491-2eb9-4b3b-1829-08daa2aaf0e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 06:13:49.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bcneveLP8Fpcm00XWUOUQmmGvP4yHOsutO//Nm6Rz04v+K44XGuOcn9Bqc/349UTcaTcjtxZ8vcKVTyIuErVG978f7P0uqDzvY6R5VrK1Q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7968
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry Reding,

> Subject: Re: [PATCH v1 03/11] dt-bindings: pwm: rockchip: add
> rockchip,rk3128-pwm
>=20
> On Tue, Sep 13, 2022 at 04:38:32PM +0200, Johan Jonker wrote:
> >
> >
> > On 9/12/22 18:21, Rob Herring wrote:
> > > On Sat, Sep 10, 2022 at 09:48:04PM +0200, Johan Jonker wrote:
> > >> Reduced CC.
> > >>
> > >> Hi Rob,
> > >>
> > >
> > > Seemed like a simple enough warning to fix...
> >
> > Some examples for comment.
> > Let us know what would be the better solution?
> >
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D
> >
> > option1:
> >
> > 	combpwm0: combpwm0 {
> > 		compatible =3D "rockchip,rv1108-combpwm";
> > 		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> > 		#address-cells =3D <2>;
> > 		#size-cells =3D <2>;
> >
> > 		pwm0: pwm@20040000 {
> > 			compatible =3D "rockchip,rv1108-pwm";
> > 			reg =3D <0x20040000 0x10>;
> > 		};
> >
> > 		pwm1: pwm@20040010 {
> > 			compatible =3D "rockchip,rv1108-pwm";
> > 			reg =3D <0x20040010 0x10>;
> > 		};
> >
> > 		pwm2: pwm@20040020 {
> > 			compatible =3D "rockchip,rv1108-pwm";
> > 			reg =3D <0x20040020 0x10>;
> > 		};
> >
> > 		pwm3: pwm@20040030 {
> > 			compatible =3D "rockchip,rv1108-pwm";
> > 			reg =3D <0x20040030 0x10>;
> > 		};
> > 	};
> >
> > PRO:
> > - Existing driver might still work.
> > CON:
> > - New compatible needed to service the combined interrupts.
> > - Driver change needed.
> >
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D
> > option 2:
> >
> > 	combpwm0: pwm@10280000 {
> > 		compatible =3D "rockchip,rv1108-pwm";
> > 		reg =3D <0x10280000 0x40>;
> > 		interrupts =3D <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <0>;
> >
> > 		pwm4: pwm-4@0 {
> > 			reg =3D <0x0>;
> > 		};
> >
> > 		pwm5: pwm-5@10 {
> > 			reg =3D <0x10>;
> > 		};
> >
> > 		pwm6: pwm-6@20 {
> > 			reg =3D <0x20>;
> > 		};
> >
> > 		pwm7: pwm-7@30 {
> > 			reg =3D <0x30>;
> > 		};
> > 	};
> >
> > CON:
> > - Driver change needed.
> > - Not compatible with current drivers.
> >
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D
> >
> > Current situation:
> >
> > 	pwm0: pwm@20040000 {
> > 		compatible =3D "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
> > 		reg =3D <0x20040000 0x10>;
> > 		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> > 	};
> >
> > 	pwm1: pwm@20040010 {
> > 		compatible =3D "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
> > 		reg =3D <0x20040010 0x10>;
> > 		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> > 	};
> >
> > 	pwm2: pwm@20040020 {
> > 		compatible =3D "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
> > 		reg =3D <0x20040020 0x10>;
> > 		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> > 	};
> >
> > 	pwm3: pwm@20040030 {
> > 		compatible =3D "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
> > 		reg =3D <0x20040030 0x10>;
> > 		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> > 	};
> >
> > CON:
> > - The property "interrupts 39" can only be claimed ones by one probe
> function at the time.
> > - Has a fall-back string for rk3288, but unknown identical behavior
> for interrupts ???
>=20
> To be honest, all three descriptions look wrong to me. From the above
> it looks like this is simply one PWM controller with four channels, so
> it should really be described as such, i.e.:
>=20
> 	pwm@20040030 {
> 		compatible =3D "rockchip,rv1108-pwm";
> 		reg =3D <0x20040030 0x40>;
> 		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> 	};

Sorry to jump in.

Renesas GPT has also similar case where we have large PWM IP block
having 8 pwm channels. Each channel has it's Own pinctrl, unique registers,=
 interrupts
for each channel. But there are 4 sharable external trigger input pins for =
all the channels.

If it is a single block like this, how will you associate pinctrl=20
with each channel?

At board level if you specify <pin4 enabled>, without pwm channel
specific information how will you configure channel4?

Maybe something like this will help. Is it acceptable?

	pwm@20040030 {
		compatible =3D "rockchip,rv1108-pwm";
		reg =3D <0x20040030 0x40>;
		interrupts =3D <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;

		pwm4: pwm-4@0 {
			reg =3D <0x0>;
		};

		pwm5: pwm-5@10 {
			reg =3D <0x10>;
		};

		pwm6: pwm-6@20 {
			reg =3D <0x20>;
		};

		pwm7: pwm-7@30 {
			reg =3D <0x30>;
		};
	};


Cheers,
Biju
