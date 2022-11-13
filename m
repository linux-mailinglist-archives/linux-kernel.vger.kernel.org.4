Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA80162706F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiKMQTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbiKMQTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:19:11 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622CE1056A;
        Sun, 13 Nov 2022 08:19:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty8nCbqC3SCvUDfWiPCWgB2UpRziXO3609xKC1jH4ZnDYiWlnXpMr7Yz6gsgVAkVEa+FnFttfIkBZjAUCgncI3uyFnruWGAcgZugJlkWOScGaqf0Ws8CeVFQeYfxFModgqep9hAvFce254OVbaPHdlOUvp2jI9lt57vqcBhxw8a9k9t72H6Es/16YlVppK6I7LCSu7DsyJs1SwvM8Jlk1NppzARAcoS8WaK/AmI3Z1uXjeK8aLGhddJCHxTGCjkR88uZlalDQ7PNKMVa4KleI/6yTLAfX1wW/2e1xJWaFhRjbFbPiaD9YTayrD+snmcez7AYua+UfAW5NF9LNqk6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUU29qmxe/8cxAl+4TnCf/L+KaaRovDvKpEmZ4mTcys=;
 b=V8VziN7Ln7UExZ+Bw1bXQ217u/OSzgr/iqkM3knOT1dGSPw83SIboTQLu2Q85IXG7LnsA5QZEOXlEwtC/Kj/vEoDSxd83L6q5k7ScrAXDq8WZR0RZeGAbYZ/mj6edvABTtfUds2riXhjYoyTGiIGWAE2HoSsD9HuUZqG2UhqrfUbOMb/VvM97WyuNz//dyRfAPJByOp8mfPowK7K/htNbjp3eBlWZgtpNJZ0CSI/LwJ2AnGXrb/iPvKaNOiICYOCAEOX/jqTW5WHLswKmFWpCL6nGSm1OK0diWRssybk6rrS1aUp68Z0f3qVGmlZOPE9DQ9c7QBXLOp08qwjFpD3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUU29qmxe/8cxAl+4TnCf/L+KaaRovDvKpEmZ4mTcys=;
 b=ZvtJWNf+jhQehLRhZ2QkwD7V9SJ5FBq+MM/xq+xw/SslPKVBhsACs+f7seC8j9AEiQ79LGT5Mj0AT1XmurjFN0TF8Pc4HUp19ES22T6U5wct2cDz23N96P/tFmm/+5M8SqAA2L2CK7MkFUWR74WYHccqNt3lV4fcrV7IxjbjFSM=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 16:19:07 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%8]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 16:19:07 +0000
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
Subject: RE: [PATCH v3 6/8] cpufreq: amd-pstate: implement suspend and resume
 callbacks
Thread-Topic: [PATCH v3 6/8] cpufreq: amd-pstate: implement suspend and resume
 callbacks
Thread-Index: AQHY8tKTHjsVTtNcqUmDYRZb9OoOI64zxO6AgAlMkDA=
Date:   Sun, 13 Nov 2022 16:19:06 +0000
Message-ID: <DM4PR12MB5278BFABB3E7C20D74C30C299C029@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-7-Perry.Yuan@amd.com>
 <30690bad-e3f4-36ee-c957-a2cf750b7775@amd.com>
In-Reply-To: <30690bad-e3f4-36ee-c957-a2cf750b7775@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-13T16:19:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=92c9992d-6108-4329-ad49-cf76006b6889;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-13T16:19:04Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 54006a65-87e3-4039-b79b-42cd1b18146e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|PH7PR12MB6695:EE_
x-ms-office365-filtering-correlation-id: 20c0dfd6-005b-4590-bb2a-08dac592c9e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfRdGObFtEhWv697mXPapK2P6jYZRtN+Cyf+C3A/B+mQwv5HzKmMh+Gi10+C1HJZB+nejXFPjMa+0Vplky+0lDRFOxVV7O7c5AJiHq1MhODbm0w0ofJmcf4OcZTV9ZMnnlrGIhl7fvT5iWmzBKlEi7jA+slI1yh8qm2vFU5c2S3IhRssnf3bzVTkVF5kc8iEWFD2/XQTdCsAwVY4jUt9O+1qj8Dx1rB9PudVMzPWJW71D5+bTp+Nx679sHauCw+p/cRGbIiIY0MTX4nYKevfT0PeF7YE8aECwyCq1ZGYkqo3s+KJ3UHteJG4X304fmQOBth+edNX9aDdD+KZUvQdwT7aHLNC3mEkp6LMj8ImWqTIcDVJXOwmvRMDcHP1N/BJsMSoWO0rhkw6GSe0Ix9LeMHxQsfFn2qP0sgFTqTumyfbEZJKhH60rGA1lokQdE1XFGvEh8AaD1oyacsv0jc8CdJbzD+AE0jOy8cRHhzsqvQXHGkg8HtRC46JJl/heZ8LYQAEhMqGpQp2345la51vgASj39NNAbiJuNH6D5DE5sXhrG2qxdIeWmxdo2G32r6vPOv65ubsNvYxelKpQ+wS/8tRV+7HkbMtubgVCQbBsbXHX0LKyltUF1Ctg9Ic5jdvj2vVMTepf20jeuSySw0Z0bFuCYmlxQ681CuNga8gvLwd7MLtkcT+0sWSEjP3g9sOTxQ9koEnNZvGy+jL/EaySEE/YMvcLO62+KgvSn8VRYkWoDxVXwBpvKSWou/HO+L/W5ex3yI4ovDM9JEQYPqNDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199015)(9686003)(122000001)(26005)(71200400001)(54906003)(110136005)(316002)(186003)(66476007)(66446008)(66556008)(76116006)(33656002)(8676002)(64756008)(2906002)(66946007)(55016003)(15650500001)(4326008)(86362001)(52536014)(83380400001)(5660300002)(7696005)(6506007)(478600001)(38070700005)(53546011)(41300700001)(8936002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bytoWW56K3NxVnNUZFp6Z2IyRS9iQWJpeVlSZjJNK1JaQS9haVRPSGlpSjhy?=
 =?utf-8?B?dDlkeFlhVFpGY21CaG5SV0JCa1Z0UnBnQkc5VC9sV2NQdk96ck8vR0tDZjhu?=
 =?utf-8?B?ajVkVHRYUFBCakxmbTcwRldYcCtEcDFibExwZStFUGtaM2I3UDZmVDA2SjJt?=
 =?utf-8?B?TTNKSkRZNzladmx5STVzRkwvOElUVGNRcnY3WVFlcVJOaDB4M0MzOTUrRSsv?=
 =?utf-8?B?L0tPaDJpUTBKY1dkdDh0SzVXQzVZY28wb2lKc1hLUUZoYjExT0l4V0paUkRH?=
 =?utf-8?B?cGUzN1E5YWtSWlBOSkNtdEpFOXA5VERzQm43SVNhUERhZkhwSkJEOTFBTUZh?=
 =?utf-8?B?OFRDSnowMW1lK1o0VTUwL0VUd2Vuc3Q0V1VoRFVMUm5vZGVIQk9SS2U0S2Zr?=
 =?utf-8?B?M3NHQ0NnWHkvSmIwNGcvWk00MDNYMjVSblNlVStBNHpJK1AvWjQ4cXJrR2JI?=
 =?utf-8?B?T25VU2hlOUJlWXdPcG1oanphV0FDM1FJQUJQMUhtdHZZSTU1aXZ0cHNnVDhV?=
 =?utf-8?B?U3YyZEpFYXFJeGpUeEZKK0U1VzlYT0IyblJydGNCZ3lWbndvc3ZqS3lPV2Q4?=
 =?utf-8?B?Z001YUkxRlM5QXd3ZHJCNE9WOHNFVHlQUFlueTNURk5CUTV0alNNS2Y1eVZF?=
 =?utf-8?B?Y0VISG43S3FjdWdaSFRZVW5iVzZNUnJ0NHJtV1poQTZNbm44SWxTTGVFVVFP?=
 =?utf-8?B?ZHUrUmhrWEowR0dHOUVSNXVlUnkrVDhDSjJiekszdHVYY1Y1bkN1dEJzanND?=
 =?utf-8?B?cHVNSm9vS01mNmk1V0hnYlFmSzFZaXZZNGtGMmJyMjRiN045cjk0VXdWMVNr?=
 =?utf-8?B?dkpMQ0pUQ3lqSndkTlRnaFpLL0FIdWJJQkdjYlI3TnVlSWtKYkRMS01NUmF3?=
 =?utf-8?B?cERSY0ZPVEFWek42SmdjaW9MNjcyYXdkdkhDbmtMamZUWmEyRGRLb3Azblk4?=
 =?utf-8?B?MnE0MVdSUFhaK1E2TVZxUGp0ZFBkWkc0N3l1NDlCNS8rOGt4N2o0Mlc3TU4v?=
 =?utf-8?B?bE02Z3UxYUk1dy9jZnBTeFc5amJlYWlVa0dUY1k0cW5UbFFCeWk2alhTSTdT?=
 =?utf-8?B?c1g0ak15eE5RNGhzWXhHSWN0ZldseTZRaEUyd0ZSMmtCWXIyRW1na0hLcWEw?=
 =?utf-8?B?YlJoV2pLSXQ5Si9PMGVmQnVYZHBsNVBNRnA0dFN5aStvVThhRzcxc3g5VkVI?=
 =?utf-8?B?Q3hNaGVocWJxMktuTUlnSFBjNWxRZC9Kb3VGRnRhTncvUGMwVnlRUEhFQ3RD?=
 =?utf-8?B?a3FWRTVncTBRTUxPZ3VQOStpc3pJZE9IYk5SQnN2LzUrYWw1QnJuKzJyYjBE?=
 =?utf-8?B?K1FKZUVNZlAxNWVEc1RTYTFjR2xUZXZidHdlMERjaER0NnF2bk84VkVnRVhp?=
 =?utf-8?B?TC9ZdEpFb2NKMExrM3ZIZ3J0YWtTSGI0UXVxUHFvK2pqZXZVcldCU1NoRWlL?=
 =?utf-8?B?SkVtek5GSzJ3RjFUQWxIRmJwZjJWWnk5UCtGaENuSGd4eGEwNGxUejErcUo5?=
 =?utf-8?B?OERwbFBTWFlLbndSSWgwVUtBejRieFpQeUFhL3VLTC80aWNIQUtvWDJsR24x?=
 =?utf-8?B?SHF1OWt0MFBKTU93TGJqVFNNWWZRRTBHd1VFTFlLSXdEQnJSYUVoa3BQem1k?=
 =?utf-8?B?QTZ2N0tiY094RE1YV1ErR0tOdFdJTFU0Uk9oTXFPNDU1aXNyQURyNjdSSDVm?=
 =?utf-8?B?YmpnOWFoZWZ1M2xTM0ZWWFlwQkd2WWJ1Rnl6U2lTa0VmRFhvQ2o2cWMwMDdQ?=
 =?utf-8?B?M21ubHRMeHJBWjU1V1ZER3FwN2p5REdZUVcrSDMvenVPMCtpaXZnTWhhNndB?=
 =?utf-8?B?bjRUMVozaDZlYTlLWDF0eWZOKytBNTBGZUpsTkdTY1hjZkgwMTRWbFlXbEVH?=
 =?utf-8?B?SkRQczB0VCt0K1YrZDdRM2NsV3JwR3A1aEtlT2hXZEgvZ0xQaTREZ1ZMZ1Rp?=
 =?utf-8?B?em1PSUNZb0lLOVYzMDhPVFR1OTlTVlBacGNDTzQ1aEhTSGxLN1d4UUp4eUor?=
 =?utf-8?B?SDlGRW5IOUNyVzNBYUVuTSt6VWplY1ZNYkJLZ3E3dVYzUVhWTE1oaWpTZ3RG?=
 =?utf-8?B?d1Fsak5tMEpGcytBTDFGSk5wSFZ3SDJBN1lZRlVyUHUwekYvZURxYUxlaHBm?=
 =?utf-8?Q?FBDe9Ajms8EAKxVY1W7qiuMeP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c0dfd6-005b-4590-bb2a-08dac592c9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 16:19:06.8759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +O80UYbC3mFFaS/v2E+37Ikh5MVqGNFdUNoy99JLvyAoLwcNXdHIcljSKJR7vDQ+RQs6veDveTY58AmCdHu1YA==
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIE1hcmlvLiANCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlv
LkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDgsIDIwMjIg
MjoxOCBBTQ0KPiBUbzogWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT47IHJhZmFlbC5q
Lnd5c29ja2lAaW50ZWwuY29tOyBIdWFuZywNCj4gUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT47IHZp
cmVzaC5rdW1hckBsaW5hcm8ub3JnDQo+IENjOiBTaGFybWEsIERlZXBhayA8RGVlcGFrLlNoYXJt
YUBhbWQuY29tPjsgRm9udGVub3QsIE5hdGhhbg0KPiA8TmF0aGFuLkZvbnRlbm90QGFtZC5jb20+
OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFu
ZywgU2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFv
amlhbi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29t
PjsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDYvOF0gY3B1ZnJlcTogYW1kLXBzdGF0ZTog
aW1wbGVtZW50IHN1c3BlbmQgYW5kDQo+IHJlc3VtZSBjYWxsYmFja3MNCj4gDQo+IE9uIDExLzcv
MjAyMiAxMTo1NywgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBhZGQgc3VzcGVuZCBhbmQgcmVzdW1l
IHN1cHBvcnQgZm9yIHRoZSBBTUQgcHJvY2Vzc29ycyBieQ0KPiA+IGFtZF9wc3RhdGVfZXBwIGRy
aXZlciBpbnN0YW5jZS4NCj4gPg0KPiA+IFdoZW4gdGhlIENQUEMgaXMgc3VzcGVuZGVkLCBFUFAg
ZHJpdmVyIHdpbGwgc2V0IEVQUCBwcm9maWxlIHRvICdwb3dlcicNCj4gPiBwcm9maWxlIGFuZCBz
ZXQgbWF4L21pbiBwZXJmIHRvIGxvd2VzdCBwZXJmIHZhbHVlLg0KPiA+IFdoZW4gcmVzdW1lIGhh
cHBlbnMsIGl0IHdpbGwgcmVzdG9yZSB0aGUgTVNSIHJlZ2lzdGVycyB3aXRoIHByZXZpb3VzDQo+
ID4gY2FjaGVkIHZhbHVlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8UGVy
cnkuWXVhbkBhbWQuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxt
YXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KDQpUaGFuayB5b3UuDQpJIHBpY2sgdXAgdGhlIFJC
IHRhZyBpbiB0aGUgVjQuDQoNClBlcnJ5LiANCg0KPiANCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMv
Y3B1ZnJlcS9hbWQtcHN0YXRlLmMgfCA0MA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IGIvZHJpdmVy
cy9jcHVmcmVxL2FtZC1wc3RhdGUuYyBpbmRleCA2Y2U5ZmNhMGExMjguLjg0MWIxZTIzODNiOA0K
PiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NwdWZyZXEvYW1kLXBzdGF0ZS5jDQo+ID4gKysr
IGIvZHJpdmVycy9jcHVmcmVxL2FtZC1wc3RhdGUuYw0KPiA+IEBAIC0xMjgyLDYgKzEyODIsNDQg
QEAgc3RhdGljIGludCBhbWRfcHN0YXRlX2VwcF9jcHVfb2ZmbGluZShzdHJ1Y3QNCj4gY3B1ZnJl
cV9wb2xpY3kgKnBvbGljeSkNCj4gPiAgIAlyZXR1cm4gYW1kX3BzdGF0ZV9jcHVfb2ZmbGluZShw
b2xpY3kpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgYW1kX3BzdGF0ZV9lcHBfc3Vz
cGVuZChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkgew0KPiA+ICsJc3RydWN0IGFtZF9j
cHVkYXRhICpjcHVkYXRhID0gYWxsX2NwdV9kYXRhW3BvbGljeS0+Y3B1XTsNCj4gPiArCWludCBy
ZXQ7DQo+ID4gKw0KPiA+ICsJLyogYXZvaWQgc3VzcGVuZGluZyB3aGVuIEVQUCBpcyBub3QgZW5h
YmxlZCAqLw0KPiA+ICsJaWYgKCFjcHBjX2FjdGl2ZSkNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiAr
DQo+ID4gKwkvKiBzZXQgdGhpcyBmbGFnIHRvIGF2b2lkIHNldHRpbmcgY29yZSBvZmZsaW5lKi8N
Cj4gPiArCWNwdWRhdGEtPnN1c3BlbmRlZCA9IHRydWU7DQo+ID4gKw0KPiA+ICsJLyogZGlzYWJs
ZSBDUFBDIGluIGxvd2xldmVsIGZpcm13YXJlICovDQo+ID4gKwlyZXQgPSBhbWRfcHN0YXRlX2Vu
YWJsZShmYWxzZSk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXByX2VycigiZmFpbGVkIHRvIHN1
c3BlbmQsIHJldHVybiAlZFxuIiwgcmV0KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhbWRfcHN0YXRlX2VwcF9yZXN1bWUoc3RydWN0IGNw
dWZyZXFfcG9saWN5ICpwb2xpY3kpIHsNCj4gPiArCXN0cnVjdCBhbWRfY3B1ZGF0YSAqY3B1ZGF0
YSA9IGFsbF9jcHVfZGF0YVtwb2xpY3ktPmNwdV07DQo+ID4gKw0KPiA+ICsJaWYgKGNwdWRhdGEt
PnN1c3BlbmRlZCkgew0KPiA+ICsJCW11dGV4X2xvY2soJmFtZF9wc3RhdGVfbGltaXRzX2xvY2sp
Ow0KPiA+ICsNCj4gPiArCQkvKiBlbmFibGUgYW1kIHBzdGF0ZSBmcm9tIHN1c3BlbmQgc3RhdGUq
Lw0KPiA+ICsJCWFtZF9wc3RhdGVfZXBwX3JlZW5hYmxlKGNwdWRhdGEpOw0KPiA+ICsNCj4gPiAr
CQltdXRleF91bmxvY2soJmFtZF9wc3RhdGVfbGltaXRzX2xvY2spOw0KPiA+ICsNCj4gPiArCQlj
cHVkYXRhLT5zdXNwZW5kZWQgPSBmYWxzZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4g
MDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyB2b2lkIGFtZF9wc3RhdGVfdmVyaWZ5X2Nw
dV9wb2xpY3koc3RydWN0IGFtZF9jcHVkYXRhICpjcHVkYXRhLA0KPiA+ICAgCQkJCQkgICBzdHJ1
Y3QgY3B1ZnJlcV9wb2xpY3lfZGF0YSAqcG9saWN5KQ0KPiA+ICAgew0KPiA+IEBAIC0xMzE4LDYg
KzEzNTYsOCBAQCBzdGF0aWMgc3RydWN0IGNwdWZyZXFfZHJpdmVyDQo+IGFtZF9wc3RhdGVfZXBw
X2RyaXZlciA9IHsNCj4gPiAgIAkudXBkYXRlX2xpbWl0cwk9IGFtZF9wc3RhdGVfZXBwX3VwZGF0
ZV9saW1pdHMsDQo+ID4gICAJLm9mZmxpbmUJPSBhbWRfcHN0YXRlX2VwcF9jcHVfb2ZmbGluZSwN
Cj4gPiAgIAkub25saW5lCQk9IGFtZF9wc3RhdGVfZXBwX2NwdV9vbmxpbmUsDQo+ID4gKwkuc3Vz
cGVuZAk9IGFtZF9wc3RhdGVfZXBwX3N1c3BlbmQsDQo+ID4gKwkucmVzdW1lCQk9IGFtZF9wc3Rh
dGVfZXBwX3Jlc3VtZSwNCj4gPiAgIAkubmFtZQkJPSAiYW1kX3BzdGF0ZV9lcHAiLA0KPiA+ICAg
CS5hdHRyCQk9IGFtZF9wc3RhdGVfZXBwX2F0dHIsDQo+ID4gICB9Ow0K
