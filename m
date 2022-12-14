Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED9B64C956
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbiLNMzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbiLNMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:55:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279FB2615;
        Wed, 14 Dec 2022 04:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671022528; x=1702558528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M4450M7nvPRhLV/NCk1uT7OSwVw6dip3lxK1yCrrXiY=;
  b=bUezGY1mQjJ+5Ahf4e6Rm4TZo33HEmvLNxHQxinMedia6IjC56R4a0fv
   8YxrovReBc/QufKWHjgjh2h4S65KvTxK6IV8UnHq7idldveiXUqDP43Ya
   iTOVQQGV/V5LSdeIyoOzE+sGp7FKMaHk8wfir279Kg5NXOTJSHgs4u/Rd
   wREdwoPC7SnX7CGAhwJCQQki108OM8TArxYR9G8thDoSdhSz0PPZFR2/T
   2nVMtkDLc+6mlTWH7XNHfaPSyYogMqiifaC+Fb6ovv+99cq42vKo7jEVV
   JjspYxJndkmdvt7vtQYRSHzSWxDcog+S8TSQKLQ+owfINtKBEhydT5KB7
   A==;
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="128102732"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Dec 2022 05:55:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 05:55:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 14 Dec 2022 05:55:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex+EyqcNknGWcOewwPmNh8jWhrLzJ2KROuO+s5p7htfjQPYRHtibWG62PHfW+B8bX98GnZZJgDBm05+ncQhjV873hxmlhbRnm/wIwU7CPX8tPnr/AUk5ZjY+ERWls8BCf6lc2cW6nCQUPcB5x/bB4SrtdQkAQUyU5MQmeSEmYvc3KzDozgPewdm7d2VDh3vxaQwzfoGo2YjB3NBLMoowe5zIgm6XqxoHEJWkrNbBw23zy+m16zPelDUlqhOHYkNnB98CpDWlmCbVU5xTRniYtq5170SdtSSoTOE2vup/HKu5553yAxN188POF4kr8drvY7nbUjTV7GGK5D9Fnh8mew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4450M7nvPRhLV/NCk1uT7OSwVw6dip3lxK1yCrrXiY=;
 b=dkD9vjbt5PTHjEAFM0iJEMK2UqCnSOGn0DujmLAJq44kG20a9X2pQtZV6vPNS76lfCiThxDHrM1JKjB1MDYp4UVvy7wpSJt5ZfCyp61WgTSZYoA+VTVWZZX/7Tw/OP8TfJTQmsghqGiMq8u1KmXCXYHSKF4VWZTaSxvXDtTgsQsNf32ZpaCeaZkkPiHL8YAXGPqgyhyKAq52TpyqVSR0XgnBuEX2p331vPfd/NKY3gftypjyQ2XAdAjPjgifANw9atE8F/5IGkTH8OyGpDY5NPiclKndkFP9CxJH9fOJPHz9Dfy4S7cksxzIjgFxLOfCRM1bX43c01bqsCt5pkEJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4450M7nvPRhLV/NCk1uT7OSwVw6dip3lxK1yCrrXiY=;
 b=dgmnRrNQbn0mKo7MW5ehTy4WArHgyVozRVWrLXU1ayaqR2llhdxEyL8qIEJtMzXfl4rS1vrAdPgaTkmTVBUGPgqUJrRBEsUL4iTdyTaqkt87e36NmKL2VyBUpK14BbRyl/W6AkluupvPS4eMA1qyW+4w44L71VaLcRCrTq/1ZRA=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by DM6PR11MB4625.namprd11.prod.outlook.com (2603:10b6:5:2a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 12:55:06 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::775:3af1:d96f:ef6e]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::775:3af1:d96f:ef6e%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 12:55:06 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <Nicolas.Ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jacopo@jmondi.org>, <hverkuil@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH v10 3/5] ARM: dts: at91: sama7g5: add nodes for video
 capture
Thread-Topic: [PATCH v10 3/5] ARM: dts: at91: sama7g5: add nodes for video
 capture
Thread-Index: AQHYXtOFLMdFbrhp9U+PmUo7kDl4W65uuOMA
Date:   Wed, 14 Dec 2022 12:55:06 +0000
Message-ID: <323a98c7-85f1-a21c-d655-7b510481adc0@microchip.com>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
 <20220503095127.48710-4-eugen.hristev@microchip.com>
In-Reply-To: <20220503095127.48710-4-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5384:EE_|DM6PR11MB4625:EE_
x-ms-office365-filtering-correlation-id: a364b9d2-af30-4f6b-d4aa-08daddd26cdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7HGgr7G1dRq/61m6WlPPffLOUSOcCMdHTPvNJ/g6kumIb9xbP/63jelkr/pvNmjwPAl+nEJa3j7LcTjDcm2AwMO02iNBnwxV6PbpdH6KxZd+ErtHjvb591BugeXeiPZ1EHwYmMDPb8yxF6Z6iFdSs9jiTGUpXxZUqS5U2zUcsz75ymNLmQFmf13noOFFwoYGARZpjd9Mmln6vwpXK3LWiN14w+J4NnJpqfzzXOcM4VRyzVd//uPOPVOhE/sU+wdihZRIxyMCkZI17Q2ozzsw+F3B7DpLDorzvHP6hGMJSTvAFkzn7xQQPUfKGxTq5MTLZXoQqOeXBvl7Oy1d53WEs8GXC6L4C8cxQRxFbsNasQ4RQf4qzUROrSGY+SQ+Yvxlck8tw1Ma5iQHDIYEicvqyCACavu2tcMF9lxTgBWD5Ijd9vOR5lQfnltLP7zzLsgxepqcNGx/7osaYZFXwgRRiiglOAHbqt2o/cyT3SUfkm7uXcsLq4euO3PHFQGaqNBj9bwfGTdYRwtcA+TXp20fABUNLvxi6HYus5gSdNV4LFKqVVvxNqT3QwQVr1cwUuGSjQMSc/2kz9z5CQfXj2CjDx7dQdfzxtRmsYIoVf2Md6DiJwd6GbyGu+1N9GBcWrBFrOqyb2QZXkBR8xeKKoC5H//b3Aw8QYIgFVz0CHTwuS8/W93s9fmOjSY7PrgxI1W8mNrjJ1LDFInZsU0dAM3eiVieWYKS40kAM6SEx4IeJL8TXacHHEZdoYdhraBCU0QduyrqFM7+P1gIT85252ooA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(54906003)(110136005)(6636002)(8936002)(2906002)(41300700001)(91956017)(4326008)(8676002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(2616005)(316002)(36756003)(83380400001)(38070700005)(31686004)(31696002)(86362001)(478600001)(186003)(6512007)(26005)(122000001)(38100700002)(6486002)(6506007)(53546011)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWRXMHhxZnpteVFZQnc4SGhtWmg5aXk1ekxzR0JSY2hRdkZhK0ZrS0lxd2xJ?=
 =?utf-8?B?OUVHMmVERzUvbmxaeFNjU2t5dUhkY3QyQUhKTFFibGlYcUlHNHAyb0w4dWla?=
 =?utf-8?B?dVRFNHgxVlNYZ3AzRncvL0JJaFhWMndwLzRSNDUzeTl2VE9idkVRZEhXbE1o?=
 =?utf-8?B?ZmtlR3hJLzhUajNVcWtxNExzQXczV240djkzZXE5dm1BWDhEdW9QcklnakxN?=
 =?utf-8?B?UDg0dC8yTkg3ai83djV0WXlBbWNIOFh1SmtMOGNybGlPYzVRSlZIMHNtaVYv?=
 =?utf-8?B?TmdSYlpscEZtWCtYcnk4aWEvRDI0UFJFVTloRVlnejJSUy9UUVE3YTFldW1I?=
 =?utf-8?B?RGRnUEtmWTd3ZDRQdXQwcjhBUlBBL2YvRnUrZWRXMnIybmRyTjFpSExRVVp1?=
 =?utf-8?B?cjhzT3RZbG5vWVZZdGVCSmFWc3FIMFRjYTQva09kdWVqVkQxQlFCczhIR2Er?=
 =?utf-8?B?UlV3STkwVzRGczNZeFdnR3ZNM1JieWdNUVRqdml5a2t5ck0wbnYxalpxbFRj?=
 =?utf-8?B?TXVMcWRIYVlRbVJxR203VGJwR0U0TDlSS2NIa29QUGVkNE5uUDk3a1VHUTNq?=
 =?utf-8?B?RDhuMlRGbDZselhMcXN0ZXQyQ0tDNklQQzFrcjN5SXhnVEhwanpTRTRhVU9s?=
 =?utf-8?B?WEtseStLVE9IVGtnVmhlNTlnNUJ3NmJ4SWpsSUtYajBveGJuUFJwZmFtRkhJ?=
 =?utf-8?B?S2dXVTJCMlVXM2NGaGgyMEpvK0ZuL2VKQ25rU2xibDkrRml1WmlDZlhlL1ND?=
 =?utf-8?B?cXYvU2lnQ1dCQ2hVUDZQc0M1S3piK2ErQUhNcWVkWDdhWXdZQ2JXMFpoN0lU?=
 =?utf-8?B?YlY0dzhzVm5CYWlJZTBJQUV5N21wNVJJVm5tTFBwUUJKOEFLNU5hRVZCMWFz?=
 =?utf-8?B?N1ljVkFRMDVUSXRvTHNqWVpucWF0d29mOEJZZmlxdm9vWEhudlBkek94c213?=
 =?utf-8?B?TW5VVTlkNzdWZEVaMTY4VTdBMTkvNVVkUSszQTVBQnY0V3V1eVcrY3V1SS9j?=
 =?utf-8?B?c0xGNVA1K3NEeFhMYXQ1WWR0bnVhOUdQVlFvamtEQk95c0lJSnlJSFZCVmsy?=
 =?utf-8?B?OWtaNk4vSithZjllSmpYREVtY1ZESUVDOWVwOGVqcjl1K0ovRXpsYjhQMEJr?=
 =?utf-8?B?VWtzZWZMdGtveGlRdS9WOC9DQmpiODE5YzFsSTllYWpUMjlKQi9TVC9ENU51?=
 =?utf-8?B?cS8vbG1uUTRZUmFGK0lhTHZlM3Zxa1l4emRFbFgyck9RVGcxMm5KWGVtaUlY?=
 =?utf-8?B?MDJ2Q216WGlNQU9RaEFuRVJPZnZJN0JoTnpDRzRCNU1Da25mUnhTM2VpYk54?=
 =?utf-8?B?M0VITkdxNVFXQ0xXUVlyS2pqWE1NU2Rkd1JCWU5OLzN4MGVaQXhYN0JiM3hU?=
 =?utf-8?B?cFJWOU1HUTVDSUFwclpPbkVSbFUvWmVzdUZUMVVUazF6UEJleE85aDNIUEpG?=
 =?utf-8?B?QWIzZXdMZmtYWFNWUkg3VkRzSVUzRUIrWW9XaXdsUFBQWENiaXFJdFBvT1lO?=
 =?utf-8?B?aTdNeS9xV200SmxkYklXdnJRMUxiSHpZSVRpUTFwVUM0UkM5R290enNSMWp5?=
 =?utf-8?B?V05SNnZhZW5iOUhLMjlyQlJtMFlkSmdiTnpLWVpia0RmYzJLMWlneHV6UDFH?=
 =?utf-8?B?UVJrMElOZVJWK0RraThScmdtbkFUNWRaTnNmcXdMWlg4eFY3OXZGNXZYSGUw?=
 =?utf-8?B?TEJkUG5aSWYwQTdrOUJQd3JrdGJwS09uUlBDN0VkSG9HWmdza3lYQnZTRlhS?=
 =?utf-8?B?R25OVGVlL3hzYWQ0TUVPN0dHM2VObHdDS2xVN0Y2ZEdVUGVlSkliMW1UbE5V?=
 =?utf-8?B?dmJQeVFRekRHMHV2Z29lWEhLZWsvbWZhZ0Rkem01R3VXcm9QcG5xSHQ0aUNt?=
 =?utf-8?B?K3FQcHJad3FiK3FkaEU1YlRhVjR5SDhLT3Z4bXAzVlVxSnlrQnZJdUxlY0oz?=
 =?utf-8?B?cUpSZml2bGFTWCsvSitOUGwrSnd5UHRvay9GcldYUC9BcTZqbS9tWm81OUs0?=
 =?utf-8?B?V3paZkw4N2xOSW00KzBwNU43cStpS2g0SWVYRkJ6YTlabnJSY0l4Rjg4WHhE?=
 =?utf-8?B?QkNYOUs4ZFVJM2JiMXVHeWgwL1lBYzhVMVJwOEhmaENDTHd6VEhGaTJOb3l2?=
 =?utf-8?B?VDF5UE5BUnBWOTZkcUpQZ3BZRVRHdGZOUFFvWGFiZm5ZUWJ6UkRFRTVxcXpr?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6241052F8307FA488DBD2E5ABD56E599@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a364b9d2-af30-4f6b-d4aa-08daddd26cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 12:55:06.5260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4K3q96qHiGL1JiagLbfcSz8NJyb/HumhIVnCuMArFG/SW5CVuPEBxSdGPmRVbKkdWserJ/R85NrFcdwPdU0jT0//W5bQoS5HTyOiWhentqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4625
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIyIDEyOjUxLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPiBBZGQgbm9kZSBmb3IgdGhl
IFhJU0MgKGVYdGVuZGVkIEltYWdlIFNlbnNvciBDb250cm9sbGVyKSBhbmQgQ1NJMkRDDQo+IChj
c2kyIGRlbXV4IGNvbnRyb2xsZXIpLg0KPiBUaGVzZSBub2RlcyByZXByZXNlbnQgdGhlIHRvcCBs
ZXZlbCBvZiB0aGUgdmlkZW8gY2FwdHVyZSBoYXJkd2FyZSBwaXBlbGluZQ0KPiBhbmQgYXJlIGRp
cmVjdGx5IGNvbm5lY3RlZCBpbiBoYXJkd2FyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEV1Z2Vu
IEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMg
aW4gdjEwOg0KPiAtIG5vZGVzIGRpc2FibGVkIGJ5IGRlZmF1bHQNCj4gDQo+ICAgYXJjaC9hcm0v
Ym9vdC9kdHMvc2FtYTdnNS5kdHNpIHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtYTdnNS5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMv
c2FtYTdnNS5kdHNpDQo+IGluZGV4IDRkZWNkM2E5MWE3Ni4uZmU5YzZkZjk4MTliIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvc2FtYTdnNS5kdHNpDQo+IEBAIC00NTQsNiArNDU0LDU3IEBAIHNkbW1jMjogbW1j
QGUxMjBjMDAwIHsNCj4gICAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiAgIAkJfTsNCj4gICAN
Cj4gKwkJY3NpMmRjOiBjc2kyZGNAZTE0MDQwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJtaWNy
b2NoaXAsc2FtYTdnNS1jc2kyZGMiOw0KPiArCQkJcmVnID0gPDB4ZTE0MDQwMDAgMHg1MDA+Ow0K
PiArCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCAzND4sIDwmeGlzYz47DQo+
ICsJCQljbG9jay1uYW1lcyA9ICJwY2xrIiwgInNjY2siOw0KPiArCQkJYXNzaWduZWQtY2xvY2tz
ID0gPCZ4aXNjPjsNCj4gKwkJCWFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDI2NjAwMDAwMD47DQo+
ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArDQo+ICsJCQlwb3J0cyB7DQo+ICsJCQkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCQkJI3NpemUtY2VsbHMgPSA8MD47DQo+ICsJCQkJcG9y
dEAwIHsNCj4gKwkJCQkJcmVnID0gPDA+Ow0KPiArCQkJCQljc2kyZGNfaW46IGVuZHBvaW50IHsN
Cj4gKwkJCQkJfTsNCj4gKwkJCQl9Ow0KPiArDQo+ICsJCQkJcG9ydEAxIHsNCj4gKwkJCQkJcmVn
ID0gPDE+Ow0KPiArCQkJCQljc2kyZGNfb3V0OiBlbmRwb2ludCB7DQo+ICsJCQkJCQlidXMtd2lk
dGggPSA8MTQ+Ow0KPiArCQkJCQkJaHN5bmMtYWN0aXZlID0gPDE+Ow0KPiArCQkJCQkJdnN5bmMt
YWN0aXZlID0gPDE+Ow0KPiArCQkJCQkJcmVtb3RlLWVuZHBvaW50ID0gPCZ4aXNjX2luPjsNCj4g
KwkJCQkJfTsNCj4gKwkJCQl9Ow0KPiArCQkJfTsNCj4gKwkJfTsNCj4gKw0KPiArCQl4aXNjOiB4
aXNjQGUxNDA4MDAwIHsNCj4gKwkJCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbWE3ZzUtaXNj
IjsNCj4gKwkJCXJlZyA9IDwweGUxNDA4MDAwIDB4MjAwMD47DQo+ICsJCQlpbnRlcnJ1cHRzID0g
PEdJQ19TUEkgNTYgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICsJCQljbG9ja3MgPSA8JnBtYyBQ
TUNfVFlQRV9QRVJJUEhFUkFMIDU2PjsNCj4gKwkJCWNsb2NrLW5hbWVzID0gImhjbG9jayI7DQo+
ICsJCQkjY2xvY2stY2VsbHMgPSA8MD47DQo+ICsJCQljbG9jay1vdXRwdXQtbmFtZXMgPSAiaXNj
LW1jayI7DQo+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArDQo+ICsJCQlwb3J0IHsNCj4g
KwkJCQl4aXNjX2luOiBlbmRwb2ludCB7DQo+ICsJCQkJCWJ1cy10eXBlID0gPDU+OyAvKiBQYXJh
bGxlbCAqLw0KPiArCQkJCQlidXMtd2lkdGggPSA8MTQ+Ow0KPiArCQkJCQloc3luYy1hY3RpdmUg
PSA8MT47DQo+ICsJCQkJCXZzeW5jLWFjdGl2ZSA9IDwxPjsNCj4gKwkJCQkJcmVtb3RlLWVuZHBv
aW50ID0gPCZjc2kyZGNfb3V0PjsNCj4gKwkJCQl9Ow0KPiArCQkJfTsNCj4gKwkJfTsNCj4gKw0K
PiAgIAkJcHdtOiBwd21AZTE2MDQwMDAgew0KPiAgIAkJCWNvbXBhdGlibGUgPSAibWljcm9jaGlw
LHNhbWE3ZzUtcHdtIiwgImF0bWVsLHNhbWE1ZDItcHdtIjsNCj4gICAJCQlyZWcgPSA8MHhlMTYw
NDAwMCAweDQwMDA+Ow0KDQpIZWxsbyBDbGF1ZGl1LCBOaWNvbGFzLA0KDQpUaGlzIHBhdGNoIGlz
IHJlYWR5IHRvIGdvIG5vdyAsIGFzIHRoZSBtZWRpYSBjb250cm9sbGVyIHN1cHBvcnQgZm9yIFhJ
U0MgDQpkcml2ZXIgaXMgaW4gdHJlZS4NCg0KTGV0IG1lIGtub3cgaWYgeW91IG5lZWQgdGhpcyB0
byBiZSByZXNlbnQuDQoNClRoYW5rcywNCkV1Z2VuDQoNCg==
