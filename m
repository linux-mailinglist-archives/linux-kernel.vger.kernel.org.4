Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ABF6DCBC9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjDJTrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:47:34 -0400
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C246A1BE7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 12:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbdiNJ+y3iNXinQ+krmUvMa1CCgBu6fAF37GbpBNn2T0Ay/amMSj9w/81b0wz5iTYH1mZbfUQc1PGLi+YfB4iQ9IiR4gOLwxVkgH5P9OfpNIKAeq6izM/XtzHsvVKo95hU1fp3mf4zYfHlPMS8Ab6KBGUSIABft+JL59mI8dRj4nsh8KjzwQ1yFXW8a+rZkCg4N3wpax3fRD6AshDDG6hbMi9TQe41LrNCHiMytpsLf7C0V+Qh2aybWkEZ0UqkEdLHHJJ3Msnp6WVQUU2y87a52QwA6lklN2KHk5gSUR2UIo8rTkbfpjJ3Qp40mmnsPcbU+CYo+YlkcpvSe0Pn/HSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNGi1g8gYxuY9BzHQmPWFhQwaEbqyjVs3Jf+/kSVYwc=;
 b=SnIK56NK88PwTPC16bJiuYjni8pH1pYMAvqvm8U7l//a0KiXXVttLadytWp5Ol7wPM1o2VsjSyvN4z09jRQRGY9+u8sTatuyjh2BJfOvqVrhsNCzmvC5DeiYilfor1uQW4Tro+UziXDpbSYRhwhD49qnvVfX8SOZDVfD9iQGXtCWAVV9ayim+novDcF/2p/+jbTEKsbwquBH3ym5w6L/q3VscKfMp8IifQiPXvnYgrtP8vUXT+rp6t+iU/kXksOJQO77S98naNp4NpE8BkkjRtYeSbLEV1xtBuRzjs0bp8BhcnxpJvstvHABR1DFnNIouPIbQ9SK9qEI84v9WP8rNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNGi1g8gYxuY9BzHQmPWFhQwaEbqyjVs3Jf+/kSVYwc=;
 b=0b8qkT0OL9l1IbCHic2G/06w7wYAFwFIqj3mo3xXyqYMmFY9laJGqSWzSvacCrYJ/WHQBf2Z7SLmyFfMYV/wbvNK0LpjX65CTw7DI/wtOhUV3pO2X/rDtWHXYQruU06/8Txuy1i01uCTG/XQmbWmc/f1d/EiMYyfwBuIRY0jG8Q=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SJ0PR05MB7595.namprd05.prod.outlook.com (2603:10b6:a03:2c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 19:47:30 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f1bc:4933:8701:7ff0%6]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 19:47:30 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Huang Ying <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm,unmap: avoid flushing TLB in batch if PTE is
 inaccessible
Thread-Topic: [PATCH] mm,unmap: avoid flushing TLB in batch if PTE is
 inaccessible
Thread-Index: AQHZa4FwosvoCxZx+kWFav90J+Ui/a8k84GA
Date:   Mon, 10 Apr 2023 19:47:30 +0000
Message-ID: <402A3E9D-5136-4747-91FF-C3AA2D557784@vmware.com>
References: <20230410075224.827740-1-ying.huang@intel.com>
In-Reply-To: <20230410075224.827740-1-ying.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SJ0PR05MB7595:EE_
x-ms-office365-filtering-correlation-id: 0b497712-c71a-47d5-eb18-08db39fc6b9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdljNko3diODgG1/pg2FiumWKjvk0NPMtmaw0nQKoWULjbq7lX0m51bCfi0QBjP2/d8WGqKVV48S+tzm9bYt1Umt6yItUM4MN3WtSvOfxJGv6JlLJFEdkuH88mDYzP9jCigfwM26kKJYU/ANdyHcLK0Huh0L/WKHdkqQBa6HyalAw3La7nYxbiRitnW54Iw+zmaRTMVP3U4v4fIpOeZ0YdXg2NamTFPLyFxUOj8muOaXJ6H/HgnFz3/vWf4wLT7JQoU8EpqeKWd8gCSv2OnGVD7FpfmfKASBokbN4WY4VHFDARvBcDGwaKhHki/W/ZSV4eA2JyGxOkTSl2Bt/Lcg8NeJoQuKqqbhJtdu2OJVRGqaNVmUHNdl0sAkNrZWGMJK5suSQgflKo3HsOJ+lhLSiD+HrwtgS74tcAJ/olvdnvShMYO7zDmhuURUdzQcfPNlVvCvTNCZeKRtQaJQ8yD+HdKcPrrA/zVqot2JYJO+7BFcSnLIKN5pr+PEA4hPTzc0CSadAfXblPuLu0jQCPDFr8mons0lZpPFxGB+O9EQgmlM0qi4AfbDRNWOFVmoeO90iEDXsx3YUg+J/OrchFOjnkc3dqo/bUoD92+SjTK1yvXIqyin0fpYBstZ7luwzV3wyn14//xjyu6wlScN0fEUtmKgouVMnvp/9guOXPZt0XqZsLj2qnSYoZbM71ielvim
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(478600001)(71200400001)(6506007)(316002)(53546011)(6512007)(26005)(186003)(54906003)(6486002)(2906002)(64756008)(76116006)(66946007)(4326008)(66556008)(6916009)(8936002)(66476007)(8676002)(41300700001)(66446008)(5660300002)(122000001)(38100700002)(86362001)(33656002)(36756003)(83380400001)(38070700005)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0hWRmNybFptVFNVZUR1SFRsb2cvdkdhWUM5dFRYYTB6L1JkcGM5bUVURnJs?=
 =?utf-8?B?aFNtbFF3YUg3a2UwcVBzZ2I1WFRHamlJVCtYZkdlempraS80SFNBa0xXQzkw?=
 =?utf-8?B?QUU3SFJjd3ZybnZncDgxTnZtM1JDa2oyZm51bUJ1akFPU1FaL2FhalVWczZq?=
 =?utf-8?B?VDIyT3hJWjdoZGZ3UnJIWmFKT2JmYXk3WXpZYWthQ1VTSmpENlBtOXp6REds?=
 =?utf-8?B?T3J3allDWVp1RnlyTkZPL0Y4Kyt5SlFyRVg5a0VMVG1WSFB2b3I3aERsUWZS?=
 =?utf-8?B?YUxuc3QrTktINVMrU3djYVFnZmZyRkJoRWZiNmdzV1I3OVBKMzdOYmplaDQy?=
 =?utf-8?B?ZW9vZThFUUFXdS9MVDh4UUt3aHBlRGJxT2J6ZklwWnR5cGo3TW5YSEt5YTRE?=
 =?utf-8?B?ZDN6ckZNSkpCMzU1VmN5dW9IUEZLV2REVEFsSlgrdHVGUjJlOTE1Z3IvcUVq?=
 =?utf-8?B?cENiMUVnSVBWR2s2K2ZUUUpWWkpXNTJ5aEpHMkhibU1vL2NNcHQvTk50eVd1?=
 =?utf-8?B?c3BtZ3lGYmh1VDRDQU1IcE00bjA4clJBK1NhQlZSNjlWUDJoSkFLM0d3MDBk?=
 =?utf-8?B?RFV4L1RsOXBHN3Q3RjlRSDlQTWtFVVFqSVZmYmJIRWczaWIyK092SmNuWm1t?=
 =?utf-8?B?WjhIdGh4cWZzS05zK0RRZkc4VnZzRkZ6WDFMQnZvUm5QMUYvenZZUktRYUVp?=
 =?utf-8?B?bzZjSUpZZTk1ZXJpTkwxUC9MMjBzRCtQWHNyNlIvQmNwWjVodUZROUhkTkI2?=
 =?utf-8?B?ZzBHdE01R0I5VloyQXRUaFlMMUJscFgxVDMxUkZZSEtEaitKSThZTXFYbmM5?=
 =?utf-8?B?UG00cHZWTlJBSkJBTG1wV05GSUdwbW1qVkZLU2tGVDNoM1FOdkxIU3JYNnQ5?=
 =?utf-8?B?SUZqMzFSNTdmODh3bUFmMzNwQkpiakRmN1FEU1JlRWkzenJKVzBXSjhrVWFY?=
 =?utf-8?B?clU2cW9FNkZVQ0lLN2xuc3BVQmdYS1FSc1B2NmdhZGs4dkJocU5WWHI0Mkh3?=
 =?utf-8?B?Tm1aekswaUNJa0l4a2ZodjQwU09iZ00rZFhMRVFFMkhidFZIUU50cHhBNXYz?=
 =?utf-8?B?UFd2WnV0bTVsa2o5N2VEWHBRdHgxbnhWK0lRd0swVmQwa1AwMHVHVElzNkNk?=
 =?utf-8?B?TzVsNWFubE5NdUFmK2szUVNLMFl6dXZoZHFhbmV5V0x0UVpmdEVYRStka05U?=
 =?utf-8?B?dGVHa05BU3lHVFJwMm5rdFRGRFRMS0dmUk1sa3hjc3U1aXhWUjQrZUJkQUc5?=
 =?utf-8?B?U3VXSmIrcFZCcXdWTUVEWHZ5Q1NURHBYNG1Lek5namRVbWducUNrVTF3UU81?=
 =?utf-8?B?SWNDOFJHMTJsdzN4bGJFOFQ1YXhTdXV6SW5TRHNYREFNRzhtNmcvRmI5SXdz?=
 =?utf-8?B?NnpKQkN0V3hsd1ZpTlNvcE1kbDZ2U3QwQTk0RXJFOGowbURtRTlZK2x4NTVn?=
 =?utf-8?B?T3Q5dzd6NDg3aVNVbFlhbEpjeWt4cFRpblMxVkFnRTZBNy9ZQ0R5NldkelE2?=
 =?utf-8?B?OHhhRm1zcjVVaFMyeHY0N1ZwY0t0UEVOd0ZSMkxadmlQWklxTDJDRkVrNzBy?=
 =?utf-8?B?RzduNFY1TkdiOXpFL09lYkZTZDF5dkZEQXpIbk9haENQdUw4SFFRbVA1N290?=
 =?utf-8?B?Zm5DS2grcG12YlNGSWdBMHJGRlptM3krMDNvU2xid3Q5MHprYVJhalNyOFQx?=
 =?utf-8?B?M1pxKzdLdkx4ejF4bWFZdTNmTkhpMHZLakVOZmNWY3B2bGx5eElKazhuNFp1?=
 =?utf-8?B?aGw1bW82V1VIYXRPVEROY251UHZJZk5rWmFQZ1NNWENaQ3RWL3pMYlhMczAy?=
 =?utf-8?B?OTVhMEMxWXMvSTJSN3dxMXFlUTAyTDVxWEZZeVcwZ2Y1ckk0MnM1S2Q1OU9h?=
 =?utf-8?B?SnhybXVYemlERWpXMlNoUm50QnFQNFhyOTFFWmVRL25hRk03em1wT2UwRHVy?=
 =?utf-8?B?RDZDRTFPc1lib2RrK1BuVmkrdkkxUU0vQ1hFMmhUYUFyS01RZUJMRUx6NGtQ?=
 =?utf-8?B?NS84YTFJblpjTUJkVDNpcDh6b01uSXo4Z2toSmxaUDJoZnZTbGcxYmtKSzdt?=
 =?utf-8?B?dDFReEZ5V3V3aHpHcnpLZ0dOdG9uLy9NOGtGOW9PSnFKblBJTHUweUtqOE5n?=
 =?utf-8?Q?OBFe/m7wRw3Ihl2mKgvsBG7vD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28FB824C46AAF9438447C91B2DB1A11B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b497712-c71a-47d5-eb18-08db39fc6b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 19:47:30.2427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rO6tHg6s4OSKOaGD41qk/nPOlXN31d9QOtllZndzvW9qW3qUC9RcGIsWeFOYVbD/cGh8DPsPQkxyAPQMvFBLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7595
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXByIDEwLCAyMDIzLCBhdCAxMjo1MiBBTSwgSHVhbmcgWWluZyA8eWluZy5odWFu
Z0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gMERheS9MS1AgcmVwb3J0ZWQgYSBwZXJmb3JtYW5j
ZSByZWdyZXNzaW9uIGZvciBjb21taXQNCj4gN2UxMmJlYjhjYTJhICgibWlncmF0ZV9wYWdlczog
YmF0Y2ggZmx1c2hpbmcgVExCIikuIEluIHRoZSBjb21taXQsIHRoZQ0KPiBUTEIgZmx1c2hpbmcg
ZHVyaW5nIHBhZ2UgbWlncmF0aW9uIGlzIGJhdGNoZWQuICBTbywgaW4NCj4gdHJ5X3RvX21pZ3Jh
dGVfb25lKCksIHB0ZXBfY2xlYXJfZmx1c2goKSBpcyByZXBsYWNlZCB3aXRoDQo+IHNldF90bGJf
dWJjX2ZsdXNoX3BlbmRpbmcoKS4gIEluIGZ1cnRoZXIgaW52ZXN0aWdhdGlvbiwgaXQgaXMgZm91
bmQNCj4gdGhhdCB0aGUgVExCIGZsdXNoaW5nIGNhbiBiZSBhdm9pZGVkIGluIHB0ZXBfY2xlYXJf
Zmx1c2goKSBpZiB0aGUgUFRFDQo+IGlzIGluYWNjZXNzaWJsZS4gIEluIGZhY3QsIHdlIGNhbiBv
cHRpbWl6ZSBpbiBzaW1pbGFyIHdheSBmb3IgdGhlDQo+IGJhdGNoZWQgVExCIGZsdXNoaW5nIHRv
byB0byBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZS4NCj4gDQo+IFNvIGluIHRoaXMgcGF0Y2gsIHdl
IGNoZWNrIHB0ZV9hY2Nlc3NpYmxlKCkgYmVmb3JlDQo+IHNldF90bGJfdWJjX2ZsdXNoX3BlbmRp
bmcoKSBpbiB0cnlfdG9fdW5tYXAvbWlncmF0ZV9vbmUoKS4gIFRlc3RzIHNob3cNCj4gdGhhdCB0
aGUgYmVuY2htYXJrIHNjb3JlIG9mIHRoZSBhbm9uLWNvdy1yYW5kLW10IHRlc3QgY2FzZSBvZg0K
PiB2bS1zY2FsYWJpbGl0eSB0ZXN0IHN1aXRlIGNhbiBpbXByb3ZlIHVwIHRvIDIuMSUgd2l0aCB0
aGUgcGF0Y2ggb24gYQ0KPiBJbnRlbCBzZXJ2ZXIgbWFjaGluZS4gIFRoZSBUTEIgZmx1c2hpbmcg
SVBJIGNhbiByZWR1Y2UgdXAgdG8gNDQuMyUuDQoNCkxHVE0uDQoNCkkga25vdyBpdOKAmXMgbWVh
bmluZ2xlc3MgZm9yIHg4NiAoYnV0IHBlcmhhcHMgQVJNIHdvdWxkIHVzZSB0aGlzIGluZnJhDQp0
b28pOiBkbyB3ZSBuZWVkIHNtcF9tYl9fYWZ0ZXJfYXRvbWljKCkgYWZ0ZXIgcHRlcF9nZXRfYW5k
X2NsZWFyKCkgYW5kDQpiZWZvcmUgcHRlX2FjY2Vzc2libGUoKT8NCg0KSW4gYWRkaXRpb24sIGlm
IHRoaXMgZ29lcyBpbnRvIHN0YWJsZSAoYmFzZWQgb24gdGhlIEZpeGVzIHRhZyksIGNvbnNpZGVy
DQpicmVha2luZyBpdCBpbnRvIDIgcGF0Y2hlcywgd2hlbiBvbmx5IG9uZSB3b3VsZCBiZSBiYWNr
cG9ydGVkLg0KDQo=
