Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142F4627071
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiKMQT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiKMQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:19:56 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4776DFD31;
        Sun, 13 Nov 2022 08:19:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke7yUqrI0iqucQE9m2aHkpRJwWa7zEzifVhyQp8vIfpqnjC2MeJiN2mK3J4ZFtGfZDS2xf+iYdeDVR0MVAwoSMPXCmoaxesisk4tt5U6/kfAuCFa1cWYI2MZS3PhUbAQp41/484QzcmwxwhTHLjGpyyhYwIIijV/Mpz0BKnJdcoS+07ZHEJ3aeyz5IO+vtRSB9zZGzvw6q4+qPQw5T1lIX0C7B6AO6ZjE6/diS/P1EyYJdJggD3lom7KDIBP+lA6Luq5kOhpRCAQflC0bJySujizwnExuGIVSGH1+A9qKrHjGyUiwnttXEkcTcZ9K+PrbIBw2nYCDzlGQ5LxDOP2Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg9jepPRZ/vj0NkBY0vBLMnROFvAs1+kBWEdxkAWuLw=;
 b=ZNVQEu9ZfJ7XkP6+QQXEbfm2nHGpC4eI2p1hSa2JQcE7/8o4Vu/LhfrMpFnYHSfNrBJoeQP47EobvHt5oEShqh7txjPsuC9ppdlequPYwlXdB0bwr3BEPJ3SlgKhcTANjqflGe9JcCYdXQQkm0OPd5h1L1XpNX/TLY2wsoni62YJVB9dtXzRT38a2s/Ul7nYWJ0bM3fXjMUHMk1guuW2Wme8UGHwqG58WIsn33hG2FXfGd6MwgJAjQf3QzLx1dFTR0F6KLymzPpOQvJy0AJY1B7IP9O+T8xt/zNtvETmyh6VGymkaRlpRuKolBOCmWXFqkHatrqqyh94b7P22gWnFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kg9jepPRZ/vj0NkBY0vBLMnROFvAs1+kBWEdxkAWuLw=;
 b=m75ACA6SX9B7uC1ZN/QeQvpdT58+AhrLzzwajsd/uxJX5j/v9R2ZNGCJUScab1XVdeJeQonhQJQ7J3fj5Eh0Qz9VS61+pHvxgD5OwZPttrv8grXbqjfrUObD3RnqUFdUVM35Q280bx7dERLbo4j/kV4KC8cCoMut55eysdxw9Ek=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 16:19:52 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%8]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 16:19:52 +0000
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
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/8] cpufreq: amd_pstate: implement amd pstate cpu
 online and offline callback
Thread-Topic: [PATCH v3 5/8] cpufreq: amd_pstate: implement amd pstate cpu
 online and offline callback
Thread-Index: AQHY8tKREJanYXqRbUqBcet7pc2U164zxh4AgAlLkAA=
Date:   Sun, 13 Nov 2022 16:19:52 +0000
Message-ID: <DM4PR12MB52789D7F114E1A9FC00784979C029@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-6-Perry.Yuan@amd.com>
 <6a2df432-be04-be50-392a-9a935a588822@amd.com>
In-Reply-To: <6a2df432-be04-be50-392a-9a935a588822@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-13T16:19:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=23af0fe4-69e0-4a31-9204-8632cd933e70;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-13T16:19:49Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 035a0d28-b1ca-45ee-bdeb-5d171b63360c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|PH7PR12MB6695:EE_
x-ms-office365-filtering-correlation-id: 67d779e2-a644-4f98-c83f-08dac592e4da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XCx4JHFAfMaVj1ZPZhhpPkia9oaTsE7+USYar7LrsugBlt0cfmimD/uZWmsqpfu7PsiqXeXt3+wUN8EqE6CrqyaJBLtf5gfY80Zk+1F+rwPei/BNB+UadhgUD6QADSNL9LGUIn5FaC524SX1eTwqYqzsA1wX+BOpliIw0IAWKReWuULXGALxcd4+MK2cB1GHsHyGr5bY2lXp4a0EcQW+z81bFxdjdBSbuFgOnt6prXB9cCoIfX/bjD9yEpeHiY4KNn+k7HIdTMiscyBp3bAK79B/wQsQ3tS0L3kti2FVLAGg2+dWkF/9M61NOhEAu6+13pSg+ZbnsfmoRJqZ062K5Igf8gv0ynbODcQeLeJkovc73Nlf2oqijlEbZdOXBk5yQQXEpSZyzKjYPQzRxIKP3l6Qwb6IpRHS2T9iDe7fafwyQfSDeNWSb5E1UBo1xk0p0mthTCDUZrnCeRDraPtj32/XFiakz2EG1d5eJkprDaOMyum29Mpl2ZxBxdv9ip9J3R3mmgBFj6qLUbooJE+qsiCEU0x5Y5xzDRAUjrDIOxhkVf/n4V8KuGjzBLZkQZc0MOp4tMA9/12DGSVhhc36Ak20Ou6Tu3GS3WftVGsNLlonek8rl8RKvUO2I3VoX9cvDfYLobywykv9d5wqIwE/CBawe7ttylf4VCHWAAciWDdIgxg70WtqguwcuD0Addmei2cBwvrl9EUWCgDTVHINv09qePulAsgDre+aaqFYe7Ki8Z/9NAq5rYEwIXYDU4yqEWPtfxZinr3PFz6Ulb2k7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(9686003)(122000001)(26005)(71200400001)(54906003)(110136005)(316002)(186003)(66476007)(66446008)(66556008)(76116006)(33656002)(8676002)(64756008)(2906002)(66946007)(55016003)(4326008)(86362001)(52536014)(83380400001)(5660300002)(7696005)(6506007)(478600001)(38070700005)(53546011)(41300700001)(8936002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTNPSGNvd0QvRHBDb2tzbFRzYzNEbmJ1SGQzeHM1Vm9GMWpLMnpwNmladzZi?=
 =?utf-8?B?elU2bkhWeDArMWUyQm03M29SNkhOZndjUS9NbFVxcnl5eW5iT3p4TUgxQjdS?=
 =?utf-8?B?dXFENFE2KzFxNzJhNkVNcmlWaUZlZXRYcmtDTVJWa0tUdFlHYmhxSHc1c2J2?=
 =?utf-8?B?K0o4OCtucjVsKzI1Wk5TQVA1SFQyQ25DTmozN05ucDFLdGtEWkNva3phRERZ?=
 =?utf-8?B?akJXQytvSkxDaytuM0RTbXNhT09FeW56RUE3ZlJsd0hodDh1emozZTZlSUV2?=
 =?utf-8?B?Y0t2OHZ6SkFiSzRZL3pNL3lRNTJ1NzFyTlhGNFhTNEdPWTZkYUl6clMySUVX?=
 =?utf-8?B?Z0RDdDV0VGVjckdCa0tXR2FVYlZvU2hLR2RnSDlENGdBWm1KM3g1RUlxRjZj?=
 =?utf-8?B?eCtacXdvandrbWFDWldKbTVTY0c4QU5peTd3eW5oSWlodkhTY1hvaWFqWUQx?=
 =?utf-8?B?WlBkZ2lyVlF3bU1ZNW9IODNmMFcrUk9UZElhdVZNOVd4ZTlLb2lVZEJTWitk?=
 =?utf-8?B?ZXVxTmFPUkV3ZTR5TXQrM0MvMGljTGNEQnNXMXRYamFTc1Q5UVJBTklia1JY?=
 =?utf-8?B?UGFHSDk1eElHNXJkTkZKZWM0clBjNHV5NnBVdmtDcXVMNkZSb0dVQk9FWm1Z?=
 =?utf-8?B?NEQ3N1ZzUkhpNSsyaGtDdUNaZFlZaGJjUExaSmJrSzRrcDU0MXpKNmxWWm0w?=
 =?utf-8?B?SU5EZm1MNVVxeFMxOEZDVkRhQTMyanlISDNWSW56ZmhwL0NPdFRIeVVvWE10?=
 =?utf-8?B?VnNwbkhXRTkzVUU0M2JhR0xmcExWZkZtZnlmdERobFNzWXJFS283eUpFNlNB?=
 =?utf-8?B?akZZR1I0aGFDNHoySGJ1eHRJUXRUSS9zTTdsZm95TXdNNlV0TFJaaHVKOXU4?=
 =?utf-8?B?N3JraGwyRkJmUHJFSUlSMFI5YmJOL3hVZjVqQkhwMnpiQlU5OHRVR1U0Mkt3?=
 =?utf-8?B?Q2dsNUU2d3JmbisxYlYzZDdsaHdaRU40amhFY3IrcXFZNExJVUZnZVJqZ0Fy?=
 =?utf-8?B?TTZZKzRWL1FjajREY1ZKM25Sbzgxek5vZU5VY3Q5bjNrL1dEd250dzdPYXRt?=
 =?utf-8?B?eXFXNm1WTnV6UEFRRFFwQ0pnZ3h1VGQ1aXhrdlJQSVFLNkdybWVFSEVZOEVz?=
 =?utf-8?B?czRFaHdOWXdtaSt1LzA2QlVHVzFyOU01c3piRkJHb0lBd1pxS3c1eWVLR1Rq?=
 =?utf-8?B?Uzd1U0VtQ1plQXNXR3N1eDZBd0plMi9LMnM2SlRLRXNxa0dGQU9VWkVxT2xF?=
 =?utf-8?B?ZGlJNmJrSWNtNUxHa0Rpc3o0TkJCdkoveWljY1VNK1VWalY0WmFPZ3VlUmN1?=
 =?utf-8?B?bHJtaDBzZE5QaGpYSGQ4U25tV0gyaW5td1VvUU5VZFBhYnR0UUxJZFE3UzFy?=
 =?utf-8?B?U1FoWlZZT3EzWDRGUXVSL2MrTDVnalRjcndkb3ZvcXhKYlZ6OEU3Wng3elNO?=
 =?utf-8?B?b2dKaDNQZ3FML2ZKRHNuakt6d0R0Mjk5Ymx4Z1FBQThvV3NSZlFpMnJJZXJK?=
 =?utf-8?B?RkxpUEg2UmJYVzNZRUN5bzhuSERPbFFKUW10Q2kxWFdYVW81eFUxdFFOY2pm?=
 =?utf-8?B?VVRBbVcvdUNmMnlzajN5amMwbko5MHFqN3lnWWJKNkxkQjRiUjhQcnFpbFEv?=
 =?utf-8?B?dW5xQXRKaEphWjlJZjlyQ2pFUDBMamhHNEFDM2F4MGp2MjJpWWMweHlJZUVN?=
 =?utf-8?B?OGMxd2NiN1hzUGcyOTZKYk16anlnbDRSZjVQZE5RNlA0WXFLZ0JlUnpBSCtS?=
 =?utf-8?B?ZlNJZi9EeDlUajRpaHVpbmRpVjAwbE52WHN5NDBKVzRYZTlzM2ViRUI3b21V?=
 =?utf-8?B?a0xhbHcyYUxoZm14dGNjWmtSOWY1S3JJL2lBbVgzRlBta1IyeFVCRUZMWGpj?=
 =?utf-8?B?dXJRUnRGbk1CcmN3cTRtUm1ETzlVNWVCNUZwc1JrZ2FDcmFEU1hrUzlLTjds?=
 =?utf-8?B?ZzZ3a1h6RDZqQzRiaWJjNW1nWndhdy9wL1BEa293Z1ZZbWp4Q0Y1ZnF0K3dU?=
 =?utf-8?B?WWhuVGd4S3AwUHAzU0tMajV3Z1V6N3lyQlppRldkenhacVpmbndwYlNscnZ3?=
 =?utf-8?B?djRFV0FQS1J0b1VJR0ZNcEQwRGFKNGozMnQyLzVzaWYvOXRKa2dSUzRvV2d3?=
 =?utf-8?Q?hxjr7jCtL+Dv3trQY3s4djnU9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d779e2-a644-4f98-c83f-08dac592e4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 16:19:52.1474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5nOr3iYGKrrGm6/uEmI3ZSuiwTAep0r26ujM2viNDvJNKJP/U4aZpGmBsgMGXaze92mb+5J3gdXpwLcY9YOXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695
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
TWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgOCwgMjAyMiAyOjIyIEFNDQo+
IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVsLmoud3lzb2NraUBp
bnRlbC5jb207IEh1YW5nLA0KPiBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgdmlyZXNoLmt1bWFy
QGxpbmFyby5vcmcNCj4gQ2M6IFNoYXJtYSwgRGVlcGFrIDxEZWVwYWsuU2hhcm1hQGFtZC5jb20+
OyBGb250ZW5vdCwgTmF0aGFuDQo+IDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47IERldWNoZXIs
IEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5nLCBTaGltbWVy
DQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9qaWFuLkR1QGFt
ZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+OyBsaW51eC1w
bUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNS84XSBjcHVmcmVxOiBhbWRfcHN0YXRlOiBpbXBsZW1lbnQg
YW1kIHBzdGF0ZSBjcHUNCj4gb25saW5lIGFuZCBvZmZsaW5lIGNhbGxiYWNrDQo+IA0KPiBPbiAx
MS83LzIwMjIgMTE6NTcsIFBlcnJ5IFl1YW4gd3JvdGU6DQo+ID4gQWRkcyBvbmxpbmUgYW5kIG9m
ZmxpbmUgZHJpdmVyIGNhbGxiYWNrIHN1cHBvcnQgdG8gYWxsb3cgY3B1IGNvcmVzIGdvDQo+ID4g
b2ZmbGluZSBhbmQgaGVscCB0byByZXN0b3JlIHRoZSBwcmV2aW91cyB3b3JraW5nIHN0YXRlcyB3
aGVuIGNvcmUgZ29lcw0KPiA+IGJhY2sgb25saW5lIGxhdGVyIGZvciBFUFAgZHJpdmVyIG1vZGUu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXJyeSBZdWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+
DQo+IA0KPiBSZXZpZXdlZC1ieTogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxv
QGFtZC5jb20+DQoNClRoYW5rIHlvdS4NCkkgcGljayB1cCB0aGUgUkIgdGFnIGluIHRoZSBWNC4N
Cg0KUGVycnkuDQoNCj4gDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0
ZS5jIHwgODkNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBp
bmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaCAgIHwgIDEgKw0KPiA+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCA5MCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVx
L2FtZC1wc3RhdGUuYw0KPiA+IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBpbmRleCBl
YjgyYmM2YTdmNjYuLjZjZTlmY2EwYTEyOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NwdWZy
ZXEvYW1kLXBzdGF0ZS5jDQo+ID4gKysrIGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0K
PiA+IEBAIC0xMTk1LDYgKzExOTUsOTMgQEAgc3RhdGljIGludCBhbWRfcHN0YXRlX2VwcF9zZXRf
cG9saWN5KHN0cnVjdA0KPiBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQ0KPiA+ICAgCXJldHVybiAw
Ow0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGFtZF9wc3RhdGVfZXBwX3JlZW5hYmxl
KHN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0YSkgew0KPiA+ICsJc3RydWN0IGNwcGNfcGVyZl9j
dHJscyBwZXJmX2N0cmxzOw0KPiA+ICsJdTY0IHZhbHVlLCBtYXhfcGVyZjsNCj4gPiArCWludCBy
ZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gYW1kX3BzdGF0ZV9lbmFibGUodHJ1ZSk7DQo+ID4gKwlp
ZiAocmV0KQ0KPiA+ICsJCXByX2VycigiZmFpbGVkIHRvIGVuYWJsZSBhbWQgcHN0YXRlIGR1cmlu
ZyByZXN1bWUsDQo+IHJldHVybiAlZFxuIiwNCj4gPiArcmV0KTsNCj4gPiArDQo+ID4gKwl2YWx1
ZSA9IFJFQURfT05DRShjcHVkYXRhLT5jcHBjX3JlcV9jYWNoZWQpOw0KPiA+ICsJbWF4X3BlcmYg
PSBSRUFEX09OQ0UoY3B1ZGF0YS0+aGlnaGVzdF9wZXJmKTsNCj4gPiArDQo+ID4gKwlpZiAoYm9v
dF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0NQUEMpKSB7DQo+ID4gKwkJd3Jtc3JsX29uX2NwdShjcHVk
YXRhLT5jcHUsIE1TUl9BTURfQ1BQQ19SRVEsIHZhbHVlKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4g
KwkJcGVyZl9jdHJscy5tYXhfcGVyZiA9IG1heF9wZXJmOw0KPiA+ICsJCXBlcmZfY3RybHMuZW5l
cmd5X3BlcmYgPQ0KPiBBTURfQ1BQQ19FTkVSR1lfUEVSRl9QUkVGKGNwdWRhdGEtPmVwcF9jYWNo
ZWQpOw0KPiA+ICsJCWNwcGNfc2V0X3BlcmYoY3B1ZGF0YS0+Y3B1LCAmcGVyZl9jdHJscyk7DQo+
ID4gKwl9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgYW1kX3BzdGF0ZV9lcHBfY3B1
X29ubGluZShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkgew0KPiA+ICsJc3RydWN0IGFt
ZF9jcHVkYXRhICpjcHVkYXRhID0gYWxsX2NwdV9kYXRhW3BvbGljeS0+Y3B1XTsNCj4gPiArDQo+
ID4gKwlwcl9kZWJ1ZygiQU1EIENQVSBDb3JlICVkIGdvaW5nIG9ubGluZVxuIiwgY3B1ZGF0YS0+
Y3B1KTsNCj4gPiArDQo+ID4gKwlpZiAoY3BwY19hY3RpdmUpIHsNCj4gPiArCQlhbWRfcHN0YXRl
X2VwcF9yZWVuYWJsZShjcHVkYXRhKTsNCj4gPiArCQljcHVkYXRhLT5zdXNwZW5kZWQgPSBmYWxz
ZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIHZvaWQgYW1kX3BzdGF0ZV9lcHBfb2ZmbGluZShzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kg
KnBvbGljeSkgew0KPiA+ICsJc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhID0gYWxsX2NwdV9k
YXRhW3BvbGljeS0+Y3B1XTsNCj4gPiArCXN0cnVjdCBjcHBjX3BlcmZfY3RybHMgcGVyZl9jdHJs
czsNCj4gPiArCWludCBtaW5fcGVyZjsNCj4gPiArCXU2NCB2YWx1ZTsNCj4gPiArDQo+ID4gKwlt
aW5fcGVyZiA9IFJFQURfT05DRShjcHVkYXRhLT5sb3dlc3RfcGVyZik7DQo+ID4gKwl2YWx1ZSA9
IFJFQURfT05DRShjcHVkYXRhLT5jcHBjX3JlcV9jYWNoZWQpOw0KPiA+ICsNCj4gPiArCW11dGV4
X2xvY2soJmFtZF9wc3RhdGVfbGltaXRzX2xvY2spOw0KPiA+ICsJaWYgKGJvb3RfY3B1X2hhcyhY
ODZfRkVBVFVSRV9DUFBDKSkgew0KPiA+ICsJCWNwdWRhdGEtPmVwcF9wb2xpY3kgPSBDUFVGUkVR
X1BPTElDWV9VTktOT1dOOw0KPiA+ICsNCj4gPiArCQkvKiBTZXQgbWF4IHBlcmYgc2FtZSBhcyBt
aW4gcGVyZiAqLw0KPiA+ICsJCXZhbHVlICY9IH5BTURfQ1BQQ19NQVhfUEVSRih+MEwpOw0KPiA+
ICsJCXZhbHVlIHw9IEFNRF9DUFBDX01BWF9QRVJGKG1pbl9wZXJmKTsNCj4gPiArCQl2YWx1ZSAm
PSB+QU1EX0NQUENfTUlOX1BFUkYofjBMKTsNCj4gPiArCQl2YWx1ZSB8PSBBTURfQ1BQQ19NSU5f
UEVSRihtaW5fcGVyZik7DQo+ID4gKwkJd3Jtc3JsX29uX2NwdShjcHVkYXRhLT5jcHUsIE1TUl9B
TURfQ1BQQ19SRVEsIHZhbHVlKTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJcGVyZl9jdHJscy5k
ZXNpcmVkX3BlcmYgPSAwOw0KPiA+ICsJCXBlcmZfY3RybHMubWF4X3BlcmYgPSBtaW5fcGVyZjsN
Cj4gPiArCQlwZXJmX2N0cmxzLmVuZXJneV9wZXJmID0NCj4gQU1EX0NQUENfRU5FUkdZX1BFUkZf
UFJFRihBTURfQ1BQQ19FUFBfUE9XRVJTQVZFKTsNCj4gPiArCQljcHBjX3NldF9wZXJmKGNwdWRh
dGEtPmNwdSwgJnBlcmZfY3RybHMpOw0KPiA+ICsJfQ0KPiA+ICsJbXV0ZXhfdW5sb2NrKCZhbWRf
cHN0YXRlX2xpbWl0c19sb2NrKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhbWRf
cHN0YXRlX2NwdV9vZmZsaW5lKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KSB7DQo+ID4g
KwlzdHJ1Y3QgYW1kX2NwdWRhdGEgKmNwdWRhdGEgPSBhbGxfY3B1X2RhdGFbcG9saWN5LT5jcHVd
Ow0KPiA+ICsNCj4gPiArCXByX2RlYnVnKCJBTUQgQ1BVIENvcmUgJWQgZ29pbmcgb2ZmbGluZVxu
IiwgY3B1ZGF0YS0+Y3B1KTsNCj4gPiArDQo+ID4gKwlpZiAoY3B1ZGF0YS0+c3VzcGVuZGVkKQ0K
PiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCWlmIChjcHBjX2FjdGl2ZSkNCj4gPiArCQlh
bWRfcHN0YXRlX2VwcF9vZmZsaW5lKHBvbGljeSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+
ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgYW1kX3BzdGF0ZV9lcHBfY3B1X29mZmxpbmUo
c3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpDQo+ID4gK3sNCj4gPiArCWFtZF9wc3RhdGVf
Y2xlYXJfdXBkYXRlX3V0aWxfaG9vayhwb2xpY3ktPmNwdSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IGFtZF9wc3RhdGVfY3B1X29mZmxpbmUocG9saWN5KTsgfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyB2
b2lkIGFtZF9wc3RhdGVfdmVyaWZ5X2NwdV9wb2xpY3koc3RydWN0IGFtZF9jcHVkYXRhICpjcHVk
YXRhLA0KPiA+ICAgCQkJCQkgICBzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3lfZGF0YSAqcG9saWN5KQ0K
PiA+ICAgew0KPiA+IEBAIC0xMjI5LDYgKzEzMTYsOCBAQCBzdGF0aWMgc3RydWN0IGNwdWZyZXFf
ZHJpdmVyDQo+IGFtZF9wc3RhdGVfZXBwX2RyaXZlciA9IHsNCj4gPiAgIAkuaW5pdAkJPSBhbWRf
cHN0YXRlX2VwcF9jcHVfaW5pdCwNCj4gPiAgIAkuZXhpdAkJPSBhbWRfcHN0YXRlX2VwcF9jcHVf
ZXhpdCwNCj4gPiAgIAkudXBkYXRlX2xpbWl0cwk9IGFtZF9wc3RhdGVfZXBwX3VwZGF0ZV9saW1p
dHMsDQo+ID4gKwkub2ZmbGluZQk9IGFtZF9wc3RhdGVfZXBwX2NwdV9vZmZsaW5lLA0KPiA+ICsJ
Lm9ubGluZQkJPSBhbWRfcHN0YXRlX2VwcF9jcHVfb25saW5lLA0KPiA+ICAgCS5uYW1lCQk9ICJh
bWRfcHN0YXRlX2VwcCIsDQo+ID4gICAJLmF0dHIJCT0gYW1kX3BzdGF0ZV9lcHBfYXR0ciwNCj4g
PiAgIH07DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oIGIvaW5j
bHVkZS9saW51eC9hbWQtcHN0YXRlLmgNCj4gPiBpbmRleCA3ZTZlOGNhYjk3YjMuLmMwYWQ3ZWVk
Y2FlMyAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2FtZC1wc3RhdGUuaA0KPiA+ICsr
KyBiL2luY2x1ZGUvbGludXgvYW1kLXBzdGF0ZS5oDQo+ID4gQEAgLTk5LDYgKzk5LDcgQEAgc3Ry
dWN0IGFtZF9jcHVkYXRhIHsNCj4gPiAgIAl1NjQJY3BwY19jYXAxX2NhY2hlZDsNCj4gPiAgIAlz
dHJ1Y3QJdXBkYXRlX3V0aWxfZGF0YSB1cGRhdGVfdXRpbDsNCj4gPiAgIAlzdHJ1Y3QJYW1kX2Fw
ZXJmX21wZXJmIHNhbXBsZTsNCj4gPiArCWJvb2wgc3VzcGVuZGVkOw0KPiA+ICAgfTsNCj4gPg0K
PiA+ICAgLyoqDQo=
