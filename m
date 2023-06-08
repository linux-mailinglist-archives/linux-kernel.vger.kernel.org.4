Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423A6727F56
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjFHLqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbjFHLqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:46:21 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6B30DE;
        Thu,  8 Jun 2023 04:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3P7Y1yg36ZSgJdfYZdwiOTg3R0Q22VJItDpi3vflq9t52XW4kPYEXDdm9323Fjo67jhXx450ObgBZ6eCiqP4pBQX+Y5sCaiG5TAQDgzJJzfGRIjQm9lEqeiYZXm43RuuS+xxW0tPfEILPGEyr3cmMCAreW1QxBEJ64+We6us9Qbb1a/WETaIwcI4NpQRknKpqzjVou4uElUwfaHKCyFRx4bpf92RlU6DaASRpw2za+O3Uh/hzKJS/6meZBYrmpJG85/efD8CdnViKJPQIHjoNIxJTH7fJyjfpwlkMYbDTkxe3DEAyW180cm5QcmNkR0UehkBb2le9u+H47Hdyxdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2qHo+bus1O0l9OmFE4oXkw4hnr1W96fQ09JgsR+pY4=;
 b=oStII9DW7VU0TX1eC0yCgMTl9oIwtPOpVen+kMRRQzq7HNFdShQIFJpNVVRgQgKTTXxwxAJBqop3Y1hAuCFFpvAOMn8R9tAYrAWlQrD6zKBHwP2gvu8fnsLN5fptMFOhJBLjDcgBnVWUxRrQEu/igbjcC5UU+z+7VOW3AtthJ44La0U2Xl/Hw+PWsn99ievRWf8vIPPzjjlsgDAYDN2gU2CdbzyD3yebvkVn0ugU85FV+5GtcQOMqNqNuUQsudEZsYW8ond1oXPT1AWcNkwkyeflmnaGJFBqaoaBRNnfQkQFIr52WRfHdR50uoE1BDSRgGxAQUtJwxS7yDt2GLVkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2qHo+bus1O0l9OmFE4oXkw4hnr1W96fQ09JgsR+pY4=;
 b=rRrDquVKqodVCWRhWGAmzw/GEl1sVZTiQIbW+PyRV2n5fnSjk0we4cubQjvstd23OFZJo5kyJGpmILhw7T9/yPynjVcFZMtqwkbg2SPer73sMFLcOrV2dwGUG6U6l6xMQ97iKhdHWBlfLTvxLC9myx6AgMjTkC75+vcVXN5kY3Y=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DB8PR04MB6858.eurprd04.prod.outlook.com (2603:10a6:10:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 8 Jun
 2023 11:45:47 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 11:45:47 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Subject: RE: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
Thread-Topic: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
Thread-Index: AQHZjYwfsEMWykr3yU+l+9icR15kza+A27Sw
Date:   Thu, 8 Jun 2023 11:45:46 +0000
Message-ID: <DU2PR04MB8630C01C9CEC0BE738F5E4689550A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|DB8PR04MB6858:EE_
x-ms-office365-filtering-correlation-id: a2c7dcb8-b483-40e0-9c79-08db6815e649
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SeSEzoF/5Gdg5DvV5TcRBwQnWA3bjqu2JqY2lDl6F27pDrPh2pHMl6LXnYkmqaJcPbj7UVsd87DlHfkaTog4yyDXJEXv1XoatjzyGRUhqWuNPCxaS5QV/JpOi//PY3VnTBhyW+hObZvHAPdL+nWO2rn9tpLFP4GVfiTtDnfAtZ9U8GQIt8fmx9X//ovMmXn8qpZeHjp0sItbrZLd5lMwsuo5vdhoKawRiF0kQ/04QyXG6IwZrvqQdu8oqKN8jhZWJ+XwSUQhybTbAfcJ77BtwZSDAlY4xF1SyXxsDffHBCJ7TpyteNnrjgCRbj/NnJf360EGva2tlFgMECL9nL2/bsYmv8GgilzHb4JY8+PRXEGA5Qlbkx5y1B7xUDqmtF4O7rqBxV0GB+xn4U5kkYFoLJqppgxqFtisMEKF9Zc+RhvXE1+IH4WUZhyxkdSIcf6A/Yextec5xbN803WFnJptsSb5RYXAftw5oJiEWVDgcd+Wcbm/92Tp1cHOv3200ow0j8d6+RrqlR+uscIFKwU1VzAes3ucJ87LJtiJUQzqSbgGpu9dmBIXlQVE9EMgTByjedeu0Kxhj0+VRwJDBEOt0X0SHLpSl7BltCExKxXu/GYrI70FEXq2iI89sHuYDn9z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(71200400001)(7696005)(2906002)(66446008)(64756008)(76116006)(66946007)(66476007)(122000001)(66556008)(110136005)(38100700002)(38070700005)(8936002)(86362001)(8676002)(44832011)(52536014)(5660300002)(41300700001)(6636002)(316002)(33656002)(55016003)(478600001)(53546011)(26005)(6506007)(55236004)(9686003)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qYW7dsy7Vl5jy5MwVwopgKJCXUW6/sXXkrjIdg0q7ASDxaC5jeRMaz8F33w3?=
 =?us-ascii?Q?q4JN9hpDi+52jYVa7iEwQyYttAzaOlTjzpxnZUuV8jPrOixg3ojawCna97WQ?=
 =?us-ascii?Q?0M/h2RANpavQ4NCquX/qOgKZvr7aYQUvep1N9g1Vw5tZbhNOs/UVCIYynpjE?=
 =?us-ascii?Q?rA/398lUNVndjEAs2gGfWb3BLd5hGTfhpNuiAznf9XrSJRa3yHpUW2o31z0w?=
 =?us-ascii?Q?D560wY8pvVNQJf2bMOIbtmc+eHourrFFW4FZyn5lB35UIIJttIq4SbFMKSPa?=
 =?us-ascii?Q?LQF4z489v++yBkj/U3wqnPRIt9N4tzD5rEZ5pGNL3T8F9PHQxNWo2ub4+bEi?=
 =?us-ascii?Q?3UUlpLPzJ3aKX7R9W0tloo+curpsktJUiDZD2O/PHKzOMUSVVz/6R7S6VhF0?=
 =?us-ascii?Q?aOd+AbV195DhMsUKMTmEVewQK5m2xtPXkeoAozTpT3v4Uy9RDkxL2QcFBeFl?=
 =?us-ascii?Q?o9+RZ7IUJSaLVL/plyAK5Hj/e8P+OXmSqhVNB2rAtT2koWLOKC4F/a9ReOyh?=
 =?us-ascii?Q?9K/PK2pbkcf1vAWdBZ+VYyUknpX/OObfv1eqSuGWlUrFwQil6l2JqAGZnwzX?=
 =?us-ascii?Q?bzvfRNwHhEIe2tNKpRQ5kusP++uuCiEqwDs5983/CpLEec02wwF2yByqVnza?=
 =?us-ascii?Q?tZpYt/LED2U1ZYyH8LGHf4kstAEdrzYoO7Tdk8Oa1GpGgZl/wiU9CmKuAa8m?=
 =?us-ascii?Q?+vD0yQEwfvJHIQPF8M5aiZg4W4acsf9CDtYF4WpPmPWlgGvwMUjdFiCuC7Hw?=
 =?us-ascii?Q?EkcVadkjDgyvBRI8GQa5EH1rmG23k5thYuDLNc9H/25quPlnfep8xRgbK6Uf?=
 =?us-ascii?Q?af7iq/LNn4IVYEymKs6h48krciEaxpn+7Lei1wi8Fzk2reU+1Vj7+xXeK7mD?=
 =?us-ascii?Q?0djTS6zDs6GqNw2wDoJt7mL5xryxen3Q1mz/85aNjg7oEW6KLClkTlncjOhS?=
 =?us-ascii?Q?UBvYVH9QI9ckgV8MlxEry0AiORCRnU8lS2HBX+geyIM808PKPwcolqs8TQ/5?=
 =?us-ascii?Q?Cr7TjOzs3oZWSh0SZ1LjWnC4HaCIaDm0rKTyOtYY+E0QMBKr7EkV/vEUoITA?=
 =?us-ascii?Q?jxApgczp56medl8CbURiemRqPsEiz7s8gCLUbtIZ9SyB3L3zF7/vTL/3ef20?=
 =?us-ascii?Q?oa2QtZnV5O87DV9VfUCVLpN6RsIoXFkz7Hi+TveVM9eunKvfPgkhMdQIx8RD?=
 =?us-ascii?Q?fDGDtH1Mo78nK/Bu1Du0Z64D04ZLp01YV8b36kKzPvZIpyuy8lq9zwwsgalH?=
 =?us-ascii?Q?3o+YzCE1HB9A7PIBldA08ALsl8MfBMq6N35D9Jgeo8RlInyOi136fDm79i3A?=
 =?us-ascii?Q?P584H7EGUxX8UGn34f2KK0OlHeSti5MFhp0+sJq1ur6EY6xvpzVB4Vy4x3nz?=
 =?us-ascii?Q?6iZXnRxdvK3fPtLSAdl1fBHmVm3f71Q4iFB0Pzq6lJlrarNQMXYxZNfsALbl?=
 =?us-ascii?Q?SHvfpt4BE1jBmKWme6ELHss3AfnKi+tGzxxONKmAYm71kafhsgmPJEhGuqZd?=
 =?us-ascii?Q?KVGLE1BTsLujp7u32Ay0PW6zA/EShVOq1817+gqpCmPA4u0eBK26/uknaQYB?=
 =?us-ascii?Q?85gPfAkfn2FpMEFq31YtIYwEacPswYGgbJeA463A?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c7dcb8-b483-40e0-9c79-08db6815e649
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 11:45:46.9652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RJ016S3UwWG63S1zXltTFlVFxP5En6a3GIswqFgksCcdjF+O5MALu6FA2qooxOnRF8Y6g4ygKID2yKOfE6PsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-By: Pankaj Gupta <pankaj.gupta@nxp.com>

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Tuesday, May 23, 2023 9:04 PM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Iuliana Prodan
> <iuliana.prodan@nxp.com>
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Subject: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
>=20
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
>=20
> This series includes patches to remove CRYPTO_ALG_ALLOCATES_MEMORY
> flag and allocate the required memory within the crypto request object.
>=20
> CRYPTO_ALG_ALLOCATES_MEMORY flag is limited only to dm-crypt use-cases,
> which seems to be 4 entries maximum.
> Therefore in reqsize we allocate memory for maximum 4 entries for src and=
 1
> for IV, and the same for dst, both aligned.
> If the driver needs more than the 4 entries maximum, the memory is
> dynamically allocated, at runtime.
>=20
> Meenakshi Aggarwal (5):
>   crypto:caam - avoid allocating memory at crypto request runtime for
>     skcipher
>   crypto:caam - avoid allocating memory at crypto request runtime for
>     aead
>   crypto: caam - avoid allocating memory at crypto request runtime for
>     hash
>   crypto: caam/qi - avoid allocating memory at crypto request runtime
>   crypto: caam/qi2 - avoid allocating memory at crypto request runtime
>=20
>  drivers/crypto/caam/caamalg.c     | 138 +++++++---
>  drivers/crypto/caam/caamalg_qi.c  | 131 +++++++---
> drivers/crypto/caam/caamalg_qi2.c | 421 ++++++++++++++++++++----------
>  drivers/crypto/caam/caamalg_qi2.h |   6 +
>  drivers/crypto/caam/caamhash.c    |  77 ++++--
>  5 files changed, 542 insertions(+), 231 deletions(-)
>=20
> --
> 2.25.1

