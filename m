Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8545BA6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiIPGer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIPGen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:34:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A892B2DE0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663310080; x=1694846080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Bg0sjbgQwofYQQSW2bg3onm2H7XVkzA3lSS8P9S6t54=;
  b=NfJT89PmNUftnsg5C6tScTUarEwXqKC3E8UXCmos4EQKC79cUTHpbVbN
   b2zHSYR4boJ7VpMabzLoUvyUhHldvuF3qeeSo8TpR0lcOYY4b3pZQ32Ku
   eYTi2d0PGPYvZ7ycYQTCyPbwq/L4dbazeRLCnsw5tCcOJnDHQNuaoy6Am
   F7Zll0gJBHGDws046NMB7WpGoiXJHJH9hkYVha6VnDRsdb6JVtPni3QEl
   QX59CIkdoJ3BAIbtWj3b9+MH/VfXtz3xvnZbjVCJ8np7W774U9jIE0hKP
   yT9RyaZobWyIvY7Cl80b/kcKcE//a18eNf7BBrgnaouOlxHTX9zD1V5OO
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="191112549"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 23:34:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 23:34:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 15 Sep 2022 23:34:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK+De8s5oo9zI7W25AySo/UA3hrfh4cbLC2L1gHY498J3IGLecomGScdEUK/bL38leHqrqy+rqZgvYeqDpJgI3lKh9zq9uh/dRIxkVSngVM1P7uRnr7uHzjFEz/SuoBeImeO9r1ko23paAZYEgz5tO+dJ1jIBTJFCW5cb7R6HXlEqk4ho+icwsboj6S7f8HeykDcYm2AL0zDEVSLWVH6sW1PGs4v2EfVIvgPG/QaFlqRCmirtWfbs/+JseF8E7F+tltWdZkz9A0GnStlH4/ekM7RpqV/G0UiPWZuWYc2Bpig4Yw27ZCoJfhyBUbmF3Zi5WlPIiG/z3BwLzrnaCTm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bg0sjbgQwofYQQSW2bg3onm2H7XVkzA3lSS8P9S6t54=;
 b=OQ+9rYfMRf3yjK4d5iTwz0FqgMTwyLk3ZP+zrsnKTTZVcAQ3J7E4jmNV6Vd+y3oIZjQCGAX9cCwTe/SPUZwtzPCEXfVAASlt0gJvYPtOdV+MLslNZE/n6XSwjAyG5QqP3erwD70xSS0A0h29/8JaPt30QVVJlKLKfNW2473g1NM7z2ukc0cbd406Qln0s60SB0o4n8BBlbSEbGpIH9sAz4bLxVSwXBJy0w/jl9jIDuezhGlj3YoyScEUIp32M5pj50+3Y5RBqCG9czI6qZTn91f9hmtf43+uXE01jQwwiZEHDmYlvjXBEt7A6ntD6yfbq5m9kdpcT6yYev5Q1Mh44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg0sjbgQwofYQQSW2bg3onm2H7XVkzA3lSS8P9S6t54=;
 b=K8UImP6wZ/D52Wd575eGnJGYlBeP6CZtZrw2evJ29XMd7Y63AlmsgI12c2rX30aQm7ye4B5jH9LESPy9GG2Edt058//vA48YTnPGNDUDxsRwm8BuN6Dl88fNvFj4yyCyUCftsgndQC0P1RwiPSJz87wVmH8SJW+p7s1vEd0TLDw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MW4PR11MB6620.namprd11.prod.outlook.com (2603:10b6:303:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 06:34:34 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 06:34:34 +0000
From:   <Conor.Dooley@microchip.com>
To:     <vineetg@rivosinc.com>, <linux-riscv@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <palmer@rivosinc.com>,
        <cmuellner@ventanamicro.com>, <linux@rivosinc.com>
Subject: Re: [PATCH v2] riscv: ztso: disallow elf binaries needing TSO
Thread-Topic: [PATCH v2] riscv: ztso: disallow elf binaries needing TSO
Thread-Index: AQHYyYQq7AHa3Cms0USowTkeq57IPq3hmaYA
Date:   Fri, 16 Sep 2022 06:34:34 +0000
Message-ID: <67a3aba3-68bb-5e8b-4e4e-869c8e99e879@microchip.com>
References: <20220916030552.1396820-1-vineetg@rivosinc.com>
 <20220916042331.1398823-1-vineetg@rivosinc.com>
In-Reply-To: <20220916042331.1398823-1-vineetg@rivosinc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|MW4PR11MB6620:EE_
x-ms-office365-filtering-correlation-id: 06505299-d58d-4ddc-3b0a-08da97ad8514
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y/7Eiz4U5NnLHq0Twyu/FmuRxWtvR6Djniym+QIHFTMHTCvFyAMbcJDqxmRA2M7hqzjnCmDNvRYkCn3Nv+zzRUVNUx9PSR/Vru1YeYxukl4nv7DiWZt+44716sE5Gf4Gb2wCN9o83eqtwoBh7ZUkKIzINMNhWOk6mU92Cw33AICp81Fd7D9Jd/NkSMCyxrZGwpjVCotghQzqZ8q1YnVx2z1dVQFR8AhtmMpy04NdzL9xct22ALTEFjKWEsdDWL1Cjsinn70bcoLOjW35ZC6aZc0bVvBWcDV4fJ+FURLbeLULoPWqkWEGsAq2CxSFZMYkfggosWOLm/VnUJY480W7PmYBINj3A1mqWdifHQu04F7Xqy4J9tfJKnu/GTdUOP5iFUGQBFNPqzMFBp4AqHC7ANFk5E4CqZowfAWNu132EMP/RtsvwT/DRh2Sky7T534Jh17KTurX3Vr0/zcDugM69eH5at2CXL3+FSZzM/9IN6DW7qqCsHHk80W9D3G5q9uAKKGxjP05pzUcs93KjiOAbcimJ6/vlCqOnbfr8gmKjsMUwOJDzNTHssG0M6tBCPVk2LbKOZMfhqtqDFVxcGDTuaCcXdxwU1ccCnyPMDHK35G+Xwtktr8xsUhSGvcK0/pFfqpv1jTouZAnhTobDbV/oTmj5RahZFRbh5i3zl2dnrPYkcaIFaABa4wHAVZJDITPVhy5YptJGzaly7G6kD+Tg7g3gdXEpnsjx1kCk02KFyB/emgYZBL0/Da0MR1wfn/yxMfNgGJcI/IZWHQon9msXznUFLkUKNpi1vlfF+zkT+TXP6xnb4RMWXlpvW79aRIpe9D0p5lwGzBgYvyndVCI0Ay5N74VQWbAS6sJVUyWG3c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199015)(122000001)(38100700002)(41300700001)(38070700005)(2906002)(71200400001)(186003)(26005)(83380400001)(2616005)(53546011)(966005)(478600001)(36756003)(6486002)(6512007)(64756008)(66556008)(31686004)(66446008)(66476007)(91956017)(66946007)(76116006)(316002)(8936002)(8676002)(5660300002)(110136005)(31696002)(86362001)(54906003)(4326008)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVJnaEZHTGlOWkgwcThhNVRiWUJpT25ETHEwYkZjUkRjVERzbkhXL0RJT1RL?=
 =?utf-8?B?cHpGNFFZS242cVRENmRSZ1pXaThQRTZsbTNWdFNzSFFGZ1lPQmtKemJEcnJ6?=
 =?utf-8?B?QnUzMjlpa1dlVkVEYkpKRmptalZTaG1ObER6a3ZVV2pQb1ZjZ29Jbmw5cHBT?=
 =?utf-8?B?YVJmZmJMaFh6U2s2bHoxTFdDUGJXT2NnN2xDUk9JZmFsVTVxYXNuMjQ1bG9m?=
 =?utf-8?B?MUd0U1BRRC9Ob0FWZ3NxYUtTeE1wSmt4YmdPUzgwdU53cDZ2c0pRMTRSS1Nz?=
 =?utf-8?B?ZXZGekNjd2diQzZBOEtGS1Q3ZnM2cTRtay8ybTM3cW1vVTVXa2hGM0tkY2pM?=
 =?utf-8?B?Um4yS1lVRm8vWUhXNzZGRG5OTXBmdUU2akNXT0xoNGRFOERHcGZOWkpsOVM0?=
 =?utf-8?B?bERsRTl0Q3NhVkJZODRmdnF0MWVLV1VWNVhzSkRMY1EzQ0NFbFpYaG9GNlRS?=
 =?utf-8?B?d053NjQ1NWRkV0J4V0tyYjZxVnNreDJqSXlMVkpJOWROKzVROTVYRThCbGFD?=
 =?utf-8?B?ZjVFcnBMcDVvanBza3RhSFlkUURmVFFub1J3V0FEUkVlbWRaQ2FsMWlkZWE2?=
 =?utf-8?B?TnlrTzFGYnNMSUY0d01kTG1RV0VlZXA0ZlFPSTVOa3FUUElNTS9mZWhnNEtC?=
 =?utf-8?B?aGFLTG5kS2ExYTB0b3RwazNKNGxRcE93K3dSVVArR1FhVjdzNUd2OUpoWkRZ?=
 =?utf-8?B?Qkp0aDJZMGhrcVdHR3JxK3FrYk5DeXhLTmxRS2hFdHo3SGxGd242RlZHcEVW?=
 =?utf-8?B?TURzSU01SlVyRTN3VUN5WmtzdXpSdzNQbWMzVnR5MWpBRVJjZ0hpcnhwOWNW?=
 =?utf-8?B?Q1ZEY0t2aHdqTFRDcmFLSWx2aEp2NDRvZy9IRGkvVTJINEVDSTlvMzE2M2or?=
 =?utf-8?B?SzRyUldmVHZ1WGV1OEd4aSt1bEdsRU8wcXJuTjlWMWhqZHVUR3BwSkp2eWUv?=
 =?utf-8?B?SkhZSC9pQUdiTkorSHlSME9PVFZ1dWxhanl0MEFhSW83cTFnaHRUUHMxOElh?=
 =?utf-8?B?WGt2M3Zyd0ZCTWF1c1UzMXRzRitXMm1pWXc4dGFGS2R3UTh1SmJmY2M0bXE1?=
 =?utf-8?B?dVA0RXhyVzJJVHlHUEpJZ0tRUFc4SzVuRU9yeTJiQ3V6ZE1rNHhVQVBQeFFu?=
 =?utf-8?B?TlREckNsbWI3YUFlZE9UNW9JZGEvdVU4M2lwNHFUS0cweGtyUm5lTGgxQVc3?=
 =?utf-8?B?bDhlUlNHS0FhRkNNM21OaGZkSWtTQzJabGhWUlQxL0xucDNtMmtHUWIzV2Iz?=
 =?utf-8?B?NkRHNkdVM1B2UmJwY3hUNEtxRG9LbmhhbWtDUVJRa1FmcVlNV2diaXpleVFX?=
 =?utf-8?B?eEovWDNEcndvazkzVm4wb2pUT1Z6NGN1QTFRYUFLdjlpc0xyV0hhRWpqN1Iy?=
 =?utf-8?B?UWJ2UzYrakE5YmhIMnRTM0V0VDc4OWY3MWlsVXRid1ZFQSszQ0kzYmdBMFlk?=
 =?utf-8?B?TW9TZy9iZjRLY0tyMm1MbEUyVnZMY1BmWHR2S3NMZ2kzTFdpSndmS2hxazNs?=
 =?utf-8?B?SmtqKzE1RjdMU2xnWGVJallnRTRyMVF1aUV5Q0N0N0NmQ09rRHRycXdQWHBh?=
 =?utf-8?B?UVBvb0h4NmZlZ3I3SVIzQW9LL1g0eGNGYWRNNUFzN2ZyaEJ2ei9UdEh0cWRK?=
 =?utf-8?B?dG00c1czU3NFcWNYSlpDdDZjQ2MwZHBpeWdycWhTeFVUVFJyd1duYWRFb2Q3?=
 =?utf-8?B?cjBJYWZCT2V0aDRCSWh3VXhTN2YxU1ZpUFNEc3R1WE5YQ081RnBjV1NJY2xa?=
 =?utf-8?B?cTBzY2l5bmlRVi9UcUJldVcvVVMwRzkyYXl1YWJCMC9iQjA3TzJtajFxWlQ2?=
 =?utf-8?B?a2RqeEhsdlNwOW9aYTdMUjg5MThsbHIwNlp5Mnh4Tld3VHA3Q0JQUEZaWXYy?=
 =?utf-8?B?c1AvelFLakMrVFdPSHNlbGs4UkRBK3A2TlIzNjhNdWM1bXpvcEZ4N01mQXRk?=
 =?utf-8?B?eFRqa0lyRlcwa05VSHJKemkrSU1TVXBJd3hzK256SFh3cVVhVUJ4RE1nNllw?=
 =?utf-8?B?ZlYzSWZySnpzUUdNYW1CeXJRcC9oTytZMVV2Y0UvNlcxOVBCd3lhaXBka1hw?=
 =?utf-8?B?a1BWT2lNejRJRk5VMk1OUmpNZlNRMlFnZkQ0bENyMVlZWHhhTU9TL1pyd2JH?=
 =?utf-8?Q?LVbU+OtJRiyDj6j9SaRctymEn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3EF5A9697771A418151CBC8B1DB7C73@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06505299-d58d-4ddc-3b0a-08da97ad8514
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 06:34:34.4022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2vqLNqnThdbuVVs8OoRNgEg5T222yrj0zPav4eFP/yja5+08KadJGjxs6JkWVyLEVoCTJNxW8E2ShMSqgIHrCryOaFAEETkxBO5Y8EGPoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6620
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDkvMjAyMiAwNToyMywgVmluZWV0IEd1cHRhIHdyb3RlOg0KPiBbWW91IGRvbid0IG9m
dGVuIGdldCBlbWFpbCBmcm9tIHZpbmVldGdAcml2b3NpbmMuY29tLiBMZWFybiB3aHkgdGhpcyBp
cyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0
aW9uIF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQXMg
b2Ygbm93IHRoZSBzb2Z0d2FyZSBzdGFjayBuZWVkcyB3b3JrIHRvIHN1cHBvcnQgenRzby4gVW50
aWwgdGhhdCB3b3JrDQo+IGlzIGZpbmlzaGVkLCBkaXNhbGxvdyBiaW5hcmllcyBuZWVkaW5nIFRT
Ty4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgbmVlZGVkIHRvIGhlbHAgenRzbyByYXRpZmljYXRpb24g
YW5kIHByb2xpZmlyYXRpb24gb2YgdHNvDQo+IGJpdHMgaW4gdG9vbGluZy4NCg0KSSBoYXZlIHRv
IGFkbWl0IHRvIGJlaW5nIGEgbGl0dGxlIGNvbmZ1c2VkIGhlcmUsIGlmIFp0c28gaXMgbm90IHJh
dGlmaWVkDQp3aHkgZG8gd2UgbmVlZCB0byBwcm90ZWN0IG91cnNlbHZlcyBmcm9tIGl0Pw0KDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBWaW5lZXQgR3VwdGEgPHZpbmVldGdAcml2b3NpbmMuY29tPg0K
PiAtLS0NCj4gQ2hhbmdlcyBzaW5jZSB2MQ0KPiAgICAtIEJ1aWxkIGVycm9yIChhbmQgYm9vdCB0
ZXN0ZWQgb24gcWVtdSkNCj4gICAgLSBJbXByb3ZlZCB0aGUgY29tbWVudHMgYSBiaXQNCj4gLS0t
DQo+ICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9lbGYuaCAgICAgIHwgMTEgKysrKysrKysrKy0N
Cj4gICBhcmNoL3Jpc2N2L2luY2x1ZGUvdWFwaS9hc20vZWxmLmggfCAgMiArKw0KPiAgIDIgZmls
ZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vZWxmLmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUv
YXNtL2VsZi5oDQo+IGluZGV4IGY1M2M0MDAyNmM3YS4uYjZiNDU0MmIzMDM5IDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2VsZi5oDQo+ICsrKyBiL2FyY2gvcmlzY3YvaW5j
bHVkZS9hc20vZWxmLmgNCj4gQEAgLTI2LDEwICsyNiwxOSBAQA0KPiANCj4gICAjZGVmaW5lIEVM
Rl9EQVRBICAgICAgIEVMRkRBVEEyTFNCDQo+IA0KPiArLyoNCj4gKyAqIE1ha2Ugc3VyZSB0aGUg
ZWxmIGJlaW5nIGxvYWRlZCBpcyBjb21wYXRpYmxlIHdpdGggZXh0ZW5zaW9ucy4NCj4gKyAqDQo+
ICsgKiBJbiB0aGUgZmluYWwgaW5jYXJuYXRpb24gdGhpcyB3aWxsIGdldCB0aGUgZXh0ZW5zaW9u
IGxpc3QgZnJvbSBEVCBhbmQNCj4gKyAqIG1ha2Ugc3VyZSBlbGYgY2FuIHJ1biBvbiBnaXZlbiBo
YXJkd2FyZStrZXJuZWwuDQo+ICsgKiBGb3Igbm93IGRpc2FsbG93IFRTTyBidWlsdCBiaW5hcmll
cy4NCj4gKyAqLw0KPiArI2RlZmluZSBydl9leHRfb2soeCkgICAoISgoeCktPmVfZmxhZ3MgJiBF
Rl9SSVNDVl9UU08pKQ0KPiArDQo+ICAgLyoNCj4gICAgKiBUaGlzIGlzIHVzZWQgdG8gZW5zdXJl
IHdlIGRvbid0IGxvYWQgc29tZXRoaW5nIGZvciB0aGUgd3JvbmcgYXJjaGl0ZWN0dXJlLg0KPiAg
ICAqLw0KPiAtI2RlZmluZSBlbGZfY2hlY2tfYXJjaCh4KSAoKHgpLT5lX21hY2hpbmUgPT0gRU1f
UklTQ1YpDQo+ICsjZGVmaW5lIGVsZl9jaGVja19hcmNoKHgpICgoeCktPmVfbWFjaGluZSA9PSBF
TV9SSVNDViAmJiBydl9leHRfb2soeCkpDQo+IA0KPiAgICNkZWZpbmUgQ09SRV9EVU1QX1VTRV9S
RUdTRVQNCj4gICAjZGVmaW5lIEVMRl9FWEVDX1BBR0VTSVpFICAgICAgKFBBR0VfU0laRSkNCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS91YXBpL2FzbS9lbGYuaCBiL2FyY2gvcmlz
Y3YvaW5jbHVkZS91YXBpL2FzbS9lbGYuaA0KPiBpbmRleCBkNjk2ZDY2MTAyMzEuLmZhOWU0YzUy
YzdhYyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL3VhcGkvYXNtL2VsZi5oDQo+
ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS91YXBpL2FzbS9lbGYuaA0KPiBAQCAtMzIsNiArMzIs
OCBAQCB0eXBlZGVmIHVuaW9uIF9fcmlzY3ZfZnBfc3RhdGUgZWxmX2ZwcmVnc2V0X3Q7DQo+ICAg
I2RlZmluZSBFTEZfUklTQ1ZfUl9UWVBFKHJfaW5mbykgICAgICAgRUxGMzJfUl9UWVBFKHJfaW5m
bykNCj4gICAjZW5kaWYNCj4gDQo+ICsjZGVmaW5lIEVGX1JJU0NWX1RTTyAgICAgICAgICAgKDEg
PDwgMykNCg0Kcy9FRi9FTEYgPw0KDQpUaGFua3MsDQpDb25vci4NCg0KPiArDQo+ICAgLyoNCj4g
ICAgKiBSSVNDLVYgcmVsb2NhdGlvbiB0eXBlcw0KPiAgICAqLw0KPiAtLQ0KPiAyLjM0LjENCj4g
DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
PiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LXJpc2N2DQoNCg==
