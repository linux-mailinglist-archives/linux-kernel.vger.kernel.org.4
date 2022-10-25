Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495C560D7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiJYX2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiJYX16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:27:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2131.outbound.protection.outlook.com [40.107.94.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68305CF84D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 16:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhlUspSkXIRRw3Ww1WeDimAW2qo3RujE8kDr+hrnSBeubvLLHFuUIIpfB3XU1CP5GmzsaMDaItziA5YGbiEAPWxAA9RV8w+Z03waVB6XdhUJQgApNpO/0wKFLfgxSE+vlzJAc5UOCIT/txN7Euvh9riojbaEqctwSEwm2sD0oGI1UN7kHCvTDLCh7HluI8zBmO8HpA6W1DXsvUtvpEfEwxH9WVcY4LjuUA/IYuWlOGXG1+R1ezrohRJbgxJd62l9eS5H2x2/DvyJqXXLes39bd4oRMFAQ8xbj/s3I7NWN7bvB7FV81eGI2niXjNRKyqGT32dfttnVIchpppORxwcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGXNv4TRIl9ky4UA/ofPnIrsVPEiD28INUmIJPChI1A=;
 b=epJLMl8p0VNBGvTLVUWF8fkZeJW2lu+5vOPC8SaT+lTpFc7eL2nlwih6IpQrWobrKoWtPd5TqMIaC+0cIF+Ia1f7Uy4v82G2KqEabz+PJjz9IdwQ2g7Kd8ROP37RtoNhH/pokThYhUXGH9h3pqyUGq2Qr8oUnZ5DsAwMnyQIdFwNG13l3jyDPeSgPO7JMrX+9h1Z+g9xdJe65DWR2YyntTHmSLl0y2Km5noW5LHjdhmzgwpF5i5B2gE/lH9Kp5+TLcgrineyxoj2MEvxis/eH27pbTfNiYlVrghqvH9WGldZz9effRolQE0FJxwj0vLr/7TzqMw8t63jyev526W0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nathanm.com; dmarc=pass action=none header.from=nathanm.com;
 dkim=pass header.d=nathanm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nathanm.onmicrosoft.com; s=selector2-nathanm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGXNv4TRIl9ky4UA/ofPnIrsVPEiD28INUmIJPChI1A=;
 b=ldEKR8CBzTlMbPymQdiDy9ZXYTxrOCLz95Ol9QNwlQRAb6oCPtI4Wev5jmpZIIncb6ZHmbw1ijgh2FSUfLF0Sg/2fNGTAP+nJZyUlB1akWsil1weZJH/D8RclUHBo+KjIFswEU5Per8o8YLBNqgmarGDAKgLEsp6tvXuHMWzyFk=
Received: from BYAPR06MB5573.namprd06.prod.outlook.com (2603:10b6:a03:a8::18)
 by CO1PR06MB8187.namprd06.prod.outlook.com (2603:10b6:303:ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 23:27:55 +0000
Received: from BYAPR06MB5573.namprd06.prod.outlook.com
 ([fe80::8680:24cb:c1f9:6497]) by BYAPR06MB5573.namprd06.prod.outlook.com
 ([fe80::8680:24cb:c1f9:6497%5]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 23:27:55 +0000
From:   Nathan Moinvaziri <nathan@nathanm.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
 chars match
Thread-Topic: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering
 if chars match
Thread-Index: AQHY6MloFgm8mLQmeEe/yASKS6uSYw==
Date:   Tue, 25 Oct 2022 23:27:55 +0000
Message-ID: <4eb86647-488e-4976-1580-d03d49a65f2c@nathanm.com>
References: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
 <Y1embP5sEp/NPxK0@smile.fi.intel.com>
 <BYAPR06MB557390C5F741300BDE2BAA8BD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <bad224c0-98a3-37db-99c3-b44687cc396e@wanadoo.fr>
In-Reply-To: <bad224c0-98a3-37db-99c3-b44687cc396e@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nathanm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR06MB5573:EE_|CO1PR06MB8187:EE_
x-ms-office365-filtering-correlation-id: e94aad8f-9429-48e8-a3d2-08dab6e08b66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZlhS8cug+bb0qBu2xeRs0muGrJ433uZuTcy84f1vc0A7bNQpKT3eRfxk1W4b2HGUDmgP54n1oDvRreDr7tGgKqkofCE1QWfeK2WXLEM3inob8qoh5ij7tdS26EAF6G3N71P4i/dlIeVu+/8OHV4ZFcmqtAl6kRUWwB+x0s3RPiZi27kV44ujkeup4HRWqqjFyIZXSdibnXfS9B+XqoXT92VaGl70KnAwaJE/U4Y26Xg4bVJCpjmx+dmB9Pco5nHzTKOnq+/LlzRPK/E0oLL9jmD3nghLWlLSlpVogX+iQUYQY7d7A6fGE3rjblZc03QlQBFIpMNlewrwiHFZvZrOm864qUB9SSBEme185HQ8Tthpmfn9G1BfSn1oyjq8FCE9M+vS1U8xfDLoxTsEPewYApLuKJ2P18P8sxn15L7Bs00Rg8euFFpG5RIGkCNc+VGDXeFEabm8ECrsC6dM10kdYelfH463gckDIA7iQkUE8uasnfZqd6ykkEj2JhViKri/jq2R0J99KmFggR3L+xozPgCBFNMgWamorjkToofvpJ1UFIs+VrJeh4m0Zv/VLWnT4tGsvK0rrrADdKchQFBeccihDuytPPP/2bmDKuwx4V5niRBI88fPpxGzeUe4tODtaKEX8qct5NgxD+xqybVqSb9cPv6YEpwziXzAlnfitN3Dx+r08TI+QGwmwdxgCvipOcSsgBuc9xP9Xo8dplBmHiqyne9vEEsTPHJ73aJY9ThurhK8GGnbcM6BRVDSsbeuNp9EwVV2Ebu+TWXWYFWrD/rq/wyN5E6WSUWCd6bLjo5Aw9NdfoKjM10d+LHN9q4jcu9I0rusnVUXFX7iNwrVog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB5573.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39830400003)(136003)(396003)(346002)(451199015)(31686004)(36756003)(4744005)(83380400001)(38100700002)(122000001)(66446008)(186003)(8936002)(4326008)(76116006)(2906002)(66556008)(31696002)(66476007)(64756008)(8676002)(66946007)(54906003)(5660300002)(6916009)(316002)(86362001)(2616005)(53546011)(71200400001)(38070700005)(6512007)(6506007)(26005)(41300700001)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zi9tbVYzaFNzVnV5L2F2R01mcW91WjdzR3Z5N2FCT0l2V3E5SXY3bnBnZlhO?=
 =?utf-8?B?TkZDRThMOHNRMk5vN0RGYVNwb3YrNFJJU0F0UVd0L0ZoTHUwd0k0RnoxMXVy?=
 =?utf-8?B?TTB2dFR0ZGlWd0ZUcmV3RW9wQ1J0Qk1WOHVXaDVIc2lrTHJINFV5SUlNLytn?=
 =?utf-8?B?YWJDRlFRQjd3R3hmQUl1dVRTSWhMZ1d1bWU3eUZlNzlKUG9NQXIxZmdUWDd2?=
 =?utf-8?B?cWFuaSs2NVFjc3IxRVMxbnUyUDlKV3pUVUdJMVZRZ2ZXTUZjTDQxa0VVTUNu?=
 =?utf-8?B?S3haRDNER0FYOWhhR04rUUs5am9VVU5QK2F4RFdBV1ZBaFZIaVJNK1BKZEgz?=
 =?utf-8?B?QVk3cW5RRHVhU1RoQ1ZWN2p3S3ZUdTAzY3JhUnNrVUJrZ0JnNWtQcVBWRVM2?=
 =?utf-8?B?blBxajBUbWhtM3JkNjFSZkFlei9VTHd3dVZ2Nk5pSWthQUVlMXNHVWlaZ21T?=
 =?utf-8?B?aklEMFp0ZW1rUkVXdlJkU1FGTzgybXJwaTlCdlpuTnFOOURjcEpKZHdsS1dH?=
 =?utf-8?B?MnY3LzlDRytoTEpQaFZQUDRCSnB1U0xzSkxyQUVuQjA2dXJDMHE4c1VXblhi?=
 =?utf-8?B?L2V2TmpSbzlMMzdaaW1HaWs5bkJaZ1FrdnhjOHMxaGtBTWNiTGNzUnNFOEFM?=
 =?utf-8?B?Q0wvMFlLSi9lODRoeGVoa3hkMjZPbXJBNkYvME9ibTdWZkxtVkNGQ3hGN0lG?=
 =?utf-8?B?cGdtRklEUGxwNkwrU01uWisvUmlOeWwxOHRYNXFTVkkxMTdMK0twT2lHYkNj?=
 =?utf-8?B?QjVQQXMyczNhZ3U3MkFIaXZTSXRUNG9NN2VwOWJGTU9FRkl4Yk1oMUt3Ukxh?=
 =?utf-8?B?ZzVyUXhsUEFNRXB4RVpCZXJzblpOTnNaUGt4bXIvZFFTUzBOekVrOFplSXB0?=
 =?utf-8?B?ZFVGZlhzUGdBa080Q0UyeEUzS1Znem00WUlEMDRlU0pOYzJhZ3poSThwWUFF?=
 =?utf-8?B?S1lsK0FkWnJGYVhHVFpONlk5OW1HYTdSR0lzTTY4TURZNk5Nb2UwZ1VBM1Ar?=
 =?utf-8?B?NHRmelVQMUlqRGdCM2NDdGdWaXEzVDcrcUdVMlJVaXZab2dwdnp4WUhVUUtv?=
 =?utf-8?B?MEo2MGdkVjB4ZU1yLzFGLzB0dEhWRWU3d20zT2E5NFhCVzZLNU1sTTNlVUdK?=
 =?utf-8?B?RFNBZk5wdVFLdlhneGZuRWhUMjBLbkQ0ZVd3K0wzOUtUakRRcDFUWU1pMzdn?=
 =?utf-8?B?eWlvSU1BMVAwMitlbThTYWEwd1RkT3RGS09HZFFaMlF4WVNrNW5NQXpYTDE0?=
 =?utf-8?B?TXc2UldHY1hoV3A1T0hBTFJ4QWlVR1hmWnIrS0hreTlVUGo1bGxrODBhbXNP?=
 =?utf-8?B?eFJHTDNFMjBtRjZzRjZacnFMK2I1czVMSndVUldLcnYyT0dtbjJLQmtZVHV1?=
 =?utf-8?B?bVR4NHJQaHNKOGd5bURaS0M3c0pIY09Zd3kvbm9oZ3RYYlNoQXE5WlVmcHFs?=
 =?utf-8?B?dXUyWXZveitSTjJjWUNwNVZZeDhqL3dWZ2VNMDF0SE5nNVY3Ull0aTYwdmdZ?=
 =?utf-8?B?djU1UEdxTWtHTDJzM25qWjBuTzhpQWNHZ1h3cEVwZENNNEluKzVZU21NZVZI?=
 =?utf-8?B?NVhCb1FSV1FKS1BlRTlTMGg3Z3BtMTJ4QlByVlgyYit1aXNnUUh2d1JpYTV4?=
 =?utf-8?B?ditQbkRvVHZBNFlaQ3JReXpZRjlvTkRWNUFpRk00S1o1K3V5V0VLV1N6L2pP?=
 =?utf-8?B?YkxWUE5Ic24yUGZPeGJRaHAxS2IrU1RJV3Z3TTd1SmpDWmk1TXRGaDZFaWxY?=
 =?utf-8?B?MmlyNSs4c2diL0h4d1p2VWh0WWJWOXc1VktmNzVxM0JzRnVUUG1Tb3lsbTdw?=
 =?utf-8?B?aVlHYkNiYlFlengxbDBDaklubUcremsxWDNKRzA0ZDZwaVdwUFlteGVwSE5o?=
 =?utf-8?B?V2RkZUlrVW9qNWU3M0hSZk5ic2huK0tpSVU5RFNQTVFhQWlxQUFzZ2htS2Fv?=
 =?utf-8?B?c0ZpMkNuOVZLdFpTK0xYNHFUdXpGbDhWb2cxSG9ZYnozcjRSdzVYY1ZwR0Vz?=
 =?utf-8?B?alk2NDRtOUtaU3VFTTI3cnBnUVBTOFNyV3dIbkJlcXU5NkEzVXB0NnhrQkVU?=
 =?utf-8?B?eXgzbWNZREsvZVpEZjdpVDVSWEd4d3B6TWVFNlZHWHk0SUhHcWpITFl6Sitm?=
 =?utf-8?Q?c/n0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FB98E7578565B4998211047A7B77627@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nathanm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB5573.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94aad8f-9429-48e8-a3d2-08dab6e08b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 23:27:55.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e74266a-92ff-414a-9879-2149aecc5932
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HdhTMEhkfYfbqy4g78PebJixg4ndNN9sJFpsxEmEQ8kdLus4oqR+rR7tcliAXA3CENaAiDA9WjcUUAJOOJznCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR06MB8187
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMjUvMjAyMiAxMjozMiBQTSwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBIaSwN
Cj4gdGhlIGFsZ29yaXRobSBvbiBnaXRodWIgaXMgbm90IHRoZSBzYW1lIGFzIHRoZSBvbmUgcG9z
dGVkIGhlcmUuDQo+DQo+IElJVUMsIHRoZSBvbmUgb24gZ2l0aHViIGlzIHdyb25nLiBJZiB5b3Ug
Y29tcGFyZSAyIHN0cmluZ3MgdGhhdCBhcmUgDQo+IHRoZSBzYW1lLCB0aGV5IHdpbGwgaGF2ZSB0
aGUgc2FtZSBsZW5ndGgsIGFuZCAiaWYgKGMxID09IGMyKSANCj4gY29udGludWU7IiB3aWxsIGdv
IG9uZSBwYXN0IHRoZSBlbmQgb2YgdGhlIHN0cmluZ3MuIEFuZCB0aGUgcmVzdWx0IA0KPiB3aWxs
IGJlIDwwIG9yIDAgb3IgPjAgZGVwZW5kaW5nIHRoZSB0aGUgY2hhciAqYWZ0ZXIqIHRoZSB0cmFp
bGluZyBcMC4NCj4NCj4gT24gdGhlIG90aGVyIHNpZGUsIHRoZSByZXN1bHRzIG9mIHRoZSBiZW5j
aG1hcmsgb24gZ2l0aHViIGFyZSBsaWtlbHkgDQo+IG5vdCBhY2N1cmF0ZSB3aXRoIHRoZSBhbGdv
cml0aG0gcG9zdGVkIGhlcmUsIGJlY2F1c2UgdGhlcmUgaXMgb25lIG1vcmUgDQo+IHRlc3QgaW4g
ZWFjaCBsb29wICgid2hpbGUgKGMxICE9IDApIikgYXMgbG9uZyBhcyB0aGUgMiBzdHJpbmdzIGFy
ZSB0aGUgDQo+IHNhbWUuDQo+IE9uIGdpdGh1YiB0aGlzIHRlc3QgaXMgc2tpcHBlZCBiZWNhdXNl
IHlvdSB3aWxsIGdvIHRocm91Z2ggdGhlICJjb250aW51ZSINCj4NCj4gQ0ogDQoNCkhpIENKLA0K
DQpUaGFua3MgZm9yIGNhdGNoaW5nIHRoYXQsIEkgaGFkIGNoYW5nZWQgaXQgYXQgdGhlIGxhc3Qg
c2Vjb25kLiBJIGhhdmUgDQp1cGRhdGVkIHRoZSBjb2RlIGFuZCB0aGUgYmVuY2htYXJrcyB0byB3
aGF0IEkgaW5pdGlhbGx5IHByb3Bvc2VkIGluIHRoZSANCnBhdGNoLiBSZXN1bHRzIGFyZSBhYm91
dCArLy0xJSBmcm9tIHByZXZpb3VzbHkuDQoNCk5hdGhhbg0KDQo=
