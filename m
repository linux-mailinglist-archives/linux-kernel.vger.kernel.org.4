Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5CF6F39EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjEAVoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 17:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEAVoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 17:44:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F9610F1
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 14:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHX4mrdB5UpaC15CtQF+O6fU9O1EOZ/TH3zZn5ciah1Af7RRuOVsoUPEyESwd2rz4btbAoay8H+6F8YcreSC/bc0Eleb6YNI388TMsrAFA+ua2CfDV7m5YCzJaIx3gdgHQns3Hu24/Ow47cOTmWrMdc1PWgXwzxNWziWnJI1OKiWAVN9OSLyCvMzCOk5aV0/nmRSNO1GsZDBl5RAluqXF/KCNWjFfh1S64zgK4+Bb544ojUhHiUZuRlARCKY8xWXJ959NJqyV0XHMxsHICs+YKziSJTwK7iu8vm+E5Igih7BOCjcMbL7XTfTxoI6yIcKEVSkBKO6oBLkjKUyI+J/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQPpXaxY1Vm0ISqQ11lgUMJlEZQdXHStLfjguD6HDoU=;
 b=a8JLD4rl/CE89MiNZWDczIsw/Pgw0EVo5Y1co3g5E4N66kDP9/GkZb2ADoQ2YqQAyztZhGmPzRpqytN6eaW7qEC7Fon5KMpIv9ECgh0F4hUxBAAxP49dF1aKSnbZrOYqYO3k/nMvDYcsg3b3kK/IS0rdW6P5Fw9HEJ2O9Q5aMenCcsac0mUBfKtG4adXsoiZrx99nQmxP/SzNs1ynku3KVF5bXG7SI2q0pcNzRLo1dJO+3zoEG4s1VsAY874iUawfWr6dU+fvoHYFh7r5tZpxsAAcwkxgru5qRqnYvrW0ktdUfquvFHkS1MNC5xNcFea4laZ5fEeaKK+Gq+rbXhUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQPpXaxY1Vm0ISqQ11lgUMJlEZQdXHStLfjguD6HDoU=;
 b=E4aIN6pT6bbQREZH+hYEr2MEsoEJMx4rxdbFiEjumZIdHhJjK4HUg5fmPDCcLTp2wMKSHril7HXjTBgCrTqw/eEqMR46skCmHR2OZ7trTRMMg6xi0x1pCo1TYIjw4haLIFg4kVoctaGIArZg1U8/o8Wtc+hHEp+DQ2jXZpTHc/0=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by CY5PR19MB6172.namprd19.prod.outlook.com (2603:10b6:930:2b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.19; Mon, 1 May
 2023 21:44:49 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8242:2254:13b6:74fc]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8242:2254:13b6:74fc%6]) with mapi id 15.20.6363.009; Mon, 1 May 2023
 21:44:49 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Andrei Vagin <avagin@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fuse uring / wake_up on the same core
Thread-Topic: fuse uring / wake_up on the same core
Thread-Index: AQHZXonZnrNnGQvxikaxtbJ88GLEB68OcL2AgC/yZYCAAOYogIAAE+eAgADLvYCAAVIbgIAEtDAA
Date:   Mon, 1 May 2023 21:44:48 +0000
Message-ID: <239b3ff9-7cba-69b8-0f0a-312fbf5afb9d@ddn.com>
References: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
 <20230327102845.GB7701@hirez.programming.kicks-ass.net>
 <20230427122417.2452-1-hdanton@sina.com>
 <20230428014443.2539-1-hdanton@sina.com>
 <d954ca54-2a3f-b111-7ba5-41169de473ce@ddn.com>
In-Reply-To: <d954ca54-2a3f-b111-7ba5-41169de473ce@ddn.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|CY5PR19MB6172:EE_
x-ms-office365-filtering-correlation-id: 63e4813a-924c-4ba5-a0e0-08db4a8d49b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6EbdrQEeGI8BZ0NQ3FX/O2iaEaBvbMEDoXG1y69+BQAhg8L1Ee0iovj3qxB8exb92lqKvLYkpVDToXCM+bmatoTgk1wUK4X6dIld+mM8OPkv/aCuBoLI1Zkjqt72VGJ965L5Y9KN272ormyoLNOMxEEu7UO/hBHmMasGapUErjkUZDV/YvrrsyhMfERsNppgvF0FrJnHMduIGwil01niGRoPw4VbyyuE6N/RtAs3ohg1BQbC6e3ikIEz8Bxg3zYJE5o76Efu8YqaRg3mqgBm09K4PysnlEX1tekwOZQFGzhuzq2tuW0RAYXBKAe3TY3JXjo0OQQgvC0SoJHcUSEvRejzn9wr9YTOi/+nwptftkSPFZoIJ+jioRN6wxlHkZEnGtXIvaIduK8dNoWHZKPNTsVwTmAAvTYiUFTKzQJsSkVKLo4AYScUvCIDuCJWw4F1l8dSfyfN8dWi/qRHnhIMO20R32jypOYEarUHI3K2q/BRQEgBLb1JlmyaJVO3C6inTupL9GiRxRiiXKhcuy8uvLNS8ugGA6u4nPntJPDpBcAC1amcwHwaPUxJe2ISzjd3Z+9YI9T5WPoN8wss1OELKS8Vn2c87clhV8fas+msqaBU8GCNA8STG0HesvImFjkAqWsRva+12Srlj/AgKsQ3Hntu83TH6lGsLe23WYTHwHDTHiPgtte4WYGxOTD3nuuwJkp1X6fsyM9IjwNudhfpOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(451199021)(53546011)(6506007)(186003)(66446008)(6486002)(83380400001)(2616005)(316002)(5660300002)(71200400001)(4326008)(66556008)(76116006)(66946007)(6512007)(66476007)(64756008)(41300700001)(6916009)(8676002)(8936002)(54906003)(478600001)(2906002)(91956017)(36756003)(122000001)(38100700002)(38070700005)(86362001)(31696002)(31686004)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzNLOFdqeFR1R1o3bVVCT0JPOVVSczlGQU84VlJqeEZCZWs3Q1BOSWJIdThn?=
 =?utf-8?B?Nmk5TXFsSVNaby9DVm5GUnM5SEpPZEdlZmtRVkpFalo0eVVUSERRaHd4cE1J?=
 =?utf-8?B?eS8yQ2UxZFdGbDNYcVNoTVpsSDlNMFdYRnpjbDUvaU84R2xKQXBueXo0ZWJZ?=
 =?utf-8?B?V0s5Rjh6bHB1UEtYREZkYW1ZMldCMDZLK0tmYjBvdnhIWmhoam5wcDc3WlFK?=
 =?utf-8?B?YnN4WFZVSDVBL0h5NWlPNCtQTVdOV2VRWmxyNVpNREhtU1E0N1E2WGxlb0ht?=
 =?utf-8?B?ZzNOdVMyUDZIL1phU2UyZXdFL3pSalo4MTdFZktUR21lSWgyaTl2N3JsTlF3?=
 =?utf-8?B?MzRVSmlGZHZXNUJTWnRzTzhEVXhpUENEenZ6NjEzem84UkpacC92MmNUU3dp?=
 =?utf-8?B?amszSS9XUGJJaElIb0FsU0F4dWlUNXdVQTFDUjRVRXdyVnpIK1NqaWt0RDdT?=
 =?utf-8?B?TnR1eTZoYkFTNlNDakhXdWIrdUgyZVFJMUNHVGlvY3dhSXBaczJJdllUZkI0?=
 =?utf-8?B?NXdFbkwyNHQvanlWYm1aV0tSM1lCNTc2NTRRbW02VW0xY3dmL1p5blVCMU4x?=
 =?utf-8?B?bm9jOGNRMGFia1poczV5MmRwejRDdTFkK2hSS3krL0tvT3hCQ2dZa3BZWlFQ?=
 =?utf-8?B?aDk2VjhoZDk4YkxTV3JaMlp2WjEvdHNUNGplR2x4ZXBlVmxOekpiSmI4ZXhx?=
 =?utf-8?B?WnlOMEM3VDlERm9rekJSUVlTWmo2dTFkdm5xV2QwNGVIQkxJMWsrc0hxTzVT?=
 =?utf-8?B?V2d2N1prODJsdXFGR0YvWUQ4TUxmcmc0Z01KeWtBdzl4NVZnekg1VUVOam0v?=
 =?utf-8?B?bk9Vc3ROZlYxRjJsb0Ryc2VEb2FzY0RURkdNb05OdzBVcFZhU25VNXVpYmQv?=
 =?utf-8?B?NE5ocTZ3aTlrSmFLdnR4TDdiZFFVSUNyd2x1RTFaNkhIYzhidFByNWF1bEg3?=
 =?utf-8?B?UkdLMDVJZVcyNVlSdzBYbzIrLzdoTFhTc3kxQUtQc1ljVTQ3RWxqU1pvTXgz?=
 =?utf-8?B?V1dIN3BCWXZiNXlRL1NuSmlrQU1jWEZOM3RYTFRvbEllL3pOM3VQYyt3OW84?=
 =?utf-8?B?MzAwbGpuSU5FYlV0WE9rN1lQQ09uUFBOOUE0M0ZDck5WcHc4cDRiUVFrRXo4?=
 =?utf-8?B?ckkreHE4NGwxYVdPMmlLbzhUaXd6Zm9qWHZMeWdoVVZaNW1SQ2xpME5Sb29x?=
 =?utf-8?B?amhjdVNZVFdicFgxSXk0ZDE3TE85REVjbTRXWnAzSlFVanliVFFPNS92Y2Vi?=
 =?utf-8?B?YXBwVWFRWmU1VHRGdTdaa1llcEJJWDRPMWFMN3NobWVDNGt4cUI4WlVmRXMz?=
 =?utf-8?B?Wko5eUMxVWpQSjViVmtERlhLUWV1SFJpbG5nam9NaldpOVhnelVESldUS3JZ?=
 =?utf-8?B?RitJS1NGUEFXaVJxWmg2Y0cvYkFnSTdQV0ZwaVZnOHY5NUk2dS94L3Fzallh?=
 =?utf-8?B?dVBiNFltYlM1RDVHYWlTVktXckZVdjZvaGhkMFdxR0poNW4rMG1hUmsrK2NK?=
 =?utf-8?B?SDVtNHNWb2ZQZk10OE16ZVpwVDdwdkZnVUVqVkw4MjdqUUhZa0VrMm9YUzRm?=
 =?utf-8?B?RGhwOWErR0tndVZlVlhBV3JBQjBEU3RMQ08waGZKK3lkb2x6UWhUUnZDL2VO?=
 =?utf-8?B?Q3dLSU5DVElwSVVsRmdENjdTZWdQbWRJcXByMzFrSllETkxuNUd4MGlJb3g0?=
 =?utf-8?B?VDNxVWJiOThyV05kTDAzQ3dUV2hod2tuMWQ4NG5INDBOV0xvUDhoS29jcDln?=
 =?utf-8?B?dDFYSktDVit1WnlXM3hwWURqc2t1V0E5d1pCWHA4Wm55Vkxic1BUZkExQlZl?=
 =?utf-8?B?c01vU2FwaE9iWkZaNng0SHhHSWxiR3R6cXQzajBuUERGTCs1bWFVNFROTU1h?=
 =?utf-8?B?eG80WGg4TjUzVG5FNmF3aDN6VzE4eThTU25vck5WVFkyYUpwaUl5K2RaTGlp?=
 =?utf-8?B?bDJkY21QTHZmeXRZaWEvSk5kdnI4MkpRRVFOV3N1YnBzYmlsOFRaR3FNYUxv?=
 =?utf-8?B?UTdFcWs1WDhxb2pjNmxwbytySVdyNElkU1ZSM0NOVGR4U0ZPOE5qR09QS05F?=
 =?utf-8?B?NUY0OFppb0R0enZvQ2tDN3BLOE1JdXRqL3Z5ams4TXlqWWkvTHV6bndwTWZ0?=
 =?utf-8?B?KzVxYzh1MmM2aTJ3UWE2UEFaMm9XNE8zR3FoNzc0UjJXL01Bb20xVzZ6NTk1?=
 =?utf-8?Q?RYSVwiPq4SCSEJqHY40tZcs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6306BEA3D7263B49BFE844B092DDAAA5@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e4813a-924c-4ba5-a0e0-08db4a8d49b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 21:44:49.0072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVhN2ZtgsQm1P13IrpM15XyROOhjMhuLExIYHykDceP3RvZWHVHtvYjqypQzcY+sEtQmx9dZyEdAV+B3po/doA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6172
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yOC8yMyAyMzo1NCwgQmVybmQgU2NodWJlcnQgd3JvdGU6DQo+IE9uIDQvMjgvMjMgMDM6
NDQsIEhpbGxmIERhbnRvbiB3cm90ZToNCj4+IMKgwqAgcmVzdGFydDoNCj4+IMKgwqDCoMKgwqAg
Zm9yICg7Oykgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmZmlxLT5sb2NrKTsN
Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvc2NoZWQuaA0KPj4gKysrIGIvaW5jbHVkZS9saW51eC9z
Y2hlZC5oDQo+PiBAQCAtOTUzLDYgKzk1Myw3IEBAIHN0cnVjdCB0YXNrX3N0cnVjdCB7DQo+PiDC
oMKgwqDCoMKgIC8qIGRlbGF5IGR1ZSB0byBtZW1vcnkgdGhyYXNoaW5nICovDQo+PiDCoMKgwqDC
oMKgIHVuc2lnbmVkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpbl90aHJhc2hpbmc6MTsNCj4+IMKgICNlbmRpZg0KPj4gK8KgwqDCoCB1bnNpZ25lZMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzZWVzYXc6MTsNCj4+IMKgwqDCoMKgwqAgdW5zaWduZWQgbG9u
Z8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXRvbWljX2ZsYWdzOyAvKiBGbGFncyByZXF1aXJpbmcg
YXRvbWljIA0KPj4gYWNjZXNzLiAqLw0KPj4gLS0tIGEva2VybmVsL3NjaGVkL2ZhaXIuYw0KPj4g
KysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYw0KPj4gQEAgLTc0MjQsNiArNzQyNCw4IEBAIHNlbGVj
dF90YXNrX3JxX2ZhaXIoc3RydWN0IHRhc2tfc3RydWN0ICoNCj4+IMKgwqDCoMKgwqAgaWYgKHdh
a2VfZmxhZ3MgJiBXRl9UVFdVKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmVjb3JkX3dha2Vl
KHApOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChwLT5zZWVzYXcgJiYgY3VycmVudC0+c2Vlc2F3
KQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGNwdTsNCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoc2NoZWRfZW5lcmd5X2VuYWJsZWQoKSkgew0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgbmV3X2NwdSA9IGZpbmRfZW5lcmd5X2VmZmljaWVudF9jcHUocCwgcHJldl9j
cHUpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5ld19jcHUgPj0gMCkNCj4g
DQo+IA0KPiBIbW0sIFdGX0NVUlJFTlRfQ1BVIHdvcmtzIHJhdGhlciBzaW1pbGFyLCBleGNlcHQg
dGhhdCBpdCB0ZXN0cyBpZiBjcHUgaXMgDQo+IGluIGNwdXNfcHRyP8KgIFRoZSBjb21iaW5hdGlv
biBvZiBib3RoIHBhdGNoZXMgcmVzdWx0cyBpbg0KPiANCj4gIMKgwqDCoMKgwqDCoMKgIGlmIChw
LT5zZWVzYXcgJiYgY3VycmVudC0+c2Vlc2F3KQ0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gY3B1Ow0KPiANCj4gIMKgwqDCoMKgwqDCoMKgIGlmICgod2FrZV9mbGFncyAmIFdGX0NV
UlJFTlRfQ1BVKSAmJg0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHVtYXNrX3Rlc3RfY3B1
KGNwdSwgcC0+Y3B1c19wdHIpKQ0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gY3B1
Ow0KPiANCj4gDQo+IA0KPiBXaGlsZSB3cml0aW5nIHRoZSBtYWlsIGtlcm5lbCBjb21waWxhdGlv
biBpcyByZWFkeSwgYnV0IGl0IGdvdCBsYXRlLCANCj4gd2lsbCB0ZXN0IGluIHRoZSBtb3JuaW5n
Lg0KDQpUaGlzIHdvcmtzIHdvbmRlcnMhICBUaGUgZnVzZS11cmluZyBwYXJ0IGlzIHRoaXMNCg0K
ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGV2LmMgYi9mcy9mdXNlL2Rldi5jDQppbmRleCBjZDdhYTY3
OWMzZWUuLmVjNTg1M2NhOTY0NiAxMDA2NDQNCi0tLSBhL2ZzL2Z1c2UvZGV2LmMNCisrKyBiL2Zz
L2Z1c2UvZGV2LmMNCkBAIC0zNzMsNiArMzczLDkgQEAgc3RhdGljIHZvaWQgcmVxdWVzdF93YWl0
X2Fuc3dlcihzdHJ1Y3QgZnVzZV9yZXEgKnJlcSkNCiAgICAgICAgIGludCBlcnI7DQogICAgICAg
ICBpbnQgcHJldl9jcHUgPSB0YXNrX2NwdShjdXJyZW50KTsNCiAgDQorICAgICAgIGlmIChmYy0+
cmluZy5wZXJfY29yZV9xdWV1ZSkNCisgICAgICAgICAgICAgICBjdXJyZW50LT5zZWVzYXcgPSAx
Ow0KKw0KICAgICAgICAgaWYgKCFmYy0+bm9faW50ZXJydXB0KSB7DQogICAgICAgICAgICAgICAg
IC8qIEFueSBzaWduYWwgbWF5IGludGVycnVwdCB0aGlzICovDQogICAgICAgICAgICAgICAgIGVy
ciA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZShyZXEtPndhaXRxLA0KZGlmZiAtLWdpdCBhL2Zz
L2Z1c2UvZGV2X3VyaW5nLmMgYi9mcy9mdXNlL2Rldl91cmluZy5jDQppbmRleCA3ZDMyNzY5OWI0
YzUuLjcxNTc0MWVkNThiZiAxMDA2NDQNCi0tLSBhL2ZzL2Z1c2UvZGV2X3VyaW5nLmMNCisrKyBi
L2ZzL2Z1c2UvZGV2X3VyaW5nLmMNCkBAIC0xMzEyLDYgKzEzMTIsMTMgQEAgaW50IGZ1c2VfdXJp
bmdfY21kKHN0cnVjdCBpb191cmluZ19jbWQgKmNtZCwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdz
KQ0KICAgICAgICAgICAgICAgICAgICAgICAgIC8qIFhYWCBlcnJvciBpbmplY3Rpb24gb3IgdGVz
dCB3aXRoIG1hbGljaW91cyBkYWVtb24gKi8NCiAgICAgICAgICAgICAgICAgfQ0KICANCisgICAg
ICAgICAgICAgICAvKiBJbiBjb21iaW5hdGlvbiB3aXRoIHJlcXVlc3RpbmcgcHJvY2VzcyAoYXBw
bGljYXRpb24pIHNlZXNhdw0KKyAgICAgICAgICAgICAgICAqIHNldHRpbmcgKHNlZSByZXF1ZXN0
X3dhaXRfYW5zd2VyKSwgdGhlIGFwcGxpY2F0aW9uIHdpbGwNCisgICAgICAgICAgICAgICAgKiBz
dGF5IG9uIHRoZSBzYW1lIGNvcmUuDQorICAgICAgICAgICAgICAgICovDQorICAgICAgICAgICAg
ICAgaWYgKGZjLT5yaW5nLnBlcl9jb3JlX3F1ZXVlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAg
Y3VycmVudC0+c2Vlc2F3ID0gMTsNCisNCiAgICAgICAgICAgICAgICAgcmV0ID0gZnVzZV91cmlu
Z19mZXRjaChyaW5nX2VudCwgY21kKTsNCiAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAg
ICBjYXNlIEZVU0VfVVJJTkdfUkVRX0NPTU1JVF9BTkRfRkVUQ0g6DQoNCg0KDQoNCkknbSBub3Qg
ZmFtaWxpYXIgYXQgYWxsIHdpdGggc2NoZWR1bGVyIGNvZGUsDQpnaXZlbiB0aGlzIHdvcmtzIHBl
cmZlY3RseSB0aGlzIHN1Z2dlc3RzIHRoZSBzYW1lIGZ1bmN0aW9uIGlzIGFsc28NCmNhbGxlZCB3
aXRob3V0IGV4cGxpY2l0IHdhaXRxLCB3aGVuIHRoZSBzY2hlZHVsZXIgcHJlZW1wdHMgYSB0YXNr
Pw0KDQpJIHRoaW5rIHRoZXJlIG1pZ2h0IGJlIHNpZGUgZWZmZWN0cyAtIHdoYXQgaXMgaWYgbXVs
dGlwbGUNCmFwcGxpY2F0aW9ucyBhcmUgb24gb25lIGNvcmUgYW5kIGFub3RoZXIgY29yZSB3b3Vs
ZCBiZSBhdmFpbGFibGU/DQpXaXRoIHRoaXMgZmxhZyB0aGV5IHdvdWxkIHN0YXkgb24gdGhlIHNh
bWUgY29yZT8gTWF5YmUgYmV0dGVyIHR3byBmbGFncz8NCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvc2NoZWQuaCBiL2luY2x1ZGUvbGludXgvc2NoZWQuaA0KaW5kZXggNjNkMjQyMTY0YjFh
Li4wNzc4M2RkYWVjNWMgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NjaGVkLmgNCisrKyBi
L2luY2x1ZGUvbGludXgvc2NoZWQuaA0KQEAgLTk1Myw2ICs5NTMsOCBAQCBzdHJ1Y3QgdGFza19z
dHJ1Y3Qgew0KICAgICAgICAgLyogZGVsYXkgZHVlIHRvIG1lbW9yeSB0aHJhc2hpbmcgKi8NCiAg
ICAgICAgIHVuc2lnbmVkICAgICAgICAgICAgICAgICAgICAgICAgaW5fdGhyYXNoaW5nOjE7DQog
ICNlbmRpZg0KKyAgICAgICB1bnNpZ25lZCAgICAgICAgICAgICAgICAgICAgICAgIHNlZXNhd19y
ZXE6MTsNCisgICAgICAgdW5zaWduZWQgICAgICAgICAgICAgICAgICAgICAgICBzZWVzYXdfaW86
MTsNCiAgDQogICAgICAgICB1bnNpZ25lZCBsb25nICAgICAgICAgICAgICAgICAgIGF0b21pY19m
bGFnczsgLyogRmxhZ3MgcmVxdWlyaW5nIGF0b21pYyBhY2Nlc3MuICovDQogIA0KZGlmZiAtLWdp
dCBhL2tlcm5lbC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jDQppbmRleCBiOWQ2
ZWQ3NTg1YzYuLjQ3NGJmMzY1N2VmMCAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9mYWlyLmMN
CisrKyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMNCkBAIC03NjA1LDYgKzc2MDUsMTMgQEAgc2VsZWN0
X3Rhc2tfcnFfZmFpcihzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGludCBwcmV2X2NwdSwgaW50IHdh
a2VfZmxhZ3MpDQogICAgICAgICBpZiAod2FrZV9mbGFncyAmIFdGX1RUV1UpIHsNCiAgICAgICAg
ICAgICAgICAgcmVjb3JkX3dha2VlKHApOw0KICANCisgICAgICAgICAgICAgICAvKiBjdXJyZW50
IGlzIGhhbmRsaW5nIHJlcXVlc3RzIG9uIGJlaGFsZiBvZiB0aGUgd2FraW5nIHByb2Nlc3MsDQor
ICAgICAgICAgICAgICAgICogYm90aCB3YW50IHRvIHJ1biBvbiB0aGUgc2FtZSBjb3JlIGluIHNl
ZXN3YXcgbWFubmVyLg0KKyAgICAgICAgICAgICAgICAqLw0KKyAgICAgICAgICAgICAgIGlmIChw
LT5zZWVzYXdfcmVxICYmIGN1cnJlbnQtPnNlZXNhd19pbyAmJg0KKyAgICAgICAgICAgICAgICAg
ICBjcHVtYXNrX3Rlc3RfY3B1KGNwdSwgcC0+Y3B1c19wdHIpKQ0KKyAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIGNwdTsNCisNCiAgICAgICAgICAgICAgICAgaWYgKCh3YWtlX2ZsYWdzICYg
V0ZfQ1VSUkVOVF9DUFUpICYmDQogICAgICAgICAgICAgICAgICAgICBjcHVtYXNrX3Rlc3RfY3B1
KGNwdSwgcC0+Y3B1c19wdHIpKQ0KICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBjcHU7
DQoNCihub3QgdGVzdGVkIHlldCkNCg0KDQpUaGFua3MsDQpCZXJuZA0K
