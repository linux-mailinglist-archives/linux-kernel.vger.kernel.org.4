Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7545EED3E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbiI2FaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiI2FaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:30:07 -0400
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D46953D14
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 22:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1664429403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SLL24HaRMXrqD/4YPt5SxGo2ZvfZa6Ss7VgKjKEOxLU=;
        b=LmAeALFldFhnqeFh1JvSdgC8gfxiSkISZi6/uC/VLRdYsQZ+M3//OI407ovkZ8JoW269W4
        /+wrMqZqWa0mZmsSeb5N1wa5Ko3Ry8FttGaetn0Fgz9ow+YReb3N9Nksz5RUH3O1VTAhkE
        DLddzvJhrjmIC1RVETkVuaN4hYNphNp1cr4zPwnTr5p7q2puYwY1DGNM/ArPyaG/+N86bs
        FwrN2mCqrsrGe5QELZB7CoYzyHl2OrVXGOVw+oebR+aTbWQ4IgmVEGxFKt5sHvnBhKjC6F
        E3fB3/cxJVNUJpSx/RSJ6I8CU8l0CZ5jT9Rx1CdC/EDv4Tse48rl0zYYRzU72w==
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-5hFmBke-NKqtelqnU8zOtw-1; Thu, 29 Sep 2022 01:30:01 -0400
X-MC-Unique: 5hFmBke-NKqtelqnU8zOtw-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by SN7PR19MB4815.namprd19.prod.outlook.com (2603:10b6:806:f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 29 Sep
 2022 05:29:57 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::f362:51bb:74a3:fe2c]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::f362:51bb:74a3:fe2c%7]) with mapi id 15.20.5676.015; Thu, 29 Sep 2022
 05:29:57 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-lgm-soc <linux-lgm-soc@maxlinear.com>,
        Yi xin Zhu <yzhu@maxlinear.com>
Subject: Re: [PATCH RESEND v2 1/5] clk: mxl: Switch from direct readl/writel
 based IO to regmap based IO
Thread-Topic: [PATCH RESEND v2 1/5] clk: mxl: Switch from direct readl/writel
 based IO to regmap based IO
Thread-Index: AQHYzkwBN81C1Ig0E0aREB0eQMfyQQ==
Date:   Thu, 29 Sep 2022 05:29:57 +0000
Message-ID: <MN2PR19MB3693E5E3FD66117576981AA6B1579@MN2PR19MB3693.namprd19.prod.outlook.com>
References: <cover.1663827071.git.rtanwar@maxlinear.com>
 <4c56443ecd9041f102681ebf36b6854090ab82e3.1663827071.git.rtanwar@maxlinear.com>
 <20220929001416.6F090C433D6@smtp.kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR19MB3693:EE_|SN7PR19MB4815:EE_
x-ms-office365-filtering-correlation-id: f42c2318-376a-49b9-b826-08daa1dba5ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: jx1CbYLZI7hlZOUhZfRaTbD9IsuCNQRkLTyZZYysilT0Pihuh3hvWaryVP8RBuCktvmTbp3PXAZw1nBaC5f+fH14BDuEne9bWb1bQezTFbBrkXwuilOFhwZ885UxRN9QzM5GqU3ySCEbo4Mk/aDG2MSLBNyblNfYswBVpUUCLxvmGbL0KYO7HQxTCeZzRtmy9o6eXecGN5V1JGAMJVZF/zJQ/6dyBg68PkEk4E9ADamDiqerlCW5sV8peQecLqYIYxngdXIvzCVK0Q3lRggrBREKenwNe7qiUnuTy2LO6FRhVzKPL4INz3DExL/8edS6ZaCOW50YcvOvPzgxALbqGrX+Ohc0MGp8gb55TTnJHcgxkITk345CnVKkuye9gAd64PEEn4bVnENRIZiTp2eD5f0+4R7DglXWs4LScKVvUDmFkGh6Ei/Kb/E8ldB9sbA+WwvekwXOl6Nly7y8/XFAm5ZUM/e/c2jciDYfrgGTLDGNpVQJNgeRYht6W6yHGzrVnCcc9kUL8ciuBVVPrWQfbcg4jtFsFyBpt41P7/hJCditU3MyExqzJMAK8BVdb5xkHJlX5tWlZeudrz18XByTZEPLZMptcI2Nloo7mtIEBuQzkk8cciaatphE+ap87Nu5b0ZK9nnSSnbaj0yfVDTWD+zMEVyfEMKii7S5+Ms8ev6bca/+QF2qyTL13LmUGzm6nrlsp/SlBgEqjUmAvLH6LS/hkFYQJ+2u1nmcX077m4d86boGc/jF0fxiC2nOIK4k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(39850400004)(346002)(451199015)(478600001)(9686003)(316002)(54906003)(4326008)(66476007)(66556008)(66446008)(64756008)(66946007)(8676002)(110136005)(53546011)(107886003)(5660300002)(71200400001)(41300700001)(52536014)(8936002)(7696005)(6506007)(4744005)(26005)(83380400001)(186003)(38100700002)(38070700005)(122000001)(2906002)(55016003)(33656002)(86362001)(91956017)(76116006);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jrDJBkXd97V6lTEFtTN6Z8TUeCoa5VEhQaZRzR7aTa5+iQ2+mKugVNFkd5Ka?=
 =?us-ascii?Q?tOCRimxBUtdIpaKHDQbeZraGAi9BfEFotZ+XdRVQz8LsyeqMcqpXLqj+8FbA?=
 =?us-ascii?Q?CSwyKBuNz7S2loTDe5yorypffur809Fv2kpSnl5wwl8aGYZ57i0EjJ9skMr3?=
 =?us-ascii?Q?2Q4v7DzyPYmyfYh0tD/FEJfrswDRAGt/5GORX9bd0poj02U4f5n4mlki88uD?=
 =?us-ascii?Q?kiNmEPVVdW8bSlQgk+VFWwHdPWTbj5vQdjuSEDJzJIK5dK5DDxWUjV21MG0e?=
 =?us-ascii?Q?fdvte0lE5GRIbmNCH85gZn9DfJ/pwgfi3K8P80rV8462sfZi9DxwBKEylaN1?=
 =?us-ascii?Q?C2UIwWOL4vAcfWdbCyFgoLWJvuHaEEpFNZ5XcncUlQY52VyTdjpdfSWrOS2P?=
 =?us-ascii?Q?esvyBB+rtBQC47huMlTWC7MG7S9IXrjla3MeWtCdW5Y78Hb12GHphQMsf4CD?=
 =?us-ascii?Q?pYTscdLmZR13KDpgv/W69zov6oVfD36yB50Ql0bCfOQV1iZXPfi3l/25/2vT?=
 =?us-ascii?Q?Mx70iyePrfAWXBLaI19Rb89sjww7b5GhCDVEuGCVPU4H+ZaFdLX7EPp993US?=
 =?us-ascii?Q?UTMhU6X+fTYj2PGFhPZO6SFcy/WRT6YZSEppItcJfRHpcIDZgfoKgGmgTd/1?=
 =?us-ascii?Q?HACwn0odzi7YKKqJfazyYt9rp/Ik/SDHiYDYeLqCoP10yHQMbZ3nWhfFlgmh?=
 =?us-ascii?Q?upIJ+2D/svNvVUElIkbKzjTZiJHW/QGSzv7/XuQ/RgRyzruCv2P0+TVysITV?=
 =?us-ascii?Q?uUo92uZTg6chXnMaP6elHuAbukI83XWvYivLJYPf8QlHWqFA5IZIA+6rqKQF?=
 =?us-ascii?Q?gKKsEM4cbZEpngfsf0r9RMyBoyqRUyhQZ8G42hJ3V+xUzU+YVbrvKtsOhZkr?=
 =?us-ascii?Q?On/v+GPTFLtpwuadpkHUfug5JzVnKiGTv6Cbmns0yexL/nMVPfNqpPiAyBSW?=
 =?us-ascii?Q?RcYbEntDjClpnUR8gSKrcN4Ue+MKD7fdynb/DJRGtzadoOiGxhFUyTzSBoPA?=
 =?us-ascii?Q?Yt712dxigPe43qOOTyCXeQZOBpJztg+ZcpayWrDjXQbJHwV9qScLZB8CnDdI?=
 =?us-ascii?Q?r6Teq63KG3pErHm5c6a4d92PXcgEJlyQVFxvuPSIPeMVQn5M/wiLmWKRuAzv?=
 =?us-ascii?Q?ZHW7ONVKsGOHMrhB/fFGOc9KHL4K98yhNpb2nSxAU8TgSnaXDtohFXYKBeqH?=
 =?us-ascii?Q?GQeacK7R0IuHw+8uFBNawVXfCTZTnkmUYoqsaEB9w4/reVXekFk6Axc/JAuP?=
 =?us-ascii?Q?RILNZcZLGJalIzOtCBcFhiZPgVfhxJZqLaZ6/DVFQ0+uYrOt/6BP/KAq+F/x?=
 =?us-ascii?Q?IOw8qN6C7L2QcJsRZGnZMMEuK/qzQrm3L1PB5mza+WHJ22pCeRsYcjPb8a7h?=
 =?us-ascii?Q?cr0sJDs7aM/VnKILpAx0nlSTFeyKe6+tfVrKhnJGX6L1myCWWb92FAywk7xT?=
 =?us-ascii?Q?a3yowsx4Epp77nYHd/MbQWhxtDD7338kvc4N6kAXUfoP8UZp/ZXEs6VxheNZ?=
 =?us-ascii?Q?aln/Pzf3oYWSoN5p63aF5bwaeUOxIdeq3TYRvWTxf8UkMN/HinjG/el0NLyC?=
 =?us-ascii?Q?5ZhCh2cT3nHfuDjvjqCvxI1L67ej4L3x+/Fiylo+znjMMHdU3lDashev7A/E?=
 =?us-ascii?Q?qg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42c2318-376a-49b9-b826-08daa1dba5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 05:29:57.7313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDFx8VeX2RaejQgDj3xJYBhneL8SSPqhZAZedxJkBHeN52XRbNJf+sV/EEIDv/VNVipLWHqIzm2Cvh1moG28Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4815
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,=0A=0AThanks for review and response.=0A=0A=0AOn 29/9/2022 8:14 =
am, Stephen Boyd wrote:=0A> This email was sent from outside of MaxLinear.=
=0A>=20=0A>=20=0A> Quoting Rahul Tanwar (2022-09-21 23:24:24)=0A>> diff --g=
it a/drivers/clk/x86/clk-cgu-pll.c b/drivers/clk/x86/clk-cgu-pll.c=0A>> ind=
ex 3179557b5f78..c83083affe88 100644=0A>> --- a/drivers/clk/x86/clk-cgu-pll=
.c=0A>> +++ b/drivers/clk/x86/clk-cgu-pll.c=0A>> @@ -1,8 +1,9 @@=0A>>   // =
SPDX-License-Identifier: GPL-2.0=0A>>   /*=0A>> + * Copyright (C) 2020-2022=
 MaxLinear, Inc.=0A>>    * Copyright (C) 2020 Intel Corporation.=0A>> - * Z=
hu YiXin <yixin.zhu@intel.com>=0A>> - * Rahul Tanwar <rahul.tanwar@intel.co=
m>=0A>> + * Zhu Yixin <yzhu@maxlinear.com>=0A>=20=0A> Does Zhu Yixin approv=
e? They're not Cced on this patch.=0A=0A=0AZhu Yixin is part of linux-lgm-s=
oc@maxlinear.com mail list which is CCed=20=0Ahere. In v3, i will separatel=
y CC Yixin and request him to review again=20=0Aand provide a Reviewed-by t=
ag if no concerns.=0A=0AThanks,=0ARahul=0A=0A>=20=0A>> + * Rahul Tanwar <rt=
anwar@maxlinear.com>=0A>>    */=0A>>=0A>>   #include <linux/clk-provider.h>=
=0A>=20=0A>=20=0A=0A

