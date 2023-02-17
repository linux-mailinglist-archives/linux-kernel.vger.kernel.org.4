Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0345969ACE2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBQNr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQNrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:47:53 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2055.outbound.protection.outlook.com [40.107.9.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8714126C5;
        Fri, 17 Feb 2023 05:47:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEi5hid4htvm6wW7c2HgXhVNb1cpo9n+040DtKik3TgUqFK5Gbvu+VoopYOwwYvKRriPVxmrJMPdHn3Kzo2ttNOCzbZYLjTSViPnRMjrp6wTUwFAmohDzwlyXLkFi4GDXD8PfYb3AX4tyHTNzf7M/XTV06KA7zwJZztGLqYeUOwCUHs8YcpVsyNXc0bb2AFvXdlPSVZWnVjI374O0Xh994cxxyyjRsmPmQ/yAH905YLtFd711nEESE29qK07Z9rm1QEs6hKDOKkTDiUZ29qzyUf/tKRYDdSN2PqjfPN+4pl5ZPiVCWpCZNJu/jVn/ltGVUApU/wtOy31FHvf+p85MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NoszZcGYZCMocOxyddTMqZR9TihWezFjxTM7Ma9GS8=;
 b=jzqh6dE0QNhIAiM/rEWy+HgZi06HNdeAxFUZ+m6n1hcxfIN3PJRco7MnCBX3sN36rvznk25htYbM+evSGuntzJaXSXx6R4X+Pn3vUscXdHtSPsE3mAGFsMvHctCB4ZMA1ZO0WDXkKQh/1U4V8B9RZF1AXtI2uqFoPrKDv9AcYQ3M4RPzGvzY1wig7UspktBdC78Ik4jbVWGeH24WcK59R/q1vIEiTlSso5IuPdQxqH4Bhg4FaF5xspAee3tK5NJDSVFG/3yJjQokRCrkyCLmEYHV2pgKMmwwVuUjK4FRMCSL+gm0/oy02nd+RUMpsRnP+coC1LJ9Stpd0u+Z+xpmFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NoszZcGYZCMocOxyddTMqZR9TihWezFjxTM7Ma9GS8=;
 b=65o08pejvVwKuTHhMh5ECYimQHsmFfJbI+/0wVMvcIfgIAV01PxfxITSqPRXb9cdnA8m5m8HER7Cw6Vf3Fhkb3j6tUexSCFUQkxG5KfsI+O2OUdTu5OEwLekl6skeINr6qTMOD5R1JmxNuhAGkIhMbI8bd8Br5+a+ze1b1xN28A8Yptuh9PnbUNPnMSYKxWOXrkQiQkFTW8ejBgRFiATK+HqLabfB9W6DVISUSjwnRm+K84Hi1n5rcAm7WvOAYKf1BPpcagtXfUsQs5igKwFJfFEBUaLdQAi/wa/mPPr5wtWS3A1GdCyZIB/G020378YdoLG4tl9oKBvOi/yhD4ymQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2143.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 13:46:55 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 13:46:54 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>
CC:     Matthew Wilcox <willy@infradead.org>,
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
Thread-Index: AQHZQgM90k2+mVJ2NEqh/LEr0apefK7Rlz6AgAAUA4CAAAStgIABdHEAgAAEMQA=
Date:   Fri, 17 Feb 2023 13:46:54 +0000
Message-ID: <107be2c9-021b-85f6-d32d-ddb9e75ce24f@csgroup.eu>
References: <20230216123419.461016-1-bhe@redhat.com>
 <20230216123419.461016-13-bhe@redhat.com>
 <Y+40p3oegc2Of9w2@casper.infradead.org> <Y+5Fcc6wsbr0qmoN@MiWiFi-R3L-srv>
 <bff4f286-ccf8-40bc-8fe5-d4041adf89f5@app.fastmail.com>
 <Y++Bypsg9YCmUEcd@MiWiFi-R3L-srv>
In-Reply-To: <Y++Bypsg9YCmUEcd@MiWiFi-R3L-srv>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2143:EE_
x-ms-office365-filtering-correlation-id: 86060ea4-266c-4b90-db1d-08db10ed6e72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBWfcGizK84Rri0wT4j5aFNwZdayzAVOSN9pfEEjav+QSfarkoSaf/131UZ3z0p92sBX7083NeAADE9uaRb5oUxemyTqDwyvmdM9Ea1xzqI89AO+AhWshLMOhGiHG/32Q3Bjy4WRgDUmqi9fWuX/OH25Dz1OkunvTFjZ1XIev/rgH4/R90gRtzCS8kyC9cKks5tAcxLmLuZmq+6lhsOFVKpe3bV8n5EX/WqjdrenX5qegEvhu9A5TzdOTH6Foo3A2ARVRb5LyzURdsHOf3ywx/JwcEX8e09hQ+v2APLXNOT2987ngDo7SwLIK/57MQ9MmcxHlJpP+5f+vNpvDe3JHrkJ/EmgO8LY9ijJnYL7rXPHjdbvmiL65ydlhWvTtOIkbvNzcQs7h5JodEfo/Aw6zt6gJGHzYxhpWXwfitREUzXSe5D0V7hm/rJ0I8W3SAkvp/LTf3Bo7HuoioGQug2f5bhpx9r9tcBFoQ9sYw+lwqHvoMzir8syfv/enXCTFRhAN0gmmnU1y/rsXhL6HimEU8fzigKcfgMFXIlRj8Tt7q3ejFzgYj4C32eXhMRLIcp/LUDcoxzA+zjzjn2UCqYUp9btDTamaR6I6xSYs1dN2ob66diHgCbReBlSNaiBkVNgwY65tYH2uzBjINW7WXl2qbXjTGwbQKQgvgfPNcR+oyKSzKE3/Ll14mvMElTfFDAG9XwDqZ/ejkAcMhGBBFGv/24O00xDraw16lAaOsW/gPHMAaD9ajdzJh77qJBjPBXiwJ6KtxTi1t81w6escdXW4fCKlzimhD8U2hoGMhdnIGk8KY7VYJVUIM1GTBNfIua7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39850400004)(136003)(396003)(346002)(451199018)(91956017)(31686004)(76116006)(66556008)(66946007)(38100700002)(8676002)(66446008)(64756008)(41300700001)(4326008)(316002)(122000001)(8936002)(110136005)(66476007)(54906003)(38070700005)(4744005)(5660300002)(31696002)(36756003)(6486002)(7416002)(44832011)(478600001)(2616005)(2906002)(186003)(26005)(71200400001)(6506007)(6512007)(86362001)(41533002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1F3a0p2dGhPTlhSaGZ1K1FlK1Rpbi9YVzZxZUdjUVRvZEQyWjExQ295Smxz?=
 =?utf-8?B?ZW1MOHhyd2lvQStraVN6eC9sR2tVdWRZY0RWTmVRN2hjTFZyelpaQm1jcDBw?=
 =?utf-8?B?RW5CM3dPbmNxL2Nsak4zN3pJNWNxU1NGdnhzSlVxamtrbi9sNTFBQUhtcnBX?=
 =?utf-8?B?blRyYjh1SGRqVmwwUEM5VCtTaWNZcTJPSkxEMW9xQ29EQmQ4Nk5iSEYydVVL?=
 =?utf-8?B?a2diakNEV1NYYjZwbHJZcW45d3VjWitkV2duamNPbUtzOG5GMjFOeWFTT2NF?=
 =?utf-8?B?dkdOK1pXWDBIOTVGR29BL1BDemtQcEZaVmJmL3UrTWY2bkxKVjZ3NGZrZHVw?=
 =?utf-8?B?clVCYWVrVGUwTDUreUlSSkVJWWRDUGpVcit2TURuOGdpc0lCSkw3anRMTDdM?=
 =?utf-8?B?MEE5UVlEajl4eTMzQWgzWEJBRHRzbkprcGxRZG1tR0N5aHVIQWFES0Uzb0Qv?=
 =?utf-8?B?TFhiaWFrMUNGMUFjRjFKdU91SlNHVElTNTVkVmZOaWEyaWY2YlVEczNVYTlE?=
 =?utf-8?B?cFQvWnFpemhhSUtmNTZrU3dFQmFGYy9JKzBhZHkvbUxCZ3pHTmx5b3dqN1dE?=
 =?utf-8?B?STEwSzNaOVdHamw2K2d1Ylo3c1lLRDh5anFhVHpvdnkwa3ZKUTRicDhIYzl5?=
 =?utf-8?B?RGNDUGJyMCtoNGdJRy9hNmd5Ym1ObDhyNzBhYWNpQWVUZTVmVzFDOGNVaUZV?=
 =?utf-8?B?dlhtNEZ1MGpObHYzUVg1a0g4WVZBSWtJQmx3ekplQ203aWtTQjd1dHZraU5T?=
 =?utf-8?B?bFNGUzNjby9yc08zS0pnNCtYSVhzSlpoUVVxUHAxSnd4UmhIUy9ib0lTd0l0?=
 =?utf-8?B?NW82VFBZdEIyU0FMaUhjU0ZLbU52SjEyM1Y5TzBNM2tlbFZLVTNVUSszc3Jk?=
 =?utf-8?B?a2dIeFRlQmU2MXZWT0VaK3dFdXZnaFlrVkJ1RUcyQTBQS0JDRVNFYVovL0sy?=
 =?utf-8?B?ZFM5cElHQkdwY20ycVBCMkZpWG92cTRhVWl0b1pYaVZVblNaV1pzY2Q4T0M0?=
 =?utf-8?B?OElBMXN1VlYvbVNMSEJ6Mjc2a3pSWm5XQzRTY3BlQU9IT3VMajl5QjlHUEll?=
 =?utf-8?B?VmtCc1dlTkp4UHlURXIySDJtOC81UDE3OW56bWdjTmRtTFZrbjlQa3JYN0JJ?=
 =?utf-8?B?b1E0RU9QbGRyL0JtOEJySm5FaHlKMTdZSUo4dzhZaXF1a0IvVnNCMVEzNW9o?=
 =?utf-8?B?OWdLLzN6U1ZPVEd0MmtVeGVhOFYrd3l6R0JhcTNSU0dySk1STDBUSkZPNVAr?=
 =?utf-8?B?WE5tcnZnQnArS1lpV2tjYXhOZ29qcVAxczN5VkVNbm5xT00xMFl2TlNWRytW?=
 =?utf-8?B?V2twb0NRZFR4dW53bmd6MkRuRnpiVVpqdlJ2VW8wSFhvbEN5RUVKL2lRSlBh?=
 =?utf-8?B?d00yTDIyREg5ZnZwc04rRUdOTFpLbXVucHpwc3dmT0VhNWlnSzRuSjYySXQy?=
 =?utf-8?B?cEhxbmFseEFOaGVQYnhRa2xpRzVCaHBJWm9lUWxqSEdVTU15QSttazZNVkp1?=
 =?utf-8?B?NWRFSDR6RTZtRzVvNHluTVpyeWY5UkF2ZnF3WnFKSUMwTDdRUER1cmhqSTJH?=
 =?utf-8?B?MDhzN3ZLMlo1Qkhia3JQWDg1V3RwTnFJbkp5REY4S1ovWC9hdG93SlhyQ3Ax?=
 =?utf-8?B?SThlRzd2cEN0Z0x6bFZ6VHpOd3B5bExpVWMzL3o3bktrRDBMcjhlVUtPb1F1?=
 =?utf-8?B?dEtqWjEvWXFZdHVNZ2Z5d3J6SmpncFN6OEcwbnJEMUhiNWFSQytwaGpKM2lx?=
 =?utf-8?B?cGYzdUM5cWpCdjBwaE1weUxVT0FrS1dRNnJsSjFuYVlmNFl2QzRWemwwUE9R?=
 =?utf-8?B?cVVaWDlXMzY1NVAwbDRIYzk1Rlc1cGovY2JJNXduYlRuNXJXRmg3d2s3Tk42?=
 =?utf-8?B?eTdrN0lOdFl2UERtVHo3UGMxYTVvWElvTFQ0V1lGU01MR2YycU9GSVh0Zndr?=
 =?utf-8?B?azVlSkJYR0x2elVsTkgzSlpwSy9EYnN3dHhGSWNGdkJJMkpkSFlxM3NFVjQ0?=
 =?utf-8?B?RWhKTGFYTllNQ1YyK0NycUZEYnRMbG4vbWJ6YVB5N2FSODVhalFNSU82Qkp6?=
 =?utf-8?B?NHRzZ3RqcTdnaERuQUF6RVJwM051RzkvR1JuU0pyT2o0VEl6OWo5SVRNbVVG?=
 =?utf-8?B?ZnFYcFlvcnF4Y0g0Mk5oQnZQT0ZyeHZzK0VhQ1huUjU2SlozRFcyc2hmNkhT?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <428ABEB9719B894C9A53864B07D8BA1E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 86060ea4-266c-4b90-db1d-08db10ed6e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 13:46:54.9215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ykih9mPcOFHVHx00AdUYYS9FkA9Ubwnt4lnA8uq44sAAo97bdkUhw8tU/fMAaWMf6dUaVpwAV8NE0iDNOTCaWJJmHugDYNLET9YgCAzipkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2143
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDE3LzAyLzIwMjMgw6AgMTQ6MzEsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4gT24g
MDIvMTYvMjMgYXQgMDQ6MThwbSwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4+IE9uIFRodSwgRmVi
IDE2LCAyMDIzLCBhdCAxNjowMiwgQmFvcXVhbiBIZSB3cm90ZToNCj4+PiBPbiAwMi8xNi8yMyBh
dCAwMTo1MHBtLCBNYXR0aGV3IFdpbGNveCB3cm90ZToNCj4+PiBJdCdzIG5vdCBpZiBpbmNsdWRp
bmcgYXNtLWdlbmVyaWMvaW9tYXAuaC4gVGhlIEFSQ0hfSEFTX0lPUkVNQVBfeHggaXMgdG8NCj4+
PiBhdm9pZCByZWRlZmluaXRpb24gdGhlcmUuDQo+Pj4NCj4+PiBpbmNsdWRlL2FzbS1nZW5lcmlj
L2lvbWFwLmg6DQo+Pj4gLS0tLQ0KPj4+ICNpZm5kZWYgQVJDSF9IQVNfSU9SRU1BUF9XQw0KPj4+
ICNkZWZpbmUgaW9yZW1hcF93YyBpb3JlbWFwDQo+Pj4gI2VuZGlmDQo+Pg0KPj4gSSdkIGNoYW5n
ZSB0aGF0IHRvIHRoZSB1c3VhbCAnI2lmbmRlZiBpb3JlbWFwX3djJyBpbiB0aGF0IGNhc2UuDQo+
IA0KPiBOb3Qgc3VyZSBpZiBJIGdvdCB5b3UuIEtpbGwgYWxsIEFSQ0hfSEFTX0lPUkVNQVBfeHh4
IGluIGtlcm5lbD8gSWYgeWVzLA0KPiBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYS4NCj4gDQoNCkF0
IGxlYXN0IGtpbGwgdGhhdCBvbmUgYXQgdGhlIGZpcnN0IHBsYWNlIGluIHlvdXIgc2VyaWVzLCBh
bmQgdGhlbiB0aGUgDQpvdGhlciBvbmVzIGluIGEgZm9sbG93LXVwIHNlcmllcyBtYXliZS4NCg==
