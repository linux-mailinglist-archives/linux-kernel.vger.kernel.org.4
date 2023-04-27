Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDACF6F06B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbjD0NgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbjD0NgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:36:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AEF49F1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 06:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJghhhrf+kJ1lGVPUre3LAEp7mPPwAcAXwVjP9ICAP1zd1jeu7fGrecRQmosoIMh6WeVP1LsmTLbmrGzYrIBDNaR69DpCqJYtiBNWWAh3DGziOU1qSAJ7ZOeGyXRB1cy+oj6dLta2b260zEHExGTocFEOUAkfohrYvucG1TjWYZxvqkvIEN4f0vY1Jhjnsz6m4Oszu1XdGqNPZi9l7Dt40ADvzrMUrUgg+/J4dfz8/jmZ8OdghIdrnvbuoTplcsze29UbnWhFSKp+soxffniTjE5nBUrYo9SlyypEheBuKV5fV/aJifhet9Zq9DXsCQojuFpxxq3ofW9cWTl8UR+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RteQbsOoBz/tkRE8KxVW/lYrVtBrfcdKjkJkIhqZJZ8=;
 b=HGmTHsfk+ysFGDqoPBEcu09o7hLqf+lAnjZmqzEwfZ+2D2W3vOjmJaDax21lMet73OId4ZrdUaetJYqfpL7i87HXd1T7MtCP/aEXwDhsegFWUM7TYURgBiJNzSuX21eSbx8vOuEeWjEkBPlP/ai/x3y1R4QNPJlxlgtIQD7tMYyZMbagHfxtfo+RNEXBp5xU4xdNZziK08Ttnf4Db3j1FZzW1lPRt2GwP/MYYJQ/cQJZZSW9Dx4GaDAMh8P2+yMWgGrwCE/Ifoly+XHTqGAXDmCOLST8o59VZ0gVY46gUbT49RtfhzNbnouwJ+SEny5uF1kp/D1iuRkR2Rs+4Hncmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RteQbsOoBz/tkRE8KxVW/lYrVtBrfcdKjkJkIhqZJZ8=;
 b=OcKRupu3bi5az4shL/LEGcryUWV8cfrLo5aNQG33ZBn+jYJThCHGUqLvJHtNpkhHSoH0Hn5Eot+gs8vviN/IQ1SNjEKiv/7GOEaLxSlP6TSPdEEq96AAKRI3ObtiXMO0zrvKv05w6hBBlOqIWHff4VRDHhJzuJa2uEupFBtM7Kk=
Received: from MW2PR1901MB2041.namprd19.prod.outlook.com
 (2603:10b6:302:12::15) by PH8PR19MB6713.namprd19.prod.outlook.com
 (2603:10b6:510:1c8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 13:35:32 +0000
Received: from MW2PR1901MB2041.namprd19.prod.outlook.com
 ([fe80::d7ab:e23:fe6d:3152]) by MW2PR1901MB2041.namprd19.prod.outlook.com
 ([fe80::d7ab:e23:fe6d:3152%6]) with mapi id 15.20.6363.009; Thu, 27 Apr 2023
 13:35:31 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Andrei Vagin <avagin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: fuse uring / wake_up on the same core
Thread-Topic: fuse uring / wake_up on the same core
Thread-Index: AQHZXonZnrNnGQvxikaxtbJ88GLEB68OcL2AgC/yZYCAAOYogIAAE+eA
Date:   Thu, 27 Apr 2023 13:35:31 +0000
Message-ID: <3c0facd0-e3c7-0aa1-8b2e-961120d4f43d@ddn.com>
References: <d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com>
 <20230327102845.GB7701@hirez.programming.kicks-ass.net>
 <20230427122417.2452-1-hdanton@sina.com>
In-Reply-To: <20230427122417.2452-1-hdanton@sina.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR1901MB2041:EE_|PH8PR19MB6713:EE_
x-ms-office365-filtering-correlation-id: e8147af8-da54-4161-29f0-08db472445cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9wZugpK3//caFsmDmmncykAcLDnTTJo8p2NWVjHHR9Bq3Pks7FUujpfNS+nPyLyyaV2hkcVL/qjf4rgUkmRSFleP1F7D0AHGPzc7NQZLtpxeXDJFHwpQl7D30ySs0CgxX9paNJJ3dg+MrsD+Y9lzVPTN0SuDkfFk1DhO0fH/NP1pZ9Swi1W/BltByqXZJJR3wUHcX/h6ScvDNn4D/CTP+IlGuKLIVUm4yECSvHwstlIjP3h9oG8nks2cSSkbO2eJTizkN97B93/FnCfXtQOJSy/vYICXNXTeSOXb3/XIJmPDPFvvF8HlPwMTnlaEZVpNb1KgDBCSo66obDA1UFh10iyf8o5Wj9elb9GPBlYHA497PsylXrF05eLEL6TTcbxg/lph01HPqx5QvwBfXnTWMtvgqRMwVp4FFUxB69Yj8YN6WXQOkqMDur2HmcDD2x5UIEY8WIkGcMNB1RkJp4Cxqp5CE+X2xT7b1QtEKxGhfKykLORDrz283VDsTvwPsvuNnZVYFTcylF6Z0bU+7TN9ijsu8R/QSiLLbtReJDhFXUu5Yl+62aJPCYQKsVvXKBhgssDrU3+0OAE9j40xDnqXUiTDl2KEvX1pfJGCzM+au4atn352xGD4B22usSwJFiyB/lW+jFvAsMew26B/wz5M4lTvhu14reDaUbaCUMvKuV9FAk2qKxbzhzndhyFN09wC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR1901MB2041.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(376002)(396003)(366004)(346002)(136003)(451199021)(83380400001)(2616005)(31686004)(36756003)(86362001)(31696002)(53546011)(6506007)(6512007)(71200400001)(6486002)(478600001)(91956017)(76116006)(54906003)(66899021)(66556008)(66946007)(66446008)(316002)(4326008)(6916009)(66476007)(8936002)(8676002)(38070700005)(41300700001)(64756008)(186003)(2906002)(122000001)(38100700002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alVvWjVqZExaYTE4cUJzSVZOdzlSdS95N085NVZRMzdzSTYveVNmUi9DeURx?=
 =?utf-8?B?UGlPQzdnWVVDdjhZdU1tNnM4TENoQzkzVGR5cXZZMmQ3bmEzaWxWR3MwYlkr?=
 =?utf-8?B?Q2JOcDNMRnhBdW5kbEtUVVVoU2VvbXBLTlg0YURlVnhPT3JLR3hWYnVQd2Vk?=
 =?utf-8?B?YUh4UHVSM3M3elQrYjJoT1liWTJyVGJhai9NbG9JdmdPZzhQOG1zcE9Hckgr?=
 =?utf-8?B?OWdnM1UvK3hYSkQweVRFNUk5dFl0bS9EME5seU5BeXdGbWErMnc3K2M1Rjl4?=
 =?utf-8?B?QldWMDNJR2F1ZjZRWDhIUWVVMWxPMllIVVBSMUFOMnJSeDZtSWdJUXVwa01Z?=
 =?utf-8?B?TjRtMTVHd3VpOW5laVh0MDdVYWt5THdrUk1BcmxUNGlHTWFWczJyRFZ0ZGRp?=
 =?utf-8?B?MGlZTTREU3lHdVRIYTlDU0JnM3dITXNwMGV4eXNTUllkallOb2FpY21GVVp4?=
 =?utf-8?B?dmZjOUJYM01EenVBTElUYm1ueWdtdyt4RWFhSnNtM0tXeUsyWW9WOU5yN1dE?=
 =?utf-8?B?Z2RXQ1M0QVU1WHJzQTV6YXFvd2REUVAzcU5tYTh2dC9GKzRCRUdkbzRHRmRW?=
 =?utf-8?B?S0VadHcwNXV4THh0ZlU4MUpDUjdBYXUzQUttMVVlRURKQXZVdWRHN2JkMjdO?=
 =?utf-8?B?RjhVbVBrb0t2bGJnVkZHRFdwR1piMzBiYjQ0a014dDA0NlVkUlArSUtLTjZq?=
 =?utf-8?B?cDIrU2ZEUnFObW1VYy83Qm5JWnhlVVJTUjF4cmNOaTZQTjVyU2N1MVNyNkEz?=
 =?utf-8?B?cFhQL21CVS9RNDNZSXpTTGduRS9US1FacFEyVm45WmVEalhQZVU5cThpQWly?=
 =?utf-8?B?RGlJc0ZtQ1RRTHNiZjVFTmpNNkxmdTh0Y0NwaEJNZXB3bUNpd1J3bGMzNVl5?=
 =?utf-8?B?dVNIdzVLaEpnZ01vTzVVV3UwbUZCUU1KR1dRNTU3bEJJTTYvWjY0WmFIYnl6?=
 =?utf-8?B?UiszTEROWUxRYVpBQzVLVXBpYU85RE9nZVV5WGlseENUUWU4WWpPc05yM0Yx?=
 =?utf-8?B?cWFtQTd2U0x5Y25NYUxpVHptenQ1NTFXenpySEN3V1dUL0tiT1lndlFRNnpP?=
 =?utf-8?B?QWFJUzY1dnN3eEtMSjRVWW15UW5KZTV1U2FkSzdFYk15ZGNjKzhpTHFYU2tW?=
 =?utf-8?B?MlZvZk9KMllGNnEyRVgzbWtpVk9WMVpXRWdzNTVGbnRpZzlSaytPS3hDNmNy?=
 =?utf-8?B?ZE43V0F3aFdtOEp5YnNRM1ZkSzBON3JQdytHZzZkN3ZKZVBEdG8rSVVodm4y?=
 =?utf-8?B?bXl1c0hSRjlwRFJ1TUpweWx0UkNEd0tHM2dLWURqaXl5cUQ3WnNkYmxoaG9z?=
 =?utf-8?B?aVYxUHdLbXpPckxrUkZhb0UrTVQrZDRTMU5pWWJvbnZweVBNd3lic200NW9s?=
 =?utf-8?B?MURpeGVSY2RkQVNHei9hc2NENmpjenZkWU5zNmYyMzI0b2l2NUpYTWpxRGZt?=
 =?utf-8?B?VnduNWkyMERibml0eTRPWmxGYnd2R3lVbTVIbkJyTGZFY3gzdkVMNkpXTjhR?=
 =?utf-8?B?NEYwdDJnTUpZVWtHYUVlM1BsVGZsc1FFL3JFUEZBcW1wUUF1MXpXT0NHclpL?=
 =?utf-8?B?R2JLYmNyMEVKcDMzZ1hWTGFuUVVBclF2cER2anpXMDdUc0s3aW1YMWFTR3Vm?=
 =?utf-8?B?WHhJeGtvK0Z1TkRGRm03UUtIeXpTOFNkMUVSWHlQQWY2dTArQzRkRHFOK094?=
 =?utf-8?B?bzBzd083Y2FaR2hkcFNQQkhEN3VFZmd0SUtJT3ZkcWpUT2xBelZ1NzRsYzVz?=
 =?utf-8?B?QnArb2hVOUgvRUF0WVBoWFJQdnRhMzdqOXI4UTc1RmRrZTRhSUNtbmdKMDFi?=
 =?utf-8?B?RlpPN1pYOW9QeEY4VlQwZFptMldVQWQ3cDZpUmpZRGVZY3dYa0Npak5qWHFm?=
 =?utf-8?B?RnpaZVorWjhWb09TQ1hJaXVaRUc0NnNVNVZjRU1xQm1FeG82ZUtrNUNmVitl?=
 =?utf-8?B?TXhRRmVUK3RPNCtySUd1WHM2cXpBcDI1YXdJbHN1Z1NMcEhjTStRT3k1MUdm?=
 =?utf-8?B?bEtwUXpCaUZxbkZXVHNLU0dLbXRIM3NZZmxWLzd4aUZJZXBScCtRQ0V4NjB0?=
 =?utf-8?B?UHVDS290R00xUkNDUGQ0L2ozMVlnQUZUUDh2cUU5M1hpUTYxYTBEUFQ5TUJE?=
 =?utf-8?B?a0plTGR3NXJRWGFPdHhyY0FqNG9wY1pQMmZMa1BuMGU4YTZwcTdGcHhuaGVY?=
 =?utf-8?Q?i6+hU7tngOlqNrDCObWTYQY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AE7EC1BEFA8A04AA3FD225CA661E4DA@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR1901MB2041.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8147af8-da54-4161-29f0-08db472445cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 13:35:31.8056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9dIzqdK/4pCk4bACeYVKqS1pUPMhRGH4TMeVBihnneDEZlU6icJLVp1EbRh9J5l8Bz8Mxqu36bkOOg5HycUfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6713
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNy8yMyAxNDoyNCwgSGlsbGYgRGFudG9uIHdyb3RlOg0KPiBPbiAyNiBBcHIgMjAyMyAy
Mjo0MDozMiArMDAwMCBCZXJuZCBTY2h1YmVydCA8YnNjaHViZXJ0QGRkbi5jb20+DQo+PiBNeSBp
c3N1ZSBpcyBub3cgdGhhdCB0aGVzZSBwYXRjaGVzIGFyZSBub3QgZW5vdWdoIGFuZCBjb250cmFy
eSB0bw0KPj4gcHJldmlvdXMgdGVzdGluZywgZm9yY2VmdWxseSBkaXNhYmxpbmcgY3B1IG1pZ3Jh
dGlvbiB1c2luZw0KPj4gbWlncmF0ZV9kaXNhYmxlKCkgYmVmb3JlIHdhaXRfZXZlbnRfKiBpbiBm
dXNlJ3MgcmVxdWVzdF93YWl0X2Fuc3dlcigpDQo+PiBhbmQgZW5hYmxpbmcgaXQgYWZ0ZXIgZG9l
cyBub3QgaGVscCBlaXRoZXIgLSBteSBwcm9jZXNzIHRvIGNyZWF0ZSBmaWxlcw0KPj4gKGJvbm5p
ZSsrKSBzb21ld2hlcmUgbWlncmF0ZXMgdG8gYW5vdGhlciBjcHUgYXQgYSBsYXRlciB0aW1lLg0K
PiANCj4gTGVzcyB0aGFuIDIgbWlncmF0ZXMgZXZlcnkgdGVuIG1pbnV0ZXM/DQoNClRoZSB0ZXN0
IGRvZXMgbm90IHJ1biB0aGF0IGxvbmcuLi4ga2luZCBvZiBtaWdyYXRlIGltbWVkaWF0ZWx5LA0K
SSB0aGluayBpbiBsZXNzIHRoYW4gYSBzZWNvbmQuDQoNCj4gDQo+PiBUaGUgb25seSB3b3JrYXJv
dW5kIEkgY3VycmVudGx5IGhhdmUgaXMgdG8gc2V0IHRoZSByaW5nIHRocmVhZA0KPj4gcHJvY2Vz
c2luZyB2ZnMvZnVzZSBldmVudHMgaW4gdXNlcnNwYWNlIHRvIFNDSEVEX0lETEUuIEluIGNvbWJp
bmF0aW9uDQo+PiB3aXRoIFdGX0NVUlJFTlRfQ1BVIHBlcmZvcm1hbmNlIHRoZW4gZ29lcyBmcm9t
IH4yMjAwIHRvIH45MDAwIGZpbGUNCj4+IGNyZWF0ZXMvcyBmb3IgYSBzaW5nbGUgdGhyZWFkIGlu
IHRoZSBsYXRlc3QgYnJhbmNoIChzaG91bGQgYmUgc2NhbGFibGUpLg0KPj4gV2hpY2ggaXMgdmVy
eSBjbG9zZSB0byBiaW5kaW5nIHRoZSBib25uaWUrKyBwcm9jZXNzIHRvIGEgc2luZ2xlIGNvcmUN
Cj4+ICh+OTQwMCBjcmVhdGVzL3MpLg0KPiANCj4gVGhlIHNjaGVkdWxlciBpcyBnb29kIGF0IGRp
c3BhdGNoaW5nIHRhc2tzIHRvIENQVXMgYXQgbGVhc3QsIGFuZCBpdCB3b3Jrcw0KPiBiZXR0ZXIg
d2l0aCB1c2Vyc3BhY2UgaGludHMgYXMgYm90aCBQcmF0ZWVrIGFuZCBBbmRyZWkncyB3b3JrcyBw
cm9wb3NlLiA5NDAwDQo+IHNob3dzIHBvc2l0aXZlIGZlZWRiYWNrIGZyb20ga2VybmVsLCBhbmQg
dGhlIHF1ZXN0aW9uIGlzLCBpcyBpdCBmZWFzaWJsZQ0KPiBpbiB5b3VyIHByb2R1Y3Rpb24gZW52
aXJvbm1lbnQgdG8gc2V0IENQVSBhZmZpbml0eT8gSWYgeWVzLCB3aGF0IGVsc2UgZG8NCj4geW91
IHdhbnQ/DQoNCldlbGwsIHRoaXMgaXMgdGhlIGZ1c2UgZmlsZSBzeXN0ZW0gLSBlYWNoIGFuZCBl
dmVyeSB1c2VyIHdvdWxkIG5lZWQgdG8gZG8gdGhhdA0KYW5kIGdldCBjb3JlIGFmZmluaXR5IHJp
Z2h0LiBJJ20gcGVyc29uYWxseSBub3Qgc2V0dGluZyBjb3JlIGFmZmluaXR5IGZvcg0KYW55ICdj
cCcgb3IgJ3JzeW5jJyBJJ20gZG9pbmcuDQoNCkJ0dywgYSB2ZXJ5IGhhY2tpc2ggd2F5IHRvICdz
b2x2ZScgdGhlIGlzc3VlIGlzIHRoaXMNCg0KDQpkaWZmIC0tZ2l0IGEvZnMvZnVzZS9kZXYuYyBi
L2ZzL2Z1c2UvZGV2LmMNCmluZGV4IGNkN2FhNjc5YzNlZS4uZGQzMmVmZmI1MDEwIDEwMDY0NA0K
LS0tIGEvZnMvZnVzZS9kZXYuYw0KKysrIGIvZnMvZnVzZS9kZXYuYw0KQEAgLTM3Myw2ICszNzMs
MjYgQEAgc3RhdGljIHZvaWQgcmVxdWVzdF93YWl0X2Fuc3dlcihzdHJ1Y3QgZnVzZV9yZXEgKnJl
cSkNCiAgICAgICAgIGludCBlcnI7DQogICAgICAgICBpbnQgcHJldl9jcHUgPSB0YXNrX2NwdShj
dXJyZW50KTsNCiAgDQorICAgICAgIC8qIFdoZW4gcnVubmluZyBvdmVyIHVyaW5nIGFuZCBjb3Jl
IGFmZmluZWQgdXNlcnNwYWNlIHRocmVhZHMsIHdlDQorICAgICAgICAqIGRvIG5vdCB3YW50IHRv
IGxldCBtaWdyYXRlIGF3YXkgdGhlIHJlcXVlc3Qgc3VibWl0dGluZyBwcm9jZXNzLg0KKyAgICAg
ICAgKiBJc3N1ZSBpcyB0aGF0IGV2ZW4gYWZ0ZXIgd2FraW5nIHVwIG9uIHRoZSByaWdodCBjb3Jl
LCBwcm9jZXNzZXMNCisgICAgICAgICogdGhhdCBoYXZlIHN1Ym1pdHRlZCByZXF1ZXN0cyBtaWdo
dCBnZXQgbWlncmF0ZWQgYXdheSwgYmVjYXVzZQ0KKyAgICAgICAgKiB0aGUgcmluZyB0aHJlYWQg
aXMgc3RpbGwgZG9pbmcgYSBiaXQgb2Ygd29yayBvciBpcyBpbiB0aGUgcHJvY2Vzcw0KKyAgICAg
ICAgKiB0byBnbyB0byBzbGVlcC4gQXNzdW1wdGlvbiBoZXJlIGlzIHRoYXQgcHJvY2Vzc2VzIGFy
ZSBzdGFydGVkIG9uDQorICAgICAgICAqIHRoZSByaWdodCBjb3JlIChpLmUuIGlkbGUgY29yZXMp
IGFuZCBjYW4gdGhlbiBzdGF5IG9uIHRoYXQgY29yZQ0KKyAgICAgICAgKiB3aGVuIHRoZXkgY29t
ZSBhbmQgZG8gZmlsZSBzeXN0ZW0gcmVxdWVzdHMuDQorICAgICAgICAqIEFub3RoZXIgYWx0ZXJu
YXRpdmUgd2F5IGlzIHRvIHNldCBTQ0hFRF9JRExFIGZvciByaW5nIHRocmVhZHMsDQorICAgICAg
ICAqIGJ1dCB0aGF0IHdvdWxkIGhhdmUgYW4gaXNzdWUgaWYgdGhlcmUgYXJlIG90aGVyIHByb2Nl
c3NlcyBrZWVwaW5nDQorICAgICAgICAqIHRoZSBjcHUgYnVzeS4NCisgICAgICAgICogU0NIRURf
SURMRSBvciB0aGlzIGhhY2sgaGVyZSByZXN1bHQgaW4gYWJvdXQgZmFjdG9yIDMuNSBmb3INCisg
ICAgICAgICogbWF4IG1ldGEgcmVxdWVzdCBwZXJmb3JtYW5jZS4NCisgICAgICAgICoNCisgICAg
ICAgICogSWRlYWwgd291bGQgdG8gdGVsbCB0aGUgc2NoZWR1bGVyIHRoYXQgcmluZyB0aHJlYWRz
IGFyZSBub3QgZGlzdHVyYmluZw0KKyAgICAgICAgKiB0aGF0IG1pZ3JhdGlvbiBhd2F5IGZyb20g
aXQgc2hvdWxkIHZlcnkgdmVyeSByYXJlbHkgaGFwcGVuLg0KKyAgICAgICAgKi8NCisgICAgICAg
aWYgKGZjLT5yaW5nLnJlYWR5KQ0KKyAgICAgICAgICAgICAgIG1pZ3JhdGVfZGlzYWJsZSgpOw0K
Kw0KICAgICAgICAgaWYgKCFmYy0+bm9faW50ZXJydXB0KSB7DQogICAgICAgICAgICAgICAgIC8q
IEFueSBzaWduYWwgbWF5IGludGVycnVwdCB0aGlzICovDQogICAgICAgICAgICAgICAgIGVyciA9
IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZShyZXEtPndhaXRxLA0KDQoNClNvIGl0IGRpc2FibGVz
IG1pZ3JhdGlvbiBhbmQgbmV2ZXIgcmUtZW5hYmxlcyBpdC4uLg0KSSdtIHN0aWxsIGNvbnRpbnVp
bmcgdG8gZGlnZyBpZiB0aGVyZSBpcyBhIGJldHRlciB3YXksIGFueQ0KaGludHMgYXJlIHZlcnkg
d2VsY29tZS4NCg0KDQpUaGFua3MsDQpCZXJuZA0K
