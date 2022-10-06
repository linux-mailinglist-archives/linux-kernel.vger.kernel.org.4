Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CFA5F6B4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJFQOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJFQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:14:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E96938B4;
        Thu,  6 Oct 2022 09:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmV+KQ1TiFjqHIVeSYF04DSzFUEHzCUzAM/EDLp75PB6d/pujzk+bBgK1ju7I0/CLWIV5jPNOFpUdK1+oUgCmPPzgRU8urqvWyQhw/qvapUUNVr+XCesE7RyDLjf7l3fIDHuXkugA1SVLuSviLrZFp4TDxXbN6cBcvDjdsE8oXjwwyDkI3veJldHjrykWBLEwJ02y35uUmxQVLcSn2wUuuR4GnwxzuteylBkNSwufWkvXkCZpKdS0ihpU6RZARLMIS5a6jh3fh2+hx5mdB8k36P2XSLTaSVWLpUbiDXnjcMIgN2VPmZH0Tvhy1q8HXeP86GtXa2GPd0UxzjMZORE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMspCGjtOLj+LBRhm2w/wdRExsya1sfHyYUh9nr7bUg=;
 b=kk6PNSEXAsVEN43ThHDZvuLrD7u7rxiIuda6R3ietAVbcJQjE/KtHNLQJJYTyef6OgJXzXLzr4++wTtpYZe5Xc02PD1YqYR0NqRMCUo/lIET4EQJ7p8AyEnX55HmnlfwZQeb57Vl6Hk73+OpABsXfhxrIE0KnTnfd1lVK2CKqpe7/I7MpyL9e9zgkN9a8nzMsBQ/fPjy9XuyDoY5iKtIkHgBgu81d262O/dTeJTxTYQW1dMd9B8GcHlUs/Ea49Y+mBk/5n+G6y+sJr5zhJqEv5R7t8dZE9ujDyoz2HkQby2YDMyEoE7s1SW+1klLbaNpopHyynmRRHYm5wGWOf0K0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMspCGjtOLj+LBRhm2w/wdRExsya1sfHyYUh9nr7bUg=;
 b=UJnHKMNbLa1Gz/btm8apVuMNnicVTMnFOD7OEozRnU/4bxNi4rszeUekpT/2cG0WsGdrUgQRdWSY+ro9c1Jk8er7/RpyuuMmb57iRUCeGBChG1YPztboybvhlHk1R3N6exffglh08hbkBWJ2IGgeHrfgvehyX5qIrJ66L3Ff6ldsV1BEe7t2/20aOdmdCQh8m2mEv21hctHB8FVM3uk4son1F/4/j/MxP+eXKmocfyDzBX5KqiVYdLXgekS6mhcAoEib4TO88v8cnyNG7TsFWVWqhEvM1LD3o+BHm3h36+PmqxXOo3YGG/IAk0sbqzlLBCSdZunMz7iem2bR8z2ojA==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Thu, 6 Oct
 2022 16:14:35 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::3c98:4af6:e849:aa5]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::3c98:4af6:e849:aa5%4]) with mapi id 15.20.5676.031; Thu, 6 Oct 2022
 16:14:35 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Subject: RE: [PATCH v5 1/2] perf: arm_cspmu: Add support for ARM CoreSight PMU
 driver
Thread-Topic: [PATCH v5 1/2] perf: arm_cspmu: Add support for ARM CoreSight
 PMU driver
Thread-Index: AQHY03eZbdRwasQ0NkO0/RBm6KsShK32FDcAgABW9/CACylroA==
Date:   Thu, 6 Oct 2022 16:14:35 +0000
Message-ID: <SJ0PR12MB5676BCFE7E8AC56729C1D9D2A05C9@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220928201830.45637-1-bwicaksono@nvidia.com>
 <20220928201830.45637-2-bwicaksono@nvidia.com>
 <f67bf3b6-c8ba-4134-5772-ce750f4bb4dd@arm.com>
 <SJ0PR12MB5676FE048F8105D01C83D0EBA0579@SJ0PR12MB5676.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB5676FE048F8105D01C83D0EBA0579@SJ0PR12MB5676.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|DS7PR12MB5984:EE_
x-ms-office365-filtering-correlation-id: eaa88335-052a-4e80-37ea-08daa7b5dc27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OdQW6B3y4JOHY1FvkSV8E5CKcSl+NNTNz/+q/4wQY5Rf2XgSwTBcVn9dLPCDkZnk5K5jDFi0Njisy4x1SFDiOimYAgg6yWANO20mBIr5g0WmqmgAGIrJrHn9ijAyGpU2mFc4Q6XAZoV4/2EtS1CHRpD4znpelgsvOUrS19csJi0PDbadpEa5fScnQY+GuUK+ItRCnviErNjxRt47Ms4r9EIDCMn+02OU+eX4hQKzEIpopjL2zK9K9GSNlrQJdAb7/Wu4VzaUwLJGIStsnLeL/uJCz1AFP4mVQVMZa4djdmtxEtNVniCC5grrZR9SqaLCkpnEL8Gtt6m35kAepQH9oJfzmU33dFVBHfWPIqFpMV41agn1Fyc6xWMs/tt+kH48t/uBCiODiTp5zoNC3+ag2oRiVbxlBAa3o77Jj98tLdx4p6LK+/qaafmND3N3bHFltWhzuQ8KNNu7rgzFuitXVlswAKtRxmUt5e2h8ufBmvX91r8D41FwBPGZY0kuReWFViKETZEENOyf6ah2ca46NVW5qjYG5/NqwqKk/ywgZhyJqsF7RdPuQKIj8jOCoPyVLqBgbJbTzdWyYxqC6j5mFjOmFLYuQMCYr5YDjqdiTowgVctB6HrWuGS043P7CVXZHbzt8hvosuNChFZbbpt1p8+JnuJkoi1rdIR3/rdCI7Ym+voNYcG1M3xxUhPwPN7Mdbh5g0m7C7+NkiYfEiQN9vtSGRcuolfIcnPEJt/dQmPGrFMturpIuABUSGoFPFkd4netJPE62HKP52X9QZASoNrN8LlBUuBhgZLAkMR2JXYvL80ft89IsSZ9I0VuXCahpZ/go0PlFlCK1wSQXJnIARy6aIkGoBSPPYeCdwzJd0NT5n9Yx5e58bYr3YwLZAgHvsIo1AfDFop/WEz49Egmjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199015)(71200400001)(966005)(478600001)(110136005)(53546011)(4326008)(8936002)(66556008)(186003)(2906002)(5660300002)(122000001)(38070700005)(316002)(76116006)(66446008)(54906003)(66476007)(66946007)(64756008)(8676002)(33656002)(26005)(9686003)(6506007)(7696005)(83380400001)(55016003)(7416002)(52536014)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmVVMEVWYVJURWtXQjJIQytVbVFNZkJoTlY0clo1NHZLUnY2U1EzbVNmeEtN?=
 =?utf-8?B?NjlBVFNLdzR3V2I0a0JET09oWDU0c3hGYVlTYm5IbzBTZU5EeUVsMk9CdDA1?=
 =?utf-8?B?dHVpMVRpY3VFc2Fkbnd6WFI5MUVqeVlFTHhjUnIxdE9mN3NpYTc3QjFtcjlq?=
 =?utf-8?B?VnZzZWI5QlArTW5SR1FTejdDOFc2RjB0ay9xSWw3R3hEaW12OVpRQy9NS2ZB?=
 =?utf-8?B?QmhJbHBpc2M2T1pxOTJldzhiWEp2UCtwSEVFdCtnc1dIZFRSNXFRQjJCdFJ6?=
 =?utf-8?B?UXlDZXVMa295MmZFUDhpY2Qwcjk3bFoyRVZiTkFidU1XaXVoKzhVakRkOTND?=
 =?utf-8?B?aFluOCtzSkRGZ2hnejFvUW5Vb2RGeEF2MERNUzFvMjQzZm5TbGtxN3ljTDJz?=
 =?utf-8?B?YUxWRFFZU0gwUU5kYnRHb2xubCtMeWIyaVIxRUJ3ZWtsc2trSTkwOWhCMHdy?=
 =?utf-8?B?ZmxqYlp6eGwvMEt2dVJtVXI1OEg0MlR6b1BtNU9iS2llUk52SzdGNWV3TUpD?=
 =?utf-8?B?L1k3SkVlb2MzOFc5TG1Pa3F6RHhtVWFhWGhxazU0QklLL2padkV4Y0NRYW1t?=
 =?utf-8?B?eUdRZGhwU0NmS0Q5S1NPaXVmOHp5RWVyK2hoWmN1Q3VvUFdvZXh0cXVDeEY5?=
 =?utf-8?B?REo2bG1MbXZKRVprRW9wMkhvZE0vbGE1SVZoQjA5ekNjZnFVRFFFS2tLTUZN?=
 =?utf-8?B?MERFYVJHY05rcktVdklJUEtnS0xZVDZjNkJOa1gzeVR3WXdremROUGxRSjRG?=
 =?utf-8?B?QWE4RElkaEIzemFURlRSQjBoemQ5eXNldm1FcGsvditFMlRwR1VFUFd6dTl3?=
 =?utf-8?B?OCt1bUhmWGJoaldXdzFkUWlQaVdPb2pBSk1YRGFVbnBJTmw1ekw4ZnIrT3FR?=
 =?utf-8?B?cU51bGtsWU9NQUJJbGgwaFFqSU05U1A0UVhGeitxM1czakZYc1gxTEVadmpx?=
 =?utf-8?B?OUhtbjluUzdKVzRZSk9IWjdvUGkrNXh3NU0rM0Q3STdZL0ZIOHVCaEthOEpo?=
 =?utf-8?B?V2tIRXU4d29KSE5lbHJWcFFFMk5TTzlGUUxEQ1lDZ2tTK0dXR3pnaUtBQU53?=
 =?utf-8?B?Qzk4a1Q1MU5mb0haeWI1ZmdMM29vbEFwaUcwUHNxdVE4RnZNMVptcDA4SnYz?=
 =?utf-8?B?UDRzOHkzYnltT21LeVRkMUs0VmM4MFpKRytyZWJwaVZnb0t3Um83N0YzUUVk?=
 =?utf-8?B?ajBKS3MybGZXZWdiUGZ3RGJJaUY4MXFVT3FDaGZiZWRONytiWWNzNEcvLytC?=
 =?utf-8?B?WEVGSkFjL0VtRWJUbzRvSGNCd2hZVW4xZytPcDBUY1dqSXk2NVdUUmlhWFJW?=
 =?utf-8?B?Z0JXSXU5ajhPaEFpMTcyNzI0emNyT0lXODFDVVE0MFA3amVSR1RORG1rbnJr?=
 =?utf-8?B?anR4WG1NZG51SklQL0hnMkV1anZ5c2t2QzhEa3NiNTR4c3hTU09LMmRTdmtM?=
 =?utf-8?B?akFyczIrRWxyV2hyVkExeHFYUDBpMmZjdnJZY0huUjZSQ3lBSzVrRmEwais4?=
 =?utf-8?B?SjhsL09nL2xIRkNidDI0OVBIeWlHQ2RkZ2haNk1IWEsyaFlKSTdtZktheXR6?=
 =?utf-8?B?cmtnSlBZODR4YVpaWnBmYmRRTWgrMHg5UHNmS282ampOSnhRQmgxRzhOR1Q3?=
 =?utf-8?B?dDFBallxN3huakljVldjOVBJaXdiNm9iUE80Z3k2S1JRYThLRGxQVisxT0Jj?=
 =?utf-8?B?b0tRbEthaXVqM1NtblpwRjdZMFZaQk82R3YwOTdmRGk5UFdzL0IxVjNOSkMx?=
 =?utf-8?B?ZmNJUWhuOTEzRFliK21jV2N0SXFCTU5CWDRRMGE2d1ZoZUR5SkVkKzZnSUdk?=
 =?utf-8?B?eDVGSGlWTThRWUJ4Rnk4bWpWaVpxOThteGVVbHR3R2ZzWkRsUm5TMTdQbVVS?=
 =?utf-8?B?eDlMMDI1V3RFTHErdUJXWTl0UnNXd1BUd1l4Q3RCZHRxdDJXVkNneFpMTUlk?=
 =?utf-8?B?cWozVlo3OTF5SUU5dGZJUjhpSzU4N1FpMWsrVjA1a2lzQTIvWjZHVDZ3cDgw?=
 =?utf-8?B?NnlLUVF3d3FYaGlHMUd1WEZvY244MXJzQlRyZE1pQ0VEMWt3eEYrRWU3dE5p?=
 =?utf-8?B?MGEvallBbE9VbmVpbk1VbzYxSHpSR1NaekdHdnE5WjV2aUxSY2JJZDE2S2xI?=
 =?utf-8?Q?trsb24X/UAd31hbZ6msF6A7pm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa88335-052a-4e80-37ea-08daa7b5dc27
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 16:14:35.0198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDyDkkQeMNdPGgzloOkiOH2yHVTa66eflpcSQhLaLhPi9ZVfkQuzwfgmKhqemDv9cQReKTgnYP7NiAj7zi9Nzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3V6dWtpLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVz
YXIgV2ljYWtzb25vDQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjksIDIwMjIgOTowNiBB
TQ0KPiBUbzogU3V6dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT47IHJvYmlu
Lm11cnBoeUBhcm0uY29tOw0KPiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbEBrZXJuZWwu
b3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbQ0KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC10ZWdy
YUB2Z2VyLmtlcm5lbC5vcmc7IHN1ZGVlcC5ob2xsYUBhcm0uY29tOw0KPiB0aGFudS5yYW5nYXJh
amFuQGFybS5jb207IE1pY2hhZWwuV2lsbGlhbXNAYXJtLmNvbTsgVGhpZXJyeSBSZWRpbmcNCj4g
PHRyZWRpbmdAbnZpZGlhLmNvbT47IEpvbmF0aGFuIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5j
b20+OyBWaWtyYW0NCj4gU2V0aGkgPHZzZXRoaUBudmlkaWEuY29tPjsgbWF0aGlldS5wb2lyaWVy
QGxpbmFyby5vcmc7DQo+IG1pa2UubGVhY2hAbGluYXJvLm9yZzsgbGVvLnlhbkBsaW5hcm8ub3Jn
DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjUgMS8yXSBwZXJmOiBhcm1fY3NwbXU6IEFkZCBzdXBw
b3J0IGZvciBBUk0NCj4gQ29yZVNpZ2h0IFBNVSBkcml2ZXINCj4gDQo+IEhpIFN1enVraSwNCj4g
DQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBTdXp1a2kgSyBQb3Vs
b3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPg0KPiA+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1i
ZXIgMjksIDIwMjIgMzoyOSBBTQ0KPiA+IFRvOiBCZXNhciBXaWNha3Nvbm8gPGJ3aWNha3Nvbm9A
bnZpZGlhLmNvbT47IHJvYmluLm11cnBoeUBhcm0uY29tOw0KPiA+IGNhdGFsaW4ubWFyaW5hc0Bh
cm0uY29tOyB3aWxsQGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tDQo+ID4gQ2M6IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gPiBsaW51eC10ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IHN1ZGVlcC5ob2xsYUBh
cm0uY29tOw0KPiA+IHRoYW51LnJhbmdhcmFqYW5AYXJtLmNvbTsgTWljaGFlbC5XaWxsaWFtc0Bh
cm0uY29tOyBUaGllcnJ5IFJlZGluZw0KPiA+IDx0cmVkaW5nQG52aWRpYS5jb20+OyBKb25hdGhh
biBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgVmlrcmFtDQo+ID4gU2V0aGkgPHZzZXRo
aUBudmlkaWEuY29tPjsgbWF0aGlldS5wb2lyaWVyQGxpbmFyby5vcmc7DQo+ID4gbWlrZS5sZWFj
aEBsaW5hcm8ub3JnOyBsZW8ueWFuQGxpbmFyby5vcmcNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY1IDEvMl0gcGVyZjogYXJtX2NzcG11OiBBZGQgc3VwcG9ydCBmb3IgQVJNDQo+ID4gQ29yZVNp
Z2h0IFBNVSBkcml2ZXINCj4gPg0KPiA+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVu
aW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+ID4NCj4gPg0KPiA+IEhpIEJlc2FyDQo+ID4NCj4g
PiBPbiAyOC8wOS8yMDIyIDIxOjE4LCBCZXNhciBXaWNha3Nvbm8gd3JvdGU6DQo+ID4gPiBBZGQg
c3VwcG9ydCBmb3IgQVJNIENvcmVTaWdodCBQTVUgZHJpdmVyIGZyYW1ld29yayBhbmQgaW50ZXJm
YWNlcy4NCj4gPiA+IFRoZSBkcml2ZXIgcHJvdmlkZXMgZ2VuZXJpYyBpbXBsZW1lbnRhdGlvbiB0
byBvcGVyYXRlIHVuY29yZSBQTVUNCj4gYmFzZWQNCj4gPiA+IG9uIEFSTSBDb3JlU2lnaHQgUE1V
IGFyY2hpdGVjdHVyZS4gVGhlIGRyaXZlciBhbHNvIHByb3ZpZGVzIGludGVyZmFjZQ0KPiA+ID4g
dG8gZ2V0IHZlbmRvci9pbXBsZW1lbnRhdGlvbiBzcGVjaWZpYyBpbmZvcm1hdGlvbiwgZm9yIGV4
YW1wbGUgZXZlbnQNCj4gPiA+IGF0dHJpYnV0ZXMgYW5kIGZvcm1hdGluZy4NCj4gPiA+DQo+ID4g
PiBUaGUgc3BlY2lmaWNhdGlvbiB1c2VkIGluIHRoaXMgaW1wbGVtZW50YXRpb24gY2FuIGJlIGZv
dW5kIGJlbG93Og0KPiA+ID4gICAqIEFDUEkgQXJtIFBlcmZvcm1hbmNlIE1vbml0b3JpbmcgVW5p
dCB0YWJsZToNCj4gPiA+ICAgICAgICAgIGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1l
bnRhdGlvbi9kZW4wMTE3L2xhdGVzdA0KPiA+ID4gICAqIEFSTSBDb3Jlc2lnaHQgUE1VIGFyY2hp
dGVjdHVyZToNCj4gPiA+ICAgICAgICAgIGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1l
bnRhdGlvbi9paGkwMDkxL2xhdGVzdA0KPiA+ID4NCj4gPiA+IFJldmlld2VkLWJ5OiBTdXp1a2kg
SyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
QmVzYXIgV2ljYWtzb25vIDxid2ljYWtzb25vQG52aWRpYS5jb20+DQo+ID4NCj4gPiBBcG9sb2dp
ZXMgZm9yIHRoaXMgbGF0ZSBjb21tZW50LiBQbGVhc2UgZmluZCBpdCBiZWxvdy4NCj4gPg0KPiA+
ID4gLS0tDQo+ID4gPiAgIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgfCAgICAx
ICsNCj4gPiA+ICAgZHJpdmVycy9wZXJmL0tjb25maWcgICAgICAgICAgICAgICB8ICAgIDIgKw0K
PiA+ID4gICBkcml2ZXJzL3BlcmYvTWFrZWZpbGUgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4g
PiAgIGRyaXZlcnMvcGVyZi9hcm1fY3NwbXUvS2NvbmZpZyAgICAgfCAgIDEzICsNCj4gPiA+ICAg
ZHJpdmVycy9wZXJmL2FybV9jc3BtdS9NYWtlZmlsZSAgICB8ICAgIDYgKw0KPiA+ID4gICBkcml2
ZXJzL3BlcmYvYXJtX2NzcG11L2FybV9jc3BtdS5jIHwgMTI3Ng0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiA+ICAgZHJpdmVycy9wZXJmL2FybV9jc3BtdS9hcm1fY3NwbXUu
aCB8ICAxNTEgKysrKw0KPiA+ID4gICA3IGZpbGVzIGNoYW5nZWQsIDE0NTAgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wZXJmL2FybV9jc3BtdS9LY29u
ZmlnDQo+ID4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BlcmYvYXJtX2NzcG11L01h
a2VmaWxlDQo+ID4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BlcmYvYXJtX2NzcG11
L2FybV9jc3BtdS5jDQo+ID4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BlcmYvYXJt
X2NzcG11L2FybV9jc3BtdS5oDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQv
Y29uZmlncy9kZWZjb25maWcgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gPiBp
bmRleCA3ZDExMDUzNDNiYzIuLmVlMzFjOTE1OWE1YiAxMDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gv
YXJtNjQvY29uZmlncy9kZWZjb25maWcNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQvY29uZmlncy9k
ZWZjb25maWcNCj4gPiA+IEBAIC0xMjEyLDYgKzEyMTIsNyBAQCBDT05GSUdfUEhZX1VOSVBISUVS
X1VTQjM9eQ0KPiA+ID4gICBDT05GSUdfUEhZX1RFR1JBX1hVU0I9eQ0KPiA+ID4gICBDT05GSUdf
UEhZX0FNNjU0X1NFUkRFUz1tDQo+ID4gPiAgIENPTkZJR19QSFlfSjcyMUVfV0laPW0NCj4gPiA+
ICtDT05GSUdfQVJNX0NPUkVTSUdIVF9QTVVfQVJDSF9TWVNURU1fUE1VPXkNCj4gPiA+ICAgQ09O
RklHX0FSTV9TTU1VX1YzX1BNVT1tDQo+ID4gPiAgIENPTkZJR19GU0xfSU1YOF9ERFJfUE1VPW0N
Cj4gPiA+ICAgQ09ORklHX1FDT01fTDJfUE1VPXkNCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BlcmYvS2NvbmZpZyBiL2RyaXZlcnMvcGVyZi9LY29uZmlnDQo+ID4gPiBpbmRleCAxZTJkNjk0
NTM3NzEuLmM5NGQzNjAxZWI0OCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcGVyZi9LY29u
ZmlnDQo+ID4gPiArKysgYi9kcml2ZXJzL3BlcmYvS2NvbmZpZw0KPiA+ID4gQEAgLTE5Miw0ICsx
OTIsNiBAQCBjb25maWcgTUFSVkVMTF9DTjEwS19ERFJfUE1VDQo+ID4gPiAgICAgICAgIEVuYWJs
ZSBwZXJmIHN1cHBvcnQgZm9yIE1hcnZlbGwgRERSIFBlcmZvcm1hbmNlIG1vbml0b3JpbmcNCj4g
PiA+ICAgICAgICAgZXZlbnQgb24gQ04xMEsgcGxhdGZvcm0uDQo+ID4gPg0KPiA+ID4gK3NvdXJj
ZSAiZHJpdmVycy9wZXJmL2FybV9jc3BtdS9LY29uZmlnIg0KPiA+ID4gKw0KPiA+ID4gICBlbmRt
ZW51DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wZXJmL01ha2VmaWxlIGIvZHJpdmVycy9w
ZXJmL01ha2VmaWxlDQo+ID4gPiBpbmRleCA1N2EyNzljNjFkZjUuLjNiYzkzMjNmMDk2NSAxMDA2
NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcGVyZi9NYWtlZmlsZQ0KPiA+ID4gKysrIGIvZHJpdmVy
cy9wZXJmL01ha2VmaWxlDQo+ID4gPiBAQCAtMjAsMyArMjAsNCBAQCBvYmotJChDT05GSUdfQVJN
X0RNQzYyMF9QTVUpICs9DQo+ID4gYXJtX2RtYzYyMF9wbXUubw0KPiA+ID4gICBvYmotJChDT05G
SUdfTUFSVkVMTF9DTjEwS19UQURfUE1VKSArPQ0KPiA+IG1hcnZlbGxfY24xMGtfdGFkX3BtdS5v
DQo+ID4gPiAgIG9iai0kKENPTkZJR19NQVJWRUxMX0NOMTBLX0REUl9QTVUpICs9DQo+ID4gbWFy
dmVsbF9jbjEwa19kZHJfcG11Lm8NCj4gPiA+ICAgb2JqLSQoQ09ORklHX0FQUExFX00xX0NQVV9Q
TVUpICs9IGFwcGxlX20xX2NwdV9wbXUubw0KPiA+ID4gK29iai0kKENPTkZJR19BUk1fQ09SRVNJ
R0hUX1BNVV9BUkNIX1NZU1RFTV9QTVUpICs9DQo+ID4gYXJtX2NzcG11Lw0KPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGVyZi9hcm1fY3NwbXUvS2NvbmZpZw0KPiA+IGIvZHJpdmVycy9wZXJm
L2FybV9jc3BtdS9LY29uZmlnDQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5jMmM1NmVjYWZjY2INCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+
ICsrKyBiL2RyaXZlcnMvcGVyZi9hcm1fY3NwbXUvS2NvbmZpZw0KPiA+ID4gQEAgLTAsMCArMSwx
MyBAQA0KPiA+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiA+ICsj
DQo+ID4gPiArIyBDb3B5cmlnaHQgKGMpIDIwMjIsIE5WSURJQSBDT1JQT1JBVElPTiAmIEFGRklM
SUFURVMuDQo+ID4gPiArDQo+ID4gPiArY29uZmlnIEFSTV9DT1JFU0lHSFRfUE1VX0FSQ0hfU1lT
VEVNX1BNVQ0KPiA+ID4gKyAgICAgdHJpc3RhdGUgIkFSTSBDb3Jlc2lnaHQgQXJjaGl0ZWN0dXJl
IFBNVSINCj4gPiA+ICsgICAgIGRlcGVuZHMgb24gQUNQSQ0KPiA+ID4gKyAgICAgZGVwZW5kcyBv
biBBQ1BJX0FQTVQgfHwgQ09NUElMRV9URVNUDQo+ID4gPiArICAgICBoZWxwDQo+ID4gPiArICAg
ICAgIFByb3ZpZGVzIHN1cHBvcnQgZm9yIHBlcmZvcm1hbmNlIG1vbml0b3JpbmcgdW5pdCAoUE1V
KSBkZXZpY2VzDQo+ID4gPiArICAgICAgIGJhc2VkIG9uIEFSTSBDb3JlU2lnaHQgUE1VIGFyY2hp
dGVjdHVyZS4gTm90ZSB0aGF0IHRoaXMgUE1VDQo+ID4gPiArICAgICAgIGFyY2hpdGVjdHVyZSBk
b2VzIG5vdCBoYXZlIHJlbGF0aW9uc2hpcCB3aXRoIHRoZSBBUk0gQ29yZVNpZ2h0DQo+ID4gPiAr
ICAgICAgIFNlbGYtSG9zdGVkIFRyYWNpbmcuDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
ZXJmL2FybV9jc3BtdS9NYWtlZmlsZQ0KPiA+IGIvZHJpdmVycy9wZXJmL2FybV9jc3BtdS9NYWtl
ZmlsZQ0KPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+IGluZGV4IDAwMDAwMDAwMDAw
MC4uY2RjMzQ1NWY3NGQ4DQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysgYi9kcml2ZXJz
L3BlcmYvYXJtX2NzcG11L01ha2VmaWxlDQo+ID4gPiBAQCAtMCwwICsxLDYgQEANCj4gPiA+ICsj
IENvcHlyaWdodCAoYykgMjAyMiwgTlZJRElBIENPUlBPUkFUSU9OICYgQUZGSUxJQVRFUy4NCj4g
PiA+ICsjDQo+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ID4g
Kw0KPiA+ID4gK29iai0kKENPTkZJR19BUk1fQ09SRVNJR0hUX1BNVV9BUkNIX1NZU1RFTV9QTVUp
ICs9IFwNCj4gPiA+ICsgICAgIGFybV9jc3BtdS5vDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wZXJmL2FybV9jc3BtdS9hcm1fY3NwbXUuYw0KPiA+IGIvZHJpdmVycy9wZXJmL2FybV9jc3Bt
dS9hcm1fY3NwbXUuYw0KPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+IGluZGV4IDAw
MDAwMDAwMDAwMC4uMGZhNWYyOWJmMWM2DQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysg
Yi9kcml2ZXJzL3BlcmYvYXJtX2NzcG11L2FybV9jc3BtdS5jDQo+ID4gPiBAQCAtMCwwICsxLDEy
NzYgQEANCj4gPg0KPiA+DQo+ID4gPiArLyogRGVmYXVsdCBldmVudCBsaXN0LiAqLw0KPiA+ID4g
K3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICphcm1fY3NwbXVfZXZlbnRfYXR0cnNbXSA9IHsNCj4g
PiA+ICsgICAgIEFSTV9DU1BNVV9FVkVOVF9BVFRSKGN5Y2xlcywNCj4gPiBBUk1fQ1NQTVVfRVZU
X0NZQ0xFU19ERUZBVUxUKSwNCj4gPiA+ICsgICAgIE5VTEwsDQo+ID4gPiArfTsNCj4gPiA+ICsN
Cj4gPiA+ICtzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqKg0KPiA+ID4gK2FybV9jc3BtdV9nZXRf
ZXZlbnRfYXR0cnMoY29uc3Qgc3RydWN0IGFybV9jc3BtdSAqY3NwbXUpDQo+ID4gPiArew0KPiA+
ID4gKyAgICAgcmV0dXJuIGFybV9jc3BtdV9ldmVudF9hdHRyczsNCj4gPiA+ICt9DQo+ID4NCj4g
PiBUaGlzIHdvdWxkIG1ha2UgYWxsIHRoZSAiUE1VIiBpbnN0YW5jZXMgKHdoaWNoIGRvbid0IGlt
cGxlbWVudCB0aGUNCj4gPiBjYWxsYmFjaykgc2hhcmUgYSBub24tY29uc3QgYXJyYXkuIENvdWxk
IHdlIGluc3RlYWQgcmV0dXJuIGEgY29weSBvZg0KPiA+IHRoZSBhdHRycyB0byBhdm9pZCBkcml2
ZXJzIG1lc3NpbmcgdXAgd2l0aCB0aGUgYXJyYXkgPw0KPiA+IFRoZSBhcnJheSBjb3VsZCBiZSBh
bGxvY2F0ZWQgdmlhIGRldm1fIG9uIHRoZSBzcGVjaWZpYyBkZXZpY2UsIHRodXMNCj4gPiBpdCBn
ZXRzIGNsZWFuZWQgdXAgb24gdGhlIGRldmljZSB0ZWFyIGRvd24gPw0KPiA+DQo+ID4gLi4uDQo+
ID4NCj4gPiA+ICtzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqKg0KPiA+ID4gK2FybV9jc3BtdV9n
ZXRfZm9ybWF0X2F0dHJzKGNvbnN0IHN0cnVjdCBhcm1fY3NwbXUgKmNzcG11KQ0KPiA+ID4gK3sN
Cj4gPiA+ICsgICAgIHJldHVybiBhcm1fY3NwbXVfZm9ybWF0X2F0dHJzOw0KPiA+ID4gK30NCj4g
PiA+ICsNCj4gPg0KPiA+IFNhbWUgYXMgYWJvdmUNCj4gDQo+IEkgd2FzIGV4cGVjdGluZyB0aGUg
dmVuZG9yIHNwZWNpZmljIGltcGwgdG8gYmUgYXdhcmUgYW5kIG1ha2UgaXRzIG93bg0KPiBjb3B5
IGlmIGl0IG5lZWRzIHRvIG1ha2UgbW9kaWZpY2F0aW9ucyB0byB0aGUgYXJyYXkuIEJ1dCBJIGNh
biByZXR1cm4gYSBjb3B5DQo+IHRvIGJlIG9uIHRoZSBzYWZlIHNpZGUuIFdlIGNhbiByZXZpc2l0
IGFnYWluIGlmIGl0IGlzIHVubmVjZXNzYXJ5Lg0KPiANCj4gSSB3aWxsIHNlbmQgdGhlIHVwZGF0
ZWQgcGF0Y2ggc2hvcnRseS4NCg0KSGVyZSBpcyB0aGUgbGluayB0byB0aGUgbGF0ZXN0IHBhdGNo
Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXJtLWtlcm5lbC8yMDIyMDkzMDAyMzQ0
My45NDYzLTItYndpY2Frc29ub0BudmlkaWEuY29tLw0KDQpUaGFua3MsDQpCZXNhcg0K
