Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BCD615C04
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 06:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiKBFy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 01:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKBFyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 01:54:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33AC2626;
        Tue,  1 Nov 2022 22:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZxkK00xP/kLwAkqcQ6kLJDXPmgRsiB6dunOtGkxjGk5tM6s1kmpBLCi9Ys6P3V49d956wqBTYj5JPybClnIJsC271aYz4w+ZpE8y98Tl666Xoj7H+AnqrRnXvLbxFRla5V28pnsAOQzyb5ynueP17EM/UZjWIfCYd3WUQ+a26MIfeErmou9ITNSo/+rGeDo85PrmRmhpOC417tbILw3G6nztGzv+/R1I+U+S2c4AIBIrehfynmXsS9Mz3ML4A9Gdjj/awMJ/rVY4HQpqVutV/s07z0fOi7NQYLbhiyQ6JlGDtOtV4sncyGF6bY48wB8pByAJ0Of7wP8yMwpS1gO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E/kP71JXOK5+yCN8iEbSv3+5AxEYlcPeZfn8erpxkw=;
 b=KrpM7ILV4f7uJ595gfd8SpSDbWxu6SqZ1et+QxT9cnvskVROEEvg4csDTa99DXhZCVjKRJEiFrTLoPzLYTk6qUJPRiGIuWONGAE7ehjYlkUv13SEvAqCoz32fHPbCh4TIA228y97r+zCU4qgo/e+NYo0PPd8pF6zhUN2a2U4/KLjhouWc176A9g+y3FcLfjo5kxnUY0TLWm/x1D6obihHCSSNusYKIrYO/6tgqc3ykbRSB7vXPv7Yp1phq+2FMsUD8Qm4TMph4hP8SJucgzERz95GW/EbSmBhO/Zqw39ghLZagC0/kcWd046w+WsZhcHkCHAwZAmyRa5h7b+aC0rXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E/kP71JXOK5+yCN8iEbSv3+5AxEYlcPeZfn8erpxkw=;
 b=o/Hd0IqmI/MRKqpTPadRALMRIyPsySl0Wq+LY3OVV0o1fz416ahW4REcgkcuvvP9B+DcBgktntNzFe1QH3p+tYEPNo/JUcPkDW8h6omuzaLb6+WG4I1EgyV11sz1nC0EqLQ+xvMKd76daaMUGxdmyLoV7ambMEtr6VeI+L5tRb07uV+nuLhBQWsQ72qn5uJVbRkjLMcHKhiX2rdpB0jowkTAyqZMnt6HIHf2FB0fVNhxXM9sw9/76vK6dIQG0hes4DUySGvcTiSFqQpWSSczLk7uJUk/M/1KV/1sWGoXm+GpvQ5Dqizv+oabl0NMwOhPkzDRUZLgM6rrbCD8V95+XA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 05:54:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 05:54:20 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Subject: Re: [PATCH 04/30] scsi: target: Use kstrtobool() instead of
 strtobool()
Thread-Topic: [PATCH 04/30] scsi: target: Use kstrtobool() instead of
 strtobool()
Thread-Index: AQHY7jgbr7eByiXbhUmTK+NFixFMIq4rIqkA
Date:   Wed, 2 Nov 2022 05:54:20 +0000
Message-ID: <2326193c-d522-afa3-2e68-c88bf2a6483f@nvidia.com>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <fcddc0a53b4fc6e3c2e93592d3f61c5c63121855.1667336095.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <fcddc0a53b4fc6e3c2e93592d3f61c5c63121855.1667336095.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7947:EE_
x-ms-office365-filtering-correlation-id: 3f648dd2-fe45-4864-a0d9-08dabc96afa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: taEZKfU7kQ8I8XP9mJY8UDcw1iNbsiYrXgM4GsGBLzFSA5K15dOsEttCiGFaXBVvIRLnQelwPVXjaP/0TdDhJGFWnS2EAzyBe+fFrfgB8T4wY4bsUTlrncHwd2igwq6HpaUwr8SdBSFkX1iXeRrQppHSsYkLFOjN8mk5nUym8VrUm9ljvNQiaZhev6EjMzeGR4hinnDbVXtNKMVjDwO+aXyl2vTdOpOyk/t6acM4tIqXJkrZyjB25b0oMtvEeYsd6xBoZdjk/iVnDbN6QTG4CdzZ6xnHCr2ooDcOFQMHk7Zo4vJBlzRsT8H7aJHA27q+c7aVLenReNn9fqBx4nYbYvPXtWwf3/nGNtV+EF0rstlLOnAhwUrYoiHZ3vgyWAdDCTJ64EIQyEnl4nXu1iMtEAvhtEUoy75H2+JHC/wNFOkkU6mIWGOrkQPJy2We+ovzZQJbx0xlpntkkUYbatMQ3858HCGHPzthiCz6QlI1SL36+O0/zma/mrStTuz2Qoy9FBXFxOm7Byc/PRtLWb9ONTC2O42P+94/jJ3VUw/fa+Otumba/XA6rRGXqDaBpwC1SKOoItf8bI4+IJjCg/BURv2weBycnvPqtgPA2QXKOoIiDcYEX6ej8ti7LkOjxcAkonJKG1oHBWBAa/LDMwHcHztD0+QsVE9ETGuIi8jNBHNdFb0DhB99ypTmIS/VArJeiYJfT2jIC8RtdyUmMs7H/3zPNqBwNDO6zQqQmBzW67kyDxhzxbqUKN8ZxPKmrQOkyNGWwmtlE4FIr1gOS9x5vd9laHkZ4pCEiUSKt2tOpeJt7akAUVO+p2sx/SZ+GPuJGHHkal/JB2eppmXu0pFNTj6FjXHAdxkFmoDXoWfCneT67O1IPhp6U7TZUjgo1O/sVi69P02SZpALsMU6EXXRc1oM8BgdOJDz18PGzjZU54Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199015)(86362001)(31696002)(83380400001)(38070700005)(122000001)(38100700002)(2906002)(5660300002)(8676002)(66946007)(41300700001)(76116006)(66556008)(8936002)(66476007)(66446008)(64756008)(4326008)(6506007)(6486002)(186003)(6512007)(478600001)(54906003)(110136005)(2616005)(53546011)(966005)(316002)(91956017)(31686004)(36756003)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGZML3VkMkRrN0lCWXdvdUpud2l1UStxVFowYTRoVVdZditJWTcyeldhandk?=
 =?utf-8?B?L3ZneWR0QnFsSExvcFY5K2RVVlJ6S3MrM0pmU29jcjIydW1YSFM4VjdOWXNF?=
 =?utf-8?B?ejVRVHBIdlNlcEhuK3pFUmFjcC8yZXhuYlVwalpGUEZLWXMyMlFGWVFFME94?=
 =?utf-8?B?SzVLT2o1M0FrZFppdG90TzRjL1dIclNWNTdteDl3ME4zT2haaDAxbjFIYzRI?=
 =?utf-8?B?NTdpaTFlbmx1alg1alRBNkFSeExiaHdwU3lmTWxYMEJUZERFY3J1U3VMa3lG?=
 =?utf-8?B?Y0Evbm5BRkIzRlJZNEZsWldnZzl6Q1E4cTBKREpFaEw2dndDVk40S1hOaG5a?=
 =?utf-8?B?UFdlN0lWY2ozYVAxNnhSdGg2TWhYazVtQU00OWw1NVdMeU40MU1UUU5qYTFY?=
 =?utf-8?B?ZW9PMnJHY2s2MWhxbG9ScnBOb1k1RXJGM0FRUkpvSGVSVW1SZDk1UnJrbmFS?=
 =?utf-8?B?eW9RWUxiWURIMjJXeXNhQ0o2VFhBYVo4M0hYK0J1VEhWaEkrV2F3Q1ozbVgr?=
 =?utf-8?B?SEZGdEFTQUdQTThyMU5QdERrRjU0cGNtYkVRYXRacFJzTVlCZlpvdFpseVho?=
 =?utf-8?B?bk5ScStlRHoyOHhmTUVYRzZ6QzhvT3UwSXJySkFKTUFheGw0Q3FGTmNFTk5O?=
 =?utf-8?B?WEhWSWxlRmZPay9lUUJiMy92TXUyblJUOWtvMVE1TWpmRnNGa2kzdFNGK1Av?=
 =?utf-8?B?KzY2bEs1dU1WdnhVNG9xTUhxMkFuc2gvb1R0dVZvQVZoMlF5MXVOVC9ndERO?=
 =?utf-8?B?czJDVG1VeGRjdzFYRTRJRStESjBmZExvTGdmaDg1RXV4MGJIRzF0Y1d0NUx2?=
 =?utf-8?B?MHJOMVB5cExZQUtJWXREWWVWczI4by9LOTF6RTBOWnhDdW1ocFBPeFRnZ0VP?=
 =?utf-8?B?TXgxWk54WEtQVi9tNDQrRHRCa0tHcjB1bDhmTWhqZUlzYUNhNWZTblduRUNP?=
 =?utf-8?B?cXRqR3g4ZXIxQXA1SFltclhiRHlXbTJIbUFOVVd2Yk9PdlJRbDVEQmN4YUhZ?=
 =?utf-8?B?RGNielVtODBncXVLY2drVnFVSWRYVXdyeDRuZVAyYmllZC9kWkQrSlFwM3Ar?=
 =?utf-8?B?SEpYcFBpUFd2eldTbUR5bzJ6STV0QmZzdFNhREUrMSt6OVRpUTk0OG42bXdo?=
 =?utf-8?B?RkV6eldEcmxlNWJGdldwL3M2dE45dWpRYmRsVER3KzJQUTNwb3E0TzlzYXNr?=
 =?utf-8?B?dG9TWkpNclZYNFVtK0NjZ0FHQmRId3lVL1k5eGZGRTlnTU9FM2JMcnYzaytX?=
 =?utf-8?B?dEt1WjlaeG5kL2crZWNhVlcwWHEzVms4WGtqcGcxSTVnT3VZQVdPRGxWenlD?=
 =?utf-8?B?ekNOUGhWcksrcTlnM0pVN1hLaVlWaGozSnA2OVhpRFhlM2o2WnUzdy9EVzdD?=
 =?utf-8?B?K2VuVTVCc0ZTVHJpV29KWXBpWWU2ZXgzamJ2YWtiNDlKckgxWCtFQmdESXdx?=
 =?utf-8?B?YUFhbzZhRWhnUEx3ZFFwRjFaVDJjTDlPSlE2aW9pa0t0V2dmcDVleFBDcEli?=
 =?utf-8?B?NjE0WDhoNzFoZDRlVVJqblh5NFN2S2hPejlSbG4yL3VBNHR2WFV3RkxvL3py?=
 =?utf-8?B?dldvTHZKell2RGlLWmlGNWViOFpwTlBqY0VOODJnNkxwc1Z4NHJ6Z0pPa01u?=
 =?utf-8?B?UC9JTjFqSjhWN3p1czQ1OFJoRmFwUkltSWt5VDZ5a0xEZ1h6OHZSRGZIR25W?=
 =?utf-8?B?MENMTHlma2trYmVpYXFuS0kyeWNZU2xhWG1peVlXb1UxNytUUk1jb2R4ZHZi?=
 =?utf-8?B?Zzc3QTB5ZnZOKzhqUm1HRjk0d2U2ampSMVJWSHlZNndsWFJUOXdORWFFQmNS?=
 =?utf-8?B?YXlWN0RiTWlZWmlpbWl2K0lQY0paYWZsQ0NMbjBZTWZPd3h3V21yR2c1QlpW?=
 =?utf-8?B?Ly9lZ21Wa3gvTGxpdm1qdy9qc0JoQkVlVUhWVjlnRVBnMVdFb2lpdUlZaHZu?=
 =?utf-8?B?UWhoQm5ZTldJZHZPYzhIYWtHTUdRK1hFYTdZUVdKYlpXZDA2cVYyaU5wcmNI?=
 =?utf-8?B?T01lVE9wR2dYcnRlUEI0ZzU2bnZqaXdRQk1tVzhUNWsramNESFhTWUFuMTlq?=
 =?utf-8?B?WkMzNnErdHBQbXdSNGEyY21TcmQ1QjZNYjVabWZBVlh1b0hyVDNNL2h4UDRL?=
 =?utf-8?B?VUs1aE5tYlpiTzg4dkFISjMwYzIwUUhYUWNYU2d3S1k1OVUrdVRDdXBQTSs0?=
 =?utf-8?B?ekE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BA62C73ABC83448AE84D57F7A76F09F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f648dd2-fe45-4864-a0d9-08dabc96afa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 05:54:20.3977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFOPpmHQ44C7ISZ5tOZXAAOoIEwnmlgDFfT5JKUbwKWHaoA2ofq5hxYFQNCg6hs/M+PJ1rM6Oo2FcF+iGWJtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMS8yMiAxNDoxMywgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBzdHJ0b2Jvb2wo
KSBpcyB0aGUgc2FtZSBhcyBrc3RydG9ib29sKCkuDQo+IEhvd2V2ZXIsIHRoZSBsYXR0ZXIgaXMg
bW9yZSB1c2VkIHdpdGhpbiB0aGUga2VybmVsLg0KPiANCj4gSW4gb3JkZXIgdG8gcmVtb3ZlIHN0
cnRvYm9vbCgpIGFuZCBzbGlnaHRseSBzaW1wbGlmeSBrc3RydG94LmgsIHN3aXRjaCB0bw0KPiB0
aGUgb3RoZXIgZnVuY3Rpb24gbmFtZS4NCj4gDQo+IFdoaWxlIGF0IGl0LCBpbmNsdWRlIHRoZSBj
b3JyZXNwb25kaW5nIGhlYWRlciBmaWxlICg8bGludXgva3N0cnRveC5oPikNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28u
ZnI+DQo+IC0tLQ0KPiBUaGlzIHBhdGNoIGlzIHBhcnQgb2YgYSBzZXJpZSB0aGF0IGF4ZXMgYWxs
IHVzYWdlcyBvZiBzdHJ0b2Jvb2woKS4NCj4gRWFjaCBwYXRjaCBjYW4gYmUgYXBwbGllZCBpbmRl
cGVuZGVudGx5IGZyb20gdGhlIG90aGVyIG9uZXMuDQo+IA0KPiBUaGUgbGFzdCBwYXRjaCBvZiB0
aGUgc2VyaWUgcmVtb3ZlcyB0aGUgZGVmaW5pdGlvbiBvZiBzdHJ0b2Jvb2woKS4NCj4gDQo+IFlv
dSBtYXkgbm90IGJlIGluIGNvcHkgb2YgdGhlIGNvdmVyIGxldHRlci4gU28sIGlmIG5lZWRlZCwg
aXQgaXMgYXZhaWxhYmxlDQo+IGF0IFsxXS4NCj4gDQo+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsL2NvdmVyLjE2NjczMzYwOTUuZ2l0LmNocmlzdG9waGUuamFpbGxldEB3YW5hZG9v
LmZyLw0KPiAtLS0NCj4gICBkcml2ZXJzL3RhcmdldC90YXJnZXRfY29yZV9jb25maWdmcy5jICAg
ICAgICB8IDI5ICsrKysrKysrKystLS0tLS0tLS0tDQo+ICAgZHJpdmVycy90YXJnZXQvdGFyZ2V0
X2NvcmVfZmFicmljX2NvbmZpZ2ZzLmMgfCAgMyArLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy90YXJnZXQvdGFyZ2V0X2NvcmVfY29uZmlnZnMuYyBiL2RyaXZlcnMvdGFyZ2V0L3RhcmdldF9j
b3JlX2NvbmZpZ2ZzLmMNCj4gaW5kZXggNTMzNTI0Mjk5ZWQ2Li5iOGE1YzhkNmNmZGUgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdGFyZ2V0L3RhcmdldF9jb3JlX2NvbmZpZ2ZzLmMNCj4gKysrIGIv
ZHJpdmVycy90YXJnZXQvdGFyZ2V0X2NvcmVfY29uZmlnZnMuYw0KPiBAQCAtMTIsNiArMTIsNyBA
QA0KPiAgICAqDQo+ICAgICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovDQo+ICAgDQoNCg0KDQpJIGJlbGll
dmUgeW91IGhhdmUgdGVzdGVkIHRoaXMgcGF0Y2ggdGhvcm91Z2hseSwgd2l0aCB0aGF0LA0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoN
Cg==
