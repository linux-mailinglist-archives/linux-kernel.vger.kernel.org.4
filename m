Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0646C2AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCUGzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjCUGz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:55:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6AA3C797;
        Mon, 20 Mar 2023 23:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBG+NBLH5c6wM1UH3BZRhfc32WYas8W5b+KRUh+7f2OP5ZsFaF5IW/t2DVAi2oqqSG8Pr+4Ta4LVhLmYM06lz5MpyJR6h1wpWz/UGYKfC9gvaNKSmODUg5o/V8cd/ovnH/3u5XsWW8Kx+smXraP25tZAcmC86OgEKeoqrxgVVOoI2SH7y1v9aajt1hyDA8AFvWHQgqs5uKj48fjrGCob3K5ATdEXmuu9PK/BWonr9CIPv72AcHJmbEiIZdpDJXPs2Mh5TMftn2xVJQg+tl0aqEMRvrOXzxNWN0X+pvfP1rRdmUKEmZQAUlN74b9slWK6vH/WRjk/DMyK7KfFkCn2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt5in3IwdFROVM00DAhM3mymxe4IViXwChy6exP3qi4=;
 b=JxHGx1MuTSseVM9jJ/l+Rrkl/ytxjJ44iPF845DrhlY9mJb4SjaPbV8utsfjY0QmNA9zF20KS4L2OCdEk04eBxl09ct58dhkEIINcLJX3E8HA02RfKhGZCy4owRzGcXygcukePBrXo0ifMqEmA9UkxFhxIZGgaVxvxmN1eCBnzw/PNIib9hKvB4PJephJVpYZi7Md99MSTubkKRga2KHFPibXjeu6kI26s+Q56y2BngJETapC3a9159Xex4t+3dRLvQ0/xbTKIN+DqpeMXDf0YlanI8Zy0WnkZJ1jsfNw/CUs7eovAcDZuToufyE3ksDKGKxHEqxzhP1GQxAds0KVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt5in3IwdFROVM00DAhM3mymxe4IViXwChy6exP3qi4=;
 b=axKQI0pP3tq1COJlY6QRoy9t1OExAOoCkUfEvUZgfhhdkHNUsLhbuJN7EzxWQXXpP0q5cppHDvmQmmmpmMqxu8qcu8phwvPOumpvwVnLdKOYF6hkBFS6MH3R5PsST7BLoN61jixXmPs+7VgGR65ivHvyzEm7Y8XhzeHgX2REzRw=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PA4PR04MB7823.eurprd04.prod.outlook.com (2603:10a6:102:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 06:55:11 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87%7]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 06:55:11 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] crypto: caam: Clear some memory in
 instantiate_rng()
Thread-Topic: [EXT] Re: [PATCH] crypto: caam: Clear some memory in
 instantiate_rng()
Thread-Index: AQHZW6T8qM2pEJHQqE6oUcuL8PwIJ68ErEqQgAACSYCAABtSoA==
Date:   Tue, 21 Mar 2023 06:55:11 +0000
Message-ID: <AM0PR04MB60043E404C9175C7918BD676E7819@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <16d6bf3bd7a6e96a8262fcd4680e3ccbb5a50478.1679355849.git.christophe.jaillet@wanadoo.fr>
 <ZBkj9tUFl8OJeoic@gondor.apana.org.au>
 <AM0PR04MB6004F6DC17B8CB859D13EF1EE7819@AM0PR04MB6004.eurprd04.prod.outlook.com>
 <ZBk7ZdSacxFzJSxJ@gondor.apana.org.au>
In-Reply-To: <ZBk7ZdSacxFzJSxJ@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PA4PR04MB7823:EE_
x-ms-office365-filtering-correlation-id: b20e6b98-228b-4b85-025a-08db29d93740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0nVA8SdByQxh87HWV4RGp65cEKDrLQOUsh5U5kWHJqhrMQYTyk2/g24sNNRjKx8gtfXP9pNkitZ2eYxhfXIEARsBilk2ROD6hEktfs9KEnKATNJpOP25eIDH+04TYtF5tsmGvibBrxrcQUOyQ9G3sy1MxSTd57uI2Gp4BXbs+G4UhV2e2d3AphbxHzwM1LGbZLcamu6bOilFrR76v7P5d/ZF9JUMHdl1U5k/BNp+9KG7d8MYJXkhAE1IAtu1tdVBfoXtBW0q3afkr2IZtsj1Tv2tNGXhiN339j9lQD92nZX95OmCferr2vG8k3O+jGD/gYqPPnAfy0voHHl52TQUMbastE8pilPDcfVHjnAUf1piMdT4b1hNFKaIBgqMGqjMbRaSy0+q4DpwTSnExRd5dfetOTb2W1ek5E4iniwZ1tHF0UfiriCJzjiMccEX7sLHc81w9zb+wnZAk2ZgIwkmj89fdNtc0fKv4j6tQVGYs1WLhXrv4Syg2ayEhRkTkHOf+NOGVuEVXv2W4nwvofyR9ko/NyBZM+ZgrdBWoFZ2I1X+BSSfnNyoxBHBsM+XTwgzvF6+GdmRlTm87Q9AlSraxDjSnaQxlZ01K4epwiwZgwifU5WFsR2oM5l+alGU04rv4s1dTR9xv0QWQ27pPxpx8W/Pnyi9lEeoJLM2bqIU1l4KVF06JZygGin5RvqqSL9VhR19ChjA8EgiyFxlSKN1Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199018)(54906003)(83380400001)(86362001)(38100700002)(55016003)(38070700005)(122000001)(8936002)(66446008)(4326008)(8676002)(64756008)(66556008)(66476007)(6916009)(66946007)(2906002)(52536014)(44832011)(41300700001)(76116006)(5660300002)(53546011)(186003)(26005)(9686003)(6506007)(7696005)(478600001)(71200400001)(316002)(966005)(33656002)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MG5TtHbnQ8zaBvtWGIgeCCH23s837KxOq8QDkIjxKenl7KsLn1LR0rpTnIc1?=
 =?us-ascii?Q?H8b1Xe2+2lLhq+P/KG4JLgjru91bgZhblOk0jidQpFOVrWv1+wqCLHz58LIZ?=
 =?us-ascii?Q?yw8+rumKmU1sJWoOyN6iw8YFFQDY7AMUVPT6lQ1NGyIAeC2bff7hK9tluiBb?=
 =?us-ascii?Q?couKqjNGX/rXUHTWFpdiRz7vKHkf5ZsaESCReIOzjEevpc74sSJBhaS5ii8q?=
 =?us-ascii?Q?1FfY2fCe8YknZ56MB80SrHIZpEpHWoYct7w4HLJtcKyTYO6QjjadO00EZiXz?=
 =?us-ascii?Q?zSEFC4fRWS4xsjf9jeURF4xVBabrIHGSLQUchARppho4W8Tm88yUUJO7UvjR?=
 =?us-ascii?Q?7HzLW2mJly5weA37ZLd3Q7XZjk1QSYFeA7qf6niev5o0cfAmEj7fF9ZWkeRl?=
 =?us-ascii?Q?pEvLuNIJSxexu8j7zdkPSoT63C3HWt82/oee4cz4W7JR1oSGr0xX70to0/7P?=
 =?us-ascii?Q?TP4Obr/cWDFsX0xnskZ0usTyYzzpzBe8csAt+wqRpELEZF5E3WdO2G5OFM/X?=
 =?us-ascii?Q?PJVZ75wPpbQRG8YjJvVbhDoC8OuTCWnn8NL8v3Ylx3xNrdMduD/UxlzhqXYn?=
 =?us-ascii?Q?30rQhcCKvOBiahCL4XeavBk11uiI6D+3hfBZ31JpW2WO//INuFzNqC7F7GH+?=
 =?us-ascii?Q?dWKp08KS2WzE5KxYyf/A/Fw02iAR8YajDvpC+FcMUiffvQsxiDn3pta3xtfw?=
 =?us-ascii?Q?hc5Bcp6XCKOFxYeYDvOJS+nWUcrXbYuH38UF2nFV7WwL7uwOhAosonAZfppZ?=
 =?us-ascii?Q?1iuYrP+aGmJ3T735jujUD5XpyrN25VY+a7fuZA3abMCEl1fPgizJQAAAEIBc?=
 =?us-ascii?Q?9Bq4bOxWJcsMqsRqvhZBES+E5+u0f7MCJNnow2HJF2QqU67I1Gr+RAD9bsjM?=
 =?us-ascii?Q?kn7NChiVavcJRzrJuSXIWo/OIM8eP4ffmwdNM7urOVn6NNWo1CiTuFcRz6w9?=
 =?us-ascii?Q?R0uYiLGYMxfj7Cptxx6kl7CcJF4NUUJF35DJjxa3KqnqBzfNaxKs6lcO/91G?=
 =?us-ascii?Q?XbFR9pjmgixm6qCRlxSh5BzEso7LipWYB+WMsjE2gqzh16yyfhc91RKUUB7w?=
 =?us-ascii?Q?O057nk5YwNs+9XOoWk9i8j5YvNjJ84MQFbe+1xcOs+I1GU0hUbCSztl8UQUh?=
 =?us-ascii?Q?51JTf7dfxPj4ogLTlYhLIDCcqmKMOqE4GeqR5jB4LxN+oChdaASJbReNZ2Zn?=
 =?us-ascii?Q?fAlGzyjdQwzH6+SWpRZ7haP0AxyZD3O3JO0yw+ksgDcMW+wAk6xIWsWtbeti?=
 =?us-ascii?Q?Oh+bZJ8p+TLKxIXvy83RdUANpxt/4wSlwShJdVqTng0eoNlIVL5gbaXVoR3p?=
 =?us-ascii?Q?MUROV6IQkTFv7UbIuEluTWMHwAjkZPdf3qD5miUn1x0YXOI3ZlIXyUL269xU?=
 =?us-ascii?Q?Ss3HRWtBhzXaaLsTrmu3l2blld5smMHoHFi4xUKBpKrKv0KoqenhKUcOK0pg?=
 =?us-ascii?Q?2ItH7zU5roZcl0Ybm0c/mJRR4K/pKNwlMKvVlCPHAPF7tWh7Fd3VE0swTmGO?=
 =?us-ascii?Q?UXvm6sReAqrBcymXdKGACzoudWF8UkWFfZ+t2gQMbd+oo5duRT143HSVu5a1?=
 =?us-ascii?Q?aFMlo3Dxao86GkCMyHHbZdLh0cszutEZzH+4SKDd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20e6b98-228b-4b85-025a-08db29d93740
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 06:55:11.4484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LYgQpA3DL4Hj3NsVLi6YxETF+SUktA/1G2fRKF0Qe2MO/qYBO9774w9bZg/sxIqLfCZGEHCLO1pjBKJYKtBNEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7823
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Tuesday, March 21, 2023 10:37 AM
> To: Gaurav Jain <gaurav.jain@nxp.com>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>; Horia Geanta
> <horia.geanta@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>;
> davem@davemloft.net; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: Re: [EXT] Re: [PATCH] crypto: caam: Clear some memory in
> instantiate_rng()
>=20
> Caution: EXT Email
>=20
> On Tue, Mar 21, 2023 at 05:03:24AM +0000, Gaurav Jain wrote:
> >
> > memset() is needed to clear the desc for each state handle before
> recreating descriptor.
> > So it is required.
>=20
> OK so we should move it to the top of the loop then.
kzalloc() will zeroize the contents of desc for the first time.
In this case memset() is ok at the end for instantiating other rng handles.
=20
Thanks
Gaurav

>=20
> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor
> .apana.org.au%2F~herbert%2F&data=3D05%7C01%7Cgaurav.jain%40nxp.com%
> 7C46125a50355a466bbd6208db29ca159a%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C638149720177317067%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000%7C%7C%7C&sdata=3DDmvSAsFT0dY%2FL%2FP5lcw90hR0FYAKRdnI
> kZxiaMN1MVk%3D&reserved=3D0
> PGP Key:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgondor
> .apana.org.au%2F~herbert%2Fpubkey.txt&data=3D05%7C01%7Cgaurav.jain%4
> 0nxp.com%7C46125a50355a466bbd6208db29ca159a%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C638149720177317067%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D8NA1ediu3cnWLFbisXecjq5Z%2BuK
> uztPYtlcRDCPSMno%3D&reserved=3D0
