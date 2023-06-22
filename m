Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE077395E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjFVDsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjFVDsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:48:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E38D1BD4;
        Wed, 21 Jun 2023 20:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687405704; x=1718941704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FymOEy3uBRhsxAj17eH+2MvBJTfdX5oLX79mZSGP8sU=;
  b=zjSUBKBqAWSVRKVyf4HxGA2K2AYEYFmoQtNkt6adw6ektT2wNBOhsxa+
   BkzMk4yMV9ZABJ3Oq3SwhP2KgHFtDL89xdsnVhEWba3GX1ScEEMrzvA6d
   qbucBt3f3qFvSxrhBLGrN8E3zqvyrdRIORWravblGCmPFGEZV9GMh9xpb
   NY+AXquO4T8K4BFe5TKTB7ZaplwksWN0N6pf5Px+lFpeHNs74Ip++7/J0
   jaFutkXAxYrlfBDytReDf3jrzNwLGbTh5BZ+eAyKAjNGwsZ+y7orpGLpU
   3f3/k25DOpi/4maax0ed5B+EsW/ctRbbPscPslIeMAqmmL/ZvgNB+VxWM
   w==;
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="scan'208";a="219182980"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2023 20:48:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 21 Jun 2023 20:48:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 21 Jun 2023 20:48:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXNf1sIOdSXXVXvVIdNTmN0J22vYfM5kUZ6YO9oZkTQ6wSYXM6Mu4w3NOkyJSoM5ksxay3Ij0G9lbFUz5i5yNeMF5ubY1yR1iVInYBRLACIBD7lnybN4rl6dKP38wcySWYySq06ICPkSD2/znhTKUAXu5m0OIJZ+NHLDsktB2lk7Ae8L1M1jIFmHy1V2PrisTuKnLgjHG0BpLzslK3k1DN66T/ZvxnxdrK3+hRRBjyxrJrwA5fmxILgm7NcMNMOFbs16PR6Bf4wHGI3TW0xkd0gp05TIWUHtcx8B/kamxzzAhxAjMBUb7NUE1O+2QcPyzO2NdY5tx9wW3/nPcZrxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FymOEy3uBRhsxAj17eH+2MvBJTfdX5oLX79mZSGP8sU=;
 b=C665qKzAx7KdXNbr10ZnNtJOOvYgk6RysixoXACw7FJPEn/9maweAQgRQwKMUN4y8C2Xu9oh6ND8jrY57q2WsWRLRn4mFaBudS0qJcW52OBVKkYhfvY1GOxYknH5PMnJF2lIO6h+i/89qbZ329Isgw/wl8n3dAerUH+Y6baPxpqGUD6/krFD1xQU86yL/3K3uQjcq+uQHqPcBH1AfBzznawHE5POI8Gls1EtOAE/1hI7KgP/CTsKKFUnClIHvCKS3ZpqwkgoXfn2RkV2BTkcrp5jFWFAIpfHU8qonsyEnUflp2YlwoO3AjqLW1maD/Jkp0Aa2r7ZhNJattSFPUeE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FymOEy3uBRhsxAj17eH+2MvBJTfdX5oLX79mZSGP8sU=;
 b=iX8YgmDDS4fnGqZAazbuNELRL52u2TAaF4yP7epPLwizsVTOwvyrZWEIb0IgUcdsjqrOOuqaL+r+EyZTVKEWfspNSj8VbiOhM3vErV8+3MV4bsFPY6GhJbHDWDeFkdzlDpwjxGtHoHXE2qWCjMa3Q9Vn2fD2NQatcxcyQnrGFbA=
Received: from DM5PR11MB0076.namprd11.prod.outlook.com (2603:10b6:4:6b::28) by
 CH3PR11MB7771.namprd11.prod.outlook.com (2603:10b6:610:125::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 03:48:13 +0000
Received: from DM5PR11MB0076.namprd11.prod.outlook.com
 ([fe80::3e10:f478:aa80:b431]) by DM5PR11MB0076.namprd11.prod.outlook.com
 ([fe80::3e10:f478:aa80:b431%3]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 03:48:13 +0000
From:   <Arun.Ramadoss@microchip.com>
To:     <olteanv@gmail.com>, <UNGLinuxDriver@microchip.com>,
        <andrew@lunn.ch>, <linux@rasmusvillemoes.dk>,
        <f.fainelli@gmail.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <Woojung.Huh@microchip.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net: dsa: microchip: simplify ksz_prmw8()
Thread-Topic: [PATCH net-next 1/3] net: dsa: microchip: simplify ksz_prmw8()
Thread-Index: AQHZo2wmntuaMZaRIUqZoguRiYMibK+WMhoA
Date:   Thu, 22 Jun 2023 03:48:13 +0000
Message-ID: <b8cc405d4f8a907040af68cd52387188aca80d34.camel@microchip.com>
References: <20230620113855.733526-1-linux@rasmusvillemoes.dk>
         <20230620113855.733526-2-linux@rasmusvillemoes.dk>
In-Reply-To: <20230620113855.733526-2-linux@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR11MB0076:EE_|CH3PR11MB7771:EE_
x-ms-office365-filtering-correlation-id: b456d181-0576-4404-cdfb-08db72d38117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2tl+qxXMFGBf8LIqpYMREVVn930dn/1MHa4Aq71MDdCx4BQNdY5Sf+zT82x1DsAVvjJp/aXCAc/YnMND0HHTwtGM8UVPLTk0OVhuI29J+eIoYLksIlzR8axRgPw36t07Jg6twbTrarJWxcJ5xXHAqpFY5HNvSc07HgqYyazNjgacrIoSLBQEbZcTKeI1tTVr/8zJ/pxhjIIxGgPmvDIp3ppI1/jKYj7iKSejFkopPnM8PEkbBpnyP5kyLuDpmNozIWvuIgAm6mwycpvnnFiuPXRmd1t1HpW5uqHtbx9jgA0IDBQZjvnZe1cK5GEfhuqkqohOIa+26eElYAJ4JqXfYm3EqV+UCsYu2nDuHwvlfMb2G/j5eGRMXXmydS5T3CdhmN+vYG/MalX7YoY994MMdKULPJ+5BOcLAnd/KMVBXsn3bWxMELIj5g82emfuFPnmNHTD3EaJtx6IxEKhg9PcGNdVJxAqxgij6VxDTaH51wtpCheIqq3vYX5I235YXeoZJ5dyp75wF+4GqWjiFNTxKgUAtvR7gNIh1UeKjOtLto+k7tNeBL6jusMp2Hz5BjvqsnDtrnsxnTLWUsFHiZTvLYVrvvz8t7VaY80M8MGsyXQAmvA/5u/hCCKwXHwYCFEQ+nzGsp4+WDaV/DJCCKVmjleCiQydScMS2K/FOfUWou8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB0076.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(4326008)(66446008)(6486002)(38070700005)(66946007)(76116006)(64756008)(66556008)(478600001)(66476007)(36756003)(71200400001)(91956017)(316002)(54906003)(110136005)(86362001)(83380400001)(26005)(6512007)(6506007)(186003)(2616005)(38100700002)(966005)(921005)(5660300002)(122000001)(2906002)(41300700001)(4744005)(8676002)(8936002)(7416002)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0M5d3lvQVJkWTV5anozWmVOdWVZZWVaYmhIRW5tZUpqa21UUXVmWkNla0V5?=
 =?utf-8?B?eE9EZWR6QTFubHI1WUt5QkltZnFuM3lPUjFDSE16MG9CbXVVeVplVTFqa0J5?=
 =?utf-8?B?WlUyWUxkcmpiaHVmemtBclgzbEFLOGY2K0JBTmF1Mmh3cXZJMUtvSFZBdmJN?=
 =?utf-8?B?YmhTWmp6RHE5MW9WbVVseUNiL3FoZ21PNGJDakJpOFpzTVBpaU13ZzdmVnBV?=
 =?utf-8?B?NHN6NitmOUFrd3g0T1hwSU5mUlpuT3R2MWlqamx5cUZ5NEZ2R004OTI1bncz?=
 =?utf-8?B?VWxQQWh1TUoraUhsY3lDYzhaMzlmb3JzbnArVlBZeldGUGVhYzNwUVRoNEZz?=
 =?utf-8?B?ZWNTWkx2MHB6dTBhMEVMbGhvbGdZS1NwQVczendodVlBeDU0OUVLS0YrMUVl?=
 =?utf-8?B?aVdXc1pEZ1g3WGcxaGxnVnJFVzRrcTlxMVpRaUo5aURNeEIvWmhBKzZtU0dJ?=
 =?utf-8?B?cCtJTndlVTZCWE1PWmpiYTczS29vVWx1OFExd3JMWXMzaWlrenhIN0ozYWxw?=
 =?utf-8?B?OXh3azVIVXV0THdVdnpVRjNZcTF2MXFzM1lQYzdQOEpNNHpsaHdjWUJXU1Ey?=
 =?utf-8?B?SDF1SC9YdmJUVXdQZzlJMG5TVEZjSllkbWltVHc3Q3pweGtmNHFRdFBFSVg1?=
 =?utf-8?B?UGZOWThYMDFyQkdYZFZvUlpuRzM5QVl4L1ptRm9WRlc4ZVZxNkRnU0NncnQy?=
 =?utf-8?B?VjR1QjZMeFlLcXpOUi9BQWVpY1lCTFVyRExOWFp3MllwM0FBZzNOekFoQjdl?=
 =?utf-8?B?MmN2OTBoa2xvTFdOUW96TE9MMEo4V3RsL01JNVAvMkY4OWpHTVFHQkNXd1dm?=
 =?utf-8?B?cXNLL051NWNYN0xnTEgvNkltWTVxUjBibkU4NFliUUs3aWw3ejhsK0pGV3pS?=
 =?utf-8?B?WFZTMlhLWSthaHJMbXgzd0hSYWtOK3NXT05RWDlEQlhxNFRBeGJsUHJ3N1pS?=
 =?utf-8?B?OC9xVUFRRlYraXg0cWwxY2J3dkdDYTN5aW9mVWlKK2p3L1RLM0E1VXQ4cW9u?=
 =?utf-8?B?VlhSNnVPSjVlRWwydG9lT3ZWT09zc0FZVm9FeUJlV0U3cjQvdVVjU0tXdjAy?=
 =?utf-8?B?MHE4WlIwOE5IR3gwRDFZQUFhQmVrL1BMd0hzUUZOMlRQVEZVbkhUZTRFWjZn?=
 =?utf-8?B?di8vdjlBcVhpRGJMbmFPWDd0bzVpSVNkNWhpZlp5MXVHNXVVUUFNZXk3NUtE?=
 =?utf-8?B?VlRYREFLSExtdmV6UXlmWVEzaERQMFpwd2NIemE4STJRRWc3Q3cyQ3VyWlBj?=
 =?utf-8?B?WDNDbzQ0QUcyMURWWFdodDNJZk90N3pYVlBTckVXZmU4ZjVDaWN1QWwzcEJo?=
 =?utf-8?B?ZDVGNk5OSjlUUW9lS3g4cUpBRjh0NXZYMDRNZHFTNWViRm5mNzdhRFNIczVJ?=
 =?utf-8?B?a0lMcGV1UmJqNzREbzR6d1FnOUFvUU5LUUJDcGlSd0d0ZWRHZ085QWlSUk82?=
 =?utf-8?B?TGUySnVMMnJ0OVdFekg5VEZONFdibnM4ZFoyd0tGNityNXZycVVlaVVwb0du?=
 =?utf-8?B?RUZrbGNJenJCOUFSSGt2bGtRdThYYXFVOWFpVEYzM01ZRld2MTZ1ZjJKTEd5?=
 =?utf-8?B?NXl0MnQ0ZSsvelFvT2dtR3lha09rZW03U3BBdE02MG5FU3lxbW5xcjE5ajRB?=
 =?utf-8?B?NThFMnJuYzY2aGhoRWZZb0xId1ArZzlVdStEdEJESlZHd2NpdUN5K1crUGo5?=
 =?utf-8?B?RTZlNFFVMGxyUU5EUFdMajlTdXNMT0xUM2d1aXpBcnlEdjVFUmkyZFIwMjQx?=
 =?utf-8?B?V0YwTlpsRkRGaEpDNzBraW9ydElzL2d1eVdUZVJwSU1FL3hNZkRHbnExeC90?=
 =?utf-8?B?aE9qRDFwUG54Wk1SaVdSTUV3Qm00UGF6S2Eva2hlcnYrN3daOUxUZEZvMDJu?=
 =?utf-8?B?Rm5iaXppU2dXU0MvMHluNmc2Y2g2TWtybHR1emRsa0w3STM3dTJYMG4rTzMx?=
 =?utf-8?B?ejBMTWRHT3N2bFlabU9ZU0Z2YmtURXdIL1lsRmlWZHFiY2MrMFhYOG84cVVU?=
 =?utf-8?B?akdMNWp4dkRrdEVlQWZ0QTJOQy9EaTE2MjZRdWdjSEdhNjlmSllIVVplSFRV?=
 =?utf-8?B?OUZ0aUFnVHEzRVNiRG1nWG80Z1lnRmdlNHlpek5tWlBtRjZCRVJQWDBIbzhw?=
 =?utf-8?B?cVc4cWxMTzU2Rko3Y1hqQjhtWXcyVnJpS2FybnA2bjRQQVYvOVZOUGdkNm9O?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0270C7749EC91E4E97B7FF3533EF9FC9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB0076.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b456d181-0576-4404-cdfb-08db72d38117
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 03:48:13.2383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZverF/ce7+GHkGOKw6FX24Fpx74J5WWVsj6mszJNHFtMvmp2R0zQbdNsa/jst+nuq9ggPZv2sqpVesl+eOEVffn9GV8SD29410RNOZ29E+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7771
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTIwIGF0IDEzOjM4ICswMjAwLCBSYXNtdXMgVmlsbGVtb2VzIHdyb3Rl
Og0KPiBbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBn
ZXQgZW1haWwgZnJvbQ0KPiBsaW51eEByYXNtdXN2aWxsZW1vZXMuZGsuIExlYXJuIHdoeSB0aGlz
IGlzIGltcG9ydGFudCBhdCANCj4gaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50
aWZpY2F0aW9uIF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0K
PiANCj4gSW1wbGVtZW50IGtzel9wcm13OCgpIGluIHRlcm1zIG9mIGtzel9ybXc4KCksIGp1c3Qg
YXMgYWxsIHRoZSBvdGhlcg0KPiBrc3pfcFggYXJlIGltcGxlbWVudGVkIGluIHRlcm1zIG9mIGtz
el9YLiBObyBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhc211cyBW
aWxsZW1vZXMgPGxpbnV4QHJhc211c3ZpbGxlbW9lcy5kaz4NCg0KQWNrZWQtYnk6IEFydW4gUmFt
YWRvc3MgPGFydW4ucmFtYWRvc3NAbWljcm9jaGlwLmNvbT4NCg0KPiANCg==
