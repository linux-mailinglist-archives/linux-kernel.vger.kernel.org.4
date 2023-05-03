Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481C66F54C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjECJcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjECJcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:32:11 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15B344B2;
        Wed,  3 May 2023 02:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sxg3p/1gQwPlFV1I2fDX0KQA6Y4+RrEWAkQbDKQt2h/HCiZs97MtZ9OWzBQ4uqavaOcdGBRLJGYKEsfqkibaGSrfxQDQPNdJkGwBNsWGp3KQ/c9GqNZgg8MIGXLXSvopAu8Cq9R2X2MMtRhJ0oeK3ZYN5DK9zm/xkfexPqrgJt61fFZKWm2pxLG3aLoUh4deTRJ3lNDEZnMawHOVrWWiK4+W4kcdoZRlNoalxo2CxIjLatbxAFP79gQdcraGpGdPCV3e3FEryawi4oEd84dJ1VINmAyspdOfDvqkN2RUjkuJQVv3UriLeiowo7joHQpyJKW23+HziFiIiblA/cRNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3wsXDZGQy6m8skb11Eb5sBRDTFDyyZVX97V51DnHjo=;
 b=DWwWfvokOojPIL/aCOuDgx1vZgZJRgETSVorX4TDfF4NDYJYJPzICm2Jp51vyOnxBsYH0Qu3kKAmuWKa6smkSUBPwTkzEiIGrEKjepKAMqDOA8GrT0sMIFcoXE8CSP148IKcqyyNXdA3s3sKIiJOGMFIpQZaOM78YnXIJTGZDCdUFXyNzl9KNqBwYYoXXoivEdv4EbsRGveE9JJRP3fBJqROhcqC8B6N1qRAifExJOsPmSDVWIK1XxHH4X88x551+zlH3whDChac13yFZqjvL3TTNjTqYMpXiWGQ/jDMyvnRcNsFQJTcLKZEwQLNntLH5nwnzHwxjMB8hKN96NMjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3wsXDZGQy6m8skb11Eb5sBRDTFDyyZVX97V51DnHjo=;
 b=JMKkGYXp0K8r768iqYMulHloH8kMMEyRX6qtr9GuOXwvErVeB1HjH1nbKf2Hz+fXauRDhvAt0A5+WpZmksCCQq8Lb2lpeAlKK/Nh6tSCvQB1BlH8K5b8Bp1b6iKyDjBWQ/vwNvuaqlAwcmfQDJc2RvCOvrgruLLMxc6xUBKc4jJgLffMJZWZPGNIswcUEDYHXKuhF+OSjsjm2lApb8oZJfYrYayjtsIyEuqPDpgDnrX1q0Hxrkd52APqSHoYpbRMaxU/OeFNhernOk4pvOpsV4Le3qEZBNBa7CgJlS0V5qLORJcTFI7xWtiuATy6rMgEd7cGCbBkK8E2xv5WXXrWlQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 09:32:07 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 09:32:07 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 06/12] Documentation: Add info on nvme_tr_type
Thread-Topic: [PATCH blktests v3 06/12] Documentation: Add info on
 nvme_tr_type
Thread-Index: AQHZfZW3QCHq9yxCUU+AbUYbzExdHq9ISRWA
Date:   Wed, 3 May 2023 09:32:07 +0000
Message-ID: <d5ba8682-2d35-542d-aa35-2bbaf7aaebd1@nvidia.com>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-7-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-7-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7130:EE_
x-ms-office365-filtering-correlation-id: b0a5b0b8-246b-4edb-8f2d-08db4bb9436a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n1ptUg6z7RHqBNFneG0RhdeOciWx33XlKyLPBH0ed0kafGxcgF5MWl5VBlTxeuhmMnrlHXOvOvVoPx7dPsKwgZYXxji3Jy0l50Oi1KPI/c3mQa0yHJs0umTgpCVRUgDU5itaVrJG/eKwWyu4V+8WDdy0I/M+o2oQaHyJG2FlcMZt43l4dmq3yNadmf9GOaluXx43ck8IiBQjk+W/YVzL+xf0Z4QW2IQX7t4JqDLnntcZa/X5A6pkuOh/1+pZIAeIvEOo3Iae0SWsVufSIn0kVUbwNHX6OX5dNX4snoSa9zqnwJQUy6QIlLsTM1VkeryUGcRn0piqPWekG3a8FbVqa7kTUyGOSOAHEmNJoR5UENIrgc9AsJFmReTpkbwoBZwde9+/FHKRSpZDiuCKnQM1hiih6L6M3CKpk0Gd+w4YEn6QfjrJ3yZsM1DujiyxHAL0LXkrkYJdnhKOYJVcf08+uopfONWXgk5+iMeUc7sLW4jJczFa1gDKSFtHTl8Ubqu7PTrEzWSoGtVGzcvEWEt+IPGh7xLjkYWk8fVMp5X6kBs9bItcd5P7HyZJuO2UMXwtnjRqMKmNRParFTLiFTe5ow0UZvZYexjXJ3t6ueKxkIhLgiSXXDn3//LSmiuCbL07z8Qjk4vficM9wXg/epg4Wkz23x94XxILnj7bIsTx/0F1g/Nn3WvE3Z9dVDEoA17x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(38100700002)(2616005)(53546011)(6512007)(4326008)(316002)(6506007)(41300700001)(76116006)(54906003)(91956017)(110136005)(478600001)(66446008)(66476007)(71200400001)(6486002)(66946007)(64756008)(4744005)(66556008)(186003)(2906002)(122000001)(36756003)(31696002)(38070700005)(86362001)(8936002)(8676002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzFWMU1VUFdzRUlDU1QxblNKSG4vTElaY2xjbUxtWTNiZDBiT2EyRkJ0dzJC?=
 =?utf-8?B?S0FYWVYzak5hV1k3U01OTlF3Zlo4V1NjRW1PeTd2M2JyYitkbkJ3UlFjZHdr?=
 =?utf-8?B?L1BEMU43ZVh1N1ZSSmlkSmwxaXZSTlljVVR2NlZoM3lWOWp3UG1BNjZIbVl6?=
 =?utf-8?B?NDJqc3UxRmcxSjZWbG1oODhkcUx1ZUxxNmRqQUI5QWNRaTczUWIzTStPaGUv?=
 =?utf-8?B?RUt1M3Mrd0dqeC94RGJ5a2ZPYVlVVXljRndHandqbWFNUE5zdVVxUmFvK0Rz?=
 =?utf-8?B?Yi8rRDNMWjFER3NnWVRWZ2ZadlFITzQzTUZ4NzVKbnp2M2cwak1QZlBJUzVT?=
 =?utf-8?B?OEIwb2Ivb1ltbDc4MGsydE1DQmJTenhmcHRFbXRaMGovZlVrNEVGWE96NGYr?=
 =?utf-8?B?N2J4YmMrL1NLeVdhcWg4ZkZtcCtQSHNoQ25mTENiM3FzVHBvblNtTVYyQW4z?=
 =?utf-8?B?c1poSWM2U2VkTzFXTThkL29MR1VMUWQ2clRKSzZJSVRIcG96UHdSV2ZWSmVk?=
 =?utf-8?B?UVBjQmdqVDE3S09Bc1IwQ1NidVRSWUhpbVRzUmtYTHlZQmY1NzFYazZ2Rm9D?=
 =?utf-8?B?NFhqdk5ZYlJMRXFxWGpNTmxtbnp6cFl2VkcwNWlpYUhBcW5weCthVkk1bHph?=
 =?utf-8?B?ZXVPT3Bzd0FGK3Nhc09TdDNxTHhzaytldE9lWUNKRGZ4VWpldjdramVaaFRy?=
 =?utf-8?B?blk0UDQrMk50aldEOUNFdDdYUG9BVDlLTFI5Rmw3RUVaQng2K2xkNGZ3RnJk?=
 =?utf-8?B?NG9uRkxqeFBDUVF2VmZxYUdVb1ZORTRiL1dGOEdoZTZpQVJkK2R0TjJZZ1FX?=
 =?utf-8?B?SW11MmRKV3RHTjBEajlXMnZEY1E2S21uaDdubG10Q3FRcHc2cm53YlVXc1dH?=
 =?utf-8?B?a2NmV0ZhK0Z2MHVpZlNRaEw5NFVqU28xd1RRaTN6ZkdJSktYa05rYWNyZVFo?=
 =?utf-8?B?M2E5R3FtcWRYM3d3bjhzdE9GZXpTYzlMSlF3TWxvcnA5Rm5iTWF6cGJ0WHRy?=
 =?utf-8?B?cHJ3bE9WWVk0SXh1K1F6MHFWejEwMm9HQm9hZWVMMGJTS3Z1TDNpK1JtUHFP?=
 =?utf-8?B?WTVFMEhKMWFQelNrUmNZS2xDT2tBdWZVMHBtVTJBMDNqb21JY045ZWoyZHFw?=
 =?utf-8?B?WlZzd2ZQdkIrYnJIUFNacXFEZXl4Vy84bGpYUjZPWXE5WHZMQjRRYTRrL2Ny?=
 =?utf-8?B?TXhYSUU5UFFDZmhRTkFFQ3VpK1FIakkwZktnMFk4Mk9mc1FwYlhDL2lEVnRU?=
 =?utf-8?B?ZzhvMittREY3aUhSVzNSemN4UVhGMXppMzZmZFpkanQ5ZlpGTm9EaDFrRlpR?=
 =?utf-8?B?RDRHaENFbmk2cjE2eEZNaklMZGZiRjFrMHBQeGRmWHVvT2wxS0E4Qnl5RnVO?=
 =?utf-8?B?YVlXRUpqVnBSVEVEbGlQUkZxdzhKa2xJR2NTSG9WZWF4YktZeDZ5a2RmQXpI?=
 =?utf-8?B?NW0zcjNYd3pCdzFHYmx3UVV0dUJXS29GWEJ0TWpBMUs4YWlHTDlLYUNPS2t3?=
 =?utf-8?B?b3ZkRlJiTVJ5MlJOdlU4RnJsUGxhVnEwN09tWXdodGFKNzM2cmc0Ums3dCtm?=
 =?utf-8?B?azF1SVNVeXJmWHN5VlQ0V2dtaGR1MzJGVm9zQ1VtUEF6SHI1Q3k5ZGNscFEv?=
 =?utf-8?B?QUo1c1hBQ0lkQ1dja2VGV2tqRERJeW9mNS9mUzE2UDVSclFucGtUMk1CeENn?=
 =?utf-8?B?VzRmN2FYUEl2UzVFc3ZsWDcxRDhhVXZmcHRPbzRDRE96aldDZW9rc01nS1hw?=
 =?utf-8?B?YmsyZXUwSkZyYmxnbERNbUV6dXJ6Q25WVDBLVVFSVUo4T0FBczdINVJMQ1pN?=
 =?utf-8?B?U3BKN09Fa0JsNEcvN3BjUERuNERWRGZ3NzQ2MVFKQ3dxVHhqVE5ZRVQ3dklj?=
 =?utf-8?B?ZGV0OG1nQlNGWTVnYVErek1rbFNkdzZ4ZzZtMmFaUlZUMWRZUmhuRkhIK2o2?=
 =?utf-8?B?ZkhVUWpwOXp4SWE0Nk9oeThDS2VLRjRuZjlORHhyOUxsWTEvOHJJL2FxR0xt?=
 =?utf-8?B?dENNbmR4UFp3RzRqdVlPV1IwQ25UUXJKVzlZTnZhY3N2NnJwajV2YXQ0Nzl4?=
 =?utf-8?B?bEI2ZnZmMmxTek5YaEZKeUpaZkkyb0J6ajBQdXNxSFQ0dDhyTlE4MGtvWkpQ?=
 =?utf-8?B?YkJuTC83aEw0YjhpMCtVZVZLZDFvWTFhQVAwYUlpa2ZKeWFFUWdpdllTNzdE?=
 =?utf-8?Q?xDEhOyOwMhcP2Ht4Xw6Q/u4yMi2BFKDYzJDyNSUsZqal?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF4B48D582DD9E478BA9E5052987ED7C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a5b0b8-246b-4edb-8f2d-08db4bb9436a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 09:32:07.4625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdwGTcpaduT+NFxWTJ/I3rvePnKnyYM8FuoM6qRMbkaEhANLLurzGDiCA4niewlDrAJkQJibH23oYswZE7znLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIzIDAxOjAyLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBNZW50aW9uIHRoYXQgdGhl
IG52bWUgdGVzdHMgY2FuIGJlIHBhcmFtZXRyaXplZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRGFu
aWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPg0KPiAtLS0NCj4gICBEb2N1bWVudGF0aW9uL3J1
bm5pbmctdGVzdHMubWQgfCA3ICsrKysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3J1bm5pbmctdGVzdHMubWQg
Yi9Eb2N1bWVudGF0aW9uL3J1bm5pbmctdGVzdHMubWQNCj4gaW5kZXggMzU1MGYzNzdmNDg3Li43
ZTgyN2ZiYTdhYzAgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vcnVubmluZy10ZXN0cy5t
ZA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL3J1bm5pbmctdGVzdHMubWQNCj4gQEAgLTk4LDYgKzk4
LDEzIEBAIHJlcXVpcmVzIHRoYXQgdGhlIGtlcm5lbCBiZSBjb21waWxlZCB3aXRoIGBDT05GSUdf
QkxLX0RFVl9aT05FRGAgZW5hYmxlZC4NCj4gICBSVU5fWk9ORURfVEVTVFM9MQ0KPiAgIGBgYA0K
PiAgIA0KPiArIyMjIE5WTWUgdGVzdCBwYXJhbWV0ZXJpemluZw0KPiArDQo+ICtUaGUgTlZNZSB0
ZXN0cyBjYW4gYmUgYWRkaXRpb25hbGx5IHBhcmFtZXRlcml6ZWQgdmlhIGVudmlyb25tZW50IHZh
cmlhYmxlcy4NCj4gKw0KPiArLSBudm1lX3RyX3R5cGU6ICdsb29wJyAoZGVmYXVsdCksICd0Y3An
LCAncmRtYScgYW5kICdmYycNCj4gKyAgUnVuIHRoZSB0ZXN0cyB3aXRoIHRoZSBnaXZlbiB0cmFu
c3BvcnQuDQo+ICsNCj4gICAjIyMgUnVubmluZyBudm1lLXJkbWEgbnZtZW9mLW1wIHNycCB0ZXN0
cw0KPiAgIA0KPiAgIE1vc3Qgb2YgdGhlc2UgdGVzdHMgd2lsbCB1c2UgdGhlIHJkbWFfcnhlIChz
b2Z0LVJvQ0UpIGRyaXZlciBieSBkZWZhdWx0LiBUaGUgc2l3IChzb2Z0LWlXQVJQKSBkcml2ZXIg
aXMgYWxzbyBzdXBwb3J0ZWQuDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
