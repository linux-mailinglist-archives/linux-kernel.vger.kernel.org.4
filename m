Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263CB6D500F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjDCSLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjDCSLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:11:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4132134
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680545504; x=1712081504;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zrQofNJvsGa+n+b3EiC8bQoA2+tWVtJLKM7VwzWPtjI=;
  b=zxZm1YyslbVStVX3GW0OmdTklKW5H37WR7jjjcHg2c17Yd1zSt9cQCLP
   rVgyZbs7Fu55kJ61ynNX92CUl5xtgAwikSe32eEi3hT+Kfaze7nNBJtcH
   V++YQt+P3jAZhtgm5ejJhQTAg9Jbw4DbUUmPwwIOVTK46K/Zjcc31XGMe
   321wqxJ4lG8oGaBCmlji1uTXLDVp1D/roWOehOi6A3bFoLvmwpttL1GS6
   tSGKoKWDLMV663VNZxjBr1m1UUoeMNtvngN+wYg8xJghv0R33cLpzuDdw
   KXs6fujYrjDNDQkzfyq0ehig4qZJW49NAOq9j5Gu49twav1efHq6JqA7s
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,315,1673938800"; 
   d="scan'208";a="207954637"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Apr 2023 11:11:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 11:11:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Apr 2023 11:11:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+B5gAIDCFpmr5EUP2OWtwDnO0c2qG+ceHsjZFH6m9MB4z0KsgMGRiH7WblP6oc19RLqXNYZX/SGNHOvGqRzQAvLABLcOy8rDpAEuY3KOANq9ORH2E9T5euq8XvnEspW3B3aKt5Gw3NV1M4+S+yd4DEOwLmd4OTthU5Ni9L/1G37qETaHt6UqOn/eE1Macq3S6tZeNFAJgRg3P05Zd5eAgmt7PcZdCeyctEcfSC5UDU69LKdrTBahwDZJaXrotlH3WVaaD7be7ykzCKGvcSJ/aa8raE+0XuBynB0BhbNaJU20xWZqtpH8zw3vygmVKLjbqNA595sWkAhknEyUXMi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrQofNJvsGa+n+b3EiC8bQoA2+tWVtJLKM7VwzWPtjI=;
 b=DiLpg2IEfl2xHHMNMsL9ME4Wf6cjnsZMkR8Hl7E4kuFGePRutApHudifSYfKyI36kryjQqaoWnb7Qh6s8Es8lma63W5+5kHmVdXFEsirvewXbop5s43DBnuiC2JqD/FMVh1GRcxlOfG/JuU3ZTxZWN8d+v4vs+pwfZcewA86nm6yzjuFO/M4Aqa1jvXdoC2Udb+JZhTachGISkoTg1TdYaR3OLrMTGInBmkwYmuU31xcvZlYEuzgrOR7Gd7FSXXshjsQuloV54IdY/tQ40PtXhWWqzBV+KZfYCr23DLc97QUBjNotSwooDva3MNKSdPdgttpjycD+Z7z0NGIFUi02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrQofNJvsGa+n+b3EiC8bQoA2+tWVtJLKM7VwzWPtjI=;
 b=jE+Hl9IACEfH1a8OQKubpZZa15Jq+83PUZNlnL7wlFYJGsCE7YmvxF/+5o7Yv3/GnUB0ZiKYne7v1soDc9fWLM/3a+Gxz5er+AejUz8PRRyWHlp3zN1q5gMBlHJBs/YEB6gzxjUtICVJsAQn4cyKVH3wPHA4T8MCg0jxvQMqjks=
Received: from DM4PR11MB6166.namprd11.prod.outlook.com (2603:10b6:8:ad::21) by
 DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.29; Mon, 3 Apr 2023 18:11:33 +0000
Received: from DM4PR11MB6166.namprd11.prod.outlook.com
 ([fe80::2643:88e6:3188:8a55]) by DM4PR11MB6166.namprd11.prod.outlook.com
 ([fe80::2643:88e6:3188:8a55%8]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 18:11:33 +0000
From:   <Valentina.FernandezAlanis@microchip.com>
To:     <conor@kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <Conor.Dooley@microchip.com>, <Daire.McNamara@microchip.com>,
        <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] Hey Jassi, all,
Thread-Topic: [PATCH v3 0/8] Hey Jassi, all,
Thread-Index: AQHZZkqN8TI2HkRUM0Ksp3C3lzo2cq8Z4toA
Date:   Mon, 3 Apr 2023 18:11:32 +0000
Message-ID: <d3fe02e9-0e34-17d0-251e-5cc4394c8889@microchip.com>
References: <20230307202257.1762151-1-conor@kernel.org>
In-Reply-To: <20230307202257.1762151-1-conor@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6166:EE_|DM4PR11MB6504:EE_
x-ms-office365-filtering-correlation-id: 4f48f6d7-6fe6-4ac5-2d3e-08db346edb14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xiKia2vu1y0oZ5UD0rTyGIeFxDUYoO8uzzQxPy5dTuSG6c/Xkug7ZU3YSsmMEmWJBoQ/7pUaJF3Flu1fq0dJOPQ3nExENxa9vvRQMeK2bPuVzi1wv66dQ/wsSqK0YxIIOMHd7B2bpilstvG3lDZn01Xj5+oBmrMFCyyFhALrdNMK8PDbQyfBVfnJWAVzC+1mI70yco7icU1hxD4BNQ+PKCcERHT234faTlBBwevMZNr3z162BcN34f5w595465y9sFX2g/AjM1MsBY4OQqIgags2eRL7v7KjmS3ff2laGODJLdUKnCqpVCqUtFfEw7HalAW66lQEq7hsXz9+qfRNv1UvB2IKrQ0wgQIsZPipgVK4KLdChVHuCxPQ1rMNV4Nv24KfvkIqiguJQWZomN2BLIhvL/1cIg0R7SG4acSB0IH67/z4GwyfzToMLNKFFq9Sd5jaLNISRUAsl7ey6pun6hJ2/u7wxpvtZQa2YroANcQJN49dhChzd+M4MbwuaY+A+Df2cryyEKEhmU49JVtGdZtKboJJ96Sm48EL+NztQCbcUYpgEW+Jz1w/hwZG8LLLz82AbeIodOLXn4X2jaAXY/4h/vt6PtjpFlGmkklNLcehmoPywQ65M1zd/bXbimS97r6kuZusyWlcs4voEv2kSxNJ7YczdoXqUfR5DgtX01oL+UKR1Lcor6AFkoxAZ93m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6166.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199021)(31696002)(36756003)(38070700005)(86362001)(41300700001)(54906003)(76116006)(64756008)(71200400001)(66556008)(4326008)(6486002)(66476007)(66446008)(478600001)(316002)(91956017)(110136005)(8676002)(66946007)(186003)(2906002)(5660300002)(8936002)(38100700002)(122000001)(26005)(53546011)(6512007)(83380400001)(2616005)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnVMeTR5N3pnUVg2V3M5OCtYSVVEeHNSaUtsTzFBSS95RnMzSVJrSlluUStM?=
 =?utf-8?B?MXBCL1RZNDJMaVpnT29IaUtSREZxQjFGVUJkR3FKSk1NbDJOcTZSdFZ6Q3Jy?=
 =?utf-8?B?c1A2Q3N6ZllCVmVoVmh4RlBNTjNFck92RlN0WktPelZHei9Fak53ZFpYbDF3?=
 =?utf-8?B?VTBRaitMWk9YamFCNTd6Z0V1Z01rNHBPZWMxVFM4UU91dDE1SWVKaVorODJt?=
 =?utf-8?B?dzJkWlFlTmNHcDZORkNsQi9tb3NoRXZRajU0aVcyaXo2QzhxZ1NsQnJ0MmIv?=
 =?utf-8?B?ZTU0OXhsbS9VTUpMMERsdnVQbmQwUmtjbXNRUXhmdlBGamhRSm9GcU9aVG5r?=
 =?utf-8?B?TjkyaXJQRmVrQkhGazZzREhwM1lWdElocTVnL2dvZytoNktnVlFBOGw1T2lS?=
 =?utf-8?B?SHlSbnhGTTZuSlMzcFJGaFlvZEJiVHh4eGtHeksreWRLVStFZ05CbmFVU2pG?=
 =?utf-8?B?bXB1c2lxMDR1UStudlFIb0lFMFlVMU1USXVOdFBOVllVYWsrUU9JbjhUMlZo?=
 =?utf-8?B?MHFvemNYNEd0Y2tNbFM3MCs1bmNhSUp2WEVlcllML3hWRFJIbDljeCt4Uzkw?=
 =?utf-8?B?d1ZQbHQ4V1B2UU0zV29QdjJXVzNpZ1YrSUw2dWM3eHo4ZGxtMXJZK1Q3NG5G?=
 =?utf-8?B?R053ZC91Qyt5cHk5RGZNSEY5ZmR1RzZKY3RiZXZpYkdEZnFNSDJKVDY3eHZx?=
 =?utf-8?B?Zm1VMWdwa2hVN2NzZWI3V3ZIK3IwaW9CS2piR0k4cVJkTTg1TS9UWjNKbERJ?=
 =?utf-8?B?aHJmWkNNa2pUS2svdm1kdjZqZE1Qd1g0M0cwQWtGOFp3b2hyUzJTNUxtNnZP?=
 =?utf-8?B?d2VBS2FObStCYVlTc0hoNWhTTzg4YWVTaE1xRUw5UmhJclRYN1g5K3MxZURU?=
 =?utf-8?B?U1FiK3B0YmxIQ1VKKys4dG82WHFySFJ6cWFVZHlRcXV5L1Q3QUtZZk54dnNL?=
 =?utf-8?B?clVRU3JDZTFscHpuWlRGTmprZ1JDWTRQSCtZcUFYZ2YzUDlNaE1mckdJRHd1?=
 =?utf-8?B?UTRuSWF5dklidExZb2FhSHh5dHA2YTJLU2ZYeHFQb01iTTB3SUZ6Q2NUeTB4?=
 =?utf-8?B?UVVncm9BSVlIK3RuaUFtS1Nuc2NQNytIb2NVVDExWlhLOVNzRzcwS3lHVnNp?=
 =?utf-8?B?aE50SmhHVVRoUWNTdVRzb2hCQW5LVmRaZFNSUExqWTlQeHY2NEFVRnFEYWNw?=
 =?utf-8?B?S3NKWHVCWjEvWEpOcHR6N0FoeXBLZnNLamFicDlGL1Q2bE5CdVBoM3h4QXBD?=
 =?utf-8?B?TWpHQ3lycmhFVFB3Q2pDZkQ5aE9RL2xaYXF6Y1hiSEIyVURzMEUydm04Zkcv?=
 =?utf-8?B?emZ5Tm5uREg3NHhxdWNwWFN2aG1QSVpMU2pGVWx4V0RwNTBVVmlZQTdMK1M5?=
 =?utf-8?B?RWt0TW1FWEtndDFuUkpjUUo0WFY2WE9GaEtiSkpQN2QvNXhaa3Z6aEMyN3FZ?=
 =?utf-8?B?TVVNT2FneDhpd0phK0kxM1JIcm84eGtGTXBqT3l1b0FJVCsvTEhTS2VIVFpC?=
 =?utf-8?B?cElKcmNQY09tYUFuM2dyRlFSbnVEZ0hLVkVUeEQ5ekM1VTBocWo5QU01L0Rh?=
 =?utf-8?B?aGdYLzJGeGlWNWN2NExoMEJGczVLdExxODNtNEtmalpwaFkycGNlZXhBOFJt?=
 =?utf-8?B?Mkt0ZFFkVE1YbVh5UWxEN1R2MXc1aDV2QlNITmd1dS8wMkxScFdZdzc1Tkpl?=
 =?utf-8?B?Z28zMmZTNDVCNmZ1RmlEZlZCbWdzK2NIcXgrQ3JMRm9pc0cwZGU2UzhvSFc3?=
 =?utf-8?B?Z01UZUxnQldJUkljMGJwOW5Lb1MwUmNIOGNOOUc4VDdYV3BUazFFNTZlZHNk?=
 =?utf-8?B?RUVHRzY2SUp4cmVmdW1RWWJWYUFHUWdHSW83VXNwTHZ1NkVmVHphTXo5OWJO?=
 =?utf-8?B?dUFZZitNeEgrelJFckw0REZndDdoQjFkMGZmVkJabXFZYlJNTURGK3VWWm1P?=
 =?utf-8?B?a2t5MEZlVFV3TUE0cjQzcjhVNWZhYytWNmVwWENuNU1yWDB4NUJkVlJzZUpR?=
 =?utf-8?B?VVIyekx6QjhvVHN2ZGtWMUF1UWFaOEhodDFoMjkwdjRoQ3RKWXpHb001Ymg2?=
 =?utf-8?B?Yy9GdjdiK2tnbjlGSUJ5SDB1OC9SVTFVczQ3cWNwRm01MVVIVnZQSkhvcS9X?=
 =?utf-8?B?ZHZ5MnVndm0zSTZnV0JrQW1uY0psdGhtWEZBNHZxeWhBTTRScDhJZ3FTdU84?=
 =?utf-8?Q?KgZPWfLdQLL46NTEisKarDI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E00FD2FE07EAB045B12C5BCB28D8F0B5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6166.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f48f6d7-6fe6-4ac5-2d3e-08db346edb14
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 18:11:32.9519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5x3wPGDOdxEuuIQjUt7aF9PFGd8hR6GaBEc9fEIwx1e8ZWzbI8H3vh2UJa/RTNqPWcMx1MDeaLRd6nE+1f8ViEH0fMpsGSTQWOsr0rXbPShDnXtIeKd2lqzmxlYguPLX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMDMvMjAyMyAyMDoyMiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBGcm9tOiBDb25vciBE
b29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiANCj4gSGVyZSBhcmUgc29tZSBm
aXhlcyBmb3IgdGhlIHN5c3RlbSBjb250cm9sbGVyIG9uIFBvbGFyRmlyZSBTb0MgdGhhdCBJDQo+
IHJhbiBpbnRvIHdoaWxlIGltcGxlbWVudGluZyBzdXBwb3J0IGZvciB1c2luZyB0aGUgc3lzdGVt
IGNvbnRyb2xsZXIgdG8NCj4gcmUtcHJvZ3JhbSB0aGUgRlBHQS4gQSBmZXcgYXJlIGp1c3QgbWlu
b3IgYml0cyB0aGF0IEkgZml4ZWQgaW4gcGFzc2luZywNCj4gYnV0IHRoZSBidWxrIG9mIHRoZSBw
YXRjaHNldCBpcyBjaGFuZ2VzIHRvIGhvdyB0aGUgbWFpbGJveCBmaWd1cmVzIG91dA0KPiBpZiBh
ICJzZXJ2aWNlIiBoYXMgY29tcGxldGVkLg0KPiANCj4gUHJpb3IgdG8gaW1wbGVtZW50aW5nIHRo
aXMgcGFydGljdWxhciBmdW5jdGlvbmFsaXR5LCB0aGUgc2VydmljZXMNCj4gcmVxdWVzdGVkIGZy
b20gdGhlIHN5c3RlbSBjb250cm9sbGVyLCB2aWEgaXRzIG1haWxib3ggaW50ZXJmYWNlLCBhbHdh
eXMNCj4gdHJpZ2dlcmVkIGFuIGludGVycnVwdCB3aGVuIHRoZSBzeXN0ZW0gY29udHJvbGxlciB3
YXMgZmluaXNoZWQgd2l0aA0KPiB0aGUgc2VydmljZS4NCj4gDQo+IFVuZm9ydHVuYXRlbHkgc29t
ZSBvZiB0aGUgc2VydmljZXMgdXNlZCB0byB2YWxpZGF0ZSB0aGUgRlBHQSBpbWFnZXMNCj4gYmVm
b3JlIHByb2dyYW1taW5nIHRoZW0gZG8gbm90IHRyaWdnZXIgYW4gaW50ZXJydXB0IGlmIHRoZXkg
ZmFpbC4NCj4gRm9yIGV4YW1wbGUsIHRoZSBzZXJ2aWNlIHRoYXQgY2hlY2tzIHdoZXRoZXIgYW4g
RlBHQSBpbWFnZSBpcyBhY3R1YWxseQ0KPiBhIG5ld2VyIHZlcnNpb24gdGhhbiB3aGF0IGlzIGFs
cmVhZHkgcHJvZ3JhbW1lZCwgZG9lcyBub3QgdHJpZ2dlciBhbg0KPiBpbnRlcnJ1cHQsIHVubGVz
cyB0aGUgaW1hZ2UgaXMgYWN0dWFsbHkgbmV3ZXIgdGhhbiB0aGUgb25lIGN1cnJlbnRseQ0KPiBw
cm9ncmFtbWVkLiBJZiBpdCBoYXMgYW4gZWFybGllciB2ZXJzaW9uLCBubyBpbnRlcnJ1cHQgaXMg
dHJpZ2dlcmVkDQo+IGFuZCBhIHN0YXR1cyBpcyBzZXQgaW4gdGhlIHN5c3RlbSBjb250cm9sbGVy
J3Mgc3RhdHVzIHJlZ2lzdGVyIHRvDQo+IHNpZ25pZnkgdGhlIHJlYXNvbiBmb3IgdGhlIGZhaWx1
cmUuDQo+IA0KPiBJbiBvcmRlciB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gdGhlIHNlcnZpY2Ug
c3VjY2VlZGluZyAmIHRoZSBzeXN0ZW0NCj4gY29udHJvbGxlciBiZWluZyBpbm9wZXJhdGl2ZSBv
ciBvdGhlcndpc2UgdW5hYmxlIHRvIGZ1bmN0aW9uLCBJIGhhZCB0bw0KPiBzd2l0Y2ggdGhlIGNv
bnRyb2xsZXIgdG8gcG9sbCBhIGJ1c3kgYml0IGluIHRoZSBzeXN0ZW0gY29udHJvbGxlcidzDQo+
IHJlZ2lzdGVycyB0byBzZWUgaWYgaXQgaGFzIGNvbXBsZXRlZCBhIHNlcnZpY2UuDQo+IFRoaXMg
bWFrZXMgc2Vuc2UgYW55d2F5LCBhcyB0aGUgaW50ZXJydXB0IGNvcnJlc3BvbmRzIHRvICJkYXRh
IHJlYWR5Ig0KPiByYXRoZXIgdGhhbiAidHggZG9uZSIsIHNvIEkgaGF2ZSBjaGFuZ2VkIHRoZSBt
YWlsYm94IGNvbnRyb2xsZXIgZHJpdmVyDQo+IHRvIGRvIHRoYXQgJiBsZWZ0IHRoZSBpbnRlcnJ1
cHQgc29sZWx5IGZvciBzaWduYWxsaW5nIGRhdGEgcmVhZHkuDQo+IEl0IGp1c3Qgc28gaGFwcGVu
ZWQgdGhhdCBhbGwgb2YgdGhlIHNlcnZpY2VzIHRoYXQgSSBoYWQgd29ya2VkIHdpdGggYW5kDQo+
IHRlc3RlZCB1cCB0byB0aGlzIHBvaW50IHdlcmUgImluZmFsbGlibGUiICYgZGlkIG5vdCBzZXQg
YSBzdGF0dXMsIHNvIHRoZQ0KPiBwYXJ0aWN1bGFyIGNvZGUgcGF0aHMgd2VyZSBuZXZlciB0ZXN0
ZWQuDQo+IA0KPiBKYXNzaSwgdGhlIG1haWxib3ggYW5kIHNvYyBwYXRjaGVzIGRlcGVuZCBvbiBl
YWNoIG90aGVyLCBhcyB0aGUgY2hhbmdlDQo+IGluIHdoYXQgdGhlIGludGVycnVwdCBpcyB1c2Vk
IGZvciByZXF1aXJlcyBjaGFuZ2luZyB0aGUgY2xpZW50IGRyaXZlcidzDQo+IGJlaGF2aW91ciB0
b28sIGFzIG1ib3hfc2VuZF9tZXNzYWdlKCkgd2lsbCBub3cgcmV0dXJuIHdoZW4gdGhlIHN5c3Rl
bQ0KPiBjb250cm9sbGVyIGlzIG5vIGxvbmdlciBidXN5IHJhdGhlciB0aGFuIHdoZW4gdGhlIGRh
dGEgaXMgcmVhZHkuDQo+IEknbSBoYXBweSB0byBzZW5kIHRoZSBsb3QgdmlhIHRoZSBzb2MgdHJl
ZSB3aXRoIHlvdXIgQWNrIGFuZC9vciByZWl2ZXcsDQo+IGlmIHRoYXQgYWxzbyB3b3JrcyB5b3U/
DQo+IEkndmUgZ290IHNvbWUgb3RoZXIgYml0cyB0aGF0IEknZCBsaWtlIHRvIGNoYW5nZSBpbiB0
aGUgY2xpZW50IGRyaXZlciwNCj4gc28gdmlhIHRoZSBzb2MgdHJlZSB3b3VsZCBzdWl0IG1lIGJl
dHRlci4NCj4gDQo+IFRoYW5rcywNCj4gQ29ub3IuDQpIaSBDb25vciwNCg0KSSB0ZXN0ZWQgdGhp
cyBvbiB0aGUgSWNpY2xlIEtpdCBib2FyZCwgbG9va3MgZ29vZCB0byBtZS4gU286DQpUZXN0ZWQt
Ynk6IFZhbGVudGluYSBGZXJuYW5kZXogPHZhbGVudGluYS5mZXJuYW5kZXphbGFuaXNAbWljcm9j
aGlwLmNvbT4NCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gY2hlY2sgdGhlIHNlcnZpY2Ugc3Rh
dHVzIGluIHRoZSAudHhfZG9uZSgpIGNhbGxiYWNrIHJhdGhlciB0aGFuDQo+ICAgIG1wZnNfbWJv
eF9yeF9kYXRhKCkNCj4gLSByZS1vcmRlciB0aGUgaWYvZWxzZSBiaXRzIGluIG1wZnNfYmxvY2tp
bmdfdHJhbnNhY3Rpb24oKSB0byBwbGVhc2UgbXkNCj4gICAgZXllcyBhIGJpdCBtb3JlDQo+IC0g
ZXhwYW5kIG9uIHRoZSBjb21tZW50IGluIHNhbWUNCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0g
dXAgdGhlIHRpbWVvdXQgdG8gMzAgc2Vjb25kcywgYXMgcmVxdWlyZWQgZm9yIHNlcnZpY2VzIGxp
a2UgaW1hZ2UNCj4gICAgdmFsaWRhdGlvbiwgd2hpY2ggbWF5IHZhcnkgc2lnbmlmaWNhbnRseSBp
biBleGVjdXRpb24gdGltZQ0KPiAtIGZpeGVkIGEgdHlwbyENCj4gDQo+IENDOiBDb25vciBEb29s
ZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiBDQzogRGFpcmUgTWNOYW1hcmEgPGRh
aXJlLm1jbmFtYXJhQG1pY3JvY2hpcC5jb20+DQo+IENDOiBKYXNzaSBCcmFyIDxqYXNzaXNpbmdo
YnJhckBnbWFpbC5jb20+DQo+IENDOiBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+
IENDOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IA0KPiBDb25vciBEb29sZXkgKDgp
Og0KPiAgICBtYWlsYm94OiBtcGZzOiBmaXggYW4gaW5jb3JyZWN0IG1hc2sgd2lkdGgNCj4gICAg
bWFpbGJveDogbXBmczogc3dpdGNoIHRvIHR4ZG9uZV9wb2xsDQo+ICAgIG1haWxib3g6IG1wZnM6
IGRpdGNoIGEgdXNlbGVzcyBidXN5IGNoZWNrDQo+ICAgIG1haWxib3g6IG1wZnM6IGNoZWNrIHRo
ZSBzZXJ2aWNlIHN0YXR1cyBpbiAudHhfZG9uZSgpDQo+ICAgIHNvYzogbWljcm9jaGlwOiBtcGZz
OiBmaXggc29tZSBob3JyaWJsZSBhbGlnbm1lbnQNCj4gICAgc29jOiBtaWNyb2NoaXA6IG1wZnM6
IHVzZSBhIGNvbnNpc3RlbnQgY29tcGxldGlvbiB0aW1lb3V0DQo+ICAgIHNvYzogbWljcm9jaGlw
OiBtcGZzOiBzaW1wbGlmeSBlcnJvciBoYW5kbGluZyBpbg0KPiAgICAgIG1wZnNfYmxvY2tpbmdf
dHJhbnNhY3Rpb24oKQ0KPiAgICBzb2M6IG1pY3JvY2hpcDogbXBmczogaGFuZGxlIHRpbWVvdXRz
IGFuZCBmYWlsZWQgc2VydmljZXMgZGlmZmVyZW50bHkNCj4gDQo+ICAgZHJpdmVycy9tYWlsYm94
L21haWxib3gtbXBmcy5jICAgICAgICAgICAgICB8IDU1ICsrKysrKysrKysrKy0tLS0tLS0tLQ0K
PiAgIGRyaXZlcnMvc29jL21pY3JvY2hpcC9tcGZzLXN5cy1jb250cm9sbGVyLmMgfCA1MiArKysr
KysrKysrKysrLS0tLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCA0
MCBkZWxldGlvbnMoLSkNCj4gDQoNCg==
