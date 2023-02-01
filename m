Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF88868666E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjBANLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjBANLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:11:39 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EDB61D7D;
        Wed,  1 Feb 2023 05:11:36 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3119u5Dj011870;
        Wed, 1 Feb 2023 08:11:33 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3nfnvvguq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 08:11:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wrv0DFHomZ7Fj5BUJ9XWJ0QrZ8DtEwnb2hxk02OjvLFeD0TAHvuOOtccD0GRRK5puqb0p22Eja3WYRay9Y1d+TYqUPC+yBJRDkcDgbmIAbi6OO0ah+9MeTmTmBXwLrmTbvhiSuMX1M2gkUotLFcG0sBghXKxCHNaOITTixy+Zn5oG32gEDWV0+nOzZHk14cHyMwF4bu1aVCPrFiYSU/9+XWCZ+B8JkFNogR+7eQYk00e6K6ziDu6kK34GRUyms/5wK8wj0PGQ65yaZMA0POT0I3412jeK5wF1TP33U56wfQuDitSQUsxQva4Sm5UeZw4x1axRqFQx1mlzZQhs1VfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFz+cyxuX5H52P2a28lUTlyuSJAmnTildWG/RBF37R8=;
 b=ZJn1eUPzcZJNVqeGj/KhjXS2meuoBV5SSdRTBQsBzaTaTrvYx7BfFbHaKF8MDsfkUc2VY3Yn9Un5lsfOBPBB1dDH3A9vdjjXvrtIXjbxGWulLW671bfdDt757+AI3zPwPtaBQ+WYwCfizFBtjtCDlcCGasyCeq89FfIZBOU7dkf1vPfG4xUh3PVGuD6rqA13rcuSvt+J6ULIAikUTGyMZ/x4sd6tnYN+UVX7K7YhJ1fIDiXnzPDNEAy6um9Wc6tBTUH9vtqnZvU3h0x+4qBH03Be6mxaGfSWpyj+vkBxQG7xCS2ovDRs20m2ZU16xQHtiPxYdeAqJGQtMkShhkb5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFz+cyxuX5H52P2a28lUTlyuSJAmnTildWG/RBF37R8=;
 b=XHvWgfbsrsV9V1DCAHMP48WXkkJL4HFNpO+SBP0tcg+3WoKMAPlJ+/3lZvP8f2uWAiTaTzvEYjA+REyElTGkfXl3n/1vD7wqy9GYomZMLHN4gNpxGW/dq73TH3AcD5U47v7GKFmO/jWFs2ReZCCDrrzthxhAT2ydf2SVfXKkULQ=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BL1PR03MB6069.namprd03.prod.outlook.com (2603:10b6:208:309::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 13:11:30 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::fdc9:2a00:3b74:9060]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::fdc9:2a00:3b74:9060%7]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 13:11:30 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: iio: dac: ad5592r: add gpio_chip names
Thread-Topic: [PATCH] drivers: iio: dac: ad5592r: add gpio_chip names
Thread-Index: AQHY+mM74RG3gPw8BEirirbipGiYpa5NBR4AgG2ArrA=
Date:   Wed, 1 Feb 2023 13:11:30 +0000
Message-ID: <CY4PR03MB33992B4DBEF40A9F960001289BD19@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20221117090130.51702-1-antoniu.miclaus@analog.com>
 <20221123204832.3e514378@jic23-huawei>
In-Reply-To: <20221123204832.3e514378@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1lZWY4ZmM1Yy1hMjMxLTExZWQtYWQ4ZS?=
 =?iso-8859-2?Q?00MTU2NDUwMDAwMzBcYW1lLXRlc3RcZWVmOGZjNWUtYTIzMS0xMWVkLWFk?=
 =?iso-8859-2?Q?OGUtNDE1NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIzMzQyIiB0PSIxMzMxOT?=
 =?iso-8859-2?Q?czMDY4NzUwMzg0NjciIGg9IkZ2eUxpdVA5ZzVqVWxTSXk3S1VYWlBLZlln?=
 =?iso-8859-2?Q?WT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBQURTMU94UGpiWkFaWGw2Q1dBN21aamxlWG9KWUR1Wm1N?=
 =?iso-8859-2?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBbkl6dWxBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-2?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-2?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-2?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-2?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-2?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-2?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|BL1PR03MB6069:EE_
x-ms-office365-filtering-correlation-id: a4654682-d571-4256-b893-08db0455d597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OsEKY9UXjCsguE1+Pf517D+Lbs1NWAndvRK6n+YkbhZgnnGWwrV1Fqp8tZUakWRIdp0DZSDJ43K6juspEv8Ths0oZ3F48E7A4YolOWVZ3jNY33d1cYfliJF/xnf7wejYvjSwrFc9GpciCr8YndDzox3ZrKaQfX4CP3SWPZa20F6yQzBJPxeNFIbWtPkEmpcO9L5IF9ezekpuBECRLu5Cd6ZK/rO+0Vv3C2bH8DOUEyngvTGLnc061rV4rNqwAE1NdxInsSyKNJdvLUGQxKiOPe1BEilkqWnKPsHwd8LKk/41mJCtnEhdS0IqlMt7sUSPmd5+f7KcNTvko86rTz92mlsZVC6udDAyJrAvAGnLcUg4WM2lGkSleb+GO/lJMkiYAKvV5EJNzi9cZEYeiXX4wtvStI/wKpr52eIezonzc6Um7BL6zBsuHTvNj8/rVbJTbfbYoob0s5pbK4FrL+tRtSQKRHakMucPB5qt6cZjYgtKgE7zdsq+pRP0I002f38PKWzBP4iuj29ypwecw50pJHULKw1BPxBJ91qoXMkp1EozEAwr2ioTadRLBQBYVmussP2T5/c66rMcPsPGObYCFZPmuHK6HNK0ree7NOWF0tDNiWMs5xcKthC7JWj91CxUweHKnzClg9L/PPFJltL40rdTa26WqHfNPAt6Ewpp1ATRDV7FGKeM6lS6pEVVpDaa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199018)(83380400001)(54906003)(316002)(41300700001)(52536014)(8936002)(4326008)(6916009)(66946007)(64756008)(66556008)(66476007)(66446008)(6506007)(8676002)(76116006)(9686003)(26005)(53546011)(186003)(478600001)(66574015)(71200400001)(7696005)(38070700005)(86362001)(55016003)(33656002)(2906002)(5660300002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?1S6CBIzf91jkMc1OBO9fJZu6Odhht0cpmrzog8uekfcQ3tl+Zjt7780Ez1?=
 =?iso-8859-2?Q?YmLdUEkq+c1gGb6C6dnk6FNJzrSN1MBbKDLe2kC/vKE1g8EYy/9DCsNQ3F?=
 =?iso-8859-2?Q?Z88AtRICPhFgv0fWq16E0+BE25jZJc1RB7yZFoOfuRJ2eTacDL8UwK9I+o?=
 =?iso-8859-2?Q?4MTWkUEU3eEFhmqnzMOR0jtenUPJcrcm7zIfIEREN67pJoGzJfSrOzTkRY?=
 =?iso-8859-2?Q?hakX9de0b+YeDH/v9E7PbGo/ju5sbvTfaz+8M4IDQZjmOAuBEBrr/x6jYw?=
 =?iso-8859-2?Q?no9w/0XGbERnOCSi9vyF6Z1Nna43nVuqa3jGoR83SfFD4wyLQVkxTsdmqe?=
 =?iso-8859-2?Q?IGvGyoOrE3n/U2FhHk8uPaMFmLIV1MDjQlILHruQ+fwZvNFzxZvksCajqw?=
 =?iso-8859-2?Q?vcZx9Y69tPV5NrX3R3hO/PKUfW8ZeqJRD/2bCEow1CeGSLAT9uEBvLtUxu?=
 =?iso-8859-2?Q?No+Xpf4JPf2TlhENPiAZSjPDHprBEyo1AOY8IaNMxMLfJ1Lqg63jmf8bc2?=
 =?iso-8859-2?Q?QA9Z/YHV9wePMUMK0wu/mpT/bbAGV+YE1qJ0MiiODXup242S0fZnJ4kWXG?=
 =?iso-8859-2?Q?k7DdtctjO7xQ4EMB7Qo+N1w7YISYg7yz0vrrx2ZfoIJ2c019pgXpPz7Jf8?=
 =?iso-8859-2?Q?VZOPwxK8cMcchoGLN0gkfCMSwKKKfFJVzcjLZ4K7d6kwZGJDLCa8REORH5?=
 =?iso-8859-2?Q?SNIhuwZJFHiC3/odTHRPX/JES7/inyyk0/mdPrQPZUKDlxyBuhmbrF2Rub?=
 =?iso-8859-2?Q?b2E6OeOJFxYnxVgg9RpSPcfuIGSm2ZFX/j/QmxGDlu9qLIszWdIcaJaZDh?=
 =?iso-8859-2?Q?74jeIEvjNBf229U2T1SM8WuBX3BA/1ezC+wN5zeo8497DWxDlLb3Aq/VBM?=
 =?iso-8859-2?Q?ZZS6+igO+JdBbkXPEmkvoREwQsjbqukHuWnETdKgYlhoIc7jPRqoL6grYG?=
 =?iso-8859-2?Q?Fr4Jqdz5XRv6GvcXNFEX2bak7FGsRU2UqW2vlyztsxuTQyTVS7rN5MeLWt?=
 =?iso-8859-2?Q?/8xfu66FPATxzbKz6AC+AyFFNQXFtkDSZ7DG1c5ZJSaPdkiG72PF2jnfTd?=
 =?iso-8859-2?Q?qLFIRdJFQl2IIKspRF3mkxzUrQmT3GN5fkddg/MvNnM+rz6gFxZkBb9+kI?=
 =?iso-8859-2?Q?42tPZhbowMl+5zj2VkTUXXYpfKUaUwjTpnmYDQvKdkVEpmDRYHGapNicyZ?=
 =?iso-8859-2?Q?EGnUcviziBFS/MXeLkgaCQ3zMHEc9RpBJ2NwvVUbCJ6sp1EA2AKDqqa1iS?=
 =?iso-8859-2?Q?kkBUsiMhtPQsRY9I7yNjuK126Sjxa1D8QTUCpsCjzd3OHpfyvP/gAQHYXM?=
 =?iso-8859-2?Q?MBIvgfNi0EEMspEivVE+eKZ5DVhIm4bdmOFyfKNpcZVNSTqNwOxm+iqplz?=
 =?iso-8859-2?Q?iPyLBfjL1pDJK56BK49IvbtcgTThxyRekyQyNaXZOzcMMN0HlGHBFZtewc?=
 =?iso-8859-2?Q?nWMRRLKqKbFJ/RoLp6b+SPq6bIYOUe9kCmICpYTsLXek5ei3iXlBOlzHHA?=
 =?iso-8859-2?Q?IN6XCNyX6S/GYa+m26Fw2pC4R65eEIwFhstfaeY55civkNACobQ5BMOs23?=
 =?iso-8859-2?Q?IdTA53EF99yhmTwS5+fodzKH73VNq40+2iSG6eoCKv5NttImt9jQ1RurKQ?=
 =?iso-8859-2?Q?JLChXdaDMYVKuGz6iSeHyvV7YPhCs2llb3?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4654682-d571-4256-b893-08db0455d597
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 13:11:30.5122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yAy0Agh1cQqgZpKRUWzzpUszjgjaDcxLtg/NgEVFgJov14OoAuJFZybTv3zXixyLjjkhgAFgVviqcgYVys6d5g7wYDDAzDT7+I2z8MukGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6069
X-Proofpoint-GUID: 892L5n1vUzTzhbT7jC-bJeREAb67ht7B
X-Proofpoint-ORIG-GUID: 892L5n1vUzTzhbT7jC-bJeREAb67ht7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010113
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Wednesday, November 23, 2022 10:49 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] drivers: iio: dac: ad5592r: add gpio_chip names
>=20
> [External]
>=20
> On Thu, 17 Nov 2022 11:01:30 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add array of explicit gpio names for the `gpiochip` structure of
> > ad5592r, mainly for debug purposes.
> Can you give an example of when this is more useful than the offset?
> (which I'm assuming is also available when debugging?)
>=20
> Jonathan
>=20
Hello Jonathan,

I guess this patch is not mandatory. It is a gpio_chip structure member tha=
t was left unpopulated.
Also, I think it is nice to see explicitly the gpios under cat /sys/kernel/=
debug/gpio alongside the others.
This is the current output when trying to debug on a rpi (without the patch=
 applied):

analog@analog:~ $ sudo cat /sys/kernel/debug/gpio
gpiochip0: GPIOs 0-57, parent: platform/fe200000.gpio, pinctrl-bcm2711:
 gpio-0   (ID_SDA              )
 gpio-1   (ID_SCL              )
 gpio-2   (SDA1                )
 gpio-3   (SCL1                )
 gpio-4   (GPIO_GCLK           )
 gpio-5   (GPIO5               )
 gpio-6   (GPIO6               )
....
gpiochip2: GPIOs 496-503, parent: spi/spi0.0, spi0.0, can sleep:

gpiochip1: GPIOs 504-511, parent: platform/soc:firmware:gpio, raspberrypi-e=
xp-gpio, can sleep:
 gpio-504 (BT_ON               )
 gpio-505 (WL_ON               )
 gpio-506 (PWR_LED_OFF         |led1                ) out lo ACTIVE LOW
 gpio-507 (GLOBAL_RESET        )
 gpio-508 (VDD_SD_IO_SEL       |vdd-sd-io           ) out hi
 gpio-509 (CAM_GPIO            |power_ctrl          ) out lo
 gpio-510 (SD_PWR_ON           |sd_vcc_reg          ) out hi
 gpio-511 (SD_OC_N             )

The gpiochip2, corresponding to ad5592r has no explicit gpios, due to the f=
act that the
gpio names were assigned.

Regards,
> >
> > Since the gpios are configurable via the dts, generic names are
> > used.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  drivers/iio/dac/ad5592r-base.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-b=
ase.c
> > index 7a9b5fc1e579..076bc9ecfb49 100644
> > --- a/drivers/iio/dac/ad5592r-base.c
> > +++ b/drivers/iio/dac/ad5592r-base.c
> > @@ -124,6 +124,10 @@ static int ad5592r_gpio_request(struct gpio_chip
> *chip, unsigned offset)
> >  	return 0;
> >  }
> >
> > +static const char * const ad5592r_gpio_names[] =3D {
> > +	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6",
> "GPIO7",
> > +};
> > +
> >  static int ad5592r_gpio_init(struct ad5592r_state *st)
> >  {
> >  	if (!st->gpio_map)
> > @@ -140,6 +144,7 @@ static int ad5592r_gpio_init(struct ad5592r_state
> *st)
> >  	st->gpiochip.set =3D ad5592r_gpio_set;
> >  	st->gpiochip.request =3D ad5592r_gpio_request;
> >  	st->gpiochip.owner =3D THIS_MODULE;
> > +	st->gpiochip.names =3D ad5592r_gpio_names;
> >
> >  	mutex_init(&st->gpio_lock);
> >

