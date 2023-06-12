Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC2E72D37E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjFLVtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjFLVto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:49:44 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2091.outbound.protection.outlook.com [40.107.113.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5352818E;
        Mon, 12 Jun 2023 14:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBGVnglVdtPUB8qEV/s89xmGCn9Tm8+FFfaM4X6fTV+FkyR6QKzraaVOE+emjU1hmdS2QgoXG2Yme41is0fq6DLCuDfTSQPO1ZmMQeVbRm+kyAelZR2SeWOjezvbMjayt1XoxB/SgQUvKYFZaq3NsNUif72t0cHFBYeQBBWOkanWcXOFwDcgRdc91LtzXLhK+FBMup/IGtNotvd/orn9amKc97SMxrgqKeJpp4ph7N0knaePhyTnOz4Z8T2llnsjeCK21B/598i5+5DPw1jcu9u5L/AH6nsfUoOhi3q2m0K4fUNMZV4Z820UyjA+srNqWPLe6azJs2i6zJIJI/ZQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuWI1a/2zZ+WLt9iyU9N5XJzYTOJPpmS6ZJp7QAHTAU=;
 b=UhJ2eI7RKcddA+793yDPkUBQQloNToG93htg6sUU2bXwuPr2r33ARiPAtLuiGdiqAbIodcSIm7uVDnMQATBYfsenAXes795vWmPoaFzlg73NWPB+YKwy0csj7L5ee4gyaFHTE8XaSYECzx9yf/pTvWLtEIscTRAI+CI6WOOsFQRLYBJAPhwa0Vswpj2r1K1uwv6C/KRwq8Xe7DN9EgnEkLqVyXNW69SqvsDd6I2fP6/N/Hku9vIzVK94ethnHEfEPBX8dVNvmAGow86NqHOy8c5NHTAlNRN7wkq5gILiQT6uY0dowYO2x7zGzTOmn0QI6oVj0oeBhf+09eXOvjeMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuWI1a/2zZ+WLt9iyU9N5XJzYTOJPpmS6ZJp7QAHTAU=;
 b=RFw6JNF0wEmrAAtTXNMY6f7hC+jPJ6iDeyCSezHG5oqhYw4n1k/UsJXcN1RKTwKwHRWKjBjOWietMVxSUEYNjr1aRyYH/NqTRxl30ukRn8cUYdrziBDOrndjHQ2B3m6mCWQEcETVCi9jYAsBve4IvKOvkpz5wrXPT7+wI3Zk1XE=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB8680.jpnprd01.prod.outlook.com (2603:1096:400:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 21:49:38 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:49:38 +0000
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
Subject: RE: [PATCH 4.14 00/21] 4.14.318-rc1 review
Thread-Topic: [PATCH 4.14 00/21] 4.14.318-rc1 review
Thread-Index: AQHZnRrmWYh7sSyvPkudDHkz6p1wEa+HtBJA
Date:   Mon, 12 Jun 2023 21:49:38 +0000
Message-ID: <TY2PR01MB3788D8C4D2BBB653901FCC5BB754A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230612101651.048240731@linuxfoundation.org>
In-Reply-To: <20230612101651.048240731@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB8680:EE_
x-ms-office365-filtering-correlation-id: 45688a4a-ba59-4915-1ef5-08db6b8eebc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2VZfJmFd+QgFVMd8QJOpeHMC+UQdwXHKwA4RUgqRCthfGYvGZj9Kt7TnV+oH6K2PAtt0TwdGolsBpQS9puG9W4MRN4tYTB6dA8hfhMS9Z1cJrJjdDE3i7JBtFXQTgteLMnfeAnN8JXi1glgOdzsTHaGAkH0eKrTl/an3O/B/DMPLnrqdQ08A3ohLqzvQ3sVONGEYrQ4Wg+AS9DCYfNcKBe0gARfDZfMlxDtCp7cZCZU3GNAxtPNOT7wovWvkEHphlmvaw6w6j7jgzYyjjqfKghGC+fBxET+rd1J+jLkOMUBjkvvoaqPJUb0tlPnJA9STwZ7gPRKlV7zp0g0BvC5FKytaVeiOTji4nEYdvIhL+0D9N71W394H4wAZ8fnWayeXx4MyQ0DXS7AEyFJi0XQUlSMCKrg0e1/gLa02hYArn36pla2ZLq5CY1GaizlWcQ+hI6L+ir5tLr/cD7bj7EaS1UQEt+IUVvC+zCBs/6PxqAFeH+BY4y+MMQ7j5XtlFj+hmD7vRhu1x3QT3szRwZHorE8/uyzWPK/XeZKn2vQxAuR05fDDXWjSkc4TxCM5OSkr9TuqTx853CP5sGYpKH0pX+cimANiB5kAZ5M9S+G9R1kjEQQwiuK5AipqBgqGWPCxlZMSXUEgSfrIGVxCMjQofw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(64756008)(66476007)(66556008)(66946007)(316002)(7416002)(4326008)(66446008)(41300700001)(76116006)(186003)(4744005)(2906002)(110136005)(54906003)(478600001)(8676002)(8936002)(5660300002)(52536014)(71200400001)(966005)(7696005)(6506007)(33656002)(122000001)(26005)(55016003)(9686003)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?mUIwQ9ZLx8Cx4ecU3XyF+PqwH2GaeolYhu8M6R1dxYNTww2ZwWFrnqPL?=
 =?Windows-1252?Q?QtaNBRLbWKKPcoKNjaoFQKNY5bHb4uJgZP23omIM9aEvj4nDBRq6nXyz?=
 =?Windows-1252?Q?xvvNzmkBLjvpcUb8DrXtl9taj+rnfoFkvcMhlTHPk7arEmjUU5XMom3x?=
 =?Windows-1252?Q?1DP54jfpeAaQP0d58f6c4AmaK35ZdyvTDAsuA/ysTiRerczOh++l5PFh?=
 =?Windows-1252?Q?jv9cYezzXmRDLsWO62d/AzCPJkAT8OfgZ2Yx4RzUHVqd9tosf0squLl+?=
 =?Windows-1252?Q?88gfcCcVqlIOscfMaiE9cBczLoYOpFh+cQRNVwMlqJrS2m58mRnpbBsj?=
 =?Windows-1252?Q?7boqPZfmy3XE3gJCJp1FdjCYkV1SIRl8ZxtjObo7r9IV+2l65i/OVUyu?=
 =?Windows-1252?Q?/g086RrsENrx73M9NorOHC5SHbIHDrhm05u+zxf7TcY0lHtEBT+7hSzE?=
 =?Windows-1252?Q?qYlJID3Y828mzAiIPca1qoA4NbaO/hhOzQk6uROMDOBZCrsj1QRmmHMa?=
 =?Windows-1252?Q?TQriJ19y2DqVM2JsFwW3buu7k+rOFZXDL7nUTl06aEUVUdOKwekIdI01?=
 =?Windows-1252?Q?IbBntGBjMtBu8ITEW/v+9SP1D6bQAESAhWGNjW296ObdvH55aMo1NznZ?=
 =?Windows-1252?Q?nc1K2RzIJfL7ZAja620Dnol/E3HuGDl/syj480AozTA3kq3IxD1aBPvf?=
 =?Windows-1252?Q?q2zXszLSlSfPUsE7dVM8Lg1j7axYELr7+KGiGnrYjoLPRE4Lg+8XixPI?=
 =?Windows-1252?Q?qQ+iSIFOONtkt9BIwL4yJsPIPEjN5jxgMxTofJxrKxS8nqDuBn6crWCN?=
 =?Windows-1252?Q?lCN/MB4SsFTFpiqPeqf1rf1sBpBxzub8Oqc49p7pPJf74bEmPohj5V7b?=
 =?Windows-1252?Q?fh7tR8dFw0K9KOzTARjl99PZJ6y8463HqWAe8sHvZyey0r9Ql7XVs7Wv?=
 =?Windows-1252?Q?jGdOww3sxLaqFdBpVWiN5uJjO3BqI3RYKcWY5SEAmOgxLOY43QQ2mlTH?=
 =?Windows-1252?Q?OkoKAIQk94Lo5V1Usl9SL9bS64XfhuNcWu5rc8aZ/pnIdrg1PV2FQOP5?=
 =?Windows-1252?Q?BT3ZgYB4JEwWPPl+P1iZ9KZZihs2xz+ROKbjGDrKBvlAxmux4uxS3v3Q?=
 =?Windows-1252?Q?4R0A76P+Pp5jLeSttPQOiqMEoBD7Yn0qH06PoiDDJ2vhmiwQZzKBL+E8?=
 =?Windows-1252?Q?v41YiLfSlfp0/IWOwbtFVu12kNV0FCtJiDhVpFaP3UZ9DTRmju1C6D3F?=
 =?Windows-1252?Q?5ptl2hgX45y94p+alMO81MrrHrPtZlkMVQKxDh/PyALqK/h5pO/V3YMv?=
 =?Windows-1252?Q?OSJEnXG2NuyFFZAcX57Rcpl/IG/E/mJ3Bi1FQgXav4gwjVrzQfgHN0M1?=
 =?Windows-1252?Q?B0UFpTymG7t1uxfmGdMXCkry6SuByClb+QIyFUbmiNh29lVYrpt150Dm?=
 =?Windows-1252?Q?JsWSf432iUsP9RiqKhuk2qEaZFXBJce+1FBsE60F7lYARww2MtherJ9e?=
 =?Windows-1252?Q?IYob0Klf/JiTkdWiAG8LKuTTaKEHE24fBCpT6OQdh36xa3E65FfV9/Ew?=
 =?Windows-1252?Q?PpKOO2VdDTQAH8bq8+Bysu9l32/YpZpr8bwPwuY1fYABEjh1TOvdu+F4?=
 =?Windows-1252?Q?zcQZ17rDR3G/dWnGot81w67i3SR2jE+bAmXqDHosuetqkAywPYbXPylz?=
 =?Windows-1252?Q?miH7sINEZJTSoLrQh/kBEqeoXcPWsJp4GM4k9GVGDaUd/Q+8lpze8A?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45688a4a-ba59-4915-1ef5-08db6b8eebc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 21:49:38.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zzntcq8e8fXZR27ULgMepCz/yC4tUpduZfM+6sXh59ddwqfU032sB4Y2ENpV5mwZmSAr+Sq2Bvy1PSG7gpY+RY617hcNSvwTPBwdog9nzj8=
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
> This is the start of the stable review cycle for the 4.14.318 release.
> There are 21 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 4.14.318-rc1 (6958cbc0e=
f5c):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
97026121
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-4.14.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
