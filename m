Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D916156DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 02:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKBBKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 21:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBBKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 21:10:01 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345511A396;
        Tue,  1 Nov 2022 18:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOb+JovXhNDL9vgPgYIVE0Qr523EBfwY2nj092pWVPLKt3Px1/MU2deOh8+Se+NNZEn0Otnb1nizCwyYCbABYf/cxD2/AhifUSpe+vxews/u7oEVqEnUEoKo6cFidJY+XvjKb46IPtrBv1vR4wxchZNrXIfLNgbYdL2ATP+4vPICYF0pRxfc668NGbAXVrz5pzP5t745SyawwW4IoBAWWubaAsufin+y9sGkbpkzo8alpO8Hm9n88BoljouK25hkZFgHBmPB3ntpWppwKtlUVMBnEGeETSrfzm03DCXQm2eXNNqRawmQbo7z9x18gmRIUIN9QRYdqZ8WwipYu/d3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IcwIcRbZauIkG16BYnvyyggNvcUNROgpxho05VtLYs=;
 b=O9kWPDrxerLapkqjBCZ8G6XGcDr11uQ27/yBAyG3bipbCOlK0OvJU8f3zVgtvoAGxXk+bJI7pCVD8wdzN5i5xcdIxWGcfst+jF0tVSF+JkXuPBA2CDm7CqBEDf/89ZdcDRzOw7ZZgotGCFFZkIYXxz+l1kaCwxIKew1YZy+QZau+nlm2YTc/bHBkDZAk8SHjVqAVYYgHNq91UxyesnBba2qBwU+0ZKtfZisz6/4Pwte0bkq+CFTbQFrJd6WDSKk+UQldwJpobx8obWsz+8qZJhN8YLZewL25W+0d1XxEVMbNbBvZBzh67j68HCNdX9PFFH1T0+tMqWlw6a9lObKVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IcwIcRbZauIkG16BYnvyyggNvcUNROgpxho05VtLYs=;
 b=J2jO7h7lbl4jzglR5Z9p2SyAReHimJs96cTFhMPidJyU8BN0F2NoZ61kRdIPVtAO3YfvHGjrKP4dCs2R6po5H4MH9cd+43quiCEn2rRRIm33bwz4ypuyzCxaRMWVuH47YF8cm748DAJo8ctitD4ME+thMvW5/7ZwI/2LnH852VYe5URabv3fjvpE5I5pGXCbExr+c+mobGVFhGmwDxchnUUTPmxY0UN5QiB4px+l730viuYRxvkUiglOkGl8fDY0XCEl2yeiskCbP7xOM3I+kHJJFHhSUPOvIQ+falTDp1pLWFpofrDUKaxlR6yk/nopO1Mh6kaTJb1S0cWco291Sg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 01:09:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 01:09:58 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH] null_blk: allow teardown on request timeout
Thread-Topic: [PATCH] null_blk: allow teardown on request timeout
Thread-Index: AQHY4R8DFU2LJu/Wy0udZZqXPfzvLK4SpTKAgAJ8nYCAAN/vAIAU66oA
Date:   Wed, 2 Nov 2022 01:09:58 +0000
Message-ID: <0d7bdb05-07e4-d414-dced-8bd30d1fd9c0@nvidia.com>
References: <20221016052006.11126-1-kch@nvidia.com>
 <f2baa3b4-81c9-a6d8-0c26-3e695dad5d10@acm.org>
 <d3e05b4e-466b-844c-b815-79233856e527@nvidia.com>
 <b49d7e9b-fdee-915a-436a-bb624addf9a2@acm.org>
In-Reply-To: <b49d7e9b-fdee-915a-436a-bb624addf9a2@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6529:EE_
x-ms-office365-filtering-correlation-id: 9c853fe8-0c54-4025-3657-08dabc6ef5e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9umSa5CqNJ4wd+z9OnSzFNcLCojlp3FGiGzwTE/OvvAgFFbRybCgcMEoh3fJGluUbSiPz+gHfVJH+9OdPxDKx2hRuKFTGX73BGjyItChuAB67fHefeQIZCyRr6pmq5h8gUgZXZ0gK8Hvth4vQSFOJ5eJ2JE+P2yaXlNQxNK/5wPcv/58kfjTLaEepdsA9xV5WvFtxa1vnoXWh1fd5INgaxYZa3CyJV31vRUMPyj0aKiIS0aBY79Hz/0R4CdQURQa8Ru68berDlf+jCx5qFpCFEzvNdAITVHyYn0f4P34lbyp1gCyzJb6Wi04P8xNdgTX0uhUxxNnd2eM8qHL27V8ss/XOE7xjUHWkgaCBJRVKu420Nu0dtrLXdh4RGd7HBO8n/tosfbt1n2ZSKtA7EEajwPTACOWljKdq5K4ASjBQRzlTPVkyKoS60OxQYmq+KXvJ6cH5AaFDe6WgtV+e93khSfCMhQ/OR1Jwm16nZHdv8b/ypDsRMlqUAQL+s8uczP0BTb0PMgtHoRtWEk0XssyuWBYP0FVa/wc+zQAHEXqo1mLfu9C+Kejy43cw7ZDU+bL5fDbnkCmq8vjWUJwWQjL2WUP60LF3czfFKpvhuImcrc8IRubFhivhFEPCFOfErdvSjhNAXrtHIdHyqlD/4VaPrtgEr9KCNo09g3ZGu8VelgfyzLyMxlNKu7UCc6bmsoioMU9su7FKXOpNk+U2egjON2afdnGh7jsIH+L1SSQsyWgJD8twh/mtSsnT8PvJBJIrcAPkk4ntdrNoF7DAF9xPVXo9IgmMuKPZQDiy8w2EoQ5FosHifFw26FWBcPs+NB9teilLNVOt6fG3Pe71X09LW9ZVZt0D8g1NGHFRjY8jPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(31686004)(36756003)(38100700002)(5660300002)(2906002)(7416002)(122000001)(83380400001)(31696002)(86362001)(38070700005)(6512007)(316002)(54906003)(478600001)(186003)(2616005)(71200400001)(110136005)(41300700001)(91956017)(6486002)(64756008)(8936002)(66556008)(66476007)(66446008)(4326008)(66946007)(76116006)(8676002)(6506007)(53546011)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzFVTlpvRVdaWlAwclVOZlJFNzBwUXVIeWNBSUlmVGdSQjBiOGd2bDdFUXJh?=
 =?utf-8?B?WjEweG9iZ2xPTTRyYWJpQ3lDQjIrbEJ1SUNkcGFGaGZ4RDlBb3M0NHE2Zy9M?=
 =?utf-8?B?RXFTSVd5aXhMOGc4MCtXR1BseWYvUVBEaGh1aTU5RHo0M3FiVEFSR3hZR0Nl?=
 =?utf-8?B?WWdPUm1UeExseWZFTHN3RktrckdJbW1tUGxMTTk0MkZYOTBWekJzREZzd0ta?=
 =?utf-8?B?V3k3cmQ0NkYvbEZXdklZaitjajIvTWpHbEJtZXVkMXlYU0tYNGxhdGJMQWsx?=
 =?utf-8?B?aVJNMEN4YzVrS3R1Rnp3OXowSEhLZS9mTFNydFBKdmxqWEJ5TiszYUpPMVlo?=
 =?utf-8?B?b3RtSUQyNjVjalUyWFN4THhKRDQrVXdMdFBGbEV4UlpjRUVJOWY4Si9zNnI3?=
 =?utf-8?B?ZmtsTmhGZC82NmVvOG13ODJlNU9kN056UDhXaEdFWG91UXM2bUxUZjNWQjRB?=
 =?utf-8?B?c0lSY0RwSUlYU2xoYk44VVNSdTVzYzJKM015Q2d1cmcyUlFleXV5WkhUdFRM?=
 =?utf-8?B?S3BCZ0ZySUs1N0paa1F5VVBKRUZBeC8veVVRMEZNUzAxV3FWc2dSdmdIVEgz?=
 =?utf-8?B?QWZBL09BM0dBdk9kdlJFaTdBRjJxMkFTTmh2SFpWUG85bEhwcjkrdlZ2MGRQ?=
 =?utf-8?B?anVwblZRMHhCREc5dTJoSEtRc21UTy9ZWktxajFBZXp6dUUwWnJkZmdLM2ZX?=
 =?utf-8?B?SkVSYUhVTEkyNnhsYWpXeUh6WHR5aDl3Vk84L1puRGE5dWNYNEU3bjZ0MTlJ?=
 =?utf-8?B?cUVLMEJZYW50aTYzRUE3d3d0Z0llaS9LYi9ibzZTR2FoY2tEaWZoclF0RjRI?=
 =?utf-8?B?MitGVDN1NnFxZWk0OTRqMlJZaWdNc1p2YkpURTkvaFpnSEVHZUdpT2hnTVNv?=
 =?utf-8?B?TDF3emR2ODY1N1hkV1Zpa3EvUlpEbUx6MHluUHZTaEd4TXM2RUx3MzdDOGtB?=
 =?utf-8?B?TDJxWHh6dXNKTFFpRjY0ZllaOGZab3dNdnNWaFlrUzBIZXo1TUNpRHNGSUs4?=
 =?utf-8?B?OVplRjh6OU50WU0waWJYN2NhMHNsUUVFWk92ei9KVnJ6RW0vRHhxd1c4N1VM?=
 =?utf-8?B?MXhFS2JsRElSRHZCUDhaM0pyUHVxaGZmR0dpQTRwMkF5ejZaSHJEdHA1ZlhY?=
 =?utf-8?B?akRkVVBZR2tRcGpMTzg5QTA0RW1PUExYSUpYT2M3ZCswZXdyZTVXVmIxUnJa?=
 =?utf-8?B?WGR0bkpseDQrcHI0ZXpqT3VEdW5OWGV0RXIxK0E5VTdZVmxQN3lwZTNzdC84?=
 =?utf-8?B?Z0RuSkUyazBnRGlVWkZHbG1CV0JmMThyNk90Mnc0N0pjSzdyMEFraU1rdTB4?=
 =?utf-8?B?WUpJVkIrK1JmaWdJaHJUdTdKRS9xcXQvNjdHWUptZGgyYWRHWXVoY3hFcTRi?=
 =?utf-8?B?VnR2bXV5OGtPLy8zbkhnUEFjN0piODZTQWdPb0x2RENuaUJzaGhZY2I3VVhs?=
 =?utf-8?B?ajhQOFVvT1FzcEJhaXBhbnk0T256U0tOdFcwVkNWNGErc0lZNjdGWXJvVXU4?=
 =?utf-8?B?OHppeEQ3Rit1Q0NnZW1EMmlDWG04TmMwVEJjRjFDdC9CUyszMWJWZmNvQ202?=
 =?utf-8?B?T2k4SzFRRkdVa0FWZzl1eis1VEpOT2RqUmhMRUlsZFJlU3JLNk0wczRTUFFT?=
 =?utf-8?B?cFRXc3paa2VDZHptTEVMWWY3QlZpVzNNZm1Rc3F1elhXdWRSb0hRWnRMT3Qr?=
 =?utf-8?B?anJZTEhPeUZKLzRyYjY2V3R2U09LU3J4M3cvQkZFZVk5ekhJMmNheFMyZXNv?=
 =?utf-8?B?cG9QRktDYnAza0xSVGpidjNwMWlUTURWTDdGUEdPNGdpWnc3bGRmUDRKSk5i?=
 =?utf-8?B?bTh0N2xacjM5cXIzamVlb0QyWjdWZG1ET2RwTGZwbkR3b09QTHJnMEtoNTU3?=
 =?utf-8?B?b0JjZk5XM01EaStvKzJnRmxKNFF6SmNBZVBQMUUvM2d0Y0xaZG42RTgzWFh6?=
 =?utf-8?B?aGVJa2pmWXN2L2xEeW5xdWkvWVM4Tnc3QnM4VzI3S0NMeEJjVTJiSUZnUjRT?=
 =?utf-8?B?Z1QyaTlEQ2xweFpnN0ZOUENxOU5zc0MwaGxqSUZvZi9HV2ZHRzk4bTNFMGxz?=
 =?utf-8?B?T2pEd0ZoWUg2T2lYWkNBR1NRVGFaSVZ4NXdUNmd6VUJDcEJLSXVzRkpiM1ZW?=
 =?utf-8?B?WGtNcjBraytidUUwUjJCSnNncGZnd2lNUlV1Y2hkcURad1JBRWFGZC9nWm5Y?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0024351DDAB0FB49BCB2E35AEAD3F2F0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c853fe8-0c54-4025-3657-08dabc6ef5e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 01:09:58.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SwkUBuCUhAsDM2RvSSGrQ6uPHFXNjEv2Drg6+9whjyaiuuQnE4CNeGH2b/Mtz+Yh2rC90SWPfTHIq49v07zPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTkvMjIgMTA6NDEsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gMTAvMTgvMjIg
MjE6MTksIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEFsc28sIEkndmUgbGlzdGVkIHRo
ZSBwcm9ibGVtIHRoYXQgSSd2ZSBzZWVuIGZpcnN0IGhhbmQgZm9yIGtlZXBpbmcgdGhlDQo+PiBk
ZXZpY2UgaW4gdGhlIHN5c3RlbSB0aGF0IGlzIG5vbi1yZXNwb25zaXZlIGR1ZSB0byByZXF1ZXN0
IHRpbWVvdXRzLCBpbg0KPj4gdGhhdCBjYXNlIHdlIHNob3VsZCBsZXQgdXNlciBkZWNpZGUgd2hl
dGhlciB1c2VyIHdhbnRzIHRvIHJlbW92ZSBvciBrZWVwDQo+PiB0aGUgZGV2aWNlIGluIHRoZSBz
eXN0ZW0gaW5zdGVhZCBvZiBmb3JjaW5nIHVzZXIgdG8ga2VlcCB0aGUgZGV2aWNlIGluDQo+PiB0
aGUgc3lzdGVtIGJyaW5naW5nIGRvd24gd2hvbGUgc3lzdGVtLCBhbmQgdGhlc2UgcHJvYmxlbXMg
YXJlIHJlYWxseQ0KPj4gaGFyZCB0byBkZWJ1ZyBldmVuIHdpdGggVGVsZWR5bmUgTGVDcm95IFsx
XS4gVGhpcyBwYXRjaCBmb2xsb3dzIHRoZSBzYW1lDQo+PiBwaGlsb3NvcGh5IHdoZXJlIHVzZXIg
Y2FuIGRlY2lkZSB0byBvcHQgaW4gZm9yIHJlbW92YWwgd2l0aCBtb2R1bGUNCj4+IHBhcmFtZXRl
ci4gT25jZSBvcHQtaW4gdXNlciBrbm93cyB3aGF0IGhlIGlzIGdldHRpbmcgaW50by4NCj4gDQo+
IEhpIENoYWl0YW55YSwNCj4gDQo+ICBGcm9tIGNvbW1pdCBmMjI5OGMwNDAzYjAgKCJudWxsX2Js
azogbXVsdGkgcXVldWUgYXdhcmUgYmxvY2sgdGVzdCANCj4gZHJpdmVyIik6ICJXcml0dGVuIHRv
IGZhY2lsaXRhdGUgdGVzdGluZyBvZiB0aGUgYmxrLW1xIGNvZGUiLiBJJ20gbm90IA0KPiBzdXJl
IG9mIHRoaXMgYnV0IGFkZGluZyBhIG1lY2hhbmlzbSBsaWtlIHRoZSBvbmUgaW4gdGhpcyBwYXRj
aCBtYXkgZmFsbCANCj4gb3V0c2lkZSB0aGUgb3JpZ2luYWwgc2NvcGUgb2YgdGhlIG51bGxfYmxr
IGRyaXZlci4NCj4gDQoNCkkgZGlkIG5vdCB1bmRlcnN0YW5kIHlvdXIgY29tbWVudCwgdGhpcyBw
YXRjaCB1c2VzIGJsa19tcV9YWFgoKSBBUElzOi0NCg0KKwlibGtfZnJlZXplX3F1ZXVlX3N0YXJ0
KG51bGxiLT5xKTsNCisJYmxrX21xX3F1aWVzY2VfcXVldWUobnVsbGItPnEpOw0KKwkvKg0KKwkg
KiBXZSBhbHJlYWR5IGVuc3VyZWQgdGhhdCBzdWJtaXRfYmlvKCkgd2lsbCBub3QgYWRkIGFueSBw
bHVnZ2luZyBieQ0KKwkgKiBxdWllc2Npbmcgc28gaXQgaXMgc2FmZSB0byBzeW5jIHF1ZXVlIG5v
dy4NCisJICovDQorCWJsa19zeW5jX3F1ZXVlKG51bGxiLT5xKTsNCisJYmxrX21xX3RhZ3NldF9i
dXN5X2l0ZXIobnVsbGItPnRhZ19zZXQsIG51bGxfY2FuY2VsX3JlcXVlc3QsIG51bGxiKTsNCisJ
YmxrX21xX3RhZ3NldF93YWl0X2NvbXBsZXRlZF9yZXF1ZXN0KG51bGxiLT50YWdfc2V0KTsNCisJ
LyoNCisJICogVW5ibG9jayBhbnkgcGVuZGluZyBkaXNwYXRjaCBJL09zIGJlZm9yZSB3ZSBkZXN0
cm95IHRoZSBkZXZpY2UuDQorCSAqIEZyb20gbnVsbF9kZXN0cm95X2RldigpLT5kZWxfZ2VuZGlz
aygpIHdpbGwgc2V0IEdEX0RFQUQgZmxhZw0KKwkgKiBjYXVzaW5nIGFueSBuZXcgSS9PIGZyb20g
X19iaW9fcXVldWVfZW50ZXIoKSB0byBmYWlsIHdpdGggLUVOT0RFVi4NCisJICovDQorCWJsa19t
cV91bnF1aWVzY2VfcXVldWUobnVsbGItPnEpOw0KDQp3aGljaCBhcmUgY2FsbGVkIGZyb20gZXJy
b3Jfd29yayBpc3N1ZWQgZnJvbSBibGstbXEgdGltZW91dCBoYW5kbGVyDQphbmQgdGhhdCBuZWVk
cyB0byBiZSBhIHBhcnQgb2YgbnVsbF9ibGsgc28gSSBjYW4gc3VibWl0IHRoZSB0ZXN0Y2FzZXMN
CmluIGJsa3Rlc3RzLCB0aGVzZSB0ZXN0Y2FzZXMgYXJlIHBhcnQgb2YgdGhlIHNtb2tlIHRlc3Rz
IHVuZGVyIGJsb2NrDQpjYXRlZ29yeSB3aGVyZSBibG9jayB0ZXN0cyBuZWVkcyB0byBiZSBydW4g
Zmlyc3QgdG8gZXN0YWJsaXNoZWQgdGhlDQpzdGFiaWxpdHkgb2YgdGhlIGJsb2NrIGxheWVyIGJh
c2VsaW5lIHdpdGggbWluaW1hbCBkcml2ZXIgdGhlbiBtb3Zpbmcgb24gDQp0byBjb21wbGV4IHN1
YnN5c3RlbXMgb2YgYWRkaXRpb25hbCBkcml2ZXIgY29kZS4NCg0KQ2FsbGluZyBibGtfbXFfWFhY
KCkgQVBJcyBmcm9tIGVycm9yIHdvcmsgaXNzdWVkIGZyb20gYmxvY2sgbGF5ZXINCnRpbWVvdXQg
aGFuZGxlcnMgZmFjaWxpdGF0ZXMgdGhlIHRlc3Rpbmcgb2YgdGhlIGJsay1tcSBjb2RlIHdpdGgN
CmNvbWJpbmF0aW9uIG9mIGRpZmZlcmVudCBlcnJvciBpbmplY3Rpb24gcGFyYW1ldGVycyBmb3Ig
bnVsbF9ibGsgd2l0aA0KYmxrX3Nob3VsZF9mYWtlX3RpbWVvdXQoKSBhcyBwb3N0ZWQgaW4gdGhl
IHBhdGNoIHRlc3QtcmVwb3J0Lg0KDQotY2sNCg0K
