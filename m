Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38D2703E44
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245259AbjEOULQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245213AbjEOULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:11:01 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2091.outbound.protection.outlook.com [40.107.114.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D20B1157B;
        Mon, 15 May 2023 13:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdA+HX8AzPZenIG8KJJy2P1OnaJfhSX6BOS++Ta9Na2zkwifJYvL7L9nYiAHY1gbt6dIFipI+wRY0W0030y13IJl5XH0oZrc6bzjctRGrh8LuuDoNjdNo5hkJPve6BKJ228SAPVbwSP/2gPJVv7klm5dqXMdWbSuBndrYXG/6DsNanTc+ZgFShFrfdv6i7HZ6HMaCenmk1s+E0dlMT6KfEZnebjhARqUMTwTD1QDl+m+QFi3NeZ2i/jpSoOt36Fg2gKOo+WopYeJ1gd6r53BkiI+KaoINQa9wuafFMYef/aJul2l0i/7/YF9H9Z/fY3D2Cj985jiV6takf9f0c600g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEi+3pE3ckDksCjYfYJoXx4vd7yxeAlSbQ9dn8WfD9E=;
 b=ilREY+u9LuLsPO/TB0dFLJ4E6jNj4fsNgIGPC11R4NNhtdbw91N5KAQO3R6WlOPFEN6PMcyHfn0IN9TOGDi8GU1k0snKu+wkCWQtPLJhRxxiAWfTwhXHwJLEY16DpHzShgidUb2BRuAIrAapyE/kvMeJSbGmHqt4leMUT/h6zJI8NIjYNkdg3VLksE6ucQi9PGti9k74cOnrtSn270q0JXfarn9j0EUj2Rdcf899IGnxCGIIuXb40z4nSJMUaGbXKkiwYCIJh3SrYOTdFGtRS0FTA4e9gDM2+wkZMqqcIuow4pzwB7Uv6cAxr4enQREGXKjAcuKGevi56pxlsVBhbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEi+3pE3ckDksCjYfYJoXx4vd7yxeAlSbQ9dn8WfD9E=;
 b=gtV6STG2rbOfn/5COjDoNhO9pujKl2hJfoQLTs5SUS+VH/cNXg/a/1iZJI5KkdVnVy+onZFIu/0me0rM3FD/wbeuA+1cDxvH1Inx2JeRnbn+2lSBN0UzvSopm5zxh3XCBKkS5dD7+bs4IXmD+ArJXN0FI8tG8rQB9uCxNPBtSNs=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5459.jpnprd01.prod.outlook.com (2603:1096:604:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.31; Mon, 15 May
 2023 20:10:39 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:10:39 +0000
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
Subject: RE: [PATCH 5.10 000/381] 5.10.180-rc1 review
Thread-Topic: [PATCH 5.10 000/381] 5.10.180-rc1 review
Thread-Index: AQHZh1PSQ9W1IIn1ckyc1Q5L1Tdt0K9bwwbA
Date:   Mon, 15 May 2023 20:10:39 +0000
Message-ID: <TY2PR01MB3788D5C14EAB0D1DEBED3031B7789@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230515161736.775969473@linuxfoundation.org>
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5459:EE_
x-ms-office365-filtering-correlation-id: 154aa55e-84ba-474a-fd81-08db5580744f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uQ6/zUFB4sj5gIAHfSsmswOmKdCgZt9TKg/J3BT9i2GIXZdltiyBSVLDaRayeQ9885TymU/xWZOaozvAI14MpK8ZlQSFM5D0ZLhjE6m8qihHBjmt1/UnS6QaO1tbdr2F/dcQBlDw9a15aLKoR2QuQLL/k8bR0anC9d4CEfR5/RXTqS+vvMK78EhKpEb/zX+b7jMwRHLzkLbEJSQbL9How3BzPFgLdgdFsLE8qmIxTXvJXA32hO1pm7PcEH/X2THsIExFHp74Rnw5Xc46nFmAhyDLJmxYJf1uRwCXUYARuZSLh5YYwBS/sJyvFhwzrcBbzmAG5T0mSqg+3s/uEupH2WiSWe2DhH+l1GDfA8TX6bkxqo4f+m5226V9cnn82fjCncWijGZHglzgC4eOyQNaZXF1dd+Mmy0/aMQB83gNBDe7N1HnsPCgWoLCxtb5gUYKJAEQ5cduLh1Lw0He+WdPcqp0vnAJniiAXUAn+/7nnle7BSmx5u3OeeW/8umN9MKZlQSgCRVaBamhzz3ymgvxA+usH4dVjal5g1RydDpkVH0mB069T8Xnw30lggfYl2ursV/hijCihuSQUBbbu+qJoFw7k9LnLbSJu9q7UZS+KLjGgKL0zQNRFnf3/Y7du50EUsxD7LN5GrDSgIPPnPh6Wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(52536014)(8676002)(8936002)(5660300002)(7416002)(4744005)(4326008)(316002)(41300700001)(2906002)(478600001)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(55016003)(54906003)(33656002)(110136005)(7696005)(966005)(26005)(186003)(9686003)(6506007)(38100700002)(38070700005)(71200400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-3?Q?pyRD42jb4wtivmkp0/kQYMEp6JW+YsHhuDAg8Rf4uAP8pvpHicWi4uYhiz?=
 =?iso-8859-3?Q?ifVMoHWgVstHArLbLXBuRjHK6Rv+XDpwo6VtHHTIPwrjsWNB/wC2RusVxP?=
 =?iso-8859-3?Q?nY7pgXSudAdYzbgiQT+3G1KTq0O8OhiAjtTgPoFiPYKz1m0q7fIZyAqeMX?=
 =?iso-8859-3?Q?KBCd0d87Lh7BszGNE/tQA58e+oDiEXa3xq69k9/I+QApbj7nNfXxwWj5Hm?=
 =?iso-8859-3?Q?BDKRZG0WZEz3ygvl5CFYR0m/YwX24PVA/UAxShfVHg71qBYKCEZRIgisK6?=
 =?iso-8859-3?Q?R1QVbUSwb4VVt7AHOEonfS8Uh7J13ZvW/ObS/V3WMtvQuIP3w0keY0rUud?=
 =?iso-8859-3?Q?EdSw41kANps/LXR8yA/6cddaKSJECcHyPiJ6T6N7+heCjtemdcyP+fNE/N?=
 =?iso-8859-3?Q?CR+idHm49musRcNblLwxDapKdWXwa4uDOEmk8KPyPVQ8CHNdH06MuHNphU?=
 =?iso-8859-3?Q?vWdXPf9fgozAbSiUH5Fhgfny4ywUmjxx6faaYUOKgNXPeIBrgv1vtkrNya?=
 =?iso-8859-3?Q?6PiOEcvrR4aPhJvRxnLdW6iSFUuCI/Z0BuQJYFxysq9eN0DT1TKpC5RGiv?=
 =?iso-8859-3?Q?K0pMgoPoxK4IKJd06ONQ5T/WUk1cPqAx3AoJ4oa57rCS0hxIEGNZnT5+Hw?=
 =?iso-8859-3?Q?k7RKZxGjH73ZJyPbaySXM/EIVpHKZdO7FpVzV8COWZ4MrGC+j8uladFya9?=
 =?iso-8859-3?Q?d6XDePF0EAlP97/rdfVTqmVha4eZAFL2Jctza6+FTF+1Jw7H6wpvUqtoLl?=
 =?iso-8859-3?Q?w0qrhFCl3768jIqdd304dp718nfatWxhngYyqhMnYvNtM7Ra+yZSO9oxTi?=
 =?iso-8859-3?Q?t+Fhr//2QViAna+cQ/foNACMfUur0EkNIS+FTqT3Ab5wSjRgG+qnctPVCo?=
 =?iso-8859-3?Q?piNPkCgUCvVF+BUA0L9ZLum8hFdrSwPRDAUwyQfZRynKpcJaaM+dRuPMOF?=
 =?iso-8859-3?Q?VFnc+oghJoqSxMqtrjV97A8/2C3ZbdP1NRWVmDvCIQLgVjbQORcf2tb/EI?=
 =?iso-8859-3?Q?+aNaJqA9LzhQxPhMbEki/NG5EivxMi5xzgmo47aZ/gcevQia2j+jCRqcyf?=
 =?iso-8859-3?Q?YaJY/OnNGXI8Gs+2cR89UX2onCa6QNUTBSpcnoGS/vzEcJ7TX9f0zCRMl4?=
 =?iso-8859-3?Q?4qfHDFKcgW5ZlvY1/brOoSmytncOwPvfXF1By6R8Zkl5+eByWI3uH2AqNQ?=
 =?iso-8859-3?Q?ZiHZ65GCbb2/QNkyoVa6ccVDLC3lHcSmFexYag4OdBrkPUUnz50M35dkLv?=
 =?iso-8859-3?Q?Q48vG6n8aojMDQsQpGUpLXlsFrzh4IS0ruTBnL8am/QQmoY8ib+FvYceqb?=
 =?iso-8859-3?Q?bA6EAkC8PqAjgFR7VBF7KtsIqKHRJ1qNMhXQUe4bM+dTl01WYToKAXl9s/?=
 =?iso-8859-3?Q?FWfSR8oBlmr39kVbbM3OXLs9pM7wSyU+aQqVokur0694zy4FcsEm/NZM3Q?=
 =?iso-8859-3?Q?QalovY/pScbsxiW1WImL5ZyOWgvbH3Ikxxwcm25mWyoFfp606yHTrdfAz5?=
 =?iso-8859-3?Q?C+M6NF0ZsqHdjHzJuoRLcJjdwlBXHbM79a0NSQlCsvQNGmSIRK19s10Wxj?=
 =?iso-8859-3?Q?amjBhjH2JRGaq+H32c9wp3VW+iJsSnpnYdlpcvhxjJOs/2MpLr0qXXvt+I?=
 =?iso-8859-3?Q?km2/EaYyZ1ci7YiGezHkoeq47EN4jV0QlWkofjp+wiT70CdID/chjR9A?=
 =?iso-8859-3?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154aa55e-84ba-474a-fd81-08db5580744f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:10:39.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R59qMFCzOV2y0XIb4BQXi7fPMR1QYQrAY9lRFLpEkR/OLXtp2vAMLymgj/h1Jg1UoT7w6Txjl6XU4OcnjFI6Bo4UAZqyR4ukYnZdw8lhAC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5459
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
> Sent: Monday, May 15, 2023 5:24 PM
>=20
> This is the start of the stable review cycle for the 5.10.180 release.
> There are 381 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 5.10.180-rc1 (065b6901e6da):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
67957631
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.10.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
