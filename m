Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1092638BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiKYODG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiKYODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:03:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CC317400;
        Fri, 25 Nov 2022 06:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669384984; x=1700920984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gieQnnApzkWQT549ymAQRNEsRgwQub6UNW8E6fjiKd0=;
  b=t6dVlrd+89ACCgIaY/sS5NKSw9mUZv21anszrm0MDGMmSrV7vvpRMhod
   C9g5Uwc4mR0yROkDcTV1GJNeBcsnvjyrmqx4udqeG1nPEG5t/afEahM4W
   lb1N3Qyp9hQBQYlF3l2eJPYeRJk7oh5Ggq/M1CD1NYFvPrpe81omblTir
   lUS56jrzozZZiizDUFdHiOXEx//nwcewfwQS1q4Zwlk/dLlmvnFVktEq6
   VK2Ss2dld30Pyyr91S6p5aGj/lrd08U9NOQJN35ohfa/XJ3T+m9/WSPRH
   OWw79vgLaK88QP9oLVKpUYwh98gYY/mFxl/afoZ1sOmkdL/FB3sdObvKg
   w==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="190546699"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 07:03:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 07:03:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 25 Nov 2022 07:03:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beElXfImUHg0EvH6Fcd17bkaeDm5z8iTmdNWu0AvIIULn0gth2iBEWxO76qGCSwbDQ0bZ4B9Ap0zHSYTAPPF2gYx6Gffy191mWZ/n5wb1kH/Xo/UsfpWUVcKmj+f/CvcTcMVusAuFijqzplM03A0ZSDf2OH3PqWNCcDBSQ6y6zw+K4hb6Yyj7W+EAK9YvfRLgKKFwmIF2pEIw0avOfqa32BA/my5YPKzqxploIIAhTxM05kqiuNNvHLC3vUb3I4mBNaMPuJRp47BsmAW36iH/TmuLh90olb2x6v9nEJxjrxiOSylXuDgeH11I86RqO0lYhOpicuZHGR2uMOY3wvjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gieQnnApzkWQT549ymAQRNEsRgwQub6UNW8E6fjiKd0=;
 b=jFuUXogp6w90wIOxLE1+8LaBsFs/TQWr03zrKoglRH/OyZihQeNPYGNPbt4bYqVA+0ftsgTewBUDZWYpx4n7Ysa8cw8+bf4SyS6L1K4ng+kRyLRXJYKqQZSfuPXQfocGvVOjVakxO7QlHCynwI6+J0V7GvKbXJ1+ithrjW+b8PqmwThw8wGg/ecci0WsdyJPR4UwDqZHXEebDlSKAP//fPPxjpdsTMuU3zrKayjGbjoVw6/YBTZVrBydeQGEco9ouN8r7od5ZMggkQjAn44Q22FFyTYgDEmdoXHeROykkCZ9+0s6LrHV98mdV/Pz+nIWMrceFCLk18nvE2gdWLESRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gieQnnApzkWQT549ymAQRNEsRgwQub6UNW8E6fjiKd0=;
 b=aIwGXbh8mUKcoTryueXTOUrNgeNnQX6geF60c7w79JaTzqXolj1qj45+lyQFHAf2gGXW3OvKFzxnwWPXN1dBIbHlzs9TZWW3Yho2EdrsPCZLsGt8oQZpDpugkcf88qzPGDoygsPd4ezsB0FfBxSuX92SBqox6p/3rZz+TnmJri4=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Fri, 25 Nov
 2022 14:03:01 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::98f6:c9d1:bb68:1c15%10]) with mapi id 15.20.5857.017; Fri, 25 Nov
 2022 14:03:01 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Eugen.Hristev@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ARM: configs: sama5/7: switch to new MICROCHIP_ISC
 driver
Thread-Topic: [PATCH v2 1/2] ARM: configs: sama5/7: switch to new
 MICROCHIP_ISC driver
Thread-Index: AQHZANahQ7Coeq75vEeNpyr/UEf0WQ==
Date:   Fri, 25 Nov 2022 14:03:01 +0000
Message-ID: <da0c818e-5774-8280-8bba-4e7e8e683b05@microchip.com>
References: <20221125130646.454084-1-eugen.hristev@microchip.com>
 <aa27b328-5167-408c-7731-080aa3a4ebb5@microchip.com>
 <5c93892b-4d04-3b55-72ec-36d3519d543b@microchip.com>
In-Reply-To: <5c93892b-4d04-3b55-72ec-36d3519d543b@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR11MB1953:EE_|CY5PR11MB6139:EE_
x-ms-office365-filtering-correlation-id: f8e905d6-6bda-481c-9bbf-08daceedc3cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+4VatYnW8f+duDp59mfYcCghv10Lbb1/i9HEWYpMTE+1BS0J3nnbeZ7bNQIXYKxV8LfUrdbMsfpr9flch5ivUmvxaT9lZceYObAJp5IUktL7hRtKAwWmMeyCJG+SGd58LnT3Uv4fK6ue/NIzn0bSHr859MP/Q2vvmiimumuS1TxPgHOnnIJ5mwoTMbmunW3J2LxegkyijCrA63W78PLJWbWp98htUVp90080z0b+Rd7aGZMLq8mLPzr4NJFY5BBx63qYNY3KDiydit44+Q0lU6x7VHuYoy1xa3ZIWvBrvJtoaJdhM3tMSI647Wz493VrXc2IcmGM963DKs7DNBUyzjAZmmZFSagKJ7E9vujiJGr6kPmEUmZO23VTOwby7LiqjyQa6erGZw4y/MIe1lDVvcB9w8Fj2lWjbEGBCoPvgwum8CKepRxBYH3mVZ36eYxDbQ6oX7m68xcyWV6l5PuPSmmlLu8VwCIZQ0Sz8qKo2WngcZK8W9qcdxzDnrx7RIQIib6RbGiUAOT8S8dw+WceSBX0fTS67VCF5qKAUnMEzDvFGJXFx/5eAL9jfY84pIthhqzZdX6kYziVxfS5n7me452E6Yov0XLYgDYu0vOnlni2BNaEl+RDTJSSpxw4sks++iS5TyIkkMcJAowBrywxpVJq9BksSEa8xU+pE6xDSDfR4ucdby2Yy6MyMFxN8z1LFECnXO5FZF8qhqTwSaj4/BQ+ee7vOCqmXREOtPERwA6guadCBJBv/M57ogOEcMhtRoGYudmrKbBvr6lOKurIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(66446008)(76116006)(91956017)(66476007)(66556008)(66946007)(36756003)(8936002)(64756008)(6862004)(41300700001)(4326008)(8676002)(5660300002)(86362001)(31696002)(6512007)(71200400001)(53546011)(26005)(6506007)(83380400001)(2616005)(186003)(54906003)(37006003)(38070700005)(6636002)(316002)(6486002)(38100700002)(478600001)(122000001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWhmeVBiZ1pJazNMcHNlK1pteGtRdUFyKzB0bUdRQ0JEV1VHaUdVbHFjeEhP?=
 =?utf-8?B?RGpUZ05nODhZT0NZWlZVcGN3U044KzFhU01wYS9yMExRaUpLVDJnM2RMZlZR?=
 =?utf-8?B?aU9lbTVla0o3Y25sQzg5aGorcFdmY2V1UFM2NkVLY2JYRTVjYmRmQVkrL2Zo?=
 =?utf-8?B?dnR6VURtL3FVelUxK1RUbWVtR25TU1BFTjNFMUxUcjU1aWJKb3hqdVIxZisz?=
 =?utf-8?B?ZC9SVXZDQm9NVkRvbEVCSkI3VGIreEtFd0w3OG5YRzkwRGtuaWUwS3FGZjE4?=
 =?utf-8?B?ZmdjTGJlUDJuMGJScHpjd1dYNzBtQmpFR0tUNVJrazg2NDkzQmhsa3l3S3Nm?=
 =?utf-8?B?VHlSOTZmUEdwaXkzTEJVY0tjRG9pNTZMQkJ6ODZOK3N1dndBM2VxQUVpdEg4?=
 =?utf-8?B?aWUxRGIyb1NMMGVLMnFSK3NWTVE3czRxSzJvV3gvL2VoU1FlUnhUUkNlY0xw?=
 =?utf-8?B?b2FNdENDdmZ3cURNVjQxMkxOMU1DN0I5b1Z6YXczUVBBTkZWQW5EZm9MK0dt?=
 =?utf-8?B?S0puVVUxMkRsdHowVEgxUEdacWNSZUZKZ2ZzSlN3aVNSSFJ5RmtzZi82V3hw?=
 =?utf-8?B?QmlVS1o2M1pLTEZZRDFxL0ptY3FjczI5L2xScXhCK3Y4ZG90Uy9WdEptclNM?=
 =?utf-8?B?MzhKSnMxVEdQMDJMV2JFQnQ1VklRQzIzdklBNEdlUWFRZS9wT2JJcGhiRDJU?=
 =?utf-8?B?T3BGWndEK0ZjVURpQW9GZEVkckowbXgzYzd0Z0pVQ2Zpd0oyT3Z6ZWJWQk5t?=
 =?utf-8?B?ck5XR0JqKzhQQ3JxeWtEWEcyRmhrY1cydlI3b0JkSy9DK1FrQmNZMzlEUEhh?=
 =?utf-8?B?MkFGMVUySjAzaUlnUjFRcy9zbnArOHpXSEIwRXhpTXZDUXlCUk4xdTFrcEpH?=
 =?utf-8?B?cmJFc1BZOUlqT1hhM05TSTlaRUFwWWZ5RGtNaW4xaUkwbHFtMkw0V0gvRjVi?=
 =?utf-8?B?Szl2THFzdVF1NzJzZE5ONEJXYjlZa1BnaEZmVTlvTFNMYWdzUzI1MXR6S01H?=
 =?utf-8?B?K3p3UGRHaHY2dGJjU1ZxbjAxSjdjYzdIM05EQUhsdFVwRkMyQTlSdkJwNlEr?=
 =?utf-8?B?YXk3ejMwcnAzemoxQytCamVjY05vbmR3MmVORWdHVkNKSG5aQnVNenQ4ZkZ2?=
 =?utf-8?B?UXBudDBCS2ROMFFSTytLb1F2MHQrUlFoaWNzTVZMNDNtUHFHNy80ZFoxU3Fs?=
 =?utf-8?B?QmU3cmZpYS82cmsybGNwUytCN2tZTzJ2cFJFczhVTEZNNkVYbUxIZ3dmdTBM?=
 =?utf-8?B?U1RVREQ5blU1dExOV2V3bDlZc0ZTbjBWVW8xTVUxTVh4QjFEUHNqa1FQZjVi?=
 =?utf-8?B?VlhTWDQzVjQ3a0plVEtsSjZLWVh1eHBqdS9CbVRqRVdMNEt0enRBd0ppRDd2?=
 =?utf-8?B?dlc4MEIza2lTa01RekM3QldWK2xoTzlxdnluZHRjdjhRUTMxSmRRaGplVyt0?=
 =?utf-8?B?NXo0Y2RlRzBVU1JGZVdoVWYyc3BJMlh4a1lxRGtobHNZTmYxYnNJeTZ0cFll?=
 =?utf-8?B?N2FQSmgwdUlLS3lyaHNnL3FmOHlwaEluSjFNdzVGY0dGK3BpdzhYL1ZCdWZQ?=
 =?utf-8?B?bEFUYmp1VDNRcTZaTVNTQTZVOGVicWVNVXVHQjZRb0MyRHo5R1pXZy9OUmhK?=
 =?utf-8?B?TmhDeVozOWpaaWV1YldnM291RW9tQ1JqOVFwUHRVdklKUUErUndSYWQvcHN1?=
 =?utf-8?B?Y3VOWXJ1aFV4cFZKaXIxc1ZiTHJEZGpycjd0QzduSnBYZWlQRHQ0Z3RKZGY1?=
 =?utf-8?B?U093NW1WSXc2MGRuMnlrMWw4Tm91WmhxK3lwdDdQNHZoa2tlb0psSHMzRzFY?=
 =?utf-8?B?emlDd2s0MXUyOS9GYWQyaFJDWE8wZ0xvUUEvWGhtelRhMDZtYjF1YTdIaExS?=
 =?utf-8?B?M3AxN1lwUFl0WEhFMzVxQW5xMWdJZDJyeDFoUXJKQyt5Zm9MOWFtS0RzYlcy?=
 =?utf-8?B?VEkrckNYL1d1eFBzWmIrTmlRME5xSitvaTg5amZVZFh5MUk5bFppRklQVTkx?=
 =?utf-8?B?NnlidnlGb0ZDdU1XRTVMakNEVVFrbkFlSmdTV1c2OVp0L0JubE8yZ1Q1Y3kw?=
 =?utf-8?B?WTk4VUhOdFhoYmtnMjNGTGo5WTN6Z01XZDhFVkl6WUprMXZmdG9aRUhRalov?=
 =?utf-8?B?NTk4NExJVDR0ckxLalBPald1cnlrVk5kWkk0OU0xSU8rdlRRUHNUd0tBNmdY?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A423F44AB333B45A0C0CFC78EFC5892@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e905d6-6bda-481c-9bbf-08daceedc3cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 14:03:01.3480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQ2vXOMYOV4GixzQeKruUKpYC5ttd/dfEpuZjFpv6GCXZ25ecGH780WTg/sUg7tHpSQv5ArIW7uOxHCaO5xDOT71avvNUFHTajnejDy/NQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6139
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjUuMTEuMjAyMiAxNTo1MiwgRXVnZW4gSHJpc3RldiAtIE0xODI4MiB3cm90ZToNCj4gT24g
MTEvMjUvMjIgMTU6NDcsIENsYXVkaXUgQmV6bmVhIC0gTTE4MDYzIHdyb3RlOg0KPj4gT24gMjUu
MTEuMjAyMiAxNTowNiwgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4+PiBUaGUgQVRNRUxfSVNDIGFu
ZCBBVE1FTF9YSVNDIGhhdmUgYmVlbiBkZXByZWNhdGVkIGFuZCBtb3ZlZCB0byBzdGFnaW5nLg0K
Pj4+IFVzZSB0aGUgbmV3IE1JQ1JPQ0hJUF9JU0MvTUlDUk9DSElQX1hJU0Mgc3ltYm9scyB3aGlj
aCBhcmUgdGhlDQo+Pj4gcmVwbGFjZW1lbnQgZHJpdmVycy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYt
Ynk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBB
cHBsaWVkIHRvIGF0OTEtZGVmY29uZmlnIChhZnRlciByZS13b3JrZWQgYSBiaXQgdG8ga2VlcCBl
bnRyaWVzDQo+PiBhbHBoYWJldGljYWxseSBzb3J0ZWQpLCB0aGFua3MhDQo+IA0KPiBJIGFkZGVk
IHRoZW0gaW4gdGhlIG9yZGVyIGdpdmVuIGJ5IG1ha2Ugc2F2ZWRlZmNvbmZpZy4gSXQncyBub3Qg
DQo+IGFscGhhYmV0aWNhbCByYXRoZXIgZ2l2ZW4gYnkgdGhlIG9yZGVyIGluIHRoZSBtZW51Y29u
ZmlnIGl0IGFwcGVhcnMuDQo+IFdoZW4gbW92aW5nIGZyb20gbWVkaWEvcGxhdGZvcm0vYXRtZWwg
dG8gbWVkaWEvcGxhdGZvcm0vbWljcm9jaGlwIHRoZSANCj4gb3JkZXIgaW4gdGhlIGRlZmNvbmZp
ZyBjaGFuZ2VkLg0KPiBJZiB5b3UgcmVvcmRlcmVkIHRoZW0sIG5vdyB0aGVyZSB3aWxsIGJlIGRp
ZmZlcmVuY2VzIHZzIG1ha2Ugc2F2ZWRlZmNvbmZpZy4NCg0KSG0sIE9LLCBnb29kIHRvIGtub3cs
IEkgdGhvdWdoIHlvdSBhZGRlZCB0aGVtIHcvbyB0aGUgZHJpdmVycyBpbiB0cmVlLg0KVGhhbmtz
IGZvciBsZXR0aW5nIG1lIGtub3cuIEknbGwgcmV2ZXJ0IG15IGNoYW5nZXMuDQoNCj4gDQo+IEV1
Z2VuDQo+Pg0KPj4+IC0tLQ0KPj4+IGNoYW5nZXMgaW4gdjI6DQo+Pj4gLSBzcGxpdCB0aGUgbXVs
dGkgdjcgaW50byBzZXBhcmF0ZSBwYXRjaA0KPj4+DQo+Pj4gICBhcmNoL2FybS9jb25maWdzL3Nh
bWE1X2RlZmNvbmZpZyB8IDIgKy0NCj4+PiAgIGFyY2gvYXJtL2NvbmZpZ3Mvc2FtYTdfZGVmY29u
ZmlnIHwgMiArLQ0KPj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vY29uZmlncy9zYW1hNV9k
ZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL3NhbWE1X2RlZmNvbmZpZw0KPj4+IGluZGV4IDg3
N2JiZTdiNzc3ZS4uZjg5ZmQ0ZTBkMTBhIDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvYXJtL2NvbmZp
Z3Mvc2FtYTVfZGVmY29uZmlnDQo+Pj4gKysrIGIvYXJjaC9hcm0vY29uZmlncy9zYW1hNV9kZWZj
b25maWcNCj4+PiBAQCAtMTUwLDggKzE1MCw4IEBAIENPTkZJR19NRURJQV9QTEFURk9STV9TVVBQ
T1JUPXkNCj4+PiAgIENPTkZJR19NRURJQV9VU0JfU1VQUE9SVD15DQo+Pj4gICBDT05GSUdfVVNC
X1ZJREVPX0NMQVNTPW0NCj4+PiAgIENPTkZJR19WNExfUExBVEZPUk1fRFJJVkVSUz15DQo+Pj4g
LUNPTkZJR19WSURFT19BVE1FTF9JU0M9eQ0KPj4+ICAgQ09ORklHX1ZJREVPX0FUTUVMX0lTST15
DQo+Pj4gK0NPTkZJR19WSURFT19NSUNST0NISVBfSVNDPXkNCj4+PiAgIENPTkZJR19WSURFT19N
VDlWMDMyPW0NCj4+PiAgIENPTkZJR19WSURFT19PVjI2NDA9bQ0KPj4+ICAgQ09ORklHX1ZJREVP
X09WNTY0MD1tDQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTdfZGVmY29u
ZmlnIGIvYXJjaC9hcm0vY29uZmlncy9zYW1hN19kZWZjb25maWcNCj4+PiBpbmRleCA4ZjI4Yzlk
NDQzZjAuLmNjNDJjZWE3N2YzOCAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL2FybS9jb25maWdzL3Nh
bWE3X2RlZmNvbmZpZw0KPj4+ICsrKyBiL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTdfZGVmY29uZmln
DQo+Pj4gQEAgLTE0MCw3ICsxNDAsNyBAQCBDT05GSUdfTUVESUFfU1VQUE9SVF9GSUxURVI9eQ0K
Pj4+ICAgQ09ORklHX01FRElBX0NBTUVSQV9TVVBQT1JUPXkNCj4+PiAgIENPTkZJR19NRURJQV9Q
TEFURk9STV9TVVBQT1JUPXkNCj4+PiAgIENPTkZJR19WNExfUExBVEZPUk1fRFJJVkVSUz15DQo+
Pj4gLUNPTkZJR19WSURFT19BVE1FTF9YSVNDPXkNCj4+PiArQ09ORklHX1ZJREVPX01JQ1JPQ0hJ
UF9YSVNDPXkNCj4+PiAgIENPTkZJR19WSURFT19NSUNST0NISVBfQ1NJMkRDPXkNCj4+PiAgIENP
TkZJR19WSURFT19JTVgyMTk9bQ0KPj4+ICAgQ09ORklHX1ZJREVPX0lNWDI3ND1tDQo+Pg0KPiAN
Cg0K
