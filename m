Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122FA5FE44F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJMVe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiJMVes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:34:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C8EB870;
        Thu, 13 Oct 2022 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665696884; x=1697232884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VZTH6722m98QTHSUhCBhla6OtfjrNnjY5EZoCy6q/cA=;
  b=X7GlX5wPVQZR/EpWOJ6vF13wVROyonOFTroOSqJLjmLyCByBUmy5I+Bv
   OyH+6MlmybzUdDdA2kKIKPyAAwe93YrDAcZnPtFbMyTZBiyzX7rbMfnmU
   gRecDLbTL/I7cQIPwPvQ+MDbSRMLM0UUSVXHHmEaNq2FF/I3OqkAXm1ty
   0K3WMeF6gh0zOPWTW6pXXBHiYGmkEKF+SFQwaVXJ7ehnhVLTTsnOoD1vJ
   z941BLl8AZDEuGkYMkdWmLtwmG5+lBvVwgCXMuU8a0KAsWq8qBg0/gqhy
   vEG737x73J9lpGYfHvbiMWBWshxXmCRNUmSVT6TVLeW/i//gpDOuCM5d8
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="118485327"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Oct 2022 14:34:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 13 Oct 2022 14:34:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 13 Oct 2022 14:34:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewrIkEAHvRZvEx/D3J/uHhrF5Bl/rAPYMmE7Qf3yzC/TE7/5aVT/CUcsGsSgpSMYa5IyulP/WXB9vr55cuLuM5FInCGTgOFemYUWSJYhFW9yX8IYcid2fTx81peVF4KQOU0bSuHx0PwqlEuX6e2IQV8qlEbBa2ipW4hnOs1KMVgi6/b0oekUT8xrMjlTiSkiOuxKitLgzEmTwfSVgiQ+XGRRFgLspE6I7wIrYBcxFQuTAbovAn0hN+0xde2MvzcihuK7vYQQ4/92YAwHkdbLq0lS8RxMIOvuYglAoc0qhyjiXgpUHYcyeY7eSiszwav0530LKN2UEmv5lK5+NisAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZTH6722m98QTHSUhCBhla6OtfjrNnjY5EZoCy6q/cA=;
 b=ilS48HWoSea7ptFmDK+UIXBZv88jHXOPX7jHR4Rnec+c8rciXQuGBeeLyOUmyRM+YvZrmlFjBismhHe2qpuVjyixThFWuA2RuUrIS3z5oKqWuShTs5gJwXrB/dhyARI6s2fsDDHCDLvHftsL1hte462Uz29awexwrL9PRb3WQEhA2i/MWuxpxSPLi3+TcpSn78Tq6JOfVXq53FQmCpG/OA2DTjEHePUadSG476M51ijDUtRwPtmuK7M6boLKsAGbcxQS4QHxwWsO/NpeegBUrhQDQNZmPSTuZsG2s/xeyT4swsFTLGC8/b1e+wEkwwZqCmsbMr5KYL1tzrW8OI5m8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZTH6722m98QTHSUhCBhla6OtfjrNnjY5EZoCy6q/cA=;
 b=dXqy9bkhZc6d4Q5gt1CLUce6uPl2tf28HYqXmBj54/GG6doYmZIfKhvSGmX9i8Baa89tYaU1k8eC/FUQU6imSpyK2Yz9DwVQHyiP0iCH5XmXN4FL08a42q03/opOvVx5F32XHLE8vrxXjEvjuepve6LZ68Zg055dkvfAUJVwFAk=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 21:34:26 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::68c0:270e:246d:618a]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::68c0:270e:246d:618a%3]) with mapi id 15.20.5709.019; Thu, 13 Oct 2022
 21:34:25 +0000
From:   <Conor.Dooley@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <a.zummo@towertech.it>,
        <christophe.jaillet@wanadoo.fr>, <Daire.McNamara@microchip.com>,
        <Conor.Dooley@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Thread-Topic: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Thread-Index: AQHYt5IndXqzWMJbz0OfuNYZ1M2LkK4NJ4kAgAAAdQA=
Date:   Thu, 13 Oct 2022 21:34:25 +0000
Message-ID: <5d78b5ac-ee87-102d-f234-c9a51d53d111@microchip.com>
References: <e55c959f2821a2c367a4c5de529a638b1cc6b8cd.1661329086.git.christophe.jaillet@wanadoo.fr>
 <166569636075.1226796.3261311337977278707.b4-ty@bootlin.com>
In-Reply-To: <166569636075.1226796.3261311337977278707.b4-ty@bootlin.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|CO1PR11MB4964:EE_
x-ms-office365-filtering-correlation-id: 85ff4aba-ddcc-4eef-3ea1-08daad62b3ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3K7yp7ukg9GuvsVfyjTIpQnOI+9czLdg8dJR8rpqySOP3v+9P2Gu57jQB0HnQtlzfaxi79Sy5nV11Mg/vT55bk2fUFfkLGhggeDT5yfmqUbowoIpXaMievXc2LgFtJi4Xbmjl1Sn35B6pPyEflS0Yel9+7vjUU7+tr0VGwNqAbC2IjnVuBxV3zWzTmbnQ8axuqhnk0P0R+KjUaVqxbRwHPQm1290RsDyjvZqoma3SzzMmHywKWsS7rFyCW5UONYQcsu2X+krHdEIEyndbRHGfUOorEjT4ouDfwq80qGxCmBCwC+4wAIVqaLCRKuMbowxqhvuHp2aTJnYHxxUlUO8W6Es2t4mP7tvrrvCpzG5qEX0Ftrwpfnff1/kx7Ydt2mjrW1h3oST8Wf14p8rDo31tyuyjn8xJzhs0CP1fUWzwGWuQO7gwdnruG1lCC+cQ4xmym7vF80wpuT1GAsMQ1IRXmbO6og7U1pLaVl/Gxs5PiYPDfMVqDhIJIEqRLKYyQYjNJUBgSFRfG4Pqc68cRbmfcMGvk9FwGNJGlqaygRIsExiGj+zkdYcFGAdRKFeYM46A00Zrbk+nG3mzDV7M+Pu+JnwK1KM7TUKxjXt5mbJnJZltgXVlSydOEAv0Ag1UfeU6Fy+mwatb9WKH2ip2PuqKYmgKJtpMHFOGkJDjev5sOURGxmMlWifxaMR4TSDlbhN10HJcy0X5o5sKR4q/i7mmQETfeJJnkWLyQiX/KBopXW2podmKS1TIYRdfczdK9O4u0XtOmuY7qm/OJ/aSVV+JbtFS4/SU+9WdBjRxUghSTayQj9K80ByrocIAL2dviSTMEbkBjom1lFWON8eGQf3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(66946007)(186003)(4744005)(122000001)(41300700001)(2616005)(5660300002)(38100700002)(8936002)(2906002)(4326008)(6486002)(6506007)(110136005)(8676002)(26005)(316002)(76116006)(64756008)(91956017)(478600001)(54906003)(66446008)(53546011)(66556008)(71200400001)(66476007)(6512007)(31686004)(36756003)(38070700005)(83380400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmkxcHMvekQrVGZYVm9JMFVLSFp6Q1NkcWtENk1ldEJOS0RIcjl2UFR6N1hV?=
 =?utf-8?B?THJwenl3OTBKRVJDUGxTVVMvL3QyM3hRb3NnVW9vQ1JZQm9CdzFvNm1VcWlH?=
 =?utf-8?B?a2JGU1FJSHZOaTVIMm00VkZSbzZ6ZCt1NjhscnRBYVJXcWJTazkyUy9UWG9r?=
 =?utf-8?B?MExXTFdzajVWRWNVZDVUOEhvRWtUSWtubm9kY0gzR256VHhuNG1VR24yZjBz?=
 =?utf-8?B?TmVEYlYyZjBwTHIwYXVIVno0MnE3LzljTi9GMWE4N2ZqaGsvZ0FYZE9YUldB?=
 =?utf-8?B?bFZ6V2ltek0zeXM2L0c3Z3dUWXhJUE0zSkJNYTVwelk3UlU4RnJSczFvS1dh?=
 =?utf-8?B?bnc0TkZ3T3ZIWlpneURMc0lON1duUXpnQUViMFZFMjFRZmt5eDQ4ODN5ZTBY?=
 =?utf-8?B?Vml1aHAyTFZNOVlZc1Z4VXkzeDFwbTNWQXJ2UVF3Q1JGaERLMnFmaHREd09a?=
 =?utf-8?B?SVY3N1JuUFVjbklETVdhTlRVZkVEWHJyYlRwSXliaFdoTUR3VU1tdHBvRVp5?=
 =?utf-8?B?R0x1U3I5eHlZekNOWDMxOHVwRWNOR3RFWGJDam5Ga2EwNldoNUNwTGtWK0du?=
 =?utf-8?B?c1JEZnppV090SjZhOHVZbGE1TGh5WjUvekp4V2MzVnNrS2RLak1OblVkcExZ?=
 =?utf-8?B?ZUFxZmRWTWhHTkJ0ZzYyME9MdUp6MHJiUWh3S2xxRVNwN0NGZ1laeDc3NGdK?=
 =?utf-8?B?Q3g3S041cFA4T0FPLzM3aFlZYlNQYWRpeXhPOSsvT2ZvQUozM2FVeStLdlJO?=
 =?utf-8?B?TUFXa2xHRllSUEI3N1NjYjhFRGRvV3pYZVdyNERhQWl0cjZQR283R0lXOHRC?=
 =?utf-8?B?MUx0djQrVmZrZ21EMXNLbGlLMmNWR3pSVnFlclB3bXdsRzFPbDdhNC9aMHJB?=
 =?utf-8?B?SERlczgrRG5wS2U4UEx2SlpCaUhTNlBUaEk5eGF5N0kwQjJYWWhqWUhyM2JJ?=
 =?utf-8?B?SlI5U245eUtDQVB1STFhYWplc3EzQTIzZEFUazBtRVNRcnNKeWJjV2NhYWlJ?=
 =?utf-8?B?RXJuWldsdWxVbmlPRW9PQjU0K0tGMmxGYlE2MkVZaXAyV1ROZkRydlIrdUt2?=
 =?utf-8?B?R1ZFdE5TSVp4cm9kY0ZaUEhlZ3BsbVFJUnJJaFY4bnpSbUxScHl1V0I5UHls?=
 =?utf-8?B?b0VZVmZzYjluc0NtMVcwTXF5c01oUHZLWkwyR2pHYjREblBEWTZlSWgvVjNW?=
 =?utf-8?B?UEI0Zmt2UkFNMTdxaG5Dc1RWeEpIRkF1TTNLRGNLYmxRN29nZ3VONVlpR25z?=
 =?utf-8?B?Mit3NnlKaGJ5VnphRFZreklyMUV6cEsyenFzRmpCTnVwaUgvZlU1YzFJcnRo?=
 =?utf-8?B?R3diTGRuaVRUQi96VE93aERRSVhqNklBZWxndXpJUU1Xc1lxNWhxSUIxaUlQ?=
 =?utf-8?B?Z2k0MzBIV1FMTFF0MHNmdGxHbUthb05mSWFIenNXR2U3bE1JcGhYNUZwKzN2?=
 =?utf-8?B?ZkNpUUhKcVpWSERwL28veURVSUNlWTB6RFNTakRJWW0zSkJEcFpxOEs5bUZR?=
 =?utf-8?B?TTA5YVAydHI0TWd4NlFnZ0xxbHJCbTVBekRFb2RSWFlhVlBBM29SdmliQllD?=
 =?utf-8?B?WDBDYS9jUi9CQWZHR0c5NVFKKzFnbFZlWTdHLzdYRmtuQndyVDBDY3MwczJD?=
 =?utf-8?B?a2lPWWlwVUgrRzJvcFhQTHRTV3dnWVd5di9Dd0RuYmJyN2s5Z2JJMGlBd2xs?=
 =?utf-8?B?UW1QR1ZMOGh4WFJZQUtMc3o3d1JRb2JCOW04TCtWRThPcHl0TWFEcGVQSUxX?=
 =?utf-8?B?dnEvT1NGU0ExaWljM2RDYmY5WDVxRHZzdG82VDE5R3VCb1lzSWcwK29oUnpn?=
 =?utf-8?B?dUQ2amtMeWlLekdDdDhjcDBmSkVxUlpVVzllaC95OUZBVzJIKzFkR25Cd1RB?=
 =?utf-8?B?MXBCSHhkbjZhdjY5a1E1ejVhekNtWEN3b0tET2RWSjVIakVqR2Nsbi9VREpZ?=
 =?utf-8?B?dHBycElrbE5uUGVJTm03ek1Qak9laGFpU0ZHLzJGK09uNUo1QWV5NU1waU5n?=
 =?utf-8?B?NERVMklUb3B5Y1lSQkRkSnFKMG1JdXdwNmFEVnlKWlNSQ0FtT2dybUZnR3ZO?=
 =?utf-8?B?UlQydFhxbExWSW5pbXJENkcxM1RpaUsrQmJuYTlmVGNXc1NQOGNJU0Y2MCth?=
 =?utf-8?B?MFY2dkZiZzl6TXpKRUNMWi9hTlU3UmxXL0p4eEMzRml2OEJmdXU2WHpZZHhr?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB5E0ED05603554FB3E4901A88F63D69@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ff4aba-ddcc-4eef-3ea1-08daad62b3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 21:34:25.8622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBVR30TtsY5xWrH7iYizbJywXxsOiA1hhupfY7c4Hfhd+A8sntm86kfl42gVsDixrjRV9p2GYLP8tEMNzrHJDNcUxAOdmNYv6FC4VXSaWec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMvMTAvMjAyMiAyMjozMiwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IE9uIFdlZCwg
MjQgQXVnIDIwMjIgMTA6MTg6MjUgKzAyMDAsIENocmlzdG9waGUgSkFJTExFVCB3cm90ZToNCj4+
IFRoZSBkZXZtX2Nsa19nZXRfZW5hYmxlZCgpIGhlbHBlcjoNCj4+ICAgIC0gY2FsbHMgZGV2bV9j
bGtfZ2V0KCkNCj4+ICAgIC0gY2FsbHMgY2xrX3ByZXBhcmVfZW5hYmxlKCkgYW5kIHJlZ2lzdGVy
cyB3aGF0IGlzIG5lZWRlZCBpbiBvcmRlciB0bw0KPj4gICAgICBjYWxsIGNsa19kaXNhYmxlX3Vu
cHJlcGFyZSgpIHdoZW4gbmVlZGVkLCBhcyBhIG1hbmFnZWQgcmVzb3VyY2UuDQo+Pg0KPj4gVGhp
cyBzaW1wbGlmaWVzIHRoZSBjb2RlLCB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aHMgYW5kIGF2b2lk
IHRoZSBuZWVkIG9mDQo+PiBhIGRlZGljYXRlZCBmdW5jdGlvbiB1c2VkIHdpdGggZGV2bV9hZGRf
YWN0aW9uX29yX3Jlc2V0KCkuDQo+Pg0KPj4gWy4uLl0NCj4gDQo+IEFwcGxpZWQsIHRoYW5rcyEN
Cj4gDQo+IFsxLzFdIHJ0YzogbXBmczogVXNlIGRldm1fY2xrX2dldF9lbmFibGVkKCkgaGVscGVy
DQo+ICAgICAgIGNvbW1pdDogMjRmYjMxNjE1NWE1ZjZiYTI3OGE4YjExMGM2MGU2N2I3OTkwMDM1
Ng0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiANCg0KV2hpbGUgdGhpcyBpcyBvbiBteSBtaW5kLCBt
YWtpbmcgdGhlIHJ0YydzIGFoYiBjbG9jayBjcml0aWNhbCBjYW1lDQp1cCBpbiBwcmV2aW91cyBk
aXNjdXNzaW9uIGFib3V0IHRoaXMgcGF0Y2guIEEgZml4IGZvciB0aGF0IHdhcyBhcHBsaWVkDQp0
byB2Ni4wLg0KDQpUaGFua3MsDQpDb25vci4NCg0K
