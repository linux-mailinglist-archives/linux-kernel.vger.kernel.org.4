Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FF869C7B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjBTJcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBTJb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:31:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0D15C94;
        Mon, 20 Feb 2023 01:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676885516; x=1708421516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k6mSdEsUH+veZVNbR/T/5I3wuUpthyQodYarRB8AQeg=;
  b=Hvb7DN21pHGcuX/44RVKSTtxnLPczt2ZMXqjljabX9uR0E31U0PVZgH/
   Jx8hadtardWHIeZN1xC4OVrumAi9aQSmfDgujLf34P7PfcoCD7Tu8p8/v
   1qUyrZWn0cWsYhMzSyMK23YJiNazGC+YgWOYrY+YiVct6vNWo2jMSXaWX
   I0dYWZhnTb9Oe7DfGT+7vVPnQxJohJgS6nKlmIsfqBTz4tDqA9IyshQsA
   8OpM/chIFKyAs3UFGxeGZpxsSAN0N9DnFB6d0rAKrwvMNcJEzi0LbqpgV
   r3WP4XqFWnXvRFbcD2oVRB4oXnUp+jVxNTIEk6uuduqer6gnnfAhdP8IN
   g==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669100400"; 
   d="scan'208";a="201401294"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Feb 2023 02:31:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 02:31:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 20 Feb 2023 02:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQvkvdkjEHWB0boChED1WxdoyhLqgpJntP3J+tY+DXri+cx+XGOjgDjw6kfhctXU4FhQ0FmNwuh2GEXFfPN80Rrqo9s30RhOvCguxGWgbQB/P+TEVtyN6e10oBnHk0wrJUP/oYRihGJfLagmU0TGpxkc/ckkcFJ6nusZztDl9kxoTrWc35LXNOCd8848GNhZB1UVIwD+UN2AIJg8Y18zURdVzHDPd4DVxEUFk4SmN34023A8GnA+yuI8eRxlwg7vcA1u+uThAZyyG7N3QZbOmmLBBCfLrbMoE5qw7/sAab02bkpUTea8dBOuizAOGtR4vaJAxIg5kGWuv93bjprlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6mSdEsUH+veZVNbR/T/5I3wuUpthyQodYarRB8AQeg=;
 b=N3RIwlNlqsYAZeNVXU3oRTRWV1eVKER84fb3ewW6JCmEgDS5HrQF3Tgu7Im8QvrXRkgFQO0d+1cCv4NBq+U6BNXmnrufGVa+FANLcHbY+YCleBlReE1PDZ0c6hMTm1EOYyKfhP6NRLvpjdceNh9QkodNk+nn4GuHq7zgVanRAYphanVWMSjIv96+ZOaJfVz4qlJxZLTFPqrrGyLHfGGHtbMZWl7k8Mx4ZR7iZxVoZsTopW5R4Fj9SwhoxD9zNc5u42WlSpJDdO3Yp6MdeR7xKMJOyLLi3IY1bHWkdI7gRgf+hYwG8W6z7pfIxLaOQ6qHWs7Jt5NlFEGcWzhYZV32zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6mSdEsUH+veZVNbR/T/5I3wuUpthyQodYarRB8AQeg=;
 b=qgAseZuf9A4T9r0oUsvNBZ/d1dIm3RqrlOCKx8OQFQD+7P2MBpGrY65qRU65X3d3hggeHqiVlj/ZMAiMB2bzVP+o+4y5MsgfKvUQovD/E80hebJYoJEWzVHXrCgFfF7w3pk/HOn07ROMMjLuhhgdWiC4pVR/SdZKC8OQ00uZsWU=
Received: from BN8PR11MB3668.namprd11.prod.outlook.com (2603:10b6:408:81::24)
 by SA3PR11MB7485.namprd11.prod.outlook.com (2603:10b6:806:31c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 09:31:46 +0000
Received: from BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::df96:2404:8ae1:8b9c]) by BN8PR11MB3668.namprd11.prod.outlook.com
 ([fe80::df96:2404:8ae1:8b9c%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 09:31:45 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <arnd@arndb.de>, <linux-gpio@vger.kernel.org>, <michael@walle.cc>,
        <srinivas.kandagatla@linaro.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>,
        <Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Topic: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Thread-Index: AQHZPpY5vK269zMPJUW175op5Ze6367OH1cAgAFGAaCAAEoeAIAACswAgAAHKBCAAAiScIAAHpeAgAFb50CAADe8gIABYnaAgAAGvICABLnRgA==
Date:   Mon, 20 Feb 2023 09:31:45 +0000
Message-ID: <e1375c213b496b86df3f61d04003d94390c80240.camel@microchip.com>
References: <20230214082804.2761756-1-michael@walle.cc>
         <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
         <7276bef47792e489abd093e4bd0044de@walle.cc> <Y+yeyNCA48IbKOKC@kroah.com>
         <BN8PR11MB36680D97C97B4894E321CAD9E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
         <BN8PR11MB3668A1E8541035E257F2C500E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
         <Y+zFo4SP5L/KkT/v@kroah.com>
         <BN8PR11MB3668C37EFBB42FB3FFC7618FE9A09@BN8PR11MB3668.namprd11.prod.outlook.com>
         <Y+4YO7HSmETanIU2@kroah.com>
         <b8663c30e7b46955c5da4794919acf5f518aae52.camel@microchip.com>
         <Y+9HOdHGqmPP/Ude@kroah.com>
In-Reply-To: <Y+9HOdHGqmPP/Ude@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR11MB3668:EE_|SA3PR11MB7485:EE_
x-ms-office365-filtering-correlation-id: 6e8dd14c-44da-45da-d25d-08db132548b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PFGo3p/I1actLnSToyv5gmvNpKG8iuR0hf0OZnMWDVJn/ZaFGhOsQBvUmebuuUP/ChSrskwxeXodC25ljux7LDE8i0gsHZwXsFTarEhzo0SBEExTSbE4rm5p+FlvX1Lt4jA/0tPL1xGr/yie85m3MDMJBxTLRp9Ty5OVzdtFES5bkyFD8O0o0u4NIwjOAgvpecebjYKnoKA7jCm0YOGwWKoxAa16xMSB8GxyikAmG6NweMUsV2pW9vcVIkFsY7tJPvHjlPAnPYWeqY2+TXaKxJROsiw6i2/g2v4Wd9WHxM8ZBPav3trAlWVuDuqKW9Btku27hvDYdru9r9VX9llXSRivldklhX+Slla48+7mPgnoDsqK7wpdd4nCriXMZqLftaZR7PXCERTaTJz0eQRvyf9umH+OzfEXP3mE8J7msuFrgivevJddRCzvKyx+GWy7gRRtxglQU0DByGmE6PFvfHZByi5DWru6YoAKckXUhx0vj+92midbGUQXLaiObbckXrIXlvS92DNoO8wm8aVWutdLsTuffAGaFYNHK53ASnw5JYHSDEsOssXQv6Lh/E7iv/hnF12hVjzz7vnmMsJKtQuqtNxplDblbYelS5T2MUHAFI3wKKPz1+W28Ig6Gl9IRjg+eNBwY2JecjRiF6dzmRnK3NPzaE2CdqdVQtr6/cQbwXRfRAJD/Pw9dqqVy2r6YbOOFqHUrmmPj7bAGcX/Y32ID6k2/Y+11hahicatB7w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3668.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199018)(186003)(26005)(122000001)(2906002)(6512007)(41300700001)(6506007)(38070700005)(38100700002)(107886003)(5660300002)(2616005)(8936002)(316002)(6486002)(86362001)(76116006)(66946007)(8676002)(66556008)(66476007)(66446008)(6916009)(4326008)(64756008)(478600001)(91956017)(71200400001)(36756003)(83380400001)(54906003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmZNaXFBM1hqbEMvWkZnZXZoUFVpUnUxNFllR21JUXlreDFjYU83bVIxNTFU?=
 =?utf-8?B?aEgrZzZDeDRiV09LamlmQUJZMldwblBKVFFoMmdzRHU1WWo0Q1o3Q2JJZG94?=
 =?utf-8?B?bnlsMGJXRzdWa04vN3lmZWM2alFnU3k1V1lqWTJqRHhudVpqS0FTYlR1Y0h0?=
 =?utf-8?B?KzFmMFBEeitPd2F6NXdqUWlNRG9lRWZuNVNNUVYzc2JLU1l3OXdmWGRSUnBH?=
 =?utf-8?B?dytGdWthelRYZnhaL0F5RlkzZFVzeGVpcFFUNmc2ZGN3azhnUTJmaDBlQnlx?=
 =?utf-8?B?c0RtalNHTFQwSGFRMWJ6UkxVUFFHdnJIQmxLaXI5UVhkOWNYaE5XVlNWTmhu?=
 =?utf-8?B?V2ZobVFtRSsxbXdXcndFdHNmL0RXcUVHYmpndE5rU1lORi82V3V4OXFrd0dB?=
 =?utf-8?B?dnZrUWc0RGw3eUI3MjBGTTYvT0dqc2JWSThSQTdNL0JqakM3KzAzRXpCYWtM?=
 =?utf-8?B?dU1CNWU5SnFJenk4RFl3MjU2NkJwMkpBbTFjQ0o2bG1KUVR2cFhnYTM3QUhD?=
 =?utf-8?B?Y2c3cXJ6VG1BUXFLSzZrSDQxQ3hVSDMrdnluamhwbXU3V1AwQVB2c1pOeDgv?=
 =?utf-8?B?bXpwOE5hWEZVMWZPN3NSeHZpMWZ3MDRVTHVkVkt0TWNnVlBhRHIxcG9qYlVB?=
 =?utf-8?B?cUxLQzY3dzhHVjlqQkFna2ROcWE1T3FtMVV5MkgybGJGaDZ5UjNLZEEzbmx5?=
 =?utf-8?B?RUc3cWZBU296MFU5N0dGV3JtbU1iVVpUMElQVDFhMG1NK2hUZ2NtMU5aa2wy?=
 =?utf-8?B?NS9sMkdQZW9tbTB3c3pZTmVaazJXeC9XaVlZQnNvQ05xd0JQb1JyMXpPNXFu?=
 =?utf-8?B?bzVYQTlBKzJNUGdEVHh3UlZHRVZxMXNjbG9qblhPS3A1Uy9KcHVsQnkycXJB?=
 =?utf-8?B?SUhhNlRPRDgzQk1PcC8yLzJaSzV4Mm9kWWU0cVdHbUhtUWhyWFU4MVdJUkk5?=
 =?utf-8?B?SWxYYnU3WW54bzZuWUVjSlRZRDdxd1FYYkR3Z29PNFRQWml0NFVHcUVGMTBi?=
 =?utf-8?B?bHIvZ0d1YnJZbzZyS1h3dmUxRE1ZQnVCMkpocmYzS1BGdGROQ1JzZHpjVDdh?=
 =?utf-8?B?bFI1Q2FwbnJzOVA3NVg3WDVCTGR6Uk44V1o2UCtxajB2dC9rdUllUCtCLzQ5?=
 =?utf-8?B?WVREZytyeFB4ZENyb0hlOWxJaFIwQ2FzUG0vMEtuOFFBRXZSc29sSERHN09Z?=
 =?utf-8?B?S25odUk4VzdxMGcrTVhIVlNYU3F2L3Jsa0FKZUt3YzhBaHh6aW1OWGR4OWJx?=
 =?utf-8?B?cXJ4RUF1U21kNC8wNFd3VkhXWUtOVDJaaTcvQ082UThGRFRkR0JQby81Vzl2?=
 =?utf-8?B?U2hFR2FCTGJVekozbkJBYW1rTE5oaTFjeFZLbUtRTFloN3JNeGZRaTlCcGRR?=
 =?utf-8?B?blNSUGpGbHA1MWNmdzU0UGFaTFIxdGlPMTR2bzdpeHdibjdtUGxEU1FBaXJ6?=
 =?utf-8?B?UWVSTktpUHNJUUFCT016SFVYT2hwQWNacHpxMFNrWTE0RHhBRjRqY1ZzRFBH?=
 =?utf-8?B?L0FweWtiK0xKa25uajNxNGZlM2ZUUXRKaEZYbGVFU05KQXh5aEhOQTdrckxJ?=
 =?utf-8?B?bjdkMm1kYmxJdkxteGtJcDJGODZNU2hkOWQ1KzBaM1Y0SWJ0SjFxeDBKeVhn?=
 =?utf-8?B?L2gzcnVhSERaRFkzcjZMQktOVldoQXYrejJaWCtTNU9DelgzVHJERjlPSnJY?=
 =?utf-8?B?MEE2cEdLREt3NE56YnVtYUZoaS95aFpoMGh1M0RIYVZTOVZpcU55clZkcGFG?=
 =?utf-8?B?NXVxdnpNS3BWRi93dG8vRTF3VWViQUhrdzFqVWJDclRSS0RCejUyRjQ3WnRv?=
 =?utf-8?B?ZVF3TjI5Q2d0a1pmSW9qNFFxQWEyTzVnTHQ3TlA4emhFbEcrUXBVTDJOOUJS?=
 =?utf-8?B?TjEwSDNyUytrcjdlempYMHp2OTVNWHhSYXZjdUFaWGZON2FLdHNkbkxFZWFi?=
 =?utf-8?B?RyswTTVucmNyVnE4T1FlYkpJRDFhQ3YxMmFPVjQ2SUxtTDdPMEJ5K1IvSkJG?=
 =?utf-8?B?UHA1a3UzcGhmcXhubzVFamxXM1ROam1vNGJvc0V2MjRuY1ZxZlVJWVZPVm5n?=
 =?utf-8?B?dDE4d2tscm9LWVo4MTBrVXZRVmR6djdEUU1ZNGZ4RWl4K3RDRjgweDV5MTVG?=
 =?utf-8?B?N1VzRFpodE9NUlJWQzl5TUVqazRLd0lHelliMGFhUUFNMDlpM1lRQjFvNkhO?=
 =?utf-8?Q?HYKoM+llt9PHKWdBmYjwR00rkZi0aH3TyVY8+2IvEFHw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6196BF3D3F2DCC47B2FD3F52C8028F88@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3668.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8dd14c-44da-45da-d25d-08db132548b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 09:31:45.6984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCXogJRRBbasnGNG5e1ysOvaVnhIz79PgYAxBmnUxXTVciLaMu+zVI3dun+gnMhsFWnKa3KzvgSU9+ynfoJxifnejIX8I7bcJ3bfD8xANAwiIF8LkhM9ZmUtiQ5b/LoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7485
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTE3IGF0IDEwOjIyICswMTAwLCBHcmVnIEtIIHdyb3RlOg0KPiANCj4g
T24gRnJpLCBGZWIgMTcsIDIwMjMgYXQgMDg6NTc6MzJBTSArMDAwMCwNCj4gS3VtYXJhdmVsLlRo
aWFnYXJhamFuQG1pY3JvY2hpcC5jb23CoHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMy0wMi0xNiBh
dCAxMjo0OSArMDEwMCwgR3JlZyBLSCB3cm90ZToNCj4gPiA+ID4gPiA+ID4gR3JlZyAmIE1pY2hh
ZWwsIEkgZG8gbm90IHdhbnQgdG8gZXhwb3NlIHRoZSBlbnRpcmUgb3INCj4gPiA+ID4gPiA+ID4g
ZXZlbg0KPiA+ID4gPiA+ID4gPiBwYXJ0aWFsDQo+ID4gPiA+ID4gPiA+IHNldCBvZiBkZXZpY2Ug
cmVnaXN0ZXJzIHRvIHRoZSB1c2VyIHNwYWNlIGFjY2VzcyBkaXJlY3RseQ0KPiA+ID4gPiA+ID4g
PiBmb3INCj4gPiA+ID4gPiA+ID4gc2FmZXR5DQo+ID4gPiA+ID4gcmVhc29ucy4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBCdXQgdGhhdCdzIGFsbCBleHBvc2VkIGhlcmUgdGhyb3VnaCB0aGlzIGJs
b2NrIGRldmljZSwgcmlnaHQ/DQo+ID4gPiA+IFRoZSBibG9jayBkZXZpY2UgY3JlYXRlZCBieSB0
aGlzIGRyaXZlciBkb2VzIG5vdCBleHBvc2UgdGhlDQo+ID4gPiA+IGRldmljZQ0KPiA+ID4gPiBy
ZWdpc3RlcnMgdG8gdGhlIHVzZXIgc3BhY2UgYXBwbGljYXRpb25zLg0KPiA+ID4gDQo+ID4gPiBX
aGF0IGlzIGl0IGV4cG9zaW5nPw0KPiA+IFRoZSBkZXZpY2UncyBPVFAgYW5kIEVFUFJPTSBhcmUg
bm90IGRpcmVjdGx5IG1hcHBlZCBpbnRvIHRoZQ0KPiA+IHByb2Nlc3NvcidzIGFkZHJlc3Mgc3Bh
Y2UgdXNpbmcgUENJZSdzIEJBUiByZWdpc3RlcnMuDQo+IA0KPiBPaywgdGhhdCB3YXMgbm90IG9i
dmlvdXMgYW5kIGlzIGEgbG90IG9mIHRoZSBjb25mdXNpb24gaGVyZS4NCk9oIG9rLCBJIGFtIHNv
cnJ5IGlmIEkgd2FzIG5vdCBjbGVhci4NCj4gDQo+ID4gVGhlcmUgaXMgYSBPVFAgY29udHJvbGxl
ciBhbmQgRUVQUk9NIGNvbnRyb2xsZXIgaW4gdGhlIGRldmljZSBhbmQNCj4gPiB0aGUNCj4gPiBy
ZWdpc3RlcnMgb2YgdGhlc2UgY29udHJvbGxlcnMgYXJlIG1hcHBlZCBpbnRvIHRoZSBwcm9jZXNz
b3Incw0KPiA+IGFkZHJlc3MNCj4gPiBzcGFjZSBhbG9uZyB3aXRoIG90aGVyIHJlZ2lzdGVycyB1
c2luZyB0aGUgQkFSIHJlZ2lzdGVycy4NCj4gPiBPVFAvRUVQUk9NIGRyaXZlciBtYXBzIHRoZXNl
IHJlZ2lzdGVycyBpbnRvIGtlcm5lbCdzIHZpcnR1YWwgc3BhY2UNCj4gPiB1c2luZyBkZXZtX2lv
cmVtYXAgYW5kIGFjY29tcGxpc2hlcyB0aGUgcmVhZHMgYW5kIHdyaXRlcyBieQ0KPiA+IGFjY2Vz
c2luZw0KPiA+IHRoZXNlIHJlZ2lzdGVycy4gVG8gdGhlIHVzZXIgc2lkZSwgdGhlIGRyaXZlciBz
aG93cyB0d28gc2VwYXJhdGUNCj4gPiBkaXNrcw0KPiA+IChvbmUgZm9yIE9UUCBhbmQgb25lIGZv
ciBFRVBST00pIGFuZCBib3RoIG9mIHRoZW0gY291bGQgYmUNCj4gPiBwcm9ncmFtbWVkDQo+ID4g
dXNpbmcgdGhlICJsaW51eCBkZCIgY29tbWFuZCB3aXRoICJvZmxhZz1kaXJlY3QiIG9wdGlvbi4N
Cj4gPiBUaGUgZHJpdmVyIGhhbmRsZXMgdGhlIElPIHJlcXVlc3RzIHRoYXQgb3JpZ2luYXRlIG91
dCBvZiB0aGUgZGQNCj4gPiBjb21tYW5kDQo+ID4gYW5kIHRoaXMgd2F5IHdlIHdvdWxkIG5vdCBu
ZWVkIGEgc2VwYXJhdGUgdXNlciBzcGFjZSBwcm9ncmFtIGFsc28uDQo+IA0KPiBJIGRvIG5vdCBy
ZWNvbW1lbmQgdXNpbmcgYSBibG9jayBpbnRlcmZhY2UgZm9yIHRoaXMgYXQgYWxsLsKgIFdoeSBu
b3QNCj4gdGhlDQo+ICJub3JtYWwiIEVFUFJPTSBpbnRlcmZhY2UgdGhhdCB0aGUga2VybmVsIGhh
cyB0b2RheSAoaS5lLiBhIGJpbmFyeQ0KPiBzeXNmcw0KPiBmaWxlKT/CoCBUaGF0IHdheSB5b3Ug
Y2FuIG1tYXAgaXQgYW5kIGVkaXQgbG9jYXRpb25zIGhvdyBldmVyIHlvdQ0KPiB3YW50Lg0KR3Jl
ZywgSSBoYXZlIG9uZSBxdWVzdGlvbiBhYm91dCB0aGUgc3lzZnMgaW50ZXJmYWNlLiBJZiBPVFAg
YW5kIEVFUFJPTQ0KYXJlIGVudW1lcmF0ZWQgYXMgdHdvIHN5c2ZzIGZpbGVzIG9mIDhLQiBlYWNo
LCB3aWxsIHRoYXQgc3RhcnQNCm9jY3VweWluZyB0aGUgUkFNIHBlcm1hbWVudGx5IG9yIGlzIHRo
ZSBzd2FwcGluZyBpbiBhbmQgb3V0IG9mIHRoZSBSQU0NCmhhbmRsZWQgYXV0b21hdGljYWxseSBi
eSB0aGUga2VybmVsIGJhc2VkIG9uIHRoZSB1c2VyIHRyeWluZyB0byBhY2Nlc3MNCml0Lg0KDQpU
aGFuayBZb3UuDQoNClJlZ2FyZHMsDQpLdW1hcg0KDQo=
