Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A980870F1FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbjEXJQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240605AbjEXJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:16:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDFA132;
        Wed, 24 May 2023 02:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684919764; x=1716455764;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3w1452oJrgqVtO7cVroc76oyN5u86ZxzKqeKO2tUyto=;
  b=IMha+IVCY734X5PezaGg0pj5vvDKyUAJSfkvZa9sc+ORvEa/Wx7oFLH0
   MV7ChHMdl/imjrIxhg1mTtrOq+MbBl1mptyW4Fj2nAwuozOHpqvOxqv/v
   MREP/tlsn6LtaXRuPmztHzrPB/WkwHxKEQXxCGg4kl8pvXWP/pZ/VvTmR
   QVIzl/10C2qnoI4PndTAdFCyuE/RiV0rcpUyHcpClHe0wR6zg/XPcuat0
   oN8gQSKbA0rVD6wrrv7LSWLG1tTQ6osEkXurbuEu/6zOLBD2+UD7gu7lx
   nFhMXxdOxyss2BO8O26m0tXAOJNWsAOVklCkRI69j7TZKkixQ1Yyo929X
   g==;
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="217022321"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 02:16:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 02:16:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 24 May 2023 02:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/lWIhlF2sVRMap1Cu5OwYXClRIDRYQRNfHm8Fc0TUtb9FBQK33fuVOBgUqH5zJzb3cRgxOL2YtP/NtYHVMRSJdpI92FiSq+2QlWuouY4XeupqySncDUfQRSjvPRcFmeNeA8Tclmt3QZFER+whLeTOhfQy/ip+MwvW8n0VOJBGTLIWBQL+U6fKMa0Z/pNwKZOj+Ri2zsL7eeUcgxvAw9xroQAGjw7mUEZbtaeXFDNX9xeN7FZSU2GwxsuuC0DmdsC5QKzdJpzEaUGbx92lCRUOPssOW0H7YvgJ4TGMqzTpvpkYkc2mO0jJU1zEBz0j3/LRStfTFuql40xCFnL/SZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w1452oJrgqVtO7cVroc76oyN5u86ZxzKqeKO2tUyto=;
 b=l4deGjK43/WYrCMlXYIr7xYtR5iAkbO/cKfkkNNAHZzOFOVHeU89XP8oIDr+diktefaPpIIJDCJAIOlLFxPr6gP1/V7tLR6XhH2i6sPVK2wixS9+fFxwykJ4RcZdXoHMATElkFrpNQCSaO9R/TsQjU1+G5q7e/V+4wKVl5h3zhQ3ZEpabo+dtpC/KnoiJ2IrwTP7JC1lfSsVvG8VOa0zcqURuBzDXLcA0KK5tiu5ruEHD+suKKbxL09mLRLgoNVOvLhANmsjiyGwPtFOCXhPE3jQ8n7/Dlf4vkmwmI5aqMI8+ZuPSLU8lMl+bYwQoWV5Ck+07f1JyrBbUd/qPVUpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w1452oJrgqVtO7cVroc76oyN5u86ZxzKqeKO2tUyto=;
 b=Mj0wQsEi6nymnEjKhEJu3e+wkD5+XshJP4XGGv4MfLETyt02ldlCXk0ZO3cjlfwZWzHhGcCT6g0QCgmbhGwplkAqZfD7mbRE9zCuGx5HfTB2ywaBq4zfJv7RjP7c5o6tpWWIrg0I8fbGjOtictbtUcTlKldBuBn5j67BFiqpXks=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by MW4PR11MB7152.namprd11.prod.outlook.com (2603:10b6:303:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 09:16:00 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 09:15:59 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2: remove extra line
Thread-Topic: [PATCH] ARM: dts: at91: sama5d2: remove extra line
Thread-Index: AQHZjiBaX2sGrLwrQ0SPuWzLICLccA==
Date:   Wed, 24 May 2023 09:15:59 +0000
Message-ID: <752a6654-0589-b3e6-8cdb-f0cf7dc13b08@microchip.com>
References: <20230522124812.107227-1-claudiu.beznea@microchip.com>
In-Reply-To: <20230522124812.107227-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|MW4PR11MB7152:EE_
x-ms-office365-filtering-correlation-id: bfadc3f8-4aa5-4080-63d1-08db5c377d49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zs5Dnb3/7q2tknALOyVobetCw1jNXlFt4JQ8HdotVy7Rjjqx4xqIt4C9tdE71YWINM+ler7dS+F8NbImoep9Aoi1Yqm4Ompx56hQokyZiGoDwuXYUvo1ku18OsDOBJ/JhqVHONbWjxEe8NuOrMBEH9FtESfus68U4eivBoXT9/zcHEVCkDsgEt1uFVquM4N0RJ7b2frZ81O/b1DJCYwMRcoIam8z7Z15OUxnERItbzvjT3J3qW07N8I3stkDRvfYRoZZed5aKFkLqfzUij5t9MzhXauxE4JKxc5C41o0Bf3T69BUKb2Ot+v4GExhYW0lF4HQpWykqCUzOGZi+1k+jtuItNW8BtowRmyXnM7QFFUAfVJPjBLn6QMVIyrvaCUpi2OMzG22Uh+3gjGzfMEmBLgHNT9cvsFcRRITpPPiR3CqtKJAB45e9DEFhzTspKILni0w4EJZHSOPdE444hdgHaqTojSu6DcRaFS5PDQcQe/fWg/G1Ko2pvXaLrDKp0ylG7TJuKcSK6iSH58l/RB86TKyDrT03M6MmKHF+jiSjNlEM3AutM+1mk0Hjabrh8wTE9gtn+eBwmcmWGir2vxrgo+ulPKHiiBLhv+PASjoDOvftPxcqx6QAnioDCTDvLp9XgbNTLpv5QM7UMUOm8ZNDc3UKQDU1I2ifjHe/excn3+yPcDC4xlGNTxGvatlAvOZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(31686004)(316002)(478600001)(71200400001)(54906003)(110136005)(41300700001)(6486002)(76116006)(91956017)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(38100700002)(38070700005)(8676002)(8936002)(122000001)(5660300002)(36756003)(2616005)(83380400001)(86362001)(31696002)(53546011)(6506007)(6512007)(186003)(4744005)(2906002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1R1ZTUxRVJDRkNQTElMTFYxZ1I3WmNINlhKV0djN1k4TURKLytZN0Nra1lD?=
 =?utf-8?B?SC92Z0dKeFpBVzVuZjFVVmpVaDVKb3h5c2NYeEZIcXhtc1RsTmYxejIwL0RD?=
 =?utf-8?B?dUFpSHVzSEZCZHh1WFpaNVFiTnlWWmZXdlljaG5ZbElnNk9TOEJsc2ZiZDI4?=
 =?utf-8?B?UTNibkpUQ2RnZ2VtT3FCMVgyUnN0NkFvNlpZVm42djd0YkxQZWZSL2UxYVVl?=
 =?utf-8?B?UXR4MEF1anVhNGg3ZTg4TkNheXRkc0JpaUpRcnhJczkvdFNURWw3U2JEb09r?=
 =?utf-8?B?dzI4WTI1Y3AxZGlUSy9STUtaTnFDZ3c4elZ0ZFZiV253TXp0clJYc0cwNTZw?=
 =?utf-8?B?THJpTTlvaEJTSVEvZnRDWjAremxPSDBNeWxqVTRMQ0F0eFo1NGxVZk9hMk56?=
 =?utf-8?B?SFRXSitCSzZ5TlVYcXFpWFA3OHVGZ2pqNWhTeTYvbHo3U1F3UU1vVmVreFM0?=
 =?utf-8?B?YjFHdkxNZWsvc29BSkhKcklMM2FoaXlDdmxsaW5tWnoxZHgwOFIvSVhnU2Vq?=
 =?utf-8?B?U0hTUWs0Yy9NQTI3MXMwT29XeG1zWVZHZkNkTmFIa01TQWZFVWlWT3M5RU9F?=
 =?utf-8?B?TXlKcjdkbUJmQlEzbDlCaW5sL0FSYWNhZUdnSXdxenN1MWZpSzQyWjFPYi9n?=
 =?utf-8?B?d2l4Mzg1K1FBTFpXZHJSdGwyV2VBYTBEWTdwa0JLYWNOYUFhL3BjWENBaW5z?=
 =?utf-8?B?RHQxUk5sbnJVdXQrUFpqdEY0TEFPMWtxMktDazRlcUh5YWlINUxlUnNqMHZG?=
 =?utf-8?B?U2tRUzQ1d1JxL0lUY21nVjZpS01HVGg4LzdDT2ZGd3BMb2puRWVSUVl4RHFK?=
 =?utf-8?B?MldUYkU2Rm1nRzNSU0diR3llMU45OUk5K0dlMldrRDZWRWgrR1FuU0ZOc3NW?=
 =?utf-8?B?ODF5LzZPOE1hZ2xpSm9CSlltaGxTL3JZekFFKzJ1Rk95c1RtckZZbmNocENm?=
 =?utf-8?B?VFVsendCN292bUszdmR1UlU5T3d2MjRtZ2kyemc1dVhJbHUrWkFBVGJxUmla?=
 =?utf-8?B?TThoZ0dIUTZMZStVZy9KOG93OTJrRzRxU0lqSjBzd09Eb1dNRFhXQVBrM3Zi?=
 =?utf-8?B?K1YyeTF3dldwK0ltTjEvTGh3ZUE5NzVlQjBtazY5S0JZbzJydVI1bTBIVmtK?=
 =?utf-8?B?YmxReWNoSHd1ZDBYcVhGdU9CaXRVV3dGT0ZzQWFoMmRYWUhERDZaSzZXKzlY?=
 =?utf-8?B?UVNRT1YzYjR1Yys4a3ZuRWRJOFpld1pZcFlLS051b3RCL0NISkI1eUZ4byt4?=
 =?utf-8?B?M3ZKTFJvdXZUd3lsMGgvc2FlM3FuTStEUXUyMHhyNEZlK3htN3ZDaGUza3FQ?=
 =?utf-8?B?c3FwZmpqWmIzSXpMV0V5N05CcFpyQXVFMTBhem5IZFIxZEZCdHFsNi9vQVp6?=
 =?utf-8?B?TzhyRWNmSWNtVXQwNG5qVWxINXgwWmZvRUdvdHVVMHdsNFBqS1l6NnQ2YmF0?=
 =?utf-8?B?cGJQU3o4cytqMldvN3Q5K1BJOWtoMlNRUHBDOHBJV2UwYlQ3WVNyTy9ZdjM4?=
 =?utf-8?B?SFhubEg1WHNiRHVKR21hOC8xRVpJN1R2L3h1K2VtZ05zQW0yU2FOZFhFL2hI?=
 =?utf-8?B?Yjc0ZzVzM3krMDdLS1RUTVdQTDhlQ0VXT2dvYkh4QlJhQ2NueVZZcjVIc0RT?=
 =?utf-8?B?bVA1dGttTXBqYTRVQnl4ODJmVnBGUHhPNkpJVGwyT281S2w1aGlOVkRlMysr?=
 =?utf-8?B?NHFyMHJ1S0FMakVHaFBTSjNuNFlsTlREb1hQcE8rVEJSd3hvSFZTVGxsTGtT?=
 =?utf-8?B?ekZ0cmJVYk9hWnJQU2lUMkZHS2Z2eWtEbHIwM29udW9rTXI5QlAxN3lXRUZS?=
 =?utf-8?B?T3c3cHJGWGw4VlNiSXg1ejZCek1uMVpLdCtEVlY2OG84Vi95NjVLL1p0cTI0?=
 =?utf-8?B?dXpPVGwxRDBsYmpJdFB3eXYwSWRKWmNGbGVVbUxXOFhETXB4MWxYbHAxVUZa?=
 =?utf-8?B?QU04ODl0QnpoUGVxOFNTNWUwazRONlpoVUxtaTg3ZWFQbUFtVUhjQ0draG9n?=
 =?utf-8?B?VVJYUzlqcEY1NDhPdysxQS9yQUQ0NnBybW9OYWhWazVKSklSa3YrVFlOWTdu?=
 =?utf-8?B?bUFrdUZ3K3d1Y2FRdG9RdDlmSSsxZ3JhdzE1RDZ4Tm9LZTZoS0pVS3EvOW1t?=
 =?utf-8?B?aS9xdk1rN1Zxc0p6ZEkyMDFycFhyUERhdmcwQzVTbkpobUpzQkw5V3AwUlQr?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BFEFFBA6B8BC944901825B64349CD80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfadc3f8-4aa5-4080-63d1-08db5c377d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 09:15:59.7862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekc64iobvuJwho3c5DBacpjEuFPbzJwNpZ2YJt38C9Ngz1CCI1Dreo1OLOVxxrFNRtVGzP0LvI/YI7MW7ZBEg7o2upxOSwA3G5MwSP5wJWc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7152
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDUuMjAyMyAxNTo0OCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IFJlbW92ZSBleHRy
YSBsaW5lIGZyb20gdGhlIGRlZmluaXRpb24gb2Ygc2xvdyBjbG9jayBjb250cm9sbGVyLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hp
cC5jb20+DQoNCkFwcGxpZWQgdG8gYXQ5MS1kdCwgdGhhbmtzIQ0KDQo+IC0tLQ0KPiAgYXJjaC9h
cm0vYm9vdC9kdHMvc2FtYTVkMi5kdHNpIHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRz
aSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaQ0KPiBpbmRleCAyNTZkMjlkNjY4MzAu
Ljc5NWEwMmIyZTI4MyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTVkMi5k
dHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDIuZHRzaQ0KPiBAQCAtNzA3LDcg
KzcwNyw2IEBAIHdhdGNoZG9nOiB3YXRjaGRvZ0BmODA0ODA0MCB7DQo+ICAJCQljbGszMms6IGNs
b2NrLWNvbnRyb2xsZXJAZjgwNDgwNTAgew0KPiAgCQkJCWNvbXBhdGlibGUgPSAiYXRtZWwsc2Ft
YTVkNC1zY2tjIjsNCj4gIAkJCQlyZWcgPSA8MHhmODA0ODA1MCAweDQ+Ow0KPiAtDQo+ICAJCQkJ
Y2xvY2tzID0gPCZzbG93X3h0YWw+Ow0KPiAgCQkJCSNjbG9jay1jZWxscyA9IDwwPjsNCj4gIAkJ
CX07DQoNCg==
