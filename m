Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B7D68061C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 07:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjA3Gnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 01:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjA3Gnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:43:41 -0500
Received: from BL0PR02CU005-vft-obe.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBB627491;
        Sun, 29 Jan 2023 22:43:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwL6kVO8350w6cU3hi+iAyKf6xz4eTeHG4B+2NIL7au4g8WBrxSPT+98UuqX1AptLJpTVr3lqmg6o4/fD7JjgZjx3n97niOHQjkwVu4Woo00vwrUyaZhEMozCamN6NhCV6fg67Xz/cdACuBq6OHNthfsLgq4JUFWFvVA51nM1PJ7/FV/Ckcxp+qFN/hGI3qXZCrtKDOf0odGdoBhzUingj2N60FfMaaWmEKydVXYAaUXPiqv6c7Qo/1p20WQWhv50+jKJIaojwOL+0k5nMNeYpClIGzQv9DmHnD/zf/BLLRrnnEbfcL21OlUaJcdVyuFmSevMtWBk+8Bk7Jc7CUb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bswSPHL/XwpsNDopC9YXxjfq9RwkZWESzA4wA6hKW8=;
 b=JOTmGcEL7hOhTON3t9Ttx6n0pTgha0Or94HERSUbk4VdnOghpRzmxp5MTGRo0rwqUfqm0FD515+AKXVOh3taiLvlsdWdNOMgwsx23J9rm22VUcpeFLFxSQZBBJEteV7ULWG8v4HsIP23utPqBE378nsGkW2anq32BMPLbb8CXjkFjiKQ8OdbVWm8bMPUtDbgMa9b6YIilMJxxcvg4l9y//3IzNcnu73HVWDSdOu82bsbnJeBvP9b8/utBs+/oEn7mU5F7B52OfU1WtuK00B3b+IysndWdyS639kNxGyMl5w2PRY7dJOwvl8WfUJCfPOzAajQlNVu2xoJGCJ4KxUJ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bswSPHL/XwpsNDopC9YXxjfq9RwkZWESzA4wA6hKW8=;
 b=n74ZaUvx9VWk8f0/TI7WbqtSgehqGMHUNxZBBb8twttgdtc830iA3h0891HscdZ3vTf9u/26wa/zop11gnEyLoEG2Q9kP87XpdEgEjAACiNWFuuiKfor4O3JuwBl8ly8YhLlMn0LUrtux1XubZV1raXnQpDqtmZPoy0OEz6pXas=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by PH0PR05MB8654.namprd05.prod.outlook.com (2603:10b6:510:ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 06:43:33 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::624:f4e4:128b:fa0a]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::624:f4e4:128b:fa0a%6]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 06:43:33 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ajay Kaher <akaher@vmware.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "chinglinyu@google.com" <chinglinyu@google.com>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH 0/8] tracing: introducing eventfs
Thread-Topic: [PATCH 0/8] tracing: introducing eventfs
Thread-Index: AQHZLoQIY+66B+0gV0mn71NP5aiSw66sOL8AgAmDUoCAANMvAA==
Date:   Mon, 30 Jan 2023 06:43:33 +0000
Message-ID: <2DD82DF9-3409-43E9-957D-CB296E3FD7D6@vmware.com>
References: <1674407228-49109-1-git-send-email-akaher@vmware.com>
 <1674407228-49109-9-git-send-email-akaher@vmware.com>
 <20230123115108.7dab91f3@gandalf.local.home>
 <223F3594-6BFF-48AF-B0BB-6BF050C8207E@vmware.com>
In-Reply-To: <223F3594-6BFF-48AF-B0BB-6BF050C8207E@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.300.101.1.3)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|PH0PR05MB8654:EE_
x-ms-office365-filtering-correlation-id: c514d3dd-8d32-43ad-b182-08db028d4e9d
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OxX4OOvv5h6mxqrc9KQKviUTliL4mC0XpRNHkbYZxtVqioPruOnkPz9QEYKBSmrlRNOxEGQkmmhkKQ1hXiIw13A32I66DR2WyRydLMaCvgkGw6FvNiXZ1WV93OQQ/gXqsQdCzZRUCKHX2t7XNnuATT5b8rJ9vQgzznBfiF1oejoX6SgunDCc4bulXQYMSeIyP6Nxm5wd9zhN78RoJ+TyBrEiH/9ETzdb5ZjNFbEUHKvuSR/VG4gaj/VULNi8ugu6PlPC94paLbTGx6AyHwr/afbwsiVk/v+hwWrNhjU5+77UZY1SIApuKLuFkY0Cpl/2b86NX5dxM3Xqt745Cs1w0yJc6eCmN8AoJd9Lucpbn2xX4hW0fisHwH2i4b2nH83KuHPwI+q/oWzQMaY01s87L++1Gb10K3E9Ot6juX5OYQ9bpnJRnbBPyxetJ6wuPXnqqQwAxsCUtFoNhKuIz3szG9yUy3K6PWx4SZQesiPb9ZYED8LBll3Q0MAZABgPdFkshMpYdHrwZBGtP3YbmdFIuqzYw0kNUv2Eb9yefT5NQmHVcoTnaRO1AVcbLme4M/TXxogOpYVhnV/cqW0gkOFzKOp4ZTxYyWVRJDV5mm+s/DkCW/9FVbtLj76878+H1D0ZFK/CFR6J16yXY3Tf2BN+Jc+qG7kf0mTmgx1Pw+lzm5TTPReKssLgdodjWWcMpeKC27tL6BlHyi5ghP2JoFxIYOccdVdXlD7V3A1H8La4wtb5VPdgCPhqhFTqGaenG++9tPQpgVwQ+pvw4++8a82C+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199018)(54906003)(6636002)(53546011)(5660300002)(26005)(186003)(6512007)(36756003)(2906002)(71200400001)(6486002)(478600001)(33656002)(4744005)(6506007)(91956017)(122000001)(38100700002)(64756008)(66476007)(66556008)(66446008)(66946007)(4326008)(76116006)(8676002)(2616005)(316002)(86362001)(8936002)(6862004)(37006003)(38070700005)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amVpQzVGMjhQUjhKMndiQWgraHl4N1NLMzFnU2ZMbnNkZnk2cS90d0R6WFhx?=
 =?utf-8?B?ditZK1creW1jeTlDWW1NM2hjQzJtNUlvcXdKM1MvUm8xQ1FHU04zYjZYYU5H?=
 =?utf-8?B?ay9yYjlwYmMyQ2E3OTZka2ZpNU9wUUNIYU8xaWdFU0JJU3FVc05BZjBKblZC?=
 =?utf-8?B?cmZ5bXJ3aDNPRlVZRjRPZ2YxMkY2V1dwTXFxM0E3am80NVlMOEYrYndkbEc3?=
 =?utf-8?B?Y0FKUFZZeldVdHU2NU1DcGxOSVRpVUp5UVFZdDJhREtTL3JnOXA2Y3ZZNVB1?=
 =?utf-8?B?L1VuWkREcjE1ZjFXaGZBb3Y4S3BLK3AwaHFVTEZHNVdTTkJISDZGVTNWSERC?=
 =?utf-8?B?Y3Q2UTV5blQxcXhVNk5aL1JMWkRNdU5YNFVZTHd6eVVSSWsxQjFLSEFld2Ro?=
 =?utf-8?B?bE45cEMyREI2V1RWUE93WUp0UGVRcDJUZnNta3BkTTBiQTh4RCtiekFGUkV3?=
 =?utf-8?B?VG1kanBPbUdlQWFoLzZrSkNuZW9hWGdUei94dGFsWmFmVDFaMXQ1b3habEYw?=
 =?utf-8?B?eURmallGTTNtMHhzOUU1VGg4U0tRclpHVDhvSTI5K0JwVUFtdjhSc1Y0TUoz?=
 =?utf-8?B?K2IzNGpOdEt2Z2gvd1RZdFE1S3pQV0tZK1pHNVdhVTF6b3hJdmFzS1h2OExF?=
 =?utf-8?B?UWszcW1hWXZ3SHpqSEkyNitQOW5RY0I4cnJSdmxsRjVEVEhWazdJUmFpZUU5?=
 =?utf-8?B?b1AveTZVU2Q3OURZOG5iMW5qSHJZUG8xL3NIY1dGeEFUSVFpdDFlaWdNNWFJ?=
 =?utf-8?B?ZXBCTVpCbDdUcVM3YzFkY3VreVJKN3FIeERpN0FHaUxvM2NkT3BGR0pnSXpY?=
 =?utf-8?B?Z3RZa0FLTW9PQ0c5YVpxU0JTcmpXV0FSTm9BZCswMmxtVCtIelJGeUpVNCtj?=
 =?utf-8?B?UVBZS1ZUenZ4QldDNlBGdTlnMCtleFBDK01kNTJBc1dhMmtrTlhIMFdkK2dB?=
 =?utf-8?B?Qlhia0pHenExbytvdThuZ3pBcGs3UExRampabmI5TzhCZ1ducDMvRWtoWDBP?=
 =?utf-8?B?OUI2MnBQRjBObGxab0hYQ0hNNEphZklHTHhMUEpmdUcwR2FEQ1l3QkF0bDZD?=
 =?utf-8?B?eEozalh2TXRKbFBRcEFyYyt3Ym5RVExTWEZkQ0c5WHpnZml0RVE4WWNOVkxl?=
 =?utf-8?B?VWhKRDUvWTZhZm5yckp5M29FU05tNUdmVXNKRDRmTDlCMzNjclVFaXZCOFV3?=
 =?utf-8?B?TWNNRVNaRm16Y1hFcGpjekwzTE9oNUhlU1NRVk11dkYxdlY2ZHNXK2wzcm5F?=
 =?utf-8?B?MzR6bXlQSTRyQmlHMWNUYU5PLzdwQ050NU8ybVRSb2xrVllSMUlmbGxEMklp?=
 =?utf-8?B?WUR0aHdYbnkvUm5sTWJDRWxBK09IT0x3RVdkRFV0ZkkwMUI5Z2JNM0d2ZFI4?=
 =?utf-8?B?Z3hHNU5EdUtOS0EzUFlNemdVV1oyV2pxOVVrU2FvdVc1SytjcWxvaE8rWUdC?=
 =?utf-8?B?TnZ5MGU2ckxQd0JHbDJCcDdTZG9pQWdtWFB2TFVwNVdHK3ZhVjcybmVOMUZx?=
 =?utf-8?B?T1RhK2FqNjJVcS83aStRSCtlZzNLTlNxelZBN3JRbkJOdGRDOEpsN2VCbFRK?=
 =?utf-8?B?cTFBU1ZFWXBzRElsMEhWMVp1cHJBY3lLSTEyMUxCVXdPQXF3SGQ3YVA4Znhq?=
 =?utf-8?B?bnE4RjR5Sjl3S1ozRzVpOERlcWhKK3RHWjlvSVRWRkFnMk5EVFJObkM1alZO?=
 =?utf-8?B?MDZrQUVQYlZCNHNUcGRjT09heG4vUEpsZ3NHWjFUQm1kNkJCb2xWWC9KK1U1?=
 =?utf-8?B?dDdsUjE1Ti91UlBKWkx5c0cxYmltb3ZYTWJydk5hWTNqYWtFSjBEOGdNemJy?=
 =?utf-8?B?YW1oLzk4a2JIS3FCNkwwZEN4ejB5VHVlYXNON2ZTRDNkbEd0dUNZbmx0YXFK?=
 =?utf-8?B?dkM2L1lLWjFKYkNVODVrTUp5eFJpUFF5NnhiNVlwTU9sZFpGTmd2R0ZGZ0NK?=
 =?utf-8?B?MXA0QmlMc1V6aGp4ajdIK0tvVmhCaStBRUtmSXdqdldqWjB2am1senFnNmVD?=
 =?utf-8?B?cTFHVjJwS2dLdXdlRzlPRjZqbjlFT2wrYzBHL1ErS1NkQ3JqclhiUjdoK3gr?=
 =?utf-8?B?bXZKNzYzOFJCbEs1L0tQYTZVdVpGUGZDeTE4NkNySTA0cmo2VFlPRmtUY3lE?=
 =?utf-8?Q?1VSkfry2/jLO5lbNL4KL59O/D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08BED1121310414FA35EFA7995ED120C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c514d3dd-8d32-43ad-b182-08db028d4e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 06:43:33.5346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prXkoxtsuCMXvdCnEBQvxmD/Gpytm0xjsrkDOPiXsY8a4q0nLVCZ5vj/rGgsvyGP0eQbl4SC9aDs648lnNXebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8654
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEphbiAyOSwgMjAyMywgYXQgODowNyBQTSwgQWpheSBLYWhlciA8YWthaGVyQHZtd2Fy
ZS5jb20+IHdyb3RlOg0KPiANCj4+IEhpIEFqYXksDQo+PiANCj4+IFRoYW5rcyBhIGxvdCBmb3Ig
c2VuZGluZyB0aGVzZSBvdXQuDQo+PiANCj4+IE5vdGUsIHNvbWV0aGluZyB3ZW50IHdyb25nIHdp
dGggeW91ciB0aHJlYWRpbmcsIGFzIGFsbCB0aGUgcGF0Y2hlcyBzaG91bGQNCj4+IGJlIGEgcmVw
bHkgdG8gdGhpcyBvbmUsIGJ1dCBpbnN0ZWFkLCB0aGV5IGFsbCAoaW5jbHVkaW5nIHRoaXMgZW1h
aWwpIGFyZSBhDQo+PiByZXBseSB0byBwYXRjaCAxID8/DQo+IA0KPiBOb3Qgc3VyZSB3aHkgdGhp
cyBpcyBoYXBwZW5uaW5nLCBidXQgSSB3aWxsIHRyeSB0byBmaXggaW4gdjIuDQoNCkkgc3VzcGVj
dCBpdCBoYXBwZW5zIHNpbmNlIHlvdSBjcmVhdGUgdGhlIGNvdmVyIGxldHRlciBtYW51YWxseS4N
Cg0KSWYgdGhhdCBpcyB0aGUgY2FzZSwgaW5zdGVhZCB1c2UgJ2dpdCBmb3JtYXQtcGF0Y2ggLS1j
b3Zlci1sZXR0ZXIg4oCm4oCZLg0KDQo=
