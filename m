Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E887221CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjFEJQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFEJQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:16:08 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB51CD2;
        Mon,  5 Jun 2023 02:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMxDCQEh5QZdMURPZh+KteUbA/8ngFcGRW+tHJtIjALl6GtougBqWsKX22ZDg7UtCvAh/uE4oNl3VVeFgE1PyVgcWPCzDSWTNQ1WMAut8nI+WWgPBtnnmCAXDWo5bdgiM6IIDkJXl5PcigVo1q12SrkDWtxqfmk+ScFsW5EYcADdTeSh2pzEfMxSdtJl62zz90Um1+P7+eqjeZ6gKitanWMHgZSN3fOCxTYjCrh8JodKnBkntr2kSvzcgwSRHn3qif0iSIjR6rlOKZc8OMJfXj8TOsmoVqY67fq+zJSPJvJ4+KBZjhikpz0H2aG4JAU6rY3FnDCql7hwY/wcPf8opw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7eOPS9kRGCy2fwYwi5/vm9m2pfQwZIUatA9nk4Z7kQ=;
 b=dz+LrpCoHX7fMZFwJrizJzDZgjnCPj+K9UqBJ0mqHfLEx135HJ/zav68nI/m6BJbNlUMaCM6ImMo3g8wXuSHKUpyF2d6axkK85qZsITSoQYwdXQY97mmWzwPCcRBUFu23YdMXdj1F6lxlYAyB2JUW+IP0K3yxqHPLRS/YgvpEF0hun4WF+gB16tCZgPqC8E0v3SmRhRf8M3Xp3+6q6B22DgvgYYrgVQjG/TLwv5NZ+fzqhEG5aU0Rz6oWrYVo+4jBFNm9Y7KS/loBlQWfTmBRcSfWNYPUK1vAPo9BK24iHs/MUG5lDYN7OSn0C217aluUEBvZ68Dj44hj/GjJdQtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7eOPS9kRGCy2fwYwi5/vm9m2pfQwZIUatA9nk4Z7kQ=;
 b=pyY/1rN6lYKAan3Sy3RbPPd9yMc7yTHe4SeGxk7iXXnSwI0C4lpZD6uALk5N5fR4LHC//upOok4FNQX9peHt3oswtp93wXi/G12YMwzU/6IH3WnDoBE9SAp90YM5j9W+suqBAPml0tKGBRW3LHjyfDDwVhyNlsp30zYmRMWRVt0=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB7996.jpnprd01.prod.outlook.com (2603:1096:604:1be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 09:16:02 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:16:01 +0000
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
Subject: RE: [PATCH 5.4 00/16] 5.4.245-rc1 review
Thread-Topic: [PATCH 5.4 00/16] 5.4.245-rc1 review
Thread-Index: AQHZlIwvlsXJkX4Xq0GwkmbV6Y3of697806Q
Date:   Mon, 5 Jun 2023 09:16:01 +0000
Message-ID: <TY2PR01MB378893B0ED3A47535AF5E686B74DA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230601131931.947241286@linuxfoundation.org>
In-Reply-To: <20230601131931.947241286@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB7996:EE_
x-ms-office365-filtering-correlation-id: 6e9190e6-a2e3-4970-94be-08db65a57b7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVGcmZ0iJlDquf2qSEiWjqGbv6t/ziSsCrA6pffr7vIDd8ANfsXvSljy+Sxl1VO0glTBuvbmxl7QRot+QORuTFdPasNgPQMMsp4WVOFDOddbRin44SxB8F7x41tcOwKRLv1IIJRwlTBdTw9td3FNKez9LNrtvBhZXNU1akmvUN3WMiaoEv/kQud5HJgfuNk+hawRAy/U/N4bThYKK6YR0Akc1qSLlsbbPdYjsyr42jrJC5b2NUM0W/YYMbxaiTiPfZxs8SsWfp0OIcCCJ1hZsOyjTMrwil6sGzUoKBCLK3maPb7EaEaIBibhKOVRbRKD7c6UhzhvBL+j22wYmWtuivmIreMdjgO3ZdovC3VXr5OT1SkEvm+coSFbuTwQHP8RwKetHvAsH0FudsAuO24m1IMqO79ldB05BXFI9iLouC0MP81Nz6mwUM046wYBu3iZXQC6v6PxnLIf9pGqyiA+8zUIgj0+WGIp0hw4RxFinWSK/VWw/U1+f58G+3+b2aSPTb5Zsnfd79nS1PdXeWMqhTZdajgKxdxcxD6jcd8syIoDa/uNYxH622Tpkb43fe7oo3xB0MmwSMVelnKm5Lo5qns+Ugl1D0D5dEwfuAPMJHg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(966005)(7416002)(110136005)(33656002)(478600001)(55016003)(8676002)(8936002)(38070700005)(316002)(41300700001)(66946007)(52536014)(76116006)(122000001)(4326008)(66556008)(66446008)(64756008)(86362001)(66476007)(5660300002)(38100700002)(54906003)(7696005)(71200400001)(2906002)(4744005)(186003)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?tj1p9r8lF65DT2es1MdG6tDRQ2VSxK5Os7HVCDjQGipwhb12iHBzn/fK?=
 =?Windows-1252?Q?7ChIAYr/svYvXSdqXn2hdjtT2u/aBGjUKF4zBEWGugLrPXYm4AR9v2Db?=
 =?Windows-1252?Q?vmJNNZkmTeCQ6xsaSXOEjeRko09KCuC9mMAM4ytJ3V6mZHRmsRr+Hx8y?=
 =?Windows-1252?Q?I3RtvaspF5zqjPK4klxnQ4dsY5tug3T2KLdL+xR8/wJh5Rpp3B46Y87K?=
 =?Windows-1252?Q?LQEvn93nEkR60GHFil720sjOoDypVlHu3oyaoZezf5AUe4Ot5rgzHpzX?=
 =?Windows-1252?Q?UeO3tndIiRFek9TtAqZe0cmIKP+vlqPu2o5LYrFAmfLEy9RKJtVPrh9v?=
 =?Windows-1252?Q?acw2F63gD20L1wwufTri65v0c+J/lotBr/Q76ZUQT5Jqng2nIC7pHzF2?=
 =?Windows-1252?Q?HNaKEly2q1koOnwJixS/3S28ICjiXXTSHrezMHI57xhwq/WfmfWYcqGL?=
 =?Windows-1252?Q?AooFXavkrVk6OEaMjcuFB53T798V/36EPAOoYuiAVpuIjyuhAaVDfu/V?=
 =?Windows-1252?Q?WJLYjG4LmE03VyZxZfnRCVcSQlG4BzBITcd0ywvEaPJ4rIYanCmGj0aO?=
 =?Windows-1252?Q?bINPhvQbiwyPwRZYHeXWVRMfwhRHrHBmqMu1uxA+cwSg4vyVvWEQin7S?=
 =?Windows-1252?Q?k8fePh03ny3hokWZZuEjn3ofCXsSgVKSnHSj348D8gqpWlzzMw7Ua4Wj?=
 =?Windows-1252?Q?06GavcO2BJZH/e9tHg/ZB4uzP+KSzuCov9b5M224bca2sQB1zwFH+ZBA?=
 =?Windows-1252?Q?43NmQbsqJW2lC8SQcEXVNJcq0qq2VagjZvwMeb9YdpLTr+4trMOxKk32?=
 =?Windows-1252?Q?ho6rudGs7lmilj/Mn677zf7tgUZAq6p1DrwIyqmD7oKsiZyjPQ227HK1?=
 =?Windows-1252?Q?5mjUFpojdZJfDv3GFtElP8rvrW6mBtEXhOIjm/NjeDMirl1Sze4cJgxU?=
 =?Windows-1252?Q?DnhKCX9maMUAHNHCCNTuo+GsGmph4WMEB7vDhkJzK932H/HYBinyRkIU?=
 =?Windows-1252?Q?TbHt4GPoPS3uSeJ2wPotJefmj7lePkGoMkJRHd5oasYOFio+Rp4BlHPw?=
 =?Windows-1252?Q?D49+x0UgiKAi+r4pXXTibiO9pay0jmTH1RMvD1s4RDfd9T36AtVo0GoE?=
 =?Windows-1252?Q?iANzjpSmNb8qC+9lESwYt+hJZ0ym935VHteb82n4yAbIEFfYGcm05q/c?=
 =?Windows-1252?Q?KBtFyzkGGhLnhqUMNt8hXSOvchClBlEdtXfWCfZgwW9LZFCJEnTt4xmz?=
 =?Windows-1252?Q?eegdcP+nIzSsrikhhU/ij9B06vOhrV9CJvr3b8FsdlYL87xcScbMBO26?=
 =?Windows-1252?Q?Pl2RfIuL5KS/dGKsg5vf3OkR78vVmSJIs8A98iqfwcTmVavU0a2CUV/S?=
 =?Windows-1252?Q?YMTSzg8HSrnXFS1YAbQ5owBGMlzKVes7IRCWMkq/iDoRfl3UVgIG74OB?=
 =?Windows-1252?Q?QXWo0WdpwRAs7XXSewclrAlBAm9QNySiPNNT9Y+/vPIyw8HZEO0oQdKk?=
 =?Windows-1252?Q?+9T/XT/KHP/CRQGGV8vW80mfVM6s+4JTJEqeULDv5l8F4giK8kqxBoCg?=
 =?Windows-1252?Q?AFU1gBSqfvAfj0exYsByTc3TXzZflUACMvm8dLSc3BCweEoshq3H+2Eg?=
 =?Windows-1252?Q?YQlLkJKsyuzyi/o0+aP4QtgvzWo3oxcSCNdP0ydHniM/PMKBnbPpimw9?=
 =?Windows-1252?Q?6D4HaCchVs3HqyUgCa4SzAluSptG7QyvIJ88STbRwPOQbGPLh202Qg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9190e6-a2e3-4970-94be-08db65a57b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:16:01.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2ifiXXcTjpqkNhjqZj61WcWpKF58ca/rvifiWOF/gdA+U1WA2x7h5vq9KeFo6vPpPMNl2xCoTErmvzjvysUISpot69M13KB8OMqU6Qq7Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7996
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
> Sent: Thursday, June 1, 2023 2:21 PM
>=20
> This is the start of the stable review cycle for the 5.4.245 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 5.4.245-rc1 (50329515aa64):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
86201773
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.4.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
