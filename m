Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EA75FC9C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJLRNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJLRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:13:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D31BD018E;
        Wed, 12 Oct 2022 10:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvw7TuVSoohq33mRv0uTQWOeu9FrO83Nd1WUeIQoCwE9/sM0BtDVyyvLCTQPwMlI5dJRB7bAguynfXjWQDGj4Q7cdbCZCP1udwoxnF8Mmj2+iZVwzzvZ1OXrEiajsaXzzONsVg/VOAUxOVfG8/aDfvUkjhrlTZUfUo/Ma+jXKKR3qUsSe+9Cq43qteuRL71mEVl3wQGPsReK1z1TQK5uM5Horb2csjmgX8sAxQnYkz/JIKEsALuI/GY+9TqClBLikH5mMbV8/nSDkYcQJB2Jbkq9QydKSiFB/84k5EDmOFAfAOE3tIN1Fdbow/10G0KX7e8C184xsKoqs++0mgTagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBfndLu2BLrcuJCJezuHCGr2jgwYSkVhnrDat8WrDQQ=;
 b=INEI9ruWkqMf47HOj/wm0Aqu7aZF9knM1hSzzrN4BYaCYtaubBoEKSv1o5zOh9dAOuEcQQyp4DNOiyjsTLj/WDFxQ5fvra2ErYRXtz9a8GNv8DWF6OJHonw+Qh7/PDlez88VRM9C0NiZFi4/vacQ8NMv4DadsXEQPBjmIAdbxaJxhXO+9Itl+iTisP5K7tKxkaoweXdJI/yKKUU5CJPX1fnKxv2wfv9IL39hB9O5AKHDk/e/9ei3pfapNtocsr2fLhIbX1IA7nACFgfiZjNWIk1iM6p+fQOShG4eLIK+agVfb42pNZj9icE1sXgs4DDCuk9zUXa7iElIS6iZDMZr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBfndLu2BLrcuJCJezuHCGr2jgwYSkVhnrDat8WrDQQ=;
 b=TsDpF5P7V6nkI+ZOcb2QUJJzu5jiMSKepoDvI0w8GHS6VUeLWLiYoyJATTRtzZwiYUyUx9EecyDSt5O4Q31aWpVT8CkhzuCYaZxdZJbioaE2RUgg39sID/ICMQFC0kado2YsgXTHcxks2E6yVHzGaSk56Zp/N+x2AD35Erjd1+Y=
Received: from BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 17:12:59 +0000
Received: from BYAPR12MB3240.namprd12.prod.outlook.com
 ([fe80::b440:5e40:e62e:2c2c]) by BYAPR12MB3240.namprd12.prod.outlook.com
 ([fe80::b440:5e40:e62e:2c2c%5]) with mapi id 15.20.5709.015; Wed, 12 Oct 2022
 17:12:59 +0000
From:   "Kannan, Arun Balaji" <arun.balaji.kannan@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "Mutthareddyvari, Jyotheeswar Reddy" 
        <jyotheeswar.reddy.mutthareddyvari@amd.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "git@xilinx.com" <git@xilinx.com>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
Subject: RE: [PATCH 0/4] pinctrl: pinctrl-zynqmp: Add tri-state configuration
 support
Thread-Topic: [PATCH 0/4] pinctrl: pinctrl-zynqmp: Add tri-state configuration
 support
Thread-Index: AQHY09Jl/+Ua+3Z4UEitBy6ufLXEAq4LEuQw
Date:   Wed, 12 Oct 2022 17:12:58 +0000
Message-ID: <BYAPR12MB32400C920705E7123E729B5EDD229@BYAPR12MB3240.namprd12.prod.outlook.com>
References: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <YzRvEPUWUXP4x7+h@pendragon.ideasonboard.com>
 <YzR5ZoAbaYONnmPS@pendragon.ideasonboard.com>
 <9b7fac69-265e-52f2-21e4-83d9da0f257b@amd.com>
In-Reply-To: <9b7fac69-265e-52f2-21e4-83d9da0f257b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3240:EE_|SA1PR12MB5616:EE_
x-ms-office365-filtering-correlation-id: d7b3d73d-ecdd-4662-cf85-08daac75031f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LCqelTGtDNb5zmmYHeaNaOK+64a0ts+zK0KSzd6GFIo4jg2Lyak02XsVd3/Jws1RwCWEMp/H8W+smTGJv6MRpFU+G5V9w8MbT8LR8+3EQiwo7neSRR6oD8OMn8r090UzpEKo9VsJ+F+4wtL3jgsWacJH7HZllWQYH4KogVWSQXPaYGcCJg7f93kGHdRYn+uhmppj8nv032WtkfVjvLEcuHYFulQVLAmf8+Lg5QqF62XcxLYOiaGFc3p7fBYrefIOpTZJ51voq+nUs1LZSopOsu7xD+UCDWLrJcC/g3tY81ph8Bgv+DqKGg6PzD/se5IVwvazaN/fLKQqp6K7yPSpARVqb0145+C8pvdy4tlX0I/pK/dBMpsoESTbpNLr41m2+FjkmEHIWD8uQZyiJRVQ36jZSWdXVJCwMWxWBPT0Jm14evIiiH4o2SL5d88xzGxK7HCobSBWOlFrdRcMUg0USpe5gbFpDt8w0SFo/3CrVG0vWf/6Eg7VErgJO1F4Qn293UuZ81y8q28ZmPc/6UeNJP4LCqkYLrEsg+DTZjbIvuOyoREWUiGKR0uMUmevltYaOFaQaD4Tni8M7nfWoBNUfdsXEDXiUJEbwA21lpA4KERQyrtyP3vMbEQ0PBktwQ3N7IO/jKxlb+LSOuS6veY+bNcW9jYuTltCgOyHOUPhUL/amM099uxjTs33/EwmqVqni0uQmJKmqQA9ZTE8PX3IYav3Y5LruyTf5TOME8J69fW9BKQQzmjZSexUCOLWBGzcFh2Q6R0UKBomvf/MSV7UUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3240.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199015)(33656002)(86362001)(55016003)(122000001)(66556008)(5660300002)(2906002)(41300700001)(64756008)(66476007)(8936002)(9686003)(4326008)(8676002)(66446008)(26005)(52536014)(38100700002)(38070700005)(76116006)(54906003)(66946007)(71200400001)(110136005)(316002)(83380400001)(6636002)(478600001)(186003)(6506007)(7696005)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czJUR3p6eFo4aktEdHpVcURqTGYwcWhZbGlMUStEQ3RQRThoaTZtd29RMlJG?=
 =?utf-8?B?c21lKzVHM0duaFFyQWF5dEh2R1dLNDdnckdJL1dGZHhFWG4wcEtodWtkdkRu?=
 =?utf-8?B?U21tbmpnZ1R0U1Vya3czdVEvMzl3Q1MxMW5nMVlGc1BRM1h4bXd2T0grVE8y?=
 =?utf-8?B?M05IaWNyZ0FnK2ZiZklVSlNHWkQ3dHBXYW5reEpDZ0U5YWhRNFI4MWZBbnBw?=
 =?utf-8?B?NHNDbjc4SnpmSjIxejlVcFZoS2hFNFNRanVpZHhoKzg3THBpK2lwQTVYelJp?=
 =?utf-8?B?dTFTRnk3Qm43Q3UwQk9EaWszWDh3bzhVNDdqQjk5WTRZaFhiY1A1K3E2bG5P?=
 =?utf-8?B?bE9SN2VuTXVIN0NzMEIvMHprV2tWTGsyRG0yeGxPcTk1dGh3U3BiOGtVMXoy?=
 =?utf-8?B?UHdmTHkyQXY0WXRVT05hOCtORU4xVVk1MlFySEE1NTNPTWwxRkwzdXFYNHhC?=
 =?utf-8?B?SG1rWFFZeHZZTmtGQUM0cHFKN0FWWm9xd1BQUFRISCtLalRhREMrb0tJNVVQ?=
 =?utf-8?B?ZXVIVmdWcmFTQ1p2elJBaUFiUnJ5RnlISjBEUGZZTlJ2UVBPSWUxYjlqK1Bk?=
 =?utf-8?B?eVFFeU1JRzU4czdUdjdyeVkwaUIwVnNUWW1nb1VmRTdTZHVrcnJxRHdwd1VD?=
 =?utf-8?B?MkFyVU4zK3V1VTMvMTY2R3BCeXVPTnUyVmMrbHVsNWwxcXRuWVU5b0lNZ0xC?=
 =?utf-8?B?VFRqRWtjdmlCYXl3VWFCNVAyMjlXc3A5U0tWMlRXd2w3QUNTbm8wV1NMaHc1?=
 =?utf-8?B?K3dpT2JFWmJzTGF4Vnl5NzVicC92VTFOVWxyZGpaYnRDM1dPR3I0eUV1SnRp?=
 =?utf-8?B?UDhjY0UvSUV1Q09jNWZ4dGgvNmlOb0QrSFNwTnRPMXFxRkxkem51WlNZR2ND?=
 =?utf-8?B?M2ZkSzFiSUFnd0xLQWk4eU82OVcvUWtYeUFidlg2c3BPYWVtNW1rUDZFbG14?=
 =?utf-8?B?dTQrUGNudGdNcWZJanJGOVQxL1pDQnpoUkdNSzYwNE8xcHlGMGRCOFNVL1Jo?=
 =?utf-8?B?SyszcDRwQmpFMTBvdmNFT1pOOHc0alZ2Y3JBMGdlYUwwT2R6NHJ0ZHVMb28z?=
 =?utf-8?B?OVpRNThxVzM5V3BjS2pXWDVyZ2pHKzdzcFhBb1lpYkFxL3loVVlNd01mWWwx?=
 =?utf-8?B?K3lnNnJKWGZpVWxrY3BxS0NDb2RvNHUzRGMvTDNxL2JKOEhHbm9KdklLdGdP?=
 =?utf-8?B?aS96Qk10SGU4WlQwdnFLMUhyMmRSNkN2emtrZ24xOURjV3Q4M29GVE9ld1Jk?=
 =?utf-8?B?YTlJeHdpVEFHZDN3RytnM3VENjRwQVFlU1J1RURCMmtvbEhsM3VaS2o2WGVs?=
 =?utf-8?B?Zkt6aUp5NHRLUk96OGpyKy9Bb2tsR2NHZUdRR3NPWC9IbGQ4TTNHc1hieTRJ?=
 =?utf-8?B?UE5zeTdLcy9GaGY0Y3hHcm4vN2U5K3ltMkZVRFZ3cGcyeWY0TEZXbGpabEpY?=
 =?utf-8?B?MVd0Uk9xR0IxT0s4ditldFVHWHM2dFhWMFJMZUJnVFRCYVlOcFFGUXk0ZDZz?=
 =?utf-8?B?c1NUV2xkU0ltZ3NVQ3BLZlEvdFFuZERvRWkyVHpJT1hseE9Ed1pZKzVId3JX?=
 =?utf-8?B?MXFYdVllMnFEUWNrQ3F1TGdOSzdJc1hkMzR5SGM5R096N3R0L0NDbEI5N1Ey?=
 =?utf-8?B?TlQrNEFRSktpRDNBdEwwL0VRMXdMUTZOcjZxOTBNWG5wa3BLYUNNUlJVcjNs?=
 =?utf-8?B?NDlIdUNDNjVoTjhvd2VwUFVCNHRSeGJCcm1CRlNyT01wV05kMURpNk5rSjI3?=
 =?utf-8?B?amtyUi92eXBSUTdjN3JyN2dYa3M2Q0QvdGVnUGRGN3Vib1IzUVRPbTNkTTJ5?=
 =?utf-8?B?NXBqdmdqaVRZa2x4bTBqRzN6Zk01bS9uZGozNTFJbmVQZEs2TEc0QnBEZ1d2?=
 =?utf-8?B?ZjMvNURML0QxTmYrOXZmbWQvV21jd25JQ3dxYnlqT0tXd1NVVjNscDlFQk02?=
 =?utf-8?B?UkNETndEcndnZjBocUVrNysxeFFyNUVGSGZ0a3BnMS82bkVzdWVtQ2NrN3hF?=
 =?utf-8?B?dFEwYlM1QmhGaVAvd0RFdnZIV09xd2pXeWlIWjNkcm5vdkU2aUhlaS82OW1k?=
 =?utf-8?B?QkNCbzV4aWVnd3Voc1VxOVl0dG5BOGZBeTllcGRJY1ZjR2tGN2VycUhrNndk?=
 =?utf-8?Q?ZP/c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3240.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b3d73d-ecdd-4662-cf85-08daac75031f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 17:12:58.9601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXqE489ww3CAwwI4/rOpPQv6KKGP2bXPI3rrsM515pZxP+DAEIjx/t+8YRn/YRIwiCkCeuacNI8PogUqxLibGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudCwNCg0KV2Ugd2lsbCBiZSBhZGRpbmcgYSB3YXkgdG8gY2hlY2sgZmVhdHVyZXMg
dGhhdCBhcmUgYXZhaWxhYmxlIGluIGZpcm13YXJlIGZyb20ga2VybmVsIGRyaXZlcnMgaW4gdGhl
IG5lYXItZnV0dXJlLiBPbmNlIHRoYXQgYWJpbGl0eSBpcyBhdmFpbGFibGUsIGtlcm5lbCBkcml2
ZXJzIGNhbiBxdWVyeSBpZiBhIGZlYXR1cmUgaXMgc3VwcG9ydGVkIGluIHRoZSBmaXJtd2FyZSBi
ZWZvcmUgbWFraW5nIHVzZSBvZiB0aGUgZmVhdHVyZS4NCg0KV2Ugd2lsbCByZXZlcnQgdGhpcyBw
YXRjaCBhdCB0aGlzIHRpbWUgYXMgZXhpc3RpbmcgKCYgb2xkZXIgcmVsZWFzZWQpIGZpcm13YXJl
cyBuZWl0aGVyIHN1cHBvcnRzIHRoaXMgcGFydGljdWxhciBwaW5jdHJsIHRyaXN0YXRlIGZlYXR1
cmUgb3IgdGhlIGFiaWxpdHkgdG8gY2hlY2sgZm9yIGF2YWlsYWJsZSBmZWF0dXJlcy4NCg0KUmVn
YXJkcywNCkFydW4NCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNp
bWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2Vw
dGVtYmVyIDI5LCAyMDIyIDEyOjA4IEFNDQo+IFRvOiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50
LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+OyBTYWkgS3Jpc2huYQ0KPiBQb3R0aHVyaSA8bGFr
c2htaS5zYWkua3Jpc2huYS5wb3R0aHVyaUB4aWxpbnguY29tPjsgS2FubmFuLCBBcnVuIEJhbGFq
aQ0KPiA8YXJ1bi5iYWxhamkua2FubmFuQGFtZC5jb20+OyBNdXR0aGFyZWRkeXZhcmksIEp5b3Ro
ZWVzd2FyIFJlZGR5DQo+IDxqeW90aGVlc3dhci5yZWRkeS5tdXR0aGFyZWRkeXZhcmlAYW1kLmNv
bT4NCj4gQ2M6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz47IFJvYiBI
ZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Ow0KPiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1l
a0B4aWxpbnguY29tPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3Nr
aStkdEBsaW5hcm8ub3JnPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IGdwaW9Admdlci5rZXJuZWwub3JnOyBnaXRAeGlsaW54LmNvbTsgc2Fpa3Jp
c2huYTEyNDY4QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNF0gcGluY3RybDog
cGluY3RybC16eW5xbXA6IEFkZCB0cmktc3RhdGUgY29uZmlndXJhdGlvbg0KPiBzdXBwb3J0DQo+
IA0KPiBIaSBMYXVyZW50LA0KPiANCj4gT24gOS8yOC8yMiAxODo0MiwgTGF1cmVudCBQaW5jaGFy
dCB3cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgU2VwIDI4LCAyMDIyIGF0IDA2OjU4OjEwUE0gKzAz
MDAsIExhdXJlbnQgUGluY2hhcnQgd3JvdGU6DQo+ID4+IEhpIFNhaSwNCj4gPj4NCj4gPj4gT24g
RnJpLCBKdW4gMTcsIDIwMjIgYXQgMDQ6MTY6NTVQTSArMDUzMCwgU2FpIEtyaXNobmEgUG90dGh1
cmkgd3JvdGU6DQo+ID4+PiBUaGlzIHNlcmllcyB1cGRhdGUgdGhlIFhpbGlueCBmaXJtd2FyZSwg
WnlucU1QIGR0LWJpbmRpbmcgYW5kIFp5bnFNUA0KPiA+Pj4gcGluY3RybCBkcml2ZXIgdG8gaGFu
ZGxlICdvdXRwdXQtZW5hYmxlJyBhbmQgJ2JpYXMtaGlnaC1pbXBlZGFuY2UnDQo+ID4+PiBjb25m
aWd1cmF0aW9ucy4gQXMgcGFydCBvZiB0aGVzZSBjb25maWd1cmF0aW9ucywgWnlucU1QIHBpbmN0
cmwNCj4gPj4+IGRyaXZlciB0YWtlcyBjYXJlIG9mIHBpbiB0cmktc3RhdGUgc2V0dGluZy4NCj4g
Pj4+IEFsc28gZml4IHRoZSBrZXJuZWwgZG9jIHdhcm5pbmcgaW4gWnlucU1QIHBpbmN0cmwgZHJp
dmVyLg0KPiA+Pg0KPiA+PiBJJ20gYWZyYWlkIHRoaXMgY2F1c2VzIGEgcmVncmVzc2lvbiA6LSgg
V2l0aCB0aGlzIHNlcmllcyBhcHBsaWVkLA0KPiA+PiBib290IGJyZWFrcyB3aXRoIHRoZSBmb2xs
b3dpbmcgbWVzc2FnZSBiZWluZyBwcmludGVkIHRvIHRoZSBzZXJpYWwgY29uc29sZToNCj4gPj4N
Cj4gPj4gUmVjZWl2ZWQgZXhjZXB0aW9uDQo+ID4+IE1TUjogMHgyMDAsIEVBUjogMHhGRjE4MDE5
OCwgRURSOiAweDAsIEVTUjogMHg2NA0KPiA+Pg0KPiA+PiBJJ3ZlIHRyYWNlZCB0aGF0IHRvIHRo
ZSBwcm9iZSBvZiB0aGUgVUFSVCwgd2hlbiBpdCBjYWxscyBpbnRvIHRoZQ0KPiA+PiBmaXJtd2Fy
ZSB0byBzZXQgcGluIE1JTzE4IHRvIGhpZ2ggaW1wZWRhbmNlLiBBY2NvcmRpbmcgdG8gdjEuNyBv
ZiB0aGUNCj4gPj4gWnlucU1QIHJlZ2lzdGVycyByZWZlcmVuY2UgKFVHMTA4NyksIHRoZXJlIGlz
IG5vIHJlZ2lzdGVyIGF0IGFkZHJlc3MNCj4gPj4gMHhGRjE4MDE5OC4NCj4gPj4NCj4gPj4gSSBh
bSB1c2luZyB0aGUgVkNVIFRSRCAyMDIxLjEgZm9yIHRlc3RpbmcuIERvZXMgdGhpcyBzZXJpZXMg
cmVxdWlyZSBhDQo+ID4+IGZpcm13YXJlIHVwZGF0ZSA/IElmIHNvIGJhY2t3YXJkIGNvbXBhdGli
aWxpdHkgbmVlZHMgdG8gYmUgcHJlc2VydmVkLg0KPiA+PiBJdCdzIHZlcnkgbGF0ZSBpbiB0aGUg
djYuMC1yYyBjeWNsZSBmb3IgYSBmaXgsIGEgcmV2ZXJ0IG1heSBiZSBiZXN0DQo+ID4+IGF0IHRo
aXMgcG9pbnQsIHRvIGdpdmUgdXMgdGltZSB0byBmaXggdGhlIGlzc3VlIHByb3Blcmx5Lg0KPiA+
DQo+ID4gSSd2ZSBub3cgdGVzdGVkIHRoZSBWQ1UgVFJEIDIwMjIuMSAod2hpY2ggQUZBSUsgaXMg
dGhlIGxhdGVzdA0KPiA+IGF2YWlsYWJsZSB2ZXJzaW9uKSwgYW5kIHRoZSBwcm9ibGVtIGRvZXNu
J3Qgb2NjdWUgdGhlbi4gSXQgdGh1cyBzZWVtcw0KPiA+IHRoaXMgZGVwZW5kcyBvbiBhIGZpcm13
YXJlIHVwZGF0ZSwgd2hpY2ggaXMgaW1wcmFjdGljYWwgYXQgYmVzdCBmb3INCj4gPiBhbGwgb2xk
IGRlc2lnbnMgOi0oDQo+IA0KPiBUaGF0J3MgY29ycmVjdCBvYnNlcnZhdGlvbi4gU3VwcG9ydGlu
ZyB0aGVzZSB0d28gcHJvcGVydGllcyByZXF1aXJlcyBuZXdlcg0KPiBwbXVmdyBvciB0aGF0IG1l
c3NhZ2UgaXMgcmVjZWl2ZWQuDQo+IEkgd2lsbCBsZXQgQXJ1biBhbmQgSnlvdGhlZXN3YXIgdG8g
Y29tbWVudCBpdC4gSSBkb24ndCB0aGluayB0aGVyZSBpcyBhIHdheSB0bw0KPiBkZXRlY3Qgd2hp
Y2ggZmlybXdhcmUgaGFzIGltcGxlbWVudGF0aW9uIGZvciBpdCBhdmFpbGFibGUuDQo+IA0KPiBU
aGFua3MsDQo+IE1pY2hhbA0K
