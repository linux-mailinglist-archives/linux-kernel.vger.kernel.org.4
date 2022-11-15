Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B08628FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiKOCC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiKOCCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:02:22 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7548F175B0;
        Mon, 14 Nov 2022 18:02:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTCZuUvPLzejALuKXs4uHRrzsH7jfUsFHdqA4NzX6BgKxguY2EHrFAVm1oJPbRBWJ+lc33hFbWieaGaRsQJ5b0HCgQAlY7j3wVAvH00Qbl3cJT2zYAZ3Fg5gqgbT7CwIW/Ia2vDs+MBighfZk2og019dNrj1XYGD4NxrT254mLFqzFsnLpA0VssWEWRXEU2YboWlb/3yGRD0KJaghjQWe/HuC9FXWj2GJUJzBQkfgJ5/S1JJ3mTjqXvaU2B/NJZuWtEhzREwAed6C/c+zJHy53Z7tUui4oHNHCF3Wfq9V0NcwkV5nZuiBnpD6WK3+PS/rr9aYuAKFTgcscDhAprkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPKrWSd3IyIa1sj+rig+L+EXR2X4/ckP+qHax/57ssE=;
 b=PYK4YU5Qfwa4uRJ8vSnQ6XoxFyyqOXwHLcRRNxQWjODljG8KORarnjySo/BX7vfSoiW1i7MJQnX7QudaOFsoU7afSd5Vi/FSLKLrTS5rSmloaWCvD3UBM1fe8QpZRocXp4rLqPGdDXdnbxE3tZ1S/lH3Bt+Z62YG1hrkOzBl81C5cXrhBa21zpOzgEJaF0LeTU301cwp7o2AjYQ2CjGi5/Xmq61qtX4RCPcJAV0teSJZQIa3xD8DY8Q5EYn9evcRm7mhm4qtstHKCMv3STKQvOVufKLNHfckn7gt546PbriAI18S6eRWW4FOCOg07zBFIvi3pHTMvqpdGUwWsH9cbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPKrWSd3IyIa1sj+rig+L+EXR2X4/ckP+qHax/57ssE=;
 b=5B0HoDZSQxHC7gF6+Qsjkxxd9N3+EHVWFdxTDamOtm+aKH6KpOzPfOSVfr8RaGfOcO9ZWAzMyWS24wIwiEKI9KtAY/g+12SmdiGmG3idDhTgWnzboiBaXayrrGy6UwIZwOsP6NO5i5Xx9Gf1F4DB+OkjrSgTpp4oq9vUW+8OQ3g=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 02:02:14 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%8]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 02:02:14 +0000
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
Subject: RE: [PATCH v4 3/9] cpufreq: amd-pstate: change amd-pstate driver to
 be built-in type
Thread-Topic: [PATCH v4 3/9] cpufreq: amd-pstate: change amd-pstate driver to
 be built-in type
Thread-Index: AQHY9S4szXsadYSI/Eeej6+Pf4zLHa4/C2OAgAA2hlA=
Date:   Tue, 15 Nov 2022 02:02:14 +0000
Message-ID: <DM4PR12MB527806DE50E92CDE5625CFB69C049@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
 <20221110175847.3098728-4-Perry.Yuan@amd.com>
 <7cdf6256-d0be-0037-4ec1-405ad10f90fe@amd.com>
In-Reply-To: <7cdf6256-d0be-0037-4ec1-405ad10f90fe@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-15T02:01:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1fdd0ae8-bd90-4cb3-ba88-0d1ca611b171;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-15T02:02:12Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: bf692e0f-4e20-4ce2-8973-cc72a8e23c46
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY5PR12MB6132:EE_
x-ms-office365-filtering-correlation-id: 99dae47e-4caf-4a7f-6443-08dac6ad6aa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9b7uWkAIfipqdyRGObDClWNTExtvhv6+MDNa3T9KSfJEnBi/I5ChWNCmp+Ls4ToZUs6y0AP266z9g//3PUGzFHHyCRU/qblgflgswucseeAd0LOY+VjPHqA2E6eMczEOoSGpcInWjz6I0sZkPLPCHAdupzwLym5LAFo0YQHZb2SfGkwokXone5dpdvg57ozyBsT4wi2j5XxbGNTgb+R4kSA2aFCFVnuXc//JeQ/pNPt53OCLBjkt7oFGgJAyDYYBVGZfxUkqSzmLHUllKuO8bmNPK/Q10vOUHsbZqVu6bz+BmoA03T7Ae2xRb3ugTPq9z4WqzrkSAUQCZfGRKFEN2xAo7hFzPjgVMMULhQbnCZiSMd1msmN00L7IKidXKM4je1BZW3pJIM/G4hTsrBSQ00mApviGAOLcF7cl5hbT1kw75h+ETjcOFfmrMbHYoGtV12asE2NrlZaCGI96Q+W6EIzprevzkPVaBh+lPJnJibLtGIK+GrjVn8VDx+k3CfGJBk72xqvJEJiM5dOO13kyk6YppYLvJmcwyE8gg54EGJW6J6lnhbIBb9ezN3QCqsrr8lxNK2kgvOoKDWY2grgR5owoMtcrB9s45KGRtH37QeVTUCLuxITzFacokvEV4iGKzru91vqOrLJkKb0vE+d+6SMXB5Im4OmnLeOF4UaAzSGvYdZF90ZzRwNrLKeek/JIjdi7VUMAEFdGocSmQNMNwb3xwbbLSSyAsMkVIXil5BqEZ8SqGW+nnUOG+UWRvXU/b3sE9cd2yczJBuYJbU115g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(5660300002)(186003)(41300700001)(8936002)(52536014)(2906002)(53546011)(316002)(66446008)(64756008)(8676002)(4326008)(66946007)(76116006)(66556008)(66476007)(26005)(38100700002)(55016003)(122000001)(9686003)(86362001)(33656002)(83380400001)(38070700005)(71200400001)(54906003)(110136005)(478600001)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHdKN3p6d1l5cStoVVphNkFhL1loWnRjV3Jsc0VJdWk0aTBadXk5MWpEdnBw?=
 =?utf-8?B?OFN0NVdQcFZaeENDaXhsR0dtaDNVaGlZeGV4RlBJVTZrQTlHc0w5Ym5OU0FZ?=
 =?utf-8?B?dmlXVVE0WmZVTHpVVlpEVW9GSEtlb1N2UzhZeHpiayt3clNYajM5TndpSjEz?=
 =?utf-8?B?L3FOYncrUWtYWFhYTjRmVHIyd1l3YTU5TUUyZm1BUE4wMWxDVzAyc1JkSFdR?=
 =?utf-8?B?VkRSSFZ6VFg3dEE1ZEdDNHcrM29SSSs1WXBWbDJMUkQ1djdEREEycTVMZmxw?=
 =?utf-8?B?RE0vaXJ6RXh0UnRRQW12VzI2MXMraWMyYm1OdE9pai9FSkg1cHowS1FWSm9u?=
 =?utf-8?B?WGN3TUduWUc2S3NDR3I2M2VwaHNiSGZ1dVRRaHMyZ1NseGlsZmZvVis3amYw?=
 =?utf-8?B?UWtYM3A1R3BkSi9YUFIxN2x6Z2tCMW0vbGlCTkNHWXlRV3pJK3ZpeWQ2cDlp?=
 =?utf-8?B?VmR5TFd0Y2RQR1VwMUkrWGFWUE9EMm8rRW9hb1FybXg0L1UrVDVLV200a3Fi?=
 =?utf-8?B?SUM3bjdrdlMwSEJuMjZHcUMra1Y1Ly9NZzlrOENIMWFNM21IMGg2N3Z4ODlp?=
 =?utf-8?B?Qkg3cVhnK3FuU0RtdlVDVW1nUXFWVWE5Q3VieGwzUFoydGxKeS94SGFiRjRo?=
 =?utf-8?B?UXRobTBPakR0cXc2QzdnT0VtbVVkZUsySldZRzN1TFg1bEVQSncxSGJtN1E0?=
 =?utf-8?B?dHRqWTZwdkZmOVliejN2TXQzN21hbWd6eUw4b0I3cE50UDcwZmxkcUl4T09C?=
 =?utf-8?B?ejRPL2g1UEcvczFZalhOeFNDZXQzQzYwRmJlRC9xSUMyZ2gwSlVCYUNTYkdZ?=
 =?utf-8?B?Zk9aRDYrRkxxNThGVEZpOW1KSmorWGp4eGJsQmtXcnlnMmpZUHlwNWUwOHZr?=
 =?utf-8?B?ZGFiZXl0dWUwTXE2TWhHYlBYNzg0MWN3eVptZVhuSWtxT0tYS3kreEhjejZK?=
 =?utf-8?B?L0MyWXVldWU5RlF0M2NRMW5rVGtMRGRJRklIMnBTeVloV1dIa2xjOXpwVVZJ?=
 =?utf-8?B?RkFqeTQybnlPUU5ydWE4RGtxdUdiaWloR0RwRE5xVll2MFBuZFdjaTJMWW5S?=
 =?utf-8?B?R3hNVlFHME1TN0wrNHdpT2M0YXMrWTVsWnh0aFJXZEd1R21XdWN5dEk5MjZr?=
 =?utf-8?B?UTg3MkJWWGhKQmdKWDg2RjIveFNsWEp4TWRCMERwVXNGWmtlY1UwUktjODhR?=
 =?utf-8?B?SnZMSGJ1eFlaLzU1dlFEM3J4NkVBZkdYUGN1dkhtRmxtQ3NyMzhhTjRwR3dO?=
 =?utf-8?B?NU56Q2ljWE82K050UkRGTHp3UEpaaHM4T0phTXFKbFVPZjUzVU5vK01mKzdD?=
 =?utf-8?B?WWwwWWJ1MUFXVFNZVktORVlCOGVVT2lEdUdocWZtSytqQS9XUzIvY1QxREFu?=
 =?utf-8?B?aU96dWZtbzJBNjBUcW52cXMwOGFPcWd2TThxdnFGRExLUTJZVzhoOHVhOXVh?=
 =?utf-8?B?cG4ycU5BYmpjQTNILzBxZXpkZEYxVG14WHVLY1JWNlkxSUR6dGtLZlE3R0th?=
 =?utf-8?B?YnNjbGtIUGJtWktZY1R0cUhDVkpVd3N4RTl3YXNMZmJGcTIzSmtzb094N1BD?=
 =?utf-8?B?ZHRTbEhodVY4Y1FRbXlZcEZUL2paZkNQNml0WUdFK0YreWJsTzZ0TktrcHZi?=
 =?utf-8?B?N2JWcDhibDhQT2FjdUxEL3ZsWGxuV1d1Y0RUdFh4Q2Q3OFVESE04OU5nL0hF?=
 =?utf-8?B?WDZic3liNTlWcmIyUUhGYTdNNmtEcVMvc1dUbzNkdkp0UVBwQUY1MWxQY0pO?=
 =?utf-8?B?M1VoN0laNXgxajYyNGNybW1VMWlGZWFxUGZWMjdLQWtrT3Z1Z01hcWphWDBx?=
 =?utf-8?B?emNRMzBGTEJQL3FRcFZ3RStoOE1uMWY4Wk1QN2djMXRJYUZiNzdNZENOYkln?=
 =?utf-8?B?ZkE5dmh3c3BrSkMydTNHOFBEYTlwdS9jK2V6S1ZDYytWNzFjUHEwYWRUTzVO?=
 =?utf-8?B?YTNTM052Wk5Rc2dJblhubFg0K1ZSWENKQkFsek5tK3AzdWh3MHFjZ1FTV3hv?=
 =?utf-8?B?alR2VUJtQXdxcHA4QUUycExTcG0yUE9kS3RUUG94MHVUWHg3dnIrYnk1ekp3?=
 =?utf-8?B?UmkrZG5EdXBwbVgyQ2gzN2dEeXJBdXZHeHk4emllcGs0a0pRMSsvaDh4Ukxy?=
 =?utf-8?Q?Ppc+LeiEwiJ7P/h/NqlDdwedY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dae47e-4caf-4a7f-6443-08dac6ad6aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 02:02:14.6638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfWT+pyb4UKu4uvP+1YQYCqCuEFvU77J/4iXhMrwxrWk2PFx0hu6+OeacI8QaUt+vSqCYjIq3154fGPNRX1xtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
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
TGltb25jaWVsbG9AYW1kLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTUsIDIwMjIg
Njo0NiBBTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tOyBIdWFuZywNCj4gUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IHZp
cmVzaC5rdW1hckBsaW5hcm8ub3JnDQo+IENjOiBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJt
YUBhbWQuY29tPjsgRm9udGVub3QsIE5hdGhhbg0KPiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+
OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFu
ZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFv
amlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29t
PjsgS2FybnksIFd5ZXMgPFd5ZXMuS2FybnlAYW1kLmNvbT47DQo+IGxpbnV4LXBtQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY0IDMvOV0gY3B1ZnJlcTogYW1kLXBzdGF0ZTogY2hhbmdlIGFtZC1wc3RhdGUgZHJpdmVy
DQo+IHRvIGJlIGJ1aWx0LWluIHR5cGUNCj4gDQo+IE9uIDExLzEwLzIwMjIgMTE6NTgsIFBlcnJ5
IFl1YW4gd3JvdGU6DQo+ID4gQ2hhbmdlIHRoZSBgYW1kLXBzdGF0ZWAgZHJpdmVyIGFzIHRoZSBi
dWlsdC1pbiB0eXBlIHdoaWNoIGNhbiBoZWxwIHRvDQo+ID4gbG9hZCB0aGUgZHJpdmVyIGJlZm9y
ZSB0aGUgYWNwaV9jcHVmcmVxIGRyaXZlciBhcyB0aGUgZGVmYXVsdCBwc3RhdGUNCj4gPiBkcml2
ZXIgZm9yIHRoZSBBTUQgcHJvY2Vzc29ycy4NCj4gPg0KPiA+IGZvciB0aGUgcHJvY2Vzc29ycyBk
byBub3QgaGF2ZSB0aGUgZGVkaWNhdGVkIE1TUiBmdW5jdGlvbnMsIGFkZA0KPiA+IGBhbWQtcHN0
YXRlPWxlZ2FjeV9jcHBjYCB0byBncnViIHdoaWNoIGVuYWJsZSBzaGFyZWQgbWVtb3J5IGludGVy
ZmFjZQ0KPiA+IHRvIGNvbW11bmljYXRlIHdpdGggY3BwY19hY3BpIG1vZHVsZSB0byBjb250cm9s
IHBzdGF0ZSBoaW50cy4NCj4gDQo+IERpZCB5b3Ugc3luYyB3aXRoIFd5ZXMgYWxyZWFkeSBhcyBJ
IGhhZCBzdWdnZXN0ZWQ/ICBXYXMgdGhpcyB0aGUgb3V0Y29tZT8NCj4gDQo+IEkgd2FzIGEgYml0
IHN1cnByaXNlZCB0byBzZWUgdGhpcyBzdGlsbCBhcyBsZWdhY3lfY3BwYyB3aGVuIHJldmlld2lu
ZyB2NC4NCg0KVGhlIGRpc2N1c3Npb24gd2UgbWFkZSB3aWxsIGJlIGluIFY1IHNvb24uIA0KSSBh
bSB3b3JraW5nIG9uIGl0Lg0KDQoNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZXJyeSBZ
dWFuIDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2NwdWZyZXEv
S2NvbmZpZy54ODYgIHwgIDIgKy0NCj4gPiAgIGRyaXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmMg
fCAyNSArKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY3B1ZnJlcS9LY29uZmlnLng4NiBiL2RyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLng4Ng0K
PiA+IGluZGV4IDMxMDc3OWIwN2RhZi4uMDA0NzZlOTRkYjkwIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvY3B1ZnJlcS9LY29uZmlnLng4Ng0KPiA+ICsrKyBiL2RyaXZlcnMvY3B1ZnJlcS9LY29u
ZmlnLng4Ng0KPiA+IEBAIC0zNSw3ICszNSw3IEBAIGNvbmZpZyBYODZfUENDX0NQVUZSRVENCj4g
PiAgIAkgIElmIGluIGRvdWJ0LCBzYXkgTi4NCj4gPg0KPiA+ICAgY29uZmlnIFg4Nl9BTURfUFNU
QVRFDQo+ID4gLQl0cmlzdGF0ZSAiQU1EIFByb2Nlc3NvciBQLVN0YXRlIGRyaXZlciINCj4gPiAr
CWJvb2wgIkFNRCBQcm9jZXNzb3IgUC1TdGF0ZSBkcml2ZXIiDQo+ID4gICAJZGVwZW5kcyBvbiBY
ODYgJiYgQUNQSQ0KPiA+ICAgCXNlbGVjdCBBQ1BJX1BST0NFU1NPUg0KPiA+ICAgCXNlbGVjdCBB
Q1BJX0NQUENfTElCIGlmIFg4Nl82NA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NwdWZyZXEv
YW1kLXBzdGF0ZS5jDQo+ID4gYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jIGluZGV4IGFj
ZTdkNTBjZjJhYy4uODVhMGIzZmI1NmMyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY3B1ZnJl
cS9hbWQtcHN0YXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+
ID4gQEAgLTU5LDEwICs1OSw3IEBADQo+ID4gICAgKiB3ZSBkaXNhYmxlIGl0IGJ5IGRlZmF1bHQg
dG8gZ28gYWNwaS1jcHVmcmVxIG9uIHRoZXNlIHByb2Nlc3NvcnMgYW5kIGFkZA0KPiBhDQo+ID4g
ICAgKiBtb2R1bGUgcGFyYW1ldGVyIHRvIGJlIGFibGUgdG8gZW5hYmxlIGl0IG1hbnVhbGx5IGZv
ciBkZWJ1Z2dpbmcuDQo+ID4gICAgKi8NCj4gPiAtc3RhdGljIGJvb2wgc2hhcmVkX21lbSA9IGZh
bHNlOw0KPiA+IC1tb2R1bGVfcGFyYW0oc2hhcmVkX21lbSwgYm9vbCwgMDQ0NCk7IC0NCj4gTU9E
VUxFX1BBUk1fREVTQyhzaGFyZWRfbWVtLA0KPiA+IC0JCSAiZW5hYmxlIGFtZC1wc3RhdGUgb24g
cHJvY2Vzc29ycyB3aXRoIHNoYXJlZCBtZW1vcnkNCj4gc29sdXRpb24gKGZhbHNlID0gZGlzYWJs
ZWQgKGRlZmF1bHQpLCB0cnVlID0gZW5hYmxlZCkiKTsNCj4gPiArc3RhdGljIGJvb2wgc2hhcmVk
X21lbSBfX3JlYWRfbW9zdGx5Ow0KPiA+DQo+ID4gICBzdGF0aWMgc3RydWN0IGNwdWZyZXFfZHJp
dmVyIGFtZF9wc3RhdGVfZHJpdmVyOw0KPiA+DQo+ID4gQEAgLTY1MywxNiArNjUwLDI0IEBAIHN0
YXRpYyBpbnQgX19pbml0IGFtZF9wc3RhdGVfaW5pdCh2b2lkKQ0KPiA+DQo+ID4gICAJcmV0dXJu
IHJldDsNCj4gPiAgIH0NCj4gPiArZGV2aWNlX2luaXRjYWxsKGFtZF9wc3RhdGVfaW5pdCk7DQo+
ID4NCj4gPiAtc3RhdGljIHZvaWQgX19leGl0IGFtZF9wc3RhdGVfZXhpdCh2b2lkKQ0KPiA+ICtz
dGF0aWMgaW50IF9faW5pdCBhbWRfcHN0YXRlX3BhcmFtKGNoYXIgKnN0cikNCj4gPiAgIHsNCj4g
PiAtCWNwdWZyZXFfdW5yZWdpc3Rlcl9kcml2ZXIoJmFtZF9wc3RhdGVfZHJpdmVyKTsNCj4gPiAr
CWlmICghc3RyKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gLQlhbWRfcHN0YXRl
X2VuYWJsZShmYWxzZSk7DQo+ID4gLX0NCj4gPiArCS8qDQo+ID4gKwkgKiBzdXBwb3J0IHNoYXJl
ZCBtZW1vcnkgdHlwZSBDUFBDIHdoaWNoIGhhcyBubyBNU1IgZnVuY3Rpb24uDQo+ID4gKwkgKiBl
bmFibGUgYW1kLXBzdGF0ZSBvbiBwcm9jZXNzb3JzIHdpdGggc2hhcmVkIG1lbW9yeSBzb2x1dGlv
bg0KPiA+ICsJICogKGFtZC1wc3RhdGU9bGVnYWN5X2NwcGMgZW5hYmxlZCksIGl0IGlzIGRpc2Fi
bGVkIGJ5IGRlZmF1bHQuDQo+ID4gKwkgKi8NCj4gPiArCWlmICghc3RyY21wKHN0ciwgImxlZ2Fj
eV9jcHBjIikpDQo+ID4gKwkJc2hhcmVkX21lbSA9IHRydWU7DQo+ID4NCj4gPiAtbW9kdWxlX2lu
aXQoYW1kX3BzdGF0ZV9pbml0KTsNCj4gPiAtbW9kdWxlX2V4aXQoYW1kX3BzdGF0ZV9leGl0KTsN
Cj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gK2Vhcmx5X3BhcmFtKCJhbWQtcHN0YXRlIiwg
YW1kX3BzdGF0ZV9wYXJhbSk7DQo+IA0KPiBEb2N1bWVudGF0aW9uL2tlcm5lbC1wYXJhbWV0ZXJz
LnR4dCBuZWVkcyB0byBiZSB1cGRhdGVkIGZvciB0aGlzIGVhcmx5DQo+IHBhcmFtZXRlciBzdXBw
b3J0Lg0KDQpZZWFoLCB0aGF0IHdpbGwgYWxzbyBiZSBpbiBWNSB0b2dldGhlci4NCg0KPiANCj4g
Pg0KPiA+ICAgTU9EVUxFX0FVVEhPUigiSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4iKTsN
Cj4gPiAgIE1PRFVMRV9ERVNDUklQVElPTigiQU1EIFByb2Nlc3NvciBQLXN0YXRlIEZyZXF1ZW5j
eSBEcml2ZXIiKTsNCg==
