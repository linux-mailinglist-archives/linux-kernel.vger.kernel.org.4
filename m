Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F1651AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiLTGqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiLTGp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:45:59 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF413EA9;
        Mon, 19 Dec 2022 22:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu3/m6KCw2VfkCaRn6RNHH5drco3ZYumMmlCUpEZ2wshjFm9gtjNd91T0Es0hoU6G1WhEaIC7spNFxBEQgy3vRlaMazHKbicOlYVJ9wSU9tRZVYqklHjBMCFgCcDV86FfkU1mhg+BqWVj4Z1t0xINvlDRoOMbJeWyCGeuEoIUR4mE+DdPk6OogVzL21K/uUK9gUuO+PncxMcI1Br+BB29zJlX4yIGuKvbPlA3XMHhUoRiWA9sPz64KAjgwKyYOJw2eqbJ3tFwYFnKCLmP6YV/c0x5yz2q0NZs3hKorvyWehGJ7YLKM4Dg/eSJlC8mMPL4SdH7D/vBVwjnyl1xSMOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+jfsdgN6ye6V7UMEIG2nO7IgfAmnDPe0VwwasowLVo=;
 b=dtAKEw1cX9RGFLSE84rxoCYysOXs27YSgJ1wZU59WkOi3dbWlsJ5UYC0RkgFGg70B+pdEXlGy7K49lzZhwpu8oPrU77/dOTyo1prVepMzN38OjAH9V6tv1hrJAcTbIm1xZqmtvTAKgNKUJL1WtCbj2cTkgBNiaIjDefsLvyNfNNuAoNgoDw32zFrbRCia+Y8///EcrwLIkg88EUuOdhk2XzxsyvjXCWabGV9IcvSr0B96ZPJRf9pYp3vH2ctpT/iDOrvtnY0SCGEVfXt8PCeJ90vJw9GO0SRPCLcCdmykX6Y/OI3NWyJ4w5ha79P2ElTzdydqSlXCt0PCceBPVZ49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+jfsdgN6ye6V7UMEIG2nO7IgfAmnDPe0VwwasowLVo=;
 b=kgN7ZuDyf/22q+j8rcUMZlDmvRtjVTGteDuLxpuJ3L7CQagBOY9O7SrRS3rz/RQVX6KB+h+L3WD6HeKvDKFPn8rnppX68oLD3ISJClE9+6Z9+sxWhtD7JXM0WmzES4oyUeC+GPdu2e4QgOPGiEkXvoGbVsSZOt5ME7p2O0NElo8bNSThB/l5P+BuqHNv9+kQLwjLWUFvNGcorHjFtuX13eqSLxwjcdO1CQDr23DJ3+6JFe5QFUC01roI5yMXlAfeKVx9xTTivup5mvVfxg27eQFm6z0Trfl9aRxgTE3PhVQEgz5Z2td4nDFGvSuU9UBG5q5szP/2kUKQWxPrAuJeKQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4589.namprd12.prod.outlook.com (2603:10b6:806:92::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 06:45:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 06:45:55 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "zhangyanjun@cestc.cn" <zhangyanjun@cestc.cn>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: fix multipath crash caused by flush request when
 blktrace is enabled
Thread-Topic: [PATCH v2] nvme: fix multipath crash caused by flush request
 when blktrace is enabled
Thread-Index: AQHZFD3p2tJT+hG7502CVljDzbikHq52VO+A
Date:   Tue, 20 Dec 2022 06:45:55 +0000
Message-ID: <366ac89b-41a9-4954-3a07-179a5f304122@nvidia.com>
References: <20221220063233.43932-1-zhangyanjun@cestc.cn>
In-Reply-To: <20221220063233.43932-1-zhangyanjun@cestc.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA0PR12MB4589:EE_
x-ms-office365-filtering-correlation-id: e7c62839-21d1-4a67-846d-08dae255d860
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: denAdeEs1xHzvbsEgY85brm68Gjyer25ilkxuD0TSB7xu4/AqqaX9r0CnHzqtqWU2JBz6e8J2bp6m8BAm42Z4Ni9Pn6CShE7XdPFCr21ZubGowHyiupzXGo5m/ET0b4kxuFLhOdKH0B35EB/NX7Yn0mxNYo2tlnGSk8km4vGLZ+T+wqZs6MyPfVSMgHMnJ0stiw9l7VEN2yLj0zsfN32hySVAczIUcURBVT/WwKZpbkH60AD/ixbvHsOQBtXfsXAnfSlR8fdevQExj6lYHRLFuhsWroRCekOk/6ZG/1LtZ2rLncWHV/7WM36EIdl2cuPLwYeCoyp0Kx/kbwLYdK46dy8p7flAP4ZXnPnIDQRRf0HdU15gj9QbY3/Xdqk9/3PrW9osLB34sQ7kMhhaoGQbSZaAoymAzryglk3k5T6sio5yPRU51gNp1VAZHOilgrJNEXP/ixo5/sBPoadDizCnojS9DVAIZPVQcWzuX5VL7pvualjdeYwfGTGk0XPJuzvuO6v7qPxkqseC1LKHOWJsTQW2G0WiY77p+jjnqHXNSwGXQuum1615vVwWShZ0uxobZ6b+FRBa/j/sNRcyPJMDT24GmtX00uE8vhCPOX/4ahEO6B8hbME+ux5iWcfzaMy8WVpJq+wxbu8U4xqDzzzRNji+Jl/bdrvsAgXQMsiQh5YvCXkPRMCRR6tXjCKGkVJiCipmjM56VOgP15x8+7fQarLOJFBYOV6YVBx+sgRfMmaN+FZOoNCfTKbkipjSJgDe8KX1e+42H/WiAm6g5uZpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199015)(6486002)(478600001)(71200400001)(31686004)(66899015)(64756008)(66476007)(66556008)(66446008)(76116006)(6512007)(2616005)(91956017)(186003)(31696002)(66946007)(6506007)(86362001)(316002)(6916009)(54906003)(38070700005)(38100700002)(8676002)(4326008)(41300700001)(122000001)(83380400001)(2906002)(8936002)(53546011)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OERRMTFxb0hZZkFKMEFYNG4yR2xXTXE1ZEVMeTJGVHgvdGRRcUhWakltZHdH?=
 =?utf-8?B?ZWM5NVZtQVBVTmhLenRMMlZZNEx2R1Bud3IvQjMrUFhKV2JZZEQ1VlBIOGdY?=
 =?utf-8?B?OEFQNTJ3R3JkNjFaSXZjdmFFRjNsQnMxWVQ3VVRCRHJFUHM1WFpnTFBrM2NF?=
 =?utf-8?B?WHBrU0Jha0pBNFpYNngxQWRmb1Z3aDloTkVGOEpmQVJQZE1yL0IydHJaUDky?=
 =?utf-8?B?MUppanZrNDJVTXhKZFB4S3BsMEM1KzVpNzFPTmdnYWdmcXB4UThyZUtwTkQ3?=
 =?utf-8?B?aG10aVlUeEVja3BIUkJPZE0zYkJKMSs1RFBHUXozWUpuZVFzYlloMzdsRk9q?=
 =?utf-8?B?dVcwM1U2aEFraDZ2TUJLUWpzbFZtWXhHdUlpem94Tm90V2c0Q0pkd09pU1BX?=
 =?utf-8?B?QjVEQWtyOXZwZUs4bG5rMmZMb2R4OEpRejNGeks3Zk5mYjlHUTIydFJ5Z3kw?=
 =?utf-8?B?RXV5OUpsZWpQMjQ2WU8rR2ZXRVArMWs4NExrakxUanVGQ1ZMclFDV08wb0FP?=
 =?utf-8?B?bGM1SGNNTVJjVlhpRzRaL3NPb0ozRkMwSFZKdldvYmN1aTdtSDA2K1pNcGJU?=
 =?utf-8?B?N0kxRVk4eVVlWDV4M1FuT3EvZUJCM1orWDZqK01Wa21TOTBFT1BWUForMW9W?=
 =?utf-8?B?RTdPSnptWkF4WWx4UW5sN2IwREZoLy81dGNtLytELzFBMk83VktkTHhsM3lU?=
 =?utf-8?B?bTd1OVVRMmtQWlE5MjREODNsSVFnQmZ5MDZERGlCSGFtWVMrcy9od2NPaWFt?=
 =?utf-8?B?alRhcXFybm85aGdqZUVMWnltUTNuWUdEbi9HeTNhSGJQMXAxaHY0anRtQThy?=
 =?utf-8?B?MlFzR250eWs3czV2YzBZTXBoMXQvMjFhOFkvTnFFbEovOUNpb0h0b2tWS1Nr?=
 =?utf-8?B?VXJHUDRoR2ZpNmtVMEVMVFlNSHRGbzlZS2JWelZleFJ3K0ZQZ2tMOVNnK2tD?=
 =?utf-8?B?NW04enlUUDdqVGVQNlEwSUJ0c2tQOTBvajdxaERERFhmL3h1RFpOclVPRGE2?=
 =?utf-8?B?VUNhaUFtWlJmRk1xWjhWWVh4Q1VlU21pK2FJaFRJR2cySU9lS1NWeC9zRkJH?=
 =?utf-8?B?WDJ6OEVZS0MyOUFlTDBKbHRtd3p4MkhNMlVCQ2QxYUMxV3hwdUNEYUZlMVhx?=
 =?utf-8?B?RWprZ2RxYTIva01kNUZPc3JTVU1yNis2VXp3WktSNGJNdUJjS2pRZlB4TnFR?=
 =?utf-8?B?Z3J0TE9PNHlSd3VqM1FtN0o4SkVLbEk2Tm1vUERQWjREWnFBTnliZzdRSndU?=
 =?utf-8?B?M3J3clIybHdSY3ViNWRDNFZWdUhJQk5FQkVBanZudW1kck9RQVVQSnpFa3RJ?=
 =?utf-8?B?eHRSNzNlK1lxYU1vQ2Y0NTVobU1FTUMvSnpNaWZWaEZiaklsbzFBekZJR3NO?=
 =?utf-8?B?UFhBb3U0ZU1mQWwrRGU1QUo5eUh2emt4NzFpK3BJZklPTXFnS2grbFRRbDZU?=
 =?utf-8?B?Y0FWUGdkYnQ3WmNwSmY1UXFaMjNBK0ZEUS9YY2Y1S0FQcXlmUWRsL3k3K3Fl?=
 =?utf-8?B?QnR3TU5Ka1BHUE5OeXhubW14Ti84TWlHR0tuSzhpRTFqWTdJemVtTER4M0U1?=
 =?utf-8?B?UjU3OGFIZW1GY1hCOUFhT1hPMUtKK0pTSnhBQ1N3R3QrUnpyNHNBZncyMjVw?=
 =?utf-8?B?SDE1WUVRZ0IvU2J5Q3llLzMzQWt1WUN1dEtPSDBtQVRlazAvTklrVzlSVGxD?=
 =?utf-8?B?RUVMUGJiUThzWnVDenFZcjlrV1VDS1ppN1VOazhJUktJM3QvTy90Z08wMnF5?=
 =?utf-8?B?UkFyTnNPWElvUlBDNEpZNUpldExrVlZiTkpEeWlYNlJHR3FseE1hYmNGTzQx?=
 =?utf-8?B?bDNtdWNHOTRlbCt5RmxSSFBJTGZlMDgrc0hVRTFpbTJ2aml2UGN6L21IZ3VW?=
 =?utf-8?B?aGppN0RjUXp4ajVlMjhnNWZwa0tNR2RDc2dzalVBN1JuQWl0QkhjYkdINGNq?=
 =?utf-8?B?dGg2S2lDaGJ4MjlSUjNhK25oOVNabUZTcWoyb0FIREthY0ZpTDg0QXdFdVdi?=
 =?utf-8?B?QmpHSTZrYTdiQ0dmbit3b2NOSi9RaFRSWkxicE5XcWdWeWFUNFdQVytWUG9m?=
 =?utf-8?B?RzFSOUF2RkF0cVlWMUJJOFdvY3MrT1kwTExOb1RzSDRYYkw0R2J1V0VBSWQy?=
 =?utf-8?B?RWJtd0ROMjI3MFBjYlUweDc4Um4reHFTT0dpTU5COGoxaVBnclZaYlhYM0Jt?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B6EDF1B3B71A04E8306AAFA5D3DB5B1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c62839-21d1-4a67-846d-08dae255d860
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 06:45:55.6023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxDMVmTrr3gSM+G2/pc/qPZxjdFsEhopK66/LZFEYVtI2fXGKpu+ZTzQgK8R4nfWy8x9VHuJ6yqPGcOrUKq2xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4589
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTkvMjIgMjI6MzIsIHpoYW5neWFuanVuQGNlc3RjLmNuIHdyb3RlOg0KPiBGcm9tOiBZ
YW5qdW4gWmhhbmcgPHpoYW5neWFuanVuQGNlc3RjLmNuPg0KPiANCj4gVGhlIGZsdXNoIHJlcXVl
c3QgaW5pdGlhbGl6ZWQgYnkgYmxrX2tpY2tfZmx1c2ggaGFzIE5VTEwgYmlvLA0KPiBhbmQgaXQg
bWF5IGJlIGRlYWx0IHdpdGggbnZtZV9lbmRfcmVxIGR1cmluZyBpbyBjb21wbGV0aW9uLg0KPiBX
aGVuIGJsa3RyYWNlIGlzIGVuYWJsZWQsIG52bWVfdHJhY2VfYmlvX2NvbXBsZXRlIHdpdGggbXVs
dGlwYXRoDQo+IGFjdGl2YXRlZCB0cnlpbmcgdG8gYWNjZXNzIE5VTEwgcG9pbnRlciBiaW8gZnJv
bSBmbHVzaCByZXF1ZXN0DQo+IHJlc3VsdHMgaW4gdGhlIGZvbGxvd2luZyBjcmFzaDoNCj4gDQo+
IFsgMjUxNy44MzE2NzddIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRk
cmVzczogMDAwMDAwMDAwMDAwMDAxYQ0KPiBbIDI1MTcuODM1MjEzXSAjUEY6IHN1cGVydmlzb3Ig
cmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUNCj4gWyAyNTE3LjgzODcyNF0gI1BGOiBlcnJvcl9j
b2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlDQo+IFsgMjUxNy44NDIyMjJdIFBHRCA3YjJk
NTEwNjcgUDREIDANCj4gWyAyNTE3Ljg0NTY4NF0gT29wczogMDAwMCBbIzFdIFNNUCBOT1BUSQ0K
PiBbIDI1MTcuODQ5MTI1XSBDUFU6IDIgUElEOiA3MzIgQ29tbToga3dvcmtlci8yOjFIIEtkdW1w
OiBsb2FkZWQgVGFpbnRlZDogRyBTICAgICAgICAgICAgICAgIDUuMTUuNjctMC5lbDkueDg2XzY0
ICMxDQo+IFsgMjUxNy44NTI3MjNdIEhhcmR3YXJlIG5hbWU6IFhGVVNJT04gMjI4OEggVjYvQkMx
M01CU0JDLCBCSU9TIDEuMTMgMDcvMjcvMjAyMg0KPiBbIDI1MTcuODU2MzU4XSBXb3JrcXVldWU6
IG52bWVfdGNwX3dxIG52bWVfdGNwX2lvX3dvcmsgW252bWVfdGNwXQ0KPiBbIDI1MTcuODU5OTkz
XSBSSVA6IDAwMTA6YmxrX2FkZF90cmFjZV9iaW9fY29tcGxldGUrMHg2LzB4MzANCj4gWyAyNTE3
Ljg2MzYyOF0gQ29kZTogMWYgNDQgMDAgMDAgNDggOGIgNDYgMDggMzEgYzkgYmEgMDQgMDAgMTAg
MDAgNDggOGIgODAgNTAgMDMgMDAgMDAgNDggOGIgNzggNTAgZTkgZTUgZmUgZmYgZmYgMGYgMWYg
NDQgMDAgMDAgNDEgNTQgNDkgODkgZjQgNTUgPDBmPiBiNiA3YSAxYSA0OCA4OSBkNSBlOCAzZSAx
YyAyYiAwMCA0OCA4OSBlZSA0YyA4OSBlNyA1ZCA4OSBjMSBiYQ0KPiBbIDI1MTcuODcxMjY5XSBS
U1A6IDAwMTg6ZmY3ZjZhMDA4ZDlkYmNkMCBFRkxBR1M6IDAwMDEwMjg2DQo+IFsgMjUxNy44NzUw
ODFdIFJBWDogZmYzZDViNGJlMDBiMWQ1MCBSQlg6IDAwMDAwMDAwMDIwNDAwMDIgUkNYOiBmZjNk
NWIwYTI3MGYyMDAwDQo+IFsgMjUxNy44Nzg5NjZdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6
IGZmM2Q1YjBiMDIxZmI5ZjggUkRJOiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgMjUxNy44ODI4NDld
IFJCUDogZmYzZDViMGI5NmE2ZmEwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDEgUjA5OiAwMDAwMDAw
MDAwMDAwMDAwDQo+IFsgMjUxNy44ODY3MThdIFIxMDogMDAwMDAwMDAwMDAwMDAwYyBSMTE6IDAw
MDAwMDAwMDAwMDAwMGMgUjEyOiBmZjNkNWIwYjAyMWZiOWY4DQo+IFsgMjUxNy44OTA1NzVdIFIx
MzogMDAwMDAwMDAwMjAwMDAwMCBSMTQ6IGZmM2Q1YjBiMDIxZmIxYjAgUjE1OiAwMDAwMDAwMDAw
MDAwMDE4DQo+IFsgMjUxNy44OTQ0MzRdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpm
ZjNkNWI0MmJmYzgwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANCj4gWyAyNTE3Ljg5
ODI5OV0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0K
PiBbIDI1MTcuOTAyMTU3XSBDUjI6IDAwMDAwMDAwMDAwMDAwMWEgQ1IzOiAwMDAwMDAwNGYwMjNl
MDA1IENSNDogMDAwMDAwMDAwMDc3MWVlMA0KPiBbIDI1MTcuOTA2MDUzXSBEUjA6IDAwMDAwMDAw
MDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMA0KPiBb
IDI1MTcuOTA5OTMwXSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYw
IERSNzogMDAwMDAwMDAwMDAwMDQwMA0KPiBbIDI1MTcuOTEzNzYxXSBQS1JVOiA1NTU1NTU1NA0K
PiBbIDI1MTcuOTE3NTU4XSBDYWxsIFRyYWNlOg0KPiBbIDI1MTcuOTIxMjk0XSAgPFRBU0s+DQo+
IFsgMjUxNy45MjQ5ODJdICBudm1lX2NvbXBsZXRlX3JxKzB4MWMzLzB4MWUwIFtudm1lX2NvcmVd
DQo+IFsgMjUxNy45Mjg3MTVdICBudm1lX3RjcF9yZWN2X3BkdSsweDRkNy8weDU0MCBbbnZtZV90
Y3BdDQo+IFsgMjUxNy45MzI0NDJdICBudm1lX3RjcF9yZWN2X3NrYisweDRmLzB4MjQwIFtudm1l
X3RjcF0NCj4gWyAyNTE3LjkzNjEzN10gID8gbnZtZV90Y3BfcmVjdl9wZHUrMHg1NDAvMHg1NDAg
W252bWVfdGNwXQ0KPiBbIDI1MTcuOTM5ODMwXSAgdGNwX3JlYWRfc29jaysweDljLzB4MjYwDQo+
IFsgMjUxNy45NDM0ODZdICBudm1lX3RjcF90cnlfcmVjdisweDY1LzB4YTAgW252bWVfdGNwXQ0K
PiBbIDI1MTcuOTQ3MTczXSAgbnZtZV90Y3BfaW9fd29yaysweDY0LzB4OTAgW252bWVfdGNwXQ0K
PiBbIDI1MTcuOTUwODM0XSAgcHJvY2Vzc19vbmVfd29yaysweDFlOC8weDM5MA0KPiBbIDI1MTcu
OTU0NDczXSAgd29ya2VyX3RocmVhZCsweDUzLzB4M2MwDQo+IFsgMjUxNy45NTgwNjldICA/IHBy
b2Nlc3Nfb25lX3dvcmsrMHgzOTAvMHgzOTANCj4gWyAyNTE3Ljk2MTY1NV0gIGt0aHJlYWQrMHgx
MGMvMHgxMzANCj4gWyAyNTE3Ljk2NTIxMV0gID8gc2V0X2t0aHJlYWRfc3RydWN0KzB4NDAvMHg0
MA0KPiBbIDI1MTcuOTY4NzYwXSAgcmV0X2Zyb21fZm9yaysweDFmLzB4MzANCj4gWyAyNTE3Ljk3
MjI4NV0gIDwvVEFTSz4NCj4gDQo+IFRvIGF2b2lkIHRoaXMgc2l0dWF0aW9uLCBhZGQgb25lIG1v
cmUgY2hlY2sgd2l0aCBpc19mbHVzaF9ycSBiZWZvcmUNCj4gY2FsbGluZyB0cmFjZV9ibG9ja19i
aW9fY29tcGxldGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5qdW4gWmhhbmcgPHpoYW5neWFu
anVuQGNlc3RjLmNuPg0KPiAtLS0NCj4gICBibG9jay9ibGstZmx1c2guYyAgICAgICAgfCAxICsN
Cj4gICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggfCAzICsrLQ0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxv
Y2svYmxrLWZsdXNoLmMgYi9ibG9jay9ibGstZmx1c2guYw0KPiBpbmRleCA1MzIwMmVmZjUuLjQ1
MDQzMjFlZCAxMDA2NDQNCj4gLS0tIGEvYmxvY2svYmxrLWZsdXNoLmMNCj4gKysrIGIvYmxvY2sv
YmxrLWZsdXNoLmMNCj4gQEAgLTI3Niw2ICsyNzYsNyBAQCBib29sIGlzX2ZsdXNoX3JxKHN0cnVj
dCByZXF1ZXN0ICpycSkNCj4gICB7DQo+ICAgCXJldHVybiBycS0+ZW5kX2lvID09IGZsdXNoX2Vu
ZF9pbzsNCj4gICB9DQo+ICtFWFBPUlRfU1lNQk9MKGlzX2ZsdXNoX3JxKTsNCg0KRVhQT1JUX1NZ
TUJPTF9HUEwoKSA/DQoNCi1jaw0KDQoNCj4gICANCj4gICAvKioNCj4gICAgKiBibGtfa2lja19m
bHVzaCAtIGNvbnNpZGVyIGlzc3VpbmcgZmx1c2ggcmVxdWVzdA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvbnZtZS5oIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oDQo+IGluZGV4
IGEyOTg3NzIxNy4uMWYxYmQzNzVmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9u
dm1lLmgNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oDQo+IEBAIC04ODQsMTEgKzg4
NCwxMiBAQCB2b2lkIG52bWVfbXBhdGhfcmV2YWxpZGF0ZV9wYXRocyhzdHJ1Y3QgbnZtZV9ucyAq
bnMpOw0KPiAgIHZvaWQgbnZtZV9tcGF0aF9jbGVhcl9jdHJsX3BhdGhzKHN0cnVjdCBudm1lX2N0
cmwgKmN0cmwpOw0KPiAgIHZvaWQgbnZtZV9tcGF0aF9zaHV0ZG93bl9kaXNrKHN0cnVjdCBudm1l
X25zX2hlYWQgKmhlYWQpOw0KPiAgIA0KPiArZXh0ZXJuIGJvb2wgaXNfZmx1c2hfcnEoc3RydWN0
IHJlcXVlc3QgKnJxKTsNCg0KZGlkIHlvdSB0cnkgd2l0aG91dCB1c2luZyBleHRlcm4gPw0KDQph
bHNvIHlvdSBuZWVkIHRvIHN1Ym1pdCB0aGUgYmxrdGVzdHMgZm9yIHRoaXMgT09Qcy4uLg0KDQot
Y2sNCg0K
