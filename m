Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B724663F0A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiLAMiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiLAMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:37:56 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B417205E7;
        Thu,  1 Dec 2022 04:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669898271; x=1701434271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=frgx892P5A6NhrU+kultCQzgnTkx2xIr7k0g4GB9XLw=;
  b=IeQzFE//xwH3AQa25CU5ChdEuGQ1Mybur6COa3pDRWe9kY5vTAU7quxj
   QdrXb3WPrqQo7rmMjsFaOhrNbkWYyD54QlKUXdDX4GPgZEmvQQAfblUwb
   7vQ/zJBdesS98YijKmj2dbPm/Ft1nr6VC2U0DNvnNWfIYbEoWX6AUalNk
   yoheRYtz4Ldo2+bZ9KYLNCah73wTvQT9keWdymb0eY/tcyb1FBGkXJaG9
   HOEFF4ULoNfq0eHlMe6ESJYwDpZiz/HwnuZavPF6df1RkI97r2zYayhsD
   x/IGe555y2PGx1jdI/NcnNIYByFC1YmyXNLqSPyUaFMpyOZJe4xdfdH7Z
   g==;
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="191286149"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Dec 2022 05:37:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Dec 2022 05:37:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Dec 2022 05:37:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNK9uHjWmbX0fbqcZDLyz9MuvnjPvUoVMvj4ucq4w4+QdIhWLvvoPy0/4dVFXI9FjpUbjcF3Gj3GofgI763kPogYHp7hYPGVsi2db4JGg4HW5ypQ7SGdqYP8KEM6UBZ4Jx8oPFLvlKBq+K8Ep9MkAkwPgM8RapQzELJ8kLutzUPd90KnjOhKbIbAiQ1krSKdx4plv9YsJgdEp8k7CqEdHMVEi8brwwHBTKriep1LHOPiaMnIvUJEForZ/WjwVOFaKoVDElrCbgURcHQp/DW/TpdePzCV8rK2S+fwRfTt97Fm6CG2o9EDEHCRN7NZmUtxriLMl8wxlPn+KXH1o/xRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frgx892P5A6NhrU+kultCQzgnTkx2xIr7k0g4GB9XLw=;
 b=MuRNFjAV+6lo+l5osOn+cGnfpxv7nfiPOGRKRyEKuGYo2f6Y9rzj42CFPpmdZeDFxywCZjcV6wLnGslkeaLQqoBAjLRNOnuQH9miRfNVkfxr3BWfAKC4Dy+2P2pD3T6eJJbm1U4BnPtTUVJKGhIDQ6SU/liZH4F0n2X/mF0c0njRZtHw+3J0tb/tFFHKPe5/rhYCvLJZ2vgPmIha5TuOLlWEMLOMUXCpaVsgRyj+4fNTO2QDtRXFbtiNmBnNXT64c/y3xMxb6QLM9tM3mzzRLKa/O+jEEoCwomGDsJYWqjXkm3iqsC/99TzD+Q2ueJbp1zUv1GpBEuhf6DCklzNYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frgx892P5A6NhrU+kultCQzgnTkx2xIr7k0g4GB9XLw=;
 b=HVw9zxZoaNn7JagyI6mHuXguWlbGRINtlNS170qcPp5SD7I1hG5yGF2COnHCOeiDFhBAca2Yl1BncrG7b1Kxy6GNEeevm6Y6DzdDxvr83ra4ebjRKmbcTJYvMBakolNLgPS3qfgrfcKhXMOrYFQr3YNFPR1wUXhHOng2cdRCd6Q=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB6379.namprd11.prod.outlook.com (2603:10b6:510:1f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 12:37:49 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::f79d:bb4a:e2a1:7bb6%6]) with mapi id 15.20.5880.008; Thu, 1 Dec 2022
 12:37:48 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ajones@ventanamicro.com>
CC:     <conor@kernel.org>, <palmer@dabbelt.com>,
        <linux-riscv@lists.infradead.org>, <aou@eecs.berkeley.edu>,
        <corbet@lwn.net>, <guoren@kernel.org>, <heiko@sntech.de>,
        <paul.walmsley@sifive.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] RISC-V: resort all extensions in consistent orders
Thread-Topic: [PATCH v1 2/3] RISC-V: resort all extensions in consistent
 orders
Thread-Index: AQHZBRVtePpMTlRDd0C09eEQJBtfKa5YvJuAgAA6c4CAAAIigA==
Date:   Thu, 1 Dec 2022 12:37:48 +0000
Message-ID: <6c5e52d2-2f1f-1180-a678-5b8ab6b32f39@microchip.com>
References: <20221130234125.2722364-1-conor@kernel.org>
 <20221130234125.2722364-3-conor@kernel.org>
 <20221201090041.525op4sateq5wq4y@kamzik> <Y4ieQf4Q9ywJivDH@wendy>
In-Reply-To: <Y4ieQf4Q9ywJivDH@wendy>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH7PR11MB6379:EE_
x-ms-office365-filtering-correlation-id: 0a05093c-897b-44ad-734a-08dad398daec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A7Qxsg0xuxsqlAYiFObVcU1gG6jwDKi3Ltd4PU7kD8khdUkm8n+HfgAMR4KGKxsZFVl/t62Y/J989aFnSUj/TEcyKItKmp8bIda4ZwGqqN7jiNYyMY1NZauHup7autL1x3oaEIOwVEtc2AtsFExi+S6rYo6Gmp7ZtISH7AeJexY+j/mSQJvMXT7IqCEbG6hFZA9+qovpVLkD60OBhJe9Gc7hr49q0fyDUmotgJY4YsAUJB/EqHqJ0CWQRpXptnR67YzI1SiC89hnsdMT16ktJkKU6V86Az/SRTw7Ggurub/jrz14U/pAk/2FFJN4iBwBTCnQZDpmrTC9cdyqT13DysXWGbQeCKry9vim6SeTeYS8mPezmifmLkDhC3w4OP/09UayA8T0Y6cd+0tEEDVvmESUt4EPl8uJhNv3HV4NIXT170n9W5YKjZ219tHxWc/yjS4MgPv9SucUhkReFxjfymbM4PmKDE8Eo+ybvSSB371WoLoBY+OtFy4gr5LBmtBsWbQfN2l8rr6nR/ecU20QvaPMD3G/Kl5YmvLneGg0DY69JF3a+PyoNmcFpzxkHVlr4W8hiFO7UKWWgsyAico+fgWyZuz/3O62Aa6RwqrB/NOzCUNC4hCfr0vUfLvhODv5rlrpSfag8GL9iwrBzVw39DaWmbpKcHUfwKZjq+O7EWifEwf3v2xETfkrko4YJWuiIa60A/eg8f2/tSpyr3w0wZXmjwkMm3ZuGuB6+RmM7caWzHIYHDbrrzjiC07zfnOJD2GZv9vN1EmsCsKfy8A5cWnsXPcmOdyCwxL5zi8jxME=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(91956017)(66476007)(64756008)(8676002)(66446008)(66556008)(31686004)(41300700001)(54906003)(6916009)(316002)(4326008)(76116006)(7416002)(66946007)(5660300002)(8936002)(36756003)(966005)(26005)(6506007)(122000001)(71200400001)(186003)(53546011)(2906002)(6486002)(6512007)(478600001)(2616005)(38100700002)(31696002)(86362001)(83380400001)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czU0b25UL2svdXYyMWJaMldLTk5Pblh5dWtRaG92emN5bklEcXcyR2xGWURz?=
 =?utf-8?B?a1dxWW9PdzV0ZkVjVHI4ZUxKMXhkWDQzVjV6RFM0VnFnQjI3REJlNVpNbS92?=
 =?utf-8?B?cXVKWWZDVjFwNVJuVlhBRUR1TU8rbjBVY2graHM4OVRaMEdCbm81elM4MmVG?=
 =?utf-8?B?YVhwM01SdWpJMVFTdzlFaXBqQkV4K1hDRGFWV0J6dTlrYkluTHVMZmNlbHVI?=
 =?utf-8?B?a0VvcTE2TmdVV05JWXdFZTcvVnB5Q3ZDUzFGVHFCT01ZZDN5RitmUmtzSmxO?=
 =?utf-8?B?cFFQV0RnSk5wUUdtdG9wU3ZtdVpTQnJ4Znd0ZUQ4Q09nQU03enordkZKZ0pQ?=
 =?utf-8?B?QVd6ejNvRkdjaDB6VzF5YUxFNThzeFExM29GL09kSXJ2NldRVmYvZklBZnVS?=
 =?utf-8?B?cHNoc3NCaTRSWFVydWtIT1hOclZRa0xhc2dpZ1BzSTBiQzVuWVhxb2VuT0lN?=
 =?utf-8?B?Zk5IQlk3MlZDZEE3Q2tFcWsyYlR0RFdkZnoyVzN0Ri9qR0lSaThOcmZDRVdM?=
 =?utf-8?B?VGRBS2d4ZGtKVlgzTmFzaGhmNWxBNWZNbUI4MXFtUHg4S0d6UG9KOXBkcDNi?=
 =?utf-8?B?TVhLQXU3aVk0djVzVDdqVmVYbEpvb2lXYmtZWTM4N2FLTSsrTzhLT2R3YXBN?=
 =?utf-8?B?V3BmV1E0Y1JZNFZyZE1vSEQ1eXhXelp3TXFNVklxblVyS1JIQ1R6SlhaQ29p?=
 =?utf-8?B?MXFmVG5yZE5Jb0FiMXdQandJUEhRT1ArUVVKNjVNd2ZtQmxyRzVLckZRb2I1?=
 =?utf-8?B?N1o2UVY2QS9RakxRNXdmSFErK2dydStLZFlXL1pjaStWT1hST01OdCtzdzVF?=
 =?utf-8?B?bXV1SUhzVGQwa1ZnNC9PZDMwVEdKTzR6eGNzeVZiNTg4a212a0VPUUpzQWc4?=
 =?utf-8?B?VGlYbmF5dGhUTkJ0M0FSUTdpU01UbGRDOCtZWG1BQmJMbzNvOGZzTmlmWGNv?=
 =?utf-8?B?bFBocWlob3NRN0wxQ3hkazlGRDFERmtsQm9QcG5zSm9Wd3Y2bGROTVg4OTFR?=
 =?utf-8?B?cTd0QkQ2NHFJQ1QxN0x5SWlmNmh6b2pOWUh2Z2FLVkNjd2hxcHprWmFnNDRE?=
 =?utf-8?B?RlZ5Zmhsd0RwOHFnd2ZOTU1qelJuaUFYcnVTNlhMcjB2Z25uZzdSbUZxcHc5?=
 =?utf-8?B?VWQralpnRVZSZGN6TkM0bTlzQldIR1Z1NnZub25RdHEvck9ORTlYZ1AyT2Zy?=
 =?utf-8?B?UUJyZXR5RnBCNkswWVg5bmJHUW9MK1hyK1hVcGZVVFVFcTVNaTJzUDQ4VGE0?=
 =?utf-8?B?bENnb0RNQnE5cVdLZUhZQ3dpUWlLcGd2N1ErT3doSi9Kd2gyc1RrM093TnVi?=
 =?utf-8?B?dEZxQ1FMR2JTZzk1aVEvdStoejRyVUdJdVJBT1JSQ2swZC8zU2g2azJ3aWdE?=
 =?utf-8?B?cFJoNFBCYXVqbjBCYThiN3ltYlRGUGNhUGZSbzE4NDZ6cWsxQVRlL2ovOWNx?=
 =?utf-8?B?UnNzWUE3MTYxeWZ0ZjBBNkZXTXdMYVcvc25NSUUxMWNqbENiMjRGTjQxakVF?=
 =?utf-8?B?TE1lWVpab0JOV3o2R3I4VTJYdHF6b0xUOXpQamczNXZJNlkzK1dnajZ2UVdn?=
 =?utf-8?B?eE1CRXhHSHBya1JZd3o0RTUxRk5HMStCMFplSmtXdFdRWXUvcHJzZHlCbVBN?=
 =?utf-8?B?RUZtdWQ3QnRGWmFZWkI4SmFlcGRzb2psc2xTaFRzYTd1VVFUTG4zZjYyWUd3?=
 =?utf-8?B?L0p3WkJLSTd5eEtHMlRzTFhHck1lZUllNmRmaitmRkRFYlZ4Wk4xQ2tyR1Vw?=
 =?utf-8?B?QWNCZkRDczNBeHNZNjFUSFVoalFFOXM2bWttekFxVVdPVHVJb2lGdzd5c3NZ?=
 =?utf-8?B?UEl6Qi9QV1RoeURCOGlWc0I0eXEyQlVwekltZjlzQUQ2QjBUd3RlUSt3Rnpn?=
 =?utf-8?B?NEhwZlZwZC93QVF2V0VLTWEvd1ZCTzhUN2tSZ280TjQvVHRMUnRjRnNWUExz?=
 =?utf-8?B?SGQ5cDVwaU1xb0R5VlRZZE9tN3p4SEpSUnZUM1BEem05R3dlRHRCUXRGbjNl?=
 =?utf-8?B?R3g1VkxjRDNiWEcrVm5mandPNXNFWDJtd3RySEhDMU13UDJ3M2JMUjBIZWxx?=
 =?utf-8?B?SXIzbUoweU53RWNOR3NyV0JoMjI2TlR1WGN4TTE3anhvSzZYeTFMOFF6OW5j?=
 =?utf-8?Q?72yfWRVlIg45hGRqHkDMR3cB2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B687F347FB7F624E92F650254E1ADB37@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a05093c-897b-44ad-734a-08dad398daec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 12:37:48.7609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnblTdXVJy5avTG8MEWXx8mLcoelp8s5rjUeYjnU3yHMqW8IsQn8YTb4PpZaR73/PgJyfJjKIHT1Xtjd0HvWXHpMmp/oOTcQr7yjiTW9q9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6379
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMTIvMjAyMiAxMjoyOSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFRodSwgRGVjIDAxLCAyMDIyIGF0IDEwOjAw
OjQxQU0gKzAxMDAsIEFuZHJldyBKb25lcyB3cm90ZToNCj4+IE9uIFdlZCwgTm92IDMwLCAyMDIy
IGF0IDExOjQxOjI1UE0gKzAwMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+PiBGcm9tOiBDb25v
ciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPj4+DQo+Pj4gT3JkZXJpbmcg
YmV0d2VlbiBlYWNoIGFuZCBldmVyeSBsaXN0IG9mIGV4dGVuc2lvbnMgaXMgd2lsZGx5DQo+Pj4g
aW5jb25zaXN0ZW50LiBQZXIgZGlzY3Vzc2lvbiBvbiB0aGUgbGlzdHMgcGljayB0aGUgZm9sbG93
aW5nIHBvbGljeToNCj4+Pg0KPj4+IC0gVGhlIGFycmF5IGRlZmluaW5nIG9yZGVyIGluIC9wcm9j
L2NwdWluZm8gZm9sbG93cyBhIG5hcnJvdw0KPj4+ICAgIGludGVycHJldGF0aW9uIG9mIHRoZSBJ
U0Egc3BlY2lmaWNhdGlvbnMsIGRlc2NyaWJlZCBpbiBhIGNvbW1lbnQNCj4+PiAgICBpbW1lZGlh
dGVseSBwcmVzaWRpbmcgaXQuDQo+Pj4NCj4+PiAtIEFsbCBvdGhlciBsaXN0cyBvZiBleHRlbnNp
b25zIGFyZSBzb3J0ZWQgYWxwaGFiZXRpY2FsbHkuDQo+Pj4NCj4+PiBUaGlzIHdpbGwgaG9wZWZ1
bGx5IGFsbG93IGZvciBlYXNpZXIgcmV2aWV3ICYgZnV0dXJlIGFkZGl0aW9ucywgYW5kDQo+Pj4g
cmVkdWNlIGNvbmZsaWN0cyBiZXR3ZWVuIHBhdGNoc2V0cyBhcyB0aGUgbnVtYmVyIG9mIGV4dGVu
c2lvbnMgZ3Jvd3MuDQo+Pj4NCj4+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyMjExMjkxNDQ3NDIuMjkzNTU4MS0yLWNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tLw0KPj4+
IFN1Z2dlc3RlZC1ieTogQW5kcmV3IEpvbmVzIDxham9uZXNAdmVudGFuYW1pY3JvLmNvbT4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29t
Pg0KPj4+IC0tLQ0KPiANCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvY3B1LmMg
Yi9hcmNoL3Jpc2N2L2tlcm5lbC9jcHUuYw0KPj4+IGluZGV4IDY4YjJiZDBjYzNiYy4uNjg2ZDQx
YjE0MjA2IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2NwdS5jDQo+Pj4gKysr
IGIvYXJjaC9yaXNjdi9rZXJuZWwvY3B1LmMNCj4+PiBAQCAtMTYxLDEyICsxNjEsMTIgQEAgZGV2
aWNlX2luaXRjYWxsKHJpc2N2X2NwdWluZm9faW5pdCk7DQo+Pj4gICAgKiBOZXcgZW50cmllcyB0
byB0aGlzIHN0cnVjdCBzaG91bGQgZm9sbG93IHRoZSBvcmRlcmluZyBydWxlcyBkZXNjcmliZWQg
YWJvdmUuDQo+Pj4gICAgKi8NCj4+PiAgIHN0YXRpYyBzdHJ1Y3QgcmlzY3ZfaXNhX2V4dF9kYXRh
IGlzYV9leHRfYXJyW10gPSB7DQo+Pj4gKyAgIF9fUklTQ1ZfSVNBX0VYVF9EQVRBKHppY2JvbSwg
UklTQ1ZfSVNBX0VYVF9aSUNCT00pLA0KPj4+ICsgICBfX1JJU0NWX0lTQV9FWFRfREFUQSh6aWhp
bnRwYXVzZSwgUklTQ1ZfSVNBX0VYVF9aSUhJTlRQQVVTRSksDQo+Pj4gICAgICBfX1JJU0NWX0lT
QV9FWFRfREFUQShzc2NvZnBtZiwgUklTQ1ZfSVNBX0VYVF9TU0NPRlBNRiksDQo+Pj4gICAgICBf
X1JJU0NWX0lTQV9FWFRfREFUQShzc3RjLCBSSVNDVl9JU0FfRVhUX1NTVEMpLA0KPj4+ICAgICAg
X19SSVNDVl9JU0FfRVhUX0RBVEEoc3ZpbnZhbCwgUklTQ1ZfSVNBX0VYVF9TVklOVkFMKSwNCj4+
PiAgICAgIF9fUklTQ1ZfSVNBX0VYVF9EQVRBKHN2cGJtdCwgUklTQ1ZfSVNBX0VYVF9TVlBCTVQp
LA0KPj4+IC0gICBfX1JJU0NWX0lTQV9FWFRfREFUQSh6aWNib20sIFJJU0NWX0lTQV9FWFRfWklD
Qk9NKSwNCj4+PiAtICAgX19SSVNDVl9JU0FfRVhUX0RBVEEoemloaW50cGF1c2UsIFJJU0NWX0lT
QV9FWFRfWklISU5UUEFVU0UpLA0KPj4+ICAgICAgX19SSVNDVl9JU0FfRVhUX0RBVEEoIiIsIFJJ
U0NWX0lTQV9FWFRfTUFYKSwNCj4+PiAgIH07DQo+Pg0KPj4gVGVjaG5pY2FsbHkgd2Ugc2hvdWxk
IGhhdmUgbGVhdmUgdGhlc2UgaW4gdGhlIHdyb25nIG9yZGVyIGlmIHdlIHdhbnQgdG8gYmUNCj4+
IHN0cmljdCBhYm91dCB0aGUgSVNBIHN0cmluZyBwdWJsaXNoZWQgdG8gdXNlcnNwYWNlLCBidXQg
SSdtIGluIGZhdm9yIG9mDQo+PiBjaGFuZ2luZyB0aGlzIGFycmF5IGFzIG5lY2Vzc2FyeSBhbmQg
aG9waW5nIHdlIHRlYWNoIHVzZXJzcGFjZSB0byB1c2UNCj4+IGZsZXhpYmxlIHBhcnNlcnMuIEFj
dHVhbGx5LCBJTU8sIHdlIHNob3VsZG4ndCB0ZWFjaCB1c2Vyc3BhY2UgdG8gcGFyc2UNCj4+IHRo
aXMgYXQgYWxsLiBXZSBzaG91bGQgaW5zdGVhZCBjcmVhdGUgc3lzZnMgbm9kZXM6DQo+Pg0KPj4g
ICAuLi4vaXNhL3ppY2JvbQ0KPj4gICAuLi4vaXNhL3ppaGludHBhdXNlDQo+PiAgIC4uLi9pc2Ev
c3Njb2ZwbWYNCj4+DQo+PiBhbmQgdGVhY2ggdXNlcnNwYWNlIHRvIGxpc3QgLi4uL2lzYS8gdG8g
bGVhcm4gYWJvdXQgZXh0ZW5zaW9ucy4gVGhhdCB3b3VsZA0KPj4gYWxzbyBhbGxvdyB1cyB0byBw
dWJsaXNoIGV4dGVuc2lvbiB2ZXJzaW9uIG51bWJlcnMgd2hpY2ggd2UgYXJlIG5vdA0KPj4gY3Vy
cmVudCBkb2luZyB3aXRoIHRoZSBwcm9jIGlzYSBzdHJpbmcuDQo+Pg0KPj4gICAuLi4vaXNhL3pp
Y2JvbS9tYWpvcg0KPj4gICAuLi4vaXNhL3ppY2JvbS9taW5vcg0KPj4NCj4+IGFuZCB3ZSBjb3Vs
ZCBhZGQgb3RoZXIgcHJvcGVydGllcyBpZiBuZWNlc3NhcnkgdG9vLCBlLmcuDQo+Pg0KPj4gICAu
Li4vaXNhL3ppY2JvbS9ibG9ja19zaXplDQo+IA0KPiBZYWgsIHRoaXMgYWxsIGtpbmRhIHRpZXMg
aW4gd2l0aCBQYWxtZXIncyBSRkMgc2V0IHRoYXQgZG9lcyB0aGUgaHdjYXANCj4gc3R1ZmYuIEtp
bmRhIGJlZW4gaG9sZGluZyBvZmYgb24gYW55IHRob3VnaHRzIG9uIHRoZSBpc2Egc3RyaW5nIGFz
IGENCj4gdmFsdWFibGUgYW55dGhpbmcgdW50aWwgdGhhdCBzZWVzIGEgcHJvcGVyIHJlc3Bpbi4N
Cj4gDQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYyBiL2Fy
Y2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPj4+IGluZGV4IDY5NDI2N2QxZmU4MS4uOGE3
NmE2Y2U3MGNmIDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUu
Yw0KPj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPj4+IEBAIC0xOTks
MTIgKzE5OSwxMyBAQCB2b2lkIF9faW5pdCByaXNjdl9maWxsX2h3Y2FwKHZvaWQpDQo+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB0aGlzX2h3Y2FwIHw9IGlzYTJod2NhcFsodW5zaWdu
ZWQgY2hhcikoKmV4dCldOw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2V0X2Jp
dCgqZXh0IC0gJ2EnLCB0aGlzX2lzYSk7DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgfSBlbHNl
IHsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogc29ydGVkIGFscGhhYmV0aWNh
bGx5ICovDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTRVRfSVNBX0VYVF9NQVAo
InNzY29mcG1mIiwgUklTQ1ZfSVNBX0VYVF9TU0NPRlBNRik7DQo+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFNFVF9JU0FfRVhUX01BUCgic3N0YyIsIFJJU0NWX0lTQV9FWFRfU1NUQyk7
DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIFNFVF9JU0FfRVhUX01BUCgic3ZpbnZh
bCIsIFJJU0NWX0lTQV9FWFRfU1ZJTlZBTCk7DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBTRVRfSVNBX0VYVF9NQVAoInN2cGJtdCIsIFJJU0NWX0lTQV9FWFRfU1ZQQk1UKTsNCj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNFVF9JU0FfRVhUX01BUCgiemljYm9tIiwg
UklTQ1ZfSVNBX0VYVF9aSUNCT00pOw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
U0VUX0lTQV9FWFRfTUFQKCJ6aWhpbnRwYXVzZSIsIFJJU0NWX0lTQV9FWFRfWklISU5UUEFVU0Up
Ow0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBTRVRfSVNBX0VYVF9NQVAoInNzdGMi
LCBSSVNDVl9JU0FfRVhUX1NTVEMpOw0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBT
RVRfSVNBX0VYVF9NQVAoInN2aW52YWwiLCBSSVNDVl9JU0FfRVhUX1NWSU5WQUwpOw0KPj4+ICAg
ICAgICAgICAgICAgICAgICAgIH0NCj4+PiAgICN1bmRlZiBTRVRfSVNBX0VYVF9NQVANCj4+PiAg
ICAgICAgICAgICAgfQ0KPj4+IEBAIC0yODQsNiArMjg1LDcgQEAgc3RhdGljIGJvb2wgX19pbml0
X29yX21vZHVsZSBjcHVmZWF0dXJlX3Byb2JlX3ppY2JvbSh1bnNpZ25lZCBpbnQgc3RhZ2UpDQo+
Pj4gICAgKiBUaGlzIGNvZGUgbWF5IGFsc28gYmUgZXhlY3V0ZWQgYmVmb3JlIGtlcm5lbCByZWxv
Y2F0aW9uLCBzbyB3ZSBjYW5ub3QgdXNlDQo+Pj4gICAgKiBhZGRyZXNzZXMgZ2VuZXJhdGVkIGJ5
IHRoZSBhZGRyZXNzLW9mIG9wZXJhdG9yIGFzIHRoZXkgd29uJ3QgYmUgdmFsaWQgaW4NCj4+PiAg
ICAqIHRoaXMgY29udGV4dC4NCj4+PiArICogVGVzdHMsIHVubGVzcyBvdGhlcndpc2UgcmVxdWly
ZWQsIGFyZSB0byBiZSBhZGRlZCBpbiBhbHBoYWJldGljYWwgb3JkZXIuDQo+Pj4gICAgKi8NCj4+
PiAgIHN0YXRpYyB1MzIgX19pbml0X29yX21vZHVsZSBjcHVmZWF0dXJlX3Byb2JlKHVuc2lnbmVk
IGludCBzdGFnZSkNCj4+PiAgIHsNCj4+PiAtLQ0KPj4+IDIuMzguMQ0KPj4+DQo+Pg0KPj4gSSBy
ZWFsaXplIHRoYXQgSSBoYXZlIGEgc3VnZ2VzdGVkLWJ5IHRhZyBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UsIGJ1dCBJDQo+IA0KPiBJIGRpZCBvbmUgdGhpbmcgYXMgYSAicHV0dGluZyBpdCBvdXQgdGhl
cmUiIGluIHRoZSByZXNwb25zZXMgdG8gYW5vdGhlcg0KPiBzZXJpZXMgYW5kIHlvdSBzdWdnZXN0
ZWQgc29tZXRoaW5nIGRpZmZlcmVudCBlbnRpcmVseS4gT3JkaW5hcmlseSwgSSdkDQo+IG5vdCBw
dXQgcmV2aWV3IGNvbW1lbnRzIGluIGEgc3VnZ2VzdGVkLWJ5LCBidXQgZmlndXJlZCBpdCB3YXMg
b2theSB0aGlzDQo+IHRpbWUuDQo+IA0KPj4gZG9uJ3QgcmVhbGx5IGhhdmUgYSBzdHJvbmcgb3Bp
bmlvbiBvbiBob3cgd2Ugb3JkZXIgZXh0ZW5zaW9ucyB3aGVyZSB0aGUNCj4+IG9yZGVyIGRvZXNu
J3QgbWF0dGVyLiBBIGNvbnNpc3RlbnQgcG9saWN5IG9mIGFscGhhYmV0aWNhbCBvciBhbHdheXMg
YXQNCj4+IHRoZSBib3R0b20gYm90aCB3b3JrIGZvciBtZS4gSSBwZXJzb25hbGx5IHByZWZlciBh
bHBoYWJldGljYWwgd2hlbg0KPj4gcmVhZGluZyB0aGUgbGlzdHMsIGJ1dCBJIHJlYWxpemUgd2Un
bGwgZXZlbnR1YWxseSBtZXJnZSBzdHVmZiBvdXQgb2YNCj4+IG9yZGVyIGFuZCB0aGVuIHRoYXQn
bGwgZ2VuZXJhdGUgc29tZSBjaHVybiB0byByZW9yZGVyIChidXQgaG9wZWZ1bGx5IG5vdA0KPj4g
dG9vIGZyZXF1ZW50bHkpLg0KPiANCj4gVGhpbmsgSSBzYWlkIGl0IGF0IHRoZSB5b2tlIHllc3Rl
cmRheSwgYnV0IEkgZG9uJ3QgdGhpbmsgdGhhdCB0aGlzIGlzDQo+IG11Y2ggb2YgYSBwcm9ibGVt
LiBJZiBpdCBnZXRzIG91dCBvZiBvcmRlciwgd2UganVzdCBnZXQgc29tZW9uZSB0aGF0J3MNCj4g
c2VuZGluZyBhIHBhdGNoc2V0IGFscmVhZHkgdG8gZml4IHRoaW5ncyB1cC4NCj4gDQo+PiBNeSBi
aWdnZXN0IGNvbmNlcm4gaXMgaG93IG11Y2ggd2UgbmVlZCB0byBjYXJlIGFib3V0IHRoZSBvcmRl
ciBvZiB0aGUNCj4+IHN0cmluZyBpbiBwcm9jIGFuZCB3aGV0aGVyIG9yIG5vdCB3ZSdyZSBhbGxv
d2VkIHRvIGZpeCBpdHMgb3JkZXIgbGlrZQ0KPj4gd2UncmUgZG9pbmcgd2l0aCB0aGlzIHBhdGNo
LiBJIGhvcGUgd2UgY2FuLCBhbmQgSSB2b3RlIHdlIGRvLg0KPiANCj4gQmVpbmcgYSBiaXQgaGFy
ZC1ub3NlZCBhYm91dCBpdDoNCj4gLSB0aGUgc3BlYyBoYXMgc2FpZCBmb3IgeWVhcnMgdGhhdCB0
aGlzIG9yZGVyIGlzIG5vdCBjb3JyZWN0DQo+IA0KPiAtIHRoZWlyIHBhcnNlciBjYW5ub3QgYXNz
dW1lIGFueSBnaXZlbiBleHRlbnNpb24gaXMgZXZlbiBwcmVzZW50LCBzbyB0aGUNCj4gICAgaW5k
ZXggYXQgd2hpY2ggdGhlIGV4dGVuc2lvbiBzdGFydHMgd2FzIG9ubHkgZXZlciBnb2luZyB0byB2
YXJ5IHdpbGRseQ0KPiANCj4gLSB0byBicmVhayBhIHBhcnNlciwgaXQgbXVzdCBleHBlY3QgdG8g
c2VlIGV4dGVuc2lvbiBBYmNkIGJlZm9yZSBFZmdoICYNCj4gICAgdGhhdCBvcmRlciBoYXMgdG8g
Y2hhbmdlIGZvciB0aGVtDQo+IA0KPiAtIGV4cGVjdGluZyB0aGF0IGEgZ2l2ZW4gcGFpciBvZiBl
eHRlbnNpb25zIHRoYXQgYXBwZWFyZWQgb25lIGFmdGVyDQo+ICAgIGFub3RoZXIgd291bGQgYWx3
YXlzIGRvIHNvIGlzIG5vdCBzb21ldGhpbmcgd2Ugc2hvdWxkIHdvcnJ5IGFib3V0DQo+ICAgIGJy
ZWFraW5nIGFzIGl0IHdhcyBhbHdheXMgbm90ZWQgaW4gdGhlIGNvbW1lbnQgKGFuZCBieSB0aGUg
c3BlY3M/KQ0KPiAgICB0aGF0IG5ldyBleHRlbnNpb25zIHdvdWxkIGJlIGFkZGVkIGluIGFscGhh
YmV0aWNhbCBvcmRlciAoSSdkIGxpa2UgdG8NCj4gICAgdGhpbmsgdGhhdCBpZiBhIGNsYWlydm95
YW50IHdyb3RlIGEgcGFyc2VyIGFuZCBrbmV3IHRoYXQgdGhlcmUnZCBiZQ0KPiAgICBub3RoaW5n
IGluIHRoZSBnYXAgYmV0d2VlbiB0aGUgZXh0ZW5zaW9ucyB3ZSBoYXZlIG5vdyAmIHdoYXQgbWF5
IGJlDQo+ICAgIHByb2R1Y2VkIHRoZXknZCBhbHNvIGFjY291bnQgZm9yIHRoaXMgcmUtb3JkZXJp
bmcuLi4pDQo+IA0KPiAtIHRoZSByZS1vcmRlciBvZiBzc3RjIGlzIGdvaW5nIHRvIGxhbmQgZm9y
IHY2LjEgJiB0aGUgYWRkaXRpb24gb2Ygc3N0Yw0KPiAgICBvdXQgb2Ygb3JkZXIgbGFuZGVkIGlu
IHY2LjAsIHNvIGVpdGhlciB0aGF0IGlzIGFuIGlzc3VlIHRvbyBvciB0aGlzIGlzDQo+ICAgIGZp
bmUNCj4gDQo+IEkgZ3Vlc3MgSSBzZW50IHRoZSBwYXRjaGVzLCBzbyBteSBvcGluaW9uIGlzIGZh
aXJseSBvYnZpb3VzLCBidXQgSSB0aGluaw0KPiB3ZSBjaGFuZ2UgaXQgJiBzZWUgaWYgc29tZW9u
ZSBjb21wbGFpbnMgYWJvdXQgYW4gaXNzdWUgdGhhdCBzb21ldGhpbmcNCj4gb3RoZXIgdGhhbiBh
IHJlLWppZyB3b3VsZCBicmVhay4NCg0KdHlwbzogcy93b3VsZC93b3VsZG4ndC8sIHRoYXQgY2hh
bmdlcyB0aGUgbWVhbmluZyBvZiBteSBjb21tZW50Lg0KSWYgYSB2YWxpZCBhZGRpdGlvbiB3b3Vs
ZCBicmVhayB0aGVpciBwYXJzZXIsIHRoYXQncyBub3QgcmVhbGx5IGENCiJ1QVBJIGJyZWFrYWdl
Ii4gSXQncyBvbmx5IHNvbWV0aGluZyB0aGF0IHRoaXMgcmUtb3JkZXIgd291bGQgYnJlYWsNCmJ1
dCBhZGRpdGlvbnMgb3IgdmFsaWQgY2hhbmdlIG9mIHRoZSBzdHJpbmcgYmFzZWQgb24gY3B1IGNh
cGFiaWxpdHkNCndvdWxkIG5vdCB0aGF0IHdlIG5lZWQgdG8gd29ycnkgYWJvdXQgSU1PLg0KDQoN
Cg==
