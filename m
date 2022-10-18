Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF7602119
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiJRCWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJRCWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:22:14 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2083.outbound.protection.outlook.com [40.107.114.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3800B8BB97
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:21:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7NYt2q9yxUVF2zCpiBIt5bWlmvBybgTzPHcnf55LkmiryAsTqyUM4AmY61Bukj4GktQOW2cCkGH12agZ1HkyDWP8oh2/tAZCEwHKsIHtkSzepH7dXN7UowZKIXZ1Hx+rKqfuMd5/bwchjtROjEYGYB2gqva9FsALydVeJOHbEmc4qVn0MG5UE069R2V4tbblwWXXz63o5TkTuHd6IfcGUqoQLKvV7tKlYDuRns+6iIUwL1EU/M/kmBI2s1rb0sc5ZIjDvQ3JSnOISrzF5CephEhUYtEtAjntSqPf08A6wNWp5GT2LWIL0CkLJucuXTq6xwyCBUEACHUHS2SPQFxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89AgmnQYbu8U3DuhMXGEzZEexHpuIvPMkAIOVDR5B8c=;
 b=N+xSSIZSHxRQQFMSElvL4F7AQ1nDhTwNqmPp+e5KJgwi0I1vKHzFpYobIT5vqfHyNNY3lS14rYXFepPWLx8BF9mgTRm8watQS7IFFllmaUVdn9HJBFqnbCMWfImwirwRE6w0WP9rg3yYoTDEhY6QWHvzeiXlVjft/KsLMdZAoIxRl9vf2+AAL5yEpsgZfSjknItjZdiPGQaoBh7wksjIjRMRrFhZFsw+9+p32ojKyYVCL+OuBi3u4VNzd1x5x0aOEdk4slg3VedJMQnBVPLHaF3KfGoPvMKFvBn4IjU5l56b762HLin5rjHdyEsqQgk4dZK4Ma3J0F6L9yYOKbCoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89AgmnQYbu8U3DuhMXGEzZEexHpuIvPMkAIOVDR5B8c=;
 b=nhrmuwatk7lEAkC7NROjUQA734WsvlFMw5yjRReoHybP/9wSRJXBHsv6+xlgW+cSq+4gz3YOD+pXHEnMrZgbfUHV9OeJbI3Y7We3Kz/3WriEOayQf50AJhq8y3MVfLUhEQa6pMfZEzzOIiLCseUHMc+jkh6J5knvRJ/XkUKWzeI=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB5998.jpnprd01.prod.outlook.com (2603:1096:400:60::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 02:21:56 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::9f34:8082:cd2f:589c%8]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 02:21:56 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Thomas Tai <thomas.tai@oracle.com>
CC:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
Thread-Topic: [PATCH V3 1/1] x86/sgx: Add code to inject hwpoison into SGX
 memory
Thread-Index: AQHY4nhoy072LzINSkiYMQXcm1DRhq4Ta9YA
Date:   Tue, 18 Oct 2022 02:21:56 +0000
Message-ID: <20221018022154.GA3732841@hori.linux.bs1.fc.nec.co.jp>
References: <20221017223305.578073-1-thomas.tai@oracle.com>
 <20221017223305.578073-2-thomas.tai@oracle.com>
In-Reply-To: <20221017223305.578073-2-thomas.tai@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYCPR01MB5998:EE_
x-ms-office365-filtering-correlation-id: 32cb727d-55fc-4b4c-36aa-08dab0af8776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GgSMOCccSYg5UT6WvhK+JMxtSjXNk2PSjb9K6flWJ0vjPwm1DmVLNSzJWp9piQDouH06lIOzML8yQzd6TDQOBZ7bljtdBx/UQZbjnvHN7eRTlwDhWc6Q4M5J6xhFkLuWbx+Kktr5pQx3cm/JPYyCovaDef072eZcrHMhHSXQzfTLxsrY911A/2FUiGjX2oLbj4XE1/YkY/ahhlG1qDD5sNxJQtJHdPRTeIGBoMW22C159NYXPXlrT2I4kRV1sbV1LJRZxwjAnXH1BPKZg8Na84x1AVxareUYIm60C1s/iD7uRhz3fqBx44+TmrCTKWoZXHBu73CGNMHR/TMca6AlVCy3pHTIZgVBvz70pmbdZcvP5ORdWV+b6kTQVi1TjFaWc0gFdhDMJahfN414e5eBG8u7cypNA8GYnZbXW072CgdKthfXwfqhK/nrXlT13bJ2YAC7fZlWhAfTlNnc8wdyzE6HX9jnlK6d7MIzc2OivT6ap7+geRZWjbVxOcesSMBH/Y1GZdQ9+hSgvyCDURyPJnGYJP2eg11sopdX7wkfKijqRsGs13B4x+j5ssBN8cxs4bT+bjhU4+8zMWLh5iAEceSG5AXaIS+5IGqxeTNwQZbmlbcuh9wzQBvtrjelfeGD4CO+8U/hLglFwAs9Pu9XvBmcf+RcsqKVNuaPlRkb7XyoqyOW0xrRdKvi+PO7qaKfac+ggmlpqv4eJ13STxCjJ8ehJk71p52glbO4u4A936QDRGdpP8aBIjTl0dlLjJC/dhv8/N7gw/phIfkqRgAEVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199015)(85182001)(33656002)(86362001)(82960400001)(4744005)(5660300002)(2906002)(122000001)(38100700002)(1076003)(186003)(6916009)(6486002)(71200400001)(38070700005)(83380400001)(26005)(316002)(6506007)(6512007)(478600001)(9686003)(54906003)(66476007)(66446008)(76116006)(66556008)(66946007)(8936002)(41300700001)(4326008)(64756008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUhGd2NrUWZ4bDY4dGdsUUdBZEtiVEdPMUJIbDJIU2hxMEh4ZVc5NXlkV1Bx?=
 =?utf-8?B?UTZVZGMwSzJDMzRYTjJFMW95ZmhISXh2MjVBUmlYRm90b1UyK3JxeVhRT0RS?=
 =?utf-8?B?THZ6WDI4akxnbjJzbVRicjFBV1gwendRLzEzbkFvUFRmZVJ5MVBuMWQyS3lF?=
 =?utf-8?B?N1FtOVFZRnM3Si90dk9EVXhQR3VDZHdEWkRoZHhQNnRQTGtKdmF1anAwNVdj?=
 =?utf-8?B?UnBXZlN6OHFHa2lwMzd3UzFFTmp1bm53WXdIMlZoN3AyUkhYcGMzU3RUWEtK?=
 =?utf-8?B?UDQrYmtwQXNud01LMzhUQnJNZUlVamkzTEl1ZHR0NDgyYk5aOXhBOWErOHNN?=
 =?utf-8?B?TS9uMTRnQWZFcDZDSDR1SDU1eXRGOEhQYTJkdURncC9YWFg0ejlUQTVnRXVv?=
 =?utf-8?B?UXI4VWhRWHhSTEw1N1RNQWZubkRnZ3l4Y2JMTll0eTRsOVFwemVFUzNCZjRy?=
 =?utf-8?B?RHZHTGFoUzNEdGwvWUpzVkFYR01NS25iZmU4MnhybnZEcjk0MHYrV28rMU5y?=
 =?utf-8?B?bXBDS2gxQXA2a3FKRjVRTVdzOTJ2dGNPOTJUVmt4Z3hJWWJMdHBSM0w5aE51?=
 =?utf-8?B?bWhzSkUycTJqcVU2cExyMVUwQXFvTUdleEorTHdFZHF4eklIY1J3ditWakUx?=
 =?utf-8?B?WUxOZEd0KzlXd2ttbHZYRWdmWktRbGNTVTR1ZXBRNzh6ZGZTVmJFWXROS0pY?=
 =?utf-8?B?MXlmQlhkbHpMQXVZREN5STlJMVIraWk3bFNKeHlCa3R0eEhVUUtMQmZOTUhP?=
 =?utf-8?B?NlRmNUdRQThyQ3BtRkRjSHFudjRvdlB5YUJxbG5aQjcxNUNoVXduaEtQbGdD?=
 =?utf-8?B?SGw1SFpWQkJQUE1vWGVvSkd6U3o5YUU5M1JuVTRYY3Fnai8venJTQTlLMEhF?=
 =?utf-8?B?UzQxeDJDM2xTdFZON1k1UjNDYUN6Ri9FcmVjTGczNm5SMEFGdng4cFhkZEtH?=
 =?utf-8?B?Y0crNUwxMDlWWXVialpsdVMxWGdPVUo1K2VXUGJZU0x0a1pjQjJOSC9heGlM?=
 =?utf-8?B?TmhTWjVlalFLQlp3L2FrZDJ5Ym14eWQ3SUNsZzlQeGpOOW80U0VXSWloTnE3?=
 =?utf-8?B?NTRUZHZ0TTF5dzNxai8vYUxjOUpRRHArUlRGbTRZOTJhUTczQ2RxY0taMGx2?=
 =?utf-8?B?MnltSUtPSWsyTXZWMU9Dbm9PS05yVnBOak1ZSUZJT0xkOUNOdndWVVpiSHdB?=
 =?utf-8?B?OVk5NXAxMVpLUmZaYTBhRzNmTHo1MVZhVlJ4NmhEMCtIL3lDQlova0xKRDVh?=
 =?utf-8?B?UjRtb0FmaGZzam5qV1ZvTjIrYU9xOGFyNmQwa0JFNzRnbjFqVWpINzV0alJ0?=
 =?utf-8?B?OHpsWDZGOGNOYjVJOVluaWNrek51NityUUREcGNEYW03ZnNWTHRISGtGNGhh?=
 =?utf-8?B?a20vVDlIK3RuYlY0KzkzZk92YmhRaTdTVFhTNzV6Z3U1MHk0ak5QZGlEM2Fs?=
 =?utf-8?B?WmpKc050Tm80YlZoNE5CQzNCRTYycnVLRzVUdUFvR1Y2TWR5V1Z2WXdDOHJB?=
 =?utf-8?B?UlRDL1dXOTQ0bmxVbWVKbStjWG82UXpHWi9PbURTbitVcTVvb2RuTk01eEpk?=
 =?utf-8?B?d1BWeTV5NFN0VW03Q1dzRStURzhYYlNLSUVKMUtHWE9VSHdhVFVDallaMW9t?=
 =?utf-8?B?OXQyWURoY2gwZGNOdmRtbTBxanVrMUN3bDB2T0Y2dGlLbmUzVHVXdGZ2YVd0?=
 =?utf-8?B?enVNbm8yek9wSUdlSlgrNHJJWVJOR3RjNEhPYys5Nyt5cjNBVFYwOTIxYXBS?=
 =?utf-8?B?NjE5aGk5NFJFL3ZvWXZ2UjhJejYwNU9XV2o5cXZWVGl4cCtZQUU0WWhiZXI3?=
 =?utf-8?B?d2RpRkRxQUlnVGFSRXJ0VmRTM0F6MVJUa25ESS8raUplYXR5VnpOUjI1M1VS?=
 =?utf-8?B?V1BGZWpXaVY4bFRRT1Y4ZFpIUGVxSVhBVk00UEN0ZFZhWDQ1RGVwSGtmYXpG?=
 =?utf-8?B?WG44bWNFb0t2OWNvOUhCdGFGQjZvTVA1L1VNNE11dDc1NmtIWXYrVSs5VC9l?=
 =?utf-8?B?RkdiRitmMS9MOHpzRUk3LzNzWmVNLzRKTHNhMzMwS044SVpGTXVFcmgvQW5v?=
 =?utf-8?B?Y3BDU1ZZZ1dkZWZzdDNMKy95R2VJTS9zcTllRXZRVGJEUHdSdng1b3RQUE0y?=
 =?utf-8?B?eXpDZ1Z3MmtpQk1VcVVEWk01eWhoYVd3bzdnVmtRQ3JWV3AweHVrT01UUXhC?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <588DA3E202627149B9B1169694909249@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cb727d-55fc-4b4c-36aa-08dab0af8776
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 02:21:56.4314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmGrKi22oMiLTtdfrKw4YlSYRVOmowli7WPU0sKpOLMw/km5uq2cxXIa4dJmY4WHvp08gsHu06oAnfwxI0dfXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5998
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBPY3QgMTcsIDIwMjIgYXQgMDY6MzM6MDVQTSAtMDQwMCwgVGhvbWFzIFRhaSB3cm90
ZToNCj4gSW5zcGlyZWQgYnkgY29tbWl0IGM2YWNiMWU3YmY0NiAoIng4Ni9zZ3g6IEFkZCBob29r
IHRvIGVycm9yIGluamVjdGlvbg0KPiBhZGRyZXNzIHZhbGlkYXRpb24iKSwgYWRkIGEgc2ltaWxh
ciBjb2RlIGluIGh3cG9pc29uX2luamVjdCBmdW5jdGlvbiB0bw0KPiBjaGVjayBpZiB0aGUgYWRk
cmVzcyBpcyBsb2NhdGVkIGluIFNHWCBNZW1vcnkuIFRoZSBlcnJvciB3aWxsIHRoZW4gYmUNCj4g
aGFuZGxlZCBieSB0aGUgYXJjaF9tZW1vcnlfZmFpbHVyZSBmdW5jdGlvbiBpbiB0aGUgU0dYIGRy
aXZlci4gQWZ0ZXINCj4gaW5qZWN0aW9uLCB0aGUgYWN0aW9uX3Jlc3VsdCgpIHdpbGwgcHJpbnQg
b3V0IHRoZSBwYWdlIHR5cGUgYW5kIHRoZQ0KPiBhY3Rpb24gdGFrZW4uDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBUaG9tYXMgVGFpIDx0aG9tYXMudGFpQG9yYWNsZS5jb20+DQoNCkxvb2tzIGdvb2Qg
dG8gbWUuIFRoYW5rIHlvdSBmb3IgdGhlIHVwZGF0ZS4NCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmln
dWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+
