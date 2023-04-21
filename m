Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0E96EA55C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjDUHy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjDUHyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:54:37 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2BF869A;
        Fri, 21 Apr 2023 00:54:16 -0700 (PDT)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KLHYZi023441;
        Fri, 21 Apr 2023 07:54:06 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3q3d6as90j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 07:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLJykm05DAOOH8Ktr3LEOHMR4Q9MGfgr79XN/BSqc4111fTW//A+WH7nveAeLuN3FQ+w8hTA37x0bEkpr/f/1jijNSgb0XlgItpr6gd3CY07e2HCLjVckyVsNRcE5nDIgcljetSl8n5AO0uWc7yXniWB2cQIsbdg0ez+tRTiEvKqSkR0hBDPjkMPmAizbmGVXY6QEU9y8LjpAVQH3/7Ze/GHicV5YD1GyIBpbUR0l2mEPu4HMNdbMJr5FUxWO9x32IF02nIFmenkPtHJKCj284TPfnSRAyYOpCfhZEdcjnaDGcc/4oiCtZf/iHevMiMSI0BNQxqhwMRD6mf6P7X9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVEQNFC1jPHwjp7bP+IxvgS8pIKVaq1JO3a8IeHuouA=;
 b=ZcP/ogGyg3BvJDsz601XF5qcs0M25UZ1jv3Y+kHKfvK9nph0+GARXXt0cP3z5tJcIAzh0EQbPhqz5ncbbHnTw1S65WQjIg2gBC8bdshN8Ofj/7lIFr7twFyKjdgbGf3VbqYGIZEFxQifTz0t7LeWAWVLYImstKoSTI0QZbkPFm8W38thpipiJ9/nhE0sibKukzmTiiKuSmAVo5kmEt4Gd/o7+lYcMUpWJtoSpAy05jSuZc7BK/V7WrjO0LuSPTX6B1QTqgphsrSspMh8kYGChYxhuojpJJ9KpSMr1Dyrih8hPXUPIVflM8NZ6u2o9GIfIAt5LbVsKDC8C0APKoh4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVEQNFC1jPHwjp7bP+IxvgS8pIKVaq1JO3a8IeHuouA=;
 b=JWhudaT4oW0a4K2UPJUO6PNBzFK+rfnjib9nrWQM4WCJ/OwKsDzz7HXdZSEhuAiZzNBuYDHIjWJSSwsdkSvedpYbUPkt4hI10iaeGu3yKFRTDS7FcfaR9HhVNX1oqnFmMFwK2C9KO9wKUV9vQ/fXtKkG/Wuo0bsKfbAR3HjfUVJnMnIN9eW1qfj7OeKTWMgJgPSFIeE2tPEHV87PBMjDR9DKgPrdMSdN/FuGf+XSYStMUiRefo2fWxR0stoWLYHMOGeubuYBHxLxh5iaAvEeDjcJxfbnzdCD/VbqkFPbfIYwCS1fB1Bh1tlaYyamRQoMM6zhFEUZQbEfxSChYWM2pA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AM0PR03MB6228.eurprd03.prod.outlook.com (2603:10a6:20b:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Fri, 21 Apr
 2023 07:54:03 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::bcf5:cd14:fd35:1300%9]) with mapi id 15.20.6298.045; Fri, 21 Apr 2023
 07:54:03 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Thread-Topic: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Thread-Index: AQHZaTpLwL07BD9460y7/F64OnMs/q8oQvCAgAw/L4CAAATzAIAAF4AAgADb2IA=
Date:   Fri, 21 Apr 2023 07:54:03 +0000
Message-ID: <cc525b37-51e2-2e46-4744-8cfeaa61579f@epam.com>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
 <ZDcqx9JVMvqr2WYu@e120937-lin> <ZEFw0TYs3TEHuM1D@pluto>
 <e2c3eae9-4c99-43fe-abcf-4f1840c58c64@epam.com> <ZEGIrj0PyrURANDr@pluto>
In-Reply-To: <ZEGIrj0PyrURANDr@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB7136:EE_|AM0PR03MB6228:EE_
x-ms-office365-filtering-correlation-id: 2d414f10-0e80-402c-7343-08db423d932c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+RKZY1NnxPOgKBMiDDqhWEV70KH5O6PusDyWgVntAMthRNm/U9jZ1LGDT0h3xaoZuSxubwyLQEr42ekK/rjtFmDxh8yjPOrlLfQ188eakRvpqwCE2wmXuLweTFZ2qJSJxGrFJzCQulZWzcXHaerZYvO0J3dumDFSeTTXqGYFE9eGpw78Fx1+WfHI0rDenfEjPIjILn7pIP26TJttlB3KcqAlXCM5ll2gi3U3PuVkdOX/ndk4ifeLj6D+nQt9OR1hV2KWiRAcoboUYacxSUizFoaOL4Xg1qzCIWfP3AeAk5CtAUYrwEB6X+JMoJVGdcDToyMgqPZZaILRRHPaMzKwf4o8yIZeO1+6w7Ad5of2eHiHpFU1O90ARlVTrHPpueb9KhbWb/GCf8LNRbXmXBiqVD4jQVfW36EIxbhuTtRCYgWiHhvrQz/D1/vUVJD1m8eKmsBBgQyYPBDVe0Mhr3HXIh+/McDQmxfneFl3oaYeP3KKrLUV/TQR4Y8IhECXgwtk55Q9u1mRwRSDPGC3ZzVKM9GpvEGfMy1eVJOmVbASrEMS1nkT8MZaPHTfTKM5LU1B5eLd0kTqgd1+UuH//mNz1wH7PhZiRd9bZhFtSpsbFT1LFLbPT8xFjJubO96pL6DSjXZbptkdtOd0972+MfVmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(122000001)(31686004)(316002)(4326008)(54906003)(6916009)(66446008)(66556008)(66946007)(64756008)(76116006)(66476007)(966005)(91956017)(186003)(6512007)(6506007)(26005)(53546011)(2616005)(83380400001)(38100700002)(5660300002)(8676002)(41300700001)(8936002)(478600001)(71200400001)(6486002)(36756003)(31696002)(38070700005)(86362001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVF3c21aZ3VQRnpYK3FyOE9WSWRiNEVISXNRRlFaeFhZbVA1K09BRVF5YnEv?=
 =?utf-8?B?MnpxcUZja0RZZkFtSm9XT0Z0MjMzTXFGQzlmMU05azVGV05JVWIxWWhEVFRn?=
 =?utf-8?B?eVd6TzU4MEVlTGN0d1poUzBZVllndlVUdWlESWxxNXFaOFNLWjZ1MTllcGJj?=
 =?utf-8?B?TWt3ZTdVeE9jWk5xc1BQTjRTRW5yaEM0N1FwSVhIaUtVWktoUjRCbGdpbERH?=
 =?utf-8?B?MGpOeG93a1JRUllPTHZxQWJDZkNMZ2ZqZWFMTmJKVVV2NEx1bDNiaGpFUjZ0?=
 =?utf-8?B?Mi9MVkk3ZkFqelU5alVNZjNCa0djSEMzeWlaTXFhU01SYVpMcmxlMW9XSHd0?=
 =?utf-8?B?eFhYK0xEdHl2MzR0WjZuek9zK2hSYnhpR0NOSWozeUNIOUpZdzhFaE5yQXo3?=
 =?utf-8?B?Q21wVFBUR2hLQUNtK2JjYlc0VEJoWFBuSUlwbUZBdkF5Uys2eG9FNWt2NnFK?=
 =?utf-8?B?R3QrbjFUbXBMd3dUTW9kZEhDbjExS3BhbDRxVkUvS1Myd0JYK0RTVUoxMnp4?=
 =?utf-8?B?VC9vcllVMW9XK1JVdUhKQmM2QmJ5OHpEZTZLZ1hmZTdCTFBjRFVpZ3VseXR5?=
 =?utf-8?B?WXBmdTdpc0lNa1dvYi9TUVVCN01OVW1JNXExK04xMDRSNWRxemVsRi95ZWt0?=
 =?utf-8?B?R00wcXhTaWN6ZWE5MjduNndmZ2pLa3ZuSWhuS3hDa0UzakN3cVQxaDN6VkJv?=
 =?utf-8?B?SFpxOHRtMmdzVzVqclVZMDJadUs3MVJoRkZHNzVVKzN3MHlDaFpyZ1c3SjFC?=
 =?utf-8?B?a3cxMU1TelBVWkV5VFREd2ZoRkQydVVVZUtCZ0JMbU9iTGxIekx4WnhVVzVE?=
 =?utf-8?B?UEE1RVFSeG9qeTd1WFl0NWhuZTN3ZTJINVREYS9SM0FFYjRGTXprU0hmOUFH?=
 =?utf-8?B?MXZMYkhpa3RjTkROTnNuT3V5VGRWZE42N20wR2R5Q3E1WnpDdXN3WjlIZnlL?=
 =?utf-8?B?aG5Xa29RU1AvcFBnU0NpWE1UUzMzdG9ydUJQZW56a1VveVVQNE5Pdk9oWktw?=
 =?utf-8?B?cmJWNEJRQVZJVzZzSDJ0cXdOTlBsUTdWL0FwQm1xS0VhN05oS2FBVkcyVE5Y?=
 =?utf-8?B?US93TlFZSVpseGRXRVhaK0xqb0dJTjlUVHR5YVp1TnpVSVN3L1h4QVFIcWxQ?=
 =?utf-8?B?bFVhZG9ZQ2RkTVdsWXlmbTV3cVR3VGtHUVU1OGxaaERpOUFCclFUZ21BSjdh?=
 =?utf-8?B?WTUwWVNuVGRSZWZVUWhWeEFCcnB1TVNHbHlPUXBzSExqQ1JHL0dkenJwTnZN?=
 =?utf-8?B?Ym9OeDhTcXp1NjVUeWFqQlh3ZTBnYU5rb3hUUU9RelRycUZxVlNrWkY5M2hY?=
 =?utf-8?B?LzhYcVdiU0E3czJzODRnVWZvbVVZblVnZXJLYU1MdlFUd1o2WUlneDc1OXBQ?=
 =?utf-8?B?aEEwRTJIRGZIMHROVlIrSll5VHlaMzJVRXdWaDN0VnpWWlJJckNyUmJWSnFs?=
 =?utf-8?B?SFpJZzRnc3FYeDcvWFdUbkVxSE5CMWZnV0c1SERtYmNQOG5uamM1Z1MwUml3?=
 =?utf-8?B?QmVRMkhISzRPeWwrZ1VDaWRKRnhjZk5JbWRnaytEM0VRN08yUVZCU3lBTytw?=
 =?utf-8?B?ZStza3ZCajQrcENQaXI0cDB6R0ZUR0RkZlJrYjRXZkV2RlFsRVVUekVLMVVi?=
 =?utf-8?B?Y2t5NG56MjByZjAyUEd5V2RxKzJQKzZyaVpYaHhKTTFWc1Q3TDFINUllM0JX?=
 =?utf-8?B?bVF5TXhUbldScHEzQXVXSUNVU001NFFqeVBKdkNQRm52YXVsdzJlczFtcm5l?=
 =?utf-8?B?Znhld3JWMGc0QTUrNFJsZlVIM2FKa2QvWlVnUzJRRDI0SE1GdU1HK2JYRDFm?=
 =?utf-8?B?eThzZFZzZ2tVekY5SjRHSmV2eG1URjJzMWhBaGl1d01jRVUraGVTZnZSK0pj?=
 =?utf-8?B?Vml6VCs3d203OCtMK1pMWjdYRlRMSHlpM2M3dzhhWW85dWFaRXR4dUd1S1N1?=
 =?utf-8?B?eXlaakZTaWJzZkNZeWY3NjVZZFNBQnl5RWUySURWVXBMYzc3bVJBc2drV3g4?=
 =?utf-8?B?dm9jVFFlUVhBekZ1MVU2enR5NTJrdVlZSWhvTm9obk5CQ1puSFk2ZjZySG5J?=
 =?utf-8?B?VVAxVHc3NGZPTHJiMFdwWW1aZ1k4a2ViemNRRWxsTGV1YXVrMmZTellnU1Vk?=
 =?utf-8?B?K3F0QmN0UnlJVmxkcVJvSWFOS3hSUStZRmdReEtGdlljK01ZcWZCL3NPTUdy?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F91A23F6275684CA1D7F4030BB04FC7@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d414f10-0e80-402c-7343-08db423d932c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 07:54:03.2253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtzAp+K5OJOVA7KZCKS8kUQuAJruPuslLadDAJC20FTeGRBJvP7IeIeXcbYz1EOUhfgLSSRanTueOnHXnn4pcy0s1mG53TxtcjKEOdjDH0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6228
X-Proofpoint-ORIG-GUID: jJ0B8EPSCUX-w0JbkJdniU-BPMlZoAg4
X-Proofpoint-GUID: jJ0B8EPSCUX-w0JbkJdniU-BPMlZoAg4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_02,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=822 suspectscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ3Jpc3RpYW4sDQoNCk9uIDIwLjA0LjIzIDIxOjQ3LCBDcmlzdGlhbiBNYXJ1c3NpIHdyb3Rl
Og0KPiBPbiBUaHUsIEFwciAyMCwgMjAyMyBhdCAwNToyMzowNVBNICswMDAwLCBPbGVrc2lpIE1v
aXNpZWlldiB3cm90ZToNCj4+IEhpIENyaXN0aWFuLA0KPj4NCj4gSGksDQo+DQo+PiBPbiAyMC4w
NC4yMyAyMDowNSwgQ3Jpc3RpYW4gTWFydXNzaSB3cm90ZToNCj4+PiBPbiBXZWQsIEFwciAxMiwg
MjAyMyBhdCAxMTowNDowNVBNICswMTAwLCBDcmlzdGlhbiBNYXJ1c3NpIHdyb3RlOg0KPj4+PiBP
biBGcmksIEFwciAwNywgMjAyMyBhdCAxMDoxODoyN0FNICswMDAwLCBPbGVrc2lpIE1vaXNpZWll
diB3cm90ZToNCj4+Pj4+IEltcGxlbWVudGF0aW9uIG9mIHRoZSBTQ01JIGNsaWVudCBkcml2ZXIs
IHdoaWNoIGltcGxlbWVudHMNCj4+Pj4+IFBJTkNUUkxfUFJPVE9DT0wuIFRoaXMgcHJvdG9jb2wg
aGFzIElEIDE5IGFuZCBpcyBkZXNjcmliZWQNCj4+Pj4+IGluIHRoZSBsYXRlc3QgREVOMDA1NiBk
b2N1bWVudC4NCj4+Pj4gSGksDQo+Pj4+DQo+Pj4gSGkgT2xla3NpaSwNCj4+Pg0KPj4+IG9uZSBt
b3JlIHRoaW5nIHRoYXQgSSBtaXNzZWQgaW4gbXkgcHJldmlvdXMgcmV2aWV3IGRvd24gYmVsb3cu
DQo+Pj4NCj4+Pj4+IFRoaXMgcHJvdG9jb2wgaXMgcGFydCBvZiB0aGUgZmVhdHVyZSB0aGF0IHdh
cyBkZXNpZ25lZCB0bw0KPj4+Pj4gc2VwYXJhdGUgdGhlIHBpbmN0cmwgc3Vic3lzdGVtIGZyb20g
dGhlIFNDUCBmaXJtd2FyZS4NCj4+Pj4+IFRoZSBpZGVhIGlzIHRvIHNlcGFyYXRlIGNvbW11bmlj
YXRpb24gb2YgdGhlIHBpbiBjb250cm9sDQo+Pj4+PiBzdWJzeXN0ZW0gd2l0aCB0aGUgaGFyZHdh
cmUgdG8gU0NQIGZpcm13YXJlDQo+Pj4+PiAob3IgYSBzaW1pbGFyIHN5c3RlbSwgc3VjaCBhcyBB
VEYpLCB3aGljaCBwcm92aWRlcyBhbiBpbnRlcmZhY2UNCj4+Pj4+IHRvIGdpdmUgdGhlIE9TIGFi
aWxpdHkgdG8gY29udHJvbCB0aGUgaGFyZHdhcmUgdGhyb3VnaCBTQ01JIHByb3RvY29sLg0KPj4+
Pj4gVGhpcyBpcyBhIGdlbmVyaWMgZHJpdmVyIHRoYXQgaW1wbGVtZW50cyBTQ01JIHByb3RvY29s
LA0KPj4+Pj4gaW5kZXBlbmRlbnQgb2YgdGhlIHBsYXRmb3JtIHR5cGUuDQo+Pj4+Pg0KPj4+Pj4g
REVOMDA1NiBkb2N1bWVudDoNCj4+Pj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRw
czovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGVuMDA1Ni9sYXRlc3RfXzshIUdG
XzI5ZGJjUUlVQlBBITBrTUxRNWMzdEtzTWZXQ3FUS0hwNmVvbFkzc1RabHlLbUFEN0I3cGJpU0VT
QUJVVW9Cem1oZ3JZZERnV0dDX2cwdmdMRTR6d3JTNHBwZVRPRDhLaXpQOWZJZUprcGckIFtkZXZl
bG9wZXJbLl1hcm1bLl1jb21dDQo+Pj4+Pg0KPj4+IFtzbmlwXQ0KPj4+DQo+Pj4+PiArc3RhdGlj
IGludCBzY21pX3BpbmN0cmxfcmVxdWVzdF9jb25maWcoY29uc3Qgc3RydWN0IHNjbWlfaGFuZGxl
ICpoYW5kbGUsDQo+Pj4+PiArCQkJCSAgICAgICB1MzIgc2VsZWN0b3IsDQo+Pj4+PiArCQkJCSAg
ICAgICBlbnVtIHNjbWlfcGluY3RybF9zZWxlY3Rvcl90eXBlIHR5cGUsDQo+Pj4+PiArCQkJCSAg
ICAgICB1MzIgKmNvbmZpZykNCj4+Pj4+ICt7DQo+Pj4+PiArCXN0cnVjdCBzY21pX3hmZXIgKnQ7
DQo+Pj4+PiArCXN0cnVjdCBzY21pX2NvbmZfdHggKnR4Ow0KPj4+Pj4gKwlfX2xlMzIgKnBhY2tl
ZF9jb25maWc7DQo+Pj4+PiArCXUzMiBhdHRyaWJ1dGVzID0gMDsNCj4+Pj4+ICsJaW50IHJldDsN
Cj4+Pj4+ICsNCj4+Pj4+ICsJaWYgKCFoYW5kbGUgfHwgIWNvbmZpZyB8fCB0eXBlID09IEZVTkNU
SU9OX1RZUEUpDQo+Pj4+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+Pj4+ICsNCj4+Pj4+ICsJcmV0
ID0gc2NtaV9waW5jdHJsX3ZhbGlkYXRlX2lkKGhhbmRsZSwgc2VsZWN0b3IsIHR5cGUpOw0KPj4+
Pj4gKwlpZiAocmV0KQ0KPj4+Pj4gKwkJcmV0dXJuIHJldDsNCj4+Pj4+ICsNCj4+Pj4+ICsJcmV0
ID0gc2NtaV94ZmVyX2dldF9pbml0KGhhbmRsZSwgUElOQ1RSTF9DT05GSUdfR0VULA0KPj4+Pj4g
KwkJCQkgU0NNSV9QUk9UT0NPTF9QSU5DVFJMLA0KPj4+Pj4gKwkJCQkgc2l6ZW9mKCp0eCksIHNp
emVvZigqcGFja2VkX2NvbmZpZyksICZ0KTsNCj4+Pj4+ICsJaWYgKHJldCkNCj4+Pj4+ICsJCXJl
dHVybiByZXQ7DQo+Pj4+PiArDQo+Pj4+PiArCXR4ID0gdC0+dHguYnVmOw0KPj4+Pj4gKwlwYWNr
ZWRfY29uZmlnID0gdC0+cnguYnVmOw0KPj4+Pj4gKwl0eC0+aWRlbnRpZmllciA9IGNwdV90b19s
ZTMyKHNlbGVjdG9yKTsNCj4+Pj4+ICsJYXR0cmlidXRlcyA9IFNFVF9UWVBFX0JJVFMoYXR0cmli
dXRlcywgdHlwZSk7DQo+Pj4+PiArCWF0dHJpYnV0ZXMgPSBTRVRfQ09ORklHKGF0dHJpYnV0ZXMs
ICpjb25maWcpOw0KPj4+Pj4gKw0KPj4+IExvb2tpbmcgYXQgc2NtaV9jb25mX3R4IGFuZCB0aGVz
ZSBwaW5jdHJsIGdldC9zZXQgZnVuY3Rpb25zLCB5b3UgZG8gbm90DQo+Pj4gc2VlbSB0byBjb25z
aWRlciB0aGUgQ29uZmlnVHlwZSBmaWVsZCBpbiB0aGUgU0NNSSByZWxhdGVkIG1lc3NhZ2VzLCBz
bw0KPj4+IGJhc2ljYWxseSB1c2luZyBhbHdheXMgdGhlIERlZmF1bHQgMCBUeXBlLCBhbmQgYXMg
YSBjb25zZXF1ZW5jZSB5b3UgZG9udA0KPj4+IGVpdGhlciBleHBvc2UgYW55IHdheSB0byBjaG9v
c2UgYSBEaWZmZXJlbnQgdHlwZSBpbiB0aGUgcmVsYXRlZCBTQ01JDQo+Pj4gcHJvdG9jb2wgb3Bz
OyBJIGltYWdpbmUgdGhpcyBpcyBiZWNhdXNlIHRoZSBwaW5jdHJsIGRyaXZlciBjdXJyZW50bHkg
dXNpbmcNCj4+PiB0aGlzIHByb3RvY29sLCBhdCB0aGUgZW5kLCBkb2VzIG5vdCBuZWVkIGFueSBv
ZiB0aGUgb3RoZXIgYXZhaWxhYmxlIHR5cGVzDQo+Pj4gKGFzIGluIFRhYmxlIDIzIG9mIHRoZSBz
cGVjKS4NCj4+Pg0KPj4gSSdtIG5vdCBzdXJlIEkndmUgdW5kZXJzdG9vZCB5b3VyIHBvaW50LiBQ
aW5jdHJsIHN1YnN5c3RlbSBwYXNzIGNvbmZpZw0KPj4gaW4gc28tY2FsbGVkIFBhY2tlZCBmb3Jt
YXQuIFNvIHRoaXMgbWVhbnMgdGhhdCBjb25maWcgaXMgYm90aCBpbnB1dCBhbmQNCj4+IG91dHB1
dCBwYXJhbWV0ZXIuIFBhY2tlZCBmb3JtYXQgbWVhbnMgdGhhdCB1MzIgY29uZmlnIGhhcyBib3Ro
IGNvbmZpZyBpZA0KPj4gYW5kIGNvbmZpZyB2YWx1ZSBwYWNrZWQgaW5zaWRlLg0KPj4NCj4gU29y
cnkgSSB3YXMgbWVhbnQgdG8gbWFrZSB0aGUgYWJvdmUgY29tbWVudCBvbiB0aGUgUElOQ1RSTF9T
RVQgcGF0aCBidXQNCj4gSSBtZXNzZWQgdXAgYW5kIGNvbW1lbnRlZCBvbiB0aGUgR0VUIHBhdGgu
Li4ubXkgYmFkLg0KPg0KPiBBbnl3YXkgZXZlbiBjb25zaWRlcmluZyB0aGUgcGFja2VkIGZvcm1h
dCBhbmQgbG9va2luZyBhdCB0aGUgUElOQ1RSTF9TRVQNCj4gZnVuY3Rpb24gc2NtaV9waW5jdHJs
X2FwcGx5X2NvbmZpZyBJIGRvbnQgdW5kZXJzdGFuZCBob3cgdGhpcyB3b3Jrcy4NCj4NCj4+IFNv
IEkgcmVjZWl2ZSBwYWNrZWQgY29uZmlnIHdpdGggYm90aCBpZCBhbmQgdmFsdWUgb24gY29uZmln
X3NldCBjYWxsIGFuZA0KPj4gdGhlbiBqdXN0IHNlbmQgaXQgb3ZlciBTQ01JLCBleHBlY3Rpbmcg
ZXJyb3IgZnJvbSBzZXJ2ZXIgaWYgY29uZmlnIGlzDQo+IFRoaXMgaXMgd2hlcmUgSSBkb250IHVu
ZGVyc3RhbmQ6IHlvdSByZWNlaXZlIGEgcGFja2VkIDMyYml0IGNvbmZpZyBmcm9tDQo+IHBpbmN0
cmwgc3Vic3lzdGVtIHZpYSBvcHMtPnNldF9jb25maWcgdG9nZXRoZXIgd2l0aCB0aGUgcGluX2lk
IGFuZCBpbiB0dXJuDQo+IHRoaXMgY2FsbHMgZG93biBpbnRvIHRoaXMgYXBwbHlfY29uZmlnIHdo
ZXJlIHlvdSBidWlsZCB0aGUgcGFja2V0Og0KPg0KPg0KPj4gKwlyZXQgPSBzY21pX3BpbmN0cmxf
dmFsaWRhdGVfaWQoaGFuZGxlLCBzZWxlY3RvciwgdHlwZSk7DQo+PiArCWlmIChyZXQpDQo+PiAr
CQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwlyZXQgPSBzY21pX3hmZXJfZ2V0X2luaXQoaGFuZGxl
LCBQSU5DVFJMX0NPTkZJR19TRVQsDQo+PiArCQkJCSBTQ01JX1BST1RPQ09MX1BJTkNUUkwsDQo+
PiArCQkJCSBzaXplb2YoKnR4KSwgMCwgJnQpOw0KPj4gKwlpZiAocmV0KQ0KPj4gKwkJcmV0dXJu
IHJldDsNCj4+ICsNCj4+ICsJdHggPSB0LT50eC5idWY7DQo+PiArCXR4LT5pZGVudGlmaWVyID0g
Y3B1X3RvX2xlMzIoc2VsZWN0b3IpOw0KPiB5b3Ugc2V0IHRoZSBwaW4gbnVtYmVyDQo+DQo+PiAr
CWF0dHJpYnV0ZXMgPSBTRVRfVFlQRV9CSVRTKGF0dHJpYnV0ZXMsIHR5cGUpOw0KPiB0aGVuIHNl
dCB0aGUgU2VsZWN0b3IgdHlwZSBhcyBQSU5fVFlQRSBpbiB0aGUgYXR0cmlidXRlcyBiaXRzIDk6
OA0KPg0KPg0KPj4gKwlhdHRyaWJ1dGVzID0gU0VUX0NPTkZJRyhhdHRyaWJ1dGVzLCBjb25maWcp
Ow0KPiBBbmQgaGVyZSB5b3Ugc2V0IHRoZSBQYWNrZWRGb3JtYXQgcmVjZWl2ZWQgZnJvbSBwaW5j
dHJsIGludG8gdGhlDQo+IGJpdHMgNzowIG9mIGF0dHJpYnV0ZXMuLi4oLi4uQlVUIHlvdSB0aGVu
IGFzc2lnbiBiYWNrIHRvIGF0dHJpYnV0ZXMNCj4gd2hpY2ggaXMgMzIgYml0IHNvIEkgdGhpbmsg
dGhpcyBpcyBhbm90aGVyIGJ1ZyBiZWNhdXNlIHRoaXMgd2F5IHlvdQ0KPiBjbGVhciBhbnkgYml0
IGp1c3Qgc2V0IGFib3ZlIHdpdGggU0VUX1RZUEVfQklUUy4uLmJ1dCB0aGlzIGlzIG5vdCB0aGUN
Cj4gcG9pbnQgbm93Li4ubGV0cyBpZ25vcmUgdGhpcy4uLiBhZCB5b3Ugc2hvdWxkIGFueXdheSB1
c2UgYml0ZmllbGQuaCBpbiBWMikNCj4NCj4gLi4uc28gdGhpcyBhdHRyaWJ1dGVzIG5vdywgYXMg
eW91IGV4cGxhaW5lZCBtZSwgaW5jbHVkZSBib3RoIHRoZSBzZWxlY3Rvcg0KPiB0eXBlIChQSU4g
dnMgR1JPVVApIGluIGJpdHMgOTo4IChidWdzIGFwYXJ0KSBhbmQgdGhlbiwgYXMgYSBwYWNrZWQg
Zm9ybWF0DQo+IHRoZSBDb25maWdUeXBlIGFuZCB0aGUgVmFsdWUgdG8gc2V0LCBib3RoIHBhY2tl
ZCBpbnRvIHRoZSBiaXRzIDc6MA0KPg0KPj4gKwl0eC0+YXR0cmlidXRlcyA9IGNwdV90b19sZTMy
KGF0dHJpYnV0ZXMpOw0KPj4gKw0KPiBZb3UgY29udmVydCB0byBwcm9wZXIgZW5kaWFuaXR5IGFu
ZA0KPg0KPj4gKwlyZXQgPSBzY21pX2RvX3hmZXIoaGFuZGxlLCB0KTsNCj4+ICsNCj4gc2VuZCBz
dHJhaWdodCB0byB0aGUgU0NNSSBzZXJ2ZXIgYXMgYSBwYXlsb2FkIGZvciBQSU5DVFJMX1NFVC4u
Li5zbyB5b3UNCj4gc2VuZCBiYXNpY2FsbHkgdGhlIHBpbiBpZGVudGlmaWVyIGluIHRoaXMgY2Fz
ZSAodTMyKSBBTkQgdGhlIHUzMiB3aXRoDQo+IHRoZSBhdHRyaWJ1dGVzIHdoaWNoIGluY2x1ZGVz
IHRoZSBTZWxlY3RvciBQSU4gdnMgR1JPVVAgYW5kIHRoZQ0KPiBDb25maWdUeXBlIC4udGhpcyBs
YXN0IGFzIGEgcGFja2VkIHRoaW5nIGluY2x1ZGluZyBhbHNvIHRoZSB2YWx1ZS4uLg0KPiAoc28g
dGhpcyBjb3VsZCBjb250YWluLi4uLmxvb2tpbmcgYXQgVGFibGUyMyBhcyBhbiBleGFtcGxlOg0K
PiAgICAgQmlhcy1wdWxsLXVwICg0KSArIGEgdmFsdWUgaW4gT2htcykNCj4NCj4gLi4uLkJVVCBm
cm9tIHRoZSBzcGVjIHYzLjItQkVUQSByZWdhcmRpbmcgUElOQ1RSTF9TRVQgKDQuMTEuMi43KSwg
eW91IGFyZQ0KPiBzdXBwb3NlZCB0byBzZW5kIG9uZSBtb3JlIHUzMiBmaWVsZCAiY29uZmlnX3Zh
bHVlIiBhcyB0aGUgcGF5bG9hZCBvZg0KPiBQSU5DVFJMX1NFVCAocGFnZSAxNzIpIHd0aCBzdWNo
IGZpZWxkIGJlYWluZyB0aGUgZWZmZWN0aXZlbHkgY2FycmllZA0KPiB2YWx1ZSB0byBzZXQuLi4u
ZmllbGQgd2hpY2ggaXMgaW5zdGVhZCBub3cgTk9UIGNvbnNpZGVyZWQgYXQgYWxsIGFuZA0KPiBz
byBqdXN0IHNlbnQgYXMgemVybyBhbGwgb2YgdGhlIHRpbWUgLi4uIGFtIEkgbWlzc2luZyBzb21l
dGhpbmcgPw0KPg0KPiAuLi5zbyBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQsIGJlaW5nIHRoZSBl
eHBlY3RlZCBmb3JtYXQgYnkgdGhlIHNwZWMgYXMNCj4gaW4gNC4xMS4yLjcsIHlvdSBzaG91bGQg
aW5zdGVhZCBwaWNrIHRoZSBQYWNrZWRGb3JtYXQgeW91ciByZWNlaXZlZCBhcyBhIDMyYml0DQo+
IGNvbmZpZywgVU5QQUNLIGl0IGFuZCBzcGxpdCBpdCBpbnRvIHRoZSBhdHRyaWJ1dGVzIGFuZCBj
b25maWdfdmFsdWUgZmllbGQuLi4uDQo+DQo+IGZyb20gdGhlIHYzLjIgQkVUQSBzcGVjIEkgaGF2
ZSBJIGNhbm5vdCBzZWUgd2hlcmUgdGhlIDMyIGJpdCBhdHRyaWJ1dGVzDQo+IHBheWxvYWQgaXMg
c3VwcG9zZWQgdG8gY2Fycnkgc3RyYWlnaHQgYXdheSB0aGUgcGFja2VkZm9ybWF0IHZhbHVlLi4u
DQo+DQo+IC4uLmFzIGl0IGlzIGltcGxlbWVudGVkIG5vdywgaXQgaXMgb3V0IG9mIHNwZWMgKGF0
IGxlYXN0IHRoZSBsYXRlc3QNCj4gdjMuMi1CRVRBIHB1YmxpYyB0aGF0IEkgY2FuIHNlZSkuLi4g
YW5kIGlmIGl0IHdvcmtzIGZvciB5b3UsIGl0IGp1c3QgbWVhbnMNCj4geW91ciBiYWNrZW5kIHNl
cnZlciBpcyBlcXVhbGx5IG91dC1vZi1zcGVjLi4uLndoaWNoIGlzIHByb2JhYmx5IGEgd2F5IG9m
IGJlaW5nDQo+IGNvbXBsaWFudCBCVVQgbm90IHRoZSB3YXkgd2UgbmVlZCB0byBoZXJlIDpQDQo+
DQo+IEkgY2Fubm90IHNlZSBhbnkgb3RoZXIgd2F5IEkgY2FuIGludGVycHJldCB0aGlzIHRvIG1h
a2UgaXQNCj4gd29yay4uLmFwb2xvZ2llcyBpZiBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLCBpbiBz
dWNoIGEgY2FzZSBwbGVhc2UgZXhwbGFpbi4uLg0KPg0KPiBUaGFua3MsDQo+IENyaXN0aWFuDQoN
ClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRoZSB0aXAuIFRoaXMgaXMgZGVmaW5pdGVseSBhbiBp
c3N1ZSB0aGF0IHNob3VsZCANCmJlIGFkZHJlc3NlZC4gSSdsbCBmaXggdGhhdCBhbmQgcHJvdmlk
ZSB3aXRoIHYyIHdoaWNoIEknbSBjdXJyZW50bHkgcHJlcGFyZS4NCg==
