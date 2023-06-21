Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797D9738AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjFUQXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjFUQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:23:02 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95E51BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:23:01 -0700 (PDT)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LEMGS8022913;
        Wed, 21 Jun 2023 16:22:45 GMT
Received: from eur04-db3-obe.outbound.protection.outlook.com (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3rbjagveft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 16:22:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKd0py37KJhjF80XQVN2R6W+NYJlux0pDCFX5rc+om0qW68X12lcrc2s6S7tz5ucreXDQrMgyYyrruLr+7lnE492UNbytmDaYEdrGqxKXnB4M2ropHjTRXUiosX/RMIKEh27bGqJNUkUwGXTfOCq0TSp2DbyOsjiiNKDyuCecV1SxV7j5UcKUTowVfs9GITmiMhL2Z/FgDQ3k9RArY+I/PR30rYaLtag//TEufQRQ4HMYhNRL5xsZwaggItsuhYCQ3om9Lnnn+0EEGWNzZxr6uH/4BmzPgdul4OSmuyQC89VrIwuLIDlqT+qSWwhTShCxGYMWn0w4F/VIgqHdoBG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/D2NJMRMD9S1NncsUQwzmdZjNDh4NsYU2OG0KrJsNU=;
 b=S9GQ0qa98iy4i9+rjPPDlzPkBYsVRhsEQSV6ssUe3tIhJZagX8cquZht783UkGGzH3rG01+LewZkzD93POJecn3DS4GrhdEi+b6J+kQaCZKGJihv4bV6jDJmnCP4Q7S2pLsmFcWGxOByIvNYZmEGWwYpSC5OANiE0nNUv2o2pVozAn4RKpSm3ypTNAk2QoqYscFqSPxNX94m2e1HfeuCdl5bSYRqxYaDiUfmPmRTvq4dyAWASwnoIFTfVLPmfnBaRD8KcWdMo7ow2xxOh3f6xGrWmLziBceGQjYripv3RqN5Gcp5b/wU7bkIcaYJz45AeE1Xxv4S7lKYKM5IjDTisQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/D2NJMRMD9S1NncsUQwzmdZjNDh4NsYU2OG0KrJsNU=;
 b=TOZ2rZi4kGwEswz0qmx41bz6G4g8UPPQMnGI8k2Sy17/ktkSo8vVIp8hxPjE9WYEIiBv37UxcUtsQWH/aawo75IWmvYC17Z1FZWMxJz8+aZ680fUmGb4gxng+3p13Gt8v08YTavOJ2qysGJMehcAxBOsuM4m43khFXQsPqXDowfSTjEzLtDCU790vAwP2jaFql8cl48hUH0X0nb4exRN0yCF7uPaMqRBkpv9o/SKky7xBoWh/2GLCZmMtni4FA/DUM1+HK8oJIJJpM14RH0xTaCh+C6X/Lq2AYbzTSTpYXHslmKUrW6An898+hlBg1H1hrDm9+7uZYgW1S5NmVuAXw==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AM7PR03MB6231.eurprd03.prod.outlook.com (2603:10a6:20b:142::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 16:22:42 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2%6]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 16:22:41 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>
Subject: Re: [PATCH 1/2] xen/virtio: Fix NULL deref when a bridge of PCI root
 bus has no parent
Thread-Topic: [PATCH 1/2] xen/virtio: Fix NULL deref when a bridge of PCI root
 bus has no parent
Thread-Index: AQHZpEMsTHUEiJGFk0eoUHhzZZ0I8K+VcKUA
Date:   Wed, 21 Jun 2023 16:22:41 +0000
Message-ID: <249a24a2-497f-7695-452d-f509ebe89a14@epam.com>
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-2-petr.pavlu@suse.com>
In-Reply-To: <20230621131214.9398-2-petr.pavlu@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AM7PR03MB6231:EE_
x-ms-office365-filtering-correlation-id: 77bacb24-a0e2-4a15-99b6-08db7273bce0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XENO/y1zOSYEgRhp2/qXq+u2mvvH9fO1ttxWls0tejxhx5MbWWRZsP6FxqsNFt3dR7TEat5BBGHLdlVKhUtf7n1ShyWFHRSM41lKedNtNX1FhI2wCSgSBnUzcRuzwyV+coqKgp3lmT1DS889ghIge8lAH2RrJNEeKK9+SOG8TBRGfeIoePYr2wDzuNqsGUedRbCnXNgFUN3V97J/wKuYQbzLhT4dHaZgn2j7oOtDihR0Y8BMs0CxWVt7xPfbmNaD5OvIfkFPDOp4vlGRIXLNw8v6McBMHUYA6AuNXUeYyi4VGMPi/PiIt1wtdZCm6Mg99rBoWaXodwEYRpqTJyvUvfNuhHOVs6Gcp3BgLQWaD+YHl2Dl6Xmr3gWpL+03rq9PPSCzAQMYjeQvx0BKMMo1h9s1O1vImRwUr2SoDpvDe7Bw89NzO64hBhtzf7Iiv84pmqYiBwBYTJJUOs/+amp+KiLn2zZgSxY1uaX43st6PeBj5mAEAYCvfk8X7R399Af1Qkl4F/p8P/QvQ0RqrUT9Gr51u0ZsWZ1UTytm/9VnrCp+aEUjIFWN5+ckEyvr8G1UI+YD1Vn09kVmFguVK8QmUaPkTNcwKrAKDvxtq9nbVu9laQOgugs6ImThxuJiIMQD5OLqFLL4BO1d5VpBK41P7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(5660300002)(66556008)(64756008)(66446008)(76116006)(4326008)(91956017)(66946007)(66476007)(6916009)(316002)(36756003)(2906002)(31686004)(8936002)(41300700001)(8676002)(54906003)(6486002)(86362001)(31696002)(38070700005)(478600001)(45080400002)(122000001)(38100700002)(6506007)(186003)(53546011)(6512007)(26005)(71200400001)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzNZZEx5RDl0UW9DcU4wSTdsU0owbUZiOGdMRFREM2FJT2JicDIvUTlYREZG?=
 =?utf-8?B?bEdLWURUcm41b2RXdTZXK3U4NE9FZVVGRmlDb0hVM291TE5DSWNFbitVZ3JM?=
 =?utf-8?B?eCtna3NFZW1tNkJoN2I1VjNtRnJwSGRCL2ZHeXdraDV0MHZKbSsyTkY0em1l?=
 =?utf-8?B?d1hvckdxUExJaXdUdWxTN2JLSjd4cU5Ha0RNUnRMT1c3c3Rvc1gzdTlGN2Vp?=
 =?utf-8?B?Nnk5WGo0a0RDVy96dE9CSS9zQ3VVYlVBRDJPTFV4U1lrQ2hFa29JZmtmVlV5?=
 =?utf-8?B?VytucHlzdDBYa3F0NlREdEN4ODdJWW9sdEdUQzlJeDRhRFZ3Si9YZ1NYaGlC?=
 =?utf-8?B?MllNcDJGWGJwNEpGQlR5U1hOYzBZNnFMNEZCamJ3WnFTeWF2dU16RzUrT2Jq?=
 =?utf-8?B?d2cxYS9mUlVrWklUVld6RDZhb0gyYWlsMzg5WmVSRHpHMDVDQnQzY1Fjclh4?=
 =?utf-8?B?b1dqZkJkTS9aUkh6cEMvNisvSnhWSGkyR3h3clJVdkZ5eVVmQ3NNcFVSYkFV?=
 =?utf-8?B?djlmbHhqRXIxNi9HUDFaaWVhOVBmeFVtYmdERm5FK1hYMTY5UDR4ZzB3Si9n?=
 =?utf-8?B?KzZJZ2M2Y3BZRmtxOTI0L3ZsZnhabE53c1BmUHJ0L1U4V3VxdWxObVRacE40?=
 =?utf-8?B?dkI4Vnlia0xid0Z0WUlmVTl6OWt2WnE4YVlYYUUzaWc0ZXZCbHBZT0d1Q0pX?=
 =?utf-8?B?MjVQanlPaVFDTk1zSS9YRWdudC9QTWNuQTFQV3haNmwzbFNCZ05xWGM3WFhl?=
 =?utf-8?B?Zkt1UG5NRTBTWTB3dS94M3lRdHBUMVJLQjVaOCtlUFdXd3h0NGhKR2ZwYXI3?=
 =?utf-8?B?bTlVcGdaakc5L0tDMzNESHlVT3E5UGpxeFJxV3dtK2RSMmJPTUFPNjBBWGJ0?=
 =?utf-8?B?bE5GWXd1ZE5yOUp4dHZuTUZmbkJqODFYVldFSHJGNGg1RU1OVzViMk8wZjNi?=
 =?utf-8?B?UC9SRmZxZzBaVkhvRW1TL0svMXZFMDJiSmIxSWRHQ1d5cGNZWXV2cmJqRjJ1?=
 =?utf-8?B?bHUzcnVkVHVCTnpDNG9SNHZVTWVOd2dLRU1EMUxOMWVDdWFxa2NEdkJKRm5U?=
 =?utf-8?B?S0FnVjFVTHJaK3FkdVZCN09yWWFQQVhVS3BnZmQ3YUNMR2M5bm5mdFdlZUVq?=
 =?utf-8?B?NTZxOTEvMGlMMHZmS2dNanpyU2NXVTY1aU9ZRFVxSUd1RXZiTXhVMUI3Tldv?=
 =?utf-8?B?NFkxVkRtYWlUZTZlNWV3dzBJa2Z2N01yNTY3Z2FlclR4S3RVU0QvdnZHUUx0?=
 =?utf-8?B?YkxNRlRoYTZjaGplczdOSTlWRlFVcStFek9SdjJHVWEwakY2aTdTMTFYdWxR?=
 =?utf-8?B?cjFDMlQxaEVKSUxUTU96ZXJCRXZ3MEt3OE1xUkFVWi8vSC85TldQdmp3a3RD?=
 =?utf-8?B?N1h5WXBtQ2ZHa21LWDFFTUdINStwblNyTUEzMHFHUzJoVFlVS3U4NHp1ZEg3?=
 =?utf-8?B?cm1kWno0RHNJdDNZVnJzUEZLTE43d0RZVi8rcmlUdk9yTlJGNzc5Tk1jMDZB?=
 =?utf-8?B?dlplRWdkTFBjOEp1TXNocWpyczZ4ZCtxa2JMQXlEeFVVYjFqT0llQXBVRU1Q?=
 =?utf-8?B?OU1WbENTYUU2eCttUE1QR2tCSHVQeHVYN09TRXM2cmsvUTJMaHJqWmJvK2Js?=
 =?utf-8?B?azcxTi9kOUZhY2JSVDRzeS93dGh3TFpVbjhHNng5c0tHTEZvZXFvY3FPUDFE?=
 =?utf-8?B?R3E4R1VGUk1rR3JmaVI1WkpyVEZvZkhzZGpQTUR6bUpVekJvWktVZWhRWUJJ?=
 =?utf-8?B?MUpLZi9oWW5wbTlEYWQxKzlpNGlILzVGNW9reDU0V3luU0dqZml3UkRZZU81?=
 =?utf-8?B?V1ZPdmh0MDNGaWdNa1VFTXpiZlEyRThiVmh0NzFyNlFubnowdEYyTmRmaHVD?=
 =?utf-8?B?aWtlTFR0SVBhV29yaHNnd2VzeFpYZ1JCQ3hmTHRXWVZNTU1Dd2JWTkhCTW9n?=
 =?utf-8?B?aFZldHA3UGtRbnoyZGxhbURnRnJabFRsdHczQlZ4ejhTRzNkbEtwWTR6UVFr?=
 =?utf-8?B?TTRReTZXMEIzRitycWtwQjZhVkpDTzBxZHRvU2xhTGYrMlNNZ3dPN3Jtd1dw?=
 =?utf-8?B?cFdIOUg1dGtrRmEwaVB6di9tVFpXcm1rakkxbHVZcHBXV0tFSndBc0lMcTZi?=
 =?utf-8?B?dGp0Rm93cWxJOGNxMjJMd2pmUXN6OHcxTGpPSEVoQURTb3U5alFUY3RSOGtR?=
 =?utf-8?Q?lBRgA0bWw9jGAmwgEVo/spY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA2434A057C0C441A6B709D3021B90A2@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bacb24-a0e2-4a15-99b6-08db7273bce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 16:22:41.8632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHkjZaDuaAVORVdigNK+uRMBDnoxTSwHRWENMsLqMymOHvDnkQsSqjTjcNPlt0n/KTLA+oFBt+Jn1bictxI3YfaHV/Gob9oJ/m6USwQ+PsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6231
X-Proofpoint-GUID: Sj19oyAM8pXdwVFShufE1uAxHNoof2ah
X-Proofpoint-ORIG-GUID: Sj19oyAM8pXdwVFShufE1uAxHNoof2ah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306210137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIxLjA2LjIzIDE2OjEyLCBQZXRyIFBhdmx1IHdyb3RlOg0KDQoNCkhlbGxvIFBldHIN
Cg0KDQo+IFdoZW4gYXR0ZW1wdGluZyB0byBydW4gWGVuIG9uIGEgUUVNVS9LVk0gdmlydHVhbCBt
YWNoaW5lIHdpdGggdmlydGlvDQo+IGRldmljZXMgKGFsbCB4ODZfNjQpLCBmdW5jdGlvbiB4ZW5f
ZHRfZ2V0X25vZGUoKSBjcmFzaGVzIG9uIGFjY2Vzc2luZw0KPiBidXMtPmJyaWRnZS0+cGFyZW50
LT5vZl9ub2RlIGJlY2F1c2UgYSBicmlkZ2Ugb2YgdGhlIFBDSSByb290IGJ1cyBoYXMgbm8NCj4g
cGFyZW50IHNldDoNCj4gDQo+IFsgICAgMS42OTQxOTJdWyAgICBUMV0gQlVHOiBrZXJuZWwgTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMjg4DQo+IFsgICAg
MS42OTU2ODhdWyAgICBUMV0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBt
b2RlDQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBu
b3QtcHJlc2VudCBwYWdlDQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0gUEdEIDAgUDREIDANCj4g
WyAgICAxLjY5NjI5N11bICAgIFQxXSBPb3BzOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkN
Cj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBO
b3QgdGFpbnRlZCA2LjMuNy0xLWRlZmF1bHQgIzEgb3BlblNVU0UgVHVtYmxld2VlZCBhNTc3ZWFl
NTc5NjRiYjdlODM0NzdiNWE1NjQ1YTE3ODFkZjk5MGYwDQo+IFsgICAgMS42OTYyOTddWyAgICBU
MV0gSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJ
T1MgcmVsLTEuMTUuMC0wLWcyZGQ0YjliLXJlYnVpbHQub3BlbnN1c2Uub3JnIDA0LzAxLzIwMTQN
Cj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBSSVA6IGUwMzA6eGVuX3ZpcnRpb19yZXN0cmljdGVk
X21lbV9hY2MrMHhkOS8weDFjMA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdIENvZGU6IDQ1IDBj
IDgzIGU4IGM5IGEzIGVhIGZmIDMxIGMwIGViIGQ3IDQ4IDhiIDg3IDQwIGZmIGZmIGZmIDQ4IDg5
IGMyIDQ4IDhiIDQwIDEwIDQ4IDg1IGMwIDc1IGY0IDQ4IDhiIDgyIDEwIDAxIDAwIDAwIDQ4IDhi
IDQwIDQwIDw0OD4gODMgYjggODggMDIgMDAgMDAgMDAgMGYgODQgNDUgZmYgZmYgZmYgNjYgOTAg
MzEgYzAgZWIgYTUgNDggODkNCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBSU1A6IGUwMmI6ZmZm
ZmM5MDA0MDAxM2NjOCBFRkxBR1M6IDAwMDEwMjQ2DQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0g
UkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogZmZmZjg4ODAwNmM3NTAwMCBSQ1g6IDAwMDAwMDAw
MDAwMDAwMjkNCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBSRFg6IGZmZmY4ODgwMDVlZDEwMDAg
UlNJOiBmZmZmYzkwMDQwMGYxMDBjIFJESTogZmZmZjg4ODAwNWVlMzBkMA0KPiBbICAgIDEuNjk2
Mjk3XVsgICAgVDFdIFJCUDogZmZmZjg4ODAwNmM3NTAxMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEg
UjA5OiAwMDAwMDAwMzMwMDAwMDA2DQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0gUjEwOiBmZmZm
ODg4MDA1ODUwMDI4IFIxMTogMDAwMDAwMDAwMDAwMDAwMiBSMTI6IGZmZmZmZmZmODMwNDM5YTAN
Cj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBSMTM6IDAwMDAwMDAwMDAwMDAwMDAgUjE0OiBmZmZm
ODg4MDA1NjU3OTAwIFIxNTogZmZmZjg4ODAwNmUzZTFlOA0KPiBbICAgIDEuNjk2Mjk3XVsgICAg
VDFdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODg4MDRhMDAwMDAwKDAwMDAp
IGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBDUzogIGUw
MzAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+IFsgICAgMS42OTYy
OTddWyAgICBUMV0gQ1IyOiAwMDAwMDAwMDAwMDAwMjg4IENSMzogMDAwMDAwMDAwMmUzNjAwMCBD
UjQ6IDAwMDAwMDAwMDAwNTA2NjANCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSBDYWxsIFRyYWNl
Og0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdICA8VEFTSz4NCj4gWyAgICAxLjY5NjI5N11bICAg
IFQxXSAgdmlydGlvX2ZlYXR1cmVzX29rKzB4MWIvMHhkMA0KPiBbICAgIDEuNjk2Mjk3XVsgICAg
VDFdICB2aXJ0aW9fZGV2X3Byb2JlKzB4MTljLzB4MjcwDQo+IFsgICAgMS42OTYyOTddWyAgICBU
MV0gIHJlYWxseV9wcm9iZSsweDE5Yi8weDNlMA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdICBf
X2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg3OC8weDE2MA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFd
ICBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4MWYvMHg5MA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFd
ICBfX2RyaXZlcl9hdHRhY2grMHhkMi8weDFjMA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdICBi
dXNfZm9yX2VhY2hfZGV2KzB4NzQvMHhjMA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdICBidXNf
YWRkX2RyaXZlcisweDExNi8weDIyMA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdICBkcml2ZXJf
cmVnaXN0ZXIrMHg1OS8weDEwMA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdICB2aXJ0aW9fY29u
c29sZV9pbml0KzB4N2YvMHgxMTANCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAgZG9fb25lX2lu
aXRjYWxsKzB4NDcvMHgyMjANCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAga2VybmVsX2luaXRf
ZnJlZWFibGUrMHgzMjgvMHg0ODANCj4gWyAgICAxLjY5NjI5N11bICAgIFQxXSAga2VybmVsX2lu
aXQrMHgxYS8weDFjMA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdICByZXRfZnJvbV9mb3JrKzB4
MjkvMHg1MA0KPiBbICAgIDEuNjk2Mjk3XVsgICAgVDFdICA8L1RBU0s+DQo+IFsgICAgMS42OTYy
OTddWyAgICBUMV0gTW9kdWxlcyBsaW5rZWQgaW46DQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0g
Q1IyOiAwMDAwMDAwMDAwMDAwMjg4DQo+IFsgICAgMS42OTYyOTddWyAgICBUMV0gLS0tWyBlbmQg
dHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQo+IA0KPiBUaGUgUENJIHJvb3QgYnVzIGlzIGlu
IHRoaXMgY2FzZSBjcmVhdGVkIGZyb20gQUNQSSBkZXNjcmlwdGlvbiB2aWENCj4gYWNwaV9wY2lf
cm9vdF9hZGQoKSAtPiBwY2lfYWNwaV9zY2FuX3Jvb3QoKSAtPiBhY3BpX3BjaV9yb290X2NyZWF0
ZSgpIC0+DQo+IHBjaV9jcmVhdGVfcm9vdF9idXMoKSB3aGVyZSB0aGUgbGFzdCBmdW5jdGlvbiBp
cyBjYWxsZWQgd2l0aA0KPiBwYXJlbnQ9TlVMTC4gSXQgaW5kaWNhdGVzIHRoYXQgbm8gcGFyZW50
IGlzIHByZXNlbnQgYW5kIHRoZW4NCj4gYnVzLT5icmlkZ2UtPnBhcmVudCBpcyBOVUxMIHRvby4N
Cj4gDQo+IEZpeCB0aGUgcHJvYmxlbSBieSBjaGVja2luZyBidXMtPmJyaWRnZS0+cGFyZW50IGlu
IHhlbl9kdF9nZXRfbm9kZSgpIGZvcg0KPiBOVUxMIGZpcnN0ID4NCj4gRml4ZXM6IGVmOGFlMzg0
YjRjOSAoInhlbi92aXJ0aW86IEhhbmRsZSBQQ0kgZGV2aWNlcyB3aGljaCBIb3N0IGNvbnRyb2xs
ZXIgaXMgZGVzY3JpYmVkIGluIERUIikNCg0KT29wcywgc29ycnkuIEkgaGF2ZSB0byBhZG1pdCBJ
IGNoZWNrZWQgd2l0aCBEVCBvbmx5Lg0KDQoNCj4gU2lnbmVkLW9mZi1ieTogUGV0ciBQYXZsdSA8
cGV0ci5wYXZsdUBzdXNlLmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogT2xla3NhbmRyIFR5c2hjaGVu
a28gPG9sZWtzYW5kcl90eXNoY2hlbmtvQGVwYW0uY29tPg0KDQoNCg0KPiAtLS0NCj4gICBkcml2
ZXJzL3hlbi9ncmFudC1kbWEtb3BzLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMu
YyBiL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPiBpbmRleCA5Nzg0YTc3ZmEzYzkuLjc2
ZjZmMjYyNjVhMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+
ICsrKyBiL2RyaXZlcnMveGVuL2dyYW50LWRtYS1vcHMuYw0KPiBAQCAtMzAzLDYgKzMwMyw4IEBA
IHN0YXRpYyBzdHJ1Y3QgZGV2aWNlX25vZGUgKnhlbl9kdF9nZXRfbm9kZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ICAgCQl3aGlsZSAoIXBjaV9pc19yb290X2J1cyhidXMpKQ0KPiAgIAkJCWJ1cyA9
IGJ1cy0+cGFyZW50Ow0KPiAgIA0KPiArCQlpZiAoIWJ1cy0+YnJpZGdlLT5wYXJlbnQpDQo+ICsJ
CQlyZXR1cm4gTlVMTDsNCj4gICAJCXJldHVybiBvZl9ub2RlX2dldChidXMtPmJyaWRnZS0+cGFy
ZW50LT5vZl9ub2RlKTsNCj4gICAJfQ0KPiAgIA==
