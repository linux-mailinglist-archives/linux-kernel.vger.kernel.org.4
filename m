Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1C9632490
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiKUN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiKUN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:59:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F9BF80E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669039104; x=1700575104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f4IaknlYAutYqsmZsPuX77XqXcz9pevcOG6Q2quN5zs=;
  b=rMjgsdj5QuhtvpaNXXhpHriH/73JYPGk/5urtGhV+Lub+JSUy6bKh1y7
   eSx5xjrMvzB5mQIVa5z8amfQJEty7FvwdOl99otv6c1m1kkA7m7w2su1t
   Md9tm9T4AzA3gi1aix7p4eqHmMnRJa6h11lDzKYr7+yzFLXZUKgHajWdQ
   CIlTCD0iHdYzMJqjsnCd7D/Ba7L9db8dct2TjxgTs7xX44BdwrRFV4ekU
   VPp3rMfmn0arlmjthYqWCjamcrWK5JOP/BUqGdcBxzotnhSRyNINOq1n4
   ZJKkZwQ85aPD8FqG4yEbjFoPtpMdUzZNA04brA75XKCBQzpSWyuqPnF5l
   A==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="189855782"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 06:58:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 06:58:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 21 Nov 2022 06:58:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuYVTecnmRtvt+lAy9RkbdNpRshQPv4f8dIGzYts9onpfqZHsJTKF0h3G4OF98D6xskTbb2TbFUhHwCSQx7zgTDyflhY7WxlkcHX/iySeD4BKHlG7x5650TzqBbh9aD73RB867a+Jf3CUiZRyw2Yc1xxwwpM1U1ViJZj//lcxfvl6b0pTeGBnPhU7ABb49DbC0bozGBL0/iSZ/TDER8BEiDzDWwinEy4HG6pxcDWWCscpGoF3JMQRIVKHCOw0CDa2gKBMFN8qzQSjB1EXdi2lZFxQWYA5UPZCrH9PvS3wNcF0HHZWxTdP/ElRSALVTv5WBdYHH9IFGEl3LeQ0vWRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4IaknlYAutYqsmZsPuX77XqXcz9pevcOG6Q2quN5zs=;
 b=Fbg4Rwa6n+vzaDmo1EXfPcB/0ZUovlAwIyNwy9FO/kcpnu/bOYFLKOhaSgs5UQvdBXsOwVZR6o7CjfqK1vFLaUBEumKAuI+1Ki3BlSKft9+Z0QTEEtWUSTMC/aU4z6+QXdODbxRxFDP6cNwAiz9Hfhbi/H6cTIVhG1dxlhXePZERGIrXDf654p4D2vIOYYIHzs3XNz92fus1+cEnesca1Ec1pX1ZG1MciizSmDL5VF2N0bZIIC/94tuTPnk9BHBFOGb49+Ig/QD49LdgWmUYOXAlkaVMlZRjUNVxhXT09P4nN8NHyimdmjJXiPrp1WwTTb7cy9r96x4B3miVxr+6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4IaknlYAutYqsmZsPuX77XqXcz9pevcOG6Q2quN5zs=;
 b=ohvLyQTZkKEkPdBeA0heXdk1m5FcPjlLHzheh0er2DfPqS7yeAHS2DNU8XrAw70Nk+e18Ry/WUkqvw5mAm25PTpJtCU8kL7lit6NKqd2BsD2l6W7hg2auc6CkSSMLWKgsxU+KrcH/fQ6YV2JJ/plAeEsjHzS3HsA/Ljyt9b7R/c=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 CH3PR11MB7676.namprd11.prod.outlook.com (2603:10b6:610:127::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Mon, 21 Nov 2022 13:58:20 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::626d:ef37:c13f:1c4b%5]) with mapi id 15.20.5834.009; Mon, 21 Nov 2022
 13:58:20 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Delphine_CC_Chiu@Wiwynn.com>, <michael@walle.cc>
CC:     <patrick@stwcx.xyz>, <garnermic@fb.com>, <pratyush@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for w25q01jv-im
Thread-Topic: [PATCH] mtd: spi-nor: winbond: add support for w25q01jv-im
Thread-Index: AQHY/bFQnClaKp+Es0alm4ZJaWKJrg==
Date:   Mon, 21 Nov 2022 13:58:20 +0000
Message-ID: <a18f1506-e54e-d55f-b627-26cae554749b@microchip.com>
References: <20221007052108.3339266-1-Delphine_CC_Chiu@Wiwynn.com>
In-Reply-To: <20221007052108.3339266-1-Delphine_CC_Chiu@Wiwynn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6479:EE_|CH3PR11MB7676:EE_
x-ms-office365-filtering-correlation-id: 2f5f0ac9-c080-4172-552d-08dacbc872de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /LplHvQJpsH48GBrbCq19F3RFC5BuDM2nJ8jG47CVrNZ4XjCIRH+E7a62iRyj/eVcPuRo8mu9TidC8knxHLKiA6tDiWD2ofirRTpWKE6lSD1y5t5HKVmuQPOVeVk2ayWyeEIqou3fYc/itV+RK5m34kurDf/IdSpOubGIY9qFezMGAaesoo1ETPDLE2bqnYjDmgTnuHOQnN+KmEk14mir2WwMBcSRQyOFw9C1HqzGpFU3yW/8FUYEDW1FF+V8vz8u8xoSULbb/ZE+gBqSYzpHVAINit3mnFyF5pkt9fehlUA1luo1N8ZdDBLmkCR3nGJjA7PIdteXiPGZYhLazJ9r35moWs2lYicgj2smmU+jr4RLQSu5+7p+7wKwmfHOgYWf1b+/F/s+uSsZvAOZBL5u/8iqqrHFv1Q72cgJ3t/c7TV4HBzKagsr+ZdutvoPnvWGvD29qqlcY/JtMNowvZk5nsZijOfpQj22pLwBHrHqUkNe4KAr3v+PG+EaeQwoMsh6GUU9n7LFhyHON3IB5WMDdQsxwn1ICrblCZzhCLSyAPZqX/H5OOeKRG9rNHxdSiPkS/iTo7ywqjWx4aejqDt1lq01vk45ZF3TfStPDkCAQ4G5QdL/K9Kzvvj+3t7/+19XPXjA9soJC0PzaiN1YNdK5aTiEEgTUx9mA9pV/X4JX621UW+HdSFieiYMiIuhE5sLJbHDsiUn3H69dg+4Uh8KEwXcXEGHu+XXtLNjdo1nGS6inA+gWupvkSbia0pmnbXwK+lk2DtdcwRbnJ04ovK1OaSd13/DQdBSbqrJK/SRnQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199015)(186003)(2616005)(53546011)(6512007)(6506007)(966005)(6486002)(110136005)(478600001)(26005)(36756003)(2906002)(71200400001)(122000001)(38100700002)(38070700005)(31696002)(86362001)(91956017)(66556008)(66946007)(66476007)(66446008)(64756008)(76116006)(4326008)(5660300002)(8676002)(7416002)(8936002)(31686004)(54906003)(316002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXBGVzIvcm95SGwwQUROU2VmTHJiNTV5NldBcHMwb0xDa0t4QVc2cDBDZlVv?=
 =?utf-8?B?MjhHRSs1Z1p4bTRGV04wdVhzQ2MxNmpqR0VQTEZlMng3eEFQcXZWMVRiNGsx?=
 =?utf-8?B?N3g5cVh5cGloR1VXYlI4VzNEUmR5M1BhOE5md1ZlOVhsVkFNSzUxazkxKzlD?=
 =?utf-8?B?YkNJblN3ZDQybkM2NlVrdHdjK3pidk5xTHlHSTl0bSthMWtXazYwN2RFSlJi?=
 =?utf-8?B?bWlZaFVJemxOR0FxamFsNmpVMFRGd2dkcFpDTEVSWlVoMis2ek0wNCtPUG1J?=
 =?utf-8?B?YXpvTFBZdm1VWDczLzBBYU9oZE45Zk9rV3RYaDd4TEVkem1iZ2tGT255bDd2?=
 =?utf-8?B?TmJUV2lqZHdOeW0yb0lBbStKbm5LZERrMnJ1Rmp1Q1pKb0RySEg4WkNTeEdV?=
 =?utf-8?B?Q1l4RC9memNpNk4vdlVtR25ZVDVSak80VklNM2QwN2pwRW13N0llSDRHTHlY?=
 =?utf-8?B?SUF2dURHYUxnTk1RU1djZ3JZSHJpZm8zdkZpcW95dmsrRHAvUUtSeUV4alQy?=
 =?utf-8?B?V0tIMFhVQ2FQRU5Qa1RRWW9GL2ptamJtSmpEZHRKQzR0MDZadzJFemVHaHZj?=
 =?utf-8?B?aEN0OHZvS2szYXJ6cHdIWGdVOTNJSXIxQ1JocGVwRzBhSHpGT3U3dEEwWXdq?=
 =?utf-8?B?MnVJSHFjQi9YV3FBdjAraEpkS2cvR3djcnpqOXUxUk8zMnhNUjZZWEQvTDd0?=
 =?utf-8?B?T2M3V1ZwenVqR09kb1h0aFhlUVUvSEJ6dmU2VHFEQ2lJQ1piSFZ3MXRaYk1H?=
 =?utf-8?B?SGk3ZkYxMG90akxQU2I0T1FabGZpczVkSXA2eEhSNURpcE15T09TUGNOWml5?=
 =?utf-8?B?T2FqTzBPSDZxUVZSYitWSUdQVVR3OCtGa3VZK0hLdnYzNFR5LzRGNGtYM1JD?=
 =?utf-8?B?VC9PRmFMZnM0Tm56VFFQak0wTmV6OWYwcXdCM2JEalBaeUMvS2RtUSs0dVE1?=
 =?utf-8?B?ZlNGY2hXWU1HWkovR2VpcEZCZDluR3Z3eU4yYUdjNkJtK0FQVlJJSzVWVHpJ?=
 =?utf-8?B?NWx0eXlORUJxTE9pN0JFS0JnNUVmdy9NRGpDTmlkakRTWWxGcWIyTjBKdGV0?=
 =?utf-8?B?K2dpRi9OYTBJTEZSMmxscy9QS2NRTm1Mc0x0SGw2NktZNkU2ek5wcGdoSXZ2?=
 =?utf-8?B?ZkRXbUpwSTVzcnIvSk5aOUJuQVg2YmVQYjBNN1dremRKNUpXVTdYRmRneHZz?=
 =?utf-8?B?dHRQQU05Z1pjTkczdjNnaVVFZGgzUnZiNTMvWjRBVTM4dDZITGRCYjdDQmVK?=
 =?utf-8?B?Q3VtVkowazNoMGltejF4aVN1dmpncXJJSVdJRUg3MFBUVXUxTGtpNHZpTXNY?=
 =?utf-8?B?b2pBUDVycGJ3N3RLdWtWVysrc2NkMEQ4ZEEwc2dSTE5Wak96MVZoSnFiUkpq?=
 =?utf-8?B?ZUErUGNFOTBRUTZXTkp2eGVWR05ENms3Nloxbk8vU0ZPMCtQK0RiTjIybGU1?=
 =?utf-8?B?cUV3cklPdldaOVNMWkJURm5MTThuSCttNjhnNW8wS0YwcWMzbkNkbmZtUTda?=
 =?utf-8?B?QTVHd1dFaDJEM0VlS2pYOGlMTXJCSGdtemoxY2Q2anh0dG1PdncrMG8valZY?=
 =?utf-8?B?Smp4ZlRydnFYSk56dTR1elBOTVVCQmgxaDVOd3lDVEJvbEJ5a0FCRWVXZ0dJ?=
 =?utf-8?B?aHR4MUV3aVBMZE9qRFhpREsrcEJuQjI3TVZHdmZaQ2tBN0hxSCtLOTdERHpC?=
 =?utf-8?B?SjNNbG1rNkFEZWZkM2ZWbXY1Z3Nna21kUnBYWmxmemh1UFRjdnVuRnBzajFm?=
 =?utf-8?B?YU5jNjBlVFIrUHpCVmVQbDFPZmhublI4OFlJZkl1OVEvT05qd0RHWHRibWVo?=
 =?utf-8?B?eU9mR1JlUnVwa0ZlcE0rTzdudlpnTkRPbmoxWU1RS3NkNXNGTXJUOExGQXVT?=
 =?utf-8?B?dE9pUjZSV0d0RUw4L2tyMjBOdkNyQklOSVR4RHhDY094WHp4THBNdko0Skhz?=
 =?utf-8?B?WFJmWHpIQXpxOG9TdUlBcCtSa28ydVB3bDFXMFhIblpia21jYTVCTm5sazlP?=
 =?utf-8?B?L2Z4VHErNHYveS9Nb2paeDg0UlRpNHJLajlmMXBhUUJxUEdsRVQyUnhYNExt?=
 =?utf-8?B?aWIvY0ZOQnJZRWh3am0ycnpXeG9EYXJReHhpL0JjSmpmeFplUTlLVGxrT05s?=
 =?utf-8?B?SFVISEU4bWhLaGNRNmhmS0s2ZDdyeVpXRVJ6SmdwUXFYQzhCellmRjQ1eVh4?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40CFC7DECF6E2C4B9B643425A690FE3F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5f0ac9-c080-4172-552d-08dacbc872de
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 13:58:20.7105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4ZoGQRo2uPFo8ippbCarIdTuKNf8CK0GSW5iM9NIPAON/1Jx5k1LqEkCYgaKIfQ05lq2QxYyRZxjhRwJ0tWqOfsiJbIn5iJfgW0HhVPuPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7676
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNy8yMiAwODoyMSwgRGVscGhpbmUgQ0MgQ2hpdSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Igd2luYm9uZCB3MjVx
MDFqdi1pbSBjaGlwLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGVscGhpbmUgQ0MgQ2hpdSA8RGVs
cGhpbmVfQ0NfQ2hpdUBXaXd5bm4uY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Iv
d2luYm9uZC5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jIGIvZHJpdmVycy9t
dGQvc3BpLW5vci93aW5ib25kLmMNCj4gaW5kZXggZmZhYTI0MDU1MjU5Li44NTBmMmZkODY3YWEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jDQo+ICsrKyBiL2Ry
aXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jDQo+IEBAIC0xMzksNiArMTM5LDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHdpbmJvbmRfbm9yX3BhcnRzW10gPSB7DQo+ICAgICAg
ICAgeyAidzI1cTUxMmp2cSIsIElORk8oMHhlZjQwMjAsIDAsIDY0ICogMTAyNCwgMTAyNCkNCj4g
ICAgICAgICAgICAgICAgIE5PX1NGRFBfRkxBR1MoU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFE
IHwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU1BJX05PUl9RVUFEX1JFQUQpIH0s
DQo+ICsgICAgICAgeyAidzI1cTAxanZtIiwgSU5GTygweGVmNzAyMSwgMCwgNjQgKiAxMDI0LCAy
MDQ4KQ0KPiArICAgICAgICAgICAgICAgUEFSU0VfU0ZEUCB9LA0KPiAgfTsNCj4gDQoNCkhpIQ0K
DQpUaGUgZmxhc2ggZW50cnkgaXMgbm90IHJlYWxseSBuZWVkZWQgYXMgYWxsIGl0cyBmZWF0dXJl
cyBhbmQgcGFyYW1ldGVycw0KYXJlIGluaXRpYWxpemVkIGJ5IHBhcnNpbmcgU0ZEUCwgc28gd2Ug
Y2FuIGluc3RlYWQgdXNlIHRoZSBzcGktbm9yLWdlbmVyaWMNCmRyaXZlciB0aGF0IHdhcyBpbnRy
b2R1Y2VkIGJ5IE1pY2hhZWwgYXQ6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tdGQv
MTY2OTAzODA3ODExLjg1NTAxLjY4MDMzODYwNzU4ODE5MjI3NDIuYjQtdHlAbWljcm9jaGlwLmNv
bS9ULyN0DQoNCi0tIA0KQ2hlZXJzLA0KdGENCg0K
