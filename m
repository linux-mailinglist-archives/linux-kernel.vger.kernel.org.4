Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0300962F2A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbiKRKdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241737AbiKRKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:33:16 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED793CC7;
        Fri, 18 Nov 2022 02:33:15 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI9KFUC026589;
        Fri, 18 Nov 2022 05:33:08 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kx0p7jdjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 05:33:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edjmDWzjN+WsuG1ZtwmDuCigLXaf138vHD1HIhETWwoHmknNPpNuSZPApZ4d1HYM40eu0bbY9zK/UMecWF/V9Tm7eNlEE2JIhnpauVufy/zCofodx+K4V9Rgy5Xm9qFmUbC+rGkSjXcN30hS0fS2YgeHABzCiK86yRQTwh6FaD0iYqRYxGNnAHLDisDhtptE1GD4yJs9D3roO9wCCJ7RYncZA1rpC6m8rbbsNybwnOxj+gBoxi3D3R5AlutIPTuRMRX04VJNeXBPyPsvPK6fj3AymWK9rXfTnE0vmfa1+ZdVp6JVfx/Ph2yDHn+uFBviR+HmMo7axAjtYu014TpO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehJjSENAZyClONxeee/u2/h+a4kMu0P0L9icZgG27gA=;
 b=Do5pFpYOPY5kxuNTrzaupKn/bdgkGYFuQ1OnKzg8B4SEH/pwflj3G34QNCZWjVJOaefe2zPcZE/HxLkB0Di4mkfAQkUbg/QYwtBf7mxK57bFj1TVWS0x/xiJG7nKA03tOQf8pWoUY4t73kr8NVEInj1yNiwBCqsY5M3AnQKLXQL94ScAOUhM7bCU33yt5Ab7NE4nCDMSpdn7mfbEv2XsKy6INPgmyZ9nRU+/k2zo1bdcHtdBm4I0HLAUFfhXC4j/wDScoz53/XfjTskhVSn6/OIjuNwFbdnhdpalzmcxqIUmOrH8e/kmVLql0Le6bxBFO72tQTOKr63KbRMq9s0gvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehJjSENAZyClONxeee/u2/h+a4kMu0P0L9icZgG27gA=;
 b=djDNFtmvGBhe78fNe5MY3ObF3z/Yxenz/iRTZeWbujZyXCyaqhm//YGxJRbR0TbxKl+iF6WfONUML/xqgIzsd2ISonnP6t0S7hOE9zaOEq6pRXtxuTfMnoP0zWFWOUW1MGzU7nj/G5Uk4+C45PvS+pcOyHLll5e8o6paRudRFTQ=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by MW4PR03MB6667.namprd03.prod.outlook.com (2603:10b6:303:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 10:33:03 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::a07b:a2c6:abe1:c35e]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::a07b:a2c6:abe1:c35e%7]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 10:33:03 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Subject: RE: [PATCH v3 2/2] iio: frequency: adf4377: add support for ADF4377
Thread-Topic: [PATCH v3 2/2] iio: frequency: adf4377: add support for ADF4377
Thread-Index: AQHY+OJ39zHNcri0L0KekFRAlfFmI65EfPaQ
Date:   Fri, 18 Nov 2022 10:33:03 +0000
Message-ID: <SJ0PR03MB6778D5319F22812F1D2FBE7899099@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221115110041.71495-1-antoniu.miclaus@analog.com>
 <20221115110041.71495-2-antoniu.miclaus@analog.com>
In-Reply-To: <20221115110041.71495-2-antoniu.miclaus@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNWY4OWVmYjAtNjcyYy0xMWVkLWI2YmItYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XDVmODllZmIxLTY3MmMtMTFlZC1iNmJiLWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iNTM1NCIgdD0iMTMzMTMyNDExOD?=
 =?iso-8859-1?Q?A5MDk3NTI3IiBoPSJ3dG5NZmxFcG1tUkNNRC9aOVZBcityNUNldzA9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUEzNS9naE9mdllBU09NQVFIeVNIYXRJNHdCQWZKSWRxMERBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVg1bDJLd0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|MW4PR03MB6667:EE_
x-ms-office365-filtering-correlation-id: 3a7618b1-0bc4-48d9-8d87-08dac95045cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wHX5C4DZOyXtMiA0TZyPjMzggzaSxk36oOn8Tu/648h/GZELsQlgB1J4NiSDq9UIze/aZDeC6pr48o6TI7UCsrU7/mYhAoFIG6SnqYZ53JNjcpKfppJOnm3OJqGIHQjAFUgz05OQ/VBBkkOxAlo1B3FAKugbsWuIkVaEfXtqZBPuWg4o4QRniRZNFSa112Qbe9NMOAzdDgOZslqisihCmjri7ThhX+tVc27T1PTMA62NLOYEe2otBCA3G7KPBAlEeZIemZAkUVneKcdzo+hMawwBeE16DNM0cNaQQFogRhDit5mUGHpqGWJvxBIrkyc7MepKOln0UaPaUEJhrPyFnbNSMc3+wHxoftqRRXZ1aO988+OLk4a4CC5f44Fi/O4ZzB7iqOwdRY93w5KnBqA90wffNzSMm3aPlpSzfkMXyncYbtqfsd0Q4XSHpFGdn6s4EsGqbiuj4HT1zL0zbA++TDc55WfYOZDeKBkb2DKA/4IfmrJyQDZTzKBOuGk7u6/tctjN7uD09elBDHn6VYfx1Ag+/uOMwsg724X0rSO1oSoSXkwJX/q2m0GAW2mLXK+noUbrnTBK7DM7Kc/aZahGIvbo65fvdsObRMcHOcQ9gYdeIhVW6Vftd3RTus/TG1QQVfxwWNCQmWbYmf3kytTNDClkZFyGGyoqQo03qp/CnQl0BAf3Gx8Y3aQPbZcwLuDgLuPsV4v0ZN6d/IVPMEkPye2qudRH5JWVESIfvl/e5To=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(8936002)(186003)(38070700005)(5660300002)(316002)(52536014)(26005)(9686003)(66446008)(66556008)(8676002)(4326008)(66946007)(66476007)(76116006)(41300700001)(38100700002)(86362001)(64756008)(122000001)(2906002)(55016003)(83380400001)(33656002)(71200400001)(478600001)(66899015)(110136005)(53546011)(107886003)(966005)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KBLkTegMI4oKqXWtMwRqsI/x8HvXDopRCEitsdOVzqdREH3dHAdYwlF12F?=
 =?iso-8859-1?Q?lh2/ebGB0ee8qKaf1P88TjP3ND8n0mlPyjxxs3wqugk17FxK+o6iLRrFhN?=
 =?iso-8859-1?Q?cC8NUdrXvu0b7jGoxx6zIrxbbGggExZec9wQPSj0SFK4awMBmlQmqEe6JY?=
 =?iso-8859-1?Q?eVZryJODPwedmwBuDWPCOgpxzG8nG2pBJaZi/0gA2NBMF5oZZAaStfg7pV?=
 =?iso-8859-1?Q?6xwxXvNt74s8Bury7QJioN/Bshhs96zRCm0zNhLu3moYHB2Sjg92gHZ8ly?=
 =?iso-8859-1?Q?ellREmylzDnqfK8ymvkE0io1gRtCtcLZiGAanTAV8MsSZBG9AyGpx0VSYI?=
 =?iso-8859-1?Q?MFJCvYlUPBSo5ej6gXjcBKiQ15oSh99dl6qoJIutDQypswAoLhjMggHnop?=
 =?iso-8859-1?Q?koPVmmK8p7HQ2rNOeMjGx4Gw8jgCsScSiiRIoBUS2D8Jku2mSdQZPqg1dc?=
 =?iso-8859-1?Q?dFlXm8z3QJ4h6CdCUEor0Es0rjnEVyH1zBFSEA6SPSjd8bGIWE282t2vX8?=
 =?iso-8859-1?Q?qJcI72n9N0bzQ0y0NMrNPLt2H24fvhJeYxZKyX3cN2PEuTtsqbaeWhY+kD?=
 =?iso-8859-1?Q?3eKO8gBgC+ZO07oRi4hktT93kTz3ktx8AQ+WbLHOIjMtIKU2mZUEDLs1nG?=
 =?iso-8859-1?Q?UnikxSQyBw+7lH2DX7QhSBXXfJMjd3B/5FoQhQG5G42lAXGWIEHj+HKNfW?=
 =?iso-8859-1?Q?4cEZ6UUrbhJslPGrWWLYsvMz7/UhVncoGvJRFHrzsYxyWLVBtKRNxE81aG?=
 =?iso-8859-1?Q?rJrSa9O0aCK0SDfPb9UGij4kkIHSqOK+vGxqotqCAqjkGR4bKZr/90/JCu?=
 =?iso-8859-1?Q?2fem6s6WNE0SbK1nUJ6hlpK5+GH1BBjsj91ccAbA+VcFmjr/sgp9FyWjIt?=
 =?iso-8859-1?Q?1rfBXB3PZLyAVEv6Q8miUfeJZ62w1I7QBDEcQAjthZ+9KFJ4j49MqNEx+Z?=
 =?iso-8859-1?Q?PNsqESXzU1XvkbXQfkH3nD17jsZu4RfkAwyJ34pIi/KW5ksB0DdCHj+T4W?=
 =?iso-8859-1?Q?FdNEXvqrG2DrYVsoBRurow1Isn4csbGVvUsXS1S/VPNcX6Zr9MlU+PRTX7?=
 =?iso-8859-1?Q?04l80VQbQDgBuWaPexHjYs3UKKXRXh3gFihunToUfUW7scOp0HGJsf6m6S?=
 =?iso-8859-1?Q?6w/mdUINPM83Fmf8N0Gq9QL+4O6DfcgdX3KYPIhQABCWYupVG6wf+CWUkc?=
 =?iso-8859-1?Q?DWz+PLtWUUGkNh/vC7bDWre+H4a+VIF70KauexT5GTMHO4w0DJgCDL0ej5?=
 =?iso-8859-1?Q?WIPvb9cOlrln8R4GZDI9YBDF9eDj4RcUtJNY997+pPgtARPj/ZwTpbTSO1?=
 =?iso-8859-1?Q?iPr8GDqz3SJgil06pUjrzA0IRKJWb6bOb7mmVYfOo/uWopSfSrYpXZ3tJq?=
 =?iso-8859-1?Q?u9VSdePH04zNwjZrVL1Z2HyPhvdWBgGXQGIrDRTcds/H9sPdgd+H6w4dm7?=
 =?iso-8859-1?Q?2tLR8OE+/quoYJfz9NObkADNpwygadJXgBwXRh2ZTX4d5oKVdvlV9Xkn8y?=
 =?iso-8859-1?Q?Nu3Hl9Gou23DdKMupsm8wQwjthjfKHCTAeoqItxPFCLt1aiZa6boQZV8bL?=
 =?iso-8859-1?Q?B2KNNLtPjsXs3+c0JORhr9MSYpfUd5eZgvD056q1AwD8lRmi0OV45fU4DQ?=
 =?iso-8859-1?Q?xVN421Oi9aOgwM3XpjnH/R0hrT74nGUw/K?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7618b1-0bc4-48d9-8d87-08dac95045cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 10:33:03.1255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfFUGGwN91FxBEnLDVNjXz1YBDdwv20Ui9uRLpN2usckbZSz2Pm+2SZUbGzSl+AMP9xHvNmJV/jqUgDKukALuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6667
X-Proofpoint-ORIG-GUID: Ls7ezVkf0tdDyo4GbQ4YIiVt6I9gSXC_
X-Proofpoint-GUID: Ls7ezVkf0tdDyo4GbQ4YIiVt6I9gSXC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180062
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Sent: Tuesday, November 15, 2022 12:01 PM
> To: jic23@kernel.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Subject: [PATCH v3 2/2] iio: frequency: adf4377: add support for ADF4377
>=20
> [External]
>=20
> The ADF4377 is a high performance, ultralow jitter, dual output integer-N
> phased locked loop (PLL) with integrated voltage controlled oscillator
> (VCO) ideally suited for data converter and mixed signal front end (MxFE)
> clock applications.
>=20
> Datasheet: https://www.analog.com/media/en/technical-
> documentation/data-sheets/adf4377.pdf
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - add register name/value for the macro definitions
>  - use `__aligned(IIO_DMA_MINALIGN)`
>  - add extra spacing for `reg_sequence` structure
>  - check frequency value before reg writes in `adf4377_set_freq` function
>  - remove ternary operators inside `adf4377_write` and `adf4377_read`
>  - remove comma after null terminator
>  drivers/iio/frequency/Kconfig   |  10 +
>  drivers/iio/frequency/Makefile  |   1 +
>  drivers/iio/frequency/adf4377.c | 994
> ++++++++++++++++++++++++++++++++
>  3 files changed, 1005 insertions(+)
>  create mode 100644 drivers/iio/frequency/adf4377.c
>=20
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfi=
g
> index f3702f36436c..9e85dfa58508 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -50,6 +50,16 @@ config ADF4371
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4371.
>=20
> +config ADF4377
> +	tristate "Analog Devices ADF4377 Microwave Wideband Synthesizer"
> +	depends on SPI && COMMON_CLK
> +	help
> +	  Say yes here to build support for Analog Devices ADF4377
> Microwave
> +	  Wideband Synthesizer.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adf4377.
> +
>  config ADMV1013
>  	tristate "Analog Devices ADMV1013 Microwave Upconverter"
>  	depends on SPI && COMMON_CLK
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makef=
ile
> index 48add732f1d3..b616c29b4a08 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_AD9523) +=3D ad9523.o
>  obj-$(CONFIG_ADF4350) +=3D adf4350.o
>  obj-$(CONFIG_ADF4371) +=3D adf4371.o
> +obj-$(CONFIG_ADF4377) +=3D adf4377.o
>  obj-$(CONFIG_ADMV1013) +=3D admv1013.o
>  obj-$(CONFIG_ADMV1014) +=3D admv1014.o
>  obj-$(CONFIG_ADMV4420) +=3D admv4420.o
> diff --git a/drivers/iio/frequency/adf4377.c
> b/drivers/iio/frequency/adf4377.c
> new file mode 100644
> index 000000000000..26abecbd51e0
> --- /dev/null
> +++ b/drivers/iio/frequency/adf4377.c
> @@ -0,0 +1,994 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADF4377 driver
> + *
> + * Copyright 2022 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +

...

> +
> +/* Specifications */
> +#define ADF4377_SPI_READ_CMD			BIT(7)
> +#define ADF4377_MAX_VCO_FREQ			(12800ULL *
> HZ_PER_MHZ)
> +#define ADF4377_MIN_VCO_FREQ			(6400ULL *
> HZ_PER_MHZ)
> +#define ADF4377_MAX_REFIN_FREQ			(1000 *
> HZ_PER_MHZ)
> +#define ADF4377_MIN_REFIN_FREQ			(10 * HZ_PER_MHZ)
> +#define ADF4377_MAX_FREQ_PFD			(500 * HZ_PER_MHZ)
> +#define ADF4377_MIN_FREQ_PFD			(3 * HZ_PER_MHZ)
> +#define ADF4377_MAX_CLKPN_FREQ
> 	ADF4377_MAX_VCO_FREQ

Well, I think we are more than fine in using s64 :). Anyways, as the write
side is still a bit weird, let's stay with extended attr.=20

...

> +static int adf4377_get_freq(struct adf4377_state *st, u64 *freq)
> +{
> +	unsigned int ref_div_factor, n_int;
> +	u64 clkin_freq;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret =3D regmap_read(st->regmap, 0x12, &ref_div_factor);
> +	if (ret)
> +		goto exit;
> +
> +	ret =3D regmap_bulk_read(st->regmap, 0x10, st->buf, sizeof(st->buf));
> +	if (ret)
> +		goto exit;
> +
> +	clkin_freq =3D clk_get_rate(st->clkin);
> +	ref_div_factor =3D FIELD_GET(ADF4377_0012_R_DIV_MSK,
> ref_div_factor);
> +	n_int =3D FIELD_GET(ADF4377_0010_N_INT_LSB_MSK |
> ADF4377_0011_N_INT_MSB_MSK,
> +			  get_unaligned_le16(&st->buf));
> +
> +	*freq =3D div_u64(clkin_freq, ref_div_factor) * n_int;
> +exit:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int adf4377_set_freq(struct adf4377_state *st, u64 freq)
> +{
> +	unsigned int read_val;
> +	u64 f_vco;
> +	int ret;

Could initialize ret to -EINVAL and save one line of code :)...

Anyways...

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

