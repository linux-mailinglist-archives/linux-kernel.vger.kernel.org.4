Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D78E638B85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiKYNrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKYNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:47:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DD329802;
        Fri, 25 Nov 2022 05:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669384043; x=1700920043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bmiRxk2tWCO6LXHGeW1v3ahstbWG4+w39dx4v9a7+tk=;
  b=YL50KT0ylaDW0yQuIBruON8dojYsOjrKuhDQrQKvwohd2WGoriW8e5fn
   tj6+9aVvZGbE/Uz9JX2rFDB/x0Y2FMtXySnToAvy2w0c1xQg3SQw5N2j3
   RGTC/JlSuNhUBPIuDRaUJ89lJdMEQ4Mfh/3RxBhOrGCI+0TBHDyagmjQp
   U9mtPM2kc8bmbj7MKYHdiA2wuWbBItW0w0Pm+6Wy25kfEOGGAibqXq0S9
   bDfKVaCnAyGYbd9XelKp1UDZ79mMgNvGu9/d3Igo5SOADgz+IZwvS1SAw
   9y4lkxR+lMyi+Gihe+ah04SIy8rri5O6Qu+51UYf+tiAoOYIYNK4ypxZX
   w==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="185190011"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 06:47:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 06:47:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 25 Nov 2022 06:47:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fx8GKN8oC1W8dJ6QeYcFukMxoscc/yu+PirXFy9dXEfuo3sciHBsKwHDcACx75WWusL/Z/XCjRvlmEzDYe3B0Q0NuFH+TnEhjj9WxTLUVB11gNIKzbePAfJIwMbI86L0SZrfKooAt+DpyTk8ZECXUabNDwLYXhKmYSgSTSw/8fHonJ5OJFuTCPMvcDg5Jut9fcYdk2bvPYSLMRTvGbcG8dV9taYO5do940NmVi/KRy9e+wom+mkADCpXGMpLVggF5BNCWOvhmGnLuYsnSektqs4MiyIW7vchSMGgd7ZtLXCzOYjCE0A62kBoka4kJQhR85TSog038NQJHLdNbyhLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmiRxk2tWCO6LXHGeW1v3ahstbWG4+w39dx4v9a7+tk=;
 b=jfF0KrWmkW/G/BfF59/meyXu1Kt+OwdhYYhqTJH/K4RreHhynBWFRr3XRaKv/X/DIPRLagoAMHZ+m8ds/7XGl2xjGilG4bDLLt7pDOQogWhbAwAdoZx1anj2ngkmH2p/fGq85eeA8XU5BdPziXg/HCVzmKeD0PD0zP8CSFR8KB+051YRdv5KuGdLWfQ+jtOyOBELHMh9RgGqBeMTZ7WK+wKIoU7L5Iosgnn3PwX3uTi/34TCml8AWoFZYqIy6BN2aKsEwCj6ocYtj33rUFPfFEvlFuKjMKyEpr3wsJ2TZf+U26KUzES9yRfu/OS59cWJGTmo/wSubEhHg9EUGFegag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmiRxk2tWCO6LXHGeW1v3ahstbWG4+w39dx4v9a7+tk=;
 b=J/w++iPDdlzcc/RROrWq/6XymB1LB/59o3ntZmOMApBfYoxSudY/e2LdKE1M3xFcDfP3TCLqh2czAYSJSvgFQHapKPtKdubVYck4w0uPF3R5IpD0fV8HmUvaN6gPtN9y4Eu0fnscGI7dSCamNNOsi+DuXWyDpg3ataSYNfvWaec=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 13:47:19 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5857.017; Fri, 25 Nov
 2022 13:47:19 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Eugen.Hristev@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: configs: sama5/7: switch to new MICROCHIP_ISC
 driver
Thread-Topic: [PATCH v2 1/2] ARM: configs: sama5/7: switch to new
 MICROCHIP_ISC driver
Thread-Index: AQHZANRvVSqFR5WCaEiFs+9HfXWdpg==
Date:   Fri, 25 Nov 2022 13:47:19 +0000
Message-ID: <aa27b328-5167-408c-7731-080aa3a4ebb5@microchip.com>
References: <20221125130646.454084-1-eugen.hristev@microchip.com>
In-Reply-To: <20221125130646.454084-1-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|DM4PR11MB6237:EE_
x-ms-office365-filtering-correlation-id: 354b9412-13a6-4fb7-a1b4-08daceeb922e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFwXN9QzKSacjG1OL/Rrt/+04UGixB/hM/kzUHIadfrLqHjh3U4EbAcjZKJuryEXfVJCSyzUd7yHrIQBlO3QBSzI+QR4U9tjJ73HXCe4u1enf/H94a8Aizyq6J0aQyG6Nr/gM42uGH4fg2dJPE9mfeVd4aGNOTYRXh+iTZjtBpfcZfrYmig7CF0QSwdZldDAUyz/wBfBWgb3s2p+HrDG1oTAu0uDAN2ilVLd7P0+NlTnWjf8kbksZyKK84KPEUacs4L1S3dUyBu5ykmImBktU8L5jitD5FJa3Kpsi5DifPvGp1hnBM7+vCXLFS5kdPK9LzaUabTBnA3fGR7v6JLOd5px4eIsGfMm0L3QMOtJFvBIdSKDS01BzpmgZyZa3j+/Om71jTAIf2KDmJlkVTTkaE46kkPP0QQjPZ2KXPODvDSMUPxBxnPJXE//DQ6sU5WLUwPJfLNsCEK2BClgNgVaVImhxrhobWeAniI+7Ze4ZPHpL/ZJAlK5lND2PvgTSp7mthVfqAnKOCG5FkV0xUEkdLZHNPVgJy8UmMaxlwtRrF8FGsrLVcJTtnsj86QRYHeKUkTmG808rsWFVXLgJ8KT7yFRCkZRcldPdLAkDjR6UuOsx2/1pSTkFqQUgF0YbUlbNd20iLyRiu8XBSqRk1HOz9a4XtRt30adgwHGZnMy3095y356aYzxMAiYzp/qkO9Mjx6rrDYGJv1mdo5msfkNgSu6mbKGIkK/et19CkTPyjCaKBRdUR5aJjockf5nucheZM7M1RR2eahK6FZvGCaseg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(31696002)(86362001)(76116006)(66556008)(64756008)(66476007)(66446008)(66946007)(8676002)(4326008)(91956017)(41300700001)(38100700002)(54906003)(6636002)(316002)(6506007)(8936002)(6486002)(5660300002)(2906002)(6862004)(83380400001)(37006003)(71200400001)(38070700005)(186003)(478600001)(2616005)(53546011)(122000001)(6512007)(26005)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmRtNjlCdE83RGd1WTlJRHMyQVFJWFlERndCVW5uM2RITThZSThlcDhmTllY?=
 =?utf-8?B?MVA3eUhIR3IwaUhMVGF6ZDlMVUhwbzAwQ1NwUEdtZmNtUmNtdlZnNVdtWVhk?=
 =?utf-8?B?bnI1S0ZaNkpranFKZXZ2a2lCam5udDhJempDbTQxMWtBM3hXaFJNb2V3SHlr?=
 =?utf-8?B?MGVBbjZaNXFadjJPNk1DT0ltYUlaTVdwSEdOekFQZzA4SlYzcWFFZlFMSlho?=
 =?utf-8?B?R0xvUGJ3dExVMHh0WklqbnRFTVhKeWpKYjBLSVVkQXRTL3FOWHN1blhSU091?=
 =?utf-8?B?TzgrU2ZNK0VCRy83K2VoZ2NUVUxaT3hXL2llRy9qWjlUV3RUaFg1VWdtMkVF?=
 =?utf-8?B?Y3VYa1VuSUNXalJzZHI3eFRpRDJVMTVwTTBkRlBKaEdROHpCdVdrSFFhMERv?=
 =?utf-8?B?bHZGWWhmdlltTmZkM0JwNmlFcFN5dUJUQUsrc3dXbGVWeGE5WW13Z1ZPYndB?=
 =?utf-8?B?VHk4eXhpTVY1MGdSU3kxbEhkNmpidkFneWIza2FFcnQ4aWlUOWJFUVV1UGtB?=
 =?utf-8?B?T0N5bWRTMTVsNDI5OFRvMjUwL2MwS2pNMWdMbjI4QTVublRhMUJnZ3NhVU8v?=
 =?utf-8?B?S25ReTAwUjZuVjdvc0paSmg2YzcyRVZTY3A3ZTFVcFJDNDIxN2JVNXgyL1di?=
 =?utf-8?B?UThvVjdLQktYcTF4MURSWkd1TGZHUnRFaG5xZmU4TmpFc1VjWFdVYVRGTTVt?=
 =?utf-8?B?b2NrakVWcVExNnVJK0tGckxzL3VzNkEvSmNGa0xKb0NBcHdXN0xuSGMwVHRp?=
 =?utf-8?B?MUt4U1I2ZW9EWmRpSjVPcDFHQ2Y1T0d6d3REelFrNXlTRjVwN2s2MEtYb3Vn?=
 =?utf-8?B?SWhYcUx4cjJpU3NJQUMvZE9uR2o5dVVXeGYyRitHdUZyOUl1L2VGOGpOQkQ1?=
 =?utf-8?B?V3pLTnhSLzN2eVZlWUROd2lNQjFxU3o0TjBIOFJ2TVBvb0k0ZXFCb2JxVnEw?=
 =?utf-8?B?cGFMVHJDbTEweGp6eTg1QzVJblVZT1hHcEFmb3I0YmlJTzNtOFlkMm9ZOURp?=
 =?utf-8?B?cjZPUVc5elZzLzE5TzR1ZnR3UFVraWFHaUhVdXV2VGtaSlJsY3RlQmFTaTlZ?=
 =?utf-8?B?YThqRTVKWFVIeUovZnQyOTJuSmk1SU9iUVZOQVRkSEptckF5Z1FpY0ZEeGdU?=
 =?utf-8?B?OTl0T2kyanFLb2ZWTzloYTVkME52LzBCYy9pTWRlSkphUmFGZlQydHQ4S1FU?=
 =?utf-8?B?ZGVOYjMwK3VvUnRqSTVXbzZhRjY2RUQ2S2VHVTBsT0d4THZzSmc2R2YzbjBL?=
 =?utf-8?B?clUyZFpxSEVnaStzWnZ0NnZUbUMrVlVTbDNQWjYxUEhITHkyeWJuNEo0U0NO?=
 =?utf-8?B?SFRXMTV6dGlBamNQVmVZZ2VhekVtSzRqbFlEZVZoVmlYNThWVWhOa3FhaGNT?=
 =?utf-8?B?cFFaM20ybkYvWk9ET0dVZ09kTXQrdDM3aW5qVGpQdlJ1NHRycmYzRkptSmJR?=
 =?utf-8?B?YThldWw4aXUvQVpEelozZHRGQy9kb2s3Sy9DSUpBWkxQNTl0T0VIZVZZZUVn?=
 =?utf-8?B?T2o5NnV1N2UvT2lpa0RsZW1DSExmMkdGOVNLdEp0M3FYSDcwbVAvWVZmc1lw?=
 =?utf-8?B?Q2JGOFczbWhZY1Z4NWFvMUswNGQ2ZUh2d1hlUlN6VzY4dFU5V3VXaHJnN0Fi?=
 =?utf-8?B?UXExMDE3ZG1rbmhVZmFmeWh3RGNVRmVRb291THpma0xsVTNkcnFvWVJ6S0FW?=
 =?utf-8?B?QlVTeWRaTEVFZjdHUzJPRXAvN0gzL0V0anNPT3ZES3dZclVoKzRRVVp6SU5R?=
 =?utf-8?B?cGV3NXlDNmhtK1pyV1BaRVd3bVlEamdzQzc4N0xYZWN3NkVUQ0ZFUkxpSjVs?=
 =?utf-8?B?dkVrRCtnUjZNbkUxbWdad25YTko2TDIvSnoxSUh0MEtvbkhJdDlCNVB5TnF6?=
 =?utf-8?B?eFBOZzY2d3VKOGVKR25SaHcwTmN1dDEyb1JZVWdSTkd1cVRDM3poUDhOdUlN?=
 =?utf-8?B?N3ZFTXlZQzBSSG1Gb29XeHRFMENuYUEwS0Qra0NFVEhBYnR3TWJxL3JGSlE5?=
 =?utf-8?B?ZFVwYURRZk1XbHJheVZsZTNiNlBWazR4dlJrQ3JuazlPOTViclRMLzU5MWJE?=
 =?utf-8?B?WVdVenFDbnVQZitzcmErUkt6T3hwWDdRYkF3dFV1bitYS1poRUs1Vjg4Sktl?=
 =?utf-8?B?dzIwODUwRHZYejhVWFdSNlpTUjY2cVlUSXJ3Rzcvc0llYjhJalAyUjhZWXRR?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9C3EBAFAC371341AE9A8587678972E1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354b9412-13a6-4fb7-a1b4-08daceeb922e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 13:47:19.0887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cm5feX+gaRGWdl4kEGDpHO489jESLlBMEVDgx7Ml2mFq2gGNeostDxLvFOAqhDDQNYZHUnh8ILvQK3rqNncch3WeCHGvRZai65+TxoHw7kU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMTEuMjAyMiAxNTowNiwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gVGhlIEFUTUVMX0lT
QyBhbmQgQVRNRUxfWElTQyBoYXZlIGJlZW4gZGVwcmVjYXRlZCBhbmQgbW92ZWQgdG8gc3RhZ2lu
Zy4NCj4gVXNlIHRoZSBuZXcgTUlDUk9DSElQX0lTQy9NSUNST0NISVBfWElTQyBzeW1ib2xzIHdo
aWNoIGFyZSB0aGUNCj4gcmVwbGFjZW1lbnQgZHJpdmVycy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCg0KQXBwbGllZCB0
byBhdDkxLWRlZmNvbmZpZyAoYWZ0ZXIgcmUtd29ya2VkIGEgYml0IHRvIGtlZXAgZW50cmllcw0K
YWxwaGFiZXRpY2FsbHkgc29ydGVkKSwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiBjaGFuZ2VzIGluIHYy
Og0KPiAtIHNwbGl0IHRoZSBtdWx0aSB2NyBpbnRvIHNlcGFyYXRlIHBhdGNoDQo+IA0KPiAgYXJj
aC9hcm0vY29uZmlncy9zYW1hNV9kZWZjb25maWcgfCAyICstDQo+ICBhcmNoL2FybS9jb25maWdz
L3NhbWE3X2RlZmNvbmZpZyB8IDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2NvbmZpZ3Mv
c2FtYTVfZGVmY29uZmlnIGIvYXJjaC9hcm0vY29uZmlncy9zYW1hNV9kZWZjb25maWcNCj4gaW5k
ZXggODc3YmJlN2I3NzdlLi5mODlmZDRlMGQxMGEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Nv
bmZpZ3Mvc2FtYTVfZGVmY29uZmlnDQo+ICsrKyBiL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTVfZGVm
Y29uZmlnDQo+IEBAIC0xNTAsOCArMTUwLDggQEAgQ09ORklHX01FRElBX1BMQVRGT1JNX1NVUFBP
UlQ9eQ0KPiAgQ09ORklHX01FRElBX1VTQl9TVVBQT1JUPXkNCj4gIENPTkZJR19VU0JfVklERU9f
Q0xBU1M9bQ0KPiAgQ09ORklHX1Y0TF9QTEFURk9STV9EUklWRVJTPXkNCj4gLUNPTkZJR19WSURF
T19BVE1FTF9JU0M9eQ0KPiAgQ09ORklHX1ZJREVPX0FUTUVMX0lTST15DQo+ICtDT05GSUdfVklE
RU9fTUlDUk9DSElQX0lTQz15DQo+ICBDT05GSUdfVklERU9fTVQ5VjAzMj1tDQo+ICBDT05GSUdf
VklERU9fT1YyNjQwPW0NCj4gIENPTkZJR19WSURFT19PVjU2NDA9bQ0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vY29uZmlncy9zYW1hN19kZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL3NhbWE3
X2RlZmNvbmZpZw0KPiBpbmRleCA4ZjI4YzlkNDQzZjAuLmNjNDJjZWE3N2YzOCAxMDA2NDQNCj4g
LS0tIGEvYXJjaC9hcm0vY29uZmlncy9zYW1hN19kZWZjb25maWcNCj4gKysrIGIvYXJjaC9hcm0v
Y29uZmlncy9zYW1hN19kZWZjb25maWcNCj4gQEAgLTE0MCw3ICsxNDAsNyBAQCBDT05GSUdfTUVE
SUFfU1VQUE9SVF9GSUxURVI9eQ0KPiAgQ09ORklHX01FRElBX0NBTUVSQV9TVVBQT1JUPXkNCj4g
IENPTkZJR19NRURJQV9QTEFURk9STV9TVVBQT1JUPXkNCj4gIENPTkZJR19WNExfUExBVEZPUk1f
RFJJVkVSUz15DQo+IC1DT05GSUdfVklERU9fQVRNRUxfWElTQz15DQo+ICtDT05GSUdfVklERU9f
TUlDUk9DSElQX1hJU0M9eQ0KPiAgQ09ORklHX1ZJREVPX01JQ1JPQ0hJUF9DU0kyREM9eQ0KPiAg
Q09ORklHX1ZJREVPX0lNWDIxOT1tDQo+ICBDT05GSUdfVklERU9fSU1YMjc0PW0NCg0K
