Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C799D7278B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbjFHHZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjFHHYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:24:53 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2128.outbound.protection.outlook.com [40.107.114.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E3E4A;
        Thu,  8 Jun 2023 00:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQqEcstw/LfJtr89PNdook4/QjT46Bhxedw2NIZaEO63BKOahi4obMbTKM2Sgb6W9YWS/RWUBnPGdyXhWzY0oBMv3LFuR7/TxBOn/CHS3w0yWOHjadbRGOLs7b0LKZKZEy5Byo2kCoT1k1axMKheXdysOB89Z38dQbKZvJ2UG6rQaz8TH+g1ManTd9hGHteEp2yAOudkk8kai/PSdYQeHIqe+Dpbw22nsEEkBD5ZCr7oSxLt8B/w1RvJQMAgEIjJahZIgTZCH5EfjAYO+LGKy/N3mytdwidI8lnyEldHFJBcrBHtRttSKMnc8q+z4okO8pde1YK98jZoz4nGgOsDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvBl7vszmkdxtB/G/BwrRPAkZLe3yjtIMMX4yL1e2ok=;
 b=h+rRjtDbEfA+7YKbEvOWkn46I6vvUSjo4J8B6OjPILhTUlkYKkW1fBJJtJ/dyr80SnJR97c6igIMWhOHzdfNr3VURRCai0aA4ttAMRjOvyn/rE/9ReyMiHHHE8mcNUOuKUNOCdfPql6yauuKv2VTBoO0adfMGA+9Q5KTM01614Kzk+LBMKRsksR9L2CIrMkM2MOHV4Fw6sMkdJlgG2HyQAzTTQe0DAYnWax6QS7YQuLKVw9riSap4et8n18tiVavQWULIsfdtrUPAIk1wIAR1i9cmZhGH8HKhdmqfBiWOPAYV1i7V4FSftIZzEZOxi+BnhQ2PQNUxLwvflUO9fQPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvBl7vszmkdxtB/G/BwrRPAkZLe3yjtIMMX4yL1e2ok=;
 b=bgiCSKT7hIRvSWsJK4DhBeqqv0iGQUB2mdNFO7YtHwiYmMI+/ppPok4dVkibGxU5bWDYubSR+J3SfqbSbYMYm3sdcxfa2oUHfOhVK1NVH9i3ejGj/ew7F+u/y7iE/k+FRu0hBezNfpsO6e9n4mBCQIParNgU8UM1j3hrE2LlckM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5907.jpnprd01.prod.outlook.com (2603:1096:604:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 07:24:49 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:24:48 +0000
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
Subject: RE: [PATCH 6.1 000/225] 6.1.33-rc1 review
Thread-Topic: [PATCH 6.1 000/225] 6.1.33-rc1 review
Thread-Index: AQHZmYAVASJDhYSmwE+fmLSrT6MUMK+Aae4Q
Date:   Thu, 8 Jun 2023 07:24:48 +0000
Message-ID: <TY2PR01MB3788FA9EB3D8EAC669C3F623B750A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230607200913.334991024@linuxfoundation.org>
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5907:EE_
x-ms-office365-filtering-correlation-id: 2cf49975-0eee-494b-c965-08db67f1712e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: daD0ojWTpf5f2xCLnVLOnfWv3U0gcR175iND7GQ9Ffw1oY4lb5XqdCiBFOx28IEVTjBchGZj+eWQ0bxcyeSWmKbYjZ6dv5ZFLTcCc9QFmvgcvdV9bYCrb/8hmiPB1WGbsqkpfpS/RzaNr9J73IgfrIqoLXPEL9041gYfgel1vJdRNwMkIy316UezQbMUSAvWk9/gcYAMJwZBDYA+Y02PkiY0bTHVTQ8ATDmqYbGNyb+dTbIVPeWYs6ybba/AaakKd62cVMIG2y3uz3ZSzhwLI3MXC+uAVVUvDLEwfVDMj3eto0MR67bJBqjqlGQaVYWWS2uXYVhCR6Qje4LBUE7WqYi6dIED/BrXLLpZzK0StKP8OqH9YtJ+ZJY3aKiMWV+cEcwG4yYNyT7fd7YC8wIYXiykqKjbdkLbLBjxfC6ZdgUE7VWukS7smKZaLB+ZCI8HyTDRNFSJ3Vf8RSHrtglV1E7PSAp2kf94QGdl//awTzweeXF0lgBTdbmj734x0X2QkdzbLMFcZ6i8qyadiNFDWWaKiTHsPb+Kuhazq54iQpMzAOBjLQ4CBeuX78QiZFgBCzrFzNMV+Lmp8YCnCF8KEXbBID2XE46LAgpHFEsMrEktUJHukaQqDisgeOsCcGzg7vyK09Xhb1wZ/GHI82LFIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(186003)(9686003)(6506007)(26005)(966005)(86362001)(7416002)(7696005)(4744005)(2906002)(71200400001)(8676002)(8936002)(478600001)(110136005)(55016003)(33656002)(316002)(38100700002)(5660300002)(66446008)(76116006)(122000001)(4326008)(64756008)(66476007)(41300700001)(38070700005)(66946007)(54906003)(52536014)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?ig3Hn+2v36GwgzMHQgx5oD2ryJMtiJr6yVv3ysdQNbycCEKX+h/TqHNN8B?=
 =?iso-8859-2?Q?oxj8Jhrit50f5nZhtfkTp7PddvsYAzYS68j8y0age/RVdiuv2N4sd488Sq?=
 =?iso-8859-2?Q?8ujFDmUCAn80zYOXkFwkUMdMhClMCnUjm6+7rNIqbFC2/PTxe6k3fIrZVv?=
 =?iso-8859-2?Q?TTJjX9SoRz0kkEuq/6HE/xsba2DxtaXOfc+28IxacYQw2f15cXmohH7oh7?=
 =?iso-8859-2?Q?i3JVOiWhk+TUPlzt6tl1d13V3xMImCO98Yrpp7Q70SFkpM/ehSC0Cw3nBv?=
 =?iso-8859-2?Q?3XzDzDAVDTpPh2JIweUUA+/ThTq6vEkjKBpPy0kblX/JJ0+5EDXHw/ys2b?=
 =?iso-8859-2?Q?puwQGiHJ2MA0K4/jFSCMpIu8WGMiYx1BhhEizs8svy+IkzVgvxlFFxxKag?=
 =?iso-8859-2?Q?xvnVxEga9MRRT5YFVs/8UnGzOF3oCIcDSJSjnJ+Ds3Xw2VOtjXcVM/TBEK?=
 =?iso-8859-2?Q?3LTcTZiNgM4KwVPwePZmjiku1kKpmnAMjw4d+Z/ESxvLEcQzlxyM3f9itP?=
 =?iso-8859-2?Q?73G30PLL/Z5T4x4MgIxKleH0JlXcGisZ2U3ooxz+pnxzziQhMy76ePpnbo?=
 =?iso-8859-2?Q?RJ9LIxyqCQ9rnmpi5iIfTiZTnxaErcYnaVjsr7D90HZCWwkwZW0CyfaMbx?=
 =?iso-8859-2?Q?Tdw0/AN7xH7ONprfbctT8U0FIYJ0OrPrhKcKFSldclRVSPWqNiiJBdzeon?=
 =?iso-8859-2?Q?X1PKSPqChvooARB3zEuErUbR2KVSqFmXP/mnNLrtKSlT30HYzS7oym98KF?=
 =?iso-8859-2?Q?qqaDVkNMjPEq2C6SE5l1qDRLlXeCkUbVFA5vmnojWRtVjjpTJ5/vnLlo++?=
 =?iso-8859-2?Q?1zPsrn6cmxBJ7hpBw7akyVHRGw8zJGhki0JHgvIAt+DzmIFbT4LzBO+zNA?=
 =?iso-8859-2?Q?N4kDuRHFJEP848OlI7VmqufjARxBV16VXTnJkE1FrNhMSGaCy5wnBVVssX?=
 =?iso-8859-2?Q?FWfLSdExXZztjd1gSGbPMA00QaJDCfBBMsg/F0v0CIc2EnWOqnuvKn1DCG?=
 =?iso-8859-2?Q?RrT/5Z8GwkwiJBXY/fbvxiXHv9Qqx2AKQZ6vIsKRyMcdS4wUOZx66Am84d?=
 =?iso-8859-2?Q?c07R5BUREcDDp/GYbCei/S3DuQkjXqFekRH+3k5Wgv9szvarx+pEP0hdTq?=
 =?iso-8859-2?Q?4kJS38Xc7sdUtuLUS3ctx/6EZgh7K96JOaLbtbORemtVZP8Mm7tijMs3W4?=
 =?iso-8859-2?Q?/CaNgj9nkg2ZZiCvqE4VK+8hvrhkKr0WeBZVcdd2al5f2K0NV+RQfIDpTd?=
 =?iso-8859-2?Q?ipYBrRPQHeT75dhHISBT89d6nMTcINNvFiV1QyFkfkx0M2cHyc6WFQxhYv?=
 =?iso-8859-2?Q?812UaZxWHJZXGVDQ/TWjotR9nAcy/jbYopV2w/w2d5uYal/hf70It+zhT+?=
 =?iso-8859-2?Q?GARnFkjcsZPgEbCFXojPnH4pLp9+KcNSCfe500XZ7VxMI3OZu2wmAoadrt?=
 =?iso-8859-2?Q?7mkPbuhr4wAZMBPRnOwTGdJsZFR4EzsAy4wmFdsJcFQoKcVoC4UREX0SWr?=
 =?iso-8859-2?Q?MaxQ4b8URnag0PXJo9fnPqWy9uMrWZerM5XuXRXmGqOU/w4i8G0JjBNn/m?=
 =?iso-8859-2?Q?+5XISC155KsKDPqJ7bK/PavuXWErkMpobRoF2rCFSTB7dlO4g7wCdlRT6/?=
 =?iso-8859-2?Q?BET4L9zw5cNp4/BHLGNRCojWPhDugBT1fGYPoCMmlEbrjMwLfpZBhkmw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf49975-0eee-494b-c965-08db67f1712e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:24:48.6220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTT/32Supd8wfk/aB41VJN7V5e/q05ZEGaHv+nebZYKDiUFXtnmK4aIoRoxLtcRAi5+6J1Z+vxG2Ip97/Yz0gnZreYr1Zlm2S7pESbALkhw=
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
> Sent: Wednesday, June 7, 2023 9:13 PM
>=20
> This is the start of the stable review cycle for the 6.1.33 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted okay with Linux 6.1.33-rc1 (8f4f686e321=
c):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
93074084
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.1.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
