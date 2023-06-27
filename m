Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B846740443
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjF0UFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjF0UFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:05:42 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on20711.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFBD26BC;
        Tue, 27 Jun 2023 13:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFRUBQlCVOZYRfHMeGQ+lYCQX0J8P+fHnuoR4FTr8zsmg+sBcZEWUrZX4jxA6a2jhPWdae6rZqqwLY2xfYTQjxn08WFXzFFSTCM+ajqlUrAwOfwnEgM0VvvLCsSCEntkGbuIncepCKxhtSyfwE+eU9JoVh1ipTq9ZEvI/uRQNVPnWL8AQ7txW3avRjPXBfKzgf1nb7YVDetIN4JY+VxBuYZ0BRn5jmaNuToAXirx02BaG5fQ9oZKjX1yrkMwU7KI9t8RMNedicZDeZKenYo6bAVG4wpAWSUVpEkvzKMnbSh1v1PzrmbLUesd8rqXSaI5ova6dL2LM/tW3OPaol8ewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3AbTeQtC1QejRC5U7qZz5+rbEbwcBlS425Fqn8XUGE=;
 b=FfTl23wsIMH9GVCCBL4nYvQByAXG5pBKfR/rmtQt+++12+GoUFInfylECQYmgWbWnap52QIIkgd1SxvlClc0by/fYSgKRfcuTaJ5me1hkvMHh0XVuAsBIAxwBWcXFhbPNJPdGLQD1c/rmKG6MENvbfy/9QLXd6oerJUwU7AaNHZ0pKGH8uoSQWd2t1FUACvQDSJZqbWHP+8z5RUiTwy51Anr+Tbg4CUl7W9A7QzVExldnX74Xd4kWZEaoGe+82vhaRU4SWvbvB6BrAmvZLVdxzc2a7ccwHgvJx8JDd+Thd+fT6OhZ9S1Hnj5jXmGxN+CCdaQMTrgDdn7SaEAe4wZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3AbTeQtC1QejRC5U7qZz5+rbEbwcBlS425Fqn8XUGE=;
 b=gWBJrmwPa0Wpf+9AQTbWGWQzHeEgunXEWpw3+D3e2wgNRWvDCy6EW+C18/alOGeXOy0NZVtYHABB4uUbXG/HEfeBOHkIcPRMXfdxtzqMQ7JQXDsGYYhZaDS/xfsY1bPbxm6283SFTEHh8WODBYi5ictcuKW3GUCZdzB1N7BmgYM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYVPR01MB10876.jpnprd01.prod.outlook.com (2603:1096:400:2aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 20:05:35 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 20:05:35 +0000
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
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>
Subject: RE: [PATCH 4.14 00/26] 4.14.320-rc1 review
Thread-Topic: [PATCH 4.14 00/26] 4.14.320-rc1 review
Thread-Index: AQHZqFotGV1i4SBfaEKJiqDkPFlvqK+fD4JA
Date:   Tue, 27 Jun 2023 20:05:35 +0000
Message-ID: <TY2PR01MB3788A6767605F34226EF99A8B727A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230626180733.699092073@linuxfoundation.org>
In-Reply-To: <20230626180733.699092073@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYVPR01MB10876:EE_
x-ms-office365-filtering-correlation-id: fa2e1c0e-a953-44e8-48c3-08db7749dec7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GswTQOpPzDMKZPwNx6lnGAuOqfIfyI9UOMeyoMaHKJAxw+XrTShxhrbaV2Yx4TpCVphifpFlVWohyHJ8B3MbDbGNWKEY0bQbKG2zAm9ZZPZM87jNehV0kVHp0rmBJQj0JF2/JVa280ErPFKokzdJXjpiLtzrEckWAy0ptpFTt8ddQHO8OWtKTxLOEHsqj7BDKQUEXNmFu7QmZcVFUYldtSYN7j3qblXyAUvGwHDTxRU91oNChS32JMyDMrf0C3pxfARHnshaKbmFPO0SudgZ5yHPW99PE+zyujjCHZBV/s03rdhJGqaIZkevFB2mgVHaaQepJwMthFSVSNHO6uQAARDm4afkIJXv872BQ7RPeb8xij6XONmnHR6pr/6b8ORLjMu/jkuL5dyvwAhIpISItPyFBNlFNGW5el6AbrdLBXh6fPEV4VjECuos7xAImIehHQckTazVxGia0tDDTC0drnShstOSbBwDgU5uZqtTH8OlygidYhpQzW4txHYz9k2aYgZmdu0L+FIYwzWTaDdBmV/WaqdBUTZDCSz6XNwwQQmfKbEbW9+f1Q+jKCPGecVsROWs8tIRxDqARNbAaz/uzPY6zFSpcFU3M1kD+4nJPDJx6wQ3hBjxzuOLdX4cLUbOQfhUg0ocT649GwW707TKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(8676002)(66946007)(66446008)(64756008)(4326008)(55016003)(66476007)(66556008)(41300700001)(8936002)(316002)(76116006)(6506007)(186003)(26005)(4744005)(966005)(9686003)(110136005)(478600001)(54906003)(71200400001)(7696005)(5660300002)(2906002)(7416002)(52536014)(38070700005)(122000001)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?sQ38/COGGwuOMtPeIvF6PbZj181TwvK1HyMiH/50V4FTKMVYag69unto?=
 =?Windows-1252?Q?DvJ76MfrfeTlfutGPuErGS7iiiTJ2aUiHIVUwQZLIZVUKlJ9GW+wL7QZ?=
 =?Windows-1252?Q?yyciJsOYxfVBUgBtcVdc3iZxRR8EbTNBVnu2CAhzmOoqw2neqm9DYPA6?=
 =?Windows-1252?Q?aNHVjGNqLqbQHGJC94bnB2di8cM8xWFo6u7nSvf5/bHRuBhwM9GFqs9Q?=
 =?Windows-1252?Q?PzJZJkRQEWEOs/mPGVs2hmQ1gjZ0fzRgyLf9YwXtYGN474h8I+iNftOn?=
 =?Windows-1252?Q?JYx1FKaZR8JuxTdepyuQIXVGyB/iE4syStHPRTG/afGjeTQF4H55WvxT?=
 =?Windows-1252?Q?O9nuQ1QBz2/FKOETlv0Xcqhz+Cmpzetkwq+B0KbN5qJ/vpwnMRlxpEIC?=
 =?Windows-1252?Q?R38cAJGVtF/KUvDuUZKHyQJtUO6rKk9i6B8VkIvc68YOqzPyNdY0B3PW?=
 =?Windows-1252?Q?FNJIHHk4eSNvY+FtEJLShw5xS1XCGWJhMC3JeXvlW4Vkud9tkt8O/ay3?=
 =?Windows-1252?Q?Zz2QtHKI+M6JSuBtpLmf6POrAZNtutqBHelMx9JRwEQhXHh2rD1YZbQD?=
 =?Windows-1252?Q?XHeAsMrIaCq3Kq68S6daMV2wfVAkbkzvtEdeXnIHOK8mX0kT2DClGWgS?=
 =?Windows-1252?Q?GPsmE68g7mA9uwSW7Zks1Uk/TDBjrkESg1AB5qs3gGZQp/xJQvsoWpMe?=
 =?Windows-1252?Q?kq2Oal/xGTF47xtr69PLiU660V8JkfKWLDfFH1tiUimYpbCi1DAFtZ3W?=
 =?Windows-1252?Q?OZZkwRgn6WWFC6wou5FQVYXrrfOW01dZnByVqx2jZxpOdL852Tb04+Xl?=
 =?Windows-1252?Q?qjG3P31a+NnZlcEIw3MSQR9exOLaK63MUua93dAVzWcQE56rUY5n5WRR?=
 =?Windows-1252?Q?lNH5ouPPWLAeL5abYm27WvdN//ReDZWgETV0kW0cmt3NaZa0T1W5f46f?=
 =?Windows-1252?Q?aQYqe0ziOk8eDsHas3fCfaLtqtMvg/0CYlVwzXevema6aQwhWN2c3UvY?=
 =?Windows-1252?Q?Me0ebSD9n683B/AX4gyhCRugTlus4EWzZKdIJPIUkj8NSsI3HXCGEJTq?=
 =?Windows-1252?Q?SJqzE/YuNs3X8pXAwc86pL5A2LzchdU9AcSy2x2xfCQTzxlbkSSMh+zq?=
 =?Windows-1252?Q?AOSCsAqsq5qNqZVlF+CvkIWTzOw2IpKpN1ArUA5qq1hNaAXZ5y6kcttx?=
 =?Windows-1252?Q?kJZwlkZ6FhP8hiOgn8ykoO/B3S3MQbwg4WLs+UfQazub0ui+q6VD+cWN?=
 =?Windows-1252?Q?Ec2ghRN1lJwx+oII+WJmcEanWXUqwWZkTL5/uUvAjBxfljLVS0bDKq3c?=
 =?Windows-1252?Q?zAaIYMN5TyAwlFDVyT0kCw3RsRTuGiywCTdd3LAFbR83fCm7bVyDXkkJ?=
 =?Windows-1252?Q?gKH/dQhRnsQdBVzQGKugNjZ7xIRAOaVUBMstXn0RGDzW3EzHuID2bH+7?=
 =?Windows-1252?Q?68RLRUqI0157WVGIY7TKbp9C1zJq+gtIzhuqk+CRvtloXXNOV0yDUA6x?=
 =?Windows-1252?Q?suCrtOe3xEjHQWYvL0cr0QRYJ4gaeTSKrmY0Yb1G9KpJxZxAe1xKDSwg?=
 =?Windows-1252?Q?J66Y1RtHteVft/5XyRE0TmRlM7Rf7wvHxmCdHJKfjNwVMgm8J98Otg8q?=
 =?Windows-1252?Q?LIUfSc82Hg1k9IFTp5N6a38vBVcQOfZQl0CWtmXlc/vqoMq52QLqUXxS?=
 =?Windows-1252?Q?FRlHx6a+BnKfNw/P9p56nhCcKs6S5j2hbrqDNjbVf6jxueMJeMRVXA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2e1c0e-a953-44e8-48c3-08db7749dec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 20:05:35.6973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyMixs1LcOVX23wO/5FV76fSBHHZOXnPSD7Uyz4dyAFLvLCmt5i8IVE3QRTq9WkkaVpXbd5EnpcitZLewbNd6H3rQpdFISJJWezJicTtVpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Monday, June 26, 2023 7:11 PM
>=20
> This is the start of the stable review cycle for the 4.14.320 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 4.14.320-rc1 (11aa1c269=
7f5):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
12373156
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.14.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
