Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7D56131C7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJaIhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJaIhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:37:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51D9C775;
        Mon, 31 Oct 2022 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667205469; x=1698741469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rFT9uN211LfOhtWk25sstAIeLcefDMiSY1k5QAQnIyQ=;
  b=GFYtrdlaZMeSDRbgnOVax/V0FajyHiJ90cvoACxCJTFpWsLoeSkw3Wgq
   7xG0gx4KTUruyAarwYhsb04jlWPVAMp6uOI7o2D+hrhmkzO0Kzne8eZXO
   AXILxQifYgyuJpITXs80hQiPchq31dPAKo4HwemGGF8C4p719QAl9hvlb
   ZZ9oXfsQh2QUiMbtsLZDkUkVn+rjhgk3npN5cKG0LQbSR3k7wXN71/YNf
   CGULTRA8QYGOk04UDchdw7E0W5YYImhnvNDQ+Sfa2wDrJ+db8uK8FQWTN
   b8xPAR9ObRhaJD8PvZYUO45aNGGJ04aJ4wpvaI+PQLOeK77hFW/1SpBaF
   A==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="187017298"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Oct 2022 01:37:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 31 Oct 2022 01:37:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 31 Oct 2022 01:37:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq7rpyxa1ectFK7JtISlU28yYhqXo0HR8KfzLesHY+2eGO4ZOml0MkwWL3/psINGp4oUx5brDOFwJWYUJl+hGYeJMu0KIc2/M4SaXlvvCq1DLYvWz0h1TY8W29ctXVNk1E607b/qs+Cc9o7UbocjM4ttQq6j6cZeh7CxfukmU4Os7RuNAe2dsIUE4gySTn2HwAqD++kQMleZ6dqwfmDWOPD8WrGH6fICbthlEOMzEqSLHVig3hrwgkYRrzoKvXBC8UTvI8Z+4LpOClo4IjlrC4w/IXBIRSfOC+BKAzFxLFQO7ZVBJgGv8XZafqVfv4oWykcyPzSMm46R75npqfDtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFT9uN211LfOhtWk25sstAIeLcefDMiSY1k5QAQnIyQ=;
 b=D849ix0rXPD3EBY6WgBIQ7KnmJDF4tXWeuHNwCt62IWdNAeajZq4eZ18kh4NgC07+njSMpqv5IzT55REzqXDdneU/ZvUyvHav0bD7NBnvmkk8MWZHvSfUb2FJ84y+OOZy7RTypZLJZvLBEh0Fs8p9XraUvV/s1dmcKHXWFga/zVJGl60uuQglcX8Xe6W219rlhSpTFZ8b37y6aYjut1bsRL8CcEAWvBIedQ8284dqFA6sXt2JQNGyPXz1PmPTgVU9lf7SWFzPBqYW+Gj8+smEWsqe/pYHK8DofqggsBBzu5NtmpYifZWId2f7kLs4+vfXSMQS/D8WN5nGofYPCwqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFT9uN211LfOhtWk25sstAIeLcefDMiSY1k5QAQnIyQ=;
 b=UePkmflPUjIKfUXlSBpUt/MfID89swOSH6raVkI+FyJwG0RoLW6F7oCrjFIXvHs9pvA4IY5eV+VU74GqPCQLDyjvJ/JSmNphpfFYZ5P8mNxhUbZMUNq0mDqZMfx51SPuZOcJJbP4qzCz4tcUxHY2DBWiIQo2BcZCLKLz7DTGuio=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by PH7PR11MB6932.namprd11.prod.outlook.com (2603:10b6:510:207::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 08:37:46 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::51f:528c:5fde:40a2%3]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 08:37:46 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Horatiu.Vultur@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH v2] ARM: dts: lan966x: Enable sgpio on pcb8291
Thread-Topic: [PATCH v2] ARM: dts: lan966x: Enable sgpio on pcb8291
Thread-Index: AQHY7QQNmvsv3EcUA0CeOWaSSWkBBQ==
Date:   Mon, 31 Oct 2022 08:37:46 +0000
Message-ID: <28d8073b-e6fa-e8cc-525c-fef9831b343d@microchip.com>
References: <20221026174303.702919-1-horatiu.vultur@microchip.com>
In-Reply-To: <20221026174303.702919-1-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|PH7PR11MB6932:EE_
x-ms-office365-filtering-correlation-id: 13572a0f-1ed5-4314-d72e-08dabb1b2fb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8By1GFDlAA/DlPXD3EMA1/p+Q9Qzk8sxY6oExXMq0S2Kzf9i8/6gM0Jr4EfOyxeNofcKUj3pk27xd7AbSHK9g2j/uXd37NaybrvPEzRkHCmp6g8IhRe6o6z+lyFtJ4ioxXe2ph79fibLCEEV4LzmNK5OaEyJZ2poiRrSofTp+wYLgY1wDRuzBu8JKplHqbidszZ62h/VdzVx6dScA8JMsadeGDmKrkAN+pLrBclpu1B1WBOSaElBRvAt7CaIwhc8hbUsIiIrD43WLGIq1lyAaL1REFCR1hNjg1h0a0pn6DFglP6fWEtAQ3uUGu1Hg3oVsrrKMy1E4R5xwZmEgRJ/9hb0h1bq04Ia8arPbkNSFycCnHeuGl2G3kfE9Wv6zX/TRESiHTBOxw6vSQdDxwVg1V7MfijDCl0clbPvCumZcGYOrKCFlNLwdraHc6jBKb661shk76rtDAdDIgVVxPBkh33O4D9CMXGofRoHy0n/8RPPpSmEcf3iiuDZSo59Ap5GqKj3UpOQces2w0GYLYIsc/y1HUmJoetGDOzjYNwbDh2zPYy0+l60X38DELMT2zmtgbSyxU0dET+ZbO17NThQ82Wm0QzBmaHNCJGM+UNs4z0qi+vTun+rBA7RVznDWc3DYKLJ3nrgxm+0qxT2XV+uXsj4RseIbVRr/JaS005r3eDNpZLa7By5uoGmB2UYzqR8XjL1abyVMMVfwej+hLYzKYbUP7evGSwuL+M75iduXANGv1aUzNUh/JDc8cKlKQXkXjH5OLr1ofU+iP7sN1Cz3grARZb1COTZ9ahtTus2753mSn8KAMbZOuKQjTytV7ZqudniwiiLwdYIAp6bUeAVfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(2616005)(38070700005)(186003)(4326008)(8676002)(64756008)(91956017)(66446008)(76116006)(66946007)(66556008)(66476007)(110136005)(107886003)(316002)(54906003)(36756003)(26005)(6512007)(8936002)(5660300002)(86362001)(31696002)(6506007)(53546011)(41300700001)(6486002)(31686004)(83380400001)(122000001)(478600001)(2906002)(71200400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE1IUkt3aHJScXBtcGhOclluYlFwMGpJdTNreFM4WVdrV3FxdTZ0c1ViM1FC?=
 =?utf-8?B?RnY1eGlUL250QlhwTlFiNUJZNDNvUnRPUko0dG5uMjc3K3g1NVMreXFzWHFl?=
 =?utf-8?B?MDY3bkM4dlVCNWJMbnQrWXFaSXdVYStiS0k1WVJXaW1zd1MvWDVaV3VKbXN1?=
 =?utf-8?B?VXpuVFJZYkV5cnJ2NlhZbVJDV3VCRE9XSUQwTUxFTXllMGVTRVF5a3U3djBo?=
 =?utf-8?B?U0Z2MEdIK2hMRm1CeGhkb0xiS3VKNE5rV0pod1dXRXRyemJDTllPM29NWFVy?=
 =?utf-8?B?QlJoaThPZGx6VEhrS3ZxaDNSQmFhZEVCOUw2U3h3Qnpkbnp5aVZ3OGJyUjV4?=
 =?utf-8?B?REpWYnZuRmtORHgySjdsTVAvUEJBZytsVUovUlVPQ0ZkQjFUazdXY1JxTUpm?=
 =?utf-8?B?V3lRdStzdkYvak0rYTFhK1FacUJOUkx3SlpnNUJGRVJKUndvVXBIZUh3VnEw?=
 =?utf-8?B?RllwNFdzTUVUYW5kVWRLTFFrTTlYYjIzcUNjZlBiSEtIbFhLdWJDVVh2TU1L?=
 =?utf-8?B?R0JidE5IVHhqQUFUT1FBL00xWXNNeG9rbXkwQjF6OXY0STdZaWg5Mms4bTFQ?=
 =?utf-8?B?MUk4dUFpTUd2eTJaaThrVkNyMC9HK2pPVTVlMldJNFF5NktiTUk0MTVjVHBi?=
 =?utf-8?B?MytpMmhqby9EenZrdHk0dmRReW1wY1dCcEVzL1lnWGFCUStUY2RMWUdXN2Q3?=
 =?utf-8?B?UkZ2bk1vS25jMEhMeEpJajRuV2l3eFZ3VGV2NUlMeStrcEd0dUhWUE9BRWhh?=
 =?utf-8?B?ZXU0eUI2Z0h0SnoyUm5XRkRwOXA1N3VmNnR5NFAvUktiNVJnSk93dWtJZndR?=
 =?utf-8?B?YlZvWUpGdTY0SlF2T0pNT3F3dHJZQXpYMjVyMVRrbWVzdzhsYi9NM05LVVVr?=
 =?utf-8?B?aVZ3a2J4Ym9OdWVqNlQ0cnVCaUNJOWF2WklXaWlQclg4T2tPTUtQV2xITGZ6?=
 =?utf-8?B?N0pjNVBsZVNiSjZGK2FLQXBoa1Y3QkRKbmJqVzl3MGJVbkxnRjNadWFRKzdz?=
 =?utf-8?B?Q3VlZ2haTFZacXRNZ1JBOFp2OUlOTmJ6VFVWY0xzVUpXZm1Fei8rd3Z6eVpn?=
 =?utf-8?B?VUlRWnN0L1pYUWp4dUROQmwzUHNaUmlUYysyZjZWS1J2ZE54YzB6Z0k2Q1Jw?=
 =?utf-8?B?cjZNeVdMaVlyVDVJZzBOaUg0c1ZpK0dEcUhlU3EwVEJoN3pDcWpaSHpnOWRh?=
 =?utf-8?B?eHhWdDBCY3VCWUNKS2R4M3kxYXhBRUM5QlpaNTBiMHlBMXZqaWQxN0d4ZTc3?=
 =?utf-8?B?WUV6UWVWNCsyYTg0NDd5di9yM0ZPTHR5RE5KMXZBcTJBR1lsaUJJSGVaSmR1?=
 =?utf-8?B?NUg1eWhjWVpoWDEzV253eHZqLzhqTWxKVTBPazdQalZ5dlZ1dWUxV2NmVVJP?=
 =?utf-8?B?d21INEJmL1Rpd1lFTUkyMFRaRW5QSXp1cEk4bGp1cUZoUUhLRzdBa2JsVmg0?=
 =?utf-8?B?OTBPWWh6TllTRW1nejFVR205c1VCTjYrUDFaNk15SWdrMDJLUE45S3Y2aU43?=
 =?utf-8?B?YWhMMUwvSG1BUStLeS9POFVkb2hjK2lIZ3lUNU8yZmNGSlBBeG1rV2Vmbk5t?=
 =?utf-8?B?RDZlczd5WWwzS04waS9ydEZneWQvYm9hZFEvL2pCWlJBSndRR3hiS0NUa091?=
 =?utf-8?B?NElGUXNXVExWTFFRb1NOOWpIWnBYZGUzU2dzQU5hbFVaZzFJbFQwSGpmVnU0?=
 =?utf-8?B?OVlzQ1Z3eGZjMjFGRHFib0RVdmpScFdFQ3Zlc1ErUHpWSndoVmlwbHdneXdh?=
 =?utf-8?B?a0MydWkveUluOXJmcDkvcjRUU2c5VU9mZWNYUWRjbU5IeG50Y0V3TkEvTDU4?=
 =?utf-8?B?WFFKNFpJTy84NHNzY2lDRVNFakxGSWVwcmxqYVRUZEdIRGgwb203L0IrS1Uw?=
 =?utf-8?B?dU1hbXkrSVk4UkJoS0xjREtSMnlXQ2d5a1UxWDRXNE9DSWtBM1F2RnlxOWRP?=
 =?utf-8?B?ZU1FaXd5dFpIYUY2S2IvUjN2R1UzYmFZZWNyU1haU0ZnK28zM3lRRmtSZWw4?=
 =?utf-8?B?K0o5TmUzWWw3OFZmZGk5eEdLRVJ3RUhzdlB3ZThPOHYxdjNUNVZEVXM1QVlv?=
 =?utf-8?B?cm82VU81b0paUElDNVFZbk5ydlQ3KzRMa1hBeEU3RzFWY29tRVo3NVk3WnNk?=
 =?utf-8?B?elNORVAzVmlHU1dYVm1vTDN0N2xONWNoWnliUFZ6Vm1lN2pqMFplN3JDcGRl?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <414647A1A2065341B4D98745069F87AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13572a0f-1ed5-4314-d72e-08dabb1b2fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 08:37:46.4613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 576zOpJUccWmxW1X9HtMog4cxKZUbsiRyqUq5gfQ6mGCS9zozu9cLcnhbYdtRQg8Ajy2QOsILE8zzmdSzQ/a1NBIB3EiCGaWG/SugaVguic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6932
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMTAuMjAyMiAyMDo0MywgSG9yYXRpdSBWdWx0dXIgd3JvdGU6DQo+IEVuYWJsZSBzZ3Bp
byBub2RlIG9uIHBjYjgyOTEgYXMgdGhpcyBpcyBuZWVkZWQgdG8gYmUgYWJsZSB0byBjb250cm9s
DQo+IHRoZSBMRURzIG9uIHRoaXMgYm9hcmQuIE90aGVyd2lzZSB0aGUgTEVEcyBzdXBwb3J0IG9u
IHRoZSBib2FyZCB3aWxsDQo+IG5vdCBiZSBhdmFpbGFibGUuDQo+IE9uIHRoZSBvdGhlciBib2Fy
ZCBwY2I4MzA5IHRoZSBzZ3BpbyBpcyBhbHJlYWR5IGVuYWJsZWQgYmVjYXVzZSBpdA0KPiBuZWVk
ZWQgdG8gYWNjZXNzIHRoZSBTRlAgcG9ydHMuDQo+IA0KPiBGaXhlczogMGI3YmFhMWEzMDdmICgi
QVJNOiBkdHM6IGxhbjk2Nng6IGFkZCBsZWQgY29uZmlndXJhdGlvbiIpDQo+IFNpZ25lZC1vZmYt
Ynk6IEhvcmF0aXUgVnVsdHVyIDxob3JhdGl1LnZ1bHR1ckBtaWNyb2NoaXAuY29tPg0KDQpBcHBs
aWVkIHRvIGF0OTEtZml4ZXMsIHRoYW5rcyENCg0KPiANCj4gLS0tDQo+IHYxLT52MjoNCj4gLSBh
ZGQgZml4ZXMgdGFnDQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC1wY2I4Mjkx
LmR0cyB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngt
cGNiODI5MS5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LXBjYjgyOTEuZHRzDQo+IGlu
ZGV4IGY0ZjA1NGNkZjJhODcuLjNhM2Q3NmFmODYxMjIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
L2Jvb3QvZHRzL2xhbjk2NngtcGNiODI5MS5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMv
bGFuOTY2eC1wY2I4MjkxLmR0cw0KPiBAQCAtNjksNiArNjksMTIgQEAgY2FuMF9iX3BpbnM6ICBj
YW4wLWItcGlucyB7DQo+ICAJCXBpbnMgPSAiR1BJT18zNSIsICJHUElPXzM2IjsNCj4gIAkJZnVu
Y3Rpb24gPSAiY2FuMF9iIjsNCj4gIAl9Ow0KPiArDQo+ICsJc2dwaW9fYV9waW5zOiBzZ3Bpby1h
LXBpbnMgew0KPiArCQkvKiBTQ0ssIEQwLCBEMSwgTEQgKi8NCj4gKwkJcGlucyA9ICJHUElPXzMy
IiwgIkdQSU9fMzMiLCAiR1BJT18zNCIsICJHUElPXzM1IjsNCj4gKwkJZnVuY3Rpb24gPSAic2dw
aW9fYSI7DQo+ICsJfTsNCj4gIH07DQo+ICANCj4gICZjYW4wIHsNCj4gQEAgLTExOCw2ICsxMjQs
MjAgQEAgJnNlcmRlcyB7DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgfTsNCj4gIA0KPiArJnNn
cGlvIHsNCj4gKwlwaW5jdHJsLTAgPSA8JnNncGlvX2FfcGlucz47DQo+ICsJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IjsNCj4gKwltaWNyb2NoaXAsc2dwaW8tcG9ydC1yYW5nZXMgPSA8MCAzPiwg
PDggMTE+Ow0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gKw0KPiArCWdwaW9AMCB7DQo+ICsJCW5n
cGlvcyA9IDw2ND47DQo+ICsJfTsNCj4gKwlncGlvQDEgew0KPiArCQluZ3Bpb3MgPSA8NjQ+Ow0K
PiArCX07DQo+ICt9Ow0KPiArDQo+ICAmc3dpdGNoIHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+
ICB9Ow0KDQo=
