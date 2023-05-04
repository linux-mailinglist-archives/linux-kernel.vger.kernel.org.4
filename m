Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10526F70C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjEDRT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEDRT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:19:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544DBB9
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S149zLuFANUYDQGJvHPYfgRQO74KXw5FfiiESYvjklVDjygP/zATnxoam9WHdW/je0VF/IwE7B8eDMzBkSmBgi1rpJZMDx01hIQdqT3jMq0j27p99d3Xzf68OaLfTXNvtqTKZk2YRGYM5o0QuAouphhIE7qS/OsEb4yn72n0ojlN5eqYFssPwklj4kHK26uZiP81xkoNtuX4b/L4XfFjAi8k405RbqNPQyHfYPDk24rCSxy5buh6uKDfQWOiiAO67RYNS9/pv6g/Jx4navH1sLjWiusbYtXaca0lZAWsKO0XvZo2McS73LQmAMhbi0uBHXNdJoNTR2YqwrEGfB3/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keHnjrr95G4GRH+qJB6ImmjZLEIb0sW0f18oLPWNusI=;
 b=aChp8txbw57D2zxS1+WF0tqAjxsw09hwk0L1vUudkzBHs9sN6AOS/ePkqKtSNt/ThstCDq0taTyxsGRvga/s2U0IY4p64gGgqMrLOE6QbdLs5rlsDUGTbqcPh/WuFZeBsjrBWe+hQXePWtwVtADfv3q9r/7T3ENfON1IOsgTlA1mu9tlOMz2QUSgNdWF8z7KBNDqMc7zGwRIRYloB8yXxCpGHFQXmCpV40tN78ndhk2H1nJab+24sPrMAVgn7hmNyMfceyNgka2wvqvnlGk8a/rPCN2a6RFchlAOzu1+ZB/jkLs5ou64h54DXhNyTxgiIT8285tWnmIwI45B9uBI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keHnjrr95G4GRH+qJB6ImmjZLEIb0sW0f18oLPWNusI=;
 b=AKTwKKqeTEHRWOSpvhV6g/9obMMoirG6AbqteYvQ3TOVZ8TJ1xHkXhRkJFw5NIC3J13Vsus2c6JKmgvL4Y9WR15kk2wyeoiTEsMIiqF50BvytZs2mwE0h0SLlN8tFYDI/dTQI6e2ZlukLiu44xpkwK7FVucjt40YtPVej8zurDFVYzfyZFXpJuYrKMBN3aS2XghL/askQCo1XfvLKd9h7jVaGUvDeitGMFjEcIE0Qb6WPQIHE5ii+sI+4jfRWOqk0tvHXwKKVgmtihoImsn9JAZWPfLXS4deVA4/COsRA+bZfj5tRc400dL4J2DSHSqgX3nPU6DpVlWk7WqF+ACogA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 17:19:55 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::9e8a:eef5:eb8a:4a02]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::9e8a:eef5:eb8a:4a02%6]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 17:19:55 +0000
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     Feng Liu <feliu@nvidia.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Gal Pressman <gal@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Thread-Topic: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Thread-Index: AQHZfo9/nZP06ML0wECcAFMaORWcJ69KWRYAgAADEwA=
Date:   Thu, 4 May 2023 17:19:55 +0000
Message-ID: <209b4b364facec3cc26f3d12acd4b466b9278b47.camel@nvidia.com>
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
         <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
In-Reply-To: <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|DS0PR12MB6463:EE_
x-ms-office365-filtering-correlation-id: 80f39ab4-4b0e-4e05-e459-08db4cc3c7a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kP3TS0LYsT7ULddsy9kJqB8rqVyU4TeCXDtbSz9E/Rnsl+aA8h1Mqr6oeEtraoO4rk9ZXfBt+px6Y+FOgahgbhMXf/rzOr5+OI2tvPsI+0Mv/34LJiqaS2jLLD+SwWnnHBcUYSHPtZ8ADG2jnvILW4i0EhBnofDu1neV2bYr5bP2hX0BEB+XUKefNlTpt22JNZMwlnknTu6uRMkLigFZr+R7Mg6xC687R+cmROuIjjmf7ZM24irG6/NDDij1MjD2ZOv7MbsDSmW7vCrfJQnpt+etYLudoDa/UgABa/83UJK/0Iesq0CGKGeE9tH9kNhNHkBRSI1GMdmc/YA6wQp6YnaEMn2DSZ1UKogBCDWsFpaLXr4ZuhLhpRz7SO2J7AGiFiLQ5nB26CEc5C2piCC2uNrqbPRCzB3LFQn/S/l78Crx2x/K7i/q3i8exIk6GrU8hfDsxF2GpMTT2ly5MkcTog1Z7wm3NVE4AmKVT6c+EUsNdHJIqqOuihhFwVRPXVZpWkTVC/+BGze2+B+AeC9NdRdyLSMZ2OMn+eric9O7lITGg+saTrlhXaZ3FtJltOnVA4J9A2qaCmd4Tbudgsih+vRIwqv7fz5/BJ+BDOll8NJJT6US/OMBoloC3de1f5qw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(2906002)(66556008)(83380400001)(122000001)(38100700002)(2616005)(6486002)(6506007)(6512007)(38070700005)(186003)(36756003)(110136005)(8936002)(8676002)(5660300002)(54906003)(71200400001)(478600001)(4326008)(316002)(64756008)(66946007)(66446008)(66476007)(41300700001)(86362001)(91956017)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0xLVUNzTTZpZThiWmdXT3JwVHoxOTU0bFZ3VjUvaWRsZmNyTWlBRllkRU1P?=
 =?utf-8?B?VUpHVTVJb3V6YS80dUtxcjFIa0Y5YWh2NmNwaTNGQUIrQXprM3NxMFJkc0Ft?=
 =?utf-8?B?RXM3UGJjUXYzdnFTUjNhVjl2ZklRZHZPd0xERTdhQTlPNjZiczhla3FqcnNp?=
 =?utf-8?B?d1ZxNk5iL0pmckQ1Ui9PYSt0NnI5a0RleU5lMVdFb1JnUGY1azRBTVJEUC91?=
 =?utf-8?B?c0gyQTV5K0Rqa0JsV05SekF2dS80SWoxaHlOaElxamVzVGUyWTgzWC93VlVD?=
 =?utf-8?B?c1BjZFdRbFplS3cxUjdmbnZTM3pxdHFmSUJQaXdxS0YxclpzTTRvUm1rUlgz?=
 =?utf-8?B?ZVEva3BXN0R3UG8rdk5zV2RJeHVpMjYySEdaWDR2RnpKTU9zNkRVRzhvNjI3?=
 =?utf-8?B?bm5Fa09mQm5XWkJBWVM2SWRSb2pSZ2pvZEorTWE2VlFKVlkxNTBFWjVrczY2?=
 =?utf-8?B?a1BQbmJpQmJqaGRXSzFFN2ZlVEV2MkE0S0hzNWQwWU9OQ0ZCZER5Ym5TSjlU?=
 =?utf-8?B?cHZPclo4Y2U0VFpmNmgwN21FNDZvOXErQThQekNOL3QxUGFVNUJ4K3dnYXQ3?=
 =?utf-8?B?alczZS9hMzUwK2k1ZC94b1NuQ0p3OVFZa3N1RCtPaFRXRG4wSk5ReTlidTZB?=
 =?utf-8?B?ZnRZMVJaMmdLNmxyZHZCY1Ruaks0ZStkVVNUcUlPNi9wVmJ5c0RKU0VQUWZW?=
 =?utf-8?B?VllnRit6cC9pSkh2MkRjWkhBYy84U0R5K0hOdE9oMXkrTytRWVlTYkNDZkpW?=
 =?utf-8?B?UkcyVlNFdnVhUzlIdDlnU2dTV2RKQ09oenNCdnYzTEIzNkMyZWFyK3FIamtk?=
 =?utf-8?B?MGpGcmN2bGJzMWlxbHV5Mm9XV2NKcG1wL1dQNTdXWFAxaFN2emtyTXMxUTZM?=
 =?utf-8?B?V1BiOUJOYWZSUWhCV2xxbjYzQWZDbEVmU01uOGtUVlVodWFGdFB0bFZnYUY2?=
 =?utf-8?B?bzhmZ0lGWEplSlV4UkphVkd2aXp6alRMbXByd0tOTk45S0tDUExVeCtLbkhs?=
 =?utf-8?B?Z0JoOW9wS1BHVjdSZUowYUpVRzMxdUpRaFlvaHJjcVh6K0tKdUxjeW01bm1Z?=
 =?utf-8?B?NWFTNGF1RVpjUW5MTWNVYlRQT3AwY21zNWRGSkZGVFJrZmRPQnVJbERvYytG?=
 =?utf-8?B?c0kvaWpGWk5aWklzdVRQU3BJL08wQm9FT0FWNWo2RDEwaUxyM1JEdG9jTHlr?=
 =?utf-8?B?K09ha0Y5eWRiVVd1NjZFTzFVU1RGcWNhaE15QVNwa0crTExXSGd6N1JCazdr?=
 =?utf-8?B?R1pmb25ZRzZGZ2VoUUpZNWZQQmFBZ2ZpM0hoRWErWHJUdGFJYkk0UFRtc1dL?=
 =?utf-8?B?NVRwdlIydUpwMEZ3ZkU4NDE2MVdQa3AvbDlKVXFJaVd6eDBCU0NTR2phWGE4?=
 =?utf-8?B?TFhGb2lhRm9wVDZHYUlGMmRaQS9lQWxvaTNNd2l2KytJZ3Bhck9odlRGVVpU?=
 =?utf-8?B?QWhNdVMrSFJNVjhoWEFVbzE0ZXRjR2VDOFV0SFc2bFF1bVFhMldRTXo5Wmo5?=
 =?utf-8?B?d3JUSUNrZUNvLzIwTnFrZmRVSW5ubXE5QnZKWnovUkNsUnlHT0c2UW9maW5O?=
 =?utf-8?B?VnV2Q2tnbWhHSUdIeldkcVJkZDRhb3RtZTY3NTdFQ1NjcUFSMjRXN3ZGWnlj?=
 =?utf-8?B?UmxZMXRSeXZzeUllV1dzVHhRVFA3S1BJQjBrcHQvOGVHVzVmVmJEMUhaK3po?=
 =?utf-8?B?UmZQM1BZMzE0d2U4WWNKZm5rbXdVZHV4WWdXRkpGT2ptS091SmgzRGFIYnRN?=
 =?utf-8?B?YXpuQzBqTDNPOWJ2aEs0WkE5RTdPOEVMZSt5YVpyVmkvaG1VT3pFcFpSMEVI?=
 =?utf-8?B?MFlRMlBWZCt0cURFNEtMazVZTmpKRVRSNW9LVFNyZ2JtWEZYUG5vd3hTUkhG?=
 =?utf-8?B?WVEyME1wUmlSSmZTUHJtckxkaEhBVFJyYlpiN2RTNVNPMU91ZUljM1RVazNT?=
 =?utf-8?B?bUxJd2hGMlZOWWtVQmUzS1lEM2tvd3BtSXJwc0xYcVZQMTdqaEowdWp2ZU5D?=
 =?utf-8?B?RGQvbGMrNzVyZFo2eVNpMFhYOHVLdDVmT3doeTgyM2hteTJEVVE3WWxtNHlt?=
 =?utf-8?B?SE1TWnQ1c1VwSWg0bmVjdVl6Tm1aei9hbENZL2RQVFNITDVCcDdNS0tQckN2?=
 =?utf-8?B?YTNjLzFuMVF1cTRic1pOcnpEN2NYTGYwZk5jOHNVVHJEcUlZaS9zMDc2SCsr?=
 =?utf-8?Q?PLpjzbNe5e5JTOaOcAJW7krQht3Iavye7v5MkFTJ0PL2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3EC6E5CB1BC9549B3EF5D70863D9460@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f39ab4-4b0e-4e05-e459-08db4cc3c7a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 17:19:55.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QOyFlMY6YG7IGWF8aGjHkGdopsCmITX8xCWUG+MpEVminJpK6bPIRTITHmQLjFEkoSJr9iM8uiAU5UfLBJgLvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA1LTA0IGF0IDEzOjA4IC0wNDAwLCBGZW5nIExpdSB3cm90ZToNCj4gDQo+
IA0KPiBPbiAyMDIzLTA1LTA0IGEubS45OjUwLCBEcmFnb3MgVGF0dWxlYSB3cm90ZToNCj4gPiBF
eHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0K
PiA+IA0KPiA+IA0KPiA+IFRoZSByZWZlcmVuY2VkIHBhdGNoIGNhbGxzIHNldF92cV9hZmZpbml0
eSB3aXRob3V0IGNoZWNraW5nIGlmIHRoZSBvcCBpcw0KPiA+IHZhbGlkLiBUaGlzIHBhdGNoIGFk
ZHMgdGhlIGNoZWNrLg0KPiA+IA0KPiA+IEZpeGVzOiAzZGFkNTY4MjNiNTMgKCJ2aXJ0aW8tdmRw
YTogU3VwcG9ydCBpbnRlcnJ1cHQgYWZmaW5pdHkgc3ByZWFkaW5nDQo+ID4gbWVjaGFuaXNtIikN
Cj4gPiBSZXZpZXdlZC1ieTogR2FsIFByZXNzbWFuIDxnYWxAbnZpZGlhLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4NCj4gPiAtLS0N
Cj4gPiDCoCBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIHwgNCArKystDQo+ID4gwqAgMSBm
aWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIGIvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3ZkcGEuYw0KPiA+IGluZGV4IGViNmFlZThjMDZiMi4uOTg5ZTJkNzE4NGNlIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMNCj4gPiArKysgYi9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jDQo+ID4gQEAgLTM4NSw3ICszODUsOSBAQCBzdGF0aWMg
aW50IHZpcnRpb192ZHBhX2ZpbmRfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlDQo+ID4gKnZkZXYs
IHVuc2lnbmVkIGludCBudnFzLA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBlcnIgPSBQVFJfRVJSKHZxc1tpXSk7DQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZXJyX3NldHVwX3ZxOw0K
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBvcHMtPnNldF92cV9hZmZpbml0eSh2ZHBhLCBpLCAmbWFza3NbaV0p
Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAob3BzLT5zZXRf
dnFfYWZmaW5pdHkpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG9wcy0+c2V0X3ZxX2FmZmluaXR5KHZkcGEsIGksICZtYXNrc1tpXSk7DQo+IGlmIG9w
cy0+c2V0X3ZxX2FmZmluaXR5IGlzIE5VTEwsIHNob3VsZCBnaXZlIGFuIGVycm9yIGNvZGUgdG8g
ZXJyLCBhbmQgDQo+IHJldHVybiBlcnINCj4gDQpJIGRvbid0IHRoaW5rIHNvOiB0aGUgc2V0X3Zx
X2FmZmluaXR5IGlzIG1hcmtlZCBhcyBvcHRpb25hbC4NCg0KPiA+IMKgwqDCoMKgwqDCoMKgwqAg
fQ0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgY2IuY2FsbGJhY2sgPSB2aXJ0aW9fdmRwYV9j
b25maWdfY2I7DQo+ID4gLS0NCj4gPiAyLjQwLjENCj4gPiANCg0KDQo=
