Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD925B3B8A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiIIPMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiIIPMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:12:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC081440AE;
        Fri,  9 Sep 2022 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662736340; x=1694272340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ak/ICqZdasJI0cD/zyQ4a4NKv6I332tOVAcM6Dr0zN0=;
  b=P7roP3xHD7KfoY9lhofjeaZcAYg2P7V4XEmjPBae/GaWWA1Im/Bok0cW
   n02J9UXSTL3m825Z0n4/1JZc/mW1rKbHVQaTO5XIHhYL3uMPsnDa18EBx
   yxjA7zH9vWu2DxrmFJRCtaOu2gWP34LcI7njqIbV+e3e/Om+YuexG8Jzz
   Qhn+VUhaX8xJF0tA5giogGh8FMaquqXnuP+evU9q2UaDcCUd40qFPtEyA
   nZo03ms0X0kLdZdFSnqLMHD4S0XqcoCu/2uwJ7bB9aqJPMFjrUPnVo1t3
   EFbgmE8FeHzRMd7yVV1nScmLp2Xz/gAqGKHJ3Hzm2pI+LSrT/4pA+56qu
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="112954213"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2022 08:12:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 9 Sep 2022 08:12:19 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 9 Sep 2022 08:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QT1v2w7MiSoFaqnZm0+veOS3YxyVAuuxAacfo8H2PyDpI/q9zn1K5ASsy1JMHCwTvDdRJAc7LbU8UtanC7w8DhQcDCAMDand+JVXeXQ5QgMT1GG17Bc7WNWUcjikCRQLtOw+7Ab6EOJugC2hRXfwKi8/HGDbi8i/6TM5GKusprml2Byefjtd2k6IsiHkm4OYWgcGVSwCf1IkL+sG7c/TmLMIJy7CZ3vqZg5QXp8W2vNuDaNn+wMa9DfJyuW90I4Qze1+97GslPTGcK+RaHe2NEnSgFjZz8ogSWZp6MyyJAOhsGKr3eqCl7enFzHW3wJWCBZWTA59ocFd6Xcg51dcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLRR97+xpxZ3s4/9tToguaea7bxfGjgZ7WaaCZMvZFY=;
 b=AvFIOr2j/8tX/ugfh9EtMBzUp9WC9GRP5cpGecfSXxlQan/yz2flKc/4g27s3IHS7VcZ8jRO6tO1B8PcOpyDXaXtadUjNczviH7B/g65oN3RMWW7WufX6VD0lA6RySK0U+x4f+7XnQXh0sDOk3VAxt5g+AUjzge+s0bqbeDFD0iml6ckukHbAc6YB4E2aXpiF47To7k6ChvxOjrZzuAnFmibTQBq7/1rilaPDeG1O+wnTHVEx2ZpVHiHI9BOi4ocq/sCJ9JFnPuAba9x2UwLzXO/SFdfFDPdTJ0jhiq68yWYzb5p4LIguqbuVQ0Hn8YTVvMnh7Uup93XZKjFOI/BiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLRR97+xpxZ3s4/9tToguaea7bxfGjgZ7WaaCZMvZFY=;
 b=BtzmEFQrMke/lr6vilGB9wP2f9KdJVv4V9FwB6QtdZjfLntZju8M1FjPvxtTWibqXH6jk14ur670V4TdZGqT3bHv9GXEgO2n9oqUmH8LN6ZnqGIfFdmY+5Ge3m16WjNCej1EJwLoDOA6YTJxFILIk3nZLGdPVZQ4tTIxlHFJnpQ=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 15:12:09 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::3198:2077:56c7:1780%4]) with mapi id 15.20.5612.014; Fri, 9 Sep 2022
 15:12:09 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <sudipm.mukherjee@gmail.com>, <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>
Subject: RE: build failure of next-20220906 due to 4ec7ac90ff39 ("misc:
 microchip: pci1xxxx: Add power management functions - suspend & resume
 handlers.")
Thread-Topic: build failure of next-20220906 due to 4ec7ac90ff39 ("misc:
 microchip: pci1xxxx: Add power management functions - suspend & resume
 handlers.")
Thread-Index: AQHYwfw9eg54+szR4EyIZ0UVDHtDVK3XOCGA
Date:   Fri, 9 Sep 2022 15:12:08 +0000
Message-ID: <BN8PR11MB36682FAC4238F3BFE6426181E9439@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <YxdX2l88PSFGe1r4@debian>
In-Reply-To: <YxdX2l88PSFGe1r4@debian>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|PH0PR11MB5029:EE_
x-ms-office365-filtering-correlation-id: a21c315c-477c-45ef-6349-08da9275aa37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AS8uCF5XGgiSDDWXzaqfK33/5LRBzueJERG7y/OLij0Qq1jPfQOo2SwlPzYdZl3y4/viS0w75uHKN9DEjpM9TfkF+vw/8kPM6em49KII0J0Lj9Cg5gVd0sUgshLz0UZ0cy9Zt41ctWXYOwqYV5T6PGS5qjTtbEk7DUiyApW0hkohoTLs6nU4kLlLcnihrmCIx2A21LJF36TGF5WUJj77m2IUZHNRwX1uqaxew/uUXT9VaxdmPxoeYl13lU++q4OaNmoFDplPdgXSPnuA+4ICb+1+1EMgTd5ift2m3ruzhuHA+4xg4jpUgF+I7OfXJHhq5K6qknQl29BkM/Gxxzap3l3ay2b7ljO48vn+XbaiicVRVtFa/GOXdMizttJ1SgRHoTPPkCJCDfi7lbEG0I0pBwAInvndpWATZ1FJ8VWDgZxGqQc6Xb2l3qIruT+hiMq5fwIM0AYC5x3fYe9Dn6YqArQE9OgrAJ0tOyM6bev91pTXmpvNLpywa7X3gENIoCsP82hQXJ45RCFkkNkcdpXE2O5Y0oe6xlW11v1UWaIZw+TEkl23/fspmrcUc9EKr4eLvgfcCPUm8ogWM6ocNBJrM/NgRtmPzp3CqavEL7NKaYfg4O418ilDsotRrgI7e3w1TvqciFRV3Xhs7hS0kiOFSgROBQIGS8ziE0XrFn+JlceToeBaGfQNX0FDzQV3PhRzxjJljoUBJj8NLuHOUSzX/0izs+25wWgZbBfnXi4QT6ordXWGs8g8LOqipIKt13Lec/JlxRGyBgJ0rQFzxP/7WMMjIzTfJy9M7rfEd/zTQysHw6zvUjr64znf7dotHHbLg/DkbsrNAc4rcdQMWgDz7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(366004)(39860400002)(376002)(122000001)(76116006)(66556008)(8676002)(66946007)(64756008)(33656002)(4326008)(66446008)(66476007)(38070700005)(86362001)(38100700002)(316002)(83380400001)(71200400001)(186003)(41300700001)(6506007)(7696005)(26005)(8936002)(478600001)(53546011)(110136005)(54906003)(9686003)(15650500001)(55016003)(5660300002)(2906002)(52536014)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KhMBWz7/qEHxYRk/vUPfEs8GZCe7TZFQi87Xvy+wSf4XBltRQ7QitUsdrUXf?=
 =?us-ascii?Q?d3LZ3Ex80TvhmigkEqitXCouyEGKj1N6T+cvGvNs19WvdSRqehlmfTY6k438?=
 =?us-ascii?Q?WjAntQ9H8r4rEXXyHe9IR7CwKTwStAoX1aPg1SoLNaiGKuSJyt0COgpeGDxe?=
 =?us-ascii?Q?OX/+DjB23DEMGcjMjmKcD/uZbyPPtJAQR8NSVfO6MNdCtrs6S/NW7xo9ojiC?=
 =?us-ascii?Q?AsBgsjtJw7JEHwUq92AhhspBcbMmIPOX3pJE6Jkf5yUuFsA9AIOuIJbTMg8u?=
 =?us-ascii?Q?O7mBsrGA3Eq0prv1VzTxWASFYmC32v6MibQ1Q6ZBVAAbKZe3zpBP3i5rvC4U?=
 =?us-ascii?Q?IhOFWTN4/UymTa+ktpEsI7Zqwkjge8OO4K/AQ8gmFcvR8eaxlUzYsvQHzPbk?=
 =?us-ascii?Q?yoxlSkRiH22cMqeLXyi7IlhMzdXN/oVYR/fAiugdar5pSYWHO6eGN8skveVu?=
 =?us-ascii?Q?CRu6b/rmJG+5IBoH+cRxbbiUgGUwHOxWvnznN6nTivTPd5N2cxVhOaW8NK7E?=
 =?us-ascii?Q?SDRjifdK0iQMZz1DVFDb9byvb1ma3nVmi32ijkcgQ+rZqmVtjDFont2JaTq5?=
 =?us-ascii?Q?ZBdntx4BccGzTnPUFJaRYZEQrif6IRxbW9wb9AsQWVVQOZANOMofi6LCk+YC?=
 =?us-ascii?Q?/l9ctAKy+PoAlbjU8O739gybYowR2mEpulBEjVa79MrerUgo37ut/w8sIaxc?=
 =?us-ascii?Q?gplJdZ1oxNu2VZoA8KhC9tDRfOMnoTrAkyI6wwxqdiLTqyPNXm1IeOsedY8u?=
 =?us-ascii?Q?tBnMVsg5cEcQYhgHYEQGQ3w/5qsvfkMuEKxbg2dApatjRjbX+5q75sGrAsjU?=
 =?us-ascii?Q?ENjxA1RyX8/IEz3BAWLJEHfvo4Foxg3STp/TeNCPlHtLt7Pn55aSwAZjtXjV?=
 =?us-ascii?Q?52zggjmF0l3P1hw9L3IHbyQJXjdOH1RNZGw+2c+BwWJsBRNr2CwziVRveJ8t?=
 =?us-ascii?Q?hI6rESiNBkdFsU4ltde9V0vDvS/Yg2imTg6erKAghOWceN85CAVLp3vBWkHL?=
 =?us-ascii?Q?4DyaKU4+0Ny4YeoEVddhXET4DYeFDQwTg53LDP9NHiCukLLlYZDXgZSEHYDc?=
 =?us-ascii?Q?WhuWOlKKA3Pg3B1V23OEfKQ00FOFM0gh87KKWeTZ2dwLZCy4VRTLr/HKy4RB?=
 =?us-ascii?Q?hxRl6Avq93JDlfsHDVLOTPvhyEStJNnC9DFOStWY9c+UmIhXXO9Ec6ewSHQp?=
 =?us-ascii?Q?BH/9KOZQGbe3yeyPssYGQ7GG18xfyQw750q6ln23T04qI3EF02PBtFGJtdT3?=
 =?us-ascii?Q?9WFZ3+6kkDxVNk3ay7Cjue6DjuGV9asSPq4naq+Kj49smef9qhA6xE+YJ/0l?=
 =?us-ascii?Q?xT8sWoA90DAIIh6QOmNXn2XYK4N2HS1gvJG/UKmlqC7v+r+YEmPphycBBsqN?=
 =?us-ascii?Q?P3hYlWrnWr/r2Zghd+FGZ5ibz/wjTkW6Hefnv9wyESl7uPwE7Djjfor+A+iq?=
 =?us-ascii?Q?zfyBEgLGTETHAkrjg3KZPja/rpwktByXwUdRd0xpxoXnzyagkwtK2c3JGWbn?=
 =?us-ascii?Q?Iad4Z2Bb7X01JHXmT3mM8wlOalIwnwlkhCEe8xDzNR3OMyrE5SofS4x1J9aP?=
 =?us-ascii?Q?/5THw8h6+d76f3QwtJLz5HxsUvW5cbQlkIPV8/DgJmfoE6PqfmU4aSLiVCxg?=
 =?us-ascii?Q?qZZB4eIYgTEIXULIivqBlqw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21c315c-477c-45ef-6349-08da9275aa37
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 15:12:09.0775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +C8BQMVClhZgiYPkN1sdrmOcdJiDfcDbLK5KpzXCHKbB6RX6HiK44ZNps3glRQD6g9WoCW6BGX/aZa47EttAx6H1BWhO6idqrz7ZyS4Hu1gPVdkQEiJsTKMru1qGir1U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sudip Mukherjee (Codethink) <sudipm.mukherjee@gmail.com>
> Sent: Tuesday, September 6, 2022 7:53 PM
> To: Kumaravel Thiagarajan - I21417
> <Kumaravel.Thiagarajan@microchip.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>; linux-gpio@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-next@vger.kernel.org
> Subject: build failure of next-20220906 due to 4ec7ac90ff39 ("misc: micro=
chip:
> pci1xxxx: Add power management functions - suspend & resume handlers.")
>=20
> Hi All,
>=20
> The builds of riscv, s390, csky, alpha and loongarch allmodconfig have fa=
iled
> to build next-20220906 with the error:
>=20
>=20
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error:
> 'pci1xxxx_gpio_resume' defined but not used [-Werror=3Dunused-function]
>   311 | static int pci1xxxx_gpio_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error:
> 'pci1xxxx_gpio_suspend' defined but not used [-Werror=3Dunused-function]
>   295 | static int pci1xxxx_gpio_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~
>=20
>=20
> git bisect pointed to 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add power
> management functions - suspend & resume handlers.").
>=20
> I will be happy to test any patch or provide any extra log if needed.
Sudip, can you please share the .config file that you used for riscv and if=
 possible other .config files too?

Thank You.

Regards,
Kumaravel
