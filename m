Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24E65ECBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiI0SP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiI0SPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:15:39 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11010005.outbound.protection.outlook.com [52.101.51.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE8F67442
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM0XUD3ew0GlOwi55qGdwx6BPljTA5p9s5ud+ghEbfT7imKDGYr/QZdf0iHd9wvSsHz4Tjwy7QFa7MgTdvyseDqke+u5CuMVBMtILJOS1lO0ZcSMJSMtBpmjq7AUTE7t3qDTIPwgQn3O6r2I0tdAgGVCJDMwlLMxBXe0aVd7xilHRPQV2B4stk76WfsmQVXjxhBShOBu9buVeG5scprE8wFE2UwxW0WkBkMWAQiDUmJN1MmvvNC4Qx1M4miawzkDdzORr5C1SC6i5z9fcplFz44zeahMma09zESio75C4DWmdB9HxUw/fXSVz2Er/LL75aSJ4qf/7Umbagg2PCwf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bxCK7+gGUkC0BSiWu2w72P8CeZlTD5X47sjm3Zy5lQ=;
 b=J7eb0c2TolENyCgM3wUDSZjAqjPusKoIoexuF18D2rqzHW5cQly/wk6zpTm6m5fpAPgGjFM4QD3iDh9UzqVr1IvHtYNHtJI3VGSCegc0nKUYN6g8ox+VJN4KZfhS/zIH8A65m1onjcIiQJ/r7I6Dv6grmhtteThn0g9kH2QiH5ah6iPEmEcxjMMBuDULL22nXw3U/sYn4qMVMFNMBbYXlzc16NnXmrvZEi1Mt/jgUymkE5GYTx94ko4ZvqgcVpvTprxA1p7SY8c02kNSB6M9caWJKAVccyYOQTuEfFN8lGGOYtEJbHMSJW2+MIObF0IUEKnpm0ADXcyaPb4rLMOQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bxCK7+gGUkC0BSiWu2w72P8CeZlTD5X47sjm3Zy5lQ=;
 b=v3jRj0xGVGPsSbLWTKWpuS3ox1gY6mL8/JAicCJJSzgJL3XQQjy5RFOcObi4mZO8jfesmy9ddQTtqALH1dJG3EJHuXqF2KT2f8D/PWTmKHP83reBLHCfAk1C8FurPJHct7hUNV3l2p0zs8SuBhb6U78LTE7hitkS46Z1RZCE3h8=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN3PR05MB2433.namprd05.prod.outlook.com (2a01:111:e400:7bb8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.11; Tue, 27 Sep
 2022 18:15:35 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%5]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 18:15:34 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Chih-En Lin <shiyn.lin@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [RFC PATCH v2 7/9] mm: Add the break COW PTE handler
Thread-Topic: [RFC PATCH v2 7/9] mm: Add the break COW PTE handler
Thread-Index: AQHY0o4u7sJ3OoqXUEeBdcbNckfUOa3zlSgA
Date:   Tue, 27 Sep 2022 18:15:34 +0000
Message-ID: <8F98262B-206B-434C-88B9-9F3A6919782D@vmware.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-8-shiyn.lin@gmail.com>
In-Reply-To: <20220927162957.270460-8-shiyn.lin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BN3PR05MB2433:EE_
x-ms-office365-filtering-correlation-id: 0335d595-26db-4ca7-1398-08daa0b44598
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3IoGXurnGy2E68Td8gN/5j8y0yyIbDqQ26KORSG6pfFRTyiZjY5pGSd0ZwUvtVMr1zk6IPiyClnceNZNfVgqGd42TBLZBDcSEnrBmr/I8pPRUoBXEY+USGShylyGHYQLJZrdImh+UNFyl8e96AdMKVqtVoU5yl+RKN29wQzf06ZsmD2svTOxvuXPSc53dTiJJdPhlb73upx2AYRurgRt682d6KzKvmxoAyikzK3P1s5Jq0fG69CvIuMICmQUPArz8Dox7OlhfgYVayPddGkWXxsXSlLA83FLafvthRkP9k9rPJ/gDEQ2mWxbe/VvMlF8xs/1DRrCHItQiMg33EbR84PsrR9qlf7la/LAD074H1LSoYHGrBD5xUVDyPC/Wvg3zxhaUjBS6PK7veUaSMG/0yqE89ah9tG4ju1PpzKD25G5j/E97xumHGaJNuiI/6yINPEOEQ8lHWRv9oY3htVTtD18kMAcd0GYXLaSGo/Ok688ttS8imL4c1m6MzDimSc3obpD0JqmqyT5wUzE72W/2NJizXSkKO5LyuMrNOtJkUFZXrJ0UZ0GIuo4kR5gFKZLNtqINxtcpbMHXJsjxp/ZBIOU+zntKUTcoxR4NrtlVqPRkDY/suGVraAp+ru+muuwazWnEJeaWGzl+m1Inm53h3kmaml+dCanPQG80wm03yTAbvUxJAEpFU3Ppx8ZTnLsaFnHlSvKNu+PocN2UmGB8wfDUPLmIIWoYA4jPkhzL1E69ckz5V/7bRHxNdKU21gTkfD5qsnLkT09idJfibGWmOqHjK3n4iU3iz00EPiPWoBONqN3CziPLnVoX+AhtwGblKuCDH4RNKQBTbGbZ+1qvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199015)(86362001)(186003)(2616005)(122000001)(38070700005)(83380400001)(316002)(5660300002)(8676002)(41300700001)(7406005)(66476007)(66446008)(64756008)(8936002)(38100700002)(7416002)(66946007)(4326008)(76116006)(2906002)(6506007)(26005)(71200400001)(53546011)(66556008)(54906003)(6512007)(6916009)(6486002)(478600001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1BlRjQ4VEpQNkxyTDJmUjJscHVxTFZSMWdXc09aQVNZMW5GMEdmNDlMZTZ5?=
 =?utf-8?B?UzQwZ1J0bXpCV3FtZjZXUTBoZGVjUHJja1JSQmw4ekVJUXI5THlML2NtSDJZ?=
 =?utf-8?B?c016VnZYT2ZQcndZcDF4U0xQY0szMkU4WUt0L0NjN2o3UTZucHdMM200NENP?=
 =?utf-8?B?M2pCRHZkRkxyaEFaRWU3aE9pWEwrNTgzWGl6L0FFYjVvaGtZeUZGeFpzV0p6?=
 =?utf-8?B?ZzRycnI0akhyY2kzS1cwQms0d2RZOHI1ejVFcHlHc0UzdkpnS0RtRG85a0c1?=
 =?utf-8?B?cFJUWUQrZVM1aW4vVUFrT3oydkd4Z1prOFkzZEROdU5Jc3JmM21CQVVBanpY?=
 =?utf-8?B?a21SQmhXSTllREwzbnJYMUVaUlFjWGtaZjVrbUUxZ2J0NTA0SnN4cGZMeVE5?=
 =?utf-8?B?c3cwMmNva0JHeUE3R3ptZDBGMEhoempuOUp0amRNUkhxb0tzR0RROEpmR2M2?=
 =?utf-8?B?anB4bzFIUWh1RXZWcU5uSVROdVZ3bGthbDdjSFNJVmg5M0J1Z1JUUDByRUo2?=
 =?utf-8?B?cTQ5QTI3Zy9iRkxtQmtxSHpyVU9rbXBtamxBNndpODQ2RHhuVU4zUjFUYkpW?=
 =?utf-8?B?d1NrbXBIbzZTdmNGejdDOEJWUUhWMEZIR2VERWFlNGl6WnhMU3EvV0ZyRUR1?=
 =?utf-8?B?alVNbUR6K216ckYzeGRLcVM5WkhqY3owUmNvU0RVZmVrNkx6WTVBQ3BlU2ly?=
 =?utf-8?B?WnNUVEhOYXh1NVNzb3AycDBSK1VFZXhKalZSblZBYTgxRWg1a1owSHVITWdK?=
 =?utf-8?B?WmdtYVB6bW1mM1Q2YjJHK2tVQUg5cXVnRWJEMGVRRjdJcDZiRnpWWjBLbnRi?=
 =?utf-8?B?dkpaYUorK29yMzJBMytHYmJkVEIrOGZ1OFU5MGlqZTNQRUlYNzcxVWVzTUZJ?=
 =?utf-8?B?aVBDcDVQL2hxTFE2b2dFdkV3aUZLd3NhSmk3aHVaMXJVVmtxa0xpVHJWVllh?=
 =?utf-8?B?YWtzZ3VYZFpyeVB5ZEtmQ2RKaTRsUmprWnhiQ1BZN0Iyanh1SHpkRmdGQUVV?=
 =?utf-8?B?OFJaZEpGTGtnck9TaGZIU01NNkkrL2kyMzJYYVBHTFpQTHlFM2xmWmlEQlBr?=
 =?utf-8?B?eCtvTkYyT2hOL1Jnb3J3K0Fwd2R0SWYwV2IwMGpucVlrRkVjdjdINlJWWEor?=
 =?utf-8?B?bWdScHM0Y3ZNd2VIUzFSaDlBQ1Z0Qm16VU9PbUdRaGE1YlpvazloQk5Wd0xa?=
 =?utf-8?B?YUdjdFFoSW9GaGQ4NGVVQjhxeW9TTFFyZEtkTFhwL1BEQzBKamdRU0JwT2d2?=
 =?utf-8?B?Vzk1Smk3YXRMTXNzYnlaOW5OQlpNNDJRMGlQc0Noa3ozM3UzOHlWWUZZTlJL?=
 =?utf-8?B?VHFvUFY1eWRDZHlFMlFseXJQcjlaUkQ4ZFRSY0loQUxkbXpXSHcydFhnaVRC?=
 =?utf-8?B?a0pRL05DSlBuRlZNSWFRRmFocjJlcnpPaXEwdWQwR29uVHlwM25CcFl4dWpl?=
 =?utf-8?B?UVZxU1BUUTh5b2haRkNaN0Vxc0pPRWplSkpSVjczVFRpUnZua29yWGdNN1JZ?=
 =?utf-8?B?aUVjdUZ1RVpqWDFUd091Qmd1Z1VLcHArT3pmenFHa0NjemI4TEJQT2NRbTRo?=
 =?utf-8?B?ZzBoMThjMFhtdlZsTGJUcmJMTlJpOEtkUmxwNEduRUZVMk8rdnVsNk03R0Mv?=
 =?utf-8?B?ZjQzY2xqcGlGSnZQbllLQks4S0RSNTBoYVVDMUVPL0JjbS9tSlY4eS9UaFdw?=
 =?utf-8?B?bWFWb21EOHNNYjRYTGtjZzBwcjJld3pSd1V5eDFnRzdvRHg0N3lPellCS2hp?=
 =?utf-8?B?VGZuSjdzVmMyZXo1WWh2SkFobVlXNVhWQjRSWWVYWXZaREl2bzhDSERBSm1y?=
 =?utf-8?B?SEtvbmd4OEd4VVQrSGZYU3BQSCtOWWlxcGxWeVJGLzZiOFRJSUxGYkg5ZWYv?=
 =?utf-8?B?NzJ0NDBPL2IwNzBsOTlaR1B6YWkyZjl0bVdMUjlSLzN0MzQyQ1dOeXB4ajFG?=
 =?utf-8?B?Sml3UnZndGNnbDRSN3lhVlF6eVcwVDVYQmJ2UG5zUVVGZXNCRFhNT1RjcjZB?=
 =?utf-8?B?TnJ3VUg0QUVPWk9SZVRSVlFKNkhNc3ozYVhiTFNadkdnckZZVGJsdDFxUmY2?=
 =?utf-8?B?VmU0VElRWHROejkvdEduM0ExSXVFQmEwN0M0UjBCRnNOd2RaclVySGJvTU95?=
 =?utf-8?Q?MLIIlzBqlbjHZJP2PeMCyDrL1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BE3AFFE78C20743B8B489D29054830D@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0335d595-26db-4ca7-1398-08daa0b44598
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 18:15:34.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omnI7JNERD+qBdf08fZ54Wz0Wwy28WTYbI7GZrdHgNxOXsyIkg8cGlO7mGHizP0KSnnMPcBOtapAaL2JKae8tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR05MB2433
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2VwIDI3LCAyMDIyLCBhdCA5OjI5IEFNLCBDaGloLUVuIExpbiA8c2hpeW4ubGluQGdtYWls
LmNvbT4gd3JvdGU6DQoNCj4gVG8gaGFuZGxlIHRoZSBDT1cgUFRFIHdpdGggd3JpdGUgZmF1bHQs
IGludHJvZHVjZSB0aGUgaGVscGVyIGZ1bmN0aW9uDQo+IGhhbmRsZV9jb3dfcHRlKCkuIFRoZSBm
dW5jdGlvbiBwcm92aWRlcyB0d28gYmVoYXZpb3JzLiBPbmUgaXMgYnJlYWtpbmcNCj4gQ09XIGJ5
IGRlY3JlYXNpbmcgdGhlIHJlZmNvdW50LCBwZ2FibGVzX2J5dGVzLCBhbmQgUlNTLiBBbm90aGVy
IGlzDQo+IGNvcHlpbmcgYWxsIHRoZSBpbmZvcm1hdGlvbiBpbiB0aGUgc2hhcmVkIFBURSB0YWJs
ZSBieSB1c2luZw0KPiBjb3B5X3B0ZV9wYWdlKCkgd2l0aCBhIHdyYXBwZXIuDQo+IA0KPiBBbHNv
LCBhZGQgdGhlIHdyYXBwZXIgZnVuY3Rpb25zIHRvIGhlbHAgdXMgZmluZCBvdXQgdGhlIENPV2Vk
IG9yDQo+IENPVy1hdmFpbGFibGUgUFRFIHRhYmxlLg0KPiANCg0KWyBzbmlwIF0NCg0KPiArc3Rh
dGljIGlubGluZSBpbnQgY29weV9jb3dfcHRlX3JhbmdlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hLA0KPiArCQkJCSAgICAgcG1kX3QgKmRzdF9wbWQsIHBtZF90ICpzcmNfcG1kLA0KPiArCQkJ
CSAgICAgdW5zaWduZWQgbG9uZyBzdGFydCwgdW5zaWduZWQgbG9uZyBlbmQpDQo+ICt7DQo+ICsJ
c3RydWN0IG1tX3N0cnVjdCAqbW0gPSB2bWEtPnZtX21tOw0KPiArCXN0cnVjdCBtbXVfbm90aWZp
ZXJfcmFuZ2UgcmFuZ2U7DQo+ICsJaW50IHJldDsNCj4gKwlib29sIGlzX2NvdzsNCj4gKw0KPiAr
CWlzX2NvdyA9IGlzX2Nvd19tYXBwaW5nKHZtYS0+dm1fZmxhZ3MpOw0KPiArCWlmIChpc19jb3cp
IHsNCj4gKwkJbW11X25vdGlmaWVyX3JhbmdlX2luaXQoJnJhbmdlLCBNTVVfTk9USUZZX1BST1RF
Q1RJT05fUEFHRSwNCj4gKwkJCQkJMCwgdm1hLCBtbSwgc3RhcnQsIGVuZCk7DQo+ICsJCW1tdV9u
b3RpZmllcl9pbnZhbGlkYXRlX3JhbmdlX3N0YXJ0KCZyYW5nZSk7DQo+ICsJCW1tYXBfYXNzZXJ0
X3dyaXRlX2xvY2tlZChtbSk7DQo+ICsJCXJhd193cml0ZV9zZXFjb3VudF9iZWdpbigmbW0tPndy
aXRlX3Byb3RlY3Rfc2VxKTsNCj4gKwl9DQo+ICsNCj4gKwlyZXQgPSBjb3B5X3B0ZV9yYW5nZSh2
bWEsIHZtYSwgZHN0X3BtZCwgc3JjX3BtZCwgc3RhcnQsIGVuZCk7DQo+ICsNCj4gKwlpZiAoaXNf
Y293KSB7DQo+ICsJCXJhd193cml0ZV9zZXFjb3VudF9lbmQoJm1tLT53cml0ZV9wcm90ZWN0X3Nl
cSk7DQo+ICsJCW1tdV9ub3RpZmllcl9pbnZhbGlkYXRlX3JhbmdlX2VuZCgmcmFuZ2UpOw0KDQpV
c3VhbGx5LCBJIHdvdWxkIGV4cGVjdCBtbXUtbm90aWZpZXJzIGFuZCBUTEIgZmx1c2hlcyB0byBi
ZSBpbml0aWF0ZWQgYXQgdGhlDQpzYW1lIHBvaW50IGluIHRoZSBjb2RlLiBQcmVzdW1hYmx5IHlv
dSBjaGFuZ2VkIHByb3RlY3Rpb24sIHNvIHlvdSBkbyBuZWVkIGENClRMQiBmbHVzaCwgcmlnaHQ/
IElzIGl0IGRvbmUgZWxzZXdoZXJlPw0KDQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4g
K30NCj4gKw0KPiArLyoNCj4gKyAqIEJyZWFrIENPVyBQVEUsIHR3byBzdGF0ZSBoZXJlOg0KPiAr
ICogICAtIEFmdGVyIGZvcmsgOiAgIFtwYXJlbnQsIHJzcz0xLCByZWY9Miwgd3JpdGU9Tk8gLCBv
d25lcj1wYXJlbnRdDQo+ICsgKiAgICAgICAgICAgICAgICAgdG8gW3BhcmVudCwgcnNzPTEsIHJl
Zj0xLCB3cml0ZT1ZRVMsIG93bmVyPU5VTEwgIF0NCj4gKyAqICAgICAgICAgICAgICAgICAgICBD
T1cgUFRFIGJlY29tZSBbcmVmPTEsIHdyaXRlPU5PICwgb3duZXI9TlVMTCAgXQ0KPiArICogICAg
ICAgICAgICAgICAgICAgIFtjaGlsZCAsIHJzcz0wLCByZWY9Miwgd3JpdGU9Tk8gLCBvd25lcj1w
YXJlbnRdDQo+ICsgKiAgICAgICAgICAgICAgICAgdG8gW2NoaWxkICwgcnNzPTEsIHJlZj0xLCB3
cml0ZT1ZRVMsIG93bmVyPU5VTEwgIF0NCj4gKyAqICAgICAgICAgICAgICAgICAgICBDT1cgUFRF
IGJlY29tZSBbcmVmPTEsIHdyaXRlPU5PICwgb3duZXI9cGFyZW50XQ0KPiArICogICBOT1RFDQo+
ICsgKiAgICAgLSBDb3B5IHRoZSBDT1cgUFRFIHRvIG5ldyBQVEUuDQo+ICsgKiAgICAgLSBDbGVh
ciB0aGUgb3duZXIgb2YgQ09XIFBURSBhbmQgc2V0IFBNRCBlbnRyeSB3cml0YWJsZSB3aGVuIGl0
IGlzIG93bmVyLg0KPiArICogICAgIC0gSW5jcmVhc2UgUlNTIGlmIGl0IGlzIG5vdCBvd25lci4N
Cj4gKyAqLw0KPiArc3RhdGljIGludCBicmVha19jb3dfcHRlKHN0cnVjdCB2bV9hcmVhX3N0cnVj
dCAqdm1hLCBwbWRfdCAqcG1kLA0KPiArCQkJIHVuc2lnbmVkIGxvbmcgYWRkcikNCj4gK3sNCj4g
KwlzdHJ1Y3QgbW1fc3RydWN0ICptbSA9IHZtYS0+dm1fbW07DQo+ICsJdW5zaWduZWQgbG9uZyBw
dGVfc3RhcnQsIHB0ZV9lbmQ7DQo+ICsJdW5zaWduZWQgbG9uZyBzdGFydCwgZW5kOw0KPiArCXN0
cnVjdCB2bV9hcmVhX3N0cnVjdCAqcHJldiA9IHZtYS0+dm1fcHJldjsNCj4gKwlzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKm5leHQgPSB2bWEtPnZtX25leHQ7DQo+ICsJcG1kX3QgY293ZWRfZW50cnkg
PSAqcG1kOw0KPiArDQo+ICsJaWYgKGNvd19wdGVfY291bnQoJmNvd2VkX2VudHJ5KSA9PSAxKSB7
DQo+ICsJCWNvd19wdGVfZmFsbGJhY2sodm1hLCBwbWQsIGFkZHIpOw0KPiArCQlyZXR1cm4gMTsN
Cj4gKwl9DQo+ICsNCj4gKwlwdGVfc3RhcnQgPSBzdGFydCA9IGFkZHIgJiBQTURfTUFTSzsNCj4g
KwlwdGVfZW5kID0gZW5kID0gKGFkZHIgKyBQTURfU0laRSkgJiBQTURfTUFTSzsNCj4gKw0KPiAr
CXBtZF9jbGVhcihwbWQpOw0KPiArCS8qDQo+ICsJICogSWYgdGhlIHZtYSBkb2VzIG5vdCBjb3Zl
ciB0aGUgZW50aXJlIGFkZHJlc3MgcmFuZ2Ugb2YgdGhlIFBURSB0YWJsZSwNCj4gKwkgKiBpdCBz
aG91bGQgY2hlY2sgdGhlIHByZXZpb3VzIGFuZCBuZXh0Lg0KPiArCSAqLw0KPiArCWlmIChzdGFy
dCA8IHZtYS0+dm1fc3RhcnQgJiYgcHJldikgew0KPiArCQkvKiBUaGUgcGFydCBvZiBhZGRyZXNz
IHJhbmdlIGlzIGNvdmVyZWQgYnkgcHJldmlvdXMuICovDQo+ICsJCWlmIChzdGFydCA8IHByZXYt
PnZtX2VuZCkNCj4gKwkJCWNvcHlfY293X3B0ZV9yYW5nZShwcmV2LCBwbWQsICZjb3dlZF9lbnRy
eSwNCj4gKwkJCQkJICAgc3RhcnQsIHByZXYtPnZtX2VuZCk7DQo+ICsJCXN0YXJ0ID0gdm1hLT52
bV9zdGFydDsNCj4gKwl9DQo+ICsJaWYgKGVuZCA+IHZtYS0+dm1fZW5kICYmIG5leHQpIHsNCj4g
KwkJLyogVGhlIHBhcnQgb2YgYWRkcmVzcyByYW5nZSBpcyBjb3ZlcmVkIGJ5IG5leHQuICovDQo+
ICsJCWlmIChlbmQgPiBuZXh0LT52bV9zdGFydCkNCj4gKwkJCWNvcHlfY293X3B0ZV9yYW5nZShu
ZXh0LCBwbWQsICZjb3dlZF9lbnRyeSwNCj4gKwkJCQkJICAgbmV4dC0+dm1fc3RhcnQsIGVuZCk7
DQo+ICsJCWVuZCA9IHZtYS0+dm1fZW5kOw0KPiArCX0NCj4gKwlpZiAoY29weV9jb3dfcHRlX3Jh
bmdlKHZtYSwgcG1kLCAmY293ZWRfZW50cnksIHN0YXJ0LCBlbmQpKQ0KPiArCQlyZXR1cm4gLUVO
T01FTTsNCj4gKw0KPiArCS8qDQo+ICsJICogSGVyZSwgaXQgaXMgdGhlIG93bmVyLCBzbyBjbGVh
ciB0aGUgb3duZXJzaGlwLiBUbyBrZWVwIFJTUyBzdGF0ZSBhbmQNCj4gKwkgKiBwYWdlIHRhYmxl
IGJ5dGVzIGNvcnJlY3QsIGl0IG5lZWRzIHRvIGRlY3JlYXNlIHRoZW0uDQo+ICsJICogQWxzbywg
aGFuZGxlIHRoZSBhZGRyZXNzIHJhbmdlIGlzc3VlIGhlcmUuDQo+ICsJICovDQo+ICsJaWYgKGNv
d19wdGVfb3duZXJfaXNfc2FtZSgmY293ZWRfZW50cnksIHBtZCkpIHsNCj4gKwkJc2V0X2Nvd19w
dGVfb3duZXIoJmNvd2VkX2VudHJ5LCBOVUxMKTsNCg0KUHJlc3VtYWJseSB0aGVyZSBpcyBzb21l
IGFzc3VtcHRpb24gb24gYXRvbWljaXR5IGhlcmUuIE90aGVyd2lzZSwgdHdvDQp0aHJlYWRzIGNh
biBydW4gdGhlIGZvbGxvd2luZyBjb2RlLCB3aGljaCBpcyB3cm9uZywgbm8/IFlldCwgSSBkbyBu
b3Qgc2VlDQphbnl0aGluZyB0aGF0IHByb3ZpZGVzIHN1Y2ggYXRvbWljaXR5Lg0KDQo+ICsJCWlm
IChwdGVfc3RhcnQgPCB2bWEtPnZtX3N0YXJ0ICYmIHByZXYgJiYNCj4gKwkJICAgIHB0ZV9zdGFy
dCA8IHByZXYtPnZtX2VuZCkNCj4gKwkJCWNvd19wdGVfcnNzKG1tLCB2bWEtPnZtX3ByZXYsIHBt
ZCwNCj4gKwkJCQkgICAgcHRlX3N0YXJ0LCBwcmV2LT52bV9lbmQsIGZhbHNlIC8qIGRlYyAqLyk7
DQo+ICsJCWlmIChwdGVfZW5kID4gdm1hLT52bV9lbmQgJiYgbmV4dCAmJg0KPiArCQkgICAgcHRl
X2VuZCA+IG5leHQtPnZtX3N0YXJ0KQ0KPiArCQkJY293X3B0ZV9yc3MobW0sIHZtYS0+dm1fbmV4
dCwgcG1kLA0KPiArCQkJCSAgICBuZXh0LT52bV9zdGFydCwgcHRlX2VuZCwgZmFsc2UgLyogZGVj
ICovKTsNCj4gKwkJY293X3B0ZV9yc3MobW0sIHZtYSwgcG1kLCBzdGFydCwgZW5kLCBmYWxzZSAv
KiBkZWMgKi8pOw0KPiArCQltbV9kZWNfbnJfcHRlcyhtbSk7DQo+ICsJfQ0KPiArDQo+ICsJLyog
QWxyZWFkeSBoYW5kbGVkIGl0LCBkb24ndCByZXVzZSBjb3dlZCB0YWJsZS4gKi8NCj4gKwlwbWRf
cHV0X3B0ZSh2bWEsICZjb3dlZF9lbnRyeSwgYWRkciwgZmFsc2UpOw0KPiArDQo+ICsJVk1fQlVH
X09OKGNvd19wdGVfY291bnQocG1kKSAhPSAxKTsNCg0KRG9u4oCZdCB1c2UgVk1fQlVHX09OKCku
DQoNCg==
