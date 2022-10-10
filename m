Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C19F5FA228
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJJQuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJJQuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:50:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62DD4AD7E;
        Mon, 10 Oct 2022 09:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5KfnO6OCXkSr9NvxprCo2yINK1JpK98y+UnFr0ReaG+xnLaWs2vFIvrKuTrig8Pi5g+Hn5NoAYGgIEweSALDmuvhzQzBxyERURAmVBqyWx1L2nK8h3AHkNJ4m9oDxketIQftz9Xi3MT11f4P3LUoQOBx6MIcj2GAHalDlAN6PX16KDFSMIea+B8ZMXIUUUQ+apXhPMsQnVgxF3CNoB0/CTNU9xFXbvo7KQhamuL261Hb4b4nB2HmhKaI63BjT7gNhR4BgSOQr4xFig5pyBCXurDS4uHxHmMc0162nzTSE+bYPN0VALu7s49wdElculoI3Yf4MODr5Wwy8FmmryFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrp7+4hyUFJwX9AEHqdeq9gIIAFN8PtcdUsqpNzq8cI=;
 b=VbWiS+Pe/TC4pnSxYnB9n0sViILJ5BYRONyQjknawQfgedgpmLp62mrmkVmRJnid+2hXrpNYfWlPCOiYdL9RjjzcqT2oK/E3hY6fr5Cll0gldXosSQLBj8oSrmdKVR+N0rhUUwS6xuHkctwqlOyEz3XxU5Nvh4mlBzbSdKi13oUqSwYaQQxGmvu86nArEiZvjuY+UNqToLsjESsKe/QH/6FmCyWuhhpYR86f+oqdfYW/NoLVI+K3eNmHcuWwoC8uvPjKlD2L6dRDQUL6G7NTeVP3AlgXwJdKgvV/lcMWd5a45sTd+ApbEPmaXT2sOJwqgURY7pX5AnBKrJYFP7wYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrp7+4hyUFJwX9AEHqdeq9gIIAFN8PtcdUsqpNzq8cI=;
 b=LcAHllR4lTh05HPKpUatHC4snKSvBFso3fs4kNMPtCzGQHfrGg2fcQbCbn6fKTGU+UXQWkSE6aOMMi5MsVrHh5EPmTJcDGRv1lCuC6JzFFPbctqw90WqQiD56Gv7ORh94whEB92PHpj6RTo02sNpL2ZCK7cYNBIwJkW3ZKLlh6+H0PkZF/NIAfPQutmiH5j/b8zbDG9fZuKWqcwutImogMD/ny4+BnLyHg8cO5TqU3F5BWdVXg3w4pFQxmdRwFwDSQ3JLRiybyyBSeNGjE/62sWcspem6nt8hVyJ5Dh3JHjECRUE1XYP1s6MM7xL9uHyQ+MV5ND3h2StAP9JzTlspg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Mon, 10 Oct
 2022 16:50:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4470:ef9a:5126:f947%4]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 16:50:33 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "christoph.boehmwalder@linbit.com" <christoph.boehmwalder@linbit.com>,
        "tim@cyberelk.net" <tim@cyberelk.net>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [RFC PATCH 01/18] block: add and use init disk helper
Thread-Topic: [RFC PATCH 01/18] block: add and use init disk helper
Thread-Index: AQHY2Hd3mT3s6BbeS0OAwKwU2s1ekq4HS2GAgACUgQA=
Date:   Mon, 10 Oct 2022 16:50:33 +0000
Message-ID: <798a9b0b-a157-6d66-14f6-c600a2aeffae@nvidia.com>
References: <20221005050027.39591-1-kch@nvidia.com>
 <20221005050027.39591-2-kch@nvidia.com> <Y0PQxdzmMzAAW0KF@infradead.org>
In-Reply-To: <Y0PQxdzmMzAAW0KF@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6138:EE_
x-ms-office365-filtering-correlation-id: b65b0484-856f-4c53-70c6-08daaadf8c0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgT8Hf2yqmm0mMLyGIQDy9thQ86Q7VsALTJ1vD4rilEdB/GPidv3j34wu1upVmMJAYk0MXRhWcZdilYenlPwYugdpKgB/Z26VZRupC3jQEiHSGoezFTuNOwrEDLAuOwNVHlrf60VBB8j1tsVgIsphGOgJ6RC6Lr8XnFi5fi1ySwwiQGVWn1zDhVrBV+fM++hapY+2yHn8eZRx5sn0CrJT4QRacdrl9sDipGjCoryJ4Q4go/i3TMbdDcXW2YIKWzvTX8+fGzGCPgQy7GqQ/RI4DlVOHj0wx9PzYQYx9pjQORgjZiYQvBwCSG+LFtXGD/SXie24Mum49AHTIdDhtVDpn1nZuuNUq9lqKQBrnm++SK+yJ8BPbe6XEf0KiFQ/Sqg5grCzQWVisEFPhbKJxw7Jw8zCn+Fjy9LwDhVBSSI1fHRibS/P2xXTEWPfCdsg6AAmd9VqcXybrvdetKWLYUOoVgsoj3vifiQnTN4mCq8IrAx/8FfByl8GG/15KefqKUVNI5TevvWRL7CGVWS+3qu+AUkCouRR3zz3F4hDEutca7j3ctaLnKmoP9vmYc2cnbREg3EtDrMHE/yfTCCNDnQKA4qi+DlCD+hdupN9dLQ3rmd/ZBlutYEVHvZ3LBkzPTpfD5RD7ZI3wR2+ZarJ3AL1ydssXIR8h71aCVBkVoyCwal+SqXpWp6qS57rftCV1lQnnU7/DFAcyUys0Pgi60fYs3z6v9aFNSAL6om+QhbEoz6+xs2xd/f+vMuqY1COw/yQDkqxsFoEplL9nbIZlBvodUK3zaFC208UlZv3sFdia6KepLCCDUiSjKIIQydBt/AbslLOuwmWElMg15Lw3cfGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(38100700002)(66446008)(2616005)(83380400001)(38070700005)(31696002)(186003)(122000001)(4744005)(8936002)(4326008)(66476007)(64756008)(8676002)(54906003)(66946007)(5660300002)(76116006)(41300700001)(478600001)(110136005)(66556008)(53546011)(91956017)(2906002)(6486002)(6512007)(86362001)(316002)(26005)(6506007)(71200400001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2h3bW5Pbmd3ZGRPSUxEL2U3bkNKK2Rhd1NSZVlxbFdqTFY2YjZyMmppQkFr?=
 =?utf-8?B?NGNiVXpwOEw1NW1NWlZCcDFha0FQQ2Z4MWRjcWZuZDJuR2tTbzZqdk1DbW9h?=
 =?utf-8?B?MDlSRWpSVkR0UTVDS211dElnZFBXeXZYVHFDdlF5NXhlbWM0RzNwS3JibXp2?=
 =?utf-8?B?NjRndzNZekQraFRLUTlxb3U2ZktWb1lJUTNINVovcTh6T3dnZEJuQUUzYzM0?=
 =?utf-8?B?VmZsU0F3MHZBajJCU1NtcjhodGtWak4rYmtpc3JjTVhGZG1qd094MWxFTWpj?=
 =?utf-8?B?UjhxS2MxbVpIOERzV2tqTXB1SDRIWkNVUFJtWFFlTmR6cDdjc3JWdktuczdF?=
 =?utf-8?B?NzNBZnJDUEVCQ0lsbERKN1JjNkNKRDU1MXFvR2pOL2dUMEx1QUpuWXJCK3R3?=
 =?utf-8?B?VDYzQ0Z1SldzbjhobTdoc3UwaVF3TzZjRkdrZDk2TnRxMWFqL2dZdWZBeE9P?=
 =?utf-8?B?NStmUTdselRhK0VDS0tWRkxIWDZ1Y0dqVFI1Rll6OGh4MHZiQnJPVTJUbTA2?=
 =?utf-8?B?d2cyYVgxSFA4dVgyZUdyOGU4Q21oR1hMQXp2QXVxOGdtak5GbTJMdzBJS0Q1?=
 =?utf-8?B?QVk1QmU3TTR0ZDhVelI0M1BYdWwrcUY5Vk45ZXNZZU84eWRVa042U20zVTlr?=
 =?utf-8?B?SjcveDdTQnBmakVGZmlReFQ3Z3lUZk9YMm5pTnJBVU1vZXdZRENUWlJTNWVT?=
 =?utf-8?B?eHVGWjNKMGtwWVNaR21xUE5sR0diU0JjNldncFFmaGp3aE9wMmpsYm9yNkpY?=
 =?utf-8?B?UjNqRnZxMzFMUkMvdjlhd0R1Y25PVGE1QlA0aFh6Y2RoNmtjUjduZXVzSzVj?=
 =?utf-8?B?dFUxdi96MnRueDZRNG9LNk9VOXV2MmZpYmEyRVpiODZMSHZFWkE0OTZERklR?=
 =?utf-8?B?QzFLeFZibDJsRlR5K0FPMHZKbDhPdnRzZCt1VmlYa3dzVy9hYVZyR1R0dG9Z?=
 =?utf-8?B?TDRtanJ3WVZnQXRxVnBJRDhXS1Fob0krNWFTcGhVNVA2aEx1U2NHNGo4TTIy?=
 =?utf-8?B?Qk44YXo1RmRPMDdzSjU3NjlLQXlmY3ltUzBkUEZiTnFTV2FyT1d5YXdvSWNO?=
 =?utf-8?B?UjBlMWVvNXNpZGtRZ2p4blMxOExWTm9GWEhNSEJOZ24veU5SNzBWZjgxdHg3?=
 =?utf-8?B?b2F4OVcvVGovYk5RME0yRkhYZEMwV042V0ZuNUdWWklFa1lYMjh4b1N6SlhS?=
 =?utf-8?B?WjcyeXhIRS91VXRVd01DYTJ5MnVvd2xYeVR6Rkc5ckkybEhTbTZkbUpsMHEz?=
 =?utf-8?B?b210akw2aUx5WEQ1UkFLaVc5eEd5TE96ejE1MDlLK2VodGRuS0RhLzRjVUNU?=
 =?utf-8?B?MTg2bEo3WHpCdk1ac1d3b0pHNW01dUdETXBjWGExZnREbDVWbHRVeFJWTFUz?=
 =?utf-8?B?WGpHeitncndDK2YwaFh6UkhvVVpLL0RPaCtpdFU4N3g3Rzd3a1lQK2VsRUh1?=
 =?utf-8?B?QS96UTZIYzB0bjErdGNUY0MrT3JwYWdFMU1iVnBIa0VuRXYwd3ZwdWNnajZR?=
 =?utf-8?B?QlVIa0RVUkZXRUkzWmwyc01SVThFcDlxNnlYODRhNHJpYmhQOHJVanNCOVZY?=
 =?utf-8?B?NUh4NkJBeVlxMzNJT3g3R1VRYllNNFF0R1NJcmF2ekluZnN5RUd2QnBDenlJ?=
 =?utf-8?B?Sit2UThMY0Nua0hGYUdNZGJ5MmE0dkthWEcxY0xzb0hQcUkxZmIvbmtPd1Nz?=
 =?utf-8?B?SGhJNnE1aVJ0aWxVNUcrVnpyUkVxVjBGNm45cXdmaEZYU2E4aW51dEZqanBQ?=
 =?utf-8?B?U2lleXhzRlJGK2RDSGcrMEhOTER6Z0w3dDN5enVVMXlPQXVINTNPa1dRWTBh?=
 =?utf-8?B?ZzlidW9mbHR1TUx2cllETkRVTXpsS2dkSzJGOVZiOVZLaXJINDhKcDNnYTND?=
 =?utf-8?B?UDFlOU1sNXphOTBmQUMzSGdHc2RkM2lXMmtSY2s4SXZpSzhYcXY5WEdnaU9O?=
 =?utf-8?B?MHBNYTRNUjloMUJtcndVVG13VktUQXk0L3pFNUczeU1jc3N5SHZTRWJHZWgv?=
 =?utf-8?B?dlBLL0YyMXBDakhlVEpiNVFXQTJnQlZ6bGd0bzA2V3g5bkd1Y0JYSE1Bc1Jr?=
 =?utf-8?B?QkVSUTFPZnIrUXRGbFZmS1prQjlVSFgwRE1RRGhmcW5scksyVEk1aXg0RlZW?=
 =?utf-8?Q?uI5S+3pCS6jQ/N1097mwCfnI0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B198BFE16C7B34BB2C74DF2C8BEDA9D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65b0484-856f-4c53-70c6-08daaadf8c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 16:50:33.0219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcHt16xa8Jef78jhfQR12/smZjIDL7sKaSiPEtMYzntvCScXI4WvOvblzU10Mil15H2vinCzNl4Mli2AGK5I7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTAvMjIgMDA6NTksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUdWUsIE9j
dCAwNCwgMjAyMiBhdCAxMDowMDoxMFBNIC0wNzAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6
DQo+PiArdm9pZCBpbml0X2Rpc2soc3RydWN0IGdlbmRpc2sgKmRpc2ssIGludCBtYWpvciwgaW50
IGZpcnN0X21pbm9yLA0KPj4gKwkJaW50IG1pbm9ycywgc2VjdG9yX3Qgc2VjdG9ycywgdm9pZCAq
cHJpdmF0ZV9kYXRhLA0KPj4gKwkJY29uc3Qgc3RydWN0IGJsb2NrX2RldmljZV9vcGVyYXRpb25z
ICpmb3BzKQ0KPj4gK3sNCj4+ICsJZGlzay0+bWFqb3IgPSBtYWpvcjsNCj4+ICsJZGlzay0+Zmly
c3RfbWlub3IgPSBmaXJzdF9taW5vcjsNCj4+ICsJZGlzay0+bWlub3JzID0gbWlub3JzOw0KPj4g
KwlzZXRfY2FwYWNpdHkoZGlzaywgc2VjdG9ycyk7DQo+PiArCWRpc2stPnByaXZhdGVfZGF0YSA9
IHByaXZhdGVfZGF0YTsNCj4+ICsJZGlzay0+Zm9wcyA9IGZvcHM7DQo+IA0KPiBJIGRvbid0IGxp
a2UgdGhpcyBhdCBhbGwuICBGb3Igb25lIG1ham9yL2ZpcnN0X21pbm9yL21pbm9ycyBhcmUNCj4g
b3B0aW9uYWwgYW5kIGRpc2NvdXJhZ2VkIGZvciBuZXcgZHJpdmVycy4gIFNldHRpbmcgdGhlIGNh
cGFjaXR5IGlzDQo+IGEgZGlmZmVyZW50IHRoaW5nIGFuZCBpcyBkb25lIGJ5IGhlbHBlcnMgYWxz
byB1c2VkIGZvciByZXZhbGlkYXRpb24NCj4gaW4gbWFueSBkcml2ZXJzLg0KPiANCj4gSXQgbWln
aHQgbWFrZSBzZW5zZSB0byBwYXNzIHRoZSBmb3BzIChhbmQgbWF5YmUgcHJpdmF0ZV9kYXRhKSB0
bw0KPiBibGtfbXFfYWxsb2NfZGlzayAvIGJsa19hbGxvY19kaXNrLCBidXQgZXZlbiB0aGVuIEkn
bSBub3QgcXVpdGUNCj4gc3VyZSBpdCBpcyB3b3J0aCB0aGUgY2h1cm4uDQoNCk9rYXkgSSdsbCBk
cm9wIHRoaXMsIGFuZCBzZWUgaWYgSSBjYW4gZ2V0IHNvbWV0aGluZyBtZWFuaW5nZnVsDQp3aXRo
IGZvcHMgYW5kIHByaXZhdGUgZGF0YS4NCg0KLWNrDQoNCg==
