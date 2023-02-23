Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A16A130C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBWWv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBWWvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:51:54 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2068.outbound.protection.outlook.com [40.107.100.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2B058B70;
        Thu, 23 Feb 2023 14:51:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E66/cesbyy2pWTqN1PDAJbYzi052Y9L+HTgxPtJ0OS0D6+nJLnDu/FubhudKz6/J+6mfvOAYPJh9nz5j/MO5IePuLCaW34/9KgGCdbGX8VTGDsdYpUVcGCwZh8Zk5FNz3gu9GrQunPSQ2lwATNuGNNaEvtu5SHuCrHofDNIbfdqH1OSYuJXWj3A8D3uw+e6C4RaiArD5PKi6XaX3rgWkNoMcKbIw/K1nzdLpOWszAvyAlaed3tgDD4VNMH7cxq6Bis2M7AW9lbouDuQf59f9Xx8z8bweSPdnPhRZZVuDHJS3wPZa5Tvtmnv8O8BfiC/ff90Eg64SbNAp5DMlDXy0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8V0oaNtw/wBTi7KY9WB0eyS+I7+r3oJv8j/CAVRLx8=;
 b=BHJ2Jk9ICPALknffv8Pa0u28gEPhjBkbmzesMLJ6qnozPLogoND/rcozspT4cBv2syGzlLV0Wf0UgvdtREOv4tsNTiXK+HouKOISugU7EWu4uG9a+o8eBSKbEfG6iKVfNf3HGEo4le0hviA01TzF+CISJWCHmW75YI8UD3F8EYtiobjegRiEZ8NOQLCX7OswUY/PXw74hhZjTx60zMokhbAf0mTZJ+7BG0NJTP3aGp4aP43gkSmyYzLz6J9UCqe725KoNkPGY/nZfAQDlbLmHQTV6s0LYGAx5HFQzDesZRLJB1LqY38HW1OCMw2i+rnumblhy9ft8Uq16e4OymNYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8V0oaNtw/wBTi7KY9WB0eyS+I7+r3oJv8j/CAVRLx8=;
 b=RogODMCeOV0afal1IJs8XwPz4A5ArJiFKgMaouYqpiYcSXqVdiM2rPhybpy8Hu43+e4/ekuzhS8O0KxBc8Pk6dwgN/4Rh9TcqSe/8hpyMuSvYJl56SU5ExdJetoYJuY11K52Db/cbC6Qjg3YFz9Sh5Y++RdrIBRGlXEL2S3xQkiGJYbClDcFem6BVAYh04uRHnYopw4o1i4KPHr4oGjPwbvfyXZ+QlFs9PvoIWVE5+ya6DYjl61t8PoyVLlOXaojjB9RGvwKMR6tKrqTr1L1z0imWHZtWKKiXbdREgZmEuHn/0LteaAOC91A3crueBoD8YeFaDwLRMcqTzshasFdJw==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 22:51:51 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 22:51:50 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
Thread-Topic: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
Thread-Index: AQHZQxaSlkLDlqQj4USzupFOvdT5/67TwvwAgAeH+DCAARyQgIAAhNPAgAAP7gCAAC3a0A==
Date:   Thu, 23 Feb 2023 22:51:50 +0000
Message-ID: <CH2PR12MB389530C5929100CB54396CF5D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <cover.1676668853.git.asmaa@nvidia.com>
 <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
 <CAHp75VdeVpjzg5Y_4Y+Ke9=3wog28vUBN4Fd8zxfa8dWGrqUUA@mail.gmail.com>
 <CH2PR12MB3895520749883D912E5021F1D7AA9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75Vc+iSt2XvpOYzwZnzX7Qg013e-E27CPjPaO-QmtferWVg@mail.gmail.com>
 <CH2PR12MB389509F68E6AFE776C5B0AC6D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VdoUDMvVk1uMQcAKQteL6gbYGpoKpFn96ysdS81LjPGCQ@mail.gmail.com>
In-Reply-To: <CAHp75VdoUDMvVk1uMQcAKQteL6gbYGpoKpFn96ysdS81LjPGCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|DM6PR12MB4044:EE_
x-ms-office365-filtering-correlation-id: b44cf59e-e64a-40c4-c32a-08db15f08d37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gh4EfET1sJPzGT2L2ckS+UT00Wvr19xGdsyhtuX/egDiz+1wnozC/b7USo5UHd5QxNBZsVjNdp/hQtvbyXlW7smMaC4M3Dna5gDAjX/olXIQpi0VIOPVHQ/RvzT6zM746ElQ/H8/ZBrX77JRogyiaBJknKnVp6Oa6Fff2zfjNUjlHEqxC2gQWbQFXKlOMuMMBjfQlIIM6HQ3nBLHVNzUf8ohZA+QbIZaSl3uinti5XEODNCT7Sbx8eITmaceu3Xf8eUcuvNdq1XHCfpFvvFemryzQ0TOsrcK2FghCKZB3dtCb/QuYWVfzoHSH+odfM8jmTcAAldF0ziLAwXF6J++0VJaQxBgbSNhwKBez1yb+g85c8Q9lnXGFiiRB/sPe0pRSl1747pmhhVPvw9TgzfTF6UKmsaxm268geZ+Brub5nrs1W5Q+BW7ul+mYbgv5kOmdZOR+uJS+NG1WyB6WdQza0gg7Om4iJDpIYoWazcfmm1J0PYO0ILADMrEl5sTvtiyeN2p8jAg995EqP+bNhrAeSx0Prpk6P/7fDtlTxOGlNTpBH4rHEW3Zwr6ayO4eMjlngcL6vSFHwVjf/vGECuRwpDGD6L8mqRY9cy6Zebj4MBaUI/TUzFRgjTIKyAXe1ccR+XnuJTBsQPeLthrV79tSqwxSRsa7ZA4n/fTDP8vDNlrmzqqiUkr2JiUZWdVypSL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199018)(2906002)(5660300002)(9686003)(478600001)(71200400001)(83380400001)(38070700005)(86362001)(54906003)(6506007)(186003)(122000001)(26005)(38100700002)(316002)(4326008)(6916009)(8676002)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(8936002)(52536014)(7696005)(41300700001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEpZcS9aV0ZQMG90OEpXdmhXajByUHdMYzlxVFBPNlJXb1hRaVU2NUx3Y1Rp?=
 =?utf-8?B?bGN3MkVQM3hQbkYza3d4aWVIWEloZmJnVFZQTHY4RjcyRVFuQWZ1M3JpaWhH?=
 =?utf-8?B?S3RJUGloQVAxZ0tVQlpUbjIwb3RjWEdZdDcvMGtOL3BRZklGUFI5RXhRZXBD?=
 =?utf-8?B?U3lMTmo4QmhDZVNWVysxNnRmZ0lRQ2VVYjZIdG1CcSthMys3QXdCNE4wYmhY?=
 =?utf-8?B?UmRMc0FtZzZaK2tCaDJZckZwWnlKL2lSZVhXcDV5K0luN2RId3V3Tk5FVXRG?=
 =?utf-8?B?OEpFeVNOc1VYcm5GR2Rzb3dZK1lPM3Z2UUJCMXVNQStEVWgrbVZRelZZQ2tu?=
 =?utf-8?B?aVB3WkN3anZBRUNFa0tJK1FLY3FmZUlJZVI3TlFrRkdRR1JTbyt2WDBzdVFq?=
 =?utf-8?B?aGw0UDhWcUc4V2w3L0lMNmtrQjBUaXF5UXJ3TlphODdkaEZucUQwT3U3SW9F?=
 =?utf-8?B?WEUwTUpnMXRUb0NEdkIvTmpnZE5ZRHdtTFM3Rk51Y0pQMlpkTU01cXFGMUxp?=
 =?utf-8?B?RmV4VktINlpQdWhYd05lcDlQOTdKd0FEZ0FiSFprK20rUHdmajk3K21lV2Yr?=
 =?utf-8?B?RVpneWZWUjBnSUtaaGFKSHdFUUk0L0duTXU2YThhcXdIQklmOEwvaE5BWDJq?=
 =?utf-8?B?S2dwdnlBYkdVRVdvSVZVZldSNGZQVk10N3B5ZU5VT0VpMnhaWTJRTytWemRS?=
 =?utf-8?B?M0JIOS9uUHh3RkVvMHZhOEpzTzBHYXFVSFhIZStSMHJyNFRTSUxKYkhQcTFF?=
 =?utf-8?B?QmdVRHlNTFphcm9lcTVWeDdCWXA3WElLOXlRejE4bFFwazFWOCtQRFVERUh0?=
 =?utf-8?B?bExvcmRNNGtDSDNZQ1hRTG1JbGZoQU4weDhvWFc0UWJnWFl5MG4xVVl1Qm5M?=
 =?utf-8?B?cDdCU3loRlBmdlNPNmN0L0lHaHBrWTdHV0p0SGdtbjdRcG5JMk1xelJYTUFq?=
 =?utf-8?B?di91TGhmdU9HV2Fzd2JtakNiSXNqcm9XZFZnakp4cm1kQVRDQ2JoOGhHdU1I?=
 =?utf-8?B?NDE0b0t3YjZUMGVzeXkvNk5ZU2Z1ZldkK09hVWJ0c1hxRkRqMTZQUUVSNEk5?=
 =?utf-8?B?d2p5TFk1UDJKdTA5eUtxMy8vb1g1TUYwNWdFRTNERnFpODkwdURaREVWQ1pK?=
 =?utf-8?B?bWNSZE9TN0NjYVY4Z1lvSXlOeTNQUHJJRi85Rlp5V2g4N1hycmdwQ0xGbmN5?=
 =?utf-8?B?RzJvZ0hPQlBPNVFsVUVVcjFKNS9aSU56c3lSTWozNnFjTjd5clo3THV0cEt5?=
 =?utf-8?B?dlFoeW9yQWRrR2VjWjNXN3dXNXVFL2hNTjQwSXNmTURTS3ZCZ0lHeGgvQmxt?=
 =?utf-8?B?ay9FcVpoTndkUG9mWCt2dDNOd3QyZE56WjNyYnlXNUZlUStOT2VSS3IxU1g4?=
 =?utf-8?B?WG5DNExCYzlrd25Vb3FCK1h5S012bXFncWtIUWVGdW5RN2hSaWJGYzJoUkpC?=
 =?utf-8?B?ZHliUjZjMmdPcGJFTm5WV2JIeUkvaTJwRnpiZjN0S3Z5S1BCMlV3L2ZRd2pC?=
 =?utf-8?B?SENRL0cvdmxLMHBTeTIwdWFrSDN2QS85Vm85alVmWDkvZzIreTR5RkJOdzNJ?=
 =?utf-8?B?eUxxbEhub3QxK3pmbld5UHY0dVZZZ21ENElzOTIveERoekVJQzdjTXdVdWtS?=
 =?utf-8?B?MzdOemRKcVlxcFp6eTQ4ODFmNnkvYVdiRDI2Z0lmeHVKZnZ5VG8wR240VnRG?=
 =?utf-8?B?ME1Da3JhN2xTZWlWWWcyQ1gzTGtsVlgwN3VpVjVVelM5Znk2M2FWeXpRMVlB?=
 =?utf-8?B?ZlJCNSt4ZWtQNm1xUk43TFY2aXhUL2pRbmJJVWJLTGVWMlNNQXUxYjFGWnhi?=
 =?utf-8?B?SHlWUU92Wmw5UWRMbE51aWRKSi93S2twN1BiMlVqVitoVFlmZ1BxZVdvak9p?=
 =?utf-8?B?VTUyVHlDbHBjcDF1ZjYyd0NRYzV2ZVhGbEsvcTlzS2hnQ29idFJ6UGFldzVO?=
 =?utf-8?B?QXRCTTJaSkxHcklXa2VIREpnS2xxdHhJTmFCSHlQMWpyVlkxcW9meCsxU3Ry?=
 =?utf-8?B?eEh1OHEweTkyWFpJZ3F3ZWZwMEI5UUVrK0xDVCs1M2wrRlpvWU5ON1dLRVQx?=
 =?utf-8?B?MXhPNDEreXBOMm8zaHZLZ2VucThFdmRxS09ONmdPL3p4R3JId0Y5cVYxT1Iy?=
 =?utf-8?Q?h6IE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44cf59e-e64a-40c4-c32a-08db15f08d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 22:51:50.8477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xLkzxv4dE2yroKXXUz8+l+x74z9EC51UONcUXAuVsP9iWTjhrg1LkUa43btwzdaIBihRUmFKM+c3eTZJPNtAXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4NCj4gPiA+ID4gPiArICAgICAgIG5waW5zID0gTUxYQkYzX0dQSU9fTUFYX1BJTlNfUEVS
X0JMT0NLOw0KPiA+ID4gPiA+ICsgICAgICAgZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwg
Im5waW5zIiwgJm5waW5zKTsNCj4gPiA+ID4NCj4gPiA+ID4gSSBkb24ndCBzZWUgRFQgYmluZGlu
Z3MgZm9yIHRoaXMgcHJvcGVydHkgKGJlaW5nIGFkZGVkIGluIHRoaXMNCj4gPiA+ID4gc2VyaWVz
KS4gSXMgaXQNCj4gPiA+IGFscmVhZHkgZXN0YWJsaXNoZWQgb25lPw0KPiA+ID4gPg0KPiA+ID4g
PiBBaCB0aGF04oCZcyBteSBiYWQuIFRoZSBwcm9wZXJ0eSBzaG91bGQgYmUgY2FsbGVkICJuZ3Bp
b3MiIGxpa2UgaW4NCj4gPiA+ID4gdGhlIERUDQo+ID4gPiBkb2N1bWVudGF0aW9uLiBXaWxsIGZp
eC4NCj4gPiA+DQo+ID4gPiBBbmQgd2h5IGRvIHlvdSBuZWVkIGl0PyBXaGF0J3MgYSBjb3JuZXIg
Y2FzZSB0aGF0IHRoZSBHUElPIGxpYnJhcnkNCj4gPiA+IGRvZXNuJ3QgaGFuZGxlIHlldD8NCj4g
Pg0KPiA+IFdlIGhhdmUgMiBncGlvY2hpcHMsIGdwaW9jaGlwIDAgc3VwcG9ydHMgMzIgZ3BpbyBw
aW5zIGFuZCBncGlvY2hpcCAxDQo+IHN1cHBvcnRzIG9ubHkgMjQgcGlucy4NCj4gPiBJZiBJIHJl
bW92ZSB0aGUgbG9naWMgZnJvbSBncGlvLW1seGJmMy5jLCB0aGUgZ3Bpb2xpYi5jIGxvZ2ljIHdp
bGwgY29ycmVjdGx5IHNldA0KPiB0aGUgbmdwaW9zID0gMzIgZm9yIGdwaW9jaGlwIDAgYnV0IHdp
bGwgd3JvbmdseSBzZXQgbmdwaW9zPTMyIGZvciBncGlvZ2NoaXAgMToNCj4gDQo+IFNvLCBlaXRo
ZXIgeW91IG5lZWQgdG8gaGF2ZSB0d28gZW50cmllcyBpbiBEVCBwZXIgY2hpcCBvciBuZ3Bpb3Mg
c2hvdWxkIGJlIDU2Lg0KPiANCkkgYWxyZWFkeSBoYXZlIDIgZW50cmllcyBpbiBteSBBQ1BJIHRh
YmxlLCBpbiB0aGUgZmlyc3QgZW50cnksIG5ncGlvcyA9IDMyIGFuZCBpbiB0aGUgc2Vjb25kIGVu
dHJ5IG5ncGlvcyA9IDI0Lg0KR3Bpb2NoaXBfYWRkX2RhdGFfd2l0aF9rZXlzIG9ubHkgcmVhZHMg
dGhlIG5ncGlvcyBwcm9wZXJ0eSBpZiAobmdwaW9zID09IDApIHdoaWNoIGlzIG5vdCB0aGUgY2Fz
ZSB3aGVuIA0KYmdwaW9faW5pdCBpcyBjYWxsZWQuIGJncGlvX2luaXQgdXNlcyAic3oiIGFyZ3Vt
ZW50IHRvIHBvcHVsYXRlIHRoZSBuZ3BpbyBpbiBiZ3Bpb19pbml0LCB3aGljaCBpcyBub3Qgd2hh
dCB3ZSB3YW50Lg0KDQoNCg0K
