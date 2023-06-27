Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A921973F3A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 06:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjF0EqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 00:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjF0Ep3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:45:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4712722;
        Mon, 26 Jun 2023 21:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687841034; x=1719377034;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ynRnU+PgWx87Zcop5a0j0Q7PBYxqJ6bNjuOsbwfw7Ts=;
  b=QmkAk3xdEX3MXQ85tL35hdcpCH2+6qibNMQtxqy3Pt7DbILHqeZ+6kRk
   VQ0asQepqhH7a4UVoOIQ2ScQ93MR1TOHAjSZsda6VJW/q3HtclJNCWhg/
   onoVDBmvbG7HWkwbktFo8DdsNkeFR8F6envycFKTTLl7/4NtRn/6bq7XA
   nZ0dM7vWp7xKuP4UjyfJAS2yGfMWpnKDx2rJKxsGlHmAVAkqnjIuHZEs8
   pZhlJqGtRRP8Pg0qbPDlUkx7w173FQ26qA94vfwZsIvhafpHiXC2Dyava
   oOZtouZUoIpLdjvsqvDGxYrYlLsasFcukvEGJK0XIk+F5JnOqrQF8nwlC
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="232358372"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 21:43:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 21:43:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 26 Jun 2023 21:43:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM2vykR1LTeEvBu/3NVWS/cUglRTy+u89j4SzlqxCUm49wFIbuY9s1pcgR6UhQwheWZHHa+eZZ7rkj3SJT2Cy/51V8pGWeIcRK/y3DVUYZCkAvmqOlw3J7A6plbERTbJJy5T/tyskOMA2u0QlI/CPqlH6GkJ+0US8OyLSiD26xifo86QtyKxv3OqvtynuYe6u9rP8CAnYVhCZ4kVJRHMtCXCttFz5xO6cHf6QP7WpHRysTyjrbUPkjaH9g5BQ1qeqqJG+/XdF9E0PVQaTeNigqfjOvvynwXAYInLIgy0a1Q+fBMun7SHX4yHdbVB9XfR1zx5cvzthSyZYeJWZ+TSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynRnU+PgWx87Zcop5a0j0Q7PBYxqJ6bNjuOsbwfw7Ts=;
 b=LY1b9WOM0tc5xiEbvmKSgyWBRm4/ZwQo92n4VFR5DAJ+zBHaRWddRKhCESVxW7asDsKLNDIJi9PAwoNc4w8L58kpTsTkXbePp9qmuU5ykds4gdqJm3S9WKqNLouEsyyp4p0+OyRGctwZNkFmhvFH12LauH+HIe+xgB0lhNqi5/DcWsTXrRG7FDQ4FozD9DcuD7JT8WxWiSUyutaLfFhCztrYh4eS0Yh4BjwP3So6y/yMAzKjxmy2K1Wd+j1Kt6Y8wozRFQu2TTj9sEJGVpy6FdxugVo4rJ8S8O1Bycjx4oJuLr8JV9GosE46062Y1glSnGD4F5msocW758ZQb0/Z8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynRnU+PgWx87Zcop5a0j0Q7PBYxqJ6bNjuOsbwfw7Ts=;
 b=upbMcu6Q30xBRgC5Vnb2nnVRSjva6uzcI5qDuRS7VHIBjqHU6VDgr2RD5bFcvmTHmlqbIgp4I1aIA1nZFEcVIWfoUXVOq5N7gwFudATbRDe50dcxC+Lt2rab3As9y1uA88G5wpFbXBjbCsYgWUVRInKz/HE5OEFwMKBE4dE60Do=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by DM4PR11MB7397.namprd11.prod.outlook.com (2603:10b6:8:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 04:43:52 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6500.031; Tue, 27 Jun 2023
 04:43:52 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <maso.huang@mediatek.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <trevor.wu@mediatek.com>,
        <jiaxin.yu@mediatek.com>, <renzhijie2@huawei.com>,
        <allen-kh.cheng@mediatek.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 4/7] ASoC: mediatek: mt7986: add platform driver
Thread-Topic: [PATCH v2 4/7] ASoC: mediatek: mt7986: add platform driver
Thread-Index: AQHZqLH42IwsUpwB+UeZKuI++0Vtkg==
Date:   Tue, 27 Jun 2023 04:43:52 +0000
Message-ID: <fb1aa025-5314-b4c4-25ed-1efbbacbdc3b@microchip.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
 <20230626023501.11120-5-maso.huang@mediatek.com>
In-Reply-To: <20230626023501.11120-5-maso.huang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|DM4PR11MB7397:EE_
x-ms-office365-filtering-correlation-id: 9e863f0c-d448-441a-e420-08db76c91b55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K8PVg3VeRCjP1D56seNbpS5B3qVK40loxjU/aoxEdbvl4E9ih4AGd02vXqx7uMacIROoiCxhbycVdQ2G1hrJuhhxsYt+ZU1ATy7877219hBdonv/3hTUy0iqJqwM26AVVWcVDwPM9rZOXmP1grkqS7mAH8d47iQNNZwrjnKXFnVaESrlqjjOKZKbcTHJqYLtvcGnRILas2OMW5bzteiHcggwkTdoYmVMHUwwSeziJmek7bSqcDz0356U0+hXNZaYr9rT7ZesrpdIw2i3D7NiL/OtnlqRq8Q19MbrDJ63Y0eR65jtGvSAEBfz1GrClnBDtY0EsIxSgx9HtDx0YGvS9V5hw5muJAyaefutMZQ7YxgvtGQbuhpea/ZZXYckl+QEepsjddorpYHu/l37XO++m6lQk1Rm4YF6QVcJaSfPtiXx8oMq7Z0f36R1oss8Z3TalZNZoJwM2+dbmmk1fKelAoNeqUE4aCQm6lFiYpTS4YsZAlCX/o0v7E/LmLew9vzKOEWONlnoplbqkcVhA3QBwN3WuF/gnJBWDx9jubhcFKk9gpqmUFRY+5JrcCx1SI5LMcDyNeJ6lwkJXgOUiy/PuvXM/ILhWTQVeo/BJ77/gxPignYTgQaohRlpGCkcAAa6ZESgQB20VviWDCBmaLTMdPyHY//bj+RuLGigoYYJN5fER4ts9g7ZPAdbtygbgFsWP4OYpbUkTLSViwuD9C3yXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(31686004)(8676002)(86362001)(31696002)(8936002)(186003)(6512007)(6506007)(26005)(53546011)(2906002)(36756003)(7416002)(5660300002)(316002)(41300700001)(38070700005)(921005)(76116006)(66946007)(66446008)(122000001)(64756008)(66476007)(66556008)(38100700002)(110136005)(91956017)(6486002)(2616005)(71200400001)(478600001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHRtb2RiNUxhUU8wZjhveW8xM0FBZDFaMy9MZU1JOVlSZ3BKZUIvWEllQ3F6?=
 =?utf-8?B?RXBOZjlBQVlrY0VtRGpZYTNwYUJqUXNUOVI5dTJ0WVNtb1dKTG1lT2NNT0Zs?=
 =?utf-8?B?OUZvcWQyaDZZdW1VYitMbXBKdUVERHZMNEpydUMvcStQeHN0ckgyWlBJZ1k5?=
 =?utf-8?B?Z0JzbmZjcC9McHE0amMzVEl3VTh0bmVyL3VyNTJmVlVqSGpTZlcwamk3T1FI?=
 =?utf-8?B?UkF4QkplS0RkQTI3VWdPVU9YSjR0SjV1MW5BbnpuaXF2SEJ5WGNvK2VoaExX?=
 =?utf-8?B?ZW9WdTVuNHNVQWNKYWxCNndoWlRMWjFRL2FGT1FjN1Z0amJvT1MwOTBWL08z?=
 =?utf-8?B?Zi9TOGJYRzV4TDhqaDQyR0pRNnFlZjAzdGNqVHRxNCtWYzlzNFR3OU5aQlZL?=
 =?utf-8?B?TUttZUxBOVB2Y2Z6bnphcGpJcnQ3NVIvbGZ5RG02S0dhZ2dCOGtXTENudlZN?=
 =?utf-8?B?THc1M20vS1VDRytsODR1SG5ZanVRamwrTytvN2RoazVuNVo0dndYdll6eUho?=
 =?utf-8?B?REF3UFlvaHlPOUtlN1k3dHhqT1dZdks5cFRYTVBSVTBpUFJaSklsTWFPNW1L?=
 =?utf-8?B?ZWNwZldSYXpNakVVYUJ6RGgxdVU3blhtZGNGQVlGUkdNL1pUU1hBbmZxY0xG?=
 =?utf-8?B?VXkzY0tPMjRYSlQwNzFoUGk4NkVvdzFiVmM3NDVsZ0ZQblJHRTRCY3RLUllX?=
 =?utf-8?B?WVFpUUJJbzFwS004ZE8xdWI5a0gzZE9ZdXllbzQ4c1gvd1FSNWRBL1htbWcx?=
 =?utf-8?B?am8xSUluaTRvQzcwOXNPc25MZW1HQk03WmtGK3hTUHNXR05pQm8vQlVRemNU?=
 =?utf-8?B?elM4UmFxaFFwRGp6U2NHUHNXdHVxUlBwZEE2UWpOWnc2TWpjVFQySTdOODFX?=
 =?utf-8?B?WE01TmdOblRhME8wY2s0bVpXU3pUYkVsa080TkowbXJWZGt0UUd2a3pCNGMy?=
 =?utf-8?B?djZUYmdrZU10ZitJRWFhTFFQcklVS0N0c2ZISWV1Mm1OWmp3SyswM2tUNm9W?=
 =?utf-8?B?MWtpTXNRdmxmYjNjVm05NnZiak5kRUpELzJHeWV0cktlcjZHQzVDbC9obi93?=
 =?utf-8?B?bG02UXJrT1J0UUZIUjhsUUpxNVB4NjJEM2h5WHpiVFpBdDh6U1hadXNwdGFE?=
 =?utf-8?B?RHptUjlnQmxuWDdsNVByODNIajJlVzVha2F0U3Z5MlZrQTJVMm43TDlDaCtI?=
 =?utf-8?B?TzJjWERKSENvd0s0SG9FQjJWZzJSQlNZQXJGVHBrem5BT2h4Q3luTEcvalhy?=
 =?utf-8?B?MGRibUI2RmhPS3pBVGlVQnVlMGlaaGJ5QW9FMkx3enpDT0c5YnQ1T3ZPdVQz?=
 =?utf-8?B?ekJwUndYZG9OdmR4U3dBOVUyTi8wTEVsSERoZDVVNlQ0MHpQUWExRGFoTzRG?=
 =?utf-8?B?TzJQc2N3TFNCdVJGWlEzaXFRMlJDeWVYeFVxSVhHaVRVaWV2QlJXT24yUW9D?=
 =?utf-8?B?VXo2MUFjczMrRjRYWHRUQ2NsL21QR1hlSEI3N3E4NXpJampIWEZCL1BiZDNN?=
 =?utf-8?B?dWlmYmtRWlIyT3RIUFNrTW5adFQ5WlpLRkdpV2w3NGRGMHNjRmpXTjI2QWRP?=
 =?utf-8?B?Vldab0FVcUhmQ2xmbVZLS2c0QkRVYnI1Y1FvNDR3WEpUZ1VuOFM2UWQ1RUdZ?=
 =?utf-8?B?bjRjVStkeTFyUldXOE55dzEyNmhOL2JqQ25rWlM1eWpOamRoeFErTUdnYzl3?=
 =?utf-8?B?R1FKVWVQeWwvaEt4Mk5ySnhkMEQ4UnBuUnF5T2ZTL09HWkZweVNKUlUrSTZn?=
 =?utf-8?B?YkllblBuNlcwRVFjWWlJaTZrUGV6UmhPOVRQbStxWGxHaitiNjdqU0krUDVi?=
 =?utf-8?B?Q0RhSEJpRDhBWmN5QVZhdWZtbXBRVTM5ejQvdVZZcFFML0JCTEdLY0h6WmN2?=
 =?utf-8?B?TWh5aEdLLzgrd2c3YW5LVFZQdzlvdlpudkFWZmdGZ2JMN2tVYkxhNE1qdmti?=
 =?utf-8?B?ZTk0bVM1YlBRUlhoMDBBcVRzMzAyd09yRmNINXJGSnR6dFhiQlY5U25KUDdW?=
 =?utf-8?B?ekI5aHlSWkRjUFJPbGt1cXNHaE1rWmhEYXB0R0RoL0VHVkdkOStkVXNPWTQ4?=
 =?utf-8?B?Um0rZmIzUTJhY0N2NklQc3ZrTC95UnNPTDMyUkdJblF6WFhjdWdGcjZncVFQ?=
 =?utf-8?B?RmpPQWlsV0lwb29FVjd6WDh0TjhvWjJBeExGVmh5QWliN3QyWTFaSXlUdnQ0?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A1A18F101B82747ADF08B5EE3DC5F1F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e863f0c-d448-441a-e420-08db76c91b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 04:43:52.1823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LtKgxxXKD0eFdSPrQzzQqNULmocyyKIB6a5NUgij8ESR+1ysVDxCG4LV1nEatna5aJDXDmeUTsgGEBlu5Cq3ZjZwZ2GDuVlY8c1gLQxeR34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7397
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDYuMjAyMyAwNTozNCwgTWFzbyBIdWFuZyB3cm90ZToNCj4gK3N0YXRpYyBpbnQgbXQ3
OTg2X2FmZV9wY21fZGV2X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICt7
DQo+ICsgICAgICAgc3RydWN0IG10a19iYXNlX2FmZSAqYWZlOw0KPiArICAgICAgIHN0cnVjdCBt
dDc5ODZfYWZlX3ByaXZhdGUgKmFmZV9wcml2Ow0KPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRl
djsNCj4gKyAgICAgICBpbnQgaSwgaXJxX2lkLCByZXQ7DQo+ICsNCj4gKyAgICAgICBhZmUgPSBk
ZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCphZmUpLCBHRlBfS0VSTkVMKTsNCj4gKyAg
ICAgICBpZiAoIWFmZSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiArICAg
ICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGFmZSk7DQo+ICsNCj4gKyAgICAgICBhZmUt
PnBsYXRmb3JtX3ByaXYgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCphZmVfcHJp
diksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdGUF9LRVJO
RUwpOw0KPiArICAgICAgIGlmICghYWZlLT5wbGF0Zm9ybV9wcml2KQ0KPiArICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKyAgICAgICBhZmVfcHJpdiA9IGFmZS0+cGxhdGZv
cm1fcHJpdjsNCj4gKyAgICAgICBhZmUtPmRldiA9ICZwZGV2LT5kZXY7DQo+ICsgICAgICAgZGV2
ID0gYWZlLT5kZXY7DQo+ICsNCj4gKyAgICAgICBhZmUtPmJhc2VfYWRkciA9IGRldm1fcGxhdGZv
cm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gKyAgICAgICBpZiAoSVNfRVJSKGFmZS0+
YmFzZV9hZGRyKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGFmZS0+YmFzZV9h
ZGRyKTsNCj4gKw0KPiArICAgICAgIC8qIGluaXRpYWwgYXVkaW8gcmVsYXRlZCBjbG9jayAqLw0K
PiArICAgICAgIHJldCA9IG10Nzk4Nl9pbml0X2Nsb2NrKGFmZSk7DQo+ICsgICAgICAgaWYgKHJl
dCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiQ2Fu
bm90IGluaXRpYWxpemUgY2xvY2tzXG4iKTsNCj4gKw0KPiArICAgICAgIHJldCA9IGRldm1fcG1f
cnVudGltZV9lbmFibGUoZGV2KTsNCj4gKyAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gKw0KPiArICAgICAgIC8qIGVuYWJsZSBjbG9jayBmb3IgcmVnY2Fj
aGUgZ2V0IGRlZmF1bHQgdmFsdWUgZnJvbSBodyAqLw0KPiArICAgICAgIGFmZV9wcml2LT5wbV9y
dW50aW1lX2J5cGFzc19yZWdfY3RsID0gdHJ1ZTsNCj4gKyAgICAgICBwbV9ydW50aW1lX2dldF9z
eW5jKCZwZGV2LT5kZXYpOw0KPiArDQo+ICsgICAgICAgYWZlLT5yZWdtYXAgPSBkZXZtX3JlZ21h
cF9pbml0X21taW8oJnBkZXYtPmRldiwgYWZlLT5iYXNlX2FkZHIsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAmbXQ3OTg2X2FmZV9yZWdtYXBfY29uZmlnKTsNCj4gKyAgICAgICBpZiAoSVNfRVJS
KGFmZS0+cmVnbWFwKSkgew0KPiArICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihhZmUtPnJl
Z21hcCk7DQo+ICsgICAgICAgICAgICAgICBnb3RvIGVycl9wbV9kaXNhYmxlOw0KPiArICAgICAg
IH0NCj4gKw0KPiArICAgICAgIHBtX3J1bnRpbWVfcHV0X3N5bmMoJnBkZXYtPmRldik7DQoNCllv
dSBhbHJlYWR5IGRpZCBoZXJlIGEgcHV0IHRodXMgKHNlZSBiZWxvdykNCg0KPiArICAgICAgIGFm
ZV9wcml2LT5wbV9ydW50aW1lX2J5cGFzc19yZWdfY3RsID0gZmFsc2U7DQo+ICsNCj4gKyAgICAg
ICAvKiBpbml0IG1lbWlmICovDQo+ICsgICAgICAgYWZlLT5tZW1pZl9zaXplID0gTVQ3OTg2X01F
TUlGX05VTTsNCj4gKyAgICAgICBhZmUtPm1lbWlmID0gZGV2bV9rY2FsbG9jKGRldiwgYWZlLT5t
ZW1pZl9zaXplLCBzaXplb2YoKmFmZS0+bWVtaWYpLA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgR0ZQX0tFUk5FTCk7DQo+ICsgICAgICAgaWYgKCFhZmUtPm1lbWlmKQ0KPiAr
ICAgICAgICAgICAgICAgZ290byBlcnJfcG1fZGlzYWJsZTsNCj4gKw0KPiArICAgICAgIGZvciAo
aSA9IDA7IGkgPCBhZmUtPm1lbWlmX3NpemU7IGkrKykgew0KPiArICAgICAgICAgICAgICAgYWZl
LT5tZW1pZltpXS5kYXRhID0gJm1lbWlmX2RhdGFbaV07DQo+ICsgICAgICAgICAgICAgICBhZmUt
Pm1lbWlmW2ldLmlycV91c2FnZSA9IC0xOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIG11
dGV4X2luaXQoJmFmZS0+aXJxX2FsbG9jX2xvY2spOw0KPiArDQo+ICsgICAgICAgLyogaXJxIGlu
aXRpYWxpemUgKi8NCj4gKyAgICAgICBhZmUtPmlycXNfc2l6ZSA9IE1UNzk4Nl9JUlFfTlVNOw0K
PiArICAgICAgIGFmZS0+aXJxcyA9IGRldm1fa2NhbGxvYyhkZXYsIGFmZS0+aXJxc19zaXplLCBz
aXplb2YoKmFmZS0+aXJxcyksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdG
UF9LRVJORUwpOw0KPiArICAgICAgIGlmICghYWZlLT5pcnFzKQ0KPiArICAgICAgICAgICAgICAg
Z290byBlcnJfcG1fZGlzYWJsZTsNCj4gKw0KPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBhZmUt
PmlycXNfc2l6ZTsgaSsrKQ0KPiArICAgICAgICAgICAgICAgYWZlLT5pcnFzW2ldLmlycV9kYXRh
ID0gJmlycV9kYXRhW2ldOw0KPiArDQo+ICsgICAgICAgLyogcmVxdWVzdCBpcnEgKi8NCj4gKyAg
ICAgICBpcnFfaWQgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiArICAgICAgIGlmIChp
cnFfaWQgPCAwKSB7DQo+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIiVwT0ZuIG5vIGly
cSBmb3VuZFxuIiwgZGV2LT5vZl9ub2RlKTsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IGlycV9p
ZDsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3BtX2Rpc2FibGU7DQo+ICsgICAgICAgfQ0K
PiArICAgICAgIHJldCA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBpcnFfaWQsIG10Nzk4Nl9hZmVf
aXJxX2hhbmRsZXIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJUlFGX1RSSUdH
RVJfTk9ORSwgImFzeXMtaXNyIiwgKHZvaWQgKilhZmUpOw0KPiArICAgICAgIGlmIChyZXQpIHsN
Cj4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiY291bGQgbm90IHJlcXVlc3RfaXJxIGZv
ciBhc3lzLWlzclxuIik7DQo+ICsgICAgICAgICAgICAgICBnb3RvIGVycl9wbV9kaXNhYmxlOw0K
PiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIC8qIGluaXQgc3ViX2RhaXMgKi8NCj4gKyAgICAg
ICBJTklUX0xJU1RfSEVBRCgmYWZlLT5zdWJfZGFpcyk7DQo+ICsNCj4gKyAgICAgICBmb3IgKGkg
PSAwOyBpIDwgQVJSQVlfU0laRShkYWlfcmVnaXN0ZXJfY2JzKTsgaSsrKSB7DQo+ICsgICAgICAg
ICAgICAgICByZXQgPSBkYWlfcmVnaXN0ZXJfY2JzW2ldKGFmZSk7DQo+ICsgICAgICAgICAgICAg
ICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoYWZlLT5kZXYs
ICJkYWkgcmVnaXN0ZXIgaSAlZCBmYWlsLCByZXQgJWRcbiIsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGksIHJldCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX3BtX2Rpc2FibGU7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgfQ0KPiArDQo+
ICsgICAgICAgLyogaW5pdCBkYWlfZHJpdmVyIGFuZCBjb21wb25lbnRfZHJpdmVyICovDQo+ICsg
ICAgICAgcmV0ID0gbXRrX2FmZV9jb21iaW5lX3N1Yl9kYWkoYWZlKTsNCj4gKyAgICAgICBpZiAo
cmV0KSB7DQo+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGFmZS0+ZGV2LCAibXRrX2FmZV9jb21i
aW5lX3N1Yl9kYWkgZmFpbCwgcmV0ICVkXG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
cmV0KTsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3BtX2Rpc2FibGU7DQo+ICsgICAgICAg
fQ0KPiArDQo+ICsgICAgICAgYWZlLT5tdGtfYWZlX2hhcmR3YXJlID0gJm10Nzk4Nl9hZmVfaGFy
ZHdhcmU7DQo+ICsgICAgICAgYWZlLT5tZW1pZl9mcyA9IG10Nzk4Nl9tZW1pZl9mczsNCj4gKyAg
ICAgICBhZmUtPmlycV9mcyA9IG10Nzk4Nl9pcnFfZnM7DQo+ICsNCj4gKyAgICAgICBhZmUtPnJ1
bnRpbWVfcmVzdW1lID0gbXQ3OTg2X2FmZV9ydW50aW1lX3Jlc3VtZTsNCj4gKyAgICAgICBhZmUt
PnJ1bnRpbWVfc3VzcGVuZCA9IG10Nzk4Nl9hZmVfcnVudGltZV9zdXNwZW5kOw0KPiArDQo+ICsg
ICAgICAgLyogcmVnaXN0ZXIgY29tcG9uZW50ICovDQo+ICsgICAgICAgcmV0ID0gZGV2bV9zbmRf
c29jX3JlZ2lzdGVyX2NvbXBvbmVudCgmcGRldi0+ZGV2LA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgJm10Nzk4Nl9hZmVfY29tcG9uZW50LA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgMCk7DQo+ICsg
ICAgICAgaWYgKHJldCkgew0KPiArICAgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAiZXJyX3Bs
YXRmb3JtXG4iKTsNCj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3BtX2Rpc2FibGU7DQo+ICsg
ICAgICAgfQ0KPiArDQo+ICsgICAgICAgcmV0ID0gZGV2bV9zbmRfc29jX3JlZ2lzdGVyX2NvbXBv
bmVudChhZmUtPmRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICZtdDc5ODZfYWZlX3BjbV9kYWlfY29tcG9uZW50LA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWZlLT5kYWlfZHJpdmVycywNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFmZS0+bnVtX2RhaV9kcml2
ZXJzKTsNCj4gKyAgICAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgICAgICAgICBkZXZfd2Fybihk
ZXYsICJlcnJfZGFpX2NvbXBvbmVudFxuIik7DQo+ICsgICAgICAgICAgICAgICBnb3RvIGVycl9w
bV9kaXNhYmxlOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAgICAgIHJldHVybiByZXQ7DQo+ICsN
Cj4gK2Vycl9wbV9kaXNhYmxlOg0KPiArICAgICAgIHBtX3J1bnRpbWVfcHV0X3N5bmMoJnBkZXYt
PmRldik7DQoNCnRoZXNlIHNob3VsZCBiZSBubyBuZWVkIGZvciB0aGlzIG9uZSBoZXJlLg0KDQo+
ICsgICAgICAgcG1fcnVudGltZV9kaXNhYmxlKCZwZGV2LT5kZXYpOw0KDQpUaGlzIGlzIGFsc28g
Y292ZXJlZCBieSBkZXZtX3BtX3J1bnRpbWVfZW5hYmxlKCkuDQoNCj4gKyAgICAgICByZXR1cm4g
cmV0Ow0KPiArfQ0KDQo=
