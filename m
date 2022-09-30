Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2908A5F05A5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiI3HXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiI3HW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:22:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497211F34AC;
        Fri, 30 Sep 2022 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664522576; x=1696058576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ESWlxioVYj528038sQPx0RjeIpM/7u33h/c0Gis3Ovg=;
  b=yRPYqaEx/xeg+/oDAxAhdP80/AA4Ttz9qwsKVuukb++oQGGy6p6i2dlG
   STC+d6UFFn++xcLE9fidmdgmwbZMetkGo+lYQWQidp3JteIL3ONu+BTpl
   Gn0EpvAMRUKGuIJmKtn2UyhmsHR339JK1Ycmn2oH1Chs4vdf9C43gt7T4
   q/bS3pj6VdyvyyYjdSKNu38LklYIqQLMyC+f3osz1Fc14MqiuXT8EWlos
   8PU4bTSjERXIu8Q3p30oJarn+aKvKOAwtkxvLxRK19+XPSSEqV/9LvcqR
   PQ2OSlnbXhuZXIij4xWZTBXN9yPZqH/QqdzWqH9X4tbmu4XOofIluJBfQ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="116187743"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2022 00:22:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 30 Sep 2022 00:22:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 30 Sep 2022 00:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrTx0nVSoI7s/PwRVsSbsb+LU3ZmS90u098YEAMLPjsYRXRsVjtpF2JntIjDH8H55dD+33clcQZte4xlLS9jNf1xH3lCacEC/wL5rQft/9k/YWOBOnqhfPG+Ip3Xa2SHQIvZpWWIQ+tNpkI7AMFuxfgEfC7Spsfpil9DRZvom9fKnOldYIB4rH+Otda01GQ1nD9KGZ9EvVaHlF6CwW/SAed8WLH5eV0wx0kPFtQOACpTQNuLo6Jm9L4kNREUhERruVGmVYSslH7G/atVHNp4Y/KsA+U7awOM7yCiOwXiYrtBUwkuoLCqM2RaS4vgCSDDRyeGThFcMdhZA5vUu6yiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESWlxioVYj528038sQPx0RjeIpM/7u33h/c0Gis3Ovg=;
 b=UKVXIusGPeBrUoL6ZZIcTtjUsE1xU3JBTnl7CKmfkNs667s419x5wea+QJbc1IEiYUfvXDiWG+a4+54FtFu4sEeBcJch9TsazUlebkvk5Aqx41Pz+arhspQj0ga6WuWpZb5c6S39cM8dASP8uKXHEZUX/3NEbBtpfgnJoJtW0HWEXxbaQMpdpDZGqt+VpfCPOoshm4nGX24mUDQRUy5MlqWHuvYf++6QXHkUUuzDcdHHoi3KtJSxx2r/v081xXrPHmDLrItThhuJUJC6/WOW+VDKEKDMYSmhyvJLm3Sc/UWNbBCBy2NLkwj+JPGFEFBuizDC0Zsr5EqspBBS6tDpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESWlxioVYj528038sQPx0RjeIpM/7u33h/c0Gis3Ovg=;
 b=cc/RkENvzp4fsfbdZKAf4wl+39UIAT2iVjpoDtQ87JOI+GJo5mBhNKEqOmfLoI+lG0uHIK5SC26vgCaHPWmsre7EKJ1SW8V0uVI5N6dcThYKfHcFWrrh9bOiPd+g2QMu3L+A5SIouLRR21i7C6frmzhVtbXyU5Xq9Ttn3d9kRws=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB6860.namprd11.prod.outlook.com (2603:10b6:510:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 07:22:50 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 07:22:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 7/9] tty: serial: atmel: Only divide Clock Divisor if
 the IP is USART
Thread-Topic: [PATCH v5 7/9] tty: serial: atmel: Only divide Clock Divisor if
 the IP is USART
Thread-Index: AQHY1J1yYmPAxnyv8kCbs6pnRvciUA==
Date:   Fri, 30 Sep 2022 07:22:50 +0000
Message-ID: <4071cac3-d106-6f5e-aefb-adefba7dc567@microchip.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
 <20220922113347.144383-8-sergiu.moga@microchip.com>
In-Reply-To: <20220922113347.144383-8-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH7PR11MB6860:EE_
x-ms-office365-filtering-correlation-id: f74d7f91-e4cd-45bc-b1ee-08daa2b494ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4dxmVC/LD17Dx3kVj2lFf/7MU7mFuX6/SJDdXLmDDwkJqaTej31+MJHZR7Kjrn49a6s1X3B39ZRkw5zEvGkyRt3OEJ57zkm+7SSYa2xNRbI499XKbReethoeELYCI2UfmOu41cYvgKEVVveVTfGeCW30eG152ZnPxKAvY8iWkK21JI0nsV0ABXwoS9xx6k9X66Hp7XRQ/vgb4SbFLh9WVQhhcvFr8+kVtxP8N4pDrrTqpTbACYhH19b+lpq4aVwu1sgatxaCU3qpTNEgrqnkjq5otR21Cin0Cyy6wwIpXnc7cqETS4erKz1jrJhHEsN6tzpbCGCsHndYSLD9pUcVvWjQfoqX2rZJUB0Y2wVnApgtsmn4OeFjttJNQUzbhZ03E3/tes+ggoMonNY4CfSfgs3WT2PliExCAxvvEIQV5k+owaNMRwsJ9dkF4Hokk9RXVg2FmtYaFH3zDmOEQRR/B5HmEvzmhKSVONo08ZneBzSog/b3vLuWsbzxl+5nzNZXiKszvoAoRUYmM5urxvOCiB2R55vXgDAmmo+dfZTLH3jmN95MMWfqcSfOXDonK3T4DWYJDIWcomz8w7O6pp8aUUdL07qYTB/fwhyhVmcFx5JI5zYtVfQ8kxBSwmyZCzWOQ3v9RhkLugPOUwFV0EMV6priFYk2q6xt+AZpOfeEZbEcH7WKDObdt03Ns+3OrTpqUcK03ICfEtcJwPSa0rv3s65IrpTnx5anNIyIo+QpuDS9z5RbALTEb/CEI+GZWQGkNTLPpMNGO3P2wAXfv34C6GEP+1aFLcCV0Cc+2ipCa7L4ZBLSTKyDyOTKU1h/ddU1k3BlzFBL+eVWueI6R87KHny07tHCFYGk1AvumeCt96w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(66946007)(66476007)(316002)(6636002)(76116006)(91956017)(478600001)(66446008)(6486002)(66556008)(54906003)(110136005)(31696002)(122000001)(86362001)(36756003)(921005)(2906002)(38070700005)(64756008)(4326008)(8676002)(38100700002)(41300700001)(8936002)(7416002)(83380400001)(53546011)(186003)(2616005)(71200400001)(26005)(5660300002)(31686004)(6506007)(6512007)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dll6Tm51ei9yRTZqKzBlaWRPYThVL1FxSWtlUC9haVh4dUlWcjdsTC9oWHFz?=
 =?utf-8?B?d25JWFdpNlpVUTE5bzZ4dHJ3SjNZakVCcnVLMFJhaWZFMzJRc0hrREtCQnFm?=
 =?utf-8?B?N0YrYXAyUW04cVdiNitXTlE3OElnaHhxOGY3QVJ6bG1iZG9CVzlBSlJvNWxv?=
 =?utf-8?B?TVRabWtydnkrR0NOVXc4S25ZUENRZWY3Zk1tQTJVVEl5dThSRW13cm5pN1ZV?=
 =?utf-8?B?MEkxRDc2L0VTMmQ5ckc2TkFzMVV2d2NBL05LdFU3bEJGYnpTRUJkeDRTSTZP?=
 =?utf-8?B?ZWhnWU56SitEQlg3djVISVlOMmJobjVKN2hEWHJxY3JwVGU3YmZZa2tnMGhs?=
 =?utf-8?B?TDJ6OFFIRzd3SlE3Y0hyZnFmRTdaM0hvMERDYUZzTDZGcWlIYWo0eFRtT09Q?=
 =?utf-8?B?Y2Q4TFc3N2VnVk9GbzZPb1NxZEg1WEhSV3ZNOEtFRm42bDI3YkZZdEc4alNY?=
 =?utf-8?B?dmJRVWtOdzdsd1BoeG5XcUdpMHIrWi9veXNkVXpxMTg5YUovbmVzajhRbnk0?=
 =?utf-8?B?NjRFenhva01ZaUxicFVnb00zWmRLM25uVG5hQnd1bDJXZUsxRWs2alhjNzN5?=
 =?utf-8?B?eGQvKzcvZDhIeEc3S2N5aWFYS0tjSHF1UlV0ZExZTXFXV0RCL21PY2kyVWdG?=
 =?utf-8?B?MUo2R2tJWjFGL2ZGKzBNVDllcE9qamQ1TjJ6Y1poTHduSS9TZTVDT0dPT2o1?=
 =?utf-8?B?U2ljbXVXYVdNTmJkWFozN0taVko4VGV4THRweTY3QmtjWWpYMnF0NjhoMDRj?=
 =?utf-8?B?a3JaOWlZejRDd2RZNWFGUzRJdDNCai90NzcvMytZSjBoeHEwYjBES0YyTTZJ?=
 =?utf-8?B?a0ZTcXY0RTIyeUxwWjhhSE1WUmxiUkhjZFBVc3RwS2hoc2FQeURmbUZtR1hl?=
 =?utf-8?B?bXliT2ZQVVN1UlY3NGV5d1cxM1Vja1Zod1dPNy9iZVJuVHhQbDRRVTIyNG0v?=
 =?utf-8?B?NTdueldidm10Wll0akdFaEUwVitFb2pXa3cwUi9kRkdCSTJtRjhNemhRbXVu?=
 =?utf-8?B?SldWZW1vWDVSNnRXa3NpR2lJeVIxUWN2bFQySjZTTmpxRG40cjZLS1h1eWtB?=
 =?utf-8?B?anhWT1ErL3l2U3RwejJxK2pZUVkxcXVaekNEODJkSmdXc0RiWVZjWnMzWm9x?=
 =?utf-8?B?RGMvRVRiZUNTMFp6bnF3eVNzNGY4Vm5nbE1OQ0dtdHZLd2svOUJEWFFyVmo5?=
 =?utf-8?B?QlNzYU1MNUVIbmQrU01oUkJvNlNrNm8wRnBMWTNqWFJqOHFiQkh1Q1QrdW9o?=
 =?utf-8?B?QXhhOEJTRXVJQTNQQ0FIKzBhK3J3b0NESEZ3MEowMFVNY2RmczQ2ZVF6Qlpu?=
 =?utf-8?B?Q3gyaHhndXhQbHFQQTEyTTN5S2N5OHVhdEtzTEJGT0lWVDY0UkxSeGRLSmZ5?=
 =?utf-8?B?OUJPdCtDUmkrL0FBdkZUQTVXVHg3S1VBZ21kVTdVNksxc2VMdGZsV2xRWDB3?=
 =?utf-8?B?Y2JrSVF1NEdyTTIxYTJBRlBFWVNsMW9KWktkbUpWNzRiZi9paGpSL3hYbFFD?=
 =?utf-8?B?V3NvWGFEVzE4bjE5eXNLR1hIMW5RUW5SQlJWdTlJWkpqTkFEaDcrUUZNV1d4?=
 =?utf-8?B?WmRUSHkrclpWT2JnM2tJbitlSUM3RFBkTkNPbUhPMWlWcUh0MkNZRDJXUHBT?=
 =?utf-8?B?TjZRZVRxdUV4elhtUDE4TkR6cnVTdXluQWkvMXI3RkhQSTB5TFBLd0xZTk9m?=
 =?utf-8?B?NnptQ0FDcGFzeHo0QUxhZzBsNDdxVU8vNzdTZkl1VVZZcTdXVFZEUUlwcVNE?=
 =?utf-8?B?UDhyQWllamgwdVJCbkIwWU5mcm5kOXZnK2ZGc2pLZUsvRHFiWXRYMmtEQjRs?=
 =?utf-8?B?T1BWbnZIajRBL1J4V1hoeW51NnBuVU1kOGRPdXJ2OFBXQVc3bVVtdFlZYU1Z?=
 =?utf-8?B?UDZ2QTJUUlZFTTF4dG1yWVVSYi9IZUV3Ym4yV1Z0eXoyNEZrM1kxdGJJVVVW?=
 =?utf-8?B?dTNpMDgwc3gyYkRCVjVld2g2Tng2cit1WTVZWmZWcllhcUlMb0IrUDc0dUZT?=
 =?utf-8?B?UVpCckVxVnEzREdRVHg3ZVRwRm5CZmp3dU5vcTVsSFpKUzVLNldWcU1senRU?=
 =?utf-8?B?S244MmwxNXZDd045cXJjTGJWdnB0MnpNb25BMlNqOENpMmJ2K01rQ0VzWlAr?=
 =?utf-8?B?WDJndTdKbW5UWjlTZEtnZkFVNUtYZlJNR1pFUndJYTRQTTUyUUd2T0lTeFZG?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <506188F0006B764BB04075260A5F5C4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74d7f91-e4cd-45bc-b1ee-08daa2b494ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 07:22:50.2543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydCH6iMgsKj4XqkbP2PMO3W2rPgyJYAf/BBGqwMMjI5uyVs6itF6iEVZ5zjV/Nl8gxL3zMFQ5bpEf0vNB+02gHhhvsyVF+fnbZF25DlRslQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6860
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDkuMjAyMiAxNDozMywgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+IE1ha2Ugc3VyZSB0aGF0
IHRoZSBkcml2ZXIgb25seSBkaXZpZGVzIHRoZSBjbG9jayBkaXZpc29yIGlmIHRoZQ0KPiBJUCBo
YW5kbGVkIGF0IHRoYXQgcG9pbnQgaXMgVVNBUlQsIHNpbmNlIFVBUlQgSVAncyBkbyBub3Qgc3Vw
cG9ydA0KPiBpbXBsaWNpdCBwZXJpcGhlcmFsIGNsb2NrIGRpdmlzaW9uLiBJbnN0ZWFkLCBpbiB0
aGUgY2FzZSBvZiBVQVJULA0KPiBnbyB3aXRoIHRoZSBoaWdoZXN0IHBvc3NpYmxlIGNsb2NrIGRp
dmlzb3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWlj
cm9jaGlwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IElscG8gSsOkcnZpbmVuIDxpbHBvLmphcnZpbmVu
QGxpbnV4LmludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1
LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0tDQo+IA0KPiANCj4gdjEgLT4gdjI6DQo+
IC0gTm90aGluZywgdGhpcyBwYXRjaCB3YXMgbm90IGhlcmUgYmVmb3JlIGFuZCBpcyBtYWlubHkg
bWVhbnQgYXMgYm90aCBjbGVhbnVwDQo+IGFuZCBhcyBhIHdheSB0byBpbnRyb2R1Y2UgYSBuZXcg
ZmllbGQgaW50byBzdHJ1Y3QgYXRtZWxfdWFydF9wb3J0IHRoYXQgd2lsbCBiZQ0KPiB1c2VkIGJ5
IHRoZSBsYXN0IHBhdGNoIHRvIGRpZmVyZW50aWF0ZSBiZXR3ZWVuIFVTQVJUIGFuZCBVQVJUIHJl
Z2FyZGluZyB0aGUNCj4gbG9jYXRpb24gb2YgdGhlIEJhdWRyYXRlIENsb2NrIFNvdXJjZSBiaXRt
YXNrLg0KPiANCj4gDQo+IA0KPiB2MiAtPiB2MzoNCj4gLSBVc2UgQVRNRUxfVVNfQ0QgaW5zdGVh
ZCBvZiA2NTUzNQ0KPiAtIFByZXZpb3VzbHkgW1BBVENIIDEwXQ0KPiANCj4gDQo+IA0KPiB2MyAt
PiB2NDoNCj4gLSBVc2UgbWluX3QgaW5zdGVhZCBvZiAmDQo+IC0gUHJldmlvdXNseSBbUEFUQ0gg
MTJdDQo+IA0KPiANCj4gdjQgLT4gdjU6DQo+IC0gQWRkZWQgUi1iIHRhZw0KPiANCj4gDQo+IA0K
PiAgZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIHwgMTcgKysrKysrKysrKysrKysr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jIGIvZHJp
dmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+IGluZGV4IGUzZTE0Y2I3NjY4Yi4uYWNi
ZjZiODJkNjg3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvYXRtZWxfc2VyaWFs
LmMNCj4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2F0bWVsX3NlcmlhbC5jDQo+IEBAIC0xNTAs
NiArMTUwLDcgQEAgc3RydWN0IGF0bWVsX3VhcnRfcG9ydCB7DQo+ICAJdTMyCQkJcnRzX2xvdzsN
Cj4gIAlib29sCQkJbXNfaXJxX2VuYWJsZWQ7DQo+ICAJdTMyCQkJcnRvcjsJLyogYWRkcmVzcyBv
ZiByZWNlaXZlciB0aW1lb3V0IHJlZ2lzdGVyIGlmIGl0IGV4aXN0cyAqLw0KPiArCWJvb2wJCQlp
c191c2FydDsNCj4gIAlib29sCQkJaGFzX2ZyYWNfYmF1ZHJhdGU7DQo+ICAJYm9vbAkJCWhhc19o
d190aW1lcjsNCj4gIAlzdHJ1Y3QgdGltZXJfbGlzdAl1YXJ0X3RpbWVyOw0KPiBAQCAtMTgyNSw2
ICsxODI2LDcgQEAgc3RhdGljIHZvaWQgYXRtZWxfZ2V0X2lwX25hbWUoc3RydWN0IHVhcnRfcG9y
dCAqcG9ydCkNCj4gIAkgKi8NCj4gIAlhdG1lbF9wb3J0LT5oYXNfZnJhY19iYXVkcmF0ZSA9IGZh
bHNlOw0KPiAgCWF0bWVsX3BvcnQtPmhhc19od190aW1lciA9IGZhbHNlOw0KPiArCWF0bWVsX3Bv
cnQtPmlzX3VzYXJ0ID0gZmFsc2U7DQo+ICANCj4gIAlpZiAobmFtZSA9PSBuZXdfdWFydCkgew0K
PiAgCQlkZXZfZGJnKHBvcnQtPmRldiwgIlVhcnQgd2l0aCBodyB0aW1lciIpOw0KPiBAQCAtMTgz
NCw2ICsxODM2LDcgQEAgc3RhdGljIHZvaWQgYXRtZWxfZ2V0X2lwX25hbWUoc3RydWN0IHVhcnRf
cG9ydCAqcG9ydCkNCj4gIAkJZGV2X2RiZyhwb3J0LT5kZXYsICJVc2FydFxuIik7DQo+ICAJCWF0
bWVsX3BvcnQtPmhhc19mcmFjX2JhdWRyYXRlID0gdHJ1ZTsNCj4gIAkJYXRtZWxfcG9ydC0+aGFz
X2h3X3RpbWVyID0gdHJ1ZTsNCj4gKwkJYXRtZWxfcG9ydC0+aXNfdXNhcnQgPSB0cnVlOw0KPiAg
CQlhdG1lbF9wb3J0LT5ydG9yID0gQVRNRUxfVVNfUlRPUjsNCj4gIAkJdmVyc2lvbiA9IGF0bWVs
X3VhcnRfcmVhZGwocG9ydCwgQVRNRUxfVVNfVkVSU0lPTik7DQo+ICAJCXN3aXRjaCAodmVyc2lv
bikgew0KPiBAQCAtMTg2Myw2ICsxODY2LDcgQEAgc3RhdGljIHZvaWQgYXRtZWxfZ2V0X2lwX25h
bWUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCj4gIAkJCWRldl9kYmcocG9ydC0+ZGV2LCAiVGhp
cyB2ZXJzaW9uIGlzIHVzYXJ0XG4iKTsNCj4gIAkJCWF0bWVsX3BvcnQtPmhhc19mcmFjX2JhdWRy
YXRlID0gdHJ1ZTsNCj4gIAkJCWF0bWVsX3BvcnQtPmhhc19od190aW1lciA9IHRydWU7DQo+ICsJ
CQlhdG1lbF9wb3J0LT5pc191c2FydCA9IHRydWU7DQo+ICAJCQlhdG1lbF9wb3J0LT5ydG9yID0g
QVRNRUxfVVNfUlRPUjsNCj4gIAkJCWJyZWFrOw0KPiAgCQljYXNlIDB4MjAzOg0KPiBAQCAtMjI4
NiwxMCArMjI5MCwyMSBAQCBzdGF0aWMgdm9pZCBhdG1lbF9zZXRfdGVybWlvcyhzdHJ1Y3QgdWFy
dF9wb3J0ICpwb3J0LA0KPiAgCQljZCA9IHVhcnRfZ2V0X2Rpdmlzb3IocG9ydCwgYmF1ZCk7DQo+
ICAJfQ0KPiAgDQo+IC0JaWYgKGNkID4gNjU1MzUpIHsJLyogQlJHUiBpcyAxNi1iaXQsIHNvIHN3
aXRjaCB0byBzbG93ZXIgY2xvY2sgKi8NCj4gKwkvKg0KPiArCSAqIElmIHRoZSBjdXJyZW50IHZh
bHVlIG9mIHRoZSBDbG9jayBEaXZpc29yIHN1cnBhc3NlcyB0aGUgMTYgYml0DQo+ICsJICogQVRN
RUxfVVNfQ0QgbWFzayBhbmQgdGhlIElQIGlzIFVTQVJULCBzd2l0Y2ggdG8gdGhlIFBlcmlwaGVy
YWwNCj4gKwkgKiBDbG9jayBpbXBsaWNpdGx5IGRpdmlkZWQgYnkgOC4NCj4gKwkgKiBJZiB0aGUg
SVAgaXMgVUFSVCBob3dldmVyLCBrZWVwIHRoZSBoaWdoZXN0IHBvc3NpYmxlIHZhbHVlIGZvcg0K
PiArCSAqIHRoZSBDRCBhbmQgYXZvaWQgbmVlZGxlc3MgZGl2aXNpb24gb2YgQ0QsIHNpbmNlIFVB
UlQgSVAncyBkbyBub3QNCj4gKwkgKiBzdXBwb3J0IGltcGxpY2l0IGRpdmlzaW9uIG9mIHRoZSBQ
ZXJpcGhlcmFsIENsb2NrLg0KPiArCSAqLw0KPiArCWlmIChhdG1lbF9wb3J0LT5pc191c2FydCAm
JiBjZCA+IEFUTUVMX1VTX0NEKSB7DQo+ICAJCWNkIC89IDg7DQo+ICAJCW1vZGUgfD0gQVRNRUxf
VVNfVVNDTEtTX01DS19ESVY4Ow0KPiArCX0gZWxzZSB7DQo+ICsJCWNkID0gbWluX3QodW5zaWdu
ZWQgaW50LCBjZCwgQVRNRUxfVVNfQ0QpOw0KPiAgCX0NCj4gKw0KPiAgCXF1b3QgPSBjZCB8IGZw
IDw8IEFUTUVMX1VTX0ZQX09GRlNFVDsNCj4gIA0KPiAgCWlmICghKHBvcnQtPmlzbzc4MTYuZmxh
Z3MgJiBTRVJfSVNPNzgxNl9FTkFCTEVEKSkNCg0K
