Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1B8739F73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjFVLcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVLct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:32:49 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2107.outbound.protection.outlook.com [40.107.113.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF6D1FDD;
        Thu, 22 Jun 2023 04:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPCRgV01HfwKSoKsqwG4viAXKZPTCv9ENYV6CDPmRhkVtGJCarnfCXEOnH1zv2fec5TqBltjcp796+LCMWSWe3h4romncKmJHgAi5sbxnFntPPFOXyi6m7y34B2sg3lGvfFbXvgMtrLzzPVsX31rFLs9gc/5Ev9NNl1LAOe1LtnqYQqac5hKGmyw1HulBhWbP+sVb8dLfv1oE0SryX1oly6otVU7Hu7T68LrohYOnz+VC9BypThjv8k1+s2QpaMJbA6z16GBCn5/DMBoE5dlBnlJQH4V7/J/8Hc/vI4GNgX/D+uES+p/7fKACuKNDJdounvkwbnyq3TOl4+opErtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P62Be+pCDYPKe9BbvbfvWFuiME8IfeLwwV89it/lNs=;
 b=WE5MlhDkYL2NEYDiU6nZjTwOP1H6ngIanCrE6SfXcLs6nf1kdXCrEr1eqO9n4PHbaAUQCf0YJ6+yG7y9EG3X2JPzXlLkUH1rTHjYf1t/1EIsR2uCTCAcECZbEYKZyqUQt5QU9yqbztsT9f5xqz53AafBtOMljdF30LwBIcVhox24/p3Gv3GQPT9CoksSp9vs96BsWDWBrixWaagRuf8xnPog33ZPqDJOVYQqVOiXTvp6xGTUhW5WbqIezIRP/al6casMFO8nKvIeMNRx8P5vi1PKPfWCN5LFx7UYMFrlJ4eNSQlKvoF6xWvcs2wmEMwjZTBOEasPfeKgC0wPTmfGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P62Be+pCDYPKe9BbvbfvWFuiME8IfeLwwV89it/lNs=;
 b=KuV/vig9gsr8nzVEjh8b6H9HTXOTH80M00xntItaVZkmqM4NY2V/2MUj2Yv5m9gpJdRoEFltuA8Fva6F96p3H80sxEukgJ4CRPmlC2xbW0YCjExr3hWdbkQn4s8S80bgNa8SirisVRy9oO/wqovHIRBEOOGpztESysfJF10QHug=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by OSRPR01MB12031.jpnprd01.prod.outlook.com (2603:1096:604:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 11:32:37 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 11:32:37 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH 3/5] spi: Add support for Renesas CSI
Thread-Topic: [PATCH 3/5] spi: Add support for Renesas CSI
Thread-Index: AQHZpEoX6eyNXl3HSk+sRgzfSXQ64a+WUzAAgABdyIA=
Date:   Thu, 22 Jun 2023 11:32:37 +0000
Message-ID: <TYWPR01MB87751C366432BF09F7B2BCC2C222A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230621140944.257352-4-fabrizio.castro.jz@renesas.com>
 <202306221354.9ZWHS3y1-lkp@intel.com>
In-Reply-To: <202306221354.9ZWHS3y1-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|OSRPR01MB12031:EE_
x-ms-office365-filtering-correlation-id: 2ddba694-0320-421c-0eb9-08db7314613a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6i6maMcVnIRbt8Ktb0wrNmwaSfv8uM9rehwpZrrERSXvHzUD1fyjc2uo9/u6W6sl6vTi7fcg0/W+mm35rSKbKk/c/OKDizEJPeNArrpuW5F0Le3SWF/ajzoEdGKFC4Cml1PktdY+vwTyXytPaQ0IiGpPEhR3weX2Tk3Bn07B0prsnxVITrvPgqxNdwWjSF2XFDVrVQJJ6Mo62UUOfec3bAnjUEJCsMaQZ8IVZCqZUsiQqRHtg5y2KZxFhSUIFSvjzGGr9856qf+bsM6Ssi29kas3hBT44J1Kb6GDaCSekDDQfmeuq8XouwhgLm7GMzszzk3dkqVyl3UKllDwj1Q+ven3ihxTtqgn3qdypogblfcDLkOF69atsqrTLuVdnoYvmL6ASFXCAMfWxYctx4W5rHRNYY4qXaaPPXuoACFYz7mPLOSFuRXLRxWEqMVITcHnwX6WFBQ976dLUoH9Cc0WTHDh4f3qyriYBjROQ4v4e8LWWPxKnXtpDSIC0mHnV5TWCMjhQAa1Cj/XjNr5Xfaif+U9lJEUAEB1oPaPjT8jR1ZRR+chk+A4o5qMrqlcj9j19EfRMzvhwMxnkTAQprzJo5OxWzgcw09SaxzB7zucOkk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(38070700005)(122000001)(38100700002)(2906002)(83380400001)(8936002)(41300700001)(8676002)(52536014)(5660300002)(186003)(9686003)(86362001)(6506007)(54906003)(966005)(7696005)(110136005)(76116006)(55016003)(64756008)(66446008)(66476007)(66556008)(66946007)(478600001)(316002)(71200400001)(4326008)(107886003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MeIKxkkQRq3sw4OlTfOi8M2h45YbY8/0PtZE6NgdaYZ1lW0Ft6oAz/CUFytW?=
 =?us-ascii?Q?sEq+eFzqPuJnzPRAWzKEOBGwUgXaPvptA4tBO+3aau776pCM9ufbEN6o6CLZ?=
 =?us-ascii?Q?qpNrhCZx/XVEtU2GHhBmlUTOKRdtbtOkScMlCGqlWKce++pKnDd+j22O22ag?=
 =?us-ascii?Q?6WNvfuA0MjF5NgVskZJo20OTsNI5RoDRiCou2WjgJEunc1zu2ZDgvNDdeVL7?=
 =?us-ascii?Q?+OSnZvwE8ILMkwNX2YhKUzWA/qCNpA6LXlGyx/tNE3LXixQ7PPSMj1KO5SXh?=
 =?us-ascii?Q?KjxU0RSx18eEBJCFMGMnkymO6cmwaJmF32GHYmQwQNdsibNflTG6zPlPlVAa?=
 =?us-ascii?Q?aBx4GuExnX2C4pVAgpu2MQ3eo3FnqYqcK2Zx5h3Cz4edQKfvJV5LX9KjMWEk?=
 =?us-ascii?Q?81W3EQAp/BldbR0977MGJ8gyfRRUiEyoDLiNhLMIOyaRLgyxEqBvws/2tLEs?=
 =?us-ascii?Q?hRdIPxIv/QZaGKAw/5j1W0okTiINJOrMUJtunHfxy4KNPzu8MPh6NMbJB+UF?=
 =?us-ascii?Q?M9e2MCvPN/eSOomwCy00PYb3EUkjSSERFuEDLgFffzxZETe23A1Zc2hWOvlm?=
 =?us-ascii?Q?Nkgd8hcnvKlRpLsyaG8o+Y4THSWelfIINxeVetW18i8ohG6AbpVwWRMG7x5P?=
 =?us-ascii?Q?hv47EQMZxhg0AIqwJjZB60I+vbY3Jlg5s1bxU6HkLU2RUBfbL3aSnvGsD0W8?=
 =?us-ascii?Q?J8IHuouNpqQwOirANaHeGxYekbPaLbjWiD9Wi1pII+hArsDHMjNTiZ8REgNV?=
 =?us-ascii?Q?XMBsVm/0MjhjHyc5pvhe08Ms51n1zrH3d525V3/Wq7ZUHA0ZPDjvyJzyf1ux?=
 =?us-ascii?Q?PPEuvJZl+WCLCV1OHOiDTbA3hJNog2iZnm3gq0JmjhsmLq3v1HuGmOsFT6Gc?=
 =?us-ascii?Q?yA6c7U+FGe6AjIRLLsERFYPk7GFOnxUbbzgTIE7Vk6a+eTSR0Ev0M0lNHh/4?=
 =?us-ascii?Q?zmy46ODMzi84jYJ9060FVxfDSRSIBL45i95mSxbH4JKLTvJTVPYr4+9sPsbt?=
 =?us-ascii?Q?orIsenJOLsh7ZW4jj+q2akt0CF8qOWiuXyu4zy7ojvk7BVdCP5mMMOal8vmY?=
 =?us-ascii?Q?BiKhrP+hgfcWcdOvp+tOhVjHiSp9SxuVNQTp7B+zjuxiErJLr59epVgmIJ0T?=
 =?us-ascii?Q?61hsx3UIA/GIxLiDZ3MF+C6/Fc3XUk66Nx0GfIeUibnGDGbq/RdszOMHVmrw?=
 =?us-ascii?Q?ZoQNryu3dH/zNJ9Cd2bWiW0ZKbGtLEptJaXPc/nkG5yJO0n4kdYUXTaMB/4X?=
 =?us-ascii?Q?bFuFu2dsmaZPyIj3yDGfanmMRHbyzF3ggM/ZLpJhbvuNoExeuup6ZwFCTAKE?=
 =?us-ascii?Q?oUNop6QeqjmLa4UMKiXlhkl3qkZEHorfYn5NZCoJtLDvM6JWYk9Yj9qHiv2L?=
 =?us-ascii?Q?unrSU/VGcQvRNJ5CyS3HMnz4wHlqWCxYDHwa86HsnpoqFYimo4Zu2Bu3WIKE?=
 =?us-ascii?Q?dYKCY1Gl4n0VnrYLTU46yX1qB58weMCdH5IL2MKaI4t2633wfDSBvWAX7WN9?=
 =?us-ascii?Q?8Daq+COWovky20rj3fJAzNgEJ0V85qcRXXbnzKr4Bb/ApF+BrcuDFhSLWLi9?=
 =?us-ascii?Q?viwJB3l5fCvI74/2j5M9lZTcX7MjnWRIP8GXe84h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddba694-0320-421c-0eb9-08db7314613a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 11:32:37.0314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dH3wn0Xw+BbOvdXd58ob50xIyaDUHMmBRocmi8vmr8MDQYHheoliXysp4/D+vwp8Gf25c6DypsQ/QzKsrhTgJyavdTtGoQpeFjPbc16eblc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB12031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

> From: kernel test robot <lkp@intel.com>
> Subject: Re: [PATCH 3/5] spi: Add support for Renesas CSI
>=20
> Hi Fabrizio,
>=20
> kernel test robot noticed the following build errors:
>=20
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/spi/spi-rzv2m-csi.c: In function 'rzv2m_csi_probe':
> >> drivers/spi/spi-rzv2m-csi.c:608:15: error: implicit declaration of
> function 'devm_request_irq'; did you mean 'devm_request_region'? [-
> Werror=3Dimplicit-function-declaration]
>      608 |         ret =3D devm_request_irq(dev, irq,
> rzv2m_csi_irq_handler, 0,
>          |               ^~~~~~~~~~~~~~~~
>          |               devm_request_region

drivers/spi/spi-rzv2m-csi.c needs to include linux/interrupt.h ,
I'll send a v2 to address this.

>    cc1: some warnings being treated as errors
>=20
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for
> IOMMU_IO_PGTABLE_LPAE
>    Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMPILE_TEST
> [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
>    Selected by [y]:
>    - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS [=3Dy] ||
> COMPILE_TEST [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]

This appears to be unrelated, it requires:
https://lore.kernel.org/linux-iommu/20230330165817.21920-1-rdunlap@infradea=
d.org/

Cheers,
Fab
