Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE2C69EB22
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjBUXVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBUXVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:21:07 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2044.outbound.protection.outlook.com [40.107.113.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2994A2BEFE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:20:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBSsI79DjYtmH5K9kzlplGTAozOCHpMEt++CrLTK8pIXCiP86WcQO6LzH7ciHcSLQaH2aEV5bcHVmHTfbknf3ifGobNiwERlP4ArN8WTGnj/0a+d5q9cpdMJ1EsXZTTpumArkCrpyyLcj5VHCO0+g42GgKcuopvqfIvCQgbzTth5fCiIuyrV+KXyPUvYZpzW7TsePQx1yyDUj3254gjNr0FNad72EvKdVgz4Gc5BcJluDYnVD7WIMr2JhIKBxPvF47IBDNrj7bkWWv07cs1oeaxmR1MXr50LvTycqDy8xCw1J70m4YGcXsnpPax+6dNc0vSOlVIMkh0eZtHt9gyYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJ/te7jK2tw5t58thEEcrH8FvgEg2RriXj25y8KddMw=;
 b=m7fCy/x3//Hkw1srq/SCot64C7Zrz9JKFz2wVBzQXPDRCK8C5N+TLtkECjfY5ag4VDwmYv9ohrvXEo0V+wGB7TRQzo5fvMTgpPzpf/7Mca3fe70DKfJSkhBxaKFAyJo/H8ozM2PI/S+l4OtqGZ/tR4b4HlHEoDBPTqkwSm+91kl1ETny6t8JTIpt393zrvvWSGUc2EI8NMvm9dTF+Xnq+c/wFTdBx52gE9ytm+hKxznyXQOYd8GUugkHOQL7gw3XNZRroBjHIcyQ94m6vvKZzr+qiHHNCo4T1WbnKqVv8RR6URp52toqfTOdGXWD5zsCHGANagtx8VX/6ezWHs5Ynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJ/te7jK2tw5t58thEEcrH8FvgEg2RriXj25y8KddMw=;
 b=AUrD2/hGTCDAQFnrEmfirrQxEfBdRuGgxy/XmDtRh/SUtR9T4q/2nPLYrbjEW1eo8Fe/Tj4B1coJd8V4JVWD35nv1t23cXmKhz/exwlYQwVSCLbGAXjc6Bm1UwZcNN+7T9qZ7V58uN9S29f0h6FnabKlUoVMbrpAWjQb7pOXgHk=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB12020.jpnprd01.prod.outlook.com (2603:1096:400:37c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18; Tue, 21 Feb
 2023 23:20:54 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::3924:5b48:7ad7:ab0%5]) with mapi id 15.20.6134.018; Tue, 21 Feb 2023
 23:20:54 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mm/hwpoison: convert TTU_IGNORE_HWPOISON to
 TTU_HWPOISON
Thread-Topic: [PATCH v1] mm/hwpoison: convert TTU_IGNORE_HWPOISON to
 TTU_HWPOISON
Thread-Index: AQHZRdLYDSG200rqhkSrDuaac6ickK7ZZx+AgACjcIA=
Date:   Tue, 21 Feb 2023 23:20:54 +0000
Message-ID: <20230221232037.GA1153975@hori.linux.bs1.fc.nec.co.jp>
References: <20230221085905.1465385-1-naoya.horiguchi@linux.dev>
 <Y/TIq05CjrMyg7f0@casper.infradead.org>
In-Reply-To: <Y/TIq05CjrMyg7f0@casper.infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYCPR01MB12020:EE_
x-ms-office365-filtering-correlation-id: 9292a6e4-9472-489e-b442-08db146247a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RRC3tn0a7+iPkZNuLz6F/ZL/FYULj6Sz2uhNmlpp0ux9NSIapTv2/zUa+55l6PUDIyBcllGxryuLqcZhsONl67/8R362SHVdtI6x1Hn1Ly4po3xbrzw7QnKU6RydPRw8o5R4U8maesT7O+iQxbJtSmTYwxpzJjU/b51MJ7v9slBz6cH/iIRuvNtToJoY77wt49UZKLTSqiffasd+fgo3g5FpbtnbWaylP4pODqDgJco5KFuPvgFWbo/1ZiVGTeZtsFUqHrXR9i5xnUl72llA71oG5Gc8URYKjBZwgpt9GEZNh9+xCbEkLpl0DhrAqE4Eof7x7RGV9XtNsZvSFiQ3Nhe+5biZH7AaR6+o7YBSxoiAMHDMlFgRueZb8qmXkUA8e+7Y8/fr7LFfAeQxanaI9hbcpKBFCh81UzrZNO5CjXe2KqXrUD3Sv219Wi1EnceQ7lXqW0eP1760xSHqJJ4k1949Ci5ltGqgMp35bUuK0QjNui/b4DtaOxGVkw58VI8P6ZCXJlqz0CHV7yWIsXFd4gQComk0jbh/I9RHL2O7ZkNh7OxPmDDSPJ+3zJCzm0jF04m2+nkIi88oT+gyLnE8ZNQmsrNvKfktEEx8LVh4mxC1kzMbFmaBFVUK/1p0UgXFaqfDU/qs2eRMz0hYIxpatKuE4NzshjwyyOryagDCbF/3HmtMgHNdQIzvXfdIPAjoeuVIP1CIn7mSMD+A1wSxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(26005)(9686003)(6512007)(6486002)(186003)(55236004)(4326008)(6916009)(66946007)(66556008)(66476007)(64756008)(66446008)(8676002)(76116006)(83380400001)(5660300002)(85182001)(8936002)(7416002)(1076003)(6506007)(71200400001)(478600001)(316002)(41300700001)(54906003)(38100700002)(86362001)(122000001)(82960400001)(38070700005)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVBqMEo0SW5STVR3b3pIOEp3Vy8zY2htNENQVTN3SDhudFVUYldDb1RuRFgv?=
 =?utf-8?B?ckJIN2liRzNra1RDVWpFZ2ViK2lyMGZQckhCWUZxYWQzdXNPK3U0Z1VqQVM2?=
 =?utf-8?B?NHdqSVhmTXBRMkp6K29rUWtIUUVWeTRBSEdtMzZ5VU0yWWJNU3pka2JweHNG?=
 =?utf-8?B?RHhRZnpwNVpEempLU0dkejNxL1hrZTBmWUpCNkxpZ1NFYit0QUEvTXlDMnc0?=
 =?utf-8?B?QU9odHRlQ0JDM2sydFZVWWRNWmFuWnBKZnJlNEVBcGRwYTBSdkxEOEIwTUlF?=
 =?utf-8?B?emhqd1NrVXdreDVzZ0lNVWtpaThTYTlyeFNacklzdFdlQnhLQVRMbHMxTjBy?=
 =?utf-8?B?T2JKdEdSbjczUldPUVZmaEYveDVERTIrL2dybFRsSzFxc202dGdaV1NzV1R4?=
 =?utf-8?B?SUtDYmpWYlZjR1NlT1JQT3J0UVhUSElOR29IQzIxNlREVkVXTlQ0SmRsanB2?=
 =?utf-8?B?cGx4SzdPd09qV0FUNmRNbkp3bDd0c2VKc1MyQnZJQ1RoZ0ZiQXYrbzhmUDhz?=
 =?utf-8?B?VXhseThyRFFFOGxNbVFwb2N3OEhpM2hlUk5qaWVZT3dVK3N0QXpCRTdPb1JW?=
 =?utf-8?B?UW05L0JiaUt2RDVmM0Rra3J4U1p3bWRSME96TFRmYmpMdmtOTGdFL25taHQv?=
 =?utf-8?B?L29iQjJKWndXWFg4WXBoNVNHL21lZjMvQ0JWd3d4LzloZ0NzU1lBL3BtT3NQ?=
 =?utf-8?B?N1JWTUNyQUZsR0o1ak03aDNub3VPWmNueHk3ejlRRUo4cDB1eTUwbk9qaUFo?=
 =?utf-8?B?SGorcVhoSlVvVlhvRXlxeGZ1ZldTY0g3R2hoTXRPU2tLeHJ1MCtCR2RmdDFX?=
 =?utf-8?B?QlFoV0JGamZHdnNiVHI4YjlUWlR1SkxVNGwxNjV1b01WcC95U2Uzcm1Qd3Yx?=
 =?utf-8?B?L0lSbjQvUTE0dlAyb05VME15WlkwOEZCbkFNMllQZ00rb2g5dDBidVcvbUIy?=
 =?utf-8?B?YW5wekg4YUdrektJcG0xUEI1YVhmQVp4NmpoMzRTZm5ZMUpYUk9HMkF2K291?=
 =?utf-8?B?d3N6d3gyM0FrRmptMzR4eXphVDVHTHdBTFV3c2c1UDF1Q0ExRXhEQi8zZ2pO?=
 =?utf-8?B?OXAyN2prOXdmK2pNaytuVGl4Rys0aUtPN29QOWxmUTlRc2Q5Y2w3aEdiZm93?=
 =?utf-8?B?UUQ1ZzJLMUM5bXMyb2VGemxUQjNjMmNscGNhT1YraUZ6LzV4Yk92TElxOW1X?=
 =?utf-8?B?blQvYTJwbkJFWVNNZjBDRjR4MmpFaTVmclE5TnFibXIxVGpDS3hWUThmN0pk?=
 =?utf-8?B?TWU4Wm9HYjlJa25oMzNaV1RjaHlCMkdWMWQvVmVpZVY4S3BpNGUyc1RHbXor?=
 =?utf-8?B?VjdoTW10a0ZBR0E2L3g4T3ZmZkpMcms4MW02cHBVYnFKUWhjREI3azdHckNV?=
 =?utf-8?B?UCtpOTl3UXZtRmVGeHhFc1JFZVJoTFFmN3RBdnVDdkNNTjk0b3Y0NjE1WExn?=
 =?utf-8?B?T2FORkxqYWg0V3Rpc2VBYWNDdThvblI5Q0hYc2piZWVVd3RiRGZmTTYvUVcx?=
 =?utf-8?B?d1c3aTY2ZkFJZWlxUlVBTmgrUEN1OVJPeHFDS3liWEgxcEh6bGdaV1dXOURJ?=
 =?utf-8?B?SUFubTM5c0NyYnRqNjQyOW1IV0Y1b2JKYTVPRGRnNWYxUzRRT3A1b3l1RjQ0?=
 =?utf-8?B?RUpXNXNCekZQS2swZm1zRTFad2lNYlQvZ29vUzZnV1pTclhFZ2pNVGRQTDVT?=
 =?utf-8?B?QnA5SXZiMGozK2l0bmxVQ2JzSjkwL1pKN0d2N2dJaEZkdTByL01wTWpDYnRq?=
 =?utf-8?B?blo1SEVUZ1pQU0xiN2NEU1h4UTZKR1VhTWJXODREZi9rcE9LZ0w3VFV3ZFZV?=
 =?utf-8?B?aVYrTVdDOUZleFR4UFRPVkNTVnBicWMwdDdaTFFHSldoTytYaDFpNzgzbDRU?=
 =?utf-8?B?OUpTQy9nQUF4bkxEZmtidGx4ekRrdkRudFpDbGRJZjZEWEYxOWMzWVhSVzhi?=
 =?utf-8?B?cXZVQXZtYWhRMlIwWVRCRHZHdEZ4VmhDSjRpOE9TZnJRVzMreW1YSnZLVExr?=
 =?utf-8?B?M1FjamxtYi9CZ2R3SUhPZnNLTWtSY3J5dW9RUUhqVW9sOTg3dlB3bnVhdUZT?=
 =?utf-8?B?OVBtZThDT1AvSUVkeTRyWmxJRWFlbEZwd1ZwM1pzVkZINEM4NTFHSHV4bHdo?=
 =?utf-8?B?VEZPQnhlZ1NXZW0vN2M0bnNHTEVsbmxCZmdsWnVEQmQ0ZXhNWHU0OTQ1TnJK?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DA79A3686F5B44F8C9C3F58A9A28D8A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9292a6e4-9472-489e-b442-08db146247a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 23:20:54.3915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kEp8neBEop8JaBrIOuFmk3tIVLDgg0QtnYBAai4sjBTn5aVK5IZCtHS/FA4ynPYWrLSZvt74Kr2VggoyyKPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBGZWIgMjEsIDIwMjMgYXQgMDE6MzU6MzlQTSArMDAwMCwgTWF0dGhldyBXaWxjb3gg
d3JvdGU6DQo+IE9uIFR1ZSwgRmViIDIxLCAyMDIzIGF0IDA1OjU5OjA1UE0gKzA5MDAsIE5hb3lh
IEhvcmlndWNoaSB3cm90ZToNCj4gPiBBZnRlciBhIG1lbW9yeSBlcnJvciBoYXBwZW5zIG9uIGEg
Y2xlYW4gZm9saW8sIGEgcHJvY2VzcyB1bmV4cGVjdGVkbHkNCj4gPiByZWNlaXZlcyBTSUdCVVMg
d2hlbiBpdCBhY2Nlc3NlcyB0byB0aGUgZXJyb3IgcGFnZS4gIFRoaXMgU0lHQlVTIGtpbGxpbmcN
Cj4gPiBpcyBwb2ludGxlc3MgYW5kIHNpbXBseSBkZWdyYWRlcyB0aGUgbGV2ZWwgb2YgUkFTIG9m
IHRoZSBzeXN0ZW0sIGJlY2F1c2UNCj4gPiB0aGUgY2xlYW4gZm9saW8gY2FuIGJlIGRyb3BwZWQg
d2l0aG91dCBhbnkgZGF0YSBsb3N0IG9uIG1lbW9yeSBlcnJvcg0KPiA+IGhhbmRsaW5nIGFzIHdl
IGRvIGZvciBhIGNsZWFuIHBhZ2VjYWNoZS4NCj4gPiANCj4gPiBXaGVuIG1lbW9yeV9mYWlsdXJl
KCkgaXMgY2FsbGVkIG9uIGEgY2xlYW4gZm9saW8sIHRyeV90b191bm1hcCgpIGlzIGNhbGxlZA0K
PiA+IHR3aWNlIChvbmUgZnJvbSBzcGxpdF9odWdlX3BhZ2UoKSBhbmQgb25lIGZyb20gaHdwb2lz
b25fdXNlcl9tYXBwaW5ncygpKS4NCj4gPiBUaGUgcm9vdCBjYXVzZSBvZiB0aGUgaXNzdWUgaXMg
dGhhdCBwdGUgY29udmVyc2lvbiB0byBod3BvaXNvbmVkIGVudHJ5IGlzDQo+ID4gbm93IGRvbmUg
aW4gdGhlIGZpcnN0IGNhbGwgb2YgdHJ5X3RvX3VubWFwKCkgYmVjYXVzZSBQYWdlSFdQb2lzb24g
aXMgYWxyZWFkeQ0KPiA+IHNldCBhdCB0aGlzIHBvaW50LCB3aGlsZSBpdCdzIGFjdHVhbGx5IGV4
cGVjdGVkIHRvIGJlIGRvbmUgaW4gdGhlIHNlY29uZA0KPiA+IGNhbGwuICBUaGlzIGJlaGF2aW9y
IGRpc3R1cmJzIHRoZSBlcnJvciBoYW5kbGluZyBvcGVyYXRpb24gbGlrZSByZW1vdmluZw0KPiA+
IHBhZ2VjYWNoZSwgd2hpY2ggcmVzdWx0cyBpbiB0aGUgbWFsZnVuY3Rpb24gZGVzY3JpYmVkIGFi
b3ZlLg0KPiA+IA0KPiA+IFNvIGNvbnZlcnQgVFRVX0lHTk9SRV9IV1BPSVNPTiBpbnRvIFRUVV9I
V1BPSVNPTiBhbmQgc2V0IFRUVV9IV1BPSVNPTiBvbmx5DQo+ID4gd2hlbiB3ZSByZWFsbHkgaW50
ZW5kIHRvIGNvbnZlcnQgcHRlIHRvIGh3cG9pc29uIGVudHJ5LiAgVGhpcyBjYW4gcHJldmVudA0K
PiA+IG90aGVyIGNhbGxlcnMgb2YgdHJ5X3RvX3VubWFwKCkgZnJvbSBhY2NpZGVudGFsbHkgY29u
dmVydGluZyB0byBod3BvaXNvbg0KPiA+IGVudHJpZXMuDQo+ID4gDQo+ID4gRml4ZXM6IGE0MjYz
NGE2YzA3ZCAoInJlYWRhaGVhZDogVXNlIGEgZm9saW8gaW4gcmVhZF9wYWdlcygpIikNCj4gDQo+
IEhvdyBkaWQgeW91IGNob29zZSB0aGlzIEZpeGVzIHRhZz8NCg0KSSB0aG91Z2h0IHRoYXQgYmVm
b3JlIHRoaXMgY29tbWl0IHRocHMgYXJlIGFub255bW91cyB0aHBzIG9yIHNobWVtIHRocHMsDQpi
b3RoIG9mIHdoaWNoIGFyZSBjb25zaWRlcmVkIGFzIGRpcnR5IHRocHMgKHdpdGggbm8gYmFja3Vw
IG9uIHN0b3JhZ2UpLg0KVGhlIHJlcG9ydGVkIHByb2JsZW0gYWZmZWN0cyB0aGUgY2FzZSBvZiBj
bGVhbiBmb2xpbywgc28gSSB0aG91Z2h0IHRoYXQNCml0IGdvdCB2aXNpYmxlIHNpbmNlIHdlIGNh
biBoYXZlIGNsZWFuIGZvbGlvcy4NCg0KQnV0IGluIG15IHNlY29uZCB0aG91Z2h0LCB0aGUgd3Jv
bmcgcHRlIGNvbnZlcnNpb24gY291bGQgYWxzbyBoYXBwZW4gb24NCmdlbmVyaWMgdGhwIHNwbGl0
ICh0aGF0IGhhcHBlbmVkIHRvIGhhdmUgbm8gZWZmZWN0IG9uIHZpc2libGUgYmVoYXZpb3IpLA0K
c28gSSBzaG91bGQndmUgc2V0IEZpeGVzIHRhZyB0byBvbGRlciBjb21taXQ/DQoNClRoYW5rcywN
Ck5hb3lhIEhvcmlndWNoaQ==
