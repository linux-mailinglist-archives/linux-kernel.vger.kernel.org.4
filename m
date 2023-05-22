Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2382C70BAE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjEVKzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEVKwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:52:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28FF9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684752703; x=1716288703;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YxyqbOzzyt2L8w6Uda2eBenjVxLLgvCcax98ZmUk/aQ=;
  b=ETxv2TxT6QaHTSS5+8Z662iOfo0pFtNXjru1GmoXwp/3NM4gK45XJnBu
   lWST6FSkthlapA3krgSRfH0R65fZ0VcEgfi6Oz5+n68M8yaWxPWouIKMM
   vJqMpOEMVlhFvCnvm/lx5AjjVCmj0Fm/P14tX0FRsNlQs5gykK6ytYKHb
   dVvmkTiBk8EZuvfHqqGi1LJjc7Y/G0Uczm1FreSczOpwSG30xyV744sXh
   QY84jDsG7+2EafkSrrcADHqDqn5c2A64LTGJnz3xyvtxlssKU3Zc2s2PB
   SSRBo/9W1keHRweNCikBXa0i1JbqWbvWilyCURIAj1Datrd3PMlMJwerl
   w==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="212445512"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 03:51:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 03:51:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 03:51:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZYSPXTMF0NcIYgVx9e0ssD1WujP+Gd4v+9S0nKG+9oEesJ8DgxEspZJoVvzhxnfU0h/ji2CtaXDwCX7kelPPZFc1eLLugBbqA4/xnH+gFYJ8bfpo3vqTy1QQyQ1YzF0wbJHOVvbVAPb3gq0SoULLOGXauIsij17/hQPW+QxK2IPCZyGnpNmktKA45aPLVq+nJbTsAUxhpIZytqQ+uayboI+CpZTK7kAFMjC0xocN+lyk2aMp1leuHfaoHE61JwbU1ddckUhRfMWgkFJ6edobJG12nCGFUFvo/QgnLz32kxaUmo6sxZfcAuZbuCiVThZ094RAookQ9bTPrzSYBm2/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxyqbOzzyt2L8w6Uda2eBenjVxLLgvCcax98ZmUk/aQ=;
 b=bYmBQlJm521LAZrJUMeV6eWtZzoPfKGhpvqliCcxE3xj9AmtBy4GU8HNP38L9fWo17w8jCGb6HhI1ekyY8yHiSaD0oEJTnDLk5NW1GAp4XO221NJcudcEdnEAcBzGExHFK5R0qkxqaJ05L7VQYj59tjCStwsJr1oGpzVyL5TuJENNXBSqVfNd1GTtYAFdHKRfXUu7i8ce35mlk6sLQN/DHJbUncYYVih9vPsMu7Xqkf5P58vw4cM8U4ZsRZgya2PoCWjK5xCSLwV2OYVSy70/pB5fXbmznPnjB0bLJVt6GFxcIjNlROve7FC6MDLcrGJ1VydDnbe+X9d9p3UlTmvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxyqbOzzyt2L8w6Uda2eBenjVxLLgvCcax98ZmUk/aQ=;
 b=RIEXLZ5MdsL766tRDlWduk2ITQO2QIOFSP6l0NPz9ckBfexCLQ3yLo3WxYo6wXRh1lO35FAeBcUuVjZMMQAKyZzynR96pmBDFcY4foeDN17sEFTRd8w2jRazI/g8UoqgS+HoR6tgnKuAs3BKj7FdWO9Y2G+gWXSVq9Fr+QAJkvg=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by CH0PR11MB5283.namprd11.prod.outlook.com (2603:10b6:610:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 10:51:30 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 10:51:29 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Conor.Dooley@microchip.com>, <soc@kernel.org>
CC:     <conor@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <Lars.Povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <Daniel.Machon@microchip.com>
Subject: Re: [PATCH v2] MAINTAINERS: update arm64 Microchip entries
Thread-Topic: [PATCH v2] MAINTAINERS: update arm64 Microchip entries
Thread-Index: AQHZjJtdEvZyTJDfIEqwBK+O8axA6Q==
Date:   Mon, 22 May 2023 10:51:29 +0000
Message-ID: <14404185-93f3-965f-e6ef-8e1285250c95@microchip.com>
References: <20230522-wagon-stencil-a164ec39322a@wendy>
In-Reply-To: <20230522-wagon-stencil-a164ec39322a@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|CH0PR11MB5283:EE_
x-ms-office365-filtering-correlation-id: 35a28b54-cc26-4326-038d-08db5ab27fa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6GpZQJEzggkRIxRfe29tU2FO00GbHXF2Oj/SkQErP2DR15lVRuW4o5L0duI6HE9qdxCrIWQYGe57HcQz5LaFlgPEJa2yixWXE8er0JurX9CiawPyk+smTVJydBYTkLYADzsb4qD47QXsk3wDbpjiJsRQ0768lXBEQ6IC8egqAWrfl+Bv9nF5AYRJ7yLnhnvKP8PSarLJ98QdVDcNw5+d15/ylWUsZa+67wp4dTeoBQaGLJF60kLNI+jTjEbI/KFKO62Pxh8K9NipQXJicSStoxYz3XlS6QolaPweP2nLWzAATmhV3Tmhhx1eVtbCp2yvaUDoSqqGls9SenLZ1kwuZ8EGjGr71WFpbIxDjF65tN0Sc71dOR6hfwGyA8xY7ZLmcrr8auAbXx+RF92Wbxu0LEjE5nSRnjHrJBsU2DwYMTprTiPSdAnnPLHqwCTRRQZUuOvKaSJYDlvXSjmpHuDc1aN/tR/jwpdOrlU9ihqT3tM4QtyUlvwIKonHF6N8jLBBl3a6u+F7rPTMR+kFWa95j81VqWd0jgwuqp++YMHr5uh70GpH76ryJsmWks2vCMq6shUU8S7VN/MMSQqg6LUhvnFi53/nIO9HX0IaF5rbWq5+gNOPYUbcGYQMAn/MJcVyeK1xS9J+npOT9hPtxCZfBCBnrYpE5Lkfp2UJh6clH10=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(31686004)(2906002)(110136005)(54906003)(15650500001)(5660300002)(8676002)(8936002)(41300700001)(91956017)(76116006)(316002)(66446008)(66476007)(66556008)(66946007)(478600001)(4326008)(36756003)(6486002)(64756008)(966005)(71200400001)(53546011)(6506007)(6512007)(122000001)(38100700002)(31696002)(86362001)(107886003)(2616005)(26005)(186003)(83380400001)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3oxMDczczRtRFZoRmk5M0NYcUNXMXorOGxlTldCcEhJN09ONzVVcDAweHJK?=
 =?utf-8?B?eFp3RUxnZDNXdTluMk5nd2loOWlDY05MV1NlUEV1SDZpcU5QOXhmaXlGdngx?=
 =?utf-8?B?WGx1K0RuMHBaR1U2dEZzRkZweTZNdkJkMTBVcGhNTXR5OUpKdUhCdjVkN09L?=
 =?utf-8?B?QUl5Tk5JK1ZxVzVNbldGcXM4OVpEZjNQaVgyM3hTOXBiL0tRYVNDNDltUlVR?=
 =?utf-8?B?NUVIa2xMVXd3cFFEbkJ4cUlVMENjVnZrRlJqNVhuYjhFeG53eHkycXhMUGJi?=
 =?utf-8?B?L3l6SGk0N2x3L2UzWWNjeHRxSCtIU0JYaW5WTVp6S0lwbkdLMVd6dndXQk1r?=
 =?utf-8?B?NXUxeE1aZEdWSTVYdjJmZHE0dXZYcHpZbnpSR05tRUVxOVArNmNZOWhoT0E1?=
 =?utf-8?B?bWQrMkVSKzAwOEIzbENaSmRyT0djK0JYMjI5a0x5N1loYnN1QzkrdzJkV0Jz?=
 =?utf-8?B?OFdRUFQ4NmhJM1ZDUTBNYmx3NnFIa1BzTGRRL1NyWjRQT2NyRWM1V0c2UlE3?=
 =?utf-8?B?ZU1QMEI3a29GMnZyWTlWWTBBdUt2OThENWpXZTJlUk55SXNCYmJCam5pZk9N?=
 =?utf-8?B?RlAxN3JCNERXd2orZENEWFI0a3JUbkhUelY1T2pvZ2c5Z0NhVTM1UUxudk5W?=
 =?utf-8?B?YVdrRnZBY2JKdUFOdDc4U2hKVFF1NzVJMmltTkZGQmUzZDk1YnFVV24zTnJq?=
 =?utf-8?B?VDFRSitzMG8rUWxlS1dmT2htUTZscDRJSDhjTGtJcXh4bng5d2tVN0l2YWJY?=
 =?utf-8?B?dVpEaGFiV2dlRFFGQjhOQWd0dE50dUIreHZMYXlFeTFOVVpHL05nK2k4L0F4?=
 =?utf-8?B?VzNxcmJ2YUR5RWczTHJjcis0RnhLZk9keElmcWVuSVJERHlWTWRIeGgva2dN?=
 =?utf-8?B?K1ZHYWVRNDNzOGU0ZGtwSllqYmtnYVA5UXhiQXpCTDJna1M0T2lLYTJMNUZM?=
 =?utf-8?B?MFNUZzBici9iZzVLcE1EV003bXpHZWF5LzN4NGF6M0VSQmRWWjBvMmkwL1VE?=
 =?utf-8?B?Ti9RMUNHa1dXR3ZOSGpVR2xLNW9Ld3RPMmNmVU9YREk3b0tXWHFtWUVsNy9o?=
 =?utf-8?B?c0h1bHUyaGcrdm94RjFoRzAzUXQzWHRhaFlTWkp5RE5MeUdZd2dtNWorNEh1?=
 =?utf-8?B?Rnp3NEVqZEtUdGkySkQzVWxEN0l2emg2QW9YeHQ0NGRMRHJVSklYUFMvUzYx?=
 =?utf-8?B?ZEwvdG91ZWE3cGJ6aWVkWHBUZFVEWm9RNndPaXd1blduMDMyN1NJS3pOczdW?=
 =?utf-8?B?TkJwcHZGYTQ5MXdjayt4b2Z1K3RKMHZ0QktLY3lUSk03VVlPNUh0aU5PWGtV?=
 =?utf-8?B?TFBxcU05Z2E2VmJLanVCZXcvek9OcHR2aGZKeEZSVzB4bjlzakxlUkN1ckJV?=
 =?utf-8?B?SlRqSmtVSk9rdUNObTJPRWpDVmorMjNSanB3dlJ1RDdyY0RKQlpvOHFoWGFj?=
 =?utf-8?B?RU1kTVI2YUp4bUVSbUNKem5aWERtZXpGSXAyaVk0cHdrZHBqRjJ4MWE3MDIw?=
 =?utf-8?B?bFUzNmxEUkZPSzQxaW5CVEphUEIweTg1dDNTTGhNQkVqK2lEbFMwd1BueXZl?=
 =?utf-8?B?WmJwejFFVjhxNGtCSDlzODViUGxRcVQ3bFRlSnE0bzhlRXB4NDVEaVIwbk8w?=
 =?utf-8?B?ZkhITGVnRDVaZXVpY09lY3NTNnMyd3FaQThEMWFzdGFUUGJkOTM3N0gzMFVi?=
 =?utf-8?B?Q1RMancrVk9YbWlRUGM4cm05Rm9aRlpQVlhoQnljRldFQjBveVF1VHlOVTVI?=
 =?utf-8?B?ZGJuMlQvQjVoWEQ4L0xlRm43VWhNWmJDdkdDdzBqODBWQUlqcW1hTWp1MlpQ?=
 =?utf-8?B?enUydmFHUU5FN2o0RWszSkY0ejFJUG1MdFZHejVuWVlFYlNEcTFMSlBJYzl6?=
 =?utf-8?B?TmtGUk1NYzdyb3pIbFB0NnNkbGZHNnhKMDNHU3dwMitTaUhOUmNUUU9IbXpo?=
 =?utf-8?B?TzJyeXVHOTlLRS9xakRuU0VOTVgrbjlEYUp3V1ptc0lScnp0MThzejdLYlFi?=
 =?utf-8?B?b3VhdGpiZy9JTEZVbjBScmJGTjI4Nkd0dTVONUtRQ2tLOWo0WVpaNzNtV05Q?=
 =?utf-8?B?cEFqYVErWkt2dTF1SFEzMDR3bXZjN21QMWdtb0pVSW9SMHlrWXpqRTNxckdH?=
 =?utf-8?Q?aViLWLgOKN5MyUZxyQDNA4EnV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E0366B44AE98240AEF6D773246709A0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a28b54-cc26-4326-038d-08db5ab27fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 10:51:29.5004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbM4sXpwuDHAoYrWI+RJn3WWHjavL0lsJcQbG/MyhWtX4WvBiJXubSqzfFwJZILwSVlnk1Dg82c8DiXwlA/gQQEn+4BNNeQux6fRCgDnaYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5283
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDUuMjAyMyAxMjozNywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBLcnp5c3p0b2Ygbm90
aWNlZCB0aGF0IHBhdGNoZXMgZm9yIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWljcm9jaGlwIHdlcmUN
Cj4gZ2V0dGluZyBsb3N0ICYgdGhlIGxpc3RlZCB0cmVlIHdhcyBpbmFjdGl2ZS4NCj4gDQo+IE5p
Y29sYXMgYW5kIEkgYXJlIHdpbGxpbmcgdG8gc2hlcGhlcmQgcGF0Y2hlcyB0byBBcm5kLCB1c2lu
ZyB0aGUNCj4gZXhpc3RpbmcgYXQ5MSB0cmVlLCBzbyBhZGQgYSBuZXcgZW50cnkgY292ZXJpbmcN
Cj4gYXJjaC9hcm02NC9ib290L2R0cy9taWNyb2NoaXAsIGxpc3RpbmcgdXMgYXMgbWFpbnRhaW5l
cnMuDQo+IA0KPiBEcm9wIHRoZSB0cmVlIGZyb20gdGhlIGV4aXN0aW5nIHNwYXJ4NSBlbnRyeSAm
IG5hcnJvdyB0aGUgZGV2aWNldHJlZQ0KPiBwYXR0ZXJuIHRvIGp1c3Qgc3BhcnggZGV2aWNlcywg
bGVhdmluZyBMYXJzLCBTdGVlbiBhbmQgRGFuaWVsIGxvb2tpbmcNCj4gYWZ0ZXIgc3VwcG9ydCBm
b3IgdGhlaXIgU29Dcy4NCj4gDQo+IENDOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
Pg0KPiBDQzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5h
cm8ub3JnPg0KPiBDQzogQ29ub3IgRG9vbGV5IDxjb25vckBrZXJuZWwub3JnPg0KPiBDQzogTmlj
b2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tPg0KPiBDQzogQ2xhdWRpdSBC
ZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+IENDOiBzb2NAa2VybmVsLm9y
Zw0KPiBDQzogTGFycyBQb3Zsc2VuIDxsYXJzLnBvdmxzZW5AbWljcm9jaGlwLmNvbT4NCj4gQ0M6
IFN0ZWVuIEhlZ2VsdW5kIDxTdGVlbi5IZWdlbHVuZEBtaWNyb2NoaXAuY29tPg0KPiBDQzogRGFu
aWVsIE1hY2hvbiA8ZGFuaWVsLm1hY2hvbkBtaWNyb2NoaXAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQpBY2tlZC1ieTog
Q2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0N
Cj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBhZGQgQ2xhdWRpdQ0KPiAtLS0NCj4gIE1BSU5UQUlORVJT
IHwgMTIgKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlO
RVJTDQo+IGluZGV4IDMxODI5OTI3NjlhYS4uOWFlMDdjYWE0ZTZiIDEwMDY0NA0KPiAtLS0gYS9N
QUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMjQzMyw2ICsyNDMzLDE1IEBA
IFg6CWRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0bWVsLw0KPiAgTjoJYXQ5MQ0KPiAgTjoJYXRtZWwN
Cj4gIA0KPiArQVJNL01JQ1JPQ0hJUCAoQVJNNjQpIFNvQyBzdXBwb3J0DQo+ICtNOglDb25vciBE
b29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+DQo+ICtNOglOaWNvbGFzIEZlcnJlIDxuaWNvbGFzLmZl
cnJlQG1pY3JvY2hpcC5jb20+DQo+ICtNOglDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFA
bWljcm9jaGlwLmNvbT4NCj4gK0w6CWxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZyAobW9kZXJhdGVkIGZvciBub24tc3Vic2NyaWJlcnMpDQo+ICtTOglTdXBwb3J0ZWQNCj4gK1Q6
CWdpdCBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hdDkx
L2xpbnV4LmdpdA0KPiArRjoJYXJjaC9hcm02NC9ib290L2R0cy9taWNyb2NoaXAvDQo+ICsNCj4g
IEFSTS9NaWNyb2NoaXAgU3Bhcng1IFNvQyBzdXBwb3J0DQo+ICBNOglMYXJzIFBvdmxzZW4gPGxh
cnMucG92bHNlbkBtaWNyb2NoaXAuY29tPg0KPiAgTToJU3RlZW4gSGVnZWx1bmQgPFN0ZWVuLkhl
Z2VsdW5kQG1pY3JvY2hpcC5jb20+DQo+IEBAIC0yNDQwLDggKzI0NDksNyBAQCBNOglEYW5pZWwg
TWFjaG9uIDxkYW5pZWwubWFjaG9uQG1pY3JvY2hpcC5jb20+DQo+ICBNOglVTkdMaW51eERyaXZl
ckBtaWNyb2NoaXAuY29tDQo+ICBMOglsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcgKG1vZGVyYXRlZCBmb3Igbm9uLXN1YnNjcmliZXJzKQ0KPiAgUzoJU3VwcG9ydGVkDQo+IC1U
OglnaXQgZ2l0Oi8vZ2l0aHViLmNvbS9taWNyb2NoaXAtdW5nL2xpbnV4LXVwc3RyZWFtLmdpdA0K
PiAtRjoJYXJjaC9hcm02NC9ib290L2R0cy9taWNyb2NoaXAvDQo+ICtGOglhcmNoL2FybTY0L2Jv
b3QvZHRzL21pY3JvY2hpcC9zcGFyeCoNCj4gIEY6CWRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jv
Y2hpcC92Y2FwLw0KPiAgRjoJZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtbWljcm9jaGlwLXNncGlv
LmMNCj4gIE46CXNwYXJ4NQ0KDQo=
