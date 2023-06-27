Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1573FB05
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjF0LWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0LWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:22:40 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0587926AF;
        Tue, 27 Jun 2023 04:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687864959; x=1719400959;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S9pgwjc9+aT2TkZgXIS3qBbE88SLIMyC1fy07XsrkWI=;
  b=fLjLCF1aXNzNX7tTK86KBZEhpUWAF8Ai9j1iRU2QZfkuCg89PmBONPOL
   dcRTMlG2cR3zUMqm0PTGHhiBKYj8gPah/53o67F8a5hrc+aMF470Kro8d
   LzS9UjHVMqxVxA1pYQby5UvnrloJKuS4hnQTfHgGVxZ1eLKdS1AJfEg1/
   +e3D8DjesH/qumnE477bzN9/Vov4uLpFHaKVAp0+YCzjQaHa2bL0+C7a4
   xaPQLkqCdfQlCvpPk429PlyMC4eAc0sjcmK+HPeB1qs/SGqIXUKnPxNy0
   nh56Mk2rZx3W3RyFM2abO1rnNmK+L63WMF0skFCr6nee9CDUhUR4bSRVK
   w==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="348522879"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2023 19:22:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoFqBmM7l371La01z4oo7Hhn3F5HM3uBWAxZdgj4+hEM19B0i+3uOKoplCVYA9eZfzwqdJj/HbR2zAJsJTXc4kgn5gBY1AQ8RI2O5FHCkEIZ36bJU0UQq5jd6DHnnfhFT5qs4/g6KHIC4WNmi+RwzlxbZfo6RdPCnvn6MIp4OtkGm8qQK/surtk+gDLe2LLoOGjOkPvhuupITekEW1ej5OomYmDKEp6hiGfIh6UEFkfuu4eA0CsgA925ZQFYcKnUMlpp/OBqLGpIEa8OocvWohaHYq+xTrOM0buEERF/FoP2Uip9xvpla0AGdcJWaYmmhY04KGXrNVQRAN+7WPpp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9pgwjc9+aT2TkZgXIS3qBbE88SLIMyC1fy07XsrkWI=;
 b=hrwAnPwdsI01Rn2S1AIHPrMjv691KlnCG2cwsKGaBhgEkoAgazAPr3RhoQ56wgf6d2Jo/V32VAyX/aKD27xb7LU2Y+2uH0X3SMmhFHKmhESn5GEX7sQ1MnFkEA+M/c/THqLnipwoA8lYanV+s3CEtY9nBBubHpunjsiITGUMy2Y/IiefnIP17DpJALqmNp3/o/qNFJfLr1+gc4fhhAeP4E2ChV9gvfZ77pJKJx6pvM8cgKpUSaiJzGMOKf7IeMAfkZ2VEFdFiAN7qwPN6G5CbfwYF3CXcSOmHCOVhfOwEaa14UefnEYylApEgOd4/riJK9vNvrykBJTJ2yOjYWDIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9pgwjc9+aT2TkZgXIS3qBbE88SLIMyC1fy07XsrkWI=;
 b=XCbaHJS7ppHNv25OmMFhM9IOvt8Ks0ak7XJxN4nsHXuNu8RPCq2TjAPQ+YakJWe3iL8r9ZZCMadNQUirHRMrxYlbOKWz6g71F4kyeHc19g9TsJ2WcHMHvhad+lfXy19DBiqbyQeZMxTWQRr5Cg3qlxsedEh4AhAUdexlV8jUZdU=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by PH0PR04MB7206.namprd04.prod.outlook.com (2603:10b6:510:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 11:22:36 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::23d8:739:4578:cbc7]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::23d8:739:4578:cbc7%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 11:22:36 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: RE: [RESEND v2] ufs: core: Add support for qTimestamp attribute
Thread-Topic: [RESEND v2] ufs: core: Add support for qTimestamp attribute
Thread-Index: AQHZqBmraa5SJIbjX0SShq6Lycf7Lq+dBZUAgAFvU2A=
Date:   Tue, 27 Jun 2023 11:22:36 +0000
Message-ID: <BY5PR04MB63275EC6110218B5F409AC59ED27A@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <20230626103320.8737-1-arthur.simchaev@wdc.com>
 <2d034edbe84092fa4030fa2bf366d4b58c4b9405.camel@gmail.com>
In-Reply-To: <2d034edbe84092fa4030fa2bf366d4b58c4b9405.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|PH0PR04MB7206:EE_
x-ms-office365-filtering-correlation-id: 9361dc3a-6c1d-448c-cad1-08db7700cf0c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uoN2yrvsq0qifeZ75ZtaKuG/yGzZvHAAdgZgUtxRFcFJOYU7NwStpkVVw/pgpyAg51VoYLe0WXpIgGnGr9jJ8kBn+l03fTJE0wydM7QUvqgT8maTTWtIwmr+6BpRx1TM+N00QssE/OBw16120BUh4C2F7omHxV54wRsNKY0v9Ft3Iu1GHBG3pLWlYz8/4w+DPmFiMoNfssYzNWnMKuu6cNbi3zjQEoBt5Acc9P+5Ry3JyUIF3A2c278fXtHGcvJtbrakKeL2hac8SaOEE8KwP7WMGgmxoVW6WlQwwn0ZHgsm+HARMfwSCnUWvHY3FEw9fBn42zF4eaC6ba3jhRvuOb3LhthDg0SULw2YNCFApWYhl6o2TTMQpgQK+tG0Z0GcMyOSwIp9Zo+FSEZybrYSfRklnVhnQeYPT/GY/O4zySFCjFvYPGtEJymWomcpTM0Ny5KUu+l1iyaCeyUrVeLtwY5LkDuzKVhBFMyNqPRebPS1mNl1IjNAhuHVgBU6WKUD9yJ4Ek2+L7RnKggHeUgsH6BzzbvfpeXNGG0KDVnv3ncrM4jwqjWVDV6NQFEtBWqOmSdvFbOkeXVQC2Rhm1vTjG4zILxeazRNE1PG/kRdzTIYr2fOZhDt70WNJ8q8tIonxM84FSLlUdbKJgJzLFx+ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(52536014)(478600001)(966005)(110136005)(26005)(7696005)(54906003)(9686003)(71200400001)(2906002)(186003)(6506007)(4744005)(41300700001)(86362001)(33656002)(38100700002)(5660300002)(66946007)(122000001)(66556008)(316002)(4326008)(82960400001)(55016003)(76116006)(64756008)(8936002)(66476007)(8676002)(38070700005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTYvOUhXUHR5NVpDUzVHOXVFTlpRVm1SU1NoT0JPdzBwUk1WVnA3cnZjYTNG?=
 =?utf-8?B?SzJKdERSQjhERUcyc3ZrcHkvb3BHeUJUM2tYQ3pLdUs3NG5vTzF2VlczMThr?=
 =?utf-8?B?T3gvbDQwVDU1TGEreTEycWs2QlRSVXg4clVJNEZVOUNKZXNFaVM0Z2xMN0Qx?=
 =?utf-8?B?QWNGbnhjVVkxRWdpOHBkblhBT2ZRSmdiUWp4SjRGaytaRys2SFhNdFhka3Br?=
 =?utf-8?B?ZGtZanI1bFd0TGkyNXZOWWNFVVJqRmRPM1Z3R0hIbmk4V3lERjhlVXlOZm96?=
 =?utf-8?B?c3dvL0paaVdKNTVLNWEwU3ZHaE1LcnpxeVl3aG1kWUQybFc3VENBTUFPa25W?=
 =?utf-8?B?ME5EeGFhdEdGWjFMMHdQWDBidDRxVnkyWWZ2SDBYTE5uclZReVRqNkdXYUtz?=
 =?utf-8?B?eExzZVBrUGNRT1RWaThYS0ppdTdvTmRIb25MRlJaaktJVkNzRzRhNWtrazM5?=
 =?utf-8?B?Vkh0b1NoV1d6cWNWWDVVc05FWTViZDIxcFRkdFZQZWpWTGcydFFvN3A3MVBi?=
 =?utf-8?B?a2NWcXdkVFY1L0hxR3lDYVZKSk51b2luc3FhUzZsb2tyaTFOS3hoaDBIaVJx?=
 =?utf-8?B?VHREczBVTVRiR0xNQlRFdjBrbmgwOWkwdXVFS2kyYyt6d0p5RTJFdmcva2dQ?=
 =?utf-8?B?UzdGL3F2UFlPb2IvTjA5NURxZmdtOGY5bkEyL2QveS9YUFV6R25iYkVjZW1q?=
 =?utf-8?B?SGlWTXRnQ0ZhYy85K3dWcjIwa3dHTEZxWEZ6OXJCNVMyZUpzQ0g0V0N2Rjhu?=
 =?utf-8?B?S2tIeXl4OEg3NnBvZ1pBbCt1b2g0U0RldjZhTDNyRzVtRUxKOVJkUnVxeHpD?=
 =?utf-8?B?VGU1MU1TSmxIYzhPOC9Qb2VCNnlNQXV4d3FkOTFtZmYvemg5YmNVZVdQMmlH?=
 =?utf-8?B?N2d0b1RqaTk2dENVaTVZeEROWjU1YTRaOGlKM0RFeVpuU0dtVnJncGJtSEI5?=
 =?utf-8?B?S1VPejRQTVBsUjA0SFA2dXVOMFdkTzBJR0IrYUI1YUN0TkloTldPbG9WUS9E?=
 =?utf-8?B?Rmt3a0lMUUNSYlVCK0ovckNhUG9RN2U3cWlKMUJNSWpWUDdkVDZVc3d3aWdX?=
 =?utf-8?B?dmw5N2pWL2RMVGF4MVZFalVJK1UrVkk0eWRFRmFmSGQzSUFYbmV2eTAvK3Nk?=
 =?utf-8?B?d21qT001QXo0VjQzT1Z6TUxDNTUwWkYzTkdjSzRGUS90ek9YSUl0dllESzMw?=
 =?utf-8?B?NjhHcHJSNmtRRzVmWWZjR2lMWlp3bk0ySlk5L0dyNDFPUmNZbTJJZm5YcTdi?=
 =?utf-8?B?aUk4S3grNVFLMmIvTkRoVFRLZFU3a2dMbjVHQ3lUNWN6bmw2czZ3bHpjV1BY?=
 =?utf-8?B?bnZzSTNlL0h2Q0JlMkpUM0wzS3hWTXA5eGZSMzFlNkNGVWpjUi9pdmx3RGFi?=
 =?utf-8?B?NkozNXlReHdGTE9JZk5Sa2k1bGFxQ2QwY1paTEpXNnVuTU1hNTB3eWhSTTAx?=
 =?utf-8?B?cmZOZkl3d3BTdUt2dmE3Qm1rcVRJb2ZPejJhTjBvUzlzamxBRG81VExscjhG?=
 =?utf-8?B?RmZoWi9kYVRUQmdtcWl4TVRodEJRM3B2bWZ1bWdFKzl3KzVjb2ZGYytnbngy?=
 =?utf-8?B?aHlHanl4YndLN2UxSVY2RncrTkM0NERrMVgxS1lYMk9JOGQ3Qm4xM2h5VjFs?=
 =?utf-8?B?UlVLUVJmZ0R6WUhDWE9mTi9YTUt4Rzl1cEc1UUF0SEF0bTZpbDE4YjlUS1Nr?=
 =?utf-8?B?S0RBR1FWUjdXUmJ4YjJPa3AyK3BsYXA4dkYxeXYrYU4zTkNhK3F2QkNhOVdk?=
 =?utf-8?B?SVRZUVo2TTduakRYUGd5bWVicHFwMy9NdytFVHo2b1RBSWlTZ2pWYXBmOTVl?=
 =?utf-8?B?azBKSUtLR0lIYTExNzlBaUllV2h3QS9uWEEvQk85MEMvRWVUU2Z4REt3dVlz?=
 =?utf-8?B?UU1vZC9UZTN5T0VNcTBKbFRBNmwrYllMOEt5Sm5uVDVuZ05aN1dUM0F3WEZJ?=
 =?utf-8?B?SEY1OCszbjRQV2w3LzMvK0hCNHl4K0swVHBpd01aeXA2TlRMcHdoRlFhMEZN?=
 =?utf-8?B?dWVndnRoRDNjQ0xaNDBkbWVKMTdQazBHSENPdXRjZUNZY0x5alROMzduYTFR?=
 =?utf-8?B?N0hYQ0tLM1FOUXdsZGkwa01nSnVCT0s5allhUHcvYy9kcmxINHNkS0p5NWNo?=
 =?utf-8?Q?gt1lWTdmMKREv8BKFXNxQltLN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zo56CqWBL7U0nR+pJFeD+U/TBVjRux1JWt8kQAmi1jL4Jt8TMd0UtPZD9bvWiTY7w1CiZrghy7Pa3iFqr2hbEQQxHVHSUqoXAG/28ebSkBDeDjMztvpmVQeMwAjlUPbZcnMQEzdLu1FC9zVbETodjLUmE2HfXhixxkiRftGDjHXvlAM/KieDIXLtohuK7jiAXC+9AVojFYVHMKdDlMpam2siTImO4IwSFzhrfB/jEXb4+w6fEOCB2bfo6d85hKg6B1KKUwpcVQs1PqdBJ7SmKYzALtzb+JVMs3gBHK4NW/4JtADVHLTBwyHlPBZzvlYaI/FkJN9zl9nUpNquzboIRJA7rsEt9XpfGBN1yuK1wFzsqI5c9txK6Jj4LnIGy46RLk/IwuUcD1nveJ69RhC0ISsELj9aRv1SDxo82PqegmrkyukTctb1mq/ldAZQ2yocZji73Y6iXV8/s7Ntz6ZLMxaSMr+IWDF+xmDGkw4e+il69EHEog5XVzeI8JTT/GTC2aY5DvuddIM46CBkUCyl/OA71nf7Jbsv6pdx25t3uNo0RIU9I1emLpqbOJcJmbg4zjCH7Acu5vJvKbxn/L2ujrcW42SNBO6F9iwuJaHCq/AnoQaZNgcVTej767KGlBmJ3osE28Nj0i7aFsCp971zsygeoRTBa4yedDOLQm3+/aI3gETMIRhFF0kADeo+yGf/NxoLBQojZ4DU7EQKNAWotVPJkg3Gc7R6sNLXRR2zsFqScxm1jYSP9j3GkPcNjUyZ2iM8QNe9zX8o6yzQmK8wylI6F5QXOKdkEh7SeYGjKX61eVU03MjFP1nGrwmiNbCP0zmwcayZ/+j9MGWEN7g+X06MJsZI0yl4YTldL+QScNxZ+lpWxPDVDpzQxww/scifr0zJTKTDH1JLFC9Ee9i3DA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9361dc3a-6c1d-448c-cad1-08db7700cf0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 11:22:36.0141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjDYMxwLFl4mh3hF/BCFDqa8lmhIfm9VkTQPIfs4cDtzExoS4U6gvif0XMyHt3L57AtyzLdI4AGaOHmJz08GOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7206
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSGkgQXJ0aHVyLA0KPiBJbiBmYWN0LCB0aGlzIHN0cnVjdHVyZSBzaG91bGQgYmUgYSAi
VHJhbnNhY3Rpb24gU3BlY2lmaWMgRmllbGRzIiBpbg0KPiBRdWVyeSBVUElVIGZvciBhbGwgcXVl
cnkgZnVuY3Rpb25zLiBCeSBjb21wYXJpbmcgMy4xIGFuZCA0LjAsIHlvdSBjYW4NCj4gdXNlIGN1
cnJlbnQgdXRwX3VwaXVfcXVlcnl7fSwgYmVjYXVzZSB5b3Ugb25seSB3YW50IHRvIHBhc3MgNjRi
aXQgVFMuDQo+IE9yIHlvdSBjYW4gY2hhbmdlIHV0cF91cGl1X3F1ZXJ5KCkgdG8gbWFrZSBpdCBt
b3JlIHVuaWZvcm0gdG8gbWVldA0KPiB2YXJpb3VzIHF1ZXJ5IGZ1bmN0aW9ucy4NCj4NCkhpIEJl
YW4NCg0KQWN0dWFsbHksIGluIHRoZSBpbml0aWFsIHNldCBvZiBwYXRjaGVzIEkgY2hhbmdlZCB1
dHBfdXBpdV9xdWVyeSAsIHNpbmNlIHRoZSBzdHJ1Y3QgZGVmaW5lZCBpbmNvcnJlY3RseQ0KYW5k
IEkgd2FudCB0byBjaGFuZ2UgaXQgYWNjb3JkaW5nIHRvIHRoZSBzcGVjLCBidXQgYWNjb3JkaW5n
IHRvIEJhcnQncyBjb21tZW50LA0KdGhlIHN0cnVjdCBjYW5ub3QgYmUgY2hhbmdlZCBzaW5jZSB0
aGUgZGVmaW5pdGlvbiBpcyBpbiB1YXBpIC4gDQpTZWUgdGhlIGluaXRpYWwgcGF0Y2ggc2V0cyBp
biB0aGUgbGluayBiZWxvdzoNCg0KaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgt
c2NzaS9tc2cxODE5ODUuaHRtbA0KaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgt
c2NzaS9tc2cxODIxNzguaHRtbA0KaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgt
c2NzaS9tc2cxODE5ODcuaHRtbA0KDQpQbGVhc2UgbGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsu
DQoNClJlZ2FyZHMNCkFydGh1cg0KDQo=
