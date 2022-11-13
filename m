Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD6627065
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 17:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiKMQRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 11:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 11:17:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9BCFACF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 08:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668356219; x=1699892219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KuX1y3B0BNN6CdHB0+te5w5ePUJx4utmMqCft53ID5s=;
  b=jegAdj0y5a5EUHGfhvgZKvgLjUJ/onKXrYEQoJOH5wIXQknTsgx3rN5C
   r89yfneldJgqHuF+8R+SPmyd+qXi5EanYlAndUQs2PrRb1JuYTT2eaB43
   NGkW99FmbEHuw4BWqBaEnbreNDvHFLFrz1nIc4Gy87x1hAo8PNmoYUYfY
   HL+DPntrlX6QNg5MoVcCvOtkSX5yNQnyTc2f0/ExKhUc7ODIAg/BvAMfO
   Yo2mi+OW7+mC2Madr2h22Lk3gsSRm4Kv88DxYxQ9a5GE2TzQ5wXe4CsKb
   eDBoPHK2fqRl+oqQl68aGwyM9H7Yaao4QEjthitLZ5Rc1+ojEdtiDFDFL
   g==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="186751051"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Nov 2022 09:16:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 13 Nov 2022 09:16:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Sun, 13 Nov 2022 09:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGrAM9AbMMaAxj70eF8hXPiZdViV3ymUxagcfHOWVUqCsQjQXxEYJtUOACOwOL7HS6+fUxrpreg0D1oHAtYpkGNnjyD5rU76nwCtIE3BrvV52LEvbQqr3890nKAN3P1V9yZeTsGSWPQCRYGNwNmquOFapnnf53RXKpsW3AJ270Pe57ht78HNkPSAdYodE7QWA7+689DlPUPTKL+jN6x/IeSQoNC1frlLSyyit+1CfI3U/GlYOd+2+qvPnuCLqAIUX5cPIJ/PkW+sjilJuPW/QHPoL6fCsG1uOl229OS14e9tTng481FmWFWzSHNpby3UTwrMoMG9triGQaFGjnZwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuX1y3B0BNN6CdHB0+te5w5ePUJx4utmMqCft53ID5s=;
 b=RwFPnnCxK0Oxt3JkeolJhsOn8kQeVizBh/mgZuJIkAZXMsYp6FoSsOYaBeQilrqPxVR7XhxOqh/jE3lMGhVNek7oEYu4KsHOP5zOyWuw1PKZuX+9pFOx/sImDHJ5J9e1MG/Sbz00nTdn8n9C5YAytJ+ktxBQaY/lIn7/zFh6DFnHe+3g10qptaulxOZ5QHCD/RV0xU/XN7R0YM2gFgwfAh9gSSTl+pSIg5rZVGi5u8GgNE9kvhRgMsqDzh8xox++N2F89KVou8y6j2slZ2bAy3J2GdrR6suI+Pxo13RSTQfLD1S1oX3KyJ4DYPLRb5LoYzbjUF19EL0kiHVWzw58FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuX1y3B0BNN6CdHB0+te5w5ePUJx4utmMqCft53ID5s=;
 b=LU8jHSZfgEj/Zoxug+g6Wcf9eD8hbb2VPwO6gH54g72uV2Thr9loBN+wpgqrh0cCeWe0JgKMviwZQhpcH0kjG0aP5fW1yvlgqYS0xgQ/mJp4veAnHM2/+fWFYRI3CasoIJv3+sH4RehpAuiBZBFjXBVCa9JIRoRzv87/XJ5i9d4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA2PR11MB5132.namprd11.prod.outlook.com (2603:10b6:806:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sun, 13 Nov
 2022 16:16:53 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6%4]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 16:16:53 +0000
From:   <Conor.Dooley@microchip.com>
To:     <bjorn@kernel.org>, <stillson@rivosinc.com>
CC:     <greentime.hu@sifive.com>, <guoren@linux.alibaba.com>,
        <vincent.chen@sifive.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <guoren@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 04/17] riscv: Add vector feature to compile
Thread-Topic: [PATCH v12 04/17] riscv: Add vector feature to compile
Thread-Index: AQHYzgPW4FcsKKOun0GK1XCVuJPYnK4z/tQAgAlb0gA=
Date:   Sun, 13 Nov 2022 16:16:52 +0000
Message-ID: <98343aa8-b04d-fe58-8af8-4eeca03106d1@microchip.com>
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-4-stillson@rivosinc.com>
 <87zgd2d6j1.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87zgd2d6j1.fsf@all.your.base.are.belong.to.us>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|SA2PR11MB5132:EE_
x-ms-office365-filtering-correlation-id: c6fd2777-2190-4c1f-473b-08dac5927a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eh2L9ntISpMqb4zPcIjKRRhPoaZYRqiAvmwOh4TFJjcgWcX7QPAlepkacQIfLa9RcHNa5DbQkqG9DVUXoVMS4vEY24T78GuFi/1pfeA8taGNdzUOhpH7HEubW+Z9nr8KN1D7W2To3rAvFj1nURvB+AYHx8lQOd7TR9bTRMjHPbxh46J5VmC/XgmHe+5rNGy/bNdMRxJbroMauMfPVKcKpkHjHkwJDcSe7X9tiSNiAwzZAOns6JtvrC9xIbL2i9FXSQ8+bKZTEtPN7a5S3q/ux9Y6J9ES3NHV3BDeUvu0mgVP3+YPRsnmvOTwrPlIgKl8hAHOB6gT7udTh5qkXbDIgFFoiRyCDxjtqT0CK05qZCWAOiMnOSPeMWJduoFi2yDcW+mwa3m+QK0a92v/jeUvnqqx/SZnalco+U8bmd9yCc5NvDIzXTJvXAvTnuKUgehkeK1h2vYN2RmWQrC9BE38qvRUtZXrJ890nedaV7rkP41+7cHHUzZ8WAuc2b1ysbnsCOD3GzqbXkfdO62kLSpWlJv4KrbqMaDixH7ExcaC8P0dYruTCl/GH98OpX6ON0PZcVPltG7j4IHOwTngwuJgv4p6g90PlNLaHC3a1NB9Shj6rXnItsOQjIsKEvxuhVE2zBam4zfZPNzovAXlcMfFaa6ACASkELpsFx6549dSwJjuuzbPraADw0ryYqSvhqrydWAxS7BwbYidm1UeFlS8D/OB+A7ZessjIZNXy7fhu19aakOa7rt+1SeLlp//fg3ZmaRNxsmRJpqo7XGgcc/bPGhoDzR6ZhzDpL0NNmvbUbpnMK4RMu7KAhFXQX0zydomfO0+dWseNhJKex8g95lhPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(346002)(39850400004)(366004)(451199015)(316002)(64756008)(38070700005)(66446008)(4326008)(66476007)(31686004)(76116006)(66556008)(8676002)(91956017)(66946007)(110136005)(38100700002)(54906003)(122000001)(41300700001)(186003)(7416002)(31696002)(5660300002)(8936002)(6486002)(478600001)(36756003)(83380400001)(2906002)(53546011)(6512007)(26005)(2616005)(71200400001)(6506007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTZxR2pKWlgrVE85My9INWZOVVN1dFp2UGdodGp6dmdGVnUybmpsVTJVNkhw?=
 =?utf-8?B?cHRmRnFSeThlSGFMczFVeXZ6MmNiRW10RFhYeDhWbzJOVTdRbHdMNGFXd3U2?=
 =?utf-8?B?bXR6cWllV0sxbmdBbzlQU1RKMHN1anNVcWhTVHpKQzlldHhjRlhHU0VJQjBO?=
 =?utf-8?B?ZktuUkZ6ZmErR29ZQ1JnUGkxZGh0UjFXcDQvRTM1cWZNZFlWQVkrWGxxclVC?=
 =?utf-8?B?Si83cllVQktSTWpGVHBGemFpVERSbGU3RmZjR1Bxb3hDNHdsd0FtVEtjWEVv?=
 =?utf-8?B?UWppWGJxZkthMXpGbzd6SW9xbHN1UVk0eklCVXdxZnc3SC94WG5TSlZMOHBU?=
 =?utf-8?B?Si9seVZGeEtHUXVEYlY2Y1FFQUNxb2R1ZXVsRW8xVzc1MFMzdFJ0eTJtWm9l?=
 =?utf-8?B?Y3h2S1ZRdTFDL1NtTjdmUjNNTDBCNHpmWkh5SVJIVnBRSVRUMCtrK2t1QkFq?=
 =?utf-8?B?elp5QnM0QWhBSFErSG51SXkxMVdBMTV3RTNpaGVIWXlZMllZT3RxWkVsNGtM?=
 =?utf-8?B?cEEwd2Z2ODBIayt6QjMrQ090elZrSkMxSFpBQmVUV0xXd0FaU3p0WGVjdE5F?=
 =?utf-8?B?c1RLMXRrUGxFTWYyWWJJUVhqc2o3L1cyL3NPQ21UVmlqUmNTQ0RLU1NRdGJV?=
 =?utf-8?B?ZnNnY09HQkVJYkhCaFJHc3pzbjN1NnRvQkhUYWxuWlpyRDBEYUNXcVZxSlEy?=
 =?utf-8?B?N1E4K1N1VEJORHFkWlk3U1B2YmZ5Qncxc1F3NWZ4SlE1SFRsQlc2VUl1QUEv?=
 =?utf-8?B?TUNUc1lZakswMnZodkRrVEc2WmdrQVJQbkQySmpiK3ZZM0Uxc0dqS1RGVGxS?=
 =?utf-8?B?RG00STNrSXZoRlNHTnRJendHWUc3TFdNclR1bU9LcUFscFROM3c1RUFpbUNV?=
 =?utf-8?B?Wk1VcDdTVzBCNnU1YTN1M3JaZlRneFdoQVJCa3Y2ZUg3WVhpWUN1SmpQS1U1?=
 =?utf-8?B?ZDgyc21wRXNwellPTlpVa2hpMWtEdXJGdUFWam5SMi9xNUtzUGxtVHkxWU1t?=
 =?utf-8?B?UndNcWM5TVpMTjFRQmVrT3JYNTdsSWtVT3VHYnNzdmxmN0ZSMWdKc3BKVW5a?=
 =?utf-8?B?Q1NhVWdNZ3pNbGRQZklhWWUwbHQrWjJHcWhkOUdzQXIxd2ZiMXR2K2NtYy93?=
 =?utf-8?B?VHZOWDRQbEhlcjhQZEJSQjFRRzBhS0hsSmVscTN1SnNBMWZ0cGJubjA1Z2VW?=
 =?utf-8?B?VEY3aWFjV1NVR0NGNGpwUmVLeWNuaG1DZWRlbHZKOWo1V1lMSG0za3FYM09T?=
 =?utf-8?B?NHZndjc0RnRlWUg2L2pLeXdqYmthTk1hd3M1MFp0aW5tRzJRcmFFbnoyL2dj?=
 =?utf-8?B?T3RxU1k1dXV0eWVoQnhuaEpCSkhHRHpJY2RoVmpISXF6ZmtBSXpVL01yMGww?=
 =?utf-8?B?eHh2akR4czQrYmg3Qk53OVZYaFBoaTh1VXphemMxRHpDOVB2SWFGQTJQNyt2?=
 =?utf-8?B?TGFVVFZ6SjdNRURsdGNUWWhMY09HWDYveElUSzFHOTZabDJJUEh2bjY3Smsy?=
 =?utf-8?B?b3RFZmphVXFidHRKa0Z4SVFaR3lXdW1ubk1kektGbnZzS01BMnpLSmpPeXJ1?=
 =?utf-8?B?K3RmOStPT1ZiTEhXRmhGQlNjdWpBaUYwbmU3QmRkdHVFZVgyejBGTjhLclov?=
 =?utf-8?B?ZFoyamlBbkk0WU9RWDhaN201bTJLT3JTSG9SQVVkNzlEQWkrRzlUN2dHQktF?=
 =?utf-8?B?VlJEelZZc1RXMStOSVBrUkNSRjlsU211SmxqaFRyQndTS3UrTVRueEdrR3dN?=
 =?utf-8?B?c21PdHBMS0J2V3RxU2hrdlVidmRuek5QZ01IeXlSeFZ5Q3FPU1UyQThHSFJE?=
 =?utf-8?B?QnlBM1hxa3Vva3Z4cjZiWTl5dk9NRnhLWVNTdUdtenBUTSsyZGFYK2FxeVY3?=
 =?utf-8?B?SGR0L3lzWnJEdnI5Tm4zTnhOZm12dXNrTm9mVm5MNmpIUnFlQzRMSFdMK1Rw?=
 =?utf-8?B?UWNhWE5XbHZIeTEzOHVDdFcvVndzTHVXNjdxVG1KTUVJcWhlQ1JkeURSTmFy?=
 =?utf-8?B?Qk1xM3piNmxmbUM0UGxrV08yVUprSnNPYm8yWUg1b1VzcXg0ejYxd250MnJP?=
 =?utf-8?B?TE5BMjF3R3o5VlBudURHdldqM2E3U3NWb09Ga0xBdFJ4VTJmbjVwZVJSaitP?=
 =?utf-8?Q?/09YHbgZA9Y+IF0ckR7QE87sz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <649D8A3705C6644EBB6184A12B06C5C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fd2777-2190-4c1f-473b-08dac5927a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2022 16:16:52.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJ5fxNxck16eWTNliScxfVoG+xH8YiKyHItN9XlWgB2sdIXrWI5IHhusRuDAkgjruQbbTDChmYnmS0XeJuLxGDk3utkL4np25y8USLMzHkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5132
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMTEvMjAyMiAxNzoyMSwgQmrDtnJuIFTDtnBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBbQ3JvcHBpbmcgdGhlIGh1Z2UgQ2M6LWxpc3Qu
XQ0KPiANCj4gQ2hyaXMgU3RpbGxzb24gPHN0aWxsc29uQHJpdm9zaW5jLmNvbT4gd3JpdGVzOg0K
PiANCj4+IEZyb206IEd1byBSZW4gPGd1b3JlbkBsaW51eC5hbGliYWJhLmNvbT4NCj4+DQo+PiBU
aGlzIHBhdGNoIGFkZHMgYSBuZXcgY29uZmlnIG9wdGlvbiB3aGljaCBjb3VsZCBlbmFibGUgYXNz
ZW1ibGVyJ3MNCj4+IHZlY3RvciBmZWF0dXJlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEd1byBS
ZW4gPGd1b3JlbkBsaW51eC5hbGliYWJhLmNvbT4NCj4+IENvLWRldmVsb3BlZC1ieTogR3JlZW50
aW1lIEh1IDxncmVlbnRpbWUuaHVAc2lmaXZlLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEdyZWVu
dGltZSBIdSA8Z3JlZW50aW1lLmh1QHNpZml2ZS5jb20+DQo+PiAtLS0NCj4+ICBhcmNoL3Jpc2N2
L0tjb25maWcgIHwgMTUgKysrKysrKysrKysrKy0tDQo+PiAgYXJjaC9yaXNjdi9NYWtlZmlsZSB8
ICAxICsNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvS2NvbmZpZyBiL2FyY2gvcmlzY3Yv
S2NvbmZpZw0KPj4gaW5kZXggZWQ2NmMzMWU0NjU1Li5lMjk0ZDg1YmZiN2QgMTAwNjQ0DQo+PiAt
LS0gYS9hcmNoL3Jpc2N2L0tjb25maWcNCj4+ICsrKyBiL2FyY2gvcmlzY3YvS2NvbmZpZw0KPj4g
QEAgLTQzMiw3ICs0MzIsMTcgQEAgY29uZmlnIEZQVQ0KPj4NCj4+ICAgICAgICAgSWYgeW91IGRv
bid0IGtub3cgd2hhdCB0byBkbyBoZXJlLCBzYXkgWS4NCj4+DQo+PiAtZW5kbWVudSAjICJQbGF0
Zm9ybSB0eXBlIg0KPj4gK2NvbmZpZyBWRUNUT1INCj4+ICsgICAgIGJvb2wgIlZFQ1RPUiBzdXBw
b3J0Ig0KPj4gKyAgICAgZGVwZW5kcyBvbiBHQ0NfVkVSU0lPTiA+PSAxMjAwMDAgfHwgQ0xBTkdf
VkVSU0lPTiA+PSAxMzAwMDANCj4+ICsgICAgIGRlZmF1bHQgbg0KPj4gKyAgICAgaGVscA0KPj4g
KyAgICAgICBTYXkgTiBoZXJlIGlmIHlvdSB3YW50IHRvIGRpc2FibGUgYWxsIHZlY3RvciByZWxh
dGVkIHByb2NlZHVyZQ0KPj4gKyAgICAgICBpbiB0aGUga2VybmVsLg0KPj4gKw0KPj4gKyAgICAg
ICBJZiB5b3UgZG9uJ3Qga25vdyB3aGF0IHRvIGRvIGhlcmUsIHNheSBZLg0KPj4gKw0KPj4gK2Vu
ZG1lbnUNCj4gDQo+ICJWRUNUT1IiIGlzIG5vdCByZWFsbHkgY29uc2lzdGVudCB0byBob3cgdGhl
IG90aGVyIGNvbmZpZ3MgYXJlIG5hbWVkOw0KPiBSSVNDVl9JU0FfViwgUklTQ1ZfSVNBX1ZFQ1RP
UiwgUklTQ1ZfVkVDVE9SPw0KDQpJdCdkIGJlIFJJU0NWX0lTQV9WIHRvIG1hdGNoIHRoZSBvdGhl
cnMgc2luZ2xlIGxldHRlciBleHRlbnRpb25zLCByaWdodD8NCg0KVGhlIHRvb2xjaGFpbiBkZXBl
bmRlbmN5IGNoZWNrIGhlcmUgYWxzbyBzZWVtcyByYXRoZXIgbmFpdmUuDQoNCg==
