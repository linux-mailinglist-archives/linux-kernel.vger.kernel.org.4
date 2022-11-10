Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C1E624780
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiKJQuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKJQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:49:42 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0338AC0B;
        Thu, 10 Nov 2022 08:49:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGG9o3uSjSwZXN60XK76BjmTcxLy57FLP4JCLY3Ntk8CtF9tOMe2onWGkuK6t03KTES130KBuSLbJDhaHv+wDctkGYE1cpiTDWODAJIonBQmXHYXMQMBSGH2QokWGVai6PEuebBXTnWzHeirLexkoMDowVcaguLkaEWGM7lS6meGAmA2fXmW6qdY9WiAc5Iu3GRWNs6M3xKIolDh1YgmlgVUN/SatvH9pNEmLndz6ixQhFzHYgPKzIcO09UypQPghdBOaGAK3/G6C8l9IoRxXCjSmRGlCZoyOUogi96+D9SGHpPNrAF+C8zGLyEsWWDxNqK2Aa9Fvs0XacSJZdggog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxgl++XJ3Lo3C5Kf8P4kZYOsbwxQ4b0IFJLlOsylOUM=;
 b=biZBvQKMy722FCitdNahmX5mHpoWWethiEkMXwZ0QqBeCpEWuBQ42XYLbcPK5/Bu0tvtl/oT7E4tA7VLyPJsNKmktNyxkgyWSXWLTlE0K9YeaSPSIHm+AoiBEyzzmvNwYknkNjVXeYigUUYX6pXBzOVOBo846WDd7nZcK2DKzLfxbMbrRkq+yYPbAM2EKscSA53WC00kiPf9yWQR7xL5cDRt59oIKUnYvkNNxcYHn5gpG5z+4CDZoT5HTOtxjC8hzJGH0FvCn5y2hFcmXNDGUgkw6PksCCkMREX5AyuuonDnjg0S2J/xsDKVj0GH+Ytt8Pfu932ABh2RqSGEX5JvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxgl++XJ3Lo3C5Kf8P4kZYOsbwxQ4b0IFJLlOsylOUM=;
 b=gCKMRpHi+GI7pn6s2gWtSisWBHrrsWa22ZGXtb8nv0Na0m1cUkzpkESZriTu+FWUkiMY2jmsQ6leOTsbNN4BciVMbEsc4imjdVK/bnKoHwlhNoEgGVOtByXW9YsAL58ZeMNlaDIptMkrzoUuq2v8NLaG7VsDwlmlxU4BCGTOmHU=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 10 Nov
 2022 16:49:10 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%8]) with mapi id 15.20.5813.013; Thu, 10 Nov 2022
 16:49:10 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 8/8] cpufreq: amd_pstate: add driver working mode
 status sysfs entry
Thread-Topic: [PATCH v3 8/8] cpufreq: amd_pstate: add driver working mode
 status sysfs entry
Thread-Index: AQHY8tKg0TEIlpfng0+1tBYIRiFTga44V0EAgAALVZA=
Date:   Thu, 10 Nov 2022 16:49:10 +0000
Message-ID: <DM4PR12MB527890A9B54041C0230A80FB9C019@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-9-Perry.Yuan@amd.com>
 <2c4f7c3c-bb05-e16c-19af-451fe167f2e8@amd.com>
In-Reply-To: <2c4f7c3c-bb05-e16c-19af-451fe167f2e8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-10T16:49:07Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=848d24b3-12a8-4bf9-ba32-656d972c97f8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-10T16:49:07Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 14a5efa3-6b56-495f-8e12-2cc88812454c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|BL1PR12MB5335:EE_
x-ms-office365-filtering-correlation-id: cd9312d5-b931-42fc-5dc9-08dac33b7da7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WQylpw6K99g2+9yVemVi2dJjMmjfTSKTqNV+vUv01VQHYPJ0YP1ww8kI7NT/GOInN/DQS78uoeQbV3eR6MmV8dhBhTktFxtlPtFHJFiduL1GdHJJsSd/6GVdh+eq4RMpDMpgl9q5u7dUJhYKo1RF0KTycqo8cLy6O3iFva8DkmKqkmuKxbg76i+gIC/khPO97Lpna29XdhMOMry7FSTfltYByGOiKrXgvCoaEQU7VahCZPzzIn+2jo4NKccsiUGTf8KqahE548T5N3OzgFj8/m7bCplLOUjgonvrqBp8y0XE7lgnS2TkdnF6RimhAa1DXegzbAmY6anGo8yggIedyVuuv5O3eJLICwzMi6lM323SMLgd9M2/xs1mYb1zHiznpTl087+7lkD7XiDhGE5iGjF0Ba2ixDQuUymhLcQ2z1sLdA+pgLpWjriNDKgXcuZHNgKXRBo/ggTXT4eTfw/84Dv96maCHapZFjwXd4NaU2Ykb2bd6L8N/OUwdb5FrgeKt3COZBf3QpnVjlWUc5VwoUGsaAKQle3ZH3sqBMnxwcb0wifI7Q6z/KpoL3yFkXDF+IQh8RhpQmAoBMRSFUwoJFLwSp2g3eogeVDT+eijFrjtjRk2wsbxFCg7w2fcKSt/TFYZOtqUWLLaxAs+yn7wrh9fv6bLioV9B06833vyqFHyant0SgOvTp0uOW5yMS1Ov3oMq78DUnUqSw2z+QKqqf0ki5a/q3i0THo8QTFpr/7UKR4ChIEwz2In1pxw0czDHYohHiHC/oHeygsSXXwxBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(9686003)(83380400001)(26005)(53546011)(186003)(38100700002)(122000001)(6506007)(66556008)(5660300002)(2906002)(41300700001)(55016003)(71200400001)(7696005)(110136005)(54906003)(4326008)(478600001)(8676002)(52536014)(66476007)(64756008)(66946007)(66446008)(76116006)(316002)(8936002)(33656002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnhVa2lETU5xK0YzZDBHR3RMMnpzYTg0T1VXa3BhYnJXcFdiNjRvSzFMNUVN?=
 =?utf-8?B?b3hWZFRqUVJnL3VENGJ1Y0QraEVIRVNtNVVBczZ5dDd4RFRuaHFrUXFLSDJ0?=
 =?utf-8?B?akhtcXREcWhvbmdwenNqVnFmNnJLVVpIdnFCWS91bjhDUEQxQmQ0MHVlcUF1?=
 =?utf-8?B?dG5DU3FaOUxiL0JtMVFlbVlzZE5vNXcrSVlHZmNZT1JWM2lmZ2xxbzBDcUVm?=
 =?utf-8?B?WEdYcll2UGNzcnBHT1pDR082cGk5OHF6WlVSaExKN01jNkpLUjkyNVlYNU5y?=
 =?utf-8?B?L0tJT01sdWJMeElJTXRDazZtd2FvSWFYcnF0ckJwTjgxaHdjSE9zOWV6N0xz?=
 =?utf-8?B?OEU1M3VqVTIvb2YxS3hHUk1yQkVFcG93ZHlGSHpoUlpyclR2QVNCY3Z2dmIz?=
 =?utf-8?B?cjhvSUd4Wmp1QkoyMUN3TzhxV0c2RzlxcXY0N1lhMHN5U01GbGpjSlU1V1Fi?=
 =?utf-8?B?cFc1R2svU1lKUERWc3NtRXlyZnNaRUU4bGJmRE9IVVF6bkoyeWtjZ1BOeS9m?=
 =?utf-8?B?Y2lWelJHcjVBdWN6eVU5TFQzMGlHSjE3Z0Z6K05iS1QraFpBc2ZhSG5GNU1O?=
 =?utf-8?B?UTNLMmpIZisyMmZja0Y2THJPVmMzcG5PdkhTOEpnc2haa0lxL3o4Sk9vcWhL?=
 =?utf-8?B?T2wvd00wNjh3K3AvVzFDSkJOQVpEa1Yxa3NXeWdGT0tpNFdwL29oRWV2MVVr?=
 =?utf-8?B?aU9lVXdBZ0NGU1oyd3BiODdKc1BTaDVHdldnNkphSmNPWHVRS1FNR1hUcUtx?=
 =?utf-8?B?d3dZZHd3VCtMaHhrM1hqTlR1elJhL3NHWThlbWFpM2gyZmtpeWUzcTM4aStO?=
 =?utf-8?B?Zk1ZVjZDQnhLdXRTcVRHQjkzR2VIeURWczZPSGVlUHJkVk80eHpVN1FFbXNW?=
 =?utf-8?B?dWpaVEk1Skh0VGR6SVRhamtpWXFuZzdXS1Mvam9tTG90SyttWlRLdGo0bUlx?=
 =?utf-8?B?SDNPNE1aWVVPdjdpQnZua2xPUUl4QUlqaGRqMG1HRnUzR21OL05URWdsbGNE?=
 =?utf-8?B?NDhFbFdQSEV0aXp0VFMwQi9aWTFPOXVaVkhGenJQa0hrOEZpaDlRbCtRUmJi?=
 =?utf-8?B?cnYwamM1dXErdHRkd1J0V2JQeHE2SnBtbEIwRTVVa0hzZU0yemphUHhhWUJa?=
 =?utf-8?B?VXU1bEdPMG1Bc2RhN2ZzUjlTYlNSWjlxOFFyTTdWZFFzbjZFSktEV243K3ht?=
 =?utf-8?B?RzI0Y3NhTW5rQnNsMGFPRUh1NjNZalhPVWppak1aQUJWNWV0VkJnYUI2S1BS?=
 =?utf-8?B?WDZGS25UTkFDNEkyZllmaUhWY2lzWG9xdkV0QTlnejRFK0NCcktOMGl0QkxU?=
 =?utf-8?B?NldDM01raHYyMWJaOExtbWZRVkxnaGIvM0NBQTMrY1l6RmJuYXBEN3VqUjZ2?=
 =?utf-8?B?Ny8xL2M4bDNFNC9mTXBRaGVEMDNscC9SNGFSdkdjYzNHZ3VrTVJueGhEdS91?=
 =?utf-8?B?cndOcVJOV0N1K3BMdEFoWWxENTM2d1Q3RlpoVTlVNm5OQ1VVWGc1K3F6L0wy?=
 =?utf-8?B?QjRkYzBITU1ERDdHSlA0a2xlcERkdlhCMUtNS1dtTzBYYW05TGpnS0VHUFZN?=
 =?utf-8?B?Z3FmVkg0bjhlYkZHRGxVYi84RzlPbXFMVHdnUVE0MEJMdWJkb05hSmx3M0Jq?=
 =?utf-8?B?dlRCdEsxQUpSVW9tZ08yakFPMlMvV1Rzd29TNHBxVzdIVDlRek1vUWlBYmpJ?=
 =?utf-8?B?TUk2MDViZW53VC96VU53VWFQdisraThEN2RlbnFPR251aUtuTFB4UEJ5Q2pU?=
 =?utf-8?B?Z3lHRXcvaytxeVMwdzMyeDlDcHFWNEwxcUVOc0ZEdyt0ZmV4WW14VG5aZGNx?=
 =?utf-8?B?MFVIcU5JVmtsc3drOHFBWG5ubEFHL0o0UDlQTHIvc3prZnB3Nk56M0orNG1D?=
 =?utf-8?B?RTgwcGRrK0pyeXpXZTJJcGh1L1dkZVZvekpTbmtUZkhzYy9sRTJzWlV3UG9r?=
 =?utf-8?B?ZExIZ2JkRWY2NzBwdnFsWEhRN01VZld5amxOMnE2UVRvcUsrVVlOZUU3cUUx?=
 =?utf-8?B?SWFEVkxqTWxMS3lnQkNnS0dVMDhTQzB4aHVrZ1Q2b3ExeFQyMVdLL1Q3MGJr?=
 =?utf-8?B?eFlPeXJZQUw0M29zek9UQWpTQTZaN1AvQlgwQytBbnArODR5Yzk5bUlJejFZ?=
 =?utf-8?Q?l/9L0qOJdpIt5Q3rKzV1hUeI4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9312d5-b931-42fc-5dc9-08dac33b7da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 16:49:10.4641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mRj0H9xqTvfZPagNS529ds90+xFwbw9hEgtK5V0JNzClUZI9jOuOuqBhKp+gBL72W93GnrRnqPwWEI7feDQ13Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE5hdGhhbi4gDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRm9udGVub3QsIE5hdGhhbiA8TmF0aGFu
LkZvbnRlbm90QGFtZC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTEsIDIwMjIgMTI6
MDcgQU0NCj4gVG86IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+OyByYWZhZWwuai53
eXNvY2tpQGludGVsLmNvbTsgSHVhbmcsDQo+IFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+OyB2aXJl
c2gua3VtYXJAbGluYXJvLm9yZw0KPiBDYzogU2hhcm1hLCBEZWVwYWsgPERlZXBhay5TaGFybWFA
YW1kLmNvbT47IExpbW9uY2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNv
bT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1
YW5nLCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhp
YW9qaWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5j
b20+OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgOC84XSBjcHVmcmVxOiBhbWRfcHN0YXRl
OiBhZGQgZHJpdmVyIHdvcmtpbmcgbW9kZQ0KPiBzdGF0dXMgc3lzZnMgZW50cnkNCj4gDQo+IE9u
IDExLzcvMjIgMTE6NTcsIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4gV2hpbGUgYW1kLXBzdGF0ZSBk
cml2ZXIgd2FzIGxvYWRlZCB3aXRoIHNwZWNpZmljIGRyaXZlciBtb2RlLCBpdCB3aWxsDQo+ID4g
bmVlZCB0byBjaGVjayB3aGljaCBtb2RlIGlzIGVuYWJsZWQgZm9yIHRoZSBwc3RhdGUgZHJpdmVy
LGFkZCB0aGlzDQo+ID4gc3lzZnMgZW50cnkgdG8gc2hvdyB0aGUgY3VycmVudCBzdGF0dXMNCj4g
Pg0KPiA+ICQgY2F0IC9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2FtZC1wc3RhdGUvc3RhdHVzDQo+
ID4gYWN0aXZlDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFu
QGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCA0
NA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMg
aW5kZXggNjk1OGM1ZmQ5ZTFjLi5lYWRjYzlkNjFkMzkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0
YXRlLmMNCj4gPiBAQCAtNjUsNiArNjUsOCBAQCBzdGF0aWMgaW50IGRpc2FibGVfcHN0YXRlX2xv
YWQgX19pbml0ZGF0YTsgIHN0YXRpYw0KPiA+IGludCBlcHBfb2ZmIF9faW5pdGRhdGE7DQo+ID4N
Cj4gPiAgc3RhdGljIHN0cnVjdCBjcHVmcmVxX2RyaXZlciAqZGVmYXVsdF9wc3RhdGVfZHJpdmVy
Ow0KPiA+ICtzdGF0aWMgc3RydWN0IGNwdWZyZXFfZHJpdmVyIGFtZF9wc3RhdGVfZXBwX2RyaXZl
cjsgc3RhdGljIHN0cnVjdA0KPiA+ICtjcHVmcmVxX2RyaXZlciBhbWRfcHN0YXRlX2RyaXZlcjsN
Cj4gPiAgc3RhdGljIHN0cnVjdCBhbWRfY3B1ZGF0YSAqKmFsbF9jcHVfZGF0YTsNCj4gPg0KPiA+
ICBzdGF0aWMgc3RydWN0IGFtZF9wc3RhdGVfcGFyYW1zIGdsb2JhbF9wYXJhbXM7IEBAIC04MTks
NiArODIxLDQ2IEBADQo+ID4gc3RhdGljIHNzaXplX3Qgc3RvcmVfcHN0YXRlX2R5bmFtaWNfYm9v
c3Qoc3RydWN0IGtvYmplY3QgKmEsDQo+ID4gIAlyZXR1cm4gY291bnQ7DQo+ID4gIH0NCj4gPg0K
PiA+ICtzdGF0aWMgc3NpemVfdCBhbWRfcHN0YXRlX3Nob3dfc3RhdHVzKGNoYXIgKmJ1Zikgew0K
PiA+ICsJaWYgKCFkZWZhdWx0X3BzdGF0ZV9kcml2ZXIpDQo+ID4gKwkJcmV0dXJuIHNwcmludGYo
YnVmLCAib2ZmXG4iKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gc3ByaW50ZihidWYsICIlc1xuIiwg
ZGVmYXVsdF9wc3RhdGVfZHJpdmVyID09DQo+ICZhbWRfcHN0YXRlX2VwcF9kcml2ZXIgPw0KPiA+
ICsJCQkJCSJhY3RpdmUiIDogInBhc3NpdmUiKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGlj
IGludCBhbWRfcHN0YXRlX3VwZGF0ZV9zdGF0dXMoY29uc3QgY2hhciAqYnVmLCBzaXplX3Qgc2l6
ZSkgew0KPiA+ICsJLyogRklYTUU6IGFkZCBkcml2ZXIgZHluYW1pYyBzd2l0Y2hpbmcgY29kZSAq
Lw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzc2l6ZV90IHNo
b3dfc3RhdHVzKHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPiA+ICsJCQkgICBzdHJ1Y3Qga29ial9h
dHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1Zikgew0KPiA+ICsJc3NpemVfdCByZXQ7DQo+ID4gKw0K
PiA+ICsJbXV0ZXhfbG9jaygmYW1kX3BzdGF0ZV9kcml2ZXJfbG9jayk7DQo+ID4gKwlyZXQgPSBh
bWRfcHN0YXRlX3Nob3dfc3RhdHVzKGJ1Zik7DQo+ID4gKwltdXRleF91bmxvY2soJmFtZF9wc3Rh
dGVfZHJpdmVyX2xvY2spOw0KPiANCj4gRG8gd2UgcmVhbGx5IG5lZWQgdG8gdGFrZSBhIGxvY2sg
dG8gc2hvdyB0aGUgZHJpdmVyIHN0YXR1cz8NCg0KWWVzLiANCkl0IG5lZWRzIHRvIGNoZWNrIHRo
ZSBjdXJyZW50IHN0YXR1cyBmcm9tIHN5c2ZzIG5vdyAgYW5kICBpdCB3aWxsIHN1cHBvcnQgdG8g
c3dpdGNoIHRoZSBFUFAgYW5kIE5vbiBFUFAgZHJpdmVyIHRocm91Z2ggdGhpcyBzeXNmcyBub2Rl
Lg0KDQpQZXJyeS4gDQo+IA0KPiAtTmF0aGFuDQo+IA0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7
DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzc2l6ZV90IHN0b3JlX3N0YXR1cyhzdHJ1Y3Qg
a29iamVjdCAqYSwgc3RydWN0IGtvYmpfYXR0cmlidXRlICpiLA0KPiA+ICsJCQkgICAgY29uc3Qg
Y2hhciAqYnVmLCBzaXplX3QgY291bnQpIHsNCj4gPiArCWNoYXIgKnAgPSBtZW1jaHIoYnVmLCAn
XG4nLCBjb3VudCk7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCW11dGV4X2xvY2soJmFt
ZF9wc3RhdGVfZHJpdmVyX2xvY2spOw0KPiA+ICsJcmV0ID0gYW1kX3BzdGF0ZV91cGRhdGVfc3Rh
dHVzKGJ1ZiwgcCA/IHAgLSBidWYgOiBjb3VudCk7DQo+ID4gKwltdXRleF91bmxvY2soJmFtZF9w
c3RhdGVfZHJpdmVyX2xvY2spOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQgPCAwID8gcmV0IDog
Y291bnQ7DQo+ID4gK30NCj4gPiArDQo+ID4gIGNwdWZyZXFfZnJlcV9hdHRyX3JvKGFtZF9wc3Rh
dGVfbWF4X2ZyZXEpOw0KPiA+ICBjcHVmcmVxX2ZyZXFfYXR0cl9ybyhhbWRfcHN0YXRlX2xvd2Vz
dF9ub25saW5lYXJfZnJlcSk7DQo+ID4NCj4gPiBAQCAtODI2LDYgKzg2OCw3IEBAIGNwdWZyZXFf
ZnJlcV9hdHRyX3JvKGFtZF9wc3RhdGVfaGlnaGVzdF9wZXJmKTsNCj4gPiAgY3B1ZnJlcV9mcmVx
X2F0dHJfcncoZW5lcmd5X3BlcmZvcm1hbmNlX3ByZWZlcmVuY2UpOw0KPiA+ICBjcHVmcmVxX2Zy
ZXFfYXR0cl9ybyhlbmVyZ3lfcGVyZm9ybWFuY2VfYXZhaWxhYmxlX3ByZWZlcmVuY2VzKTsNCj4g
PiAgZGVmaW5lX29uZV9nbG9iYWxfcncocHN0YXRlX2R5bmFtaWNfYm9vc3QpOw0KPiA+ICtkZWZp
bmVfb25lX2dsb2JhbF9ydyhzdGF0dXMpOw0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgZnJlcV9h
dHRyICphbWRfcHN0YXRlX2F0dHJbXSA9IHsNCj4gPiAgCSZhbWRfcHN0YXRlX21heF9mcmVxLA0K
PiA+IEBAIC04NDUsNiArODg4LDcgQEAgc3RhdGljIHN0cnVjdCBmcmVxX2F0dHIgKmFtZF9wc3Rh
dGVfZXBwX2F0dHJbXSA9IHsNCj4gPg0KPiA+ICBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqcHN0
YXRlX2dsb2JhbF9hdHRyaWJ1dGVzW10gPSB7DQo+ID4gIAkmcHN0YXRlX2R5bmFtaWNfYm9vc3Qu
YXR0ciwNCj4gPiArCSZzdGF0dXMuYXR0ciwNCj4gPiAgCU5VTEwNCj4gPiAgfTsNCj4gPg0K
