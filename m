Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B0F6F3D1A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjEBFkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjEBFkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:40:05 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1C710D8;
        Mon,  1 May 2023 22:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlY6GVJRVtxmbQ7vPQh1JDMfftj/Qy6cVBBn0CReWpY86cERUD5/ZY3sT8lHhRrMy5CIu4LiBHkX2vptCMlaY3h2iSN+a6cwz55uBbX/SMexJffNj2wGj05OVXXcBbPEAe0uQl9E/ypbsgcTBinLbgGhSxpxAMMeru2RrW41CydU/Y8xEuC3ad56hGRnMqpRH7pgbvVhY/wh7/IUZagB70MMZLEJXUEcD1pS8w2mzk5K8sDtb/Wk7KAhUBcy+vHNSd8K1WKHJRWp3DXeLPOd6L6GRijWiHm5V87jCeD7n5QU8sfzC/aQlCLAFThpdHvf882fy8Oy4ZOhNo3Ab8gDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE52E4H8oAEvLHUBYRtbu0b6rpx/r62l5FnkO4D1uvQ=;
 b=l8gsVjkKYZ56xxXe5pa4eBRqLxgSv7tNn+yYeA5WMrgOxg/FrtQXRy9j5xMP/2lQaBQmDmOcmBTKbbaT+feZObo9xSdX9/Hf3ewVLOUya9o0DZghhban9YG8y1H1RDyZQQLMpgPvtfnxgfzGUyuCTfydn1hcIvdeS83SFnFhkNl/Wkhcl5gB/nZckshSbZWhlRikJPYW1bZwoDc+iE3Cp9uCjUPesgShGuC6Uy5ua0HnQ3Zx3Q6zCMR7YWjiCQm1yt4g9lo5TpWx12yPrlbj5LHTYQrDFPFGcX1d4DZAFJXjMjwVfnXT/54SsjUQ50aatl+mA7YPtdMTimATAxtrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE52E4H8oAEvLHUBYRtbu0b6rpx/r62l5FnkO4D1uvQ=;
 b=Q6BaDUBN+mbLfxx8FI8u1+x4vR/9pnD+dCDCVdaA2G8VGvJh/5jvVVJtMER52PfLA4SRGloJH65YlL4BMZ4OOGrJFWy0pRG/jNXqHSt2ptuicASH38h4sZW14GZKFfVaq4PMBH1lEenH+rouxq5ihwTUKqq/kXFF/w9UWKOnHhM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB9389.jpnprd01.prod.outlook.com (2603:1096:400:1a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 05:39:48 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8b5:5f09:5a0f:370]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::8b5:5f09:5a0f:370%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 05:39:47 +0000
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
Subject: RE: [PATCH 6.1 00/16] 6.1.27-rc1 review
Thread-Topic: [PATCH 6.1 00/16] 6.1.27-rc1 review
Thread-Index: AQHZecTJHg99utv79U6y0DsFkpreOa9GfBrg
Date:   Tue, 2 May 2023 05:39:47 +0000
Message-ID: <TY2PR01MB3788B5A4DCC629A35BB7F8DBB76F9@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230428112040.063291126@linuxfoundation.org>
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB9389:EE_
x-ms-office365-filtering-correlation-id: cad596d1-56e3-4b40-46ec-08db4acfa443
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uimue0v9en//UxUAOUiexdlDG3w9PKFhDcQXSG6f8JXGjCcBkYrPDJauOQVT1cl2uVrBtfXiKD+cQScu4S6NkhbmbfA6SmULL/WMbblhDYvnproNs1HIici5yUy3g7wMw3FJ3Bf692mcxtVF/HnlvizWIlqKUX8IY+s4MSN+BTzjngzHAIS6yh9uOcN1KUUAJYrUfKYXyMrSWz5tJSo/Pl8S11ikDOSnTYiS/Zn4W1+EF9M57PLYWstBxop56SkUEt2216G0W1XT8VvrZOWDueLGzHgJWSdONBwK4KJhLMCWZumHVCJUxxcDwNJpd1QX/CBsdzYGUhucKzDE+36JTrd/tnC6FYBqVjAKti4sM26IQNlsH73QOX65lts5KEd4F/galOxjwapAhcXZsC6U9/AtdSCJC8xCqiwx8SmX+iR/FlQPdfBAc3nEF3TLbsds0j2DDs3VmZ8kFJicP1PmGdNS+CSsb40iSyAf/d/MXK5Yj7lZwODzyJ8w6qjEBx5dQ+Wzl2iB3S0oriItGxVMRRifCBNKJGUBe6hdkKJcWBgENwnvuUWpaSd9nEJVLXZO/S0joVLrscdDVymaws1kG+H6XpHYpF2iBd+FlRJpSzeV10Sku851GfRJkumVYIS/D+1OqtvutQxak3F0VHYmgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199021)(7696005)(316002)(66946007)(66476007)(66556008)(66446008)(64756008)(71200400001)(38070700005)(54906003)(4326008)(41300700001)(110136005)(76116006)(86362001)(33656002)(966005)(26005)(6506007)(8936002)(5660300002)(52536014)(7416002)(2906002)(8676002)(478600001)(55016003)(4744005)(122000001)(186003)(9686003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-3?Q?IhUQj8DLrOp/QOiCbKDQqZTCsvpdXwMZkdim0eNi3UKzZFdsq7ZdUuBwVa?=
 =?iso-8859-3?Q?mAeJL3fdPl8SIlyel2egk/B5qnZA8tia5ocPDEQlS4qVr6yBNTY1TyStn/?=
 =?iso-8859-3?Q?u6/p4/ZDq8+EuweAIQbVa1L4lg6K1Sg7jdgmd1NHCXQazLHcWR76bfIT4s?=
 =?iso-8859-3?Q?g+AgZ9MySvyAZ0xcps3rXI1HVdJQ29sW3iEwGXCaXDhWP92rhg1KkgPNcn?=
 =?iso-8859-3?Q?9FEwJfJjdyRvYufn1H4EuJb7o1F6tcH4IK2Qeywa/V+G2EbLJMGfKxXIrQ?=
 =?iso-8859-3?Q?9TLXcSa/0EAX3W0k7v7mZIfHEWGqYOJ5m4Yd2OjODUuZyr7hym2K34U07B?=
 =?iso-8859-3?Q?TDkR8IOt441DGD/a1fA5FJpxKjKNB/Y7PDpFAGhU+h/4wwrv5EguyqpwEr?=
 =?iso-8859-3?Q?wpfGJdFh454ViLwaT8N+KPV9QgKbH+53yTMg9VGw2i7cl6PpmUDLr4jIOu?=
 =?iso-8859-3?Q?dKQ2uzoJsGzz5DQpU2azv4toUq9JrimerEXOQBx9LeCvNbr9OOybAX925a?=
 =?iso-8859-3?Q?7skUJy5eRngQzufw734XWn/oavAT5V3H06Yr8tW+vVQiSt8ywYRg6ZrDOD?=
 =?iso-8859-3?Q?b6BYU+cTHm1O7qiE6tVKDosn3071M9t4/Pc01HAQKcGg8CqxWPPXE/rCWn?=
 =?iso-8859-3?Q?5/5qoFSsWjvpOCQ7OxcKVSa4/+F4toWJ0jCXOaTrqTihkSCasM62zA5bn/?=
 =?iso-8859-3?Q?Ayjklbs3ka47w6JrXPgEx5wLBswCqIMLRhuio+l3EY/WoFRs729P8Qsr9U?=
 =?iso-8859-3?Q?3DidA1aNuNCLBQajzkifz0xM4ehkRkL1N9kst9BkhHIsB6cKPAgtpRSzkT?=
 =?iso-8859-3?Q?5SgbcJ/pSSg55xYxShFB+5vpYpCoIDUxJT/G4zFhPIjWNUbV9711NV/4qE?=
 =?iso-8859-3?Q?G3gGT0Ir8ycuIL/iD0Drx1htRSAFAtBN3ZwPHYO+qJZKaxRN+pf3JCAF+u?=
 =?iso-8859-3?Q?4dKV/TdvzcuYJjuD1PnsAD/5IA4OaQrLR09TY9QSU6GYg2UkT9BSRrLfwI?=
 =?iso-8859-3?Q?mMQm7ak2qfS2PKD9qpzVggqlgMgwp7SQOasogKW2by24iVmcR4cTGAWXZ4?=
 =?iso-8859-3?Q?9pDcauxvoS/oHvCN1mlgAqmDah3/U5eVXF3HOnjRi3zw3R89slhldsuVQA?=
 =?iso-8859-3?Q?B1dUd2XnwoCUgiD0hr1gOdK4i609W3tdZlJBe2pKudY9GpKw6/d2Yuuvq6?=
 =?iso-8859-3?Q?AcLtbR3DVA19G+chBwEo9tcQdhN65n/s02y5yjCPhyz/qXLnhWXKVlntqy?=
 =?iso-8859-3?Q?I1h6P0CdgqqYHwwhNBXvjt1ynAKO+Xu/19O8NLgLhbx4li+hb3IWz2fjQM?=
 =?iso-8859-3?Q?fVoerKeAYUdq+QrqH7ihNvJCFMh/sfsRDFUKhZM7facGQOMTbGo6NJI+Pl?=
 =?iso-8859-3?Q?y0DfK++6ai1COiYY7AVRWCKn0iMD2OGZUOsYcmn7Vwvqw2mdGRgi35kD8m?=
 =?iso-8859-3?Q?OYDeg5nRNFs1UpawNdcYY7kvfmFfnsA/2bOoXGnufJlrBcSEY4parusCZc?=
 =?iso-8859-3?Q?q9EZheH8PMg0pPvg3Lccgjmjsg/pIzn2Kc7QYlj4WEaC1LGmCv7X6YGuEJ?=
 =?iso-8859-3?Q?k8j07OM5ZNjLETmpMG4SOivD1Xe5HPpNR3/eRiovbf9cH0xCR9NKkppaVi?=
 =?iso-8859-3?Q?41hgBr9Ni+LYRoVNXjBBnsdOiIltYJ9GTapfv0Hjd5zEhWYJArvn74MQ?=
 =?iso-8859-3?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad596d1-56e3-4b40-46ec-08db4acfa443
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 05:39:47.7045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBb96opOQ6it6vgqsQ6ydVKU6AalNKHkU2fsD2sZVX/1Ts1VZVxVTYgPO0ghMowmLZxizrfyaQM1ASSrM8IRRsVFFSnPUklBnI/VC6GZVe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9389
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
> Sent: Friday, April 28, 2023 12:28 PM
>=20
> This is the start of the stable review cycle for the 6.1.27 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.

Sorry it's late. Weekend & national holidays in the UK etc...

CIP configurations built and booted with Linux 6.1.27-rc1 (58b654bf36db):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
52034519
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.1.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
