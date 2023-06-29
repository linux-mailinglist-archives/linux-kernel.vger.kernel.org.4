Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B94741E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjF2DNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:13:30 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:7776
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229994AbjF2DNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:13:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjuM7XcM0lFasfwdopxapTjRhlG92wJg/QqK5hKyP4TcchOJqvRRPkxq6lCX8lkEHk7N/1sR36b+ns+CkdJ3gxo8P8DgMry13rhPmtSb3FoWT3Rsr1STxIYTz45cYkwR5uIeSZ6eAoswlLhabqzChhew45MuG3JyMYoBpca5vm5hoiZyD3TiKOaVNTnzc2OMj9YGXUcHVTIby1NXbuJi08HOXi29kD4i3OJv0Zyh4ZJiO1JJVRbnQyx32OwXcOl7hA/Llt4KqxcNDP4/iVSJuhWZ3KWciMklyWOoVK9+n/GQxr+Lwz9PtfPJC5K/pIJ//qDpiJc5MvA3uUk8XZ78EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVgDK0rXvBIzkYjWR4RsJgPwDt7eO5H9um3rJ/WRO7k=;
 b=NL8lAwpklpGTU072Z50lYOWHZ/Q1rMMFYH5OcOfXJKgL+apBDovphrm7kP9+JEG2Ewo6LiHxBLG+0tS2ohkPXj1DUR6V8ERySExIh1lBBZlHXL5pfjqWqqzJRMNkUhgPb3Qw+PhCpas8KiseziWjfeX70IOubmlhBLKbq/l+hopZGy5lc1hkH0XkOaWRQGK5fHsOy53CQytqz2bdVQ3CIJE1UQHYlrM33CNK05Za/lD+jQoFdBKQl36ueWkyQ+S4at0REeIMmyiE/flB8wzmCvfF881uU9FYWvpZ0oSGTdXMLTHW0U4c1cl29hxT2Y/fg8XWRqKQmkzRKuwAv6pRTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVgDK0rXvBIzkYjWR4RsJgPwDt7eO5H9um3rJ/WRO7k=;
 b=GzrWrn3n6yM+nfRmjtojkyjVL2mfQDQHHu33cFmKMhzWIQhUnq4Ip+TKZvBFBP8B/jrTEGyu2oTRroVYBOFhs6GBybowRoinbyzJ7qeKNtdT5srImOGTBH56TJKfOGhiv9Hs8vi4EZjjJ5c+WEth+BstfrXB+pgNaRSR2YKTKScW/Gasr5Eu0h0BGrOu2d3Y7coHgxflJz178v03BeK4hsItPh3NrvbEfRfU1wF+nNFFO8S5BUJHIzcwcq+r/liJza55Oy9gq2LiClC3O3IjqwHMInOTErrjbNDWVG3b7AWE2wyFYo72IQzqiIrdIqB8IAlK9HYPLrvZTevOuGuZ4A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB5293.namprd12.prod.outlook.com (2603:10b6:5:390::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 03:13:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 03:13:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Min Li <min15.li@samsung.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hch@lst.de" <hch@lst.de>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] block: add check that partition length needs to be
 aligned with block size
Thread-Topic: [PATCH v4] block: add check that partition length needs to be
 aligned with block size
Thread-Index: AQHZqjGpfgmsl5AabkqOJhmRVlyhCq+hEReAgAAJ0YA=
Date:   Thu, 29 Jun 2023 03:13:17 +0000
Message-ID: <79eabfb0-3c90-354b-a02b-0d2fddeeb358@nvidia.com>
References: <CGME20230629022807epcas5p23765f81f547eed72135c802f83543908@epcas5p2.samsung.com>
 <20230629102623.7410-1-min15.li@samsung.com>
 <fe796add-74f6-5b52-69b3-4823b93cd54c@kernel.org>
In-Reply-To: <fe796add-74f6-5b52-69b3-4823b93cd54c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB5293:EE_
x-ms-office365-filtering-correlation-id: d0c1be9f-dce0-46ab-fdb8-08db784ec8b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bYX1DNCEDOmX7h/jk/pMpwALCe+SkzZa81cl15SZt5GZXv1Knmerv9oNBeMencK5uQpyJzuuZp2NgwvHBSnHUSliSvd+Jv5yjpcV+5xfEswkuE/SNh/IiUUfQQ12L6xEqft6Njm9KSqiTxnbMQeKqcpyP7HYtWaT+CNh0NQ1gTkeOJVCBt7QI72waDZzn8hJG5tmUx8BkXP7cAbTrgGKuGR/lj30i/bWduwuhjcGRXHNLrIh8e90WmQX1a5S2f+alA7ZZbo5emyGmlC5nrIojfNfWqh2Jty+qT9JQMysUIIDVYH8YtJ8NZJ/1b7V1lI3hEt8bARoF4W8mCy4TqyRWiTBznR9JeRCB5b3bTlFn/XMtmW9a8ITWOyZDrGl8ytYKoXMqWMSKYzCSeHhBZEJZ3lIGojeW+8mfiSUiZW13xrKepBq5oUZwMTT5qu1FfdGjg4UXEqY/pEDF4h1o0LEnI2VXfm7XIoqtR3p/s1WLRY/IRdqkXK+yYypdKZ1NwRqFJWfNKrARzypSKYPc+2e2GbUlHunbgQrVd32Z+4UI6OqVKWWXmzsQiWeshhZztSs9cG3gX9HR0jd+ahEOSTc+XxLpnUJSAgMZlTNIbj28xVTlFXgexGY6+aEUbmuAlJ+zWO2h/UoI1jOpO2gao/Vw8ZpwRzaWxzdoxrx1GAj5JuAySRiYdHa72KmsCRYAfIK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(76116006)(31686004)(186003)(2906002)(66476007)(5660300002)(31696002)(36756003)(8676002)(6916009)(316002)(54906003)(86362001)(6486002)(478600001)(4326008)(122000001)(2616005)(38070700005)(38100700002)(71200400001)(66946007)(91956017)(66446008)(41300700001)(64756008)(66556008)(8936002)(83380400001)(6512007)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEZQTGxpVG8xU1pYemh1cXhFSnk1RHEwNGlQZ2NTNDdXMVFxY3FMY0xqZzlV?=
 =?utf-8?B?VmZlQVdCbzlaWXFCTXlJV3haN0VxbVVVcHRjZytmRzIzc1JRRXJISmV0Mktz?=
 =?utf-8?B?clBLVEdHN1Evc29VdFJkWXV0OHZTczZJb0hmeDV1clpUS1pldHRrTGpEeHdz?=
 =?utf-8?B?NHZWMU1EVlBJNmovQ0hmN3RuRVBuUkV1cXFlUFJLQzRIbm4zWmd0TnBxWGZI?=
 =?utf-8?B?NFRlWXR0aXNLMXVKS0I1LzdRZVBDdUlCSTRoalBJSzM0Z1FXZlBScVFRUFZQ?=
 =?utf-8?B?c2IwT1Q0ZlpqcTIwRmRDelpNYlgwSjBJQmkreEdPNnMzWUh1SEF5enJVQ0JQ?=
 =?utf-8?B?RTZSMWVYUVY3NTBwY01sRk9EQTVRTVZYMDhoV3ZuOW9kcWNsQklWZTkzRDl4?=
 =?utf-8?B?OGIzbllZcWtCN2hHNlByRHdYZStnL1lGTEpwVW5XMm9mZktlcEdRemVJcVhG?=
 =?utf-8?B?WXBnMFdYeVNSVkJaWmZtclBLOUp4eFJOTUZLbmFLR0phV3N0WWNLNUtvMjBh?=
 =?utf-8?B?aHFmUnJYWktUUURBamhlWFRDaGlWU213NnRoY0g5R3NENmpuaDlwZzJBWHh1?=
 =?utf-8?B?cGhoNzJDNHNBa05GeXNMSFo0T3dQUi94RHkzWUdQUFhWTG81Tk5tQy9uaFNH?=
 =?utf-8?B?NXhzTzUrUFNNejhOaU1MRG1odnZBdjl2TXB0Q2ZCMG5qa0c0MTBObFp5NVVu?=
 =?utf-8?B?T0QzOGN3RTYrKzY3TS9MWTgxaGcrMnBzMGc5V3ZJMGtsUldsdDBkcU1QQ1dj?=
 =?utf-8?B?Z05MTWV2MEs5ZTUxU0RCOHFPMWMwZzh5cm5aSGxnS0src0o2cm4zTVdyRWhl?=
 =?utf-8?B?K0FaL0FIeS9UcjNObDVLcDl3SE9QTzNkK1hYZnJJbmJQa05OZ09pN0JXaGdF?=
 =?utf-8?B?RTlEWUUyaVRjZ08xQW9nOW9TU0gxa1VnOEMzMGFET3FDRWVUY0E0WlptL2Ru?=
 =?utf-8?B?YUt3d2UwTWVnbkZhTEtZQXlwT2FPeGRWb2pBbFAwaHVUVEYxSjV6QlZKVGdW?=
 =?utf-8?B?dCtlTklKSEFCanZndHRzYWY2cnhhM1FwY296aFEwd2E4OXpDYnBtZy9PUDRo?=
 =?utf-8?B?UVhPUnByeUN4WEpiQ0ZtQUJzaXJBYyt4RU1vWVEzUW1hU2RuYmR0ZElIdkE2?=
 =?utf-8?B?bGFNYUZuRUFDb1U2S2tBclVCWUMvRVhLQW0vemQ1OHQyTC9MemZJVkcvQW5p?=
 =?utf-8?B?QVhqZWxHMTFwN3BFSGNLU1BCVzJjV2JwZkZYUUxxYVNIZFFLWmN0Nm1jTVhy?=
 =?utf-8?B?bjBaV3U4Q0pGSWQvZ2dUNUFCOW94cUcxRlR1OGFnQmkrbGFNTHRaVTRReVQx?=
 =?utf-8?B?aXdPV2d2QUFuU1pUR2ZNT2l1L0lLUVd6WCtBazREVk1LTXE0R2d2aFpZaFVa?=
 =?utf-8?B?dWpwWDBJRnlWd0FDYUFxbVBwMlNQUzhLNk9kRzkyVjdyTGtCODlQYUUyR0tm?=
 =?utf-8?B?VmlWMzQ3S3o0WFdyRnNwdkxmZHBJTFdDaWV3VnViQVhjeEtxYWU2Z0d0SlA0?=
 =?utf-8?B?SEFBbVNPazZyVm81WmxBV3U5UmxQcWh2OUkrTGlsdjNIeUhjK0hoMkI2dzg0?=
 =?utf-8?B?ZDNKeEZXRWl4NEhCeWxERXJ2eFA0V0pxSlRBTGU1LzRvT3hIRXQ3MStJa2dk?=
 =?utf-8?B?dFZES2tWblBVYjZDL1VnSllPV2o5Nk5wcnh5YmdJYkxGNGo4eHB6eW1kbVlr?=
 =?utf-8?B?dDNBaGJQWm9yN0R0YjdDdmpRVllaYzJJUXNqVU1LYi94SlJJS0krVnljVXpY?=
 =?utf-8?B?eTdTeUVld2hUVnNlbnBWdUNrS3VPMWpaK3dnaDNvTlFrUlVrOVJ4Q2FQKzNp?=
 =?utf-8?B?L2V2eGFqVURYTDhyampwUW1BZlpidnNnYXFCS0FUVWREUGZodk5HT3VhYVlp?=
 =?utf-8?B?WUJwcU9KV2hoM2xmSmg3aStib0d3eDA4ZTZBWmEvN2dvUjNhVnR0ajVSS1NC?=
 =?utf-8?B?ck5HTkNieUlRMGJ5N01pMzdxNjU3bll1N1VXdHRpaFNoWFVuWFk0YWpsNEc3?=
 =?utf-8?B?V29Nc1ROS0szcmZQWXZRMGNNdlZLRzFSZm9tbGFPaXNLYzZ1TWsxWUpnVGxE?=
 =?utf-8?B?ci81cVVCMUNKTWVhbFdEeHE4dHkvVTEreDB6b05DVTJ3RjdKanFqaFNnUDF5?=
 =?utf-8?B?YTNmR0dIOEFpZXE3K29GWDkwRTV1SWF6ZGZBdGs1aFM3cTNhd1V0aHlESnFs?=
 =?utf-8?Q?GPShACwyyrud6krEid5cWp1qR9sPrBvzro9M/yPDQiyH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAE953C43472E7488559401B3EB47B67@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c1be9f-dce0-46ab-fdb8-08db784ec8b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 03:13:17.2876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtcDk9W327sVJYja8PnmCilu+Bmb10uC7e1mc+1gqNLKLRP8CZXPjs1R9djxLtxjjtMdIhbHtg38MPZPtAiLLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5293
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yOC8yMDIzIDc6MzggUE0sIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBPbiA2LzI5LzIz
IDE5OjI2LCBNaW4gTGkgd3JvdGU6DQo+PiBCZWZvcmUgY2FsbGluZyBhZGQgcGFydGl0aW9uIG9y
IHJlc2l6ZSBwYXJ0aXRpb24sIHRoZXJlIGlzIG5vIGNoZWNrDQo+PiBvbiB3aGV0aGVyIHRoZSBs
ZW5ndGggaXMgYWxpZ25lZCB3aXRoIHRoZSBsb2dpY2FsIGJsb2NrIHNpemUuDQo+PiBJZiB0aGUg
bG9naWNhbCBibG9jayBzaXplIG9mIHRoZSBkaXNrIGlzIGxhcmdlciB0aGFuIDUxMiBieXRlcywN
Cj4+IHRoZW4gdGhlIHBhcnRpdGlvbiBzaXplIG1heWJlIG5vdCB0aGUgbXVsdGlwbGUgb2YgdGhl
IGxvZ2ljYWwgYmxvY2sgc2l6ZSwNCj4+IGFuZCB3aGVuIHRoZSBsYXN0IHNlY3RvciBpcyByZWFk
LCBiaW9fdHJ1bmNhdGUoKSB3aWxsIGFkanVzdCB0aGUgYmlvIHNpemUsDQo+PiByZXN1bHRpbmcg
aW4gYW4gSU8gZXJyb3IgaWYgdGhlIHNpemUgb2YgdGhlIHJlYWQgY29tbWFuZCBpcyBzbWFsbGVy
IHRoYW4NCj4+IHRoZSBsb2dpY2FsIGJsb2NrIHNpemUuSWYgaW50ZWdyaXR5IGRhdGEgaXMgc3Vw
cG9ydGVkLCB0aGlzIHdpbGwgYWxzbw0KPj4gcmVzdWx0IGluIGEgbnVsbCBwb2ludGVyIGRlcmVm
ZXJlbmNlIHdoZW4gY2FsbGluZyBiaW9faW50ZWdyaXR5X2ZyZWUuDQo+Pg0KPj4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IFNpZ25lZC1vZmYtYnk6IE1pbiBMaSA8bWluMTUubGlAc2Ft
c3VuZy5jb20+Pg0KPj4gLS0tDQo+PiBDaGFuZ2VzIGZyb20gdjE6DQo+Pg0KPj4gLSBBZGQgYSBz
cGFjZSBhZnRlciAvKiBhbmQgYmVmb3JlICovLg0KPj4gLSBNb3ZlIGxlbmd0aCBhbGlnbm1lbnQg
Y2hlY2sgYmVmb3JlIHRoZSAic3RhcnQgPSBwLnN0YXJ0ID4+IFNFQ1RPUl9TSElGVCINCj4+IC0g
TW92ZSBjaGVjayBmb3IgcC5zdGFydCBiZWluZyBhbGlnbmVkIHRvZ2V0aGVyIHdpdGggdGhpcyBs
ZW5ndGggYWxpZ25tZW50IGNoZWNrLg0KPj4NCj4+IENoYW5nZXMgZnJvbSB2MjoNCj4+DQo+PiAt
IEFkZCB0aGUgYXNzaWdubWVudCBvbiB0aGUgZmlyc3QgbGluZSBhbmQgbWVyZ2UgdGhlIHR3byBs
aW5lcyBpbnRvIG9uZS4NCj4+DQo+PiBDaGFuZ2VzIGZyb20gdjM6DQo+Pg0KPj4gLSBDaGFuZ2Ug
dGhlIGJsa3N6IHRvIHVuc2lnbmVkIGludC4NCj4+IC0gQWRkIGNoZWNrIGlmIHAuc3RhcnQgYW5k
IHAubGVuZ3RoIGFyZSBuZWdhdGl2ZS4NCj4+IC0tLQ0KPj4gICBibG9jay9pb2N0bC5jIHwgMTIg
KysrKysrKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2lvY3RsLmMgYi9ibG9jay9pb2N0
bC5jDQo+PiBpbmRleCAzYmUxMTk0MWZiMmQuLmE4MDYxYzJmY2FlMCAxMDA2NDQNCj4+IC0tLSBh
L2Jsb2NrL2lvY3RsLmMNCj4+ICsrKyBiL2Jsb2NrL2lvY3RsLmMNCj4+IEBAIC0xNiw5ICsxNiwx
MCBAQA0KPj4gICBzdGF0aWMgaW50IGJsa3BnX2RvX2lvY3RsKHN0cnVjdCBibG9ja19kZXZpY2Ug
KmJkZXYsDQo+PiAgIAkJCSAgc3RydWN0IGJsa3BnX3BhcnRpdGlvbiBfX3VzZXIgKnVwYXJ0LCBp
bnQgb3ApDQo+PiAgIHsNCj4+ICsJdW5zaWduZWQgaW50IGJsa3N6ID0gYmRldl9sb2dpY2FsX2Js
b2NrX3NpemUoYmRldik7DQo+PiAgIAlzdHJ1Y3QgZ2VuZGlzayAqZGlzayA9IGJkZXYtPmJkX2Rp
c2s7DQo+PiAgIAlzdHJ1Y3QgYmxrcGdfcGFydGl0aW9uIHA7DQo+PiAtCWxvbmcgbG9uZyBzdGFy
dCwgbGVuZ3RoOw0KPj4gKwlzZWN0b3JfdCBzdGFydCwgbGVuZ3RoOw0KPj4gICANCj4+ICAgCWlm
ICghY2FwYWJsZShDQVBfU1lTX0FETUlOKSkNCj4+ICAgCQlyZXR1cm4gLUVBQ0NFUzsNCj4+IEBA
IC0zMywxNCArMzQsMTcgQEAgc3RhdGljIGludCBibGtwZ19kb19pb2N0bChzdHJ1Y3QgYmxvY2tf
ZGV2aWNlICpiZGV2LA0KPj4gICAJaWYgKG9wID09IEJMS1BHX0RFTF9QQVJUSVRJT04pDQo+PiAg
IAkJcmV0dXJuIGJkZXZfZGVsX3BhcnRpdGlvbihkaXNrLCBwLnBubyk7DQo+PiAgIA0KPj4gKwlp
ZiAocC5zdGFydCA8IDAgfHwgcC5sZW5ndGggPD0gMCB8fCBwLnN0YXJ0ICsgcC5sZW5ndGggPCAw
KQ0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiArCS8qIENoZWNrIHRoYXQgdGhlIHBhcnRpdGlv
biBpcyBhbGlnbmVkIHRvIHRoZSBibG9jayBzaXplICovDQo+PiArCWlmICghSVNfQUxJR05FRChw
LnN0YXJ0IHwgcC5sZW5ndGgsIGJsa3N6KSkNCj4gDQo+IE1pbm9yIG5pdDogYmxrc3ogaXMgdXNl
ZCBvbmx5IGhlcmUgbm93LCBzbyB0aGlzIGNvdWxkIGJlIGNoYW5nZWQgdG86DQo+IA0KPiAJaWYg
KCFJU19BTElHTkVEKHAuc3RhcnQgfCBwLmxlbmd0aCwgYmRldl9sb2dpY2FsX2Jsb2NrX3NpemUo
YmRldikpKQ0KPiANCj4gdG8gbm90IHVzZSB0aGF0IGxvY2FsIHZhcmlhYmxlLg0KPiANCj4gV2l0
aCBvciB3aXRob3V0IHRoaXMgYWRkcmVzc2VkLCBsb29rcyBnb29kIHRvIG1lLg0KPiANCj4gUmV2
aWV3ZWQtYnk6IERhbWllbiBMZSBNb2FsIDxkbGVtb2FsQGtlcm5lbC5vcmc+DQo+IA0KPg0KDQpX
aXRoIGFib3ZlIGNvbW1lbnQgYWRkcmVzc2VkLA0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0KDQo=
