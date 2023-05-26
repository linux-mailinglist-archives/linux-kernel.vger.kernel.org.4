Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBBE711FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjEZGKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZGKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:10:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A4E125;
        Thu, 25 May 2023 23:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaVaduAnOFH1B1uCeZwZB+hTarih9jWwyXNcb17J13n2umSWMqPo0i1HtaYFtRrRq38NJw7SApkgFhxKZn/Mw2XjppdDML9vSooa/ZVSpRWggjBxSZ0D/4v/rUuOWAeijHlsQYGUTfbexA3gCwI6xjjs0gkcL6MdF+i3u6UW976tluv53g6vhc9JkqWD7ia0DiBYELtRKAJq7jjZsrfIDa98gnz2MYgpY8N2YWeAS2vHSMYvqynQrgzUUETgNtDkxDs0PaGNXoNN6g1CqOwIV7bcjic3Xd/qSkB3+HntNofslGrhkh+/66o+QOWps35OycVTWASVyKBQSOB00yWKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM9mPgDhIHDISveFc5jzf9+hgDWDRZvcVrRXjfCXksY=;
 b=J9dryW/nqiqQKCzJyVZd27/Bm14zFqOtL1jo89qXx0lL1LckO3bRKKrtLhZIInDTVFFk29zQSIsgYniIzNrpyfsXBKdfLWswwpknKySaKlzwGAsI6l+RfZyneEcL4V9KdIOxHrl/SG4iM/LYjuySiNy+LRkFY4gFY2SlzaKfA3l/McUZIsHzrEBmWPinuOCUBqQbXsE6kthI7SDAMEyWJGozldtsu2rP1AxQHM3b3k8wWnYvZNH0yW+IGCSLCQCqcjN8mU1qkbtNX8jMnsk/h3kvzw6IBM7PcDPVnaUac8EFdXhHqDmm6tww2dpunafOsNRezvxVhnKSaUx94UkuCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gM9mPgDhIHDISveFc5jzf9+hgDWDRZvcVrRXjfCXksY=;
 b=fM91zbGUVeyWeRaWBugsug9HZK3FRPx2OkNCUIG1VbIaKIsDwhIH1x/fROV0fQQdv+T/co7Y0myEguuPvJLrZb8InxkZtHeDsgoEpToONaIxpzuTnW+OrMhBWsaoq0sVfJdyvuwhgYLFPA4f0KYPl6nED2zLlpDer/pM1Q3xE8A=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS4PR04MB9410.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 06:10:35 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::dca6:e1e8:f142:2bc5%5]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 06:10:35 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Horia Geanta <horia.geanta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: RE: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
Thread-Topic: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
Thread-Index: AQHZjYweUt32QHpmXkqlWZrZU7kmVa9oE4qAgAQC2MA=
Date:   Fri, 26 May 2023 06:10:34 +0000
Message-ID: <DU0PR04MB95630B963A7F5AEED39E70D08E479@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
 <20230523165503.GA864814@google.com>
In-Reply-To: <20230523165503.GA864814@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|AS4PR04MB9410:EE_
x-ms-office365-filtering-correlation-id: 12f465a7-9617-49d9-c32c-08db5dafeb35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SOVD5TJB3Nn1iciy8zAdzeBWwhGXOsyjzQ8x+7SDlRfvjhJKEm9myob8jBnQvgwh0g9H1C9hwSTzhMLDjtNHyxltEKwb6rqg1+EtU000+5K0/kjVft+H+IFi6LV4MyHgiqVP1LDolApZPCXKc5Yt/7pcbwy+dRJhGE8W+AUj1sCKya/T/Q8ylia38KCh5KuESO8zw8u8qqZSIhCLoSo1tmGX42GciuWCdS10s+yYJ4V/ka2gPx+fK7mesDsHrxgOmh90djzp9mkttoT93xoGWQB8djkU5P0rU4ugN+28fwFrmSNWAe9bxI/FX5L0+IYcrVE/8SjkOalo1eFlZhz1PXRHe4cg/4IMlrEv63iP6zocOKYh8HsA7lLK/Q4M8t/9QqhwPRMy/YAW36enWvW7xrZdisa8FqztEEpyMHWJ4p0HkqoRwhsjgB19ni5z7NMZdFx1ZjGDTD1KBtoiGf/sqxRN2mJvOYfd7nXAdCza6WzaAcRbioGnoEZO1HoO5Gs6+UwvmzbpfeU9M3w0RYjRuvln8AnrgLrejdaAqB61GVCDUI8+AO7pL6OtcGAoimeRlkOtwNRu35k5ZxrMabUTHxEJVbZ5oVLXBMx2LMiAz0Wjh6/YGCJ2aCv/pGm6QON0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(83380400001)(2906002)(186003)(38070700005)(86362001)(33656002)(38100700002)(122000001)(55016003)(8676002)(41300700001)(8936002)(7696005)(52536014)(5660300002)(54906003)(478600001)(64756008)(316002)(4326008)(6916009)(76116006)(66446008)(71200400001)(66556008)(66476007)(66946007)(26005)(6506007)(44832011)(53546011)(55236004)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jltyTTX5SyMlN4byzxVZ0BviuWprww3d4x83hIWl4AH2YR/ibI8HyI6EF4?=
 =?iso-8859-1?Q?Hb9pI4Ay6cVgSFedUoYEVGoHareYu+zM3xc1qVVb+X+RlCIRIjDr6+aus4?=
 =?iso-8859-1?Q?JgfvDGltK/B6cux3DU1LER0VGoVPqMD2e+z/tHnckGYd15Ud2WN/TwrwkQ?=
 =?iso-8859-1?Q?P8XlYN6LtHhSDIamA8epyT/LIqteQ3jz2xO30MHFdaclhy3u4LL3On4CxP?=
 =?iso-8859-1?Q?wx79Y/ismMIPYBT+At3hPwBtPBuc5UNaYtQsJZ48AgDHdbu74TuBG4R7Id?=
 =?iso-8859-1?Q?4vNiAAFdz4L/c41Dw5qLKJw5rN0azS3MKJIZx0o4beoedaNILUhhdZW0R5?=
 =?iso-8859-1?Q?3W9Xe5s2RuElgWgT/4qnq5K/Xp0oJ0jjnsjMZ18JVUCsQEnDeMgJ/OClfq?=
 =?iso-8859-1?Q?BS+pwFo8HB2e0GtbiDdojRPGizfW0Z+UZC72fsxqI9VSAsnSUlZSEFnPNh?=
 =?iso-8859-1?Q?Qc7+YZK5YoQSCv5NdgzsN280sN3nhfu+PApe5GjohWhq38ZIjD27HG7u8H?=
 =?iso-8859-1?Q?pe+fvNo4fdm3hd4SssKDmsNaKLcDilpfzmUvhnl5xkqv59Mi54C+ohMVam?=
 =?iso-8859-1?Q?qrUXkXy+ShbT9RGabXODz1g1PlpgoBPNv8D5AGjw3Ccj74eswZGvynmLvY?=
 =?iso-8859-1?Q?r8kLYYWn9L5L+U5x3Px6ZegNae0r7bLEEh3mTU7dsh2MBpHlR4FYQQXLz9?=
 =?iso-8859-1?Q?68ieKfPnwkyRjMLanIxGtQFipcMYs6LWVecfaoULCWywCGqPl5d+zq+8s0?=
 =?iso-8859-1?Q?ZvPgLIn9HRHDJoBeZ/dCmtSo4yneIBhUkwbGn13eBMx6Gi8bq5odkWgN6X?=
 =?iso-8859-1?Q?ghzW2Btvp3Gd1n2l5T9XPP9cW4PY3NXKnbBobFOGJ5fjRz6sMisn/XgLiK?=
 =?iso-8859-1?Q?iousz6aFf3FWnfHxi61d1J6MtUyh3bPq7O9UZTTdAb1uwy3pn910K2Eta4?=
 =?iso-8859-1?Q?Vsb/SsWbMrLrtEZvqt22x8LI7QZTqAGVTsITJ1WX70HuwI5cYZruF24uMV?=
 =?iso-8859-1?Q?znmn3x3TNKLP7xmrgM12rTy+qGe16uZzHPriB7zyXkL9HtoJWXx4C5sq+m?=
 =?iso-8859-1?Q?JOcwE4JtDkuTwlcJfj31/892u+z1dH7y/FbSQ/ujJ1WlK3xmQLtG7tlaf+?=
 =?iso-8859-1?Q?is/kEq+QaWea81VLDWEAMKymR+J8o40XX+Q9vlVHBa10Q2vlmaU1hq3t68?=
 =?iso-8859-1?Q?JBU8TgxQp2jJUYfgvQOIhQ4Uj62grwROMFimXqEbU/SlbZJuNkFXhmjkX1?=
 =?iso-8859-1?Q?TTd2DFWb7q47od97tdM+2qWW+4fjGMsafDyFaJeA2TYlnVsad1R0oI6XkG?=
 =?iso-8859-1?Q?/kVIn3wdVgSjPxLJvTppk7cfAl7FybCiBxAHBW/e0wtm9AkoOERc6VtuTn?=
 =?iso-8859-1?Q?LBvpImSobogvSMK8p3pFEvOx42UFv9G+sRWlXDaH5oEvIO7hny2r9yuaFB?=
 =?iso-8859-1?Q?ZP4kKIrHvGUhQ2Tp2BE3L5TpSjOuUhz/0IqpITj83n5WAz8b360mXmjYIh?=
 =?iso-8859-1?Q?3I3DCWMrzMC0H9NcQFAiUjA4d7c3ZKWwK0ESMLIJ3SXr6TWBRRgRszbwTM?=
 =?iso-8859-1?Q?FDVIgkkD2K/0K7uE9Xvqietu9RiSk0bcmH73Foyy8Te2QHwUMAYD+vtJsz?=
 =?iso-8859-1?Q?rPQhMfZpt8RCowyUA1pc1wjzqk6XOBlTQ+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f465a7-9617-49d9-c32c-08db5dafeb35
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 06:10:34.9402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClVjG1ndMsGNvtsHDkiE0IijPU8rN8rq0OnHfG1KyKcQvdw7cPD1q52Rte568jd+Tenykot53liVY1+TtQ2mp2tA/uAgqzyVMUvFYeiXEts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9410
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

=A0

We are not updating the functioning of CRYPTO_ALG_ALLOCATES_MEMORY flag.
We have introduced the changes in CAAM driver and this flag is no longer
required for CAAM use-cases.

I will update the description of my patches in next version.

Thanks,
Meenakshi

> -----Original Message-----
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Tuesday, May 23, 2023 10:25 PM
> To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Cc: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Iuliana Prodan
> <iuliana.prodan@nxp.com>
> Subject: Re: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
>=20
> On Tue, May 23, 2023 at 05:34:16PM +0200, meenakshi.aggarwal@nxp.com
> wrote:
> > CRYPTO_ALG_ALLOCATES_MEMORY flag is limited only to dm-crypt
> > use-cases, which seems to be 4 entries maximum.
>=20
> This isn't mentioned in the documentation for
> CRYPTO_ALG_ALLOCATES_MEMORY.  So it's not part of the contract of
> CRYPTO_ALG_ALLOCATES_MEMORY currently.
>=20
> Please don't make this change without updating the documentation.
>=20
> If you'd like to make this change, please update the documentation for
> CRYPTO_ALG_ALLOCATES_MEMORY to mention this additional exception.
>=20
> - Eric
