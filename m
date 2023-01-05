Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2DA65E53B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjAEFt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjAEFt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:49:56 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC6D4087D;
        Wed,  4 Jan 2023 21:49:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVMpKR87PGHQJk8eK6gygU5h6JahBSm9A6LZxDwaD6K+tXkpWsM46MkelkKhgpUrUTKERygRfQZ5R/MGGX+fslP53VThQdhk7p+OQQ/wahwisyeZAT3o5ngnYbkrMBfl+hBlM2QMoXwJaoFt6ZgdFe5PuLGmUgQsRhnLKC2K0fZFllZfUaf5O6nCDT33iOcJ6pGLSV+5YZQ0F+XwedruuT0ISrkgMaZ3VEzoMF91t0vm1kMp3R6qtJppFZ/PR1MBLx7UFXrCue5RAlkD4pBAY3c86Dezu0KLfcTkLpXf16r/BVJUunT1WDOxkC0MmGVu6K0hQSH7eMFvy4+KinJl/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SRlQ89RWi1jnZHNdqJhHHaBGmzIjda2AbiE5b+x5I8=;
 b=Bia+CXbFbTX2eWj2m1CNNDTjKAh/hktK6HSTP0MChVmz26W8pn7L/VNH6BtKObAciDcbiWcle9o6tcY49gKNRtRMZq1IxJk2mjl+MGeNXUUrviuGu8+PuslHAHsMdw3fFvEtnsfblnssdst9g73sU7Im6xd2XCFrBrQzYpo20oUznH6wSICm+21pLsqlDfIGbOtUFaKqsDmp1y39C1iCF6KRlC1BLLPI7drr4Zd+4mVvJ8IOgbFy7xgbMBqFIwuT9q/rZS3/Zq1eMwbPuWGDx6iZP4kv4G0VKfuOBh5r3Somd/NmveRQP4Nzoo917gKnezvqmc6FKpr+OuEXQRgX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SRlQ89RWi1jnZHNdqJhHHaBGmzIjda2AbiE5b+x5I8=;
 b=EFb8RpFSml9EvDo/6emmO2eSYFp/6APlnDrgqd/1vcOngGBcwDqCu3ZjH7pjWBnaYdL2+eIA89C6+0fziF0MS33lkRgKpwfINyYmlA3K8VTwNKdUPYPboSLRrgWUg+9gY9trnqdefWtnTxcwkViSpkdpIb9wsWQhsDDl7noXim0=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 05:49:52 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 05:49:52 +0000
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
Subject: RE: [PATCH v9 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Topic: [PATCH v9 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Index: AQHZGH7vDlYW86zG/kOXbWfPNoGdH66NdsQAgAHCISA=
Date:   Thu, 5 Jan 2023 05:49:52 +0000
Message-ID: <DM4PR12MB5278F31C41AA3DFD5569FEB89CFA9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-4-perry.yuan@amd.com>
 <700d3351-1a52-5362-d22d-9326ad1220e5@amd.com>
In-Reply-To: <700d3351-1a52-5362-d22d-9326ad1220e5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-05T05:49:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ddc07089-56a0-43d7-8bd5-95db1abe996c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-05T05:49:49Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a7ed8781-2be1-4118-b2ae-4a645616a977
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|BN9PR12MB5100:EE_
x-ms-office365-filtering-correlation-id: 5cb6edfb-32a5-4446-422b-08daeee0aa67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KFx0OqyKRx+FTtlO/f3Jv8094SzyF+2sKpaoq4q1fMbRUh8QKpf9eDoBkk4zsIzdkLZcMzs8F2poqNQSFVRdUK+ejfuMweQ9zYevj7mDtABALzaoA0JaaOrvj+Lq82vcnq30o8Y5jBCZa6sJHkaBpPcnHsE55VIpUfy8ltsPptmUJqSFOy5xVgq0dded8WE2GHLM5ExTbbr6tNmChtg2Y6HdmnPSmz2BC2Jf33stS6JLzEM7aX1IJPxxkfZ21ECez4pPlxzGMBcmktS9FfYitnfg5T39l1TxRBBo7t1anMs0UGW9uXA5yan+eUE3WeQ8BQI6ObAJ36agLPA6lMucIrtGtetrmveMfQOhQp02V2Z8K7CYRBpxu5IFgsqR7cUzE3pGQt2gjsMDHIvazySRmgkhtlWJZNoYaVw2xCeRHehO+KlvvQMYlYRonx7Iz01rzj56td4WdOVdtTtYWwt+a5+h250/RZ9yJ89neHO0FiszKARDKIoQuVvOZgvv6/2Qno2ieUjCzSOcJ53xdgujlSZF1n+pXpOCzVHFfcmqcv7/S5wpzDP+/accHiawYyFiHKMWsBBgB1eKDnH2j+nontZV60rvmD008ywjxom4GIXBh1gU6UNxH0b7efIZbB0vNemR74OUkXB5hvU939h3rH64hvqP1CwQ83mVNnMBSPcxF/zhshz13KcJ4tcrRjaf4g/JzvGnKo127mLT86+tew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(41300700001)(66446008)(5660300002)(76116006)(64756008)(66476007)(8676002)(66556008)(66946007)(8936002)(2906002)(4326008)(316002)(110136005)(54906003)(52536014)(6506007)(71200400001)(7696005)(26005)(478600001)(186003)(53546011)(9686003)(55016003)(86362001)(83380400001)(38070700005)(38100700002)(122000001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3hjbUJGY1dnVk1VbnpYaTZ0VlBzS2ltblZhcmRNVGszNGR3T21iNWIrK0NI?=
 =?utf-8?B?Q0Y5L1QzVEJEbnZYaE9udVdOWlZNc1RJVjlFK01Pdm9LM081VWN6UnhvZ2hJ?=
 =?utf-8?B?N3hNbHBCdGxjV3FKUVNRMlJncVpPZWlINnp1cU5ZWUdGeThLSWRKSDl4Q0ls?=
 =?utf-8?B?RlJTTEZtbTVRMU41dHhEOVNUTCtuVHp3QzYxTFZsSUFYL0VFKzhCdVFMcVFM?=
 =?utf-8?B?SklPMGlBN3IwNEQzejlNSTlHOG90Q2E1Qy9wbGxlVWxPU2ZUR2crWDJUa1Fo?=
 =?utf-8?B?MGxKMHRwd3ExMTNveVI0NTdoOGhuOUNmUVYrNk53V2p5RGZkMlpKbFVCZXZx?=
 =?utf-8?B?a3NvOEFzeXQ2OWpUbklvamhSNnplMHcwN3crb29xb2U5cGYxcGpUbXo5MGNL?=
 =?utf-8?B?TEVPMmViTWtQeVptSjRvazlnZHhSVnY3eit4aVQ2a2Zid2twUGtRUHJSem1V?=
 =?utf-8?B?S2FaTkovVnVtVVp2dUlEREZVQ0cwRGVDUEJBUk5waVg2TG94cG96TzB4WU5B?=
 =?utf-8?B?UFY0TzVXUkt2RVJJeEtIZjZIN2NjN2dZdTdMaUhNQXJkMWkzTjM5Y0hNM05n?=
 =?utf-8?B?N2lPdVhhSzRkaGhTdUxxWTFtRFMzRHZhT3hMWTh4bCt2ZU10YTFDRGhmdkZD?=
 =?utf-8?B?Sjg3MlVGOW5tci9EdEs1clZkMnM1ZmVoUkMraGdpSHlnZzlmb2JaaUZKQUZ0?=
 =?utf-8?B?V1BRTnRVTmUxNHlTeUkzRURvTzBQbjNFcXJvRE9SV3FqcEowcmh4QVRIc2tQ?=
 =?utf-8?B?QzJZUmN2aXVMU3cwZVJCNzJuQi9wdG4vNlpUYWo3TlQxMnlpM0tpenJvNCsv?=
 =?utf-8?B?ZW5GbXdocDJ5b0NpQ003dUtFWlhXTjloWDZ1MUNyaUhLZEI0TC9Lb2YwZFcz?=
 =?utf-8?B?dC91S3EvNmtublk5c3poeXFBbC8wMFFENmRUT1pZakJ1d29Ca1FGMGN5SHNH?=
 =?utf-8?B?MEJ6dDlHdHh3L1pOUmt1eVVHd0FIWjZqMHgwTDdScFBSK2RyNXZxS1ZHa1ZC?=
 =?utf-8?B?NTF0Sjh0aE5hK1hEZld6clAvWE9uVk1yOVdCMGxLYS9IYWtrbUJWRjZBYW56?=
 =?utf-8?B?eldTdnBMLzNoWC9SZVhtNTN6cUV2NjNOc0ZXWDVBclhVSE9Mak9vNElwWnpj?=
 =?utf-8?B?M283SWdUVzlYN1dRbG1aUm5wQkVXdmlpRjJyelExaCs3VDlkZnhpMTlROXo3?=
 =?utf-8?B?MWhyb0FCQTBLWWhHRGRZai9saWkySGM5ZXJWMGI0RGVwVXRVblZJeDZtajJa?=
 =?utf-8?B?UEVzQ3FHeVc2SmxUZEs5TzUyUlNDYWhLZlVMdVFMTDd4QWxyL2IrSDNzSkNy?=
 =?utf-8?B?YnZVMWxPd0RSV1hPcnZvdWI4bHJhVytDeGVEWitpT0g2SlNIZm0vbXRlOUJK?=
 =?utf-8?B?dEo3M1V0QnNOekRzYWp0NHNHd0U4ajNkTjROa2VicW1idjJ2Szh0MittOE5K?=
 =?utf-8?B?ZzBRUWpDUng2NVJrS2FTZEw5ZnZubTUzUnZ5dHVpWStlbWxmRjVraW05N1Fq?=
 =?utf-8?B?ZkFJTUo5OEk0NFZVNkNzbmtkazZyVUUxeFFXa1Z3NExlbzFFRWZYQURtQjdW?=
 =?utf-8?B?RmhrWWtGSHFyQnZ3RzRqVEFici9qZVNWbHhKc3JUdHVUV1BBWDVLdW5Fd1p6?=
 =?utf-8?B?ZzRZakJKdlBJOWlZWDJ6K3pvR2RmQ2tQU3d6S2hCWnpkeWlVVDdhSnBNN3dU?=
 =?utf-8?B?ZGg1OVd0RTNYdHNwRTBXaWlSUmhGaFVMUzhDQ0JYeEFEdENtc0NXMjdPSEJq?=
 =?utf-8?B?RE9SRENFem9uMzJTTWxhK0FhZkdTbjUwZm1ZVmZvblpNbU1iS1dBOXRiME5z?=
 =?utf-8?B?dW4wcVByQWszVE1rVVF6RmN6UHJhMVgyTlAyb1pxQmRYRS9MQUlOTndrNHFl?=
 =?utf-8?B?OUdMNVRPR2I4WWl5OGk3S00zQWFUZXZMUnpxcTh6cUZOak8zK3IzTHdCc1Z3?=
 =?utf-8?B?WXd5cUFmRXY5QWZaZTVWcEo3NkNtczJkTTk2ZFZvTStQeDBSTTFLM0NSMHB1?=
 =?utf-8?B?NGE0UDE0dW82ZjNVdGZobjU2YXFLdTM1YlNodFAvR080cnV2SS9xSzU1dVJ2?=
 =?utf-8?B?S0xLZmN6aWxjRFBaWjRhTnhjVkt0SkYwWjQ2RjMvdHdYSXZ5bjhUbFRSRVJ1?=
 =?utf-8?Q?Gb5ZpkLI5AkOtGHrOzbo8VSf0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb6edfb-32a5-4446-422b-08daeee0aa67
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 05:49:52.5013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWrLUa+Y5UOPTXB2AGdkb7OSjIlT79k4HMs/vYGaM05l2f+7VvChff40yBQTSYKRaNDRjsYtXtA9peqMcJNuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5M
aW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgNCwgMjAyMyA4
OjMxIEFNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPjsgcmFmYWVsLmou
d3lzb2NraUBpbnRlbC5jb207IEh1YW5nLA0KPiBSYXkgPFJheS5IdWFuZ0BhbWQuY29tPjsgdmly
ZXNoLmt1bWFyQGxpbmFyby5vcmcNCj4gQ2M6IFNoYXJtYSwgRGVlcGFrIDxEZWVwYWsuU2hhcm1h
QGFtZC5jb20+OyBGb250ZW5vdCwgTmF0aGFuDQo+IDxOYXRoYW4uRm9udGVub3RAYW1kLmNvbT47
IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEh1YW5n
LCBTaGltbWVyDQo+IDxTaGltbWVyLkh1YW5nQGFtZC5jb20+OyBEdSwgWGlhb2ppYW4gPFhpYW9q
aWFuLkR1QGFtZC5jb20+OyBNZW5nLA0KPiBMaSAoSmFzc21pbmUpIDxMaS5NZW5nQGFtZC5jb20+
OyBLYXJueSwgV3llcyA8V3llcy5LYXJueUBhbWQuY29tPjsNCj4gbGludXgtcG1Admdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjkgMDMvMTNdIGNwdWZyZXE6IGludGVsX3BzdGF0ZTogdXNlIGNvbW1vbiBtYWNybw0KPiBk
ZWZpbml0aW9uIGZvciBFbmVyZ3kgUHJlZmVyZW5jZSBQZXJmb3JtYW5jZShFUFApDQo+IA0KPiBP
biAxMi8yNS8yMDIyIDEwOjM0LCBQZXJyeSBZdWFuIHdyb3RlOg0KPiA+IG1ha2UgdGhlIGVuZXJn
eSBwcmVmZXJlbmNlIHBlcmZvcm1hbmNlIHN0cmluZ3MgYW5kIHByb2ZpbGVzIHVzaW5nIG9uZQ0K
PiA+IGNvbW1vbiBoZWFkZXIgZm9yIGludGVsX3BzdGF0ZSBkcml2ZXIsIHRoZW4gdGhlIGFtZF9w
c3RhdGUgZXBwIGRyaXZlcg0KPiA+IGNhbiB1c2UgdGhlIGNvbW1vbiBoZWFkZXIgYXMgd2VsbC4g
VGhpcyB3aWxsIHNpbXBpZnkgdGhlIGludGVsX3BzdGF0ZQ0KPiA+IGFuZCBhbWRfcHN0YXRlIGRy
aXZlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlcnJ5IFl1YW4gPHBlcnJ5Lnl1YW5AYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLng4NiAgICB8ICAy
ICstDQo+ID4gICBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMgfCAxMyArKystLS0tLS0t
LS0tDQo+ID4gICBpbmNsdWRlL2xpbnV4L2NwdWZyZXEuaCAgICAgICAgfCAxMCArKysrKysrKysr
DQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLng4NiBiL2Ry
aXZlcnMvY3B1ZnJlcS9LY29uZmlnLng4Ng0KPiA+IGluZGV4IDAwNDc2ZTk0ZGI5MC4uZjY0YWVm
MWUwOTNkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLng4Ng0KPiA+
ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLng4Ng0KPiA+IEBAIC0zNiw3ICszNiw3IEBA
IGNvbmZpZyBYODZfUENDX0NQVUZSRVENCj4gPg0KPiA+ICAgY29uZmlnIFg4Nl9BTURfUFNUQVRF
DQo+ID4gICAJYm9vbCAiQU1EIFByb2Nlc3NvciBQLVN0YXRlIGRyaXZlciINCj4gPiAtCWRlcGVu
ZHMgb24gWDg2ICYmIEFDUEkNCj4gPiArCWRlcGVuZHMgb24gWDg2ICYmIEFDUEkgJiYgWDg2X0lO
VEVMX1BTVEFURQ0KPiANCj4gVGhpcyBkb2Vzbid0IHNlZW0gcmlnaHQgdG8gbWUuICBXaGF0IGlm
IHNvbWVvbmUgZGlkbid0IGNvbXBpbGUgaW4gSW50ZWwNCj4geDg2IHN1cHBvcnQgZm9yIHRoZWly
IGtlcm5lbD8gIFRoZXkgd291bGRuJ3QgYmUgYWJsZSB0byBwaWNrDQo+IFg4Nl9BTURfUFNUQVRF
Lg0KDQpIb3cgYWJvdXQgY2hhbmdlZCBsaWtlIHRoaXMgPyB3aGVuIGFtZCBwc3RhdGUgZW5hYmxl
ZCwgaXQgd2lsbCBidWlsZCBpbnRlbC1wc3RhdGUuYyBhcyB3ZWxsLiANCg0KICAgZGVwZW5kcyBv
biBYODYgJiYgQUNQSQ0KKyBzZWxlY3QgWDg2X0lOVEVMX1BTVEFURQ0KDQoNCg0KPiANCj4gPiAg
IAlzZWxlY3QgQUNQSV9QUk9DRVNTT1INCj4gPiAgIAlzZWxlY3QgQUNQSV9DUFBDX0xJQiBpZiBY
ODZfNjQNCj4gPiAgIAlzZWxlY3QgQ1BVX0ZSRVFfR09WX1NDSEVEVVRJTCBpZiBTTVAgZGlmZiAt
LWdpdA0KPiA+IGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jIGIvZHJpdmVycy9jcHVm
cmVxL2ludGVsX3BzdGF0ZS5jDQo+ID4gaW5kZXggYWQ5YmUzMTc1M2I2Li45M2E2MGZkYWMwZmMg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jDQo+ID4gKysr
IGIvZHJpdmVycy9jcHVmcmVxL2ludGVsX3BzdGF0ZS5jDQo+ID4gQEAgLTY0MCwxNSArNjQwLDcg
QEAgc3RhdGljIGludCBpbnRlbF9wc3RhdGVfc2V0X2VwYihpbnQgY3B1LCBzMTYgcHJlZikNCj4g
PiAgICAqCTQJCXBvd2VyDQo+ID4gICAgKi8NCj4gPg0KPiA+IC1lbnVtIGVuZXJneV9wZXJmX3Zh
bHVlX2luZGV4IHsNCj4gPiAtCUVQUF9JTkRFWF9ERUZBVUxUID0gMCwNCj4gPiAtCUVQUF9JTkRF
WF9QRVJGT1JNQU5DRSwNCj4gPiAtCUVQUF9JTkRFWF9CQUxBTkNFX1BFUkZPUk1BTkNFLA0KPiA+
IC0JRVBQX0lOREVYX0JBTEFOQ0VfUE9XRVJTQVZFLA0KPiA+IC0JRVBQX0lOREVYX1BPV0VSU0FW
RSwNCj4gPiAtfTsNCj4gPiAtDQo+ID4gLXN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgZW5lcmd5
X3BlcmZfc3RyaW5nc1tdID0gew0KPiA+ICtjb25zdCBjaGFyICogY29uc3QgZW5lcmd5X3BlcmZf
c3RyaW5nc1tdID0gew0KPiA+ICAgCVtFUFBfSU5ERVhfREVGQVVMVF0gPSAiZGVmYXVsdCIsDQo+
ID4gICAJW0VQUF9JTkRFWF9QRVJGT1JNQU5DRV0gPSAicGVyZm9ybWFuY2UiLA0KPiA+ICAgCVtF
UFBfSU5ERVhfQkFMQU5DRV9QRVJGT1JNQU5DRV0gPSAiYmFsYW5jZV9wZXJmb3JtYW5jZSIsDQo+
IEBAIC02NTYsNw0KPiA+ICs2NDgsOCBAQCBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGVuZXJn
eV9wZXJmX3N0cmluZ3NbXSA9IHsNCj4gPiAgIAlbRVBQX0lOREVYX1BPV0VSU0FWRV0gPSAicG93
ZXIiLA0KPiA+ICAgCU5VTEwNCj4gPiAgIH07DQo+ID4gLXN0YXRpYyB1bnNpZ25lZCBpbnQgZXBw
X3ZhbHVlc1tdID0gew0KPiA+ICsNCj4gPiArdW5zaWduZWQgaW50IGVwcF92YWx1ZXNbXSA9IHsN
Cj4gPiAgIAlbRVBQX0lOREVYX0RFRkFVTFRdID0gMCwgLyogVW51c2VkIGluZGV4ICovDQo+ID4g
ICAJW0VQUF9JTkRFWF9QRVJGT1JNQU5DRV0gPSBIV1BfRVBQX1BFUkZPUk1BTkNFLA0KPiA+ICAg
CVtFUFBfSU5ERVhfQkFMQU5DRV9QRVJGT1JNQU5DRV0gPQ0KPiBIV1BfRVBQX0JBTEFOQ0VfUEVS
Rk9STUFOQ0UsIGRpZmYNCj4gPiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY3B1ZnJlcS5oIGIvaW5j
bHVkZS9saW51eC9jcHVmcmVxLmggaW5kZXgNCj4gPiBkNTU5NWQ1N2Y0ZTUuLjA2OTMyNjlmYjc3
NSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2NwdWZyZXEuaA0KPiA+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvY3B1ZnJlcS5oDQo+ID4gQEAgLTE4NSw2ICsxODUsMTYgQEAgc3RydWN0IGNw
dWZyZXFfZnJlcXMgew0KPiA+ICAgCXU4IGZsYWdzOwkJLyogZmxhZ3Mgb2YgY3B1ZnJlcV9kcml2
ZXIsIHNlZSBiZWxvdy4gKi8NCj4gPiAgIH07DQo+ID4NCj4gPiArZW51bSBlbmVyZ3lfcGVyZl92
YWx1ZV9pbmRleCB7DQo+ID4gKwlFUFBfSU5ERVhfREVGQVVMVCA9IDAsDQo+ID4gKwlFUFBfSU5E
RVhfUEVSRk9STUFOQ0UsDQo+ID4gKwlFUFBfSU5ERVhfQkFMQU5DRV9QRVJGT1JNQU5DRSwNCj4g
PiArCUVQUF9JTkRFWF9CQUxBTkNFX1BPV0VSU0FWRSwNCj4gPiArCUVQUF9JTkRFWF9QT1dFUlNB
VkUsDQo+ID4gK307DQo+ID4gK2V4dGVybiBjb25zdCBjaGFyICogY29uc3QgZW5lcmd5X3BlcmZf
c3RyaW5nc1tdOyBleHRlcm4gdW5zaWduZWQgaW50DQo+ID4gK2VwcF92YWx1ZXNbXTsNCj4gPiAr
DQo+ID4gICAvKiBPbmx5IGZvciBBQ1BJICovDQo+ID4gICAjZGVmaW5lIENQVUZSRVFfU0hBUkVE
X1RZUEVfTk9ORSAoMCkgLyogTm9uZSAqLw0KPiA+ICAgI2RlZmluZSBDUFVGUkVRX1NIQVJFRF9U
WVBFX0hXCSAoMSkgLyogSFcgZG9lcyBuZWVkZWQNCj4gY29vcmRpbmF0aW9uICovDQo+IA0KPiBJ
IHRoaW5rIHRoZSByaWdodCBwbGFjZSBmb3IgdGhlc2UgdmFyaWFibGVzIGFuZCBzdHJpbmdzIGlz
IGluIHRoZSBjcHBjIGxpYnJhcnkNCj4gc291cmNlIGZpbGUgdGhhdCBpcyBjb21tb24gYWNyb3Nz
IENQUEMgaW1wbGVtZW50YXRpb25zLg0K
