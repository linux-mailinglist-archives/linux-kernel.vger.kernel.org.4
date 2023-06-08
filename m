Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF772789E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbjFHHU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjFHHUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:20:09 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57401BE;
        Thu,  8 Jun 2023 00:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akDBbEd4r3P3cnjEv9GcO56CBDvur71sbjs9T0Dz3/jt5/w48GyO0YHu78Uc+uHZYDiAe03rylxTc9NfH9C/Hu0ZhZjo8btfBdYEWCF8vtr1NojDgHH90LlCVmR+gQQHHewWWPWgD+JMAVFIoHdB6uCnn/DBY3wQetsOo9+Ow8qixiJwXA0041ASyiEEUdYJGBiokoAEviq1trknUSZDN9WPmmpG13s6ZzJTBBfI2gM68DO23vkwKQrZqGwG234slZDh0HzkDjZ0p2b1fu43gPwQfIFB3LhYQ5bywXSww0EVGYIHKZf7qUlan24XNxNVfG9VQD+ryrq8XKhWjHzrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N39BbvrktXGQjy5DOyFwOFohPVdlJaKb3wJ3uopzF/E=;
 b=PPBgZncV55Dn8O3una3btfYs4rRSpZVISOrFgWOFDbMEnq6KhkRK9Zaz3IezL444m5ks2XmumgeddSAQrEfn6TUHOcukc+u740LofGlIcYS/bUjoRKkufQIaYxwMRjc1hzVK9qhqfsl12ypWr9fBpxmyREq0gIlYVb2Kbpx6zrWIifSP0s2+gaF23on12bmUAbl4sfxRuaMuIUekVl+NTBHjIYiZFfQxnPyNpjxnt5+aV4B6VKBIFfL/I91w3UqrUSSlMbAk4y3Zef6IDBlzZfAokgvGPuadIfZ3kVmrLQkImvRxpQrT9wdFepit41ExWA8ksbXNvJstW5MDN4oLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N39BbvrktXGQjy5DOyFwOFohPVdlJaKb3wJ3uopzF/E=;
 b=JUU6KRGdR8M/yrf8fBb7iB3lm6Ua8Y+STCY2Mq+I51L83Nzf2kHwydQmU1YliPyTUpBpu9vzoUgakKqt0/POgJXYry0E3PO2ldX6p8blGTP+fjWqADwQTNEpGFNvsqkSxil/3tFBwA+fNBZttH6+HZ6kFjtPnQQFj8nVBmCJWi8=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB9662.jpnprd01.prod.outlook.com (2603:1096:400:230::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Thu, 8 Jun
 2023 07:20:05 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 07:20:05 +0000
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
Subject: RE: [PATCH 5.15 000/159] 5.15.116-rc1 review
Thread-Topic: [PATCH 5.15 000/159] 5.15.116-rc1 review
Thread-Index: AQHZmYKyQLH9wdQR5kSbYiZHFHKKdK+AaYJw
Date:   Thu, 8 Jun 2023 07:20:05 +0000
Message-ID: <TY2PR01MB3788CE2F551D6DEC6A15C16DB750A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230607200903.652580797@linuxfoundation.org>
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB9662:EE_
x-ms-office365-filtering-correlation-id: c97ca5b4-bb56-429d-06be-08db67f0c876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3OCsC49SX9tn21TuGTFuWeBHnPlcHwl+ivu/Pz/IyahxV6ETqQQw/HOce2AITFlRoqUF9FcUqEJ16jWgzboeVAyXJ5BJC7RN9St57Xee4a94WCFe4OXsTlpdiReSOOQoM+61lFvY8Gi19TrgaxaBIcMKHXROff9hDcwm3Dq92QS9IKpOG2lNeMRgNrWbORsXDKBvJTDmE4uHTudQUDB2TrCpyDazype2XfoEHteVo7Kf1P75wz5yi+kYJhfW0mr9Cm5GRQRLdrGVfRHkfulBo9kxZX+hyAw7MgZOkI9SIJ4kaItjUZGHTMFnVElR2GwExHkO46FrfkvwA39I/vGfFM55DZ1xlDndPVjn+WA6mcJfc6ut7X8CobJ6oTYEb+WfLTVd11gE31CGOVQ7FcsXkcfz17KqywesOLDmbLX+wXokvuDe52txhXBHlSwwTJq+MF8bSblyWk+GGpQuaB/udCRrR/NL2zuif/YaLUdVBdgcKuR0V+d2xo1tojU7q9jQy8SaVaWcNxzmF/oeiKoplHFzihoKbyLG9vWwT6sT6b3KVITCpiMk54qm7Pw+8ll4e3qkEAODIu6hZMEqkoK/NTjqQTve2DgvxhEWmRPv5LPgInbmo5OuwEyo/9MPTV/PMHzNu97TlcXAGVEud3m4BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(186003)(478600001)(6506007)(26005)(316002)(966005)(9686003)(52536014)(7696005)(55016003)(8676002)(38070700005)(86362001)(41300700001)(38100700002)(71200400001)(8936002)(64756008)(66556008)(66946007)(66476007)(122000001)(76116006)(33656002)(54906003)(4744005)(4326008)(5660300002)(7416002)(2906002)(110136005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?BUPacXvSDq5yruRL9cO4mURPhJdFeWwfTrEDffrJoNjkOdIPEPOsoGM0Oz?=
 =?iso-8859-2?Q?RvGz1sE6J5sRvDZWLiMQ8aFQhHCqRE9NjiY84PxMYRHAyAZlP8ciUeFae/?=
 =?iso-8859-2?Q?5o/vqHo1S/njbgVGlkN8eOo79aw4DFm3YcrRmvYzHpmTd2hNS0r0n+pTBO?=
 =?iso-8859-2?Q?w0C4ujk2E5pqAdI8+cAzbzNgzvLuQVd8H7hFSCDiQnGg8d150iXUlNQZbS?=
 =?iso-8859-2?Q?fTaqAoFBJ+D2QvKMMRy9tRwkoz70DREABBT/VV93iaBW9H2EQcwLIrZibL?=
 =?iso-8859-2?Q?LFBe/RCl2+CQaqTDmWQnUgl46bbeLu0J1JWPojbE+FJa74vmuu49ejr3TC?=
 =?iso-8859-2?Q?LKzVs6JX6JRjnrPix5BrkStBMdZAkEhhFCSmVNWz305/78hcJcLYgBUUDN?=
 =?iso-8859-2?Q?t/ZRDYaDzzr6hs6iHGBubaAFl1y60JR8wWTpi1oNTeZI9P8EEgxKLqYbMN?=
 =?iso-8859-2?Q?Ffn/SVn8oafpe6PXKiYua9rAgKhKNBtuTepYOBl1y1lA0DH3ONFGOvInGu?=
 =?iso-8859-2?Q?lUUMB46A97FYARmiBsyvFbrH+VEvwE8/J8Si4z0J+UUZhI+STCfueVOYxG?=
 =?iso-8859-2?Q?ejxUzvo654KbPKIHb1rqFmDBoBTW1fF9H5bfK2hX4slFKmdipedTCA3aCI?=
 =?iso-8859-2?Q?UwHY9Xq81ycznUV1L3H6sa02LvFLPz1NTjEXMRK/lfrYGHB82AI8ji2XaR?=
 =?iso-8859-2?Q?tKUZFJqa/EcmcSOgcBGc/VvYCZUy76SQJjOxIukS80Tnd4HnlfrmqSO9nI?=
 =?iso-8859-2?Q?FKMDAvn7fgAWhLnm4oCfohIYFNlMPyUin9dLjIP8jFjoRF2ZnFxDww3HZe?=
 =?iso-8859-2?Q?ah0xEDbJdlrB+x9tBR7XeE4BW/wF2K3IGmRnEewaPHg9ftL8lOsv6YmqKc?=
 =?iso-8859-2?Q?N7h/DqmQTUqZG2mmfdVrqIWJNeSr/fbPqjELdgTFrmDnt8kexORbdoyOIu?=
 =?iso-8859-2?Q?X5DBEGtqzjg0+jCgRG+icxvsnqS3ehAoJF7VsOyiHWW1lbjlKlze70E8nh?=
 =?iso-8859-2?Q?Y+oQFVnoded7kf60ABPWXS0JavLZTWNkGfttuhOKAgOI29FznDRolxVOJ+?=
 =?iso-8859-2?Q?O0KTcT71G/1ZnPPIxJt0VOIPskgxlVOBgBQfHOtncrnIRraG5KMiGUy2d/?=
 =?iso-8859-2?Q?huDSLiVjo2tq7RvR6HmlgwbF5l1u6qBXQgD15Q8Jfel+PL0OoxMlRsDo7x?=
 =?iso-8859-2?Q?s1F0kZWrNgym3vUWDzVGr7A85gnzyTJePxI2jOZIRGFtCeE5CcEPB//2Wz?=
 =?iso-8859-2?Q?KCC4TGYFuNlGGAjUgT/HFUUo+fMh7e1w5vQIPu/50O0ejbr1vxnwQEPSiY?=
 =?iso-8859-2?Q?2Y4WTcrhaNUHjCnwc/U2/7n15pYHcFrIZoE9alM4w1sZTuf2kYySaPEOBD?=
 =?iso-8859-2?Q?ChBA+KmeWrJfYK6ndMWefsk4r23zF7unNVGOM9YWZtfsOoKgOtbgNvzCM2?=
 =?iso-8859-2?Q?wcp5ZitunqaZF2tP180ODp4KDzSKniIj/PYVI7VUsmTXbC6AyGXho3Uzvc?=
 =?iso-8859-2?Q?e9T1wnLGG0OhmKRRTrdIRlZXvSCAUD/gECXF9xIkT4+zLzCGyCCGXzw1jc?=
 =?iso-8859-2?Q?7OepOwzOV1r65+Xcro955pXXFK4EK5O599s8KTbo0n85K7mWy0x9OufZYA?=
 =?iso-8859-2?Q?eU3SWxlPZnxQkSn8uRaEIs/jatKy+KXJi0SGyZAUl5aMsRLa+vsenhgw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97ca5b4-bb56-429d-06be-08db67f0c876
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:20:05.5894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YKId1dqMq2kdKgV6Xlf09LqyNjgk8RoGCdVy16k/wBbl7eD8I2p+cMHBsvZLDXAgQKy+zkEJ1Ui15DBFcpseHfY0ul3sm+jcjPIO3bME80Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9662
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
> Sent: Wednesday, June 7, 2023 9:15 PM
>=20
> This is the start of the stable review cycle for the 5.15.116 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted okay with Linux 5.15.116-rc1 (00621f260=
8ac):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
93074039
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.15.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
