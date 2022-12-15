Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37E464D4DB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 02:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLOBBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 20:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLOBBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 20:01:12 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2068.outbound.protection.outlook.com [40.107.114.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CD837229
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 17:01:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sp8wGpdvkFeaH5PTd9HH4193sdTdJfZmhMlK+d8k4ErvkdSEma/I/cw27jOXZInScfCacaKjrj8qOiDgsnPZFeUGeuTa4LcNzDjnZN0oYsZ00iD8VFIcQZ8okK0vlQ0uAC2oeeKZiZbEAswz2o3iwxSMJtXNYNpoWELwfPi8e/8MKOh4AUs1jLsXgfn0saL9Fn2u2fSArytLG30w8D7xZS8P005DA91xF2SMe1ZaqNLpxqSPgpTPGFIMTJgYDS1JmlGJuoxNbbkRH1R+Yef2T8uOGrD74CeUlqNrfYbEz7gndBqa4QNhsTFkGd/3XeyndNV/3xIBrW5niYhNV4VG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utYmaclw1tW1dIKof9Rh+r9o444aeGFerOrHWhRQ1/0=;
 b=CWhhjj0HqdAVuFC5Rxnn4tb0pgvrs89jpI25HcfsYrsqzMOBeEbD74Y0xTcN6esjBNvL6Q2DouONdm6sq7yZLQn9iuESgeTrJGuHwR8cS/Yt04TFY6SyMUXoBvDOsLx0kzzAS3pzj4g7DIOBFK1zmj5kzi3WvsZ1LFpT7Wv+RHxxVJil7sxeepkVxIrP45YY1EBUwcR8tEQRPRSTvPnhZvDsSW32L0Kn0d+apTqrfYynR4M+lvcqdrPh1lBy12tFHKvTBjrFiq6i4NkvLDYrdVlj+HzQ4XU0jnuVhwGXl6dWgKL+vbosL4NZ1wRe8htBYoiVBhVOOepQVlUhees8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utYmaclw1tW1dIKof9Rh+r9o444aeGFerOrHWhRQ1/0=;
 b=dMqjBYmt3yNnDnrbFYO3KjJ6cxXjRmKnyeHnBEVoX0nKHipNXvDbV47V7bAgH7xZVMCWa0CYo1IDtYh4D2GhiL8cRFRMPemzd6iNy07S3BjEU4iKm2jzAbOpY03ptsxul7LsBFPcYg3ykl4g2ldVQX3pztIIMXySwaMEAlCyUyw=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSZPR01MB8580.jpnprd01.prod.outlook.com (2603:1096:604:18e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Thu, 15 Dec
 2022 01:01:08 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::8c61:6836:588:47aa]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::8c61:6836:588:47aa%4]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 01:01:08 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     mawupeng <mawupeng1@huawei.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Qestion] UCE on pud-sized hugepage lead to kernel panic on
 lts5.10
Thread-Topic: [Qestion] UCE on pud-sized hugepage lead to kernel panic on
 lts5.10
Thread-Index: AQHZD1wPDHPJbfR5lUiDJDzp/bO6i65uIrSA
Date:   Thu, 15 Dec 2022 01:01:07 +0000
Message-ID: <20221215010107.GB2020717@hori.linux.bs1.fc.nec.co.jp>
References: <2b4d03bc-2b6e-45b0-655a-58b66672187e@huawei.com>
In-Reply-To: <2b4d03bc-2b6e-45b0-655a-58b66672187e@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OSZPR01MB8580:EE_
x-ms-office365-filtering-correlation-id: c06d8e1a-f00d-4096-8600-08dade37d976
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfGkp9z2qiiwX9K5uJrpu3N8XOMzWoFL5Ge5qQx0SXxeqlVd1rcdOVnR9+8ZUvYbcnVp8TAOjP4sCCWxS1e3vr6Emy01Ge5D1yDGraPizpPMwXkA6CAxEQo110B+sYw4BKwA53/K+O+beIDXsyavEkV9h1SG9HzA1b3EgS3FBnUpWmfnstyXmaFH871plgJXmpRceJuHRCQojk0gNCJavzZvutuLOqtognMMbCgJDlmMWqwQEtG533uGUiKakD5mwesTcqWq87idxexP8dHWKBxJdMu6lK3Q3lzc0wHqtkCOW6+jM6iVUfbMdwuD9rPN/emt9RPt+jozM7yU955xZoU82OawPSLLCVbPiiwtsmuaYN0OHjqkLFilkePTQ/1o3yn4z2ZfovMACGzOx2t8Es2EuZK8525fUZDDU0yA0kAWNyk/61N25XT8eMLYXK8BXWA5s6qDqlFn8r4rO5UnkvcRNTq5wxMWvfD6+cr1y1snSrICfcIy8e4x0rOROtrNsh10HzmNaa7G1kd3V9S4MYhkSHyHqIyR9uujXZqSHwDFAqLWtqmwLEEkZvLS0keAOS6CyMBvdDxIxNEjcG08xGIrMLmQV/E3oDAq/XjHHaZBXRokpZmYY5wBSfNYxabm3A1TJx9AUqU7xuDCkuUyvY0F2DyhLH8DXLP9sH243W2HvpY+BNuDUiwggbBUaGelLWFgJi5Au16ZVXtnpteNyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(38070700005)(85182001)(86362001)(33656002)(316002)(478600001)(6916009)(54906003)(6486002)(2906002)(66446008)(64756008)(8676002)(66556008)(66476007)(4326008)(76116006)(8936002)(66946007)(41300700001)(5660300002)(38100700002)(82960400001)(71200400001)(122000001)(6512007)(186003)(26005)(9686003)(6506007)(55236004)(83380400001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVZraHNIY1RlL0ZrbUR1aHRHckhFL3RhM3pBeWxEK1VtMWtDaFpuZ2xYZklw?=
 =?utf-8?B?VW1VcjhRWlZ1dlBBbWVBZSt0cmlZMDRjVFlSNE9oaERlWGJZaEJ5a2w5RGh2?=
 =?utf-8?B?NzA1ekVITEl0SVdENkUzaURPeTdxRjlaeXdrYktpeFNURzl2a0hYVWJYV3Qv?=
 =?utf-8?B?czYxV0syVWpwZ0pUalo1OUFIQ01KSXJ5R1ZaTm96cmJ3QUFlV3NBWnMreWx0?=
 =?utf-8?B?U3dXTXEzMmFOWEtWeCtQYWlSWHJIdmludlNCYk9ua3ZCTHQ5Q25GTDNHS3Rh?=
 =?utf-8?B?U1dTSmR6bzNRdVJlbUtpSHVXQkhUU204blJJU3JZa3BaTnhHNkowcElQbHN3?=
 =?utf-8?B?MDNQaU1JRzhmVVYzcmJybGN0YThhN0VSY0xtNUp4Qkh6N3lUR2puZE90NTZY?=
 =?utf-8?B?SGM1d1pFaGphOFIzR1hmWFQxcUFyZkFWOTRmYUZ3TWIvYkw3UkFEMWp6UEc3?=
 =?utf-8?B?c1cwcnZPUVplL0lJOUtUT0liZG9pWGFtejBCUWwvZnpzUjhlVGFrYnF4S1Jv?=
 =?utf-8?B?OUh4SWcvZTVPRWZnRGdUMUhHUlFjUktGcnEvWWt4SWtTUHRvSDdPZVhPMVRm?=
 =?utf-8?B?WUtvY3JZdDBQYzUrallIbG8rZDJXaWh4YU9tWGFMOExScVIvd3Y3YVdLWWJR?=
 =?utf-8?B?R2VMODdGV0dwOWhnOHpIYlFUSk1wanhDaXdGMXNBVk93UGYyRy94TTF0dndm?=
 =?utf-8?B?NE1DbHhvT3FobVdZS1lVYmxZd3l5cFJYTEo4aVhaV3hydGJOTUVCOFg2YUxp?=
 =?utf-8?B?WGF3cXZ6Vk1PK0pnOVhSUlV0cTFDOWp3SXVFU3l3Z1NONDZRMC8yRmFTam5X?=
 =?utf-8?B?TzI3MEtMR1F3UUkrRkRVbkVUdVMxSkgzWnQwSmY3RTQzZlRnV3dSNGdVeCtw?=
 =?utf-8?B?ejlHejhTNmtLdzB3dzZjQlIxaVhXOWlXWHNqS3RYcE5RWWlCQ0x6QW9uMWZk?=
 =?utf-8?B?amtoUFY4WjRFUTR4Z0hYczFpRlFuOGtOdEo0NjhrSjYvV04wcm9JS0MxT1V3?=
 =?utf-8?B?eHFwdllQb1hWbzV4OVBFU2RYTjAyK0Z0dFZzWG5uekJUWmhFSXdhMDcxc2sw?=
 =?utf-8?B?NDAxSFZaOXJCVEZYbXF1SnhtMkMxcnRBdnFveVhRMVBIdE5CVnR0ZFpuazUw?=
 =?utf-8?B?SXMvU1h3MUJyZk1CRDlRL2ZJaUJaakpaMGU2Z1UrcmhWNG92V0wvMUdNemgr?=
 =?utf-8?B?VzIvdW5hcEZ6b2lJcWRCUU90RjkzU2o2YkJIMHM2c2pTTjhubFQrY0dicWN3?=
 =?utf-8?B?UFB4UkdxeDBSa0J6RzFZQWFwT2hyYnVTenRHa20yTmRzb2lRMFRoekc5MDJL?=
 =?utf-8?B?eDVtWWNGT2h3UVUrTlZ2MWg5R2xIN0I3dFZ1Mkk2L0lkSld2L0w5VDlVT1k3?=
 =?utf-8?B?a0NDemRlRGRWdFZZYzBzNi9FemtoZ0FFcjdLMExGVlFySVFJenYyUjk5a3Rm?=
 =?utf-8?B?ejJuWnpodXZ3RS9qZStPUURqQU91NzJMeXE3N1FiKzVqSVV5L3c4RU5nL2Mx?=
 =?utf-8?B?RzkvTmtIV2d0aWRQQ1o1aDlSMSt1OGhRZ0RXVU5zVi9YMzg0UGFZV2pTc3Iw?=
 =?utf-8?B?cXg5dlVJRDIwZnRtcll5L2QwQ0VVU3BoRzdrUHQ0andLUTgrWmtrYytKOEw1?=
 =?utf-8?B?NHgwQzlmU1hFckZySXJIaDZ0Umx6WE9CNm4xTHBma01LeXNvSWxNV1l4NGhP?=
 =?utf-8?B?NXdEVjNqWjNmODZqbUoySjg4TlZHV2RzL004cGxJeXF1TEgxUms1UVJZaXZH?=
 =?utf-8?B?Z1hzNzJzcFlXUGFrZ2xaNXhXSWowUEd0eDJrdWp0YlJFbTRNejVBT0lZYkRY?=
 =?utf-8?B?dU42UlRYYS8zUFpzdlMremwrMDhhUE00TEJucDgvNUpXaWtmRnNWbHB5SEFx?=
 =?utf-8?B?WEtVd1pZTzR0enRMUEE4UE16SUg1NHk4bnkzSjg5WTZJWmJIaVpJbWk0NzRC?=
 =?utf-8?B?bHY5NXN2Y2R3cXk2YjFNL1pGeFJ6KzBIZkRrOEdzeUF6TWVXSURkSHlZU3hZ?=
 =?utf-8?B?Q0NtLzB3VVpNdE96MnFoRUllWDIwN2xGcXNYSnRUeHp6Rk1adGJ4RFppKzhF?=
 =?utf-8?B?QTBGYzhmUEtEZnZYeVVES3ZYTlRQWFByRGpMdGpLa3NaYUp4YkxSenpXelNk?=
 =?utf-8?B?RE44SHFGQkhmVTdEeVpLVzIxbExUejlReGNFaUJmQ291ZnFzdTdiMVlHWGFq?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B479E667239E246A10B237907457B35@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06d8e1a-f00d-4096-8600-08dade37d976
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 01:01:07.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O/A+fzt25pHUlU4/wFSMf13CYryEdnk40qoEEtRFCdZN7IQSvfDeM5iDtZQ5dLIaG7CqR55vl5H3LPE8rnAQxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8580
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBEZWMgMTQsIDIwMjIgYXQgMDk6MzM6MTBBTSArMDgwMCwgbWF3dXBlbmcgd3JvdGU6
DQo+IE9uIGN1cnJlbnQgYXJtNjQgc3RhYmxlIDUuMTAodjUuMTAuMTU4KS4gSWYgYSBVQ0UgaGFw
cG5lcyBwdWQtc2l6ZWQNCj4gaHVnZXBhZ2UsIGtlcm5lbCB3aWxsIHBhbmljIHNpbmNlIGN1cnJl
bnQgbWVtb3J5IGZhaWx1cmUgY2FuIG5vdCBoYW5kbGUNCj4gdGhpcyBraW5kIG9mIG1lbW9yeSBm
YWlsdXJlIHNpbmNlIGNvbW1pdCAzMTI4NmE4NDg0YTggKCJtbTogaHdwb2lzb246DQo+IGRpc2Fi
bGUgbWVtb3J5IGVycm9yIGhhbmRsaW5nIG9uIDFHQiBodWdlcGFnZSIpDQo+IA0KPiBUaGUgbGF0
ZXN0IGtlcm5lbCh2Ni4wKSBjYW4gaGFuZGxlIHRoaXMgVUNFIHNpbmNlIGNvbW1pdCA2ZjQ2MTQ4
ODZiYWEgKCJtbSwNCj4gaHdwb2lzb246IGVuYWJsZSBtZW1vcnkgZXJyb3IgaGFuZGxpbmcgb24g
MUdCIGh1Z2VwYWdlIikuIFdlIGFyZSB0cnlpbmcgdG8NCj4gYmFja3BvcnQgdGhpcyBwYXRjaHNl
dCB0byBzdGFibGUgNS4xMCwgaG93ZXZlciB0b28gbWFueSBvdGhlciBwYXRjaGVzDQo+IHNob3Vs
ZCBiZSBiYWNrcG9ydCBzaW5jZSB0aGVyZSBhcmUgaHVnZSBkaWZmZXJlbmNlIGJldHdlZW4gNS4x
MCBhbmQgNi4wLg0KPiBUaGUgZnVsbCBwYXRjaCBsaXN0IHdpbGwgYmUgc2hvd24gYXQgdGhlIGVu
ZCBvZiB0aGlzIG1haWwuDQo+IA0KPiBXZSBkbyBub3QgdGhpbmsgYmFja3BvcnQgYWxsIG9mIHRo
ZXNlIHBhdGNoZXMgaXMgZG9hYmxlIGZvciBzdGFibGUgNS4xMC4gSXMNCj4gdGhlcmUgYW55IGJl
dHRlciB3YXkgdG8gZml4IHRoaXMgcHJvYmxlbS4NCg0KU29ycnksIEkgaGF2ZSBubyBpZGVhIGFi
b3V0IHRoaXMuIEkgdGhpbmsgdGhhdCBiYWNrcG9ydGluZyB0byBzdGFibGUga2VybmVsDQppcyBk
b25lIG9ubHkgZm9yIHNtYWxsIGJ1ZyBmaXhlcywgd2hpY2ggaXMgbm90IHRoZSBjYXNlIGZvciBl
bmFibGVtZW50IG9mDQpoYW5kbGluZyB1bmNvcnJlY3RlZCBlcnJvciBvbiAxR0IgaHVnZXBhZ2Vz
LiAgU28gYXMgR3JlZyBjb21tZW50ZWQsIHVzaW5nDQpsYXRlc3QgKHN0YWJsZSkga2VybmVsIHNl
ZW1zIHRvIG1lIHRoZSBzZWNvbmQgYmVzdC4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
