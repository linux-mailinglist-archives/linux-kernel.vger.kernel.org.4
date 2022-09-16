Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF1F5BAC57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiIPLZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIPLZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:25:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F3C870A2;
        Fri, 16 Sep 2022 04:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663327510; x=1694863510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=StnkOTup/JkP0wn/u7ELOqJhRHwjt0tNYinra+SctPs=;
  b=bKxLV7RDDblDqbsnhxhPmLp/2YrOr0Cs3rIsi3dyhLjjRMOzGrh81VaP
   60tkKAQ/zSb7tP3rGISFBuhm2g+iqYw1ewntUWlnVdvTrr4G/1kzX5MDL
   eRZ6flRZmYlhMFaYg8foGYbLW8ko2b2lOyP0Wb0zIdGxkqEX+WsEDmIih
   2B8eugVAy9+/Kd3PspHM0WcakOTLYWrstLX7YAXVTztzZ1Eq+NFvSpShv
   ixoJuETvQVugnBHB6eL/QRt5CVwy1zfthycgadzhCWoascBYAy8T0OjAq
   qkVhsLc6E8QD70H3FEilMEGoTdAwp6iQfRwcdhjG6pD8CZm3y4KagMexP
   w==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="177482693"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 04:25:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 04:25:06 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 16 Sep 2022 04:25:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDRt9+0LBVF0/KHE2tToAXroYY0pIn584dPOo0LyW2WjO+wotzCDQfYU6ajTFN3OMSjCFWFnYB3SffD/Sqs6FSKafcSn28OfN12OVzSWBF1u0L7yxb4TQTzdR+QrkQROymmYphJDQt0zQY7xivnPWP/2dd8bB5YxPcKq24iO3+DYJW+0uUwVyKhBdeaiDCKneMHSvnyEWaKFJ8LBEHBgUH5yssGYB2NK3tQ+ms2lmdLgU9OZanG9Y3CHUlMkKdhTtrhTY2JKssA8R6xwpN16IOJjHuRYzFfuMpW+tIQEQ56PhjM5YB7eWO58yjopndkTjjhfU09FnfKbw1Dy9o9KJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StnkOTup/JkP0wn/u7ELOqJhRHwjt0tNYinra+SctPs=;
 b=fGYA2JrcIqv+O8AlzWtS0KC/4ZBTAhytmK0Y9TuK16B7cUM9g4uZXxjxi2wtNuOHmnVyAuTP1NafvsVp1Qjt6CEONl4iEac6danNilSl2O63QpjWZ32X8/o1caaXoAxiquF/TlPDWVLCJJc/wbsXiMaGgA2utLVdtOsu0YKL8kB4n7WwHMQc6i78l/7KoFw4znCGxIxSFCeYjs8tDSERZi9oY3+m3vI+hus33ctjJkoZ7paOvFQxoVL0OnBqcTYjeX0sXqzMWbxbzuMnQNr0YcaAOk5VBAMWI8LK4DK4xrX+36kRmhQnKqzyNody758F1AeS9MVHrHac5Jt0iJRMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StnkOTup/JkP0wn/u7ELOqJhRHwjt0tNYinra+SctPs=;
 b=ITIAa22chxxwFwvs4tbFCRUTLo+Aort22B3LMx0rRE1UfJVxTYNA2z/XEyE/yJKsWB13/teBrXl/jd2gxxygMbVsahNVX0YLNYEfK7KXGK/fw1FpEzBHx5PiaF4lc+rMyyCXNp7w7vEdohnD4HbDEaT7zXAI8wLsuLTgNelhT40=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM4PR11MB6551.namprd11.prod.outlook.com (2603:10b6:8:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 11:25:01 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5632.017; Fri, 16 Sep 2022
 11:25:01 +0000
From:   <Conor.Dooley@microchip.com>
To:     <linus.walleij@linaro.org>
CC:     <dmitry.torokhov@gmail.com>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] gpiolib: rework quirk handling in of_find_gpio()
Thread-Topic: [PATCH 3/4] gpiolib: rework quirk handling in of_find_gpio()
Thread-Index: AQHYw0XIZd+swKHCKkmkQrigMcng0a3h8WWAgAAE04CAAAESgA==
Date:   Fri, 16 Sep 2022 11:25:01 +0000
Message-ID: <f418c688-2b1c-2df7-632d-14f493baeb07@microchip.com>
References: <20220908053949.3564796-1-dmitry.torokhov@gmail.com>
 <20220908053949.3564796-3-dmitry.torokhov@gmail.com>
 <9056cbec-a411-5f87-a4c1-2f77bb2e3a33@microchip.com>
 <CACRpkdYH5FdB2+=Jrh4fvPXoz6tU2CyJF=i7cyC1ipS7T3TpqA@mail.gmail.com>
In-Reply-To: <CACRpkdYH5FdB2+=Jrh4fvPXoz6tU2CyJF=i7cyC1ipS7T3TpqA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|DM4PR11MB6551:EE_
x-ms-office365-filtering-correlation-id: bc1a3246-0f37-4eba-2e68-08da97d61899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gzykfzysIMldU1FpDZBvANIdaiLnHcTaN69TcQlnUtjelXEAXYMeuYTjFwdvnNxrZ1xO6bK4aSThtdbuCtmrDGZKBsQXO6FGJIe7hbfrr+eH2ehbkQ6+c6/x/nYw/bDCxOYLG8ScplVjm9VgTTJSV0zWYbyNR7kAUqmRqkl0Mi/1RQni6lRAnVI2oVLxNrvHbHc2l4OL0Q1vz5jtou8a34DEhk0aYr+LGctgRdj12zotTSFMzJyYcV8Gn4eTsHhs3bSWPdbPa7oze5/o+CFy4deUZpBH1LsnnYqibc+rmwlBtgMSB6FO+pHPiRj5Jl7tmTIHsk1kpWFIly3WFiQ1Jh/GOrUz6Us44l05Se6JykjQweJFaS6B4JkvqChw9HLRo9MsxjVXsYVHo05KwYpu7j7AHVtV1vze8z87mex249oths2Sxtg+SpGhweHNYr7dALpcPMAu04XXrjOcb2EeCqoLd8lGzHAZ2i7uN2lmRxyajR/8hitKNWnHp+DfsdBIAMYuqQgQtTLa7tnA37IqGQZFEZT0R6suF+i6wh1Ao6zGgz08MvDpEZDxaSicL6t+YiFGBT+BDOL1rkHJyIVRY2mVkYGJ0VY8fwCYmFVWIttXcqQ/v1YOs49IpedtwWL2oef1NxQct2Mbx/Xru71udDbFAJLDayfZ1HTPTeIAy6hNywY1UqCKdTLyPdysAmRnU8CfnazAALFVRgrQIeHejboAO2V/qkWBbKpTaiKXIAZe3AedyhdDreNI9Ozka4RtrOhTwsWCtepSraqru/uyeLFqrZBgfq7PWX8wWt2J39tfe0RYxHWcDVVeSq12oKRk2R9tML9hOWMk06yW67G3/d8OSH1yCC3j/dI73f6hrlI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(376002)(346002)(39840400004)(451199015)(31686004)(54906003)(186003)(2906002)(316002)(122000001)(36756003)(2616005)(53546011)(38100700002)(26005)(966005)(86362001)(8676002)(6486002)(64756008)(4326008)(76116006)(38070700005)(71200400001)(41300700001)(66556008)(5660300002)(91956017)(6506007)(31696002)(66946007)(66476007)(6512007)(6916009)(478600001)(4744005)(8936002)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THg1SHFDZ0dwMVZwSjJzZUVSR1FFQkg5Z0ZIWTg5RUxWMUp4UG5TM011UVlm?=
 =?utf-8?B?cHNIcDFNSS9Vc2w5RWJrUlpmSnFYVXQ1cHVWc3N4OUhsMjMyMk9YRHJGUjZ6?=
 =?utf-8?B?cVhCQ2E5STB1VEZLSDhObkcxdFVvQWJaMkJyaW00ZkZrNHFBZ04xbUhiTitQ?=
 =?utf-8?B?Y25tb0ZwRS85RFg4NzB5LzBLTUtVR0Y5MWl6dUVmTENMbm82MzQ0bFNWNzdj?=
 =?utf-8?B?VjVPeFZUVTZ1Nkh5N1RVN3RGM2thRUs5MEJ6b2pNdDNBemRUOXJDeUlYZkpr?=
 =?utf-8?B?REF6UXpPOTFJeWt6WURNbWdSRlVNQ1FadURHUGFMSTRyUTJFcmJaSGd5RGx3?=
 =?utf-8?B?akh0eWFOVWNCSDBvZVB4d3hJajBya3lSMHpNQTVhTW54azZXd252ZzFHbnVU?=
 =?utf-8?B?RkZpMnpQMi9GSCt3QVowY2kxb3Z6eUt1RGg4ZEFkbDI1Y3dvZWpKd0tGRy9p?=
 =?utf-8?B?QTVpa3llR2tBTi9RQUt3bUY0eG5qOExoNXY4eGw1WkRXWDlpZW1DYmFaWHla?=
 =?utf-8?B?UCtTMTZEbyt1VmRJRmE1b0w1UjFPMlk4L25YdTFxN0RsM05meENRelEzSmti?=
 =?utf-8?B?MXVyeEd4WnJlN3NvdG5UUVp2S1IwTUlqZnBkeUtnUDYzRTJqUHlweU5UOHJK?=
 =?utf-8?B?d3BjbktzL2hlU0hEQWpid3p6TkR4TmVSOXU2cldzckNudXdNaUdiblp1UXlj?=
 =?utf-8?B?UGxzRjdLRkM5WlRsZE5LUEN0U3ZybXZJTFUwS1c2cjRkS2RZU3FTdU5vb0VD?=
 =?utf-8?B?UFdDMXhuV0NIcFU5MjA2SHYzbFlkaWJLSHc0Tk9xTEhGUlYxZVNmMDJTbldt?=
 =?utf-8?B?WjV6dmpKdmJlamgvbGxTZTg4c1lBZWxMTWFjZ0hLTFplZ3dhZTZHKzFObk9n?=
 =?utf-8?B?VFhFek5rWEY5VThsaDVXRkJOSUtaMi9uOTZNUDcvWFkwMXZVVmJVNHBNV0RB?=
 =?utf-8?B?cmVOTi9waVFBUWlkYjZBd21rVDNNV2VwelZXSjZuRW9pQXpaUVpWS3QwN0Nw?=
 =?utf-8?B?ZW1tTW9DaldQeks1VVYvWEtocXJwR2x5bUlKMXVFMU5ETW0vUktvcFVKM2F6?=
 =?utf-8?B?MkkyQ21sSktQMktQU1BQS3NWNlB4cFdTaWZTSkM4bEVocUFSU0FNNWs4dzFr?=
 =?utf-8?B?aDdUeElNcmg5ZUpyVSsrWVVlbGsvY3pSaFdVMTFhekNjUlhpSTZvZzVtcWNp?=
 =?utf-8?B?dXdKTDhYOTl5b0RFRWNlUUpoeXRVOEV0Nm1ZNG03MW1lMVZLOFduVDJRSExK?=
 =?utf-8?B?M1hYcE1MNE9PRExiTFU2MnpRMWNtSkF3MlQ1M1ZhZTh5SHdHQTFXRFlTNjlD?=
 =?utf-8?B?R2NKY09qQXVrbTdsWWM4UDNETkxUVEN0ZjZKTUZvL0wrY25rTXZPcnZOZHRk?=
 =?utf-8?B?eThMdG1xOFA1ZENlQ3RHQjFtNlZ5VHo5REd6TklTMDhVbE94VFBGZlNJZDRE?=
 =?utf-8?B?RnNrUlRKNzl2UlhXN2JkamI1dm12UG4wdmpVem9pMnErL1RQaktSeHBTVWhP?=
 =?utf-8?B?OWJIRmgxakVjR3g5bm1DTGpsZEZmbFlpK1pQMkJkdmMzTkpleGNiaG0wY1dn?=
 =?utf-8?B?bXBQYi9IbVZoblR5NXdqYllzemF1Ujk2dGRPSkNrVUVqbEJGbncvcWpHMlV3?=
 =?utf-8?B?Qko4WEFKeWFiclowWnlpOE5Za3p4UVZ2eCtaeFoxMkhWNS9lU01UZXpEUHJ4?=
 =?utf-8?B?RDM0TDVZY1lWZ3hlVG9wK2IwWVdrVjFOUHJFa3Jxbnd0OE91WHZwa0JDSXZF?=
 =?utf-8?B?cmF6SU9BeUJJSkJ2UEh0WXZlSGNCcTJoc09Td3poVUVGekhQMHBXSm51aGd2?=
 =?utf-8?B?djFQNTNqQVVucm80bE52UmtmNG9vNFVjdHA4YzJJK2YwdEtmOFgzMnpKbkg1?=
 =?utf-8?B?L1R0MXV0MWdHc1Q4cEtMOW84dFRkUy83YmpWeHNURmxTTEJQbUVxZXJBZ3FF?=
 =?utf-8?B?a2ZWcmpNK0VYaG1FWkt5MWFWZ290UW03Qzd0Yjh0cUVNcXdaamVkczNlK2s3?=
 =?utf-8?B?OVdsdjhWU0YwNmJIZHpZV0pLeGg1WHE5Rk9yL0Y2SWF5eWRmeE8vUTd5RHFY?=
 =?utf-8?B?OTVTb3BFd2cxUWNXcmp3V2VVZ2xiamh3K2JqeDBVekdBcjlIVDZKdmlCdTJI?=
 =?utf-8?Q?wW5G0IKNA8JDYmaRZCEDzFI1Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EC54429D5D3334B82C0A49E26B5E4C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1a3246-0f37-4eba-2e68-08da97d61899
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 11:25:01.7677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tx4sJS11kHOY1QjV1vG4LxiDG/X8/Llxp3rMZoJGmuRvarAN+bjLJFUZSLIe6V+/ZnK76SBPIBvBw0WHjoo4woYc3i+3VqAdmiCrLjgkSHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6551
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDkvMjAyMiAxMjoyMCwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIFNlcCAxNiwgMjAyMiBhdCAxOjA0
IFBNIDxDb25vci5Eb29sZXlAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gMDgvMDkv
MjAyMiAwNjozOSwgRG1pdHJ5IFRvcm9raG92IHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gSW5zdGVhZCBvZiBoYXZpbmcgYSBzdHJpbmcgb2Yg
ImlmIiBzdGF0ZW1lbnRzIGxldCdzIHB1dCBhbGwgcXVpcmtzIGludG8NCj4+PiBhbiBhcnJheSBh
bmQgaXRlcmF0ZSBvdmVyIHRoZW0uDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBEbWl0cnkgVG9y
b2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+DQo+Pg0KPj4gSGV5LA0KPj4gVGhpcyBz
ZWVtcyB0byBoYXZlIGxhbmRlZCBpbiAtbmV4dCB0b2RheSBhcyBhMmI1ZTIwN2NhZGUgd2hpY2gg
aGFzDQo+PiB1bmZvcnR1bmF0ZWx5IGJyb2tlbiBib290IGZvciBtZToNCj4gDQo+IE1pY2hhZWwg
V2FsbGUgaGFzIHNlbnQgYSBwYXRjaCBmaXhpbmcgaXQ6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWdwaW8vMjAyMjA5MTYxMTAxMTguNDQ2MTMyLTEtbWljaGFlbEB3YWxsZS5jYy8N
Cg0KT2hoIGdyZWF0LCBJIGNoZWNrZWQgYmVmb3JlIEkgc3RhcnRlZCB3cml0aW5nIG15IG1haWwg
YnV0IGRpZG4ndA0Kc2VlIGFueXRoaW5nLCB3aGljaCBtYWtlcyBzZW5zZSBnaXZlbiB0aGUgdGlt
ZXMuLg0KDQo=
