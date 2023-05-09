Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECF86FC5B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbjEIMAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEIMA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:00:28 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2094.outbound.protection.outlook.com [40.107.114.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCDA113;
        Tue,  9 May 2023 05:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiWhfRTXWBj4TtbZetffsUXnwFXA4VQt6dDd69dB9THcF6VzN978Twkt6Dj/KCX8kqTqZBxprpJ7uVK4fNikNFG0Lft2CvJ3cJFSSJi7b0xtjojZhQ6GNpex+lqg4LppEqFgEYOHF9VUeG4EJY7SSVQuRRLLuSO2AB5jygdfb5KH5OH+yxCogjkQHVnHRTBq06sH9ZK7NHTjZSLufqJWPaGoWAQNGe0GuFDlImC42TAUAvpOC50+wHbJyiPNFJyPsWWgwsWeufaTG5ZY8ny9hba1YaepuyyQW8Adxa4HURIAhJOF7ORAJ/EKqTHdWsCBw7CbUaS6O36veCYKh2KERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jBxo9035tLzNnDAcGAZ21oL42TXIfMgY9ifLOBMryY=;
 b=kG90ltzeNAoYEBvh87nKo5xJOk6V1sRqTcSnIQdUoTDsi0LkqZuu6I6wcMPhK3icEu57cMZ60nQN+fLI58arGgmhZxhYSI6vm7USG5NujASXFHUn9Lu38BMMvhWp4vva2lRn1Lbq9SzB4gmaWO0zGhJB2iv0T/TT28Lg7pojZa/jgXHG7ic0FcU7VRi5s52DFRpIL+qvhAyrxRXTyLvw8COAj/sMq9+UWBbEmdtSKWR7QIvlkX95VWVJVdUBxJJ0lvDYxI1pZfYX8ypWUbFIjWaTa9sU+c+UnIK2FkYQB8JZNJYXI+BHt2UU6ytZ/tIG+7mtrL+0DpFNz1aC6UCTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jBxo9035tLzNnDAcGAZ21oL42TXIfMgY9ifLOBMryY=;
 b=kQ0oRl7LsXT7GDr2eGu5RgqBw5RZyFe0lu3wIQ2m+CJsNbzMGHR4ykNn7T4qs3DgRwd79ppcpX5S1e+hyh2NR6/LQIGXaFlGE+WRraehmig6YqqyGi3yOFdCZWjxt02OKtCLAieZUvmc2uCq45Aoy/TrH36gKWxp9kDfXsKPbnQ=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB11494.jpnprd01.prod.outlook.com (2603:1096:400:379::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 12:00:23 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8c55:9dbb:2418:df89]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8c55:9dbb:2418:df89%4]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 12:00:23 +0000
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
Subject: RE: [PATCH 5.15 000/370] 5.15.111-rc2 review
Thread-Topic: [PATCH 5.15 000/370] 5.15.111-rc2 review
Thread-Index: AQHZgiYPvpM3d3BQs02mBFpXSa358q9R09Ww
Date:   Tue, 9 May 2023 12:00:23 +0000
Message-ID: <TY2PR01MB378890A8BA8A7B0F26572969B7769@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230509030611.521807993@linuxfoundation.org>
In-Reply-To: <20230509030611.521807993@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB11494:EE_
x-ms-office365-filtering-correlation-id: 7fd1c395-eaeb-4915-d1d2-08db5084f877
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VR1FL0IyNKGxv1Vd0L136wmNnFf6oU2Lw2rlc8XwW9UEGtV+kZ54W3LgR75d8GUaGrKa5bxYiOPYNG94tHI0bAthPwgTPi24gxCAN4SDID42i7RNnUJSrl0R2q9l6UaLnem2+vvP5RtwHZQ9Kv6Djp6Dah6/e39yivPR1IgDxLMy6dcvPOzbGmYjsc+vGr/zul4MfPT5pPzpzuHfx6eFnKIM01LEn2bgdQa4rbfwfMLhE9aiuugBoo4yX83W5FlSn6Fiwpv4KhajBQ5MdXBZWFLhGvpC53+HjgAx55UTn+tOZhtDghjnpDT6DRG98xVXDCaXnKsuZmLvq+N3GkOY5bWoHyDQZh7iI6xkhFy+JYlkMlTxJNVkq+vhDCSnWZRfM4pBWs3deAKCfOan0ZaF2TnU3T0iVpDYPrccX4oA82RHz3RgM+NdLmJLknSRM8WlLxlFwHJjlclviNS1NpmT6I5mANVmEep5z+NqHeYN44ClCUb/RANQnIaDCSHV6p++QjlFBbPebfydkQpr14ViRyZPwidi8yEc2Dkve8Y6R9ZoHxHgoJMph0zyWwkYR/Jq3HIWorJcfxCpG7Z27dQIFd1IaMN+LmGxZU37toRilFZ+1WHLoweP5RGJK1hkpn/bBoZ8dWDWE056ma5lidbx+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(9686003)(186003)(2906002)(4744005)(6506007)(26005)(33656002)(38100700002)(55016003)(122000001)(316002)(38070700005)(71200400001)(41300700001)(4326008)(76116006)(66476007)(66946007)(64756008)(66556008)(7696005)(66446008)(966005)(86362001)(54906003)(110136005)(478600001)(7416002)(8676002)(5660300002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?MpLFWkLAzYGmK8iVhcouffXV1Rj7sj4Cl1OeikOWRIZ2KuLterlBMN47?=
 =?Windows-1252?Q?JCPlnYKMA5CWK2bMq5wwY9UtE68vSrXCcI5vm1u9eWzQ6J79VMqkN4/m?=
 =?Windows-1252?Q?ZmxFJ8NX2/Kcdq/bLPCfytYix7dq8zBLc+4tm/QxKEVpz7ORg2Ny6ieK?=
 =?Windows-1252?Q?Y+AF88h7UGe4piXPLAMLzMBbf7Hbv7W86VcUb0FJudpP/dBXKgnYKVDA?=
 =?Windows-1252?Q?gU2kHaAiNh1SnrptBBakQt1tOWy2mXglYf142mYYT17s3HJrHYO/V0NJ?=
 =?Windows-1252?Q?6UCv8kjWt5qd9/2l/QlbYuH6PaLuwZ3/XdflZq1/+vFa//XIhUQvAdPZ?=
 =?Windows-1252?Q?gUQx6UWNvBUnel53GeTMuUe7Ug5kKbO8wjeTkdMHZZOVmlp6+D4qZhOs?=
 =?Windows-1252?Q?KbgXOqjfLdvF3mvHx8rEMs4Ua2E8hVh+w0OMG1yksAnGOP3pD0M89GeO?=
 =?Windows-1252?Q?bx0aZ53p22OmbwHVB78ybZYB+zhJQn6QljO9HJnfKQlUyAQk72VTm5NQ?=
 =?Windows-1252?Q?UYLi4tLhsLCRGFZ77yfVEVymh/xMi3NUTiikl0dHwj3rPi0vGQYxYiha?=
 =?Windows-1252?Q?LB8CS4PBDg47j6G16kKSsjAyFixSk/Qd4EQSsh1mZCtFn6W6MMG5W3I/?=
 =?Windows-1252?Q?+gBm7woi3Heqq8Y5KrfdrIA3KjlWGxjmr4DGPh8zaQCkeEGOqE6o1a4y?=
 =?Windows-1252?Q?WonFOr9o+8+b7fLaH6xxmstbOZtUkMaNkn/Kmf/UkREP7qFM8EwuUZdy?=
 =?Windows-1252?Q?ulasG5DKDJtqCn3Y0fWF6uCYh/8EV+7p+In2Edy0uhmO6a1PUTZmOaTy?=
 =?Windows-1252?Q?XF934T4DdIzJEFy7igRtFs8Euj2IgkR/8K+Y6campIDxCFWphnSQH3mC?=
 =?Windows-1252?Q?IzZjQILvN48AAJ+l1NLgjBr6ndOYUBAi6/Xc0L1sJUkFKJc/076cMM7F?=
 =?Windows-1252?Q?IV1mWzrd+HYvR71s4e0TuYMFdnjTPCHXRPVygSCiieE1Kz7uKkoJbDVx?=
 =?Windows-1252?Q?Dc3GOvnGZzyq/QzvnyQo+IPmpxRe2CHnKvQgH8eDenWNnys7A7cRrXaQ?=
 =?Windows-1252?Q?w0b1YoqK5S+KM8VTEk+bfEFxmliRw4thTe1CiBba7wPVH25pMqA6FTiN?=
 =?Windows-1252?Q?6suWew3l8YoTv5i9c5Ai1AEfKrQzdxABOi4WwqWLk9giGmsK/hfEv38t?=
 =?Windows-1252?Q?PyfOe3Lnlf7djCWvwFA4uND439+qlskD7kCogEgstlnf1XxGv70Ij1At?=
 =?Windows-1252?Q?dUzvAPLzXlZ5vY+tAtV/O7q+YDDRXwYcEgU+XfcpgIvdCdravIV3QNyG?=
 =?Windows-1252?Q?v30FugYiLogew+1+TK7CRNKm2PWNf3a4467C5v//4O0g3hIKEqLcPqPY?=
 =?Windows-1252?Q?BmLJEvX325tfz8B2epjeiXF+Dq9wp9BOX1JrbOn8j36kbtFvQjnJtr21?=
 =?Windows-1252?Q?WVw2zt0Se2m3wrLxeGbfUxaMlO7obUFk4qdQq433VI36Zn9kOBfFvkdp?=
 =?Windows-1252?Q?z+nd9uBU4uol7HSabSqLbokq4at4qodl/RwFi8ZJl2DI3r17uc+zmypT?=
 =?Windows-1252?Q?fUKBbQeS2Amghyi4uYdWgYa+X6UFhiVsY4YPqYg50smpaljpeCLB9iMn?=
 =?Windows-1252?Q?Uoq6kTykGaV2xf6I01yxRIAvNBhvzceoI03j9VXbgL2fNj9/uEkhrBIx?=
 =?Windows-1252?Q?4lyJWophcihPd2nkPHxW+8MVfZ8U6hmgyKZ7vD/Sl5ntL4rwbugqqg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd1c395-eaeb-4915-d1d2-08db5084f877
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 12:00:23.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TR1KKjNM3PesrqJEwjy+xUcDZB81oejOihiQekulAxtU1mMRzwCt2bYeInF4AcIhZhXH4o+EgBaR9LKtaugySM7aGJ+QhhyvTEkWwLp018U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, May 9, 2023 4:26 AM
>=20
> This is the start of the stable review cycle for the 5.15.111 release.
> There are 370 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 5.15.111-rc1 (89e0c91492bf):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
59734879
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.15.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
