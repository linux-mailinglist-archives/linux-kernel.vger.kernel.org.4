Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C3A72DAC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjFMH1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbjFMH1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:27:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7CE7B;
        Tue, 13 Jun 2023 00:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686641248; x=1718177248;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=R+bRKKW4M6XPap97UH1tpgP0YYwufY/u/Xrh6MMai40=;
  b=OtG0jPLlCEUTMfwuXjDlVKHhtiqmJEJexMKQ8Yx95kddRv2uN3HvvBCQ
   R0R37b4vsB98xgtAgKCA6D2o916XAE0sjjD9l/1U2zyshHZTT9uI3FhCt
   guWtQd4kugeDXrmCkqtrcq9BxKx14KZgkGIJ9t544sDFpXeapOGUv88um
   RfpWd0xaOElVxdHstN4Cj+uf9TNx60NoS+bR5lpHNbZYIfAGNdGaCnr5G
   fs2Z6USWnHuMfuzZ3cdlQLpEHmSUrT/3fW4m/7s2seMKDmujTFfVxx+RK
   kGoPrmZvk14fYk1JA/4/w0SlgNQwlU4VSYIeWQ6q3aMbeGjIdEPA7DgVN
   A==;
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="218186382"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2023 00:27:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 13 Jun 2023 00:27:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 13 Jun 2023 00:27:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaXsj3xHPJI9gn/cp5dXR2S+dp4kXreNJqcOgghRro1zO9wpTgFBJXFw8OXNw1++fXyErR5XPwzu4cwQZt4Rwq4TDgYXzBy6w97oyjNsryxhDbJP5MBERLGXiHU0VhRbZZ3eKSgVEBnWVSdmYoYcMtuvuVEtk5YyQ/IPDdHUd0rZTzKkN+w+PdxXpQ4PQ3Gemszk5iBKDB6X5sxHbBeGDXpE7Zo1LG+WEFexvaBfNcZWgsSOvCqPxpEaGbn2fdWGAikn4o5SDTuV59BjfHqULasyJoUrL+zeJkLIztbkNe33luNAnsEc54zk+7b8JkJ/sznINOBVYqKAf0gR7I1eTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+bRKKW4M6XPap97UH1tpgP0YYwufY/u/Xrh6MMai40=;
 b=klGeHkpMvaOxhZE4raZCBXjcD4v17kJlIZO/QFBXYSD4jL8B8M+kFSP8a6/tyZ5s4QlFsmWJoyfNMXyFdux1EdTAZdwPoVvKnre8wRVJMCdBA8M/FjyZsPKQCWpBM+O6YrOR7HWzlFQVlhoSIEvYj9l7Gug8qrleUPpk0IbkX6PirLjkvt5Qf4w6K+HT+IyRlSa5td3V2PVuuEB4ec1UbRd+CXVsBHYoxp7YzxZb4PwQ8algis3Jsj9ifPv4KgnzUpYSV21B0DNHbx9Rx+/gMOXKp3+3e48O4VgvCBOyFt4Kp2KMNBsl4NU8v+trhd4X67rxM8voSsriBbsb4VvVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+bRKKW4M6XPap97UH1tpgP0YYwufY/u/Xrh6MMai40=;
 b=FBNsngJTp3v4wvoGXG2i6qJUsZkR7mHAynykdepcUSX0+57MczY1z8/TINVa21P8wuM7rgGTWseQ4g3vUyePXB5vL7bLIgakWEzb4+1ZMCX6PTQ1McXGChzsDaIdRVSWJFcx7X/RM98EArSM4oynYIDqyEBMa36zVb89MJvghnk=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by DM4PR11MB6455.namprd11.prod.outlook.com (2603:10b6:8:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 07:27:11 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6433.024; Tue, 13 Jun 2023
 07:27:11 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <maso.huang@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <trevor.wu@mediatek.com>,
        <jiaxin.yu@mediatek.com>, <renzhijie2@huawei.com>, <arnd@arndb.de>,
        <allen-kh.cheng@mediatek.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 2/7] ASoC: mediatek: mt79xx: support audio clock control
Thread-Topic: [PATCH 2/7] ASoC: mediatek: mt79xx: support audio clock control
Thread-Index: AQHZnch3OJpCsq9enEaYLBxF4PLHTQ==
Date:   Tue, 13 Jun 2023 07:27:11 +0000
Message-ID: <6fde0597-a4f4-8f22-fc31-bc8bef3296d8@microchip.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
 <20230612105250.15441-3-maso.huang@mediatek.com>
In-Reply-To: <20230612105250.15441-3-maso.huang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|DM4PR11MB6455:EE_
x-ms-office365-filtering-correlation-id: 64ca039d-b17b-4666-a8a3-08db6bdf9a35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gjXA+F/k76FsAz0NR2tqJFbuvrylEk1DML90jgjXCf6ipAH6cqH24B7HnA3V96Z/b0al5sMRc0ulJelnM+Ws8oAhHdgv9uAZbMWNQeOfPo+6VrZxgaBZxyfVdjLVmW1fQTX2I7dZM1n18SFfaifOPfXa5wvViDSyETQJ8WRyao+DkvGhiQnGROPdRtqlVc3xJ1DMsakvZTfEvHEs8BkgY8wjpxf9qq8r3EQHiflssLpPhRZZGVA+RW81LnD2s6zugDAs6luArsiAolow81NkBMGdI3UumOHhysd8PyWd5CXSATuShR4QIwnmFMRax17huFk+kbitQN/uyU+mBxxjSeoJxR8u65eoEQJKyYWz9WNKQSGYO33gK4ycN20Z68kxvojUySJ/CfcvUlhtdt8ZJyWzZ6oDGFhNZWjdaCtZ5cN8JsN7NFr6eVdEY4yyYtFh5bl9irjOLMoJtpshFXmq0VwJrbIYcd+y5rrJJHJsiqSyUxI2voLgCEK3Gq/jjem3m2+isMPNVLQAvCqx9Fzglhd8J2PRFVUQdadlpiW5d5RscIWzeBpSdVOHLMHmuFft4ULYhUKr+wE5lOA+E6w+Lnt0h0HSzxUjyqgANPBCqMw0NxqJ8usFC9TObvv+NM4BTju8gWh6gF8GRswgLUdAQmSG6drAdEzlnK03+LGsJYr6x0tfmMSWnzHl8nOzfKU3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(966005)(316002)(6486002)(41300700001)(2616005)(31696002)(186003)(7416002)(6512007)(38070700005)(6506007)(26005)(83380400001)(2906002)(122000001)(921005)(38100700002)(53546011)(86362001)(5660300002)(8936002)(36756003)(8676002)(66946007)(64756008)(66476007)(76116006)(66446008)(66556008)(91956017)(478600001)(110136005)(31686004)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWFKUE5aZmFGZTR3Uld4eEdKNldmS08wak5HQ3lKai9JczNqNUNjQUcwd3dr?=
 =?utf-8?B?T0RIRXF3SVFMTXBjbjBYR0lYczJuNTJPOFVwbHI4UnYvOFROQlQ0aTg0UHZy?=
 =?utf-8?B?cm1hbUhtaXpBRnNMaEE3MEZGL3Y1dUFGaTNrczI0NVllRHNBRDRjVWxHRWM4?=
 =?utf-8?B?WkhTamlKUlZoL2RaamVnNkdkNmZCbEpNblNpaDh6NnUxZVJYRVYrek4yUGY0?=
 =?utf-8?B?eXVpR2Z1MzZjWEtkcDlBTTdSaU9FTEpzWFBGSWdMT3d5NjdRR0JwcUN4TXBF?=
 =?utf-8?B?Zk9NQkxFcWI5T0VIbUFQd09iZ2NsNWFsUFJGL3NFOFhTeXpid3RObDFzK1Jw?=
 =?utf-8?B?Rm9YZnBxbG1LNWNsUlBsa3VkL0dITEM2TnVrdnRuS3FjaHpwMHNlemNRNTNz?=
 =?utf-8?B?c1k4cjdRT0VXTGFKaEgyMCt6NUdoNTZUTldpVmF6M1lxYjgwQmp0ZHBGSnpG?=
 =?utf-8?B?VTFDSzR6eGtNbTBBQ2c4am15bE5nemRGUnZBd242SUsxQ01UdTFxZThkWXA5?=
 =?utf-8?B?dzhCNWt6RDRUV3lGTW9QTjAwdW9rQmo0RFN1VDJwR3d2S1BqUVo5U1A1b2Nn?=
 =?utf-8?B?ZFZvMlBSNjdpYXFmNW1xakhMVEM3enZmdlRmNFcwYXNnSDJaZ2lFam1CZ2pq?=
 =?utf-8?B?cm5wb1dZN3RMaTRmMlp1d25Yd2NGa2NqdXljSlcwak8rL28wUjlHYXRsa2Fw?=
 =?utf-8?B?bVUvbU53eDBsR2dqQ3l1VzdpSHREakw3T1VJcmtUS1Ard1dUNmtKbkthbCtM?=
 =?utf-8?B?cUFzU3lDenA0alNMdFc2djBKUDI0VDZTVEtBMndFVDN1eHhoM1hUeVJNZzBN?=
 =?utf-8?B?MVlDai83dnhSWVBpZEU1SUYzRTN3TU5yaDdiZ2FLQTFxTyt1YWIxZ1R3M0tW?=
 =?utf-8?B?WmM5RmE3M1ZhdXBhUDZNVUorWnFUZkNHZ1R3bnowSzBZSnlwMWhHNGtuMHUz?=
 =?utf-8?B?dDNZWWVJczUrMDhPSkVjUHpOWDFvRzFVT3JJVU1iZGhRcElrQ0RwWVNOY3dC?=
 =?utf-8?B?RFQzS1FKWVU5elltbzNacnR2K2ZXRDhkUFdUWHFFWnFzWmY1OC9TZkRBSnlR?=
 =?utf-8?B?NUxXNjIyN1hrOTY1TWZSRjFRSzlkblhQL2lJblZhRUhKdGpCUmRpeDhYNk5L?=
 =?utf-8?B?ZmpGOXhQRHc3dDFYVURvWmNlT3R0Ri9pMW9wMDFNWUlqUEZuUTd2S3pha2lW?=
 =?utf-8?B?MHVwdGp4TGJNOU9LeVBpN1JOR0tVV2xsSU5MdWNGNUFydFloOWR6dnJERlVQ?=
 =?utf-8?B?aEFkV1c3M1V3dmlpRy9WRjVCbkRwOUZQL3NPV2RoWitsM3MvUHZhQk9ybU5x?=
 =?utf-8?B?OTZkRnJBUSt0RnI4SGhCem5Pa0JXMGFpSkJmbnowdGZtS1NHYVRTT0xiOWVF?=
 =?utf-8?B?VEg5ZmFEdWtibmZsQVh6eEhJcXpyQ3I4a3dmZ0ZjQmhqY3R5QmdXMi9ycStw?=
 =?utf-8?B?TU9OeExsWTFnWTVraGNUYTkwamsxNVBuRDI2YXZqOXRLamlnMDhSY09JY0NU?=
 =?utf-8?B?azZYYk54eHdrbHMrVTd2dS9UYUFVc0VCajNndmtxNmNMQzFIcVZCUzhhdTZz?=
 =?utf-8?B?SldrN05kZWs2M1RrSWJPaE9XNVo3U293NDdVUzd3cnVGRHJYRUVCeFhEdDlH?=
 =?utf-8?B?Y3NKa0lTczNpNFUrYWd3TEhDOE92aFNDWE5qY29LK2hkMVJDbU5pRk8rTU9J?=
 =?utf-8?B?SEVVMzB4ZSs2MW4xNXpGMHZzb2ZoT2FkdldRTGZjN3J5elhMTHI3ZHVER1kw?=
 =?utf-8?B?bEVoV3NnYVI5a2liTzA5dXE2anNpYkJFV0FCTVovLzVaSWdrd1RuUUpYblY5?=
 =?utf-8?B?RnlKd0c4R0pLRW4wTEVvRFYxU3NZWTRTZXdybUYrM2Izb0NJaVNrbUJza2VJ?=
 =?utf-8?B?czc4bFdjOEtRUU9rc1lkbUZXZXNFQ3BDMlVwV3FXUG5KUWdMRmk2WEtodXM3?=
 =?utf-8?B?T3U2Wm5iSHA3WEx5SXNsczZqWHYzSmxyd1gxMkI3MGZhZXlFR3p2ZUx6ZDZn?=
 =?utf-8?B?bXdoNkxpRE1Ld3hGZFhlcndrblE1YlBBTDJSZmtOVUxjOVlEZjF2R2dsZnBp?=
 =?utf-8?B?WlpWNmo1TVEweFJBdlM3VVVldklOQmtrbEp3dGlXVm5tK09IVDFwWUk1K1Vi?=
 =?utf-8?Q?oZ8s7sVLo2Zt3vOYfCOGhi5HO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D3B5D903CD78E4D8C67B838486A5A98@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ca039d-b17b-4666-a8a3-08db6bdf9a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:27:11.1546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u6VHTVCy/eZPe7gcLYWq0Ww6Pdz4DldMbXcgTXLqWlGPPEuCONPt/ciAWXb/KFXLLexafZM5ukEwNEZ2wk++egohG5/pEp0DxiFpgRwor3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6455
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDYuMjAyMyAxMzo1MiwgTWFzbyBIdW5hZyB3cm90ZToNCj4gW1lvdSBkb24ndCBvZnRl
biBnZXQgZW1haWwgZnJvbSBtYXNvLmh1YW5nQG1lZGlhdGVrLmNvbS4gTGVhcm4gd2h5IHRoaXMg
aXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNh
dGlvbiBdDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZy
b206IE1hc28gSHVhbmcgPG1hc28uaHVhbmdAbWVkaWF0ZWsuY29tPg0KPiANCj4gQWRkIGF1ZGlv
IGNsb2NrIHdyYXBwZXIgYW5kIGF1ZGlvIHR1bmVyIGNvbnRyb2wuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBNYXNvIEh1YW5nIDxtYXNvLmh1YW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBzb3Vu
ZC9zb2MvbWVkaWF0ZWsvbXQ3OXh4L210Nzl4eC1hZmUtY2xrLmMgfCAxMjMgKysrKysrKysrKysr
KysrKysrKysrDQo+ICBzb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OXh4L210Nzl4eC1hZmUtY2xrLmgg
fCAgMTggKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE0MSBpbnNlcnRpb25zKCspDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgc291bmQvc29jL21lZGlhdGVrL210Nzl4eC9tdDc5eHgtYWZlLWNsay5j
DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgc291bmQvc29jL21lZGlhdGVrL210Nzl4eC9tdDc5eHgt
YWZlLWNsay5oDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL21lZGlhdGVrL210Nzl4eC9t
dDc5eHgtYWZlLWNsay5jIGIvc291bmQvc29jL21lZGlhdGVrL210Nzl4eC9tdDc5eHgtYWZlLWNs
ay5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uZjAwZjBk
N2RlODYxDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvc291bmQvc29jL21lZGlhdGVrL210Nzl4
eC9tdDc5eHgtYWZlLWNsay5jDQo+IEBAIC0wLDAgKzEsMTIzIEBADQo+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyoNCj4gKyAqIG10Nzl4eC1hZmUtY2xrLmMgIC0t
ICBNZWRpYVRlayA3OXh4IGFmZSBjbG9jayBjdHJsDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChj
KSAyMDIxIE1lZGlhVGVrIEluYy4NCj4gKyAqIEF1dGhvcjogVmljIFd1IDx2aWMud3VAbWVkaWF0
ZWsuY29tPg0KPiArICogICAgICAgICBNYXNvIEh1YW5nIDxtYXNvLmh1YW5nQG1lZGlhdGVrLmNv
bT4NCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ICsNCj4gKyNpbmNs
dWRlICJtdDc5eHgtYWZlLWNvbW1vbi5oIg0KPiArI2luY2x1ZGUgIm10Nzl4eC1hZmUtY2xrLmgi
DQo+ICsjaW5jbHVkZSAibXQ3OXh4LXJlZy5oIg0KPiArDQo+ICtlbnVtIHsNCj4gKyAgICAgICBD
S19JTkZSQV9BVURfQlVTX0NLID0gMCwNCj4gKyAgICAgICBDS19JTkZSQV9BVURfMjZNX0NLLA0K
PiArICAgICAgIENLX0lORlJBX0FVRF9MX0NLLA0KPiArICAgICAgIENLX0lORlJBX0FVRF9BVURf
Q0ssDQo+ICsgICAgICAgQ0tfSU5GUkFfQVVEX0VHMl9DSywNCj4gKyAgICAgICBDTEtfTlVNDQo+
ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3QgY2hhciAqYXVkX2Nsa3NbQ0xLX05VTV0gPSB7DQo+
ICsgICAgICAgW0NLX0lORlJBX0FVRF9CVVNfQ0tdID0gImF1ZF9idXNfY2siLA0KPiArICAgICAg
IFtDS19JTkZSQV9BVURfMjZNX0NLXSA9ICJhdWRfMjZtX2NrIiwNCj4gKyAgICAgICBbQ0tfSU5G
UkFfQVVEX0xfQ0tdID0gImF1ZF9sX2NrIiwNCj4gKyAgICAgICBbQ0tfSU5GUkFfQVVEX0FVRF9D
S10gPSAiYXVkX2F1ZF9jayIsDQo+ICsgICAgICAgW0NLX0lORlJBX0FVRF9FRzJfQ0tdID0gImF1
ZF9lZzJfY2siLA0KPiArfTsNCj4gKw0KPiAraW50IG10Nzl4eF9pbml0X2Nsb2NrKHN0cnVjdCBt
dGtfYmFzZV9hZmUgKmFmZSkNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgbXQ3OXh4X2FmZV9wcml2
YXRlICphZmVfcHJpdiA9IGFmZS0+cGxhdGZvcm1fcHJpdjsNCj4gKyAgICAgICBpbnQgaTsNCj4g
Kw0KPiArICAgICAgIGFmZV9wcml2LT5jbGsgPSBkZXZtX2tjYWxsb2MoYWZlLT5kZXYsIENMS19O
VU0sIHNpemVvZigqYWZlX3ByaXYtPmNsayksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBHRlBfS0VSTkVMKTsNCj4gKyAgICAgICBpZiAoIWFmZV9wcml2LT5jbGspDQo+
ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArICAgICAgIGZvciAoaSA9
IDA7IGkgPCBDTEtfTlVNOyBpKyspIHsNCj4gKyAgICAgICAgICAgICAgIGFmZV9wcml2LT5jbGtb
aV0gPSBkZXZtX2Nsa19nZXQoYWZlLT5kZXYsIGF1ZF9jbGtzW2ldKTsNCj4gKyAgICAgICAgICAg
ICAgIGlmIChJU19FUlIoYWZlX3ByaXYtPmNsa1tpXSkpIHsNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgZGV2X2VycihhZmUtPmRldiwgIiVzKCksIGRldm1fY2xrX2dldCAlcyBmYWlsLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCAlbGRcbiIsIF9fZnVuY19fLCBhdWRf
Y2xrc1tpXSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQVFJfRVJSKGFmZV9w
cml2LT5jbGtbaV0pKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIo
YWZlX3ByaXYtPmNsa1tpXSk7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgfQ0KDQpZ
b3UgY2FuIHVzZSBkZXZtX2Nsa19idWxrX2dldCgpDQoNCj4gKw0KPiArICAgICAgIHJldHVybiAw
Ow0KPiArfQ0KPiArDQo+ICtpbnQgbXQ3OXh4X2FmZV9lbmFibGVfY2xvY2soc3RydWN0IG10a19i
YXNlX2FmZSAqYWZlKQ0KPiArew0KPiArICAgICAgIHN0cnVjdCBtdDc5eHhfYWZlX3ByaXZhdGUg
KmFmZV9wcml2ID0gYWZlLT5wbGF0Zm9ybV9wcml2Ow0KPiArICAgICAgIGludCByZXQ7DQo+ICsN
Cj4gKyAgICAgICByZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoYWZlX3ByaXYtPmNsa1tDS19JTkZS
QV9BVURfQlVTX0NLXSk7DQo+ICsgICAgICAgaWYgKHJldCkgew0KPiArICAgICAgICAgICAgICAg
ZGV2X2VycihhZmUtPmRldiwgIiVzKCksIGNsa19wcmVwYXJlX2VuYWJsZSAlcyBmYWlsICVkXG4i
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgYXVkX2Nsa3NbQ0tfSU5GUkFf
QVVEX0JVU19DS10sIHJldCk7DQo+ICsgICAgICAgICAgICAgICBnb3RvIENLX0lORlJBX0FVRF9C
VVNfQ0tfRVJSOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHJldCA9IGNsa19wcmVwYXJl
X2VuYWJsZShhZmVfcHJpdi0+Y2xrW0NLX0lORlJBX0FVRF8yNk1fQ0tdKTsNCj4gKyAgICAgICBp
ZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGFmZS0+ZGV2LCAiJXMoKSwgY2xr
X3ByZXBhcmVfZW5hYmxlICVzIGZhaWwgJWRcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IF9fZnVuY19fLCBhdWRfY2xrc1tDS19JTkZSQV9BVURfMjZNX0NLXSwgcmV0KTsNCj4gKyAgICAg
ICAgICAgICAgIGdvdG8gQ0tfSU5GUkFfQVVEXzI2TV9FUlI7DQo+ICsgICAgICAgfQ0KPiArDQo+
ICsgICAgICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGFmZV9wcml2LT5jbGtbQ0tfSU5GUkFf
QVVEX0xfQ0tdKTsNCj4gKyAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICBkZXZf
ZXJyKGFmZS0+ZGV2LCAiJXMoKSwgY2xrX3ByZXBhcmVfZW5hYmxlICVzIGZhaWwgJWRcbiIsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBhdWRfY2xrc1tDS19JTkZSQV9BVURf
TF9DS10sIHJldCk7DQo+ICsgICAgICAgICAgICAgICBnb3RvIENLX0lORlJBX0FVRF9MX0NLX0VS
UjsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICByZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUo
YWZlX3ByaXYtPmNsa1tDS19JTkZSQV9BVURfQVVEX0NLXSk7DQo+ICsgICAgICAgaWYgKHJldCkg
ew0KPiArICAgICAgICAgICAgICAgZGV2X2VycihhZmUtPmRldiwgIiVzIGNsa19wcmVwYXJlX2Vu
YWJsZSAlcyBmYWlsICVkXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywg
YXVkX2Nsa3NbQ0tfSU5GUkFfQVVEX0FVRF9DS10sIHJldCk7DQo+ICsgICAgICAgICAgICAgICBn
b3RvIENLX0lORlJBX0FVRF9BVURfQ0tfRVJSOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAg
IHJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShhZmVfcHJpdi0+Y2xrW0NLX0lORlJBX0FVRF9FRzJf
Q0tdKTsNCj4gKyAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGFm
ZS0+ZGV2LCAiJXMgY2xrX3ByZXBhcmVfZW5hYmxlICVzIGZhaWwgJWRcbiIsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIF9fZnVuY19fLCBhdWRfY2xrc1tDS19JTkZSQV9BVURfRUcyX0NLXSwg
cmV0KTsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gQ0tfSU5GUkFfQVVEX0VHMl9DS19FUlI7DQo+
ICsgICAgICAgfQ0KDQpBbmQgY2xrX2J1bGtfcHJlcGFyZV9lbmFibGUoKSBpbnN0ZWFkIGFsbCB0
aGVzZS4NCg0KPiArDQo+ICsgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gK0NLX0lORlJBX0FVRF9F
RzJfQ0tfRVJSOg0KPiArICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShhZmVfcHJpdi0+Y2xr
W0NLX0lORlJBX0FVRF9BVURfQ0tdKTsNCj4gK0NLX0lORlJBX0FVRF9BVURfQ0tfRVJSOg0KPiAr
ICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShhZmVfcHJpdi0+Y2xrW0NLX0lORlJBX0FVRF9M
X0NLXSk7DQo+ICtDS19JTkZSQV9BVURfTF9DS19FUlI6DQo+ICsgICAgICAgY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKGFmZV9wcml2LT5jbGtbQ0tfSU5GUkFfQVVEXzI2TV9DS10pOw0KPiArQ0tfSU5G
UkFfQVVEXzI2TV9FUlI6DQo+ICsgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGFmZV9wcml2
LT5jbGtbQ0tfSU5GUkFfQVVEX0JVU19DS10pOw0KPiArQ0tfSU5GUkFfQVVEX0JVU19DS19FUlI6
DQo+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKG10Nzl4
eF9hZmVfZW5hYmxlX2Nsb2NrKTsNCj4gKw0KPiAraW50IG10Nzl4eF9hZmVfZGlzYWJsZV9jbG9j
ayhzdHJ1Y3QgbXRrX2Jhc2VfYWZlICphZmUpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IG10Nzl4
eF9hZmVfcHJpdmF0ZSAqYWZlX3ByaXYgPSBhZmUtPnBsYXRmb3JtX3ByaXY7DQo+ICsNCj4gKyAg
ICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoYWZlX3ByaXYtPmNsa1tDS19JTkZSQV9BVURfRUcy
X0NLXSk7DQo+ICsgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGFmZV9wcml2LT5jbGtbQ0tf
SU5GUkFfQVVEX0FVRF9DS10pOw0KPiArICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShhZmVf
cHJpdi0+Y2xrW0NLX0lORlJBX0FVRF9MX0NLXSk7DQo+ICsgICAgICAgY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKGFmZV9wcml2LT5jbGtbQ0tfSU5GUkFfQVVEXzI2TV9DS10pOw0KPiArICAgICAgIGNs
a19kaXNhYmxlX3VucHJlcGFyZShhZmVfcHJpdi0+Y2xrW0NLX0lORlJBX0FVRF9CVVNfQ0tdKTsN
Cj4gKw0KDQpBbmQgYWxzbyBjbGtfYnVsa19kaXNhYmxlX3VucHJlcGFyZSgpIGhlcmUuDQoNCj4g
KyAgICAgICByZXR1cm4gMDsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKG10Nzl4eF9hZmVf
ZGlzYWJsZV9jbG9jayk7DQo+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OXh4
L210Nzl4eC1hZmUtY2xrLmggYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3OXh4L210Nzl4eC1hZmUt
Y2xrLmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi5iZjlj
M2VkYjY5MjINCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ3
OXh4L210Nzl4eC1hZmUtY2xrLmgNCj4gQEAgLTAsMCArMSwxOCBAQA0KPiArLyogU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gKy8qDQo+ICsgKiBtdDc5eHgtYWZlLWNsay5o
ICAtLSAgTWVkaWFUZWsgNzl4eCBhZmUgY2xvY2sgY3RybCBkZWZpbml0aW9uDQo+ICsgKg0KPiAr
ICogQ29weXJpZ2h0IChjKSAyMDIxIE1lZGlhVGVrIEluYy4NCj4gKyAqIEF1dGhvcjogVmljIFd1
IDx2aWMud3VAbWVkaWF0ZWsuY29tPg0KPiArICogICAgICAgICBNYXNvIEh1YW5nIDxtYXNvLmh1
YW5nQG1lZGlhdGVrLmNvbT4NCj4gKyAqLw0KPiArDQo+ICsjaWZuZGVmIF9NVDc5WFhfQUZFX0NM
S19IXw0KPiArI2RlZmluZSBfTVQ3OVhYX0FGRV9DTEtfSF8NCj4gKw0KPiArc3RydWN0IG10a19i
YXNlX2FmZTsNCj4gKw0KPiAraW50IG10Nzl4eF9pbml0X2Nsb2NrKHN0cnVjdCBtdGtfYmFzZV9h
ZmUgKmFmZSk7DQo+ICtpbnQgbXQ3OXh4X2FmZV9lbmFibGVfY2xvY2soc3RydWN0IG10a19iYXNl
X2FmZSAqYWZlKTsNCj4gK2ludCBtdDc5eHhfYWZlX2Rpc2FibGVfY2xvY2soc3RydWN0IG10a19i
YXNlX2FmZSAqYWZlKTsNCj4gKyNlbmRpZg0KPiAtLQ0KPiAyLjE4LjANCj4gDQo+IA0KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsDQoNCg==
