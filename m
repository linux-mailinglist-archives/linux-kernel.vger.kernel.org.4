Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C6C6D16E4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCaFmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaFmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:42:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2077.outbound.protection.outlook.com [40.107.114.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA1511EAD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV04qKv8hbsVGbNJdQfYNIffisrvuecBubfnOTMgxRt3Zwav6EqSKQaePzduTC+rT7zG2gGUWDIxAUGxQfOu03LXJizdVVNfrLV9/pnrCv0CuLSNY+IJuaFW1ON3LNpJ8qBXdPjjLl8jgM0JkFBmjcRhuq1egoERkvS/P3M/9fLJBV/onb/LX1o41P2nCXP7IIY5hJMdfft2Q1kgUtYB17eaZXl9sRcTXkD8j1xuQUza0nbyHizy0RADF8+XhaH+VIKAg2ZCaN1MP6NhnpDp06kOcxxJNno3geTW7onAT0OgHqjHt4yvbcCMwunXIIaJZihvlgGnA2cjNqatr8aZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/dqc7Epd6sfyPJctyOo+9ghT7Eucrzhx7Apvbi67cU=;
 b=dCBw+H0RXrpPcT6Kb7xcMjcjGL0q16lNgdkJ8C+DzbDL0fxL3Ek6BGltGkFA1XApNzKFCaptuj30zmHBZ3L4x6FvG9ivasdIuVDhPEz5aRp7OYNpd1jotSc715isqOBdfRhmiVgP0g29aBbFr+3oxtPOmcekvr4B1YzaSJEP+NNv6PrIZHzK8PQOKtJ+iofWKs6cs9VIGnU99giF62REVFgGeKOR7/eIeg/bkXlRjtdA0MGtnUYMD0Iwg+JVJCQLb6yEqinIrzjYb5J1C0P8TUI9HJg0NlwFuVWce/eJVzzpbWFzSQm9DVl87fnmOv33Trwg/BMtrK+wvoo257BdEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/dqc7Epd6sfyPJctyOo+9ghT7Eucrzhx7Apvbi67cU=;
 b=FCV8gOzwcp3iZO2ln8UzY9kPOBOaLXh1PLbEDFCQOj3XqkSaUPBK3iaTSTUPf3YaAUQEuPfxnGeTflm5bdBV5k942JM7Mk7RLwP5Mw7kZOxXoPCnTAE2GQaruKwqhkBQLldyoVL3sPw1NJq3vmTTk9whxA0e1ECD6xrLuovw7ZQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYAPR01MB6284.jpnprd01.prod.outlook.com (2603:1096:402:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 05:42:44 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::22a3:7e89:cc26:15c8%6]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 05:42:44 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Longlong Xia <xialonglong1@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm: ksm: Support hwpoison for ksm page
Thread-Topic: [PATCH 2/2] mm: ksm: Support hwpoison for ksm page
Thread-Index: AQHZYtukRA1rprlVwk26L/8bdjt87q8UYYKA
Date:   Fri, 31 Mar 2023 05:42:44 +0000
Message-ID: <20230331054243.GB1435482@hori.linux.bs1.fc.nec.co.jp>
References: <20230330074501.205092-1-xialonglong1@huawei.com>
 <20230330074501.205092-3-xialonglong1@huawei.com>
In-Reply-To: <20230330074501.205092-3-xialonglong1@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYAPR01MB6284:EE_
x-ms-office365-filtering-correlation-id: c201a3c5-8931-4fd5-b95e-08db31aac048
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ffXyRt4domxD9ENt4f5yTWpH8p5p4FqJI2dHLkIktewdSMDNMq8qdWJZ2M99KXce4EGkKQS9hreHZYkh4E/2vDZOhDHVFHzyyJyCtefDOVT/OljOn49FFZK8oD5PcpUZu0TP9e0wDojlehACV4I5oOZif8TnR0oAMofpTKcHKGnQoZ5m8zYFyFSIzn7Df8xUUIUpkH8g/9SDZ7V8F/plpGGAnkHePGJSt88ziOinefHC5iXxN05mrARwMMxgfWvVgMsbKqghhDjze0DimyxLF191s90ra+f+St8Tzzrue7nwegDRRd8Ra1zwVTWOZex4vbPOi08AZZWuc6Cv//845urV2jIQNJRqsoXjiHs9a//RI8ngF6wLuj+L06LQmVNgJGizZZLbxEScM7LC9aFhNLcNoyzVc3KYrf6j7R/CFUtOpqEn7Izgblf2K7Xo0PAaQNZduYB6LGdMA+Lk/CAvl73Pfnh28oYdLpTHlhvdu0+L0zagGA4kAcX5SkxGOu7yyhFVOYzwivR4nE7cysmg8BGozVV2ecyixLXET0IJ1kbAJODiZFHPXlw3xIl5xDyE8DSabVzebEM+EKkR8q8QsN+PsrOGKSqjmmxHqmztVkgUjS7RaBuALXxnGWa7nef2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(6506007)(1076003)(186003)(8936002)(9686003)(6512007)(55236004)(83380400001)(26005)(41300700001)(54906003)(66476007)(66556008)(478600001)(316002)(66946007)(76116006)(71200400001)(64756008)(8676002)(6916009)(66446008)(38100700002)(2906002)(82960400001)(33656002)(4326008)(6486002)(122000001)(85182001)(38070700005)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1pZNUptd0wwZ2U0V0FpaWxid2o1ekJSVjFXcDV1anJPYUJNL0g1cGtqc1lt?=
 =?utf-8?B?QkFGVUNDSlI2L2RISXdsUzFXY0ZOR3BGbWg5OVd1TjQ3V0xCNlZObWpzbTVQ?=
 =?utf-8?B?bk44aDhlQ2pwd1FQZXpJMDRZNm5JNkNZUitZNzNhVk1xUy9IZE9WN096MlVl?=
 =?utf-8?B?TTVXNnYwd3VETnQ4VVpaWEdGR0dtenFJUFI3emVudU9UaWpJeG9QQm10elNk?=
 =?utf-8?B?TFYvbHFodzdpRFcyQVFIcVlObEtRWmNYM3BYa3djSHE1SWV5TU84MFZpZk1N?=
 =?utf-8?B?RjFaek8za3A5QVI4eHc0TVdqcG1Qd0Y3K1JLSWZTOUZkMXBwcWNKSkVpY3hW?=
 =?utf-8?B?YURqQ0Z1OHJpd3JVZzIwQlBIY1kvcmNmRWplSjRFOFdnb0lSclVublp2UW1I?=
 =?utf-8?B?cEFBd3RDTVlMeitmSW9yWElJSHplWldOWldHMU5nbWZCdVlnak1xeDlxRWRt?=
 =?utf-8?B?TWtqek51bjNmd1dyQjZodnVMREpZb3ZOMHcrMlBWODlxKy9nMGp3bFhGWlBi?=
 =?utf-8?B?TXMvRk90bHdtclByK1IrRERYUUlJZUxVNm5IbHcvS3dNM1ZJZ3RBTjRKcmFs?=
 =?utf-8?B?c2g2T0NCam41TW5haE9JRFhRZVJkVWxkTWQ1ekdMOW1PbXRkck1VdVF1aTA3?=
 =?utf-8?B?YXZ0Q3ZsY09wT3RSZHpjQURpMGFwRm14aTRDUytpTXpwU1M0dUNuYTY4ME1S?=
 =?utf-8?B?UHZLY0N0bXVBS3lwOHNVeU5ra3dBMGlTdk5xK0JQbFVWYmo4NXJQQklvTUxI?=
 =?utf-8?B?c2VPeHdLVVl5U2lsRmVUa0QzUTdSU3B6VGU5em00OHBsckltcW96OGR2M1ZL?=
 =?utf-8?B?U3BTdGVRYm9YSmRadkJOM3U1dFBaQVZjMnFOY1R1NXJ2ejFEKzdvN0UwaHJ0?=
 =?utf-8?B?akRNNFRQZjVDTTE3NUFMNmlKL2RGRHRBL3MwVTFhbG5DVXBpV2paWGxYR1k4?=
 =?utf-8?B?djFrNEVJRmRkcm5rTGpaUlIySkwzRDZ4dStXV3IwVC93V0haWlZCdlhjaWpz?=
 =?utf-8?B?eGgrNlhiYUVwVlAyd3YrWjAxMklHdnFhc0ZkYm1GUjBNOU5aTlBxOVlUdWo4?=
 =?utf-8?B?aDRHRmNmc1Y2QnhGNVQ2bUtxNWhFbUNCTWhqalV4NWt5c3kvakFJek50U1N3?=
 =?utf-8?B?ZVFyWWJqWXV0YkNkOExWMWtsYStVM1VtcGhzKzhpeStoamJDTGZaNjNtekZR?=
 =?utf-8?B?Vk9EZitoK3NUaHdQYlJIS1RXd21sbkxYQmNVaFc2R296Zlc2MmZ2THgxSnlp?=
 =?utf-8?B?NGl5U2dteEo4ODFUbUdqSkRGcG1PWHZjTmU0UXowN0RxMHRSblYwYy8rOXUv?=
 =?utf-8?B?RTRrcGlqTjVOR2hqNlN6L3Z3c3Z2ZGF5R0c1MjhwclZDVTNQYVhWTXIrZVdO?=
 =?utf-8?B?V0hBYU5TZ2VhSVNXNFhqbFloOUJUMStuL3I0WS94MjU1NXd2UmdFS3RpcHlu?=
 =?utf-8?B?YldCcXRaME03Sy9SQ2U3cXV0WkJndGFvQ3FPWW01eFliZExMUWQ0WWlBMWZI?=
 =?utf-8?B?ZmszZUppSzFnMTdLY1h4ZDRvVVVyaVhwK2JDWUVVcWNJL01CTlp4RGtyUTRR?=
 =?utf-8?B?TXducGVWdnMyK2xoTFJwb0dIaW9DbFEyRk5GZlh4TnYxcFdEb3FzaVlLTG41?=
 =?utf-8?B?K1VDVlVpVWdqb0hjUlNHa3lUaHJDTDkyUUtXWi9lVm9zVlBkQW55SDBHN2I5?=
 =?utf-8?B?SGVGd21Kc2JTUUUyb3VTN05uWlBHd2xaV29WdE9uRVJWS3ZvL1dmZ3lON0JK?=
 =?utf-8?B?aUcxUGlKR05neXNvRmJvV1BISFJiQWNVcEJqR3ozS2p3NFhMMlk5TVVFQXlU?=
 =?utf-8?B?N2RPcUplVWZONUhVMk12MlpLNXNwb0F5UEtDNTZ3Z2k2MmFWdENVZjdsNG94?=
 =?utf-8?B?dG1pZnh0MVNJNytTbDBRT0w1RkJjQldld1llMEo3Q2xIdGk5WWVMNis1U0g3?=
 =?utf-8?B?MXJ0bW1yTStOcmV1MEhzd2JGUmlrVkpFODBaSWdRMG13RGpCQmR2V0RVdUxy?=
 =?utf-8?B?dFVlMDVMbVViUjZEQW9ic0tCeTk0UWVLNnZFMVNGVWNYY2UvS0tidHA0UmJn?=
 =?utf-8?B?VDQ4NUl2SWhTVmVkMnlOTTlIS2twZ3lOUCt6azF5NUpkYk83TmtpVGltVER0?=
 =?utf-8?B?R2JzVWMzb0d6YkR2enJGOEpGN2dIdGkwcmVmSzJ0RTJzRUpXYm02T0dkMUF5?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B415D9BFB48F5945AFEFD7F65C6513B0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c201a3c5-8931-4fd5-b95e-08db31aac048
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 05:42:44.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZ1YRQThu7lwiKb7zQQzy1avwTV4hjn46cNnCqeXE/eKTx0o0dQi3sUA9PMcObQA/MLqxmkhNPiVbs3UC9dxTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6284
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXIgMzAsIDIwMjMgYXQgMDM6NDU6MDFQTSArMDgwMCwgTG9uZ2xvbmcgWGlhIHdy
b3RlOg0KPiBod3BvaXNvbl91c2VyX21hcHBpbmdzKCkgaXMgdXBkYXRlZCB0byBzdXBwb3J0IGtz
bSBwYWdlcywgYW5kIGFkZA0KPiBjb2xsZWN0X3Byb2NzX2tzbSgpIHRvIGNvbGxlY3QgcHJvY2Vz
c2VzIHdoZW4gdGhlIGVycm9yIGhpdCBhbiBrc20NCj4gcGFnZS4gVGhlIGRpZmZlcmVuY2UgZnJv
bSBjb2xsZWN0X3Byb2NzX2Fub24oKSBpcyB0aGF0IGl0IGFsc28gbmVlZHMNCj4gdG8gdHJhdmVy
c2UgdGhlIHJtYXAtaXRlbSBsaXN0IG9uIHRoZSBzdGFibGUgbm9kZSBvZiB0aGUga3NtIHBhZ2Uu
DQo+IEF0IHRoZSBzYW1lIHRpbWUsIGFkZF90b19raWxsX2tzbSgpIGlzIGFkZGVkIHRvIGhhbmRs
ZSBrc20gcGFnZXMuIEFuZA0KPiB0YXNrX2luX3RvX2tpbGxfbGlzdCgpIGlzIGFkZGVkIHRvIGF2
b2lkIGR1cGxpY2F0ZSBhZGRpdGlvbiBvZiB0c2sgdG8NCj4gdGhlIHRvX2tpbGwgbGlzdC4gVGhp
cyBpcyBiZWNhdXNlIHdoZW4gc2Nhbm5pbmcgdGhlIGxpc3QsIGlmIHRoZSBwYWdlcw0KPiB0aGF0
IG1ha2UgdXAgdGhlIGtzbSBwYWdlIGFsbCBjb21lIGZyb20gdGhlIHNhbWUgcHJvY2VzcywgdGhl
eSBtYXkgYmUNCj4gYWRkZWQgcmVwZWF0ZWRseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExvbmds
b25nIFhpYSA8eGlhbG9uZ2xvbmcxQGh1YXdlaS5jb20+DQoNCkkgZG9uJ3QgZmluZCBhbnkgc3Bl
Y2lmaWMgaXNzdWUgYnkgY29kZSByZXZpZXcgZm9yIG5vdywgc28gSSdsbCB0cnkgdG8NCnRlc3Qg
eW91ciBwYXRjaGVzLg0KDQpJIGhhdmUgb25lIGNvbW1lbnQgYWJvdXQgZHVwbGljYXRlZCBLU00g
cGFnZXMuICBJdCBzZWVtcyB0aGF0IEtTTSBjb250cm9scw0KcGFnZSBkdXBsaWNhdGlvbiBieSBs
aW1pdGluZyBkZWR1cGxpY2F0aW9uIGZhY3RvciB3aXRoIG1heF9wYWdlX3NoYXJpbmcsDQpwcmlt
YXJpbHkgZm9yIHBlcmZvcm1hbmNlIHJlYXNvbi4gIEJ1dCBJIHRoaW5rIGl0J3MgaW1wb3JhbnQg
ZnJvbSBtZW1vcnkNClJBUydzIHZpZXdwb2ludCB0b28gYmVjYXVzZSB0aGF0IG1lYW5zIHdlIGNv
dWxkIGFsbG93IHJlY292ZXJ5IGZyb20gbWVtb3J5DQplcnJvcnMgb24gYSBLU00gcGFnZSBieSBt
YWtpbmcgYWZmZWN0ZWQgcHJvY2Vzc2VzIHRvIHN3aXRjaCB0byB0aGUgZHVwbGljYXRlZA0KcGFn
ZXMgKHdpdGhvdXQga2lsbGluZyB0aGUgcHJvY2Vzc2VzISkuICBNYXliZSB0aGlzIG1pZ2h0IGJl
IGJleW9uZCB0aGUgc2NvcGUNCm9mIHRoaXMgcGF0Y2hzZXQgYW5kIEknbSBub3Qgc3VyZSBob3cg
aGFyZCBpdCBpcywgYnV0IGlmIHlvdSBhcmUgaW50ZXJlc3RlZA0KaW4gdGhpcyBpc3N1ZSwgdGhh
dCdzIHJlYWxseSBuaWNlLg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
