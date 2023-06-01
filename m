Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9915A71EFC4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjFAQyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjFAQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:54:04 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA3C18D;
        Thu,  1 Jun 2023 09:54:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP9YWG6J0IGwNp/19Dqpu/hwVVXNob/6VY52rvdLlfKkByUgOYBmCj8Co2itc5LCUXsH+O5s4jmN3FreSq+Zi1KzyVnuQzNEuPw89SXLkmllaDjPODzaTaVA+khNq9SVvR2DT9Owwc/RgXGh74cZlu8LbA2yboTBtt1/PYsNBu/1G/ZdHsP1gNX+/gpaRRGYwOI5DwPNidIa6TEXe2n0TfGdkRY+S/xcSOFyJ4A6QK9CHZKgVgjmU9z0wpvR1C7JJaqHXffKK9Rbb6AAIH7WPzFpieB41Sy6w4vimnJoy8TzpfRjLdLXOaldNvx4YaFGokEPkqIj57hhFw9zQK/q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIasVwxQWQ0O5b43CWP6YBDfWWHvqgZdNxdXw20FLrI=;
 b=gL44dYBUglGyye7hUJJlmZZM/Fh0zWSdjbFRmJS0JwarDBqbsTdHv1Vmx7iOF9+EYuNL07si/sSSl7Dslm+2lpFRXty8MJHgkFGNKgAoK54h5sq0/fsbqLYs2Lyy5iw0XEzkIlS/oGTHHe66GLICo4uFm1DGaMt7xR8GJDxywVWbRGaFVd99Bzrx2hVa5lh3/+sMM9pj9k5s+x2vbGO11fwvPoqikJELuIXl/NfyR4xPmcgrxTDHzyNoRQ/VVpylKzClOpnmNnszSsWOpHyRyjJk5cTyjw3PCJeQrx4r7cmhp7x3Uo8/xMq5A5LSHPyRoSZ4kicLqi0OL6rEasVtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIasVwxQWQ0O5b43CWP6YBDfWWHvqgZdNxdXw20FLrI=;
 b=M+XVSAu1jBldXvjhpO0eEssbQNR3UWGfRZ972j0KDINM/o/gG380d20p7b2oYk4bQkpfo3F2NzDdlhr+qdjIbTltTRiCr/vHq7o4/AZvVe0IXkoJgWoFNCzqc6MowaYVtFrAuAmfoli8SnPtYkc06YKwK28c/+fuviBBIriygMc=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.25; Thu, 1 Jun
 2023 16:54:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 16:54:00 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Karol Herbst <kherbst@redhat.com>
CC:     Nick Hastings <nicholaschastings@gmail.com>,
        Lyude Paul <lyude@redhat.com>, Lukas Wunner <lukas@wunner.de>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "1036530@bugs.debian.org" <1036530@bugs.debian.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI string"?
 (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Thread-Topic: Regression from "ACPI: OSI: Remove Linux-Dell-Video _OSI
 string"? (was: Re: Bug#1036530: linux-signed-amd64: Hard lock up of system)
Thread-Index: AQHZkTCTXT9qiOm+i06x7G4cHp2/pq9vocuAgADMgQCAAAUmAIAAK9qAgAFBYoCAAFNkgIAAMowAgAKppoCAARahAIAABDeAgAAETGA=
Date:   Thu, 1 Jun 2023 16:54:00 +0000
Message-ID: <MN0PR12MB61017541F5AC55485A490BCDE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <168471337231.1913606.15905047692536779158.reportbug@xps>
 <ZHKrC4/G6ZyvRReI@xps> <ZHL5cCNUzVdleiag@eldamar.lan>
 <ab12984e-be17-903d-ba0a-f9c85b8c544f@amd.com> <ZHP4IqxBUPuVRvRV@xps>
 <09e24386-de63-e9e9-9e7f-5d04bad62d83@amd.com> <ZHQhPcKUF76Kplwm@xps>
 <ZHUt9xQKCwCflvVC@xps> <8537d965-ddf4-7f45-6459-d5acf520376e@amd.com>
 <ZHWfMBeAONerAJmd@xps> <ZHfa/wQlaVCeUC22@xps>
 <fe0ab1fa-6ed6-dc64-8165-8fc70669317b@amd.com>
 <CACO55tsuO1kQUFfPdPFUHm4WEQseCR2tQSDhFRzR+8wOECZCyA@mail.gmail.com>
In-Reply-To: <CACO55tsuO1kQUFfPdPFUHm4WEQseCR2tQSDhFRzR+8wOECZCyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f587c8f7-a3d5-41ef-a334-6b18f894b0fb;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-01T16:48:29Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SN7PR12MB7787:EE_
x-ms-office365-filtering-correlation-id: f9b8e9e1-befe-4802-2c26-08db62c0cc67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0V9sa6fMntep94rBmAplCyMtymF1Ug25oOwLMemnY7GcYDt+xVr8KvMv1IKSD9L6d2MmYt5zlc/DEGxLr6KDxvxR+S8VEQM9h5imaHM77/OyyiJGR7EtD6qZ5qVSM3I8r2yvTDSZESdJxYMQ6xQTVEttExzZ7hy8mqmGUDhslbc91AKSLTuFuNIwSnkuFtXDXbDpfeu1rKKYFpEUfEH9zHLat5j4nIlu/c4dT+5iw31A1BYiJaKFVtc9wEg/s4D2xfugLFO6nrrBCEWNcZvRrGT9pPbiF47VWfe/7JdUlpjjCfqPies123NSsHNprCuWFBTwZQqsoryaB0rsQcKJ4jYdHdm2HVdmeo9RzCivbYEIWr9dbjRpmdhi9gpXP1QZ4CEuOtIUtXZ9kDXWvzD4xd3RbamIIQ3MpxQ7yHucwlZfg2L/U9Y7BozAj17fuRiwoKXvxvlJQyjb6bHw4AdPKT8TSc0hezRmbkxvUJp0VFeEH2prGYrzwHH5ltpqGZjaCLuk/Wh0jokpISIcXTfcf29oavXGRUUnWjV5ee5BI6locUI96dQVY2EqYFC8o4aBbITDThuXsqSZ5jRwfj0hQCE3heOG77TfkoY5L1lTmBA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199021)(122000001)(76116006)(64756008)(7416002)(66446008)(8936002)(6916009)(2906002)(8676002)(66476007)(66556008)(52536014)(4326008)(316002)(41300700001)(66946007)(54906003)(5660300002)(478600001)(71200400001)(7696005)(966005)(6506007)(186003)(53546011)(9686003)(83380400001)(33656002)(55016003)(26005)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlBueUNza3B2RTdXd0VFREl6R0dXdFA4NkpVbXBrZTdpVGNzcE13NzEyTmRT?=
 =?utf-8?B?NWg1aTBPbWxZdm9oQ05Jd2hiZTlmcFVuek1CZ3BOS0tjNU9MTGI2VERKZW56?=
 =?utf-8?B?dlFlMTRsSUpONXVJdml6bElWSFE5NytMRG9qckUybWh0ZXdSMTVabTUvT3ls?=
 =?utf-8?B?TWdjclpZUFF4QVNzaTZaWk82SWpkL2NRUHRSZWdiUTMxZGU0STJxdVd3VER5?=
 =?utf-8?B?UnFWZmJsK2o5eU1FYTVEcSsrTjVIQWJyZ3VwQ0ZRL0FBckFSb0ZkZkp0RUMw?=
 =?utf-8?B?MnBCNUFsOFZzaTZ3bkFsNTdDZ0htSWVadUFrcGtGV013bjBIY1dmaTVvYWlm?=
 =?utf-8?B?WkorS0VoM2Z2N0l0OHhSSWFRNUhBWCtqN2ZVSVg3OEZuK2xmWEE5bW9ZcjJB?=
 =?utf-8?B?NVVzSFpnZDVxSkRwTFlsUnh3bitkSjI3dFgrdWtGNHhwOG9JVWoyRXpsenRI?=
 =?utf-8?B?ODNsN25MYjFxL1FlTklsbnBGYjVLM0ZDeEJUVUZNNjdWeWtldzFZNkRQaG5U?=
 =?utf-8?B?Sms5a0MxUlBLUVpMdjFkTUhxN0Zpd25pREdyV2F3UkZZMUsxRmd4cGN6M3M5?=
 =?utf-8?B?SG0wdlZ1bE9TczB1WmM2VFljUEdGOUJ1TGRWUWlCQkdFYzJvOENUN2dyYjFj?=
 =?utf-8?B?S2lEWmg4RndUZmJmN3FQd3pIN2ZJUDhWT043Z2V5SHc5UDc1ZC9MWE9YQkVi?=
 =?utf-8?B?TWl4eFNROHlkektrcFB6Mkw5dDNpVndxZExSendHMCtqZ2R4dlRETldoYk1l?=
 =?utf-8?B?UWJxWkxoblpTMEdFa1BOS00yUWJQY0dOMkc2OExqMlVYUjluTTlSeHUxdWR6?=
 =?utf-8?B?QUJPSzVIdlpQOEM4RVFHRkRoemxrZXF2VFowQmFRcFVuQmpPbVcrRWZQMHNI?=
 =?utf-8?B?UjJ2NjFVNWQyMlBhWVA1Qk9QYzRReVZHeU5pMVlHWWtVRzc0cGF3WnpXWHAv?=
 =?utf-8?B?Z0lRQ2hDOGVIZ045L00wY1QrUFJuZklJTS93TytUTU5CYUUxUGI1NzI4REVs?=
 =?utf-8?B?RW1PQ1g5K0J0aXErdmg2YlFpd3NYZFRRMmlGeWU0Uno2eldITXBHRVdROHRC?=
 =?utf-8?B?U0t5TklWRXRteGFRUGtLRTdmYS9rS09UR3RWQXVJL2tXenRBQmxDcktLejBk?=
 =?utf-8?B?OXZGM21CbDhZeW1CclNTNXoyZzZXTHhlUmttZGlqN0laME1jbE5nVmMwejBj?=
 =?utf-8?B?TmJGdnNna0ZUYmdwdGV4MFZja3ozeHJqcERja0ZCTWdBVzcxZ3RNYmpXT2NF?=
 =?utf-8?B?WUl2MXRTSFVwMDh1M2lkNy93d01GU1A0SGVDU3JtOXJWc0J2SFFmZUFhRm9T?=
 =?utf-8?B?cURtTDNvVU9oVmxobEcwM0l5TTBGaDVMblluOE5lakVhb3QraTY3N0d1S2R0?=
 =?utf-8?B?T0trY25kSVJWRlVGYkh0R0g0WG1jVy9LMFNCbWRPTUFmRCtaWm9ZcEhQYUtB?=
 =?utf-8?B?by95aTlkekZ1OERKMHBiWm1RYnFpSjdOMHZyTjcvNjVHSnFxYzhkWTF6akFJ?=
 =?utf-8?B?SGlnUmRjUnAvVkJHNGFXTEFJUFRNNHZIVEp3UEpTWno0SVZHbzdsRWpPVnpS?=
 =?utf-8?B?NUV0V1BwTEhZRkFsRDRDZjhxNGNab25jejZaOXM4MkJHUzJsZE9YQ2UrZHFP?=
 =?utf-8?B?ZzNjS0ZLMzhyNVFjczdOdnQ1WkFpZ3hwbE1HbGNVSEZtNUpSZkc2M3BaZnRm?=
 =?utf-8?B?UXNJWkZZZGNvQm5wVGowTGRXZ1BuNFFtMU5YRkR1MzZIU0RNRDd6aVFqQ3Fu?=
 =?utf-8?B?RWQ1ditQU29RM0xZejZmM3RoUUhwOGIvTTQ4aXdUbmZuQksvVkxlQnRReDRn?=
 =?utf-8?B?aUlQNGExWlNUaUZRYUlWWXBBeVhoSmY4T2RnZyttMWVHZ095SzY5b2s3bjFP?=
 =?utf-8?B?R09kSUVXYlk2d0V5ZkpHdVVKTXdjTWlmL2RJdVFTUS8yaVNwL2hIOVpmTWQw?=
 =?utf-8?B?MzhHdVlqNGpsdG5sZXhscDBLSGw5K3AzcDk1aHp1UUdaRWN4dytjbko1RlZa?=
 =?utf-8?B?bTBUdURrSFpXNHZITkNnMEFZSWpXU3ovdGdWNnl6aDc5bDE3Y3lCd2JVUkNz?=
 =?utf-8?B?NVpCM2R5VlA5bko3SmlJWU5HRHlZbkVsSHpNeHZmcXhTNUsyUytKN05NaXdw?=
 =?utf-8?Q?pIw4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b8e9e1-befe-4802-2c26-08db62c0cc67
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 16:54:00.5535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPtqE2J+xBGKFoRI8KS1uw/qo3C6NfqCdjz9uoUUNi2zcNG+f9FI6pM6KvB9hxSCLKYNjhubP2j7tuMD3cerYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS2Fyb2wgSGVyYnN0IDxraGVyYnN0QHJlZGhhdC5jb20+DQo+IFNl
bnQ6IFRodXJzZGF5LCBKdW5lIDEsIDIwMjMgMTE6MzMgQU0NCj4gVG86IExpbW9uY2llbGxvLCBN
YXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IE5pY2sgSGFzdGluZ3MgPG5p
Y2hvbGFzY2hhc3RpbmdzQGdtYWlsLmNvbT47IEx5dWRlIFBhdWwNCj4gPGx5dWRlQHJlZGhhdC5j
b20+OyBMdWthcyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT47IFNhbHZhdG9yZQ0KPiBCb25hY2Nv
cnNvIDxjYXJuaWxAZGViaWFuLm9yZz47IDEwMzY1MzBAYnVncy5kZWJpYW4ub3JnOyBSYWZhZWwg
Si4NCj4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBMZW4gQnJvd24gPGxlbmJAa2VybmVs
Lm9yZz47IGxpbnV4LQ0KPiBhY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gcmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJl
OiBSZWdyZXNzaW9uIGZyb20gIkFDUEk6IE9TSTogUmVtb3ZlIExpbnV4LURlbGwtVmlkZW8gX09T
SQ0KPiBzdHJpbmciPyAod2FzOiBSZTogQnVnIzEwMzY1MzA6IGxpbnV4LXNpZ25lZC1hbWQ2NDog
SGFyZCBsb2NrIHVwIG9mIHN5c3RlbSkNCj4NCj4gT24gVGh1LCBKdW4gMSwgMjAyMyBhdCA2OjE4
4oCvUE0gTGltb25jaWVsbG8sIE1hcmlvDQo+IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3
cm90ZToNCj4gPg0KPiA+ICtMeXVkZSwgTHVrYXMsIEthcm9sDQo+ID4NCj4gPiBPbiA1LzMxLzIw
MjMgNjo0MCBQTSwgTmljayBIYXN0aW5ncyB3cm90ZToNCj4gPiA+IEhpLA0KPiA+ID4NCj4gPiA+
ICogTmljayBIYXN0aW5ncyA8bmljaG9sYXNjaGFzdGluZ3NAZ21haWwuY29tPiBbMjMwNTMwIDE2
OjAxXToNCj4gPiA+PiAqIE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQu
Y29tPiBbMjMwNTMwIDEzOjAwXToNCj4gPiA+IDxzbmlwPg0KPiA+ID4+PiBBcyB5b3UncmUgYWN0
dWFsbHkgbG9hZGluZyBub3V2ZWF1LCBjYW4geW91IHBsZWFzZSB0cnkNCj4gbm91dmVhdS5ydW5w
bT0wIG9uDQo+ID4gPj4+IHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lPw0KPiA+ID4+IEknbSBub3Qg
aW50ZW50aW9uYWxseSBsb2FkaW5nIGl0LiBUaGlzIG1hY2hpbmUgYWxzbyBoYXMgaW50ZWwgZ3Jh
cGhpY3MNCj4gPiA+PiB3aGljaCBpcyB3aGF0IEkgcHJlZmVyLiBDaGVja2luZyBteQ0KPiA+ID4+
IC9ldGMvbW9kcHJvYmUuZC9ibGFja2xpc3QtbnZpZGlhLW5vdXZlYXUuY29uZg0KPiA+ID4+IEkg
c2VlOg0KPiA+ID4+DQo+ID4gPj4gYmxhY2tsaXN0IG52aWRpYQ0KPiA+ID4+IGJsYWNrbGlzdCBu
dmlkaWEtZHJtDQo+ID4gPj4gYmxhY2tsaXN0IG52aWRpYS1tb2Rlc2V0DQo+ID4gPj4gYmxhY2ts
aXN0IG52aWRpYS11dm0NCj4gPiA+PiBibGFja2xpc3QgaXBtaV9tc2doYW5kbGVyDQo+ID4gPj4g
YmxhY2tsaXN0IGlwbWlfZGV2aW50Zg0KPiA+ID4+DQo+ID4gPj4gU28gSSB0aG91Z2h0IEkgaGFk
IGJsYWNrbGlzdGVkIGl0IGJ1dCBpdCBzZWVtcyBJIGRpZCBub3QuIFNpbmNlIEkgZG8gbm90DQo+
ID4gPj4gd2FudCB0byB1c2UgaXQgbWF5YmUgaXQgaXMgYmV0dGVyIHRvIGNoZWNrIGlmIHRoZSBs
b2NrIHVwIG9jY3VycyB3aXRoDQo+ID4gPj4gbm91dmVhdSBibGFja2xpc3RlZC4gSSB3aWxsIHRy
eSB0aGF0IG5vdy4NCj4gPiA+IEkgYmxhY2tsaXN0ZWQgbm91dmVhdSBhbmQgYm9vdGVkIGludG8g
YSA2LjEga2VybmVsOg0KPiA+ID4gJSB1bmFtZSAtYQ0KPiA+ID4gTGludXggeHBzIDYuMS4wLTkt
YW1kNjQgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBEZWJpYW4gNi4xLjI3LTENCj4gKDIwMjMtMDUt
MDgpIHg4Nl82NCBHTlUvTGludXgNCj4gPiA+DQo+ID4gPiBJdCBoYXMgYmVlbiBydW5uaW5nIHdp
dGhvdXQgcHJvYmxlbXMgZm9yIG5lYXJseSB0d28gZGF5cyBub3c6DQo+ID4gPiAlIHVwdGltZQ0K
PiA+ID4gICAwODozNDo0OCB1cCAxIGRheSwgMTY6MjIsICAyIHVzZXJzLCAgbG9hZCBhdmVyYWdl
OiAxLjMzLCAxLjI2LCAxLjI3DQo+ID4gPg0KPiA+ID4gUmVnYXJkcywNCj4gPiA+DQo+ID4gPiBO
aWNrLg0KPiA+DQo+ID4gVGhhbmtzLCB0aGF0IG1ha2VzIGEgbG90IG1vcmUgc2Vuc2Ugbm93Lg0K
PiA+DQo+ID4gTmljaywgQ2FuIHlvdSBwbGVhc2UgdGVzdCBpZiBub3V2ZWF1IHdvcmtzIHdpdGgg
cnVudGltZSBQTSBpbiB0aGUNCj4gPiBsYXRlc3QgNi40LXJjPw0KPiA+DQo+ID4gSWYgaXQgd29y
a3MgaW4gNi40LXJjLCB0aGVyZSBhcmUgcHJvYmFibHkgbm91dmVhdSBjb21taXRzIHRoYXQgbmVl
ZA0KPiA+IHRvIGJlIGJhY2twb3J0ZWQgdG8gNi4xIExUUy4NCj4gPg0KPiA+IElmIGl0J3Mgc3Rp
bGwgYnJva2VuIGluIDYuNC1yYywgSSBiZWxpZXZlIHlvdSBzaG91bGQgZmlsZSBhIGJ1ZzoNCj4g
Pg0KPiA+IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vbm91dmVhdS8NCj4gPg0K
PiA+DQo+ID4gTHl1ZGUsIEx1a2FzLCBLYXJvbA0KPiA+DQo+ID4gVGhpcyB0aHJlYWQgaXMgaW4g
cmVsYXRpb24gdG8gdGhpcyBjb21taXQ6DQo+ID4NCj4gPiAyNDg2NzUxNmYwNmQgKCJBQ1BJOiBP
U0k6IFJlbW92ZSBMaW51eC1EZWxsLVZpZGVvIF9PU0kgc3RyaW5nIikNCj4gPg0KPiA+IE5pY2sg
aGFzIGZvdW5kIHRoYXQgcnVudGltZSBQTSBpcyAqbm90KiB3b3JraW5nIGZvciBub3V2ZWF1Lg0K
PiA+DQo+DQo+IGtlZXAgaW4gbWluZCB3ZSBoYXZlIGEgbGlzdCBvZiBQQ0llIGNvbnRyb2xsZXJz
IHdoZXJlIHdlIGFwcGx5IGENCj4gd29ya2Fyb3VuZDoNCj4gaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvZHJpdmVy
cw0KPiAvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfZHJtLmM/aD12Ni40LXJjNCNuNjgyDQo+DQo+
IEFuZCBJIHN1c3BlY3QgdGhlcmUgbWlnaHQgYmUgb25lIG9yIHR3byBtb3JlIElEcyB3ZSdsbCBo
YXZlIHRvIGFkZA0KPiB0aGVyZS4gRG8gd2UgaGF2ZSBhbnkgbG9ncz8NCg0KVGhlcmUncyBzb21l
IGFyY2hpdmVkIG9udG8gdGhlIGRpc3RybyBidWcuICBTZWFyY2ggdGhpcyBwYWdlIGZvciAiam91
cm5hbGN0bC5sb2cuZ3oiDQpodHRwczovL2J1Z3MuZGViaWFuLm9yZy9jZ2ktYmluL2J1Z3JlcG9y
dC5jZ2k/YnVnPTEwMzY1MzANCg0KPiBBbmQgY291bGQgYW55Ym9keSB0ZXN0IGlmIGFkZGluZyB0
aGUNCj4gY29udHJvbGxlciBpbiBwbGF5IGhlcmUgZG9lcyByZXNvbHZlIHRoZSBwcm9ibGVtPw0K
Pg0KPiA+IElmIHlvdSByZWNhbGwgd2UgZGlkIDI0ODY3NTE2ZjA2ZCBiZWNhdXNlIDU3NzViODQz
YTYxOSB3YXMNCj4gPiBzdXBwb3NlZCB0byBoYXZlIGZpeGVkIGl0Lg0KPiA+DQoNCg==
