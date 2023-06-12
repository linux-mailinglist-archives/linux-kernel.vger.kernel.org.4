Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3462F72D398
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbjFLVxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbjFLVwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:52:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2132.outbound.protection.outlook.com [40.107.114.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57832E77;
        Mon, 12 Jun 2023 14:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnQ1HcBbPMtpM6t6sATiEgRaIYsNjMx/PtIl4woYlCTt1JCS5yCNLuRcZJziO/9WiJawxN5Fyahjkvv4Wkf/pv+sfPdERyRFx6RM8+9Rp3+Z8o2IPNzJxacr6OPVeE3sYbnpLw1JqkvEnKXPWH+OrqgrYculr9XlCOE1yH/mxCY0Wh17TWxfZ/bO8UhyVilx8JSq14mAYFTSd4dd/q5HqqcQEz+wx92PjDthGd8/faaCtrWcV27ias7+E8IZwY7wQlO7fcdzbsbr2jqe+t2DHCcHzoL7g0xK8Aq6Vr6khEkokN0MnUDjqsl6NAG0iGuQO+ee0niFqk2FznKt7uamrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hh3aOPfO2Attc3UIbMcgrgEzmyYKB1Kvtkd7bKeDNKk=;
 b=Dolsph4NnQMfVHqlzBcvLl6DOFgX/YM3Pr7OeKDdqIyYz2pe505E52zwPg8zGfuqLEGfv+z9vEECf9444F7zGt1Mm9oDKlEyVR4DTGJTXJl/PyJf9193pO3LSSVHY2baPkbLL0hmUBb7v1QAn8+Nrlywna6ahgOkxZKZ2l470jYruWOucl1SEo4fXAVGIHqMaVtrBZDoj4+iwufKhi5JiG7Ik3B+3Ds76oJSYMelDQ4s2j+IXF2rxE79eoPl/Hi04bMHFMjSmZzyxtvNlEkI5336AGeOy/8b5h5tstkKWa0sALgSMGpxWM4ulmQ9cTimXuGJaKzSNnd3oM7Mx6dfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hh3aOPfO2Attc3UIbMcgrgEzmyYKB1Kvtkd7bKeDNKk=;
 b=SNO1onJ7R7I7uONsdTSBf6KvGWrZkvvv/pqVE+lRPgVYwzmd9fgdGzOHKigYkMajmF1MZ8QAPjOEdfHJ2yIfPQFRnP01oOWzXqpx4dN7B2X1so8WTCisoCMca/Eg7KsycTe6gGOkFuRnlSQ3ABPyimI1rn5SzVVll2Sh3zxcce8=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB8680.jpnprd01.prod.outlook.com (2603:1096:400:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 21:52:35 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:52:35 +0000
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
Subject: RE: [PATCH 5.10 00/68] 5.10.184-rc1 review
Thread-Topic: [PATCH 5.10 00/68] 5.10.184-rc1 review
Thread-Index: AQHZnRt6BHjPaoDLh0W3uu6YLi5dLa+HtGDw
Date:   Mon, 12 Jun 2023 21:52:35 +0000
Message-ID: <TY2PR01MB378800495C4D92B3C88C61ACB754A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230612101658.437327280@linuxfoundation.org>
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB8680:EE_
x-ms-office365-filtering-correlation-id: 8d74a8de-b1ec-4a9c-8506-08db6b8f5526
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHFz4YasMz2cq024qdMJOuumxHIUSpW8yW5KERO2DHlHqcSM8GUnzNLp3THRf38z9dyJuBFzaOrSHPfgAg36arqmJ49D6wkrzoQr2M/fWXBohUc8NnPWJoOTuyDxBhoPjbwtGlRKlX2BWtxgqRD0GU0CJ3ib8YRY05IimqGqzaB1WZMt+9htwTjMyQjTLKgLEWboeQS5hCzw3uUbMY0E+bw+eHV/xIZ6IK1aL1Fn4cH/WX+SZ/xvX6M6L8ggH2+GE02fqSbhFz91GCgSrXHeR+p156GBnvR+X5RW6qFRp1zU+8OEI2HMXLzVR37IldWhtSszZ/Q8NXSg8BtHlFwwpGuhN9FSeFzFrOOIz6aoYqA8bcFxbtNE9naZ7lRJJI67BKjnh2RMZ3O/wb2RLPTIY7T0S4OeH51lRMGpx6RiqxHKNM+3GtHH4teHVtGU1wog92QmTRYldpAURY43lhPeJL7CyHdZtHeKgAgoxKxYzB0wDfo57YqMCtI24vvUddUaU9JS2EOYbl/DZjPYsnjTiqtvXlocT0ljhYb0cVZtvEzbtN6ECCLD5XuKpAkSen9LWdzX9JfP7RjATYYRijoSIMohAQbj4OskvQp4lJwDDdh5wv5oIZldN/sKo0ESxsI1Lzcb5L5IlEUnN9tMCMIdjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(64756008)(66476007)(66556008)(66946007)(316002)(7416002)(4326008)(66446008)(41300700001)(76116006)(186003)(4744005)(2906002)(110136005)(54906003)(478600001)(8676002)(8936002)(5660300002)(52536014)(71200400001)(966005)(7696005)(6506007)(33656002)(122000001)(26005)(55016003)(9686003)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?zrmCfxSRa7GQ+QqQXdz76Qu1RIALlSHWwN7OHZYgYChuKYOIV0aqs+Qs?=
 =?Windows-1252?Q?z+r9jOvWxKyfBs1c+QGGG8MHl6OsQZEqXRjbIOTuDbYjGI4mWvMcGVkX?=
 =?Windows-1252?Q?G4LCF3FWQ8rh8e0z71ghU3fda1Hdus4X6Es+JkCFegQ1hIo1aw8S2RuR?=
 =?Windows-1252?Q?qUsE0qoF04HvWuIkgi2/bLIgGm86age1T0uYt7CvXIwpQmSkmCvvDcKb?=
 =?Windows-1252?Q?1KLcNcfk5/+TOTiz2tyU4bEQnklFNl1l+7+Nd2VU8QifG/Qbv9DN72IK?=
 =?Windows-1252?Q?MjQixpK2v+Et2StJx9UNMDgUzHkGGHMKLtg78qdz5FZ4Qtn2dV7VUj/F?=
 =?Windows-1252?Q?RGL/4D0yPG6BjDykVOlVTzQPgIpdYK+F+otLQmtNWxRzyHEvFNNujCkQ?=
 =?Windows-1252?Q?KTysLcJ/kdY/vJM1ggV+/3ufKwyqmIT5ycErbrrWNq1wCL9JrKDGLEDJ?=
 =?Windows-1252?Q?7wgiRTWs3HCHe0XbUUBVtcboPzEJW1jTvPLRHb2EaBi9ETf4OjUQEWOv?=
 =?Windows-1252?Q?kxkAE02dRS1dpMBhElu5zDRpOuuHLegP7AsWpEuhR8m14TC7hhdKegeB?=
 =?Windows-1252?Q?SvXNvjDxDgCYUa6Siuq1UL9MxkLvMF5P5WbxDOKhGlMp+I6JFs5G9Fc0?=
 =?Windows-1252?Q?QIfke3HOa/Zex1O7q+uATCXMRWL7rh7BCd5FC5xP4SLqwzHUf2Efxnth?=
 =?Windows-1252?Q?yBm3PCvL07RSJCeefzVVxvbonzdhy4zvMrk8gFLKhAs/h413t+WWHPl2?=
 =?Windows-1252?Q?Pj25xX8DDayLN7hZH/8uQ/vog33yCzkSNXWjcjxCQyED9UE/z+cvyJ4v?=
 =?Windows-1252?Q?Bt/uIIM81UvnDys9H/XjLwBcep80PaQg3gOn/+P5XN0dANErQ/AVcf9g?=
 =?Windows-1252?Q?xtKw4cAbzT+PSD2bcQZwGQO245UMAZzlxrEedkZWN+rVrsetPH7rqpWd?=
 =?Windows-1252?Q?Alc1yNt24qLMLFV+PXI49kK1kToxmwR4uwyzwDFR1gWoEMKFipTw7avl?=
 =?Windows-1252?Q?AYqMyKyHt1K1beV46YYje1/4r0nwzHKBYJ3G7EVJNDYV+JK6qFrPUKks?=
 =?Windows-1252?Q?jkm5t04lKBYXCLktqBPpR+eKvG8nk6UfTUvdaWAF0yqYPi+t0KFpQD9V?=
 =?Windows-1252?Q?pe3aWdJ5KukRYtEMQPsFTcFNfBcNJRmHhakJmEEW88Jbzjilfd2+T1DN?=
 =?Windows-1252?Q?bGOjveM1dK+VKfAOt/GFFCn3/la0qMV6m3HjQXGMH1ZRAbk+D+oJX+ay?=
 =?Windows-1252?Q?qYTVH11wwJ6JdPNuDEKvc/mCz3INEfe3w4LipQh9nUvIJjc5QlLNVxF8?=
 =?Windows-1252?Q?fO42a1yIQw/wE0OcFpIslMWCrqeDAuIaWfoTPBwdth7TCxw4FNbwjWss?=
 =?Windows-1252?Q?ieM6KGmjaHriRxLm1RqC11kzka0HRRgskzwn4vOzAsCQxaa0bNCDRlua?=
 =?Windows-1252?Q?KbqKhzGH42CKrD8fVy30/m4HZ9UFAIXiSeO8yODp1A+ukQj0HCJKKCrS?=
 =?Windows-1252?Q?myOBXamyAgJ8XGaH4+VXIEboaP/0CKjJ96Vf51CMU4ww7/7Ea0GASXZD?=
 =?Windows-1252?Q?8H0D/bGRgISwXqqVfj6sC1B6UNUdOMKmvXuiTXeJSpkIgj0YrwOT2Ycz?=
 =?Windows-1252?Q?XeFKNMxYGGixqRNmSIn+HTQXjSVIxeHNPOdvEVbYQi3G6egPxRPecog0?=
 =?Windows-1252?Q?YMvdb9CPxTl9VsD6hEBSQYkMCYkgTtmt0Cwprt6LSf768ct0EKs5Vg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d74a8de-b1ec-4a9c-8506-08db6b8f5526
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 21:52:35.5904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tt6VJ70s3nYxivREuUWV8Jf3XZImPINLZiRIJzNRl9KBGJqQ+28tga0SSqyLbFe3CKbnLEtR8DUGKDTp+ZtxI6H9bMilsBSLNFe/VJxqyIE=
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
> This is the start of the stable review cycle for the 5.10.184 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 5.10.184-rc1 (32cae866b=
182):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
97026175
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.10.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
