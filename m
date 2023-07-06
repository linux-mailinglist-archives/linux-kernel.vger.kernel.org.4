Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482347494D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjGFFFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjGFFFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:05:51 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510C10EC;
        Wed,  5 Jul 2023 22:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRQdNoAwrD6Ji8ky//HOvDutr0O/TuVMUAh7qqb3oVYbADmwkT+7hkf22bTRNV71r1DEq34wQz7+x6ulHNSpZP1RWeKZ09EwALk1eOBOG+cuggQs/w/VsRJhZConJg3rP+FPIZZEt6QkfzyqPZGaCHjBsfOJjHoN2rWXyg6w609+FW2bVWmTeG6bngsXMEv/HhAaW/6EoolfqbdZBLJATNdF2kbGo+OflVX8CNh57zTXijIVQ0hF5Lp+3qCPRwFqGo0HcQ4EdOOUyfnrj0Guz5+Dy/zpZnLYkUP0w3ACII9zqjR4IEMqnJx/pGzmAq/dh6yN/23ulH6+uj05rbDWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbgWqFIVw2IbFVhJdks+HvYBYmf6CO0nyU1l3y2W5RM=;
 b=aNT17nVuEa5/9BQrRK6ApdftY3q/zlYqiq/e4cpQGaejUCNneZKr2Sgk2a88X0Hs3VpKbe/oXSEoWb6NxxQxvTw2QVa4QaDtbdEK7ZMzt4jOHvjo/x1IqcfpY3d56DNoQOp4cc7kqZu2HbyfmT2zZ4QKVkoPoEojOHBEWa/AgYACQbZc9cLuxEJR3jrWAH1kBW55rUEGw+sxxdLwam4tRsSYGy7KkucWN6H/waQPobStbJ6JC2zgJUt+IaM7w1xLdpUUyy7TQytXTXdcJ6zXQeKGUWMoRnbBHswJI4e9veYqOzBTenCIwTSRhXU4cuguGvGpKlmZRTNX3I8y6XgN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbgWqFIVw2IbFVhJdks+HvYBYmf6CO0nyU1l3y2W5RM=;
 b=kRGPczcry+OZPCixv92a/JO80dgESROr8ewMGblFe7zcB2xdgZ7sqEBR3fmA6n2znmEyl4sZozfsxInaL2sVgzLcxI3aNzgHVp1To+bJ86jWRAt3et9GjYUjnXFYclqSeLBwFvbWDFnNztTzFrbRNMOMBnOtWkdhPSzAEt5vq7E=
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7)
 by AS8PR04MB9512.eurprd04.prod.outlook.com (2603:10a6:20b:40f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 05:05:42 +0000
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b92f:c3da:fe42:8605]) by PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b92f:c3da:fe42:8605%6]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 05:05:42 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "lucas.segarra.fernandez@intel.com" 
        <lucas.segarra.fernandez@intel.com>
Subject: RE: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
Thread-Topic: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
Thread-Index: AQHZjYweUt32QHpmXkqlWZrZU7kmVa9oE4qAgA26dgCAAA4FAIAMcSYAgAGGbgCABlwxgIAfZkXQgAIhYoCAALxuYA==
Date:   Thu, 6 Jul 2023 05:05:42 +0000
Message-ID: <PAXPR04MB9571D97F2019D5171D38F6D08E2CA@PAXPR04MB9571.eurprd04.prod.outlook.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
 <20230523165503.GA864814@google.com> <ZHh0DF4meU2ze+g7@gondor.apana.org.au>
 <ZHh/zqNu7XzwJTl5@gcabiddu-mobl1.ger.corp.intel.com>
 <ZILvtASXQKLG43y9@gondor.apana.org.au>
 <ZIQ3OKYyOcwRIOLR@gcabiddu-mobl1.ger.corp.intel.com>
 <ZImNC6KUNHquVAnZ@gondor.apana.org.au>
 <PAXPR04MB957111A43069E2658BCA818F8E2EA@PAXPR04MB9571.eurprd04.prod.outlook.com>
 <ZKWtiRcyUP8OQNSa@gcabiddu-mobl1.ger.corp.intel.com>
In-Reply-To: <ZKWtiRcyUP8OQNSa@gcabiddu-mobl1.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9571:EE_|AS8PR04MB9512:EE_
x-ms-office365-filtering-correlation-id: c935c35c-6280-4a98-16d9-08db7ddea5f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7P/4SG4o0RThJFfBH0tU9vYpFHhthoQS4WkqrzFlRC+2d4xtfoFoXZIaI5Dkjujo/AjieTAmFydZVG169VKcuUUAd4sGENM8HFJGVUcuJdetAKsDfAQtY3GjspQ3ZAxbIQrDUppNKpZ7uVGzw/RARArOfdAXaPE4KaV59g7PjBGVgY9uGW71iwANinApSukJEqgrfv5pr1grAWE4VcBYFMGNUEf0r+REvaPSZqZm7ZMk4bd9j2PLWcDpoQyY/cn9QxM1nZobZfgsh53cQEPMrIFmFNFlm0klGr6QZecbFiXgOdV7QhJ8+KjK4/WScOs+KMOQO+jG4uJC7MBpfcHYZh24jzqURldyIYGF6aGGYAoCC/BXQNWrK7hHKpUhiKcq3/KRRIGopAWM2IwJMTaiexiAiiqCNZ4GuUpmQs4oYHZQIzHPcubCgK5Gq4MfLZtGBxlI2hoHRKDiKJAyDLk8EEibiCNVaOHfg5D0RToAn/+gVBR9apnCDh8Sg6tYoH7sxkSWyxMtYEBhWFgq0+deTkiecCkI8ajJIAsoEPj5Tr5VaJHCR8cyogXHdCJ4m9Te5+ssFc8hf/EQpBEY0FX6kcr3XCOmOL0mwrWeFXVHb1HZ4il9Nf+bpbJVgsB788GV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9571.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(76116006)(4326008)(66946007)(6916009)(38100700002)(66556008)(64756008)(66476007)(66446008)(122000001)(55016003)(186003)(86362001)(478600001)(33656002)(55236004)(966005)(71200400001)(7696005)(38070700005)(9686003)(26005)(6506007)(54906003)(53546011)(45080400002)(52536014)(44832011)(8936002)(8676002)(316002)(5660300002)(2906002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e4XdGH5c6r4PbKifKjhtPA15mt7uKeLwQbhmDfWFPzAQUFuwDxXO9lgFOpQF?=
 =?us-ascii?Q?DVdscL5+FNE+KGOgDNlCw3ggb/l41uaLI1gMSeBI4KCs/V04XbKFr5De13YD?=
 =?us-ascii?Q?X6mZfEc7mLscF8ej0ZrxEkJddsdDKaTQUhNSoJte9iNf7Jgo+Avn7EFJtk5j?=
 =?us-ascii?Q?YKb30x1SLHuIJnAnRpVhwxT4PnNEFnVngJmXI78Yn2wT+quycJy5O5fxFimc?=
 =?us-ascii?Q?xc7UJ6Moum9F9+RNIzn3BuJ4ea/9D2PscUnU41qhcLfO5+2Zo3pBQ/0+vQdm?=
 =?us-ascii?Q?KVIgNrCnfqLUDo6/eNIWn56TBr/VdXzCaHI+asWOmLCk6KZKaUdT0XF5oQIr?=
 =?us-ascii?Q?9S6Sx2X1SqfoHZy73NBH8k3UMW0GedfeL0nstZOC5yuYwwFpWowdSBm4kaox?=
 =?us-ascii?Q?Uw5IayzdJyQslEjqDzUAwDela1TZMLP7ubOxrSIrwWDsBWVZ0gJwbJ+GkSYw?=
 =?us-ascii?Q?Hyhup9paUQlQSKXbod37XB4h6BISQ1jwd6ApLpq8sa+M2F1wCsWYSDhi9CfV?=
 =?us-ascii?Q?LWe1h0qWUvLQUQnNfUCZAn4iB3Mhe2YxxmZ58AkVgYifIxS1WgUuPst1I6OK?=
 =?us-ascii?Q?QD9XBxssGCeE/BIN5R4GUf2mCyp72ZA4OnbCQ9WOJ9NiINbTqmDB/vpJCayI?=
 =?us-ascii?Q?hRrU/DNXmfKidVYAwd4BP7Z2m7U4mIn4s2AW8cdEySn73l1xMU+WqHnGUkqF?=
 =?us-ascii?Q?9LyjlYfsAQnSranEx3b5Ff354Cmdpw6B482pI4//6UKDz9e1Hkk/MObgEYPj?=
 =?us-ascii?Q?CpJT9ZaZtPyOrd9pdt/TZ9YmRoVh2t/QtiXQk7vrTPGdEu8geXxVWA/Z/a8/?=
 =?us-ascii?Q?IS1nzg9bwzJKJsFGNjUDPyyJFuS49VyPB6kELIpRPA3dF5iUpv7K9pFiQ6fR?=
 =?us-ascii?Q?WvdZemlWgNjFpwRn6oNRYnGXNxddFQCO0tYNssqMlVUm1aI55VsoKcN8O+bb?=
 =?us-ascii?Q?51XkVZshurvUO49WOemryhSNbzB1TGiFIPaiQgJKDprnphkUy6bbiIQiNSP5?=
 =?us-ascii?Q?DuEzOZjYgF3rGDRcnOBQbTWXiaQktFAmK23oB6GFJSCPzXbp5FibNL42/kiF?=
 =?us-ascii?Q?SC4kxswlS5MRAis5NJbimTUwrRKvJcGDo7O+p3raLqT33eyo5+wLsFimWkjS?=
 =?us-ascii?Q?2h6iad877oL7j1LwdRYyJ6goi5UEHDAm3t1l+nBgzabCr61IueLO45SnEpVt?=
 =?us-ascii?Q?y7wQF8oPnluYTweflJA+JM6i1A4caUg4SZq47FKWZ7k9M/8+QEPAqeoA46O8?=
 =?us-ascii?Q?XuotCKkZUmS5ZN387msxXKPpHv4vDawXG5dvrvMSd9WRpN7ys2ymhXRrupoS?=
 =?us-ascii?Q?gKTJSENfy9xD5DP9n7kJTEPDsDlms87yTfuYgwPptdO508h2IPxP4PINVZJF?=
 =?us-ascii?Q?P14GPyn7Apv4BPYiP1Z/SpcBba3Z2dLUm6TpPHN6piVp5yEJyzyZb7CNjRIe?=
 =?us-ascii?Q?a+S1LyjbS2RkrF0gS+DXGulmGHCQfD3OhCaapgLd3nGv7Do2/TC1Yw18RCbF?=
 =?us-ascii?Q?KFIUU099xNimTHRlFE3nZ4j6w58oLhOHKh4RUeLcVoAAvqFhrH0BrL8hz3h/?=
 =?us-ascii?Q?z+F+Zc+E+5LUU8mYLWfoNLn36cCiKvnyW6Hy04n504y3qRnDgU1Er8BZgJF4?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9571.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c935c35c-6280-4a98-16d9-08db7ddea5f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 05:05:42.3347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rFmKFgG/Gghf42TzP1MYp/HwRBf4fWJI7Wr4ulGPtIWOyiWy87VyalrNWxztAxIFBFag142vx9BHgtYB0wA2zf7Pi0HFdGSgS24Xo8GFoGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank You

> -----Original Message-----
> From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Sent: Wednesday, July 5, 2023 11:21 PM
> To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>; Eric Biggers
> <ebiggers@kernel.org>; Horia Geanta <horia.geanta@nxp.com>; Varun Sethi
> <V.Sethi@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain
> <gaurav.jain@nxp.com>; davem@davemloft.net; linux-crypto@vger.kernel.org;
> linux-kernel@vger.kernel.org; Iuliana Prodan <iuliana.prodan@nxp.com>;
> lucas.segarra.fernandez@intel.com
> Subject: Re: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
>=20
> On Tue, Jul 04, 2023 at 09:19:28AM +0000, Meenakshi Aggarwal wrote:
> > When are you planning to send the patches?
> Done today.
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch=
wo
> rk.kernel.org%2Fproject%2Flinux-
> crypto%2Flist%2F%3Fseries%3D762772&data=3D05%7C01%7Cmeenakshi.aggarwa
> l%40nxp.com%7C7bf37c3fd13e41b6a45408db7d807937%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C638241762971432376%7CUnknown%7CTWF
> pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3DHa8TNlFgKo4sten%2BQ8wIe2z%2FzvbjI
> npuLwxHAdLVcS4%3D&reserved=3D0
>=20
> Regards,
>=20
> --
> Giovanni
>=20
> >
> > Thanks,
> > Meenakshi
> >
> > > -----Original Message-----
> > > From: Herbert Xu <herbert@gondor.apana.org.au>
> > > Sent: Wednesday, June 14, 2023 3:19 PM
> > > To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> > > Cc: Eric Biggers <ebiggers@kernel.org>; Meenakshi Aggarwal
> > > <meenakshi.aggarwal@nxp.com>; Horia Geanta <horia.geanta@nxp.com>;
> > > Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>;
> > > Gaurav Jain <gaurav.jain@nxp.com>; davem@davemloft.net; linux-
> > > crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Iuliana Prodan
> > > <iuliana.prodan@nxp.com>; lucas.segarra.fernandez@intel.com
> > > Subject: Re: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
> > >
> > > On Sat, Jun 10, 2023 at 09:41:28AM +0100, Giovanni Cabiddu wrote:
> > > >
> > > > If you all agree, I can send a patch to remove
> > > > CRYPTO_ALG_ALLOCATES_MEMORY from dm-integrity and update the
> > > documentation in crypto.h.
> > >
> > > Yes please.
> > >
> > > Cheers,
> > > --
> > > Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgo=
n
> > >
> dor.ap%2F&data=3D05%7C01%7Cmeenakshi.aggarwal%40nxp.com%7C7bf37c3fd
> 13e
> > >
> 41b6a45408db7d807937%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C63
> > >
> 8241762971432376%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjo
> > >
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DED3
> Qi5
> > > P0i31gXXPgUOcpVD8YcPhaT1gir3lzZT6C0L8%3D&reserved=3D0
> > >
> ana.org.au%2F~herbert%2F&data=3D05%7C01%7Cmeenakshi.aggarwal%40nxp.co
> > >
> m%7C6af00291047c46f2325e08db6cbca189%7C686ea1d3bc2b4c6fa92cd99c5c
> > >
> 301635%7C0%7C0%7C638223329655306217%7CUnknown%7CTWFpbGZsb3d8e
> > >
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > >
> C3000%7C%7C%7C&sdata=3DNrj0YEjJrFUNWY25h0iy5sF7tUnHSDun8KhHxnhUhh0
> > > %3D&reserved=3D0
> > > PGP Key:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgo=
n
> > >
> dor.ap%2F&data=3D05%7C01%7Cmeenakshi.aggarwal%40nxp.com%7C7bf37c3fd
> 13e
> > >
> 41b6a45408db7d807937%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C63
> > >
> 8241762971432376%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjo
> > >
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DED3
> Qi5
> > > P0i31gXXPgUOcpVD8YcPhaT1gir3lzZT6C0L8%3D&reserved=3D0
> > >
> ana.org.au%2F~herbert%2Fpubkey.txt&data=3D05%7C01%7Cmeenakshi.aggarwal
> > > %40nxp.com%7C6af00291047c46f2325e08db6cbca189%7C686ea1d3bc2b4c
> 6fa
> > >
> 92cd99c5c301635%7C0%7C0%7C638223329655306217%7CUnknown%7CTWFp
> > >
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> > >
> Mn0%3D%7C3000%7C%7C%7C&sdata=3DlBaQiOM%2BXaax2lMroHtqbtBbjXBlkkKj
> > > ms8mgBnou%2BU%3D&reserved=3D0
