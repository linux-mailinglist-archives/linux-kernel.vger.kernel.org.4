Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149D472F4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243046AbjFNGVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjFNGVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:21:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390DF1727;
        Tue, 13 Jun 2023 23:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=He5dOIQltIX8XQ7bK1Vw94C59bitGyeuP6Pfpy7223M4RIGQcGAUgiX0h/2RAh6fGedFNIr+embz5QX7RlmQTcsRkrXUrSpu1aIvO5sOVBcT2Nc/0PVYI6XUwIhIKv+p/kbn3yHmySdDDV5A+O/vol89CCXU1t3U7KibdqnS1MBm8drZeVruK+L+20v8j8E3VTwSsEYIDDYU3SFnzDhYthToKYFh6Fsb6A/nElCYRYmCBnAP8DMdlNvOSOzHLB9vZYstYj8KxkyK/a7pJ+mqq3eHFk4PnytDsk0VeJu7PLCAXKcqHa4YMaR13Co7tbiwcvX8jgRgamiPZNX6MlpJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqLPsCVQP0FhVX4DYbViHvEFZDeyU+qprws6epycYIE=;
 b=ia0luio5143mD+5xGpkWNOkICTK1tbdbScK7Rbz9wILNYzB6kSlstt0myax1RSfXszN2jhq2Q/vFGns1h08z4WgNuueOQDvlaWmr65TOD4OpIe/oKNbFGFOko+70uQTEoalr7XGi7tSW5zA2+rCTAquX9zBMiKaAB7UFhTdoZjuFgm7WS777R5+63lFM+aHHdNSSsA12HmRvF1rzU/4olN9f4paczGRiiHhQ8tZthCSECLCo6CuUApVwsniYirjEH0AUIlExr/ROMzC7XyzxtikE0BE8iKmNp75HS3dICuO4MRIAlGR5o6W+qY6LMnJJM/xr8Am+MIxzAjnQNV1FDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqLPsCVQP0FhVX4DYbViHvEFZDeyU+qprws6epycYIE=;
 b=iVXlwFmuHRAnUE2yBV9edmtZabGUHcmGnG3RkU9+dOwHFXO9oVdfCjV/DSwaluqH9h7SlTnqR7gZxlP7cW4MI48CIY0an8nihNfWwtM8pgedvyXi+L5MrdxV/oj02hXpRx3Jv5tnYrrwYGBel5UtkVUY1DTx5f3VQiS79MSnSbE=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by VI1PR04MB9761.eurprd04.prod.outlook.com (2603:10a6:800:1df::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 14 Jun
 2023 06:21:33 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 06:21:33 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     Horia Geanta <horia.geanta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
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
Thread-Index: AQHZjYweUt32QHpmXkqlWZrZU7kmVa9oE4qAgA26dgCAAA4FAIAMcSYAgAGGbgCABiH78A==
Date:   Wed, 14 Jun 2023 06:21:33 +0000
Message-ID: <DU0PR04MB9563568D86FE5A308D1EE59A8E5AA@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
 <20230523165503.GA864814@google.com> <ZHh0DF4meU2ze+g7@gondor.apana.org.au>
 <ZHh/zqNu7XzwJTl5@gcabiddu-mobl1.ger.corp.intel.com>
 <ZILvtASXQKLG43y9@gondor.apana.org.au>
 <ZIQ3OKYyOcwRIOLR@gcabiddu-mobl1.ger.corp.intel.com>
In-Reply-To: <ZIQ3OKYyOcwRIOLR@gcabiddu-mobl1.ger.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|VI1PR04MB9761:EE_
x-ms-office365-filtering-correlation-id: 8fd554e9-ef07-457c-0296-08db6c9f998d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: br3ijrkf/muGf6HKE6kxPhkvd0J3tDdEQTT2+MQ8OMx9gjCUWsuP+sDT/KxhgS1VhXeSwtA04qk1fVicMlSryhRW5reRJXr8L+w1cUVKJ9+VTKTQeY5A4DWbQAHESmQkVd/FCmiDM7NxAhmPXzyNvZejcnnYVfBVtuqIxTnCPX52YJkv+Tu/yKGoLyq1qXwLHLZLcemdjTW0WeghDzfbHPIwoM99WqB1H1DaUSs+iqLVOQDnHL5HYAnsJJ6P23cRTUMXrChkG8q+68JfoNjbFBPgM9nLjcw4c0APz6UmuM5ur0LuykqSqYI3wUH4YrvM+Dm8/8vxPmRemY1VVZCOr9AmQ+MsMbnZLyPhLqrg83blzmm96uaYx1y6CSpKwDVHp6LHdt7Ty8+z9PEvq0ALm4/JFRtP5JB9AYgY1SBLDZsMzGqWBMpfJAhhgG+K1EGJTK/011kNol6mJij7ATylTtHN2urJuDg8VuMacQT2S7GPEJmdYEC0dS/va/+KnnG5LMm1jG/Ii1HkvQkH0hZb+ftUGoEveRUdAx/0IShmYIKowCDHRbbGVeotCDYXXkynKSaieWZwiHZyiAF0NqDnNaSi6G6+ywW7c4s81HMCC6SpzE+3kmJ3navgNSNDQkom
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(83380400001)(33656002)(86362001)(122000001)(38070700005)(55016003)(38100700002)(478600001)(54906003)(110136005)(4326008)(44832011)(7696005)(71200400001)(8936002)(2906002)(8676002)(5660300002)(52536014)(66446008)(64756008)(66476007)(66556008)(66946007)(76116006)(41300700001)(316002)(55236004)(53546011)(186003)(6506007)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ri8U0gF7dk3RtmXxHVwk6QTvsmrjghPgFXrkPSW8yTIUvIC0aX26bsjIT74s?=
 =?us-ascii?Q?K4JceiKS+Mi/j8ilBTTB8xmHKkKa0qZC+3Ewir9y99FC/ouc9qBEk+osWweo?=
 =?us-ascii?Q?rp34suTrfgCQuxthtKrK0rwJ/gBd8Cg2Cf3AflRJcWvOA/dEUlk8bz0shKaL?=
 =?us-ascii?Q?/TNC7Uaa8Ipr6s7PsiP5YiRRgfxAfx0NzstlWiCFTgPv8JObsIewwxrjswMZ?=
 =?us-ascii?Q?Gu7Ch7IXg+ms5ElIVB8xL0cIf5XtUaWTq8FwU9L08NKn0Q+iNH5zEGHH/BNZ?=
 =?us-ascii?Q?ASlqW2t5Jnfb/JgmCahQBX6Qnzo8Az1PuRG9Vr/C00KpcZGQLpgjvtW090hp?=
 =?us-ascii?Q?hSKdtZIs3RtQOI3Pf9vlOnRJvCuqUQYSDIIfglcmcqagwhJxfSWmdJK/jlaH?=
 =?us-ascii?Q?YILqbQSO0JrtQB8EiQK+YdVzejVu2RvYXVzwfXWdM+Hs5Z3qDjpCtr9iqwgu?=
 =?us-ascii?Q?U/xBWSCFZifJ2lCa2Z5g1hjngxSt3AcjxQw8WcIhECCsfSdiS2so3iFwpy1I?=
 =?us-ascii?Q?6zN1if+yON/G/B1QWLWAP6YNCnfPt6QzfGLiR0gvhHnBLoYTOKekDk+ExkAq?=
 =?us-ascii?Q?9ZMuuGbgxvkQJndhXYc7OqUSfXpDb962dtOTn30EB3vgv3Ya5MdmEitEJHyn?=
 =?us-ascii?Q?GnDtUcuIR4fRTd/RT4oxDarZl7tPFc/ZZVPstEUZhAnBFv+2ouWlZnPlHBUJ?=
 =?us-ascii?Q?21oKtZmf8n2wk/2Jvr4hNLf63aOIbjUCKOuyD7SWOTYxqiwwrbsVjEEl6mS6?=
 =?us-ascii?Q?l4VImPFth1kickLp5EHyjZX50zymt7WZ9Ym7hlrkweck+1TTNM1bsD70Absy?=
 =?us-ascii?Q?ir/aW0+zXNJ4LGuj/j+3qdzFMR3G6jfbGggWYaq9f/Mw+UDBDnK963lUpF4J?=
 =?us-ascii?Q?JqjcPlfO53pabCLgqDb0Xk5eqWU83v4DM0/WuNI9clDlWrNECRRhTx9FFJRR?=
 =?us-ascii?Q?tAG081/+tb/jK+Z0OREJt6DxFPCmaSg1WgXrptbePLSra9/+nQH2v7uGfSr1?=
 =?us-ascii?Q?P/sDncj0otQhQBqQFsX8X83tmssMsL2iA6/z+kAZLV0oQNvStWm3qvveJpLc?=
 =?us-ascii?Q?9H/1uBO4temeWeN+HvRHuKO3ENSvFrAQFWyA2zu+6EcAcAdfe9lADrRr7Hrl?=
 =?us-ascii?Q?Wnwtl/SJAi2RmvEgcbbzUBwRH301cZAuUDG85SVFXyVBMfPnes6E/H+F3CDs?=
 =?us-ascii?Q?Gh47R5KrK+rAJY/p312lB48ORU59YvP3+WtTETFc1D98sjJu9EncnuY2jAEe?=
 =?us-ascii?Q?fxQnBn92BY8+ldz0axLe8V3Ci+sqdZVw/IRLs/QvrYIqfBaj1dtgz3CtBLxp?=
 =?us-ascii?Q?NYBKIolv0jOHMDFmVFEPjJWn6RpBCtiFAh2kt+ZiHsRnElVABhs/ojLQPBoi?=
 =?us-ascii?Q?xr1kRygYmUWbtbjw11FeYQSRigqocWZBHi/jpnre1iLHJRxnnY2+XbGjPkyx?=
 =?us-ascii?Q?0Z/N7SftgH9R0IRcEbFeLnSnwZ2af/PBsHQcLaC4zhlPE0XK7mSvQR0hitPr?=
 =?us-ascii?Q?PRMxyaCf0VSllYIGNszXEjdtGbSHzpNDUi0XI+WnUwXXbcfxExlTbxbnrrYd?=
 =?us-ascii?Q?ttHUOahOK9WWd+GyNEboqWSB1KTetf7iENR9mDqfGcUyP8FOxtFQ+hYFPvOX?=
 =?us-ascii?Q?dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd554e9-ef07-457c-0296-08db6c9f998d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 06:21:33.4347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcrDtvHFNaJDZ5g8aEGymU+OjJOyhng88ia/6S8y5qwzrDQV3Au7Bfv8sNFVvG3i+1WmUxWviRnawOmdglUQwK2hKqgVMDvS3/sPO7GCcrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9761
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric, Herbert,

I think Giovanni should send the patch with suggested changes.

Please share your thoughts.

Thanks,
Meenakshi

> -----Original Message-----
> From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Sent: Saturday, June 10, 2023 2:11 PM
> To: Eric Biggers <ebiggers@kernel.org>; Herbert Xu
> <herbert@gondor.apana.org.au>
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>; Horia Geanta
> <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta
> <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> davem@davemloft.net; linux-crypto@vger.kernel.org; linux-
> kernel@vger.kernel.org; Iuliana Prodan <iuliana.prodan@nxp.com>;
> lucas.segarra.fernandez@intel.com
> Subject: Re: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
>=20
> On Fri, Jun 09, 2023 at 05:24:04PM +0800, Herbert Xu wrote:
> > On Thu, Jun 01, 2023 at 12:23:58PM +0100, Giovanni Cabiddu wrote:
> > > BTW, some time ago we did an assessment of the users of
> > > !CRYPTO_ALG_ALLOCATES_MEMORY and we came to the conclusion that
> we
> > > cannot just update the documentation.
> > > dm-crypt uses scatterlists with at most 4 entries. dm-integrity,
> > > instead, might allocate memory for scatterlists with an arbitrary
> > > number of entries.
> >
> > dm-integrity shouldn't be using ALLOCATES_MEMORY at all.  It's using
> > GFP_KERNEL allocations right next to the crypto operations.
> If you all agree, I can send a patch to remove
> CRYPTO_ALG_ALLOCATES_MEMORY from dm-integrity and update the
> documentation in crypto.h.
>=20
> > But those are some seriously big crypto operations, 16 thousand 4K
> > pages in one hit?
>=20
> Regards,
>=20
> --
> Giovanni
