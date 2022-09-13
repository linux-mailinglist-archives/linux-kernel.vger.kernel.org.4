Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF215B7695
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiIMQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiIMQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:37:00 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8c::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D480FB6D73;
        Tue, 13 Sep 2022 08:31:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1brjs9E1PCNjxjbYrmPOkSRVClp/GedbgGLFxOnspsYgodH23Gj2bw50T7YYP24dz27rmOGf0KwpkknEPRb/e+Hq6+QLm2OI3BTAMqxKY1MuFs1u9wS7BQ5oZDDWLyILfBBqChkEY1RvCRZ+EMoYv3wP/3EYbSvtcTtRMD0JxrthfloBrf0KPsQAiLObhIKZJnnnJu5IA7HkeuboLqFbIyopWND9307iAP06xTbJgIu4phbNRI+JS0dQzMYD2OKILhN260cXmWvNVa7I6Mk6mYUn50t56yTlBTfLQOMh2L9Ii5pt9WNJS8EQCiYG4AolWP8yozyjfk3abDVZf0LRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeqvKpeQ7tAzozC8yhK4Fc4X+LQhGgykDzjjNHiAabQ=;
 b=VWmWa4dVDUCilXbsb30PBcifn7s1S40KvLunammvAj0zX7NGEsXxHXZAteEKDCMnIlsPWhwaZoRm9YgHVQqdpm5bizk0znRQLX/ZFzcCr0zibQCLOkrW/cMSnHskeJyeeomNKoUq+qxkia5UwjSD2HiWHudjWkSPiefVO+ygwCKgOip5mvvUuCwHsjaMyvF+fdjE6HcEf/7Qz+woE4fnBfb9BSUp9gNGSnlqpJzJfZfRM/58lVukLem4IGrymIcpvg6JiteV3mNiuv7f7X2FBVqcAPFhiwOiDdX3+7UAIUoQZC5k+A4SHDfV9SUPXHw6dG9jidMyBqqC7ku9/J/7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeqvKpeQ7tAzozC8yhK4Fc4X+LQhGgykDzjjNHiAabQ=;
 b=FVboeKw9cx2BKIw4KYzjbXFhDzgTBCvlAjdwS/bA1A7+eMqDLHHLu59IqBXyLdGazRWvNTTbg5BhoBM7YgOks26EqE+26EwTt3q8sifdsQ5/hIZksf+VO0fqqnmoehUvA/4agu/tGT525qWzp/mnlA5YgMXeAWicLixDiqZTJ18=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 15:28:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3565:585c:3431:216c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3565:585c:3431:216c%7]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 15:28:34 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
Thread-Topic: [PATCH v2 3/3] ata: ahci: Skip 200 ms debounce delay for AMD 300
 Series Chipset SATA Controller
Thread-Index: AQHYPWp+2eAC0XLlKkGwEMOfwwgcjqzKYAEwgAILTACAAB/rAIAAGMyAgAADa4CADPjgAIAAjBuAgABoqYCAACLfgIBe4WeAgAEXX4CAjXPcgIACbmyAgBP7p4CAAAE4EA==
Date:   Tue, 13 Sep 2022 15:28:34 +0000
Message-ID: <MN0PR12MB6101E77F03E5A21AEC8A5D6DE2479@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220321212431.13717-1-pmenzel@molgen.mpg.de>
 <20220321212431.13717-3-pmenzel@molgen.mpg.de>
 <BL1PR12MB5157DDFD5E75360F032346D3E2169@BL1PR12MB5157.namprd12.prod.outlook.com>
 <cc7b4426-f6a6-e6b1-4aaf-0a713ee3d388@opensource.wdc.com>
 <5fb6af7b-d84f-cbae-7eb1-543f3a7e53e4@molgen.mpg.de>
 <d9837420-1cbb-ed5e-7043-985d9eb9d065@opensource.wdc.com>
 <b3e4435d-335c-1aba-1920-c225b46d09e7@molgen.mpg.de>
 <f6c78650-f22f-fcaf-a660-b1fc4ea7f641@molgen.mpg.de>
 <22f69d9a-7d0d-a408-70b3-11295f14b82d@opensource.wdc.com>
 <67950993-2eb9-c180-7c80-98c9954c9b22@molgen.mpg.de>
 <85f8c8cb-b4b9-b3ed-e79f-a1a161c9b672@opensource.wdc.com>
 <65012735-0a92-1071-e8e0-9d101c247a64@molgen.mpg.de>
 <3135eed0-b7e3-42fa-5b6c-80360f34e428@opensource.wdc.com>
 <893fe832-d522-112e-53ec-0f030c15af0d@molgen.mpg.de>
 <318b0452-9814-6276-95a5-10478e5a1b7d@opensource.wdc.com>
 <178704d0-b5fd-f750-b77e-fece6c6d81dd@molgen.mpg.de>
In-Reply-To: <178704d0-b5fd-f750-b77e-fece6c6d81dd@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-13T15:27:48Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1c61af36-c934-4222-91a4-0eb9c6f99703;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-13T15:28:32Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 09c42ab2-ed27-4d9e-ac30-024bf618ff08
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|PH0PR12MB5608:EE_
x-ms-office365-filtering-correlation-id: 9aacdec0-a72f-4562-b810-08da959c9f50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M6wohccedsc6Rn5xcud/eAUxbFpM0OTSFQQJoDfUvMcNVs49Bk3PvvdelFAlj4GCadgQE4skzIz5JxkBsz2OyfvVdEdX472sjYxrDcaTh2RG4wb4imDJyRxtL+IjijSywOlA9WDSVGUPhlQjkrFcvYr5lrJBkoHrbyT2MGIQWTwYiaQ0K1UTVhu8tFSNZaZ2ianf94Wgx7aQF528m4n8Ayc0Px8zgNo88qy82Tee1RaY8y87zKZWv1HCPG8Go78IRM5grzfAq0v5grLx8XTfnD0BqsZxB8ZMMEQlI+QfSw0MmUBX6EoCmE7UztbVnXOptp5SwfykTEhhyJCZ7PTv1vlXoslx+kFFxZSB30sh3f3Sg62zRL32uSS2YqBSZNrQ/K2G621ZADEhzRu84hMz/GEDttKQxch27UYyfTJI8voRfGvBRtwdX1pjiljTZICjgzIWRyUxQdixxCFWch274+qoEt0J4q/P0cuuDoddpPF31rQXNVEa67h55+5zFwB+1kgP4w62BWh/aBQzMcDEKfLKbDbhTRq8jxt6xdzNgptjlMI/IT8P3Q4FdN0I2QvDWG6WmXBtSMbpXl2/XhJJyk8Gtfbh3EZmSMhMR25VQtDuSTNRw9BLYUHG0kITJl2/XgTC4DcQdFztIAbJQaRtxAq1sYCJP85YHiYjPeNQLPJBYvkBT6rpmsAN92bTmxNiA8cDZ7i7MP8TCEucdo8i1up92OFUn5woDwiN5y4kqhZXKkrauCOdmxdry/azHZxB5k9ddDxgcaC0vMIC3YHXPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(54906003)(26005)(55016003)(71200400001)(9686003)(8936002)(316002)(110136005)(83380400001)(66446008)(8676002)(52536014)(33656002)(41300700001)(66476007)(64756008)(4326008)(86362001)(53546011)(5660300002)(76116006)(66556008)(66946007)(6506007)(38070700005)(186003)(7696005)(122000001)(2906002)(38100700002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjIyNkJvTXdxS3g3MHN5UGlDelpvSklhR0tNWXduUGNJS1NOZ0FjVWI1b3p5?=
 =?utf-8?B?R2lBWVlIamVoYzhLOEd1OW92WDl2THY2ZGRNKzh6Z3FVVnhNSXVTUGxlbGti?=
 =?utf-8?B?bmpwM0s0MXlVYXk4ZzFjSUxmM05yWGs2cFFCRDhIa01oZzduRGo1cHRUWnd6?=
 =?utf-8?B?bStQTitRN3pMZDNXKzczcjhKemoyNC9Fd0JIdXIzTndQZnBsRXJLNTZVK0xR?=
 =?utf-8?B?UDdzT0hsY2VCTmRVaEx2bFRxcVJBLzgvV1k4WS9FNGlTa2Y1N0MzeGgvUGNv?=
 =?utf-8?B?U3A0N3hlUGNsZ1kvMG04YlNRaDc3QXZSenN6NTN6OE00Q1ZBbHU2dG5SNEo2?=
 =?utf-8?B?NnlhWlhlM0FWd0UyQzBYcjhVSTg2azZoUlZ5dEp5MlZSMXJPYUxQaktuRGN2?=
 =?utf-8?B?SGxTZVYrQ2hRYzVKOWpxTHYvekVrVXFDTkpWZkMycUlJeVBtTmtpSm1yREVq?=
 =?utf-8?B?QkcxamF5MlY1YlZsZGtCZk1GZ1laaHJBbUMrcEw5b3M3TmN0V1VzSHkvUVVM?=
 =?utf-8?B?NkZrV2hQeU94YXMzb3hTaVpwK1oxMS9odmRyQzV5Wlg2dldlWGpvZFErekgr?=
 =?utf-8?B?MnYxamhYZ0VpSUVhQzZWOHluVGU5cExpWTExRldNV3AzQk5GZWY3eExtWCsy?=
 =?utf-8?B?ektHODdJakMrbGtKZExHK0dQMFl0ZVBLSXFwTDRyZC9MMWFLVUx4R0VheXFP?=
 =?utf-8?B?Zi9rQTlZSzY3dzhUU0tLUVptaEwzZFFiNVBCanQwUFlISTNPV2ZhY2RqeHNh?=
 =?utf-8?B?TnFGbm55RXNKL3kzT1paM3FRRVRaM0U0U3V0ZmhZRzN5V0tKeGpqbVcrMzRs?=
 =?utf-8?B?ME8veXVyNy8xTU5BeXNtWG1MWndVUGZNRFZwUmlkaEpPY1ZsSEFDS2cxT1Rn?=
 =?utf-8?B?ZnJmL3JPTm5qU2RjOXhPT3RzdDM1YnFGOVFPQlVCMzRvbmRveDIvWHpkbC9O?=
 =?utf-8?B?ZU5FbExQYktNUmwxQXRzUlVkMEx6c01MUTcvSHFpR2dJckIyYWQ5cDVZM04x?=
 =?utf-8?B?a3FLVXdGV0ZpN2xBZlE1M1RiZ29oeG5QVEd4V2NtYmxvZWFHcHh1ZFVFQ2Ru?=
 =?utf-8?B?TXFnRm9QTGhrNzJLSUI5VkJFZGJGbGh6VytDUmdPajJXNkVmNnJyajRCVmdY?=
 =?utf-8?B?NGhJNy9hcXgxSFoxalBQb0NKMWZhMVk0U0RTS05aT1hoc0luV0taZjRZRkhR?=
 =?utf-8?B?MUpTc2Q3eFFsOVp0TzdkVXI4QWIvSkh4VkFjUmdaZ09vbExxbGhOZzZMOFM1?=
 =?utf-8?B?QmlqWmFXNXA2TFJGRDVJNlRleEMxUk82MVBIeVR2T2JHNFFrM2FoZjAraFh4?=
 =?utf-8?B?VE4rTVZSaFdvaGRwcmNLOERFcmJlMUF3Y1pZcmRuM0k3TVJtTlk0UThSb0Vi?=
 =?utf-8?B?Y0tvVXBxKzBrWThKNzcrL3lVY3JNNkFFTG9vZVR5U3JDTjYyZnRRRDV6dzB2?=
 =?utf-8?B?bC9xUzNwQldLR1g1QzN2OWlMSlJtRlc0WGw2MXFZTXpwQmxkd3l1bG4zTVZw?=
 =?utf-8?B?dU81QTVydUIrdmwweVJjNGY4NFp6bmhTN3p0eTR6MytOZEJlaUNUYmtraHVW?=
 =?utf-8?B?d1VtSXora3FHSmQraGgwK09McFI4V1JwUll1WW1uNzBzeUlnT3lYeHg4NmVE?=
 =?utf-8?B?dVpKanMvT3JIenFxREVyL2QzeHNpWVRaVWlIaTNyb0lMWkJPbFdMaTByTXZC?=
 =?utf-8?B?VGNLaXhZa0EycEtMSFJVL3ZCaHV2dmJQaVVTSkdQVzdKT0VndjNQNXRkZjho?=
 =?utf-8?B?amsvekpZcE9kTkY0Q2FTblo5dm04ak1XSHQreGgrcEErOWNad21OMnU5cjNN?=
 =?utf-8?B?TnFkaERrVEJ2K3VkZzNYbHZJRElwd0tsZ1hHdDQvN0dEK3BGU0I5MkxmOEVC?=
 =?utf-8?B?ZzlOSTNDYmNFU0ZvU1F1ejI4MUhrNWdGbmV1djFGMENVbWNhL1c5TEVrWUJp?=
 =?utf-8?B?R1c4WFMyUUhWUERLRUpiOUhaR3FwdHhZL3hLYWRZc2hVN2ZxN3BmOGZ2SUZD?=
 =?utf-8?B?WmxKRnExQnRQeVpiOHdacnY5ZW10V2NmQjZveVRCa0R2bTFyNXhiYTRxUzlT?=
 =?utf-8?B?ZHNna1pUNW1ncUdncmhsVjBKOVF3YlBpTmZkeW1OWHlUbG1PU3ZoeVlQM1FP?=
 =?utf-8?Q?Ynbc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aacdec0-a72f-4562-b810-08da959c9f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 15:28:34.6338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4IKvFCYUKuv7mQsLK5OwaDn7dkCwV8jYHxYotTKyykOmAapT2Zj98Lm3r12vJeZO9Le/MyiMGv+ybGvlFfhNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1
bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVt
YmVyIDEzLCAyMDIyIDEwOjIzDQo+IFRvOiBEYW1pZW4gTGUgTW9hbCA8ZGFtaWVuLmxlbW9hbEBv
cGVuc291cmNlLndkYy5jb20+DQo+IENjOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9u
Y2llbGxvQGFtZC5jb20+OyBIYW5zIGRlIEdvZWRlDQo+IDxoZGVnb2VkZUByZWRoYXQuY29tPjsg
bGludXgtaWRlQHZnZXIua2VybmVsLm9yZzsgTEtNTCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy8zXSBhdGE6IGFoY2k6IFNraXAg
MjAwIG1zIGRlYm91bmNlIGRlbGF5IGZvciBBTUQgMzAwDQo+IFNlcmllcyBDaGlwc2V0IFNBVEEg
Q29udHJvbGxlcg0KPiANCj4gRGVhciBEYW1pZW4sDQo+IA0KPiANCj4gQW0gMDEuMDkuMjIgdW0g
MDA6MTMgc2NocmllYiBEYW1pZW4gTGUgTW9hbDoNCj4gPiBPbiA4LzMwLzIyIDE4OjA1LCBQYXVs
IE1lbnplbCB3cm90ZToNCj4gDQo+IFvigKZdDQo+IA0KPiA+PiBBbSAwMS4wNi4yMiB1bSAxMDo1
OCBzY2hyaWViIERhbWllbiBMZSBNb2FsOg0KPiA+Pj4gT24gNi8xLzIyIDAxOjE4LCBQYXVsIE1l
bnplbCB3cm90ZToNCj4gPj4+Pj4+PiBXaXRoIHRoYXQgaW4gbWluZCwgSSBhbSBub3QgcGxhbm5p
bmcgdG8gYXBwbHkgeW91ciBwcmV2aW91cyBwYXRjaGVzDQo+ID4+Pj4+Pj4gZm9yIDUuMTgsIGFz
IHRoZXkgd291bGQgY29uZmxpY3QgYW5kIHdvdWxkIG9ubHkgZW5kIHVwIGJlaW5nIGNodXJuDQo+
ID4+Pj4+Pj4gc2luY2UgdGhlIGRlbGF5IHJlbW92YWwgYnkgZGVmYXVsdCB3aWxsIHVuZG8geW91
ciBjaGFuZ2VzLg0KPiA+Pj4+Pj4gT2J2aW91c2x5LCBJIGRvIG5vdCBhZ3JlZSwgYXMgdGhpcyB3
b3VsZCBnaXZlIHRoZSBhIGxpdHRsZSBiaXQgbW9yZQ0KPiA+Pj4+Pj4gdGVzdGluZyBhbHJlYWR5
LCBpZiBjaGFuZ2luZyB0aGUgZGVmYXVsdCBpcyBhIGdvb2QgaWRlYS4gQWxzbywgaWYgdGhlDQo+
ID4+Pj4+PiBjb25mbGljdCB3aWxsIGJlIGhhcmQgdG8gcmVzb2x2ZSwgSSBoYXBwaWx5IGRvIGl0
ICh0aGUgcGF0Y2hlcyBjb3VsZA0KPiA+Pj4+Pj4gZXZlbiBiZSByZXZlcnRlZCBvbiB0b3Ag4oCT
IGdpdCBjb21taXRzIGFyZSBjaGVhcCBhbmQgZWFzeSB0byBoYW5kbGUpLg0KPiA+Pj4+Pg0KPiA+
Pj4+PiBUaGUgY29uZmxpY3QgaXMgbm90IGhhcmQgdG8gcmVzb2x2ZS4gVGhlIHBvaW50IGlzIHRo
YXQgbXkgcGF0Y2hlcyBjaGFuZ2luZw0KPiA+Pj4+PiB0aGUgZGVmYXVsdCB0byBubyBkZWJvdW5j
ZSBkZWxheSBjb21wbGV0ZWx5IHJlbW92ZSB0aGUgY2hhbmdlcyBvZiB5b3VyDQo+ID4+Pj4+IHBh
dGNoIHRvIGRvIHRoZSBzYW1lIGZvciBvbmUgb3Igc29tZSBhZGFwdGVycy4gU28gYWRkaW5nIHlv
dXIgcGF0Y2hlcw0KPiBub3cNCj4gPj4+Pj4gYW5kIHRoZW4gbXkgcGF0Y2hlcyBvbiB0b3AgZG9l
cyBub3QgbWFrZSBtdWNoIHNlbnNlIGF0IGFsbC4NCj4gPj4+Pj4NCj4gPj4+Pj4gSWYgdG9vIG1h
bnkgcHJvYmxlbXMgc2hvdyB1cCBhbmQgSSBlbmQgdXAgcmV2ZXJ0aW5nL3JlbW92aW5nIHRoZQ0K
PiBwYXRjaGVzLA0KPiA+Pj4+PiB0aGVuIEkgd2lsbCBiZSBoYXBweSB0byB0YWtlIHlvdXIgcGF0
Y2hlcyBmb3IgdGhlIGFkYXB0ZXIgeW91IHRlc3RlZC4gTm90ZQ0KPiA+Pj4+PiB0aGF0ICphbGwq
IHRoZSBtYWNoaW5lcyBJIGhhdmUgdGVzdGVkIHNvIGZhciBhcmUgT0sgd2l0aG91dCBhIGRlYm91
bmNlDQo+ID4+Pj4+IGRlbGF5IHRvby4gU28gd2UgY291bGQgYWRkIHRoZW0gdG9vLi4uIEFuZCBl
bmR1cCB3aXRoIGEgbG9uZyBsaXN0IG9mDQo+ID4+Pj4+IGFkYXB0ZXJzIHRoYXQgdXNlIHRoZSBk
ZWZhdWx0IGFoY2kgZHJpdmVyIHdpdGhvdXQgZGVib3VuY2UgZGVsYXkuIFRoZQ0KPiBnb2FsDQo+
ID4+Pj4+IG9mIGNoYW5naW5nIHRoZSBkZWZhdWx0IHRvIG5vIGRlbGF5IGlzIHRvIGF2b2lkIHRo
YXQuIFNvIGZhciwgdGhlIGFkYXB0ZXJzDQo+ID4+Pj4+IEkgaGF2ZSBpZGVudGlmaWVkIHRoYXQg
bmVlZCB0aGUgZGVsYXkgaGF2ZSB0aGVpciBvd24gZGVjbGFyYXRpb24sIHNvIHdlDQo+ID4+Pj4+
IG9ubHkgbmVlZCB0byBhZGQgYSBmbGFnIHRoZXJlLiBTaW1wbGVyIGNoYW5nZSB0aGF0IGxpc3Rp
bmcgdXAgYWRhcHRlcnMNCj4gPj4+Pj4gdGhhdCBhcmUgT0sgd2l0aG91dCB0aGUgZGVsYXkuDQo+
ID4+Pj4+DQo+ID4+Pj4+PiBBbnl3YXksIEkgd3JvdGUgbXkgcGllY2UsIGJ1dCB5b3UgYXJlIHRo
ZSBtYWludGFpbmVyLCBzbyBpdOKAmXMgeW91ciBjYWxsDQo+ID4+Pj4+PiBhbmQgSSBzdG9wIGJv
dGhlcmluZyB5b3UuDQo+ID4+Pj4NCj4gPj4+PiBJIGp1c3Qgd2FudGVkIHRvIGlucXVpcmUgYWJv
dXQgdGhlIHN0YXR1cyBvZiB5b3VyIGNoYW5nZXM/IEkgZG8gbm90IGZpbmQNCj4gPj4+PiB0aGVt
IGluIHlvdXIgYGZvci01LjE5YCBicmFuY2guIEFzIHRoZXkgc2hvdWxkIGJlIHRlc3RlZCBpbiBs
aW51eC1uZXh0DQo+ID4+Pj4gYmVmb3JlIHRoZSBtZXJnZSB3aW5kb3cgb3BlbnMsIGlmIHRoZXNl
IGFyZSBub3QgcmVhZHkgeWV0LCBjb3VsZCB5b3UNCj4gPj4+PiBwbGVhc2UgYXBwbHkgbXkgKHRl
c3RlZCkgcGF0Y2hlcz8NCj4gPj4+DQo+ID4+PiBJIGNvdWxkLCBidXQgNS4xOSBub3cgaGFzIGFu
IHVwZGF0ZWQgbGliYXRhLmZvcmNlIGtlcm5lbCBwYXJhbWV0ZXIgdGhhdA0KPiA+Pj4gYWxsb3dz
IG9uZSB0byBkaXNhYmxlIHRoZSBkZWJvdW5jZSBkZWxheSBmb3IgYSBwYXJ0aWN1bGFyIHBvcnQg
b3IgZm9yIGFsbA0KPiA+Pj4gcG9ydHMgb2YgYW4gYWRhcHRlci4gU2VlIGxpYmF0YS5mb3JjZT14
Lnk6bm9kYmRlbGF5IGZvciBhIHBvcnQgeSBvZg0KPiA+Pj4gYWRhcHRlciB4IG9yIGxpYmF0YS5m
b3JjZT14Om5vZGJkZWxheSBmb3IgYWxsIHBvcnRzIG9mIGFkYXB0ZXIgeC4NCj4gPj4NCj4gPj4g
VGhpcyBpcyBjb21taXQgM2FmOWNhNGQzNDFkIChhdGE6IGxpYmF0YS1jb3JlOiBJbXByb3ZlIGxp
bmsgZmxhZ3MgZm9yY2VkDQo+ID4+IHNldHRpbmdzKSBbMV0uIFRoYW5rIHlvdSwgdGhpcyBpcyBy
ZWFsbHkgdXNlZnVsLCBidXQgZWFzaWx5IG92ZXJsb29rZWQuIDstKQ0KPiA+Pg0KPiA+Pj4gSSBz
dGlsbCBwbGFuIHRvIHJldmlzaXQgdGhlIGFyYml0cmFyeSBsaW5rIGRlYm91bmNlIHRpbWVycyBi
dXQgSSBwcmVmZXIgdG8NCj4gPj4+IGhhdmUgdGhlIHBvd2VyIG1hbmFnZW1lbnQgY2xlYW51cCBh
cHBsaWVkIGZpcnN0LiBUaGUgcmVhc29uIGlzIHRoYXQgbGluaw0KPiA+Pj4gZGVib3VuY2UgZGVw
ZW5kcyBvbiBQSFkgcmVhZGluZXNzLCB3aGljaCBpdHNlbGYgZGVwZW5kcyBoZWF2aWx5IG9uIHBv
d2VyDQo+ID4+PiBtb2RlIHRyYW5zaXRpb25zLiBNeSBwbGFuIGlzIHRvIGdldCB0aGlzIGRvbmUg
ZHVyaW5nIHRoaXMgY3ljbGUgZm9yDQo+ID4+PiByZWxlYXNlIHdpdGggNS4yMCBhbmQgdGhlbiBm
aXggb24gdG9wIHRoZSBhcmJpdHJhcnkgZGVsYXlzIGZvciA1LjIxLg0KPiA+Pg0KPiA+PiBOaWNl
LiBDYW4geW91IHNoYXJlIHRoZSBjdXJyZW50IHN0YXR1cz8NCj4gPg0KPiA+IE5vIHByb2dyZXNz
LiBJIG5lZWQgdG8gcHV0IHRvZ2V0aGVyIGEgc2VyaWVzIHdpdGggYWxsIHRoZSBwYXRjaGVzIHRo
YXQNCj4gPiB3ZXJlIHNlbnQgYWxyZWFkeS4gVW5sZXNzIE1hcmlvIGNhbiByZXNlbmQgc29tZXRo
aW5nID8NCj4gDQo+IE5vIHJlcGx5IGZyb20gTWFyaW8uDQoNCkkgdGhpbmsgd2hhdCBoYXBwZW5l
ZCBoZXJlIGlzIHRoZXJlIHdhcyByZWxhdGVkIHBhdGNoZXMgZnJvbSBhbm90aGVyIHBhcnR5DQp0
aGF0IGdvdCB0YW5nbGVkIHVwIHdpdGggdGhpcy4NCg0KPiANCj4gPj4+IElzIHRoZSBsaWJhdGEu
Zm9yY2Ugc29sdXRpb24gT0sgZm9yIHlvdSB1bnRpbCB3ZSBoYXZlIGEgZmluYWwgbW9yZSBzb2xp
ZA0KPiA+Pj4gZml4IHRoYXQgY2FuIGJlbmVmaXQgbW9zdCBtb2Rlcm4gYWRhcHRlcnMgKGFuZCBu
b3QganVzdCB0aGUgb25lcyB5b3UNCj4gPj4+IGlkZW50aWZpZWQpPyBJZiB5b3UgZG8gaGF2ZSBh
IHVzZSBjYXNlIHRoYXQgbmVlZHMgYSAibm9kYmRlbGF5IiBob3JrYWdlDQo+ID4+PiBkdWUgdG8g
c29tZSBjb25zdHJhaW50IGluIHRoZSBmaWVsZCwgdGhlbiBJIHdpbGwgYXBwbHkgeW91ciBwYXRj
aGVzLCBidXQNCj4gPj4+IHRoZXkgbGlrZWx5IHdpbGwgYmUgdm9pZGVkIGJ5IGNvbWluZyBjaGFu
Z2VzLiBMZXQgbWUga25vdy4NCj4gPj4NCj4gPj4gSSB0aGluaywgYXBwbHlpbmcgdGhlIHBhdGNo
IHdvdWxkIGJlIGFuIGltcHJvdmVtZW50LCBhcyBwZW9wbGUgd291bGRu4oCZdA0KPiA+PiBuZWVk
IHRvIHVwZGF0ZSB0aGVpciBMaW51eCBrZXJuZWwgY29tbWFuZCBsaW5lLCBhbmQgSSBkbyBub3Qg
bWluZCwgaWYgaXQNCj4gPj4gZ2V0cyByZXZlcnRlZC9kcm9wcGVkIGxhdGVyLg0KPiA+DQo+ID4g
TGV0J3Mgc2VlIHdlcmUgdGhlIGxwbSBzdHVmZiBnb2VzIGZpcnN0Lg0KPiANCj4gSXQgc2hvdWxk
buKAmXQgYmUgdG9vIG11Y2ggaGFzc2xlIHRvIGFkYXB0IHRoZSBscG0gc2VyaWVzIGFmdGVyIHRo
ZSBwYXRjaA0KPiBpcyBhcHBsaWVkLg0KPiANCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBh
dWwNCg==
