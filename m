Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E246038D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 06:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJSET6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 00:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJSETy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 00:19:54 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00792A428;
        Tue, 18 Oct 2022 21:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aU1XKYOhYzfBUf32C7IjteIqG4Xgiuvmom6KUy2nnJt9D6pEpyJcO61bKdxlOKLPF1y6TnaoVUQXFpG1R0wsAOVoAwmygY5Aa43T66GpggtW+VZry967Jy5Z1R9e4vJqaTJVdK0VI4mgCdbwwUywNGJwBrNhhpNaafyghS/bKxXsGn9IpbuOgz2rJvOZgureFERoPyy8y5vEGsJIjSLP/jMkTRnKVv+OoBckiIGJdn5XhIZ7Bumqpo8aFG5Vp7wveLvNTPmuMHm1HQylF576IHeBW+8bJ19NpWdSJnbXK2JEfi3jPHm9fSNGhc+t8kYu70OR22FM1yL047sR4Vcqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNIds16LZE1l0ekYbb+PXQKojuGpiDhaVyjYJh6rOIE=;
 b=axoX+Ed2D/8LR5517h+C1qBLPzpio+dud5A/feE4l7PdEpeGX7XvMSw949uTEJcR4SaS0OPN+gMXVE1yMR2qajCTXbx/8ty10FRhiAjbxQuFMq2lDtKD6UlGDwYOxjiAIolb8Iwn+zQqy2WuGjaAR5otywz77ujOLXED5WVDlYfygCizuFFil8EBk0c0pJc+vsIP+h+otlb2V+4mocjyqZLVcoxGDwr9Q8XqUsuzrGaQUj3eXMkbMTEWAsOWtSspP1ABK6ZcWCO83ZFmWT3yS2/YdPLMAr81AbWJm+VdUcJlQtSG/Gg67Ei4QOSCYErywsan9Lzdq5hCDOPa9KNZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNIds16LZE1l0ekYbb+PXQKojuGpiDhaVyjYJh6rOIE=;
 b=I4vFmxnLAqUTq2gTlrGYi5vowZP3BvlCw+SNHWLXX+yzEtu6cxX9vAsaraCVZ6djEjHmh9mmw0RZY1JnfmREOXnE6ibEYCOasAiVGRPIhYAL1TraKXUdxLoog0FFxZU064BNkePmK0lu/i7PF4wOincqPmvekC4/n7qH/Lo1aAawLWA2p0c4zyiKwrVuKI8v0YBWI1rulM28jwo0aLjEjB6zH5LGIH66CnneFijIZX7dvmlo/+XauXGadktNfVdfwVntF4KCJ07m4o93krz6f3F4ei1AeyWOivoxqRlpEVtg57bdEGlYp82OJAfYPxysjEKBIOmz2bINvx3Ztliegg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Wed, 19 Oct
 2022 04:19:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 04:19:50 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
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
Thread-Index: AQHY4R8DFU2LJu/Wy0udZZqXPfzvLK4SpTKAgAJ8nYA=
Date:   Wed, 19 Oct 2022 04:19:50 +0000
Message-ID: <d3e05b4e-466b-844c-b815-79233856e527@nvidia.com>
References: <20221016052006.11126-1-kch@nvidia.com>
 <f2baa3b4-81c9-a6d8-0c26-3e695dad5d10@acm.org>
In-Reply-To: <f2baa3b4-81c9-a6d8-0c26-3e695dad5d10@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA1PR12MB6895:EE_
x-ms-office365-filtering-correlation-id: 1ccf0db7-1885-4ae8-0a08-08dab1892a12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mDmHtU768zv9JaeCgWkXvQZ/FGlINb+xR8/O8xHFl/QNCGNgKPJdDNJd8gUnCWFmGVitB1KlAGY8Eitnfij4xa6UGh1tq5z/3U/di0weeVMTm8gF78O3hPcQvuNScH14yhfi4ujsTkZ+90aqYQaZUMPo7d4jqlKjQvc5gvJPb7iaOxJLo/Lgte2gI5mfvSKo9gEVHsdkHFnb6dps5rTRazineZAObvnNPEzDmqTRTbbcu9vqXOzD4VbV1zwB5HzIJtnLv9O/BVY4fsfIoMlntPPC9u1kLcS06QEblQxUX7M0m9Lhewz5ymwmBmTDR965U4qInn703f/B/OOBZVbZLfubbFkBdQxHdBRgirUEJUr7En3KLf8DWfWoJJqpKt9ty7oQqNLnFNDwe+Kz+lr0SvAf6vD6hhHE4BkSBROOZ3an1fm1Hz11A2dZq84XB4yQmEIO4H+F7XF50DEPVrN0k4hYww+Ew6FrTy/wUFxhs2M9vD36CHMuttEPcTO+t5AvTzUW5y6D14at6WzygPr6WI4dKtqdDnx/lTkh8jC11SNeUQj1maLq6oYwfc6XBcoj1aXAaRwySKeYVDXxgjnX81f8f44XfJVDGUjpxlt2tjvpWCYc2B/yElqbV6CSxbY58ZyIiyBtPWLFkruaQQpJIE4CA0m1tT558JTNIHJlvWanLFnseDOfwXSkNXv46Huf/VAVJOkBAXX8LUXaWWo8nxGtNaMpL3C2ADuEMnw+i9LLk0bJ3ssTW1vHBSBdSd4OKMcG9uZAOiqmlNLlf4jlrTnTUq7ohE8O+vi2eC4G46AE9ucL39jq3K/iiUhCIwVA4gtn5L5wWccSQlxP146VnRnBT1NJRVIvfdZzsPTcx4XoiBDR7VoQeOR0ldYit52MwKMMtnpDZMNx3aXQLxOFBfd4ULi2jnvm4e5ALOoOEY0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199015)(966005)(31686004)(2616005)(38070700005)(478600001)(71200400001)(31696002)(122000001)(6486002)(86362001)(83380400001)(110136005)(54906003)(38100700002)(316002)(66556008)(7416002)(186003)(2906002)(53546011)(41300700001)(8676002)(66476007)(91956017)(4326008)(66946007)(64756008)(66446008)(76116006)(8936002)(36756003)(5660300002)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTRWRHpNRmxMc2pwRW5kSUpIbktZM1BQeW9TZVpad3o5UHJqdEo5a1dHaExq?=
 =?utf-8?B?bXVlM2VOSTFoVExQZ3hQZ01hNERxckFiRktlTEFOKzhBSi85blZMVW9Tb2Np?=
 =?utf-8?B?NUk3Tk9pd2ZYeDdlMVVnQ0VmM3JZOTlvTDlQRGtjbXE4QUNrS1B6ZGVBVzF3?=
 =?utf-8?B?VGcxR3BwN21TS1BHbGZUWFB1NXFaWi9mWllXL0M0QjdDakpwdnU4WW1kT3RV?=
 =?utf-8?B?aGZyS2VOZFNpTHhia3kwYTE1SUZTRzNpZ1lSMkVwb2dadjJqQXR1RERTL29U?=
 =?utf-8?B?dTZWOWVBdFo2TTY1cXRTdXpUQlVxOHBlNFF6bmJ3aFQ5RFMzQzhleWRyWFFE?=
 =?utf-8?B?bVpubDZRU2JRY3pjSEdtQnQyVUpORWwyTjY3aDdYa29nejJCQXRkWUpoc0lG?=
 =?utf-8?B?c1d5SmQ1S3VzY09pRWozd25LLytQemtuaWZGUWtBcE5aV2FSNmpWNlRsMHF4?=
 =?utf-8?B?RVQ3NW8zM2cxZDhuVE5kYVVGelFFSGtnWXRvSHpjZkN1RFFSOW1YRjZzWi9T?=
 =?utf-8?B?ci9iZ0t4cDdzYnNLdXVWVTJMTkRPVmU3ZS9abllKZDU0L2J4SFpQd2F6NHBQ?=
 =?utf-8?B?Vk9IQ1Nocmd2dnlIZjBVYWxHR3YxK1dXVFpMQnBlT3BjRzlLZEZFVHRCTk4x?=
 =?utf-8?B?MXo0UzZIaTcrTyszby9lWEg3US9HbVB4ZHF1NEh0ZDVrcE8yNEVBbEVjcHlW?=
 =?utf-8?B?blVDYXRvMXRHQldQcko1QytoVlpDZ2YzV0dISDd0dFlZbVJlcVN0UXdpTWVL?=
 =?utf-8?B?YlUrcWJXK2ZwOWIxVTUzYWd5dytGSnZvQzJZcFJrdmtVczFnT1pDbDZrdlpF?=
 =?utf-8?B?eXJWQnhETGJublk4OG5wMGMxTjV0Mms2UElzTm5zM1VIVmxTMW1kZVNLaFIz?=
 =?utf-8?B?UmN6Wk9uWTBWbnVuZlF3aXJPTHlOM0JzTE5RQUVWYnFncWR1RmJVYkxMam1u?=
 =?utf-8?B?c2VTTEVQWm1jTXFBVkxaRXoxYjF2b0JEWVRkbUpjN3c3WWRWbzVSNlVkekht?=
 =?utf-8?B?Y05LVENXNFhlZTdwcjA4dEZHellEdlRoWG5iMG5TdTZ1VzdkdzgveXJwcXB0?=
 =?utf-8?B?OUZmekdJVGdCZzdjcXZRMGlPa1piVnY3MFVPalZBUUhnOFJDcnNhOWJENFpj?=
 =?utf-8?B?RGlBUzNoMnJGaWdSSkJkWldvcWVqam5RL2xwUS9nckhNcFgyd3BRUTJ0eFFR?=
 =?utf-8?B?eVpieDc2SXlXM2VJYkx5NThqVnoxTnN0OWc2bW5pZ05USmJwSi8wZHBIbGt3?=
 =?utf-8?B?ejdpWDI0TnRHTnRRdHozUS9YMTluaHdDSTBmYk9KYVJmVXQxNm45NWZmMXZG?=
 =?utf-8?B?UjUvRnh3MldNWm0yc1F4VlVUaTVmWVBZYkF0YkhjZUFST2tnZ2Jib1FmelFj?=
 =?utf-8?B?WlNwTWZVamxaZG1kcWg0b0xjelVWUTZ2S3RBYmR6ZU9wejNBdXNVOFRmRDUr?=
 =?utf-8?B?YnhwTlZDbHRIZ2JlODF0a3pGUERMNjVKdy9GSDVqUEVIcWFXbW1ZN0s2ekNW?=
 =?utf-8?B?cmNlRTZ4YysvL3pSV2Z0b3k0alpRdWl5T3VBdm9tN0thSmp3TnJ5MW1Qb29K?=
 =?utf-8?B?TmNYcEF3S0NLdGF4dkpSaGhnUHhZVjZuaUdGWC9QUVczVjViMzlXUUFRQVBP?=
 =?utf-8?B?amc1R0R6K3RwaUlsd0FabElhcDE2MDZVMlpWK0xHTFUyQThhM0g3WFVYYXJj?=
 =?utf-8?B?RTNYQUhGVlJJakZZVU1IdGRvVjVuTWNqTE5MT3JWamtZbDc0S1kxRENiMG9L?=
 =?utf-8?B?MExaUk02d2REOERVSkZWeDRUWDlWMEgzQ3kwYUdrMmREWXlLWmZ2T1dNUHNG?=
 =?utf-8?B?U0VOYkxiZXgweitrclBBZTRMMEZnelI1UEJ6OW1BYjdDUWd0WlpnR3lQYjFy?=
 =?utf-8?B?QWlGMWptRFRrUlBkdkI5N0JiV1lVUFFOK1BuY3RPU2U0SW1oNjZ4cWdRNnBQ?=
 =?utf-8?B?VmtZb0FMck9NM0RSQjBteUYyUmpYaXBzeGF6djNiMnBPeGZCdEFDT00ydXov?=
 =?utf-8?B?QlllSU56MXF6ZkR6TnEydjZjVDN3M2d5UjdlY2pNN0hlN0pTbERFVkhzUUZG?=
 =?utf-8?B?cWM0MnpqSlRjR0tTZ3FQWWw0MGVvTWNoT0NzTHdjNjRIamh0NmZGM0QvS25q?=
 =?utf-8?B?Vk95WmIzTHlESGJ4UmVWTzBRdGtwdm1TbHBKY2JUQ3BIQ3Vvd04xUmx3dGw1?=
 =?utf-8?Q?rneBynpi/QkI4sbbs1yCIlQPxgZKgq0RkhIFruDsPqc9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AD3E159DDABE041B6851A551C8F8419@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccf0db7-1885-4ae8-0a08-08dab1892a12
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 04:19:50.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+Y1F8zvGhVZsycvwDxJtToKzpME+syffkkDwvqu9VLbVQ0CHvybu54tYcXMtMEVB1o1jQRx2T0s5Il9GvnFjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTcvMjIgMDc6MjEsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gMTAvMTUvMjIg
MjI6MjAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEluIGN1cnJlbnQgdGltZW91dCBp
bXBsZW1lbnRhdGlvbiBudWxsX2JsayBqdXN0IGNvbXBsZXRlcyB0aGUgcmVxdWVzdA0KPj4gd2l0
aCBlcnJvcj1CTEtfU1RTX1RJTUVPVVQgd2l0aG91dCBkb2luZyBhbnkgY2xlYW51cCwgaGVuY2Ug
ZGV2aWNlDQo+PiBjbGVhbnVwIGNvZGUgaW5jbHVkaW5nIGhhbmRsaW5nIGluZmxpZ2h0IHJlcXVl
c3RzIG9uIHRpbWVvdXQgYW5kDQo+PiB0ZWFyZG93biBpcyBuZXZlciBleGVyY2lzZWQuDQo+IA0K
PiBIaSBDaGFpdGFueWEsDQo+IA0KPiBIb3cgYWJvdXQgcmVtb3ZpbmcgdGhhdCBjb2RlIGluc3Rl
YWQgb2YgYWRkaW5nIGEgbWVjaGFuaXNtIGZvciANCj4gdHJpZ2dlcmluZyBpdD8NCj4gDQoNCkNh
biB5b3UgcGxlYXNlIGVsYWJvcmF0ZSBvbiB0aGlzID8gd2hpY2ggY29kZSBuZWVkcyB0byBiZSBy
ZW1vdmVkPw0KDQo+PiBBZGQgYSBtb2R1bGUgcGFyYW1ldGVyIHJxX2Fib3J0X2xpbWl0IHRvIGFs
bG93IG51bGxfYmxrIHBlcmZvcm0gZGV2aWNlDQo+PiBjbGVhbnVwIHdoZW4gdGltZSBvdXQgb2Nj
dXJzLiBUaGUgbm9uIHplcm8gdmFsdWUgb2YgdGhpcyBwYXJhbWV0ZXINCj4+IGFsbG93cyB1c2Vy
IHRvIHNldCB0aGUgbnVtYmVyIG9mIHRpbWVvdXRzIHRvIG9jY3VyIGJlZm9yZSB0cmlnZ2VyaW5n
DQo+PiBjbGVhbnVwL3RlYXJkb3duIHdvcmsuDQo+IA0KPiBBcyBNaW5nIExlaSB3cm90ZSwgdGhl
cmUgYXJlIG5vIG90aGVyIGJsb2NrIGRyaXZlcnMgdGhhdCBkZXN0cm95IA0KPiB0aGVtc2VsdmVz
IGlmIGEgY2VydGFpbiBudW1iZXIgb2YgdGltZW91dHMgb2NjdXIuIEl0IHNlZW1zIHdlaXJkIHRv
IG1lIA0KPiB0byB0cmlnZ2VyIHNlbGYtcmVtb3ZhbCBmcm9tIGluc2lkZSBhIHRpbWVvdXQgaGFu
ZGxlci4NCj4gDQoNCk1pbmcgdGhvdWdodCBJJ20gcHJvcG9zaW5nIGZpcnN0IGxpbmUgb2YgYWN0
aW9uIHRvIHJlbW92ZSB0aGUgZGV2aWNlDQppbiB0aGUgdGltZW91dCBjYWxsYmFjayB3aXRob3V0
IGhhdmluZyB0byBsb29rIGludG8gdGhlIGRldmljZSBpZiBpdA0KY2FuIGJlIGFib3J0ZWQgYW5k
IG1ha2UgaXQgZnVuY3Rpb25hbCBhZ2Fpbiwgd2hpY2ggaXMgSSdtIG5vdCwgbmV3DQptb2R1bGUg
cGFyYW1ldGVyIGFsbG93cyB0byBzZXQgbXVsdGlwbGUgcmVxdWVzdHMgdG8gYmUgdGltZWQgb3V0
DQpiZWZvcmUgZW5nYWdpbmcgaW4gdGVhcmRvd24gc2VxdWVuY2UuDQoNCm52bWUtcmRtYSBob3N0
IChhbmQgSSBndWVzcyBudm1lLXRjcCBob3N0KSBkb2VzIGhhdmUgYSB0aGUgc2ltaWxhcg0KYmVo
YXZpb3IgdG8gcmVtb3ZlIHRoZSBkZXZpY2UgZnJvbSB0aGUgZXJyX3dvcmsgaXNzdWVkIGZyb20g
cmVxdWVzdA0KdGltZW91dCBjYWxsYmFjazotDQoNCmZyb20gbnZtZS9ob3N0L3JkbWEuYw0KbnZt
ZV9yZG1hX3RpbWVvdXQoKQ0KICBudm1lX3JkbWFfZXJyb3JfcmVjb3ZlcnkoKQ0KICAgbnZtZV9l
cnJfd29yaygpIC0+IG52bWVfcmVzZXRfd3ENCiAgICBudm1lX3JkbWFfZXJyb3JfcmVjb3Zlcnlf
d29yaygpDQogICAgIC4uLg0KICAgICBudm1lX3JkbWFfdGVhcl9kb3duX2lvX3F1ZXVlcygpDQog
ICAgICBudm1lX3N0YXJ0X2ZyZWV6ZSgpDQogICAgICAgYmxrX2ZyZWV6ZV9xdWV1ZV9zdGFydCgp
DQogICAgICBudm1lX3N0b3BfcXVldWVzKCkNCiAgICAgICBudm1lX3N0b3BfbnNfcXVldWUoKQ0K
ICAgICAgICBibGtfbXFfcXVpZXNjZV9xdWV1ZSgpIG9yIGJsa19tcV93YWl0X3F1aWVzY2VfZG9u
ZSgpDQogICAgICBudm1lX3N5bmNfaW9fcXVldWVzKCkNCiAgICAgICBibGtfc3luY19xdWV1ZSgp
DQogICAgICBudm1lX3N0YXJ0X3F1ZXVlcygpDQogICAgICAgbnZtZV9zdGFydF9uc19xdWV1ZSgp
DQogICAgICAgIGJsa19tcV91bnF1aWVzY2VfcXVldWUoKQ0KICAgICAgbnZtZV9yZG1hX3JlY29u
bmVjdF9vcl9yZW1vdmUoKQ0KDQpBbHNvLCBJJ3ZlIGxpc3RlZCB0aGUgcHJvYmxlbSB0aGF0IEkn
dmUgc2VlbiBmaXJzdCBoYW5kIGZvciBrZWVwaW5nIHRoZQ0KZGV2aWNlIGluIHRoZSBzeXN0ZW0g
dGhhdCBpcyBub24tcmVzcG9uc2l2ZSBkdWUgdG8gcmVxdWVzdCB0aW1lb3V0cywgaW4NCnRoYXQg
Y2FzZSB3ZSBzaG91bGQgbGV0IHVzZXIgZGVjaWRlIHdoZXRoZXIgdXNlciB3YW50cyB0byByZW1v
dmUgb3Iga2VlcA0KdGhlIGRldmljZSBpbiB0aGUgc3lzdGVtIGluc3RlYWQgb2YgZm9yY2luZyB1
c2VyIHRvIGtlZXAgdGhlIGRldmljZSBpbg0KdGhlIHN5c3RlbSBicmluZ2luZyBkb3duIHdob2xl
IHN5c3RlbSwgYW5kIHRoZXNlIHByb2JsZW1zIGFyZSByZWFsbHkNCmhhcmQgdG8gZGVidWcgZXZl
biB3aXRoIFRlbGVkeW5lIExlQ3JveSBbMV0uIFRoaXMgcGF0Y2ggZm9sbG93cyB0aGUgc2FtZSAN
CnBoaWxvc29waHkgd2hlcmUgdXNlciBjYW4gZGVjaWRlIHRvIG9wdCBpbiBmb3IgcmVtb3ZhbCB3
aXRoIG1vZHVsZSANCnBhcmFtZXRlci4gT25jZSBvcHQtaW4gdXNlciBrbm93cyB3aGF0IGhlIGlz
IGdldHRpbmcgaW50by4NCg0KLWNrDQoNClsxXSANCmh0dHBzOi8vdGVsZWR5bmVsZWNyb3kuY29t
L3Byb3RvY29sYW5hbHl6ZXIvcGNpLWV4cHJlc3MvaW50ZXJwb3NlcnMtYW5kLXByb2Jlcw0KDQo=
