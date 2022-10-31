Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00124613479
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJaLXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiJaLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:23:41 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36072C1C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:23:41 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29V8RAox022925;
        Mon, 31 Oct 2022 07:22:47 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kj640hnwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 07:22:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWYscbgRC1ZwynnpmBSe4t8xkCQqIUanHFIw6CRCQ2IriNqYoCerm5xIrNvyV7TwOzckRQBnGw04rCfzcMnAEZ6obV1cfvbEvL00nOaSuxd0Jp7ZwnJb+CoQ49+teeBgo3J++DxnaeVDDIyBHe04uIutZ/a8tj+NkBLjm8a6oJQIbi9p6KxjX6psVvVK9GQBhArIYCaeyvM7JmaEqjVpz9LdOVFkow17hiZn30rBE0oQnoVcZs0xdeRAXJ2RsAjYSsz31iof7Uz1VPkPFnNhW8ZSE7CSCU/nO8EMddHwfjpZQNdLSll3Kai4XH3ROj4WBt0ovBH4EMjp2tshJB1N2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zgSXKIWpuORmDNIkZRw6UwARtfTCOBPhBT/p04bP8s=;
 b=mfaR3jJSt7ysx3KnWgW4FOtQ29uhwzdTwptpKNEz5/A4tu+vpW6URKmRHDX8NP4lj20J9rgaZvi+3zOUNZHzSUM06tKes7ps00OO0rqKToOw/M7F6a87PmXk93B1OkJgMoumVwY8LH6/YvFvw1mWiF8G68jncqpOKKxwL9nNJtFBJ+Z9zLN907LxdhvR/xI/NbgvjRrJazk6wq5pEl+hQ5KXoxQwPTB/6hOKhodyWD3W1e6QpUn5nAzCooGOWp9F4Yy++R4Hh5ghHe1o5ctFC+QV/zeRYW/6WyqDoQCmmYFLoiAfQJ8gBqeol38Ea5X1eASysgF6y5XHppKqsXmWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zgSXKIWpuORmDNIkZRw6UwARtfTCOBPhBT/p04bP8s=;
 b=FVoBnmkAxXKIzhr7kheOAYMJX4cehzsidO4lTHmdbbAxpC6kqHJEm4bGX80xbvF6odYt2JHP77VrPMjFW3QXnHgwI9ynmWLOljN78AdOXjD1AKZPawqxzZRBl2gzymQzNwFlA4Oek0PzcefDG1LBp2ZUxxNozcCZOFqaTSZ3i90=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by CH2PR03MB5222.namprd03.prod.outlook.com (2603:10b6:610:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 11:22:44 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd%6]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 11:22:44 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Maarten Zanders <maarten.zanders@mind.be>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] ASoC: adau1372: correct PGA enable & mute bit
Thread-Topic: [PATCH 3/3] ASoC: adau1372: correct PGA enable & mute bit
Thread-Index: AQHY6uG48hUkX/xYHkCZTBFUr3RvVa4oX+Xg
Date:   Mon, 31 Oct 2022 11:22:44 +0000
Message-ID: <SJ0PR03MB6778F2F397C62329B3B4D67E99379@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221028152626.109603-1-maarten.zanders@mind.be>
 <20221028152626.109603-4-maarten.zanders@mind.be>
In-Reply-To: <20221028152626.109603-4-maarten.zanders@mind.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNTVlNmE0ZTgtNTkwZS0xMWVkLWI2YjktYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XDU1ZTZhNGVhLTU5MGUtMTFlZC1iNmI5LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTIzMyIgdD0iMTMzMTE2ODg5Nj?=
 =?iso-8859-1?Q?M0MTAzMzAxIiBoPSJheXI3UzljcWcyN3FVMTZBOFZDNm1TUGY4Wms9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUFGNEQ0WUcrM1lBWnYrU3d1L29iZGltLzVMQzcraHQySURBQUFB?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|CH2PR03MB5222:EE_
x-ms-office365-filtering-correlation-id: df1ae13b-4892-4e99-eff8-08dabb323b93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3y5NoCyk6sr6Hza/itWkOaNj/EqXtWftWVMg5BLVmuKtuJe/yepvMukdHLUx0jgVixQzgmH1iD7fC9zP3b/pEghV5kNFnWDYE8hLyoAiT5GAijE+tMz3IHmR73veDz2R1XOHNPaOhQohfL7BC1/ko/lVxTBCWChF556NbuCe6s9/l5XcY6hOGaI8mMlB/ZXOOowGE3ylhGuLQ4JRsv5E1m/Ntta8So2/c521Jz9c6BKzIDYehssV0jtzBLqMO+7HiGU1V2ndUTY1hjn/Yss2KuSF0cMUxE816YKFFEuSgAy23UWWf8TYfqm4qh/e8jbuN15s6nN4zkPz0hMj/BN4qhQpNa8qMpZ2ZjiNj2djm65NeMDMAPi/fHKrbh2Quo7fLt85J9w6oIXGyUFgGR8sbYDy2bDjSkUaYdhMkiCVEyyG7QUFqI/xBizUZzv1WY30JbkCHqwMMQXYeW8XZ/P9S8pHYk9BQpuvQs51Ou6lfJC7CYDVaVmuAN3voM4grhphOBJjCCGehbiQNTHlY3yf/oezlQOjbHJauTfxFwor2Y/IaKffWOXktFm+KSQuBurEQFKOyrFm1r1DT9QvP08m3adkmENs715Id6t8SAG2ImbZPPnc5kmJ5jxZbqh0qmigr9PDiSlEdDi0HywZXPPGqZx3ehiZzjAy0Sx8XHwodDcmTcflo3F9rqa+DFLGE6OUtOdxjcL7x5TV2neYAfiKOvS3kxe6wXbHT+cNQvLiiWfk5sJJFlWZeGMkxExtXeQ9YYJS++HpwnEYSUdsxXMPkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(8936002)(26005)(9686003)(478600001)(7696005)(52536014)(6506007)(5660300002)(53546011)(38100700002)(55016003)(38070700005)(122000001)(2906002)(33656002)(4744005)(86362001)(186003)(83380400001)(316002)(71200400001)(110136005)(54906003)(66556008)(66946007)(66476007)(76116006)(66446008)(4326008)(64756008)(8676002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?89KqZU0HdUChJzNy62YzQuyW1qw0+yI6juyJR4eYGYiAQMsyW4AFF5Jyu4?=
 =?iso-8859-1?Q?STrl4sgdw86rroXyMszzqk+VrKfkrBcBT09XVJANngAAFoAdzNPlGEnpSs?=
 =?iso-8859-1?Q?B/Phz3SjC/+ieSjEFrccbUJCXdUSpW/RtUdBlBEV56hXd3qHnqe45PAFGz?=
 =?iso-8859-1?Q?n1FsQntwYY0HN71kULxkv+XmHSwOY2YiVvLpgRW068A1F5/8BfuNhGWNM/?=
 =?iso-8859-1?Q?dPVrid0aXUPs1LZBbSwfUFtYbxPrRCg7G3qXGapW+oCTqD5nSbJE4IUmRC?=
 =?iso-8859-1?Q?C9sm3uIbref7nHFhH0ai25twHev+vB2lYYfIyNdCC5htj3q0j2NCu/PNAa?=
 =?iso-8859-1?Q?LAlRU1iB5ATfeeqYwyfknEUPSjkfKZbb38kDS17GGpTg/kHPixTovCknk7?=
 =?iso-8859-1?Q?y15VT3InGSlIOYSjIH2lA5ZzKHCo26ixWkQScdTNeRSngWxh4EzbqgZ10E?=
 =?iso-8859-1?Q?FjmOm/j76HrwlAF6KyD8pXNLoOr9TN33gLGJrDcQhX+r+kaI11aqb7kVtO?=
 =?iso-8859-1?Q?C2eytRiD2SUKBMXLjssZQQfjY3tPT2T/000o2YsE6rKora93D8ZVpzHB6V?=
 =?iso-8859-1?Q?g13aZQdkQCA97ZSmvSWsmB2J6IBenSJyUIT52I2vqTfyw310DHZGux21Ld?=
 =?iso-8859-1?Q?o7MOzUP0EAxUaW9WRx6TlIN81CMJMGPewnSOy5OmDGbixPgwXUAtgu04sg?=
 =?iso-8859-1?Q?vWmTPJDgljyKVsVwtNVpKXCkrqiuFwP1IAFmpq16z/tUyMObnB9++jVs19?=
 =?iso-8859-1?Q?Q/yTiSlvYGLQalpzBscR/K9aKQ3AAO3sk4z9sVCKhBQystlgjhaAR/kGUx?=
 =?iso-8859-1?Q?WLlEuSm8se36Sy1XMxOd19tywAs8USsLt0lO3bkgnNZIdg78aGfHQ0yLvJ?=
 =?iso-8859-1?Q?HiiFtQ5hOfM4p2GNcgA9+1jrykMKlroESGX05I91ZW9UakalIOYBBrWXOl?=
 =?iso-8859-1?Q?c1YHJ7j2rUDhp+qrJIxuvUS7GuanMm3usXFBLdvmsCx9O70Rgvdiqoecl1?=
 =?iso-8859-1?Q?BCym7uNM0JquNxJLOL1E8GGHetfCu/BETfXva1E4lP1bDoDJ+oxgIsUedX?=
 =?iso-8859-1?Q?6aFtW9QE68hPDoQz++wGQyzvi4Q1VAjhCgKRBjPCQEIeB3R98Vg2HfeiwL?=
 =?iso-8859-1?Q?8an919C2vO0zfS6d7q1oWgqyVhQBVrVHnUqhuPIkuyoFvK2tMOW0iJlPYq?=
 =?iso-8859-1?Q?Tc3kRL5NH5Nymqrbc82E9z+RZC1qStsNY8o86MXdIDMds3gb+u5//tG95M?=
 =?iso-8859-1?Q?qt4bUumCuB9PGatUioL3baMyhfjaq2PNmLo+D6nNE47MKNkuwof1tHxCeL?=
 =?iso-8859-1?Q?ejXZuAlVpS05oGMCfpq8eFgAwUxBopuNacbEZXAqTE3GnsTbEXM2AMOt13?=
 =?iso-8859-1?Q?BIOw1/Q6Am91ciGM0/vETRwvA/n0/u4eKP7bL93UNPjIOUY4UvKDNpmdBq?=
 =?iso-8859-1?Q?FUj6FzBskRDU/IX9Sb/CE9hxBl4hSUnC+9D3BW9OcWhCGqV5tKZ5M/kAzY?=
 =?iso-8859-1?Q?MoGN5Jmz/M9XbAsx4N8P7c3TT/DCK6CVaHz9IWL/TKt801DYMaWexxalyQ?=
 =?iso-8859-1?Q?KeN2nI+NIw1iUnlKnmyv7tDX45C7ESCAfZZZ8tdsUCLP+lkzUeOrb9WJKG?=
 =?iso-8859-1?Q?m0Q+jkcoVvpFA2lxFpqvIBqA7+KB9eF/83?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1ae13b-4892-4e99-eff8-08dabb323b93
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 11:22:44.8187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVRxoLg/D3YfLde4fYgxFFyKpXTsekYnPFOk5yikcit72/rZEgXTCXSAm3U1gO0SmEr2+EDNiI1H0h2x17icWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5222
X-Proofpoint-GUID: bcL92x86zV4lTAbZrPctq942U-VtFkzp
X-Proofpoint-ORIG-GUID: bcL92x86zV4lTAbZrPctq942U-VtFkzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_06,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=379
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310072
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Maarten Zanders <maarten.zanders@mind.be>
> Sent: Friday, October 28, 2022 5:26 PM
> To: Lars-Peter Clausen <lars@metafoo.de>; Sa, Nuno
> <Nuno.Sa@analog.com>; Liam Girdwood <lgirdwood@gmail.com>; Mark
> Brown <broonie@kernel.org>; Jaroslav Kysela <perex@perex.cz>; Takashi
> Iwai <tiwai@suse.com>
> Cc: Maarten Zanders <maarten.zanders@mind.be>; alsa-devel@alsa-
> project.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 3/3] ASoC: adau1372: correct PGA enable & mute bit
>=20
> [External]
>=20
> The DAPM control for PGAx uses the PGA mute bit for
> power management. This bit is active high but is set to
> non-inverted (ie when powering, it will mute).
> The ALSA control "PGA x Capture Switch" uses the active
> high PGA_ENx bit, but is set to inverted. So when
> enabling this switch, the PGA gets disabled.
>=20
> To correct the behaviour, invert both these bits.
>=20
> Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
> ---

Also looks like a fix so a Fixes: tag? If so, the patch should come
before ("ASoC: adau1372: add support for S24_LE mode")

- Nuno S=E1
