Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE696473A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLHPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiLHPzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:55:42 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D8755A83;
        Thu,  8 Dec 2022 07:55:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJXdCsL0cSrloK6ZXetG10aLjPmvI9u3TMBWCFt7MNKmuXrSi+57Kp5sXB4CXAJgdhjtox+d+7FDyQoMPnGBjQgLMvD62lgtZhfZ0oaofjUnLobgaZs57xQGql3qSHmg3/FgfrdUFpbhlLLsc5fThikGG7nNgVG4TfFPMEeepx9HMThH2gRVhEEF1tq4ynRxuabIlGSlq9klfsRXkMs8Ua/jR64metUjwZH3Hl9czMsPNlc1Lr28kXZTnb296zg5OPBxYKap7s1npxxPu9HnXfTiULen44IktRZzZDG5+6H0BhgXutKBqICV0jCGkwjUDriGJKcjIO+xzeRoqtW8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/0QpQRobTbO61xUvGideVQGlfXQ2Qo0a6xcKgOjSFg=;
 b=K730ZR9ALfDbxMHw7l3n+/ue/XTY0PvHiu8C/bHOky2d9FMvOrwLfZ320uGcVQ/V2wWVVaF6/0bGvzb9EQx/b2l2Z30stCPeW3OkjpkckBJIlFE8d8GUERKpLsA/Ii85UUhhioMGE9nxu+0azsq1LPYgT0s/XzuKq++EhzdjjMCsjEXssEjiszhrvoM5OtrnYB7abYrvFfRlQkpKVXTsyT+MNRaBCxYL2dOFOiet8UiZ8p/Jp/TJ5KUuWJzbvF9vGu/u3bcx20Fa4h77CNidmuMsW1YUHWgU1Hw2wzKQHFjh+Qnpj15MMeqUcVjPL+GOfPhFNVFSgwUOGnwSgsNT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/0QpQRobTbO61xUvGideVQGlfXQ2Qo0a6xcKgOjSFg=;
 b=Krji6mKvZAoi2ap5YlUOppTc3ldlTjK5mGqC1n1GwE2+AVJZ18+WD6AQKnNq7E7uKbtakHcWVOUSa9zwVgtIrenCa9zKkhcQpcHIDLrYUna7PQj3UPb3eQIo/IdmaEC/yV4wiaMp54N8oxKV5G5Ov88SUS1uwC6PguG6tqVOUWo=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 15:55:39 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 15:55:39 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 08/11] cpufreq: amd_pstate: add driver working mode
 status sysfs entry
Thread-Topic: [PATCH v6 08/11] cpufreq: amd_pstate: add driver working mode
 status sysfs entry
Thread-Index: AQHZBiMhKupbnw0otUmXvldzBwzq1q5awS0AgASsh8A=
Date:   Thu, 8 Dec 2022 15:55:39 +0000
Message-ID: <DM4PR12MB52788424B084B76E0E306DCF9C1D9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
 <20221202074719.623673-9-perry.yuan@amd.com>
 <b984800e-9d70-3f43-1af2-7f3d85d356bd@amd.com>
In-Reply-To: <b984800e-9d70-3f43-1af2-7f3d85d356bd@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-08T15:55:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7426e924-6aa2-44b5-9c2d-c41405ce5cb3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-08T15:55:36Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8f493fd0-c8d6-47b4-8a83-3433f425b5b4
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY8PR12MB7267:EE_
x-ms-office365-filtering-correlation-id: 09137d70-2108-4ca2-81c6-08dad934a737
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0vOOP+u6EVI5dlMZOK5Z5C7gZNgHTNYWTUUL+wxbiPYj+hzi7iZnI1tLcVD1QTvEPTaGVer6sshz4WM9RHrgtHxR57dSqynWy1EyBPqjao3DzYTm5lUYh8cSQ3Q3f/NBMjP18SpSiBKnhcxvx4ulc15ICZaVqrZDHNzZKnwXDKiIHkvh7voVCgiSEGfnK1eXHFJfxjO8f86gTqwrOMNWeCevTpbpzRujqS1xXqrTOSVTpXwpN8mU48j3VZGeNLx3+ymjvw2XwTiIMdSWJMhw6kWzJ4GdJyaxlVJmclnTagR+sKhVYvdn9pqHvWjhUQ0AJm0x0iETLnnu2MQ8MwkkYkHjsGphEYyisaAjGixmIUDKXEJJQCea+4f2OYW5xcLBgqewhBZsAQmIF7DxZG88KRxoT8NQAUgKQPi2MZT2SN/2pJJruXgQz79yf0EgjtPshLdupMCMhNuol/gan8oC/2O8s1M4EMrLk/kYufKt2qJ/HXTDUYG6wKOrkrGDJH/mPr9O+YAt6tVo4UqwgaRRrz9pSuERKAeKu+Ee4hfqRKEPCnmiMu5fTgtI49LBdPQmVGI9w5oFOEmtf6rPrr3ywp2W+ICQrDx0Z/4WNL+qeo5maEbZm7l1aoANiSAcqCE/tksdEaRO1Cm6AVJXV/PQh8LhFwNKrekJ3T2W/uVu9hbEXz6FSfZKPUybRGM+J19ps6UJEt+nW9Y7crYG0FLQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199015)(38100700002)(41300700001)(8936002)(4326008)(38070700005)(2906002)(5660300002)(122000001)(83380400001)(66946007)(86362001)(33656002)(71200400001)(52536014)(66446008)(316002)(110136005)(66476007)(66556008)(54906003)(478600001)(55016003)(76116006)(9686003)(7696005)(8676002)(64756008)(6506007)(53546011)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2ErN0tuT2VvK01XQmgyRmNVelJGeG8zYjhQd0hYaW1EeEU0UG9ncDE5Wmt0?=
 =?utf-8?B?TVhZbVBPR2poSDlCb1hJMEIvVjJOczFDOUpCK25Sbk9BR2Z2Mit5enhIMFhj?=
 =?utf-8?B?SmhaTmJFV0FXVUxoTzFsZk5FQzl3K0V0d09yVThxZXNid1RKMFNkaG1RYnky?=
 =?utf-8?B?UFZjRzJramVzUElVMzVuTkRFU0MzdHltRE5CdTVKSFFwd24yZk1LR3hqZmlN?=
 =?utf-8?B?d1RWWFgydUlTZ0F2Nlc3cU82WktSZDcwTHZRcG4yY1RWTUw4RmM2UWl4ZUht?=
 =?utf-8?B?RGo0Mmk4QkN3VmVhQm8rVEZqbTRVTGxxNEpXS3hkay9wN3N2UWZHQ0Z3S3JV?=
 =?utf-8?B?Wmt6V1NnSE5pOFhRWFNZRjlaZGF6OXlMSzVzVDhuejUrbjdVenZxcEh5MEJt?=
 =?utf-8?B?SWFmZWFsK1hlWUFhdFZ0WUdVeklGR1hwdno5L1lSdWtSeXljYTdRTHJjNFNQ?=
 =?utf-8?B?aWV6RU95SUxaRmtuZDgzK1lPcExud2hRdy9IdXZXV3dBVC9oSXFBQjY5UGhP?=
 =?utf-8?B?SGZXaGsxS3JNcnN1eTVwa1ZkWjVsM21rQUwzSzNyRTNRdEc5SUpBN0VHdm5F?=
 =?utf-8?B?Qi9DUHlWL2F3NjNuQ3dGOE1DNUJBdVNLYlFpOHFFa1BMaU1YZk5QQjFjTDZN?=
 =?utf-8?B?Q0FhTU9FN3dNbnowUlVCUmFORG9TMWNBRmkrRk9oNGhMRVE1Y2pBc09CeFpa?=
 =?utf-8?B?MEt6VWMrbXdkUEMrbmhVU1VSaDk3bExXU0grRUsyemhMajAyTEtjYTc5SXgv?=
 =?utf-8?B?YWwxVGp2UGJhWmV3ai82Z2Z3aVFDKy8xeFRic3NOSlVWSFFhTi91elZ3WG1B?=
 =?utf-8?B?dmRqZ0hveERvSHA3NjBWTXBiVjVDeUxnOVR4cmtIMmh3dXlid0VHNHhaRXh2?=
 =?utf-8?B?TFpTcDM3d0ltcDlWcHJQbER5UlJLQ2huVm5yK2tXZnR6YXJveGhNWEEwUkMr?=
 =?utf-8?B?bGJLVUd2ekFkRnNPdTBsR2p4SW9LelVXOTdKMkJmVHNPWEg2bG4yS0s2cncz?=
 =?utf-8?B?UllzYytkU1RzOU92dnZwV1FJeXRqKzE2b0dYZHdWZktpVlJBVDZIYVdoWmtV?=
 =?utf-8?B?ZFQ2N2RTSXhlc1FGV1NvNlJISE5RM3lKSkNnLzdPRVBSL1I4WVQ2UURIQ1NX?=
 =?utf-8?B?ZVZ5T1E1YjBzVmdUZjhLOW9WNm1ub3gvdnEvK0FTQVdhaWlkV2h5KzlQeTRP?=
 =?utf-8?B?WWxLdjlPdC9JajdYYVh0ZzV3RlZUQllHOTJsbXRaMjExSDQwRUpOQjU3T2h0?=
 =?utf-8?B?TEVtellRZnVTMXlJM21PdHl2WUU4M1BwbGk5OFlBMExUWDhRT3RZV0xMc0ZP?=
 =?utf-8?B?VHJlSXFoczJvSTNYL05lZ0NoaWFwV3NDalZNbjZYYkxQS2VFcnRuU2hQdy9C?=
 =?utf-8?B?cW45M3lxdFA4Wmoxd2hSbzFRUE9KWXV1Y0hSOForTnFvTXhvZncrOWVvc0tk?=
 =?utf-8?B?U2NweFdOQVFMa1I4QzVCRFVBRGY2UW44dUtQa0YwcVcxM2VIcG5tcmJzTUVB?=
 =?utf-8?B?c0NPOC8xZnFNdTZwb0diTHl0RlN4Q2t4YTFHNlZDNnRNaU1aSXpMNi9HNWsr?=
 =?utf-8?B?cVE1bmhyd24zWVZZSzJPeUVvY1pocFRWSWVyRlpKUzh6bHFFbFpiMVdyTU9S?=
 =?utf-8?B?Z2I3a0hhYi8yMURKOFFycnZ3OXhpbkVQUTFPbHVXSi8rRGYwNEhmNUR6U3lG?=
 =?utf-8?B?b3ZqK0NZYmZLN1dMeEIwYTkzWituS0JDelVpU0x5UjZlTVgvZytuK3dvbkFp?=
 =?utf-8?B?TTlsQXJsMzBycjc3MmxsYnBySDBFVkVLSjJER2p5TmlPV0R3VzNnZHVmUUx6?=
 =?utf-8?B?dW1LK3dqNU1CckJSNlNmNXJYOHF5MFFEb01KN2U3RVN3d0FZaER1c1dHSUJo?=
 =?utf-8?B?QkYzdkxpdnBzYy9uU3lncEpKekZCeU5mQkV0V0Z3aXNoRm1SRDlrYUFtYmh4?=
 =?utf-8?B?aEF6aVA3YmtRRUk4MFpqM3o3QW1NT0M4MGNrWUZKbjZRcW80WVBiS0xHWXlX?=
 =?utf-8?B?ajJmSXlURHVHdnVycHppS0JucUxUVUZaelhDZ2hpbzFiWjR1aTJ2TzUyYkdS?=
 =?utf-8?B?cjNYWEQyU3ZCK1VPRnFUSVEra0R0ZWhncDQvbHk2cktTSFhyRElxcWlOS0x5?=
 =?utf-8?Q?ImLdLwhjbdb1e3/mAAgOlhAw1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09137d70-2108-4ca2-81c6-08dad934a737
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 15:55:39.2837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5A/Ycc7uidZKl1s6hMn8DqfhsWVLCiKoHuwrYmfQpKYnksRDCEQN7LrzCYPiK98j31aZsw/IViuycZhodC16g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8u
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAyLCAyMDIyIDEx
OjU3IFBNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVsLmou
d3lzb2NraUBpbnRlbC5jb207IEh1YW5nLA0KPiBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgdmly
ZXNoLmt1bWFyQGxpbmFyby5vcmcNCj4gQ2M6IFNoYXJtYSwgRGVlcGFrIDxEZWVwYWsuU2hhcm1h
QGFtZC5jb20+OyBGb250ZW5vdCwgTmF0aGFuDQo+IDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47
IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5n
LCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9q
aWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+
OyBLYXJueSwgV3llcyA8V3llcy5LYXJueUBhbWQuY29tPjsNCj4gbGludXgtcG1Admdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjYgMDgvMTFdIGNwdWZyZXE6IGFtZF9wc3RhdGU6IGFkZCBkcml2ZXIgd29ya2luZw0KPiBt
b2RlIHN0YXR1cyBzeXNmcyBlbnRyeQ0KPiANCj4gT24gMTIvMi8yMDIyIDAxOjQ3LCBQZXJyeSBZ
dWFuIHdyb3RlOg0KPiA+IEZyb206IFBlcnJ5IFl1YW4gPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4g
Pg0KPiA+IFdoaWxlIGFtZC1wc3RhdGUgZHJpdmVyIHdhcyBsb2FkZWQgd2l0aCBzcGVjaWZpYyBk
cml2ZXIgbW9kZSwgaXQgd2lsbA0KPiANCj4gVGhlICpkcml2ZXIqIGRvZXNuJ3QgbmVlZCB0byBj
aGVjayB3aGljaCBtb2RlIGlzIGVuYWJsZWQgZnJvbSB0aGUgc3lzZnMNCj4gZmlsZSwgYnV0IHVz
ZXJzcGFjZSBtYXkgd2FudCB0byBjaGVjayB0aGlzLiAgSSB0aGluayB5b3Ugc2hvdWxkIHJld29y
ZCB0aGlzDQo+IGFjY29yZGluZ2x5IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+ID4gbmVl
ZCB0byBjaGVjayB3aGljaCBtb2RlIGlzIGVuYWJsZWQgZm9yIHRoZSBwc3RhdGUgZHJpdmVyLGFk
ZCB0aGlzDQo+ID4gc3lzZnMgZW50cnkgdG8gc2hvdyB0aGUgY3VycmVudCBzdGF0dXMNCj4gPg0K
PiA+ICQgY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2FtZC1wc3RhdGUvc3RhdHVzDQo+ID4g
YWN0aXZlDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFt
ZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIHwgNDQN
Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgNDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1
ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgaW5k
ZXggNjkzNmRmNmU4NjQyLi43Zjc0OGE1NzkwMjMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9j
cHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRl
LmMNCj4gPiBAQCAtNjYsNiArNjYsOCBAQCBzdGF0aWMgYm9vbCBjcHBjX2FjdGl2ZTsNCj4gPiAg
IHN0YXRpYyBpbnQgY3BwY19sb2FkIF9faW5pdGRhdGE7DQo+ID4NCj4gPiAgIHN0YXRpYyBzdHJ1
Y3QgY3B1ZnJlcV9kcml2ZXIgKmRlZmF1bHRfcHN0YXRlX2RyaXZlcjsNCj4gPiArc3RhdGljIHN0
cnVjdCBjcHVmcmVxX2RyaXZlciBhbWRfcHN0YXRlX2VwcF9kcml2ZXI7IHN0YXRpYyBzdHJ1Y3QN
Cj4gPiArY3B1ZnJlcV9kcml2ZXIgYW1kX3BzdGF0ZV9kcml2ZXI7DQo+ID4gICBzdGF0aWMgc3Ry
dWN0IGFtZF9jcHVkYXRhICoqYWxsX2NwdV9kYXRhOw0KPiA+ICAgc3RhdGljIHN0cnVjdCBhbWRf
cHN0YXRlX3BhcmFtcyBnbG9iYWxfcGFyYW1zOw0KPiA+DQo+ID4gQEAgLTgwNyw2ICs4MDksNDYg
QEAgc3RhdGljIHNzaXplX3Qgc3RvcmVfYm9vc3Qoc3RydWN0IGtvYmplY3QgKmEsDQo+ID4gICAJ
cmV0dXJuIGNvdW50Ow0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBzc2l6ZV90IGFtZF9wc3Rh
dGVfc2hvd19zdGF0dXMoY2hhciAqYnVmKSB7DQo+ID4gKwlpZiAoIWRlZmF1bHRfcHN0YXRlX2Ry
aXZlcikNCj4gPiArCQlyZXR1cm4gc3lzZnNfZW1pdChidWYsICJvZmZcbiIpOw0KPiA+ICsNCj4g
PiArCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVzXG4iLCBkZWZhdWx0X3BzdGF0ZV9kcml2ZXIg
PT0NCj4gJmFtZF9wc3RhdGVfZXBwX2RyaXZlciA/DQo+ID4gKwkJCQkJImFjdGl2ZSIgOiAicGFz
c2l2ZSIpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFtZF9wc3RhdGVfdXBkYXRl
X3N0YXR1cyhjb25zdCBjaGFyICpidWYsIHNpemVfdCBzaXplKSB7DQo+ID4gKwkvKiBGSVhNRSEg
Ki8NCj4gPiArCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gPiArfQ0KPiANCj4gV2h5IG5vdCBqdXN0
IGZpeCB0aGlzIGFzIHBhcnQgb2YgdGhlIHNlcmllcz8gIEl0IHNob3VsZCBiZSBubyBkaWZmZXJl
bnQgdGhhbg0KPiB1bmxvYWRpbmcgdGhlIGRyaXZlciBhbmQgcmVsb2FkaW5nIGl0IGluIHRoZSBh
cHByb3ByaWF0ZSBtb2RlLCByaWdodD8NCg0KVGhlcmUgaXMgb25lIGtlcm5lbCBoYW5nIGlzc3Vl
IGZvciB0aGUgYW1kLXBzdGF0ZSBkcml2ZXIgd2hlbiB1bmxvYWRpbmcgaXQgYmVmb3JlIHRoaXMu
IA0KSSBoYXZlIGFkZGVkIG9uZSBmaXggcGF0Y2ggZm9yIHRoaXMgaW4gVjcsIGFuZCBhZGRlZCB0
aGUgZHJpdmVyIG1vZGUgc3dpdGNoaW5nIGNvZGUgYXMgd2VsbC4NClRoZSBkcml2ZXIgbW9kZSBj
YW4gYmUgc3dpdGNoZWQgbm93Lg0KDQpQZXJyeS4NCg0KPiANCj4gSXMgdGhpcyBnb2luZyB0byBi
ZSBhIHNob3J0IHRlcm0gRklYTUUvVE9ETyBvciBhIGxvbmcgdGVybT8gIElmIGl0J3MgbG9uZyB0
ZXJtLA0KPiBpdCBtaWdodCBiZSBiZXR0ZXIgdG8ganVzdCBtYWtlIHRoZSBhdHRyaWJ1dGUgcm8g
YW5kIGFuZCBoYXZlIGp1c3QgdGhlIHNob3cNCj4gY2FsbGJhY2suICBUaGVuIHdoZW4geW91J3Jl
IHJlYWR5IHRvIG1ha2UgaXQgcncgeW91IGNhbiBhZGQgdGhlIHN0b3JlDQo+IGNhbGxiYWNrLCBj
aGFuZ2UgaXQgZnJvbSBybyB0byBydyBhbmQgdXBkYXRlIGRvY3VtZW50YXRpb24gYXQgdGhhdCB0
aW1lLg0KPiANCg0KRml4ZWQgaW4gVjcuIEl0IGlzIHdvcmtpbmcgd2VsbCBub3cuIA0KDQo+ID4g
Kw0KPiA+ICtzdGF0aWMgc3NpemVfdCBzaG93X3N0YXR1cyhzdHJ1Y3Qga29iamVjdCAqa29iaiwN
Cj4gPiArCQkJICAgc3RydWN0IGtvYmpfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQo+ID4g
K3sNCj4gPiArCXNzaXplX3QgcmV0Ow0KPiA+ICsNCj4gPiArCW11dGV4X2xvY2soJmFtZF9wc3Rh
dGVfZHJpdmVyX2xvY2spOw0KPiA+ICsJcmV0ID0gYW1kX3BzdGF0ZV9zaG93X3N0YXR1cyhidWYp
Ow0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZhbWRfcHN0YXRlX2RyaXZlcl9sb2NrKTsNCj4gPiArDQo+
ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3NpemVfdCBzdG9y
ZV9zdGF0dXMoc3RydWN0IGtvYmplY3QgKmEsIHN0cnVjdCBrb2JqX2F0dHJpYnV0ZSAqYiwNCj4g
PiArCQkJICAgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNvdW50KQ0KPiA+ICt7DQo+ID4gKwlj
aGFyICpwID0gbWVtY2hyKGJ1ZiwgJ1xuJywgY291bnQpOw0KPiA+ICsJaW50IHJldDsNCj4gPiAr
DQo+ID4gKwltdXRleF9sb2NrKCZhbWRfcHN0YXRlX2RyaXZlcl9sb2NrKTsNCj4gPiArCXJldCA9
IGFtZF9wc3RhdGVfdXBkYXRlX3N0YXR1cyhidWYsIHAgPyBwIC0gYnVmIDogY291bnQpOw0KPiA+
ICsJbXV0ZXhfdW5sb2NrKCZhbWRfcHN0YXRlX2RyaXZlcl9sb2NrKTsNCj4gPiArDQo+ID4gKwly
ZXR1cm4gcmV0IDwgMCA/IHJldCA6IGNvdW50Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICAgY3B1ZnJl
cV9mcmVxX2F0dHJfcm8oYW1kX3BzdGF0ZV9tYXhfZnJlcSk7DQo+ID4gICBjcHVmcmVxX2ZyZXFf
YXR0cl9ybyhhbWRfcHN0YXRlX2xvd2VzdF9ub25saW5lYXJfZnJlcSk7DQo+ID4NCj4gPiBAQCAt
ODE0LDYgKzg1Niw3IEBAIGNwdWZyZXFfZnJlcV9hdHRyX3JvKGFtZF9wc3RhdGVfaGlnaGVzdF9w
ZXJmKTsNCj4gPiAgIGNwdWZyZXFfZnJlcV9hdHRyX3J3KGVuZXJneV9wZXJmb3JtYW5jZV9wcmVm
ZXJlbmNlKTsNCj4gPiAgIGNwdWZyZXFfZnJlcV9hdHRyX3JvKGVuZXJneV9wZXJmb3JtYW5jZV9h
dmFpbGFibGVfcHJlZmVyZW5jZXMpOw0KPiA+ICAgZGVmaW5lX29uZV9nbG9iYWxfcncoYm9vc3Qp
Ow0KPiA+ICtkZWZpbmVfb25lX2dsb2JhbF9ydyhzdGF0dXMpOw0KPiA+DQo+ID4gICBzdGF0aWMg
c3RydWN0IGZyZXFfYXR0ciAqYW1kX3BzdGF0ZV9hdHRyW10gPSB7DQo+ID4gICAJJmFtZF9wc3Rh
dGVfbWF4X2ZyZXEsDQo+ID4gQEAgLTgzMyw2ICs4NzYsNyBAQCBzdGF0aWMgc3RydWN0IGZyZXFf
YXR0ciAqYW1kX3BzdGF0ZV9lcHBfYXR0cltdID0gew0KPiA+DQo+ID4gICBzdGF0aWMgc3RydWN0
IGF0dHJpYnV0ZSAqcHN0YXRlX2dsb2JhbF9hdHRyaWJ1dGVzW10gPSB7DQo+ID4gICAJJmJvb3N0
LmF0dHIsDQo+ID4gKwkmc3RhdHVzLmF0dHIsDQo+IA0KPiBJbiB0aGUgc2VyaWVzIEkgZGlkbid0
IHNlZSBhIG1hdGNoaW5nIERvY3VtZW50YXRpb24gdXBkYXRlIGZvciB0aGUgbmV3DQo+IHN5c2Zz
IGZpbGUsIGNhbiB5b3UgcGxlYXNlIGFkZCBvbmU/DQoNCkFkZGVkIGluIFY3Lg0KUGxlYXNlIGhl
bHAgdG8gdGFrZSBhIGxvb2sNCg0KPiANCj4gPiAgIAlOVUxMDQo+ID4gICB9Ow0KPiA+DQo=
