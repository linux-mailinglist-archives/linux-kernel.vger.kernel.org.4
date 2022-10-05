Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A0B5F4F78
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJEFYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJEFYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:24:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E306746A;
        Tue,  4 Oct 2022 22:24:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RILsSwy1tQObUaEQATKfY3pvb93e1AxvnUI/7uvSYeJ6/8Gp4Doejbtrf29dpMDYy8sbDpBeAnfdw77Mqwp5jZjXFxaVk5si28/mIho6uVre2dl9vgQatOnQRrZFsbxd4OVsQDJUHlCsPf2rXSMv6uobIaW2549BWCf5VShJT9IDWwoMpN4hKj5KPqgi+7oyPaFxFKBKRFn+z/w3OBhr3PEXvEcznkAi+R6V5w+uoxscyXw18Cn5I+GxQv54oSbwU3CNz29713RaSFYZwJ2xsBm5OSCqK1MQWBmrEt4OiSxvbZtBj5evyCasLGJ/+n4a3XWeaoITxXvSa/lzj8P2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIa6ysWrX033A5rOhVNV5GPfuqWhtjKXfb+Dg8Wwt8Q=;
 b=bJmF13L9Q9QVt5LIEUSkRLd0NyvOEWpB4/kDLrOiiRWinexl29g0WDvqcmT++wNcbQj9kJycPSWXB2TvDezdMISn88DuEogrZo0KDHdYdZAb1D+JJ0hM677EufBVlu/gR3+m/ty+h16oKHU5LpPXidXM2HhXUQn8Ge0dgR/kovkw1Q2hPBUliyRDtGnwyRGHDKkPRnv2qbqwyfeqQjV3exwZkdO3/kkVt2LbT51P46678LL3VkLCjTQaHcODUTY9elJ28xjdDjWwAhGpOvmEsJ7lizJSvhaxBTJBOs6VbnJ0Pia/RJWIESxCgfJSZ8cudp6XymZ4qtHRAM3H7ZzsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIa6ysWrX033A5rOhVNV5GPfuqWhtjKXfb+Dg8Wwt8Q=;
 b=rucLDony+atOVmccCVTWAZmRTUOF1dMKSuI8lH7tjiTri1IVCsroTq4auIp1cSGg6fpCCJQ7s9uh7RVpkSY04wg5sUhy+Ktxb2uc5Ijtnbd1mbbUaID6Vi00ePl7vlh2e8tI0RB/oqc8Udf4RGFoGoG8kdWngny3wz8NWXPcPRf/dYqbKnOpAcPGTAEGyLoVpBQ1Y8T6m3VnYYDPKsU/9pm8x+PWdhzqsyAzeobAJ7Wtybo/NPRJotZHo2R6+i2MdS/WD2Vcq5U24TJMtrUjZZMCE6xhKywXgVsXH7n92Dp+kzigJj90L7Nf82mkp/DtpOZP+AtL8R7UKHpNgZ3Jow==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Wed, 5 Oct
 2022 05:24:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 05:24:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/6] null_blk: allow write zeores on non-membacked
Thread-Topic: [PATCH 1/6] null_blk: allow write zeores on non-membacked
Thread-Index: AQHY2Gj9Q2YMA7ydR06f/3Ds7ZY+vq3/PFkAgAAIQoA=
Date:   Wed, 5 Oct 2022 05:24:17 +0000
Message-ID: <2553fcde-43b0-04c0-5f62-9a2c1f9430a1@nvidia.com>
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-2-kch@nvidia.com>
 <66698df8-74ca-e802-2250-04aecafa1106@opensource.wdc.com>
In-Reply-To: <66698df8-74ca-e802-2250-04aecafa1106@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6407:EE_
x-ms-office365-filtering-correlation-id: f34c91ec-0b2c-4d3f-8618-08daa691d9ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ghDfV201VMiUxzWtxxgtaAwuzoXaleEZPNMqWuu+uVTp9hDk6Sqp8KZVWI7sYqKM2uBbCc+Z15+O53m5MfIchpyXcylZgRYS+QemNDyoT0EaCnU6f5i6Xcmmh+BKlXPksmvor2WP+ML1KaidWPdTD/pxOuLIMWhdRpv6hP6L6mxnl2OcLN1XydNi+myQ5fG8bkXHNCmFdczvhp8adwMYFwOgBtusZSnhRc9b7omE060DDup+0mPcj6qs9dndPkvjO+MRplA1UNhVzArj4MAu4Le8r0bM5gwd8tsn9CzejPYty0JfyMWQWGtdury8bAsmyNyjrLH5p/Y0FfaGfnTfaxIBofbXxtekqrTHLLxUnFmbPEV+sqBp/7hQcYeOEutF/tFK9Siee762zJe6u7lgjd295oojlQxgp95w/O3PCtv47uf2DV6+mkaGITvJfAeTaumTw5kRsepA9tjfjKifULO8DMApEHLiMBmf8Eh59cK/BvZAxI4UoRpeCcRauq8jgRNMbCTy0003h3158Xty52ehsEZtpUKpoVQ1UTncXpU+6SrwTJcda9vFioTOi+4fO/5qsAoMNdhUhh3NVgLklOcVL2VWzKAmyV4UFZKCna0Zq4gdQfSY6cpcLQ6oz+cL+rBh9Yueda3NDp9E2jPCQggmoPisEA6mkLIDgkwWX/49eGXB25cR84IfKx645c4zo4F2GsCmD77Qhcgc1L1zuDQrzYNWbtTrS+CV9blqyG0fAGnfL+IjKq24w2576iBCb3mo4oRZ/Ngd3/ap0+HZSq2izm9QdTFwFmrb3i0T3FaoV8B65G0yTY/W3qtVSVdt6/YlslBA9VycIUWzF0ElFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(38100700002)(122000001)(6512007)(316002)(6506007)(54906003)(8936002)(66946007)(41300700001)(66556008)(71200400001)(31696002)(66446008)(66476007)(478600001)(53546011)(86362001)(7416002)(64756008)(4326008)(91956017)(38070700005)(110136005)(2906002)(36756003)(6486002)(76116006)(5660300002)(8676002)(83380400001)(186003)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0huRnVpMTJNYTVZbVlNQTJUa1JIRGtMMU5SblZMUWk3eG04RkJRMnRmdElj?=
 =?utf-8?B?RFZCN0JMQldub2U1d2l4YUFyWkEveHB3cTUzOE40b1A1NnJtTVM1NXl2aU0z?=
 =?utf-8?B?V0dUM01JeWNXc1h6OTdKdjVvYlE1bEpROGxNVzNqREpMblVGdHpzRFVwWmFR?=
 =?utf-8?B?RTk2RnJ0QkFZMk9IUGhWY2Q3VURrVmxLeGo2S2FKa0s3aENucXhkSDFIQVB2?=
 =?utf-8?B?b0NqYjBaQlpoWXNzYUdUQ0JjQkhNOGRDek15akJ3bTcreGM1YTg2NlNhZjQw?=
 =?utf-8?B?dWVHaFlqN0l0SXpnK0lRc3JkYkV2ZUV6NDBPODh5bTBid2JEWTBNaTlKdHBx?=
 =?utf-8?B?cjJKSVpMaDRVR2ViMDlZb3ptYTB5UEFucDNNN2lwSTB2azhzODE5dXlaeWph?=
 =?utf-8?B?K0dzdFFoNFAzQWZLYld1RHFySjVDRC9qODRzckk3R29MRVg1emJWZU4wSlNX?=
 =?utf-8?B?Zk51c2k5MGE2SEhwWm9LK041UWpBUjRmbFA1TXZraFh6a0NJVkFWNVdYajBD?=
 =?utf-8?B?eVVPZXRoNW4rWExRT1VPWDZTaGh4N2ZMS3ZhWTZQVkluU0JySnFqVjBzMHF5?=
 =?utf-8?B?MGQ2SW1NMW5NMzlPczZsRE95bEdzQnVTSE5ZTThveHBGcG9rS1NGaDhSL01T?=
 =?utf-8?B?d283VTQyWE9heDN2ZWFvdkNrRy9KR292Tkh2YXlCMmFhQ0VSdHlLT2hpNzVP?=
 =?utf-8?B?VGJ5RlpOb0grVk9mdGxvNG9PSGwxMWlxYUlwOTkzdVcyUmVwa3lZUUFXMjdu?=
 =?utf-8?B?Z1dmbm01SDFIWUxQblpCdTkxYmh0dFRBcExrNHNyOXhMaHJJS0V2VnZobmtI?=
 =?utf-8?B?ZG5sUFV3Ky9seHc5VkhLcXIwUVNvVGQ1aUNqZHE2Z3JJSzBaWUk2L3RSa0V1?=
 =?utf-8?B?VjRacHlrcjlkK3cxWnYyMWZSQ3d3MGhRVjhaMVZKOVgzYTVKemxreW5jK3Nh?=
 =?utf-8?B?QTg2dys4SUN5aXBWaXZsWEx0b3JySXQxbFc2RnpKUlJuRjdieDNLZTV2OVpG?=
 =?utf-8?B?Vk1jUEFHV0VlcitIN2JURldQQW5ydC9IWExnbjdBYk53QUozczZEeUpBS1Bn?=
 =?utf-8?B?VlU0aDk1UUxTZFo1V200VHAwOTEzUjNKNDhvUCtMTXZrZjFndG1rQ0o3NHRn?=
 =?utf-8?B?cFhyY1lncjF6SUlIQVZ6S0gwWWFLRjE3Z3J2OWdPNURaRzY3dm95RjFxTU8z?=
 =?utf-8?B?WFE2RWZQaHQzOHhOL08vY1hzZzU5NnFkWDg4T284VTRaZEVWTEphaUpoN0NW?=
 =?utf-8?B?QUVrVmw1QVVzbGFEYzV2bDBYSHAyOWJNMVhiSmRKRG9BSTdyL1lkNWdCcHU0?=
 =?utf-8?B?WU02N25Hc3puaUI0OEtuUWxKTU9DZHBJTyt4eVBHS3dqeWdSL2RwVVd4M3Fq?=
 =?utf-8?B?blY0bWRPY09OUk9uTlJ1bmw5SWxhd1BPQzloTVZnbG1KZUY0Zm1KUWVxR3hQ?=
 =?utf-8?B?VEJCYXRwQUR1TVgyUm1KU3hjQ1BRS1VIVm1HcGVXSVBaMVU3a2hGSk5uMWh6?=
 =?utf-8?B?TmZlckFFbkozS3lCdi9rU1VhdmdQNzBOeE9oMUNOMHhoQlJZUE5EeVI1Tlhw?=
 =?utf-8?B?WGloRHhKRFcveTNNMzRrbkdIb3Y0Q0xEUHkrSloxZE5ZS3o5UlRhK3JwRExy?=
 =?utf-8?B?UUtoVTltemYwS2tCc0hzTXM1MlQvMm1sSUd2K1JUOUNaUnorVDVHaUxTUDZY?=
 =?utf-8?B?STM5TEN0QXBnWEtaM2VsUjRrMElHQWRZSlQ1ZTVlZDQyWitiQVhINHdseWYz?=
 =?utf-8?B?M1NnMzloK1dnVEhyNjVDR1RNcEpOSkNQb1JVbjZFYmdEcVRaLzlCQWRmbEg2?=
 =?utf-8?B?UXlZQVFBZEtmYzVvMkM3NlU3ZndzRzcvczcvcFZqY2hXWHdyUmlDdXdlSnhn?=
 =?utf-8?B?aktpcHowc2xLMGJMT3VIalZMc0R6Tk11WldLanM1UW1ER0o2ZUVpelkwaWw2?=
 =?utf-8?B?UUs5a29UR3YxcC8rbXRGdnlGZUJKNFJaMHY5TDZnQktRVEx1a3FnWkJGa1VM?=
 =?utf-8?B?TGUzYk5vZ2xnUVdDOGdVWnVrQ1FOWXQ3UTJDYWJYZUxoSS90R3pwTmRLMFFM?=
 =?utf-8?B?b2NOSExlN3JseUU5SkVIOW9DMzBlR0JkRnZkUFdralgwVGRZdXM0VWVhdXBa?=
 =?utf-8?B?cSsxcEgzYUkraGN6bUdEKytJRW5OZlI2R0gxbHNkS1N0blVqOWxHZ1RyWXc1?=
 =?utf-8?Q?UjhZB5rbEiRQhPq9n0hBRrs2lH63jIxzzrnP5ZXZeCXL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D0890B2E752FB4493FCF0F00CB277E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34c91ec-0b2c-4d3f-8618-08daa691d9ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 05:24:17.8686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dbu8FdlfRYVPju58lCPavevPWaE214j8PMbZ/rs9h3M5rw0ldu20GMurK53RK9+DPzWheIJh461s29bYnqQ5Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNC8yMiAyMTo1NCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IE9uIDEwLzUvMjIgMTI6
MTYsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IEFkZCBhIGhlbHBlciBmdW5jdGlvbiB0
byBlbmFibGUgdGhlIFJFUV9PUF9XUklURV9aRVJPRVMgb3BlcmF0aW9ucw0KPj4gd2hlbiBudWxs
X2JsayBpcyBjb25maWd1cmVkIHdpdGggdGhlIG5vbi1tZW1iYWNrZWQgb3BlcmF0aW9ucy4NCj4+
DQo+PiBTaW5jZSB3cml0ZS16ZXJvZXMgaXMgYSBub24tdHJpdmlhbCBJL08gb3BlcmF0aW9uIHdl
IG5lZWQgdGhpcyB0bw0KPj4gYWRkIGEgYmxrdGVzdCBzbyB3ZSBjYW4gdGVzdCB0aGUgbm9uLXRy
aXZpYWwgSS9PIHBhdGggZnJvbSB0aGUNCj4+IGFwcGxpY2F0aW9uIHRvIHRoZSBibG9jayBsYXll
ci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jICAgICB8IDEz
ICsrKysrKysrKysrKysNCj4+ICAgZHJpdmVycy9ibG9jay9udWxsX2Jsay9udWxsX2Jsay5oIHwg
IDEgKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWluLmMgYi9kcml2ZXJzL2Jsb2NrL251
bGxfYmxrL21haW4uYw0KPj4gaW5kZXggMWYxNTRmOTJmNGMyLi5mYzNlODgzZjdiODQgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrL21haW4uYw0KPj4gKysrIGIvZHJpdmVy
cy9ibG9jay9udWxsX2Jsay9tYWluLmMNCj4+IEBAIC0yMDksNiArMjA5LDEwIEBAIHN0YXRpYyBi
b29sIGdfZGlzY2FyZDsNCj4+ICAgbW9kdWxlX3BhcmFtX25hbWVkKGRpc2NhcmQsIGdfZGlzY2Fy
ZCwgYm9vbCwgMDQ0NCk7DQo+PiAgIE1PRFVMRV9QQVJNX0RFU0MoZGlzY2FyZCwgIlN1cHBvcnQg
ZGlzY2FyZCBvcGVyYXRpb25zIChyZXF1aXJlcyBtZW1vcnktYmFja2VkIG51bGxfYmxrIGRldmlj
ZSkuIERlZmF1bHQ6IGZhbHNlIik7DQo+PiAgIA0KPj4gK3N0YXRpYyBib29sIGdfd3JpdGVfemVy
b2VzOw0KPj4gK21vZHVsZV9wYXJhbV9uYW1lZCh3cml0ZV96ZXJvZXMsIGdfd3JpdGVfemVyb2Vz
LCBib29sLCAwNDQ0KTsNCj4+ICtNT0RVTEVfUEFSTV9ERVNDKHdyaXRlX3plcm9lcywgIlN1cHBv
cnQgd3JpdGUtemVvcmVzIG9wZXJhdGlvbnMuIERlZmF1bHQ6IGZhbHNlIik7DQo+IA0KPiBXaHkg
bm90IG1ha2UgdGhpcyBhIG51bWJlciBvZiBzZWN0b3JzIHJlcHJlc2VudGluZyB0aGUgbWF4aW11
bSBzaXplIG9mIGENCj4gd3JpdGUgemVybyBjb21tYW5kIChibGtfcXVldWVfbWF4X3dyaXRlX3pl
cm9lc19zZWN0b3JzKCkpID8gVGhhdCB3b3VsZA0KPiBhbGxvdyBleGVyY2lzaW5nIHNwbGl0IHdy
aXRlIHplcm9zIEJJT3MuDQo+IA0KDQpJIGtlcHQgdGhlIGltcGxlbWVudGF0aW9uIGlkZW50aWNh
bCB0byB0aGUgZ19kaXNjYXJkLg0KDQpQZXJoYXBzIGl0J3MgdGltZSB0byBjaGFuZ2UgaXQgc28g
UkVRX09QX0RJU0NBUkQgYW5kDQpSRVFfT1BfV1JJVEVfWkVST0VTIHdpbGwgaGF2ZSBzYW1lIGlt
cGxlbWVudGF0aW9uLg0KDQpJJ2xsIGFkZCBhIGRpc2NhcmQgcGF0Y2ggdG8gbWF0Y2ggeW91ciBz
dWdnZXN0ZWQgd3JpdGUtemVyb2VzDQpiZWhhdmlvci4NCg0KLWNrDQoNCg==
