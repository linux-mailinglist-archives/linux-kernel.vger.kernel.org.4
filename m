Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28473683412
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjAaRlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjAaRlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:41:19 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0618893D3;
        Tue, 31 Jan 2023 09:41:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr/QbcolYlPQDNbpIw2aCQ6Whm7S82Xu88LE1wewrifszl/yoEBshPyiS4/VfNtgIUD/IRLxwWB59jV0qnDDBr5uCzhPH0bF5XRxhd1Xvu2AN4fZ+EtnSOTT7nOlYHfeqzhN61HNOa7IGrcCqh0Jt3672CcNZ6T1Wl3ZVAffdJXSm4jciIgFxZZXTBEUsVpYpCVW9U4ObYFgHZv/1jJ46xRlvyZpXPCMd1ZC8GU2GPsQOYydYwt426meGAKdAk9EOx3ZEa/t54bFpWbRbkeRRreF/R5LLhhvZ4EwKJUa2u04EHlwX09hlPGv8ImvuDK5DSHCu9vw5KHEW1UgzY1tZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJDQTdwrUYlQRI3pdVZg6e9lc1PsaZ58vU1/F63xqNA=;
 b=HakFZgkSI1YZxe5pyKBcLm5VJ4zXL49BFy+tvMTNJ+nmQ0roUlZ+71HijVyLNpP+Pu8dNA0gTuUwMT/oEHKkaBWPpP6CbnqWbCtwMIWitqOLBpMEkd0mlkyXF2T0E86UD5J0EWIYnF2dW7j3qpeV4CZhTybwy20jI+q/kTSki7ZcRlXms6z2ZevIh3fD34/2rWIHDVJOJTkDlYlomeVelhuphk6wLBTEt11YKLsIHrnUG3Qo3geCGjiskNKsaYG4DuAqlf1DOIiojG1Z63zc9o/hn6qkmdYN2eUf6a10G02TBRh+BUQMLAZ8EcagajuEe/cQOadkZ9yQO/PBc+PEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJDQTdwrUYlQRI3pdVZg6e9lc1PsaZ58vU1/F63xqNA=;
 b=bSKIXMycg4GADsBXznscF+4ArLWKNRKiZsTS261ZMvpFVa5JpRBTcuGaglr/ruKgdYKlvZWe6vsQvjWetb0lwiBzFYKugA2A2kTmHtQmJCrM1YQgc5TV0LWz9nkON5WMiwGssyLf1RSy4PPctzim8PvO78Ga8tIv1fIHHV5eYWuG7e0AUiH8bmtUXXNSTRmOiXLD4NN6Xf76JN2bgcNCHmSC90Vpm/u0H9ZrznZdo6+6UQu2FY0V3KQTUkzR2uY1qn/Bs5UHTtxJJQ7q0wOwhoajlFUBBCdAAxBeCtUotLD86Z4eV/pcWvjtO5mV/fsbxYlTBT8zCuaJYvpHHd64VA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2174.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 17:41:12 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%6]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 17:41:12 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] module: replace module_layout with module_memory
Thread-Topic: [PATCH v4] module: replace module_layout with module_memory
Thread-Index: AQHZNNeu9tEplrAKq0WRjCl0zKXTeK64PbKAgAAepQCAABJMgIAAAuYAgAAfPwCAADvzAA==
Date:   Tue, 31 Jan 2023 17:41:12 +0000
Message-ID: <2481b9cb-bbe0-fd82-c722-67ba77739669@csgroup.eu>
References: <20230130182109.3571524-1-song@kernel.org>
 <Y9jau76YwdCElzZ0@hirez.programming.kicks-ass.net>
 <1302e2b6-8980-e6e5-7433-6754634c98f3@csgroup.eu>
 <Y9kDyUaOe57IL/yF@hirez.programming.kicks-ass.net>
 <6420c572-3d0c-eb64-208e-26b38d3da873@csgroup.eu>
 <Y9kgblwd/wUZ1KCJ@hirez.programming.kicks-ass.net>
In-Reply-To: <Y9kgblwd/wUZ1KCJ@hirez.programming.kicks-ass.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2174:EE_
x-ms-office365-filtering-correlation-id: 3a4a9ae8-e244-405f-c9b7-08db03b25891
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIWRK3eaikC+2MCZCP5lEzcErpEAnddLTiWDc+jz25MBPChGENdedZNoHiYv/8j38MATTbmEn52GWMuM+bAdFQamHcqOCb1GxJ4Ew+2hOlivnQSme5+29LndppZ+1sZeNpgR2eKzhbhOpyNdeJu+2bUojGME0H6MqxVL0IBvi4270Buloi5OyHiOkoWlgYwVn1VBcMBzorNltQWZfrGI5FSBTDawcJuh4CtecegFiNlIv3h5eNptoaNOW6uF6J/D88c2nmCv1ga00QbZy36Pv15hxpJajgWzpGY9E1GO+Oorjoci/XKqvzPZt1ZZZlRO3w6mi6b79iNFEvvr1OdzaLK+m1I4Q5SjxYkJOx/zuBsXOck0zLcp8vE+nzn5Xn9ENv5xtdnwOOPSy0f8t98j7s+BiCQ0UpAU8fJT3o2dnGStOK3Z8foiFq1OMqgrwqeJHToASzYEAouYrDAkpMc7uAqmy4LySOmQF4PZ1kr6EAIw59rpOwju4prcKj5fSNhcRx9bR8A2YFFUsOGKQMK8KYuNdpq4eZraTfUR9dXWhLn+8HLfQHHvtccjOhilB0AGewM39vY3ma5A1l2ySkKS8b1HxNOl/+rCj3GLUHI5Igc46Z8vtwHByjCS63/Gl89ps0mH8IyjAwP00MwYIMASBUebLkPEQ4ynYyl8Sm0DpJr9VoZJZ6ePY4EFck3kvwPjpR9hskUDU6fzw2rJCp7pHujxjDf4al4vmy0EHdsA5N/XAGRg8WaP6K+xrV64Lgc3zDdiUzOGtJ0Wh31fQxvQKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199018)(86362001)(38070700005)(31696002)(38100700002)(122000001)(6916009)(36756003)(41300700001)(5660300002)(54906003)(316002)(64756008)(66946007)(66476007)(66556008)(4326008)(76116006)(91956017)(8936002)(66446008)(8676002)(2906002)(44832011)(83380400001)(66574015)(2616005)(478600001)(6486002)(6512007)(186003)(26005)(6506007)(71200400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1hLTU5tSlRWNXd5azRBanB3RE9RSUpFbDIxYmwvU0VDZWp2S2d5Y0tTMHZP?=
 =?utf-8?B?d1RIRjZBNm5YQ3k3NXBCNEpVN0c2U1FBTDJRbTRBdVNrWGc0UzIwck1FaWls?=
 =?utf-8?B?bEx3TXRBb3VTS3lQUlYyM3VNa2QxMnRPRDFjd1JBKzBWcHZBVUQxYU1kcUF3?=
 =?utf-8?B?Mm1JU3Z6ZlhKcDFSVlB5V3JGeVlHYkdWOWp1WjZoLzVxWE5FSWp1WFBINU0y?=
 =?utf-8?B?WHZzY3RvQkpuUEUvYjl4ZXNRcmZLSm1xTmlkSHk3bjg0RER6RjBoZzNpZCs1?=
 =?utf-8?B?WEpDamw0bG44VmU5K3lLcTVDN0hxVk5IbUduTGViemwxV2gvMEZSR1U4c09j?=
 =?utf-8?B?KzI3RXdpRXBoZnhwbjVXVXBCTjBIYnNrQ3owVXRsUC9oU3AxV1dmRTlabk5K?=
 =?utf-8?B?bW5DZ2Ftd1puR1c1OEZPOStyS0VZOTVzR1NyS3ZlU3lielF2MlJpaWpkekRY?=
 =?utf-8?B?UnB0ZzJpbjlrOUlORldKbUwvRTY1SkZKVmw3ZkYwckxJdC83L2t4NzVFTmJN?=
 =?utf-8?B?ejJPQVcxcmhXWkFBUmF4b3NRdGRBQzROMlhuVmVVbExEVjVPeGE0aVB1OFM4?=
 =?utf-8?B?TmkrN29naGRNSVBBa2w0OTUzMzVQaGZCU2xOOGhzOHVPNTFqSzdxZHdmc3N6?=
 =?utf-8?B?YzNhaHJqZmlRcTNDb0dzRE4yOEFpeWdQdm1hdVVmZ1V0NUpSYU5qYU1OcWQw?=
 =?utf-8?B?a1l4VGh2WThkMWpUSDRSMENJeXJMUlFDM0tJUjJsbGRlc1NMbll6bDZmOEEw?=
 =?utf-8?B?SWpUNmZuMGpDMkQ2SzVLWlcxZURnYmlISnpXWGxKMmNkNG1NeSs2bytHYXk2?=
 =?utf-8?B?VEFmVG1nWk5uRFBYaStpNi9vSEQwYzRQNHNCaHMzbE1Zb2RqWXhZYTJPdGs5?=
 =?utf-8?B?NXNpb1RXeHZPK05sTVVpMlpXS1Z5eTFScVNrbWJkdldtNFpMaGRNam1iK21y?=
 =?utf-8?B?aHJ4R2QwVWUxR2lBYnc4RXRKMU9OM2NXaE1ydlZiMGtoQ0tuL3c1OUhiNFNI?=
 =?utf-8?B?aG9tT1gzOHF2YnVPd0Z2Wkg0ZStWMGhDYXZyMDlFcHBmZHdVUThCSDluSjh5?=
 =?utf-8?B?ZmFDaHBjT0txM3NUNHYxRURLN3pId0RxUUZOOWs2NEllb0pYMnZ2NTlFK2VO?=
 =?utf-8?B?aWJVS1FsT3FwQUlUaUlVZUFtdU9YZUVNZkU2OG5hM09XSnl3WXpuT3NUME4x?=
 =?utf-8?B?L2pyNTVRUm9kaDhzMk5GMk1GOHJHcjVQbk4xS2MyYmtHNm5YOVIyUnUxNS9U?=
 =?utf-8?B?K3FQRW1qZTNUMHdjRFNqNld4ZkxFcnFLN01GWWwvZ0xzaE12Nlp1SmJaQVdo?=
 =?utf-8?B?UEo2T1Z5RG8yemlwNDQzdHE4Y3RwSDRFUmIvWk1qNGJTUGR4ZityNHlIWDVn?=
 =?utf-8?B?OUh0NnhRVGtqcFoyYkMrMWFhWjJYZVlvV0FwN3g3Y0VhaUFacldqUDNRMmdZ?=
 =?utf-8?B?Wi81aU1oTmhsK0VsOFYyMEF6UFNOS1ZYYThJL3pQOHU0TG96c1Q4cDBKVStr?=
 =?utf-8?B?NVVXaFpvNGhsK1A1RXN0dGh4bitEMUt0WTR1MU42SzFyVW96ajA1VjBEUCsx?=
 =?utf-8?B?ZnRuZWNWNEhIT2dNam1HVmUxRVo3dnFnWHhOaklObThnaXVENnVucXgxRStB?=
 =?utf-8?B?NFU4dDV5U3N2ZERVK3R1RG5NYlZ1WXZpRzNiMFFabk96OU5SWTdSbzAweU9h?=
 =?utf-8?B?L0ErajdVamFhQ1pCbzh2dW5lYWZGWThWUWsyVlpzNTcyRXlPTWthUTRnYjlP?=
 =?utf-8?B?S2pEc2VoNUU0emttZU03YXpxeTZuNmlXTG4yRnVoaHlsLy9ZSEVReUcrNGVF?=
 =?utf-8?B?RmNIMjZVNEhjaEQ2d2dBUzkyTDQrQ0Y5bVFybTV0WHZhRm9xamhCYjJvNHBi?=
 =?utf-8?B?ZU9wNmlmSVQzTmFweUZaU2VYUDA0ZmxzSDRNSWtNbnYxRkUzTXlLUmxyU1Qy?=
 =?utf-8?B?MkNzSnFscW4zSHU4YkNkRWJJZmo3c24zSU95THhCVHQ1VDk0ZG5MeHZsaFc0?=
 =?utf-8?B?VzIxRkk1bkRzVUZiRUcvOEg1czZiaHluS0FMZkQva3pVYWVTQWxOd2lrTHls?=
 =?utf-8?B?UGFTOG9uVmxnL0pEbG93NnVsMUFJYXVFT245cDl0L1JwUkpzRk1TU2tXcnZ6?=
 =?utf-8?B?elZWbWdKNlRaWWdVaXgyM2xuUjB4WjV3OTBPZ1lrQ3hkSEVWZlVJUUNTRnZV?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C4F5EF4C3AC604885640055EB26EA99@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4a9ae8-e244-405f-c9b7-08db03b25891
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 17:41:12.7599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdU8auAJxIk11MH5E6l/M+A/1ZdEuYufi4mbQh4hhgo/jkz7nzDjneiMnwnG2NmYU0PPj+iMSvUgmhFFkopcoE5fLVh2KHeP5yS5nqUX6oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2174
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDMxLzAxLzIwMjMgw6AgMTU6MDYsIFBldGVyIFppamxzdHJhIGEgw6ljcml0wqA6DQo+
IE9uIFR1ZSwgSmFuIDMxLCAyMDIzIGF0IDEyOjE0OjQ4UE0gKzAwMDAsIENocmlzdG9waGUgTGVy
b3kgd3JvdGU6DQo+IA0KPj4+PiBTb21ldGhpbmcgbGlrZQ0KPj4+Pg0KPj4+PiAJcmV0dXJuIHdp
dGhpbihhZGRyLCBtb2QsIE1PRF9URVhUKSB8fCB3aXRoaW4oYWRkciwgbW9kLCBNT0RfREFUQSkg
fHwNCj4+Pj4gCSAgICAgICB3aXRoaW4oYWRkciwgbW9kLCBNT0RfUk9EQVRBKSB8fCB3aXRoaW4o
YWRkciwgbW9kLA0KPj4+PiBNT0RfUk9fQUZURVJfSU5JVCk7DQo+Pj4NCj4+PiBVcmdoLCBob3cg
YWJvdXQ/DQo+Pj4NCj4+PiAJZm9yX2VhY2hfbW9kX21lbV90eXBlKHR5cGUpIHsNCj4+PiAJCWlm
ICghbW9kX21lbV90eXBlX2lzX2luaXQodHlwZSkgJiYgd2l0aGluKGFkZHIsIG1vZCwgdHlwZSkp
DQo+Pj4gCQkJcmV0dXJuIHRydWU7DQo+Pj4gCX0NCj4+PiAJcmV0dXJuIGZhbHNlOw0KPj4+DQo+
Pj4gVGhlbiB5b3UgaGF2ZSBoYXZlIGEgYnVuY2ggb2YgbW9kX21lbV90eXBlX2lkX2ZvbygpIGZp
bHRlciBmdW5jdGlvbnMNCj4+PiB0aGF0IGFyZSBub24tY29udGlndW91cyB3aXRob3V0IGhhdmlu
ZyB0byBlbmRsZXNzbHkgcmVwZWF0IHN0dWZmDQo+Pj4gbWFudWFsbHkuDQo+Pg0KPj4gQnV0IHRo
YXQncyB1bi1yZWFkYWJsZS4NCj4gDQo+ICJGb3IgYWxsIGV4Y2VwdCBpbml0LiINCj4gDQo+PiBZ
b3UgaGF2ZSB0byBoYXZlIHRoZSBsaXN0IG9mIHBvc3NpYmxlIHR5cGVzIGluIGZyb250IG9mIHlv
dSBpbiBvcmRlciB0bw0KPj4gdW5kZXJzdGFuZCB3aGF0IHRoZSBmdW5jdGlvbiBkb2VzLiBXaGlj
aCBtZWFucyB0aGF0IG9uZSBkYXkgb3IgYW5vdGhlcg0KPj4gc29tZW9uZSB3aWxsIGNoYW5nZSB0
aGUgb3JkZXIgb2YgdHlwZXMgaW4gdGhlIGVudW0sIGFuZCBpdCB3aWxsIGJyZWFrLg0KPiANCj4g
SSByZWFsbHkgZG9uJ3QgYWdyZWUsIGlmIHlvdSBkbyBleHBsaWNpdCB0eXBlIGxpc3RzIGV2ZXJ5
d2hlcmUgeW91IGhhdmUNCj4gdG8gdXBkYXRlIGVhY2ggYW5kIGV2ZXJ5IHNpdGVzIHdoZW4geW91
IG1vZGlmeSB0aGUgZW51bS4NCj4gDQo+IElmIHlvdSBtYWtlIGNhdGVnb3J5IGhlbHBlcnMsIGxp
a2U6IGRhdGEsIHRleHQsIGluaXQsIHRoZW4geW91IG9ubHkgbmVlZA0KPiB0byB1cGRhdGUgdGhl
IGhlbHBlcnMgd2l0aG91dCBoYXZpbmcgdG8gd29ycnkgYWJvdXQgZWFjaCBzaXRlLiBPbmx5IGlm
DQo+IHlvdSBhZGQgYW4gZW51bSB0aGF0IGRvZXNuJ3QgZml0IHRoZSBleGlzdGluZyBjYXRlZ29y
aWVzIGRvIHlvdSBuZWVkIHRvDQo+IGRvIHNvbWV0aGluZyBuZXcuDQo+IA0KDQpXZWxsIHdlIG1p
c3VuZGVyc3Rvb2QgZWFjaCBvdGhlciB0aGVuLg0KDQpJIGFncmVlIHdpdGggeW91IHRoYXQgY2F0
ZWdvcnkgaGVscGVycyBhcmUgd29ydGggaXQuDQoNCk15IHBvaW50IHdhcyB0aGF0IHRoZSBpbXBs
ZW1lbnRhdGlvbiBvZiB0aG9zZSBjYXRlZ29yeSBoZWxwZXJzIG5lZWQgdG8gDQpiZSBleHBsaWNp
dCBhbmQgbm90IGhpZGUgdHlwZXMgYmFzZWQgb24gc29tZSBhc3N1bXB0aW9uIG9uIHRoZWlyIG9y
ZGVyIA0KaW4gdGhlIGVudW0uDQo=
