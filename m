Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE806F644E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 07:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjEDFQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 01:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDFQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 01:16:37 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6AC1997;
        Wed,  3 May 2023 22:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC5oCQk0rvsitKmVbnDy3cCSPvy5WeuhkD/8DaGJGld9RLTJoPKHTXLq+osfbJ3BsJKaU7ZGTfaqBonLH34BQ65UyZ4Lin8MocuRzhwirW0FJgGOaqiUNQLotQGUO1Q+u2z3rO8NcY3P/D8dT2FthG3zUly3ZajKhRKbk29/0yLbCQLymHF3IjiMKH7ZCSuKJxTnzNi5GSpL6xChYs/fjZDA3VQNvNC8oEIx93tUTQdTn4Jq/9tN6CQWqBA8kUANN5cT7R2yiUQHV9KE83LUB+lgTFe0WRP/Bsv9B9D15uYTktDT/eBNcWD+N8KCu0EKr3+nvPVHG7aO3jSg1CGaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpusciAVkH+N8MK5rDv4btB1KxYM5kXvxl7p4nfBqpE=;
 b=M7605ngXaknfjpMcJiE46HL0t4Y7GZ51csDnbqIs08uaAJ6T2sOJu4oo7H8ENczo8SE0WXudYpI4wDcCFGXuyhrX/jYnYj3zEFgPS7+Om8idH+a2qYnzplPwIZIomNXNSPJ8yc2Axpe/YuZ9prenl4zsNSDu43qw3SVq9BTkOMHqoZFKMoF4YGXQ1yEVxX9Ke6OE/sK4inQFWdc7XYsAG5dvYs9wCSXXU/18HtxIbfOqb0Z7VY+PVBApaSSr+S9oFCXBjxj4o1MSW1eb+CahSOufMs+uDvG3NBoyLKT+nn4pKYnW3FjrUgqwdsmxLczU+t6A1SJ4lIx38hjf0k/VKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpusciAVkH+N8MK5rDv4btB1KxYM5kXvxl7p4nfBqpE=;
 b=sKqwAiEZJILaEeLdHTjggvZnzcYhgXrOwAdbQ6r9aExbZbu737pOC5NhCcooJxkY/lvN1zzSmsNoozwr5vsAfR+hy30MM3NqxubnZMkSoPMGQ2D9crWf0i7fsx6eXRpRTGSAzvIwn1BRY/94PQA22a8sRFeI+KG9sOBXu251/P2+zq+F+0NN5mYbqrD8W3ixscp2iblJl+tPW620/VuLdS6VwWQq5nH8gjtflkMI6DWYiCejd+Ev4hQOZ5FGMIegs8FuOj/qjU1KLmU0FErOuu7BE25fwpXWoWBXL5k/gvE7FdUAHiXhfMpC9ZB3r4Y4kI+Evu7aAUs+Argvrqpzew==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 05:16:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 05:16:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 09/12] common/fio: Limit number of random jobs
Thread-Topic: [PATCH blktests v3 09/12] common/fio: Limit number of random
 jobs
Thread-Index: AQHZfZW4HmjkjzpblECxXYEAHu0pVK9IS7wAgAAWSwCAATH8gA==
Date:   Thu, 4 May 2023 05:16:34 +0000
Message-ID: <ec72542d-a554-59ac-8f67-26eeb7f2a5b0@nvidia.com>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-10-dwagner@suse.de>
 <99a6cc5f-31b2-787c-f448-53239a351ddd@nvidia.com>
 <2ercejt6r2qjkbpaoueh66nred4ooqb5wskx5m3xn2slb5kasw@zwssje3pm4mu>
In-Reply-To: <2ercejt6r2qjkbpaoueh66nred4ooqb5wskx5m3xn2slb5kasw@zwssje3pm4mu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6275:EE_
x-ms-office365-filtering-correlation-id: 7f06bf43-5fbc-4fc0-1e94-08db4c5eba8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8HqSY8v5GGPaqOeWjhjk4Fk+P3PF7NoRT6sRzonelK2ofkycPQPzv5PT5HYn5aRjvJgadd/0/Nrq3/B3xtvyVH4zQz7wF6LrgAyZLJeKwcrY0Xe/F733Ej0NCCjhcO0lpcS/GiHh41xnsnmeCCDQ1klm7O0O7s5PbsbumeHcKslcscOu8Asd+A4sl3x0RhWNt4fDGsF6/pWPiK4EhLwpLqcMtNVENHw7AWy6JJxYuMTjukPmiFrG2jnFEJImBawOM2C9W23jUFhWQ7DR2TZTaDndita9zLny6/QL7gbBjLU7hwh8D0fyxGiIyrQOT1EWII9Zmenr5AYDkZ/Q3mWhs0TFJomxu0tLfN2i0VSRiEHu83qX6SY/WohWI2jjHDysJLME5Ho+lZUK5uwW21GCvseKuCtNdx2qZDCBgDBTfJqeFVf5T+tcXhZ7EXqdmhUxnZX1lwX9Er+45VN4CFTgzAqR09Ni2pbWt8cNFAUVYhn3fNh+YgUWO8mAwqDUhixbEMMfZ/NUoGkHbuFFfdpAaRqRSDglq3ogMXAd0mUo5jgTsjvoMcTkQSM0B2kPfpQxPiu0JdX5Zv3lYzU8haWupIc+6/8lnJnQGJexsMzHVbrTila/WpqvuAqGak2U+uCdS7ybMoerfCYjuJ4ilmCkxZopNY1UKa9rYTjc62/8yNtuCdBWqDpOnBRPUeSS20x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(66446008)(66476007)(36756003)(4326008)(6916009)(66556008)(64756008)(76116006)(91956017)(83380400001)(66946007)(6512007)(6506007)(53546011)(186003)(2906002)(66899021)(31686004)(54906003)(478600001)(2616005)(38100700002)(8676002)(122000001)(8936002)(38070700005)(31696002)(86362001)(41300700001)(6486002)(71200400001)(5660300002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3gyOHhzV21Id3YyTEYxRWpmaU9xbDg1RHlVeEJvWFRIUHRuVFdYVCtyS0tm?=
 =?utf-8?B?emZ6YUMwaS9sengvdlI3TVdEd2hiYWV1Rml3bC9DV1Zvc1pZeXRTand2UlZK?=
 =?utf-8?B?ZTJwNVp5R2lNSG9JWEpNQk45ZCtmKzNvY3FMTVByQStWMGxNeXRWVDNSOVJ3?=
 =?utf-8?B?NWVMQktDdi9mQllSdzVWNy80YVNNdVBPK3lrSjZYbkRlMnYrRnd0ZGd5MDRj?=
 =?utf-8?B?OVQyN2loYm04K1o2R2ttWWx2ZDJtUkUzRXYyUzFRYW9DM2FEdFQwZ2lVbk0w?=
 =?utf-8?B?YVdDZHVIN1drSGFDU2ZhYWFiNmhTWjhySi95ZUVMMXZkdlNaQ2U3Y2pRaDQz?=
 =?utf-8?B?TGtzWmxLQjJqYmxZcWJFQmlsWjA3bTFMbWVPT0wyRTR1eDZYRGg5TEYvWlhh?=
 =?utf-8?B?N0g5WDU1QVZoczZWemJNRFgvNmh6eFE2VENYVGs4ZnNvWWhlU3JPRDR2T1Fm?=
 =?utf-8?B?cmpwcnBVN3ZWcUZONHZzUDUyaFp1R2ZYWlBMQzVjK0RmMlNiOEpubXQ5dGRV?=
 =?utf-8?B?aHkxRllOMHMwU2x0NGU0MUk2bkJSWlVVT3BTRFdKc3R2ZGJLYWdpMm1KWHlk?=
 =?utf-8?B?QllrYm4wbm50eXZuNUtxZmwxOHFnMGJOV1BDVEIzTTl4Sno1MWUwQWlhSGE1?=
 =?utf-8?B?Uk9nZS91eXA4K1FnZ29lSThPbU1BTThETGVMZks2Y3lNanRCV0hWdS9PbVJP?=
 =?utf-8?B?SkVjKzFocml1ZFVoWW9YOU5iWFozN0VRdXE4TFU3VUVpZ1lDb1JYLytvS05C?=
 =?utf-8?B?ai9hRHRJek02bXdRaFNMekh5cWxBM3RKWlowek9kWVcyRjFXTkZyaXRjSHBo?=
 =?utf-8?B?UEFwc05TR0paNlBDZ3d3dHYzNjV6NjJvRHlSc3V3cDlTSkhSVDZaRW9iNitP?=
 =?utf-8?B?VUlPRlNVeFVDTGxZOFU4TXpSQmJZbnZrcDV0SFF2azRRVDBtNXRPRUNKMkZ5?=
 =?utf-8?B?dktWR1hwQ045WUszY1lHaEkxSXZXREFldWYwSnFQV2J0bXcvVlFoRzREQ1c2?=
 =?utf-8?B?bHZsYkN0OFBKMW5ZL1VKY3I0K0Z6WTNxVld3eHZrU0xtbkxNRDg4UUtiWG40?=
 =?utf-8?B?SGJONEZTZWQ4U0VVSElkcHpHNTM1d0ZqS0JoSjEyUmk5dWc2Qjh2WHF0dzJh?=
 =?utf-8?B?bk5BNVlsVTFlTUUrcThudE4wYlpSWXlXWWVkRGRLR0FCaVJRVEJFZTRjOC8r?=
 =?utf-8?B?THNwdVp1ODdsazVncWRvQmwzcVJaSmdjQ3ZpaFRvTVZyZy9TZmdvN2YwNHlR?=
 =?utf-8?B?TVI5MXNlWlBlRXFpZ2N1Y2g2bVhGdnRpTVJCMUtvSG9Lb1NHTDhkTnQ5RDd2?=
 =?utf-8?B?N3JXZkJlMjQ3SDhpSW93OGxBbnhZeWcxZEhIOHJXcTNlbWFvSk9PL2QvM2k1?=
 =?utf-8?B?YjJYVWFYYks1ODJPRTFxZmY2N1ZrWmU0S0ZXMjhDQ25xU2daQW4yS00waVpC?=
 =?utf-8?B?RHVlcy9OQ3EyZFJrSzMwaUM0Y2tCK1RtcjE5cEdvdGpsLzdMaHA5ZWxrbTJD?=
 =?utf-8?B?VEpjcVFsMno4emM5ek9uZTdEZzNMNGhnVWYrUGVPOG9VdGh3L21YNmZ1VUVM?=
 =?utf-8?B?ekpDUmhGQTN5emRLZjk2ZlJZVkQrQjlBOU9vQjl0cjNqZTlaWUV1NEkvbGZ0?=
 =?utf-8?B?M0xpSklFRnRYeXI5M01vNFRxbTlkWVZaa3hsTjhna08vMERzT2pjK1MvblZS?=
 =?utf-8?B?RlBFS0lEN3RIOXp0ODU2TG1GVUFVQXZrWkhrL2kxTG92Ym4vWjRMWGZtWnpS?=
 =?utf-8?B?RVlmLzVoK3BMR3lBdHlmbTVSS3ZJZjVkenN5Q3BHUnptY1hFMVRlcDVhR1Mv?=
 =?utf-8?B?UWNibWpaazJZejJtMGFVcDZPU2QySnZ2UHpIWVpsbCtPaURjeDYrRGt4NXE4?=
 =?utf-8?B?RkttZnpEeTBnUmRJOXcrMzNXcmIrS0o0cUl1RU5mYnp0SzdwMHc5UDk2ZVdq?=
 =?utf-8?B?V2dkOWkxbTQ1d3RNcUZVUEdnblRncDhmQUt5ZW5pemZ4ZzJvbEdDN3hxMVE5?=
 =?utf-8?B?SlN0UVd6TG4vVEd2N3VRdjBWYlFNRzFlQTdtUTdIS1krMTFOM29Sd3B1VHZy?=
 =?utf-8?B?QzJJQWxXaVkrQUVzbkVLUXdVSmVnZit0eWJkbXV0b1YxRW4xOFo3VCtmVmVF?=
 =?utf-8?B?d2M0c04yL1UyWFhiekc4bStERVhHM1VocWdKR3JDaFZKT0dPdzNUSk9ObVBa?=
 =?utf-8?Q?pUhhPLsLGAbrW/CwYKN7i/DW5G3eCmpTXzVkzugtb/G+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DD29C98FCCCD54F9541A3DB60062E56@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f06bf43-5fbc-4fc0-1e94-08db4c5eba8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 05:16:34.3418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgHWNodQiRJOTaliFAj34Kui42r+vPKjLeRD37Y2hNckbxQowNXytCUFuhMem6VfPL5rsgKTIytvwO4BK/WTBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
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

T24gNS8zLzIzIDA0OjAxLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBPbiBXZWQsIE1heSAwMywg
MjAyMyBhdCAwOTo0MTozN0FNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBP
biA1LzMvMjMgMDE6MDIsIERhbmllbCBXYWduZXIgd3JvdGU6DQo+Pj4gTGltaXQgdGhlIG51bWJl
ciBvZiByYW5kb20gdGhyZWFkcyB0byAzMiBmb3IgYmlnIG1hY2hpbmVzLiBUaGlzIHN0aWxsDQo+
Pj4gZ2l2ZXMgZW5vdWdoIHJhbmRvbW5lc3MgYnV0IGxpbWl0cyB0aGUgcmVzb3VyY2UgdXNhZ2Uu
DQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+
DQo+Pj4gLS0tDQo+PiBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBjaGFuZ2UgdGhpcywgdGhlIHBv
aW50IG9mIGFsbCB0aGUgdGVzdHMgaXMNCj4+IHRvIG5vdCBsaW1pdCB0aGUgcmVzb3VyY2VzIGJ1
dCB1c2UgdGhyZWFkcyBhdCBsZWFzdCBlcXVhbCB0bw0KPj4gJChucHJvYyksIHNlZSByZWNlbnQg
cGF0Y2hlcyBmcm9tIGxlbm92byB0aGV5IGhhdmUgNDQ4IGNvcmVzLA0KPj4gbGltaXRpbmcgMzIg
aXMgPCAxMCUgQ1BVcyBhbmQgdGhhdCBpcyByZWFsbHkgc21hbGwgbnVtYmVyIGZvcg0KPj4gYSBs
YXJnZSBtYWNoaW5lIGlmIHdlIGRlY2lkZSB0byBydW4gdGVzdHMgb24gdGhhdCBtYWNoaW5lIC4u
Lg0KPiBJIGp1c3Qgd29uZGVyIGhvdyBoYW5kbGUgdGhlIGxpbWl0cyBmb3IgdGhlIGpvYiBzaXpl
LiBIYW5uZXMgYXNrZWQgdG8gbGltaXQgaXQNCj4gdG8gMzIgQ1BVcyBzbyB0aGF0IHRoZSBqb2Ig
c2l6ZSBkb2Vzbid0IGdldCBzbWFsbCwgZS5nLiBudm1lX2ltZ19zaXplPTE2TSBqb2INCj4gc2l6
ZSBwZXIgam9iIHdpdGggNDQ4IENQVXMgaXMgcm91Z2hseSAzNmtCLiBJcyB0aGlzIGdvb2QsIGJh
ZCBvciBkb2VzIGl0IGV2ZW4NCj4gbWFrZSBzZW5zZT8gSSBkb24ndCBrbm93Lg0KDQoxNk0gaXMg
dmVyeSBzbWFsbCBudW1iZXIgLi4NCg0KZnJvbSBteSBleHBlcmllbmNlIHdpdGggc21hbGxlciBJ
L08gc2l6ZXMgd2UgZG9uJ3Qgc2VlIHRoZSBsb2tkZXBzDQp0aGF0IHdlIHNlZSB3aXRoIHRoZSBs
YXJnZSBJL08gc2l6ZXMgaGVuY2UgaXQgaXMgYSBiYWQgaWRlYSB0byB1c2Ugc21hbGwNCkkvTyBz
aXplcyBhbmQgbGltaXRpbmcgdGhlIGpvYnMgdG8gaGFyZCBjb2RlZCAzMiBudW1iZXIgLi4uDQoN
Cj4gTXkgcXVlc3Rpb24gaXMgd2hhdCBzaG91bGQgdGhlIHBvbGljeSBiZT8gU2hvdWxkIHdlIHJl
amVjdCBjb25maWd1cmF0aW9uIHdoaWNoDQo+IHRyeSB0byBydW4gdG9vIHNtYWxsIGpvYnMgc2l6
ZXM/IFJlamVjdCBhbnl0aGluZyBiZWxvdyAxTSBmb3IgZXhhbXBsZT8gT3IgaXMNCj4gdGhlcmUg
YSBtZXRyaWMgd2hpY2ggd2UgY291bGQgYXMgYmFzZSBmb3IgYSBsaW1pdCBjYWxjdWxhdGlvbiAo
ZGlzayBnZW9tZXRyeSk/DQoNCnRoZSBiYXNpYyByZXF1aXJlbWVudCBoZXJlIGlzIHdlIG5lZWQg
dG8gcnVuIHRoZSBJL08gZnJvbSBldmVyeSBwcm9jZXNzb3IsDQpzbyBsZXQncyBrZWVwIC0tbnVt
am9icz0oJG5wcm9jKSBjb25zdGFudCBub3cgYW5kIGxldCB0aGUgdXNlciBzZXQgam9iIA0Kc2l6
ZS4uDQppbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSBmb3IgTlZNZSB3ZSBzZXQgdGhlIHNpemUgMUcg
YW5kIHRoYXQgaXMgDQpzdWZmaWNpZW50IHNpbmNlDQpudW1iam9icyBhcmUgc2V0IHRvIG5wcm9j
IGFuZCB3aXRoIHRoaXMgc2VyaWVzIHVzZXIgY2FuIHNldCB0aGUgc2l6ZSANCmJhc2VkIG9uDQph
IHBhcnRpY3VsYXIgYXJjaCAuLi4NCg0KU2VlIFsxXSBpZiB5b3UgYXJlIGludGVyZXN0ZWQgaW4g
aG93IHRvIHF1YW50aWZ5IHNtYWxsIG9yIGxhcmdlIGpvYiBzaXplLg0KDQpGb3IgdGhpcyBzZXJp
ZXMgdG8gbWVyZ2UgbGV0J3Mga2VlcCBpcyBzaW1wbGUgYW5kIG5vdCB3b3JyeSBhYm91dCBlcnJv
cmluZw0Kb3V0IG9uIGEgcGFydGljdWxhciBqb2Igc2l6ZSBidXQganVzdCBrZWVwaW5nIHRoZSBu
cHJvYyBhcyBpdCBpcyAuLi4NCg0KLWNrDQoNCklkZWFsbHkgaW4gcGFzdCB3aGF0IEkndmUgZG9u
ZSBpc8KgIDotDQoxLiBBY2NlcHQgdGhlICUgb2YgdGhlIENQVSBjb3JlcyB0aGF0IHdlIHdhbnQg
dG8ga2VlcCBpdCBidXN5Lg0KMi4gQWNjZXB0IHRoZSAlIG9mIHRoZSBkaXNrIHNwYWNlIHdlIHdh
bnQgdG8gZXhlcmNpc2UgdGVzdC4NCjMuIFVzZSB0aGUgY29tYmluYXRpb24gb2YgdGhlICMxIGFu
ZCAjMiB0byBzcHJlYWQgb3V0IHRoZQ0KIMKgwqAgam9iIHNpemUgYWNyb3NzIHRoZSBudW1iZXIg
b2Ygam9icy4NCg0Kd2l0aCBhYm92ZSBkZXNpZ24gb25lIGRvZXNuJ3QgaGF2ZSB0byBhc3N1bWUg
d2hhdCBpcyBzbWFsbCBvciB3aGF0IGl0IGxhcmdlDQpqb2Igc2l6ZSBhbmQgc3lzdGVtIGdldHMg
dGVzdGVkIGFjY29yZGluZyB0byB1c2VyJ3MgZXhwZWN0YXRpb25zIHN1Y2ggYXMNCjUwJSBDUFVz
IGFyZSBidXN5IG9uIDgwJSBkaXNrIHNpemUgb3IgMTAwJSBDUFVzIGFyZSBidXN5IHdpdGggNTAl
IG9mDQpkaXNrIHNpemUuDQoNCg0K
