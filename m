Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7095BA6FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiIPGuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiIPGuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:50:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24950476FC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663311016; x=1694847016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dUx955b8F25g4VaB6DV76ZyXytrEMR6aPxA8JSFy0uI=;
  b=sivL5+PO/arYMBbwr3iPourKPOBlmNr6AspBg2niYNRT3lTHNxNG3V0h
   V/asd9cY/5k0v9WHlKmWtyPxk+E+hDVBffG5+/RRVIIkAsyJbtF4azZT/
   P3wC8cc/KxPlry7+pEZAivHE4sEsTOOWOhRW+z1/8Vn59jvpO4+BsPdk8
   fe4UkcEJApLtc2l0cQVzSQmx553bZmwVLzXLGaXCOVYOtNQMx7aLdimv+
   6qPsu/esQGVCsvQlpthkDSCtnsOTidwoJMri4jL41tDIhrVfSkctlW7IQ
   dgwMn5HyYabtfTrDP5LGF+4YLqv3x57nnk/eopF0rB6Uw6OGxaDnDmTCq
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="113968639"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 23:50:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 23:50:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 15 Sep 2022 23:50:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQhGCfDo4RGrR0hshHkNTUSn/DQQSVTZjtt2jSaEAbn+wY4HnDa3D5E/J1fVNd8+wFVw/mESQcMs35kWi1LletWOd5txz1RdofjLUj7Fi38L5kdsA0vYyPoJeKAJIoqXpaP+oEiQVOgpp8LsXp019UCFUbgb7uI11PAEDG1V2QDbc6pecxuqnpYVOJH4FPIkgxubdhf1CvKRgYhrlf2FzvadSLnoRWRtHkF7CDvSd5JawGxwogswUVvbLpTKxWJoDyE5RF+Jr7ZofCFUtP4qqO7eBUjz74PoXQBrNSvHSYRVZe1BBkYFPfnoTL+t4LOI3+6krspqc0k02a4aVWgy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUx955b8F25g4VaB6DV76ZyXytrEMR6aPxA8JSFy0uI=;
 b=ZRgETf5XbCK/4d+CpIlacLlwl90MYOChU00sI3MXD6YCvINv2GU4KvptrBYr/tV/5KQlQVI6W7G9y+vQWg95sUmrTFbermnpswEz+nMroyttwaxdCQyn+BBmu+hVTPOZ3MZQ2FJfDFlK6t28fxGHCSX104Isci3rnIGLQpjoPz6wV7yX9t67V7mnrxCjvCNwAF28M0HWqTiFY6t4XjIPHT97UfGaPw9rMs66bvpNSGJZ8XKUhZ+rwTHrvFacY8x1MiQ/BaqmOe/RWxCiNdGWl9Ojzruax/udAqU6AvBY7ZOfITbC5OIdVpfs2Z5tEl6Ae/GXQ4cEWBrB+g/mo8yP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUx955b8F25g4VaB6DV76ZyXytrEMR6aPxA8JSFy0uI=;
 b=CXiERmtcE3tsQfhPosTqY47qVjFcLv26MRsoh4Bh1Os4zbKiTvvcfb1vdfdBc2D9C0FzRCx+rKmrMmUdBDE3hoW6bFgJqq7Oeb71SJ1LOHRUhjOfU3demwEmTDmkIfAp4zalCIry0dQSw+H+sU8IA9lXiAbSH7Ah/L9/ewVxeHE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB5960.namprd11.prod.outlook.com (2603:10b6:510:1e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 06:50:04 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 06:50:04 +0000
From:   <Conor.Dooley@microchip.com>
To:     <cmuellner@ventanamicro.com>
CC:     <vineetg@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <palmer@rivosinc.com>,
        <linux@rivosinc.com>
Subject: Re: [PATCH v2] riscv: ztso: disallow elf binaries needing TSO
Thread-Topic: [PATCH v2] riscv: ztso: disallow elf binaries needing TSO
Thread-Index: AQHYyYQq7AHa3Cms0USowTkeq57IPq3hmaYAgAADBICAAAFRAA==
Date:   Fri, 16 Sep 2022 06:50:04 +0000
Message-ID: <e1cbce04-e475-3619-626c-63834495e56b@microchip.com>
References: <20220916030552.1396820-1-vineetg@rivosinc.com>
 <20220916042331.1398823-1-vineetg@rivosinc.com>
 <67a3aba3-68bb-5e8b-4e4e-869c8e99e879@microchip.com>
 <CAHYeh+okQuVQjRX_6CwEK5-zWFDcRfUF132WXt2BNbMSAP8_mA@mail.gmail.com>
In-Reply-To: <CAHYeh+okQuVQjRX_6CwEK5-zWFDcRfUF132WXt2BNbMSAP8_mA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH7PR11MB5960:EE_
x-ms-office365-filtering-correlation-id: a032d07f-8249-4152-f2ca-08da97afaf91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sUhjkSdV4NdfwbZgEAwGanqT6o+KTL68HPwO5K1OuCXzT7zpHsL0Zq2cfOKrsiwihdL/bv+uW/JYzD86MqRybJb+vw7t33W9qw3uhzgsJxNPdAbJ8q1ZYW4Mt1bo8j0Cil8+2DLyd7Q32K5YbvAc+6DrFlJmf5YJbcMY/H5WqzW4CEvk1VBEe3xboMR5H403eKfQ05UxqwFJBhpIZ6FHmYCT3vH3a5lyppypC+tlMg3yOn1Efo04tnaPlf+0K2bMvn7fawBmBYboNyLAZ7WTbIqlvjtUMlv7nCHubhYRqjc5JoDX/nzHQBGxINl+1l7QlobcpAT20d5J1Rap+R0mIFhGJsPlyf+zA7pvG8FRBhM8w42GxoDsjFmvB2QB3Th3oARVvU7Or780TmD17X4peFKTDGQO0DFp6K64f10ATpF/StbRJMRxzgMcUjdqyrpECkYy6MIgfR/hoeaqOzVv2UbRaTnqZe2MYR4YtbebJKhEV18bOPGXNjCJXYu/CSaMDCrdxMjijKO8l8TRzWTliohFMFcqj5Tv7esv+NZcdpPoppWw4FkDFRz8qjokwJcyXJc74f3NJedqYuCMn/9l9b2CS0Xf51/DYOP8dEyR8ezQd94qAEzaxikeB7CGHsb1YtL7++5OgleR4uh6RVX/IYpFNySfzlxuG0R21VqTZsVhqFEb41ha4r8Nl+nFnUp3HFpGoA3Nf9fk0qLO2Gq/i9FwkElVHXV8gQaC0Cv14HSNez+HwhOO+iga/HwwXCaIlvcP9CcNTaU0W33J0vSmcNjuS30SdiDosEJYE1dMOMQS6KNc58w+wr/5V9AuU0wdsmwbzJ3mkw8AD1o6ZB5qtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199015)(86362001)(36756003)(558084003)(38100700002)(31696002)(122000001)(38070700005)(31686004)(4270600006)(2906002)(6506007)(186003)(5660300002)(41300700001)(8676002)(71200400001)(6512007)(26005)(2616005)(478600001)(4326008)(66946007)(91956017)(76116006)(6486002)(66476007)(316002)(66556008)(6916009)(8936002)(64756008)(66446008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGZ0YXZ3c1hOL3lxQ2JBTkd3TUp2TEI5NklvTmsxV1FnemRjNnI3Qjg4S0s5?=
 =?utf-8?B?S2RoNjJNaDcwazBOQ09jcnFTaU5VdWRqVkVWR3BzQzlIS1VFZ0w0SXhqQnRQ?=
 =?utf-8?B?cVhPSUVGS2xDcDQvWGRkaGo4UTUyTytUZlY2WjFhZVVRQi9KV1lXSjQzV0s3?=
 =?utf-8?B?TUQ5Y2I0VmhWWUJyTWI0b2hCeVY2U0tJYzBLdENsd1JpbmYvcnRsdU9wQzhD?=
 =?utf-8?B?ZVdjRFc3SENyeGIzVmhZTHlXTnVLTk5aazc4OWNqTHZoY0Y4SWpxdlVRUHlq?=
 =?utf-8?B?NFlLYjVGeWhiOUM2RE9NblJHOHpyYWxBdnZLQzhtMFdPSENDaVhtb2tVdWNI?=
 =?utf-8?B?Yk85cFRVM1ZWbTU2ZGV2WFVib0c0OWFXSHk2eCt1V1QwU3E5U0JyNzkvUUxv?=
 =?utf-8?B?K0UvWTBVWnpleHpLb3lvZHVib3dnYXdyeFVWV2tDbkE5NlBmRE8rTHdWTHpT?=
 =?utf-8?B?T3VkWVlqNGhCSjZoeHg2SVB1U3ErUHlsWjRxaFFjYUhNTDJVQ2JsTFNxMTN0?=
 =?utf-8?B?N3BoV2FGVVQ4c0g4dDRaL3FyU043NVR1Q2dwNzhUMFh5MmR3RjhoUWpuVTMv?=
 =?utf-8?B?dTE3eXpRZFVRMzdQMlFmN2tVSHFIVG1kclMzVUFDYXhlMzJJZnpNMWpPV1dN?=
 =?utf-8?B?clNHV0RXS0x1ZitxN2g1VlJPSlc0NFNMVUdoVFpiOXZDWDFNRWF2VGxWTTN1?=
 =?utf-8?B?RkhyT3VGU0JkMkc5bzVQMXRhVWdDNVVEcU5td3lUUEJIUlNXK1hhUnpsTVBr?=
 =?utf-8?B?ZFpOTVVXaVJMbGR3aERxZTV2SDVQRG1ZNzJ0OTRFVmhNQmZYZVhyR25RLzZ0?=
 =?utf-8?B?bityNFZtaUhlQlZycUZ3NU9xV2FvR1dXMzB1M1lSUVZPQzZXVHNUdWZmbDJ1?=
 =?utf-8?B?eWYvWlF3MjBiQVdzZ2NWK3RGWWYxOGw2aGlLTXF3elp2QnZCMzJoc3BIQVBT?=
 =?utf-8?B?b3hXRTlHOWVORlNQb2JUR0VwRHM4UkRYVWJ4R0FBalJJalBMeGIweVh4YjlI?=
 =?utf-8?B?TUw0M0FUZkNJMGlVQ3U0MDBrWTZxTTl0Zk9nazhWemNKcW9qcklsd1dCNlhv?=
 =?utf-8?B?WElaSXlsMVcvNEM0QUM3NVBmSFVOdHFwSHNOUmd4Ly95VCtsSDc5VUQvRnhU?=
 =?utf-8?B?OEVURUtpdXE5K0hvZXRJMEdSMVFRcTAxNXpoSDdqeHlxR21ORG9FUzBHT1Vk?=
 =?utf-8?B?RU1zcU5QVmJSRTZIWTB6U2doUlREYWxSdzR1NExJM082QXNBYTNJNGs3WTFL?=
 =?utf-8?B?Y1dTMVhuR2JKdVRlM2hFQjU4OU1oS0JWeTY2OXlCR1VoSmhzTEc5RllYQmhG?=
 =?utf-8?B?SW40YlJKVnM1U29SNmtKeGZkWlRBakg0UXpraDUwVURHdUx0V1k0VzdhS0N6?=
 =?utf-8?B?MWJQYWlLR05PTTlWdmprVlY5aHJkS2hIbGNJVGNkRmJkVS8vbGRRQWxiUmxP?=
 =?utf-8?B?a1E5S09ob2hRVG93ME1pU3pPZHhnZkVJanlrSTVaUzdjTTBmblBtS0VvN3No?=
 =?utf-8?B?dGhkU2l4d2U2eWV1d0k1SEtRSUJHcXF6UHNIZXBqK0J4am5tcUQyUU9kc0Vm?=
 =?utf-8?B?WG9VdGVieXgxMjdIdlBRMzFCOGFlRHhuMGNqS1d4OG1hNEU2aVVtTzRKbThF?=
 =?utf-8?B?cVBFREdhTm04eUdzeVJ1S0I5TnI3bmZUZmlLa01SWUFYUm5TKzN0anpRTVNv?=
 =?utf-8?B?YmtzcTk2NGVzcXJTZVpoYVlFaldJLzZPeFc2anQ4aHZITjhDdHBIZDhEdzBt?=
 =?utf-8?B?Sk8vT2JYU2RxNlo3bzVuVHcyMFR6b1piTXJYbUY3RGszQVJvZkM5a0VRa3c2?=
 =?utf-8?B?NThLamJ1azRPNG8zd1crTzhPSmZEUmxlRTU1d2duekVmWm5ZZUltMFZROUZy?=
 =?utf-8?B?TnIxYk0vOTFMQXIyVGl6Wm9kNkVyT2x1S2UrZjlzNUJhNmRvVEdHQ2VtMjF6?=
 =?utf-8?B?QWM1dWpYQWMrZUhla1Urb2dSYkp5VzRYRUZyQ0pabytiL081dndSR1JCc0dX?=
 =?utf-8?B?YUNOREVwSmUwa25sTzd5WEZ2RjF3dkRYd2o3OHFLdWNKWVA5WlF5UnhFbE9s?=
 =?utf-8?B?c2o5NEpXL2xDZlF3anMzUnprUXB4cXNudjVTblpaMnlNckoyczFlSzBRTjNK?=
 =?utf-8?Q?JhcnXaaxR7rV5tarrLfNTNdMC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60311719AC972E40861ABA2BB3BC58BB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a032d07f-8249-4152-f2ca-08da97afaf91
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 06:50:04.6681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iri+jPwKdLVtUrjIgj+a0kbzRKG8QTd1okAfm4O5TRDGOTw9C3pcmglVGP0FFOs0WP5rPxaaw1LS+I0KJzOZEvZlH30bYpwaNPnGqHtdOY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5960
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIGRvbid0IHNlbmQgaHRtbCBtYWlsIHRvIHRoZSBsaXN0IDooDQo=
