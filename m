Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3963A67751D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjAWG3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWG27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:28:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A647EE041;
        Sun, 22 Jan 2023 22:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674455335; x=1705991335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=simjgG18RdJRaLb9y/RqyQUcLnElgH7n+ULLeQt5Hec=;
  b=xgxmDhXQ/yoidXvLSXQzgHg9ogGrfO1kgoRh/pzGZ0hhvGMJ9C4c4UHt
   ymotRJG4Fn12OujmI0i6S0ivz4VGEv19kByJHXtWdzKpfnOl7BaiAC0rF
   wnnRpTEalqd2BIN7Q6eQ4PjlqmEClQ86ZmHCZDTibMS7EcwnLO/sAbmHz
   OunHR4moUQzW5TDN18GPFCVuXwwd7FAuwUvabwCyP+5Im0AOAvA4wiLXH
   t3DmsBvJA+ItNDM09mr5ETjsp1sCARJECwiYMGNZUMfazJHC/qitrw5Sn
   WybsbRE2GDEKekLYTFJcSoSiUqrpCyNVwRQ8wMWpzhxelfW4IiA6TZSMg
   A==;
X-IronPort-AV: E=Sophos;i="5.97,238,1669100400"; 
   d="scan'208";a="197681905"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jan 2023 23:28:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 22 Jan 2023 23:28:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Sun, 22 Jan 2023 23:28:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLeEjRm9DvPtdNVhZUyg9BbgSTitaDtDrRncRPEB51yXgE0ikFsylHEwTT5CIoYuNZx8UKssBW/rDDQznlLW8m5VkoTQvntac9zUKpVLSv5Sr2vpbG0rB2pDr3amHUig0VKzdXzGIWAxUcqPepf0KoSxuHyyOxrfv0CtksTI907dzrAye/WEZcKWYPYfqpK/ZO3ZHach+VIrPHujAFFXPVGX0DMCMzWfliqDqE74uVNdkFqudQkZUTX4P9+fkbbTqyOAYuZcaaRvXDoDs6aUX7ugovgsEBJR98I/A3XHdProySdbErFnhz5ZODpzQtgW42WsLVTK6V0a62x4mvT6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=simjgG18RdJRaLb9y/RqyQUcLnElgH7n+ULLeQt5Hec=;
 b=P/ulNJyUSRlww//bwNffVs2PMqpIOPh2Dd6s2sjFUk3RS15tQu1Z8YldRSQAcOeA4b/OtT8OpYOMmBaeSRqOTE6ZzhpeY65UBLXqjA7HiesR3Q512OufKKHsI99RxhBy8vsbjOip2+JOVZLDWja6BWkJZ56StCkAKBg6sBalmEa4T4oD4uh8BrGg4QSvDOa6c8z8lVCfY4XgvRN82/l3vZqyPX35Z4ize5cQd6FtMiyp0qV1bLQ/WBMC9u5iAaCM5U5QUGAD3OJdXOrwMhKAP+S66tRznRfheqUtUQMwUU691bXg7cT1XSvHm3QNEXnruULX6VKDq3FS+kH+5OaORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=simjgG18RdJRaLb9y/RqyQUcLnElgH7n+ULLeQt5Hec=;
 b=QHNBAE2PybhUKE2a+GThrUx3+kVB+qGysUCy+SVlTLrREMhyXUO7Zy5RhAcEudx/cOJlE6CUX2A/nUp7s3/WF+of1s1yr919CTYNdE8Kn2HwKkRe3zyzoSz4Ejq44sbNC4u11FTlEJgPPjDZ7PLLvYClFvKpv5Vyj8euLLg6EW4=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by SA2PR11MB5067.namprd11.prod.outlook.com (2603:10b6:806:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 06:28:51 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6f3f:f30b:e31e:1fc7%6]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 06:28:51 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <paul.j.murphy@intel.com>,
        <daniele.alessandrelli@intel.com>, <mchehab@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <festevam@gmail.com>, <kernel@pengutronix.de>, <linux-imx@nxp.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sakari.ailus@iki.fi>
Subject: RE: [PATCH RESEND v10 4/5] dt-bindings: media: i2c: imx334 add new
 link_freq
Thread-Topic: [PATCH RESEND v10 4/5] dt-bindings: media: i2c: imx334 add new
 link_freq
Thread-Index: AQHZLUnJL8m0GQUI4ESoZxNUHSGF2q6qexKAgAEOP+A=
Date:   Mon, 23 Jan 2023 06:28:51 +0000
Message-ID: <PH0PR11MB5611EE968D282A9F998A2F8C81C89@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230121033713.3535351-1-shravan.chippa@microchip.com>
 <20230121033713.3535351-5-shravan.chippa@microchip.com>
 <ec897c39-b6df-82fc-bd9e-84c6213acb1b@linaro.org>
In-Reply-To: <ec897c39-b6df-82fc-bd9e-84c6213acb1b@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|SA2PR11MB5067:EE_
x-ms-office365-filtering-correlation-id: c803096e-b89a-41f1-eb57-08dafd0b17da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLtIyerIr/79Jy47Po/1vk2+o5+jEEgdhgMFB/tSAogSuC9uaTiObWDVzrnqpdd8l64G+H0SK1DmaoGgtQWOVGON9PwZm/E5cnpDI/I5qAJEFOFxiHtqf9H/ESH902J2cazuh08AkRtVjTYSV5ghv+XAcRq5pQ1dS4CBQ4Fr85mS7fs2xMxhrtu4QiwTGe0zPNDSw8BUL3fHzcsPeDPni2HmcMj6yC2WSJByz7TzxLnPmf+x/1YNQlcZs7GLkWNPMZW7NCpiEhrP9wue+MPnf4mKgPUesSBp8Z2f8G51ADDsFIVRTyyxem82nU3a06JR16SpclyvWfKraIqwrSZ8r0dZJfVI0D5RpFdye0U9sz8oKQlHforx1ti66CP3Y+0IIcx1UYsGHZu4aWiFxXSgDiTcXvyPkVsCgE7wcV3yXqfwaaqqlBMYRTky8uu5w0MScs+pyYJYfiKPMawY8PnWrpQklcrve953e0u1LlNrimVkIB0pJe11/veJ/ULoV7qfYPTcRHbL2QS5or8SVtl9c7UGqKgu+Itx8y1TiWz2EG0CJ81tK0iwxKEUC5vGa0Y1LvlyT8QYIJbc4rc74avFafV4WZf6Yh9lftQ2Dmvw3oVyA2Edf6GSE4zbJm9v8+jZya88k1Bjq4x29u/MgI4jKGkgVCKYe230oHKs8ohaaBdGQLSHf9wzmJo8mxMCwPyMkLERNA3OOPRMBSQy1jvlwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(366004)(39850400004)(451199015)(55016003)(38070700005)(33656002)(86362001)(316002)(54906003)(110136005)(66476007)(66946007)(76116006)(66446008)(66556008)(64756008)(26005)(186003)(9686003)(478600001)(6506007)(71200400001)(7696005)(122000001)(53546011)(8676002)(38100700002)(83380400001)(8936002)(52536014)(41300700001)(2906002)(4326008)(7416002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXQ5eDZpbS90VXNlSUdxUVA5dGgvS1ZUcFE2R0F0N3o4QnhQUEFpYkNLcDN0?=
 =?utf-8?B?ZVlTc0ZzZ1JNbFVpeDlpY2tlbEtFeVJWbGlLaDNVRFBjc2I5bUNtYUdQenc1?=
 =?utf-8?B?T3hkeFdKcnZ3WG1mYU8rVHNsdUplaTREOUUwMVh5TkI3MzlySUtZbWNVUnVp?=
 =?utf-8?B?Z1Fhd2VVekluRXVoMHZIMVNObmQ5Nmx0cFMxQzNMT1JUaEJSYlY2QlpPZ3lR?=
 =?utf-8?B?OWF4Y0tzczkzOXZvZGM4eDRCaVQyRGxxY2JSQlhkTjlDU21idUFobkd5cHRG?=
 =?utf-8?B?MnhydXBnY09ubzZtdk1pRi9OdjhpaEVnN0Y5ckJWeTRVYTVBMEpwUExuYlJC?=
 =?utf-8?B?R3FqK1QzYkpSODlWSlNDc0s2WFM0RE1URkdZcSt1REQyVXI4M2ZuREt5aTJD?=
 =?utf-8?B?SGdKUTQ0WTFDS1Y2b0lnRHc3bWRrMi9nTDhFRjRScCtOZ25GVEUwb0p1Mmhh?=
 =?utf-8?B?SXIwUldFUVhlN3VPQ0VzUmFQbXpGQzZGWG05cEFrMzlJNDRCNU0vQVVocHBy?=
 =?utf-8?B?RzVlMGF4SytIVmJtNFpsWkJPQmdQajBSajRGMWVSelhPUFh2bndYL0k2Rm42?=
 =?utf-8?B?eVQ1SS9sN1RJSHhkejJGb1lERjlNVmhvVkxLeEdvU3Y5dGVSK2Y0KzZlUjRB?=
 =?utf-8?B?TFZETWs3RUV6OXRPWk1SU3RVNUs0QXJtY2FxRUNEWk9qVHVZR2hJNXlBencz?=
 =?utf-8?B?U1F0YUdlNllFZlNkM2ZtUUZqWE5mK3I3NXVNVG05Ny9WZ0REb0ZrZUMxUEZL?=
 =?utf-8?B?VnZIZGp2cU9UUjN0S2JPL0NMQW42ZWdtZkNPWmU0RTZ0bUdwaFMzWThKVWhn?=
 =?utf-8?B?YlRES0E5cDJ2U2xxZDJRRUM4dy9ZdnJReWxaMlhWd1NFVFUzZEduSG1xM1g1?=
 =?utf-8?B?QjZUaEVQNW5kdlZjZDVnZFdIZGF1MDhkODlxV1RwYUpxYlBOdCs5ZVpicHNC?=
 =?utf-8?B?cUZEcHB1aWorQmFTSFpQMEM5dVhCTXhaNzNEQVFuRWtYMEppYlA1bUpaOFVM?=
 =?utf-8?B?SnBsNTdKTTdwUTFRWUpCSG5qUWhVM3lJLys3UnI0ODd1N1ZuTUk0UzdkdXJu?=
 =?utf-8?B?L08zWlZFcUF1Vis2VGM2Y3dEd2QrU1JEeVB4YzB5YWh4V2RxMExBTlZXZ1g3?=
 =?utf-8?B?dVRvN2U2ZlRuUThLaG9WU1VPYkVhamNEVDhlR0dia0Z2blRBL2RLTnQyY3FG?=
 =?utf-8?B?ZkZ3L1hPQm1hRWJWYTRwUklXWkgrWXhESnVoMjJZaDN3bm05NnlnTlRiOFN3?=
 =?utf-8?B?WmRSdnFsSzFVQVlONkx5andzS3lXS2V2OUdxNGZ4QXE2eVIxQXQxR3FIRHNW?=
 =?utf-8?B?WCswbUpLMjRBUWlvT0lZOFpFTXMyL2gwMEZDOFFHTjJHUG1LbmwvZVg0VUxX?=
 =?utf-8?B?ckhEQU1XTzFiQkVDTHZHOXFxTmZDeGVvSElzVHA3Ym1LME9UQ0h2eTJzbjA2?=
 =?utf-8?B?Wjc5dGdwMmJ1VSsxdUw2YzFocFN4YVVUbC84bUJQMjlNZkJ1UVZMZXBYdGZi?=
 =?utf-8?B?dldSRUQ1NE02aEJCSmR6NENOU0lEempNRzZaOWpxZTl6Z3p1WUpmSUtIR01J?=
 =?utf-8?B?RkxHNW0vNlVWQ0ZkRzVEZXkvL0RIN1UrSHRjN3A1Rmp4dWdTby9lOE4zVmdi?=
 =?utf-8?B?dGVyZkMrVzlwM2ovU3UzNHlmbHF2eWQ0Z3ZtM3ZqaCtRN29tSnFHcDExcjBu?=
 =?utf-8?B?WWVGRFZmc04wUHg3QVFyVHErc2JJNjVLTVN0MkppK1FvMnFWcEozT1BmNFZi?=
 =?utf-8?B?ck1JQzhyWnhuNWJtVVRIYnNnZ0g2UlhXc1F2QjhNTi9rOU1zY1lYODc1NEll?=
 =?utf-8?B?aGNMVkdhWG50bUxKcHVJek5yaU4xZUFack1iejFuZEFEV0xXNi95TUUzemhI?=
 =?utf-8?B?dFpUei9MWlN2M2pTN1BTSnVDdGN5OHQ0NDBxMlVjRlIza2RIQkl5OUJJTFFI?=
 =?utf-8?B?RmU4L2NoRTlYMkxwM0YxeXJ1ZmJHQnk3aHFjMTVCeXBQcktoc0w5Y01yQU55?=
 =?utf-8?B?YnpNU2lvNURtNWMwMUZReklybzVVanhFeWc3WnV1UGRHVnBLZmlQZVZxcThB?=
 =?utf-8?B?alhqMU5aditPMUs2MlRmZmxIQU9Nd3M4Z2w0bENxMHNUVGpBdkN4YzJYaHhO?=
 =?utf-8?B?YmRKMEtlQ0VNV3JDYUJNeC9KRnhnZlVtMldMdmlKOFJsZTVZdVd2aGgzR0lO?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c803096e-b89a-41f1-eb57-08dafd0b17da
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 06:28:51.2724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTqGgBqfivVVgu30P50t2vieCbJsZsXTO3voRU7yqGwpFGBvOG79gZzGCl6GvZZgAFOywKDKn3P/PMx19fDw3rpvTAjgOtvp0SW/1Ufew8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5067
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMiBKYW51
YXJ5IDIwMjMgMDc6MzcgUE0NCj4gVG86IHNocmF2YW4gQ2hpcHBhIC0gSTM1MDg4IDxTaHJhdmFu
LkNoaXBwYUBtaWNyb2NoaXAuY29tPjsNCj4gcGF1bC5qLm11cnBoeUBpbnRlbC5jb207IGRhbmll
bGUuYWxlc3NhbmRyZWxsaUBpbnRlbC5jb207DQo+IG1jaGVoYWJAa2VybmVsLm9yZzsga3J6eXN6
dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhh
dWVyQHBlbmd1dHJvbml4LmRlDQo+IENjOiBmZXN0ZXZhbUBnbWFpbC5jb207IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgbGludXgtaW14QG54cC5jb207DQo+IGxpbnV4LW1lZGlhQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgU2FrYXJpDQo+
IEFpbHVzIDxzYWthcmkuYWlsdXNAaWtpLmZpPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFJFU0VO
RCB2MTAgNC81XSBkdC1iaW5kaW5nczogbWVkaWE6IGkyYzogaW14MzM0IGFkZA0KPiBuZXcgbGlu
a19mcmVxDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZQ0KPiBjb250ZW50IGlzIHNhZmUNCj4gDQo+
IE9uIDIxLzAxLzIwMjMgMDQ6MzcsIHNocmF2YW4ga3VtYXIgd3JvdGU6DQo+ID4gRnJvbTogU2hy
YXZhbiBDaGlwcGEgPHNocmF2YW4uY2hpcHBhQG1pY3JvY2hpcC5jb20+DQo+ID4NCj4gPiBBZGQg
bmV3IHN1cHBvcnRlZCBsaW5rIGZyZXF1ZW5jeSBpbiBkdCBleGFtcGxlLg0KPiANCj4gWW91IGdv
dCBhIGNvbW1lbnQgdG8gZml4IHlvdSBDQyBsaXN0LiBXaHkgbm90IGZvbGxvdyBteSBmZWVkYmFj
az8NCg0KQmFzZWQgb24geW91ciBwcmV2aW91cyBjb21tZW50IEkgcmFuIHRoZSBiZWxvdyBzY3Jp
cHQsIHJlYmFzZWQgdG8gdGhlIGxhdGVzdCBjb2RlIGFuZCBiYXNlZCBvbiB0aGF0IG91dHB1dCBJ
IGhhdmUgYWRkZWQgYSBDQyBsaXN0DQpCdXQgSSBtaXNzZWQgYWRkaW5nIG9uZSBuYW1lIHRvIHRo
ZSB0by1saXN0IHdoaWNoIGlzICAiUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4iLCBJ
IHdpbGwgYWRkIGl0Lg0KRGlkIEkgbWlzcyBhbnkgb3RoZXIgZW50cnkgaW4gdGhlIENDIGxpc3Q/
DQoNCioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCi4vc2NyaXB0cy9nZXRf
bWFpbnRhaW5lci5wbCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvaTJj
L3NvbnksaW14MzM0LnlhbWwNCiJQYXVsIEouIE11cnBoeSIgPHBhdWwuai5tdXJwaHlAaW50ZWwu
Y29tPiAobWFpbnRhaW5lcjpTT05ZIElNWDMzNCBTRU5TT1IgRFJJVkVSLGluIGZpbGUpDQpEYW5p
ZWxlIEFsZXNzYW5kcmVsbGkgPGRhbmllbGUuYWxlc3NhbmRyZWxsaUBpbnRlbC5jb20+IChtYWlu
dGFpbmVyOlNPTlkgSU1YMzM0IFNFTlNPUiBEUklWRVIsaW4gZmlsZSkNCk1hdXJvIENhcnZhbGhv
IENoZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPiAobWFpbnRhaW5lcjpNRURJQSBJTlBVVCBJTkZS
QVNUUlVDVFVSRSAoVjRML0RWQikpDQpSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPiAo
bWFpbnRhaW5lcjpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQgREVWSUNFIFRSRUUgQklORElO
R1MpDQpLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5v
cmc+IChtYWludGFpbmVyOk9QRU4gRklSTVdBUkUgQU5EIEZMQVRURU5FRCBERVZJQ0UgVFJFRSBC
SU5ESU5HUykNClNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4gKG1haW50YWluZXI6QVJN
L0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRSkNClNhc2NoYSBIYXVlciA8cy5o
YXVlckBwZW5ndXRyb25peC5kZT4gKG1haW50YWluZXI6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMg
QVJNIEFSQ0hJVEVDVFVSRSkNClBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0
cm9uaXguZGU+IChyZXZpZXdlcjpBUk0vRlJFRVNDQUxFIElNWCAvIE1YQyBBUk0gQVJDSElURUNU
VVJFKQ0KRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPiAocmV2aWV3ZXI6QVJNL0ZS
RUVTQ0FMRSBJTVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRSkNCk5YUCBMaW51eCBUZWFtIDxsaW51
eC1pbXhAbnhwLmNvbT4gKHJldmlld2VyOkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDIEFSTSBBUkNI
SVRFQ1RVUkUpDQpsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcgKG9wZW4gbGlzdDpTT05ZIElN
WDMzNCBTRU5TT1IgRFJJVkVSKQ0KZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcgKG9wZW4gbGlz
dDpPUEVOIEZJUk1XQVJFIEFORCBGTEFUVEVORUQgREVWSUNFIFRSRUUgQklORElOR1MpDQpsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcgKG1vZGVyYXRlZCBsaXN0OkFSTS9GUkVF
U0NBTEUgSU1YIC8gTVhDIEFSTSBBUkNISVRFQ1RVUkUpDQpsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnIChvcGVuIGxpc3QpDQoNCi4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCBkcml2ZXJz
L21lZGlhL2kyYy9pbXgzMzQuYw0KIlBhdWwgSi4gTXVycGh5IiA8cGF1bC5qLm11cnBoeUBpbnRl
bC5jb20+IChtYWludGFpbmVyOlNPTlkgSU1YMzM0IFNFTlNPUiBEUklWRVIpDQpEYW5pZWxlIEFs
ZXNzYW5kcmVsbGkgPGRhbmllbGUuYWxlc3NhbmRyZWxsaUBpbnRlbC5jb20+IChtYWludGFpbmVy
OlNPTlkgSU1YMzM0IFNFTlNPUiBEUklWRVIpDQpNYXVybyBDYXJ2YWxobyBDaGVoYWIgPG1jaGVo
YWJAa2VybmVsLm9yZz4gKG1haW50YWluZXI6TUVESUEgSU5QVVQgSU5GUkFTVFJVQ1RVUkUgKFY0
TC9EVkIpKQ0KbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnIChvcGVuIGxpc3Q6U09OWSBJTVgz
MzQgU0VOU09SIERSSVZFUikNCmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgKG9wZW4gbGlz
dCkNCioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0KDQo=
