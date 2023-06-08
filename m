Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73677278AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjFHHXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjFHHXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:23:50 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2108.outbound.protection.outlook.com [40.107.114.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7F810FB;
        Thu,  8 Jun 2023 00:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jydKL4/h6/LYioeQgZBGGCvmVv2WMtwvyHJAC+hBuXomJU+rHOsp6QcwV0UjtHOIBbgGO9H6EJbsYpPI+oqC57+GPQEkr0HNzcwbJfhnXM8O7jPWBOeL1bAkkZPd6IC5Q4ugIwDxPu51ytfjyqg4ezzwLyMmSmYghiRUHDtGFcyceh8oMao9+zAROnWnPSPJqw1Jl+jNCJ6U1KNYUzu894vQDVCLvk3UvzHruWW/26FlRrEBxKwCz/+HDPDzqq7mw2JN7gBcdYVe0sORsw/tjr+Oe6JxU0oEHERlmJSiWh41tcVi+Q76On9kIKSV237P1wWSzuH2tBNGiUuIxJ/7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmRt76d0npakMjEUCox9Lpi+gNFT8+bBPSOUSnFYypA=;
 b=fT9dqIyOEU3t+wibMqZC4d6eiQicq9h91Z+lFv7LKH7Xn+sxKEiFjQmvnxjsg1KUqZCasjXKjzTWb1ED2/X3mQDP1+iCOeBsaE7iweWa3qPzzmiNaStGYOa4+JQ9x2CA5BTBvkCYklFCSy5/9sSIC9IsKvGCIgn7KEi6Xq6NDHzYAWMdEVrqC2w4J7h+3nDsPQCP5rCj0VnvdcTrKk5vCGYLnXgAQFVL8soJJZVL8mWrmP3p/QuhhdLEo5gzlVv5Bcn0N2RXV170ZOhiWjvCpNYMkZLhwqm65Re79M84k1exnVokHYwZXyHCLmyiI8BhwR4WS4SUlAbGk4CTmmC22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmRt76d0npakMjEUCox9Lpi+gNFT8+bBPSOUSnFYypA=;
 b=CcF2DXewGlSll0PfH9jT9Pj+PGMAqOmoZ4FA9PIq6Ciqh/qWltZgtKhBAujoXTX9lX76KYffuu22dVokfx1TKqKtjbksvNb3MgHqnA7AO0q50KDuqldc9jqxYumg7+5kKWHeXPOoflX+MN1qVWvrzPBYpjeydsket5tGnkbjnio=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5907.jpnprd01.prod.outlook.com (2603:1096:604:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 07:23:46 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:23:46 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: RE: [PATCH 6.3 000/286] 6.3.7-rc1 review
Thread-Topic: [PATCH 6.3 000/286] 6.3.7-rc1 review
Thread-Index: AQHZmX3P97oMAEjCmUabx+wsvuMwUq+Aad6Q
Date:   Thu, 8 Jun 2023 07:23:46 +0000
Message-ID: <TY2PR01MB3788F9576B1E140EC764D931B750A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230607200922.978677727@linuxfoundation.org>
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5907:EE_
x-ms-office365-filtering-correlation-id: d27ee880-aa9c-4e80-78d8-08db67f14bef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGe6fkuKoCFY1FHML9KhCMGGerU1QRNjPhSioURKNChtXX3J7HX5J+NCGL6fpBysV8PA9iaB/TfFozN+Lzj1ZTdpt9oxK1Pli6UBdB94g6CUep0QjCu6v2O5JzrBuVC18QbF0aBA2pgfldgWS5+spvFjWhDTq4Vwrk1AKnzlMhlCAUGsfSVuxD76bHT92vWfKH+AVOxEvw7ZJQQpG6CoFql7ZaRRSYl5JpJXX7gZhD6Dc//n60FzLBKv8SGA35Vvh03+5FspTuiYjUXtzFnBscDyACaZIncIjBA4LFqZ1DUVAfwml5vIlVxTUv6XwA+DAfhzNB+p3hDv9j6mXEbuzckab2XsWbXGmXW3TUOnMPDbual6FMquyI3cz5ZsGhC5QrcxkFGWClOCQIdq7WlZqrDLnN65O3s234k/4nPKafg/ZLl4WqOZzp1+RSWfu2N+eRvU8fxOW0lIewzBCtvWwbI07YBrg97mnzaMhUgoi1bDt7gJQIr9AWGB1bFzDxVcacDQNUGOfp4WlbDZ75a1vu10Z0k1RF4WtrqwWlLgHSB6lsTQKkn/82FFKxeS3nK6pYdK5uQz5oFhR1HW2ymFF8aNDD7KTZWhSl4XbwS+8/lrVaAX3SSqLu+1zBOSU1EMCoXZmrc7eyLw+Q2mlzLFTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(186003)(9686003)(6506007)(26005)(966005)(86362001)(7416002)(7696005)(4744005)(2906002)(71200400001)(8676002)(8936002)(478600001)(110136005)(55016003)(33656002)(316002)(38100700002)(5660300002)(66446008)(76116006)(122000001)(4326008)(64756008)(66476007)(41300700001)(38070700005)(66946007)(54906003)(52536014)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?83WVywbR2ipLyzXbGcVHSzJOG6cLUq2f2W7VrUpBzudXB/R3XX4o0FSzg2?=
 =?iso-8859-2?Q?gZMF0Yumb5vtOZNNWZCNZPLT2CB1svPZRT6vqiYy0My0IS7/fkpLgd68fr?=
 =?iso-8859-2?Q?/qlf/NzzytP9E/cRTBWwo5/GCI+r0dF6ne/NEPgS/x6ffWIUY7Mz/VAsOT?=
 =?iso-8859-2?Q?kNran31L8UlW/JsMYEmGwOrH5QZIqXpgSGHQefIOYlRuZKaZwUdnjaSGh4?=
 =?iso-8859-2?Q?s+TRhmsXWSnxXiqdgWTz1Bm75EtuS4y597gYp0HNVj2a/gI6RDxbngp58p?=
 =?iso-8859-2?Q?kxFz8BP3rI+cHzE0olHxeVA6hsI/BTBM0ZoKxUQ7sxuWgd1gGzYmyeu+1L?=
 =?iso-8859-2?Q?X4+77kselwVldAU97DcfQcUOjTmfPwm1MB/HX6p3sXfI79PQus/kMwQKTI?=
 =?iso-8859-2?Q?STuOo/4+wXxMAu21pucIxd79xNzMiOkVj7zJL50d3n/rEj9607szlOrdBx?=
 =?iso-8859-2?Q?8WlHJgpTRUUFOscCEB/7jQ3rEFIhzainVOKWY7uWht6UZOBjtYMWYMAQmO?=
 =?iso-8859-2?Q?kBEMcwP/ytz0fP0ORUsTVCxHp51yhkMiR7ZmHsIG9HYYHJa/UdWc7RiKM3?=
 =?iso-8859-2?Q?bk9WjgJsDv19B/xyiBKw47VvXtRF2z3jboly41n9j9q3hexlyr5P5sFLS/?=
 =?iso-8859-2?Q?Ox5FGXRTCuALwn1ViahZam/+kqOuufNXuC3miK0oI3ex8hFfxMK7wyo3iV?=
 =?iso-8859-2?Q?xMdJGj1DNpzxJZACo/uugeqPrZWBslw9ukGFU29LXnmSYhG2CcPUP1KMfn?=
 =?iso-8859-2?Q?A7Z9tKPlgUx44sHiyHZZqxuy3cbPDpS8UDa4ylmeb9zNlD1e/WMxBEfXTp?=
 =?iso-8859-2?Q?yHcY+1RG2thiePkaCSRto5jDoUeAb6jqdqsA24IiUVoduH+dPlkPoWqzi0?=
 =?iso-8859-2?Q?1OGWThBkA+IIfcfs1SVpLgM2JiHAg1jclthP6941uVum5V0b3I+6QZpSPf?=
 =?iso-8859-2?Q?TdOktjPo8Yn24wyA4H/oIQPHRLPCpGhswmi03gsXBimtu7/QSssl3RCAGz?=
 =?iso-8859-2?Q?sb42cR8GU8f5gVjDgh69wAJZWUjDCejTM+CbGyEvwuT2WjqchkmLZ4Fpcx?=
 =?iso-8859-2?Q?SL5dZTYOdqoVUqG8pgBN+CRE3Bf6wG0LW0BLTGp/qhXCFe30Q0vJhgzjK6?=
 =?iso-8859-2?Q?l0TxEyVdzdYmU1IuVMirPcj+9wBcZsUDsAQEVmFfvoOzRFBAmlTyxJmWvJ?=
 =?iso-8859-2?Q?rKIjqD3vqbKCrMMpby1GQPeHIvpHTfR5Rfmf7TiZS6XBalrC15xZ6HNz4o?=
 =?iso-8859-2?Q?fbd2ZlLRyo2Osz3917pew/4hwUkQs9iEsLGNokWJFJipX4kkoqTfmy62cn?=
 =?iso-8859-2?Q?4Gj+2hTxGGQktXx4bu7dfMc3fVyzWVmf9d7k8fT7/QJEI8G7BlEHdPw060?=
 =?iso-8859-2?Q?9Kur79IsROzdu9Q1S1PC7KKA6sZaxgCa9WoDwzYPgIHXWH7xRHQ+kSIOph?=
 =?iso-8859-2?Q?IDOn36dRo+26qxLtmVGiFeIZRvdZzcQ7S+POkIw7wFU8yWSjjYUkXFGNie?=
 =?iso-8859-2?Q?mTmHXg1q+UrNHlVR9MNJyWJf8lsWWDJMqjp7qW8e+o1b4bnP2LuEPdzo+T?=
 =?iso-8859-2?Q?hU/Ydk5kp9bSjyuhpiEOrNBknkXnxKpx9iEgaPTb+D6mK+1UBSwrKMeY5Z?=
 =?iso-8859-2?Q?dKx8MHbQI9nki4XeiCC+BLPBqm39yppHj8mLQMvLLEmnce2iN3hRoA6Q?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27ee880-aa9c-4e80-78d8-08db67f14bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:23:46.1725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BZaI9y6y8zzfKTPB4VAweAVbLd/t1vDwHBb7DbPZjD+z9Fgl9h7K2X2bFlm8A8GX8F76epQ1D6AfzCJcaXGSQnhVAD1yE1TvN13X9jJVV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, June 7, 2023 9:12 PM
>=20
> This is the start of the stable review cycle for the 6.3.7 release.
> There are 286 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted okay with Linux 6.3.7-rc1 (78317e11fb00=
):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
93073623
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.3.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
