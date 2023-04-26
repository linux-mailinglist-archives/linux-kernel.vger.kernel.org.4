Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256456EFB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjDZTfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjDZTf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:35:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE553591
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne29vKaVz2oUQe+unY9JiCuGiNTqkPoPrfVp89nfl6takL4li56CnRFSySLV7WTjSuytLqcLhgdKyhqAW/BJF8REU7mgeAMbXJ/o33PZjbNLqnuaQ6SA020FsBXEJ4qbb5tymIOOGUGyE1icSC9+WxcNQLcxqdgWaHSYLDH9pcxaOKM2trH57T4dTV1UV3MGpmRs+5x0JI5c0tLIw+QA4SdeOaS/3D6/5NtqbXk/VT1f2RAntkgnEAexf9b4xSk10zbt3zIQVJVzHniYWlxyop2mYAzI9OOe6pjlurIq8CalChi1U17z7tM5bA8HaTDK8v06KTGB6CeP0G5GjkpihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVO1R66uKupg+CK1iLwKZI0GYQivWTyKszJ/65NZ1HU=;
 b=Lu4dAUDDygeA7K+m6KCj8GdGndFyCarONuXcFr/cwCrWZlu5CxnA1A95yy/d45e/22UIlyy8Bz+pM+7KXXz1qysP1UbJXTBQDHNsquMh7SlSa+EfS/tZmIzke0gKoWrqgsR/F5kN2iv7XHtXIaQvo2u/DCgIF00WuyH993MVLcW8Dv11yvzrGimHcbdkUfJsbp5TX1nluXXr+17J+c69TVslN99MIU3h5M0QapBUb5smov4YObcckjFF/NifzYjYPhF6goOyaAn8YA5LT20Ijvije3LFUrxUnBtSHPbctytnCPE+Y42M8Z8KKJYF5404wTM1DAkEr/UJ4VCK57wmrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVO1R66uKupg+CK1iLwKZI0GYQivWTyKszJ/65NZ1HU=;
 b=j/K3D7f17Gm/pn6Y1sM2PQK6carACoiJCZVnE5/W+Hv5em5f5cKSDarQpkUwEmTONQ2qP+rEhPLZ6r8nScXaCDHziJhilyDETRNWNPsE9tdEaaaMlEpyCl9CpCfHOQ4NmF7W4uUr3QKlYBAmO3R45Fbd+5vjfXmYrAMcLw5HMaU=
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by SN7PR19MB4830.namprd19.prod.outlook.com (2603:10b6:806:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 26 Apr
 2023 19:35:21 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8cb3:ef5b:f815:7d8c]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::8cb3:ef5b:f815:7d8c%4]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 19:35:21 +0000
From:   Bernd Schubert <bschubert@ddn.com>
To:     Andrei Vagin <avagin@google.com>
CC:     "avagin@gmail.com" <avagin@gmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "posk@google.com" <posk@google.com>,
        "tycho@tycho.pizza" <tycho@tycho.pizza>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "wad@chromium.org" <wad@chromium.org>,
        "yu.c.chen@intel.com" <yu.c.chen@intel.com>
Subject: Re: [PATCH 3/6] sched: add a few helpers to wake up tasks on the
 current cpu
Thread-Topic: [PATCH 3/6] sched: add a few helpers to wake up tasks on the
 current cpu
Thread-Index: AQHZeHBZewdiUXwEBUq/gdxbUigVya89+5gA
Date:   Wed, 26 Apr 2023 19:35:20 +0000
Message-ID: <1e5cb834-2769-abc6-12bb-6184cfdd3536@ddn.com>
References: <20230308073201.3102738-1-avagin@google.com>
 <20230308073201.3102738-4-avagin@google.com>
 <CAEWA0a68dgA_sZVV7YWrrvK1=GkpEW1KcF1FNcmFOkDx+QKxYA@mail.gmail.com>
In-Reply-To: <CAEWA0a68dgA_sZVV7YWrrvK1=GkpEW1KcF1FNcmFOkDx+QKxYA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1901MB2037:EE_|SN7PR19MB4830:EE_
x-ms-office365-filtering-correlation-id: e4e5bbf9-278c-429e-b98a-08db468d5f49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jU0aETchvjDAmL+jb48IzFHXdg0cVZzcuzZIw/EovkJ0X6/w3IQbq6iORJXqHtRhiJcOEkI6/lJj/mUrIO9FOSOWyw2qMhm7Lac0OnZfhPcNJD+iawAMxtSKW2WHHtXFlYYPXkIt6c35KdNC3zzkCSU4Fhjad1iAyNuKOcSpHw24ioO6Ina++YWff7nHSEc9EYjL5mldMSECtA8HMVnuyD2wa3WkQinY1HjvXoLMAxHfkNIt/1v6GQMM5thWCSI+HxQ1NFwqLh5SjxED589Hpx9Spc20YfYp5Ds20bqHqJIQSlu+SycPHXHdUwYhI/Dx+nTN4kqS9jVm3XxA2I753XaUwD0wkHryRGItgDzLANf5rxgjpXNyV3OdYH2Dmeb99bIK4Mw0VWT5aEYdBssYVQEHCL1jjEfvvOn8b6hXUYII1HDnDJ94rr2/0W6wFVrczuchX6seV9w/SB0l8XPyd5sHU3+mkk7//PIfsRf76uNttH962ydzQHG22dYxiR23hfeyYlp5ys/M5txqGifOM/4HHL5+jxa5+rXp3JmI7FBui8Tc/tKmWZ6ZCrwWl1T8XKJgDSUtrTCKIvnQQ+mnE362KiUKHXgUPQR0nFJvKjWRl9S/e4hyRLQBJlh+EY0it/JQ6UqioGRmSa7LqnqOR8zNyhiNR4jfc8X+5/1AzQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(966005)(5660300002)(38100700002)(2906002)(7416002)(6486002)(83380400001)(186003)(54906003)(41300700001)(38070700005)(31686004)(478600001)(86362001)(2616005)(8936002)(122000001)(71200400001)(8676002)(36756003)(91956017)(316002)(31696002)(66946007)(76116006)(66446008)(66476007)(4326008)(6916009)(66556008)(64756008)(6506007)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3NTbHM2U004QVdacVROdzFHbktFQ0E0a2tVVTNxaG1NKzdKQkM3ZFRYdFc1?=
 =?utf-8?B?KytyWTZCTDQwNzUvME1EQVVGQWVXbi8yVmFBVjhVRlVQdFVJMlFtRlVOV3VG?=
 =?utf-8?B?OFlVZ1N3cmhIZEh5Tk9GVURJaTVzaWhFTi8wY1VXZ3dTNjBOZHNNYmVSL05B?=
 =?utf-8?B?V0o1ZGhhODdSb2p2UC9qNHFiMkpNVG9QTUZON0ZsSnlSMU9xbUttS0JPMmdJ?=
 =?utf-8?B?anpFNmJxejlDSlBJcHR5NHM1WFJ1MUhGR1p6T1gySE5RTWxpdlpuRHB0bWxy?=
 =?utf-8?B?SGRXd1Fid1dtWlJ0ODR2czk0SENSYXgrbDNQZFNGZE9qUjJ4RHVxODVHczZx?=
 =?utf-8?B?LzRjZ01JTDNCSjNtcnNOS2pERTlBcFgwbzNzZGlLT3JQVi9zWjg3KzhsUnZX?=
 =?utf-8?B?WWN0SVM2RWpvZ2M1Z2xxWkFoVjNyZURCQ0czcHJwOWFSTDhzamdJNUJ3SjEw?=
 =?utf-8?B?UFJWQVdlaEtrdHlMTHJyQUlDcy9mSzhKN2ZjTHJaVFJSVUxiVmxMditIcS9C?=
 =?utf-8?B?TmtmQ2lnN2FyU0JKTnh0cDE2TzFUZGdVM3hTd2owL3NHUm0xbS9CaCt3ejB0?=
 =?utf-8?B?VWxmTXlFTXliQ3FZY3ByY1ArMnhQcVdIZXlnVEFzUVVWeEdBaGZHcHBwMi9u?=
 =?utf-8?B?dDQ2bXZ4K29qaDZJSVIwRXJEemJTU252bXk4ajhtNU5jRS9wWERvbHNqRXJh?=
 =?utf-8?B?RnczZWR4eXlON1JBOXhxWEZYWGNDd2NWckljL0hkTFpxZDZqY0ZCVER2OEds?=
 =?utf-8?B?WVNWd2VhQy9nTThmQ0laUXB5ai82UmJJajFuV09QV0tzZGFZWXhoRnlMdkZ0?=
 =?utf-8?B?S0RXNkNnK04zWUVIakFlM1I3Mm9FRmFIeTFGM0Y5YmNhUmdhVm0vWmNSb2hF?=
 =?utf-8?B?N3IrM1RqdVNZRzdlTUh4ODJydkJKa0VlKzFSODV3ZzhpamMwZ2tEYnp4Q1kz?=
 =?utf-8?B?VlJZK1BDMjhZSWRxWEdJS0lRUXRFSEx5Si85bzgwOFl2TkhzNWt2L09ybG5o?=
 =?utf-8?B?WDU1YnQ3elIrMHN4REs0aU95MzQ1MXdiRGFHWllpSDBBbmlRa3lRaVROT0Q2?=
 =?utf-8?B?Z25wcTl2SUsxZTFmOWwvTlFTaERGR29ZdXpUTGZyQlJBZ1RaVFlrUkdVOHE5?=
 =?utf-8?B?dkJIZUlqYlNwMzBjbjZXdmFzV0prbFJWdHc3c0ZPTndRbXNCWktxYjVVTksr?=
 =?utf-8?B?QXBpajk3dFZEb0lZYzhGK3E4T1Z4TzFTWDEwbW5RME9ySjJ2bDhuc0trbjBi?=
 =?utf-8?B?bG5ZeHZweGFxTlRyWlU5Nzl3dzJ2L21UaGhWVmZNM05rbHBvTEZobjV2YXRG?=
 =?utf-8?B?VVVQZVorTWcwalJSMmpOVEFPN01JTGV2d3FZN3cvWUhielFhT1MyVHFBS1hX?=
 =?utf-8?B?UDVuVnBMRTh6U0xKTjRUSzlpaXptRWUrL1VkSUdYY0xmdGltbHQ2d0Y3WjZi?=
 =?utf-8?B?eXNYV3lSeFg1U1hOWk9IbDMvYVd2ZExabjVrUWxQWW95UnM4YU9xRU92Rkln?=
 =?utf-8?B?Zm9hTmtTMjlabmlHT21YYWJnNjJGT0JHVmJ2OEZsTmxtQzdrbHgzNTlYVzlv?=
 =?utf-8?B?dTJQU2ZGbWRUQVQ0ZElsQzdVK0hHVm9BUDJPZmp5dHBsYTJhQW4yc0lna3lp?=
 =?utf-8?B?cHN6bG54ZUV3MkE5ajhIc3VLRVZ1cTNaSXBiT0VoK1ZaT003QWRuNHRKTWdD?=
 =?utf-8?B?Z3BhZzNzQ3dNQy9zY0c4bWREbk5tNW12ZlFjQlpTZHpid0JzamlwYk5PTVAv?=
 =?utf-8?B?SFhxeXM0TW1HNnhzZm1jUy82VVlRR1RQWllwK2VsOGtLVnR2aGFZQjdXZElX?=
 =?utf-8?B?cVdCUnZiSHJZc3krS1Q4c1BXd0FOS1ovUTFtVDlXa3g4SnEwZTlGVU5PWkkw?=
 =?utf-8?B?dWR3dmxVQ1EwNi96bHBRRm84a0ZoVUw2dEczVW0rQUFKT0tvcnBUNUpsVUxR?=
 =?utf-8?B?VGNEZFUrNVYxVjJOUG9uMDlwUTJFUXpTT3AwNWNtR2N3TGphUnJxa1ZWeDdG?=
 =?utf-8?B?ek5PRUEyNGNsNEFWdTNlSHg5QmZUZkp4MmlkU3hUZTd5bnN2bWMvN3dXb2Fm?=
 =?utf-8?B?Nk1oMEk5ZC93NUtsdnh0WHhCcTI4SzkzeVplU1ZtZGp3UjRRV1BsM09TWU9p?=
 =?utf-8?B?dDZudWZFUlpscW1UdkxQNUZTOU1iQ0dIR01oaTl4RGl2YXUwRk9OMWtPOHY3?=
 =?utf-8?Q?S/9rMwc57MfCOw5TcvxZnWI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAD2848E6E34F6409CDF42026AE74DED@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e5bbf9-278c-429e-b98a-08db468d5f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 19:35:20.5588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBti4sEIOTxbHC+XyZOjyuI3Ys8XNMyGmduQicKX14e3zZP3yhPu58IVORdmqyoYT0sKQfchFYffHQ76kFrUsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4830
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNi8yMyAyMDo1MiwgQW5kcmVpIFZhZ2luIHdyb3RlOg0KPiBPbiBXZWQsIEFwciAyNiwg
MjAyMyBhdCA3OjQz4oCvQU0gQmVybmQgU2NodWJlcnQgPGJzY2h1YmVydEBkZG4uY29tPiB3cm90
ZToNCj4+DQo+Pj4gQWRkIGNvbXBsZXRlX29uX2N1cnJlbnRfY3B1LCB3YWtlX3VwX3BvbGxfb25f
Y3VycmVudF9jcHUgaGVscGVycyB0byB3YWtlDQo+Pj4gdXAgdGFza3Mgb24gdGhlIGN1cnJlbnQg
Q1BVLg0KPj4NCj4+PiBUaGVzZSB0d28gaGVscGVycyBhcmUgdXNlZnVsIHdoZW4gdGhlIHRhc2sg
bmVlZHMgdG8gbWFrZSBhIHN5bmNocm9ub3VzIGNvbnRleHQNCj4+PiBzd2l0Y2ggdG8gYW5vdGhl
ciB0YXNrLiBJbiB0aGlzIGNvbnRleHQsIHN5bmNocm9ub3VzIG1lYW5zIGl0IHdha2VzIHVwIHRo
ZQ0KPj4+IHRhcmdldCB0YXNrIGFuZCBmYWxscyBhc2xlZXAgcmlnaHQgYWZ0ZXIgdGhhdC4NCj4+
DQo+Pj4gT25lIGV4YW1wbGUgb2Ygc3VjaCB3b3JrbG9hZHMgaXMgc2VjY29tcCB1c2VyIG5vdGlm
aWVzLiBUaGlzIG1lY2hhbmlzbSBhbGxvd3MNCj4+PiB0aGUgIHN1cGVydmlzb3IgcHJvY2VzcyBo
YW5kbGVzIHN5c3RlbSBjYWxscyBvbiBiZWhhbGYgb2YgYSB0YXJnZXQgcHJvY2Vzcy4NCj4+PiBX
aGlsZSB0aGUgc3VwZXJ2aXNvciBpcyBoYW5kbGluZyBhbiBpbnRlcmNlcHRlZCBzeXN0ZW0gY2Fs
bCwgdGhlIHRhcmdldCBwcm9jZXNzDQo+Pj4gd2lsbCBiZSBibG9ja2VkIGluIHRoZSBrZXJuZWws
IHdhaXRpbmcgZm9yIGEgcmVzcG9uc2UgdG8gY29tZSBiYWNrLg0KPj4NCj4+PiBPbi1DUFUgY29u
dGV4dCBzd2l0Y2hlcyBhcmUgbXVjaCBmYXN0ZXIgdGhhbiByZWd1bGFyIG9uZXMuDQo+Pg0KPj4+
IFNpZ25lZC1vZmYtYnk6IEFuZHJlaSBWYWdpbiA8YXZhZ2luQGdvb2dsZS5jb20+DQo+Pg0KPj4g
QXZvaWRpbmcgY3B1IHN3aXRjaGVzIGlzIHZlcnkgZGVzaXJhYmxlIGZvciBmdXNlLCBJJ20gd29y
a2luZyBvbiBmdXNlIG92ZXIgdXJpbmcNCj4+IHdpdGggcGVyIGNvcmUgcXVldWVzLiBJbiBteSBj
dXJyZW50IGJyYW5jaCBhbmQgcnVubmluZyBhIHNpbmdsZSB0aHJlYWRlZCBib25uaWUrKw0KPj4g
SSBnZXQgYWJvdXQgOTAwMCBjcmVhdGVzL3Mgd2hlbiBJIGJpbmQgdGhlIHByb2Nlc3MgdG8gYSBj
b3JlLCBhYm91dCA3MDAwIGNyZWF0ZXMvcw0KPj4gd2hlbiBJIHNldCBTQ0hFRF9JRExFIGZvciB0
aGUgcmluZyB0aHJlYWRzIGFuZCBiYWNrIHRvIDkwMDAgd2l0aCBTQ0hFRF9JRExFIGFuZA0KPj4g
ZGlzYWJsaW5nIGNwdSBtaWdyYXRpb24gaW4gZnMvZnVzZS9kZXYuYyByZXF1ZXN0X3dhaXRfYW5z
d2VyKCkgYmVmb3JlIGdvaW5nIGludG8NCj4+IHRoZSB3YWl0cSBhbmQgZW5hYmxpbmcgaXQgYmFj
ayBhZnRlciB3YWtpbmcgdXAuDQo+Pg0KPj4gSSBoYWQgcmVwb3J0ZWQgdGhpcyBhIGZldyB3ZWVr
cyBiYWNrDQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2QwZWQxZGJkLTFiN2UtYmY5
OC02NWMwLTdmNjFkZDFhMzIyOEBkZG4uY29tLw0KPj4gYW5kIGhhZCBiZWVuIHBvaW50ZWQgdG8g
eW91ciBhbmQgUHJhdGVla3MgcGF0Y2ggc2VyaWVzLiBJJ20gbm93IGdvaW5nDQo+PiB0aHJvdWdo
IHRoZXNlIHNlcmllcy4gSW50ZXJlc3RpbmcgcGFydCBpcyB0aGF0IGEgZmV3IHdlZWtzIEkgZGlk
bid0IG5lZWQNCj4+IFNDSEVEX0lETEUsIGp1c3QgZGlzYWJsaW5nL2VuYWJsaW5nIG1pZ3JhdGlv
biBiZWZvcmUvYWZ0ZXIgd2FraW5nIHVwIHdhcw0KPj4gZW5vdWdoLg0KPj4NCj4+IFsuLi5dDQo+
Pg0KPj4+IEVYUE9SVF9TWU1CT0woc3dha2VfdXBfb25lKTsNCj4+PiBkaWZmIC0tZ2l0IGEva2Vy
bmVsL3NjaGVkL3dhaXQuYyBiL2tlcm5lbC9zY2hlZC93YWl0LmMNCj4+PiBpbmRleCAxMzNiNzQ3
MzA3MzguLjQ3ODAzYTBiOGQ1ZCAxMDA2NDQNCj4+PiAtLS0gYS9rZXJuZWwvc2NoZWQvd2FpdC5j
DQo+Pj4gKysrIGIva2VybmVsL3NjaGVkL3dhaXQuYw0KPj4+IEBAIC0xNjEsNiArMTYxLDExIEBA
IGludCBfX3dha2VfdXAoc3RydWN0IHdhaXRfcXVldWVfaGVhZCAqd3FfaGVhZCwgdW5zaWduZWQg
aW50IG1vZGUsDQo+Pj4gICB9DQo+Pj4gICBFWFBPUlRfU1lNQk9MKF9fd2FrZV91cCk7DQo+Pg0K
Pj4+ICt2b2lkIF9fd2FrZV91cF9vbl9jdXJyZW50X2NwdShzdHJ1Y3Qgd2FpdF9xdWV1ZV9oZWFk
ICp3cV9oZWFkLCB1bnNpZ25lZCBpbnQgbW9kZSwgdm9pZCAqa2V5KQ0KPj4+ICt7DQo+Pj4gKyAg
ICAgX193YWtlX3VwX2NvbW1vbl9sb2NrKHdxX2hlYWQsIG1vZGUsIDEsIFdGX0NVUlJFTlRfQ1BV
LCBrZXkpOw0KPj4+ICt9DQo+Pg0KPj4gSSdtIGFib3V0IHRvIHRlc3QgdGhpcyBpbnN0ZWFkIG9m
IG1pZ3JhdGVfZGlzYWJsZS9taWdyYXRlX2VuYWJsZSwgYnV0IHRoZSBzeW1ib2wgbmVlZHMNCj4+
IHRvIGJlIGV4cG9ydGVkIC0gYW55IG9iamVjdGlvbiB0byBkbyB0aGF0IHJpZ2h0IGZyb20gdGhl
IGJlZ2lubmluZyBpbiB5b3VyIHBhdGNoPw0KPiANCj4gSSB0aGluayBFWFBPUlRfU1lNQk9MX0dQ
TCBzaG91bGQgbm90IHRyaWdnZXIgYW55IG9iamVjdGlvbnMgYW5kIGl0DQo+IGNvdmVycyB5b3Vy
IGNhc2UsIGRvZXNuJ3QgaXQ/DQoNCkFoIHllcywgc3VyZSwgX0dQTCBpcyBmaW5lLiBJIGhhdmUg
YXBwbGllZCAyLzYgYW5kIDMvNiBpbiBteSBicmFuY2ggYW5kIHRoZW4gaGF2ZQ0KDQp3YWl0LmgN
CiNkZWZpbmUgd2FrZV91cF9pbnRlcnJ1cHRpYmxlX3N5bmMoeCkJX193YWtlX3VwX3N5bmMoKHgp
LCBUQVNLX0lOVEVSUlVQVElCTEUpDQoNCmFuZCBhbmQgdXNpbmcgdGhhdCBpbiBmdXNlX3JlcXVl
c3RfZW5kKCkgLSB3b3JrcyBmaW5lIGFuZCBubyBtaWdyYXRpb24gb24gd2FrZSB1cC4NClRob3Vn
aCwgSSBzdGlsbCBuZWVkIFNDSEVEX0lETEUgZm9yIHRoZSB1cmluZyB0aHJlYWQgdG8gYXZvaWQg
YSBsYXRlciBtaWdyYXRpb24sDQp3aWxsIG9wZW4gYSBzZXBhcmF0ZSB0aHJlYWQgZm9yIHRoYXQu
DQoNCg0KVGhhbmtzLA0KQmVybmQNCg0KDQo=
