Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB24E618E03
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiKDCKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDCKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:10:51 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2051.outbound.protection.outlook.com [40.107.114.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F51BAB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 19:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nb6ilMTvw6KXHY1rigsH1FDotvEAKNrsoJY0kbvd+1CxqbThzdNzxybV9eNfi5vJFck6mGeJZKhX9i5O1Z3PT86AteteXpxEDq3E1XUQYDVMqq56ko81SPMeUsa/ifqj6bDZB7N6lghot8SRVhm9QxCuBAq/bEF8dIVq8CGDybmbfBvQlEJdWq9Orika36VoipXScxCvmI2TVp52XhDhuVZ9AO/ooGaYDoR2SGJDvjpbQKG4sfNJ5pJ6GEZJWDpxpuxUxHlGqIjo8d4KCBJAj7JdcMglR1CNZDptXTekGqh+IEZ2TC2AGBfcmjXnApg+wrn0Z4Lf3vjqanVEFyFTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3p7OWofSLXfF8ePSsyO+LyCKBFpJUPoZuwi7sAjGz8=;
 b=J08gFcV2Q+qdzW1HaFqn/4Y3iEUAnr93ctZGZCcC8aF5Bg6YzO/BMAdf9MVumKWSWrA/6Tgp9TBFmsC4U0aHoeWNLY0ZNrrmDsioGw6qG/UtqJ5sOnHHJnR4ZYRKbicT6cWbJj/k2GnbW8KIkRs//p7q4naxtXykPvX5X5D/9jhICHohlelHNLE70I0epOx9VQ6VrDsSrDr6Vdxnnp9Tu/FggfrpV3b83OhhVzAblD8/dVOrnAIE2I4heaEEcBzOHTtUjcHLUwwYTi6gJ6FMfE0kokWeYPUIiI0O1Yuz7Rtmi5D1wPwFfsw45sDzTsuipZI06tfpoHpMFjNtJoi0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3p7OWofSLXfF8ePSsyO+LyCKBFpJUPoZuwi7sAjGz8=;
 b=Nw6IhHId+HDYZBNZxAvR7J/3koYg1beetMF3sjNhNROluhIkDI7CKhcHcK/xlg9McvLIGqipp1drTMcUfegrbh64M78hV/P/9HW7lvgJg6aa71KXf6raBAAJ6weSvDOVMixSd4dWjB0RBf7/rspcfmML3RTGxaaDsKL71OYiz5M=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB9669.jpnprd01.prod.outlook.com (2603:1096:400:221::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 02:10:48 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 02:10:48 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     James Houghton <jthoughton@google.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hugetlbfs: don't delete error page from pagecache
Thread-Topic: [PATCH] hugetlbfs: don't delete error page from pagecache
Thread-Index: AQHY4yxyvuDt9sfNK0SSpohdeMPIJ64uHuaA
Date:   Fri, 4 Nov 2022 02:10:48 +0000
Message-ID: <20221104021035.GA297167@hori.linux.bs1.fc.nec.co.jp>
References: <20221018200125.848471-1-jthoughton@google.com>
In-Reply-To: <20221018200125.848471-1-jthoughton@google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYCPR01MB9669:EE_
x-ms-office365-filtering-correlation-id: b04c0ce6-e56a-4728-a37d-08dabe09ca49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+U2rH6YwEV1B0DH0fSRXLzCiDZwuylQ+5qCAjwMLZiYpH6nWqiFfYNlV1fQrDRLinCicyXZA+JNeA/9wqccqI8D22K4JlvvQelZSkfOpsq6yqsByTgOo4cYZlRWMcV8xbUjLoXhcm7V6VM1BiV6K5GlVURJwKsIz17HHDZ/r6P1mWEx9lNcdV2/Xtw9vIUC7+v6y5aili9Y0caXXp8CYc8H9Jdkvc7hS3ksDrtOj0jhbi9oFudtJL5jmJKbmysiv2CK5sOTOxAeDnvCRRJ/R7hmdCsdMZb8FS1NFpXatKRazOcyITdKQzPxFcqq5MKVVV0EqI3IuqH9SZlbUjWtbCcPnfdBLeLjc5B/lvYg4Yu4tQEKZYysDmcIw6DM7t8AyegxlXUFKM2vVODYNEpFTPqi4IINHQHIWoCB/fFd87C+eZTkpWn5/GNphBmp6QOVlTbVxiRuBWxACyDmkCbtXO5QzoH9xI1W1rB54PQio/Gso80ZyQbn6iXkuJfNLzsUQclJvcP9q3ZkuC/P4zrrgvlX/Mz+BYO1M7sNVrq/7rSd69u1Jf6bGqyYbFq9b6XEniLmhAAP8aDZWg9kND8sHEDpsmiXs9SMUa0mkx1P7SK/yJUJVGaxpMGiBPJkIkQkuxUxFLP3ySytXNY4l1fgAGTQ64zLhINbeZb/C3UoGF4JRLCZx+NY02utAQPza7Qq9ApscLxXzHTFPJfmBpRjzLabbUN/o7whzA5JlofRDVsO0gq3gSNri/sYOaL2A27twoqeeGSmZ1uFVHZY/0zTzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(9686003)(186003)(6512007)(1076003)(55236004)(6506007)(26005)(83380400001)(2906002)(122000001)(6916009)(54906003)(4326008)(316002)(6486002)(41300700001)(71200400001)(5660300002)(8936002)(76116006)(8676002)(66946007)(478600001)(66446008)(64756008)(66476007)(66556008)(85182001)(33656002)(38100700002)(82960400001)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVo4V1dqeUVqN0pVNmpJQTBPYUY2RzZnckFlaC91ZW9WOVh6RzBJS3BMT2Q2?=
 =?utf-8?B?dWZNZUhFWjh1Z0NodTBnbnFMc2dVNm4wMGtkUDhaSHR5aDJvNXROOHNpVzlw?=
 =?utf-8?B?bFRPTFE2NTNLdjBYZ0pmK0lBUHZvWmg2WDN4enB0c1lrb0JzeFZkbWwrVW00?=
 =?utf-8?B?VnhVNWRUeG8zZDdTc2RTdFZKdUNZdkJMRkNmL2o5Q2dhTVQzaTIzY1l1VEp3?=
 =?utf-8?B?TFpSOVZuUEdGckhWUFpSMmJQTTFUOHVLL2lKVFQ3T2F2SkpwaG9aaEN3T01S?=
 =?utf-8?B?alJTMWgzeXpTcjArWHNId1dCVWhQZW1EeGVKUk44M3hCMUg2NXBETmh0WmpZ?=
 =?utf-8?B?Ym1EYmE5UzJkUW9icm1RSjFTM1hMUlUwWHVZNSt4K05xbmhJb0RiTitCNVdS?=
 =?utf-8?B?cEhQWVVTdHRvMXJIU3ZZdGJWUnJkN3MwTW9jL3ZHMWJiakhwalZwY25RVWV0?=
 =?utf-8?B?VXNJMGFBZnVVaGozb2FYQjhmd0lrTG95MkJXZjBZbmxwYktNVDJvOHlobGRu?=
 =?utf-8?B?eUxKWnhRZjRqQjN2cW5hRi9NcnZFYS94WEJrZVVmeTdaY1JDckRUNlB1bU11?=
 =?utf-8?B?N2FoUCtyMll1RmZBUlEwNGRXM3oyV01oanlpNVNXazdkczFteWFtekYzcC9i?=
 =?utf-8?B?TWVSbHZaeWorRHZmWWRWUk1oYVRNMU5uemQyWFdka1FKQkwyMXJOUytMWDVG?=
 =?utf-8?B?UWZnNStac2dET3pORjEzWDlKQ2RGNXVUcE9MdEZMYUl3YXFaZloyNHh4cDlz?=
 =?utf-8?B?MVU4M0EzenQ0Mk4rYjZBRjF1SEgyTjFrZmhCUG9LaXdBZTErRTcybWluR2dV?=
 =?utf-8?B?OWVEbzJoUmc2MWdkT2RaTTExN05rajhRV1JEM082WVZNcTlnRnNBU3BIcE15?=
 =?utf-8?B?YjMwaXFuaU5vb2Q3OFBKL0J1QU9IRjlhOXpQemp1Rk1YUWFuaWRCaEpKVnhs?=
 =?utf-8?B?V2Mvamh5WnFpTjE0K0tyTnJBeSs3VS91cS96Vnl3ekRlczZ6NFE0VG5EN2JR?=
 =?utf-8?B?T1pzZURWQU1BL2JnN0VlT3JjVndBWkZDeUNJb1JFSFF1TFJlenNhRDRBZU9E?=
 =?utf-8?B?d1BNQ2RKOVJuNzZuVGFCeExIY0VpeUpMeGdSWGZHNDBaLzU5THBFQVpmSGhh?=
 =?utf-8?B?UEx5MFR3ZFQ4dzlzNVpJTXhRck1GUmpHZmUrRHp3UTM3ZEFHVU1Ib2I4NlVZ?=
 =?utf-8?B?YXM0SkhQdWY2UGZvanhVN3psZEtNd3orRmZieXdycjJDK1NtVk9xSWZpaEZm?=
 =?utf-8?B?WkJOajZseWpRNzRzQldLOGIwMmQ1SmJ1a1ZEdDNucnNKZ0dFODh4OTV4Y0NT?=
 =?utf-8?B?YnN3bzF0dDZaVnk3K05XdnNTL3UzZ2hwRVI0S3JmbCtFOVFFTnVvNzU4MGhW?=
 =?utf-8?B?MDJxd1h1Um0xS3AwcUZVWG9LQUh4Si9zK1JjVmRwS3M5NXV4UGZUeGdyem9O?=
 =?utf-8?B?WXViY1FiYXdNbUs1aWZtYVc5REplWko1RmJ0bFJ0c0VyaG0zRkhWdEVWWjll?=
 =?utf-8?B?Wjh0eW1RVURBTGcrU3QySUpPVHNWVlBEVVd0amhpMzBMT0p3eVREYjI5bXRU?=
 =?utf-8?B?YjNyQU9xODUxTWdoc2thc2YvQVQwOUVJSkcvUGwxUkZuMDZMMGNqSzBTQWg2?=
 =?utf-8?B?ckZVbnVXcGpHVWdGaDB4ZEJVenR2SUVPT2xkYVFTNzFwZUcyZVVmWGRTZG9k?=
 =?utf-8?B?R2tPcDdXaEJiRktIZGJmbjFuZjNjUzlkZ0VhWDM4aHdzRk02YTl2NUZBb3lo?=
 =?utf-8?B?ZktLMEpEd1JLMHNVTHVBRG5rSXI0cEdnQ1lydFl4dytzcVZxaVUydGtvOHhw?=
 =?utf-8?B?c3J4QjZ2S0ZrZHJaZVFPZk5MMHJ1SHBlendzcnVKRUdtb2lNTEtOejNvSGph?=
 =?utf-8?B?ZS91NnJYS2hLZDB2MjFwZFRjcmJqNHBMamMzNjFGSjl5SG1UMVI0QmJhWUR3?=
 =?utf-8?B?NzRDQTVGbkdIN0YyQzVTRnNBR0lMZ1JQcFlpZCtobTBsNk0yUU9UY1BranFO?=
 =?utf-8?B?MldYLzlsaElVYXpHd2xQbGY2NTJ2dVJIQS9SK0krWUx4SGZ2dXlMYlErK3Ir?=
 =?utf-8?B?TmFuaGdkQ2t1ZEdEU1R2MXViQ1B0YXppQ0pIclhCLzZpMXExNWE0MVhzK2Ni?=
 =?utf-8?B?b3lZaFdJR1JQRkRvbTJhMmhQRjl0QlpONGJTdGk0b0htbVV5YTBnMmtqV2NI?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27A93CEEF2EF0247B12019673CDD9154@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04c0ce6-e56a-4728-a37d-08dabe09ca49
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 02:10:48.3840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rtj3T2rAavnN8wuSuPs9yZNJnyKZIsW/ndRK7OcWnOSlGi86Uqrr1Mgc8mkTJDsdcBMiuEVX4AcsiRZZ2YOfxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBPY3QgMTgsIDIwMjIgYXQgMDg6MDE6MjVQTSArMDAwMCwgSmFtZXMgSG91Z2h0b24g
d3JvdGU6DQo+IFRoaXMgY2hhbmdlIGlzIHZlcnkgc2ltaWxhciB0byB0aGUgY2hhbmdlIHRoYXQg
d2FzIG1hZGUgZm9yIHNobWVtIFsxXSwNCj4gYW5kIGl0IHNvbHZlcyB0aGUgc2FtZSBwcm9ibGVt
IGJ1dCBmb3IgSHVnZVRMQkZTIGluc3RlYWQuDQo+IA0KPiBDdXJyZW50bHksIHdoZW4gcG9pc29u
IGlzIGZvdW5kIGluIGEgSHVnZVRMQiBwYWdlLCB0aGUgcGFnZSBpcyByZW1vdmVkDQo+IGZyb20g
dGhlIHBhZ2UgY2FjaGUuIFRoYXQgbWVhbnMgdGhhdCBhdHRlbXB0aW5nIHRvIG1hcCBvciByZWFk
IHRoYXQNCj4gaHVnZXBhZ2UgaW4gdGhlIGZ1dHVyZSB3aWxsIHJlc3VsdCBpbiBhIG5ldyBodWdl
cGFnZSBiZWluZyBhbGxvY2F0ZWQNCj4gaW5zdGVhZCBvZiBub3RpZnlpbmcgdGhlIHVzZXIgdGhh
dCB0aGUgcGFnZSB3YXMgcG9pc29uZWQuIEFzIFsxXSBzdGF0ZXMsDQo+IHRoaXMgaXMgZWZmZWN0
aXZlbHkgbWVtb3J5IGNvcnJ1cHRpb24uDQo+IA0KPiBUaGUgZml4IGlzIHRvIGxlYXZlIHRoZSBw
YWdlIGluIHRoZSBwYWdlIGNhY2hlLiBJZiB0aGUgdXNlciBhdHRlbXB0cyB0bw0KPiB1c2UgYSBw
b2lzb25lZCBIdWdlVExCIHBhZ2Ugd2l0aCBhIHN5c2NhbGwsIHRoZSBzeXNjYWxsIHdpbGwgZmFp
bCB3aXRoDQo+IEVJTywgdGhlIHNhbWUgZXJyb3IgY29kZSB0aGF0IHNobWVtIHVzZXMuIEZvciBh
dHRlbXB0cyB0byBtYXAgdGhlIHBhZ2UsDQo+IHRoZSB0aHJlYWQgd2lsbCBnZXQgYSBCVVNfTUNF
RVJSX0FSIFNJR0JVUy4NCj4gDQo+IFsxXTogY29tbWl0IGE3NjA1NDI2NjY2MSAoIm1tOiBzaG1l
bTogZG9uJ3QgdHJ1bmNhdGUgcGFnZSBpZiBtZW1vcnkgZmFpbHVyZSBoYXBwZW5zIikNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEphbWVzIEhvdWdodG9uIDxqdGhvdWdodG9uQGdvb2dsZS5jb20+DQoN
CkkgZGlkIHNvbWUgdGVzdGluZyBhbmQgZm91bmQgbm8gaXNzdWUuIFNvIEkgYWdyZWUgd2l0aCB0
aGlzIHBhdGNoLg0KVGhhbmsgeW91IHZlcnkgbXVjaC4NCg0KVGVzdGVkLWJ5OiBOYW95YSBIb3Jp
Z3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KUmV2aWV3ZWQtYnk6IE5hb3lhIEhvcmln
dWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQoNCkFzIGZvciB3aGV0aGVyIHRvIGdvIHdp
dGggSEdNIHBhdGNoc2V0IG9yIG5vdCwgSSBoYXZlIG5vIHN0cm9uZyBvcGluaW9uLg0KQXMgeW91
IHN0YXRlZCBpbiBhbm90aGVyIGVtYWlsIHRoaXMgcGF0Y2ggaXMgY29ycmVjdCB3aXRob3V0IEhH
TSBwYXRjaCwNCnNvIGl0J3MgT0sgdG8gbWUgdG8gbWFrZSB0aGlzIG1lcmdlZCBmaXJzdC4NCg0K
VGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
