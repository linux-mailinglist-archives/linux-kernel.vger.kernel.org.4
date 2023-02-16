Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1286990DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBPKPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBPKPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:15:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F99518CF;
        Thu, 16 Feb 2023 02:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676542548; x=1708078548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iBh1qSL6OGiyBvkZBuRiIfurm8m2inIDXgw5a2PlqxA=;
  b=jFZrySM13zxyXqaR2GX9zbrxWqu2/Pg4ppQ9436gMRpHL+h8KYJYKuaE
   lUl72hJ2LXOQiYCwrWtxDZI/4YRwyNMp4T+bIMlb4xd/N2Bryk32gbYzn
   f+aDzZNrksgSejpERqumxT5Hc2hlU7rlIk6L94/4Y1hzlba3qxpx28Vah
   IVNftEoDoQ71l/rqwjn/iPfQH0+1SYCzr9OJZoK9n7DBJgHFvxKj5mYXA
   mkaB1RDcXVDViVjzG/6tge/pFPjKlJdGxtXtmPVJVhE4njRtqG451wgdE
   Q9Ekj/NV0V6XEG6VG0oje63tVMl8VnYYRCDNfDYP7YAi6/sRjn84oxXR7
   g==;
X-IronPort-AV: E=Sophos;i="5.97,302,1669100400"; 
   d="scan'208";a="201231916"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 03:15:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 03:15:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 16 Feb 2023 03:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJaQs5p2JwYnX01SjEPlrVyM3Zl879wTOwYnaVLogqvEBhTV9MK7fYkY8Gs/41JHd4L+YtfewxrwJh0BwBZBG7dnTXq9wORwre0BO9CAjouVXorqnU05QFokSA0ep47RT831m89vZwoeYcOox4T2QAzy+zTRmW01+XRdoCMhYccE3eSvgBJphV2hYnZ7islnFt0+iPi31jJ5j1Z4j/OkCrHmeKgHjhyXhql4DfqbAaItbpGYJUW/ZfVY/TnwoVgP7OpACi/PJxsOGdeoGtA8yXbdEGDXpRXQN1nibUQwG5JRkvQTRLBwNIqo5TZDUgX06QEym8a8+C70oB6MQW6U0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBh1qSL6OGiyBvkZBuRiIfurm8m2inIDXgw5a2PlqxA=;
 b=Zs2GlonKEr1hLj5I0BBYcq0icUvXm0/9+atQLrpffryKwNLUH9Q7X195pe0UhUHF/JaGPUw92458/KVddBHZJ4mZAkRhoVhOVmeSWqyD+pvTidWluT1MQCmcvIjg+JGlYLS4y0MFsPa7n50Q85wK7v3xGQUYlSw8Z7z4ZWYsc90HTtSgFUIhiYQxrMzEHBayDxg4WmLUvpQ/7W/QKT8zOEmTG58KMm2tt9QyBQ/dcZmuWrpPSDaxs3EHxAvMAARlg6OuopfOV5bJM/SKjSBBTy7IahNBnn6lSv5pU47JAiGWa4Hm4nr/X5XPCeFXAfUOr2ARgLA1ucEExk5TjzOgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBh1qSL6OGiyBvkZBuRiIfurm8m2inIDXgw5a2PlqxA=;
 b=L4UzcbIFZsfuVdjNRU+ak42YhptBurKc7uiPcmf+jDcps2rdCO5m0nHweuqZedhcgc343UiVzTrxVMOJu6moxqI6/kqJ4L4AeW2eRE/dT7vJ0pgGsi0JBsBDe8KMVfHvnEom78NSo65QyZUmknl2tATUhGbfpPJ1J84pKpqJ+3A=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 10:15:43 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::6eb8:36cd:3f97:ab32%5]) with mapi id 15.20.6086.027; Thu, 16 Feb 2023
 10:15:43 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <perex@perex.cz>, <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: sama7g5-pdmc: add
 microchip,startup-delay-us binding
Thread-Topic: [PATCH 2/3] ASoC: dt-bindings: sama7g5-pdmc: add
 microchip,startup-delay-us binding
Thread-Index: AQHZQe+fioCt8Bzs7ESam1aCCH/Vsg==
Date:   Thu, 16 Feb 2023 10:15:43 +0000
Message-ID: <954cdf90-c41a-4e21-31e0-88a0baf26065@microchip.com>
References: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
 <20230214161435.1088246-3-claudiu.beznea@microchip.com>
 <485d74fe-bfb5-c55e-724f-304476624abd@linaro.org>
In-Reply-To: <485d74fe-bfb5-c55e-724f-304476624abd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|SA0PR11MB4621:EE_
x-ms-office365-filtering-correlation-id: c7e63bba-13b5-4885-1da7-08db1006c334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKjb+iM9VcWPWJSvMIJMAV4z3Kon2UjbtcW5KIyex3ZrlnZIB/xXEWyHZgT8eHREbIyIvQHqD+TfrtHpeI+1J3is7I4Pz8gx8dJbWrFNeFS1oSYGEUbasGIBuYhnZN+bRyMHHUeJQRbK5PIaseqz4k+ZxKUd3Gl7jx1hSUKG+ggHMzOQLl2RWSSPm4b7jTb1wBIHP06JTDdDZsMemRwHXK0AuXMwpFXU7AKxl/nn34GOgJM0qfp+oN+6/7HQ+T7CkWFffvSjpfP45ehBH9tuIjHCL49cj7nLEa1VxIUX1u4jTl6yXyqM8Tq9IP0u3+5Yby+m4W+xBg/QGOGFykXRA90Ike+bYmEboPSZG74Q1TO1pj1U+kJDmb9R4zru0swbiiWu6wWZDgnI+tLa2RPIyPCDBPPVZ9OnoN3Q3Hezq6LJheoT/T1iAbnhN/Xoknd0AodRttvx+T7H2qb5Wo+7pNG6lhYekTbconY5d3mvXAr0Rm+wGzUnjyhCvTgLOdz/kT+xx6T31iw+Z6XVyiGqGfRnyEPYgyDSYURvRvWRpn5po3HYpvWQCZE+g2vubSSzgx8pqCoXz2oXrwJR/8NHN+5zxswtiOYHRO0j2z8lT2iPCTvHy9Sp00igm6EmKAsfoPlIQz58FnNkoZTLH2bXSQCiztXuVXR1HafUMC0hcbISf3pez2eX40DtaXB0Q/0U6go7O094rT7hp8HleXXt7jcCa4M+bfmj0TXWJ0K3vOGiUdPfFBmZhW7RR7TFzjdfhIl+Agi7Y4VVkZFjlt1tyTxgCHUQZpgSxx/o6rxPei8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199018)(36756003)(2906002)(86362001)(31696002)(2616005)(122000001)(38100700002)(921005)(38070700005)(91956017)(8676002)(64756008)(66556008)(66946007)(76116006)(66446008)(66476007)(54906003)(110136005)(316002)(8936002)(7416002)(5660300002)(4326008)(41300700001)(6506007)(53546011)(6512007)(26005)(186003)(71200400001)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3o4QzN3SUJtVkNYMmdKcEtUWVkxWjBCN0lTYlU1Mm9keEhsK2Y4eC8xOW1C?=
 =?utf-8?B?U1A5QWZ4QUg3cGE0YWozQytNU2RQVzlPMTVuSVZxYnpkSXM5MWdqcE54dWZ4?=
 =?utf-8?B?NXBPeXZ2TE1iYzlQVExDbkVxeFlhTXVBRlh5QmJ6Y29HRThmc2U5MTdhY3Bt?=
 =?utf-8?B?SGhsZnUvTzJ1OFFqVXdEWGorak4zZ2tURDNkaUNrSm5KR1FkdUt3b1ZTMXpQ?=
 =?utf-8?B?OEdQY0t0S3o1RXRrKysxOThyc2JOOFB1MXd3bk1KeGltdGJCUm4yKzdLU2pC?=
 =?utf-8?B?MTVocndtcm9CaFhLb2pTaEJOdml2VHFjNnpNbEpGM0JuMGIwUHJxVThnVlpK?=
 =?utf-8?B?eCtFZGkxeUowd212c1pvL0JESzN2b2hoN2FxSklBK3NGQjFqT2R5MmFCbi9h?=
 =?utf-8?B?aTVyVXdSUWRGZ0Rld1p0T0J4dW5ES3lpcDhUcFpIZnFjdGJzczBnbVF0dXdz?=
 =?utf-8?B?MmxoOE1DMUg5MFVYczZEeXpkdk8rck5ZTVVFbEtoNFFuS0h5bVRFUXJqMU1B?=
 =?utf-8?B?RkswTUdxaGZHS2RmVmtZZTVmWWkyeDdwSkhQR1NlOTJkNXNJS2ZxNWEveHN0?=
 =?utf-8?B?SnRxd3RvYXJsSW55aUNsdFp6MmEyMjdFemp1ZUZudDFUb3FxN1g2Sks3dDU5?=
 =?utf-8?B?UmJsU3dKQnMzVmxhOTJTUUZyTkhySG81azdLZElLaU9mMjYwaUp1YmlLc0hC?=
 =?utf-8?B?RHNYaDRqSUJaWHkyaFd2MnpqekVrN013MzVkK0JnZmdVaEg1NWt3N2tjOXNR?=
 =?utf-8?B?enFBN1YzTUhramJjc1JDL3hUNTQ4OFAyeDJsQnBwY1VIa0dzZkI3TkhrVkpi?=
 =?utf-8?B?TVdhMXlaVnhSUlBnMGJDd3Z6bVJ3Z0t1cnJ4Q0tnZnhTM2E4UkNoUy84U3l3?=
 =?utf-8?B?clFsSHVFTTVOSFVtVFFoNjRBV0tuMlFudzFFdWk0Zld6VWxTVmxaRlNvRDNU?=
 =?utf-8?B?MVB5eXJ5cU8rREIzTkFpMU82NFdRaUNWb2hqWXF6TXlqQ2RYU1ZqeHNVOTgz?=
 =?utf-8?B?S0MyYk5PRW9tSzdkQXQ0VzRSemxRTnZSY01mSjZmL29WN2xFRXl5Q0tkdHd5?=
 =?utf-8?B?MmljZWVKU0hGVmlGRjhqWms4djNZWUxJTWZmYlJiS2xLTTJkQXlaamFldU56?=
 =?utf-8?B?NFI4eEdCbDl4ZVhIMStQZG82WmRDSFQrQXNNazhjUlNQbU12a2VCZFJNRnRW?=
 =?utf-8?B?Q2tSbG5yMzN6bzhnc3NCU3BoT1hJcU9DbkV4WGZVR09jSU1hMy9hakVmdTNy?=
 =?utf-8?B?UEZQVjBVSEp4dHZESEErcTdlVFFQYUFXdzJUKzFQUzN2TmM4akdEcGhROXpj?=
 =?utf-8?B?OU1DdEVKZHh1Mk5HNWtaM3FNelF0V1l2KzFLaCtTMWVmWVFYaDVLTG1WYW5o?=
 =?utf-8?B?alJLR2dVRytuSHBWWjhBWU5DU3dvQmd4ZHo1R2NRUVl2QmppTXZVUGwxem96?=
 =?utf-8?B?cEh6Tm5RM3doRTdQajE5RElXVFkxTDFKaXB4eDcvRVRFNHlYQS9LcUoyRFpI?=
 =?utf-8?B?d3VrVGxjanA2RVVSTmhMbXFWWENKcURZdEU2YTZubDhNNFczUEp6RUx2VTBU?=
 =?utf-8?B?dWVmVkFwV3ZCUmdJUGdDbVY0K2JVdnV4U1RwNW1vYmtCVWkyNFp1cWpNR0Rr?=
 =?utf-8?B?ZUZTSE5QRjlQMklSWHpraFVvNS80K1NwZFlFSkpoU0xkZDJ1SkxQb1JDTGc2?=
 =?utf-8?B?NW9HOTJxRUdUSVZqdTNUTFQydnU5THkrYmtmT2RSUFNtTzUwSmNBUUZvdU1x?=
 =?utf-8?B?VWg0ak54TDlNYzR4Rk01VE9GVUJlTzZPdkZLNmkvcXBPS1o5VkVaRWFRakFW?=
 =?utf-8?B?bTM5VEZ4cFNyK00wN0dmODcxcWEwaktaaGI0dEMxL0xia25xMjFOVmxTcUsz?=
 =?utf-8?B?M2cwOEU3TUhqS1F2dVFJa0Qvbk1iSlU0eEQ0VUZHUGY5MUh5OFI5YU1iei9H?=
 =?utf-8?B?bmhMVmNsYmJhR211VXhVdHdLVUphOUFOTGFzKzdQekVQKzEzVnMvMmhUd3Rw?=
 =?utf-8?B?MnJ6bEJXb3AwQlZMMGpPaDQ1MG4xbWlSMTM0YUVBN2RENzljbWVnSDdicDZn?=
 =?utf-8?B?M04xYW8vdVlVSVI1UCtYWFhVU2xybDhEeTZSVGhBK281bXRzWUZuVjNYcXVj?=
 =?utf-8?B?RnhmY3pKUUM2Q1lpWjZmTnhGK2JqdUFUazcvVkdRZFFVdXFCaDhYU1RjaVZK?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4120F08A137344EBEAFE6D695F9490F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e63bba-13b5-4885-1da7-08db1006c334
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 10:15:43.3252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTxga0q7eoeq8H0fp7VRj8qYA18V4zd4lQhWfr5GtxE7qFGhpACx7m5mtGhZsH9ZBcKJiLiAsOlAEvJIYq+2sbmWoCp7CNYtDcMxZiR8ckM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDIuMjAyMyAxMjowNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxNC8wMi8yMDIzIDE3OjE0LCBD
bGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IEFkZCBtaWNyb2NoaXAsc3RhcnR1cC1kZWxheS11cyBi
aW5kaW5nIHRvIGxldCBQRE1DIHVzZXJzIHRvIHNwZWNpZnkNCj4+IHN0YXJ0dXAgZGVsYXkuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3Jv
Y2hpcC5jb20+DQo+PiAtLS0NCj4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9taWNy
b2NoaXAsc2FtYTdnNS1wZG1jLnlhbWwgICB8IDYgKysrKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc291bmQvbWljcm9jaGlwLHNhbWE3ZzUtcGRtYy55YW1sIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21pY3JvY2hpcCxzYW1hN2c1LXBkbWMu
eWFtbA0KPj4gaW5kZXggYzRjZjFlNWFiODRiLi45YjQwMjY4NTM3Y2IgMTAwNjQ0DQo+PiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWljcm9jaGlwLHNhbWE3
ZzUtcGRtYy55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c291bmQvbWljcm9jaGlwLHNhbWE3ZzUtcGRtYy55YW1sDQo+PiBAQCAtNjcsNiArNjcsMTIgQEAg
cHJvcGVydGllczoNCj4+ICAgICAgbWF4SXRlbXM6IDQNCj4+ICAgICAgdW5pcXVlSXRlbXM6IHRy
dWUNCj4+DQo+PiArICBtaWNyb2NoaXAsc3RhcnR1cC1kZWxheS11czoNCj4+ICsgICAgZGVzY3Jp
cHRpb246IHwNCj4+ICsgICAgICBTcGVjaWZpZXMgdGhlIGRlbGF5IGluIG1pY3Jvc2Vjb25kcyB0
aGF0IG5lZWRzIHRvIGJlIGFwcGxpZWQgYWZ0ZXINCj4+ICsgICAgICBlbmFibGluZyB0aGUgUERN
QyBtaWNyb3Bob25lcyB0byBhdm9pZCB1bndhbnRlZCBub2lzZSBkdWUgdG8gbWljcm9waG9uZXMN
Cj4+ICsgICAgICBub3QgYmVpbmcgcmVhZHkuDQo+IA0KPiBJcyB0aGlzIHNvbWUgaGFyZHdhcmUg
ZGVsYXk/IE9yIE9TPyBJZiBPUywgd2h5IExpbnV4IHNwZWNpZmljIGRlbGF5IGlzDQo+IHB1dCBp
bnRvIERUPw0KDQpJdCdzIHRoZSBkZWxheSB1c2VkIGluIHNvZnR3YXJlIHdvcmthcm91bmQgdGhh
dCBJUCBuZWVkcyB0byBmaWx0ZXIgbm9pc2VzLg0KVGhlIElQIGlzIG5vdCBmdWxseSBmZWF0dXJl
ZCB0byBkbyB0aGlzIGtpbmQgb2YgZmlsdGVyaW5nIG9uIGl0cyBvd24gdGh1cw0KdGhpcyBzb2Z0
d2FyZSB3b3JrYXJvdW5kLiBUaGlzIGRlbGF5IG1heSBkZXBlbmQgb24gdXNlZCBtaWNyb3Bob25l
cyB0aHVzDQpmb3IgZGlmZmVyZW50IGtpbmQgb2Ygc2V0dXBzIChQRE1DICsgZGlmZmVyZW50IG1p
Y3JvcGhvbmVzKSBJIGludHJvZHVjZWQNCnRoaXMgaW4gRFQuDQoNCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQo+IA0KDQo=
