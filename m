Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99FC5BA0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIOSqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIOSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:46:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ABE9A68A;
        Thu, 15 Sep 2022 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663267562; x=1694803562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EBrre6ikUw/9vdLZ9y1d2VIBG5+IT7/EYx+sn3MeUqE=;
  b=ByIJlztLGbPtv7jAgXT8ZvLkHhyNbJFvYqMVEM/J4t6g0k/Wyr6/THSX
   tsjABi3DtzeZ7nrO3VBVcy1t6rBXfcPBzhu5i20YHsp6EemlAfYUGOBwq
   STwE1SrguLMgvUgXhSdFJQDW2zpkBBg/TOQh5d+i89C/IOcm9KiHZ8xVF
   1qU0USJC09O+C7Aawh52PailU/KxI4Eu7QaNiEoAtC1UQKPIM8UPTECOR
   ZwRajd3lnWIla22CXBmy7LnXLMGbtuT1f0km4xn3GZa/V/qTgb7ehUyJL
   N0KqoFA5QS3LpZD8qpPIhcRsgO3q769n712fYj6hT46gcSiXnZ4vHd3YW
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="177370092"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 11:45:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 11:45:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 15 Sep 2022 11:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYR5DGoVd4S59Rq21CrB7TcUuO19N/c5owTJ4OkEVjYv0s9JBOpxNdFGmyX9PPgMuEgHdIRMImKWPp0NeMnLdS17ULmO1armQLlKq/CGKLmucORg/d67jUks4nu0WrZT1Pkrkc8g07sgZgx8G9r98W4hxA8u/ielyTVWAfheURjziYvJFsXbvGy1QihD6KU8oOckIXLc6l1OTjOI0Ohlbw+a1V8qjjhMbEL2vsljefQmpkwjbJUkbhDbGHKiihNNwiz7t1Ezfs3nOSBcRkNBpHaTHpp010mBcPV0I1niI4ZPYooOXu5s2e8aa8rAGXpnK7VkcI7un3alJUgw+FT3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBrre6ikUw/9vdLZ9y1d2VIBG5+IT7/EYx+sn3MeUqE=;
 b=EA1EO3HY3Cn+GVA9+xwtg65EmSb9P5GDHiZ2R0evBFItZySMkxFzSkZ5BztaBIL9Vu7+bnNXpKLBwyxI0wBK4qaMPJ3/VSh6zzVxXcUn2u4kbHSNYE5m0/AaGA+ye9NlSoKASxaGUfINUc+j4Iib6jxLXPtx3psmh+qrTCvwCIJrxLHnokWm2Ge8OeEVzcPN/JS2FZvIqBr/flHu4a4qjd2c6SMxHZvh2mZd70p4h6u4kw7vwxjihMoqYMdmps5JG+/aabkox3CjXDZyuT59WM1qt6sEJZjO5GVI28d2xQDhp1/qWH7i/qa2J5Xd1dV1K3SxvaK8BKvkS5+kfJESww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBrre6ikUw/9vdLZ9y1d2VIBG5+IT7/EYx+sn3MeUqE=;
 b=l9sci5Qizx18Yy+L0BWfO2C0efptAtfCW6pDX8BGNLL8WNuXLUhzKcEffX1jWdyeNi8giXKHO7RursqBiv9W1Ti776A8DZosNDRjTGc/vDat6RrMfiUeH0wpj4K4DZ5elV2BA2p+SUDEYwwiBUJuCzu+cEH9Qtcf/ojL3aLAhDQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Thu, 15 Sep
 2022 18:45:47 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 18:45:47 +0000
From:   <Conor.Dooley@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <maz@kernel.org>, <palmer@dabbelt.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <anup@brainfault.org>, <Conor.Dooley@microchip.com>,
        <guoren@kernel.org>, <sagar.kadam@sifive.com>, <jrtc27@jrtc27.com>,
        <aou@eecs.berkeley.edu>, <ajones@ventanamicro.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <qemu-riscv@nongnu.org>,
        <paul.walmsley@sifive.com>
Subject: Re: [PATCH v4 0/4] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Topic: [PATCH v4 0/4] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Index: AQHYtx7ti7bi0aG880qkYhCwNAw2tK3g+H0A
Date:   Thu, 15 Sep 2022 18:45:47 +0000
Message-ID: <9614efe9-d95e-fa0c-05fe-bac3fe62fa86@microchip.com>
References: <20220823183319.3314940-1-mail@conchuod.ie>
In-Reply-To: <20220823183319.3314940-1-mail@conchuod.ie>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|BN9PR11MB5545:EE_
x-ms-office365-filtering-correlation-id: 1b40aa68-1174-4818-7b9b-08da974a80f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MPvvRbNG45zAK+gRxt7dGUHjpGOkn7pB+RO6ZLe3EzjOutiH3cbxVyw8vIxgMwgmG7GY/dm2H3MB0y2ca4GoeGb4rRUF3I2/VC4ESmcnjWS8CNAH+9byfHv3O4Dc8UTMtVLsFkXBqVx7Jzo2Mb9B91sQg4PRWZjf3ujSy5iAM2gzH+YltFK9A01CcHJO6LaNPXbqmdMKICW7gSalYCqUlgzmGLuS1clR9RwZ/QfwLcmg4+eONL2exlZyB7hkAyw4fkKCJYdpPC5o/dfd98tzpdP6bMVwTKRn+efwEtbYF9u86xtfDEVvvq15/EyafKyyiqA8+iWcIipKMUNc2UkZUq2zofNYkUipn3NgZbMSujcJjrJnvUIq88giPV2m3/di+yQMnd6FbLLvSpUlFigGQnI+T4ECzwDE9k+PUD8toLwqSWKptdKMHYdPAYK+yJ1YD95PPfmoBtt2mHogitJq51YIWQvlCsNygtuouvlNJTSgmKpwxFoQ5zV/cx5FH0LQKBhXz2cAUxjtpOPNw9r+ST4FSCnlqSIcqEu3BYDsVYdtx2PjW5wSxX+9B/uZ5KL6HSsg6TR4XMIuuYNXXlbwVJ6QhLUoRYfJQJ7RdUHg1o4sEzFIqPvqAEC3hdGWEQo24fcBsvCjV69wSLZ0qBTe44TT0o0XAvpAdSYoB/5at1PGespYlNknNj7To0ysVUIErHOm7PbmQ/pILr+t2zr9ZqXyFifb2EXqE59YZSwWF0ZMcgyFsn6fRozO2G1etHO+GZklfy4W62NWUjtE8zy25TEQfJ31GFw/Y5gjwSY543ap/BIAOj1oah+rsydlrXxiIwg8UOksWig0dKiK9X5ASx2kyrq3rBGqVYhcqoVLqADDa1DkKLeEjUX+zRQ52nFo3G/ZWBYGMPiOmfwHiTxrwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(54906003)(76116006)(110136005)(91956017)(66946007)(6486002)(66446008)(64756008)(122000001)(4326008)(86362001)(31696002)(8676002)(38100700002)(316002)(66476007)(66556008)(8936002)(53546011)(83380400001)(5660300002)(41300700001)(966005)(71200400001)(6506007)(478600001)(2616005)(186003)(26005)(38070700005)(6512007)(36756003)(31686004)(15650500001)(2906002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0Qva2p3dytQcW1xZHRaZTU2QnpXVlpwV1V4RmhmYmtIY3RDMHJoZFM3T2ox?=
 =?utf-8?B?aUVVRkNzajNpcDFSeXVLOXZnQ2g1bUVMZnpFQUNYYnBHYkFveVFuSll5WWFn?=
 =?utf-8?B?dUpVZDJlRXJ0OXdkaGpsNm9ycjhocHpHc09BN3JjOXluSGdkdVkyMmVtdXha?=
 =?utf-8?B?dFZoSlo0YzNwSmhUT3Qwa1Vmb2hXY21pTXBnTDJhWXgyRGRMaHZUWVh2MFlF?=
 =?utf-8?B?cXRLdGN3ajVTVm45bGE3U0J1WnBUUGJaWmNYL3JmY1BCNzR3MmxPUytzL1RF?=
 =?utf-8?B?S3BFMVg2cTJBRG8vUGlXcnovRU9uN1p1UzIybjBGVmtkZTdxRTVDT01wbDJV?=
 =?utf-8?B?NmNLd1FCejJhNmFHMUpYaFJIYXArMFdwWDFWdmhvK3h0ZkVVekRTZFpqczd2?=
 =?utf-8?B?Y2ZJbEFSSXg0NW40bjZzMGlNT0VHQkdyWCtZRVM2R1hqMkd3WnhQaGJQNTht?=
 =?utf-8?B?MU1ubFZhcHJER21EeDhiR2E1d1M4SFJSeDZxd0JlOXU5aUxLQ1YzMGZURXpn?=
 =?utf-8?B?ZytnWTNYQzl1aGtscmRNa0MvSzlISE9LN01jU0lUOGVCRUVIU1k4N1V0aDJI?=
 =?utf-8?B?am1uREV4S1JjQXJaaXMxYWxtcWtaVnQ1RFhxbUxaMGJ0eks2ZEVBcDBoRDg0?=
 =?utf-8?B?azRPTGNOVkZwSWMwK2phSUFSbXBDcmVUSkJyQXV2S2VVRXhWZHBSczh4blEz?=
 =?utf-8?B?d29sZG5jOEdUTWdvUkZxaGlPekI4VGR5b3ZQV1ZTTUtCa3pJbHFqNHpWalpI?=
 =?utf-8?B?eldhWUZ5bVpueUg2VkxDUDI3a0pQeUZ2eFBnU3JGMW9TNXFJaG1mbE51eGdi?=
 =?utf-8?B?ZGlBS3A4ejErVy9QZzR6bjFFNnZ3RWRjazFtN2hyZjV5ODNkd1hxYVdGWU1H?=
 =?utf-8?B?dFZTdnpHNWxFYnFDRE5EZjhmUTF1eG1QVVBLMExMNU0wdWVSZW80L0Urd0Nj?=
 =?utf-8?B?WVhIRi9iZ3ZMMEo2aTd6WWYzNFZLSGlINDRsOUV4V3E4Vkd6SU9HN2MrTEwr?=
 =?utf-8?B?cHJCYVlxaHJ2OUFMc2ZKSDM3czY0NjNGakh5MHY0RXoyd3JNR0NCeHR5alRm?=
 =?utf-8?B?d3FsMGtOL2N6c0JIZlJHcTBqbVMxNVN6YjVqSFhlYk4xc3ErUHBtOGRrd3ly?=
 =?utf-8?B?NTQ3ekkrR3E2NEF3ODJlc0N1QTV2VktMUmNJSExBL0tyR1VHQjBEcUQ1MUlm?=
 =?utf-8?B?dTgxM09iYlZWYUw1a2tDVzdZbDNELzJ3NnhCamZhK2JqSmNyT2poQWgyZjVX?=
 =?utf-8?B?MzBRRkR1T0ROZVJRV0Y1bFJyUDliOGQwdW9sTlNZWWl1NW1tb1VtcldJKzVF?=
 =?utf-8?B?MUNhUDk3cEpIWVlZMVNsNzRIUTJMNWp6SWtaV1VQRkk5SDJKZytYeU9qTTRP?=
 =?utf-8?B?RG9XMnRwSHhqUkp5VVkrM0tmSnlpcjEvNWFxbm1xWDhlUHdSTUpyeFBubnRK?=
 =?utf-8?B?UFZ5NkFxYkhsL3JlRW16RjJDY3ozeUxhZ1dsc0gzWldEdGdMNTl6WStKUjRm?=
 =?utf-8?B?ZFdKTXV1ZmxwSEhBc0Y1WFlzeUNrcVZWa3luWnF3SVFBd0RtMUlxaTNPaG1B?=
 =?utf-8?B?aW1mZnlhb0xNSDNWanMxYXpkYnQ1VTlJOWpmempoelRHWURmRzZ4QzU4ODZB?=
 =?utf-8?B?TjA4NWp5NjFXVk5memdYOXVIR0ZBTHJUV0pwUFZXazZ2RERzeEEzM1hEYTht?=
 =?utf-8?B?ellDOCtnZkhxUVlPRjl2dW8wdkNEK2ZyVXpZZkFOZnk5L2c5Q1Bicm9HUDBG?=
 =?utf-8?B?UDMrYTFUVVcrRmZVaXJ4bFVOd1VtbHZheVNDVUtUWHA4VjVJbWl4Smovb2k2?=
 =?utf-8?B?YzRsZWh3aVJYRmpNUkRHZ0xXa29ibVFvUjE1cElXbHBHODk2ZXZWNVJCdW9Q?=
 =?utf-8?B?bWQ3VGtXUFdQRkQ0cGowdDBCWEg5aWlJeXdBMWJXYTZRMlRsVXkxaGEybjYw?=
 =?utf-8?B?bWM4dUtGa2cyWFZ2eTNNajV4VGYwWkt6UUUzeTdocUg5Q0J1RWQzanhRcXRN?=
 =?utf-8?B?Y056dTJsc1NNcU1QVHZUNEVzKzFRUGZRSy8xNjA0NE4xdUFiN2dVeUtVeXFX?=
 =?utf-8?B?c21FU21aREFVa1A0b1hrTUNnSUNqOS9FSVZDZWo3ZmsvaFh0SnZqZnF3MzZM?=
 =?utf-8?B?VVNmQTI3djd3MXF0K2VLUGNGSU0zZzRGREtyVjZkTjNDL3JuckVpSEpiVlpt?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A90C94B50077CA4787E8F88979106166@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b40aa68-1174-4818-7b9b-08da974a80f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 18:45:47.2823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jl30Vb05Z3Id1Qg6I/Sx8YweuZj0WiqDGka2kRHYT7fN1WE8jQdL7zNZodi/AwXjzRH9epvNJ7D6NNTJXZdcspDZKqiU35xMgIdvH7WLWTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5545
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMvMDgvMjAyMiAxOTozMywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBGcm9tOiBDb25vciBE
b29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiANCj4gVGhlIGRldmljZSB0cmVl
cyBwcm9kdWNlZCBhdXRvbWF0aWNhbGx5IGZvciB0aGUgdmlydCBhbmQgc3Bpa2UgbWFjaGluZXMN
Cj4gZmFpbCBkdC12YWxpZGF0ZSBvbiBzZXZlcmFsIGdyb3VuZHMuIFNvbWUgb2YgdGhlc2UgbmVl
ZCB0byBiZSBmaXhlZCBpbg0KPiB0aGUgbGludXgga2VybmVsJ3MgZHQtYmluZGluZ3MsIGJ1dCBv
dGhlcnMgYXJlIGNhdXNlZCBieSBidWdzIGluIFFFTVUuDQo+IA0KPiBQYXRjaGVzIGJlZW4gc2Vu
dCB0aGF0IGZpeCB0aGUgUUVNVSBpc3N1ZXMgWzBdLCBidXQgYSBjb3VwbGUgb2YgdGhlbQ0KPiBu
ZWVkIHRvIGJlIGZpeGVkIGluIHRoZSBrZXJuZWwncyBkdC1iaW5kaW5ncy4gVGhlIGZpcnN0IHBh
dGNoZXMgYWRkDQo+IGNvbXBhdGlibGVzIGZvciAicmlzY3Yse2NsaW50LHBsaWN9MCIgd2hpY2gg
YXJlIHByZXNlbnQgaW4gZHJpdmVycyBhbmQNCj4gdGhlIGF1dG8gZ2VuZXJhdGVkIFFFTVUgZHRi
cy4gVGhlIGZpbmFsIHBhdGNoIHNob3VsZCBiZSBpZ25vcmVkIGZvciBhbGwNCj4gc2VyaW91cyBw
dXJwb3NlcyB1bmxlc3MgeW91IHdhbnQgdG8gd2FzaCB5b3VyIGV5ZXMgb3V0IGFmdGVyd2FyZHMs
IGJ1dA0KPiBKSUMgdGhlIHZlcnNpb25lZCBleHRlbnNpb25zIGV2ZXIgY29tZSB1cCwgaXQncyB0
aGVyZS4NCg0KQmVlbiBubyBtb3ZlbWVudCBoZXJlIGZvciBhIGZldyB3ZWVrcywgSSBhc3N1bWUg
dGhpbmdzIGFyZSB3YWl0aW5nIGZvcg0KZWl0aGVyIEFja3MgZnJvbSBQYWxtZXIgb3IgZm9yIGhp
bSB0byB0YWtlIHRoZSBwYXRjaGVzIGRpcmVjdGx5Pw0KDQpUaGFua3MsDQpDb25vci4NCg0KPiAN
Cj4gVGhhbmtzIHRvIFJvYiBIZXJyaW5nIGZvciByZXBvcnRpbmcgdGhlc2UgaXNzdWVzIFsxXSwN
Cj4gQ29ub3IuDQo+IA0KPiBUbyByZXByb2R1Y2UgdGhlIGVycm9yczoNCj4gLi9idWlsZC9xZW11
LXN5c3RlbS1yaXNjdjY0IC1ub2dyYXBoaWMgLW1hY2hpbmUgdmlydCxkdW1wZHRiPXFlbXUuZHRi
DQo+IGR0LXZhbGlkYXRlIC1wIC9wYXRoL3RvL2xpbnV4L2tlcm5lbC9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcHJvY2Vzc2VkLXNjaGVtYS5qc29uIHFlbXUuZHRiDQo+IChUaGUg
cHJvY2Vzc2VkIHNjaGVtYSBuZWVkcyB0byBiZSBnZW5lcmF0ZWQgZmlyc3QpDQo+IA0KPiAwIC0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAyMjA4MTAxODQ2MTIuMTU3MzE3
LTEtbWFpbEBjb25jaHVvZC5pZS8NCj4gMSAtIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXJpc2N2LzIwMjIwODAzMTcwNTUyLkdBMjI1MDI2Ni1yb2JoQGtlcm5lbC5vcmcvDQo+IA0KPiBD
aGFuZ2VzIHNpbmNlIHYzOg0KPiAtIGRyb3BwZWQgdGhlIGNoYXJzZXQgcmVzdHJpY3Rpb25zIGZv
ciBzdGFuZGFyZCBtdWx0aWxldHRlciBpc2EgZXh0ZW5zaW9ucw0KPiANCj4gQ2hhbmdlcyBzaW5j
ZSB2MjoNCj4gLSByZW1vdmVkIHRoZSBleHRyYSBwYXRjaGVzIGZyb20gdGhlIGRpcmVjdG9yeQ0K
PiANCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gLSBkcm9wIHRoZSAibGVnYWN5IHN5c3RlbXMiIGJp
dCBmcm9tIHRoZSBiaW5kaW5nIGRlc2NyaXB0aW9ucw0KPiAtIGNvbnZlcnQgdG8gYSByZWdleCBm
b3IgdGhlIGlzYSBzdHJpbmcNCj4gDQo+IENvbm9yIERvb2xleSAoNCk6DQo+ICAgZHQtYmluZGlu
Z3M6IHRpbWVyOiBzaWZpdmUsY2xpbnQ6IGFkZCBsZWdhY3kgcmlzY3YgY29tcGF0aWJsZQ0KPiAg
IGR0LWJpbmRpbmdzOiBpbnRlcnJ1cHQtY29udHJvbGxlcjogc2lmaXZlLHBsaWM6IGFkZCBsZWdh
Y3kgcmlzY3YNCj4gICAgIGNvbXBhdGlibGUNCj4gICBkdC1iaW5kaW5nczogcmlzY3Y6IGFkZCBu
ZXcgcmlzY3YsaXNhIHN0cmluZ3MgZm9yIGVtdWxhdG9ycw0KPiAgIGR0LWJpbmRpbmdzOiByaXNj
djogaXNhIHN0cmluZyBib251cyBjb250ZW50DQo+IA0KPiAgLi4uL3NpZml2ZSxwbGljLTEuMC4w
LnlhbWwgICAgICAgICAgICAgICAgICAgICB8ICA1ICsrKysrDQo+ICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9yaXNjdi9jcHVzLnlhbWwgICAgICAgIHwgIDkgKysrKysrLS0tDQo+ICAuLi4vYmlu
ZGluZ3MvdGltZXIvc2lmaXZlLGNsaW50LnlhbWwgICAgICAgICAgIHwgMTggKysrKysrKysrKysr
LS0tLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDU2ODAzNWIwMWNmYjEwN2FmOGQyZTRiZDJmYjlh
ZWEyMmNmNWI4NjgNCg==
