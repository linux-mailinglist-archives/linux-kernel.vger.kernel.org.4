Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C1C64F89B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 11:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiLQKFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 05:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiLQKFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 05:05:20 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2078.outbound.protection.outlook.com [40.107.12.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61267178A7;
        Sat, 17 Dec 2022 02:05:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nolec61XN+Cb3BFsROHWA7XOXbjU7lGuWVOJD7fe5qwRYjaeA/9acl7ybSR2HTrhErAhm78taxMKBbNzOKcJc2mvkKnjBQLAghzsMwkB/aJPUbm9Brg6gSB4i+AEq0/0W9Nx1f4VOSjLjH5SMsTWqSikWs0DxAtEuM3HcUr8r0w9AiYuwxMqD9QHvBxgH5ZgnZ8OwwU7cPP5wzghUgEahboDnChOQHx8jVGYQA7mKAGhgbUj2aIBA5mBW/st51pM0KOuo+XZAUK6tcaI6kr280FKxgBop1Z6Zsj3/mE/pgNsnW+aRWUYAhHB7hlHV5gM8XJz9v04+YmtdWby82eLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbnYCAJGrOPSQEDh36RJ/Zwl/ecVvRp2aGCZi9KtH34=;
 b=fAD3AvXFj9mU7mWrKuteuljEfiN0eNtChsxX5AE+8raSxBqHukVhkmoEbsSVZE+XMuYwRwc/VZgGdkRKVVWfQi9MC9mefZGrJ48OWhv49XZbV9AxKFjSVhTh9ntocFL62TyTTrWY6x4Gl5dxsYeqT3Z7+AXvkFYXBim1053SrXTkdlqYrDQED6Fb7L9SzE9JcKq1BywJGnEJ6wE539HdxELNkGODGEXBPbjMwwjfCLuLJ6XRmoZNLLh+CR4QuKS0SyH6UMGoYfVS2dLT1//GgLMeHAfqeuNnhG1RxzbeBLLude0OZBXvKISLWCz3AAvtiKArUl99DZZWvOLQd0fM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbnYCAJGrOPSQEDh36RJ/Zwl/ecVvRp2aGCZi9KtH34=;
 b=1sKINo2cJE85D03eMWXlGe7gufBUtSRE5MnXufZBPxs+uwk0isSUlof9n2e7VUk/nOFMuGqeEXopkU20lBcsKEW3IXs3WzVVYu8Mj5cmhsjDW9HoFzIlTI6anw/m/eF37D0sk3aneCiY5Jq3hl6TtXSFn9EWptXpER9Rw1yZ94OLof8EB3UYA+JeXKpGYsqTgBX9m82qTvG+m5LyzOzafrJDIrwD3H/ArEFAGanVkmiB6m8Nq9yms1tuFByRg1j9tZ4vBJ/gUe6httXqZ2iM16ZJzFBEMZi/9pDBUH16hrcOcyjzB4niUD4lcm1061vaF3or/YkSEjJRVFzR6J1JPg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1598.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 10:05:15 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8e8b:856e:12eb:ff9d%9]) with mapi id 15.20.5924.016; Sat, 17 Dec 2022
 10:05:15 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Allen Webb <allenwebb@google.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 1/5] module.h: MODULE_DEVICE_TABLE for built-in modules
Thread-Topic: [PATCH v7 1/5] module.h: MODULE_DEVICE_TABLE for built-in
 modules
Thread-Index: AQHZEZwy65nCi6FE60ChA+D3ghoPpK5x2uWA
Date:   Sat, 17 Dec 2022 10:05:15 +0000
Message-ID: <7394f5cc-35be-0bc8-f92d-bb9e71d3f85c@csgroup.eu>
References: <Y5IA2NYE5IaAzNby@kroah.com>
 <20221216221703.294683-1-allenwebb@google.com>
 <20221216221703.294683-2-allenwebb@google.com>
In-Reply-To: <20221216221703.294683-2-allenwebb@google.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1598:EE_
x-ms-office365-filtering-correlation-id: 696e3bcc-8d2a-4da4-299f-08dae01631ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5aZqumEiqGXyD1SfopETK0Tv4puUdSrjET4DaqSDsn1jY3RlF89QjmBcT7ZH96QaSYIK8XV8SRB9T7A+ue49nhQotYrDxpsPqh0NXENXUdD7sySJc4GZk3tiiKASCtRt/+OCDJnSSLHdrXEwGED/VnGfGLiJNmDdSGo/wnu9Y9gLcvML0NsXOMXZYuQZ3mKzn55eRmkuuym4ZN3qt4dLEkD7mKibzUyCL873a9FpWDSGP1lDtdwN0n8LMUmjydmqASYzif7LsoH6VV4k7Gf9jlJKQPwDg4CsapmPvsbwvmoZN6CA/XxIhsKJ5UvJ5QRAwBaXKHBJLLLxw7CMn4bRqlG+QRUjoFGhzohaFItzmQyoLUFz+BNpfSZ3e+FV2AbKxDAfxpvjaZCTlU4PoiKX1Q9Zt5dmqcuZwdNiUu2xVmyG9yyeF9CJWhMf5eENPRZrO/0U1RGyxDIyh4JRV7zK7bbm+72YQqCCLvp4Nn3K/8zQYZ9G1PACR+R4BUdsSiZdK9KrRwvUhiAgczBkGGYbdAjukSwk+rvvbnrZTZx/POPgc6ip6LXetSXMtzT4ViyBM48JTjb5OmvszLnRzEk/lxv6e73JQ5fifYYwFq3kz6g6VeIrt6BwENu2GdTiYwywqZjUaZEcTDWwwteGIJXb5ez0DHGytGMHkcdq3RIRMjTSovQiOHxEs9hgFGoKk+WTwYLFlfrUkhJXNRoiiCyDvucXYKBysL1m2JAKY9INnsrW6MqpvXybGcSdbS3KrSJsIbMi1JrcFQWi6F1Fpwt/fMVfMdnIxnAtxdC64mZNHAQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(346002)(376002)(39850400004)(396003)(451199015)(71200400001)(6506007)(2906002)(966005)(478600001)(6486002)(31686004)(6512007)(26005)(186003)(316002)(36756003)(54906003)(110136005)(66946007)(66446008)(2616005)(76116006)(66556008)(66476007)(64756008)(4326008)(8676002)(91956017)(8936002)(41300700001)(66574015)(5660300002)(122000001)(83380400001)(44832011)(38100700002)(86362001)(38070700005)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkJrQ29xV0RTWFYrWGJBNVc1emtQOGFBM3BPRndzNzJkVnVOZ25QaXNjc2U4?=
 =?utf-8?B?VklwS2FkZUkxb0ZsM05FSy95QXF6OEpuczNJOXU1QVBPNzk1ZjRpZnhWa2lX?=
 =?utf-8?B?eUlUOFBHRm9ya0hkOXZxZkIyTG1zS2ZtQUtuSHJ6ZEt3aDRuSWx5WC8ydnpN?=
 =?utf-8?B?c1dpdU9TRThXcU1DaGpQSTdWZmx1Qldya2svWUdRTWF1Qk1mTDJGZkppbzI1?=
 =?utf-8?B?Vm11R1hmT1kwTlZZUG8wN2pwb0hIOUhyenU0dXIwVnVidG9MQVV4SnNOc1Jm?=
 =?utf-8?B?c1Z2QWZWTDZ2ZGFwbkp2OTRERUljVXlucDlqOXhVbGVId0VsVjdyYkNWVnUy?=
 =?utf-8?B?YVorcjNrVnBCR3VhMlhDczFQS25HWkp3MlVhdForNEVWMUlKTStqdUYyZkNV?=
 =?utf-8?B?OUhxaTFuMTNmeE5lVUk1UExTYnFROHN0cXhWUWk5S2dJQXRjTVY4Mm4yQlVM?=
 =?utf-8?B?TTMrb2JOM3JxSnNaeS9NOVl1dnAvK0pJeWlMQmJlMjhjRzBWcWxvc01VZjFr?=
 =?utf-8?B?cFhWT1hpdXNiZVF0QWFHY3FLMStTUjVTdEQyNlZSMU1odFg4VVVtN2hPdzdW?=
 =?utf-8?B?OTdJNHgvTFRmMXlCSVI5QkRyMXFhS3pGOGxteHhudnFEN1pFSEdSTURyNU1w?=
 =?utf-8?B?YkZyU1NvdjZRejlNYmRMK01DaUNIdzhEOTRCSmNGM3g0eFYyTUxsMExBOFh2?=
 =?utf-8?B?MmN0aEUvd29lTS9NMS9QQkNxWFZEN3VHVkxlaC8yNTdZN3hHV3JnNlQ0RlJx?=
 =?utf-8?B?UEFVNDhiM2IxL2NoK1l2QmhLSFhMRlRQd3RpZTgxRHBOVStBTkYyaGoxbkZZ?=
 =?utf-8?B?Nms1WXFBMUplb1NEdkRiUFRlTWtteCs1MVdHSUdscHpqdVlpdU1lSHIxTmVp?=
 =?utf-8?B?T0kzbEJ0RHFtTFIwTFpSY3NkZmN5eDc0ZWpmMmRkUkYvRjltL1VjcEVPOVdz?=
 =?utf-8?B?bk9tTnpJVHR4Tk14RkdNcjBtcFZmQlBNMjJhZUdNWUQyRVlXTUJrajZMeDJr?=
 =?utf-8?B?blZzMHFZS1JvZmFadXhlSjQvSmp4NGdHSUZVekxkbWhKZkEvNThCbnhmYnhn?=
 =?utf-8?B?UGlTQ3NOVnhIbVZTVmdUNGk3MUJoMVpKdGZ4RFhTYzgxMW81RndLQlkxUkpS?=
 =?utf-8?B?aE1uNGhGTmgxcGVXbkhGMTJOdHhjaXNtR3ZxWklYSXRYSWloUzltRkdqT2FJ?=
 =?utf-8?B?dU9md0M0QlNEMHU3NzhZeDZ5eUNGNXEydi9PenVlNHZ4NE9zQXdlbzgzNG81?=
 =?utf-8?B?VnlhOGc3amd0OWVIbUZ0TnBCejZuRnhHQ0dJSjZEQ2syRzNxMThmRWlIZ1pw?=
 =?utf-8?B?bHZmcTRVMXNrclpuckgwcTZ3SzhiQ25CMUVubXd4ckR4eU5OM21YYTJCVGsy?=
 =?utf-8?B?cUwzclZPUWZlOVVONG4zR0ppalVmeUIyazJqbUpKRTRhd1ROVmhsYWVpMFpp?=
 =?utf-8?B?enJlNEFkK2hjcU4xdXhaQWV4a3dkUWFydXJreDJ5bVc2T0NOZkNjUUpleHRq?=
 =?utf-8?B?Y05BaGZMK2crT0loRnpPS0szNEtIc3hSZjNuZm5UQzl5T3dUMGkwa2ZxNzVC?=
 =?utf-8?B?QnhWMGc1ZThuVHJ4bUtIa0xIU2QzZE11cGlHUlNNSFFYMlRhbEs4V2hITXBx?=
 =?utf-8?B?SnM5dWprVm85bEk0eEFzeHcxeTZ5Qit0NFJyR2phLzdoSk1MbXhxSlE3bFBV?=
 =?utf-8?B?bnVtZjRDb3U1NGxGalA5TTVXSDZsTEF4OFNuL1IzaEFhWEtQakwyZ2JhYmg1?=
 =?utf-8?B?UlgzcDRqZnI5MGZxNllwOEtBc01OcEhqRDZmVTNLck16UXRsYW91L0lFNmFs?=
 =?utf-8?B?NnNWYXRwRVdlbVduRzdDN1JrNU1lL2wwNGFhaDZGeUQ4OWJwWlI5MEx6NmVk?=
 =?utf-8?B?VERtWkVxb2hZazNzZUoxMG9CbkM0WWYwNFdVbDlwYUcvWVg2aHU4TGxyOTJO?=
 =?utf-8?B?UHYwY00rYncrM3F4dUtsNTl4N1FNNWQyQVYyU2xreXdrcXVJa29GTGFic1Ja?=
 =?utf-8?B?YnZPZGlxNWJybG5ha3ZtUHVBWlZFRWM5emdRZm1FM0xSZi91OWpRS205MkY0?=
 =?utf-8?B?TUdoOUlLTEJaUmMwSzNHWnh5aURqNlBGYVdSeWtDTENXSlFtUEczZGhJVk90?=
 =?utf-8?B?MWxxMnB3NUVoZWxTbWxpMmdTKzd0RnRFcXlnRHByNkRSV2dNUGJNdUtYa1l1?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6245D3807D4FC845A0F9254C607A296C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 696e3bcc-8d2a-4da4-299f-08dae01631ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 10:05:15.7562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZadKUc0mBfhWwzX0agrn8f5TPAfM6vvaeiQxZI5gSelhYHB8UvqPuwGFMHduUPCoDiBqUFLOjnHwlBw1aCI51/Wd3gM9uVTYivQ6Wd/O7ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE2LzEyLzIwMjIgw6AgMjM6MTYsIEFsbGVuIFdlYmIgYSDDqWNyaXTCoDoNCj4gSW1w
bGVtZW50IE1PRFVMRV9ERVZJQ0VfVEFCTEUgZm9yIGJ1aWxkLWluIG1vZHVsZXMgdG8gbWFrZSBp
dCBwb3NzaWJsZQ0KPiB0byBnZW5lcmF0ZSBhIGJ1aWx0aW4uYWxpYXMgZmlsZSB0byBjb21wbGVt
ZW50IG1vZHVsZXMuYWxpYXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGxlbiBXZWJiIDxhbGxl
bndlYmJAZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVkZS9saW51eC9tb2R1bGUuaCB8IDEw
ICsrKysrKysrKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tb2R1bGUuaCBiL2luY2x1
ZGUvbGludXgvbW9kdWxlLmgNCj4gaW5kZXggZWM2MWZiNTM5NzlhOS4uNDllNDAxOTM5MzEyNyAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tb2R1bGUuaA0KPiArKysgYi9pbmNsdWRlL2xp
bnV4L21vZHVsZS5oDQo+IEBAIC0yNDMsNyArMjQzLDE1IEBAIGV4dGVybiB2b2lkIGNsZWFudXBf
bW9kdWxlKHZvaWQpOw0KPiAgIGV4dGVybiB0eXBlb2YobmFtZSkgX19tb2RfIyN0eXBlIyNfXyMj
bmFtZSMjX2RldmljZV90YWJsZQkJXA0KPiAgICAgX19hdHRyaWJ1dGVfXyAoKHVudXNlZCwgYWxp
YXMoX19zdHJpbmdpZnkobmFtZSkpKSkNCj4gICAjZWxzZSAgLyogIU1PRFVMRSAqLw0KPiAtI2Rl
ZmluZSBNT0RVTEVfREVWSUNFX1RBQkxFKHR5cGUsIG5hbWUpDQo+ICsvKiBUaGUgbmFtZXMgbWF5
IG5vdCBiZSB1bmlxdWUgZm9yIGJ1aWx0LWluIG1vZHVsZXMsIHNvIGluY2x1ZGUgdGhlIG1vZHVs
ZSBuYW1lDQo+ICsgKiB0byBndWFyYW50ZWUgdW5pcXVlbmVzcy4NCj4gKyAqLw0KDQpUaGlzIGlz
IG5ldHdvcmsgb25seSBjb21tZW50IHN0eWxlLg0KDQpPdGhlciBwYXJ0cyBvZiBrZW5lbCBoYXZl
IGRpZmZlcmVudCBzdHlsZSwgc2VlIA0KaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9j
b2Rpbmctc3R5bGUuaHRtbCNjb21tZW50aW5nDQoNCj4gKyNkZWZpbmUgTU9EVUxFX0RFVklDRV9U
QUJMRSh0eXBlLCBuYW1lKQkJCQkJXA0KPiArZXh0ZXJuIHZvaWQgKkNPTkNBVEVOQVRFKAkJCQkJ
CVwNCg0KJ2V4dGVybicga2V5d29yZCBpcyBwb2ludGxlc3Mgb2YgZnVuY3Rpb24gcHJvdG90eXBl
cyBhbmQgZGVwcmVjYXRlZC4gDQpEb24ndCBhZGQgbmV3IG9jY3VyZW5jZXMuDQoNCj4gKwlDT05D
QVRFTkFURShfX21vZF8jI3R5cGUjI19fIyNuYW1lIyNfXywJCQkJXA0KPiArCQlfX0tCVUlMRF9N
T0ROQU1FKSwJCQkJCVwNCj4gKwlfZGV2aWNlX3RhYmxlKQkJCQkJCQlcDQo+ICsJX19hdHRyaWJ1
dGVfXyAoKHVudXNlZCwgYWxpYXMoX19zdHJpbmdpZnkobmFtZSkpKSkNCj4gICAjZW5kaWYNCj4g
ICANCj4gICAvKiBWZXJzaW9uIG9mIGZvcm0gWzxlcG9jaD46XTx2ZXJzaW9uPlstPGV4dHJhLXZl
cnNpb24+XS4NCg==
