Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247A76EFC09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbjDZU5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239948AbjDZU5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:57:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B352E13E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 13:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF5/l8DtRy1L/S30wqY66GoxcYdFwEWxZD3WQQlzKg4KHtsUzxc6lMuvuLjpolgryagkZtcc0DxCT4UAQlHbWRcuzaMKTh8eDlY6LlFMSzqkyyoJUsO//irGKFNry5/jwTwckjCU90zoftigl6mmb956VQee4encWYhJGQG2eX+zH/TmTzjbuAgaa9qWPRdPtl7lKSJcJTE78r/VpyVOzkFKIQ0yb9u16H0R1mC5uGT0VQWdRrTUH0Rjt1EYmwk4J8O47cgZcS01drsv2mYXt/mYoC97EE5uKaRiDL+Ia8H9O43DMrkry6S4VB0L/zIYuBY8k3HsjKYrUZpXfXcTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8lMYmyk8Map8sp/eMEha+4xVOZXmVhdgcbESWTXPKY=;
 b=Vvxa6EOZW5taaBgVzodToSY3Is/hY0iK6at4zRYbEbCTHLfh5SXgG4T4DyqILOf6nusiPQJhVbsP1bVQYnjKNTO4kK+n1mmRMpCp6HU4DMT6P2xrfPVD2rWe5zmImG7x3y16/UJTCmCKwLCndeh+O1OPSQOnl+WVyDQqDurUypPG5TIcEKvKV4GaYBnk4EW6HVulcPeztr055PoEZ2hpjDjxU0DcBdryxtriP7NnoVyFGfJqN5FU7sYCmsjNsg3mPcMPyT7L4usgb9OmNKs+0+aVFcxIVbM7XdVvD2eOABFBLZI5+vF8SGa6qBL+wi9yDt93muk+W+0Z3BpDXXrfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8lMYmyk8Map8sp/eMEha+4xVOZXmVhdgcbESWTXPKY=;
 b=1m+4smC/Shx3bGfXyH6xxo1C4KKLeruVoAeUy/g0PvAz2j1InGghsKpJPI2xc8VQbJlsGu2Y3yfVw2XZ4W/A4+EMM5qB+oorLfyue65JSjBVz0Qeo+aQsbk5xfO2/Hc1niZurVWGvzoz+RaAQWx2QLMEaeZfI4K9+xJp6wfTOSc=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by PH0PR19MB7425.namprd19.prod.outlook.com (2603:10b6:510:288::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Wed, 26 Apr
 2023 20:57:38 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8cb3:ef5b:f815:7d8c]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8cb3:ef5b:f815:7d8c%4]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 20:57:38 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Andrei Vagin <avagin@google.com>
CC:     "avagin@gmail.com" <avagin@gmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "posk@google.com" <posk@google.com>,
        "tycho@tycho.pizza" <tycho@tycho.pizza>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "wad@chromium.org" <wad@chromium.org>,
        "yu.c.chen@intel.com" <yu.c.chen@intel.com>
Subject: Re: [PATCH 3/6] sched: add a few helpers to wake up tasks on the
 current cpu
Thread-Topic: [PATCH 3/6] sched: add a few helpers to wake up tasks on the
 current cpu
Thread-Index: AQHZeHBZewdiUXwEBUq/gdxbUigVya89+5gAgAAW/YA=
Date:   Wed, 26 Apr 2023 20:57:37 +0000
Message-ID: <e7184ce2-06f6-5f45-1044-f0a8e8ad44c7@ddn.com>
References: <20230308073201.3102738-1-avagin@google.com>
 <20230308073201.3102738-4-avagin@google.com>
 <CAEWA0a68dgA_sZVV7YWrrvK1=GkpEW1KcF1FNcmFOkDx+QKxYA@mail.gmail.com>
 <1e5cb834-2769-abc6-12bb-6184cfdd3536@ddn.com>
In-Reply-To: <1e5cb834-2769-abc6-12bb-6184cfdd3536@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|PH0PR19MB7425:EE_
x-ms-office365-filtering-correlation-id: 1cad08e0-4b5f-4a6c-fbe9-08db4698de2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KnjKJjVUiU2r67ND5NRZC7/hy+prWv3WQB04Ufg2np6oAP9mVGqiJl/DiGHctHk44gjF5QQePhv2zSwsc1qpWaWg96folI4RoZ8hkVidwx2/7lDfbo4/v2a2yBb4XxicE4q026Lg0V5kHUu7rCVTKvntcdh0YPWxeknqxz4kBQwV5GPvOAfIs7+DsqRFUt3y+cDBhOXp+DXCtwqmJtwEy/P+kXegybv2Xil/87R8LH+jYeUmaDIdXYWNuvP9lxHxFj4qlqPtlBrJ2dvHJ4/7OnvcbI4NRL+gani0PLOshPMgRfGrU6Bxi0z0lofhGX06GIf6OeEl4+um01xW1a8a1J2H+qfBc7R1x4hPsIRBIT4SVFXCunHnmAdRKvFY4yYyFzqhpqU0jquyGXdGVcakFcY12pdHtYL7xJ2B4c4R6oFlqz7FMzJKYHHgdb/ZZnEevOT/F3VbQlyTDXXakabLGP3XLk7uD+nqYO5MCfuPRjPCq+68hnr/fZPod0FQz0UOAEfmSQsDpOdoBy0g/mLsWtdBQr8pBy6F9Ws1DU7VBxLgdXPiHigH9oKETbDmH2Q6wOarwZLKjCdG/5BL2cUR2fwOTtio1Sow79CFQzivTEmIgKZHAb5V2QEQSFhBu8wKj6t2NQdF/lVwjDl88MBF1A6dxyfbL0aGXpxgJgxI76w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(366004)(376002)(396003)(346002)(451199021)(31686004)(186003)(38070700005)(2906002)(2616005)(36756003)(54906003)(6506007)(53546011)(6512007)(86362001)(31696002)(6916009)(83380400001)(41300700001)(7416002)(966005)(5660300002)(71200400001)(6486002)(8676002)(8936002)(122000001)(316002)(478600001)(38100700002)(66946007)(66476007)(66556008)(76116006)(4326008)(64756008)(66446008)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU1jN2NVTG9VSjM2dVBwcVA4WEQ4RysycXhNa3V3djUzUGZXTXFhR0JtUEJH?=
 =?utf-8?B?V21VbzRGT003Nmd3cHZoNUk1N2hYY2w4MkRTUDhFdElRcFpBVk1xRXZzeEgx?=
 =?utf-8?B?Z3lhWW5LSEl4T2psRW1zb0RrZHAxQ1ZQVlg3V0ExYUZqaTN0UzAveVVqenJw?=
 =?utf-8?B?aC81YWR6blVRQlVsRWZqeVc3UEMyakU2ZHlOT3R4c2RDU2REMFJiMlVFVWx1?=
 =?utf-8?B?V1lSM3gxNTVNZWlaMXdDMkxnMEg5Zys5OXJQL1NrcE9WRmdFUXdRS1BlbWVN?=
 =?utf-8?B?clBYc0JHMlM3amFESjh1Z1NVcmNqTC90Zm1UaG9DS3NJemZDNkNodHlTUUdT?=
 =?utf-8?B?bXJJQ2kzZHNpUjRZSDE1WnF1bHk2Snk3VTUxcHlEeGlrVkE2ODBWZDlETVJs?=
 =?utf-8?B?Yk1xaGNKR1NvSVdqbHNwOHR0UXpmWVVMMzROLzhjeFN4WFV0bC9qUXF6ZUZ0?=
 =?utf-8?B?YllYRWtBaXVYTlBBL2RwUnZZaVNlbEpKNlhsSG1OU1NqR2xZQXNaK2c2OExN?=
 =?utf-8?B?cmZsQkZSS3ZWaGNxdE43UVZEcDRZOEhCN3BBSmJhMlFucmVsZ1F0MGxWN1Jh?=
 =?utf-8?B?OUYvMHFOTSs5NDI4Wnk5WEp5d3dxM1ZoNFE4MHNES3hHbG9pb1BJb1NieC8r?=
 =?utf-8?B?bUlFemt3YWVHSTF5Y2VRdEVJclNPUjNaMnhQTWo0c0tISE9NeDdaWEJEL05X?=
 =?utf-8?B?OU52bVhqLzNnMDRqNWxrMk1NYmQ0R2dQMmQ4U2FaelJTR1g3VlBCeVEyTmJE?=
 =?utf-8?B?cVc2bUJXZDJKUlByd3JVTk9GTXJmR0YxQUZ4eTRMVVZtaktFdTh3Zlg3OFRT?=
 =?utf-8?B?dkZXNGZWaFFLYlJuTmJEN1JhQTJjcVdWeWdFVm9CN01aK3A3eFhqVnorVUpY?=
 =?utf-8?B?dWphSTBSOXdKbURPemNpLy8vTW92YU05b01sL2RGQUl6SkJmM0MyQ2JtZEVC?=
 =?utf-8?B?OGo3M3EwbFFjNE9SNGg5Q284RzhlREI5bjVNa3NrMXRXMCtLNEtGd01kWkQx?=
 =?utf-8?B?Vlo1WnBEQ3RlbWJKanNkd0kwQUZGRjVMV1ZVT0o1NlRydGxoUTVRRkhUd2hI?=
 =?utf-8?B?N1B1TDlTVHQvZzM0aVJTTmx3L29KdFd2YStGMm92allqL1Rwc1FGY3UzamVB?=
 =?utf-8?B?L1U2YXZoQlpvWWNCcWFlcHdVZitpVFVoZzdPU1UzQkhzeWFsMG9rMnFPN2Nh?=
 =?utf-8?B?RDBhaVgzMTJsRE1OY0VBL3BabUJLSlF3WlgwQlFPL1I0Z0IwNlZSVndtQkI5?=
 =?utf-8?B?Ky9nUldlR25oRStlRjlnYXB6SkpUUktPOVJPa0pSSmRQMHR4Q3ZFVnFWSHdV?=
 =?utf-8?B?NnRVK3R2UERvMlR4bEwwS0NmNzc5eS9SekpoWUE4cjNIaUtIVTAwRnFkSmp4?=
 =?utf-8?B?cWdhbmFDbU5zS01xZ0dGOXlqWml1ZUZZMWVwdmlzekFJTUU5RDZCeWxQZXhq?=
 =?utf-8?B?Rms4TDVSRDlSU0xOS29Sc3hBdnRreFdpVVBFRUYyOWI3QmpuNXpsSmllUUF0?=
 =?utf-8?B?eUFHcUYvcDJxUTU4UlE2VWlFbUtTOElISXpvTVdrb2ErcGpjMzNzT0RQdVN0?=
 =?utf-8?B?T1VyV3U5VzNiYWsyWmloTW02S05od1ZzcnJ2QjFxNU9ZUW9iSGMxcm1nY3dZ?=
 =?utf-8?B?RDU0ckNFTGFEOFFERWRJc1RZYTJkWDZxSWtyS1AzZ29mb1MvUS9iMTg1MHkz?=
 =?utf-8?B?OTdnMTJTM2lUQ0M0THJFbVZRMU9hRm1mWURLa2xveWRycGhPRmR1NkxmMEJm?=
 =?utf-8?B?dkZqYkJYRTFSdG8zZEZSMytleHRxQi9EVjBLU2RaVWduOUhNYitHdGp3UHBI?=
 =?utf-8?B?T2NVOTJaWjQwd1lacmN5dGxNTHE0VzV5VDVkMXBoekRBY3lCYVV2bWRDTmRi?=
 =?utf-8?B?NU9MMjFpR1RmQklsUEx5Sm1aSkcwY3FiMU1jNzNWUVM2VXhvTzFFcHN1UTlC?=
 =?utf-8?B?aDIwYjhEbmZJOWF5OHNselpDWWVCRUUyZ3lSUmZweFZ2MUdmQzRWb29XYng3?=
 =?utf-8?B?MHh6MzNVMHJpWjgvc24yREI0bWdvVTBPRGJ3RmE3czhrVHV5ajBQajRDR3ll?=
 =?utf-8?B?WXRsbGxEK1czSnVHZk8wZUEraWEyVDAxSURWakhCL1FyUWZScXFhOU1VWXpy?=
 =?utf-8?B?TlFiR1RlbzZkWW9ZNE5RdllQWnV0RmRIajVrazduZ0ZIY2I0WTdEOW1VTGpm?=
 =?utf-8?Q?aMFlcss7kC5sf2toRZiQeHg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <922DA18490286D4499DB388283D89D69@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cad08e0-4b5f-4a6c-fbe9-08db4698de2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 20:57:37.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4IahPfIE9ibNqgl4hfIRdET4mb7GydavM1MJgFaKZLDboQGRrLw0Z/ruOvPcqKY9ILGowLLutdTiC2PC0yeNZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7425
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNi8yMyAyMTozNSwgQmVybmQgU2NodWJlcnQgd3JvdGU6DQo+IE9uIDQvMjYvMjMgMjA6
NTIsIEFuZHJlaSBWYWdpbiB3cm90ZToNCj4+IE9uIFdlZCwgQXByIDI2LCAyMDIzIGF0IDc6NDPi
gK9BTSBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+IHdyb3RlOg0KPj4+DQo+Pj4+
IEFkZCBjb21wbGV0ZV9vbl9jdXJyZW50X2NwdSwgd2FrZV91cF9wb2xsX29uX2N1cnJlbnRfY3B1
IGhlbHBlcnMgdG8gDQo+Pj4+IHdha2UNCj4+Pj4gdXAgdGFza3Mgb24gdGhlIGN1cnJlbnQgQ1BV
Lg0KPj4+DQo+Pj4+IFRoZXNlIHR3byBoZWxwZXJzIGFyZSB1c2VmdWwgd2hlbiB0aGUgdGFzayBu
ZWVkcyB0byBtYWtlIGEgDQo+Pj4+IHN5bmNocm9ub3VzIGNvbnRleHQNCj4+Pj4gc3dpdGNoIHRv
IGFub3RoZXIgdGFzay4gSW4gdGhpcyBjb250ZXh0LCBzeW5jaHJvbm91cyBtZWFucyBpdCB3YWtl
cyANCj4+Pj4gdXAgdGhlDQo+Pj4+IHRhcmdldCB0YXNrIGFuZCBmYWxscyBhc2xlZXAgcmlnaHQg
YWZ0ZXIgdGhhdC4NCj4+Pg0KPj4+PiBPbmUgZXhhbXBsZSBvZiBzdWNoIHdvcmtsb2FkcyBpcyBz
ZWNjb21wIHVzZXIgbm90aWZpZXMuIFRoaXMgDQo+Pj4+IG1lY2hhbmlzbSBhbGxvd3MNCj4+Pj4g
dGhlwqAgc3VwZXJ2aXNvciBwcm9jZXNzIGhhbmRsZXMgc3lzdGVtIGNhbGxzIG9uIGJlaGFsZiBv
ZiBhIHRhcmdldCANCj4+Pj4gcHJvY2Vzcy4NCj4+Pj4gV2hpbGUgdGhlIHN1cGVydmlzb3IgaXMg
aGFuZGxpbmcgYW4gaW50ZXJjZXB0ZWQgc3lzdGVtIGNhbGwsIHRoZSANCj4+Pj4gdGFyZ2V0IHBy
b2Nlc3MNCj4+Pj4gd2lsbCBiZSBibG9ja2VkIGluIHRoZSBrZXJuZWwsIHdhaXRpbmcgZm9yIGEg
cmVzcG9uc2UgdG8gY29tZSBiYWNrLg0KPj4+DQo+Pj4+IE9uLUNQVSBjb250ZXh0IHN3aXRjaGVz
IGFyZSBtdWNoIGZhc3RlciB0aGFuIHJlZ3VsYXIgb25lcy4NCj4+Pg0KPj4+PiBTaWduZWQtb2Zm
LWJ5OiBBbmRyZWkgVmFnaW4gPGF2YWdpbkBnb29nbGUuY29tPg0KPj4+DQo+Pj4gQXZvaWRpbmcg
Y3B1IHN3aXRjaGVzIGlzIHZlcnkgZGVzaXJhYmxlIGZvciBmdXNlLCBJJ20gd29ya2luZyBvbiBm
dXNlIA0KPj4+IG92ZXIgdXJpbmcNCj4+PiB3aXRoIHBlciBjb3JlIHF1ZXVlcy4gSW4gbXkgY3Vy
cmVudCBicmFuY2ggYW5kIHJ1bm5pbmcgYSBzaW5nbGUgDQo+Pj4gdGhyZWFkZWQgYm9ubmllKysN
Cj4+PiBJIGdldCBhYm91dCA5MDAwIGNyZWF0ZXMvcyB3aGVuIEkgYmluZCB0aGUgcHJvY2VzcyB0
byBhIGNvcmUsIGFib3V0IA0KPj4+IDcwMDAgY3JlYXRlcy9zDQo+Pj4gd2hlbiBJIHNldCBTQ0hF
RF9JRExFIGZvciB0aGUgcmluZyB0aHJlYWRzIGFuZCBiYWNrIHRvIDkwMDAgd2l0aCANCj4+PiBT
Q0hFRF9JRExFIGFuZA0KPj4+IGRpc2FibGluZyBjcHUgbWlncmF0aW9uIGluIGZzL2Z1c2UvZGV2
LmMgcmVxdWVzdF93YWl0X2Fuc3dlcigpIGJlZm9yZSANCj4+PiBnb2luZyBpbnRvDQo+Pj4gdGhl
IHdhaXRxIGFuZCBlbmFibGluZyBpdCBiYWNrIGFmdGVyIHdha2luZyB1cC4NCj4+Pg0KPj4+IEkg
aGFkIHJlcG9ydGVkIHRoaXMgYSBmZXcgd2Vla3MgYmFjaw0KPj4+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvZDBlZDFkYmQtMWI3ZS1iZjk4LTY1YzAtN2Y2MWRkMWEzMjI4QGRkbi5jb20v
DQo+Pj4gYW5kIGhhZCBiZWVuIHBvaW50ZWQgdG8geW91ciBhbmQgUHJhdGVla3MgcGF0Y2ggc2Vy
aWVzLiBJJ20gbm93IGdvaW5nDQo+Pj4gdGhyb3VnaCB0aGVzZSBzZXJpZXMuIEludGVyZXN0aW5n
IHBhcnQgaXMgdGhhdCBhIGZldyB3ZWVrcyBJIGRpZG4ndCBuZWVkDQo+Pj4gU0NIRURfSURMRSwg
anVzdCBkaXNhYmxpbmcvZW5hYmxpbmcgbWlncmF0aW9uIGJlZm9yZS9hZnRlciB3YWtpbmcgdXAg
d2FzDQo+Pj4gZW5vdWdoLg0KPj4+DQo+Pj4gWy4uLl0NCj4+Pg0KPj4+PiBFWFBPUlRfU1lNQk9M
KHN3YWtlX3VwX29uZSk7DQo+Pj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvd2FpdC5jIGIv
a2VybmVsL3NjaGVkL3dhaXQuYw0KPj4+PiBpbmRleCAxMzNiNzQ3MzA3MzguLjQ3ODAzYTBiOGQ1
ZCAxMDA2NDQNCj4+Pj4gLS0tIGEva2VybmVsL3NjaGVkL3dhaXQuYw0KPj4+PiArKysgYi9rZXJu
ZWwvc2NoZWQvd2FpdC5jDQo+Pj4+IEBAIC0xNjEsNiArMTYxLDExIEBAIGludCBfX3dha2VfdXAo
c3RydWN0IHdhaXRfcXVldWVfaGVhZCAqd3FfaGVhZCwgDQo+Pj4+IHVuc2lnbmVkIGludCBtb2Rl
LA0KPj4+PiDCoCB9DQo+Pj4+IMKgIEVYUE9SVF9TWU1CT0woX193YWtlX3VwKTsNCj4+Pg0KPj4+
PiArdm9pZCBfX3dha2VfdXBfb25fY3VycmVudF9jcHUoc3RydWN0IHdhaXRfcXVldWVfaGVhZCAq
d3FfaGVhZCwgDQo+Pj4+IHVuc2lnbmVkIGludCBtb2RlLCB2b2lkICprZXkpDQo+Pj4+ICt7DQo+
Pj4+ICvCoMKgwqDCoCBfX3dha2VfdXBfY29tbW9uX2xvY2sod3FfaGVhZCwgbW9kZSwgMSwgV0Zf
Q1VSUkVOVF9DUFUsIGtleSk7DQo+Pj4+ICt9DQo+Pj4NCj4+PiBJJ20gYWJvdXQgdG8gdGVzdCB0
aGlzIGluc3RlYWQgb2YgbWlncmF0ZV9kaXNhYmxlL21pZ3JhdGVfZW5hYmxlLCBidXQgDQo+Pj4g
dGhlIHN5bWJvbCBuZWVkcw0KPj4+IHRvIGJlIGV4cG9ydGVkIC0gYW55IG9iamVjdGlvbiB0byBk
byB0aGF0IHJpZ2h0IGZyb20gdGhlIGJlZ2lubmluZyBpbiANCj4+PiB5b3VyIHBhdGNoPw0KPj4N
Cj4+IEkgdGhpbmsgRVhQT1JUX1NZTUJPTF9HUEwgc2hvdWxkIG5vdCB0cmlnZ2VyIGFueSBvYmpl
Y3Rpb25zIGFuZCBpdA0KPj4gY292ZXJzIHlvdXIgY2FzZSwgZG9lc24ndCBpdD8NCj4gDQo+IEFo
IHllcywgc3VyZSwgX0dQTCBpcyBmaW5lLiBJIGhhdmUgYXBwbGllZCAyLzYgYW5kIDMvNiBpbiBt
eSBicmFuY2ggYW5kIA0KPiB0aGVuIGhhdmUNCj4gDQo+IHdhaXQuaA0KPiAjZGVmaW5lIHdha2Vf
dXBfaW50ZXJydXB0aWJsZV9zeW5jKHgpwqDCoMKgIF9fd2FrZV91cF9zeW5jKCh4KSwgDQo+IFRB
U0tfSU5URVJSVVBUSUJMRSkNCg0KU29ycnksIG5vLCB0aGF0IHdhcyB0aGUgcGFydCB0aGF0IGlz
IGFjdHVhbGx5IG5vdCB3b3JraW5nLCBJJ20gYWN0dWFsbHkgDQp1c2luZyBfX3dha2VfdXBfb25f
Y3VycmVudF9jcHUoJnJlcS0+d2FpdHEsIFRBU0tfTk9STUFMLCBOVUxMKSBpbiANCmZ1c2VfcmVx
dWVzdF9lbmQoKS4NCg0KPiANCj4gYW5kIGFuZCB1c2luZyB0aGF0IGluIGZ1c2VfcmVxdWVzdF9l
bmQoKSAtIHdvcmtzIGZpbmUgYW5kIG5vIG1pZ3JhdGlvbiANCj4gb24gd2FrZSB1cC4NCj4gVGhv
dWdoLCBJIHN0aWxsIG5lZWQgU0NIRURfSURMRSBmb3IgdGhlIHVyaW5nIHRocmVhZCB0byBhdm9p
ZCBhIGxhdGVyIA0KPiBtaWdyYXRpb24sDQo+IHdpbGwgb3BlbiBhIHNlcGFyYXRlIHRocmVhZCBm
b3IgdGhhdC4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IEJlcm5kDQo+IA0KPiANCg0K
