Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DE2746D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjGDJTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGDJTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:19:32 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E451B6;
        Tue,  4 Jul 2023 02:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDkz15Uqujtg/WReiGJXvwcW2us0FmcFxUVawH+iLScsZ3XUmVdSVhmhaLicUvXX7BsBzIqvu/R8iD4MWJbrdQyY2ePejwwSNGbba4Lbd3K5ZNAMhCq5iniOv3bR87bjrVZs6m4R9qFZcKaVDJIDVITS4DYNrh6/vVxww12G6fCTZ/6Yy3bgLITU98ntgn6MMEAbC4l0q+kH413Z4ta7YpHtmBuZHY7sQh2v/anNmaX2S/zCijr8fK0ZwbZY5vycDQ4TXaaNlMEPPtBYSUiLD1kiiJGMxAldpHiz/MtNsOASa8qpaYAsbJ4M7Dp53kun3cIYVT5MQ4Tuy43aBYlaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df/h4p4/juRmfBurT2EocIANESX6I4IN3WaH3yJu7QA=;
 b=JnOW+kRzBrR6k2gNUsSB+0fl8Zx8UYYNyLsF/ppdKSnkRvva1xQ/QMEnT8Y1vBL5L36jtR8s/chIzatHnXAlak56J1c25V2iIJ8xEbTjgFzTGkRwZ7XhVi644GoQT7EBj1hxFVa9R40eNni6alUdxlbflaiLGKUWWNZporm51MgO/SzQBYqAHXFv43tmhPvPXqdJBE82gMPTGbPrqEPEG9i9pE15EjlDthcDQoB12uNKf3vFYA66WoIw6AahYrJJMMg5zEGoGj106fN9kHPdA07Mp1McCLRQeRqImpz+IePhbbmbaXhpKTy6qqrD/eF2u7HHSmpHgtcN0GRS1Kp98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df/h4p4/juRmfBurT2EocIANESX6I4IN3WaH3yJu7QA=;
 b=lAFzm32YkWxkgOiNJfVAWeWs/Ds9X3jQXoEHSx348C9tRqoHasUMHtgqqgiQXvDGw6ChTq8TjuYmZpRH81nuXLCDoKLy05ltpa63z7wD87eE6SsW1xoRHDCKtUUbtcCbcl2azRokwBCKLCFU7lSDPLPZKBMk91x8ghliXV1rckQ=
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7)
 by AS8PR04MB8182.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:19:28 +0000
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b92f:c3da:fe42:8605]) by PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b92f:c3da:fe42:8605%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:19:28 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
CC:     Eric Biggers <ebiggers@kernel.org>,
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
Thread-Index: AQHZjYweUt32QHpmXkqlWZrZU7kmVa9oE4qAgA26dgCAAA4FAIAMcSYAgAGGbgCABlwxgIAfZkXQ
Date:   Tue, 4 Jul 2023 09:19:28 +0000
Message-ID: <PAXPR04MB957111A43069E2658BCA818F8E2EA@PAXPR04MB9571.eurprd04.prod.outlook.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
 <20230523165503.GA864814@google.com> <ZHh0DF4meU2ze+g7@gondor.apana.org.au>
 <ZHh/zqNu7XzwJTl5@gcabiddu-mobl1.ger.corp.intel.com>
 <ZILvtASXQKLG43y9@gondor.apana.org.au>
 <ZIQ3OKYyOcwRIOLR@gcabiddu-mobl1.ger.corp.intel.com>
 <ZImNC6KUNHquVAnZ@gondor.apana.org.au>
In-Reply-To: <ZImNC6KUNHquVAnZ@gondor.apana.org.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9571:EE_|AS8PR04MB8182:EE_
x-ms-office365-filtering-correlation-id: 9a33c2e5-4f4a-4347-a06f-08db7c6fc4af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZMOT90oPhfYC++EO110jA9Y77VxZpFoCKtODZ1bAmsLMsZY/8/3p9uOuX1pvBq/U67RIUrpFePHxLf58flZzr9GX9+gmZ+2xl4E3/wUbnbqDpVFm3S0aGSbf32fiFdQB43VidPzjMuBxujb+awv92ajf21iCgbkaF0gp96duceXHKhdfFnRo2qrDGPhqT+9yk+efeOrZVQ5LUoMSLHV5HO7t4R08ywreo+Ucmryu1QBLCtT9RFnIrve7qyGYu6l88EpbHbLecP5csKjBZskZKqPpAjZHOtvlAbs2Wq3jAS4oTMMbWZ9mjXdiaWgrS/5ds2jStj/UnupcTTrexENsYvAiosdrbICBvrdGZKX6jWtjNE044FMheap55mqvPdRya2Uey2/OPgoFN5N7TAV/XZIKoonPGKTU2SIqgSmtP+Jc0l/3yu2JAJ77XUUTeJAOK6FhBnFxgJkkpzmE1djLzlpARcUDFjFgmH9bjSj8s5Yhhmlh5/q7kRxOkMoENcVcni0nYNNpIsMIt7DpMAkAF80ivfYUKy4mE7UrVpquaRzSXyI3/2mK8HeQzlqHutCsfV2FtCakHmLbqMdSG+WKomZf3DyK08CjNSXRYIh0HTA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9571.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(122000001)(71200400001)(45080400002)(478600001)(110136005)(54906003)(52536014)(5660300002)(8676002)(8936002)(38070700005)(86362001)(2906002)(33656002)(44832011)(38100700002)(66476007)(4326008)(76116006)(66946007)(66446008)(66556008)(64756008)(55016003)(316002)(41300700001)(83380400001)(26005)(53546011)(55236004)(186003)(9686003)(6506007)(966005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+o1/jAYkUB8n5y549T+j4NL9bjFY2+pzJ+NokgidEJByX+ofGIbF7RNVID2l?=
 =?us-ascii?Q?e57OZef/aDCL6w+81y1mXfEZaI5vqySsiolRQy/nv7QOuLXzy7te8chAtwOH?=
 =?us-ascii?Q?V5qYCv/XEgGwDVpTXdfY2u4XlqHpvONopbkF2I77AZ8maq0b8NfHi3xnazMv?=
 =?us-ascii?Q?LcMYDXMOPzZberz0xpwnYJSltWmZJPfnnfRX4exIukfLtpEXkyv6uBJzsmPg?=
 =?us-ascii?Q?Z0vjp+cX8iThLTzMijFMlQ76bNqtvCTSw9SflwCh3qHAL79h+ml3geOuyJyJ?=
 =?us-ascii?Q?hh+uI7ao5SjjYWkzSBTh6iRBHV8oGOKMW/lnQiu+gDm1qN9x3xgsrONrz8ZV?=
 =?us-ascii?Q?y1KyY8/YRe9LlxehofkVeyjo/NsVpp6EpM6TtBMZ++O7H/ZRBZpHDgUBqxgJ?=
 =?us-ascii?Q?wB1Ml+bq4xHLHBVCcOXWns9Lyd8fI+L1P+Q7FpmCNuJkwO+jCco/ERaT8TH3?=
 =?us-ascii?Q?EkkcqLy29W7gXoUZI4TtXGZuk6pg3j3AxCefXJAD5epl1RYNr4SWJdifIRHu?=
 =?us-ascii?Q?wVhGnkJPHA1vIMIi+BWLRtzWNWxXneGb5s+Z7Kjv2BrENgLacKrkhFV8IpXk?=
 =?us-ascii?Q?CPYwovcJyA80PKA7sFom8jRnvxYMZDSZ3lV/wI5oVtnFQxb6eyjdryaGE1Bw?=
 =?us-ascii?Q?3BiRvyOLr6M+z09Vbbl7AHp5/wNEDkf3jGbs0SxhNIEPxmSQihrDX6099Us0?=
 =?us-ascii?Q?TUxVUPh5TTvyAzZCz0qGp0QnmedfP2/KLZtzAH7AtR5J0G/Dpo/CnpD8Xl6u?=
 =?us-ascii?Q?JERHnMiKaKsKV5+QCabHNYwhOKluksPADWT3DISElLcXlIzPrIikcqLwcPn9?=
 =?us-ascii?Q?UYoM+dc5K98bEmOdhTlGfry42oGwpijBnZNmrtkSYbYDxkWB0j00UlLG/wZR?=
 =?us-ascii?Q?kob1upCLphvzy0wZJ3UmoIBCENu0FjKfyEtkzeis/h+82bia8VfRXCmUeeao?=
 =?us-ascii?Q?gDmwX76BHTpsYvErpSALxwgyKy6a5e7pia+erLzfp+hlCsFn4KQU5atlFYkb?=
 =?us-ascii?Q?f8+E5SBZjUMJfdMP00DvULKJdC2YZVxxY3HRInE+8akkq3H6uxsLpu2h0OzI?=
 =?us-ascii?Q?ti1TjpwBMUuLPNo/I0HBBPzEoP9ijbjj452e0gCI9ljD1dM21itGsAOhCl/+?=
 =?us-ascii?Q?wfK0EEbLFexCDzgzciorG/622UHU3QYr4NBo6JOIkWonKfOpusFbOKiTd+4h?=
 =?us-ascii?Q?tceMoktrk5INhdtfkxbUA4BrL8E3Ku58QWpMtsTCxFzsIQbS4DSrSYPqaJEb?=
 =?us-ascii?Q?WZ9SNlRC6LIhmsyA+n6aTkk4gfgta0JsUGgJvjnwroBT5QerqFng1Esqw5KG?=
 =?us-ascii?Q?2PvwcTASofJioXfqi7ZJWiZ/e++F20w257p5ptIJIjMmcjznS2Jca/1qdeud?=
 =?us-ascii?Q?ZcVYOV0vqOQ0fMb5mI+Nb1FZYI2pZ//ttZuuaPDPhHD9UZsZD0U7ivCK5r9V?=
 =?us-ascii?Q?IabY3cMpOsTDgaHQldKKY6608Y+VOQhVa5e2deok9c+OKIoXxIHdC5/D4399?=
 =?us-ascii?Q?YnRCL2ZJh/i6iNXGdoRsS7GvrQvRwBg7BjytMsgkAIK+4Rpw8ggyKYxpd8rw?=
 =?us-ascii?Q?aXnOlhXVRypcrFVexsQ2yLIO/25f61goGIfMq6pexYbpkEcWPzA+FgspvklF?=
 =?us-ascii?Q?cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9571.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a33c2e5-4f4a-4347-a06f-08db7c6fc4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 09:19:28.5525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcbwkkKbyYyxdXFIRQEJb+EOvBp/jFXhzRSXZCMMbxZYNpOTRr/jqi6BP4+a2Bq0285PCrRZyit0NuHZzuGIUVL4krKVkBTsTDPKkDh6jC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giovanni,

When are you planning to send the patches?

Thanks,
Meenakshi

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Wednesday, June 14, 2023 3:19 PM
> To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Cc: Eric Biggers <ebiggers@kernel.org>; Meenakshi Aggarwal
> <meenakshi.aggarwal@nxp.com>; Horia Geanta <horia.geanta@nxp.com>;
> Varun Sethi <V.Sethi@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>;
> Gaurav Jain <gaurav.jain@nxp.com>; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; Iuliana Prodan
> <iuliana.prodan@nxp.com>; lucas.segarra.fernandez@intel.com
> Subject: Re: [PATCH 0/5] Remove CRYPTO_ALG_ALLOCATES_MEMORY flag
>
> On Sat, Jun 10, 2023 at 09:41:28AM +0100, Giovanni Cabiddu wrote:
> >
> > If you all agree, I can send a patch to remove
> > CRYPTO_ALG_ALLOCATES_MEMORY from dm-integrity and update the
> documentation in crypto.h.
>
> Yes please.
>
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.ap/
> ana.org.au%2F~herbert%2F&data=3D05%7C01%7Cmeenakshi.aggarwal%40nxp.co
> m%7C6af00291047c46f2325e08db6cbca189%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C638223329655306217%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%7C%7C%7C&sdata=3DNrj0YEjJrFUNWY25h0iy5sF7tUnHSDun8KhHxnhUhh0
> %3D&reserved=3D0
> PGP Key:
> http://gondor.ap/
> ana.org.au%2F~herbert%2Fpubkey.txt&data=3D05%7C01%7Cmeenakshi.aggarwal
> %40nxp.com%7C6af00291047c46f2325e08db6cbca189%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C638223329655306217%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000%7C%7C%7C&sdata=3DlBaQiOM%2BXaax2lMroHtqbtBbjXBlkkKj
> ms8mgBnou%2BU%3D&reserved=3D0
