Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C9B6522DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiLTOi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiLTOiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:38:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84203192B4;
        Tue, 20 Dec 2022 06:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671547099; x=1703083099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tpH9wONMCszvhaN4rH44w0PTiSijxDVawCxnXxk2WUA=;
  b=TsEh1KEmR4XaywL3lQAbIoeCfPwmEYTFWH8WYOzl+aHx/LT5XadfhmHX
   eCLl9c+JGXNrG3nUnhL7dCV+idL28gIpTAG0cwOYNdoE+HVw9PypwoLwT
   etfDrUrKWZPjItL45jt9uoSC5JwF3NI4DFILb83U9gq05LQgFgYOVllhd
   nhebvLOQ0AaN7Gwsoo+rdvuZvyar6yEWB9SZSkPBsGafPjhsAEFmIgLay
   26x/wHdC829v52oSDtZ9cHyVUhKsZt00qIIjE4ce6L4mnOQapi89qHVSb
   jJy0n+r/+1askMo7d9QEpySeLH7xO56S02wuhI2usJslonV2UI/xfzZfn
   A==;
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="204775892"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Dec 2022 07:38:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 07:38:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 20 Dec 2022 07:38:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iazO5HtPHtBGdTmmb9t4xEUA7D6EPXXryZrubfNe0JVSd9DQ+Xir9tYjnSIT/Oy3uTMWf2r2O7ZtdB/sw76DT9UoGF+zsGhZK27ECb/B9/JLF732lBOkKcAskH5Q59MNSjceM4GnomOyGmNlx7x+WUfz1ADAsmS7dseXwWxBW6lpAG9a6QylKnHJSiAIsRn0AzfpQPT8OkLHkjO1OSWqC1vKiGbTIk5IYQBKKY++sFKrEspeJU3R3CAqQDpjvl1smF62O9ZeVToGFXiZSl1sNeLiO+03Z81PAa9pibPQb7YGMYvtvcDDkwDKLlR1Ft+iFQobPQacFTbGD2qGre0srA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpH9wONMCszvhaN4rH44w0PTiSijxDVawCxnXxk2WUA=;
 b=ZxLRiHcFGgWJvDAVfZjz0YZ9VkGY0JLYe3kZruh4RvANZ6Zd5m5w/MFqYXseBp2t5DbIfXa9/f/dlg0F2oiH4Cyv5EYDAfjJOk/RO5x//AfyUZuXg1KPlitH1Rpbigkd+EC3+dw10trgzlDgqiiLbL6dI0v+/EbwF0M3RQl6zfVcS/bakPXUowjrfuI56S2X1fREjeFyHvCZGskcMn/7tUDjQZ5qn/VVUxQvTtVI2R5uBjG5zgju7F/YOcMmdSWK16vb3sN8dHxBPy3KqO4fZ3xi4hgkavaSarI0ZvdsF8AHuqhaY4uRrb6DmE8LF/7I175jveTKzfrAxa7OviIsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpH9wONMCszvhaN4rH44w0PTiSijxDVawCxnXxk2WUA=;
 b=LUd0nm03olnpKn2P6KFJ6m1UJcZMKABb5BWA9/0Cwc777hcKQIRgQc+EXr6kthGrriyNrPlUKhk+VTXA1hxQe644ObLAfC+ZOzAELzrp3Itp7b1nuOjCZnn+RSXhJjuFrvHEzSD2yUr+J1lknx70jVJNoChpof9T2GRbT/vonS4=
Received: from BL1PR11MB5384.namprd11.prod.outlook.com (2603:10b6:208:311::14)
 by PH7PR11MB6883.namprd11.prod.outlook.com (2603:10b6:510:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 14:38:15 +0000
Received: from BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::775:3af1:d96f:ef6e]) by BL1PR11MB5384.namprd11.prod.outlook.com
 ([fe80::775:3af1:d96f:ef6e%9]) with mapi id 15.20.5880.019; Tue, 20 Dec 2022
 14:38:15 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <robh@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <luis.oliveira@synopsys.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: phy: Document the Synopsys MIPI DPHY
 Rx bindings
Thread-Topic: [PATCH v5 2/4] dt-bindings: phy: Document the Synopsys MIPI DPHY
 Rx bindings
Thread-Index: AQHZEVwtB0LhKuNBckWg5VeIFProca5xK/SAgAWyswA=
Date:   Tue, 20 Dec 2022 14:38:15 +0000
Message-ID: <9c175af4-cf69-9a49-22ac-03b9e4458ee7@microchip.com>
References: <20221216143717.1002015-1-eugen.hristev@microchip.com>
 <20221216143717.1002015-3-eugen.hristev@microchip.com>
 <20221216233719.GA80712-robh@kernel.org>
In-Reply-To: <20221216233719.GA80712-robh@kernel.org>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5384:EE_|PH7PR11MB6883:EE_
x-ms-office365-filtering-correlation-id: d1586ab9-46d8-4138-71fb-08dae297d43f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0tXEwMfTrQoQyGWF+PVcYh8cfXF/kfQrXtk0ZSkiv01sxqITHXOJIwXe9oVcYykdpxpANPzROLuYekXcgY80CWeVuFbf3nixOTANHaWzZO2te0m9J1KhSSBg9KbaBqC1NelDq9D1gfUaQT7PxGvLrLWuI+oMLrGUVjtoJKo0HYqjusNgf+HXSHWWQ3an50yzWB0/aB8tEtIaJtt51ajfJ8A9M/5hPoXb43HXwm+nOCunbYBeT9Pydi5/sC1L/CsChXNqXT9MhZIsCGZkTkSuoepofSe7fEYqiXGqXRAFdEB6yjXAYIk5KACemOsykYNrsZY1ixR0HMCeFlJVEq0FOJwTyIAS6JekF4ORlKn1Vrrp6yqZhW2FRIbFBZoTD7ts3bR2k6YpOnKSeCBiC6vkU9vMPoBEZqBmgSVrLdSfjVCNfhN0zVle9GE7iyP9917fdxDETGjJ93sOTIdeEqNW9h71XfRZzd+T4p1lIkTs6K4rDaUWEAJhbOHb9v5qEK8yMZg1bOl8qA9S29ebMpGRPsrrvKigcLaUfpYCQythRECEYO8OEHiIaCxOU9fw2I6zXrIn2Gi1wDcKwqbvwkGyq6m1cCx7RNGqEHIqZMS2UoQXUlokFTCWKwXUvNajwrolkoqzr4LSqSMZOmNmR37vJljh2kE5Iv20grFFuqnUQ4iLD4ub+hTXmraKLNoJLuQrNl/nBN23QojIXh1NXQeuC+s+EViVXWCsKMuy/mEyjk3Vek55uUZqzGRVppsuzSOoMU112so40RPeSi/g45I4IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5384.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(54906003)(38070700005)(31686004)(8936002)(5660300002)(71200400001)(6916009)(4744005)(478600001)(6486002)(66556008)(6512007)(41300700001)(26005)(186003)(2906002)(38100700002)(53546011)(6506007)(31696002)(76116006)(2616005)(316002)(36756003)(66476007)(4326008)(86362001)(66446008)(66946007)(64756008)(8676002)(122000001)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE5vUzBEWFFhdGFEdVBwUStETm5jVGdwOTZNZUgyTkNraHV3N21teXYxRVQy?=
 =?utf-8?B?T1NKVndSMVhrdGpyNnc0elpMc0pkTGVnYlpCVytZNWcwQWp5cmpVMGdZSS9n?=
 =?utf-8?B?RURPaXcyWW5oSVJhSERNUG9ZV3RPbTU1QmVPampxMU9VejhvL0tjKzNpUklV?=
 =?utf-8?B?eHBjWUczclhjUG9LN3B2NHJCcEtEYStMRmlwU2QzSDFkbUl5VHdmYnBkTmp0?=
 =?utf-8?B?ZmJpVDBXU2xoZUNxN3crbHJXMHpocWllaS9GUVo0SThiS0s3S29heWxtVDk1?=
 =?utf-8?B?YkNJYkJkaHI0QWhDb2grQkRHTVZGVXJSTm9DM2JaeVZ0RFArTTQ0NzF6a3dK?=
 =?utf-8?B?dGhpcmtRTm42L3F1cWd5WHZiWUUvK3AxSitzeEo0ZjJIaWJ1SEdUWFRoRC9h?=
 =?utf-8?B?cnVYSEU2WWROeWg4aVJpOFNGT25CWmc3NkdQdVlNWU5ibzJQOFE0eEpmYnRy?=
 =?utf-8?B?WjdQTXZsaVZQbXdLaHdja3pXaHBxRU5FOCt3eVY2NzgvOTEyeUljeGVnSzdN?=
 =?utf-8?B?alNHbysyaXh4UGd0bkVZemczR1hlYTFIanlCSXFvU2RSU2lybEZENklta1pS?=
 =?utf-8?B?OEw3TFBvOE1RMDZ0T2RYeUNMMkJ0bjRzTG1RalRkSVhwYUNydkFXY1g2bE9E?=
 =?utf-8?B?d1lLRWpzbjdJbkkyOGJyZWFkZ2kzVXpBWHNxNWtvaTZTYVhoM1pYV2N2TzY3?=
 =?utf-8?B?cGIyV3hLVlI0ZnE1RDB6ME9sUjNSOUVnVEFOSTJqQkFyNnpPcHJYM0NUUFNN?=
 =?utf-8?B?M0hlMmVUUHVsNE1mcEtDd1RDVGkwdXN0SjFGUVVsWHNpc3R1K1BBcG5ISDRB?=
 =?utf-8?B?alVtK094YW9HbVp4TGw2TFhqOWovd1pCNVlaRmtUc29xeWxhQThBVXJvS1My?=
 =?utf-8?B?NXdvOHk2MG1tZlc2aHNWaEo4S0FNRTZ1Mk1OVGordEdFOGRXMXpZVDZkZTla?=
 =?utf-8?B?SUJITzQ0aitvUzRXSFZjWC91Ykc0YWJIT0g0SmdjV2FOL0R3dVc2ZzZlNU1w?=
 =?utf-8?B?aE83dmduSVlHUy9EOGpGeEVKOE8rQzVLclh0SUZSOXNoTWlSMUsrbzQ1ZnRs?=
 =?utf-8?B?NTNCUURXNTJLVHIyVkhETm9ETGx3blg4d2c4TURycGJQL0FqREZXYUUzc1Qx?=
 =?utf-8?B?U2M3WEN6VG9rQnFoVnF6WFkrY0hIaTFQdmxDRStNMFcxUjAvSEZobUhxWUIw?=
 =?utf-8?B?Nk91eFhlVjRUYk41RHpnV3BDbDNEaFZCaC8zK0hsVGpQVEo5ZVJUQy81T1BH?=
 =?utf-8?B?Q0h6cmZRREMyR3RYRitzN1Y1a2dGUFEyY3AxVjQ0TTgxZFF6aXFzZ1Q3SEp3?=
 =?utf-8?B?MGFuVkF4azVEdFgzNGU3NWY5SERCb3BDMy9kOFNSRmROM29OcTkwUUhOak05?=
 =?utf-8?B?Q29NaCs1a0NkOC9aY1NuQjVlUWdqYmZGcGJKVXh3TzFnc2ptM3M1Z1ZUOWEv?=
 =?utf-8?B?ZDhaTEU2SXQzN0JxTldrODNPcDBhRmZkajdpclVOSVI4K3oxQUJDNEVOdG5x?=
 =?utf-8?B?YitOTzFBNUlqZzF4OHlVT08xVmhYZXdjb01aeU5WSFVJU1JreUlBYVNJME9u?=
 =?utf-8?B?VzVvMEZuL0FlcmFNaGVlZGJld2tQTm0vcU1PYUkvMDdNYy9QeE5teWhQVU9z?=
 =?utf-8?B?MlZTcmlteUZia1BZOU80SzJnNTdyY08rNWUvQ09yb2w0TFVlU2wwSDdKNTds?=
 =?utf-8?B?cGpZWUdWSGRhZUN1SFlpM251M3laejMzVU1rMU5ySGE2L3F4RHZUU1RkVUJ2?=
 =?utf-8?B?TGtXbDA5am42VjVtbEMrK2FJYXBnSnJ6OUZ4MzBrT0phWG9YSElKMVMzTis1?=
 =?utf-8?B?cFgycmdoTDNGSzdINnQwbEZwSytndlg4cXJGMk9aUC9NRmlqZ0VjWUZheDFz?=
 =?utf-8?B?V0VXd2hYYUh0SHhqVGR4VzhKd0tDVk04aEtNQ1c2RjFEejVXRUhYcjVTR1pF?=
 =?utf-8?B?TE1nRVlFRFIyVmtKYUhURVpzc09nWStldE9MUFhXSyt2ZzB3UXA0NkZEeGFF?=
 =?utf-8?B?Mm5tTkJUNTMrWUVyM2ZoTGNXVm5pM2llTlZTVDF2VlYwRnNTOEdZUUZHa2NP?=
 =?utf-8?B?V1Q1aWovcU4yUTNsUUF4WVk4UUNEbzJURnFndS81cjVJWVBaU2F4Rm9OTlI4?=
 =?utf-8?B?dmswT2ZOT3dXTnhvZkVocmVlczYzMFdSeitEdzlKdDBFSGgwQUQrd3ZPQUpl?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D5FC06DECEE8B439285A31BD5D8C286@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5384.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1586ab9-46d8-4138-71fb-08dae297d43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 14:38:15.4744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sXpabB1DHg5opFVJc4PkkaFGmovgR38qMV6k2sdayGUncwhhgCkXkOrjfIDEN0Yut2Iu3oQJGgWZ3rXWcUTGZQZ8lNX0HomkPUm08Q1qe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6883
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTcvMjIgMDE6MzcsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBGcmksIERlYyAxNiwg
MjAyMiBhdCAwNDozNzoxNVBNICswMjAwLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPj4gRnJvbTog
THVpcyBPbGl2ZWlyYSA8THVpcy5PbGl2ZWlyYUBzeW5vcHN5cy5jb20+DQo+Pg0KPj4gQWRkIGRl
dmljZS10cmVlIGJpbmRpbmdzIGRvY3VtZW50YXRpb24gZm9yIFNOUFMgRGVzaWduV2FyZSBNSVBJ
IEQtUEhZIGluDQo+PiBSWCBtb2RlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEx1aXMgT2xpdmVp
cmEgPGx1aXMub2xpdmVpcmFAc3lub3BzeXMuY29tPg0KPj4gLS0tDQo+PiAgIC4uLi9iaW5kaW5n
cy9waHkvc25wcyxkdy1kcGh5LXJ4LnR4dCAgICAgICAgICB8IDI5ICsrKysrKysrKysrKysrKysr
KysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvc25wcyxkdy1k
cGh5LXJ4LnR4dA0KPiANCj4gTmV3IGJpbmRpbmdzIG11c3QgYmUgaW4gc2NoZW1hIGZvcm1hdC4N
Cj4gDQo+IFJvYg0KPiANCg0KSGkgUm9iLA0KDQpJIGtub3cuIEkgYW0gc2VuZGluZyB0aGlzIGZv
ciByZWZlcmVuY2Ugb25seS4gSXQgbWlnaHQgaGVscCBzb21lb25lLCBvciANCnNvbWVvbmUgZWxz
ZSBtaWdodCBwaWNrIGl0IHVwIGFuZCBjb252ZXJ0IGl0Lg0KSSBtYW5hZ2VkIHRvIGNvbnZlcnQg
dGhlIGRyaXZlciBiaW5kaW5nIHRvIHRoZSBiZXN0IG9mIG15IGFiaWxpdHksIGJ1dCANCm5vdCB0
aGlzIG9uZS4NCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgdGhvdWdoLg0KRXVnZW4NCg==
