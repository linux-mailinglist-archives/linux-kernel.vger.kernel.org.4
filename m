Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885105F7392
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 06:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJGEer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 00:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJGEem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 00:34:42 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2050.outbound.protection.outlook.com [40.107.113.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A965CFEE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 21:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4IFj4RvsD0Nj9jd4eQLcRQMR5eFIm0RjkPy1MtloJDYT8I/ZUD2h3M941xNzZCdyufzwTBdVe56QX0lrUrXy3q9aWi9JVyYq9Kvz/y0TqyzCfNkbD+4j/oRZYAhQkZN7ENd6TnlNtof2Ak+fF+k6hQzPArhxc9OlwwWjCtKmkCLb/+fZhnjTG9sKefdk4aJpOfOlF4Ax+xSqaCUelFe+hTWfiOnornPLKKmfoV06TS/BboScSmOpSGWgMMKobE/+qD4rLe30gAC35qJ+GDUnBojlcioSWNHjXtyWoUkR+tFWfwRv9i46TbHuzcx7SscflDRgIwGSbZfIO3qhOXi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEQ3H9TeFk5Ob7+w+LaGObKoBMfLlje1LVOODRtEunY=;
 b=nM3H6kBeO/7EBKYMJi5EELDEUzypm31m/zDIR6pOkdI72Er+aQ00gN/cWF6/kUAFnZHu1Z3OdcDwsl+w6YsZK+hHxXqFhB3BBt+vesUK9DUsP7+ux5dReFr9whPNv+C6IEUvkr/HmS4/nptqNUv7/uSv0PBkYWMhWwsbBwJbeCmiQt16dQG+Sbmo66nEyqYWK4NhJq+GKKZvTSnmrVc4mVmlvYwV/aGNH6Oxm0CQbTA6eH1M8sdBuAVVpZn+pmlxEbvn+Ksy/pDSQ5S4Tt/vulusymBOMxLspXsi5cWJDpLOGDQxQM3/q//SRhqHNEXG1I0o9yyXRGzvD7aTd1zSow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEQ3H9TeFk5Ob7+w+LaGObKoBMfLlje1LVOODRtEunY=;
 b=avYWJliFJ+I1Sy6ZQ3lubJkTITC5AYPauLVSTXCLniJMoKEpY07J3sgLVWG1gMQRR5FVrBKeelwjrceFUOAslk3nNYJFXCHZgmEKjj2znqJooG7WIW/HjflbTGTvfp6ZDCE2abCzoqqd5bgoKiT+1hKep13tx96ejig1LNU2SyY=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB8690.jpnprd01.prod.outlook.com (2603:1096:400:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Fri, 7 Oct
 2022 04:34:38 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::982:49a5:97ae:7673]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::982:49a5:97ae:7673%8]) with mapi id 15.20.5676.032; Fri, 7 Oct 2022
 04:34:38 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter
Thread-Topic: [PATCH v6 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter
Thread-Index: AQHY2elMYt0j6jGli0auvFA3GIs+t64CWGOA
Date:   Fri, 7 Oct 2022 04:34:38 +0000
Message-ID: <20221007043437.GA3236835@hori.linux.bs1.fc.nec.co.jp>
References: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
 <20221007010706.2916472-5-naoya.horiguchi@linux.dev>
In-Reply-To: <20221007010706.2916472-5-naoya.horiguchi@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|TYCPR01MB8690:EE_
x-ms-office365-filtering-correlation-id: 88639665-c0d7-4e0e-1548-08daa81d3ec2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Re4XyZRy9QSBGvAHk9rnCqpYkRjubod/Hr52XJcwFZXUcK9PZkLsRoG4aXWoKYXoy/NPBH4TgFJJ0WpjVbD6ogTrHmQTWIoVvedt8c5cRUDSnRl9VV8e9sgX3JNgn1yGuFRUmXgEipljE8TQyo2K1WBtc3E+kSBmogtjVEgn4TUBFrSfqM8IQQuWcxxfbCZ1Qc2fAI0dTEpCIm1SqIGiz7tDR5Z8akuIGU3LQhqWdvMc/IPA/1Y/6rB7mNIzkqVQlVYD0g/qxHrOvbT2HJclXtlUHKhGOQ1NgvBTp+KnwOc/feAAaqWua/9HTY30PEOpL9ASm1HJTcFle7qPqGwyhODjFAnLvShXsYAQ41FOILuwJlvIvxIVGQJX+MtPfX41eA5J/QU7ob5STzTMSWBBEHuLODmjYeO++2fLaiWL2LrXsoyOmSxK7L9Fe0EUy7QV9r87w1rwYrtZ7V16Z6GVpbFBme+oQ1y/FqbQUUp/AEeDwQzeLFxRL53GKNHhCUUXQkclEGSndoL89PzDFQP1bPTa1DuQ7kPKkiQVTPcsyFPcp4v2XAuCmpdzJ3vxQPTWoQCK8tK6TQAZ8k/hy93cckyf6u09xxQkV4icDplQ392WPJ2RjB16LELVmfwUZVfN5qZx7SIsp6sKJfikNdbrGgATAG7BfVIF2AmlLTvqavVDaaEiHu9YPhcNsf6BiRayTB/0ZjvGjtxo3ktxOLuJRUD3phTOC8f/A29rx+pGrDpnBGYDzW0vWpxztFkarDVFKeTWSugEX/a1HQBmmS/wjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199015)(83380400001)(186003)(1076003)(5660300002)(82960400001)(38100700002)(38070700005)(122000001)(4744005)(7416002)(9686003)(2906002)(8936002)(41300700001)(71200400001)(6486002)(26005)(6506007)(478600001)(4326008)(54906003)(66556008)(76116006)(8676002)(316002)(66946007)(66476007)(66446008)(64756008)(6512007)(6916009)(33656002)(85182001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckl5dEN3aG5mb1oxZC9lRjZXQlF2cTJ6S2dsSGRENzJiOVZtZ1VtTlVZZWtF?=
 =?utf-8?B?VittcFRaQVFNZmI4WnRPV3YzNDZ0ODRpbi9ZVmNjY3VsNWlxOU51eXRzRldX?=
 =?utf-8?B?RlhtOHJuNDNoOVRPT2FRTnhnSWI4Nzd6cTkxYXNnbXZaWk1sSVV5dXlsUkZI?=
 =?utf-8?B?cmRrcXppSjRHVThzRE56bDd5R3dSdjZpRkZoT1RsVmZiakFXazhQSmZuNzFK?=
 =?utf-8?B?Y1NPRGltVW1XdzVuL0lNNVZrckZPN2IrOUpvRGYrR1N2NGg2dCtsY0RyWmZQ?=
 =?utf-8?B?S3BkUVp0dnQrcDIxQzRNS1luemNzMFlYbEkvZC9QS1pDeW1DQU9iaTA4TXBo?=
 =?utf-8?B?ZDhoNGN6UEFsa3NFWXFkOHk5aDdVK3NSYzl1eXZDVFhpbDNYWE11RlR4aUkz?=
 =?utf-8?B?NWsxbTgveTFlaUdwT2RjL3lMOVpucXNscXZHQmUvK045SXlQcWVyTFd0L0NB?=
 =?utf-8?B?bFI3Y3NKcWIwTWZTOW1NeTBZNDdHMDNiWUJBK2ZicnhzOG1HeStaNGFkRlY2?=
 =?utf-8?B?ZGMwTzdrSjJtZ1drajRxK2V0VTF4UzFSYWk5SFZrUXZuUTN0MUdkbEtpRDhZ?=
 =?utf-8?B?WW1CaHNLS00yQ1hWRExSQXM4Mk1LdmkvK3QzeVNUbDBWUm85OW5laVBQSDZV?=
 =?utf-8?B?eWU0bUFIUXRjM1N0a1RkOEN3a0pjcXF3TDkrMDdCeXkwcStia3lBbE91YmQ5?=
 =?utf-8?B?WWhDMUttd2ZYYUVSeFVaRXdmV2w1blJuYlN4UWJGQUhiMExjTmN3SFA1MGpw?=
 =?utf-8?B?emkxL1JUVFVGL2xqVjArOTBFV29XM1llK1lPZkFSOGpkSElIL0FQUXdpUTFw?=
 =?utf-8?B?YjAwdjJtZ0VVS1hOOGFWa1d5NEFmMEVndDhwOWgxb1dsYk9SUHphdVBYSE1E?=
 =?utf-8?B?ZUlUdmZkWHRqRHVUUXdyc3BUV2pjN2RIblJKWGw5VEJFOWhtNCtNeUFnamFu?=
 =?utf-8?B?bHN3Tko0QWY5NWhWMG9GUHZkTCtrQkRaUlhlQVo1N2JuOFU3OHBmN0F3bHFO?=
 =?utf-8?B?UCtDaDg1VWFEa2xzeCtCOERDSjkrVkpTSDZLY0dCSllETHFlOXc1MVE2enBS?=
 =?utf-8?B?QmxHZ254NFkxMEFpL2psOWFnT2dPektCdUJSTWJtdCt1dHBRd05Zd3dsNTh6?=
 =?utf-8?B?MHhEYlh5Rm9KdTl0Nnoyb2dzajJhNmxoRzdkVmszalhiM3VVNWRqU3UyZ004?=
 =?utf-8?B?TktwTVBDMnppWjZoOWlTUFVoRnZVVjVURVFmQW0rdERaMW9zTDFkU09BYXA1?=
 =?utf-8?B?a1Jka282bU5zWnNtclkvQUwwa1c0cEZSd3VaMlhkTHFORlNMUVZTWnJuR1Bn?=
 =?utf-8?B?d0pPUmpJdjI2amNDK3J2YnJtTzlza2FUeUZIRSttcEpsMThDNWNHY21IQTBD?=
 =?utf-8?B?bjZib3pOSVRCa0xSV0c5elhGM2NoUm43cWxJWDlVSmljN0pSU0pmb3k4bjV0?=
 =?utf-8?B?Y2J0QkxVeitxb2JQek1DQ2h2WXY0MDN1UzAzTWU4Q2ZsN0dIcStpVGxIaVlI?=
 =?utf-8?B?Yys5S2d1QVpCUUlJdDZTZSt1QTlEcTFVR2ZCNVdrYm00ekUwcVZsbjI5R0hT?=
 =?utf-8?B?TW5LRThMcWlabWFObEQvYXcyRFBid29VQWc5QUhJQU56YVkxQU1zYlR2bEoz?=
 =?utf-8?B?TDhYVkN1ZThhamJrRXdmRG1qanMwWnRWYWNHcGUyTE1qY0J2bTRhMTlBV252?=
 =?utf-8?B?S2VtVVFTMndNQjA0OGlwUyt5VTdQd0YzQ0c0clpGbnhiNlZpVG8xSFdzanJm?=
 =?utf-8?B?YXNCZHdTQ3doWUVPZmU0ZjF6clpVc3FCMVFpcHJEcFBZTDJVZkJhRi9veUNR?=
 =?utf-8?B?dDFIVVVDekNwTXRFbXJwdHJZVG96c1UyaElrbURQekQxYnFqNnI1ZklaeW9S?=
 =?utf-8?B?R1VHdGtFQjFWWm9sc3hDRFlZbFFxaW80ekFEWGx2bW9DVVkwYjhXclpGLy9R?=
 =?utf-8?B?TVBNWHVNejM4UlpJUUgxNDVXY2xVY3EwMzlpTmI3REhUei9mK0tLZm5MQjRx?=
 =?utf-8?B?NGMyKzE5cFB1VW1KSjRydXJHSnRMeFZ5eGd3WjVoeDZWQzZ3bDk2cHBMZXpU?=
 =?utf-8?B?UGU2UHcxcnhTTExXTVd1eXlDYTAvdzB6TTJselRGTG53QTNIM3c2VHRhd1lR?=
 =?utf-8?B?R3pFVWc2Ny8xSkNweUFBT1NpRFZFYXVZSXZ1OFJIbnFSL09lcjVrRmEwbzlX?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3BBCE4C58FFE04792A898EABD54C5A4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88639665-c0d7-4e0e-1548-08daa81d3ec2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 04:34:38.6146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZAEFb6UkB77mrDmAk/1UTnog1KFAZL0c398um1BMZgW7WG3MagzQV56GYDWIretV7TqyYgBbUd/ggQR1/fj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8690
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBPY3QgMDcsIDIwMjIgYXQgMTA6MDc6MDZBTSArMDkwMCwgTmFveWEgSG9yaWd1Y2hp
IHdyb3RlOg0KLi4uDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvbWVtb3J5LmMgYi9kcml2
ZXJzL2Jhc2UvbWVtb3J5LmMNCj4gaW5kZXggOWFhMGRhOTkxY2ZiLi41ZDAwZDhhMTRjNzkgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmFzZS9tZW1vcnkuYw0KPiArKysgYi9kcml2ZXJzL2Jhc2Uv
bWVtb3J5LmMNCj4gQEAgLTE3NSw2ICsxNzUsMTcgQEAgaW50IG1lbW9yeV9ub3RpZnkodW5zaWdu
ZWQgbG9uZyB2YWwsIHZvaWQgKnYpDQo+ICAJcmV0dXJuIGJsb2NraW5nX25vdGlmaWVyX2NhbGxf
Y2hhaW4oJm1lbW9yeV9jaGFpbiwgdmFsLCB2KTsNCj4gIH0NCj4gIA0KPiArI2lmIGRlZmluZWQo
Q09ORklHX01FTU9SWV9GQUlMVVJFKSAmJiBkZWZpbmVkKENPTkZJR19NRU1PUllfSE9UUExVRykN
Cg0KPiArdm9pZCBtZW1ibGtfbnJfcG9pc29uX2luYyh1bnNpZ25lZCBsb25nIHBmbik7DQo+ICt2
b2lkIG1lbWJsa19ucl9wb2lzb25fc3ViKHVuc2lnbmVkIGxvbmcgcGZuLCBsb25nIGkpOw0KDQpT
b3JyeSBhZ2FpbiwgdGhlc2UgcHJvdG90eXBlcyBzaG91bGQgbm90IGJlIG5lY2Vzc2FyeS4gSSds
bCByZW1vdmUgdGhlc2UNCndoZW4gSSBuZWVkIHJlc3VibWl0IHRoZSBwYXRjaCBzZXJpZXMuDQoN
Ckl0IHNlZW1zIHRoYXQgc2NyaXB0cy9jaGVja3BhdGNoLnBsIHNob3dzIHRoZSBmb2xsb3dpbmcg
d2FybmluZyBieSB0aGVzZS4NCg0KICBXQVJOSU5HOiBleHRlcm5zIHNob3VsZCBiZSBhdm9pZGVk
IGluIC5jIGZpbGVzDQogICM1OTogRklMRTogZHJpdmVycy9iYXNlL21lbW9yeS5jOjE4MDoNCiAg
K3ZvaWQgbWVtYmxrX25yX3BvaXNvbl9zdWIodW5zaWduZWQgbG9uZyBwZm4sIGxvbmcgaSk7DQoN
ClRoaXMgZGlzYXBwZWFycyBieSByZW1vdmluZyB0aGUgcHJvdG90eXBlcy4NCg0KVGhhbmtzLA0K
TmFveWEgSG9yaWd1Y2hp
