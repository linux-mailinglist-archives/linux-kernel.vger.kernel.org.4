Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC71627073
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiKMQVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:21:45 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB43EFD31;
        Sun, 13 Nov 2022 08:21:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+a/XNxe9Qg5mQm+0aQvlnuUz/nkarJPaGbdJdxIhDRsnvTbqszJpH6IxdJUnbJKpni7rAkvXnKJ4jy6aRM5GF2OY5WHKt1pDnOPOe55ljUxqMG02gLvJbtPIerCLUEQFh6o5vtT8UhOl1KLXUpyygyaxOJbnbygnNqjfQQ3efrJB3/LpEtWNcTS+fuP16+2drV0Hwd+KzdfctAvF+huO1i3CVZBfTV4mSFj1VZCPcqYdTAds0tLvJwol54Ni5rK4LPPUvhekWUwg3n0ePpF2DDARYkN4xmNYX2vNttNTcWRLZwiWEcFdGTXLkBrHfDzRGjy3vahiEhdef7uYck8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD5hsiiDSWxtLSOj+5Q/zMqoyDoM8DHNBRHeR6+RX38=;
 b=fRDiVPXNwFRgYFTx4dmQ+u65l9zxzzig17p73HLX3c4eRR608HIAEQXZGlFZZmV8zfDWDddIM7DRdQ0l4r1VVVdp8G+YiHtbzJOdyUS2qMs1k7xRftk+HCBQspc4FPC9GhLB8rWwLwcCBcu6jcG4YH9oTX+y4lz9yWBdkRKa5d9QpWOCBvF0UqaoOLPuV3m3+gL/pvbLHBhmMrm8U7aoW3WBS6Lsp+u1E7FXb2Sh7px2WqML0wPrko5EhfyX93rRe0ot72PGRRpGX38RZWrK2CJGiwHRSnSrk8pC2DOuQWsMDbEZJ1H8yNSgKjSMKZ/qLYlRWR/V3fE/LJ8/BktdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD5hsiiDSWxtLSOj+5Q/zMqoyDoM8DHNBRHeR6+RX38=;
 b=FQKOBmqbH6+X+/VF+xT3LFWUjAjNOHl8qMLduy7bwnrWGpsh0csKUXPxrRq2PU8NCNoYMFBB2PzSgYKiOP1k+viDVR5YRTryQquhbTRqIrFgEfGC9fV3JvS5UoQzC/fNtL5IhjdYXhOZI7WmyomZB6Vxg3ZHeriM71ug3kX7gbk=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 16:21:37 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%8]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 16:21:36 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>
CC:     "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/8] cpufreq: amd-pstate: change driver to be built-in
 type
Thread-Topic: [PATCH v3 3/8] cpufreq: amd-pstate: change driver to be built-in
 type
Thread-Index: AQHY8tKNwPVgCa1VjEqJstN72fAjCq4zyDIAgAlJsiA=
Date:   Sun, 13 Nov 2022 16:21:36 +0000
Message-ID: <DM4PR12MB52781ED15FCD6409D4EA6AFD9C029@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-4-Perry.Yuan@amd.com>
 <392fb511-5d16-167d-77ab-dfaa43dca4cb@amd.com>
In-Reply-To: <392fb511-5d16-167d-77ab-dfaa43dca4cb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-13T16:21:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=89b101d4-d508-4e02-a2cb-2d29807e368f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-13T16:21:33Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: aca9cacb-47d0-478c-b769-385052ef7d04
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|MN0PR12MB6125:EE_
x-ms-office365-filtering-correlation-id: be9b1bd2-0236-42f8-bfda-08dac593232f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wQovPwY9zrRW4jCAyJ/JP6QG70uKzqqXDEv07ombYEKvxYrFfsT2cYyiJLaou/WhxREpfdRANQWXSXLDYiHrP0Fu25Ittg+p7/RnKE3vS0HamyDuSAqq3mRuAnFQr+P9SbDnGnmlXbl53eLsZAOQbnyGLK41mWeMN4OX96OPTUE4SpVNFjZnTipnkHJr/BE3/cSQPEf4U5o8qJivmGlTLU1cHgik0tzlbO3VZZDeVGswozhTipWqM/5mPae6Onnk3oiXAztc7TsYl1MjNx/Gso/8Sz38s9n9y2E6jEK5d/A6HJxyfXhc9yR6N3VOqEC1VjHEtgGGkGnp8yFun8SHO9aufm2ABiB4gJGGZbX7plFkixGylIjSjuF54CvmV1GyrLeTjmP8t6pKWxKoxV+qONegaWU3Lh/+i0jqsB2aMUxRQAH2a5b/3K5cnLqfe78Wrc9vXILwKxRYIE/eOXO+HYPgyOjpT12B0rnkNu8yT17CLkb9LuH4a9wCGNMaNOwIbS/6rW2JvxPviVGOR6G/M11KUH/epsYrAKFl7avQ/1Kl+seT6w6TkbfSXn/U8UwLEV7RJCGYh5bIQ60oWhXnBZvcorsJfourphk9opL6NSN2YDYsLqPLvZXkX2ISxtHlLrpbYCBZ597J+/Z/FtHJCV94b1eM8r8ROZQUf6ig1pGP1a8rAHosEdrbeT+lRJ6RqDowGL9MHQ0WldtAmn5kbVbzvAaYo9AUuURr3CxZ3pHZSyXK80JMVN2bDOKRpe2hjaEXNnLMcWco+vZ0O4FbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199015)(478600001)(38070700005)(33656002)(54906003)(71200400001)(110136005)(7696005)(6636002)(6506007)(316002)(53546011)(66946007)(66476007)(4326008)(8676002)(76116006)(64756008)(186003)(5660300002)(9686003)(26005)(66446008)(41300700001)(52536014)(8936002)(66556008)(83380400001)(2906002)(55016003)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkpQQjhzdExWRVdST20zR1lwNzNLVjdwU0lyRXA0M3B4Yk5seW1EWll6eldV?=
 =?utf-8?B?TDlSVGxHT0VwR29tQUZZZ21oZjFuOHVGN3NvWGNHdW5oWU1iYWhRVDZNWXRX?=
 =?utf-8?B?amJta0tTVytNdnFCMlpuSGZ5a1MzSzJXUGcrdXZSVm1zUFlhOXFqblVRb0tu?=
 =?utf-8?B?blFqL1IwLy9SdkFVbWZzdC9hSnZGM1QvRTZkN2t3c0I1dWQ3SVFhUm52aXFK?=
 =?utf-8?B?eGFUUkw4S1pLY1ZDNkgzNXJBUlVsT2FLRW9sRXkwYW5QMWJVVzArWjZmSks4?=
 =?utf-8?B?QkJuTVpDQUFpTlFTQ21GR3lid2VOSHl1NjdVb1B5VXlHOTVaYlcrN1RYS2h0?=
 =?utf-8?B?UGp5azh1YnQ4cHA2NXAzMEUvT3o0OXlwdGcvckJmc1FTWjBraDlUOHpWSDBV?=
 =?utf-8?B?LzVmU0FBSmRiLzVncFZaZXc1MDhLc2RSQjlUbEJoSSt5RkxnUTVndWNWQmV1?=
 =?utf-8?B?RGV0NGJzWGdYL2Z0ZUR0eDRQTXcwZmVwSnRyc1Ztb1FIWmJaNW1abkhQTS9p?=
 =?utf-8?B?NlJNRzBEeXViWThSSFVRRXpRUXk1OTBzamRLa1NyYlVxZVRQcnNzSmRndEt5?=
 =?utf-8?B?SXFsbWZLNFY3UDgzTjY3bEh1YWovd3NVTEtFZzhPcWF5MlNMYTQwenFodmF2?=
 =?utf-8?B?RGhyNjcrdjNhRHVaZkFTZ3JCUlBXOTlSTHhaUGFNR25OaXZCYjU1NzBKZE9B?=
 =?utf-8?B?Ti9EV1J2MytpdVlpOC95WXhuRTRmZ2dobDN5SkFTL1VGNmlYYnZpb21qYlRq?=
 =?utf-8?B?UExEejdHNVlYbVBQek9zMFBobFZpbEs1YUZvOUZmVDlualpLTXRyRTlpK2F4?=
 =?utf-8?B?eXNPdEtaOEU0Tk1qZ2NLWjYwcTg4S0piS3Z2UldSbnlyTDM1Mkc1aUs2MTFI?=
 =?utf-8?B?ZU0vdTRwczNaQ2tkaEcyRzJrRFpZeU9VNEhkb09oaXdZZkVIYnJzVWpzR2VF?=
 =?utf-8?B?RURBa01STmlUMVdnMXh0RC9RKzQ0OHNTMGNjZGgzN29ubktCQ1RqeUZ6aGpw?=
 =?utf-8?B?WmMrU0szMUJIZXJFYTNNMkg3OWljYWRVeHJKRzRZU1NLYnA3c2o4aWx5c2k4?=
 =?utf-8?B?TXpSZjY2RXhDa0d5bXduYllrK1BlNHBzbm9kV1FjN2cveVRLNlVZL1B3ZHRF?=
 =?utf-8?B?VzdQQXZ4ZVAyb0lnbHFja1JVQTNrWEpJOXM5alFnaEIrb2lHb3hGanhmN0Ra?=
 =?utf-8?B?ZUpQVVpSeG1DWXk3djRsQU1MTzQvQTlzS0FwRW1mZDlsOVlkNzY0dnl6bm9U?=
 =?utf-8?B?SmMvbVBGSVp5bU5nY0w3aVBaZ0FZaHp0cm5DcForQTMvcDhmK0diZS9BY0pt?=
 =?utf-8?B?V3BKQ1Y3MnN0c2dXYmxsTTRBTFBFSEFWbFV1VUh6UG1aYmpuNXVwZGpnY3Qv?=
 =?utf-8?B?VkM2WTVJNFBKTTdkTXQ0SXN1NlVneHlsS1I3S3d2MkJUcHBFTkNkWUo4MTFU?=
 =?utf-8?B?S2Q2SUVOKzdiOER0T1p3MUNsS0J0ckYxWTgxOGpxU1N2T0JoZTZQLyt4UTg5?=
 =?utf-8?B?NXRiU3EySFBlUmRsZkVMZjJ2dnlIeGYraVFTdFdCRVMraXVKbDUrTWNjakVq?=
 =?utf-8?B?MXdDUmh3ZmpKWG5YNS9CZEcrUmF2Y2lkMUpQTTVMR0ZWZi81cVZxVmU0eG1Q?=
 =?utf-8?B?bmc5eTdzdmFSbFREMU1CUWlaMTNBdGRTcDN5aE14OTZMajQwNzVWMVV2MUd1?=
 =?utf-8?B?d1dNaEh2cHZuMmFuR3VpM1IyZjZ0TzdxeUVlK2dKc3c1UmkrNmRPakVuTjho?=
 =?utf-8?B?NkVFNldCejg1b0dHVTcwL1BQekJubFRqeWpQTnROZkZLUHdIT3o0b3BUeU1C?=
 =?utf-8?B?bitIMVBRQ1dlcHZzMzBCelN6QThLejBQWlJraHJEVnlJQnNyaFFzZHdLZUY0?=
 =?utf-8?B?NStZMnU2VjFXTkhsTDFtdmVnRmpFcEwrT1EyRjhvKzMyRWJmS2JaOVBlS29T?=
 =?utf-8?B?Y04rV0o2N1F1WHB6UTc4cHRwVHRreFA2U1EwUjlMcjNkNE94akZsQzRNZGtS?=
 =?utf-8?B?YmpBT2hEb29nVXFWeXRxWlhwRTFwSDQraGtTOEV2Z0VZQTI3WGxpbmFMOHcr?=
 =?utf-8?B?M1Q4ajZzdWJxMnRPUTUybWx5Y1BjVVNrWk5aZ0JqR2VXRmd6aHh2WjRKMUZ1?=
 =?utf-8?Q?RVRa+0IIeRoXzCgZrASCUHMkP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9b1bd2-0236-42f8-bfda-08dac593232f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 16:21:36.6917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8t0tm50dtgvnyT/3pLYhuCY2Uyb0oXw2Wus5X3SSPLuM+E3Qh+MDg8TGVn6LXXYMxKhII5D2DmZfSzjOOawn2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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
bG9AYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgOCwgMjAyMiAyOjMwIEFNDQo+
IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVsLmoud3lzb2NraUBp
bnRlbC5jb207IEh1YW5nLA0KPiBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgdmlyZXNoLmt1bWFy
QGxpbmFyby5vcmc7IEthcm55LCBXeWVzDQo+IDxXeWVzLkthcm55QGFtZC5jb20+DQo+IENjOiBT
aGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPjsgRm9udGVub3QsIE5hdGhhbg0K
PiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0Bh
bWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkg
KEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
IDMvOF0gY3B1ZnJlcTogYW1kLXBzdGF0ZTogY2hhbmdlIGRyaXZlciB0byBiZSBidWlsdC1pbg0K
PiB0eXBlDQo+IA0KPiArIHd5ZXMua2FybnlAYW1kLmNvbQ0KPiANCj4gWW91IHNob3VsZCBzeW5j
IHdpdGggV3llcyBLYXJueSBvbiB0aGlzIHBhdGNoLCBJIHRoaW5rIGhlIGhhZCBzb21lIGRpZmZl
cmVudA0KPiBpZGVhcyB0aGF0IHlvdSBndXlzIHNob3VsZCBmb2xkIHRvZ2V0aGVyIGZvciB2NCBv
ZiB0aGlzIHNlcmllcy4gIEknbGwgbGVhdmUgc29tZQ0KPiBkaXJlY3QgY29tbWVudHMgb24geW91
ciBpbXBsZW1lbnRhdGlvbiBiZWxvdy4NCj4gDQo+IEFsc28sIGluY2x1ZGUgaGltIGluIG9uIEND
IGZvciB5b3VyIHY0Lg0KPiANCj4gT24gMTEvNy8yMDIyIDExOjU3LCBQZXJyeSBZdWFuIHdyb3Rl
Og0KPiA+IENoYW5nZSB0aGUgYGFtZC1wc3RhdGVgIGRyaXZlciBhcyB0aGUgYnVpbHQtaW4gdHlw
ZSB3aGljaCBjYW4gaGVscCB0bw0KPiA+IGxvYWQgdGhlIGRyaXZlciBiZWZvcmUgdGhlIGFjcGlf
Y3B1ZnJlcSBkcml2ZXIgYXMgdGhlIGRlZmF1bHQgcHN0YXRlDQo+ID4gZHJpdmVyIGZvciB0aGUg
QU1EIHByb2Nlc3NvcnMuDQo+ID4NCj4gPiBmb3IgdGhlIHByb2Nlc3NvcnMgZG8gbm90IGhhdmUg
dGhlIGRlZGljYXRlZCBNU1IgZnVuY3Rpb25zLCBhZGQNCj4gPiBgYW1kLXBzdGF0ZT1sZWdhY3lf
Y3BwY2AgdG8gZ3J1YiB3aGljaCBlbmFibGUgc2hhcmVkIG1lbW1vcnkgaW50ZXJmYWNlDQo+ID4g
dG8gY29tbXVuaWNhdGUgd2l0aCBjcHBjX2FjcGkgbW9kdWxlIHRvIGNvbnRyb2wgcHN0YXRlIGhp
bnRzLg0KPiANCj4gMSkgcy9tZW1tb3J5L21lbW9yeS8NCj4gMikgQWx0aG91Z2ggbWFueSB1c2Vy
cyB3aWxsIHVzZSBHUlVCIHRvIGNvbmZpZ3VyZSB0aGVpciBrZXJuZWwgY29tbWFuZA0KPiBsaW5l
IHlvdSBzaG91bGQgbm90IGFzc3VtZSBpdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNCkZpeGVk
IGluIFY0LiANCg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPFBlcnJ5
Lll1YW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRl
LmMgfCAyMyArKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gWW91IG5lZWQgdG8gZG9jdW1l
bnQgdGhlIG5ldyBlYXJseSBwYXJhbWV0ZXIgc3VwcG9ydCBpbiBrZXJuZWwtDQo+IHBhcmFtZXRl
cnMudHh0LCBhbmQgc2hvdWxkIGFsc28gcHV0IGl0IGluIGFtZC1wc3RhdGUucnN0Lg0KPiANCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gYi9k
cml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IGFjZTdkNTBjZjJhYy4uMTQ5MDY0MzFk
YzE1DQo+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4g
PiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gQEAgLTU5LDEwICs1OSw3
IEBADQo+ID4gICAgKiB3ZSBkaXNhYmxlIGl0IGJ5IGRlZmF1bHQgdG8gZ28gYWNwaS1jcHVmcmVx
IG9uIHRoZXNlIHByb2Nlc3NvcnMgYW5kIGFkZA0KPiBhDQo+ID4gICAgKiBtb2R1bGUgcGFyYW1l
dGVyIHRvIGJlIGFibGUgdG8gZW5hYmxlIGl0IG1hbnVhbGx5IGZvciBkZWJ1Z2dpbmcuDQo+ID4g
ICAgKi8NCj4gPiAtc3RhdGljIGJvb2wgc2hhcmVkX21lbSA9IGZhbHNlOw0KPiA+IC1tb2R1bGVf
cGFyYW0oc2hhcmVkX21lbSwgYm9vbCwgMDQ0NCk7IC0NCj4gTU9EVUxFX1BBUk1fREVTQyhzaGFy
ZWRfbWVtLA0KPiA+IC0JCSAiZW5hYmxlIGFtZC1wc3RhdGUgb24gcHJvY2Vzc29ycyB3aXRoIHNo
YXJlZCBtZW1vcnkNCj4gc29sdXRpb24gKGZhbHNlID0gZGlzYWJsZWQgKGRlZmF1bHQpLCB0cnVl
ID0gZW5hYmxlZCkiKTsNCj4gPiArc3RhdGljIGJvb2wgc2hhcmVkX21lbSBfX3JlYWRfbW9zdGx5
Ow0KPiA+DQo+ID4gICBzdGF0aWMgc3RydWN0IGNwdWZyZXFfZHJpdmVyIGFtZF9wc3RhdGVfZHJp
dmVyOw0KPiA+DQo+ID4gQEAgLTY1MywxNiArNjUwLDIyIEBAIHN0YXRpYyBpbnQgX19pbml0IGFt
ZF9wc3RhdGVfaW5pdCh2b2lkKQ0KPiA+DQo+ID4gICAJcmV0dXJuIHJldDsNCj4gPiAgIH0NCj4g
PiArZGV2aWNlX2luaXRjYWxsKGFtZF9wc3RhdGVfaW5pdCk7DQo+ID4NCj4gPiAtc3RhdGljIHZv
aWQgX19leGl0IGFtZF9wc3RhdGVfZXhpdCh2b2lkKQ0KPiA+ICtzdGF0aWMgaW50IF9faW5pdCBh
bWRfcHN0YXRlX3BhcmFtKGNoYXIgKnN0cikNCj4gPiAgIHsNCj4gPiAtCWNwdWZyZXFfdW5yZWdp
c3Rlcl9kcml2ZXIoJmFtZF9wc3RhdGVfZHJpdmVyKTsNCj4gPiArCWlmICghc3RyKQ0KPiA+ICsJ
CXJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gLQlhbWRfcHN0YXRlX2VuYWJsZShmYWxzZSk7DQo+
ID4gLX0NCj4gPiArCS8qIGVuYWJsZSBzaGFyZWQgbWVtb3J5IHR5cGUgQ1BQQyAsaWYgeW91IHBy
b2Nlc3NvciBoYXMgbm8gTVNSLA0KPiB5b3UgaGF2ZSB0byBhZGQgdGhpcw0KPiA+ICsJICogdG8g
eW91ciBncnViIHRvIG1ha2UgY3BwYyBkcml2ZXIgbG9hZGVkIHN1Y2Nlc3NmdWxseS4NCj4gDQo+
IERvbid0IHJlZmVyZW5jZSBHUlVCIGhlcmUsIGl0IHNob3VsZCBiZSByZWZlcmVuY2VkIGZyb20g
dGhlIGtlcm5lbA0KPiBjb21tYW5kIGxpbmUuDQo+IA0KPiA+ICsJICovDQo+ID4gKwlpZiAoIXN0
cmNtcChzdHIsICJsZWdhY3lfY3BwYyIpKQ0KPiA+ICsJCXNoYXJlZF9tZW0gPSB0cnVlOw0KPiBT
eW5jIHdpdGggV3llcyBhYm91dCB0aGlzLiAgSGUgaGFkIHNvbWUgZGlmZmVyZW50IHN0cmluZ3Mg
YW5kIGZsb3cgaW4gbWluZA0KPiB3aGljaCBJIHRoaW5rIHdvdWxkIGJlIG1vcmUgcHJlZmVyYWJs
ZS4NCg0KQWxpZ25lZCB3aXRoIFd5ZXMsIA0KU29tZSBuZXcgY2hhbmdlcyBicm91Z2h0ICBpbnRv
IFY0Lg0KUGxlYXNlIGhlbHAgdG8gdGFrZSBhIGxvb2sgYXQgdGhlIG5ldyBwYXRjaC4NClRoYW5r
cw0KDQpQZXJyeS4gDQoNCg0KPiANCj4gPg0KPiA+IC1tb2R1bGVfaW5pdChhbWRfcHN0YXRlX2lu
aXQpOw0KPiA+IC1tb2R1bGVfZXhpdChhbWRfcHN0YXRlX2V4aXQpOw0KPiA+ICsJcmV0dXJuIDA7
DQo+ID4gK30NCj4gPiArZWFybHlfcGFyYW0oImFtZC1wc3RhdGUiLCBhbWRfcHN0YXRlX3BhcmFt
KTsNCj4gPg0KPiA+ICAgTU9EVUxFX0FVVEhPUigiSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNv
bT4iKTsNCj4gPiAgIE1PRFVMRV9ERVNDUklQVElPTigiQU1EIFByb2Nlc3NvciBQLXN0YXRlIEZy
ZXF1ZW5jeSBEcml2ZXIiKTsNCg==
