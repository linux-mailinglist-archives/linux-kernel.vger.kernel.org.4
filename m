Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8220C682C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjAaMOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAaMOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:14:53 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C186C40BE2;
        Tue, 31 Jan 2023 04:14:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkJiMxCRal9tZATjlcAJu5gnqG3bQ93DB77UXzVIdCdNTMHOJYqttRnY2oN7luWnPux/YW0leiamNdU1Aq4gsOdEAMXec8O8XULzH+CHW2FukWoV+Lx3uxCZdCeiljCSCaOA4NWvT6Y5jiTxrxXI+KLOn1bysT7lJqPDEV/6YkY12RvRAxCUt24Lt8jxkfgWQ+//f049/pnuEcwzRS1bwd/JUoyt47DsUPrmQZdMrXRKkrPrx6IkYZJ3qgwbznI5zhL3GvHiaJf51AamF5ST0TH8SiCTuygcpoALtJUkz3LZ1fYGpa0uLYePPe4YOkJwt2n25VSwdiVXpbM6Euvf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkBLd8Olkg+7wDAt1QYstk/J9uCnpFsForoikwZHqE0=;
 b=GEWHGJ7detis56Y1wAcT9dYSgAYFsnnh7n5E69EhAQyfEskTxWegDQWMJurPhOdg6ckVGFc6cUl8iu9iM5mkAbIod+qB9LADe4iqVl1ujskqdHnoTX/4HNiLa0w+3c844DoXhnENWaMn6/FVc6OGcYkvNTdSxQHfBd+hxtEEP9AwZ64+MG12XockDcd6MZMQC3WWrLdE6Ih0u0+fd/Jvk8ZQ69YhIuW72kbnU36hehH4J/ftfivSnwZyxsVYTXweXubOrPPQMMZsCGjRYPH8DVJke/Rx9u98fs2HAB699FcZzqItMcdiaPZ3TyUv1SdEk6OAp4XlpmZ4GgaVt13tVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkBLd8Olkg+7wDAt1QYstk/J9uCnpFsForoikwZHqE0=;
 b=bWG7S/6WtcuRjvpZwbpjO7/p8gIr5ecAhpkz3U8C8+rvs/Mh16L44pMg2R4+akgYJcCvtOsMVO/Ae+8W41rL7mmJRvY6nvKFFvXowerO7mktPiEdtO7p2a5WdmVBbRIezg7L+H8jp0rv4lwoobC3KjzUef+ZyxmGCQ2BzNjlzo+jYnqwP2l028NObxYNpdM6wa+AGud1C5cZdUa4eKzrj//kxgDBYuftKxMyO2hOrGrtEQdmqHnS1qjw40qP846QiW0NzQxji1mhbrGQcpMVGtiWFG/lqDDve16Ev6LXzZQ5QfzesBQzevsKkOCPmXFTdnGF5wm4IN3cdFvlBIa33w==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2928.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 12:14:48 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%6]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 12:14:48 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] module: replace module_layout with module_memory
Thread-Topic: [PATCH v4] module: replace module_layout with module_memory
Thread-Index: AQHZNNeu9tEplrAKq0WRjCl0zKXTeK64PbKAgAAepQCAABJMgIAAAuYA
Date:   Tue, 31 Jan 2023 12:14:48 +0000
Message-ID: <6420c572-3d0c-eb64-208e-26b38d3da873@csgroup.eu>
References: <20230130182109.3571524-1-song@kernel.org>
 <Y9jau76YwdCElzZ0@hirez.programming.kicks-ass.net>
 <1302e2b6-8980-e6e5-7433-6754634c98f3@csgroup.eu>
 <Y9kDyUaOe57IL/yF@hirez.programming.kicks-ass.net>
In-Reply-To: <Y9kDyUaOe57IL/yF@hirez.programming.kicks-ass.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2928:EE_
x-ms-office365-filtering-correlation-id: 1fdbdbe1-f2b7-41e5-689c-08db0384bf91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: exrn90ECtOfmFNybzYwMAJEoNurE/nueW91FT3VycUPb+1ayqip7561Uc3FjYHAQTXb/BLgzo1Ql2aNxLb42JhgJpSThq8m/5defIIdTQDsxBuH1P8vG4IVF71IiBDZAAwzp6beEzspCmd04v+eKRGH2yDEkhnYrA/V6p22biDjCCekuWBvDdQZFxAPKxJtwwZosVUhLjraY5e6uBye+HmTzOq08ZrxGJZOeXKZ5o+gWTckrlI4doLIaf+g6ECC7M70H7aix9hF7gdAxfj1z/Hz0OwGdNaLoKofQKiFyeSX7VI2jfWJ8XW6Useyogbchfnam38HGVlXfxqMw3gEZI/xQ3R9I4cYn+nY3B6AzojQvRgVyVx/JlvL6lz8UO7T2tUPgQwh/E+Udlq7oZqhl3GHLGejTrzZca3QbEAm/GyfKn89QMv6eyPHObHnXT6iDSVTJDyD3n4SnSfm6gsALs6m00KYLm29b9NFYKZeMirIsHaVf6pf8KnqCjkV2hb0oRhX7zkgz+p2Ba9DRS3x2+pcb4fmFnJtxebmE5Lng569UO9/4MyKF5ayU8fOr0mPpesso03oiEcp0vDLyYo0Hc7HBOJJOgRLYmbht8soYHcest3kSMSJdyZkojRcXlYYzDnHZFJhpURPep9Uht6qzEKBUobvTuW6nDl+bAndpdZ2alrjTzyioSsG9tDo88hzvqUJGAakMRQyw+hd9x/mJ98MkfbSchrCTeOtNHr0k/VmzdMTJ4g+ScYhbGq/hOmIvJYHF5urSUFMqQMW1HRpY6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(136003)(39850400004)(396003)(451199018)(31686004)(36756003)(41300700001)(6916009)(66556008)(66946007)(66446008)(64756008)(66476007)(316002)(54906003)(8676002)(91956017)(76116006)(4326008)(5660300002)(8936002)(122000001)(38100700002)(86362001)(38070700005)(31696002)(6506007)(186003)(6512007)(26005)(71200400001)(83380400001)(66574015)(2906002)(44832011)(478600001)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVBzdFRpUzdybFpHNk1yeVBPbkluRytLbnJVZE14a1ZMS2ZxTUliVnpiRWlr?=
 =?utf-8?B?SExZZU1RalUxWUZxcGRHT3JiNU1NWEI4R0tkV0U1YmI4U2xiRXMrYlBaaE1X?=
 =?utf-8?B?YVRKVkpNSFBEb2taUnpQNVFyZ1hlcDBqaHNEZXJFUWs0d0F5NFRIdEZZdEo1?=
 =?utf-8?B?ZUxUQjFRVmhSMkVSTU9xeVlkU3NTNEhIZ1hudlJFVVlnZUozbmZiV0JrTW13?=
 =?utf-8?B?NnVpMGgza2VTMzZwRU14T3lqMlpHcWE5L3hDc0FOQS8ycFF2M2IycWx5TmlP?=
 =?utf-8?B?MlByLzlHemNJbUxNQjRNdXM1Y3QzYVR2YW9aYXNreWluQjNFbzVQMGRRRUE5?=
 =?utf-8?B?emxIMVRmc2lBS1lRbk1EZXN3RE8zUFVDK1dQY3JTY05aVm9DZ3JFSUpTTkNM?=
 =?utf-8?B?TGU5ZGl2WkUyb1BkOU85U0VmZXdyd3BCcDBqdVBjNDZJcjJSUmJLc2YzMFM2?=
 =?utf-8?B?cXVjTzB2Z0IwdFBNcUZTVmREZXRnU2NaZm4yMTZ0b2V6YXNrU3R3OVFNelkv?=
 =?utf-8?B?UXcyVVUwcG45Mm43MHJnZXlSRDhEZ1hOQ0ZpWFJLV0M2RWdqWHZnUnQrdWhD?=
 =?utf-8?B?NmxjRXNMb1h6ZWtTckYyUXEwTnZoY2FoaS9ZcVJZaFhtMGxzem5FaVdyWlR0?=
 =?utf-8?B?V1ZaT0ppazR3ZnR6YjNqaGk2OUJJd0w5UEpvZCtMMElsSkl6VGpIYi9FSnZz?=
 =?utf-8?B?Y0M0UUhwL3hSaFh0Tnpna3FsY2F1UDVlYTJ0eVlmZmZ2ZDVFVHlFWXo0YzV2?=
 =?utf-8?B?RGxYcy9EK1Z3QWZlL2oyT1ZaZ3VqTEQ5dElobnVDcXo4LzRDaXhCd0NqMlZP?=
 =?utf-8?B?NXhNcWZLVlkzVU11RzRySHNiMVRyT1IySHB0b25sUHZTMG5ad1pTdm02bzF5?=
 =?utf-8?B?MFd3dk14cVNPOXJRY3ZjZjdWUHlOSkRDZC9aNEVuM3hpVzB6U3E4K1dKbjVz?=
 =?utf-8?B?Q2xlanhFN1ZPZFpOSFNQMHdDVTZ6Q1UvVU02V2U1T2l3NUhPbHJJL1lnc2tr?=
 =?utf-8?B?c3VLVFNUbzl1Z0pUMVExNHh4UUUyQUFkdS82Z3RMN1B6V2txMXRrVjRsM2xT?=
 =?utf-8?B?S0FCd0s5aVlYcW56QXBjL0pxVWVIenZ5dzJKRG9idnlvSDhwMnZKczZUZGg1?=
 =?utf-8?B?TnJiYmdqQ0F6QW5XTkc5NHJweUUwNGtUVm5VNVAxNFArcmhkMndYQTA1WWww?=
 =?utf-8?B?akd3UWZnUXJFV3lETm1EYVY4WVJINEdWWVVxYUNsWWwvZTdXUWZLQ3owOUND?=
 =?utf-8?B?WExyU3V6d0M3NGMyQzhnNlMvcFJ1TDkvS1pia1JTbUpUUVBqMUdOMFM0WUZp?=
 =?utf-8?B?R1RzRnQxZXRubVNLNkNxSFNzMUxRVkRXMzR4eEhDUGR1cTUyYThUcURXZS9Y?=
 =?utf-8?B?RGU0NnordmdIUmVvYi9sSXlJMjRueDhBbGd4dlE2RmNDQXV0UHMxSHVDazhq?=
 =?utf-8?B?Q0tHZmNzNUpHL05YYnRzRmNQLytWUW14aHdYRVArS2pKSlpvMHpxZ0NNaTV4?=
 =?utf-8?B?S2lnM1kwTE9OUDYrRzNSTC9vRWlVS2RpeXJXaWo3V0hIRDFobEFxZ25iakZ5?=
 =?utf-8?B?eFZCWnpRNVZLcVVvQ04yaVlEVkY4eDdBb2MrZEVhTU5VY2NCbTQ2Qm1UZHp5?=
 =?utf-8?B?elJ4ZkxONUhBT2pQZ3h0bUZTUUIvRERqTUdsKytuRWswUVJCWDYwNmpmalgv?=
 =?utf-8?B?dzZsWGtWM3pGdG9RdmxFTHN4VnorcDE5ZFVmOVlGaXkwUGV4L1NwaXl3WkVO?=
 =?utf-8?B?U05SVmZJQWdaZ1pRdmo1ckJwb3ZncUZ4aE5QTkRlMVh2d01QVjBWWGpseEtE?=
 =?utf-8?B?MElFUCttejh6cFQvN28xUTdDbG5YbGk5dUpDNXZTRW9ocjBTck54aEMxWmFq?=
 =?utf-8?B?eEpPeVM5UXlPT2cyNStCcTZLT1lTWHhXQ2JOOG1HZjlTd2Y2SEhyOGxXckZ6?=
 =?utf-8?B?YTBHcE5YS3c0TVpLOTh0L1dTYk01eHFxWmR0ZlNZb0lCNDNCbjJxUGRZTWRl?=
 =?utf-8?B?UjE1eGpqWFhVa25XbExNUVFGdm00QkRvY1ZuV1BOSWh2ZGZXYk43eWI5T2Fx?=
 =?utf-8?B?QWM0VkhJVS9ENFlSejExZkZhZ3VoT0p4cWh6YWxhdGdDUzRJckxuV29IUWZU?=
 =?utf-8?B?bE1kUkJ1VGZUYUNWekhOL3ZNUWlrUFRHb3pjdnFOKy9wV2JpSWRRVWtKY2tO?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D346497A300A0438D2160CFD7E6759D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdbdbe1-f2b7-41e5-689c-08db0384bf91
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 12:14:48.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ebMzbL07pIDgO/dXvbrBiNnGfFjgjPMdqqUN5iHQSP0mX4PzC0C7nWlLqeobq02JOGS3GlzQ65qheyVn5Nt1Lgvaq/ytVP9c+2vwo4bFRgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2928
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDMxLzAxLzIwMjMgw6AgMTM6MDQsIFBldGVyIFppamxzdHJhIGEgw6ljcml0wqA6DQo+
IE9uIFR1ZSwgSmFuIDMxLCAyMDIzIGF0IDEwOjU4OjU2QU0gKzAwMDAsIENocmlzdG9waGUgTGVy
b3kgd3JvdGU6DQo+Pg0KPj4NCj4+IExlIDMxLzAxLzIwMjMgw6AgMTA6MDksIFBldGVyIFppamxz
dHJhIGEgw6ljcml0wqA6DQo+Pg0KPj4+PiBAQCAtNTczLDIzICs1NzQsMzMgQEAgYm9vbCBfX2lz
X21vZHVsZV9wZXJjcHVfYWRkcmVzcyh1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcg
KmNhbl9hZGRyKTsNCj4+Pj4gICAgYm9vbCBpc19tb2R1bGVfcGVyY3B1X2FkZHJlc3ModW5zaWdu
ZWQgbG9uZyBhZGRyKTsNCj4+Pj4gICAgYm9vbCBpc19tb2R1bGVfdGV4dF9hZGRyZXNzKHVuc2ln
bmVkIGxvbmcgYWRkcik7DQo+Pj4+ICAgIA0KPj4+PiArc3RhdGljIGlubGluZSBib29sIHdpdGhp
bl9tb2R1bGVfbWVtX3R5cGUodW5zaWduZWQgbG9uZyBhZGRyLA0KPj4+PiArCQkJCQkgIGNvbnN0
IHN0cnVjdCBtb2R1bGUgKm1vZCwNCj4+Pj4gKwkJCQkJICBlbnVtIG1vZF9tZW1fdHlwZSB0eXBl
KQ0KPj4+PiArew0KPj4+PiArCXVuc2lnbmVkIGxvbmcgYmFzZSwgc2l6ZTsNCj4+Pj4gKw0KPj4+
PiArCWJhc2UgPSAodW5zaWduZWQgbG9uZyltb2QtPm1lbVt0eXBlXS5iYXNlOw0KPj4+PiArCXNp
emUgPSBtb2QtPm1lbVt0eXBlXS5zaXplOw0KPj4+PiArDQo+Pj4+ICsJcmV0dXJuIGJhc2UgPD0g
YWRkciAmJiBhZGRyIDwgYmFzZSArIHNpemU7DQo+Pj4NCj4+PiBQb3NzaWJsZSAoYXMgaW5zcGly
ZWQgYnkgYWxsIHRoZSBhYm92ZSBpc197aW5pdCxjb3JlfSgpIGV0Yy4uDQo+Pj4NCj4+PiAJcmV0
dXJuIGFkZHIgLSBiYXNlIDwgc2l6ZTsNCj4+Pg0KPj4NCj4+IEluIGtlcm5lbC9tb2R1bGUvbWFp
bi5jIHdlIGhhdmUgYSBmdW5jdGlvbiBjYWxsZWQgd2l0aGluKCkuIE1heWJlIHRoYXQNCj4+IGZ1
bmN0aW9uIGNvdWxkIGJlIGxpZnRlZCBpbiBtb2R1bGUuaCBhbmQgdXNlZC4NCj4gDQo+IE1vcmUg
c2hhcmluZyBtb3JlIGdvb2QuIEJ1dCBJIGRvbid0IHRoaW5rIHdlIGNhbiBsaWZ0IGEgJ3dpdGhp
bicNCj4gZnVuY3Rpb24gdG8gdGhlIGdsb2JhbCBuYW1lc3BhY2UsIHRoYXQncyBqdXN0IGFza2lu
ZyBmb3IgcGFpbi4NCj4gDQo+Pj4gc3RhdGljIGlubGluZSBib29sIHdpdGhpbl9tb2R1bGVfbWVt
X3R5cGVzKHVuc2lnbmVkIGxvbmcgYWRkciwNCj4+PiAJCQkJCSAgIGNvbnN0IHN0cnVjdCBtb2R1
bGUgKm1vZCwNCj4+PiAJCQkJCSAgIGVudW0gbW9kX21lbV90eXBlIGZpcnN0LA0KPj4+IAkJCQkJ
ICAgZW51bSBtb2RfbWVtX3R5cGUgbGFzdCkNCj4+PiB7DQo+Pj4gCWZvciAoZW51bSBtb2RfbWVt
X3R5cGUgdHlwZSA9IGZpcnN0OyB0eXBlIDw9IGxhc3Q7IHR5cGUrKykgew0KPj4+IAkJaWYgKHdp
dGhpbl9tb2R1bGVfbWVtX3R5cGUoYWRkciwgbW9kLCB0eXBlKSkNCj4+PiAJCQlyZXR1cm4gdHJ1
ZTsNCj4+PiAJfQ0KPj4+IAlyZXR1cm4gZmFsc2U7DQo+Pj4gfQ0KPj4NCj4+IFdlbGwsIG9rIGJ1
dCB3aGF0IGdhcmFudGllcyBpdCB3aWxsIGFsd2F5cyBiZSBjb250aWd1b3VzIHR5cGVzID8NCj4+
IEFuZCB5b3UgY2FuJ3QgYW55bW9yZSBzZWUgYXQgZmlyc3QgbG9vayB3aGF0IHR5cGVzIGl0IGlz
Lg0KPj4NCj4+IEkgcHJlZmVyIGl0IHRvIGJlIGV4cGxpY2l0IHdpdGggd2l0aGluX21vZHVsZV9t
ZW1fdHlwZShUWVBFMSkgfHwNCj4+IHdpdGhpbl9tb2R1bGVfbWVtX3R5cGUoVFlQRTIpIHx8IHdp
dGhpbl9tb2R1bGVfbWVtX3R5cGUoVFlQRTMpLiBCeSB0aGUNCj4+IHdheSB3ZSBjb3VsZCBtYWtl
IHRoZSBmdW5jdGlvbiBuYW1lIHNob3J0ZXIsIGV2ZW4gd2l0aGluKCkgbWF5IGJlIGENCj4+IGJl
dHRlciBuYW1lIGFzIGl0IGlzIHVzZWQgb25seSBpbnNpZGUgbW9kdWxlIGNvZGUuDQo+Pg0KPj4g
U29tZXRoaW5nIGxpa2UNCj4+DQo+PiAJcmV0dXJuIHdpdGhpbihhZGRyLCBtb2QsIE1PRF9URVhU
KSB8fCB3aXRoaW4oYWRkciwgbW9kLCBNT0RfREFUQSkgfHwNCj4+IAkgICAgICAgd2l0aGluKGFk
ZHIsIG1vZCwgTU9EX1JPREFUQSkgfHwgd2l0aGluKGFkZHIsIG1vZCwNCj4+IE1PRF9ST19BRlRF
Ul9JTklUKTsNCj4gDQo+IFVyZ2gsIGhvdyBhYm91dD8NCj4gDQo+IAlmb3JfZWFjaF9tb2RfbWVt
X3R5cGUodHlwZSkgew0KPiAJCWlmICghbW9kX21lbV90eXBlX2lzX2luaXQodHlwZSkgJiYgd2l0
aGluKGFkZHIsIG1vZCwgdHlwZSkpDQo+IAkJCXJldHVybiB0cnVlOw0KPiAJfQ0KPiAJcmV0dXJu
IGZhbHNlOw0KPiANCj4gVGhlbiB5b3UgaGF2ZSBoYXZlIGEgYnVuY2ggb2YgbW9kX21lbV90eXBl
X2lkX2ZvbygpIGZpbHRlciBmdW5jdGlvbnMNCj4gdGhhdCBhcmUgbm9uLWNvbnRpZ3VvdXMgd2l0
aG91dCBoYXZpbmcgdG8gZW5kbGVzc2x5IHJlcGVhdCBzdHVmZg0KPiBtYW51YWxseS4NCg0KQnV0
IHRoYXQncyB1bi1yZWFkYWJsZS4NCg0KWW91IGhhdmUgdG8gaGF2ZSB0aGUgbGlzdCBvZiBwb3Nz
aWJsZSB0eXBlcyBpbiBmcm9udCBvZiB5b3UgaW4gb3JkZXIgdG8gDQp1bmRlcnN0YW5kIHdoYXQg
dGhlIGZ1bmN0aW9uIGRvZXMuIFdoaWNoIG1lYW5zIHRoYXQgb25lIGRheSBvciBhbm90aGVyIA0K
c29tZW9uZSB3aWxsIGNoYW5nZSB0aGUgb3JkZXIgb2YgdHlwZXMgaW4gdGhlIGVudW0sIGFuZCBp
dCB3aWxsIGJyZWFrLg0KDQpCZXR0ZXIgaGF2ZSB0aGUgdHlwZXMgZXhwbGljaXQuDQoNCkNocmlz
dG9waGUNCg==
