Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C5D5ECAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbiI0R15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiI0R1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:27:48 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11013011.outbound.protection.outlook.com [52.101.64.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E411D1E32
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGB6qc4fzJqDe5OoDUdxWKJPmN6QlHbMjcnVDrityEeVnjx5Y7hC5EFw0Doo6Wj4BShzsOW8ns/6BxijcstMw2uxUu7JS5K+8bpiLkf9CQ9ToBCFKhL41ROf1weAXASjysVU1rndvkylRFFrK4u5LEjxmbphs6PyFPH6IKYQHgjFATjrmmWwBVMrnynueraNlHLLISnsU1AQNIRhPCRImnYsmdY+ZhvycM81jWoDhwBvOzgf5qpWtnMDIBsD6dhniQUdJiCWgnilFbad7v3Qbr3uwHQzUtdcpveNVXdKfuwt5rf1aHL1F99xBwd+rDVM4tu1N4/yu7AykZnRLyiFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtTo05grLeDEDbnsUNR9x5C45ECbgNtpfpeq2VP3KHI=;
 b=GSCfseOlth0c3uSo6TEVkf+QtrJ9L+wWpFzwVfKbUnwuXI4/uoZOH3GYK43YKMZfmRPSgv9UxIsi1HGXy1U9sk8jeBp7YQaYNwU0ly2IVKP24LCtU04BHeB//SdnxHl1Ekhqwhr7uUarH+jhf0/0zTe99wyTVkBYFCJjoV8G19jRW2AJz+7NgAxVNROX68Vfn+sBf0iYF+Zfn2x56VS3i2/Dj0ihVrJyjnwS4qFRGz7cN9QrDx9eadB2rTt09HAW7Owp/Uom+ghrbCJNfnTnLSjFDVWbcxMEMxFQFD82oQLy0CVaPn9+LknxXD/+HV6e6TqJkzM2AuBZV0n2djr1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtTo05grLeDEDbnsUNR9x5C45ECbgNtpfpeq2VP3KHI=;
 b=qDOHh0ZpEPa0I3EXHL9M1vTv3xaYeDX0gmEmyseRv3/m+Pi+EMbVPTymtmMK4KwGwXVGCxBXd00adfaPVKwOzpTAhp+IlzvtZglRUNDM1wFBVlZj4/yNZqW5xQeqmdflPnl+9dtTu+6T04cpGdnPwyQrRKYxlRFzAayV5RwhHWs=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BYAPR05MB6150.namprd05.prod.outlook.com (2603:10b6:a03:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.14; Tue, 27 Sep
 2022 17:27:45 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%5]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 17:27:45 +0000
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
Subject: Re: [RFC PATCH v2 2/9] mm: pgtable: Add sysctl to enable COW PTE
Thread-Topic: [RFC PATCH v2 2/9] mm: pgtable: Add sysctl to enable COW PTE
Thread-Index: AQHY0o4Wv+p+N3mrykKB6ElxyjzWs63zh8sA
Date:   Tue, 27 Sep 2022 17:27:45 +0000
Message-ID: <8632896B-35D1-4B8F-8A7F-275DEEBCB962@vmware.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-3-shiyn.lin@gmail.com>
In-Reply-To: <20220927162957.270460-3-shiyn.lin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BYAPR05MB6150:EE_
x-ms-office365-filtering-correlation-id: f62908bb-abc9-4e95-18d7-08daa0ad971b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tgfufp4bxiQ7wdkglGlmfPxoDnRLGd/XKo84l/3Pk8Q9dpdJZgmQrSkdcaDXttMRboQE/tL0EErsKWgPBIOAB9EZO7aLXYyze1HSijYpkw7irzlrYKAxkIQttSnFx7uLDJDyOirvaqY8OPmBdMMS4v2dTVGybEiJsGCBSF3CzfLo6x/JFIvNQJnGgcsCZZHekIn73CD56Mjmm8noIEYaSkSE5IisAsqIIC0YHgxzdgD1s2Lf3P+YrVaVe4titJRAJ0jCKHckHRIh8d2lwcDHCT+ph8e3K8nOuvfO8rtkvBPS3SXMLGAupnG7fBomIR+WgNKTqcyOK4ZljGOKh2iomej9dN/HkUPNFJ9IFAjXb4EZX7LiB3OpZMRvW29jKXx4gyhU7Ll5u3Td8Is2aHExTdNBelaltuE1Ie7lIMq6vzKlKCQeXyZkMr6ZY5q1G1AmSdp0Fv4CIoHy6VQV2cat/jTgNrd/xM2L2xioXYX6cG/xRtfirK247pCAIPfXl/FgZfg/xHPNnYibYKcf0f/UWCUmBFspMW8ni5zCGEi0AtM8/XvFShdBe2S+vBw9nDurGKb5WZ2SRgF58vLuSor65hX8ZWLHABLcKoq4CNxrSVb1z1eqm98X6naXsnapu5+0m6w1v/a0W3PNo3hUVkgU3aeq6OgROEzNpNHpF4UNffd6Zxk+DBw0T+wzqYHH5X5xnt1WbQGQKZXknOIhGpHwWj7WIUbfu05HYdA66Ej26YZBQUBJEQvWR4YQQtcz6Qig1GfslHiChQiKhX8QR9MeeMW/K5GUWsSbh6sfgv7RLEk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(7416002)(54906003)(36756003)(7406005)(41300700001)(4744005)(2906002)(5660300002)(8936002)(33656002)(38100700002)(66556008)(38070700005)(122000001)(66946007)(478600001)(64756008)(4326008)(8676002)(71200400001)(316002)(6916009)(6486002)(76116006)(66446008)(66476007)(186003)(2616005)(26005)(86362001)(6512007)(6506007)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzArZm9IdVBQQkgwRGJpK0ZPVzZCNC84QnhERDVkTGNSZ1Zkb3M5eEwwYk1k?=
 =?utf-8?B?VnMxTVVxMGkrTk1sUG5yMGhDRzRUVUtrYkRZWkhTU1JSVFpDTktMemJkN2JB?=
 =?utf-8?B?dU84VEgrd2lsRUdTdXdOSlVNNGNNSkhiTjhaNnE1R0hobG9acTE2c2I0c3VZ?=
 =?utf-8?B?VmFBSVRMcGExRWV3VU5obHFDSmlkSUJlUXBmaWpPeXNpTzh5eCt3SllVYStU?=
 =?utf-8?B?NDg2VFNMS005NW9QSUFybnZGeDVHajZXMlluck5vcXhNUlZSUTVsOEQwN2Vi?=
 =?utf-8?B?ZHNXSG1tRkpXcFdNMnMxSzlDSGJoY1cvV3QrNFlHakN2ZFFsNDE5N1N3Rkh0?=
 =?utf-8?B?c0dDSDVIWHNiNERyZ1M0MEdhbi9EN211ZFNteG9DekNzZTM2cHdmb0d3VEla?=
 =?utf-8?B?N1g2SG45VFBvYnB5ZVgrSVpXQlFFdzdmMXZxd3ErUk8zKytGVVFZclArN3Vl?=
 =?utf-8?B?Sm1lMXVEMCtNQlZYYVpobitPN0EreGcyV0dscDNKM0htWXozUVgzU0UwVWhR?=
 =?utf-8?B?SDVlakxsQXo1eHZIS3A5NTBBVCtWcXE1ZWNBTWhmV2tjK2pHV2Ira0lBSk1v?=
 =?utf-8?B?VlI5T3VMWnZEYzFiSFYxRmx2WG02SDFjMXVLamFZaXEzTU5hK2J2TDBqTVNN?=
 =?utf-8?B?ZVBVNlYrQVlkSnZhQ2tBQmNxNEJSWmRPUjNCZVdZT0FXanhYMlZ2Ty9NRDg0?=
 =?utf-8?B?SjhJVEZGT1lLWm1ZbFlpSHFiTVp3RUVnajZoZXF1c0lNTHMzSGhmN3I5RzNX?=
 =?utf-8?B?MWs2OGk1amVTSHpEM0Y2cnVPS2QyMHV4K3VzWXU0MFlabFQzMTJTcVNkRUR3?=
 =?utf-8?B?MFh2U2wrK0s0eENoU1FkUlMrV29XSVhldXZYYm1wNXpyNHJRRUJLRGdqZnY4?=
 =?utf-8?B?TmJuU3hKUVBtbCtPYmFtekM5M0xjTGhBYll5eWZCbk5zeU1nSGNzRHBXbkNw?=
 =?utf-8?B?clNDbXNySDlNTzMyRVRHMkZ6RlhvV3RIam9LamRyYzV6Sm8vWDI0bU5kZ3hJ?=
 =?utf-8?B?ZHlPMmxxNXh1bndyN05JU3lNRlByVm1BQ0dIQXlETldkRktCNUhhRW01MGta?=
 =?utf-8?B?bkdTb0VzOElpLzVheFdPaW8wdExDdWQ4L3h3Z3JsV2NudGNkUmRYQXJHTk9l?=
 =?utf-8?B?dWpNZUljNVRaU0RzOGZzdmJjVGJCaWhOeUt0VE53Q1h5cjNaY25vMElVQy94?=
 =?utf-8?B?TTVDMjE4UndWb003VFp3OWx4MG5oMDk4bGUzMVAxSlVqV2xNbFgrTUJNRy9Z?=
 =?utf-8?B?aWtac2NyeEYzR0NZd0FFUzNsUDI4bGwvOS9yU3MzWVdqVGo5R3g4NGRtd3Rm?=
 =?utf-8?B?TThHYUFCai9tL2JvTjJjVW9waVd2cGZ5blJURitmRVFkZkt6d0dKT0xqMmtl?=
 =?utf-8?B?MUVPdHBlTG03dlV5UnhEaElWYTRFSjNmYUtXc2pCWVZnK0FZUzZJSEJUSGht?=
 =?utf-8?B?RzFTS1Jac0ZqOEVYRnZBSHc3dnV5eWllV01rdHltMzZwRDNVK3JHSlkzYnc2?=
 =?utf-8?B?R2g4UkFzNHkxcEdEQ29nNHhKZHM5YzNmZnc2TzV6N2RXN3dRZlE3bVZ0dkYw?=
 =?utf-8?B?T0h1Q0o1eVRWN211VTN2L2QyK3dsVGNhdjFvbHJsL2ZFQXh1WC9OdGdzTUFn?=
 =?utf-8?B?MU0wUTJUQXB5elNvRUdKZmtXbERjYmcrSG9DOFBhTVd2S29zQUwxeFRmKzVl?=
 =?utf-8?B?YUNJL0hXMlpKMkQ1MVZRRVlTZHFDTTdqQjh6SDdxak02YjJXL20yLy9JWFY1?=
 =?utf-8?B?eDZVc3dteU0ycDhhUHJOejg3bHNyTGVEOWxZNm1laDZiSzd6a3Z0T1JWK0o0?=
 =?utf-8?B?MjcwSkFtYSt3V01veWI2dlBEbFpOOGRYOU9kZ3ZXa29QQnQ5YTZSUzBCbnVs?=
 =?utf-8?B?Y004b290Y1d5Sk9Cc1NJQzZSU1VQclB1YVdvNnJ2UEhjUk1GMzJxdmtqeG42?=
 =?utf-8?B?by81V1Y0VlVKbnpPVitEeWJ4aWRMVTlLVkVWMEpiakhZemQ1d2V6MGJtTnRJ?=
 =?utf-8?B?RzdCOFE3VE9lak50QjBLdytHVXlTZDY3RjhvS1MzT2ZncEZDVm92VjA0am1k?=
 =?utf-8?B?UUkrSkRSQlVxSmI5cEU2U1hYWkkrQ2lScFZuZTZmTkZWd3M2a1ovajJLMHVw?=
 =?utf-8?Q?1H4bUy+b8bOFUti4twN7JjzbK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACE0B2E66288B347A7C8365462DA3CE0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62908bb-abc9-4e95-18d7-08daa0ad971b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 17:27:45.0643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VO/nJ8y+EbTYYl9aUbOdwxKX6jMk1eTnmNKzVFvVQJf6zfmzcDJSH8Q7juFU7eOlJUTBeGOiuPMLb+7gU7bIxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6150
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2VwIDI3LCAyMDIyLCBhdCA5OjI5IEFNLCBDaGloLUVuIExpbiA8c2hpeW4ubGluQGdtYWls
LmNvbT4gd3JvdGU6DQoNCj4gQWRkIGEgbmV3IHN5c2N0bCB2bS5jb3dfcHRlIHRvIHNldCBNTUZf
Q09XX1BURV9SRUFEWSBmbGFnIGZvciBlbmFibGluZw0KPiBjb3B5LW9uLXdyaXRlIChDT1cpIHRv
IHRoZSBQVEUgcGFnZSB0YWJsZSBkdXJpbmcgdGhlIG5leHQgdGltZSBvZiBmb3JrLg0KPiANCj4g
U2luY2UgaXQgaGFzIGEgdGltZSBnYXAgYmV0d2VlbiB1c2luZyB0aGUgc3lzY3RsIHRvIGVuYWJs
ZSB0aGUgQ09XIFBURQ0KPiBhbmQgZG9pbmcgdGhlIGZvcmssIHdlIHVzZSB0d28gc3RhdGVzIHRv
IGRldGVybWluZSB0aGUgdGFzayB0aGF0IHdhbnRzDQo+IHRvIGRvIENPVyBQVEUgb3IgYWxyZWFk
eSBkb2luZyBpdC4NCg0KSSBkb27igJl0IGdldCB3aHkgaXQgaXMgbmVlZGVkIGluIGdlbmVyYWwg
YW5kIGNlcnRhaW5seSB3aHkgc3lzY3RsIGNvbnRyb2xzDQp0aGlzIGJlaGF2aW9yLg0KDQpJSVVD
LCBpdCBzb3VuZHMgdGhhdCB5b3Ugd2FudCBwcmN0bCBhbmQgbm90IHN5c2N0bCBmb3Igc3VjaCBj
b250cm9sLiBCdXQNCmNsZWFybHkgeW91IHRoaW5rIHRoYXQgdGhpcyBjb250cm9sIGlzIG5lZWRl
ZCBiZWNhdXNlIHRoZXJlIGlzIGEgdHJhZGVvZmYuDQpQbGVhc2UgZXhwbGFpbiB0aGUgdHJhZGVv
ZmYgYW5kIGhvdyB1c2VycyBhcmUgZXhwZWN0ZWQgdG8gbWFrZSBhIGRlY2lzaW9uDQp3aGV0aGVy
IHRvIHR1cm4gdGhlIGZsYWcgb3Igbm90Lg0KDQo=
