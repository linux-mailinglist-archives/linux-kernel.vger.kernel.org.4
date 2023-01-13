Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5DA668EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjAMHT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbjAMHSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:18:39 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2062.outbound.protection.outlook.com [40.107.114.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA3E8BF02
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:03:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6jos/76X8qX41DHbCmdRddRKPsTomoE3rJDKKd6juh7KU1Wz1DgyTj0nBKUHGSYiSeufJTmQyhjKFvo0NCDYCOBC4astSnSpaSoqnI9WVQGtgxcfLzDD/RIE+0eNdWXztJFB4bGmhKf4X7+IOh86E+ixLF7zNi0auOk4iNG2Q4Mz/lN9HI4xp9y5iQdCK4rsoE5aeNnXxru08X8yPKg6/3BtfTL56Q3Se2NY/xXI5TFkPqQzoNVSYUT/dHsCJKITUXJAcO8wn1qrc/VmYiXT8Tru//mAXNYuuI4tZ/BNRZPBGVXLtESIwxFO3BhV7yhYY10oPHUAZlCjoka8zwKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOOxfFJiNvD/I4YXimlSH+SygY2P1ISBqroaFp1jYDg=;
 b=gJ0kES+TH55j9D0svmhVy4c7oEqzn1PQmJfJXybbotCXN4QEHpBexOZEIRz+lIqvKJ++ZQtZZGW78hDQKOlYfCg6+yd7J01JRPsBBAaQ2RBulW34ZcNMIXAZ+t/s0gqrOMmcZTHlevaqevzofJVmct6HaUyPjQM/plx+TW4Jt2Clrko4LlGkyJ4OoZa7sZeaOLBMDJEPpKkhDeAavOq81OVnEv56M7h92hiFrBt0V4J1WdUzbeJt5obI5WfFCtL+7tfiVo/1KhyLDnYbI0VjSx6676VAVijuMRTlWJFww5hl0BIc0wzhQ+l+fEUP9iEbZ5Op/5/Z9hVB0O0FUCni4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOOxfFJiNvD/I4YXimlSH+SygY2P1ISBqroaFp1jYDg=;
 b=Cxzgvze4DAuCWbp6/2a5fb0/tRhUBEr85gxC9NXSHij7kAQnqL7BwtlArfIrnU2C4YnmxLGKAq98dHnvso66YkzUsnd4nlAxCYhevpksi42L+O1p6GWb7JARygkCcHcGT2DP6zLyf/sHS25XyWJcmiBGpbnWzeZKQspkISVQjKE=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB8692.jpnprd01.prod.outlook.com (2603:1096:400:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 07:03:09 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::f495:bf26:717c:c45b]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::f495:bf26:717c:c45b%3]) with mapi id 15.20.6002.012; Fri, 13 Jan 2023
 07:03:09 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH mm-unstable 0/8] convert hugepage memory failure functions
 to folios
Thread-Topic: [PATCH mm-unstable 0/8] convert hugepage memory failure
 functions to folios
Thread-Index: AQHZJscFPQoioGq/B0ev5KIxE+oiqK6b7IMA
Date:   Fri, 13 Jan 2023 07:03:08 +0000
Message-ID: <20230113070244.GA3264625@hori.linux.bs1.fc.nec.co.jp>
References: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
In-Reply-To: <20230112204608.80136-1-sidhartha.kumar@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYCPR01MB8692:EE_
x-ms-office365-filtering-correlation-id: d0a1974b-f9ca-48f8-c8aa-08daf5343a5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MT93l+jLX5PG2E/YDz0essLc9Au58sAkEpTezm2J6/zXV/S+WuZlaRzOI7exSnfWoyq+Frhl00dPONHhws4jzNekwOfN7lFf3wY20wStz1pdyInfimDaEigb1JeYNuDO7ohRA6GwAYqmtlQZwY7RuElHWL82qqijHU4ufiQIe/Xo//Z/m6mdYoy2Nof9/QQOJvsVGnT+rLq6Z5Hcx3NygRQBqHTIur4S81t/LaS0Vmh6RVVghXLlhQi0xvzkjwDhmu4xLcYuC9Au16zrEPeeolVd7ifRmY/jwQi4YsU4TluoCPmraZZCTIhsov+gUNtl77hoOt2mCvEACqPlCwkQV3c6/Kqh3a36WpT1hwHrktYkZRJw2yUXuCqhFiEg/kUEuV0xN91Nu2oUIlSnw78ZEqq8o49U6RUXAd0F714ryw5YRwZKbgANQ4H3fxiENqbIhcdnqGV8giCdCj503IliWYBFRTn257Q4TVyQqCI2/+qR2+RLpoXQYtcjqfoDhBfg/qunnvUu9hCzvFkT20GuvIFoO45htcN1gdbgUTfO2/C6m8y4ZpPriHO2HXVzq4MyquomI6qwyoo6LKlLdDz32jISo/KjwN3MzFBARsXFZePylt1AkG32LHAzLfbU8GTG2aafKfcHSvB9mTIsTEryQIo/oOr4ghFbSFUS26Jal40/wMQ6pzOax9Sivju99nsj1CV1L2r8YTOt1s+foA4zDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(6506007)(33656002)(55236004)(6486002)(26005)(9686003)(186003)(66476007)(4326008)(6512007)(316002)(1076003)(64756008)(6916009)(478600001)(76116006)(54906003)(71200400001)(66556008)(122000001)(38070700005)(86362001)(82960400001)(38100700002)(83380400001)(66446008)(41300700001)(8676002)(66899015)(66946007)(5660300002)(85182001)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cm1jeE9DSCs0ZDFJTEhQNk1mTnVINDdXYkduK3U0TjMwSnhaaS9JVmRlaWVP?=
 =?utf-8?B?ZG8rd1dRVk5WemNia2lwVTQ2WUxISmFiSFJZSllHSVUyTWQwcnFzZzViekQz?=
 =?utf-8?B?Slk4NUpNRHZsaE9FZG1WTjB5MkpSbWVia3ZSRWNZZUFTMnl3TTc3RHA1Q2dZ?=
 =?utf-8?B?ZlhBcDA1Q1EyVDJTOXFVZVZZTkYzVi9Xd1NHU2RqQm8xdElKL0VUbWVNNGtD?=
 =?utf-8?B?aFh0YkNXMjA5ZkwrQjQ0S1hWbmVncXBkWHY2clhuZVRxZjhEQzh0V3BCUVo4?=
 =?utf-8?B?WkNEMXNXcVRjYWtqQW5HZjF0QWpNU3NuTlF6Vm9NbHFiSGtJc3BScEoxLzMw?=
 =?utf-8?B?UUt0L3ArcW82VHNudnJJN2V4aHJLbE9kcG50Sm9jeGIzOXBVNlE0Q21aNHNx?=
 =?utf-8?B?TVkzc1FHMmFLY1BJb244bU1Tbk1HZWo0M242bmhOMmswQjVRY2owdFo0cVl1?=
 =?utf-8?B?K0dBT1Q5Rml4TFJaZnVnUUgxVVhRQkw2RzRSRjJ4dDR2RUwvQVJnR0xENVN3?=
 =?utf-8?B?WGFzQjVheDdPQTRhS0NZT3h2ekJCV3VDdnVEdUViMERGZTA3Q3ZxaVY4TGhq?=
 =?utf-8?B?eXZubFFGWTJUOWdxN1cwNlVibmJrckxQVUtINFFidEJ0MWNUdTNlZGxlMzVq?=
 =?utf-8?B?WjQ3cUVQNnZwN1pzODhxWXBtb3NtUlhMRWwwSDIyeDRtSXMvOXpPT0RiWURw?=
 =?utf-8?B?T1hGcld0bW8zUGlzRE5rSGU4TDNwcTlwRlFRVkJ2NXFtajA4MlNhNDk3Q3J3?=
 =?utf-8?B?RVhyMVFUbmtHR2Z6YXF2a2RUTkFqTVRaWjRoYW1YN2YxNUdGZEFjdDM5dHVH?=
 =?utf-8?B?R0E2K0pmQUt5bDMzenBabnU3UmZsQk5nMlhYT1hMYXJEWUZ4SjJtSFN2Uzcz?=
 =?utf-8?B?Y2dod1JnOWFiNzFPbEozU3QyUTMzcUtYSkh5dVdXQ0piTkUxTHlVSmt1MGlM?=
 =?utf-8?B?OU5SSk9ULy9hOXNoUW9zSFNlT2F0blN5L1BrelhveTRSYzVzNXNNWGpsZS9U?=
 =?utf-8?B?YWxlZ042di8yQmtlZUhxTHVhTXNGNytVOXRBWTRILzl0UDQrZnUyN2VxWUYv?=
 =?utf-8?B?bXdrOGpTeWsvckpGYk1EL1JTL0Rwek9sVExORjNSRkdLTkhQUDhNdFFGcG1t?=
 =?utf-8?B?WWFoOThDK2xOTHRyTWUxaVZnbEhDckwvWWtHdWdIMHpBUjNtd2VpK28yVmY0?=
 =?utf-8?B?TjlDNEhuOGg5dTVoL0xqa0w1dUl4Q1NwNWoyMk90REhUZTRBSFF2YzVjMlk2?=
 =?utf-8?B?b1o1Q0MvSWtXV3A2WVdFTys2Uk9nQW13dEtmaFRvaDB6VkpHZWRWNnNzYXN5?=
 =?utf-8?B?a1NCbUorL0luRU5wMFhOc0hKeml4ZlNsc1laOHpybnd6cDdERGRZZDVoUC9N?=
 =?utf-8?B?TXM0TDlhMjgrQlh6eGlOOVAreGxqdXlxQnlyUFhrRXg1VjVBcWdlVHpZdnhh?=
 =?utf-8?B?YjcyS1JMZklsd0o2bVdiQ2VSQ0FZeFZCUld0RWRkM2xSallVZEpyVjY3dFh4?=
 =?utf-8?B?d1h1blNrNkJkd3VVa1ZWMCtqWVlCanRlZm1PN3lzbWFYYXo0Z2R6ZXNmME9J?=
 =?utf-8?B?RHd5SUI1M25XN3hKdVhqS2I5azk0UEpWZzVzR3kyNERrRjBrMDlKaXcyUmdC?=
 =?utf-8?B?MWhIa05SOVdDRXJobGRrL21NcEtGcmRLeTFQQXdTQ1RsV0Y3K2FvZWtWUGdx?=
 =?utf-8?B?bG91SFowWks2K2hXVHhBQ0QrTzdWWk1YbVVoMW40R0s0MGZvZEs1djROSW8x?=
 =?utf-8?B?a3ZZWGxPVGI4YnBXam10YytWMkY0WnNSa2krN3Zud3lCWVJCRUNDOGZtdFlU?=
 =?utf-8?B?bDl3VXFtekRRZFFUSVpGTW9GWjJWWDltK3NOWGpVNm1PNUNQRDhkTVhMMmVW?=
 =?utf-8?B?VDNWVTVidm9xeWdiRHc2MnY5VzMyQ2d3NXJ3STI4TkVPSXVtZUE5S3ZXNEZ1?=
 =?utf-8?B?dk1xZE53K0ZIR0Z5VlpuRThYWlNhUmJ0bFVXcithOENlQTYxS29hL3VTblBL?=
 =?utf-8?B?QXJiU2xKeWdDYVJDcG56NjlWUWxra29zMDd5Qkljak1JN3BxOWJPWlRWSTlH?=
 =?utf-8?B?OWZUamoySFhJNnNpRm50NDQweTVBZEVSMDliaVVod3VrMzBkQzhFaERHTXRG?=
 =?utf-8?B?OUYxbDNkbk00ZDFwVFlnTVJ0Q3d1VDR3VWxheW9MeTdNbi9acjFrUjNOMWQ0?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DA5A5A2E623AB408F9F4E65AE0043E8@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a1974b-f9ca-48f8-c8aa-08daf5343a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 07:03:09.2076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbK0PsFmGLOdfbacZp4HL59NJ98h6LTWNBggvmNlACDAMVks9d7o1S7NUPG4bxbTDSG2uTsFaNnNMYAJ2+5vwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8692
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKYW4gMTIsIDIwMjMgYXQgMDI6NDY6MDBQTSAtMDYwMCwgU2lkaGFydGhhIEt1bWFy
IHdyb3RlOg0KPiA9PT09PT09PT09PT09PSBPVkVSVklFVyA9PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gVGhpcyBzZXJpZXMgY29udGFpbnMgYSAxOjEgc3RyYWlnaHRmb3J3YXJkIHBhZ2Ug
dG8gZm9saW8gY29udmVyc2lvbiBmb3INCj4gbWVtb3J5IGZhaWx1cmUgZnVuY3Rpb25zIHdoaWNo
IGRlYWwgd2l0aCBodWdlIHBhZ2VzLiBJIHJlbmFtZWQgYSBmZXcNCj4gZnVuY3Rpb25zIHRvIGZp
dCB3aXRoIGhvdyBvdGhlciBmb2xpbyBvcGVyYXRpbmcgZnVuY3Rpb25zIGFyZSBuYW1lZC4NCj4g
VGhlc2UgaW5jbHVkZToNCj4gDQo+IGh1Z2V0bGJfY2xlYXJfcGFnZV9od3BvaXNvbiAtPiBmb2xp
b19jbGVhcl9odWdldGxiX2h3cG9pc29uDQo+IGZyZWVfcmF3X2h3cF9wYWdlcyAtPiBmb2xpb19m
cmVlX3Jhd19od3ANCj4gX19mcmVlX3Jhd19od3BfcGFnZXMgLT4gX19mb2xpb19mcmVlX3Jhd19o
d3ANCj4gaHVnZXRsYl9zZXRfcGFnZV9od3BvaXNvbiAtPiBmb2xpb19zZXRfaHVnZXRsYl9od3Bv
aXNvbg0KPiANCj4gVGhlIGdvYWwgb2YgdGhpcyBzZXJpZXMgd2FzIHRvIHJlZHVjZSB1c2VycyBv
ZiB0aGUgaHVnZXRsYiBzcGVjaWZpYw0KPiBwYWdlIGZsYWcgbWFjcm9zIHdoaWNoIHRha2UgaW4g
YSBwYWdlIHNvIHVzZXJzIGFyZSBwcm90ZWN0ZWQgYnkNCj4gdGhlIGNvbXBpbGVyIHRvIG1ha2Ug
c3VyZSB0aGV5IGFyZSBvcGVyYXRpbmcgb24gYSBoZWFkIHBhZ2UuDQo+IA0KPiBTaWRoYXJ0aGEg
S3VtYXIgKDgpOg0KPiAgIG1tL21lbW9yeS1mYWlsdXJlOiBjb252ZXJ0IF9fZ2V0X2h1Z2VfcGFn
ZV9mb3JfaHdwb2lzb24oKSB0byBmb2xpb3MNCj4gICBtbS9tZW1vcnktZmFpbHVyZTogY29udmVy
dCB0cnlfbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYigpIHRvIGZvbGlvcw0KPiAgIG1tL21lbW9yeS1m
YWlsdXJlOiBjb252ZXJ0IGh1Z2V0bGJfY2xlYXJfcGFnZV9od3BvaXNvbiB0byBmb2xpb3MNCj4g
ICBtbS9tZW1vcnktZmFpbHVyZTogY29udmVydCBmcmVlX3Jhd19od3BfcGFnZXMoKSB0byBmb2xp
b3MNCj4gICBtbS9tZW1vcnktZmFpbHVyZTogY29udmVydCByYXdfaHdwX2xpc3RfaGVhZCgpIHRv
IGZvbGlvcw0KPiAgIG1tL21lbW9yeS1mYWlsdXJlOiBjb252ZXJ0IF9fZnJlZV9yYXdfaHdwX3Bh
Z2VzKCkgdG8gZm9saW9zDQo+ICAgbW0vbWVtb3J5LWZhaWx1cmU6IGNvbnZlcnQgaHVnZXRsYl9z
ZXRfcGFnZV9od3BvaXNvbigpIHRvIGZvbGlvcw0KPiAgIG1tL21lbW9yeS1mYWlsdXJlOiBjb252
ZXJ0IHVucG9pc29uX21lbW9yeSgpIHRvIGZvbGlvcw0KDQpIaSBTaWRoYXJ0aGEsDQoNCkkgbG9v
a2VkIHRocm91Z2ggdGhlIHBhdGNoc2V0IGFuZCBhbGwgbG9vayBmaW5lIHRvIG1lLiAgQW5kIEkg
dGVzdGVkIHRoZQ0KcGF0Y2hzZXQgd2l0aCB2Ni4yLXJjMyBhbmQgbm8gbmV3IGlzc3VlIGlzIGRl
dGVjdGVkIChJIGZhaWxlZCB0byBib290IHdpdGgNCmxhdGVzdCBtbS11bnN0YWJsZSwgYnV0IG1h
eWJlIHRoYXQgc2hvdWxkIG5vdCBiZSBjYXVzZWQgYnkgeW91ciBwYXRjaGVzKS4NCg0KVGhhbmsg
eW91IHZlcnkgbXVjaCwNCg0KQWNrZWQtYnk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1
Y2hpQG5lYy5jb20+DQoNCmZvciB0aGUgd2hvbGUgc2VyaWVzLg0KDQotIE5hb3lhIEhvcmlndWNo
aQ==
