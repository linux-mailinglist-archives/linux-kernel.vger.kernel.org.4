Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBB96CC708
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjC1Prr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjC1Pri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:47:38 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BD58A7C;
        Tue, 28 Mar 2023 08:47:24 -0700 (PDT)
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SFJFea022154;
        Tue, 28 Mar 2023 15:47:09 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3pky54s57h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 15:47:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvgsIQgVF6MtxZ4IWdtKTfYaOgm1RofK2WagQ39n+Fxh084h+sLbtZNNUSLJoZY2xYsM30mX5tN56nnx+WnhFhMprbMNvwBEMMniKD0bd8Hvw1Kaoyn32XQF27wpPCIWVYr9dX1kuKXFFCTxHQew7nXYtKBBDdF63LPZqHw4KkDZST/WHoJYWojxl4IlPbjJY0KFjDcwxVX7rAlJVV9Likc93gS3b3EDUUSFUMjNzZyyiqUD0llsCEw2FnQtbR7Euoe4ccqZO5Ddp14HtzjIhakPHDPMfrTaKdz5nnVBwIo9CNHWdlXxZ+At21rEor4L+9oEXA3sdzF7f5pQ50AItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lyl2FbygBKyUAq7wNX6N1p7kZaXAlPRDYbwEJ10+l4=;
 b=kSiGk9dDUrIXOH2U8dmotPQQdv+BmumbJxq4wG9HWZg0cbeMzHoxQ6l3TUJsIn5vLnqcC3AAu4xJg8GTxNKhrdYvVRWoaL3+X2FquTmBatpRijk4NIsflvtNnHtvo6Z5Xyw2yHIqhlY16/2H2HhtZqlfWpoeIAbx/cbHkria4P6mrLNA9xi+ehyJu8bSSAaMOl8eRlhoZjtzzqUJH7+lZyE5d0DL8G35bjS5ICD+D2IZJiDJbBqwGGn4+mtlZaoQn9sCH9chiKEDO1+0/v3Eqo9M20hVlnpHorB1nl4nCBwYGf1ox+tH3/4zC9CTewi0DJ+n3OTn7DQYQV2G0qkg9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lyl2FbygBKyUAq7wNX6N1p7kZaXAlPRDYbwEJ10+l4=;
 b=Z6LJvsNA1C7kqC13gRWp1g2Sw5DKyxe5/cBPkJFdR/qtyqWacV3TZCcqEm7VULLFhf/Q6GJBdlfddqBpjjH3AE5swClBvn7LXw/ZnUtp2N5S8XdYdO+HbXskY6TwvkOptB2wRABvD6IV1O70u/N82cMZktEBLFAETfKqdPn300U73SK6K8BZlVtsi5DsHFgEByANsFc+SHkHgFrKCnXLqIOYZpVjk7zgo3CVULwD+8L0mFgZG2PXyRQAPM7dETInZ6Z2ZUrB/+Cj0F55dILvD7tHxmSNyj0HzdG1myfWofDShwh+3VVLByY+NEmhGMXmTBunG36UVnZDPauvEQJ04g==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by PA4PR03MB6830.eurprd03.prod.outlook.com (2603:10a6:102:f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:47:05 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::bdd:a497:66a0:a342]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::bdd:a497:66a0:a342%5]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 15:47:05 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Dan Carpenter <error27@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen/scsiback: don't call
 scsiback_free_translation_entry() under lock
Thread-Topic: [PATCH] xen/scsiback: don't call
 scsiback_free_translation_entry() under lock
Thread-Index: AQHZYVG+3GUB3O/23kquKYQ39EYPJq8QVnGA
Date:   Tue, 28 Mar 2023 15:47:05 +0000
Message-ID: <df07e1e3-ebe0-65c6-58c0-831739b9ed4c@epam.com>
References: <20230328084602.20729-1-jgross@suse.com>
In-Reply-To: <20230328084602.20729-1-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|PA4PR03MB6830:EE_
x-ms-office365-filtering-correlation-id: 93015f63-7a9d-4aea-6174-08db2fa3ae3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WPw6Mfg+4KfyPBtOeEvAP1zLNJwNNJsjHcPnUxYjuyYb3p8VV6dQosLOrCDsMWl9WXrCYchhTDh2jdzyNAfGKo+OcWtA9XLfZWCrjbuSADLFEbCF0YLvKyL6f6CR8xyexMUgrn2wrwRRWgjAss9tK3MMCtUxap6yNED59VrUYENANdEZ82VMV6dyu6Ok6XYaCb9dFGTM4kWhcjgPHPnxK01x+yPNjBZ2j2/LI2xiZmvqyqdyK6pbJx7+YzMwEsdfIFVK5eKi8BzjK64qBJl1VsxV+FVhGeQ5talKIO3STJZOZABZxiKypELnBL8DWgHlWR4OXuy9ZX2Nj1ysORXgX9ZZfZHQZEzUIRZYAbOtrQeOfQp84HpwXD4OM3Slfi99aqQKNvZcFHkxwDGD70l8D5pqLKYhZJDFjzaNbPYwXitjNoFID6kYt4SP14rDVJQANx9FAZ8SvlhZvM+rciSshr8HohNmAqXm5P1rrN3PYq64r/I6tXZgWo43iDUBSVIVXUj3fcV/doOP3wclSP/zy4dZ2BH8rY5NUVjf2u6m4HBbP4yCo6yFEMmB8yX9WK5gry7oxw77zJx/xdjkLF9MV8fFFqe8FApkPnanUiIu0vufyeYQpr0BntIgUvwXFLZ8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199021)(6506007)(26005)(6512007)(53546011)(31686004)(83380400001)(86362001)(8936002)(38070700005)(2616005)(186003)(31696002)(966005)(71200400001)(2906002)(38100700002)(5660300002)(91956017)(478600001)(122000001)(4326008)(6916009)(41300700001)(66946007)(66476007)(76116006)(316002)(36756003)(8676002)(66446008)(64756008)(6486002)(66556008)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFpGcDNHck5MUS85cHp0bVFlSDRVV3N6WEtwcEJ0dHdpSVpOZmFraG1UU2RY?=
 =?utf-8?B?TUxra3dCd3A1d2tLdzNKM2hmOXdtRXBUYkNwU1AyUmx2TU1qTVpFbW1Palhv?=
 =?utf-8?B?YkV6UU0xQXgrazliUWYrSVYxMk5YenJVdXFKemNmcndGYXlmbVpLR1dhZGsz?=
 =?utf-8?B?MVRaRnJJSjJxTGxyRXVGcXhlY3pSaXVFZWl1Z253RVZDWE5WeENUbjNtZjEw?=
 =?utf-8?B?US9FNjdWYk5QTmk1WHVIUFpwTWhhcHBUMTBqTkU0aVo5dGptbUlReGUvK2Jh?=
 =?utf-8?B?U0MweTBGSTMrUnpRYmc1cjQydkkvUXgwTGkyc0dHYTdYUlJrSWgyME9NMEww?=
 =?utf-8?B?MGdSUnkrcW0ybjNZY3FsQkUxTkxEZm9xQ3N1ZEpSRnZqOWpQZkIzVHJuREFC?=
 =?utf-8?B?S2FLeWxiRkxXQkdQNVNqanZJOXdtcDZSUFJZaVlnUTFqWGZBL002K2tURitF?=
 =?utf-8?B?YWlBdGxaV2dXMGQ2R2dMc3ZhbTY2SVhlN0xoS05xaVQyUjFERDBPWUJYZnVO?=
 =?utf-8?B?dk1CVXFwdzNlUXVYMUQ4YTN5M0U4b1BzZUk1a3p0YjVBRk9ZUEo2LzBwcjlI?=
 =?utf-8?B?U2hSeVl1bkFXSENLdHl6cjhYc0hPMGlQZFJyeU1WdEFscDFkTkd2Z0RpaDFo?=
 =?utf-8?B?Nmt3eFY4Rkx0VFBCMVcrTUZXUDRzNmJ6UHdzNGlkQnZtRjJySFpZT3ZrS0hz?=
 =?utf-8?B?aWpGOUlndk9jcWxPaFhQM3VJeUlreU1HYWJ0UStXTC9tN0JMZlFsSzlCUGd2?=
 =?utf-8?B?MHJSTGk3bFlsMlRTS01vVWlBK0s0SlhRS2RmK2NJY3VtZjJieFlJT04zU2VE?=
 =?utf-8?B?MHhodko5b0FVSW5rd1B5c0R2TG9LVEtWMURFVGx0eXdWUENjU0pOcEFHTGNQ?=
 =?utf-8?B?QXNoS1ZaQU51bHY0UXVBZXdISm1pY1VvL3JBU2dMRGRuUXk4UHBmMlpOZVhq?=
 =?utf-8?B?TVJBaXFWUGkyTm5tTFZYSS9xcDhCcUhsNFJmbXMzVWdjQjVvR2paTGI0STlj?=
 =?utf-8?B?bFdlTTh6UnFHOUN5bUdFR3VGbzIvblg4cTlaMzBKc21xMDVBSDgrd09JYWNE?=
 =?utf-8?B?YnJzaHp3K3IrWDVNdGczWXptWG92UHIzeEZxTmZCK1lDaTJhWFowWGphTHY3?=
 =?utf-8?B?MEt2UHBnbHhJLzlUQ0l2SCtFVEt6SXU0M25OOURmTmRRNlA5ZldLeEJDenpr?=
 =?utf-8?B?dWVDcFoyVDhuNUVNSnhJQlZ0ZlUvRHp6MSs0cFQrM1JJaDFQWTlsazIwREky?=
 =?utf-8?B?UmFZRk5RZWlGcmJrYXVZRHkvZ2xHOHJ6THRvMllMZm53aHRGamx5R2dYR0tT?=
 =?utf-8?B?NzROUGlGYW1Ecmt5WnhWK012ZmRVc2hSNUsvV2dvYmlielkvUjJVR1ZoSVJ1?=
 =?utf-8?B?K1c1bDF1Z1JDM0RPQ1V2MW5iRk0waS9oRy9nMlRxTFJrT3lZQVdrYWErQWI2?=
 =?utf-8?B?a3FDcHVwKy83bzJCcCtIT0xjVm4wem1BZk1HZ05oOGFhSnp6ZE9PVEFlOEls?=
 =?utf-8?B?WGZwVVk5RnV4anVNSUMvbEczNmltYTBPTG9ZUlJ2ZW1KTHhkdzJGUHV5b2NC?=
 =?utf-8?B?bWo5WUpTMjZkcC9OWStFSWtBZGlDbVBzRytUdXo5dmRkYW96SUFxMmZVU056?=
 =?utf-8?B?K1o3b2NMQlhIakQ2MW5oSTVmNFRRWlRjSHlrM0xwWWs5U1IzN3J2eElmS1hq?=
 =?utf-8?B?a3VYWldhT09GMkpIaHBmdEpiakRuampFTTRsaDVYTGFUc04xdkVRcTJ1Y0dw?=
 =?utf-8?B?djEybE8zalBJL0VnQzZFQlFQVCtlYndmaCt6bzRzTTkyajhNWjVINjYxcEFx?=
 =?utf-8?B?dWxxNFJFRjNLNmxNOXNpWmtVTDRGQ2VLbHBGcWdDbTVBZWZUY3VEYmd6TE1x?=
 =?utf-8?B?cXBIVFJIUlFaK2dOZ3FnNmRPdER4bTNKSWhLM2p1emFZL1FlYU1qaDV6Nk9h?=
 =?utf-8?B?QlZJUlV3UEE4V1pIMzNxMVRQRFVMUXBHdkQrUGpnR1YrcFNCalY1YXJQQkpI?=
 =?utf-8?B?eTFDdldENnRVR1MxcFA0NVd2KzJtNWZSeitVdE1GMEIrSVROYXk0WXcwQjZW?=
 =?utf-8?B?LzdHa1pJd1Q0blUxU3FJMDZnSG8vSURGZWx3NDMyc0tXa2tyTVd0czRNZUJG?=
 =?utf-8?B?QjBlbnFjVGRBNUtlN3BRN1M3OHQ4NGI4aTRHSjlZRlJzUldpSW5IamxJbFFF?=
 =?utf-8?Q?wJV+oNHOzDu+n8C17KLPdbw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B986A28BDA94C44AB2C19B25B666365@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93015f63-7a9d-4aea-6174-08db2fa3ae3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 15:47:05.2249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /yewUB5QhFAUnBOOD5B3qgCxVK0ZO2taUR7orP/FK475J2TolsGetn1szqzgud2WVPM50ClU3d4CR11ZYcU0LNywp6dzpAZHpp1bS1osS1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6830
X-Proofpoint-ORIG-GUID: CRz42z7gB8Ij7HwLbjoI_EwRzIf6KvAm
X-Proofpoint-GUID: CRz42z7gB8Ij7HwLbjoI_EwRzIf6KvAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280122
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI4LjAzLjIzIDExOjQ2LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQpIZWxsbyBKdWVy
Z2VuDQoNCj4gc2NzaWJhY2tfZnJlZV90cmFuc2xhdGlvbl9lbnRyeSgpIHNob3VsZG4ndCBiZSBj
YWxsZWQgdW5kZXIgc3BpbmxvY2ssDQo+IGFzIGl0IGNhbiBzbGVlcC4NCj4gDQo+IFRoaXMgcmVx
dWlyZXMgdG8gc3BsaXQgcmVtb3ZpbmcgYSB0cmFuc2xhdGlvbiBlbnRyeSBmcm9tIHRoZSB2MnAg
bGlzdA0KPiBmcm9tIGFjdHVhbGx5IGNhbGxpbmcga3JlZl9wdXQoKSBmb3IgdGhlIGVudHJ5Lg0K
PiANCj4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGVycm9yMjdAZ21haWwuY29tPg0KPiBM
aW5rOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC9ZKkpVSWw2NFVEbWRrYm9oQGthZGFtL19fO0t3ISFHRl8yOWRiY1FJVUJQQSEyM0lLZFZo
YW1vRnE4cHRVbnByZF9UdWJETU9iai0wUUFhbHNHaWZmQkhDZUVkT3V3cnE3ejRvaGc5MlNqMG9s
Z2wwbmg3M29YdlNyLWkxenFYaFkkIFtsb3JlWy5da2VybmVsWy5db3JnXQ0KPiBTaWduZWQtb2Zm
LWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
eGVuL3hlbi1zY3NpYmFjay5jIHwgMjcgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3hlbi1zY3NpYmFjay5jIGIvZHJpdmVycy94ZW4veGVu
LXNjc2liYWNrLmMNCj4gaW5kZXggOTU0MTg4YjBiODU4Li4yOTRmMjljZGM3YWEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMveGVuL3hlbi1zY3NpYmFjay5jDQo+ICsrKyBiL2RyaXZlcnMveGVuL3hl
bi1zY3NpYmFjay5jDQo+IEBAIC0xMDEwLDEyICsxMDEwLDYgQEAgc3RhdGljIGludCBzY3NpYmFj
a19hZGRfdHJhbnNsYXRpb25fZW50cnkoc3RydWN0IHZzY3NpYmtfaW5mbyAqaW5mbywNCj4gICAJ
cmV0dXJuIGVycjsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgdm9pZCBfX3Njc2liYWNrX2RlbF90
cmFuc2xhdGlvbl9lbnRyeShzdHJ1Y3QgdjJwX2VudHJ5ICplbnRyeSkNCj4gLXsNCj4gLQlsaXN0
X2RlbCgmZW50cnktPmwpOw0KPiAtCWtyZWZfcHV0KCZlbnRyeS0+a3JlZiwgc2NzaWJhY2tfZnJl
ZV90cmFuc2xhdGlvbl9lbnRyeSk7DQo+IC19DQo+IC0NCj4gICAvKg0KPiAgICAgRGVsZXRlIHRo
ZSB0cmFuc2xhdGlvbiBlbnRyeSBzcGVjaWZpZWQNCj4gICAqLw0KPiBAQCAtMTAyNCwxOCArMTAx
OCwyMCBAQCBzdGF0aWMgaW50IHNjc2liYWNrX2RlbF90cmFuc2xhdGlvbl9lbnRyeShzdHJ1Y3Qg
dnNjc2lia19pbmZvICppbmZvLA0KPiAgIHsNCj4gICAJc3RydWN0IHYycF9lbnRyeSAqZW50cnk7
DQo+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+IC0JaW50IHJldCA9IDA7DQo+ICAgDQo+ICAg
CXNwaW5fbG9ja19pcnFzYXZlKCZpbmZvLT52MnBfbG9jaywgZmxhZ3MpOw0KPiAgIAkvKiBGaW5k
IG91dCB0aGUgdHJhbnNsYXRpb24gZW50cnkgc3BlY2lmaWVkICovDQo+ICAgCWVudHJ5ID0gc2Nz
aWJhY2tfY2hrX3RyYW5zbGF0aW9uX2VudHJ5KGluZm8sIHYpOw0KPiAgIAlpZiAoZW50cnkpDQo+
IC0JCV9fc2NzaWJhY2tfZGVsX3RyYW5zbGF0aW9uX2VudHJ5KGVudHJ5KTsNCj4gLQllbHNlDQo+
IC0JCXJldCA9IC1FTk9FTlQ7DQo+ICsJCWxpc3RfZGVsKCZlbnRyeS0+bCk7DQo+ICAgDQo+ICAg
CXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmluZm8tPnYycF9sb2NrLCBmbGFncyk7DQo+IC0JcmV0
dXJuIHJldDsNCj4gKw0KPiArCWlmICghZW50cnkpDQo+ICsJCXJldHVybiAtRU5PRU5UOw0KPiAr
DQo+ICsJa3JlZl9wdXQoJmVudHJ5LT5rcmVmLCBzY3NpYmFja19mcmVlX3RyYW5zbGF0aW9uX2Vu
dHJ5KTsNCj4gKwlyZXR1cm4gMDsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgc2NzaWJh
Y2tfZG9fYWRkX2x1bihzdHJ1Y3QgdnNjc2lia19pbmZvICppbmZvLCBjb25zdCBjaGFyICpzdGF0
ZSwNCj4gQEAgLTEyMzksMTQgKzEyMzUsMTkgQEAgc3RhdGljIHZvaWQgc2NzaWJhY2tfcmVsZWFz
ZV90cmFuc2xhdGlvbl9lbnRyeShzdHJ1Y3QgdnNjc2lia19pbmZvICppbmZvKQ0KPiAgIHsNCj4g
ICAJc3RydWN0IHYycF9lbnRyeSAqZW50cnksICp0bXA7DQo+ICAgCXN0cnVjdCBsaXN0X2hlYWQg
KmhlYWQgPSAmKGluZm8tPnYycF9lbnRyeV9saXN0cyk7DQo+ICsJc3RydWN0IGxpc3RfaGVhZCB0
bXBfbGlzdDsNCg0KDQpJIHdvdWxkIHVzZSBMSVNUX0hFQUQodG1wX2xpc3QpOw0KDQo+ICAgCXVu
c2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAgDQo+ICAgCXNwaW5fbG9ja19pcnFzYXZlKCZpbmZvLT52
MnBfbG9jaywgZmxhZ3MpOw0KPiAgIA0KPiAtCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShlbnRy
eSwgdG1wLCBoZWFkLCBsKQ0KPiAtCQlfX3Njc2liYWNrX2RlbF90cmFuc2xhdGlvbl9lbnRyeShl
bnRyeSk7DQo+ICsJbGlzdF9jdXRfYmVmb3JlKCZ0bXBfbGlzdCwgaGVhZCwgaGVhZCk7DQoNCnNv
IHdlIGp1c3QgbW92ZSBhbGwgZW50cmllcyBmcm9tIGhlYWQgdG8gdG1wX2xpc3QgaGVyZSB0byBi
ZSBwcm9jZXNzZWQuLi4NCg0KPiAgIA0KPiAgIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZpbmZv
LT52MnBfbG9jaywgZmxhZ3MpOw0KDQouLi4gd2hlbiB0aGUgbG9jayBpcyBub3QgaGVsZCwgb2sN
Cg0KUGF0Y2ggTEdUTSwgYnV0IG9uZSAobWF5YmUgc3R1cGlkKSBxdWVzdGlvbiB0byBjbGFyaWZ5
Lg0KDQpXaHkgZG8gd2UgbmVlZCB0byB1c2UgYSBsb2NrIGhlcmUgaW4gdGhlIGZpcnN0IHBsYWNl
PyBUaGUgDQpzY3NpYmFja19yZWxlYXNlX3RyYW5zbGF0aW9uX2VudHJ5KCkgZ2V0cyBjYWxsZWQg
d2hlbiB0aGUgZHJpdmVyIA0KaW5zdGFuY2UgaXMgYWJvdXQgdG8gYmUgcmVtb3ZlZCBhbmQgKmFm
dGVyKiB0aGUgZGlzY29ubmVjdGlvbiBmcm9tIA0Kb3RoZXJlbmQgKHNvIG5vIHJlcXVlc3RzIGFy
ZSBleHBlY3RlZCksIHNvIHdoYXQgZWxzZSBtaWdodCBjYXVzZSB0aGlzIA0KbGlzdCB0byBiZSBh
Y2Nlc3NlZCBjb25jdXJyZW50bHk/DQoNCg0KPiArDQo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9z
YWZlKGVudHJ5LCB0bXAsICZ0bXBfbGlzdCwgbCkgew0KPiArCQlsaXN0X2RlbCgmZW50cnktPmwp
Ow0KPiArCQlrcmVmX3B1dCgmZW50cnktPmtyZWYsIHNjc2liYWNrX2ZyZWVfdHJhbnNsYXRpb25f
ZW50cnkpOw0KPiArCX0NCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgc2NzaWJhY2tfcmVt
b3ZlKHN0cnVjdCB4ZW5idXNfZGV2aWNlICpkZXYp
