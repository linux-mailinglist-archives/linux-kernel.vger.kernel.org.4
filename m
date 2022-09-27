Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A671E5ECC33
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiI0SiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiI0SiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:38:09 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D936E1BEA66
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 11:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0IOQrLYJC0MXB4IwjiHdAsSxcPTKZLoNLfPWwVCEWv7Vj0nJ5Ceoh3m+wFl2NtOxoiaXznlftdO16pLjQBCykZpNmx3gTujP6XtbNWHWbW+revUtAc5szAaGDTdtnwuHMKKhNWML6hxh9nRzzVR0/v734pj8DLS/CnbQOHigkvCi42eBcsOrptAwtAyWD2eJCARTibfxqHG/QvOMoOaM22Wd64EfIBTwtlgtPxffejJ4sGbBFLeYWxUGAN4zWb/lW7pNPh+ht3ukXkUoiL8v7cW2sVRf0XfmoxQW9sUscsnF5blVfU9YBi84+7eP6DzeYxMpMW956dsdMGmT+LzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnWiS6JhIFdb1gSo1ZNAT8U1rDbGq8ju9f/mX9h3f/w=;
 b=NkGqdvixhh+we76mB5J0SOQ9orVzdeoF8H9m9s/aR02dez9bBKc3YlyUbMrdgo3z71jYATvgKupyRm1LbcWm4F8/TugdZ9/rsK1cg+CsF1TlDJxQuIrLct7wIh0EuS3NJ1mKohuvo/J7Y99ilkeAFg0kumHH9cKD1OQTuPioBeuzdMECJ6sF2NA59yqhv9RpTvi6Uoyc/ZEkXUsrhbeA89VNrYbMK4qE5rVN8yec1cTpe08KmYakbWkcrbkTRlhwshVn9Yy9M5w2mj8JIJroqSUp2wl5Z+bt5d5CYtLi8rBCZbiCzBnA/PPwpyvGjEXcvk+tH3VXhTR2uvA9/Bo9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnWiS6JhIFdb1gSo1ZNAT8U1rDbGq8ju9f/mX9h3f/w=;
 b=y51LkDS6GTpUi5ahr735ajIcRJTcZ0qmBTlLaAOOp0paGwmjBI4gXrqB1DE2+44mu1uEWAwUhU0/3yaHliazdf6ugBYTJjtSrK6mkwwGgmrVBL4+oq90ZIwOjd60QBEHQlxkCWeDVsrQ6kd5PxEDAgOmBLHQ58WVnc2j3P/vaLc=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM5PR05MB3308.namprd05.prod.outlook.com (2603:10b6:4:3f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Tue, 27 Sep
 2022 18:38:05 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%5]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 18:38:05 +0000
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
Subject: Re: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
Thread-Topic: [RFC PATCH v2 9/9] mm: Introduce Copy-On-Write PTE table
Thread-Index: AQHY0o4wEIMbrk5BdEK3BIHQI3SfK63zm3IA
Date:   Tue, 27 Sep 2022 18:38:05 +0000
Message-ID: <3D21021E-490F-4FE0-9C75-BB3A46A66A26@vmware.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-10-shiyn.lin@gmail.com>
In-Reply-To: <20220927162957.270460-10-shiyn.lin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|DM5PR05MB3308:EE_
x-ms-office365-filtering-correlation-id: 9491920d-952e-487e-3552-08daa0b76aab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fjCFxyNSr9LYqBvoeuoHY+gsgdIHTPu9nFID/rc6nv3H4MX9UDCLgSt0ccRmIKB94zkvRlqKpr6tT5BRYe0puTwmiPOMh8ilDGbnOF5jujoesLtlmQhQVYobJ4zo8RlOor0KmKvTTAGWhDthIKU65b+HRL6fbs5zfJ569n0W4obeEprNz5gp2RS8AR26H79OhN3Y7Zt3qNPdGHch+1Ckfyf1c7Sp6cYCi8W2QB9QLYjSPXpOkCmEeYud6XLjhqtV9p2l5Nv8Ouqi6cuHjvRMn8jjWzfMJDbbfESzfPNjRTIjc9lp7G5tdjz/lZDorvOWBTahfy3tkFe8/mW2o0Y0Izg3cbZbOb6o5HfpwIAJke0MUUsjFAmqZkEN4qZsLhIaaM7okH8YtouraGEARUyV1jyvrFWput7LNPhoKEcKcxgyE/7uAjg5kysxtn5zsF6FbLzjxlvVwf2d7V19mN8ZKgn7UJTn48vMILPjUUCEtyaKraHDhBW9mYZPy72qGMKRy+z8dqePzM7FUxJb9ql1cRRaXw/uUPaEH1PCcvCxA0d9jLovTBPI3xyrbIoGfXX++SEYC3cEOaD09ZGZ7TL1r3sW/exEF/FnPJhx0soo4XD+gbtNgjth+bGwRdPnECTYZu4OWs1YEqMj4Z4M2xORq/i/Emnt1Hgl0LlglEahNOvQxZK8J3AwFJwxV1nElNSzg7nybQFZwuSTWbcE4Hxwpl+kShYwdnrgIeZ4ccdSf/thntfQ7bAO+DK8bW/IIY2mN94Dhs+wyhgtReMZa285mId2wXPiUD3d5UwVeZLIVW8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(38100700002)(122000001)(86362001)(36756003)(38070700005)(33656002)(7416002)(186003)(7406005)(2616005)(2906002)(478600001)(6506007)(6486002)(53546011)(26005)(41300700001)(6512007)(83380400001)(5660300002)(4326008)(6916009)(71200400001)(54906003)(8676002)(66476007)(316002)(76116006)(64756008)(66946007)(8936002)(66556008)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVEzVzdZOVlLekxnTWN4cCtTOTN0b1hIMUN6UXdIUyttZk83Q0FBOEhyQjQ2?=
 =?utf-8?B?Wkd4c2VtTjJTdjlzSEN5MUdXdWkrSDVvN2lLbndBa1FYc0FzSy9wRGxscU02?=
 =?utf-8?B?WTJHVGR0THcyVEpyRlNQam13aGZ0bjBXQzJCUkVNdFo4NWxhYk9MTFFTMkI1?=
 =?utf-8?B?R081eFdiZVFSRmZPdjhCVGUwWEJRNmhJcEVnRng2azNYekloeElwNzZEMzhQ?=
 =?utf-8?B?NVlvWFU3ajdiSlBBVldZZjdLcGhYUExkNnNxcWdIVGhtbnFIZ0lMTVBMSzFr?=
 =?utf-8?B?WEd4RWViaUtFbXdPMnJYVkF1THRVa0N5WG1TYS9BcGZ3VWZSazJFYkFRS2JS?=
 =?utf-8?B?R2JjaVlyTzlCNEhqeWxRTkF4Z1lwL3dGa2MvUWhOSGtSUlV4L21HS3BtcUJk?=
 =?utf-8?B?Y0FCcTJhNndqc0g1VHJWbHRxMk1haXNtS3JsanpvZlNhRzB3RFVqUW5RWXRh?=
 =?utf-8?B?MTRkdWxpZUdJelZnS2plcXFMQlJMd3JFZS9JS2UwdWpnczJ4SEFVK2NNVW5y?=
 =?utf-8?B?aDRxemU1V1RpcTNZK0NWYlloUFhTSDlnalNkTWZRZVRPbnZxaC9kOXBMUjkx?=
 =?utf-8?B?RmtCYmY3TVpIcUF5RS9UanZzOWY5VWhwUjFiQ3pQTERSNVZmeUpuUnprVURG?=
 =?utf-8?B?ak9ENWhnWk5rUkhTZW1jcVB6bFBJejRZSE1yOFFadHdkbml6MlRXQXZZR0x1?=
 =?utf-8?B?dEN1SXdlR2VVWU9HbGkwY1NqRUhZcU4rQ0Y5Vzd6SlVsbXcvTUd2UW1IdHFs?=
 =?utf-8?B?MCszbTdGa3pIWnJPdnp0MVVkZlJ6RXlDVXF6bS9abWN1M2w2eGJ6azdBcXVM?=
 =?utf-8?B?TVUxSFVOUnBEVGNuNEhaNnE2UWRMVHNCYzdMRHJuMnlXOCtyS3R2VlZBT0Z4?=
 =?utf-8?B?MnZMVldKbHlDUXpEb25jUWJBMjlTc0ZEemZiN2pyOUhmdWNaNCs3WTd2eDlI?=
 =?utf-8?B?UDlKc25jenFJaStMMHNMYmhtRmFSYkNQWkYwUnR4Wm43OU5GWXJuRmNpTXhG?=
 =?utf-8?B?YlFpY3N0blMyeklFTWxtK1ZNTnFlaWhqVHpnQnk0ak0vUXphbEh0dXRJRllt?=
 =?utf-8?B?YVVweGZlTmxWWEVzcllmWnZzekpkYTE4eFVDWDZKa3REdGhTWjlxT0ZOeWhZ?=
 =?utf-8?B?eXBJSElNRVdxWTRmWG5yMHZRN3dLODBaQ296ZFJlRURYL3QrbmhZc0ZNeFdn?=
 =?utf-8?B?UWIwSnVxTkZoRGRtNVFqOEx0REFMaXkvVTJzZVN6SGRrc3VyL1Q5TEJ3VUV5?=
 =?utf-8?B?UmhlSU0wbnFYb1RYcHU1VzNUOEdldHo2Q0dkVlZJbElRYXVZYis4SkZTRTQy?=
 =?utf-8?B?RjVrRzB4SnBVRFhHWVVRUlVxRmQ3RnUrdElsSTZjNXFGeEQ4TGd6bGo2ZGdL?=
 =?utf-8?B?dnoxdEQrZUZpb043VFQ4ZVVpMS9QZnJBWUN2U3RoYlRPRUdqVVNPekZ0UFRH?=
 =?utf-8?B?enVEMWRKcXdUVGpXeGozMVd6akRSY3NqWTRSUkx3VG9iYm9qc0owc1NLWTUr?=
 =?utf-8?B?TzU0RnhqUUtSWGx0SnM4SmYzOWhmdE0yMW85eW9jTk5zQVR1c3k0L2g1OWZC?=
 =?utf-8?B?SlcvMDlSZXp1b3BzZ3lWU25PL0FtYVIwREhvT09KbTRYTE9nWDlZOUpzRm83?=
 =?utf-8?B?ay90Y0hzVmRxc1llL1IrS04zVklrL2ZzV1plZU5mZzFTOWlkODkrK1pJQmMw?=
 =?utf-8?B?VHBOaHNXelVKK0tlcktJNC9LQW16YTdPMHJRZEpxNGdqVmpYdUQrSENIWTRN?=
 =?utf-8?B?b1R5N2ViaGI4M2x3RTBrWldoRnNMUWNFUU8vZXlCY01MRmJKZkhkZStXSWlM?=
 =?utf-8?B?TzZqZ3QwaFg1RWE2K2RjYmk0ODRQNWIwMUhGY3lvTU1LaVJWK2k0WTc3VlVT?=
 =?utf-8?B?azEwSTBGOXhQdUEyb3BaM1Z5OVRBbkZHUGdiZXpqaXlPSHpxU1lSU2NFdmhi?=
 =?utf-8?B?dUlwV3p1azg0UGpCU01wZmlKZHRIbFI5b1FLWlpDdU1mVGY2cUFGTHhoZjcr?=
 =?utf-8?B?dkE4ck9lYjZLc2JxeXd0T2FPSndJQi8rTHIzN2czODhlYzMydHFHUjlTdjJG?=
 =?utf-8?B?OW50czV0b2p0SmxJcEFaQ3VUT09YNUdaYmkwZXdKeWZxN2FDb05TemdqZDRo?=
 =?utf-8?Q?7+5I62LYP6ccySpY5gwSELGIw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <924D37B1AE633248A186CFD19B0C23FF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9491920d-952e-487e-3552-08daa0b76aab
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 18:38:05.4942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrB/SqiJX8U7j4pDV8Dh3+2A8y5anc6V3BroAKpoDc+u/9iiWyrWS7+99mhNDKjM4JlOMAGfAWN07HyFntPq2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3308
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
LmNvbT4gd3JvdGU6DQoNCj4gVGhpcyBwYXRjaCBhZGRzIHRoZSBDb3B5LU9uLVdyaXRlIChDT1cp
IG1lY2hhbmlzbSB0byB0aGUgUFRFIHRhYmxlLg0KPiBUbyBlbmFibGUgdGhlIENPVyBwYWdlIHRh
YmxlIHVzZSB0aGUgc3lzY3RsIHZtLmNvd19wdGUgZmlsZSB3aXRoIHRoZQ0KPiBjb3JyZXNwb25k
aW5nIFBJRC4gSXQgd2lsbCBzZXQgdGhlIE1NRl9DT1dfUFRFX1JFQURZIGZsYWcgdG8gdGhlDQo+
IHByb2Nlc3MgZm9yIGVuYWJsaW5nIENPVyBQVEUgZHVyaW5nIHRoZSBuZXh0IHRpbWUgb2YgZm9y
ay4NCj4gDQo+IEl0IHVzZXMgdGhlIE1NRl9DT1dfUFRFIGZsYWcgdG8gZGlzdGluZ3Vpc2ggdGhl
IG5vcm1hbCBwYWdlIHRhYmxlDQo+IGFuZCB0aGUgQ09XIG9uZS4gTW9yZW92ZXIsIGl0IGlzIGRp
ZmZpY3VsdCB0byBkaXN0aW5ndWlzaCB3aGV0aGVyIHRoZQ0KPiBlbnRpcmUgcGFnZSB0YWJsZSBp
cyBvdXQgb2YgQ09XIHN0YXRlLiBTbyB0aGUgTU1GX0NPV19QVEUgZmxhZyB3b24ndCBiZQ0KPiBk
aXNhYmxlZCBhZnRlciBpdHMgc2V0dXAuDQo+IA0KPiBTaW5jZSB0aGUgbWVtb3J5IHNwYWNlIG9m
IHRoZSBwYWdlIHRhYmxlIGlzIGRpc3RpbmN0aXZlIGZvciBlYWNoIHByb2Nlc3MNCj4gaW4ga2Vy
bmVsIHNwYWNlLiBJdCB1c2VzIHRoZSBhZGRyZXNzIG9mIHRoZSBQTUQgaW5kZXggZm9yIHRoZSBQ
VEUgdGFibGUNCj4gb3duZXJzaGlwIHRvIGlkZW50aWZ5IHdoaWNoIG9uZSBvZiB0aGUgcHJvY2Vz
c2VzIG5lZWRzIHRvIHVwZGF0ZSB0aGUNCj4gcGFnZSB0YWJsZSBzdGF0ZS4gSW4gb3RoZXIgd29y
ZHMsIG9ubHkgdGhlIG93bmVyIHdpbGwgdXBkYXRlIHNoYXJlZA0KPiAoQ09XZWQpIFBURSB0YWJs
ZSBzdGF0ZSwgbGlrZSB0aGUgUlNTIGFuZCBwZ3RhYmxlX2J5dGVzLg0KPiANCj4gU29tZSBQVEUg
dGFibGVzIChlLmcuLCBwaW5uZWQgcGFnZXMgdGhhdCByZXNpZGUgaW4gdGhlIHRhYmxlKSBzdGls
bCBuZWVkDQo+IHRvIGJlIGNvcGllZCBpbW1lZGlhdGVseSBmb3IgY29uc2lzdGVuY3kgd2l0aCB0
aGUgY3VycmVudCBDT1cgbG9naWMuIEFzDQo+IGEgcmVzdWx0LCBhIGZsYWcsIENPV19QVEVfT1dO
RVJfRVhDTFVTSVZFLCBpbmRpY2F0aW5nIHdoZXRoZXIgYSBQVEUNCj4gdGFibGUgaXMgZXhjbHVz
aXZlIChpLmUuLCBvbmx5IG9uZSB0YXNrIG93bnMgaXQgYXQgYSB0aW1lKSBpcyBhZGRlZCB0bw0K
PiB0aGUgdGFibGXigJlzIG93bmVyIHBvaW50ZXIuIEV2ZXJ5IHRpbWUgYSBQVEUgdGFibGUgaXMg
Y29waWVkIGR1cmluZyB0aGUNCj4gZm9yaywgdGhlIG93bmVyIHBvaW50ZXIgKGFuZCB0aHVzIHRo
ZSBleGNsdXNpdmUgZmxhZykgd2lsbCBiZSBjaGVja2VkIHRvDQo+IGRldGVybWluZSB3aGV0aGVy
IHRoZSBQVEUgdGFibGUgY2FuIGJlIHNoYXJlZCBhY3Jvc3MgcHJvY2Vzc2VzLg0KPiANCj4gSXQg
dXNlcyBhIHJlZmVyZW5jZSBjb3VudCB0byB0cmFjayB0aGUgbGlmZXRpbWUgb2YgQ09XZWQgUFRF
IHRhYmxlLg0KPiBEb2luZyB0aGUgZm9yayB3aXRoIENPVyBQVEUgd2lsbCBpbmNyZWFzZSB0aGUg
cmVmY291bnQuIEFuZCwgd2hlbg0KPiBzb21lb25lIHdyaXRlcyB0byB0aGUgQ09XZWQgUFRFIHRh
YmxlLCBpdCB3aWxsIGNhdXNlIHRoZSB3cml0ZSBmYXVsdCB0bw0KPiBicmVhayBDT1cgUFRFLiBJ
ZiB0aGUgQ09XZWQgUFRFIHRhYmxlJ3MgcmVmY291bnQgaXMgb25lLCB0aGUgcHJvY2Vzcw0KPiB0
aGF0IHRyaWdnZXJzIHRoZSBmYXVsdCB3aWxsIHJldXNlIHRoZSBDT1dlZCBQVEUgdGFibGUuIE90
aGVyd2lzZSwgdGhlDQo+IHByb2Nlc3Mgd2lsbCBkZWNyZWFzZSB0aGUgcmVmY291bnQsIGNvcHkg
dGhlIGluZm9ybWF0aW9uIHRvIGEgbmV3IFBURQ0KPiB0YWJsZSBvciBkZXJlZmVyZW5jZSBhbGwg
dGhlIGluZm9ybWF0aW9uIGFuZCBjaGFuZ2UgdGhlIG93bmVyIGlmIHRoZXkNCj4gaGF2ZSB0aGUg
Q09XZWQgUFRFIHRhYmxlLg0KPiANCj4gSWYgZG9pbmcgdGhlIENPVyB0byB0aGUgUFRFIHRhYmxl
IG9uY2UgYXMgdGhlIHRpbWUgdG91Y2hpbmcgdGhlIFBNRA0KPiBlbnRyeSwgaXQgY2Fubm90IHBy
ZXNlcnZlcyB0aGUgcmVmZXJlbmNlIGNvdW50IG9mIHRoZSBDT1dlZCBQVEUgdGFibGUuDQo+IFNp
bmNlIHRoZSBhZGRyZXNzIHJhbmdlIG9mIFZNQSBtYXkgb3ZlcmxhcCB0aGUgUFRFIHRhYmxlLCB0
aGUgY29weWluZw0KPiBmdW5jdGlvbiB3aWxsIHVzZSBWTUEgdG8gdHJhdmVsIHRoZSBwYWdlIHRh
YmxlIGZvciBjb3B5aW5nIGl0LiBTbyBpdCBtYXkNCj4gaW5jcmVhc2UgdGhlIHJlZmVyZW5jZSBj
b3VudCBvZiB0aGUgQ09XZWQgUFRFIHRhYmxlIG11bHRpcGxlIHRpbWVzIGluDQo+IG9uZSBDT1cg
cGFnZSB0YWJsZSBmb3JraW5nLiBHZW5lcmljYWxseSBpdCB3aWxsIG9ubHkgaW5jcmVhc2Ugb25j
ZSB0aW1lDQo+IGFzIHRoZSBjaGlsZCByZWZlcmVuY2UgaXQuIFRvIHNvbHZlIHRoaXMgcHJvYmxl
bSwgaXQgbmVlZHMgdG8gY2hlY2sgdGhlDQo+IGRlc3RpbmF0aW9uIG9mIFBNRCBlbnRyeSBkb2Vz
IGV4aXN0LiBBbmQgdGhlIHJlZmVyZW5jZSBjb3VudCBvZiB0aGUNCj4gc291cmNlIFBURSB0YWJs
ZSBpcyBtb3JlIHRoYW4gb25lIGJlZm9yZSBkb2luZyB0aGUgQ09XLg0KPiANCj4gVGhpcyBwYXRj
aCBtb2RpZmllcyB0aGUgcGFydCBvZiB0aGUgY29weSBwYWdlIHRhYmxlIHRvIGRvIHRoZSBiYXNp
YyBDT1cuDQo+IEZvciB0aGUgYnJlYWsgQ09XLCBpdCBtb2RpZmllcyB0aGUgcGFydCBvZiBhIHBh
Z2UgZmF1bHQsIHphcHMgcGFnZSB0YWJsZQ0KPiAsIHVubWFwcGluZywgYW5kIHJlbWFwcGluZy4N
Cg0KSSBvbmx5IHNraW1tZWQgdGhlIHBhdGNoZXMgdGhhdCB5b3Ugc2VudC4gVGhlIGxhc3QgY291
cGxlIG9mIHBhdGNoZXMgc2VlbSBhDQpiaXQgcm91Z2ggYW5kIGRpcnR5LCBzbyBJIGFtIHNvcnJ5
IHRvIHNheSB0aGF0IEkgc2tpcHBlZCB0aGVtICh0b28gbWFueQ0K4oCcVE9ET+KAnSBhbmQg4oCc
WFhY4oCdIGZvciBteSB0YXN0ZSkuDQoNCkkgYW0gc3VyZSBvdGhlciB3aWxsIGhhdmUgYmV0dGVy
IGZlZWRiYWNrIHRoYW4gbWUuIEkgdW5kZXJzdGFuZCB0aGVyZSBpcyBhDQp0cmFkZW9mZiBhbmQg
dGhhdCB0aGlzIG1lY2hhbmlzbSBpcyBtb3N0bHkgZm9yIGhpZ2ggcGVyZm9ybWFuY2UNCnNuYXBz
aG90dGluZy9mb3JraW5nLiBJdCB3b3VsZCBiZSBiZW5lZmljaWFsIHRvIHNlZSB3aGV0aGVyIHRo
aXMgbWVjaGFuaXNtDQpjYW4gc29tZWhvdyBiZSBjb21iaW5lZCB3aXRoIGV4aXN0aW5nIG9uZXMg
KG1zaGFyZT8pLg0KDQpUaGUgY29kZSBpdHNlbGYgY2FuIGJlIGltcHJvdmVkLiBJIGZvdW5kIHRo
ZSByZWFzb25pbmcgYWJvdXQgc3luY2hyb25pemF0aW9uDQphbmQgVExCIGZsdXNoZXMgYW5kIHN5
bmNocm9uaXphdGlvbnMgdG8gYmUgbGFja2luZywgYW5kIHRoZSBjb2RlIHRvIHNlZW0NCnBvdGVu
dGlhbGx5IGluY29ycmVjdC4gQmV0dGVyIGNvbW1lbnRzIHdvdWxkIGhlbHAsIGV2ZW4gaWYgdGhl
IGNvZGUgaXMNCmNvcnJlY3QuDQoNClRoZXJlIGFyZSBhZGRpdGlvbmFsIGdlbmVyYWwgcXVlc3Rp
b25zLiBGb3IgaW5zdGFuY2UsIHdoZW4gc2hhcmluZyBhDQpwYWdlLXRhYmxlLCBkbyB5b3UgcHJv
cGVybHkgdXBkYXRlIHRoZSByZWZjb3VudC9tYXBjb3VudCBvZiB0aGUgbWFwcGVkDQpwYWdlcz8g
QW5kIGFyZSB0aGVyZSBhbnkgcG9zc2libGUgaW50ZXJhY3Rpb25zIHdpdGggVEhQPw0KDQpUaGFu
a3MsDQpOYWRhdg==
