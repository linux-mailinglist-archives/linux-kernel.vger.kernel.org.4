Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A705FC0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJLG27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJLG24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:28:56 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4B4AA37D;
        Tue, 11 Oct 2022 23:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665556134; x=1697092134;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KJ0p+qY+SlWl04s4VlNoJmauFK0x+W/iN+1jXPO4Kgw=;
  b=C26DhcbW7rLeQWCKrxwlkdLCoO5cwOm0dI83SC0+vSnOJhITinVZ7WEM
   piBRSB555i7P0+2nE1nQWmUSaRieUBFW3vVXQ6I3VzKEvrGDos6ODgelq
   wVMeDwHtc6c6Qujll1y3uXiiIekLrWYKFBDh/qd7nZfqOYT6rkABY7nKB
   XeNu0n7POYCYNVEOXkB+SyaHm/cS1hJJOHy1u6DtcFe9sdNl+4jJPxNsy
   +8LBSkOfiRT/dAMkB4q2TmbqLxualHVOsdkZB3CufPtj3mZwRoj7NcvY4
   bQyLUhdaoHJfR6cLdiqErDJLcwJ3wxFkfhzr4v6KN9PbrS7x4t71MCCW4
   g==;
X-IronPort-AV: E=Sophos;i="5.95,178,1661788800"; 
   d="scan'208";a="218749612"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2022 14:28:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVjkw0Yah+rK840Az28z1fsuKbh9+S93kKsVEWadhp6LSbB3yvpJZa7PCdgTmvI0oFc9oykxpP/UqwI3OXjLFy3zxWGmble6Tj/qLPRGeMmEzIyZBnbwC3WID7kztZ+ImhLEKy2k2K2wjJCyrHf6QHVAlMueoXCXKcH2MQ+Y+20Q2VzLP2l7jUHeJltYnY+jqWjM67YAel9b4dNTreKZ76TPEPWAelYRmAFIoZDxyNQL0tneWjxybODWF/YLcsfx+Ehf3bSP0dycdg0bAtHjFYxKcPCHZk+2uICgkhApIb90CguaRdhE1+KgL+T6SJiWYcbEutqivntsfZjzNA457w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ0p+qY+SlWl04s4VlNoJmauFK0x+W/iN+1jXPO4Kgw=;
 b=GZhdbZSAntsNRoFd67BIZyaOcFsgn3CsCVuHvvNcUweCipVcJiz0mTA00sLkB/tSi16IbhfnrdFHis3voh8MeIt577j0utGx7AX3+Jj/8Q+ZrH7CfzRwXVNBHbeQWMaj17t4t8movHBMn5V40+VK9gnPdn3n6trfL3MBEmcP/nowk1c5gpXdZXB4aaridCeknNF6EIBDeJ9dcZkr8+fDfMCKIdIPbTgguhZjCQX3bmxXywGZ3DMWCdaqbfQccX99SlkRrvWcPgNzQltTykV6VRsRvow6og0BSvwHIzHod6kajVjHEL58bHWfP/LghZA196JKJte8OEYPePW4wHI6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ0p+qY+SlWl04s4VlNoJmauFK0x+W/iN+1jXPO4Kgw=;
 b=jQfLyU5yDGOdhjjYYFlkjhDbNSTm7dvzPlAX+/w7lJwLk2QGmiXBnhaoNW4MvwsuBHqtodD0P6NkJjnJhBs0Jf8LaMWZ5UpW6Bh+PKCACqmSyz2oXKceUUQvsx/1nP3HxoINOXTLBqi8I2N2FyV1pIJ4XlSH1cobqmyA8SFVWGQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB5876.namprd04.prod.outlook.com (2603:10b6:408:71::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Wed, 12 Oct 2022 06:28:49 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1%6]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 06:28:49 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?utf-8?B?6auY5Lil5Yev?= <gaoyankaigeren@gmail.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ufs: core: Disable auto h8 before ssu
Thread-Topic: [PATCH] ufs: core: Disable auto h8 before ssu
Thread-Index: AQHY3ReOb6qYvQkkBU21f4ndI5lc+q4IxU1wgABQioCAATX+kA==
Date:   Wed, 12 Oct 2022 06:28:49 +0000
Message-ID: <DM6PR04MB65756E9549E9DCDB4BCF8FF6FC229@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221011021653.27277-1-gaoyankaigeren@gmail.com>
 <DM6PR04MB6575AE77585D584652179089FC239@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com>
In-Reply-To: <CAFN68yVajOkV++gCp-y1+SD5VOKLgUeBhfgskrJZOX5dfGi07A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB5876:EE_
x-ms-office365-filtering-correlation-id: f3e3d37e-da43-4eb6-8093-08daac1b0628
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Y0XFwyzM7Az6mnJg8itO6UUuTkO6niVCmqRnagykZpjFp6vDsaLuP8EiCAV2s7ntauLqJiVMqNyTEfY0RcBNW+DdnIOfwaH416s9ofXCjRUm0Z2qMvGcWPzMvwpn4/BVitBQ/tw2pL/V7eW45isDB3874zTR4WVdADZqjv0tGA5BN2Wm1NkwHQDWmkUSxLhrXqoV9L00cUql6ykL0vBBRat/gk2+/Nq9MqWg7aoAmqFKHmtYenD9Nqf0h9HKHke5sSRu8YRLAYmL/jsYmmp9Gzpkfc8Baws8vViIMjAyscdxy6AzYLK4KMuKya+eMiQdHrgnob0f/cbZ0jt+9hS6ETMDHJfaIndt+KwSeWuZcH9P6nALo4/Wm2THkjnZ9bFHQPrNG+xof/uYj3dXyCOzO4W3Kj4gUuxgvQEZStYQTAsqnInzGQGV9D1rdOrsTiZBIrPKkJqevvOn2Fi6a/H2NpZLNr4UJhuuhukBs+csnn/3cQdyCkS8+mC0OxKuN9uHwXWy0afui4Chzrvaal3YNYTQlHkc4vfD/qneZSxOsDdNqElApgKf5zq0WHPmHsUwM/QjTvthIgR5vaKSVewzpoSI43zoHrrY2HrBuyWyPLADSG0pbiQgB/ntNRTYF25G8uWG1GZXp0r/J1GNJg/XSqTjmiaJ0nUY2cSzKXg8+dI5uulTAQgUxwwVNlK0Wr4G0Pkv24kWzDKXPGt9WWQP8FFxjDQ/XVP+R7jCu0nxC6dH6JOjB9XOGsvEJTlzYgV0j6ZmcvpKYTRtzMFF4+ecQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199015)(66476007)(82960400001)(478600001)(76116006)(316002)(4326008)(38070700005)(38100700002)(66946007)(64756008)(122000001)(8676002)(71200400001)(6916009)(66556008)(66446008)(54906003)(2906002)(7696005)(41300700001)(26005)(52536014)(8936002)(83380400001)(186003)(6506007)(9686003)(5660300002)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEdhWWd5d2JaM3AzZHFBVGt6SStFZWYrRXZiMmZVT1NuVlQvdTZWVGIzNEM2?=
 =?utf-8?B?ejcyc29xdkpNdTdZYkJNZDlYZm9LVW5QVlZSd29yQXpFYnZHeUZ1NldwUmpP?=
 =?utf-8?B?ZElFWU1Ddm53azZCdThXTnhxUE4yaVMvL3VScFYzUHp0ZUNTbDVCNHd3cDlM?=
 =?utf-8?B?Q1E4SWFTKzgzSWZwSnBwaVg0NkFqUkh5M2xOb2tZWExKcmdERnlLbVpMcElj?=
 =?utf-8?B?UVRFclpXSEpiREVjcjFWMXBBQnA4RS9qVXhCSlE0NlNTTzFKTkpSWXo5Qk9G?=
 =?utf-8?B?d3pFTUJITW9oOGZUMFo5Yk02N09Id0ExQ1B0WXpwRVVKU2ZKSTAxblFDV2RO?=
 =?utf-8?B?b1QrVVhqMFlwTVVlV3JRbTRXQ21RRUQ2Um5RalpJWWJlelpSQXdZVFNjUHdZ?=
 =?utf-8?B?N25iZVB2cEIxc3N2VlhkR2RCU0JmSG9hYm9tU2V6aFRMWTlmVmNaRFVZYVhB?=
 =?utf-8?B?WS95WlVQUDlESjhaY2Z0eHpLS1RIUzRsY1kwM29FMW1yRUxvUHBGRzEyZmpW?=
 =?utf-8?B?bVdZVEwvbk9VZ2dmOGlNMWdINHN6K1hSMmVhYnFwOXdPRk9neDRsL21nc0Ns?=
 =?utf-8?B?cDVqVSsrcEFuUmtFV3NRWEc3TDJiZ1JsYXFsMFpKRzEzcXM3NVdmbXVRUW9O?=
 =?utf-8?B?OUl4NWhrTGxBY3FNOUZndks2ZTNPcVl5dkRYaVBUNTZKRXUvZVNuSDdGNlAv?=
 =?utf-8?B?cTZqeldxeURUZHZwUkprUWt2QkI3RzBQL1FRRjIzTVBBcFdYcUcxbFUzbGRZ?=
 =?utf-8?B?dUNnNnZuSm1TUFg3bUxRazNOQmU1eG53c1Z3ZFUrQWwzSDdQdlJMbVJSTTJs?=
 =?utf-8?B?SlBjcHN0RUxUZ3YyL3RaRWlWWXkzT01RTEtZTTUwRmljekdURjBFdUJBdDJz?=
 =?utf-8?B?ZjFvZjByZk45ZGpDY1NCUzVRTzhsS2JnWEtVRWFPdzBuOTZuS2dxd1ArcUQ5?=
 =?utf-8?B?aGpZTkJKZTB3VHY1MVBwZWRIVzZ1ekR3STdSdjNFU2hXbTJ4Z1ZJVGpzTmU0?=
 =?utf-8?B?RmVtY21SRE1Ja3VwU1BocmhKb3dldGJDYmFjZEVtYlNNQXVJMmxkVFpPeXgx?=
 =?utf-8?B?a05JZjlaT1hmejdQQXhubjFwelh5eXhuSUVGK1AxM1JUU3phWlVBdHJLbUpk?=
 =?utf-8?B?MzF6c01teXJhQ2l1R2xjaVEralB3MUFzL3ZjRGRkS0dweCtLT0xuTFFDa3Bj?=
 =?utf-8?B?VXBIUXJpWnVKOEJNMFo2aU4rUThlV3UvK3ZQT3phK2ZwU2hjTnFDUlkweXJL?=
 =?utf-8?B?TFlzeWNjVkYyMjFvYXFzakh3amZCSXdDMGN5VUY2RE52WWw4czcxN2txSmF0?=
 =?utf-8?B?N0R4ckVhZDc3aUxjRzZPcjRpT25EMEVqVFBOL0xKREQ4dlJpZCt1azdXUWJJ?=
 =?utf-8?B?cWF1ZjdWVFZHc0VaVGJTVGdUUXZLaW9IeDlMMVFuZ1pQdjkyL0l4TVpLcWxX?=
 =?utf-8?B?cUFvdVpzVExhU1IyN1VFR1ViM3V1dllkQzkxanpCcDlYakVxeVM4OWR6QnZ4?=
 =?utf-8?B?UE54eGxndHNwQWNPUnFNS1lYSWZGQXU5QW5VMk9jNCtRSHpEcUo5eTRueFR4?=
 =?utf-8?B?NHQ0aXRrRTBQRFNwSW92N0kvU0hvNkEzSXdBdnMzTTMxSGxqUmo3ZVJoeWo2?=
 =?utf-8?B?WVZUbWdRTWlwdEpUNkNQbGF3WGFQM3lhYlkwRjh1TCtnRlBteFJsV0FOUUth?=
 =?utf-8?B?VFNXZzJwSnRGMDdvZ0V2RnFzOGdPVDhqUnFMbi9SQ1BrVTBhZ2piMUM4Y3NN?=
 =?utf-8?B?Y3hQa0duL0p6ZFg1SFZZcit3ZnRFZDhyS05FVkZ3bGNqNWJML2FheHBmeTI2?=
 =?utf-8?B?Z2xTcWNjbTNsVHVWZXhiQnhnaW5MczVqaWFkTFR6UjE2TE45VkU4YnhBanp1?=
 =?utf-8?B?U0h5ZHByVFRrN3lIRlNYWUxaYWtBeHIvTENkSjdjMnpKTldibnNISE5DNVlv?=
 =?utf-8?B?YTEzTS9aa2tsaHpRTU01ZUY0bzVNWk4rOEFJbnUvekhPUGNYSXBjdDBSMjJS?=
 =?utf-8?B?L05sMFNxNTJCbXM5OGltNnZtLzl2dTNJT3NESjgrKzJOSVFsdkZtSjE3cmJK?=
 =?utf-8?B?UmFWUldQR0hxMTFKZGtLWU1MTmdmemFONHUvLzI5SEJ3YUkxalhtSlZQT25O?=
 =?utf-8?Q?i19BcEtMufzMXBAqZW0GucLNB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e3d37e-da43-4eb6-8093-08daac1b0628
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 06:28:49.3289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xft9NuLeLq6fCCBbBzdkb1XtnxsEvIFjt//dtzjrcNd4PjXqLiF73WN3/Bx8pv/iEzr439QZGNH1gCMZ5aXAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5876
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gRGVhciBBdnJpDQo+ICAgVW5pc29jIHJlcG9ydHMgcmVzdW1lIGZhaWwgb24gVUZTKG1p
Y3JvbiBGUzE2NCkgZHVyaW5nIHN1c3BlbmQvcmVzdW1lDQo+IHRlc3QuDQo+ICAgV2UgY2hlY2sg
aG9zdCBpbnNlcnRzIGF1dG8gSDggZW50ZXIvZXhpdCBldmVudCBiZXR3ZWVuIFNTVSBzbGVlcA0K
PiBjb21tYW5kIGFuZCBIOCBlbnRlciBjb21tYW5kIGluIHJ1bnRpbWUgc3VzcGVuZCAuDQo+ICAg
QXNmb2xsb3dzOiBTU1UgU2xlZXAgY29tbWFuZCAtLT4gYXV0byBIOCBlbnRlciAtLT4gYXV0byBI
OCBleGl0IC0tPg0KPiBIOCBlbnRlciAtLT4gaWRsZSAybXMgLS0+IFZDQyBvZmYuDQo+ICAgSG93
ZXZlciBkZXZpY2UgQVFMIEZXIGNhbuKAmXQgZW50ZXIgTFBNIHdpdGhpbiAybXMgYWZ0ZXIgc2Vj
b25kIEg4IGVudGVyDQo+IGNvbW1hbmQuDQo+ICAgRlcgYWxyZWFkeSBlbnRlciBMUE0gYWZ0ZXIg
cmVjZWl2ZSBhdXRvIEg4IGVudGVyIGNvbW1hbmQgLCBOZXh0IGF1dG8NCj4gSDggZXhpdCBjb21t
YW5kIHdpbGwgdHJpZ2dlciBGVyBleGl0IGZyb20gTFBNLCBpdCBuZWVkIHRha2Ugb3ZlciAxMG1z
LCBhbmQNCj4gRlcgY2Fu4oCZdCBlbnRlcg0KPiAgIExQTSBhZ2FpbiBhZnRlciBzZWNvbmQgSDgg
ZW50ZXIgY29tbWFuZCB1bnRpbCBkZXZpY2UgY29tcGxldGUgZXhpdCBmcm9tDQo+IExQTS4gU28g
ZGlzYWJsZSBhdXRvIGg4IGJlZm9yZSBzc3UgaXMgYSByZWFzb25hYmxlIHNvbHV0aW9uIHRvIHNv
bHZlIGl0Lg0KPiAgIEh5bml4IGFsc28gaGFzIHNpbWlsYXIgcmVxdWVzdC4NCklzIHRoaXMgc29t
ZXRoaW5nIGNvbW1vbiB0byBhbGwgcGxhdGZvcm1zPw0KSWYgbm90LCBhbmQgeW91IG5lZWQgeW91
ciBwbGF0Zm9ybSB0byBkaXNhYmxlIGg4IGJlZm9yZSBzc3UsDQpZb3UgY2FuIGltcGxlbWVudCBp
dCBpbiB5b3VyIG93biB2b3AgLSBzZWUgZS5nLg0KY29tbWl0IDk1NjFmNTg0NDJlNCAoc2NzaTog
dWZzOiBtZWRpYXRlazogU3VwcG9ydCB2b3BzIHByZSBzdXNwZW5kIHRvIGRpc2FibGUgYXV0by1o
aWJlcm44KQ0KDQpUaGFua3MsDQpBdnJpDQoNCj4gDQo+IEF2cmkgQWx0bWFuIDxBdnJpLkFsdG1h
bkB3ZGMuY29tPiDkuo4yMDIy5bm0MTDmnIgxMeaXpeWRqOS6jCAxNTowN+WGmemBk++8mg0KPiA+
DQo+ID4gPiBGcm9tOiBUZW4gR2FvIDx0ZW4uZ2FvQHVuaXNvYy5jb20+DQo+ID4gPg0KPiA+ID4g
RW5zdXJlIGF1dG8gaDggd2lsbCBub3QgaGl0IGRtZSBoOCxhbmQgdGhlcmUgd29uJ3QgYmUgdHdv
IGg4IGluIGENCj4gPiA+IHJvdyBhZnRlciBzc3UuDQo+ID4gSSBkb24ndCB0aGluayB0aGUgaHcg
c2hvdWxkIGRvIHRoYXQuDQo+ID4gQ2FuIHlvdSBwbGVhc2Ugc2hhcmUgb24gd2hpY2ggcGxhdGZv
cm0vaG9zdCBjb250cm9sbGVyIGRpZCB5b3Ugb2JzZXJ2ZQ0KPiB0aGlzPw0KPiA+DQo+ID4gVGhh
bmtzLA0KPiA+IEF2cmkNCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUZW4gR2FvIDx0ZW4u
Z2FvQHVuaXNvYy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3Vmcy9jb3JlL3Vmc2hj
ZC5jIHwgMTAgKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMg
Yi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+ID4gPiBpbmRleA0KPiA+ID4gYTIwMmQ3ZDUy
NDBkLi40MmY5MzY0OGQ3OTYgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3Vmcy9jb3JlL3Vm
c2hjZC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+ID4gPiBAQCAt
NDI1Niw2ICs0MjU2LDE0IEBAIHZvaWQgdWZzaGNkX2F1dG9faGliZXJuOF91cGRhdGUoc3RydWN0
DQo+ID4gPiB1ZnNfaGJhICpoYmEsIHUzMiBhaGl0KSAgfQ0KPiA+ID4gRVhQT1JUX1NZTUJPTF9H
UEwodWZzaGNkX2F1dG9faGliZXJuOF91cGRhdGUpOw0KPiA+ID4NCj4gPiA+ICt2b2lkIHVmc2hj
ZF9hdXRvX2hpYmVybjhfZGlzYWJsZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKSB7DQo+ID4gPiArICAg
ICAgIGlmICghdWZzaGNkX2lzX2F1dG9faGliZXJuOF9zdXBwb3J0ZWQoaGJhKSkNCj4gPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm47DQo+ID4gPiArDQo+ID4gPiArICAgICAgIHVmc2hjZF93cml0
ZWwoaGJhLCAwLCBSRUdfQVVUT19ISUJFUk5BVEVfSURMRV9USU1FUik7IH0NCj4gPiA+ICsNCj4g
PiA+ICB2b2lkIHVmc2hjZF9hdXRvX2hpYmVybjhfZW5hYmxlKHN0cnVjdCB1ZnNfaGJhICpoYmEp
ICB7DQo+ID4gPiAgICAgICAgIGlmICghdWZzaGNkX2lzX2F1dG9faGliZXJuOF9zdXBwb3J0ZWQo
aGJhKSkNCj4gPiA+IEBAIC05MDM2LDYgKzkwNDQsOCBAQCBzdGF0aWMgaW50IF9fdWZzaGNkX3ds
X3N1c3BlbmQoc3RydWN0IHVmc19oYmENCj4gPiA+ICpoYmEsIGVudW0gdWZzX3BtX29wIHBtX29w
KQ0KPiA+ID4gICAgICAgICBpZiAocmV0KQ0KPiA+ID4gICAgICAgICAgICAgICAgIGdvdG8gZW5h
YmxlX3NjYWxpbmc7DQo+ID4gPg0KPiA+ID4gKyAgICAgICB1ZnNoY2RfYXV0b19oaWJlcm44X2Rp
c2FibGUoaGJhKTsNCj4gPiA+ICsNCj4gPiA+ICAgICAgICAgaWYgKHJlcV9kZXZfcHdyX21vZGUg
IT0gaGJhLT5jdXJyX2Rldl9wd3JfbW9kZSkgew0KPiA+ID4gICAgICAgICAgICAgICAgIGlmIChw
bV9vcCAhPSBVRlNfUlVOVElNRV9QTSkNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIC8q
IGVuc3VyZSB0aGF0IGJrb3BzIGlzIGRpc2FibGVkICovDQo+ID4gPiAtLQ0KPiA+ID4gMi4xNy4x
DQo+ID4NCg==
