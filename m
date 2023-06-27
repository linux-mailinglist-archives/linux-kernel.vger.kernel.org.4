Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8991740456
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjF0UKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF0UK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:10:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2107.outbound.protection.outlook.com [40.107.114.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D476C296D;
        Tue, 27 Jun 2023 13:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCD2NnD8F3hz0vRDVMtyj2x942a2MnbT052HOpAHkKGH7DDO3AdCWySLxJSD2Q2H0IgShjyiItgvpKSwK78pdPZb4gqsUYnUQNYAUq3iwE5yAL0pihgPJnVNNMThjYZAzcWfD1bzyI6Uw3GrX3/yd/WQI11gyNiCi8olP1tOOUHV3g9D5Ov0YKPhO4ht1JpqYsD2PJfTe7IoVARMnAmlLA3JPE1b/4XmCV6bnB8U2AckVLkQ84/Rjmnt/n6Kogj3x7DDt3bGw73VsdmOOJ5I5sdFlzX1C5fcULpU2iSbakbz4hrNj/MpAcuPCooS6VFOFzYQQHNMXBDsP8av+24fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjvrhffXfQ94wVcfZUEBqvguIPoOKbTGRXuN6jPHhqI=;
 b=di6kzIMk61HgJhrshYPtACflzeKUEwMaBpR4IdiCfEWzt3V+FSHstYm9l2UfHlU1NSZ4A9aC2B1U/NgRE4tCCmzHFm7yy5H6hYTwuImCWnO25dlJdV1PlUC1IXwCxXf4FL46nH+h0M/kd7Ys76/JVl8oPKVKAzDsBFNQpmL4j+UlEECgGqctCpW8KoLCjRgt8P1OGSGQG5FQCiPLmvQGAGiIYmJ6Erf18KLuvvtNjxhNv8Xj1vaB1x1rUiEIA+JEepujXQ+qaVs6qN9WPzHiwQN+h/T27DsRqI9zg0HtxQevkKRtclkIlHGHJwaQ+tk5v7+ovV44jcP99KwZZZYCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjvrhffXfQ94wVcfZUEBqvguIPoOKbTGRXuN6jPHhqI=;
 b=BRVWE78G0kO7+bjTyRELPgRlODBjD4MOrxQbg6owXiyHUCPe9FkEoUaY1Tk80V0qNmpYBgCSosYdbmhL8BTikMkAc3th08j/0PL/76ip+obY99nMKvaqTT8n/E0GbalOpTOk/a//LFiaCOIeNATHaUtQ9BTbM/QBj1TOPuxSTHc=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5553.jpnprd01.prod.outlook.com (2603:1096:604:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 20:10:13 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 20:10:13 +0000
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
Subject: RE: [PATCH 5.4 00/60] 5.4.249-rc1 review
Thread-Topic: [PATCH 5.4 00/60] 5.4.249-rc1 review
Thread-Index: AQHZqF0gRWssIghoP0+6TSK6RSmfQK+fD7Ww
Date:   Tue, 27 Jun 2023 20:10:13 +0000
Message-ID: <TY2PR01MB3788E9BD237F558730A395F1B727A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230626180739.558575012@linuxfoundation.org>
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5553:EE_
x-ms-office365-filtering-correlation-id: 11b23e3a-a4cc-4a78-49dd-08db774a842e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sn5TQKnPuj7FTgYTU4mTmyfgnIvLSByKrfhFRL2WRwnAgPi9ciEUfdMygCPmkQv307Mz8TKPrO5f2eDWphm+VhqkIdp4twOY4cdXQ4R7m4PBAvhLWAljxOLwLk/p0mO4RdWVlXaVUrakf4UysmBekL9KcnQ1x9i27nuBuuAsvJitvjXxnPk7YUBjIuUzLccQJfYpK4oNsAQpn5nvi2ewu8i5OK2LMfLY4V6GE1lrMRWRiijtlHsFwG6FH12E305WVlMPxRhuX9VI6wkZVOIR0cFwnfEVXeNd2hsKHlSJmsPZQ9p1XKPzavl1CVM6WYHUTiIKT4AA+kmmAtPjrRc4du1n2oVgR8Mr1qSx24gIrFGMsz4AzXHUHXSJWZk/iM1qfnu62CRD8+35L1Gut7W8SVMIZDvdkVuhuvtrkmuSNFBEbstTGfJzbpmOdT+dXWZghMeiK4HencbobBi+oaN33B5QtPdVaLEs+pPdLZW/8gmNZj8CaYozBW6f3kXXa5lLoh8aOCql8qk1TntqY3CwQg84X+TOqMp2sCM4CWrGjCXE9B9lfVwikdkW+C6iPpAqD21gKv0xwkTKJvAL7JmMQbRTxs0463XKisQyKYs46oVU+R/dyOh7i2z5dCntCVU4eoBwW+Uw2zW8E2U+/hSXmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(8676002)(8936002)(55016003)(76116006)(66946007)(66556008)(66446008)(316002)(64756008)(66476007)(9686003)(4326008)(4744005)(6506007)(186003)(26005)(110136005)(7696005)(54906003)(966005)(41300700001)(71200400001)(2906002)(52536014)(5660300002)(7416002)(478600001)(38070700005)(38100700002)(122000001)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-9?Q?d59sqAgNwmTQlsTJTz520Y3kvAO5vearc+8RucZNz9mqZBck7yiRZCMh41?=
 =?iso-8859-9?Q?m+ZBumxLwYVUCKnELKieB9o+0NKn0ub1vElZWFK4sL5Fk/xwsaAsGh7wJg?=
 =?iso-8859-9?Q?ch/5XjBybM9BNs0XAvtfpXmmtR7EVfdXqi5AdXNQgt7Itmi5SRNmHq5A5M?=
 =?iso-8859-9?Q?NHeHwJTsK4wF39J+tvbqINExpJ2w+WKbcfDCPnwM4NQa08pTx13g1aPvr9?=
 =?iso-8859-9?Q?cb3bDGSYw4gUF1SPPMsXvqgqxIVUkh9kuormayOtWuvNNZ2sYRIbZlm20L?=
 =?iso-8859-9?Q?bzvgjvlq21AnKlQXjyneEdQDdTuBFNzlVW2QpetZS8kYzsKedsZllvHHC3?=
 =?iso-8859-9?Q?YwitudXg9os0uSg3ZlFsU1TJgeGhE32wcm51REZYxxeVnGam2hSjpgrnpe?=
 =?iso-8859-9?Q?iuemdx72e2Pcpy/Nn5XJxABQc3c8Q/GQ4f3xtjq75dl4vSbb2Obb0OlukF?=
 =?iso-8859-9?Q?Rj2+GyuNlvN6xZWMwDwn2A5Ty85+UYX27WE+qEXrNHJyDtOWjCyWXIhC2r?=
 =?iso-8859-9?Q?SmW1FeMHKEUtrMoICn18tmOrEfNzLbNKv8FiUF4W3FE7UzHx+ywL/imord?=
 =?iso-8859-9?Q?U1FyP83Sp4NYecMKS1bWYWt4ibIstAOLQFihGVyx+wxgAYoFaMT7lUmXwX?=
 =?iso-8859-9?Q?i+OR3X7ZLKg5djyxwhPg5RTewxlF0/eHD5Gat61srZfEBBzRYeuURkseZJ?=
 =?iso-8859-9?Q?kg/nArHVCvupR20vcwlbLjzWFn9k9TwkWOFZ7tcH1TOD4wy7eHLa9P1voI?=
 =?iso-8859-9?Q?6qaRi64GKcYo9O3DyxPP1sly6ZWzyJPn58sy4PaOjGHpfBVvjl4Vzhco0p?=
 =?iso-8859-9?Q?ltNjVvCI9ZczBFCFwmZPyRhNoIQMsrVH8fRXdwB434caSjTDU++5dvHAYy?=
 =?iso-8859-9?Q?Crxv7NxyK7wq092xHGeELQmRY8ijmBDp8TA9EaNnWQzHjMVUNorFImkXyy?=
 =?iso-8859-9?Q?HRGDbMPJgoJRc8Q4X1L5j5AZiohxge7zgRzJeYwkLI1pTCHTuWFudgjtN6?=
 =?iso-8859-9?Q?QpYQk73pIbFjdxAjZP4JMuApaMcDUWhyACtyeJKhjQ77s6BVVpxEVpFzQd?=
 =?iso-8859-9?Q?EdUmhzWHbNPppwLOXXsmSkRn5UwPMgdlFem550Dj3dCgBfPih2fYltbgYI?=
 =?iso-8859-9?Q?GeEJxK7JT2ejkusMQLow4KHBkW6VrGM0ZiZxAH6BtKNxOs60kiPwUft3O2?=
 =?iso-8859-9?Q?MQemqbajLKmjxjfpGfMY9trqIG9l+X7yGxaXzDWggRhdGpS5aJS7v+0g52?=
 =?iso-8859-9?Q?Bbl4gRioSRPnApikIs+POYQTnI54WxbXtgvO9BIoKz7kxZnFzFnyhGB2h3?=
 =?iso-8859-9?Q?ascKb0o3cr/YmiW6r1WsBW9/43e3/bIurS8M/238zCQq+/vdsrk+iCqzZz?=
 =?iso-8859-9?Q?duISfkT5aP+8iVlm+1CscHwSOSvWTkQ9dDSSbaQg05CWkNtzw6AzGWfV6x?=
 =?iso-8859-9?Q?uNYFOI4gwxd1qJhcrqWorli5PgAKfZ3cWhgV+4YJJmJ+krKbZe4xt28N9h?=
 =?iso-8859-9?Q?OgPMFr1jwTA8HL7SY1AilNbhKsnj3k1ToO4Va5ygY61blvwM2/MxExbd3G?=
 =?iso-8859-9?Q?ClOsHzo49xWXg31iL2ZPhJwJ84E09RjmLr8RhGoTS/McqEZiBf8LXuWvvq?=
 =?iso-8859-9?Q?rLUWkxR01uo3dlG49Momb9zSJo76hrgE8X5Ackop2fO/4kMvHyoT6DEg?=
 =?iso-8859-9?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b23e3a-a4cc-4a78-49dd-08db774a842e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 20:10:13.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OOOXdHbW/oDCh/sFpm6+dr6vDVY2IJbB7i1j2sv4+eoeFdV/GMq+C4ESuuC7FKUs4EDFdnDfxlM3Y445EMMPG6BC1LE5OV8+gcC7YstIMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5553
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Monday, June 26, 2023 7:12 PM
>=20
> This is the start of the stable review cycle for the 5.4.249 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 5.4.249-rc1 (824b023c3c=
da):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
12373109
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.4.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
