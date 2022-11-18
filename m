Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11C362EC89
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 04:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiKRDyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 22:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240679AbiKRDyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 22:54:40 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79C7EBDC;
        Thu, 17 Nov 2022 19:54:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azSLD2X/tCrmn1r7SomB9U+gDYwkgnHddVr7MncbePcHF4YH2Ax5ekrv0GmNelCwBOBeB2/1RuytwoUzivW/+ChoPRv30s++ob77tu8zuru+x7qC7yhDzYXgR26GEsxFjxnkcaM2rw8D9p+KEqrCSChX53LWchv4O5eDK7jdAwI1903szee0DmMX/l+Oyl7cpEXk3hxwtP/9pb1fANwImMZIgaOzjVGOe22sTJdtnnm9sHrswKL+Q2bn82O8D0a5Ug3GoV+3bp02Ojx0zyWquYqTAKjVcpAooQRxuzG296V1/RBq0VIvT5OWuAgiyOmuUUuuGfV9kTRat605bQt/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ptt4oX49WQX7038z6ndtUg168NFIU1IacH9WizBqYg=;
 b=NEb4hHWYiewt9s2s1WKJvthLlTv7EsZ3PT39+y+rCzxm7xxh+WEt5vUXh1iuBSzEK9b3QA2akWO/5NFceLIYA3h2vkwudiz7e4kqrsqg4eYEl+R+8K7TyQzkvFXcc1r6xshiM3M+lT3dmTGLoe6dJZvSs1lT8eC+M9L2rbRnBY0Ngr4nwxXMOy6mZ0yo+o4jTTZpWUFNk2QxHtvODbrQf5L+nYSHbYhr71KU3anwtTS/4NESQNXMoyPJ3f8aYblSVegiOKFUk2q+6qC2ecpRV7VnQhxFbQNuXIDkDXmtcEnP33gOajOyPsPz2cV5Jgw5MEWcruYyWfr/jCWf5ERN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ptt4oX49WQX7038z6ndtUg168NFIU1IacH9WizBqYg=;
 b=Yh65zPDpw2Ewn4Xfo9xqYZD7Wq5Y/NA5U7ROMLGG4KtHCvSbY0l6OKGlJzEI2mqgcd4ak53uz/ELa5YWh92JiXOzRcMEaY3j1MzAPc9hqg58eVEFMzBaoe33nR+DGU4wql/S9jF3q2Ca2V3mQB5j4NmS0FWPfZkYFofcSfiLPY0=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 03:54:29 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%8]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 03:54:29 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 4/9] cpufreq: amd_pstate: implement Pstate EPP support
 for the AMD processors
Thread-Topic: [PATCH v4 4/9] cpufreq: amd_pstate: implement Pstate EPP support
 for the AMD processors
Thread-Index: AQHY9S4t04xw1uXu4EeF40Ir2WbNL65DMCEAgADnVUA=
Date:   Fri, 18 Nov 2022 03:54:29 +0000
Message-ID: <DM4PR12MB5278668BD034D950AB7416AB9C099@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
 <20221110175847.3098728-5-Perry.Yuan@amd.com>
 <5db2e4b8-cff4-8aed-a3ac-e26d0668d996@amd.com>
In-Reply-To: <5db2e4b8-cff4-8aed-a3ac-e26d0668d996@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-18T03:54:26Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4e043e50-001d-42bd-b923-41744e5a096a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-18T03:54:26Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 64ff6c53-f9e9-4185-ad56-a5526ea4a8ff
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY5PR12MB6204:EE_
x-ms-office365-filtering-correlation-id: 908b9418-4c87-4599-9f34-08dac91897ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Km8Ctlc3vyB2iUtFPya1Xf0MeNCc7Rot/UcW4UvcIvKWgua5GDQm+hskYAH7bAl6MF8K+vrVeFliHn7IvyYlJQSnNuv/jh292dH0WFxtTy08DaUDgpJg4tJhor5iD8dBjwgIGJ45ysCZR/mExWwP4SgaNg4ITjFeL8itRx+zgtBuLNNmuy/qTUTJ6UL9MAKU+Bjfsp2AOHsPArXTwEVgyQzEEHD3HrqKerOTooeyWjOZ63du25bl9ffBTb4IuQlk6Yx8Uhx4EY/ephXGh0a7jlTVWEFJO30THPVcqADK9YAmruaU+5A0m+lKC6//DGAvkyqbpTlZSodiIjVz9np9J9o1n3kfUBI0LsQ6dXzkIKmmL+MYxaba24XNKqZzG01Myc8x4UWr/YaCYKh8evOGaOLKXb/bXnYz5H8+zM0VIvpWEL/FqlRedviJcitkmF+5wUOxAS2JrxCew9J1C5eey8nRwvh1HRPk6GFA7UAIiaJRc6cCEqsGJfAndJdGIe6GJ3/h4HI26cmo7w3U28pl2ohwgIZEuLIoPP53APKdu20GKJwOMO03JzOwVAnOZ+f6Yt1mFyMW616e/iRSTqGkAh0ELm0f0MD2/jVe1ETuTtNuxCp5b2yk0gqp9gFE08/IiwQ0PQYsX2UDGSxK3eYKQwh+grWdLNJ2lmNwDQP46Rwel4GtnZ4gJJzhqmhR/FFClsGYpucSc7H4ukPfBXEaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(33656002)(122000001)(38100700002)(316002)(86362001)(38070700005)(5660300002)(41300700001)(66946007)(8936002)(52536014)(64756008)(8676002)(66556008)(55016003)(54906003)(66476007)(66446008)(76116006)(4326008)(2906002)(186003)(71200400001)(478600001)(53546011)(26005)(110136005)(7696005)(6506007)(9686003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUpsSDhjTUNKd0dKMTFGQ1NyZU1EamNhSjkxbm5YYVFXcFA0a0FiZHN5alVk?=
 =?utf-8?B?WG5Henk5VW1NZnloRWNTN2t3R3p1ZERlb2ZXNUZiSGJqSHJ5K0JuOTRIeFFT?=
 =?utf-8?B?dE9zQllGbjI5dDh2OUhvQm93RXh4MHhPKzVEN1lzdTdzWU1FeGxrRTVaS0or?=
 =?utf-8?B?amYxVVgwR1Y0WjRyRmRPV3FhTkdGOUFCYUNsc0EycnBWb04vOHR0SXp4Q3lm?=
 =?utf-8?B?NWU1RzR4Sm9leXRqRVlLSG1rcTRyODZDZVRQaU5jMmpRVEJpbFhGNHZkU0h3?=
 =?utf-8?B?WGFvYWEvSUZwZ1VPVFIvcWl0dk5ndHJuZW9rRTFCTXhUdDI1dHpMcURiQ1hv?=
 =?utf-8?B?L3VtZ1VReWl5OExpL2Y4Q1lTaHNOMlMxNUVaOVVlbENmT2szNWN3WnFiMk1u?=
 =?utf-8?B?cktFc0Z4VDJIM2xWcHhGVnZvbHZ1VytDMmZvOWovRGJmZDNjVjg2S1gzZlZR?=
 =?utf-8?B?ZWliTnNSMkx5d0p1elQ4NFpOeHplOTdZbHF1d0lsR052VHYzMStHMUdqNVQ5?=
 =?utf-8?B?UDNtV1MySkl6cDVtLzR1SVNUSDRxSnBMVXo1Vld3V0lwbVZVekNiU3B2M2t2?=
 =?utf-8?B?T29kRmxUMXY2cWVlWnVqSU00ckNKZjRmTWRGU3hvc3lPTmRWWVVNZkVjQWN3?=
 =?utf-8?B?dnR6QU96bWhjdE4yQWpNR0puU0pHKzVoR3FFaDN4T05ld1EzUHZscm43elRL?=
 =?utf-8?B?MlZzUU1LSjR6ME9OU2FyNXQ5VEppQlNFWTNYc3dPYVpwcmJxRkcwQ1YwRTBG?=
 =?utf-8?B?L1hTWUJUZHNtVDkzYkJ3Tkk5WnhFbk12UXNWUUJzTG0rUng4eFBCU1QzbTVL?=
 =?utf-8?B?VTlDYVd1QnYxZFJpc1RUU0p0dWxOYUdWYk1VMXo1Nml3LzN3VUJFREZmelVp?=
 =?utf-8?B?eFdDbUIwajR1RExqY1RTeEQ5Y3pUQ0RVWkhHdkV3MFgrSHZjWEdwSWdCNCtw?=
 =?utf-8?B?Y2REY2xqZE1Qdlg0Nk9jNmxUVThzaEJlVCt6S2ZaWURJcVA2c1NsN3M3ODJF?=
 =?utf-8?B?ZVZJRnVwSUpxVENCdWR4N3FRUDF3Um9KbGY4dW9DRHp6enl0NTM2dEg2Ymc1?=
 =?utf-8?B?Ym55YTNPMy9NV2VZa3d0R2lNdWxGUGpyZXAraXlWK1N5L2VDclgzazdtbUxy?=
 =?utf-8?B?TGZLdXo5cUw0NWtSLzc5RlhYR3J2TFVPQUJVb3JEanowUkhIUU5JVGEzSDJO?=
 =?utf-8?B?bU1hMGtOTEdaSlVnMGFIb1BPSHgwMVJOUm5ZdklTUGRjOHR1a2c3Ym9tajRq?=
 =?utf-8?B?N2R4NFNjakczU3hpK1M3Q1RybjZQSzNWOGMxd0txemRjYmk1RUdpdzRFQkhI?=
 =?utf-8?B?R1FOUjhqeUQrYk9ubWJsQUh5SnZmQlkrRzB5ZXZxTFdKc0wrNThUVExwMjdB?=
 =?utf-8?B?Sm15SEpKdWRuZFNIQTBMTFZBUnZ0RlhJR2VLdWVCRG1wMUZqUWZSMWRqSFA0?=
 =?utf-8?B?RFkyT282N0Eya2R4dW1SYmxtWjRGaVMwWTdyck4vOGQyYzF4YkhpZ1dkV0hB?=
 =?utf-8?B?ZWhpSzVqNmFqcnM2V2NYLzc4OUVGUW42S21nM1NaZFFHS2N3VWxRLzlIY1Rj?=
 =?utf-8?B?VW1WSDFFV1BqRDdUK09UbUdPMEY2bzViOVJOT01QR3RvWXcveE0va1h6cGpG?=
 =?utf-8?B?dGJnR25kQ0gxZTBrWkQwTnNjd0F0NDdZUGVkRjVaVDMxYjR1Mll0aU5kaVF6?=
 =?utf-8?B?VDVIRUY0SlVIVVIzeGpNdFZqc3Vqd2Z1NHcxdjdSMHpzZ2tMT21xZjlmTWlq?=
 =?utf-8?B?bmFYV25Ya2JIVjRLT3BkdDhmajNrUncrL0tIOFJ4M1hRN0Z6bXR5bHpvUklh?=
 =?utf-8?B?WWV0cU5vQ0J6NmNTNE5wWmR5WjhNd2gvYnBGSncwcVYvWU51YzMzRUVDVUxS?=
 =?utf-8?B?SktCK3hSTVhpM3M5eHVBU1c3bFp1MUFWa3czWTh2NEZ5ZUNBQkZXL2I2bzNS?=
 =?utf-8?B?a0p1MUxRdENNY0xqNzhTWVdxL3pxRkhCZVhhRmRjN012WkkzaCtoT013OHc0?=
 =?utf-8?B?VUdTR0M2cHdVQ2F5OGxZQzl5ajI0TTNMZnpvZTVVWk1vaDRnUXJvWnd4Ky9Z?=
 =?utf-8?B?VG0vK3kwdjBVREd4Y1ZLZ2EzSUVjYXp2V1VINktUWmhiaWsyWXlnamZ0dHA2?=
 =?utf-8?Q?DR0THyxprZ7L2XZocamY8rXQy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908b9418-4c87-4599-9f34-08dac91897ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 03:54:29.1364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqB9XpgYtg3H/OWN9c1/953H/sJ0jdB7cyyfLaJESKMsWgaJ5O7ajlK59Nx4BVK1V3UB1llAENKtgSsS7AVkYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEthcm55LCBXeWVzIDxXeWVzLkthcm55QGFtZC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxNywgMjAyMiAxMDowMyBQTQ0KPiBUbzogWXVhbiwg
UGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tOw0K
PiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBIdWFuZywg
UmF5DQo+IDxSYXkuSHVhbmdAYW1kLmNvbT47IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnDQo+IENj
OiBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPjsgRm9udGVub3QsIE5hdGhh
bg0KPiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFu
Z0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywgTGkN
Cj4gKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY0IDQvOV0gY3B1ZnJlcTogYW1kX3BzdGF0ZTogaW1wbGVtZW50IFBzdGF0ZSBFUFAgc3VwcG9y
dA0KPiBmb3IgdGhlIEFNRCBwcm9jZXNzb3JzDQo+IA0KPiBIaSBQZXJyeSwNCj4gDQo+IE9uIDEx
LzEwLzIwMjIgMTE6MjggUE0sIFBlcnJ5IFl1YW4gd3JvdGU6DQo+IFtzbmlwXQ0KPiA+ICsNCj4g
PiArc3RhdGljIHNzaXplX3Qgc3RvcmVfZW5lcmd5X3BlcmZvcm1hbmNlX3ByZWZlcmVuY2UoDQo+
ID4gKwkJc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3ksIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6
ZV90IGNvdW50KSB7DQo+ID4gKwlzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEgPSBwb2xpY3kt
PmRyaXZlcl9kYXRhOw0KPiA+ICsJY2hhciBzdHJfcHJlZmVyZW5jZVsyMV07DQo+ID4gKwlzc2l6
ZV90IHJldDsNCj4gPiArCXUzMiBlcHAgPSAwOw0KPiANCj4gSGVyZSBgZXBwYCBpcyBhIHVudXNl
ZCB2YXJpYWJsZS4NCj4gIFtzbmlwXQ0KPiA+IEBAIC02NTcsNiArMTI4MSwyMCBAQCBzdGF0aWMg
aW50IF9faW5pdCBhbWRfcHN0YXRlX3BhcmFtKGNoYXIgKnN0cikNCj4gPiAgCWlmICghc3RyKQ0K
PiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gKwkvKg0KPiA+ICsJICogRGlzYWJsZSBh
bWQtcHN0YXRlIGRyaXZlciBieSBkZWZhdWx0IGZvciBub3cNCj4gPiArCSAqIGFwcGVuZCBhbWQt
cHN0YXRlPWFjdGl2ZSBvciBhbWQtcHN0YXRlPWFjdGl2ZQ0KPiA+ICsJICogdG8gZW5hYmxlIGRy
aXZlciBsb2FkZWQNCj4gPiArCSAqLw0KPiA+ICsJaWYgKCFzdHJjbXAoc3RyLCAiYWN0aXZlIikp
IHsNCj4gPiArCQljcHBjX2xvYWQgPSAxOw0KPiA+ICsJCWRlZmF1bHRfcHN0YXRlX2RyaXZlciA9
ICZhbWRfcHN0YXRlX2VwcF9kcml2ZXI7DQo+ID4gKwl9IGVsc2UgaWYgKCFzdHJjbXAoc3RyLCAi
cGFzc2l2ZSIpKSB7DQo+ID4gKwkJZXBwX29mZiA9IDE7DQo+ID4gKwkJY3BwY19sb2FkID0gMTsN
Cj4gPiArCQlkZWZhdWx0X3BzdGF0ZV9kcml2ZXIgPSAmYW1kX3BzdGF0ZV9kcml2ZXI7DQo+ID4g
Kwl9DQo+ID4gKw0KPiA+ICAJLyoNCj4gPiAgCSAqIHN1cHBvcnQgc2hhcmVkIG1lbW9yeSB0eXBl
IENQUEMgd2hpY2ggaGFzIG5vIE1TUiBmdW5jdGlvbi4NCj4gPiAgCSAqIGVuYWJsZSBhbWQtcHN0
YXRlIG9uIHByb2Nlc3NvcnMgd2l0aCBzaGFyZWQgbWVtb3J5IHNvbHV0aW9uDQo+IA0KPiBJbiB0
aGUgc2hhcmVkIG1lbW9yeSBzdXBwb3J0IHNlY3Rpb24gYWxzbyBgY3BwY19sb2FkYCBoYXMgdG8g
YmUgc2V0IG90aGVyd2lzZQ0KPiBhbWRfcHN0YXRlPWxlZ2FjeV9jcHBjIHdpbGwgbm90IHdvcmsu
DQpJZiB0aGUgcGF0Y2hlcyBqdXN0IGdvdCByZXZpZXdlZCBhcmUgYWNjZXB0ZWQsIHRoZSBsZWdh
Y3lfY3BwY2Mgd2lsbCBub3QgYmUgbmVlZGVkIGFueSBtb3JlLg0KSSAgd2lsbCByZWJhc2UgdGhl
IEVQUCBwYXRjaGVzIGJhc2VkIG9uIHRoZSB0aGF0LiANCg0KDQo+IA0KPiBpZiAoIXN0cmNtcChz
dHIsICJsZWdhY3lfY3BwYyIpKSB7DQo+IAlzaGFyZWRfbWVtID0gdHJ1ZTsNCj4gCWNwcGNfbG9h
ZCA9IDE7DQo+IH0NCg0KUHJldmlvdXMgcGxhbiB3YXMgdG8gYWRkIHR3byBwYXJhbWV0ZXJzIHRv
IGtlcm5lbCBjb21tYW5kIGxpbmUsIA0KcGFzc2l2ZSBvciBhY3RpdmUgIGFuZCBsZWdhY3lfY3Bw
YyBmb3Igc2hhcmVkIG1lbW9yeSBwbGF0Zm9ybS4NCg0KPiANCj4gDQo+IC0tDQo+IFRoYW5rcyAm
IFJlZ2FyZHMsDQo+IFd5ZXMNCg0K
