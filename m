Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE45670E1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjEWQV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjEWQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:21:56 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17064C2;
        Tue, 23 May 2023 09:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0Gewo6qV0Gf/kZB7w/5WM/6qtjJWiI7YQSmqzK3p2ko6eqZNj8PBVtj0LxSju06JFQ9M94tutNbGt4J7iJRKE82xE2H+Axdl1WIeFLWf6qSf28TI6IGTv771aAxqHyrFMA93u5MaY8tVCsJ1KgDkOnEybM+hM1V/FUKl1OKISCUu7fAq9xIu4JETbWwtj5PURWsxcwJyI0iBIH3hMi1og3ZwOIlFdkEWpONsv890w1hunAWmm+T6WPV/lH4erQwice9MwakjeCBl1Njnh+yH721KLrRzq+2NgjInmUWkRS2aGVhhg/qZPuUNz8cWJ2hmZ2kY0JAvpEtktwSVqiNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDfa9WAPKINIqiEEJyVrQJrYm4MSCE59jhmwv/9xEu4=;
 b=EKUFF5xSmroL1JE63YHA+EOz6RvWKh98RRdqv2Tnret30ekglNQDA06M3ANtVJB7okBcmpTb1cUj0LaPJVD0jpuYpioHdxo9dC6FY7o5rXUcxkeY3k+cyySMfCvEl+ifckWRQZkJFCwzs2nEBa7tv8b/UAmX2KRPzRX5eK7GyMgdpQR7c7M8x/UWOUyeOcqQNd4WLcqIk3CUVr7RZmNrwSpZzmGvy4uOf6EP6JPQHzawsm6eEUgpMiDd1meXjmvldsjzRYVRN2/rq3eBrOjOdJtQC+VJykmac2ZLROWhk4k57QwZFsMd5rbcLhwO3STEtpz7zU5eqzToyyVvL+I94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDfa9WAPKINIqiEEJyVrQJrYm4MSCE59jhmwv/9xEu4=;
 b=z4thj7ur4WZ2pLQ/D/Pi7sLyQieG118VwWFYywXDBMmjE0FQM5Qj2/6iE1POm3Gan9vzvu++4+gG6lJXHru9CgREMBoBx5Dr/Ah4qLUXWXbUxYDjX1m8ryRqxvMF1xhcj6dcQGDren46HXPzq+GT2KgcbmZLOvJRYDsrfsMgJzE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 16:21:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 16:21:46 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>
Subject: RE: [PATCH v2 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for suspend
 related messages
Thread-Topic: [PATCH v2 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for
 suspend related messages
Thread-Index: AQHZjOgu2opSNqO3nUevgx/MFRVcwq9ns74AgABXZAA=
Date:   Tue, 23 May 2023 16:21:46 +0000
Message-ID: <MN0PR12MB6101AF7606A3547EC5AA42A7E2409@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230522200033.2605-1-mario.limonciello@amd.com>
 <20230522200033.2605-4-mario.limonciello@amd.com>
 <e9eb526d-84fe-b814-67a3-6f7977aa0078@redhat.com>
In-Reply-To: <e9eb526d-84fe-b814-67a3-6f7977aa0078@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=72d251fc-cb83-4065-855b-d29969be4f8b;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-23T16:20:22Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8718:EE_
x-ms-office365-filtering-correlation-id: 16c6da46-41fd-4e7f-3167-08db5ba9ce22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GG5nq1Kl1ekB+2qBPvxduuYjNsoTUbaoT/LVwG0GO6tP7evi1CBTFscnvpPH8p88N7ybDbf38sfU70t8YAZ1P/6rjtwxHtVCUwUjThyREz+V0PW+oGeXsTtHLbdeXlB8Ejmlu43gb936v8Xs8Qpxd6QLiYQaat6QLE3cCH6UJBpo+4TSERMjdU4PMPXsvT/LsOtdjI2Lh0rcBoeinrE/ONJLtkjbGA9msRb75Llss7pvQDhvfM+UdTC6CYwnik/zGwaQgOxjM3TbXEM4KfDgQyVgpp37ykMQZIcHDsnlRh8R7gU2/uCYLZeY1+06bLads3ulUSqWnHz7BEIN6WCMo7XDCnSv08ZsjWgynNl27KQIzaONTcSivuwL+sV19MLmN4SJ2qJRAke2NIQ4lKVDNXhgdJy1uJsLRrgdgBf6Wxy3IlMrDabAZN3Lz4MLaIWsAymHgnRXaO4Pi7LzqSuisTCaxbAhPlNnRU6xZeZQdZtes1ku76SjcOytEqEnrfMZKMrPrMGSO2fSxYFQGGP00kZDq4/4Y9xiuKdrfxL1X2tm3+y6uqBLYHK36vVSyPIRuZYV37yDWPYBH8zFnXf/eCFs5ZXbBaYFLmOgiBISfHjmJHcJHiP3VVqgZY8RGACB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(316002)(110136005)(54906003)(4326008)(64756008)(66556008)(66476007)(66446008)(71200400001)(66946007)(122000001)(76116006)(41300700001)(7696005)(478600001)(38070700005)(38100700002)(86362001)(5660300002)(52536014)(8936002)(8676002)(186003)(55016003)(53546011)(26005)(6506007)(9686003)(33656002)(15650500001)(83380400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDBoSFRlUDg4aFpzbm9xZC8vOTl2a1FBa0FjVHI4Si9VYTUxLzc2WUZlYTFy?=
 =?utf-8?B?WUtudFFpUUhiVGQ4eDdxdU9OOXFmcklmaG8xL2gzTnFlcFQ1NE1xellDSWtQ?=
 =?utf-8?B?NjdTVGRPK2tZNXdKaENKTnllOGNmSW5OTDVnTVFGWlcrMy9hQ3NYREpzVU5m?=
 =?utf-8?B?WGd5eE01UW5JcnhVUVB1S2I4TlFENXVSWHRHRWFrcVRqRUt0UGwySnRmU1NH?=
 =?utf-8?B?Z3JKNy8vcG1xVTV5c09nZXJMT2dkK01HaTNxTWhlWHh2dnVvMXdGdGtZS09o?=
 =?utf-8?B?cm9QdlRQZGhrenBXRTZIWWVjYnVRbytQMnhZczhkY1ZTNVdIUW9vYngvOUtr?=
 =?utf-8?B?RUVudEVJdzQ2NlVNbDRWN2l0cXJEYVplVUtIYThVemttdDFFT0U3VzVMM3VY?=
 =?utf-8?B?NXY2VHlPdW9ldnBrRk9zbEdLb0crSjZRcW4wNGg3MkU0Q3NtbVFvSWhlWWlm?=
 =?utf-8?B?TDRmb1hvQk9yMjR2R21JUnl3SWtCOWN5QUxndGt5S3R2S1YzVTkyb0RnTFJL?=
 =?utf-8?B?WTMyYTY0Um53dWVxbjMvWUFkNFFGU0x1T0d3VzZGL1duZ083ZkxUb0FLZjRa?=
 =?utf-8?B?UER4bXd6TUtXbnYwK01NQzBDTEJPRjV0UU5sWVAzSW4zTDdHRTdqL0VHU1lL?=
 =?utf-8?B?MjZ5NmhxYUdWQWxvYVQxdFFrSTBITkc0WVZWUFdnOUJDSEZBYzZ4RnNkcEw3?=
 =?utf-8?B?OWRKN1ZMcWQwZ3Z3eGZPU3I3cFlPLzJjYWdESGxka2pqbWlHTG01Z1p2cVpY?=
 =?utf-8?B?OUxETFUwS2JZa09QQy9GR1BkSHBRRHR4dVY1emQzWlV4c1NHTjRrQ0NhM2Nu?=
 =?utf-8?B?bFhuLzhqQnp4TU1pSWdRUUFibFhZMzlCdU5jdEtqWDU4OHBiR3FNSFd2TXZw?=
 =?utf-8?B?MGNFUGM5SVFFYlZ2T1I2RGlyRFVmY3E0YldBMktkRko1d1VvZWJxd2ZSQS9S?=
 =?utf-8?B?TWdWb1c5VG5EelRHTUc1MVRlS2ZCd0JaUWNDWG9reHJKQXNSWW9xMjdFQlc0?=
 =?utf-8?B?U1pVYlpZdHpIM09iSWtVTlQzblYvdFN0MlJuWTRwTjlHbnZOTFgyMzUvY3dw?=
 =?utf-8?B?amZLV2l2S3VQRzZIU0kvZlkzRWtPdGJnbjNYQ2t1UDA4UUZvekZTZ0sxUkpl?=
 =?utf-8?B?eXRFcEFORVpKbjFxNUlCY1hiTG53OXc1ZUIxYzVKY3UydUcrZ212eTQ4QlhZ?=
 =?utf-8?B?WEovbFNPTW0rMUVaVUJ1Z0pnT2tKTmgzdFkvTjF1NFlQYXdCdGdlbmNVUjBV?=
 =?utf-8?B?VktjcXRRVk9oeFQrMGNvWkR5cFJnWDRaVkZmc0VjZDZKMlNEc2NaTzFnZEsy?=
 =?utf-8?B?dFBodkhGVDNtWFVmY0x3czlXckRzckxqLzQ2RkUzZ0VSbFROdklGa1BCOCtR?=
 =?utf-8?B?eWpnTWVjYUgyU2ZENGg1bE1ud0NZMUIzNlNHVEh5QlNyWC9NNzdUOUJzQlJG?=
 =?utf-8?B?eXJORTgwSW15VGtNaklGSitvUWh4NkZRWE5tTi94aitrWWRhdml6U2g1aUt0?=
 =?utf-8?B?K3FhMzBzL1ZZU1VvWkdFZjFzQnRtSC9iQ1c0dU5zeGlwa2lmdkdVcEhIR3lu?=
 =?utf-8?B?ZlJ1THMveEdCR296d0hRUDg2ZWQzZGkvSHRpdnFEV2lkZ21qaWNLZE9pMWJI?=
 =?utf-8?B?VTFqVFN6Y1FGU0JZZk94a1c5WHlyN1JTeXpjY2tURDFoMWRsL0dIZWNiblVF?=
 =?utf-8?B?dUZteHYxWVE5dzdoRHZKQkxYeDlTKzI5RVRwV01wQmNlRXpySXpiTHY4QzNw?=
 =?utf-8?B?bGxqcWQvYVRuQWhOMXZiV1pkSk1OcUE1Z3I0QUZ1aWFjbWJFQXdjVzZuTEdX?=
 =?utf-8?B?dnFVamF0VVBVR0F2MnlxaHE3QkJMdk9Od2poY1NEVjdHb2NWZjVodjFYRnE0?=
 =?utf-8?B?RUpTYXN1UUVaUmVYdllxUEp4MGZRbkRwNGN3L1VmUXgrNC9qR2RodXRMOGNC?=
 =?utf-8?B?ckhtTkVublk3TXlDcktBdmNpTHdDakV3eCsxN2RhRkl0NFlXZytBSjJyQy9s?=
 =?utf-8?B?YmFlSHNWRXVCU2RzdDRVSzh5TS81RG80NFA2Qzkvb1JqMnVYSk00akdLUkR6?=
 =?utf-8?B?Mmc3MWlkQUhEY1grakNuTVptd2VLb3BqbUVvM050Yy8zNGM3UGhEWUZHTDZ0?=
 =?utf-8?Q?jcNY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c6da46-41fd-4e7f-3167-08db5ba9ce22
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 16:21:46.8952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wVTVP3vcL+aChqdUBxll/qiDo5hVn6Og9dUQBI8GOP+IcEES/6Q9txRFDzUB2Ht9fcouV+15bnDdDRMux8vtDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4g
U2VudDogVHVlc2RheSwgTWF5IDIzLCAyMDIzIDY6MDggQU0NCj4gVG86IExpbW9uY2llbGxvLCBN
YXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IHJhZmFlbEBrZXJuZWwub3JnOw0KPiBs
aW51cy53YWxsZWlqQGxpbmFyby5vcmcNCj4gQ2M6IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZ3Bpb0B2Z2VyLmtlcm5l
bC5vcmc7IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcG1A
dmdlci5rZXJuZWwub3JnOyBTLWssIFNoeWFtLXN1bmRhciA8U2h5YW0tc3VuZGFyLlMta0BhbWQu
Y29tPjsNCj4gTmF0aWthciwgQmFzYXZhcmFqIDxCYXNhdmFyYWouTmF0aWthckBhbWQuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDQvNF0gcGxhdGZvcm0veDg2L2FtZDogcG1jOiBVc2Ug
cG1fcHJfZGJnKCkgZm9yDQo+IHN1c3BlbmQgcmVsYXRlZCBtZXNzYWdlcw0KPg0KPiBIaSBNYXJp
bywNCj4NCj4gT24gNS8yMi8yMyAyMjowMCwgTWFyaW8gTGltb25jaWVsbG8gd3JvdGU6DQo+ID4g
VXNpbmcgcG1fcHJfZGJnKCkgYWxsb3dzIHVzZXJzIHRvIHRvZ2dsZQ0KPiBgL3N5cy9wb3dlci9w
bV9kZWJ1Z19tZXNzYWdlc2ANCj4gPiBhcyBhIHNpbmdsZSBrbm9iIHRvIHR1cm4gb24gbWVzc2Fn
ZXMgdGhhdCBhbWQtcG1jIGNhbiBlbWl0IHRvIGFpZCBpbg0KPiA+IGFueSBzMmlkbGUgZGVidWdn
aW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxp
bW9uY2llbGxvQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2Ft
ZC9wbWMuYyB8IDQgKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2
L2FtZC9wbWMuYw0KPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FtZC9wbWMuYw0KPiA+IGluZGV4
IDQyNzkwNTcxNGY3OS4uMTMwNGNkNmYxM2Y2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGxh
dGZvcm0veDg2L2FtZC9wbWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2FtZC9w
bWMuYw0KPiA+IEBAIC01NDMsNyArNTQzLDcgQEAgc3RhdGljIGludCBhbWRfcG1jX2lkbGVtYXNr
X3JlYWQoc3RydWN0DQo+IGFtZF9wbWNfZGV2ICpwZGV2LCBzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+
ID4gICAgIH0NCj4gPg0KPiA+ICAgICBpZiAoZGV2KQ0KPiA+IC0gICAgICAgICAgIGRldl9kYmco
cGRldi0+ZGV2LCAiU01VIGlkbGVtYXNrIHMwaTM6IDB4JXhcbiIsIHZhbCk7DQo+ID4gKyAgICAg
ICAgICAgcG1fcHJfZGJnKCJTTVUgaWRsZW1hc2sgczBpMzogMHgleFxuIiwgdmFsKTsNCj4gPg0K
PiA+ICAgICBpZiAocykNCj4gPiAgICAgICAgICAgICBzZXFfcHJpbnRmKHMsICJTTVUgaWRsZW1h
c2sgOiAweCV4XG4iLCB2YWwpOw0KPg0KPiBUaGlzIGRvZXMgbm90IGNvbXBpbGUsIGFtZC9wbWMu
YyBtYXkgYmUgYnVpbGQgYXMgYW4gYW1kLXBtYy5rbyBtb2R1bGUNCj4gYW5kIGN1cnJlbnRseSB0
aGUgcG1fZGVidWdfbWVzc2FnZXNfb24gZmxhZyB1c2VkIGJ5IHBtX3ByX2RiZygpDQo+IGlzIG5v
dCBleHBvcnRlZCB0byBtb2R1bGVzOg0KPg0KPiAgIENDIFtNXSAgZHJpdmVycy9wbGF0Zm9ybS94
ODYvYW1kL3BtYy5vDQo+ICAgTEQgW01dICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9hbWQvYW1kLXBt
Yy5vDQo+ICAgTU9EUE9TVCBNb2R1bGUuc3ltdmVycw0KPiBFUlJPUjogbW9kcG9zdDogInBtX2Rl
YnVnX21lc3NhZ2VzX29uIg0KPiBbZHJpdmVycy9wbGF0Zm9ybS94ODYvYW1kL2FtZC1wbWMua29d
IHVuZGVmaW5lZCENCj4gbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLm1vZHBvc3Q6MTM2
OiBNb2R1bGUuc3ltdmVyc10gRXJyb3IgMQ0KPiBtYWtlOiAqKiogW01ha2VmaWxlOjE5Nzg6IG1v
ZHBvc3RdIEVycm9yIDINCj4NCj4gUmVnYXJkcywNCj4NCj4gSGFucw0KPg0KDQpNeSBhcG9sb2dp
ZXMsIHllcyBJIHdhcyBjb21waWxpbmcgaW4gd2hlbiB0ZXN0aW5nLiAgTGV0IG1lIGFzayBpZiB0
aGlzDQpzZXJpZXMgbWFrZXMgc2Vuc2UgYW5kIGlzICJnZW5lcmFsbHkiIGFncmVlYWJsZSB0aG91
Z2guDQoNCklmIGl0IGlzIEknbGwgYWRqdXN0IGl0IHNvIHRoYXQgZXhwb3J0cyB0byBtb2R1bGVz
LiAgSWYgdGhlIHByZWZlcmVuY2UgaXMNCnRvIGtlZXAgL3N5cy9wb3dlci9wbV9kZWJ1Z19tZXNz
YWdlcyBvbmx5IGZvciBjb3JlIFBNIHN0dWZmDQp0aGVuIEknbGwganVzdCBzZW5kIHRoZSBvbmUg
cGF0Y2ggaW1wcm92ZW1lbnQgZm9yIHMyaWRsZS5jIGxvZ2dpbmcuDQo=
