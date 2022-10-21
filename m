Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56813606E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJUDrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJUDrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:47:21 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140041.outbound.protection.outlook.com [40.107.14.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F161826E9;
        Thu, 20 Oct 2022 20:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDrHL65JbDm9W3IoNh3DKRIw2C47Kyf6yFjYDd/i8EiKL8EB+zKOG9NrWdcRfAornChUgsiWpw4/qYNY3fcP9P/kCCIVgGI+U1MYqyvm/GWC/0kiHkecZi4+gVSszSwIWUMkukH6ys+hbi0AhY4+92rkmhbF0VTH6U40KoMz598otC28PrwF9mbceFAavn1DJHY09UXurSiwSvH5z/y5Eb/0EMiUmYKTsMoHWL/jqHP09ufiH9Rtg3ulHnUI9Fwr+dNdNm+naaJe4mG51agBhAua+eeZs9EStRHq+/AEkkU64mRmQkyBEwq3tNb3JGDmezjn04GNqWG5/VbJ6r14/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sfd7nrs4Ow8fydp/8LOBL+3qUh1H1NHZVk/rAu1Gpp0=;
 b=fcocXtyjSb32TenEo8JbvERRnAX5MiK9gLkccGNnzHH5K+OxYGvnFx5I/NWpP7PUJLxwLO8yh5f8ugsyr79FtYAaHZZ8bttZKW/8d8bwaW2SU68ec5/BkIGM5TRs7UYm+gVtlkSXmkq0itAiJzuZIVrDWz9aDiZpRQCmieNgv91SL7z1RULW9FV5HVq0sEqdFRbuSaczwo6XMObljTx9IuRxf5H6/k9p4g4Fk/FxXEs8eKsS1cCH1ZcfDbdbo2NQW/mkouOs/2irrh5Q7CBiAUBLi1+MLmfI66Tg72ZM2h6k0Nap9kmojOOMQnrz7Nf2M92h+ZAvIXGY5eaUpEUjpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sfd7nrs4Ow8fydp/8LOBL+3qUh1H1NHZVk/rAu1Gpp0=;
 b=IsueXZoQsma5NNUH3ol0JvolzXB+a8SQpuBchKSsgxVX5gtTjYY+QqQ674qBZ+3iaJHb0v3BB214Jd1/bop3iXjlYoJIRn9mOH4CkkVXxGOx5yrBEuqLQF/JpZmBkvfYlw6prmqk0e6xn+QesOwq0u9mWP4BB8TwiS1XxlGBmog=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM9PR04MB8876.eurprd04.prod.outlook.com (2603:10a6:20b:40b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 03:47:17 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::6110:8304:5648:88f5%10]) with mapi id 15.20.5723.035; Fri, 21 Oct
 2022 03:47:17 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Peter Chen <hzpeterchen@gmail.com>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CADENCE USBSSP DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/1] usb: cdns3: host: fix endless superspeed
 hub port reset
Thread-Topic: [EXT] Re: [PATCH 1/1] usb: cdns3: host: fix endless superspeed
 hub port reset
Thread-Index: AQHY4858OO+vgAgYIkenQDs6zc2vEK4YF70AgAAf6iA=
Date:   Fri, 21 Oct 2022 03:47:17 +0000
Message-ID: <HE1PR0401MB233171832F9042A4A8B4386F882D9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221019152117.1234968-1-Frank.Li@nxp.com>
 <CAL411-pHPiPeY0QTiMUwrGes+K9tQpq0OwVOnCHHkg7Aq2zy4g@mail.gmail.com>
In-Reply-To: <CAL411-pHPiPeY0QTiMUwrGes+K9tQpq0OwVOnCHHkg7Aq2zy4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AM9PR04MB8876:EE_
x-ms-office365-filtering-correlation-id: e6216a07-e8fc-473b-76be-08dab316f2fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g4YiAjV6kpmP4zQvHQE7eJZNR7TJDj7+1QrZdFtpQr3LbSNIMM49Iyr02KsrQnhjO7f1/ZgEjX386ik3cotgqT1wIfw7LGJTUHVXg1D5zw3nJZ59g/ouFqbfaEJp3/v+DN8LzDguhBFXpMMIVGyrD6dh/BEagqSwhVOgqbF50nIlmcBWiHCjtPM+8lVSk0HYrjY8K8WyjTSebXTgHITGmb1sa9BoffpW77ELfmXdrFgMsUyoyqzwcTvCVlwM8AGwnK3IViXt3ljDy19ki4EeQ/ASn1NZ4AcScP1tsuKuHVGYCQLlqtMmClfYMdl/jw2H74gV6AVHIMyJUtJNHaFFLGL5jtXZ+3MWxUS68ve5PvFo0B6fnwUjB0BSxPYvYMGvYmWRTycRlv1/dRIOaI10LB/a2emOjMefAyF8GewZCZs8LA+0mg2jhR6ozLYHWQuXZ6hoHodLMI+49xYNMPtIifh2n00UfekZu0q8mpEiR+S/38/wz2LA0qMzqMLBcxvrOh2ta6QoBLxckR25uGYIiZfa6shLkxvkOip49pfNTzQHkiLm7tSxoQqjJ/y2ggYDsLRzLcPoWbx8jCxxAp8E0SDZ437tG9Jckq4VyFMI4AhBiJndlCpUB4LMyEAKsZJGqv4NmPY0hOxO3BotbIrzP8lGIYfKhdsso8K+aXWw2v62cqwqGrcwjhlK2w5BYbfeyKgwgvS82nt570B4pfzWNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(186003)(38100700002)(33656002)(2906002)(71200400001)(38070700005)(84970400001)(122000001)(478600001)(54906003)(66476007)(66556008)(64756008)(8676002)(66946007)(66446008)(44832011)(86362001)(76116006)(6916009)(52536014)(8936002)(55016003)(9686003)(316002)(4326008)(53546011)(55236004)(6506007)(26005)(41300700001)(7696005)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFhVb2lKdUdycjMyV1N4a25QQkVtRGF4QlhtYnB6Z1lLdHE2b3lyVE1PelpU?=
 =?utf-8?B?L0t3b2pGUGNDR3NkWURNdHhEc1YwbnVsdFdqRHk0RUZpejNRUVF5TTF3TGh0?=
 =?utf-8?B?bUYwWnh2U3FlZG95b0d5S2NFdXB3R3VYWlVEc0pCQWtKanBXbFArd3NicEta?=
 =?utf-8?B?ME9vaS9HUTlWWTQrclpmMmxqVzRPWngxL3hXeEJMRnVQT0dpNG1BSGcvQzJQ?=
 =?utf-8?B?MUovVURqcXc1cjQzbEpYSTVIZ0lGTXZhQUJDalpRS1BBZVdyNE5NMGY3dXE1?=
 =?utf-8?B?VUtGc3EvMTU5OGtpQXZQSHdERUc2bmhld1l2d0F1VUtGb1RhemwxS1ZYZVo1?=
 =?utf-8?B?ckdmS1UxVTd6eUJQNWlreWpqVk9xODNDU2xnS3NGOVd4R0k0TENFSlZIaTNt?=
 =?utf-8?B?MEI5RmkxMWEzYlJjbnI5MzcrM0NDQ3RJSWhwbXVjZEY2cktBaVlxU2E5NWVN?=
 =?utf-8?B?YStBd0NUc2pjMFkzYjBJR3RZMVlSdG1DeXRlcGpNdXR5aEFjNkhESXBMcExF?=
 =?utf-8?B?QWJMYSt0VWtYdEFlZUtjNGhkdE9QVThBeitRZW5JeThzbEJibWJ2MGFjSThY?=
 =?utf-8?B?YWI1Uzc4RVI3V1QvMC9IVmN1RFM5dzVESTJGa1Z4bDBjdklwemx2K2RSTDBX?=
 =?utf-8?B?RnlnTUxUZXUyQXBHM1B5V2JmNzRjUmM5NVJ0MmQ5UFgyRFRaa0FycWJaV1RK?=
 =?utf-8?B?TWZ5bmd6amZ6bFpUMG11NTVXYU1TN3NZbjJLdW9lcW9NajN4WmU0OUFsZkVZ?=
 =?utf-8?B?VUh6cHZ1eVpwQ1VqWFFqUzhwMVNjTTV0MEczSlJUQXBOZUFkN1ZwZmpLbWNG?=
 =?utf-8?B?MFI5R2V0Wk9XTm5HaHNrTGkxU0JMK3ZhQi9TeUJMaVBvT0xYUnd5V0FKL1V0?=
 =?utf-8?B?QmswalMyN0dTN3dyMXNtaEMrelAzRUF2M0lxL0REazVjRytQNTEzY2t0bkN0?=
 =?utf-8?B?SlNTcFE4dXFzYy9QT3pTVTBOcnFoL2xmcllNOEdTVVdmYThRdHRFdlBlK2FD?=
 =?utf-8?B?bkg5dVVLbE1ZdWp2OFdQblhocVpWSzBubGRzYW1RZTNyZXl6M2dPeFlyc3h1?=
 =?utf-8?B?NWxXc21NYk1sU2xmRUprOUl4RkEvTURwa1owSXd1UE5qR211d1BHR0hhYUZp?=
 =?utf-8?B?ZFV2LzJKWkhleVlUYkZ3dnd5VDZyb1lwSm5tQk9pSk1kWkMveFdyNloxcHUv?=
 =?utf-8?B?a1ZxNjZuZ2RlSVkyc0RPVlR3TmZpMTNzS2Rzc2tiQVJpbWNqZjFSdTJGeEdp?=
 =?utf-8?B?dXZFRTRpNThIVmxrcS90VitGVDFRalRCdmtHQzFOcTEyaE13Y0d6Zk50ZmRY?=
 =?utf-8?B?bDdzL0szNmpRcUwydnpYdTdSYTVjRVBaSEI2ekR6RVkxU2NUTU1GaDB2T055?=
 =?utf-8?B?V1dXa00waisxT2N1U2twcVJCaUtuRzc3RUFaeHRXN1pPMWtXeVQrOWxhQm9h?=
 =?utf-8?B?c2plOE5kMFhpcVY3M0hnQ2hYYTJGRUR6WTR3N1ZKUVo5OStGYTNpTnFJb0V4?=
 =?utf-8?B?Y0ZYQzNiUDB2SHB6bEhBMkxvanAyZktiVVV5bHRiYW1lcFZIbXdvYVdMMFZk?=
 =?utf-8?B?eUdaS0kycjJUR0ZIVEpDdm8rVTVDbkpjK0trRVd3czZvVkdNN2N2VUF1d1JB?=
 =?utf-8?B?aGdIZVhwSEtmM0hJeThDN2lSdC9Oc3NYZEd1Y3ZXbE9HWG5ja01JOEo3eFNE?=
 =?utf-8?B?anhzZExET1BMYmpnbVQzRUVyVWIvV01GSzlyb1cvQUIzMkx2RWpMZ2trMmsv?=
 =?utf-8?B?UkVOcFNrQjVSSU43RG1pYUNVK3RQS2E4ei9wUVZwMmt4bnR4eTJWbGwxV1Mz?=
 =?utf-8?B?a1FxZ3pXVXdBdzZqcS9FUHN2RWNXTFIzREVESHJUODZjRTdoSVh2VkJFd1hN?=
 =?utf-8?B?em41bmxJVE9HbDZxWmtacmVPTnJTOEhqaTVHa1lsNWpKL1VPY2lsL01wN3kr?=
 =?utf-8?B?L3dUemRIQjlRQWkzREo4VVFINWppMng4UkROQWpCZWUxV3ZyZmJWTHBiVlpp?=
 =?utf-8?B?Mi91czl2MVlJRVRXRWtRRGhsTG44dWVISmc0Q1VFdERBdVpGVW43T0VWRWpr?=
 =?utf-8?B?VjVzSGs4RGpodG9URFAwQVZBZC9NWk5Ha2E2aStKUHNSbm9HU25RY1IwbEVl?=
 =?utf-8?Q?1aZ71F5BYkhDlwsykLj4AHVc6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6216a07-e8fc-473b-76be-08dab316f2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 03:47:17.3408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIGseJKyzQEaZcZm6+uP9BWPap7aJx7L1RPdt22GazGCyFsQwkZ8YujU2lFSAkdUU0/KoQQ3bok3G1Jxasx8xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgQ2hlbiA8aHpw
ZXRlcmNoZW5AZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAyMCwgMjAyMiA4
OjUyIFBNDQo+IFRvOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gQ2M6IGlteEBsaXN0
cy5saW51eC5kZXY7IFBhd2VsIExhc3pjemFrIDxwYXdlbGxAY2FkZW5jZS5jb20+OyBQZXRlciBD
aGVuDQo+IDxwZXRlci5jaGVuQGtlcm5lbC5vcmc+OyBSb2dlciBRdWFkcm9zIDxyb2dlcnFAa2Vy
bmVsLm9yZz47IEFzd2F0aA0KPiBHb3ZpbmRyYWp1IDxhLWdvdmluZHJhanVAdGkuY29tPjsgR3Jl
ZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IG9wZW4gbGlz
dDpDQURFTkNFIFVTQlNTUCBEUkQgSVAgRFJJVkVSDQo+IDxsaW51eC11c2JAdmdlci5rZXJuZWwu
b3JnPjsgb3BlbiBsaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsNCj4gc3RhYmxl
QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCAxLzFdIHVzYjogY2RuczM6
IGhvc3Q6IGZpeCBlbmRsZXNzIHN1cGVyc3BlZWQgaHViDQo+IHBvcnQgcmVzZXQNCj4gDQo+IENh
dXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gV2VkLCBPY3QgMTksIDIwMjIgYXQgMTE6MjEgUE0g
RnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogTGkgSnVu
IDxqdW4ubGlAbnhwLmNvbT4NCj4gPg0KPiA+IFdoZW4gdXNiIDMuMCBodWIgY29ubmVjdCB3aXRo
IG9uZSBVU0IgMi4wIGRldmljZSBhbmQgTk8gVVNCIDMuMCBkZXZpY2UsDQo+ID4gc29tZSB1c2Ig
aHViIHJlcG9ydHMgZW5kbGVzcyBwb3J0IHJlc2V0IG1lc3NhZ2UuDQo+ID4NCj4gPiBbICAxOTAu
MzI0MTY5XSB1c2IgMi0xOiBuZXcgU3VwZXJTcGVlZCBVU0IgZGV2aWNlIG51bWJlciA4OCB1c2lu
ZyB4aGNpLQ0KPiBoY2QNCj4gPiBbICAxOTAuMzUyODM0XSBodWIgMi0xOjEuMDogVVNCIGh1YiBm
b3VuZA0KPiA+IFsgIDE5MC4zNTY5OTVdIGh1YiAyLTE6MS4wOiA0IHBvcnRzIGRldGVjdGVkDQo+
ID4gWyAgMTkwLjcwMDA1Nl0gdXNiIDItMTogVVNCIGRpc2Nvbm5lY3QsIGRldmljZSBudW1iZXIg
ODgNCj4gPiBbICAxOTIuNDcyMTM5XSB1c2IgMi0xOiBuZXcgU3VwZXJTcGVlZCBVU0IgZGV2aWNl
IG51bWJlciA4OSB1c2luZyB4aGNpLQ0KPiBoY2QNCj4gPiBbICAxOTIuNTAwODIwXSBodWIgMi0x
OjEuMDogVVNCIGh1YiBmb3VuZA0KPiA+IFsgIDE5Mi41MDQ5NzddIGh1YiAyLTE6MS4wOiA0IHBv
cnRzIGRldGVjdGVkDQo+ID4gWyAgMTkyLjg1MjA2Nl0gdXNiIDItMTogVVNCIGRpc2Nvbm5lY3Qs
IGRldmljZSBudW1iZXIgODkNCj4gPg0KPiA+IFRoZSByZWFzb24gaXMgdGhlIHJ1bnRpbWUgcG0g
c3RhdGUgb2YgVVNCMi4wIHBvcnQgaXMgYWN0aXZlIGFuZA0KPiA+IFVTQiAzLjAgcG9ydCBpcyBz
dXNwZW5kLCBzbyBwYXJlbnQgZGV2aWNlIGlzIGFjdGl2ZSBzdGF0ZS4NCj4gPg0KPiA+ICBjYXQg
L3N5cy9idXMvcGxhdGZvcm0vZGV2aWNlcy81YjExMDAwMC51c2IvNWIxMzAwMDAudXNiL3hoY2kt
DQo+IGhjZC4xLmF1dG8vdXNiMi9wb3dlci9ydW50aW1lX3N0YXR1cw0KPiA+DQo+ID4gIHN1c3Bl
bmRlZA0KPiA+DQo+ID4gIGNhdCAvc3lzL2J1cy9wbGF0Zm9ybS9kZXZpY2VzLzViMTEwMDAwLnVz
Yi81YjEzMDAwMC51c2IveGhjaS0NCj4gaGNkLjEuYXV0by91c2IxL3Bvd2VyL3J1bnRpbWVfc3Rh
dHVzDQo+ID4NCj4gPiAgYWN0aXZlDQo+ID4NCj4gPiAgY2F0IC9zeXMvYnVzL3BsYXRmb3JtL2Rl
dmljZXMvNWIxMTAwMDAudXNiLzViMTMwMDAwLnVzYi94aGNpLQ0KPiBoY2QuMS5hdXRvL3Bvd2Vy
L3J1bnRpbWVfc3RhdHVzDQo+ID4NCj4gPiAgYWN0aXZlDQo+ID4NCj4gPiAgY2F0DQo+IC9zeXMv
YnVzL3BsYXRmb3JtL2RldmljZXMvNWIxMTAwMDAudXNiLzViMTMwMDAwLnVzYi9wb3dlci9ydW50
aW1lX3N0DQo+IGF0dXMNCj4gPg0KPiA+ICBhY3RpdmUNCj4gPg0KPiA+IFNvIHhoY2lfY2RuczNf
c3VzcGVuZF9xdWlyaygpIGhhdmUgbm90IGNhbGxlZC4gVTMgY29uZmlndXJlIGlzIG5vdCBhcHBs
aWVkLg0KPiA+DQo+ID4gbW92ZSBVMyBjb25maWd1cmUgaW50byBob3N0IHN0YXJ0DQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBMaSBKdW4gPGp1bi5saUBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Vz
Yi9jZG5zMy9ob3N0LmMgfCA1OCArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9jZG5zMy9ob3N0LmMgYi9kcml2
ZXJzL3VzYi9jZG5zMy9ob3N0LmMNCj4gPiBpbmRleCA5NjQzYjkwNWUyZDguLjkwOTJiNmY0ZDdj
NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9jZG5zMy9ob3N0LmMNCj4gPiArKysgYi9k
cml2ZXJzL3VzYi9jZG5zMy9ob3N0LmMNCj4gPiBAQCAtMjQsMTEgKzI0LDQxIEBADQo+ID4gICNk
ZWZpbmUgQ0ZHX1JYREVUX1AzX0VOICAgICAgICAgICAgICAgIEJJVCgxNSkNCj4gPiAgI2RlZmlu
ZSBMUE1fMl9TVEJfU1dJVENIX0VOICAgIEJJVCgyNSkNCj4gPg0KPiA+IC1zdGF0aWMgaW50IHho
Y2lfY2RuczNfc3VzcGVuZF9xdWlyayhzdHJ1Y3QgdXNiX2hjZCAqaGNkKTsNCj4gPiArc3RhdGlj
IHZvaWQgeGhjaV9jZG5zM19wbGF0X3N0YXJ0KHN0cnVjdCB1c2JfaGNkICpoY2QpDQo+ID4gK3sN
Cj4gPiArICAgICAgIHN0cnVjdCB4aGNpX2hjZCAqeGhjaSA9IGhjZF90b194aGNpKGhjZCk7DQo+
ID4gKyAgICAgICB1MzIgdmFsdWU7DQo+ID4gKw0KPiA+ICsgICAgICAgLyogc2V0IHVzYmNtZC5F
VTNTICovDQo+ID4gKyAgICAgICB2YWx1ZSA9IHJlYWRsKCZ4aGNpLT5vcF9yZWdzLT5jb21tYW5k
KTsNCj4gPiArICAgICAgIHZhbHVlIHw9IENNRF9QTV9JTkRFWDsNCj4gPiArICAgICAgIHdyaXRl
bCh2YWx1ZSwgJnhoY2ktPm9wX3JlZ3MtPmNvbW1hbmQpOw0KPiA+ICsNCj4gPiArICAgICAgIGlm
IChoY2QtPnJlZ3MpIHsNCj4gPiArICAgICAgICAgICAgICAgdmFsdWUgPSByZWFkbChoY2QtPnJl
Z3MgKyBYRUNQX0FVWF9DVFJMX1JFRzEpOw0KPiA+ICsgICAgICAgICAgICAgICB2YWx1ZSB8PSBD
RkdfUlhERVRfUDNfRU47DQo+ID4gKyAgICAgICAgICAgICAgIHdyaXRlbCh2YWx1ZSwgaGNkLT5y
ZWdzICsgWEVDUF9BVVhfQ1RSTF9SRUcxKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHZh
bHVlID0gcmVhZGwoaGNkLT5yZWdzICsgWEVDUF9QT1JUX0NBUF9SRUcpOw0KPiA+ICsgICAgICAg
ICAgICAgICB2YWx1ZSB8PSBMUE1fMl9TVEJfU1dJVENIX0VOOw0KPiA+ICsgICAgICAgICAgICAg
ICB3cml0ZWwodmFsdWUsIGhjZC0+cmVncyArIFhFQ1BfUE9SVF9DQVBfUkVHKTsNCj4gPiArICAg
ICAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCB4aGNpX2NkbnMzX3N1c3BlbmRf
cXVpcmsoc3RydWN0IHVzYl9oY2QgKmhjZCkNCj4gPiArew0KPiA+ICsgICAgICAgaWYgKHBtX3J1
bnRpbWVfc3RhdHVzX3N1c3BlbmRlZChoY2QtPnNlbGYuY29udHJvbGxlcikpDQo+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiArICAgICAgIHhoY2lfY2RuczNfcGxhdF9z
dGFydChoY2QpOw0KPiA+ICsNCj4gDQo+IFdoeSBkb2VzIGl0IG5lZWQgdG8gY2FsbCBhZ2FpbiBh
dCBzdXNwZW5kPw0KDQpbRnJhbmsgTGldIFBvd2VyIG1heSBsb3N0IGF0IHN1c3BlbmQuIA0KDQo+
IA0KPiBQZXRlcg0KPiANCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4NCj4gPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCB4aGNpX3BsYXRfcHJpdiB4aGNpX3BsYXRfY2RuczNfeGhjaSA9
IHsNCj4gPiAgICAgICAgIC5xdWlya3MgPSBYSENJX1NLSVBfUEhZX0lOSVQgfCBYSENJX0FWT0lE
X0JFSSwNCj4gPiAgICAgICAgIC5zdXNwZW5kX3F1aXJrID0geGhjaV9jZG5zM19zdXNwZW5kX3F1
aXJrLA0KPiA+ICsgICAgICAgLnBsYXRfc3RhcnQgPSB4aGNpX2NkbnMzX3BsYXRfc3RhcnQsDQo+
ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGludCBfX2NkbnNfaG9zdF9pbml0KHN0cnVjdCBjZG5z
ICpjZG5zKQ0KPiA+IEBAIC05MCwzMiArMTIwLDYgQEAgc3RhdGljIGludCBfX2NkbnNfaG9zdF9p
bml0KHN0cnVjdCBjZG5zICpjZG5zKQ0KPiA+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0K
PiA+DQo+ID4gLXN0YXRpYyBpbnQgeGhjaV9jZG5zM19zdXNwZW5kX3F1aXJrKHN0cnVjdCB1c2Jf
aGNkICpoY2QpDQo+ID4gLXsNCj4gPiAtICAgICAgIHN0cnVjdCB4aGNpX2hjZCAqeGhjaSA9IGhj
ZF90b194aGNpKGhjZCk7DQo+ID4gLSAgICAgICB1MzIgdmFsdWU7DQo+ID4gLQ0KPiA+IC0gICAg
ICAgaWYgKHBtX3J1bnRpbWVfc3RhdHVzX3N1c3BlbmRlZChoY2QtPnNlbGYuY29udHJvbGxlcikp
DQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+IC0NCj4gPiAtICAgICAgIC8qIHNl
dCB1c2JjbWQuRVUzUyAqLw0KPiA+IC0gICAgICAgdmFsdWUgPSByZWFkbCgmeGhjaS0+b3BfcmVn
cy0+Y29tbWFuZCk7DQo+ID4gLSAgICAgICB2YWx1ZSB8PSBDTURfUE1fSU5ERVg7DQo+ID4gLSAg
ICAgICB3cml0ZWwodmFsdWUsICZ4aGNpLT5vcF9yZWdzLT5jb21tYW5kKTsNCj4gPiAtDQo+ID4g
LSAgICAgICBpZiAoaGNkLT5yZWdzKSB7DQo+ID4gLSAgICAgICAgICAgICAgIHZhbHVlID0gcmVh
ZGwoaGNkLT5yZWdzICsgWEVDUF9BVVhfQ1RSTF9SRUcxKTsNCj4gPiAtICAgICAgICAgICAgICAg
dmFsdWUgfD0gQ0ZHX1JYREVUX1AzX0VOOw0KPiA+IC0gICAgICAgICAgICAgICB3cml0ZWwodmFs
dWUsIGhjZC0+cmVncyArIFhFQ1BfQVVYX0NUUkxfUkVHMSk7DQo+ID4gLQ0KPiA+IC0gICAgICAg
ICAgICAgICB2YWx1ZSA9IHJlYWRsKGhjZC0+cmVncyArIFhFQ1BfUE9SVF9DQVBfUkVHKTsNCj4g
PiAtICAgICAgICAgICAgICAgdmFsdWUgfD0gTFBNXzJfU1RCX1NXSVRDSF9FTjsNCj4gPiAtICAg
ICAgICAgICAgICAgd3JpdGVsKHZhbHVlLCBoY2QtPnJlZ3MgKyBYRUNQX1BPUlRfQ0FQX1JFRyk7
DQo+ID4gLSAgICAgICB9DQo+ID4gLQ0KPiA+IC0gICAgICAgcmV0dXJuIDA7DQo+ID4gLX0NCj4g
PiAtDQo+ID4gIHN0YXRpYyB2b2lkIGNkbnNfaG9zdF9leGl0KHN0cnVjdCBjZG5zICpjZG5zKQ0K
PiA+ICB7DQo+ID4gICAgICAgICBrZnJlZShjZG5zLT54aGNpX3BsYXRfZGF0YSk7DQo+ID4gLS0N
Cj4gPiAyLjM0LjENCj4gPg0K
