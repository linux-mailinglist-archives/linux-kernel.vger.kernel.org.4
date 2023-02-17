Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3969AE1D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBQOdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQOde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:33:34 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2077.outbound.protection.outlook.com [40.107.9.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9541644ED;
        Fri, 17 Feb 2023 06:33:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUGTeRByj1XX43RT8sZcefr9/+3ywVWzuiZrMaCn8F6c9IqmLlOMfwRMqAYc4U0KaM1THVy9lTS26RdhInMkh6EaeaXsmnkDCYXxic+efVTrjfGG9x0gUHiHKbDPzUSqgCTN28sNvqEVF/Ag0pMu0ItPXAPg9y9P5FgYM1D9JX/8DySGj4wNwXgZxz2KeuXlYw+uee6mkXVGgPo1Kn/AywWqjrvIcG5YxqSxjEmE5tjrq5MNhxY1qQBAvtRMOjBV+5oXZa4MUcD44ucz6wERMnn+9x5TkdgxBqd6nHMnngu7Rb2k/1J9oH57oxuLSQde4P2NVODcVUSBzdJD2iYSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fkx8shsMfoBzbpmOBBB6H9YIBT8oENFzHz3TuUZR+TM=;
 b=fp4+ur89ZCGVHIeMhWXpm9uB7q1NM8hijc413NcWxjH4IJULyLLx7St+smZOdoK71ydF9eRraZlAAXw4HIL6M5kkZMdIsF2/OQnDQcf5X1ACcT06Mma3z3TWQoM5UVVsrBPWfCEgmp90K7nwckm/TfzqwSAfVCEFUKU2V96Hl9giGptQq79R/FHbBNrW3rD7BhmBnkFHy7R6BOr+ktVY5Ny8Q3dtN20QvMuAdUwT7smg8ZhfXbF/7n3J6PDBZ+9vyQsIlnEbxeBXiL8Kl3fbtcCLzMD971rHvQMpGsjrTMIoK1FY4YvvpTU0ds8Q+/B91BWF+pMIJA70gUZWiCTkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fkx8shsMfoBzbpmOBBB6H9YIBT8oENFzHz3TuUZR+TM=;
 b=yUQRIGsT4GgIxp+r21H8WgA6Nr2V5v3ds64cxu0CGF4yAI3aQJTZXFlRCb2TiHeLm4bFTZV5VAPd9MrYkVPBPWsc5zeIiyatQ/DvglBri404TJ3F4ZNLnBCQrnmLopkux7zTPw/ug0x/tDPQKIXh2oHWhVyTX2SuvctPeRxdaS6HyY3ysMq4fTZRiTpenE2xOV1n8uxfJaHIUeVvYHL4/46B568kzt9jI46i7faz1RRkhCSM8uwp9ldBaKU0EopbV0DIwzY2vfnXoycG+NnfRA9a0JrKZ0T9P0/uxnljCGffC1rA2alNlr76ikewqcbL/fwaQO7bEvHWzI2V2DYi7w==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2050.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:14::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 14:33:29 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 14:33:29 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        David Laight <David.Laight@aculab.com>,
        Stafford Horne <shorne@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH v4 12/16] parisc: mm: Convert to GENERIC_IOREMAP
Thread-Topic: [PATCH v4 12/16] parisc: mm: Convert to GENERIC_IOREMAP
Thread-Index: AQHZQgM90k2+mVJ2NEqh/LEr0apefK7Rlz6AgAAUA4CAAAStgIABdHEAgAAEMQCAAAmigIAAA2EA
Date:   Fri, 17 Feb 2023 14:33:29 +0000
Message-ID: <97732d97-06a7-9307-7ad1-ef69d980f3d2@csgroup.eu>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-13-bhe@redhat.com>
 <Y+40p3oegc2Of9w2@casper.infradead.org> <Y+5Fcc6wsbr0qmoN@MiWiFi-R3L-srv>
 <bff4f286-ccf8-40bc-8fe5-d4041adf89f5@app.fastmail.com>
 <Y++Bypsg9YCmUEcd@MiWiFi-R3L-srv>
 <107be2c9-021b-85f6-d32d-ddb9e75ce24f@csgroup.eu>
 <Y++NY7iPvNAVbwMv@MiWiFi-R3L-srv>
In-Reply-To: <Y++NY7iPvNAVbwMv@MiWiFi-R3L-srv>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2050:EE_
x-ms-office365-filtering-correlation-id: 3a585164-d611-40f5-0c19-08db10f3f02d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYJqpvVd8yqyNG+jT1DjkPixDPwZWBbAiX0cpLu4SbNY1OZp1a9hNMmrc6Ahz+2Erp7gECb04znQqTngqwsAhuXCXwfuUskC93MIKJS+OmoZ+hBz/pz7USPs2IqpW/OdJETcGlzBw0hOD4Yx+qCuKaU6etOdzqQVTdc/HeEM+DiI99aobrersHi4tc4RZouBAW+lmj2eYW/V1JQTeEJBUnN7l6q5i16e8fl6yDxpIdR+kJDAfu76cmfEn3qSnRJanCFPtetTd1L23I3dsOK0c/+2QUdasL6zVRQcxPrUfr7miZQaO5IDFgxZI5P8N2Q3mw+CTnMEK+o0WO7qeXYtzBCr0FG0rVDZBnDFEJTF/EZ3O97JRmAK8l41PPbuFATffnb+JyTXx7vOzBUPXtQS484WnPlxTUS29vbsFhjdXGRoxNycqQczjtk6T0LUK0k4+Gx8EfyXutXFr7FFdWzFyX+UFcO21+gkCfdX7EgimedW/WyNd2Waic19Lv7FAi0/EQhuurd1RREKH5iAUQ8ak1zOfLe13AtKpuqM5fJQuRPG0abs7HThiOWCZodQLa2kaagLvoRkmiqM/c9ahtsrS4och8isCN+GnEBl3seUhGn4MHcrIoi6sigIscwHAOoEMjB9zIZuehB3oy5eC1M6Zl1cCDfyj8XsRr+YI3z8FI/t7YWGhu45EeVLwzSO70uuV2X4Q9nyg3lFF9VPn7iofzp+qchgOZdvVYEmYHJIXiv4dPVtZjJnLTdeGIYveOW1SQhHjnoVeGoQNWAuQwVb+ic+yBzEW9zZ32d+7/aFluAPn0Np/UFR7LVG/GyCJJBb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(451199018)(8936002)(5660300002)(44832011)(7416002)(41300700001)(86362001)(38100700002)(36756003)(31696002)(38070700005)(2906002)(122000001)(6486002)(478600001)(2616005)(71200400001)(6506007)(186003)(31686004)(26005)(6512007)(4326008)(6916009)(91956017)(316002)(66556008)(66476007)(66446008)(76116006)(66946007)(8676002)(64756008)(54906003)(41533002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVdEajBOV1o0Si8xTGlxc2hVcmt4ZFhUdGZjQmhIQ3hINXdpbE43T1ZoOGRC?=
 =?utf-8?B?VGxiQlQ3bVZ4aUVBbndGeU5vbzc5TjFoMVo0ZmY1SHdnRFNhcVlxOXhUM1Nz?=
 =?utf-8?B?SVNLWWl1VHM0dFRkMDFBVFVFc1dVSHVvM29ZbWlJNnNaWnB0Y01SN1ZnNStQ?=
 =?utf-8?B?elR0bVdWVUZzMHdDVjJWTk8zSHVhbWtoVzNvOUVuTGI0WGxuN1JxTENHTUI5?=
 =?utf-8?B?ZnVETDAwWUw2a2RaS01zN1FJTnNFWnNVNFJTcjFlVDVaaUE1N0tiUVExK1JU?=
 =?utf-8?B?SzVuVXZsK1BJWWk4cjFudTB2TTNET0IxdG8rQUF4bDkzR3ZmOG55dFpucmNW?=
 =?utf-8?B?RElJWFM2NXQ3bHhkUHlQV2VRcmVnQ0V5RHZNK3NuVjBSQktYeG84N2dVbVZP?=
 =?utf-8?B?ZmNQN21nc3FGc2NmN1lseDlWMFV6QW9YY0tlb2dMdnovY2JzZC9GdkQwdTNp?=
 =?utf-8?B?S0J2SUVMSEdtdGgwU3ErV0RLbS9BbHd0TkNLMDdqelpZU3FmWHpxNnAvQ1Vw?=
 =?utf-8?B?R1pGVUNCeVFUa2VvejllNU85SFBmQmROYkZmMFZ4Nkd5V05SQiswQWZqUGFV?=
 =?utf-8?B?NFhZdUhCNDRzZUpLZVFwT0xHZ0NtNlZuaWNtR1dNUFZsZ2tqM2U5bWgxTkcw?=
 =?utf-8?B?QVJIN2lkUFBmcnovQVdkbmpVS2R1UEliR3UxQUVmbUpycDVDQ3VQQVdka0FP?=
 =?utf-8?B?SmpIREMyM1FOcnQxazZCaCtRUE91OVdiMG5oZ0FMaTduNjMvYVdGU0JLUHQ1?=
 =?utf-8?B?WnB3d3NJWUdSVnFpWi9xaWcyZmE5RzkzRW9VWS9neXFvZzVLY3dmYVpQQk5z?=
 =?utf-8?B?Unp6WEw3bTdNa29PMVdyUUlJSXZoSStDWWZYTVFkdDF4LzEzakt1a1MzZEd0?=
 =?utf-8?B?eU82bko3ZEhxVW9PSzVubUJZYm5KejF2Q2xaMnFPcVVzSkVpS1Q1K0RCalVz?=
 =?utf-8?B?ZnNVT0EzaDBNckZibjFJTkZHNzNyeFMrdUhIdmpmNU5GdllQN24zaDNBbkVI?=
 =?utf-8?B?QnljTThiT2xRS0J6T3VTV2ZyTEhLdTZOdk41Y0QrK1o3aHlVcWx5RjJNaGIr?=
 =?utf-8?B?QmExamtmdGg3TmpibHRRemRBZlNpTW8rYzNXVlFEZ04wbllvQkFKRVZNWERS?=
 =?utf-8?B?Q3lvblcvOUVad3IzVGczT210aDkxKzY1WkF6VW50YkVNNFdpUTI3L3VjbnFJ?=
 =?utf-8?B?VXpIS3Eyb2NONmN0MXNtbFFnTGVudW16bzZhUGRGY203dHJ3clVLaWUyZ0ZM?=
 =?utf-8?B?TW1FMzc2ZkpwcmE5Y1RkS3J0NG9ydG50Zm83Ti8rT0xzdTZYMmFIR0ZPMFgr?=
 =?utf-8?B?WkJadFlYSzVGN3RmWXpsVHQwYWZITWdQZUx5OUJDKzlCQTZRNHBnUmwzMk5M?=
 =?utf-8?B?WTBDUkpqWWtUcVZaV0Yzc3d3Z2dUbnJLSERpOVFmUklnamdxQ1FjTEN6VDlN?=
 =?utf-8?B?NmFMUlJYUUwwUzNOOU1EWDkvNXFIaWdweldTRVhFdndFOEMreUtCaGh3ck9N?=
 =?utf-8?B?emxIWCs0MlJMRWpSY1dYS2NzRFYvZzRwdkhkSmxRQTNzRzEwc29Md3BmdVNI?=
 =?utf-8?B?eGM0V1hpMStIcUY3UnlSZVNLUUN3Z3MyZzdZZUozNnNBbjRsdm5vQ29xV3Bw?=
 =?utf-8?B?bmRYTE5vV1BoTEM5cGNCMjN3TEZaR0thOTQzQkJRRnNIOTRTU0JpM0toWjJv?=
 =?utf-8?B?cWorS0E0Q3NQSXVqdEhWQStTUzd3MmQ3czdXSmE2VUpVYk9hSDhXVkpqblZH?=
 =?utf-8?B?VVZEZEc5UXFXMDNvQ0FLMjhNWDJSV0U4bklwUTRYZTErZlArelNJSjc3QXBF?=
 =?utf-8?B?V3NxM25YMDhJMUlHQnp6b0MyTGY0bmd0V056MXl2OUFtWXJlemJ1TlNsY2ph?=
 =?utf-8?B?aCtOd1ZJSVoyL1RuVlRTQUpOcEhmQTA1RURlZlczSmVUSmRIRXdPS1kyZlRF?=
 =?utf-8?B?RG1FbGdXWE1QVUJGbGhtbjRCUWJJc3NuMlI4SnlReXMzcFVzTzlVR3drb3NW?=
 =?utf-8?B?bmRwRTR4RXpTVGVZQ01ObzJJakorMlNFZWVDc0tNRXdqbldrZnJ3VzlhdThu?=
 =?utf-8?B?WmdSYUVORWxsVDlDcmI1T1hEOTZNdDZoVlhDZWFZa09IaXBPS2xJb0pXZ0pK?=
 =?utf-8?B?RXRYNEpEMWg0a2FZTVUrOXNDL3ZDZndySlZwM1BQc0czZWIvY2F3TVFWWlBE?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58F5D6E344D69443AA2D03D64AF6A652@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a585164-d611-40f5-0c19-08db10f3f02d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 14:33:29.5013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLFFxQV49arSNHlOlnLJxUOYi+FBgjUeyygqzZw94nUkRvJo7d3+2EsDppLRSDCLxF+atiYj5TgBTIcdh8KsW+ITu+n2wgaQOBhYXeZBsXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2050
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE3LzAyLzIwMjMgw6AgMTU6MjEsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4gT24g
MDIvMTcvMjMgYXQgMDE6NDZwbSwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+DQo+Pg0KPj4g
TGUgMTcvMDIvMjAyMyDDoCAxNDozMSwgQmFvcXVhbiBIZSBhIMOpY3JpdMKgOg0KPj4+IE9uIDAy
LzE2LzIzIGF0IDA0OjE4cG0sIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+Pj4+IE9uIFRodSwgRmVi
IDE2LCAyMDIzLCBhdCAxNjowMiwgQmFvcXVhbiBIZSB3cm90ZToNCj4+Pj4+IE9uIDAyLzE2LzIz
IGF0IDAxOjUwcG0sIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPj4+Pj4gSXQncyBub3QgaWYgaW5j
bHVkaW5nIGFzbS1nZW5lcmljL2lvbWFwLmguIFRoZSBBUkNIX0hBU19JT1JFTUFQX3h4IGlzIHRv
DQo+Pj4+PiBhdm9pZCByZWRlZmluaXRpb24gdGhlcmUuDQo+Pj4+Pg0KPj4+Pj4gaW5jbHVkZS9h
c20tZ2VuZXJpYy9pb21hcC5oOg0KPj4+Pj4gLS0tLQ0KPj4+Pj4gI2lmbmRlZiBBUkNIX0hBU19J
T1JFTUFQX1dDDQo+Pj4+PiAjZGVmaW5lIGlvcmVtYXBfd2MgaW9yZW1hcA0KPj4+Pj4gI2VuZGlm
DQo+Pj4+DQo+Pj4+IEknZCBjaGFuZ2UgdGhhdCB0byB0aGUgdXN1YWwgJyNpZm5kZWYgaW9yZW1h
cF93YycgaW4gdGhhdCBjYXNlLg0KPj4+DQo+Pj4gTm90IHN1cmUgaWYgSSBnb3QgeW91LiBLaWxs
IGFsbCBBUkNIX0hBU19JT1JFTUFQX3h4eCBpbiBrZXJuZWw/IElmIHllcywNCj4+PiBzb3VuZHMg
bGlrZSBhIGdvb2QgaWRlYS4NCj4+Pg0KPj4NCj4+IEF0IGxlYXN0IGtpbGwgdGhhdCBvbmUgYXQg
dGhlIGZpcnN0IHBsYWNlIGluIHlvdXIgc2VyaWVzLCBhbmQgdGhlbiB0aGUNCj4+IG90aGVyIG9u
ZXMgaW4gYSBmb2xsb3ctdXAgc2VyaWVzIG1heWJlLg0KPiANCj4gVGhlbiB3ZSBjYW4gbWFrZSBh
IHByZXBhcmF0aW9uIHBhdGNoIHRvIGNoYW5nZSB0aGF0IGluIGlvbWFwLmgsIHRoZW4NCj4gcmVt
b3ZlIGFsbCBBUkNIX0hBU19JT1JFTUFQX1dDIGRlZmluaXRpb24gaW4gYXJjaC4gSSB0aG91Z2h0
IHRvIGxldCB0aGlzDQo+IHBhdGNoIGFzIGlzLCAgdGhlbiBnZXQgcmlkIG9mIGFsbCBBUkNIX0hB
U19JT1JFTUFQX3h4eCBpbiBhIGZvbGxvdy11cA0KPiBzZXJpZXMuIFdoaWxlIHRoZSBmb3JtZXIg
aXMgYWxzbyBmaW5lIHRvIG1lLiBUaGFua3MsIENocmlzdG9waGUuDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9pb21hcC5oIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9pb21h
cC5oDQo+IGluZGV4IDA4MjM3YWU4Yjg0MC4uNWZhMWU5Y2E5NTFjIDEwMDY0NA0KPiAtLS0gYS9p
bmNsdWRlL2FzbS1nZW5lcmljL2lvbWFwLmgNCj4gKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9p
b21hcC5oDQo+IEBAIC05Myw3ICs5Myw3IEBAIGV4dGVybiB2b2lkIF9faW9tZW0gKmlvcG9ydF9t
YXAodW5zaWduZWQgbG9uZyBwb3J0LCB1bnNpZ25lZCBpbnQgbnIpOw0KPiAgIGV4dGVybiB2b2lk
IGlvcG9ydF91bm1hcCh2b2lkIF9faW9tZW0gKik7DQo+ICAgI2VuZGlmDQo+ICAgDQo+IC0jaWZu
ZGVmIEFSQ0hfSEFTX0lPUkVNQVBfV0MNCj4gKyNpZm5kZWYgaW9yZW1hcF93Yw0KPiAgICNkZWZp
bmUgaW9yZW1hcF93YyBpb3JlbWFwDQo+ICAgI2VuZGlmDQo+IA0KPiBbfl0kIGdpdCBncmVwIEFS
Q0hfSEFTX0lPUkVNQVBfV0MNCj4gYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vaW8uaDojZGVm
aW5lIEFSQ0hfSEFTX0lPUkVNQVBfV0MNCj4gYXJjaC9taXBzL2luY2x1ZGUvYXNtL2lvLmg6I2Rl
ZmluZSBBUkNIX0hBU19JT1JFTUFQX1dDDQo+IGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9pby5o
OiNkZWZpbmUgQVJDSF9IQVNfSU9SRU1BUF9XQw0KPiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pby5o
OiNkZWZpbmUgQVJDSF9IQVNfSU9SRU1BUF9XQw0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9zZmMv
aW8uaDojaWZkZWYgQVJDSF9IQVNfSU9SRU1BUF9XQw0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9z
ZmMvc2llbmEvaW8uaDojaWZkZWYgQVJDSF9IQVNfSU9SRU1BUF9XQw0KPiBpbmNsdWRlL2FzbS1n
ZW5lcmljL2lvbWFwLmg6I2lmbmRlZiBBUkNIX0hBU19JT1JFTUFQX1dDDQo+IA0KPiANCg0KTm90
IHNvIG1hbnk6DQoNCiQgZ2l0IGdyZXAgQVJDSF9IQVNfSU9SRU1BUF9XQyAgfCBncmVwIGRlZmlu
ZQ0KYXJjaC9sb29uZ2FyY2gvaW5jbHVkZS9hc20vaW8uaDojZGVmaW5lIEFSQ0hfSEFTX0lPUkVN
QVBfV0MNCmFyY2gvbWlwcy9pbmNsdWRlL2FzbS9pby5oOiNkZWZpbmUgQVJDSF9IQVNfSU9SRU1B
UF9XQw0KYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2lvLmg6I2RlZmluZSBBUkNIX0hBU19JT1JF
TUFQX1dDDQphcmNoL3g4Ni9pbmNsdWRlL2FzbS9pby5oOiNkZWZpbmUgQVJDSF9IQVNfSU9SRU1B
UF9XQw0KDQpBbmQgYWxzbyBtYWtlIHN1cmUgdGhleSBkZWZpbmUgaW9yZW1hcF93YyA6DQoNCiQg
Z2l0IGdyZXAgImRlZmluZSBpb3JlbWFwX3djIiBgZ2l0IGdyZXAgLWwgImRlZmluZSBBUkNIX0hB
U19JT1JFTUFQX1dDImANCmFyY2gvbG9vbmdhcmNoL2luY2x1ZGUvYXNtL2lvLmg6I2RlZmluZSBp
b3JlbWFwX3djKG9mZnNldCwgc2l6ZSkgICAgICAgIFwNCmFyY2gvbWlwcy9pbmNsdWRlL2FzbS9p
by5oOiNkZWZpbmUgaW9yZW1hcF93YyhvZmZzZXQsIHNpemUpIA0KICAgICAgICAgICAgICAgICAg
ICAgICAgXA0KYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2lvLmg6I2RlZmluZSBpb3JlbWFwX3dj
IGlvcmVtYXBfd2MNCmFyY2gveDg2L2luY2x1ZGUvYXNtL2lvLmg6I2RlZmluZSBpb3JlbWFwX3dj
IGlvcmVtYXBfd2MNCg0KDQpDaHJpc3RvcGhlDQo=
