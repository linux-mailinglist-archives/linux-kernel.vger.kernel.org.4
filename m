Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4973D690F2D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBIR2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBIR2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:28:15 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF005A93F;
        Thu,  9 Feb 2023 09:28:09 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319GxL6l001602;
        Thu, 9 Feb 2023 09:28:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=LnH96BivBWjW8XWDdQaAjRS90znojI8KbgB3Y4wuJYA=;
 b=l36506LBEAAJ6t5FjPvgkMuqhPM6S8nWaBBkBNSMqbrl/1tgfU8cDh+1xNu9/Ga/8oF7
 TWQ4xWVwkFZhrrQfnpHvSdAWdAeT1vsV/z+Wnr88kKW4TFvLDndLjjeNe7YHPxbzWUNe
 SulkkNt9ZWMUcjRGCZAM2crsVoZKzm3xTAzyW1JLGKK6RfbbighNRHl83Vv/8iR1kkXm
 /WId/1chHKxaX4IA8wJn/UBgZe4NhP6WxqYdt//UEKe7Sp0QAj4C2dki3T/EjMVJqnTE
 D5TBIQVph6Xr+CNby0mcoPwOjmo57YgJTaHBWL7b/A9sYk0IuexBCZ9n0ULgHxa2kSjq 2Q== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nmsar4e7h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 09:28:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiXs7WvmAX2R4/AWrSCAQp1PucdEQNEMiB58mUTG96rFODh9Aax3Y1jGsNHJjylHf+hiho9C/kZG8bT/ETW8i08uc+b3HyA+yrnI4Y31hTDdeMTf690qxWFOXl5Z3tr9iQAbs2H7n25X/GKpsRRqZdLY4wI7grOssSRNBaSq7V28gZd9vNpCkEc/PPL3AB4sy6hMekVS4xO5kjth5iHpk6bHwltDpnOaC9xg0sxmN+MxN+elvVouY6V+HKLKI2Q5j5TolCOMncuGMSFGHMklGvnie5YbYGoXUBPhN9cDhpWq9ZPQkgnahojgAIGwbUUMUgrndlBK4zWx7rUikl1HOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnH96BivBWjW8XWDdQaAjRS90znojI8KbgB3Y4wuJYA=;
 b=XBrUd+pXs0C7I69APDqD81APe7Vk+DHIuecZrnM+EFBrzdHKCQoYrUXaSe/M/YhyiwPhSyj7aXDS3B8+s4fd22ZYyXdu/a3EPFcE2t0ivFJZzhEa0AtrBjweU7WPeV3zxUiA6LCw3n1qrQ73vtAhqzmpEoDC2ZF5MmTnDvvc/NerDvW1Wt2iLGu18CkzZdzVDfPWXEQgend7JnsOpP7HJR0ogtTvxVoUgc40YGnZigSp3btRhNXzKm7+7v/A2vbYay6GpF0JtGhlzQcOZkgg9CVyamBV9sd+qEjSEC335El6wb8E2HsLlN6Mn1UxtFp2f0hNhemZdgnX1cATVogQyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SN7PR15MB4159.namprd15.prod.outlook.com (2603:10b6:806:f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 17:28:05 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7b61:8691:5b41:ecf8%5]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 17:28:05 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Kernel Team <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v10] module: replace module_layout with module_memory
Thread-Topic: [PATCH v10] module: replace module_layout with module_memory
Thread-Index: AQHZOosWgrFk94mbpUiAn23Fr3awBK7FVgEAgABscoCAAGqLgIAAtZyA
Date:   Thu, 9 Feb 2023 17:28:05 +0000
Message-ID: <4CAD2C20-FD08-48A6-ACB7-C2FD42F66107@fb.com>
References: <20230207002802.2514802-1-song@kernel.org>
 <b40ec330-8c9e-0265-19b9-d82b516c95c1@csgroup.eu>
 <70DCC6C0-53E2-4C18-B147-B2F600C66E54@fb.com>
 <e46be975-0f57-c654-0018-20151618e778@csgroup.eu>
In-Reply-To: <e46be975-0f57-c654-0018-20151618e778@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SN7PR15MB4159:EE_
x-ms-office365-filtering-correlation-id: 1ef53f52-dcb9-4c56-8512-08db0ac30116
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUov7W2YR7cTW+ioFl3EZF1LJpT2fKMJ4BDwPx4Dto5VjvIZtBN29fuUD2SZ2sdvDwHh5pwQ72xvMCoZHRYAmZQxivnnS3+DYBOKMlKXC47fDrkwMbEllGC5h9JWu6XPz0/Kz3HfPwtJJ7RwHmmEwunqRY3RIRdRrE1ETk2kND9sF1hauJbP6Y3Dm2haLMuOtGH/iBafDCYe4Q4HxQOtHLsIznfTDBrxvJxhqODIAVoe33cBXkaoDMUnGhApXtyOKm8I4qiZUSbPo+J/CuaIAzrQzF1Rt8r+dsHetwIG12siphxkQ+GggPScuz0q/ArLBah4fydXGCbfbqDNpIs9Dv/KtEer8j2/kPbtE1UkqGj4XVsc0tkvuR3FOsp2tZWagw/8Q1MPgrUYKkAVZHYRsWSnjSpE0xrrp99MxEAjktJQguz4t7uibMNim0M3WSOyDxyXiwvtz1tpz1eoB230w86yugPb2+LeRO8BAeRgpt5TtxOpMhnbVMUpbvtBx+Lj+0AlbDbcPFgZFQk7sltxq4tncKDumHpOCm5bzcs44saXUBhAkdqLic67a45enkx0bISRFjSBsZ8/JO8H2/PHDVVRfMuMeMdCzb4sYgSh4L8ujAgKZmj9rZla8rSuMFo93FYTwJprDm4IZCJ4EmVfd+hZRzAwaV8FnWWINye6V+ad0ICoAulFJENnHynuTW3Zw3v47bd4Y5K37SZ4aLJfDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199018)(6486002)(38070700005)(122000001)(38100700002)(9686003)(6512007)(186003)(36756003)(53546011)(6506007)(8676002)(478600001)(66446008)(66476007)(64756008)(4326008)(6916009)(66556008)(91956017)(76116006)(71200400001)(66946007)(86362001)(316002)(54906003)(33656002)(2906002)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S01zZDBpTEY4RTNwV2pDb1h1RWd0VnlNMjBNZ1BsbnVDWU1zSEFDcmRyRHFK?=
 =?utf-8?B?R3pmcWlMMEJCcXNESTRpNlJjQXlIR1AxVlQrN0lJNHczUmtpZFp5SVlOeUFw?=
 =?utf-8?B?eFZOZDY4RUZrT2pxMSt3MnRhWTBRdnFFZ3VocnI5VzdLM200TU1lZGNoa2pX?=
 =?utf-8?B?UzlTeFdUSXYvTlVjRHNpMGZhM3hTMWFsS0lIUUNocUluUWhyczhjYlpuaU1z?=
 =?utf-8?B?MXlrdklXYmtoTlhDaUVuWlBwS2lqYnNJbmhWU0tvK2FQZFNXWFpWOEtEZmxk?=
 =?utf-8?B?S1VXeEJjaVdxOXYrTGk4V3JYOG5jM3ZkWWFHd3FzTGRYWmt3QW9oRW9JTzRn?=
 =?utf-8?B?Wmc2RWZpUVV1bkJYVUVoWldHdElLWEUzMytiV29SbnB2TFkxVGZoU3pXWit6?=
 =?utf-8?B?WVBMZmhRTG9HTUV5VDBPSWttUDZmWmFHbi9YWlR2M0NwNlM5UEJicVZ6QmVq?=
 =?utf-8?B?bWVGU21QU2NCYU9HUnNnVGNUNTJva0JIZ3BZelBubm1DV2F0MEpOR0ZxUlhq?=
 =?utf-8?B?R0tQUWpVSXIwZFFnbW81OWdvTmpUNWRVWndSMGcxcHRHOE11WVlIM2pVRTcr?=
 =?utf-8?B?ZjJHdHZmOENaZ1lIWUpNMHBJNFhtSGhmck1kVTlqMlVVeVpZeTB2dWdLREgw?=
 =?utf-8?B?eXJBNE9NN0FPOWJlWm5NRG16RGJpd0x0RTl1azhuYW85eXRhaXJYZ2ZuM1Bu?=
 =?utf-8?B?dzhuNmF4R0x3SnYxRmFXalpjQ0FJUWU5VkFwVWYxUENWS2NwbExOQldrUUtZ?=
 =?utf-8?B?WDVhekVUT0FHV1hvRHM4cnhxbDk2WnNWdmFoUVp1S3hxRGhXSU5EMWx5T2hp?=
 =?utf-8?B?dDlUN2l3dmhrWllaTkF2MkxpREMzTGNUdlQ4Y0VLZVhLbVkvSmxPaW9qeWIv?=
 =?utf-8?B?ekIxYlVmVnJ1cWFpalNyYjF5ckg2NlQ3YzMxMXp3SDZ6YjJKT3VuUUxaNjdk?=
 =?utf-8?B?Vm1qRkkrWmUvWEcrSjM1ZWpQNXFraUZxRWNSd0EwMytKVnIvWnRFZ1duajNl?=
 =?utf-8?B?dFlMNVNGVnFwbGZ4OElvSmYzdEZWOWNRRDVyeXp4ZXN6RDBOSlJGNWxKUEYz?=
 =?utf-8?B?V29LTkdLcGNpa3dxM2pDMmV1WmJoUHpTWW9tNmZHTW5DUVEyY2Q1QXVjYW9v?=
 =?utf-8?B?M1dSczhFSXZJY0M3Ullseks1L2xUMDJGTEFBYzNSY1VHL1NwSCtpTTJvZkJW?=
 =?utf-8?B?ZVE4bzdEQXBGQ09NR3JEcGRkeVF4by9ydHJoajA3QUFkOVNrdis5d1dGQk5t?=
 =?utf-8?B?aGYyK1pGVUMzUDNyOUZwcUZOOGVBcnNOc0JhNXcyYU5sRTBzMUZJS0NHRFpz?=
 =?utf-8?B?VjBNclorcjd1MXpFcVhhbFhkVlZ6WEZnWlFYc3d6cTdBMUd2VGhhUjFmNnh4?=
 =?utf-8?B?MkgvMWhzYUpSY3RBZXZWTW1HZGxkaDdEazJ4STNrSmpnazkwMGV6bVR2a3ZD?=
 =?utf-8?B?ZGx2OGE1OUdBTVFYVkxpakdZeW9NWTI3SXBjQ3ZDcXpYTDBBaXdLK2E3T3la?=
 =?utf-8?B?SVV6VEJHbzNoUm43WDZPeHZFN1A1eWhWKzh0dzN3c0tQOW4yc2FyVjhBR2pB?=
 =?utf-8?B?ZjNEbG51SFU2M2JiSWR6UXBxR2F1bmNwSFdHRlZ2Q0U2bE9qajRaUHJwbjEv?=
 =?utf-8?B?MDdVQ1pCNlhhRXhVRnMrekdYb2h2TGd4Ym5PTm1Oc2dpV1htVVREWkJaelNm?=
 =?utf-8?B?eFpVYUVOTWpRZVJxaUlKTzNHanpTWi9TYlYrMWx1ZVdEbTFTZXJjWjRucUZ4?=
 =?utf-8?B?dDdCSWYveUtaQ2JoMmUvS0RFMEk3QXA5ckRWaExjZUMzSVJzeVNjSVBOSDBG?=
 =?utf-8?B?M3l3Y2dSZmppNllMNlVscEhWcjMyNTNKTFpmYUlsTkVDV2c4ei9DZEJaZE1Q?=
 =?utf-8?B?MFNrZ3d6Umh5dzdUb3c2bDI0aDErZHhSL3RoU3lDdkJjNnZUNzljK01QZHpx?=
 =?utf-8?B?Z1poMkdLSERxR0liZVhzRm1aUTBvd1ZJTkd1NWR4N05seG1uM1k4VkFmNTlp?=
 =?utf-8?B?MFZGZGNpVHdJc0ZncXNycG53S1lZTk9NcmFUUjNDbDdzaC9jcHk0SHdESVY0?=
 =?utf-8?B?TVBuR1lHbDhwbnVsdEw4QWFPQXJDMXpjVVAra0ZkNGJhdWM3Nmd3cU5nN01l?=
 =?utf-8?B?S084TWFZVDJpSDAvUVBEKzl6TFRXRDN4aHpKTlAyM0tJb2ozTGw2bmMrMVFV?=
 =?utf-8?Q?enrERj390EmszY0z5byoZ9X6Db7IgpN1A9+TjrXovihq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1459A26CEA3BF546A3E2F9A5A50EFB2C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef53f52-dcb9-4c56-8512-08db0ac30116
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 17:28:05.6054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yFwC6llukHt5Vxc8jOrIM8pHAD/cHCh7dVLoN2rGdox2b1zSh5f6AXy5ZJwZyLP+smIZ9NGLbyzdLFmacPj9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4159
X-Proofpoint-GUID: TRUmHsdNBtxi784whkehuWqOFEAGQpfq
X-Proofpoint-ORIG-GUID: TRUmHsdNBtxi784whkehuWqOFEAGQpfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_13,2023-02-09_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gRmViIDgsIDIwMjMsIGF0IDEwOjM3IFBNLCBDaHJpc3RvcGhlIExlcm95IDxjaHJp
c3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiBMZSAwOS8wMi8y
MDIzIMOgIDAxOjE2LCBTb25nIExpdSBhIMOpY3JpdCA6DQo+PiANCj4+IA0KPj4+IE9uIEZlYiA4
LCAyMDIzLCBhdCA5OjQ4IEFNLCBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNz
Z3JvdXAuZXU+IHdyb3RlOg0KPj4gDQo+PiBbLi4uXQ0KPj4gDQo+Pj4+ICB7DQo+Pj4+ICAgdW5z
aWduZWQgbG9uZyBtaW4gPSAodW5zaWduZWQgbG9uZyliYXNlOw0KPj4+PiAgIHVuc2lnbmVkIGxv
bmcgbWF4ID0gbWluICsgc2l6ZTsNCj4+Pj4gDQo+Pj4+ICsjaWZkZWYgQ09ORklHX0FSQ0hfV0FO
VFNfTU9EVUxFU19EQVRBX0lOX1ZNQUxMT0MNCj4+PiANCj4+PiBBICNpZmRlZiBzaG91bGRuJ3Qg
YmUgcmVxdWlyZWQuIFlvdSBjYW4gdXNlIElTX0VOQUJMRUQoKSBpbnN0ZWFkOg0KPj4+IA0KPj4+
IA0KPj4+IA0KPj4+PiArIGlmIChtb2RfbWVtX3R5cGVfaXNfY29yZV9kYXRhKHR5cGUpKSB7DQo+
Pj4gDQo+Pj4gaWYgKElTX0VOQUJMRUQoQ09ORklHX0FSQ0hfV0FOVFNfTU9EVUxFU19EQVRBX0lO
X1ZNQUxMT0MpICYmDQo+Pj4gICAgbW9kX21lbV90eXBlX2lzX2NvcmVfZGF0YSh0eXBlKSkNCj4+
PiANCj4+Pj4gKyBpZiAobWluIDwgdHJlZS0+ZGF0YV9hZGRyX21pbikNCj4+Pj4gKyB0cmVlLT5k
YXRhX2FkZHJfbWluID0gbWluOw0KPj4+PiArIGlmIChtYXggPiB0cmVlLT5kYXRhX2FkZHJfbWF4
KQ0KPj4+PiArIHRyZWUtPmRhdGFfYWRkcl9tYXggPSBtYXg7DQo+Pj4+ICsgcmV0dXJuOw0KPj4+
PiArIH0NCj4+Pj4gKyNlbmRpZg0KPj4gDQo+PiBUbyB1c2UgSVNfRU5BQkxFRCgpIGhlcmUsIHdl
IGFsc28gbmVlZCB0byBrZWVwIGRhdGFfYWRkcl9bbWlufG1heF0NCj4+IGFyb3VuZC4gRG8gd2Ug
cmVhbGx5IHdhbnQgdGhlbT8NCj4gDQo+IEl0IGlzIHVwIHRvIHlvdS4gSWYgeW91IHRoaW5rIGl0
IGlzIG5vdCB3b3J0aCB0aGUgZWZmb3J0LCBpdCdzIGZpbmUgZm9yIG1lLg0KPiANCj4gQWxsdGhv
dWdoIGl0IGNvdWxkIHByb2JhYmx5IGJlIGVhc2lseSBmaXhlZCBieSBkb2luZyAodW50ZXN0ZWQp
IDoNCj4gDQo+IHN0cnVjdCBtb2RfdHJlZV9yb290IHsNCj4gI2lmZGVmIENPTkZJR19NT0RVTEVT
X1RSRUVfTE9PS1VQDQo+IHN0cnVjdCBsYXRjaF90cmVlX3Jvb3Qgcm9vdDsNCj4gI2VuZGlmDQo+
ICNpZmRlZiBDT05GSUdfQVJDSF9XQU5UU19NT0RVTEVTX0RBVEFfSU5fVk1BTExPQw0KPiB1bnNp
Z25lZCBsb25nIGFkZHJfbWluOw0KPiB1bnNpZ25lZCBsb25nIGFkZHJfbWF4Ow0KPiB1bnNpZ25l
ZCBsb25nIGRhdGFfYWRkcl9taW47DQo+IHVuc2lnbmVkIGxvbmcgZGF0YV9hZGRyX21heDsNCj4g
I2Vsc2UNCj4gdW5pb24gew0KPiB1bnNpZ25lZCBsb25nIGFkZHJfbWluOw0KPiB1bnNpZ25lZCBs
b25nIGRhdGFfYWRkcl9taW47DQo+IH07DQo+IHVuaW9uIHsNCj4gdW5zaWduZWQgbG9uZyBhZGRy
X21heDsNCj4gdW5zaWduZWQgbG9uZyBkYXRhX2FkZHJfbWF4Ow0KPiB9Og0KPiAjZW5kaWYNCj4g
fTsNCg0KSSB0aGluayB1c2luZyB1bmlvbiBoZXJlIHdpbGwgYmUgYW4gb3ZlcmtpbGwuIExldCdz
IGp1c3Qga2VlcCBpdCANCnNpbXBsZSB3aXRoICNpZmRlZi4gDQoNClRoYW5rcywNClNvbmcNCg0K
