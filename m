Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F56E6F8349
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjEEMvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjEEMvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:51:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314DBA1;
        Fri,  5 May 2023 05:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683291094; x=1714827094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BW6gBcFqBmO9g7z0/fkOWtXGrVStnkNT+kZfJZyyo/Q=;
  b=DThlLTfPY3Et8SZlaicFI28FHVlRHrC2UYqt7s2EQ/+Mm08fwlCI6f0P
   F+cPHjJnb33djUfBtcpYa+njGLupBnXx3F0lg2YQbbaGnEjS0YGjA/IMu
   DZlh8xVbqEWUU5/2oU6TAEYy3CCBm3WQ7QlAP0Tl7L3DJp5GQan4HqmCM
   WU6KCv5CCwuvnEkLvCouw+R6e7VsAJkS1OANhUvYLEg249vRwiAIp6G96
   9xo13QmUMqG4QR+S7q2/y6KkxccAu+783IaW6L3I8McQZKrQaUqdpgAA/
   3qoPM4IUiUMgO7uzTcpqfk5618TmymqhdFprVwMIBDdW1C/O8P0+H2z0v
   w==;
X-IronPort-AV: E=Sophos;i="5.99,252,1677567600"; 
   d="scan'208";a="212059821"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2023 05:51:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 5 May 2023 05:51:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 5 May 2023 05:51:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kun+YNYsbwDmDeQyg6ryegzeBEBjHZSD/kTjHvfPgyXj+RXS4FkffQlBM68cVTRM5jHTHhLf+vi4wZGVS8cKQXbCKeG3Y6BHiEKXK2xBaKNpuQUM34nlj4peOTicQvc3bYUtyD/adMDTPbqxJeodQrhRgKTGUV8R5ucF7aoAX8NJxnb727n0gQWOiBhLumird9wHVx1zElwPhD9Ho7Kbc8UeciypSq2hd9rffPuBtgwrSp2IVGj50SUEdipyl8qaIjdrMwWzSqcVCy0aiV8mf2g7TBrjPfvb9BGxPPiiriRXLt1RMcbSiU2e96GRJ20W5r1Bt4Ut6xAcDXVNJhClnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW6gBcFqBmO9g7z0/fkOWtXGrVStnkNT+kZfJZyyo/Q=;
 b=mHNbfYAp6K0jyayr+oT/VoQW3npD5tezvfE94qb5jRUbFNt7cEbHvpXlOixv2i7UJR7Kvc2Ei/unm/tgAFrznxUG4vw0Z8IaUM0k9E/u3wFPKUtfOHDRttC+iAkogaoSowW2QdJEj1WY5ZhCGZLhVI+kJ/I1jkPdH+26PGxeBNlp7xBIdo8l9BYtdZrGFvB/5/DFRmJoMf1uUWj0+Zzzm/4lrx4KKXLpPKCRWYCiLarOHTwm4YJM0m5GD08/bBmjNDGdhO9Iz22VkntZAB2xtTRlYmb+wRUaoE8fJTuDDEmzNt8T0bdwsM+hHI+ZxcQ9Ez1IDFoMnxCpoU8lR6aXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW6gBcFqBmO9g7z0/fkOWtXGrVStnkNT+kZfJZyyo/Q=;
 b=NuoX4psWnGSvkVUWk8iv526Qi5mwPif8ZavL+D5EYvkFDIgCaAvLziv4fJsUJ/w8deRTCu/geWctnmtQ9q1THJda9T1NyuMXubgwy60r9pVLgppv9CblgLjfD1QDDoCTusCO8mxZbOFqDMcXEiAwJjolCtr+2mdYselG1KHC8mk=
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com (2603:10b6:a03:4c3::17)
 by SJ0PR11MB6767.namprd11.prod.outlook.com (2603:10b6:a03:47e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 12:51:28 +0000
Received: from SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be]) by SJ2PR11MB7648.namprd11.prod.outlook.com
 ([fe80::27bf:a69f:806f:67be%2]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 12:51:28 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: clocks: at91sam9x5-sckc: convert to yaml
Thread-Topic: [PATCH 5/5] dt-bindings: clocks: at91sam9x5-sckc: convert to
 yaml
Thread-Index: AQHZf1BP49/5Vqs1yEGb0OUk59pbpQ==
Date:   Fri, 5 May 2023 12:51:28 +0000
Message-ID: <04a13f5f-40f2-2bcd-8220-75db8857fbe9@microchip.com>
References: <20230504060729.689579-1-claudiu.beznea@microchip.com>
 <20230504060729.689579-6-claudiu.beznea@microchip.com>
 <7f9f991a-fa56-2f65-293b-bd0ec5d07c40@linaro.org>
In-Reply-To: <7f9f991a-fa56-2f65-293b-bd0ec5d07c40@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7648:EE_|SJ0PR11MB6767:EE_
x-ms-office365-filtering-correlation-id: b6cf0144-92aa-42fb-ccce-08db4d677180
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +yITeBJ7MWWRRUohgzt0asDSh1WixOFp4prMwEWdJVJw5v1K/UTnbcHjZ+DT7cIlcsr9SBE1vMtuNqpGzEJ3rix3g9T1VmSo8coZdY3gUAIW7W/Kg7GIhJGOKXZBgDxVmwVOXLcmXiCK3l/bUBDOnOixOHZzeSchzUCYExTEzuGoLZ06/UkCIyjgMhIj1ihpq9GiLxWEdPS/iOTIXmmyU6r8D1n27KnHbKRwDVQw3jFUVOSdW4AWLViNtWWFMhac3mdr7pgOlNvAirWRYXmvmW3QL0vrEtUm5kbGxZOAi2HrSkN/v1/VmVcwdOPH3q4LXu8TthKveHbRolsRrSugWchA1FfxvF5KjU7GikN8QE71+1AxK/yqYoahhtkQZEdTOmJY0HL2ftxILZ/LozYiqP5FJZnhacLOmuhy5pg6jT/3fmKOWJMVyKXT1A6vTh86dZwC43wbRXSej8hPh/sxVH3aCD8Lw4dMUr/g/jKV3T9BsVu/ySyMBpUK2CcEuFl3BIVVai+prJ6XZzsBqLAwIR3nr1hU0ynQcnPEw9yRqbpnygikBxjbvJ2h/8ILcw2zR3VLNM8DVv6cqwR/YEu5LiZh3tvyL05QQNX9SS34h7tCeVLe1+KtVfKJCKlKlowK0cqdpNSyazt19iAuY5GRQVhorMmwktVhMNUOPUUo0xeM/C+ojgylLgVYBj3ddb2EN0mzbsbM3+ZXX2jmzpVMZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7648.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(41300700001)(122000001)(38100700002)(6486002)(38070700005)(478600001)(2616005)(6506007)(6512007)(186003)(26005)(53546011)(83380400001)(71200400001)(66946007)(66556008)(64756008)(76116006)(91956017)(66446008)(66476007)(31696002)(54906003)(86362001)(4326008)(316002)(2906002)(5660300002)(36756003)(31686004)(8676002)(7416002)(110136005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2QzME91UmxVNlNUR05vMlU2TERvb3cxanZJei9wRmJFWlE2akpLSkpnUE14?=
 =?utf-8?B?dkJKditvWUo2andlNzVWdnhnZ0xYcmNYVGxnYUFWbW8yNVNYSWkrb1phcjk1?=
 =?utf-8?B?eDZ2OEJUTmQ2bEMvL1FoVWdKZ05wcEZ5Q0tlVFdFVnRiRTY0R0ZMbllvV1BP?=
 =?utf-8?B?Z2RaaWlYZFY4UVA3c2dKRVAwNVpNeWVFeExOSFFVQk9sOGRld1FHMi9KM0Jv?=
 =?utf-8?B?cmlxV21jYlFTbklILzJtS0Zma1poek9NT2ZzTURBVjB6RWZoMXJPRml4Mld1?=
 =?utf-8?B?bkRNa29tOXd4WWo3bFhCY2s0SDM2NXR6UTdnVGhyVExCVWtncldLa2Y2d3Vs?=
 =?utf-8?B?SGFUTFhzUVFCU1hQZkhUejE0eGFLSFRZU0dDTGVVQmZHTVBLRlVPOXh3cUxY?=
 =?utf-8?B?b0c2UVpwTWxFVjZTQTRjd1FTUXFqcklTais4TjE0WnZDLzdJeWtRVGlrYU1E?=
 =?utf-8?B?ZnVGQTNseXNUd2Z5QUFSUGtpbnIzVldXdlVZeGJwOHNORFh2Yzh2ZjR0Nzc1?=
 =?utf-8?B?bTRabjJxQnBtTWZjcHcvVXVZWTYzMDlmRE9PcWppcUp3djJITG95SmtBMmFL?=
 =?utf-8?B?QWFaSTBOcmxoakgxc3E0d0JVUnF0aUhaNytOYXdRRksrN3h5SDZmeTYyR21y?=
 =?utf-8?B?YTZUWStLQjNkQU4wTE5GZDBFWTRCNXE1K09UM0s4amRkN3BmazVpb2tGS2NR?=
 =?utf-8?B?YTMxbWZKMXZGY1Vxc01pdkxSVjQ3S0l1WTVwWkE0R2lwbTZyYUg5N1hwZFll?=
 =?utf-8?B?dHlpNTlSVE52YTV0cmIxSlZDeldmUnZPS3hiWDFNbmZLSDg1S1dpRDRKOGQ2?=
 =?utf-8?B?ZkF5U1VCS25NN1l5TGVDdDdPdTlodk1iK0pxa3RJaTFUSFRYZ1NFSjdabFYr?=
 =?utf-8?B?L1BkWDh1QlRLcWo3cG1ib2orRDgyamVJb01PVFlEbjlDdFZ5dC9iSWZ0aW92?=
 =?utf-8?B?elRRdjBCbkxzY0xUd1VFZnVjQlB3UnB4SkhFTGFKVTJNSFFjVyt4OEJsbStD?=
 =?utf-8?B?ZDhiVTIzZTM0Mm1wNTRFU2wzbXBWTXpzZ2s0MHN6bHVOdy9adllSNGxMaWpn?=
 =?utf-8?B?Z0JhcXlnNFUzMzdHQ0ovN3h5eFRMU2FZTFkyOXRjOWNEK214dDBlUjBzeGN2?=
 =?utf-8?B?Sit3VlBDbmoraTl6eWpRdDFrYXRPWTBDWW1SNnFNbTRJNzFPWGlNZjRWRUd0?=
 =?utf-8?B?TmN1NDdaWnA5d241ZklsaGNQdDFxeFRxWG5NN0h3VkJLSnFDT3ZJaWo5alJJ?=
 =?utf-8?B?RUl5YzVYNU9nZ3BLN3F2TWJWcmRUaXdxbUVIUjdaUTRKWGVrcUxhWnRISVIw?=
 =?utf-8?B?d1pvSlFXUjI0aEJaeUpiVVBtczBZK1BzckhOQVVac0RMZ21lOE9EYTlTcEx3?=
 =?utf-8?B?ZFdaV1FPSHZYLzY5TllFOW1CYW9kWTRudC9MdndZbFErTkFjeWZMa0xJZC95?=
 =?utf-8?B?MTVOU0NwbElKVjM0ZHdNWlNDS2htNnBIVllmOElnSFluaHUvRTZxUjBka2p3?=
 =?utf-8?B?K0NmZm1NdytSalZ1REhTaFFxTnNGVHAxck9PZlNMNXBlQ1R0MENGNENKMHUx?=
 =?utf-8?B?UVc1WXo1NkZETmdJMGQ3WXRscnBOK2o0d3pPMGZQR05hVElSWjJDRXc3c2RJ?=
 =?utf-8?B?SXlaNDZsYkN3M3NmNGFwNHREeGVtSEtwa2RHYmp4djNjYVl1K1RXclE2OTdQ?=
 =?utf-8?B?MHhDbWhLN1RmWkRKUHdtcXl2OEExczBDMmlUS3laUFlndkVmak94SHZlK1Rp?=
 =?utf-8?B?YTI2QlJMUXl1UzhyRGVvY1J4TnV2VzBNZmFTTndrSFo1RnJVRDFrZGtVMDRx?=
 =?utf-8?B?MnNjeEw0OFFMTlNkQXYxRm5KdlJoekdKV3Iwd1dPVEVXVEMvbDQ1M2Zvamds?=
 =?utf-8?B?d2haTWVLQkFoNE1oWlkzSThnMUFrdEZYSHRkcE5DVmd3K0EyaW5LcDVMSGZW?=
 =?utf-8?B?MEJWTzBBclRNQVFSMnFrTGNiKzkxanAxdkcyRnNXYkFucXJHRExxQ1F0Qkt1?=
 =?utf-8?B?UEw5d2hFTWlGLy9KYU1aeUpUM0gvRkttVnRCUlU2N05tQXRJTHcvVkVTanZ1?=
 =?utf-8?B?UjR2R25TTVhkNWpRLzl2RHNDcnJiK3JDT3ovWHMwcDhtYUJIOFRqQ2tDa2s4?=
 =?utf-8?Q?cBkAr285/6fWYVtC2sleQCosa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A791989E44EB1B429A8F0E2E539191BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7648.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cf0144-92aa-42fb-ccce-08db4d677180
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 12:51:28.3990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpOxVJHr9SYpe0oXwuke3tQ4HxRIaEqQ1VgOzNwz7N39NXwmMD9aw70GGv352DbhgYNIWQyvtBKmoQ/oHbOpXzvy9ILxT1HOPzpYuJA92jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6767
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDUuMjAyMyAxNTo1MCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwNC8wNS8yMDIzIDA4OjA3LCBD
bGF1ZGl1IEJlem5lYSB3cm90ZToNCj4+IENvbnZlcnQgQXRtZWwgc2xvdyBjbG9jayBjb250cm9s
bGVyIGRvY3VtZW50YXRpb24gdG8geWFtbC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1
IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2F0OTEtY2xvY2sudHh0ICB8IDMwIC0tLS0tLS0NCj4+
ICAuLi4vYmluZGluZ3MvY2xvY2svYXRtZWwsYXQ5MXNhbTl4NS1zY2tjLnlhbWwgfCA4NCArKysr
KysrKysrKysrKysrKysrDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspLCAz
MCBkZWxldGlvbnMoLSkNCj4+ICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Nsb2NrL2F0OTEtY2xvY2sudHh0DQo+PiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxc2Ft
OXg1LXNja2MueWFtbA0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvY2xvY2svYXQ5MS1jbG9jay50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvY2xvY2svYXQ5MS1jbG9jay50eHQNCj4+IGRlbGV0ZWQgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggNTczOTQ3ODVkM2IwLi4wMDAwMDAwMDAwMDANCj4+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdDkxLWNsb2NrLnR4dA0KPj4gKysr
IC9kZXYvbnVsbA0KPj4gQEAgLTEsMzAgKzAsMCBAQA0KPj4gLURldmljZSBUcmVlIENsb2NrIGJp
bmRpbmdzIGZvciBhcmNoLWF0OTENCj4+IC0NCj4+IC1UaGlzIGJpbmRpbmcgdXNlcyB0aGUgY29t
bW9uIGNsb2NrIGJpbmRpbmdbMV0uDQo+PiAtDQo+PiAtWzFdIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9jbG9jay9jbG9jay1iaW5kaW5ncy50eHQNCj4+IC0NCj4+IC1TbG93IENs
b2NrIGNvbnRyb2xsZXI6DQo+PiAtDQo+PiAtUmVxdWlyZWQgcHJvcGVydGllczoNCj4+IC0tIGNv
bXBhdGlibGUgOiBzaGFsbCBiZSBvbmUgb2YgdGhlIGZvbGxvd2luZzoNCj4+IC0gICAgICJhdG1l
bCxhdDkxc2FtOXg1LXNja2MiLA0KPj4gLSAgICAgImF0bWVsLHNhbWE1ZDMtc2NrYyIsDQo+PiAt
ICAgICAiYXRtZWwsc2FtYTVkNC1zY2tjIiBvcg0KPj4gLSAgICAgIm1pY3JvY2hpcCxzYW05eDYw
LXNja2MiOg0KPj4gLSAgICAgICAgICAgICBhdDkxIFNDS0MgKFNsb3cgQ2xvY2sgQ29udHJvbGxl
cikNCj4+IC0tICNjbG9jay1jZWxscyA6IHNoYWxsIGJlIDEgZm9yICJtaWNyb2NoaXAsc2FtOXg2
MC1zY2tjIiBvdGhlcndpc2Ugc2hhbGwgYmUgMC4NCj4+IC0tIGNsb2NrcyA6IHNoYWxsIGJlIHRo
ZSBpbnB1dCBwYXJlbnQgY2xvY2sgcGhhbmRsZSBmb3IgdGhlIGNsb2NrLg0KPj4gLQ0KPj4gLU9w
dGlvbmFsIHByb3BlcnRpZXM6DQo+PiAtLSBhdG1lbCxvc2MtYnlwYXNzIDogYm9vbGVhbiBwcm9w
ZXJ0eS4gU2V0IHRoaXMgd2hlbiBhIGNsb2NrIHNpZ25hbCBpcyBkaXJlY3RseQ0KPj4gLSAgcHJv
dmlkZWQgb24gWElOLg0KPj4gLQ0KPj4gLUZvciBleGFtcGxlOg0KPj4gLSAgICAgc2NrY0BmZmZm
ZmU1MCB7DQo+PiAtICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTl4NS1z
Y2tjIjsNCj4+IC0gICAgICAgICAgICAgcmVnID0gPDB4ZmZmZmZlNTAgMHg0PjsNCj4+IC0gICAg
ICAgICAgICAgY2xvY2tzID0gPCZzbG93X3h0YWw+Ow0KPj4gLSAgICAgICAgICAgICAjY2xvY2st
Y2VsbHMgPSA8MD47DQo+PiAtICAgICB9Ow0KPj4gLQ0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxc2FtOXg1LXNja2MueWFt
bCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9hdG1lbCxhdDkxc2Ft
OXg1LXNja2MueWFtbA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAw
MDAwMC4uNjI2NjBjODIzZWExDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svYXRtZWwsYXQ5MXNhbTl4NS1zY2tjLnlhbWwN
Cj4+IEBAIC0wLDAgKzEsODQgQEANCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BM
LTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICsk
aWQ6ICJodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9jbG9jay9hdG1lbCxhdDkxc2FtOXg1
LXNja2MueWFtbCMiDQo+PiArJHNjaGVtYTogImh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNj
aGVtYXMvY29yZS55YW1sIyINCj4gDQo+IERyb3AgcXVvdGVzLg0KPiANCj4+ICsNCj4+ICt0aXRs
ZTogQXRtZWwgU2xvdyBDbG9jayBDb250cm9sbGVyIChTQ0tDKQ0KPj4gKw0KPj4gK21haW50YWlu
ZXJzOg0KPj4gKyAgLSBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNv
bT4NCj4+ICsNCj4+ICtwcm9wZXJ0aWVzOg0KPj4gKyAgY29tcGF0aWJsZToNCj4+ICsgICAgb25l
T2Y6DQo+PiArICAgICAgLSBpdGVtczoNCj4gDQo+IERyb3AgaXRlbXMgaGVyZS4NCj4gDQo+PiAr
ICAgICAgICAgIC0gZW51bToNCj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5MXNhbTl4NS1z
Y2tjDQo+PiArICAgICAgICAgICAgICAtIGF0bWVsLHNhbWE1ZDQtc2NrYw0KPj4gKyAgICAgICAg
ICAgICAgLSBhdG1lbCxzYW1hNWQzLXNja2MNCj4gDQo+IEtlZXAgb3JkZXIgYnkgbmFtZSwgc28g
NWQzIGFuZCB0aGVuIDVkNC4NCj4gDQo+PiArICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05
eDYwLXNja2MNCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgICAtIGNvbnN0OiBtaWNy
b2NoaXAsc2FtYTdnNS1zY2tjDQo+PiArICAgICAgICAgIC0gY29uc3Q6IG1pY3JvY2hpcCxzYW05
eDYwLXNja2MNCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+
ICsgIGNsb2NrczoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgICIjY2xvY2stY2Vs
bHMiOg0KPj4gKyAgICBlbnVtOiBbMCwgMV0NCj4+ICsNCj4+ICsgIGF0bWVsLG9zYy1ieXBhc3M6
DQo+PiArICAgIHR5cGU6IGJvb2xlYW4NCj4+ICsgICAgZGVzY3JpcHRpb246IHNldCB3aGVuIGEg
Y2xvY2sgc2lnbmFsIGlzIGRpcmVjdGx5IHByb3ZpZGVkIG9uIFhJTg0KPj4gKw0KPj4gK3JlcXVp
cmVkOg0KPj4gKyAgLSBjb21wYXRpYmxlDQo+PiArICAtIHJlZw0KPj4gKw0KPj4gK2FkZGl0aW9u
YWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiANCj4gcHV0IGl0IGFmdGVyIGFsbE9mLCBqdXN0IGxpa2Ug
cHJldmlvdXMgcGF0Y2guDQo+IA0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSBpZjoNCj4+ICsg
ICAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgICAgY29tcGF0aWJsZToNCj4+ICsgICAgICAgICAg
Y29udGFpbnM6DQo+PiArICAgICAgICAgICAgZW51bToNCj4+ICsgICAgICAgICAgICAgIC0gbWlj
cm9jaGlwLHNhbTl4NjAtc2NrYw0KPj4gKyAgICAgICAgICAgICAgLSBtaWNyb2NoaXAsc2FtYTdn
NS1zY2tjDQo+IA0KPiBEcm9wIHRoaXMgb25lLiBJdCdzIG5vdCBuZWVkZWQuDQo+IA0KPj4gKyAg
ICB0aGVuOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICAiI2Nsb2NrLWNlbGxz
IjoNCj4+ICsgICAgICAgICAgY29uc3Q6IDENCj4+ICsgICAgICByZXF1aXJlZDoNCj4+ICsgICAg
ICAgIC0gIiNjbG9jay1jZWxscyINCj4+ICsgICAgICAgIC0gY2xvY2tzDQo+IA0KPiBNb3ZlIHRo
ZXNlIHRvIHRvcC1sZXZlbC4NCj4gDQo+PiArICAgIGVsc2U6DQo+PiArICAgICAgcHJvcGVydGll
czoNCj4+ICsgICAgICAgICIjY2xvY2stY2VsbHMiOg0KPj4gKyAgICAgICAgICBjb25zdDogMA0K
Pj4gKyAgICAgIGlmOg0KPj4gKyAgICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgICAgY29t
cGF0aWJsZToNCj4+ICsgICAgICAgICAgICBjb250YWluczoNCj4+ICsgICAgICAgICAgICAgIGVu
dW06DQo+PiArICAgICAgICAgICAgICAgIC0gYXRtZWwsc2FtYTVkNC1zY2tjDQo+PiArICAgICAg
ICAgICAgICAgIC0gYXRtZWwsc2FtYTVkMy1zY2tjDQo+PiArICAgICAgdGhlbjoNCj4+ICsgICAg
ICAgIHJlcXVpcmVkOg0KPj4gKyAgICAgICAgICAtICIjY2xvY2stY2VsbHMiDQo+PiArICAgICAg
ICAgIC0gY2xvY2tzDQo+IA0KPiBhbmQgZHJvcCB0aGVzZSByZXF1aXJlZC4uLiBidXQgdGhpcyBp
cyBpZi13aXRoaW4tZWxzZS4gVmVyeSBjb25mdXNpbmcuDQo+IFdoaWNoIGNhc2UgeW91IHdhbnQg
dG8gaGFuZGxlIHRoYXQgd2F5PyBTbyBvdGhlciBjb21wYXRpYmxlcyBkbyBub3QgbmVlZA0KPiBj
bG9jayBjZWxscyBvciBjbG9ja3M/DQoNCkFjdHVhbGx5LCBJIHRoaW5rIEkgbWVzc2VkIHRoaXMg
dXAgYSBiaXQuIEknbGwgZG91YmxlIGNoZWNrLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3
LA0KQ2xhdWRpdQ0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoN
Cg==
