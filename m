Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FB36DD33E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDKGpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDKGpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:45:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D6DE5F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmT9oEio4eZHZRZOtM/tg61z73J5gYEsaPVdyffv9rtVYd7mil1FyoJPH//w94UJ/OsICIPmF83rUz8Hc0y76X1bnCttICZuYlyUipU+an0h7+IVfDRby9ZRzuah+2PwiiU/Hg9zJMrK4xQci+eE/KfHob2NCYNQz70DZbuJSijIowPsOzdW858jR/H8C7wjUiLy289cSORttvGK3nYl/6f7nvMlKMqVILD40EiDr3VhaWxaa5+Z1wRL7uEjRSpVKi8GTEdbwRUCRlkogDYyhqAMQbJrZwEqEobd0mvT29agW2REZGKIkSCJ643A1RRNkZRaT2vyqmQPCAckP8RESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fckn2WQ2rHAVpzLRS/e6wbVaLrbk++Da+PW4z/q8O0s=;
 b=b7CYMO+a5tGoWcBU1OaI7vudsIMkMhTgRKLH/6mNYPsOtkoZwT0VFzvEFB/kEPIEZzmHW9AgdzSqS2EaFJPKda7ns3j7nlDrMgqRCIxiXgvRdR6EKkB0CHlRgyCNaaslMDXuZ0LzuJWAgm5AYbNTn+dDUDYFDeQ0zVpXtr7y77OyDFpqjRFLV+xu/t/bEWYSah022dkYN9uS/91T1h1QtDZEXFbv4z6f4g437f6j400uX5mcPB1dfyQsLxzQ9+JbMJqhxym26EFG/c+o+I96f1bOK+fAjdJ8sQvuX3fNv/mMt1LBmd/QF9fsu5ijKlgBzhzjkU/BmCKxAVZLuTNh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fckn2WQ2rHAVpzLRS/e6wbVaLrbk++Da+PW4z/q8O0s=;
 b=siCp2VpXRe2VigC3D/CcLkTK4wPyb3ktx+Vz8cAUl+W7kvGgyKE1OE7nrJ0bRTxzR8ynSPIT2bGrqUPHAhBH8k80rNEI5Mc0mMUazKIezK24aXKzWSdECXG4CZOEZ2NSvVTmbo9kvJVtnfDqhN0sWQvmDXl3UB8jNz5UgxdggEFTQsdEH4DB32pQDvphuwrn5Y2CTXjfB7v0o7KKHF+9oO3QrQgWPzij+mQzf8dsL+Xw0D//cSRHACKjf0oYAMQzk88CuALPwOEmc8K1TjW+r9b7DRGOSHhRwoWoty0Jmtf/mDvKzCGNegJBzMXipIRnkGowJQHgOQMz8CVWh2bq/Q==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TYZPR06MB4223.apcprd06.prod.outlook.com (2603:1096:400:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 06:45:40 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 06:45:40 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Topic: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Index: AQHZbBZh3jvrK38aOUOklBMw4wCkQq8lk3uAgAAOhKCAAAaVAIAAARZw
Date:   Tue, 11 Apr 2023 06:45:40 +0000
Message-ID: <TY2PR06MB34243A9E1E9D4E34692A23BC859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <CACGkMEuOK+XqSa93a7+ki25yjVWSzfSzd5nsqMUo8sH1=B9hRg@mail.gmail.com>
In-Reply-To: <CACGkMEuOK+XqSa93a7+ki25yjVWSzfSzd5nsqMUo8sH1=B9hRg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|TYZPR06MB4223:EE_
x-ms-office365-filtering-correlation-id: afdb9609-e23b-4357-674f-08db3a585d62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFLRXZ+gxvfMyePcea6URuLTAqF5oW4GRhkWAt65/ZuNPoiVVgyeoOofM3Ga+lyJwRAObix+BXsOR+DuEivqc/i/ZTRWiEuwMv3Mx8PPUdWe2Pfd0lUGunL8hDrEQxitOphnsp4JjUEdJfZX3dSzLt1OF8SrXl2aSwKBRCSAGArZaulF9dZoV8Qr8ROZ9Idznn8cAn463jUXZLKDK5CMjkR2qsu/PODDlJsFVF3naaVOkfowIxQjwwlTdDAhN55PS+p5N9zjd4NzpstTqXI8AtNXcH/W/7FKNZ2hJtZ9Y4GlChdg5mjh0z6MAKyHfTTQM/L4UIwMicRxiv74/FYtgWNxiEWX2zQxT5errMi1f0EqNXPIae7vzFASm/vBQYlVLhngvGllQovP0POx8vMKWkxCJ/EHSWi8nwdSXEUW+b0Jz9+kuPxrayb5UF64MIY3WxrlksrADIHbO/4eWi86I95p5p9v44fgh3YnOoEGO/8m+HxfvuIKDqXieJmrEM+YNkvu3clCBxWPRUYxMOQQ62FAXp0VHKOBmC91AS+2eHheTuXZqa2AF1w4aoTUHVK+2LE4Xub8wk7YDbGN7uzcCEFEtIrElzRYDwxLiITXEdD3mWW0QUanzCa7ET2X0mLQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39830400003)(451199021)(86362001)(33656002)(7696005)(316002)(41300700001)(76116006)(66946007)(66476007)(66556008)(6916009)(71200400001)(478600001)(64756008)(66446008)(4326008)(54906003)(55016003)(5660300002)(52536014)(8936002)(8676002)(2906002)(44832011)(38070700005)(38100700002)(122000001)(186003)(53546011)(6506007)(9686003)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZYQ0k0K3RVVDZ0bzVETHJTRGlSNW9sZS9hSUZqdCtVa0g4ZExoWHVVMVpn?=
 =?utf-8?B?SGtMeDF6T092ZWZHc3Zkc2ZDcW85dXBFTmxMQmcyUEg4NmdLb1BtUE56UnlB?=
 =?utf-8?B?SUtxSGkwaDJuM3J0bjZ1NVlNSFMzazNzaXEvZXg3dndieTZidmxMbGhQNHNt?=
 =?utf-8?B?Z1lmMktBUTNtK2NTbTBUMlJPNUdaTmtRRmovWW5BaVFMVkMvQzlUT0FaeTBw?=
 =?utf-8?B?NzNFTHFSU1Z0TVh2UmU1cWZkd1EyQlE4VFkvb045WVRyaEYwVkNyWVo3QUxj?=
 =?utf-8?B?UExwVmNPbENGNitLakpCN2pKb1hyMEwyRWhuL2JPTzRNNUFURFhLZytoc2d0?=
 =?utf-8?B?MnZPVHB5Mml4cUttbzFjeGdraHdBSkxVMVdtcExjV0grZ2xNOHRqTFpxbWlU?=
 =?utf-8?B?dWNtcWM1bkdxTmVZbEF5K2t5MXFVT1B6U3Zwak5IcGhpNmtUNmJrQ1BIYjk2?=
 =?utf-8?B?aGpTdHU4YmIwVHc3ZDVmY1ppMi9VYVk5dGFPRFd0cnJmNC9oSjNiNUEyNkNy?=
 =?utf-8?B?eDIwejI2V2lSVVVGMTVyMTJkR25iS01YL2x5bWZNRjZLUGZ3eE42NU1JUTNT?=
 =?utf-8?B?VkZ2VFh2dmRzVGRoWHdvSklKRlRjdWplVllleU1GVmpFMVo5b1ZCZkF1ZU0x?=
 =?utf-8?B?WXZqb01sY2haMmJ3aSttZTlRcVo1dE0rVGhqS3lLaW1qQWtGUEg4b0w1MFJX?=
 =?utf-8?B?WlFGWVJEM0M1R1VDb0xmWWhSajRhTE9GTFFMTWNaZmN5dndYaThsQUZNMCt5?=
 =?utf-8?B?YSt0VVJCNWZaVFNnQ3JvaDNhenFlUFhuSnhnVFdEZERTYkFGb2xmNTNGUzhr?=
 =?utf-8?B?WFVPUkFRbTBJc2tNbEVVejVxZnNoOC96WEdMV2NPNHo3VHo0dnVuVVVCNFJH?=
 =?utf-8?B?eHl4SFpoK2FFdjJnblQvUVpuQXhYc3JHd1NrdllzdHFGYmU1NjdtbERkU3Ri?=
 =?utf-8?B?blBzU2oxQnNVTEdFazJoUUJpRlRPVXY2LzQ0UThxRVM0UlMxejlQdzZrY1k0?=
 =?utf-8?B?N3M3QlZFUlliZG5IZmV1NEhOSDhBcGpqdWRxZ3NaR09TVEFQRUFGMGVmM0g3?=
 =?utf-8?B?YUVTZWRjcS9EOWI4UStpSmpxVWFmK2c5MUNvelBqMTVuRGNxQkFBQ1RGdmFJ?=
 =?utf-8?B?UzZhcFFTbmxnRE5MbjhWb1ZzY2FhaTFwcDhoWVlzbzhMUER3ckJTSXVyOXBy?=
 =?utf-8?B?NmpjQkQvcVBYeGZwRFA5OVRueFc0WmpPZ0x0Z2d0YjJHMVI3MlJkdkpjZ1ZB?=
 =?utf-8?B?K1ZUSlpxdWxXREdOVGRvelQ3a1V6QnkyekxsRXgxRndwenViT01LWU1CQkpP?=
 =?utf-8?B?R0JudWhlQ2Vvb3Z4bmU2b3BLY1FFK0E1aWh3eUV4OFM2OTRPU3Z1dWxqeWhS?=
 =?utf-8?B?UTFqMzlqV0lHTlBkSjRkYTFROGNjL0Y3RVBSUjVqb1VIUkdlbzl5TWJtcVRY?=
 =?utf-8?B?ekwvN2x3dE1mdlNDTjJWK2orQUg3SHVmUUFrUXc1dWxuQkgxTTBRRlVqN2ZL?=
 =?utf-8?B?WXo2VTlRQW5NdzM3Nm1YSnBsczZPSlZiekFqQW1wYnkrTkxvMk1TOWdDVlpa?=
 =?utf-8?B?Ri8wTkt0ZWNtVjVIUUgzUWV5K1E0WTBEcVpxUEZFMWFHZnlvNlZSZy8wdzBY?=
 =?utf-8?B?YmY3Tzc4cWdPcXF5R1MrTlJkYXJXbVVKaTNGYVhsZUt0TFVkYjBKcjk1YW15?=
 =?utf-8?B?UkhtWlNLaHoyQ09rREtsdTluaTZDaUFBMWpvN09FMHZ6aCs3YUFsMHUyYy9p?=
 =?utf-8?B?R1VGby9SVFZSc2xpakY2OGl4aWNocTdSNm5jUGtxYjZVZTJpd3hZejFxc2hr?=
 =?utf-8?B?L3Z2dUJaaTM1NEVVUWM5b0tNVVBTL2lFZi9Kdm56V2RFRXcyL3FzdzF4UnN2?=
 =?utf-8?B?YUJBeklnc04rcE5PYmN5eGpuK0dkY0Rmd3RzMmxtT3hSdjA5THVueW1oVTJv?=
 =?utf-8?B?anY1RWRZOE1ENDZSdXdWRjZ0aXl6TzB5QVdENzg2blcxdFY5MjBwTytPblhO?=
 =?utf-8?B?NlZhZTRaSmlnSWYzSWcwbkZmMzl4QlQ5Nko3Z1BEaXo3ZjNUcjhkekhPb0RS?=
 =?utf-8?B?WlFJcUdMQ1V0aWN5dnZwVFNxSlhEZmpObVgzYmNweGZDL3FoSisrUFV0cUJI?=
 =?utf-8?Q?wTaH+lfzRAi5ZPhm807N2I4RS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdb9609-e23b-4357-674f-08db3a585d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 06:45:40.1179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XdqdM5tJUKQvs/+aSNzcjnDjcwl4tfWZJP+yWt/5BMKDGaY69OCuMI/3H3hFzhcx+4QXcYegPqV2Oa9TR+/BGN4jBFEf1AQ70a+EGKQJ81E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4223
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTEsIDIwMjMgMjo0MCBQ
TQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IENjOiBt
c3RAcmVkaGF0LmNvbTsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
dmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRldmljZSB0byBiZSByZXNldA0KPiANCj4gT24g
VHVlLCBBcHIgMTEsIDIwMjMgYXQgMjozNuKAr1BNIEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFn
dWFybWljcm8uY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhpLg0KPiA+DQo+ID4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDExLCAyMDIzIDE6MjQgUE0NCj4g
PiA+IFRvOiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+IENj
OiBtc3RAcmVkaGF0LmNvbTsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSB2aXJ0aW9fcGNpOiBXYWl0IGZvciBsZWdhY3kgZGV2aWNlIHRvIGJlIHJlc2V0
DQo+ID4gPg0KPiA+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgOTozOeKAr0FNIEFuZ3VzIENo
ZW4NCj4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+
DQo+ID4gPiA+IFdlIHJlYWQgdGhlIHN0YXR1cyBvZiBkZXZpY2UgYWZ0ZXIgcmVzZXQsDQo+ID4g
PiA+IEl0IGlzIG5vdCBndWFyYW50ZWVkIHRoYXQgdGhlIGRldmljZSBiZSByZXNldGVkIHN1Y2Nl
c3NmdWxseS4NCj4gPiA+ID4gV2UgY2FuIHVzZSBhIHdoaWxlIGxvb3AgdG8gbWFrZSBzdXJlIHRo
YXQsbGlrZSB0aGUgbW9kZXJuIGRldmljZSBkaWQuDQo+ID4gPiA+IFRoZSBzcGVjIGlzIG5vdCBy
ZXF1ZXN0IGl0ICxidXQgaXQgd29yay4NCj4gPiA+DQo+ID4gPiBUaGUgb25seSBjb25jZXJuIGlz
IGlmIGl0J3MgdG9vIGxhdGUgdG8gZG8gdGhpcy4NCj4gPiA+DQo+ID4gPiBCdHcsIGFueSByZWFz
b24geW91IHdhbnQgdG8gaGF2ZSBhIGxlZ2FjeSBoYXJkd2FyZSBpbXBsZW1lbnRhdGlvbi4gSXQN
Cj4gPiA+IHdpbGwgYmUgdmVyeSB0cmlja3kgdG8gd29yayBjb3JyZWN0bHkuDQo+ID4gICBFbixJ
IGZvdW5kIHRoaXMgaW4gdGhlIHJlYWwgcHJvZHVjdGlvbiBlbnZpcm9ubWVudCBzb21lIHRpbWVz
IGFib3V0IG9uZQ0KPiB5ZWFyIGFnby4NCj4gPiBhbmQgSSBmaXggdGhpcyBvdXQgb2YgdHJlZS5v
dXIgdmlydGlvIGNhcmQgaGFkIGJlZW4gc29sZCBhYm91dCB0aG91c2FuZHMgLg0KPiA+DQo+ID4g
ICBOb3csd2UgY3JlYXRlZCBhIG5ldyBjYXJkLCBpdCBzdXBwb3J0IHZpcnRpbyAwLjk1LDEuMCwx
LjEgZXRjLg0KPiA+ICAgQW5kIHdlIHVzZSB0aGlzIGhvc3QgdmRwYSsgbGVnYWN5IHZpcnRpbyBp
biB2bSB0byBob3QgbWlncmF0aW9uLHdlIGZvdW5kDQo+IHRoYXQgdGhlDQo+ID4gICBMZWdhY3kg
bW9kZWwgb2Z0ZW4gZ2V0IHRoZSBtaWRkbGUgc3RhdGUgdmFsdWUgYWZ0ZXIgcmVzZXQgYW5kIHBy
b2JlIGFnYWluLg0KPiA+ICAgVGhlIFNvYyBpcyBTaW11bGF0ZWQgYnkgZnBnYSB3aGljaCBpcyBy
dW4gc2xvd2VyIHRoYW4gdGhlIGhvc3Qsc28gdGhlIHNhbWUNCj4gYnVnDQo+ID4gICBJcyBmb3Vu
ZCBtb3JlIGZyZXF1ZW50bHkgd2hlbiB0aGUgaG9zdCB1c2UgdGhlIG90aGVyIGtlcm5lbCBsaWtl
IHVidW50dSBvcg0KPiBjZW50b3M4Lg0KPiA+DQo+ID4gICBTbyB3ZSBob3BlIHdlIGNhbiBmaXgg
dGhpcyBieSB1cHN0cmVhbSAuDQo+IA0KPiBJIHRoaW5rIHlvdSBjYW4gZG8gbWVkaWF0aW9uIGlu
IHlvdXIgaHlwZXJ2aXNvci4NCj4gDQo+IFdoZW4gdHJhcHBpbmcgc2V0X3N0YXR1cygpLCB0aGUg
aHlwZXJ2aXNvciB3aWxsIG5vdCByZXR1cm4gdW50aWwgaXQNCj4gcmVhZHMgMCBmcm9tIHRoZSBo
YXJkd2FyZT8NClllcyDvvIx5b3UgYXJlIHJpZ2h077yMd2UgdHJpZWQgaXQgYWxzby5idXQgaXQg
bWF5IGJsb2NrIHJlYWQgc3RhdHVzIGZvciBhIGxvbmcgdGltZS4NCkFuZCBvY2N1ciBzb2Z0bG9j
ay4NCg0KPiANCj4gVGhhbmtzDQo+IA0KPiA+ID4NCj4gPiA+IFRoYW5rcw0KPiA+ID4NCj4gPiA+
ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJt
aWNyby5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Bj
aV9sZWdhY3kuYyB8IDQgKysrLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYw0KPiBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19w
Y2lfbGVnYWN5LmMNCj4gPiA+ID4gaW5kZXggMjI1N2YxYjNkOGFlLi5mMmQyNDE1NjNlNGYgMTAw
NjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMNCj4g
PiA+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYw0KPiA+ID4gPiBA
QCAtMTQsNiArMTQsNyBAQA0KPiA+ID4gPiAgICogIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+DQo+ID4gPiA+ICAgKi8NCj4gPiA+ID4NCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51
eC9kZWxheS5oPg0KPiA+ID4gPiAgI2luY2x1ZGUgImxpbnV4L3ZpcnRpb19wY2lfbGVnYWN5Lmgi
DQo+ID4gPiA+ICAjaW5jbHVkZSAidmlydGlvX3BjaV9jb21tb24uaCINCj4gPiA+ID4NCj4gPiA+
ID4gQEAgLTk3LDcgKzk4LDggQEAgc3RhdGljIHZvaWQgdnBfcmVzZXQoc3RydWN0IHZpcnRpb19k
ZXZpY2UgKnZkZXYpDQo+ID4gPiA+ICAgICAgICAgdnBfbGVnYWN5X3NldF9zdGF0dXMoJnZwX2Rl
di0+bGRldiwgMCk7DQo+ID4gPiA+ICAgICAgICAgLyogRmx1c2ggb3V0IHRoZSBzdGF0dXMgd3Jp
dGUsIGFuZCBmbHVzaCBpbiBkZXZpY2Ugd3JpdGVzLA0KPiA+ID4gPiAgICAgICAgICAqIGluY2x1
ZGluZyBNU2ktWCBpbnRlcnJ1cHRzLCBpZiBhbnkuICovDQo+ID4gPiA+IC0gICAgICAgdnBfbGVn
YWN5X2dldF9zdGF0dXMoJnZwX2Rldi0+bGRldik7DQo+ID4gPiA+ICsgICAgICAgd2hpbGUgKHZw
X2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYpKQ0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgbXNsZWVwKDEpOw0KPiA+ID4gPiAgICAgICAgIC8qIEZsdXNoIHBlbmRpbmcgVlEvY29uZmln
dXJhdGlvbiBjYWxsYmFja3MuICovDQo+ID4gPiA+ICAgICAgICAgdnBfc3luY2hyb25pemVfdmVj
dG9ycyh2ZGV2KTsNCj4gPiA+ID4gIH0NCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4yNS4xDQo+ID4g
PiA+DQo+ID4NCg0K
