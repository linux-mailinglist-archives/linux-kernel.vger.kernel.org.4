Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F572BA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjFLIXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjFLIW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:22:59 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2828E71;
        Mon, 12 Jun 2023 01:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgmvTaU7QtnezV6BMHQxHWVQJrS9OvMOv5zFNx9zZVRRtIt77gDh1Tvrr7xnFwD8RXBGOXE9x1tUzq3uAorjNJchsg0F6aCqLZDcJBqWY0MdnGSsr1iTmT2/E2Udsd0DJbqWCO3onI0JHraa+uc73d+xOPBLOo74ovAmMrG4hjvgDE5y5bj+Irbl3klcQ340hmPZ9+W31nQMobe7+i6c/6IL3lGlzQZnOHdftgBXuN2/v9Y0OSqaES+edWd8KiXYDKSCdk0A2OarwRWr1hWJ3hwnxgBZmiZjCjNEKx4PcWkTchkuSJZg87jp4afOoxFTcrtXICeyzoXX3flnu85mpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYe5dYUm3equ9D1SJaL/Y8frjz5bNKJ6H0lCj/ed6F8=;
 b=lpl5hxtU2Vgw9y76PXbMYtZozOUfw3+6u0hfTNFD8AJTVxHDMF6B0mllZfqUlGunAGxA9rn84mXjGsx5M4qNyXU7LCODaLJm5MGTR3bQ//pbJq1lSLunIVWZOzJtovaBA4RZkDoi/zhxaeFRp9X949ujsTifY+ZcoyVMBfeLhqUnGQGAfldm/z8W05++UHWuxl59qKbwJiqi1ZhBrz9DTzlM6LB+IpopwQNOTQxHjC/j1R2CpAMuBBbZb/qKv76gS/8g196r+msTcHkqU5CupzAs35eUfZ8IhNJCoiR8FWmnJ+M9u1jvfEncSedG99COSVN5jkom2JHyR06m1WctBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYe5dYUm3equ9D1SJaL/Y8frjz5bNKJ6H0lCj/ed6F8=;
 b=EkZKndGR7v8KhGhGxSzbucOOPx/iOkPB3yNBcRFS/lojewh2vkRXGAGybgeeAtCRW9Y4AzuLovE04tmPZ0VLCm+252sk5Bbq+7OZCsiiHk9SBrGxzEmkErN0FdlB/kcLgnOb6o9JNFJk+M4bU0wzLk7R6UQ0hMCswRAKwiSBLtw=
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by DBBPR04MB7595.eurprd04.prod.outlook.com (2603:10a6:10:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 08:22:46 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 08:22:46 +0000
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
Subject: RE: [PATCH v2 1/5] crypto:caam - avoid allocating memory at crypto
 request runtime for skcipher
Thread-Topic: [PATCH v2 1/5] crypto:caam - avoid allocating memory at crypto
 request runtime for skcipher
Thread-Index: AQHZmr6YL2tp4KlYrkWHE/h2xyHxZK+DTjqAgAOKPjA=
Date:   Mon, 12 Jun 2023 08:22:46 +0000
Message-ID: <DU0PR04MB95632454BBABC70B936925448E54A@DU0PR04MB9563.eurprd04.prod.outlook.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
 <20230609103842.4159321-1-meenakshi.aggarwal@nxp.com>
 <20230609103842.4159321-2-meenakshi.aggarwal@nxp.com>
 <20230610021835.GB872@sol.localdomain>
In-Reply-To: <20230610021835.GB872@sol.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9563:EE_|DBBPR04MB7595:EE_
x-ms-office365-filtering-correlation-id: dc33f372-2baf-4832-62f3-08db6b1e33d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vIbz2SuaHbjqsLdSJTfukHEFZEEikKtMg98JKj9EPi3irHSXS72/jsU4tDQiuHvAw1KZGkp8XMQ8XpFNbiUb3d0FVP/BGCzjAw6q9W6aCTzYDNpD00WpzX3Pd6QBLV2bpvV09ErISXOW2syMwsrvaI4u6UV6fCIwaow6Xo1uWWNfwPAWY9JK3Iu+exQ1TKyiX6bw0mwpiIh8me480vlJapNUZUloyCT2/SRrcTZF96IskuiFclQ2vU/yr14onKhO/bmQ2Mwo+h83ajmgGgn5tdAnbjc74OIfrDCAd8M75Akr5LtynU6A6n9ygfBBPnjouhSDqjr9Uy7vBPqeCUthlK9v/UvJCq1W+x5eaY3j8PL4Fqkcx3O9ouUVRhSMrXj5mgolD6GAN/uZVdBPM9W9h1Utw1+5f5xRdltO+/93hExSMNsKE7XnoJdJ36cuVSam9JzD8vHxsw0VN50eo+2n/ZnPhLhKwhy7OIotlFeorcR71ZFg5/rXaXifp8pQaGhEs4MTwJ/RiF0r9WzAaJ53kn5oyzXwofHpD7SGjOdpB54C0VoCfu2QqqTK0vxhGj8hAq+Hr7XRLRthKPauuyDSJYkFBSN9f5lJ7mA/s+GUy0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(7696005)(966005)(9686003)(83380400001)(38100700002)(86362001)(38070700005)(122000001)(33656002)(6506007)(55236004)(53546011)(26005)(55016003)(186003)(66446008)(2906002)(5660300002)(54906003)(44832011)(52536014)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(66946007)(66556008)(76116006)(66476007)(45080400002)(71200400001)(64756008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RZL5M0L8AqeRGjPsQ0W9nmppwyy7K6qlkOSxt76WSzORVuIYu/GR9pv+tALz?=
 =?us-ascii?Q?nZ+Pfn3j2YVnfBMuPk+RtopawpRBuAnXSlaQimIHaTOH3RWkc3BFb17T3K6l?=
 =?us-ascii?Q?Vje5DKWOa6EEzIW9U46RAEz0cgVryJEUuWZIUce0SFLtsD3bB0DyXcTG/ZsP?=
 =?us-ascii?Q?2k33gCfUb8dyW4u1buISq9qsj9S/x5tW6zdW8jqbzFHZOxNnOvs1N7LD9Tch?=
 =?us-ascii?Q?+sMxnG9GEQQmFCwRHl1pNzwmwbB68cwTJAuP13NnmI/y7j+ZYvENYzH7MUYR?=
 =?us-ascii?Q?a3CriFxsNjdlYEw7FoB9T9Tx0DXWUb78F2xjr3DHjeTDqx1sn5Fpzw09Umzq?=
 =?us-ascii?Q?SJMKitU5c2MQi1ot6wxqDpYr3/CqZx9Ad4lkBoIHIPcxlmDhEyCl24N2JTds?=
 =?us-ascii?Q?U8UbiHImpC4qCh7v0r3N5riP4J5Yn01Sp/nycnpOWH2D8wNZ9rjucojHpmqK?=
 =?us-ascii?Q?JXq70eOIMdwQfdqWCMkJi15v/bjWLgIfs7qlYIYftUm3+Jp3IHVyzu80Pjn7?=
 =?us-ascii?Q?0FrF6lBz3o7Lz1icKLC2mM6+F07bq3XZT6YGvemB0J5TCnLD6QwM5Te7wqGu?=
 =?us-ascii?Q?k+Lgmj4XZvGpVPgQIFwTbmkVAHLmDJD4VRYiHE4a76w22s/UySlHZvuAmq7q?=
 =?us-ascii?Q?yelT6rLi5fHGv4zpvub9l1huQX77Z/lQGmdmq/z58RBCEHhoEqx4Hw/eGBru?=
 =?us-ascii?Q?YjAtBimYdtMWD36mHVBQlLfHvlAhDHYYwxqBWoml2lcJHf/6oP5hU9ffuyCk?=
 =?us-ascii?Q?kMOUPQVwxc7ufFS3+/X4LdsNaEITj9rDYACKvHIKP2Y0THYlBkkRuKjjGc7m?=
 =?us-ascii?Q?KSjfmMHCfJFTiUAknAhjO4z/lrlOCU+u8rQYM9qv/DP6mNrohd5JIlJ33zfn?=
 =?us-ascii?Q?eRyg9CnAIv50sYa5rcDKO5WTG7bLJmIJx0jmrONpEl+QTDC8+SIu/Wv4y9l0?=
 =?us-ascii?Q?QZ7YjMbJ8zQaYJFxAfdUNEbccuWS00+54zrxN3+MrF6/v0M2PmVP95HJUix2?=
 =?us-ascii?Q?EDZAzq+xKupIOTlmTFAadf565JAkieG2TSpu4BH4HqgrFn7o75VYtXxR0tmV?=
 =?us-ascii?Q?ALxW8uwsBnOrih353nR/5FNKeS1GVekidLKAG02QhU9DqWD4QnGucmZWVoq6?=
 =?us-ascii?Q?mJ7CvW6M/SeZguClaUsHTTteAceYQuU2I68F5eBd4ZennNMiiU90qgWI5AWD?=
 =?us-ascii?Q?jnuiSoP3sf5RUBKuH37lHinKMpHhN5koxXNOsmf1vPVHpjTCn37d6fe9HoZU?=
 =?us-ascii?Q?Gf6ABXOniTCCucki6FI/5pAgzYb36hCN59UJvJmbiQlPf4unJefjvDnqPkkm?=
 =?us-ascii?Q?jHOIQBySLt3/yajY3OpjnbkPlyJSBGQKtMcUYYyxOWVq7Pqa5WgvEP+6VNmR?=
 =?us-ascii?Q?D6QpvqZfHYcOWIQTZsme4+lj+M9mKWWMGDilRhvG120W0U8ovCUB20Iw8SkA?=
 =?us-ascii?Q?ptjyh6KLvjhw023JUnMCyDCpzl40r/cRHgHfjn3R3ZwQVocNdd1+ImrOPGP0?=
 =?us-ascii?Q?cBSDHa3MTPLlHxUq6jC1BAkYC5Rrl1siOMwdFuOF568ijAz+20XXcYM9c++k?=
 =?us-ascii?Q?tKalDQnxpm8eXSX62r799dBFmlaYjRtlFWvGnw4r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc33f372-2baf-4832-62f3-08db6b1e33d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 08:22:46.5407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qovH7UC3DUhkqzMijpmxa8ZbaxvB+IHguqoniz/bnT6KaAuU1Twm2W2mwwofxZQFEEsQ/dJjfrqe/3MmIVNw8dFaNXmw1Wh+hgliYaqDplg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7595
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,


Because of CRYPTO_ALG_ALLOCATES_MEMORY flag, caam algorithms are currently =
been skipped by dm-crypt, and we want to enable dm-crypt caam offload suppo=
rt.
As per earlier discussions, we are pre-allocating memory for 4 S/G entries =
and, if needed, extra memory will be allocated at runtime.

I suggest, we should update the documentation of CRYPTO_ALG_ALLOCATES_MEMOR=
Y with above information.

Thanks,
Meenakshi

> -----Original Message-----
> From: Eric Biggers <ebiggers@kernel.org>
> Sent: Saturday, June 10, 2023 7:49 AM
> To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Cc: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Iuliana Prodan
> <iuliana.prodan@nxp.com>
> Subject: Re: [PATCH v2 1/5] crypto:caam - avoid allocating memory at cryp=
to
> request runtime for skcipher
>
> On Fri, Jun 09, 2023 at 12:38:38PM +0200, meenakshi.aggarwal@nxp.com
> wrote:
> > If the driver needs more than the 4 entries maximum, the memory is
> > dynamically allocated, at runtime.
>
> Again, this is not currently allowed.  Please see my comment on v1:
> https://lore.kern/
> el.org%2Flinux-
> crypto%2F20230523165503.GA864814%40google.com&data=3D05%7C01%7Cmee
> nakshi.aggarwal%40nxp.com%7Cfb75f9f6a37346e27eef08db695903a2%7C686
> ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638219603267394331%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1
> haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DENoae4C6pFeMAIn%2B
> GVDqK%2F3PfwiqM0HEvFjjGMUepeo%3D&reserved=3D0
>
> - Eric
