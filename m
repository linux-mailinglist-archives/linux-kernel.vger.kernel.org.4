Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B686B6A101C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBWTJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBWTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:08:58 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB53536FC1;
        Thu, 23 Feb 2023 11:08:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm4s50g6oUcqTYt7tT4T1GhRlGC115tCdsHXWxXkdH4B5xTuJ3imPs8KT6IJdvtSnCEAZ3Ee42+83pRlKZ8N1xTSIzjxkO7eujVocHe4QXDLVEhDcNr3W5yCivW4CN9O9KtouypZH2/IiB6G1W5lVk+raZ4ugtgfcCn+xnPXXOpd7lFf0xbaHvEn8qo6yyTDEaCpEC53mx+INDrnU+MRdUrft5mCqacdQi6Yf2tQBcRYaak2ocnEjyjBR3Ba5PWN+HHrZROwUjGM/U3rE3T5q/gFMaO8ACddZBLerB56K5kg58xKCNTcEyyX2KS1JyseHEg7beyBZhb0cw6Ssy5BHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtaLpd5vFJQfmOpQBGxY1wWtNq2JAuTPCYT1k03Y+DI=;
 b=B71WYZf3CPAtYQhdHldeUvkY2KlfgmS94ncLKAu515/NJ7kbnymQQInKVqIVPNCg/3rWGWGfWFx6xggaf8uG13JcgTee4grSv1eycOsUk4UHDx01x4Rw8oA4nPpATS2QB1iwY08TMIdOQEv4MVFjMvxGX19xfVqI/9f1ax5r1yUn9UpRnx5pSeCfVwPGj21KPpT8D2JAndCD5Ybcn3BvD3VEAXKjloEXCDTuPVYRG0VfeX5YykRMHzHIUHfwN9Zzeb5Oh872ziZd42z1BjdTvrixCzjxBB43g+sRgZbGfjsBrquiKrtQXsMaZPiD2FQTSdM2frdLJsD3+K3tdQZdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtaLpd5vFJQfmOpQBGxY1wWtNq2JAuTPCYT1k03Y+DI=;
 b=J7jJTGJXxy3iwNFHvt4n3ViVrUovlW4hSBWZ1/3xbz0gibGqRwRreR43b1yIMmUm8c5mZy8zZ204lecG6Qs9Q7BSws5b6CIp+m91c2wpdABBq+Y4UKM90bknYwsrcPIYDdo+tSx0ZUXrAnxc4x+kqsjBd27Nq9K8Qm3QXTiaWb6f72iSZi4EyLqMjq3eP6n3enM03OUEGgaXMLPV0XjC6h6Al3NDR//GnlnfUNnODtvX7EvW8pQJMSImez7CfDOGofjhC+0LllTheuLl3bntnLfv9Fo4hUc1OX0QEbzArVxJ17hLhXZh3WiPZFgK6qCd6RaOSwKneZ0EqeoGCCNR0g==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 19:08:47 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 19:08:47 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
Thread-Topic: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
Thread-Index: AQHZQxaSlkLDlqQj4USzupFOvdT5/67TwvwAgAeH+DCAARyQgIAAhNPA
Date:   Thu, 23 Feb 2023 19:08:47 +0000
Message-ID: <CH2PR12MB389509F68E6AFE776C5B0AC6D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <cover.1676668853.git.asmaa@nvidia.com>
 <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
 <CAHp75VdeVpjzg5Y_4Y+Ke9=3wog28vUBN4Fd8zxfa8dWGrqUUA@mail.gmail.com>
 <CH2PR12MB3895520749883D912E5021F1D7AA9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75Vc+iSt2XvpOYzwZnzX7Qg013e-E27CPjPaO-QmtferWVg@mail.gmail.com>
In-Reply-To: <CAHp75Vc+iSt2XvpOYzwZnzX7Qg013e-E27CPjPaO-QmtferWVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|DM4PR12MB7502:EE_
x-ms-office365-filtering-correlation-id: 1f024e72-0006-42b6-238e-08db15d1643c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rEGN6lwWsVCeXSCaLvkvFNaGK+6SsrqCZviE7hnLiNElTk7MdM5j3Yon1C2ijNAbGCcpvSVo2FYCHE3WybpPlIYjHO6Sn5pdGPAItMobKjRDRUuzcVCuTSs4uE+/dBx1dtfrvFZRGNB+7ugzSeyy5wo3LeNY5y5w4H1Yf05FgrEh5Gqi6AfEJ9B2FUomhtc5oqnDl459jZjGBlyKiUMx3MCYXRa9l+5Wg+8LyAD1SmQk4fjqiIPGxakEW49wou4OquxvvTZLYtNdwG3C3DTLPlTRJr6p/dhpI4uRjB29Fo7SRGpyvX0Omr/9B7Yy0oCNmeBVwdBAxfLjA82/wLTWW+qtwQrQhNq0eUK3LWEdN0hnQeizt5sOekOpdME3rwjdT8K8GepggQ8nivOyZUlUDIx30xYadXMgWIo2qUR3FRn8IwTgRhP5Hq7w7htG61DTj7V6FpCdTEfWiFuon8jCnqxQYg2exujGMhT55Yr6iRBOTsXT4jDoOaCnQ1LIPCpvWE7GhfRGarsRoc4JUj6dr8n44dgcMaPikns0RvQUy8jybGZFSDWnr/SZM0+wPwem1TKkwxSrbaX+mqmoog63vsvIcFUyntP+TQW7PvKXUpWHICOwUAugbs6aRqji1PSNEJOKccQPDvbF2Z0m+q7ZuIgzIpLSuXRx51ZLfgm9TfSsNSTP/iC6SwpbUrZ1dfjY7r8fqzhyvmUNgAfPF9qfgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199018)(41300700001)(83380400001)(5660300002)(478600001)(9686003)(186003)(26005)(86362001)(38100700002)(52536014)(8936002)(8676002)(54906003)(4326008)(6916009)(38070700005)(55016003)(66946007)(76116006)(6506007)(33656002)(316002)(122000001)(66556008)(71200400001)(66446008)(64756008)(66476007)(2906002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmpSd1I4eVBwYTM4V3NVaUt6OWJjR3VJZFVZalFHSStmUTBZME5JVXpSREti?=
 =?utf-8?B?b3dpRnNxMFdrelBuWndUbzhxYXl6aXYwVzNBRFpnVVcycThuNExXdmlEdHZV?=
 =?utf-8?B?R2JqL0xmaldyMlhERTVzVWMyekhxd3JVM2s5RWE3REc3M1pobmRnVllvRlVo?=
 =?utf-8?B?V2VZOGUvaFR0VzVpa1VoYjBIZExaRGpTK0ZNNkhFRE84ZmNYZHNnUFZ1aWNB?=
 =?utf-8?B?aE5DM3FsQ040bGtiNEVkVDFuSmRUWG5TSkp2UG8wQ3Z3M1p0dWFQTGRybDg2?=
 =?utf-8?B?Q3NSa0R0L0JrZHQ3eGwvdzd2eXFTSmljajI0VDBnaDRkMXZnS1dwbm1zcU84?=
 =?utf-8?B?VUxwSGRPRkV5Yzhia2lGbG1Xci9pWkZkeExqemtjcXEyMlFkNUhsRU1jNWNH?=
 =?utf-8?B?TXJ1cUdmckNYZlJwTU16YWJ0akR1TnIvdCs0cFpFMyt3d3Y3L0pPOXdQZVNj?=
 =?utf-8?B?SFo3emZyTzA0R0hDcVBVcFpGVWNJdG50alNDN2tuNWRhU1VmRURUamd3dkFO?=
 =?utf-8?B?N3N1LzZrTzlINUpSclFjd1JWbXpVUUpHWGtYQlRtdVUrYUZkUVIwcE54NFVG?=
 =?utf-8?B?S1p5c1dFM2Q4YVRhcDEzK29EZTVibFRZRUdqY201OG1DY3EyYWNvWFhFdzdF?=
 =?utf-8?B?VGwvMlVnWG91TU9TL3V5blNtNDhkUzIrUml3ZUpBYmZnaC85aWZFTDM4TXF2?=
 =?utf-8?B?OFJuLzhqa2hnQmRTN2ZjbkRXRFd0RHU5djFHQW1VdXZUaUhNc1ZkeFRoTjJo?=
 =?utf-8?B?aUV1RnF4bitpUnNYbTJFd3Z1VTlqc2lCVjhVWFV0ak00dkg1a1BsRmhGcjh5?=
 =?utf-8?B?Ky9ZbXJPejJDYnhpWW9FT3lSZy9aRWFEV0w4cHk4NWxJT2pybGlLa2dGbm1k?=
 =?utf-8?B?MC9XZlM1aDczOUpqZ0QzZ1NLc2ppWUpPMElibWRNanBkWFM4aEQ0RHhHWUl5?=
 =?utf-8?B?R2lsN3VNN0Rhc3p5RjYycHdENjBOcTNzL2I5SytNVTdOT0xpVVdzN09ETXJG?=
 =?utf-8?B?SWh1Q0VrbE9zT1NSYUJFQ2tFTENSY2VPbUhpOFA5bFBvOFBqWWVTeDlOZWdD?=
 =?utf-8?B?TUpWcU44WVJZWm1FL2tNYzRSM3g4ZHcyMFBZT0xzc3RSRzZWcm9QSTRIZ3JS?=
 =?utf-8?B?MzV1MnFKdzFSU2haYWRMVVI0UlEyUzBaZmIweUFPZFZMMHdUTnJERHg1UXZz?=
 =?utf-8?B?Z3F6OVJ0SlVwMHB5RlU2US9ja1VCRkM3Q2NWa2Y0eGRoc0l1ZXFiMFp3WDAz?=
 =?utf-8?B?Yk9XR09qU2s3RmpVWjE5QWxlUEc2SDBrbGFhVVBmYi9KaEpMT0xEWFpSQVNY?=
 =?utf-8?B?NzRrbHB0UGdWNHd0VGdOMFdNWFAvNTFBRkxFT3dhbGovNmRlWDJBT3FLWVpU?=
 =?utf-8?B?My8wSitneDhKSmlCS3J5Q3czN1pzN2VYRTQzcURBTWVWOW8vSXpaOWpKa08x?=
 =?utf-8?B?U1JBWmdnMGRPcFI5NndBaFV2M2pXelVBQzUvcUVoNzBjS0tWSE5oeWpLZ3Rz?=
 =?utf-8?B?a2YwYmYrRVNuSDZSSDNpSEliWll4SWFnc1R5aG9PTkVNbUNsMGN3eDJldUp3?=
 =?utf-8?B?Z094ZkRDeHptN1hUODlYejhtc3BFcUNXazVCTG1CcnBvMnFlNUV4aWdJN3hJ?=
 =?utf-8?B?S0o3TTQzeEtzNG9JVWJmakJIVFhUYkxRR2R5R0ZOYXdSb1VpWlc0R3FTRmxR?=
 =?utf-8?B?R0IxdDBpVklkR3cvM0hmU0FmQ0VqWTNhY0xpTlJFS011QVhXWVllWlpoSHZm?=
 =?utf-8?B?SC82UEF4elFLekxieTg0Wk9PYTMyUkNnVlRPQzRWSG84Ulh6bnlTSGd3bXdn?=
 =?utf-8?B?TUdpMkV5cE40V2ZMaWZwSUs3WU9BTndjR0pHSjdLWnFFQXpXMHFnajhUR3A5?=
 =?utf-8?B?eW9KSTY4SCsrclkrN3lhTlBBU3R1akd5eXNDYlB4YU1CTFEzQXA5Zk5Eek5M?=
 =?utf-8?B?SjVJanNQcU9WRkVsbmw3QS9zMi9Ed1pibFV1S29yOEI5UFFoa2MxTEt6ZWUw?=
 =?utf-8?B?cHptVmI0VHpHb2RKN1dkbGxjWFlxbUw4QUVPVlNaY1dqQy9RMjBMMUR5OFhB?=
 =?utf-8?B?Zks1ZnpMZ3RpTkpiWVBWNVRtcmZ0V2ExUitDbXQyNzBwWGwwV2JEeWhacVlk?=
 =?utf-8?Q?604o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f024e72-0006-42b6-238e-08db15d1643c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 19:08:47.6443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8dKW8BeEK3+l5Swvd/JotpUghijJu5CqrhRqikRxcLA6CAtbeOFsamr6XM3coF4llrT7P4lKuyzdjHupUFD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gKyAgICAgICBucGlucyA9IE1MWEJGM19HUElPX01BWF9QSU5TX1BFUl9CTE9DSzsNCj4g
PiA+ICsgICAgICAgZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgIm5waW5zIiwgJm5waW5z
KTsNCj4gPg0KPiA+IEkgZG9uJ3Qgc2VlIERUIGJpbmRpbmdzIGZvciB0aGlzIHByb3BlcnR5IChi
ZWluZyBhZGRlZCBpbiB0aGlzIHNlcmllcykuIElzIGl0DQo+IGFscmVhZHkgZXN0YWJsaXNoZWQg
b25lPw0KPiA+DQo+ID4gQWggdGhhdOKAmXMgbXkgYmFkLiBUaGUgcHJvcGVydHkgc2hvdWxkIGJl
IGNhbGxlZCAibmdwaW9zIiBsaWtlIGluIHRoZSBEVA0KPiBkb2N1bWVudGF0aW9uLiBXaWxsIGZp
eC4NCj4gDQo+IEFuZCB3aHkgZG8geW91IG5lZWQgaXQ/IFdoYXQncyBhIGNvcm5lciBjYXNlIHRo
YXQgdGhlIEdQSU8gbGlicmFyeSBkb2Vzbid0DQo+IGhhbmRsZSB5ZXQ/DQoNCldlIGhhdmUgMiBn
cGlvY2hpcHMsIGdwaW9jaGlwIDAgc3VwcG9ydHMgMzIgZ3BpbyBwaW5zIGFuZCBncGlvY2hpcCAx
IHN1cHBvcnRzIG9ubHkgMjQgcGlucy4NCklmIEkgcmVtb3ZlIHRoZSBsb2dpYyBmcm9tIGdwaW8t
bWx4YmYzLmMsIHRoZSBncGlvbGliLmMgbG9naWMgd2lsbCBjb3JyZWN0bHkgc2V0IHRoZSBuZ3Bp
b3MgPSAzMiBmb3IgZ3Bpb2NoaXAgMCBidXQgd2lsbCB3cm9uZ2x5IHNldCBuZ3Bpb3M9MzIgZm9y
IGdwaW9nY2hpcCAxOg0KDQpncGlvY2hpcF9hZGRfZGF0YV93aXRoX2tleSB7DQoJWy4uLl0NCglu
Z3Bpb3MgPSBnYy0+bmdwaW87DQoJaWYgKG5ncGlvcyA9PSAwKSB7DQoJCXJldCA9IGRldmljZV9w
cm9wZXJ0eV9yZWFkX3UzMigmZ2Rldi0+ZGV2LCAibmdwaW9zIiwgJm5ncGlvcyk7DQoJCWlmIChy
ZXQgPT0gLUVOT0RBVEEpDQoJCQkvKg0KCQkJICogLUVOT0RBVEEgbWVhbnMgdGhhdCB0aGVyZSBp
cyBubyBwcm9wZXJ0eSBmb3VuZCBhbmQNCgkJCSAqIHdlIHdhbnQgdG8gaXNzdWUgdGhlIGVycm9y
IG1lc3NhZ2UgdG8gdGhlIHVzZXIuDQoJCQkgKiBCZXNpZGVzIHRoYXQsIHdlIHdhbnQgdG8gcmV0
dXJuIGRpZmZlcmVudCBlcnJvciBjb2RlDQoJCQkgKiB0byBzdGF0ZSB0aGF0IHN1cHBsaWVkIHZh
bHVlIGlzIG5vdCB2YWxpZC4NCgkJCSAqLw0KCQkJbmdwaW9zID0gMDsNCgkJZWxzZSBpZiAocmV0
KQ0KCQkJZ290byBlcnJfZnJlZV9kZXZfbmFtZTsNCg0KCQlnYy0+bmdwaW8gPSBuZ3Bpb3M7DQoJ
fQ0KCVsuLi5dDQp9DQoNCmJncGlvX2luaXQgew0KCWdjLT5iZ3Bpb19iaXRzID0gc3ogKiA4Ow0K
CWdjLT5uZ3BpbyA9IGdjLT5iZ3Bpb19iaXRzOw0KfQ0K
