Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2606A6589
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCACeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCACeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:34:10 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6243E32CC4;
        Tue, 28 Feb 2023 18:34:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoOx5jITY6FTlEdh4lPiw2gwTVU8vBF0upTmHj2BPIRPik8XfnxqzHSNAnKdYytXhGVeBqKTfMo8IGuySZgOs0B8lH1nST8MCz6pRH9HQhffbTy/Dt5bP6vqG868lTt99yajR3NavAAfL7H/JwHegz0wJBHQDk54BNwHNMdy6xnbk3YMO+HFJ5We5zwIlXohjhb7rdAZYDyj2ck1HD3intu8p6X1g1pUYfJ9lnSC6HTlZU6yCgSpi3FXwkUqZKyArUtcN5GRuDYSFu5MlsMzl7IDgMRb2xSLxF/cFPODel05Pv1+Zjx3QX7r2g9oFouFb8deThs7wGPlsxybWBpqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pmHnuVC0fgTE0QI/Lw+VNwSDKuPgwrsnd5drNhX588=;
 b=igWZWrmcGtcpb8BfZ1A2sk2Op9FFZX4C0Qba4iMJzhdxs7PmUNxD11vXoOfThlzVrvAxQ/T5VqaOmSaBeTgMTS7QBV4IboZkfzWaSP9KDa5WppuvJsJ9a/lQrIf/KY5Ii7ANJY74QHRUMx4GXi+tPh03pYKplNG+a7+Ja5n6LKCeO4qOi/QA21AgToSiNTKM6Vg1XHRn9CRSehASNq+dFXqAFNHb70l50kl4ysoOswNbcgeL/TiTEwnKL6Y3ljuepsD42UGbFEaqIGbyBL+pnxQZKAYUT9Ut3smViRhGaGM/CzKjmmBfktf88aXVxRJBy+wdZ4brbagEz8GrW9x1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pmHnuVC0fgTE0QI/Lw+VNwSDKuPgwrsnd5drNhX588=;
 b=gGcny2suReH1dNpj8n0Hf0tCGdEyruJpbOHJEGcbtMPXDwCLonUUnSQwFcaxTkLvECNMNWcuER9DY9yU9gvE6AG2371Zbbs/UNx4E1oyQ9pOhJeg001MBuJWsN5s53G5IRjrE9aN1GxBCN2Bkn0GkLHaEXbIw5m9HWhs9zWd8Ak=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 02:34:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 02:34:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jacky Bai <ping.bai@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: clock: imx8m: add interrupts property
Thread-Topic: [PATCH] dt-bindings: clock: imx8m: add interrupts property
Thread-Index: AQHZS+EBh/OWT4xnpUaYX+DXnCXQT67lNAkAgAAASIA=
Date:   Wed, 1 Mar 2023 02:34:06 +0000
Message-ID: <DU0PR04MB9417700E2F71A06D9A7247BB88AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230301020122.3389102-1-peng.fan@oss.nxp.com>
 <AS8PR04MB8642379DB76D1C529CB8960487AD9@AS8PR04MB8642.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8642379DB76D1C529CB8960487AD9@AS8PR04MB8642.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PR3PR04MB7322:EE_
x-ms-office365-filtering-correlation-id: 671d28ab-7388-4063-b35c-08db19fd6dc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxXNH2h98IgIDS5F66SfbIZ+VkjPvH72OAOnoQQ71skSY1ebcj5dAPhVmAogPadK8ilxmIa1liVJ8YVkt2svMtqeaj8/uGsKw07lVfL934uNyJyjQyoYlQY5nXZEKVrmeOr9CIRKbnvxFXC9FsUYmJpTcYwvWKgxNFbSW92cdHGcq0qN+nLDXY8JvgZg1fDdiTLh/XDVDtl79us3f7UKZ0YTwS0XCFKarafIuLso0Z/VVIXHToi2+e8yKddlTyOC8bXLr5EHIxIr4RoJ8ve6wjrM5nqEhlju40O4QL96xjudBYsUhjh6OZC/lIb+Fv1k1m50fsKjpF9aQsbXmEbAdIOCkExmj/IZAky1ef46RQD8SRS66IuC9UhW9TmO6R4M9M4d5KH2+SPqq1iWEyK64XKKBBaeim712FFavjbKHAXWR55T6phH6PFXCQOt71UryQgv+F/r9ae7YLxRPu1K6SjpJJ7amyjfCv2+AMxEEx0xOC1T1wGbqwvJ/QYGkNyabAJbjfE+XXdamoTpYAcqJD1/3JIL/7qPW7G1TglT5QFbnbBz7ybrQXuWWT4F8jqzCjQhaViUuIbv4jgfH2vRod0HO2t224scI+a5S5jAX5JFhvOM9Bx1kuk3DAbe2ud6r0qJc+scivsSLvksvutKn7oUvcauzb12tIyBB+RWg8JXCpbBpCdjotC1g1exPP5kP6knPdcC9FgL5LQ9A8lg3CEDrRS7RIjPmUkXjTO/yEcvUIYeSSL51rH4ff1tzFPV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199018)(41300700001)(52536014)(38070700005)(5660300002)(44832011)(9686003)(122000001)(38100700002)(186003)(26005)(83380400001)(6506007)(86362001)(76116006)(66556008)(54906003)(110136005)(316002)(66476007)(8676002)(7696005)(33656002)(4326008)(55016003)(921005)(66946007)(71200400001)(478600001)(2906002)(64756008)(66446008)(8936002)(7416002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iMiYbdVfrngvjAuoPuC10d5YDYNppn9x6ktfdNKoXxEpugxr22LppKy4xMe1?=
 =?us-ascii?Q?xmR3OOxDD2TkTrUyHs1lpkOPYvnqS1oVVKR31Z10V1aLosOIg7aMuHcMw8Ly?=
 =?us-ascii?Q?5b/Rf7eXmcDIJonIgfhzTIxcNHOH4NlFeXk8CBb8+jElUXkcjnLJ15olHBnd?=
 =?us-ascii?Q?r5kuA5iPcNzXO0PNnzyvFPBjXXZUIKTRpczWhhDVwd3kuYN6M84wcE5GnIT/?=
 =?us-ascii?Q?+5Ja4BhVHFEzTTHnmUMsx8EUU68qOJdk7PvUqW3pAgjkKSXasR3InHUPPriv?=
 =?us-ascii?Q?E+kf2uU7ztLDDGInMADslLt1HXWQEh2Euw3XULF/0udNVMrBSsp+nH0ajfiI?=
 =?us-ascii?Q?EaAKH0SqSe8AXjmoMlYCZF12iJNTPJeJneu873kUH5XJVmuLmYJXZlaYmFKz?=
 =?us-ascii?Q?UF9y7MMGAzUgSFY5/iXOfqm1KvERkC7XdGXLNWPQ27Ujg5EUDxLd1zFgKleN?=
 =?us-ascii?Q?VCZgo6auDYR7+l+0cx/SSy57CVodHHthwGewJKB3kC0TS2aL7hII9OvsF7Qk?=
 =?us-ascii?Q?wvUI7KaPuMhEGgBO9Ck37w7qMp/0nMbdATzETdDqdpGa2F+Hg+LtI/xLhISE?=
 =?us-ascii?Q?5L/b5cMcZIqMvz7OB77CT06zhLNgTE4M0TrCAuW6zQn4EYh5vy+cfk1/ujAm?=
 =?us-ascii?Q?3VZgRRecvjiLR2xD55uZ2M3nGviSNuZPgO2xqaso/2mJYgZULH+iDaoaLGjc?=
 =?us-ascii?Q?3ZW9RD8POja2s3TYIef3ovyLlsAa1wK6Lh0mJdaZMU/PBHN2nZktZpQeb13a?=
 =?us-ascii?Q?MeUpqChvhH7u1DcPl5U0qUUWdrrCnB4z0GQF9q1tc28hmqmVZg1INsTaPCQH?=
 =?us-ascii?Q?f49XTnQjU2cCskoqqOY2hWMjzFhnH1BlKh/0Ehp5tQmbF/ujCwaxGGsPL2Ev?=
 =?us-ascii?Q?ka86UDQ5ZVM6U1L6pcBg7SbUTyPuGZ1iHqXJSiFQFTp1dKDXcEmzHIih/rn3?=
 =?us-ascii?Q?fdnXxvfmOSDmJmmCcIzVmLf45n0WvodZEdEHSLESvTUwQIQ7f909NZQVx2UT?=
 =?us-ascii?Q?nPEUq7xUWOt+iZwKKIOwWupeenvInCuvUomRL+V5PU/wlcdJLK1u53gsqJtr?=
 =?us-ascii?Q?Ni4Ouxl+qOtzfmpCcM3X4r/ZgteS7NjXF0v9CxTUkBHSkNI6h7t9nWDjZTGi?=
 =?us-ascii?Q?IN5wePmG07PGrcCctYJL/Q9tKiMhUfZV/y4pEJnzX35JgxpkwJSLlKPKuT3R?=
 =?us-ascii?Q?rovUXVjUCvDThWJIZsiNn6cDW89nvKSth5GhL+YXaQIsmsJHz1SELX43Xo5A?=
 =?us-ascii?Q?qCMhb4fG2tG2Wl27mysyGJ0wNTymoPmHaG+T+6w+y8n4NjQI53GTPdyV/WFC?=
 =?us-ascii?Q?UphL+ATbSPLlhe3zzkyK/rYvOmUmEJXr3SBJbJAhHs52pLFP6cpO7oJ3rKME?=
 =?us-ascii?Q?/zyR6N+tcKMDd668sy9jS3FoqvbTioB5bmN3/NUSdqiUpPZJ9UOXhZ+gTTp1?=
 =?us-ascii?Q?nC2q6YuBX+C0LJMosXX4qm/4BcRte1bxJX1OatXYhOimCgrgHDKPEEud3Q6X?=
 =?us-ascii?Q?fmHLb++fiwColMavt65CUDza4gGlsVaYYbcZzpMYpr/SVXRX9M1szy5W8psr?=
 =?us-ascii?Q?o4DqzVqEMGiLqxSmiSM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671d28ab-7388-4063-b35c-08db19fd6dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 02:34:06.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSSu3jcoCAzRwg2jEux1Ga9O4Qk+By1A/xYu8pfx04JhuJzB2ONj5T586bx37++OcXmnY1LENWTwknaYiZnDOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: RE: [PATCH] dt-bindings: clock: imx8m: add interrupts property
>=20
> > Subject: [PATCH] dt-bindings: clock: imx8m: add interrupts property
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Since the CCM module could trigger interrupt, so add interrupts
> > property for i.MX8M.
> >
>=20
> Any chance that these interrupt will be used? More likely such interrupt =
are
> useless and has no details about how to use it in RM, just piece of words=
 in
> the interrupt table.

This is to clear the System-Ready check warning. This is to describe
the hardware. Since device tree already has it, and the hardware
indeed supports interrupt, so let's add it.

Thanks,
Peng.
>=20
> BR
>=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > index 0dbc1433fede..ac7ad8459c79 100644
> > --- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > +++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> > @@ -39,6 +39,10 @@ properties:
> >        ID in its "clocks" phandle cell. See
> > include/dt-bindings/clock/imx8m-clock.h
> >        for the full list of i.MX8M clock IDs.
> >
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> >  required:
> >    - compatible
> >    - reg
> > --
> > 2.37.1

