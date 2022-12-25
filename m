Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE282655DC5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiLYQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiLYQlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:41:51 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4401F5;
        Sun, 25 Dec 2022 08:41:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDpgAC9J2hceLe/RPfZHIk/h/HYEPa+BuvIpSqd3vWWUp6TYPgPYNiIXIW2R2AvsPTOop8Pei8R4I9Sjduq7u8sCOxzsC7tDPaZ1ZScR0SZx42sW+S6Osp/Aa45yKkbTg//XpHJPZyivkIHu3BvkNoTGCC5elS0HxMXhxVtrMybreVMa7fJ2E5XUIR7pW2nJtVqrisoBZV2k99Mkd4RF0jP8EvrTxhH7z97HA6BrIQwa/z7Gl+y8sSJlO9X1qnCpttMOzcvx5cRoyErV2WgaaL+466jcruT85YsLq0INLN8O3ybOWeekFCnnsbyKspDsV9QSKsidTrbfFmi18x9W3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6ZIleJy4LZ5UDGfxa6z7E7PGKi6GRNJuorWrzuTG/s=;
 b=PAtPxzI3P1pPq1As2UEOWfUEY+QOkWSPcX7Ke4+9qD413baJCSmP/fg6PhPk7sag/BU6pt9bmHccEIWJGhXUL2D7AE6EFe3RZRkuKU/gXwCHYc3u6w0baBLC0vi7tskukn60oCFIfC147jUOTjyZB8wc3DecU5IDX6jlkTLXijaqjv4TccECWM/2XRQOn8v18bXupsXInNSPOf0JTZvPRvgJ5+/aAjdtnnFVHLEHWqU/KN2RZyBzk5jiohliExt3VYA1rsfm3tEA9ajpCii/rES8zoEn4/UJ8YBmqhSVOocBBw6F7r6NwXWTY9YkKFZ1BbikoOO7H9AOTxXsh0+g9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6ZIleJy4LZ5UDGfxa6z7E7PGKi6GRNJuorWrzuTG/s=;
 b=NZTPEmpaLaugLovRpCwxlRkprMLbWYa6nDadyPyJd5SlztAPqesic+vgCQ8jCkK3ko0M4uDgLfcwAcBWp4HrF+qSxKPIZsLCCDx0mkb48IG/sBK0pigxg87Id47iPC5Vq3vF7KogPJjlWHcfK9M1e/6OXHGXDbfOkx43iCCB2+s=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.14; Sun, 25 Dec
 2022 16:41:49 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%9]) with mapi id 15.20.5944.015; Sun, 25 Dec 2022
 16:41:49 +0000
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
Subject: RE: [PATCH v8 05/13] cpufreq: amd-pstate: optimize driver working
 mode selection in amd_pstate_param()
Thread-Topic: [PATCH v8 05/13] cpufreq: amd-pstate: optimize driver working
 mode selection in amd_pstate_param()
Thread-Index: AQHZE3TxL3bokS986U2fruy1nJROBK57P6aAgAOXW4A=
Date:   Sun, 25 Dec 2022 16:41:49 +0000
Message-ID: <DM4PR12MB52787CD610133B0978D3B2BB9CEF9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-6-perry.yuan@amd.com>
 <bce86f79-9757-530b-b34e-1d2a71281e75@amd.com>
In-Reply-To: <bce86f79-9757-530b-b34e-1d2a71281e75@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-25T16:36:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=22567707-3674-4e47-abc3-a557a784487b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-25T16:36:54Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: bb4c2c29-2acb-4a9b-a13a-f4c947bb0d28
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CH2PR12MB4860:EE_
x-ms-office365-filtering-correlation-id: 54675815-ccd8-4d08-07c1-08dae696eb53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N/G+tdriqxS/wYKdZGQdkcM7BwPyMpKr5MaTOHDwvsWANzyjq4LnMXgKnKTnF5MExvPrrb1xpClina1eOpS5j2es3AUUzQH5uq86obHMOPfkp4ZQwJMgEgzocUnm/oFMVYwT2oNk/eFHqnlt0i8ReYx6ipTIIyfTZ2GCWmjnZ4OAdXOVSoyI173bWue1QGL9/oJexztgJ/FcJr/2prXdbpV/E1JoLgM1AnQErTGQaaiNUwPZ7Q4hVM0mN3gZUp1+wgc/ZMFi3f4jjrK3Bj5LAbJPCl7ZdEAgDttAeVT89BNNSwOcxSr3GQ4mpT74zNrBw4pi/PkwmqPYWPwkRQs9Bri6wfOKm0+F76Pk5Yi6EpNUrFvm51W7Yj8k2LR8KJ4fod2pddiAufRD7enVAN7kNazP+pGPeQgQ5pJjoo3d0xyYI8bclLVY2zLFkFBQ9fkZj/il1lSLEETjftzkRgp6RTsYDUmM5l1CxnNzLvNeV+oyooOvfntghN6pT0zH6+7VRQoJNevod2nPXC38U34P1yWueY4ewgOFDsHDU3Ch4NE+3TrowAdgJN1ihGguO2nDEyv9aMDqNuGcgN3rIO3FkwewVrIF6fpqoianDXmp+JY4T63o8dKWrq5lAKULTCV6uWHQTDMkLQor/xrEHZIJEXIxtQOaIr0PoFuxKDO7xQps/+cq8MF3E5IlYv291f1sdyyhhsy0w7S/8T1fasPAuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(83380400001)(2906002)(54906003)(33656002)(110136005)(316002)(38070700005)(26005)(478600001)(9686003)(186003)(53546011)(122000001)(38100700002)(7696005)(6506007)(71200400001)(86362001)(55016003)(4326008)(66476007)(8676002)(66556008)(64756008)(52536014)(66446008)(8936002)(41300700001)(76116006)(66946007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnRzSlBYWHMwL3RvdjZHQmJZMHh0eDAzWXVOaTYxYzZudW5pL2lORDdKOUVk?=
 =?utf-8?B?U1k2ZHRhMy90WnJDbkZ1QzJiK0tBaU1aOGR0Wm5obmVWT3I0NlBzUTIzVXht?=
 =?utf-8?B?WitXZ1dqbmp5WXF2TGpjNmI2ajVKNkFrU3NOams2LytSMXZWU2lia3BjV3Yy?=
 =?utf-8?B?eWFkOUkyYkFJdGlxdkJRQ3R6Qlo4My9uN1FHRDJKdDczTkczLzYzalhzQU5J?=
 =?utf-8?B?NkRpYTVRaDlSVWM0WnIzaTk5Y1BweEljR2laMzlhbUt0SzFvemcxQUJxYXVj?=
 =?utf-8?B?amphaEJ3cnNZWDNhWnFVcUcvdVlrV2U1b3Vyb1JDK2FOeUh6eFlFbUcwTHVE?=
 =?utf-8?B?L0ZSSmUxZWMwWjFmd2NYdVhNMzM5L3B2dVBuVzFWNVNxOEZlRGxjWGNkQ0Ev?=
 =?utf-8?B?SU5BZ01vTGVoUzhrYXg1T2xCMDJBc3BMYWx3ZVRtTW1ab0hoSTlLZGYxelRo?=
 =?utf-8?B?QnNZYW1HeDl3YmRoSnlaSkRmRXRnU28vdmp4cTJhb3FnNVlRTDBENkJVRGR2?=
 =?utf-8?B?QWltTzR6RGlYZ1dkSjQzWHJrc1A4My91bXJUMmI0M0xaUmRYN1ZXdDZtc256?=
 =?utf-8?B?THgyYTN5QUdYdWJaNHlubzMrMWNHODhYb2ZLRkhFU1Y4YW5sUTRhSzZxKzlE?=
 =?utf-8?B?YnprWWJWcmFnNzRTeFNRQXlzREk3MW9CL2FTVlZoY0IyNUZnLzgvZWpjYVBw?=
 =?utf-8?B?TlJBVS9hTmxXenlCSWo4Q0ZaV3lKYW1LYjhMWVZETy9RNytseFE5RlpUdHFO?=
 =?utf-8?B?V2tSS2t3K0FmSHIra1MvcVA1RVJJcUMvYlVtbnBneUhVd1RVaG85bk1PRVlB?=
 =?utf-8?B?VG5mTEFQakpja0dldkVSWEJsZ0dpeFVQWjlIV0F3eHZNYjZpemFyUkpVS09p?=
 =?utf-8?B?VnFSMm9tNkdoamxxcWQxSHY1STR3V3B6YTFpNTIrekZWZnFSSEVacEpjTTdG?=
 =?utf-8?B?bUt3RkwyWUcwU3RpOU1ZSjBjdGYyTFEydnhEMlZLMU9vZUtnaUFXUnBva3dx?=
 =?utf-8?B?dDRUZE9lV1gxbHVFeWRyUmhkbDlxeGVwYVRmYlRQR3g5RytLVUJiU0EvcmdZ?=
 =?utf-8?B?b2JlZFFSemU2SElVcHlMeHk2ajU2bjFWcnZnR2h0NkVqSW8zdVJMZ2JVM041?=
 =?utf-8?B?anZaRmVibzJNYmFZNTYyTGswMi9saGxTd0twWEp5ZmU5UVVtVDVsUnZMaFBq?=
 =?utf-8?B?aG1zVklRd2c2NkFuYlAwMXd5aVAyYllOSXN5dkVjN1pNQW5EK0tuSXQ5eE9I?=
 =?utf-8?B?MFB6bjdzZUE2QW10bnhOUklVd2hsMGhSNCsra1ZsM0VaQjhvVWJDYzJyTlcw?=
 =?utf-8?B?NnprNDhUZ0NBT1BNT1BmcXAweHJXV0tHUENRbjc4aE94aFNrMjJZSWlVcEFi?=
 =?utf-8?B?RHppQUcrdGpDb1FaZnZ6QUlWVDhqVmoxM0ZKVlFva0VIMnZKWTROL1lkZUl0?=
 =?utf-8?B?eG51LzZMYnpyaTNqS1IvSmR0a2dpQVJxSWZ6TzNZeGc3WFlZcmZ6YkpmUk0x?=
 =?utf-8?B?T3VoVGJtd3VnZmpuVngyVkZ3SkJodXVrVVh1cjg4UkhVMkNPLy85bWkycFhK?=
 =?utf-8?B?TWtBL2xockw4VUpMTE5JZVZFS3pLbmdObWFJT2RBemdjWk1hUE1oNXhSNEN2?=
 =?utf-8?B?OElJcCt6NFpZUG5SRTZRbWREaFpFK3BxMzZUdWN5ZUZpdFQ3TmRkSEJ1c3RB?=
 =?utf-8?B?SjlRWXFmL2R6cWF2MGRNT1VZSnhjbFcyTnJGSlcyQStZb05RUDMzYytSM2U5?=
 =?utf-8?B?aXZqL3p6NTRzNGFFeEsrUUlGUVpVS0NxSmNud0hpaWlHdk1veTVDaEpldkRF?=
 =?utf-8?B?L2IwRElTNjVrTFJLenhLUVI4NFhRK3ZWYUJCOHpEMEU1Mkh3TXlPMzd6alR0?=
 =?utf-8?B?OThiK1lpOXcycVlmdEx6UURvTkcrUkxjTExYQ3ZhMVpwS3ZZOUZ3R0RLYlU0?=
 =?utf-8?B?ekd6QUtaSEVtSFc3VmlpOEdhQTEwNkdnUFZFRzVxZUtoUWhBZzhhckxDamx3?=
 =?utf-8?B?Ni85UDl5eVBRczl5c3NEM1VTbXZ2eXlUeXBiYWZtOWhIbmluelpZMzluZ3pE?=
 =?utf-8?B?NmFFOTNVRTkrb1U5U3ZhbS9hNDZORXh6ZnpFVkF0MVo5eXlLSnVlNmJCVU1r?=
 =?utf-8?Q?QyHrLoh4SyyQFHZ6B8JkYUbHa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54675815-ccd8-4d08-07c1-08dae696eb53
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2022 16:41:49.2813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOwGBOMJZQVhzuiOFvzb0ZeVOHZLHJkjJg+7SCcjndTe1oN1zLCaRW225uuGNRDwUyObXIF4AlZS67p/EClqmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
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
IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMjMsIDIwMjIgNTo0NSBQTQ0KPiBUbzogWXVhbiwgUGVy
cnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tOw0KPiBM
aW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBIdWFuZywgUmF5
DQo+IDxSYXkuSHVhbmdAYW1kLmNvbT47IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnDQo+IENjOiBT
aGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPjsgRm9udGVub3QsIE5hdGhhbg0K
PiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0Bh
bWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkg
KEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4
IDA1LzEzXSBjcHVmcmVxOiBhbWQtcHN0YXRlOiBvcHRpbWl6ZSBkcml2ZXIgd29ya2luZw0KPiBt
b2RlIHNlbGVjdGlvbiBpbiBhbWRfcHN0YXRlX3BhcmFtKCkNCj4gDQo+IA0KPiANCj4gT24gMTIv
MTkvMjAyMiAxMjoxMCBQTSwgUGVycnkgWXVhbiB3cm90ZToNCj4gLS0tLS0tLS0tLS0tLS0tLS0t
LS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+DQo+ID4gKy8qKg0KPiA+ICsg
KiBlbnVtIGFtZF9wc3RhdGVfbW9kZSAtIGRyaXZlciB3b3JraW5nIG1vZGUgb2YgYW1kIHBzdGF0
ZSAgKi8NCj4gPiArDQo+ID4gK2VudW0gYW1kX3BzdGF0ZV9tb2RlIHsNCj4gPiArCS8qKiBAQU1E
X1BTVEFURV9ESVNBQkxFOiBEcml2ZXIgbW9kZSBpcyBkaXNhYmxlZCAqLw0KPiA+ICsJQU1EX1BT
VEFURV9ESVNBQkxFID0gMCwNCj4gPiArDQo+ID4gKwkvKiogQEFNRF9QU1RBVEVfUEFTU0lWRTog
RHJpZXIgbW9kZSBpcyBwYXNzaXZlIG1vZGUgKi8NCj4gPiArCUFNRF9QU1RBVEVfUEFTU0lWRSA9
IDEsDQo+ID4gKw0KPiA+ICsJLyoqIEBBTURfUFNUQVRFX0FDVElWRTogRHJpdmVyIG1vZGUgaXMg
YWN0aXZlIG1vZGUgKi8NCj4gPiArCUFNRF9QU1RBVEVfQUNUSVZFID0gMiwNCj4gPiArDQo+ID4g
KwkvKiogQEFNRF9QU1RBVEVfR1VJREU6IERyaXZlciBtb2RlIGlzIGd1aWRlZCBtb2RlICovDQo+
ID4gKwlBTURfUFNUQVRFX0dVSURFID0gMywNCj4gPiArDQo+ID4gKwkvKiogQEFNRF9QU1RBVEVf
TUFYICovDQo+ID4gKwlBTURfUFNUQVRFX01BWCA9IDQsDQo+ID4gK307DQo+IA0KPiBJTU8gdGhl
IGFib3ZlIGVudW0gaXMgc2VsZiBleHBsYW5hdG9yeSB3ZSBkb24ndCBuZWVkIHRvIGFubm90YXRl
Lg0KPiANCj4gd2hhdCBhYm91dCBiZWxvdz8NCj4gDQo+IC8qKg0KPiAgKiBlbnVtIGFtZF9wc3Rh
dGVfbW9kZSAtIGRyaXZlciB3b3JraW5nIG1vZGUNCj4gICogQWxsIHN1cHBvcnRlZCBtb2RlcyBh
cmUgZXhwbGFpbmVkIGluIGtlcm5lbC1wYXJhbWV0ZXJzLnR4dCAgKi8gZW51bQ0KPiBhbWRfcHN0
YXRlX21vZGUgew0KPiAJQU1EX1BTVEFURV9ESVNBQkxFID0gMCwNCj4gCUFNRF9QU1RBVEVfUEFT
U0lWRSwNCj4gCUFNRF9QU1RBVEVfQUNUSVZFLA0KPiAJQU1EX1BTVEFURV9NQVgsDQo+IH07DQoN
ClN1cmUgLCBjaGFuZ2VkIGl0IGluIHY5IGxpa2UgeW91IHN1Z2dlc3RlZC4NCg0KPiANCj4gUGx6
IHJlbW92ZSBHVUlERUQgbW9kZSBoZXJlIGJlY2F1c2UgaXQgYWxsb3dzIHVzZXIgdG8gcGFzcw0K
PiAiYW1kX3BzdGF0ZT1ndWlkZWQiDQo+IGluIGtlcm5lbCBjbWRsaW5lLiBUaGVyZWZvcmUgaXQg
YnJlYWtzIHRoZSBkcml2ZXIgZmxvdyB3aXRob3V0IGd1aWRlZCBwYXRjaGVzLg0KPiBJIGNhbiB1
cGRhdGUgdGhlIGVudW0gaW4gbXkgZ3VpZGVkIHBhdGNoLg0KPiANCg0KUmVtb3ZlZCANCg0KPiA+
ICsNCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBhbWRfcHN0YXRlX21vZGVfc3RyaW5n
W10gPSB7DQo+ID4gKwlbQU1EX1BTVEFURV9ESVNBQkxFXSAgICAgPSAiZGlzYWJsZSIsDQo+ID4g
KwlbQU1EX1BTVEFURV9QQVNTSVZFXSAgICAgPSAicGFzc2l2ZSIsDQo+ID4gKwlbQU1EX1BTVEFU
RV9BQ1RJVkVdICAgICAgPSAiYWN0aXZlIiwNCj4gPiArCVtBTURfUFNUQVRFX0dVSURFXSAgICAg
ID0gImd1aWRlIiwNCj4gPiArCU5VTEwsDQo+ID4gK307DQo+ID4gKw0KPiA+ICAjZW5kaWYgLyog
X0xJTlVYX0FNRF9QU1RBVEVfSCAqLw0KPiANCj4gLS0NCj4gVGhhbmtzICYgUmVnYXJkcywNCj4g
V3llcw0K
