Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C545EF72C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiI2OGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiI2OGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:06:12 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BDF1514EF;
        Thu, 29 Sep 2022 07:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pb8BUNUnsCD3H9GqQ0k9hVi/HfyNT3rVlXy1SftrE4E+cB+qmWsqOY3YCiX90G34mfSqbU3OMn9FgnxMjRT6ajrqvXtKVlIaop+BYgv5eE7WbdwZyUF57CfKBWmMS+PRs3mmZWERz1XElaKd2LEVPQo4QLxbUMv7JUWsdvEe9IX8eBNC5JvtsziKr912M+sBNwVo+owlalgk8SbUoUnGpn0gNJ7QHAYpysUUk/WQpxvUoXmbW/Ft4qVGOPZ1wCtInbU1ozVlvqBknF+bzyORcoYPs8D2vcoUxtiffN942NbwjYwqSlYbYUJHxDvImftq9jwCZhK/Mq1WnzvJ0szJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiiA1fspuJz6cvLY0hAIN1Tx8J/tzQLxoyxyc/aAvFE=;
 b=MqlnoWiBTxgasbjCLdRAD+LeElLVbKdQ1iNxdxVsehgqggKJjobdeoVCacuTVfvBwSvwajN3b/1LCsQvJrPrY/tqW4axOx3eulnthEcciGYwdKmsdDUk3vtPCEzG8Y1XQuneRLBZJJFutu90GuL1CJUfjg2mjyg/+NdLj5/FDT//aATrjLyNaNNrElhvyzdFsF6S+WZNFYnDFAY9rNrEMCRQGSTW6Wj33FNF7c4nF0DyzLFOPSWn8DGU56lbSG5ahKtCVjsKjopkIUpnSrJNGmzxHlc3NoKcddqBWAG/LoJoMPsWV9fqcwymD1n1tV8m6IM9XdJz+sfKXtfvWJIVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiiA1fspuJz6cvLY0hAIN1Tx8J/tzQLxoyxyc/aAvFE=;
 b=aLH9wxJQsfev/CYEQK0GR5HfWjqats60GyMeG1VEvYudHvoC87w8HGccfZla21pKomZMUVO3mxT1GDTptfuAhsNZTTBaFsk1BGCz1Nt+vuoBa37dVD7Nr8DtxkNBtw+2VBRDlGHZTYPsMXVijTfCRYqQ8MRdNrIUBIyQjC9FEjcFoKDcw4bkOJ/WOuS6Cj9tcHNUGwNtgeSj/V2wmvRIO5S4QNb0xNJsUa+jqZuK1JruNmaXF4SVvsxSy89rtasVv41vyn9JeujkQQDLv/2UmmAXFqbFBnM3Pt3wxnNxclL4aRpDeiOYllYTs+Eac08PN6gCcggQRcr+4Enunq1aQw==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Thu, 29 Sep
 2022 14:06:09 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::3c98:4af6:e849:aa5]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::3c98:4af6:e849:aa5%4]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 14:06:08 +0000
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
Thread-Index: AQHY03eZbdRwasQ0NkO0/RBm6KsShK32FDcAgABW9/A=
Date:   Thu, 29 Sep 2022 14:06:08 +0000
Message-ID: <SJ0PR12MB5676FE048F8105D01C83D0EBA0579@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20220928201830.45637-1-bwicaksono@nvidia.com>
 <20220928201830.45637-2-bwicaksono@nvidia.com>
 <f67bf3b6-c8ba-4134-5772-ce750f4bb4dd@arm.com>
In-Reply-To: <f67bf3b6-c8ba-4134-5772-ce750f4bb4dd@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|MN0PR12MB5740:EE_
x-ms-office365-filtering-correlation-id: e2903fe1-b673-4dbc-db8b-08daa223c200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aTCzXTTXjreR13IJaXNe2+anl+xGpa7TeiEn7V8rr6I/xUitkONgS6dBYBGpVpgR8epVA1i9sdimLM6Jn5eQuHHwvI22bNRiQyGIE/5Ex8+YcpMqzDhyCPHVTpVDcrD9xWh1drMUPS2mgUBr0dXEvthz3WcLKN4+cEABqbEwM9G71j8cF1XUKRbhWG5mvTi/sX+Ifc/HM0yeBgBXJzxh8Mv4TEQmFIUFc1cIM+dpkBYWTX+rig6rEkRQqoVdOjdUzxiUaaeZBBzLlyqSua0Eceze1tPSK2Lx0SIKaoRh43IiewBp71S1pM7ImsdtsLI3fzOJYPmMfBk/GlB5NCzPy9ULk2GIHwMptfOqZTWiEt6D2v11fprUDoD/coufnEMpZUim6CwJ7A3FVI9oG+4XpoQX/oKeqt4d/Nla7dlC+YZfrvB+y6qie1RD8Ij+GO4cM/T1Waz+w8kyOJwK2KLGCuCvE4pIywsql/nem3rsQnsMeyHs2regUP/rKoUO02NK71nAAEC20CvKrnRslT1xodGExw6KzNTlJ2YIhD9FloExSj7KG4Y+cxIHJFA0rBwHgVri1EwOsUwjQsy//6gbZ3UAvdtV6K3dy+svhUbuASK8LH271gZhmxxAFUTngnBnYpKyius3T0Uwzhf7Xd9irDlr8za7aUuOhchlC+T3+ssfFpv/1WR6r9/z1ZPN0e5qapGiJAQnJyGLOHCOQdUqbuLKmEM9IxOHXXBHhgoA9XiT5cb9DTXGV1OAkJ/XHAjZNrzLSydgu/yHQOb4gE7JALYUCcp/+Oz6/JWlPvzvRwaOEFfF3egUYvrtdzTVH/jyuVxmBiMPslUj4KDPDtxYbt/UnY0/768icsW5PHE32wGgDmuXgkRsYINrFMg8Vns1C5PjEKSr4LtigxuRG/8hQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(54906003)(110136005)(122000001)(7416002)(186003)(2906002)(33656002)(8936002)(52536014)(66946007)(5660300002)(66476007)(38070700005)(66556008)(86362001)(8676002)(41300700001)(26005)(4326008)(76116006)(66446008)(53546011)(9686003)(6506007)(7696005)(64756008)(316002)(478600001)(83380400001)(38100700002)(966005)(55016003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkRKc0FJTUpQbFdKTklMMDJrbjhJblYwZUVpamJQcXFTQzVvTi8xVVc5QXJP?=
 =?utf-8?B?Zmt3MjRmTUVuSWFxWEx5L1JRVVJuQ1VIcS80ck5GUzU4QmhobmtLU2tKaWh3?=
 =?utf-8?B?WnJPY0grbkVaZGlDTm9ETnVReDFzMFJCcEhYTGp3MDZYbHNJZkNhbGpUQ2VF?=
 =?utf-8?B?WE1welFSOWh4dEdMblVDUmd5VmRxLzJJL08wQmxJK2FkTE5DczNJdGpVUWV1?=
 =?utf-8?B?b1ppYW4rN0x2RzVWNmUxcGQzcmtYN3MvTEJCWFNBMGZIR0tLaWpPQ2k1WXVZ?=
 =?utf-8?B?ZVY4bmVkMUV5S09NNXY5VEhyT1haSTV5Y3hkemZhalUyOXdxb3ZMbXNBZXFv?=
 =?utf-8?B?RXlIdUNKdE80VHlJL0kzNTJxUmlCSlRjaGV6OTN4dnJ1aHJ0V1Y0MkIwcjVV?=
 =?utf-8?B?M3dPUXdNajJQQnBLL3hMb05XYk83RWM1OFBEZVZnOGRXUGYxaFFVK1ZIVWJX?=
 =?utf-8?B?T2xFd3orTzZWeGh5Y3JJM1d4Tk1LVXhZMDJ3VlQ1TW4yQ0NOMkJqaTZMS2l6?=
 =?utf-8?B?bXY2OUh3VWZ2S1dOdUJNNDk3SlpPYUkxb0ducGdlMFlFNmRvZGpOQ2RTV1h1?=
 =?utf-8?B?WU1vQVlLSXBZQyt4MGJUL1Eyd05mc1hQNmVZNHZ3eThzbnQ2bWxDalpnQVJt?=
 =?utf-8?B?bThPUTh1RHBPcEtWa2ZXRFU5MXRGYzgwUFB5ZXhxN0FYNk5qSm0wYXJqSG5i?=
 =?utf-8?B?R2cvRklGSmgycnVsSmFaQ2FXREFRNEY4RnRocHdkMkx0dHJyTUlhUDVpRHdS?=
 =?utf-8?B?SUZnVFdHTE1NSTlEc0daQUNFZ0ZLSFM0bC96ZVhLaW93WUV3dUNsVVl0U2Ru?=
 =?utf-8?B?OHR4NGdRTEN1T00zVkdkWW1wNmd4WjJMcyt2VTFCdFpQUTBsMEN0STVhd3Ba?=
 =?utf-8?B?S1dIaXhtM1JOTlZZdFVPZytFQWl1R3paMUwwTDRidlJuc1YydHY3elo3cmJm?=
 =?utf-8?B?NmtpWTVCdU9xR0V2aDRzeThnTFNJcUVObU1CZ1RaRWhBR3FuS0R3dzE2M3lr?=
 =?utf-8?B?RGRyd25veG1xWDl5anZJdEhXUWZTREU4RUUxaUpiWU5BZUFCMnZ5L2ZHMFpT?=
 =?utf-8?B?R1gzS1NHYUJkdHZhTjdTQkZOcFg4THVJblV3aEh3VDFoOUkvbFZ3U1BsYmZ1?=
 =?utf-8?B?WGd4MHNxNURzd204YkI1cE5HNFkyZzZXVFRtajlwUFZRYmVmdUYvcU9JK2Nk?=
 =?utf-8?B?MnR6UVlYN0sxVHFITTJ0OVF3WkRrT0Jad250MTl5RktDVVRDZEt3R2xKSzJZ?=
 =?utf-8?B?MWR3dFBsZmhoZGlKaTFJanF4YTlKK2g0QThKTjNPa25Pclk4UFZteldteExa?=
 =?utf-8?B?ZkhTd01tWjN5Slo3cmcxcHdHd3VhNFRDSG9OQ1RkYlZiVnVjNEdzakpyV1VI?=
 =?utf-8?B?azZReVF3UE51K2ZacGIwcCtSblpMRkNvMVplZjBYdEVuVVNkUmxSdVZkaEVW?=
 =?utf-8?B?V1FlOERNemw1SldORGNsUHZoOE51VEhyYUlkdDlGbDhicVlTbkdtOXBtaFRE?=
 =?utf-8?B?U3RZUVltWjMwVnc4WDFxVEZvdkhKa0RmRnpOTy9rVnNiMXBPanpwTHh3T05H?=
 =?utf-8?B?OVk5Q1R6R1VMbmNSNE9scTVKTVVWMDhlaHVHZTkxb0l2THpHakFPa2hxU2hG?=
 =?utf-8?B?ZnlSWEVwaXo5eDUvMDhFQWdqKzFZUDlQb2JHWXFhWW1MVytIOUs5UE1YeHdO?=
 =?utf-8?B?VWJ0eGRMaFVtbjc4OVg1a2QrMVRvQkFERFRicFIwYVR1T1ZWQTQ2TDFsM2k2?=
 =?utf-8?B?RFBUZ1lvUDN0aEFjRzlDbnNDRnVhVHNZUnJaS0o1ak5TSnZ5ZlVWQ1lJYXZB?=
 =?utf-8?B?QWlVNU15c2xPeUNnS09xaG1xNDNXdVZuVlZVV1JsV0dIQWxiNzFSdmpuMGRt?=
 =?utf-8?B?K3NNWEY3dlhkdzdWeElWVFNqOVdTd1FOL2ZnUS9ZNmc4akxTTGYzL01LWW0z?=
 =?utf-8?B?NDdBVE1sWjRlVXVZQjJlS295a1piTjRBYWQ4cHZuYzFiUWVTRnJldG5rRVFi?=
 =?utf-8?B?ZzF1ZGZsZk5pdktvMG9mVHd4UkNaQjhHMU42SjVTZmRkUGNtcnNEMHV2K0pT?=
 =?utf-8?B?MFlqaDRWdDlJZHdwNjZDNHpUeVVsaWpGaFY1MWxhMVNMMnUyTDhPOXRkanJW?=
 =?utf-8?Q?X8mzh5Q0zywrk4aDZoOr48TbN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2903fe1-b673-4dbc-db8b-08daa223c200
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 14:06:08.8425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Snj7ctv1wAfGWWpLKHmmT/6OL1rn2Z2tJfzFLdtzjHJriSCuW6Ql6axQe4LNzZ6aPN9OchDs2CglfOjhTHIKpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3V6dWtpLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1enVr
aSBLIFBvdWxvc2UgPHN1enVraS5wb3Vsb3NlQGFybS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBT
ZXB0ZW1iZXIgMjksIDIwMjIgMzoyOSBBTQ0KPiBUbzogQmVzYXIgV2ljYWtzb25vIDxid2ljYWtz
b25vQG52aWRpYS5jb20+OyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsNCj4gY2F0YWxpbi5tYXJpbmFz
QGFybS5jb207IHdpbGxAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb20NCj4gQ2M6IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgtdGVncmFAdmdlci5rZXJuZWwub3JnOyBzdWRlZXAuaG9sbGFAYXJt
LmNvbTsNCj4gdGhhbnUucmFuZ2FyYWphbkBhcm0uY29tOyBNaWNoYWVsLldpbGxpYW1zQGFybS5j
b207IFRoaWVycnkgUmVkaW5nDQo+IDx0cmVkaW5nQG52aWRpYS5jb20+OyBKb25hdGhhbiBIdW50
ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgVmlrcmFtDQo+IFNldGhpIDx2c2V0aGlAbnZpZGlh
LmNvbT47IG1hdGhpZXUucG9pcmllckBsaW5hcm8ub3JnOw0KPiBtaWtlLmxlYWNoQGxpbmFyby5v
cmc7IGxlby55YW5AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvMl0gcGVy
ZjogYXJtX2NzcG11OiBBZGQgc3VwcG9ydCBmb3IgQVJNDQo+IENvcmVTaWdodCBQTVUgZHJpdmVy
DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRh
Y2htZW50cw0KPiANCj4gDQo+IEhpIEJlc2FyDQo+IA0KPiBPbiAyOC8wOS8yMDIyIDIxOjE4LCBC
ZXNhciBXaWNha3Nvbm8gd3JvdGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIEFSTSBDb3JlU2lnaHQg
UE1VIGRyaXZlciBmcmFtZXdvcmsgYW5kIGludGVyZmFjZXMuDQo+ID4gVGhlIGRyaXZlciBwcm92
aWRlcyBnZW5lcmljIGltcGxlbWVudGF0aW9uIHRvIG9wZXJhdGUgdW5jb3JlIFBNVSBiYXNlZA0K
PiA+IG9uIEFSTSBDb3JlU2lnaHQgUE1VIGFyY2hpdGVjdHVyZS4gVGhlIGRyaXZlciBhbHNvIHBy
b3ZpZGVzIGludGVyZmFjZQ0KPiA+IHRvIGdldCB2ZW5kb3IvaW1wbGVtZW50YXRpb24gc3BlY2lm
aWMgaW5mb3JtYXRpb24sIGZvciBleGFtcGxlIGV2ZW50DQo+ID4gYXR0cmlidXRlcyBhbmQgZm9y
bWF0aW5nLg0KPiA+DQo+ID4gVGhlIHNwZWNpZmljYXRpb24gdXNlZCBpbiB0aGlzIGltcGxlbWVu
dGF0aW9uIGNhbiBiZSBmb3VuZCBiZWxvdzoNCj4gPiAgICogQUNQSSBBcm0gUGVyZm9ybWFuY2Ug
TW9uaXRvcmluZyBVbml0IHRhYmxlOg0KPiA+ICAgICAgICAgIGh0dHBzOi8vZGV2ZWxvcGVyLmFy
bS5jb20vZG9jdW1lbnRhdGlvbi9kZW4wMTE3L2xhdGVzdA0KPiA+ICAgKiBBUk0gQ29yZXNpZ2h0
IFBNVSBhcmNoaXRlY3R1cmU6DQo+ID4gICAgICAgICAgaHR0cHM6Ly9kZXZlbG9wZXIuYXJtLmNv
bS9kb2N1bWVudGF0aW9uL2loaTAwOTEvbGF0ZXN0DQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogU3V6
dWtpIEsgUG91bG9zZSA8c3V6dWtpLnBvdWxvc2VAYXJtLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBCZXNhciBXaWNha3Nvbm8gPGJ3aWNha3Nvbm9AbnZpZGlhLmNvbT4NCj4gDQo+IEFwb2xvZ2ll
cyBmb3IgdGhpcyBsYXRlIGNvbW1lbnQuIFBsZWFzZSBmaW5kIGl0IGJlbG93Lg0KPiANCj4gPiAt
LS0NCj4gPiAgIGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcgICAgICAgfCAgICAxICsNCj4g
PiAgIGRyaXZlcnMvcGVyZi9LY29uZmlnICAgICAgICAgICAgICAgfCAgICAyICsNCj4gPiAgIGRy
aXZlcnMvcGVyZi9NYWtlZmlsZSAgICAgICAgICAgICAgfCAgICAxICsNCj4gPiAgIGRyaXZlcnMv
cGVyZi9hcm1fY3NwbXUvS2NvbmZpZyAgICAgfCAgIDEzICsNCj4gPiAgIGRyaXZlcnMvcGVyZi9h
cm1fY3NwbXUvTWFrZWZpbGUgICAgfCAgICA2ICsNCj4gPiAgIGRyaXZlcnMvcGVyZi9hcm1fY3Nw
bXUvYXJtX2NzcG11LmMgfCAxMjc2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgIGRyaXZlcnMvcGVyZi9hcm1fY3NwbXUvYXJtX2NzcG11LmggfCAgMTUxICsrKysNCj4gPiAg
IDcgZmlsZXMgY2hhbmdlZCwgMTQ1MCBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9wZXJmL2FybV9jc3BtdS9LY29uZmlnDQo+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9wZXJmL2FybV9jc3BtdS9NYWtlZmlsZQ0KPiA+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvcGVyZi9hcm1fY3NwbXUvYXJtX2NzcG11LmMNCj4gPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL3BlcmYvYXJtX2NzcG11L2FybV9jc3BtdS5oDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyBiL2FyY2gvYXJtNjQvY29u
Zmlncy9kZWZjb25maWcNCj4gPiBpbmRleCA3ZDExMDUzNDNiYzIuLmVlMzFjOTE1OWE1YiAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+ID4gKysrIGIvYXJj
aC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KPiA+IEBAIC0xMjEyLDYgKzEyMTIsNyBAQCBDT05G
SUdfUEhZX1VOSVBISUVSX1VTQjM9eQ0KPiA+ICAgQ09ORklHX1BIWV9URUdSQV9YVVNCPXkNCj4g
PiAgIENPTkZJR19QSFlfQU02NTRfU0VSREVTPW0NCj4gPiAgIENPTkZJR19QSFlfSjcyMUVfV0la
PW0NCj4gPiArQ09ORklHX0FSTV9DT1JFU0lHSFRfUE1VX0FSQ0hfU1lTVEVNX1BNVT15DQo+ID4g
ICBDT05GSUdfQVJNX1NNTVVfVjNfUE1VPW0NCj4gPiAgIENPTkZJR19GU0xfSU1YOF9ERFJfUE1V
PW0NCj4gPiAgIENPTkZJR19RQ09NX0wyX1BNVT15DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGVyZi9LY29uZmlnIGIvZHJpdmVycy9wZXJmL0tjb25maWcNCj4gPiBpbmRleCAxZTJkNjk0NTM3
NzEuLmM5NGQzNjAxZWI0OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BlcmYvS2NvbmZpZw0K
PiA+ICsrKyBiL2RyaXZlcnMvcGVyZi9LY29uZmlnDQo+ID4gQEAgLTE5Miw0ICsxOTIsNiBAQCBj
b25maWcgTUFSVkVMTF9DTjEwS19ERFJfUE1VDQo+ID4gICAgICAgICBFbmFibGUgcGVyZiBzdXBw
b3J0IGZvciBNYXJ2ZWxsIEREUiBQZXJmb3JtYW5jZSBtb25pdG9yaW5nDQo+ID4gICAgICAgICBl
dmVudCBvbiBDTjEwSyBwbGF0Zm9ybS4NCj4gPg0KPiA+ICtzb3VyY2UgImRyaXZlcnMvcGVyZi9h
cm1fY3NwbXUvS2NvbmZpZyINCj4gPiArDQo+ID4gICBlbmRtZW51DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGVyZi9NYWtlZmlsZSBiL2RyaXZlcnMvcGVyZi9NYWtlZmlsZQ0KPiA+IGluZGV4
IDU3YTI3OWM2MWRmNS4uM2JjOTMyM2YwOTY1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGVy
Zi9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvcGVyZi9NYWtlZmlsZQ0KPiA+IEBAIC0yMCwz
ICsyMCw0IEBAIG9iai0kKENPTkZJR19BUk1fRE1DNjIwX1BNVSkgKz0NCj4gYXJtX2RtYzYyMF9w
bXUubw0KPiA+ICAgb2JqLSQoQ09ORklHX01BUlZFTExfQ04xMEtfVEFEX1BNVSkgKz0NCj4gbWFy
dmVsbF9jbjEwa190YWRfcG11Lm8NCj4gPiAgIG9iai0kKENPTkZJR19NQVJWRUxMX0NOMTBLX0RE
Ul9QTVUpICs9DQo+IG1hcnZlbGxfY24xMGtfZGRyX3BtdS5vDQo+ID4gICBvYmotJChDT05GSUdf
QVBQTEVfTTFfQ1BVX1BNVSkgKz0gYXBwbGVfbTFfY3B1X3BtdS5vDQo+ID4gK29iai0kKENPTkZJ
R19BUk1fQ09SRVNJR0hUX1BNVV9BUkNIX1NZU1RFTV9QTVUpICs9DQo+IGFybV9jc3BtdS8NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wZXJmL2FybV9jc3BtdS9LY29uZmlnDQo+IGIvZHJpdmVy
cy9wZXJmL2FybV9jc3BtdS9LY29uZmlnDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBp
bmRleCAwMDAwMDAwMDAwMDAuLmMyYzU2ZWNhZmNjYg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiAr
KysgYi9kcml2ZXJzL3BlcmYvYXJtX2NzcG11L0tjb25maWcNCj4gPiBAQCAtMCwwICsxLDEzIEBA
DQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArIw0KPiA+ICsj
IENvcHlyaWdodCAoYykgMjAyMiwgTlZJRElBIENPUlBPUkFUSU9OICYgQUZGSUxJQVRFUy4NCj4g
PiArDQo+ID4gK2NvbmZpZyBBUk1fQ09SRVNJR0hUX1BNVV9BUkNIX1NZU1RFTV9QTVUNCj4gPiAr
ICAgICB0cmlzdGF0ZSAiQVJNIENvcmVzaWdodCBBcmNoaXRlY3R1cmUgUE1VIg0KPiA+ICsgICAg
IGRlcGVuZHMgb24gQUNQSQ0KPiA+ICsgICAgIGRlcGVuZHMgb24gQUNQSV9BUE1UIHx8IENPTVBJ
TEVfVEVTVA0KPiA+ICsgICAgIGhlbHANCj4gPiArICAgICAgIFByb3ZpZGVzIHN1cHBvcnQgZm9y
IHBlcmZvcm1hbmNlIG1vbml0b3JpbmcgdW5pdCAoUE1VKSBkZXZpY2VzDQo+ID4gKyAgICAgICBi
YXNlZCBvbiBBUk0gQ29yZVNpZ2h0IFBNVSBhcmNoaXRlY3R1cmUuIE5vdGUgdGhhdCB0aGlzIFBN
VQ0KPiA+ICsgICAgICAgYXJjaGl0ZWN0dXJlIGRvZXMgbm90IGhhdmUgcmVsYXRpb25zaGlwIHdp
dGggdGhlIEFSTSBDb3JlU2lnaHQNCj4gPiArICAgICAgIFNlbGYtSG9zdGVkIFRyYWNpbmcuDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGVyZi9hcm1fY3NwbXUvTWFrZWZpbGUNCj4gYi9kcml2
ZXJzL3BlcmYvYXJtX2NzcG11L01ha2VmaWxlDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwMDAwMDAuLmNkYzM0NTVmNzRkOA0KPiA+IC0tLSAvZGV2L251bGwNCj4g
PiArKysgYi9kcml2ZXJzL3BlcmYvYXJtX2NzcG11L01ha2VmaWxlDQo+ID4gQEAgLTAsMCArMSw2
IEBADQo+ID4gKyMgQ29weXJpZ2h0IChjKSAyMDIyLCBOVklESUEgQ09SUE9SQVRJT04gJiBBRkZJ
TElBVEVTLg0KPiA+ICsjDQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gPiArDQo+ID4gK29iai0kKENPTkZJR19BUk1fQ09SRVNJR0hUX1BNVV9BUkNIX1NZU1RFTV9Q
TVUpICs9IFwNCj4gPiArICAgICBhcm1fY3NwbXUubw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BlcmYvYXJtX2NzcG11L2FybV9jc3BtdS5jDQo+IGIvZHJpdmVycy9wZXJmL2FybV9jc3BtdS9h
cm1fY3NwbXUuYw0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAw
MDAwLi4wZmE1ZjI5YmYxYzYNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVycy9w
ZXJmL2FybV9jc3BtdS9hcm1fY3NwbXUuYw0KPiA+IEBAIC0wLDAgKzEsMTI3NiBAQA0KPiANCj4g
DQo+ID4gKy8qIERlZmF1bHQgZXZlbnQgbGlzdC4gKi8NCj4gPiArc3RhdGljIHN0cnVjdCBhdHRy
aWJ1dGUgKmFybV9jc3BtdV9ldmVudF9hdHRyc1tdID0gew0KPiA+ICsgICAgIEFSTV9DU1BNVV9F
VkVOVF9BVFRSKGN5Y2xlcywNCj4gQVJNX0NTUE1VX0VWVF9DWUNMRVNfREVGQVVMVCksDQo+ID4g
KyAgICAgTlVMTCwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRl
ICoqDQo+ID4gK2FybV9jc3BtdV9nZXRfZXZlbnRfYXR0cnMoY29uc3Qgc3RydWN0IGFybV9jc3Bt
dSAqY3NwbXUpDQo+ID4gK3sNCj4gPiArICAgICByZXR1cm4gYXJtX2NzcG11X2V2ZW50X2F0dHJz
Ow0KPiA+ICt9DQo+IA0KPiBUaGlzIHdvdWxkIG1ha2UgYWxsIHRoZSAiUE1VIiBpbnN0YW5jZXMg
KHdoaWNoIGRvbid0IGltcGxlbWVudCB0aGUNCj4gY2FsbGJhY2spIHNoYXJlIGEgbm9uLWNvbnN0
IGFycmF5LiBDb3VsZCB3ZSBpbnN0ZWFkIHJldHVybiBhIGNvcHkgb2YNCj4gdGhlIGF0dHJzIHRv
IGF2b2lkIGRyaXZlcnMgbWVzc2luZyB1cCB3aXRoIHRoZSBhcnJheSA/DQo+IFRoZSBhcnJheSBj
b3VsZCBiZSBhbGxvY2F0ZWQgdmlhIGRldm1fIG9uIHRoZSBzcGVjaWZpYyBkZXZpY2UsIHRodXMN
Cj4gaXQgZ2V0cyBjbGVhbmVkIHVwIG9uIHRoZSBkZXZpY2UgdGVhciBkb3duID8NCj4gDQo+IC4u
Lg0KPiANCj4gPiArc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKioNCj4gPiArYXJtX2NzcG11X2dl
dF9mb3JtYXRfYXR0cnMoY29uc3Qgc3RydWN0IGFybV9jc3BtdSAqY3NwbXUpDQo+ID4gK3sNCj4g
PiArICAgICByZXR1cm4gYXJtX2NzcG11X2Zvcm1hdF9hdHRyczsNCj4gPiArfQ0KPiA+ICsNCj4g
DQo+IFNhbWUgYXMgYWJvdmUNCg0KSSB3YXMgZXhwZWN0aW5nIHRoZSB2ZW5kb3Igc3BlY2lmaWMg
aW1wbCB0byBiZSBhd2FyZSBhbmQgbWFrZSBpdHMgb3duDQpjb3B5IGlmIGl0IG5lZWRzIHRvIG1h
a2UgbW9kaWZpY2F0aW9ucyB0byB0aGUgYXJyYXkuIEJ1dCBJIGNhbiByZXR1cm4gYSBjb3B5DQp0
byBiZSBvbiB0aGUgc2FmZSBzaWRlLiBXZSBjYW4gcmV2aXNpdCBhZ2FpbiBpZiBpdCBpcyB1bm5l
Y2Vzc2FyeS4NCg0KSSB3aWxsIHNlbmQgdGhlIHVwZGF0ZWQgcGF0Y2ggc2hvcnRseS4NCg0KVGhh
bmtzLA0KQmVzYXINCg0KPiANCj4gU3V6dWtpDQo=
