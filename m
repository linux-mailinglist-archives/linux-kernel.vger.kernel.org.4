Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31EE68A709
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 00:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjBCXtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 18:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjBCXtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 18:49:11 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2052.outbound.protection.outlook.com [40.107.13.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F466A778B;
        Fri,  3 Feb 2023 15:49:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQnhSDLebOZvLICUCJYv5IRh4+WOlRSS77M2CHwNo68ZGjuQBSxdsV3RQ3Hbsf/BAgp5Cz50rY18SwHeWZ4J+WZovgdm2R7XuZHU1HrRaCgo5/9vmwZBYcSM2ohA+g6joCVv9uBMrRKH/13obSZCJ16fsAw2XuNPmKmBo8FMMa2g4pVQfquagHWAOL3i810Ru5QyJ71lpnLPrVdh02WHKrdtkAYr5IkvPjyyF1eZbIIz+p9hJRurMCTj6MFVg2UODIIUQU70l0Cfe9vtnudt8ZT6LXXU0Hg8R80tdQFccZ71YPvQ16H6TlWnqyI6NDIJPcOJy+GciqIdVfNhwH3LaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNgRerGCxDBsgUgm8oAU6xbOSQAWv//Tcw4lE7u4ZpI=;
 b=QpIsuj4LCTgpB3MLBik7fB7bQCUPv9Cooi4KxVWNqySbLDrMDbtPVfqfE1hSVAS7wFD1z66jJTxjegGLA2gjUx+TgtGosHAzKxsVpAPMScCtCVsZYAXXtLczTkn9yZjNeuJ8FNE3qPzLgeRTAPdNUhGAj7B3ViLpFwWn4xGyMKlwTHi6J+s7tWMN9nsG9z5f6HfhZQSyaWCxi6Q/4ZXLsNPs/4jQ6rqgX1b+Oc3IGmU6EQ3L0+lofJG1vDdHOa/f8A2WtHu91C0JH//lrCjjcCpqMinQvEIH5T2OCd2Pc7QUxCYPRjyM+Ki4G6s421KoSMiHOqa3UDL7htIK8MSLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNgRerGCxDBsgUgm8oAU6xbOSQAWv//Tcw4lE7u4ZpI=;
 b=MKp1QdPfsWyq7HZQtEH6Hev3s7YlxdZD119c1nuHHB0GYhtWrS3SXvKU2OULrs8PGDWk2OI/kNYi44WVfN2qKt+kpeoGv3LCE2pcZaR42Dd4G+gcB53RmGMBQVPq+06SZ/JhSc7LEiueSrEnEvfbb86LBBF/jOoZLXnk2oxSEVI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7785.eurprd04.prod.outlook.com (2603:10a6:10:1e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 23:49:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Fri, 3 Feb 2023
 23:49:03 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>, Jun Li <jun.li@nxp.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V2] dt-bindings: usb: snps,dwc3: support i.MX8MQ
Thread-Topic: [PATCH V2] dt-bindings: usb: snps,dwc3: support i.MX8MQ
Thread-Index: AQHZN3EBIMdG65+qaUS6uw5+ONteWa69PnYAgACmfBA=
Date:   Fri, 3 Feb 2023 23:49:03 +0000
Message-ID: <DU0PR04MB9417FD3A56076FC789D2719688D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230203014526.1461386-1-peng.fan@oss.nxp.com>
 <167543212276.4084541.17286318072815310709.robh@kernel.org>
In-Reply-To: <167543212276.4084541.17286318072815310709.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBBPR04MB7785:EE_
x-ms-office365-filtering-correlation-id: 277eca59-3236-4b83-8cea-08db06413b03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cq5qWvcgy3pgfIiKTkIwe5X2e1rhpS1bkG44UJ2cz/EenX867xNd3DexWzTGwNXLj7neZGCWBzjmOjIoDrBRW2inxhiWd5qLG2eNbGpxXxds59+pFUH1iPGwzuIen19KqANx4xdQQtw8esps9HCOG3MeZ242ndHkqfxTXVTC8l7tNtsz3sO3Jz67lzSyy53hi3g2ay4KYAIrYM9El8MLAgfW2m/Zt+oCbpTRKeoWAZet66UWNkvbKmEnhACxfRYBKbck8wrHEQGEQ4ye9hS745SPd6tU2eHdJzJyo8P1lZwG4OGA66P4saRANdVcupY+ePJW/mCV3rQChbHLBDHcoMiBzchjrZn/IQ/IF+UqXAsFStaNV68eglShHQvDJbRUagS1RchUVJ+SA1cnjAfWtmMJqtWEYP4Us+VmH1g74DtYSxrgP5zVCIhdBWB96ONN9yA+y0GVXpYwjPiB5LcuU6vmBmG+g8CcGtVKAoj1Fb7ThTmxGQbOtm+KNjTyXYO2wA5QjjLoLMeHXgIL8Ci14vr+aDCzglJXztIHbYKUk1bK7oI2j39HTtibwPXsssBEFZhFpYNe0rJy3kxiis8bYIF5QpvvYGpdVbbgRZIXwYA/aEXRp3DPSgrwRvTKron5kBvmHE9L9NJyS0UnWwKVARjfX+1gu0vh4oUHsXQnt8h6siWccIP5eScoxQoBLdEjQiXgr7WL5L3RqU6Z0r5wkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199018)(66446008)(316002)(54906003)(110136005)(4326008)(8676002)(76116006)(66476007)(66556008)(64756008)(66946007)(41300700001)(8936002)(5660300002)(44832011)(52536014)(2906002)(38100700002)(122000001)(45080400002)(38070700005)(71200400001)(478600001)(86362001)(7696005)(966005)(33656002)(9686003)(83380400001)(186003)(26005)(6506007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2dP6UqbT+RVm8RtUX6amF7GtsXTgOpMBXrH8XUbLGBLkSQMcp7C76zDYIzb0?=
 =?us-ascii?Q?ZaU1lxhPT3fmLq644hDo3vGfr1TVgJRqPeguSu2KEBAAHH+s0pvA2OOATx/c?=
 =?us-ascii?Q?uV+EkEL3UWLHtIwvPHSDAPIutpcEZUIw9lDAUpRfjgj1lGJR4dXyqbeADv9/?=
 =?us-ascii?Q?wd/wRfcXEOwx7H245YnOYRpuqvDP6PRPeRQAUzSrrVgEOzTFRLZ/Xwe3kJzb?=
 =?us-ascii?Q?hkGGQX312zBnbma+ZSHcHYb+s1VErB9/u6knxr8UxwGA8MfAfvYeMW8mvK2x?=
 =?us-ascii?Q?l2qBp6w9J18oc+N5R1baG8Wt1o7I900+a4SvpxeVxf3aHzVNX0EQEneSLbwh?=
 =?us-ascii?Q?KiedFxbTi6dIo0OLRtD96Tp+hSq/H0x5fBxJhFYKerDeAUo3pwRqP6u1jvED?=
 =?us-ascii?Q?oO72trgN8h0pai+rGc+wO6lSJw96sualAs/de+PKoZulb6LfXeniCOTZUyXf?=
 =?us-ascii?Q?+S74Qhp1qf2MVAAz9BWSt/dS3miU+02CTzCK+aK5GBkwBC9zlXbezBtppiQh?=
 =?us-ascii?Q?eThBgKlO2vyd1hTJ78mt5xlohlFgSy5Gr4P3NpmWXxKwZUZUr1Jn61DpKjm6?=
 =?us-ascii?Q?2VUmRNBgRg/XFTErgduQO0qzeDRbKuFEJftNxNHJRotYQr6oLMhP9Yz3MXGI?=
 =?us-ascii?Q?mIicnR2ZmlwXK6hacgC5QBQDJD3eLsyIRfgc4edtVAmJ5naWP1L5LmhwZuxp?=
 =?us-ascii?Q?p6JCxAU92W708C0+nst0JrSLmlivRRzWUMpfRX8tToae1lmDK5WBWmlaFpvF?=
 =?us-ascii?Q?AIJgJtel8yQbqrkYIxEW/Vx+g/Ui3TI52bnKO2rp9kWT8Gc/9maxSb1HnyjT?=
 =?us-ascii?Q?4Ka4O18gqaHJ7Be8vExLFvgbX7XkL5+Xywo36AeHpUBsAQwQ62qkUcSdOY4G?=
 =?us-ascii?Q?cH3lF/m7VnPL5I3ZE/JYUEgQAOqh1fGLAvdLpwKlwGnoeYt6oilgNWhIAM0I?=
 =?us-ascii?Q?wh/Y6JGTilvvwJ3RgH+coGLMUqhP6EWOawI30f4SUvvomQkxQFLWJ99BwR7c?=
 =?us-ascii?Q?AgoR5bGXc3CNV1oNOo7QI+zprByyhMS0O5pwManODpbSXiqRCyWOmRoogTI4?=
 =?us-ascii?Q?RkhCg/rQew+aBCybRfzc/EJ8T6AMw54Uip2YmTjd02F/weEDzPimd5ypiild?=
 =?us-ascii?Q?3uqfzEviQH2jXtzLyDeAq9Bajp4tgckJIkDSBOq7vTQclX4Z6m0kuwr5r9e4?=
 =?us-ascii?Q?OB9qA2rntKrHxgxRPTPjSvbQ6nFHPEjuaDZ8keDIbb7h+TmdfJYXqjEAoSmq?=
 =?us-ascii?Q?tDoWAiXYaF9DiQj+JLhnOy9l6hALPUxfUP0Z1SXm9TAa+ZDt9/zThkVirm3s?=
 =?us-ascii?Q?b2L0CFVnbwWvtbz8AV/EaDE0vE2xLPbs3PNKv445chq1f7N/s+rn7f6A4u14?=
 =?us-ascii?Q?VpCtX/0Hmr+XAeZ88kgcXG2ECPzFCKp+szEWGu4WpmHS7ZMHOSz+GxCVYs85?=
 =?us-ascii?Q?Jvg0qu6fjgrHA7lkOakAc6ZmQIgbZmeTcBVsIt+A5hTSF+lMe0dGy4YnSS11?=
 =?us-ascii?Q?6fxz4VBl62mBkGfpMjpOwo6Gz9An8hhjTqWBLWZ5vHuJmZw2c2Le1J+427FP?=
 =?us-ascii?Q?Vs7oO+8o+8q9j7eQ9UY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277eca59-3236-4b83-8cea-08db06413b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2023 23:49:03.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91nGv1iCoANK/F4xyMmQgyHFwJWk9kru/VjZCp78y7ziHpYxXZUmof2Wd5K5/nU9J2IkwxS07SPDzSHM82uEJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7785
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Subject: Re: [PATCH V2] dt-bindings: usb: snps,dwc3: support i.MX8MQ
>=20
>=20
> On Fri, 03 Feb 2023 09:45:26 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8MQ use Synopsys DesignWare USB3 Controller IP, so add the
> > compatible.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Rebased on linux-next, remove power-domains from v1
> >
> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 12
> > +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:

The error is not related my patch, I could help add rochchip and LSx suppor=
t later,
this patch is just for i.MX8MQ.

Thanks,
Peng.
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.example.d
> tb: usb@fe800000: compatible: 'oneOf' conditional failed, one must be fix=
ed:
> 	['rockchip,rk3399-dwc3', 'snps,dwc3'] is too long
> 	'fsl,imx8mq-dwc3' was expected
> 	'snps,dwc3' was expected
> 	'synopsys,dwc3' was expected
> 	From schema: /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.example.d
> tb: usb@fe800000: Unevaluated properties are not allowed ('compatible'
> was unexpected)
> 	From schema: /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.example.d
> tb: usb@fe800000: compatible: 'oneOf' conditional failed, one must be fix=
ed:
> 	['rockchip,rk3399-dwc3', 'snps,dwc3'] is too long
> 	'fsl,imx8mq-dwc3' was expected
> 	'snps,dwc3' was expected
> 	'synopsys,dwc3' was expected
> 	From schema: /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.example.d
> tb: usb@fe800000: Unevaluated properties are not allowed ('compatible'
> was unexpected)
> 	From schema: /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.example.d
> tb: usb@fe800000: Unevaluated properties are not allowed ('dr_mode' was
> unexpected)
> 	From schema: /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
>=20
> doc reference errors (make refcheckdocs):
>=20
> See
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> hwork.ozlabs.org%2Fproject%2Fdevicetree-
> bindings%2Fpatch%2F20230203014526.1461386-1-
> peng.fan%40oss.nxp.com&data=3D05%7C01%7Cpeng.fan%40nxp.com%7Cee5
> 16452b425433a617808db05edd0a4%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C0%7C638110291187788208%7CUnknown%7CTWFpbGZsb3d8eyJ
> WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> 7C3000%7C%7C%7C&sdata=3DK6Ys5viPQON7rwwF5Vf29oBSYHWxuP3X%2Fm
> Bl29S%2FQ7U%3D&reserved=3D0
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself.
> Note that DT_SCHEMA_FILES can be set to your schema file to speed up
> checking your schema. However, it must be unset to test all examples with
> your schema.

