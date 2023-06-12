Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF86172D39E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjFLVxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbjFLVxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:53:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2099.outbound.protection.outlook.com [40.107.114.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6EA10F9;
        Mon, 12 Jun 2023 14:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSWPG3973XDQVXKx1N4l6Iur5qgbWqNFenlEUnqy2Zx2Q1m4coC4++aCKJiALxFwDUGL/UBNnq1ulW6hzNhNaOheWevnzTDdjFIWQ4MJ1ElmRONs0Yx4LuyAtWD/Zbc8jFBBRoDAqSdDdifpFecus/QM6s11/uIVPlvqaO3HOy8yoXdNt1VGgxKMzvjoRCBgwC9QEcXAVaWCeQJUOGiFamY+YPPkC3liDZa4S9mEfWyDk59KKXcIH753qRAPt6xHiqDV3Ol6ho1BAhbFhJKvNaDyGGnKw5KSybjoE3Td42Z6DKFV2dB6+mNSw6db2GTx1XgiyYj2sp0r/DhyB6wzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o99FOv5ZqZMeF4TU/jes7zkplth9D0lca+wPjdBJokE=;
 b=QRtEXf5UUzlGt5fgFqudvlkk6R2VO2zZd7IJhjX5UR+CFsE3h2RGGAWKHczmgTS4afeVamxto7aDuMukfnQ8v+yCYBfZDI58YkiN+rab/9ysHvhVNpZNmzviDLdDFD7lDLGrFa2UDmbxhvtPR6LcOcgvVFHWBl5vF29vOtm7gaAmonQH/9Onfg54DAU9SznlHyeO/yfnwVz1H0UUQ8VpbXf8OkYT+GhQuY7ZGJDSJAKNPgC9x+k6dBax7Q8YMvexB6iUjkQizqurqvvCap6u7kW46DwKKfljHtsSticrKqntSoYb4E7UiDWB3dGFlNNrk6BHuJ9ZPA1iwkQGDC7IVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o99FOv5ZqZMeF4TU/jes7zkplth9D0lca+wPjdBJokE=;
 b=JpPoaGLDUMfNM2DCoLZPyfX1OR0ccrK5gqgViS9veIExUCVTFVMp4krQaaE/MJnj+NeXWNujOxbhQAWn9jOsJGLxDeBGr4u95Se1SOzMaR82vp/b5lcOc5Qwy7IHi3pk+t/5T3uaUF/Qqt6laCVs6Skm2jeNQ0S6PxbHf8tbPRI=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB8680.jpnprd01.prod.outlook.com (2603:1096:400:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 21:53:14 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:53:14 +0000
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
Subject: RE: [PATCH 6.1 000/132] 6.1.34-rc1 review
Thread-Topic: [PATCH 6.1 000/132] 6.1.34-rc1 review
Thread-Index: AQHZnRxkpLFT31A0BUq+nKFZbX/S9K+HtOew
Date:   Mon, 12 Jun 2023 21:53:14 +0000
Message-ID: <TY2PR01MB37889370E317ED5458E5B82EB754A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230612101710.279705932@linuxfoundation.org>
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB8680:EE_
x-ms-office365-filtering-correlation-id: 99dd74e1-c151-4b73-e4fc-08db6b8f6c4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8LwlYE3kPkduotJh/DEWyheOmTEn7AtMnd7wXEsuKhO7YCe0E+1cJ2UiDsb7W3rNHVk5rd4CdXwIgHQLT0FgOGozmf0j4U6ZeF77HCDdbacnTjPkbSsWnpMrSlvxSBWWMvQQ1tLOUBwv+PDN8xuUllUhheKk7QdTVSpyPwyrn0srIkhuyBi5aV9j1HMXGNobcXiXezbNhjnzE0jhgV5iZxIRFHubYru7RBHA8Y8Caz5pplKZ1jgTss16Xvv750bzSDOJ1v9bToxvVmTz9J6HvgF9SWVdm1xP3XX/0IKO5mJuy3OxSLgfnNQwJgiQaV3okwpoouW0sfgQ/tTe9X2w5jaWuIWQ/9wwtet1KTi05FLI7XKiByXQIRErPCmy/vEsKehzwJclOLyBr2z9OUbi5y+FyNpjHmuc3xLq4ta/J/UVc+9qwRch2kKzIqwGGG/gVrKfC2ugNN+9ypnco2WV86bFPZbhLq7t7cr/Ya0koMIjV1e7JCgHoAf4YzecxN3Fk0CU67rzPXqZl6Sd3CA+WT9Ng37G+EKvK9jlb9O5LbLjNDmopXb+zqMj6m5mVO66gAbqPb7atwm9XqCiHiO2ZIkhdKBD6poxKFEO+hYbE7SghEYwxZAl0+CYWBC9YAYui9kTD5ligR2smSGvKmI/qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(64756008)(66476007)(66556008)(66946007)(316002)(7416002)(4326008)(66446008)(41300700001)(76116006)(186003)(4744005)(2906002)(110136005)(54906003)(478600001)(8676002)(8936002)(5660300002)(52536014)(71200400001)(966005)(7696005)(6506007)(33656002)(122000001)(26005)(55016003)(9686003)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?u53D5JbxA0hhhQlEZowJVr/gjmfasuQ3UdMfRA8aTUT3oU1Tu69LzzDq?=
 =?Windows-1252?Q?o8qNUWVJglVq1ewKzgvBhPNBlkhxnVuIUBsmKap1CBs3TBC+lQlVqlac?=
 =?Windows-1252?Q?UaS1VhzzkaxouVJ/CYfIGjt4gVvZ73aQdei0TCXZtaepyzxqrEXqRtEG?=
 =?Windows-1252?Q?f3GMmCTow2QCFfmpZY2p/ijZZX/ORH5I56z1y5QhnB2dF8ILa/0zgKTB?=
 =?Windows-1252?Q?HpXg5Hhq1iLn8NXK+4CZd6EIuxTO52Dcgu32NCitdBcF8KTuUiBI408a?=
 =?Windows-1252?Q?b0ud8kI7mziiGV38rShlyNLP/K1nR454ipSkAl9YhZDM9wKN4mfDsknq?=
 =?Windows-1252?Q?slMCzjBDCdl59/YSMPOgV8SWGW5XGL27chRH6PbW+rtxbVKhE2m+FR7K?=
 =?Windows-1252?Q?RbBxyzBqv6esk5pq273VfVecWiV8sh9UwdIyhUsZfc9VCASQQif3eygK?=
 =?Windows-1252?Q?j6gKZzgfweEDfUOQomnz2EJuqxO+wCAhhCvjwujr6rWEoM1DwNpG1zJq?=
 =?Windows-1252?Q?XfDFrNPtgjbdoQo8c1UiuZqLuTdsnUpfsmn8eR+HiaGhksgMp2zAxZb3?=
 =?Windows-1252?Q?tqLY84+7VhVJC+vrT9TQm/EtfMq5Fhujsheu4ckDxJdes07a+84bFv6C?=
 =?Windows-1252?Q?uVyeyl9ToKcmbE2CDazhxGaAkDYMr8D/0gS2CA0kYJflTZ+2wbwRzQDl?=
 =?Windows-1252?Q?dkULDwfewMPqFeYAhDWKwqDaQ9IbyI3xmtjZF6HjhLBCBUvd5cjIAdXb?=
 =?Windows-1252?Q?d3UheK1d+XDu6MK7fjNUshpYkLI3URf5R1oQjvuh5EOqyHptyzREYxtX?=
 =?Windows-1252?Q?IYkFD+1xEWLKO1d/HFTfn05a7Chxm5YDlbmGRPpX3/X5GxQXfxYbVoYK?=
 =?Windows-1252?Q?ETR6EdtYA1onXlXkYrk2ArBGz3C9vrjCDywo1TDyO+8sivToRtNza2NZ?=
 =?Windows-1252?Q?shKSRoIWMXmTaOKc8YRx+8/06gJ8VcWumv3RhGBIb6bKE2pgHIjDXJzU?=
 =?Windows-1252?Q?yTYQUNHTT/46J7DsqebGxFrDtqAcTKuYN2/ci2NPy7OzjWgC4wOVJ4Ws?=
 =?Windows-1252?Q?e2OmTka2IIzrYSYlJFl6pgR3mWduqlFPamdxzk0l2reROwu7lnx2cCDq?=
 =?Windows-1252?Q?qAH/l48RFN0W5TUSt1WhrTvu973HmVrbIeb7AHPleXiL3af5zZ1xBM7G?=
 =?Windows-1252?Q?SUuYpiffDkCkIycrDDokFtz1cvCHZ8IHHdLLkbP2q9TGCO4dbxZn37ph?=
 =?Windows-1252?Q?fQw31gs3/X12FZVGmVF9h/2jk6PsXHsPc23+hJPu39pOp+C32rH9XjyA?=
 =?Windows-1252?Q?u+aNyTy/PfGEcpW/SR55UlqIKyNmuiz2V1m5YyId0mtCGu+m3r0c3hqd?=
 =?Windows-1252?Q?gLOyBEfDCuRUr2LMurhfFa6WDJv9o8l8Jhbj7htmeelV5UeK2H8IZORc?=
 =?Windows-1252?Q?s9BC+eQeaHMys8g3ZP/OgF6xO27sTvIpHHEKa6YRSgLb6BGHdj7HKI9t?=
 =?Windows-1252?Q?5E+RfkbxmteEBNTDraXAyaCsRVYxU5jimaOmIIve1aSMDzyBC6bL5QCw?=
 =?Windows-1252?Q?YlTRn8/HnupV6vNB890nhH6VrKtInaxpIzrVtWlhtQaRA4Pcv1HVy98s?=
 =?Windows-1252?Q?qKarlmCI6Na6066YwjIGtv6A6OmncWqN83tRlrPb5YzS1b71Fj3zxaul?=
 =?Windows-1252?Q?mhu0ldeCgYYU2YdoitiNTSPLPs4MXOHBXO7izwKG+92ogLlueB5ifQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dd74e1-c151-4b73-e4fc-08db6b8f6c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 21:53:14.4012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UywlWU1w4T8v23CoTud5wR7WEkutmcgPZaA4w/YUA70B5ljr3HE6+414Mkb689gQsEJbL4693NidXAKDhv31/wlP2HUHq6o6nKMuXlKep1c=
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
> This is the start of the stable review cycle for the 6.1.34 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.1.34-rc1 (08f336c8c68=
d):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
97026254
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.1.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
