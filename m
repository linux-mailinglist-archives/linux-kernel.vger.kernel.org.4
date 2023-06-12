Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5172D388
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbjFLVv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237906AbjFLVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:51:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2093.outbound.protection.outlook.com [40.107.113.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F44B19A;
        Mon, 12 Jun 2023 14:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyD/xraByI8tlNqxEKx9rQecB6DKCxvfZMoofoBWs2Yoe6VHtlkEvUBKnPLdIBRSWNd0sWIKBsXYpQnhx8KWQaK1hjrUYStqN/4DLvxcENflTk1Q7qON9ZMRWAU6q9IHWJbR5Dibn/ZMhGdhjY4vDF0XgGKTUIaj979XevR7yFoypM+xTavec6nn6IDdvx0zArRS4eRR8A2kF1SC2ye8z9Z8BWsS1ZmHexBhcQ4dIkWn4R3vef9o/Ti37gtVZUZf7PcNouZMVJU7coWsvPWm5AZNNIca2hKUJA6la7BqcZq6c9/NyMW23vgVx4oBOcDZ62MHA+Y2yE8DfTW0xjBOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zbzt2SKOS3u92z2qxHcRSTiGKwTBgcFKgbDHhlwEUhU=;
 b=XuSy25F3r8uQXX3b3PWtVm8qQnkBSah+1hr4p9xp9ivAHjYqKTKPphfybxhieoQupLTnr/8ofenH4AEz+AuhzU0k6zdfN7HmVRPXG4Bx/D+ooGrVeN0k0tpV2sWAqwURWyDbBnmHN2d2HRt2S5+IOECLYc4wBtWbhXumdCtP/l9hqT49wZ92xeYcPDRlr6O8mGSmNiWbDz7ye/CpW4CzB9prNMi/u5Z64KQ5DPIg4uu6us2UoA+cJeRbihiSjetd5Cv+5x9ZHdBzmnulUguqA+FuSnw7yi6tQFsxDnbZoOu9rTmiJK1gFQUGj5nMY9kCBIfpVsWQSi9Q1YjifDzvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zbzt2SKOS3u92z2qxHcRSTiGKwTBgcFKgbDHhlwEUhU=;
 b=Pg/yUJFLEppavDENyuY1NvXciAkeG2I5cudoVp7U2T1soewcjDRzkn89jI5Da8P5/q0+fBeHL5gqOw/mDGfN6Vb/U/DSvT9hA8DvdvNyyvHPBI1ttktebpawPCJiH8+Upxn/aa5Tn1BVHmUQkFexcPmdle8RYavSuVLwOfkRJlk=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB8680.jpnprd01.prod.outlook.com (2603:1096:400:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 21:51:49 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:51:49 +0000
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
Subject: RE: [PATCH 6.3 000/160] 6.3.8-rc1 review
Thread-Topic: [PATCH 6.3 000/160] 6.3.8-rc1 review
Thread-Index: AQHZnR0LvyE1z++AdUGcEeNuhIa9vK+HtQPQ
Date:   Mon, 12 Jun 2023 21:51:48 +0000
Message-ID: <TY2PR01MB3788C98ADC20EB1905998201B754A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230612101715.129581706@linuxfoundation.org>
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB8680:EE_
x-ms-office365-filtering-correlation-id: 0f6a1673-6bca-43a7-43d6-08db6b8f3961
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5/zwoANRQo5RX/tRd9Oct95mGNT+QSBJ7kEykKd8J7gI7z2tCviqjiU0f+bWvdzwAxY5ZPnrLba3O9PRf9oThSPiH4dwB46ySTb0bcOHh9bbMx6j3s0E/ZtF7EQaktoXV0WTPZnWkeFziYlrJdCC8fSqOpOb/l8gmy8yY0flNbMsSvtl9xBwhI6c82ItuLp1snV+7Sq+eAss29qBzPMRO6YuF4eGq9SCNKfJu3YP58sMitTG4vLK8/RzPuUuzmKUmC9s6kesNYXfs6b5lmDDiyvr0fZWWlPTHN4LRVu21Z+PUEuXusGqHwB5PupzhxW8D9IBbzeOVIdoYzOV/ZJupnzU5hnmu2/X+WH5uJEB8q8salVyoU0G4CrgNZYfJdtY4Qkg4TU0WTzb/Yc9+DE2Eoh2C5adH92JbDMNNmRvnhVv+0u+YqnlpHodK3IoTBCojIXRbyL6QnzUsrwXxrN4Lm5P1Npj/FBKZWiptAj5T9TRdex+ystWh6mlMnugXHrLUZkbaz35dKTV6GkVl5ULTk7cjWl8Fdp1odPDr51J6A/B5IF/BjkvrobKugxfCJOw8Ai7bhafq9uXTxtNs/ztOOt6MI75OEoQz4ARCQrGvCQqwTXLqGfFW0jjWRQYfQvNDI/QDsLr9pZdI8lY7pK+0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(64756008)(66476007)(66556008)(66946007)(316002)(7416002)(4326008)(66446008)(41300700001)(76116006)(186003)(4744005)(2906002)(110136005)(54906003)(478600001)(8676002)(8936002)(5660300002)(52536014)(71200400001)(966005)(7696005)(6506007)(33656002)(122000001)(26005)(55016003)(9686003)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?6tOFyGo8/5UkS6CqTzYcl3x+LLQkoiX4LCEZOjGuTKuavYnUb2VNCNQe?=
 =?Windows-1252?Q?42Bd7UxOHvkjGpaKz65S71FKvni3TRrFo8hb1kOHVP67FbRop8+jG/28?=
 =?Windows-1252?Q?s5U9AW81tZk1W/7du4iKAW3+cf7FlDrBrkY7iTkVxGhFSR2Z2IWHctbH?=
 =?Windows-1252?Q?BIXa83dhdQXw31gDecjuzQ7c4KS94CoRo1we1zFnYHhnyA/GVDQgPHK5?=
 =?Windows-1252?Q?hboC0lwodH01QFItT5eiVmr7Ha0B0wC4TIpj9EFHzXWahdENujix2MvP?=
 =?Windows-1252?Q?WWK2NCWM+zexKHlQf2G1iNEo8giK69h4Y5pf61tBdXNDji8DtaDUrUgu?=
 =?Windows-1252?Q?ypjfzMaOxK0Z5NpiZt24rUrEWMQ87J8F5oL2jk120FSLY44J2GjIlJ1i?=
 =?Windows-1252?Q?97sxPjBjtQK+3kT5jfMfAYso2SzIBvLQ+BbCt8zNKu/MYb95IBMAcQ7H?=
 =?Windows-1252?Q?q0tdDp/L8VzrrDq0a8+3itSJ3YctWAj83WxWDuznVqOEYEbGwbSk5XVZ?=
 =?Windows-1252?Q?zlqb8WaWseA529fVgmum8eZN6XKBrLFcubhM5KgKt5JFObl9QlUV1joX?=
 =?Windows-1252?Q?TcQ0Ha3DtQRqt6nQ0x9BL0MsQG1KUYF9gzJi9RVlvvFGipA25OkqYwLz?=
 =?Windows-1252?Q?gbIrUfJrfbgaoXYms3OW3sULvz4ZPW3cpeMi7fYl3R9poiB25dGCnw1q?=
 =?Windows-1252?Q?ZnZgZKYo9aolWc+zNdwgJGx4JqHnA/M8dSn9vMaRdAnuaTkFQdY7GCcU?=
 =?Windows-1252?Q?bRIacmP5JGpk+CR6SVVlzXbWt0kq5OwtxtFKbPN5imWHJsXkJ7xJAY6F?=
 =?Windows-1252?Q?oXfHN71f6U6xfPN/1k6ntrO/IrRlG99CSgx8fsic22vC4R23WftWyaOp?=
 =?Windows-1252?Q?dm72m8T972UH+y/bGZqXRL/5Erx/tdRt1avJSZ9IOZNYoWggMGd4pd+9?=
 =?Windows-1252?Q?ZqIT/NoyDRCpmuY8SFddzWgSiapRn0CLr71PRwWUY7hA/0+F7XeT65Lb?=
 =?Windows-1252?Q?T48Ww5aFTtm5mjbUhcnAKqrUO6EkjoaSaBr1U5xKH6zWuSYVLxql81Ji?=
 =?Windows-1252?Q?BUcQMrwQjhQwRIaiL0wshAUkhnSQCeMjaP2KVGdp0p1bc19VaxyeJFry?=
 =?Windows-1252?Q?XL0JO4bZCPt33cJ7p2YPumRBmGqPY9Kkac4TAH1ZW1IeJtDhWu1yT7qK?=
 =?Windows-1252?Q?ESOS1R9Psln0gmUPnxVjUR+ieiRZn20UImTbMDO5lnzo+TOeUX8coQA9?=
 =?Windows-1252?Q?Ltr7Av06u95SgU6sF+3J5UCwC0tp86oEJYQFdFsBDValUPHs2R3GYLih?=
 =?Windows-1252?Q?spAx3RLk7TTMvfcBB2834bjDrTg4FxeZLrn+4qEMvpDs+chZZdv5uHGX?=
 =?Windows-1252?Q?jyxP3mp1Z+6+aLZEbfBYsLXq4IwXyGBpq5zWvZki648mIo5Ev0Atl40x?=
 =?Windows-1252?Q?tyc3+u3xyhzH0wKDxZDWvLwga5AjkSjxGzqZy9uFmLGvL/FZ6mY3oV0k?=
 =?Windows-1252?Q?uZfZaT5PUZrGLoejs+T7koChl0tlc6QhX0XMWkwEiKhyPysMJSOYMeMo?=
 =?Windows-1252?Q?hXbzfe9AoeDMnwmyorcQr9zn+4rXhGcZ/ilZue9ZkL5YUwaQihly2Vr5?=
 =?Windows-1252?Q?5eT8izUWUJzbpKiO3SywZHeWJJ0f+PLmxv/ATjAyML6eLXUWDpRphGBP?=
 =?Windows-1252?Q?v4RhdNdAlLt9FiLq4BJnWDDXX1EvVwkQWYgcUlQqDs4kzCvuwHvzPg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6a1673-6bca-43a7-43d6-08db6b8f3961
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 21:51:48.9995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agS58GeRh1NHoabI4KfZsG1RQvj3nXalwCEcm94y7wjzy5IZE0FEU1wqXBZaj0QuB4JlMPNPwvsUFraz7OGGU+HtM3pFW/ZvT1LpE9SQj/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8680
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
> Sent: Monday, June 12, 2023 11:26 AM
>=20
> This is the start of the stable review cycle for the 6.3.8 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.3.8-rc1 (718be3905b8f=
):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
97025257
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.3.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
