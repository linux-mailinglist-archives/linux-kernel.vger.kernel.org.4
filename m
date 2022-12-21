Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67740652BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiLUDIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLUDId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:08:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0815B1AF2E;
        Tue, 20 Dec 2022 19:08:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUUTb9iFbei3TvJ7JPNMwegZCNTDil1VA5wlyPiLdnnTQRgW+4ZqA9qR8ieF63m6Rnm8jmSrvJtDbDteWxnUxVfWY+fb9D36H6OO2TfPCyPGwdYABrM6QbPVc/TTIcDCLtFZp+KsUuYSUGLu6UwDokCrnfrh+jj0ywwGqqeZx4MkZmUVGTaJEwxKyg0YzLxX10KpW307VZeYaC8O1i+eGH+R5FamkI1OEfQEAi9UaIHHr7/pVxH5aKV28aOyuXhhP3PQdW767EfyGa8A632ijdDSxlISLyHcr7G+gZXlesk4bBRY64CXev5Qjfnu/XYQsjBgkObs8wd03esqAxHM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdczuuDe0Bd55SxAj0QqMl6t4Qb8fHmj603GRZMEfmg=;
 b=is6c+8VXGghX/7LB3nqv+HlsXQ+sPZnopZytWJ5VMaqQCRqdlFSeIrbaWFsakpQdNTfRyZrAsGerWAMDZSAjCO1/y5RuhWU/YKpTS8ozbaTOGr3bvrgqNPcA8m4iuKnMhN8jIj8ECxS/pyQ2FYEo09nXdOt9g/8ir4Z3I4BJoDBJBjRDMKxS3XzYdoamLXHTM+CD/T577mIUKYKcY8lslOodHUPM4+SGuRcTc14XCcJoXqR58rfbZ0Te9yYCKnwrnFf/FR5jYtM1WjrlOK63JYuNIkuccGbJgn4h8TytXAvX55Ajq54oECi/iYsMn/Xun4lzOj8v3KlIdjpHanmz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdczuuDe0Bd55SxAj0QqMl6t4Qb8fHmj603GRZMEfmg=;
 b=fZPgt7WPFuj/eO3PEM5DddxU4ugs9ZAJpNBGUB8RT6c5wXA/3NpEGh1Ns1axeF4t2DYjJx5qmpNDmZw0F68/45HXGA1tCMabGKeUZtWPrrXpq9z29HLwtOvcQPvwTaNpBOO+SRtg1z28LzQGaLiesxhuQryAXQXHSiIzzY7EYPI=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Wed, 21 Dec
 2022 03:08:29 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 03:08:29 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Tor Vic <torvic9@mailbox.org>,
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
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 00/13] Implement AMD Pstate EPP Driver
Thread-Topic: [PATCH v8 00/13] Implement AMD Pstate EPP Driver
Thread-Index: AQHZE3TmYgEBXyN7/EuDSIrGXKeYb653FqqAgAAK2gCAAIo5oA==
Date:   Wed, 21 Dec 2022 03:08:28 +0000
Message-ID: <DM4PR12MB52783553074D58DB829827029CEB9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <73b77acd-813a-458b-61e2-87116720cc38@mailbox.org>
 <7602a0c7-df8c-5d6d-401d-55620d28c584@mailbox.org>
In-Reply-To: <7602a0c7-df8c-5d6d-401d-55620d28c584@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-21T03:08:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a519f4af-d530-4e00-bf06-82553e34969e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-21T03:08:24Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8043faec-06a0-43bc-bc5d-910e6b8d4e17
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|DM4PR12MB6352:EE_
x-ms-office365-filtering-correlation-id: 22f01910-797e-4099-6612-08dae300a250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4pC89aak5IB6hH6cE2sfGvkUh1Pke/rYYSgoUtdPUwXNehbqIKlf5UP36cIWmHu0OTUrgywy6AsBfYP0hCpxhadiuQylZTm1KrqedddfLIWXSn+Awyplea0LO45r4xuPqcEKWlt/4PguPs/uYFASeTSyxmyKXhbvzf0uX0GoeFyvJeI/rX/G0S4JKhYCOcZ94Cg5Fi5KYnYrm9h3Hh1sj3/yjZ7fWIhhaVaQczDFlJJR4IoXiBxFQKgNd8ny1+xWOWMF7VrVvx9fb5+rL6CuxlcgEpYmWD1+gql9t9RI1uu7z3uhlnrABd86r/79HBslhAtK4V3ctRjWHHO+52j4ETKrfhv3RVSPTTFGwkaH3YwZovmd6edVAsx1IAcFJBVFBavW+j593eqVVOab7bt6wLgsrnmMPcjOtxTzx1SlTh4GmPrpqhQsGXGPR3YsN979d9e0QFW4LNfzpdbcAOaknmo2AcnaGkkc5gg7tRziI7fMSK5a3xGvv5kHY4HvJ7fVLSUo5RcZkpSkTEE4V3q70B4YfO8af93HMnDrJnJFzpFqg8qKfWsV7I9WVjsNwNev+mtZZpC2MOtFl/Q6F4CfaoyHldzqTiYcHdMu9dPvzl4H+UmwPW8OBn56phZKVDgLT292KNsLYTmjlqPXqDA58P/VuH1Ym73p9JmXftj4MkmEb9BxE5oT1yfoIYixWAVjmBKR3Gx7vSSpE6vfmPQJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(33656002)(8936002)(5660300002)(55016003)(41300700001)(38070700005)(122000001)(83380400001)(38100700002)(86362001)(52536014)(2906002)(478600001)(54906003)(110136005)(71200400001)(76116006)(53546011)(66476007)(26005)(4326008)(186003)(64756008)(316002)(6506007)(66446008)(9686003)(66946007)(7696005)(8676002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VC9mQlhqYU11LzBFVmVlRGxGMkI5OGJRaENGUVVaaEhzcVFNZGhoVkhSc3BP?=
 =?utf-8?B?aGpTUVBCVHFJTUEyc1hyRDEvUzRGb3BOZExCY2daOGxEM1R4amJDaHVWc2Jp?=
 =?utf-8?B?L01NdjhoaUs5SlRaL3NtVzduVldoUU9TTGlRK3pmUmZZeWl5N2doemVpbEJH?=
 =?utf-8?B?WS8rUEtmVkxGZ1hYOFNQTm02NEFXaGwweTBKQ2puMWdzcWJzY1pRSEp1Tlpa?=
 =?utf-8?B?eTZLUk51dDFBckpjY2tIUGh3Z3JGSDVOK0VaL050NGUwY0VDRVRXdU1MRW5w?=
 =?utf-8?B?L0hacVVWSDhaa0JYZmZTTVh5YkFESWRlS0xSQmlXelQvV2JVZ3FPbE9JVTZL?=
 =?utf-8?B?SFY2S3BxNmVZNmE1N0dsVUg1aHdYeUNBR0RuV3lUTGd5bVA1NDNVaXhJSDVV?=
 =?utf-8?B?SG55L05XZExMM1ltRHJ6ckViOG5TTjNlRis4Unc4NXNlQ0pyYnNHRzBabERR?=
 =?utf-8?B?TkhhYVhrYVhJNHZyZzZFQStyTDRMSm1LcWY2WTREVFlwUnM3czNoY3I2cVNH?=
 =?utf-8?B?OTFRRjJpeGtDSDJOeFBKQ0hUYkFqQVpjakRDYis1VWVzU2pQTlhWR1FabnpJ?=
 =?utf-8?B?NXdrQk4zOVZIMHBkQlBVd0tOeTREQklCVWxxZTUrUVFaNzVzL0NoWVdKU1Fq?=
 =?utf-8?B?cHNhTVdZMzE3S3M0cUxUTGxPbjE2ajE3UXZQUVdMQ1B0ZkJLN2l0ckx2Smdt?=
 =?utf-8?B?QWpEWHAyYTJDemlWa3NSQjVXYno1aDRNZFVKZDBrbHBwcDVQNnlOZDZrcW90?=
 =?utf-8?B?WnhqbUU2T2laTms3ZGVxYXhzVDlSUmhGRlpKRFR2b0w4MXFNMEhqOEVrbE0y?=
 =?utf-8?B?c1FsUy8ra0E5QlVzb2hrbUZZanV1STB2QUpHdkw0Q1pMNEZYYXlpemI3YXVk?=
 =?utf-8?B?eTRLNDVSZ3VrSGFYZU1jQlJBTnIzSlNFdVIrdG5rRFgzTTE2ajFaS1dkSHZm?=
 =?utf-8?B?Ukl3TVBBSjkyL3p3bnBaSjFUcXZoVFpPalVoSHh1Mm1kRlpZTDMybHJkRWtV?=
 =?utf-8?B?bkdoc05Cb2FYTnlEVktrOUxDeFFSL2VXUUdWc1ozN01JbXduaHZGNUVxVGF0?=
 =?utf-8?B?S1p0bFVaUHFZSHJqazh6SGF3RlZncjc1T1pGYStVRmhrMXFVVDVVQW9abFRt?=
 =?utf-8?B?Tk5kSnNnbUU5dmxFK01jTHZscGFnMVgvOU82WmgrcmVhMHRvZGJLYnBNekdQ?=
 =?utf-8?B?K2ZVKzd4ekdrWVJUamVnYzFWdTdYdTlweGZlbHQzc1h3blNRTjUwSXBVQlpC?=
 =?utf-8?B?cDJtVzI0L215eG9QSlp3ZlhjK1hTVDF5SHFhTXVnY0xsdDNLdG1LWHUxL3kw?=
 =?utf-8?B?T2s0VDUwRFdBSS9JV2EvdDhlQmZOVmgwMGIwYUk2K2RPYXIrQTNlM1RyY1RS?=
 =?utf-8?B?akdsTFZYekxHOVNMZEpoRmYzdjVEakE2RXJJbTBTSGNwWEpmMjN3MVBLc2Fw?=
 =?utf-8?B?V3J2OE5yQ1FyWTFCVWhhcGFuN3ZhZndWU2wwUVMyZGZ6TEdycUhiWXpwSUox?=
 =?utf-8?B?OFRJYzYvZ2RRL0VOMUFsKytBbExWa3hSL2xINVgzZGRiMUdqdnpiNzlQQWhD?=
 =?utf-8?B?UlNuNGg3MnkzeitzaW96QkZKUnlVK25taEs1WXlIR1FDRGlKd0tPOHM1YVIx?=
 =?utf-8?B?N0xBM2pjNWxZSC9rS1pvYXJwajhMK3dueTRadXBOc3QyWkt4Z2MxNGo0ZDNJ?=
 =?utf-8?B?V0FkQ1JldVZNaitnbk1qRDVQQURISnQveGtvMExsMSs1bUw5QkFEeEV0T1lX?=
 =?utf-8?B?Ky9LMUFqYWVFZUY4UGNjSzBNdlBPc0JjaSsvVFhDZzZxUDNLZkpuWm95cmZj?=
 =?utf-8?B?L2Z0RXhUUThyaFFjQUpXc2VuY3NFdFh4SnhqZ2t3VFNSZ1gvN3Y5YkFET2VW?=
 =?utf-8?B?amRVNU4reDNIaGRzZDlkRVZYQTBoNUJPL3F3d1d0dnFVOWh2VnFlc2hPZnlH?=
 =?utf-8?B?RTRiRkR1SGQvajZtUG0yS0lRYVNaNEtOTXY2ck1ncE55MVRHNWMxSVhiOTVT?=
 =?utf-8?B?UXoreDZvVzdhRUtDUTZoT05vaUx4ek1jY2JScFlZUEIxc0JXWlY1RHhNTTNt?=
 =?utf-8?B?LzdQb3hOY3ExSVZDeGE3cCtCaXY4K0dZZEp5c200SjJjT1RCK0RncHJnZEN3?=
 =?utf-8?Q?yl9I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f01910-797e-4099-6612-08dae300a250
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 03:08:28.8561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JwXV9ScbV5ZOCkrJTFqzk7F4OBHdVqzBrBUz9YVVEPNg7PNdsUpZgs+CLUTf0gmShOEnyvK21JBwvvmnFfKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
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
TWVzc2FnZS0tLS0tDQo+IEZyb206IFRvciBWaWMgPHRvcnZpYzlAbWFpbGJveC5vcmc+DQo+IFNl
bnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMjEsIDIwMjIgMjo1MyBBTQ0KPiBUbzogWXVhbiwgUGVy
cnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tOw0KPiBM
aW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBIdWFuZywgUmF5
DQo+IDxSYXkuSHVhbmdAYW1kLmNvbT47IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnDQo+IENjOiBT
aGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJtYUBhbWQuY29tPjsgRm9udGVub3QsIE5hdGhhbg0K
PiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0Bh
bWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkg
KEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsgS2FybnksIFd5ZXMgPFd5ZXMuS2FybnlAYW1k
LmNvbT47DQo+IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDAwLzEzXSBJbXBsZW1lbnQgQU1EIFBz
dGF0ZSBFUFAgRHJpdmVyDQo+IA0KPiANCj4gT24gMjAuMTIuMjIgMTg6MTMsIFRvciBWaWMgd3Jv
dGU6DQo+ID4NCj4gPiBPbiAxOS4xMi4yMiAwNjo0MCwgUGVycnkgWXVhbiB3cm90ZToNCj4gPj4g
SGkgYWxsLA0KPiA+Pg0KPiA+PiBUaGlzIHBhdGNoc2V0IGltcGxlbWVudHMgb25lIG5ldyBBTUQg
Q1BVIGZyZXF1ZW5jeSBkcml2ZXINCj4gPj4gYGFtZC1wc3RhdGUtZXBwYCBpbnN0YW5jZSBmb3Ig
YmV0dGVyIHBlcmZvcm1hbmNlIGFuZCBwb3dlciBjb250cm9sLg0KPiA+PiBDUFBDIGhhcyBhIHBh
cmFtZXRlciBjYWxsZWQgZW5lcmd5IHByZWZlcmVuY2UgcGVyZm9ybWFuY2UgKEVQUCkuDQo+ID4+
IFRoZSBFUFAgaXMgdXNlZCBpbiB0aGUgQ0NMSyBEUE0gY29udHJvbGxlciB0byBkcml2ZSB0aGUg
ZnJlcXVlbmN5DQo+ID4+IHRoYXQgYSBjb3JlIGlzIGdvaW5nIHRvIG9wZXJhdGUgZHVyaW5nIHNo
b3J0IHBlcmlvZHMgb2YgYWN0aXZpdHkuDQo+ID4+IEVQUCB2YWx1ZXMgd2lsbCBiZSB1dGlsaXpl
ZCBmb3IgZGlmZmVyZW50IE9TIHByb2ZpbGVzIChiYWxhbmNlZCwNCj4gPj4gcGVyZm9ybWFuY2Us
IHBvd2VyIHNhdmluZ3MpLg0KPiA+Pg0KPiA+DQo+ID4gVXNpbmcgdjggYW5kIGNsYW5nLTE1IG9u
IDYuMSBJIGdldDoNCj4gPg0KPiANCj4gR290IGl0Lg0KPiBNYXJpbyB3YXMgcmlnaHQuIElOVEVM
X1BTVEFURSBtdXN0IGJlIHNlbGVjdGVkLCBpdCBoYXMgYmVjb21lIGENCj4gZGVwZW5kZW5jeS4N
Cj4gDQo+IFRoYXQgZG9lc24ndCBzZWVtIGNvcnJlY3QuDQo+IA0KPiBXaXRoIGl0IHNlbGVjdGVk
LCBpdCBidWlsZHMganVzdCBmaW5lLiBOb3QgdGVzdGVkIHRob3VnaC4NCg0KWWVhaCwgSSB3aWxs
IG1ha2UgaXQgaW4gdjkuDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2shDQoNCg0KPiANCj4gPiAt
LS0NCj4gPiBsZC5sbGQ6IGVycm9yOiB1bmRlZmluZWQgc3ltYm9sOiBlbmVyZ3lfcGVyZl9zdHJp
bmdzICA+Pj4gcmVmZXJlbmNlZA0KPiA+IGJ5IGFtZC1wc3RhdGUuYzo3ODkNCj4gPiAoL3RtcC9t
YWtlcGtnL2xpbnV4NjEtdmQvc3JjL2xpbnV4LXN0YWJsZS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBz
dGF0ZS5jDQo+ID4gOjc4OSkgID4+Pg0KPiA+IHZtbGludXgubzooc2hvd19lbmVyZ3lfcGVyZm9y
bWFuY2VfcHJlZmVyZW5jZSkNCj4gPiAgPj4+IHJlZmVyZW5jZWQgYnkgYW1kLXBzdGF0ZS5jOjc2
OA0KPiA+ICgvdG1wL21ha2Vwa2cvbGludXg2MS12ZC9zcmMvbGludXgtc3RhYmxlL2RyaXZlcnMv
Y3B1ZnJlcS9hbWQtcHN0YXRlLmMNCj4gPiA6NzY4KSAgPj4+DQo+ID4gdm1saW51eC5vOihzdG9y
ZV9lbmVyZ3lfcGVyZm9ybWFuY2VfcHJlZmVyZW5jZSkNCj4gPiAgPj4+IHJlZmVyZW5jZWQgYnkg
YW1kLXBzdGF0ZS5jOjc0OQ0KPiA+ICgvdG1wL21ha2Vwa2cvbGludXg2MS12ZC9zcmMvbGludXgt
c3RhYmxlL2RyaXZlcnMvY3B1ZnJlcS9hbWQtDQo+IHBzdGF0ZS5jOjc0OSkNCj4gPiAgPj4+DQo+
ID4gdm1saW51eC5vOihzaG93X2VuZXJneV9wZXJmb3JtYW5jZV9hdmFpbGFibGVfcHJlZmVyZW5j
ZXMpDQo+ID4gID4+PiByZWZlcmVuY2VkIDEgbW9yZSB0aW1lcw0KPiA+ICA+Pj4gZGlkIHlvdSBt
ZWFuOiBlbmVyZ3lfcGVyZl9zdHJpbmdzICA+Pj4gZGVmaW5lZCBpbjogdm1saW51eC5vDQo+ID4N
Cj4gPiBsZC5sbGQ6IGVycm9yOiB1bmRlZmluZWQgc3ltYm9sOiBlcHBfdmFsdWVzICA+Pj4gcmVm
ZXJlbmNlZCBieQ0KPiA+IGFtZC1wc3RhdGUuYzoxODkNCj4gPiAoL3RtcC9tYWtlcGtnL2xpbnV4
NjEtdmQvc3JjL2xpbnV4LXN0YWJsZS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4g
OjE4OSkgID4+Pg0KPiA+IHZtbGludXgubzooc3RvcmVfZW5lcmd5X3BlcmZvcm1hbmNlX3ByZWZl
cmVuY2UpDQo+ID4gLS0tDQo+ID4NCj4gPiBhbmQgYSBmZXcgd2FybmluZ3M6DQo+ID4NCj4gPiAt
LS0NCj4gPiBkcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jOjk2Njo2OiB3YXJuaW5nOiB2YXJp
YWJsZSAncmV0JyBpcyB1c2VkDQo+ID4gdW5pbml0aWFsaXplZCB3aGVuZXZlciAnaWYnIGNvbmRp
dGlvbiBpcyB0cnVlDQo+ID4gWy1Xc29tZXRpbWVzLXVuaW5pdGlhbGl6ZWRdDQo+ID4gIMKgwqDC
oMKgwqDCoMKgIGlmIChyYykNCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefg0KPiA+IGRy
aXZlcnMvY3B1ZnJlcS9hbWQtcHN0YXRlLmM6MTAyNTo5OiBub3RlOiB1bmluaXRpYWxpemVkIHVz
ZSBvY2N1cnMNCj4gPiBoZXJlDQo+ID4gIMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+ID4g
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+DQo+ID4gZHJpdmVycy9jcHVmcmVxL2Ft
ZC1wc3RhdGUuYzo5NjY6Mjogbm90ZTogcmVtb3ZlIHRoZSAnaWYnIGlmIGl0cw0KPiA+IGNvbmRp
dGlvbiBpcyBhbHdheXMgZmFsc2UNCj4gPiAgwqDCoMKgwqDCoMKgwqAgaWYgKHJjKQ0KPiA+ICDC
oMKgwqDCoMKgwqDCoCBefn5+fn5+DQo+ID4gZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYzo5
NjI6Njogd2FybmluZzogdmFyaWFibGUgJ3JldCcgaXMgdXNlZA0KPiA+IHVuaW5pdGlhbGl6ZWQg
d2hlbmV2ZXIgJ2lmJyBjb25kaXRpb24gaXMgdHJ1ZQ0KPiA+IFstV3NvbWV0aW1lcy11bmluaXRp
YWxpemVkXQ0KPiA+ICDCoMKgwqDCoMKgwqDCoCBpZiAoIWRldikNCj4gPiAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBefn5+DQo+ID4gZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYzoxMDI1Ojk6
IG5vdGU6IHVuaW5pdGlhbGl6ZWQgdXNlIG9jY3Vycw0KPiA+IGhlcmUNCj4gPiAgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIHJldDsNCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn4N
Cj4gPiBkcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jOjk2MjoyOiBub3RlOiByZW1vdmUgdGhl
ICdpZicgaWYgaXRzDQo+ID4gY29uZGl0aW9uIGlzIGFsd2F5cyBmYWxzZQ0KPiA+ICDCoMKgwqDC
oMKgwqDCoCBpZiAoIWRldikNCj4gPiAgwqDCoMKgwqDCoMKgwqAgXn5+fn5+fn5+DQo+ID4gZHJp
dmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYzo5NDk6NjY6IG5vdGU6IGluaXRpYWxpemUgdGhlIHZh
cmlhYmxlICdyZXQnDQo+ID4gdG8gc2lsZW5jZSB0aGlzIHdhcm5pbmcNCj4gPiAgwqDCoMKgwqDC
oMKgwqAgaW50IG1pbl9mcmVxLCBtYXhfZnJlcSwgbm9taW5hbF9mcmVxLCBsb3dlc3Rfbm9ubGlu
ZWFyX2ZyZXEsDQo+ID4gcmV0Ow0KPiA+DQo+ID4gXg0KPiA+DQo+ID4gIMKgPSAwDQo+ID4gZHJp
dmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYzo5OTY6NTI6IHdhcm5pbmc6IHZhcmlhYmxlICd2YWx1
ZScgaXMNCj4gPiB1bmluaXRpYWxpemVkIHdoZW4gdXNlZCBoZXJlIFstV3VuaW5pdGlhbGl6ZWRd
DQo+ID4gIMKgwqDCoMKgwqDCoMKgIGNwdWRhdGEtPmVwcF9jYWNoZWQgPSBhbWRfcHN0YXRlX2dl
dF9lcHAoY3B1ZGF0YSwgdmFsdWUpOw0KPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXn5+fn4NCj4gPiBkcml2ZXJzL2NwdWZyZXEv
YW1kLXBzdGF0ZS5jOjk1MzoxMTogbm90ZTogaW5pdGlhbGl6ZSB0aGUgdmFyaWFibGUNCj4gPiAn
dmFsdWUnIHRvIHNpbGVuY2UgdGhpcyB3YXJuaW5nDQo+ID4gIMKgwqDCoMKgwqDCoMKgIHU2NCB2
YWx1ZTsNCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXg0KPiA+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID0gMA0KPiA+IGRyaXZlcnMvY3B1ZnJlcS9h
bWQtcHN0YXRlLmM6MTA4NTo2OiB3YXJuaW5nOiB2YXJpYWJsZSAnZXBwJyBpcyB1c2VkDQo+ID4g
dW5pbml0aWFsaXplZCB3aGVuZXZlciAnaWYnIGNvbmRpdGlvbiBpcyB0cnVlDQo+ID4gWy1Xc29t
ZXRpbWVzLXVuaW5pdGlhbGl6ZWRdDQo+ID4gIMKgwqDCoMKgwqDCoMKgIGlmIChjcHVkYXRhLT5l
cHBfcG9saWN5ID09IGNwdWRhdGEtPnBvbGljeSkNCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+IGRyaXZlcnMvY3B1
ZnJlcS9hbWQtcHN0YXRlLmM6MTExMDozMDogbm90ZTogdW5pbml0aWFsaXplZCB1c2Ugb2NjdXJz
DQo+ID4gaGVyZQ0KPiA+ICDCoMKgwqDCoMKgwqDCoCBhbWRfcHN0YXRlX3NldF9lcHAoY3B1ZGF0
YSwgZXBwKTsNCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn4NCj4gPiBkcml2ZXJzL2NwdWZyZXEvYW1k
LXBzdGF0ZS5jOjEwODU6Mjogbm90ZTogcmVtb3ZlIHRoZSAnaWYnIGlmIGl0cw0KPiA+IGNvbmRp
dGlvbiBpcyBhbHdheXMgZmFsc2UNCj4gPiAgwqDCoMKgwqDCoMKgwqAgaWYgKGNwdWRhdGEtPmVw
cF9wb2xpY3kgPT0gY3B1ZGF0YS0+cG9saWN5KQ0KPiA+ICDCoMKgwqDCoMKgwqDCoCBefn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4gZHJpdmVycy9jcHVmcmVx
L2FtZC1wc3RhdGUuYzoxMDY0Ojk6IG5vdGU6IGluaXRpYWxpemUgdGhlIHZhcmlhYmxlICdlcHAn
DQo+ID4gdG8gc2lsZW5jZSB0aGlzIHdhcm5pbmcNCj4gPiAgwqDCoMKgwqDCoMKgwqAgczE2IGVw
cDsNCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBeDQo+ID4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCA9IDANCj4gPiAtLS0NCj4gPg0KPiA+IENoZWVycywNCj4gPg0K
PiA+IFRvciBWaWMNCj4gPg0K
