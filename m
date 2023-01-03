Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B0D65C1F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbjACO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237746AbjACO3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:29:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4056204;
        Tue,  3 Jan 2023 06:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1672756159; x=1704292159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SG2+ZdNqsaSkTGXwsu4Qg1uQbAp1W62XzAHh2GpGGXk=;
  b=jddhGZh1dyzDHdHBKiCL9jesGpzO7S7fmLtYdilddwys4ULAvBbvhgap
   8rPB40b71dslquMrpeU3tHCjjMPV2PR9hCKK4u6q/GUjzHvt2ICyJ/7QP
   fwgAZDGnkhITTRnVSMKH+BNU4rhzor+1ne9KG8HgKRwnC1u7E4UgaXl9d
   6+MFpWV+X8qUMtLBclHdvZGcY8HLiJZG9/YwJs/V2cCCL7ES6qhMiyiGV
   60yI1y/RTXsclbx3DZJCSjsKBGP57GIEKtg67VIr3mUScE276DJzN6obU
   JE35mxfP6KskIoky3pU6mjki3pnpC3AiUmqoJUGijxmBXS3t5TFscHk8i
   A==;
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="130582106"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jan 2023 07:29:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 07:29:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 3 Jan 2023 07:29:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h30lMZP9n75e2SE2Sjtx38dlkl8Se08mZXkkISZbAvna2Kiqw9M22U5axa5eqm9mGrj3j09hD4D/LAwxYWQgfJ2JklS8t/qd8PxNJ22KrpvwNq65B9P1hRkjf6mlarLKVH4OKvygeqWbyqBrSc3DdSNcVNpovKAdUW5x/l7BN/NoxlpJWqHOKqhn+4KCbDdjYjDP1MQGQwA3bzCWYFzUzDfvb4hNmxpG4Km4XDi9nmIn1N8+mC5zLukgJWdYdOoNZBNG8WkjvlRePmdjduCJuJ2TBAFnGKb/pBON5DUMBVfm5RLTS4Bv4bT+LSfJhtsZp9uJZXPkr5v6UvUAvC4mig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SG2+ZdNqsaSkTGXwsu4Qg1uQbAp1W62XzAHh2GpGGXk=;
 b=JK20x1r6desOT2TOWseQRNxVHB+1T2JcxzGZ5jk5rT+lzHwcu8gzoBzCD6IzMb2wAn8pNDyz3M6QgzNHgofuPQjUDVVkQCxtoJJxHlwiu4cwrd+NBw15wfAI7/lQehLOn9hLpb77orL4YOWYGtaVDrLiaelBCZCBysTjrVV5U+mRz2N5H+sPOuKxl8JMFE85VesXPV/ZjThPXxV+nw9dbrpM7tY/jdTCvQXDKVYMmG5zhRMCmR+22KSPmuM4tx/UzdGmL0fLhvUENR3t9KQ7vk89nEXwbMiPsKbWHgvKTP0CWWZEy5ql2kUc42834vKu4TLwF7Mfjaq9JssX1PYA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG2+ZdNqsaSkTGXwsu4Qg1uQbAp1W62XzAHh2GpGGXk=;
 b=H8yVm06BNvHlFbRLwLILOr6NQpp+pLZcb9UGgb3jkSxeFoQqke4j90uYLgeu8oa8XAjogx8TKR61nZCLmnJnA6WHc2daNqm/oC9T5/wpU1aapn4aTjjOGa90Ixb82BJQcveMgEk/HDqK4eM1l6TYj1C9DRRMQ55xwDjA7if/NfY=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BL1PR11MB5400.namprd11.prod.outlook.com (2603:10b6:208:311::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 14:29:14 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::108f:e428:de3e:8baf%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 14:29:13 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] memory: atmel-sdramc: remove the driver
Thread-Topic: [PATCH 2/3] memory: atmel-sdramc: remove the driver
Thread-Index: AQHZH3/AvUwd1xLAGkqTIYbyuGhZEQ==
Date:   Tue, 3 Jan 2023 14:29:13 +0000
Message-ID: <26653401-058f-7fda-9da5-5f2bfc945ca3@microchip.com>
References: <20221208114515.35179-1-claudiu.beznea@microchip.com>
 <20221208114515.35179-3-claudiu.beznea@microchip.com>
 <2f9793fb-8840-fd3c-8af1-42c6c11ed475@microchip.com>
 <9054a7cd-2993-840f-1f4b-7837b43a1800@linaro.org>
 <23389f8e-daf4-67ca-1e3b-c5a6433f3986@microchip.com>
 <4632f71b-2b67-b634-1cdb-69ac741a8ef0@linaro.org>
 <92347fcb-46b3-d1bf-82f1-960f69300a29@microchip.com>
 <414b2785-fba0-1426-d059-befeabe9ddac@linaro.org>
In-Reply-To: <414b2785-fba0-1426-d059-befeabe9ddac@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|BL1PR11MB5400:EE_
x-ms-office365-filtering-correlation-id: a9ed7067-3dbd-4420-58e1-08daed96e333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wmDNOKv+Dgl+eMN9+xzjJT9hPO5vbWJPzwLxhKyjmeA0KJ10YmTHLAf1OF8dJWDcp8HUuGsreDdYahVOO5g2bUBc57yVc7RNFaHPo00PbMBmI10W3NRfchKXRgb7rrWpof4s6wq3DC0+AzoSwInA4i7OfW6I6Fk3H83EqOaIyJl0katTrMtRUjOAS70UEvyz9eMZQxzX4oZvUS6NDQ9+rJRiKPtFE2010BBTZuwUjgtuaC6uEfIu4BbZR0FLCwGhijJrEnHEEDKxt9oQyysa3114ykB4r5GlQap7AwdUBddbo2ViK8+2YMXlbTMyt33BZqlP7IkSvKEX08t3sRTyXQhkW5SnuWQ126AY1Ywpd2XpfIiTekqJtP/YdFhVcX4wmYT9RBwBdZ1zCGeuoQmhhxmvkUZ6bMQS9fg/QKoPSpfGKVHK9LO+qL9PHB4kvTEhnreP4s82TtfK8LRcPD5AlgkP3ebZC9TnQobgv9xgpjEK1OLumaA7yuE3GQdqmpz1AeYiO2WPsX6NezioVSdsNajkeLj5IWKxaJflDpkjk1i9TcfDuoa5hPqRzojcmrNPVE8ItJOefT6x+UzuJj/l4RqvD5W1JEnmxA+pC0JemI5kb/i4Up3gjsbSCerPRtDYIHWI93rZpEECnP9ACSY28ede6O2rBAd9PbsPu9iQdj3jG4ALYaWMRA5CqdP+jz0a+ipvZn45s2UPFKDv6jEDDXoUXC4XkBxeoVwvMdIM6ecOWk6pWCLtttMJ48n4VhYTR9qQVt0L9IYrkQqWGa5yFl8mG7PjSrenTY2bR2IKLkE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(66946007)(8936002)(66446008)(66476007)(76116006)(91956017)(8676002)(66556008)(4326008)(5660300002)(64756008)(54906003)(41300700001)(2906002)(31686004)(316002)(36756003)(110136005)(478600001)(53546011)(6506007)(26005)(2616005)(186003)(6512007)(71200400001)(6486002)(83380400001)(86362001)(31696002)(122000001)(38100700002)(38070700005)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWM5aWpsOW9Ub2FsYzcveVlLQm9kNVBiZGVSeGJsVUwvK2c4TndpeUVYR0dn?=
 =?utf-8?B?TE5GcStydFhXblQ0Z21CYXp1SEpFTHBJNjRsUW9IQTFpUHZRUG4wSHEzdjha?=
 =?utf-8?B?NHRHdkFyYXBxZlYybndKTDR2cU9wV3E4YlhoSHNMSTFkOCtXNEdGR3luVHpC?=
 =?utf-8?B?NkwzZkVWQ1QycVZqMmNvS1F3djVxcUREa3l3N2laMEduR0Zva0xLZzJZSTF6?=
 =?utf-8?B?bHFFYzRXNm1ZVFJ3Y1FtMWJ5UVU3Wkt4ZVMxVlBlclJkbFVpeFV5S1k2bXYv?=
 =?utf-8?B?YVR2Q0pWTy8zTytSVTRHZitocHozK2NGUUp5S2lrQlBZRUtmRE1lQVRCVlRm?=
 =?utf-8?B?Y3o5dVVSblMwRnR2VHhlQWRtSmVNUDZ0ckNydjV3RnRGTjlzNDB2N1JsemVi?=
 =?utf-8?B?eFZtQURheXJLUlUxWGV6THNKMGtON0orOHlBdzFCR1Y0QXVKa29KZEpvMW5i?=
 =?utf-8?B?UTh4azN2TVVpL0RZVWNyYWJEVDN0U0g4Zm1OMGVTdDVkNitSS2Z0dmpQYmla?=
 =?utf-8?B?Y2dyL09TcTRTekVjcG5sS2YxTWJ1UDZpdGlsbHhrbGozRmJLUWpsaC90TXJZ?=
 =?utf-8?B?R0pVRzlhaEt1SXN3SUhuRHdJckQ5WTdBakVPeWdCOHpzVXR3OXpjQXRubHQz?=
 =?utf-8?B?WUlzSWFCN3ZSZDVoLzR3R3BpeElJcnV0V3hrb3VmR3Fva3ZSOWVYLzcvY0U2?=
 =?utf-8?B?dU5wTUNQRXpHR09heThKajB3ZlcrNjVWY2xETHluQ0tRZ0wrMXZ2cmRKNmpB?=
 =?utf-8?B?eFQ2NlIxalpSbUZqNFpOaDVCaDBSTkRrQ0xUaFRRWGVSdFNsczBudTBLWHpl?=
 =?utf-8?B?a0ZodEw5TGtrai95cmRvN2pqL000NEZWNTVDUmkxQXAwWFhUS2tST2lpaWR6?=
 =?utf-8?B?bXBpbVFuRkxYOE9IUHI3RS9GamFwQk9qMyswTHUrcjlUUVV4WUMrZmpPVjN1?=
 =?utf-8?B?NmhDMFpNTVFqUWtmdFlkY25WdVB0ZDZDOFRJbk9kZjlZd3c0NGx6cVM4OFg3?=
 =?utf-8?B?RVNvWjhTellPenJ4Q0h5aDFEemo3L3RmTFhHejlGQ3FibmtxcTZZRmdEZmZ6?=
 =?utf-8?B?aGptc0p2TC9sNi9pUHppb0JCM2NNcUEzZUNxWDh5VXVrdVFsMkhwaWRuUkV5?=
 =?utf-8?B?YUdkanFUVUhXZUMrdzIrTnptcDZlOEcrci85QU9VZDJIcnFqZWljL0NIc1Uz?=
 =?utf-8?B?eEljcURVZ1pCWlkyQWlWNGI1dWxBV29xSGlwc2JuYlJVS0x2eVVSWXNFdUR2?=
 =?utf-8?B?QTNlbDc0c09md2NkK2tOUDd5aDNYYnBoa2JnTTNVMzlVRDlKZCtNTU5NeHFE?=
 =?utf-8?B?aVhHb2xRRlh4YmE5NEdBS1pLUzN3TmdZQThIZkMzaHR4eFAyV0JNa3YzdnpB?=
 =?utf-8?B?aTluZWpzUzZIenFsa1ZpaXVmVG80MUt1OElUTUc2ZU5vb3NML2FnL0hSK3Qy?=
 =?utf-8?B?NHhTTzhsSUNIQnV5cFcyWHU3N1JRbTRyd2pkVkZuOHZUTURoOXE5dWZGczVW?=
 =?utf-8?B?Z1lmVXVwN2hVcjMzY0x3TjB6RGwyZ0R4TkVlcjVRLzZHUDVGSXdyU1BUMkFR?=
 =?utf-8?B?ZFZzVUhXeWVXQ1NMWXVNMG10VHdJbkZGM3FvNEhmbW5FejFFd2ZQM3RvZW45?=
 =?utf-8?B?OGJSU3dPVDhkRElGRlZ4b0wveEdjVndCOTQzZjg2Z2dhVE92d0QzQW5aS0s5?=
 =?utf-8?B?UDJnTExML2JwUzR6R2RVeFNMb0haVVZTdDByK2QzNFFObCtPSGFwZDNhWGtj?=
 =?utf-8?B?NkQ2NVRIZkVFRmxaYkt0NU9rMEJFWGMxeGhRMlNua2pXSnErQW41UHJhREls?=
 =?utf-8?B?cWZOUmJ2NTdUL2hDZkdYWjlKOUNkT0FpQ0FwcGJ4bGc2SXplTlVlR2dJNE9x?=
 =?utf-8?B?VzdaK2VCeXEvNG9kQTRIa1c3TTBCRmRPSitucnJVbWdxZi8yQmdHM2Y4M085?=
 =?utf-8?B?RHA3MFRITlJKUFlGVEc2bVR1U21xNW5XdkFrZzFJaVNTTWUyb05rS21KU2Yy?=
 =?utf-8?B?SS85b1ljdmFRYUhyaXlBcUtCb1pDdHRGNHhlanFrTkdhdDJNRGpCaWZPVmIw?=
 =?utf-8?B?ZTNxNmkxbXlMbEFmdmFNRmRnRFBHWnFiSTMxclhBQnFPcHlkY2VqZkVEdEx3?=
 =?utf-8?B?dkZOQ09SdFBCUTJOOVorUkpXclBOa21jZGtlVUdLbmNaaXlKMFNlSzZ3RjZm?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D43190BE3509C48938A2EE7038D0588@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ed7067-3dbd-4420-58e1-08daed96e333
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 14:29:13.8391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JtaHEw7oeI9q3vATaI03exj4eDzGfO34592uT7uHg3sGWPnfVx4k+cWlGfsb4AVWFMo01Z1kucYn0kq7MiiDoSFyoA1HjMT+bWbMIjm3f4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5400
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDEuMjAyMyAxNToxNywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwMy8wMS8yMDIzIDEzOjQ1LCBD
bGF1ZGl1LkJlem5lYUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiANCj4+Pj4+IFVoLCB3aHkgZG9l
cyBpdCBkZXBlbmQ/IEkgdW5kZXJzdG9vZCB0aGUgY2hhbmdzZXQgaXMgYmlzZWN0YWJsZSBhbmQN
Cj4+Pj4+IHJlbW92YWwgb2YgdW5uZWVkZWQgZHJpdmVyIHdpbGwgaGFwcGVuIGxhdGVyLiBPdGhl
cndpc2UgaXQgaXMgbm90DQo+Pj4+PiBiaXNlY3RhYmxlLi4uDQo+Pj4+DQo+Pj4+IEFUOTEgZGV2
aWNlcyB3aWxsIGZhaWwgdG8gYm9vdCBpZiB0aGlzIHBhdGNoIGlzIGFwcGxpZWQgYW5kIDEvMyBp
cyBub3QNCj4+Pj4gdGhlcmUuIFRoaXMgaXMgYmVjYXVzZSBjbG9jayBmcmFtZXdvcmsgd2lsbCBk
aXNhYmxlIEREUiBjbG9ja3MgYmVjYXVzZQ0KPj4+PiB0aGVyZSB3aWxsIGJlIG5vIGNvbnN1bWVy
IGZvciB0aGVtLg0KPj4+DQo+Pj4gVGhpcyBJIHVuZGVyc3RhbmQsIGJ1dCB3aHkgZG8geW91IG5l
ZWQgdGhpcyBwYXRjaCB0byBiZSBhYmxlIHRvIGFwcGx5DQo+Pj4gMS8zPw0KPj4NCj4+IFRvIGF2
b2lkIGhhdmluZyBBVDkxIGRldmljZXMgZmFpbGluZyB0byBib290IGluIGNhc2UgeW91ciB0cmVl
IChjb250YWluaW5nDQo+PiB0aGlzIHBhdGNoKSBpcyBtZXJnZWQgIGZpcnN0Lg0KPiANCj4gQnV0
IHRoaXMgcGF0Y2ggaXMgbm90IGdvaW5nIHRvIGJlIG1lcmdlZCBmaXJzdC4gSXQgd2lsbCB3YWl0
IG9uZSBtb3JlDQo+IGN5Y2xlLCBzbyB0aGUgZGVwZW5kZW5jeSBpcyB0aGVyZS4NCg0KT0suIEFs
bCBnb29kIHRoaXMgd2F5Lg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1DQoNCj4gDQo+IElmIHlvdSBu
ZWVkIHRvIG1ha2UgaXQgaW4gb25lIGN5Y2xlIGZvciBzb21lIHJlYXNvbiwgdGhlbiBJIHdvdWxk
IG5lZWQNCj4gc3RhYmxlIHRhZyB3aXRoIHRoZSBjbG9jayBwYXRjaC4NCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQo=
