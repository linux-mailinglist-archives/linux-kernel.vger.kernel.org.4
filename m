Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6881570A792
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjETLgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 07:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjETLgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 07:36:42 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5C4E42;
        Sat, 20 May 2023 04:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAM/2+9KcgS9SwNSh+Fls26lcHjhzKh+Vh+oOtn0p4ioJex0Z4iq4jckh0bNMxjonS+zygP/kApAbCtsUBYgdZXMJFQtDXYUAHbOgi3/vODv7kDFY1n3SQC3XE9M6DUqLabm4BYIXW84MRz2tnecYW6q6KdVE60b6STyL7ZSTebjj/7m1PHCj/6BYWi3X+DzkLvKy6vl6RIf2z/J9TbkP9zcfnZbPkrP6b4oEhcdSC6s3GO5pbkbZr4buPDlPPmNBdoZJmha8cI+Vf/4DR8Lq2a6gmssbPTwjFBK7P8eaki2ki1tYC8gnTtPMSpL3ZqrscXgqnFfR6KVCuAaAlDumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f2KnBOaYcJsSLbtQOW+xYQDQmsnToiFn9fb8nG8XCU=;
 b=RBASGVgbphny5bOq7H9DYDZ7MyzfQuxjZlN69DyVpIdDaEeGZ9Vf+GV32ogZtbV6SROjQk7jgtSpzNwwRIR+b/bPrGPwDMQ3/LdjCVQn1NBjFHpgMWi5plFwhyZj16AAZvQdSMywKTk5pSXbGngMEej02UzODPSxea+f87JBxLSIERzuufGoCG0iyTlAZaxoWe44+PZEdDCKEhmT3kHu9JbNdJL2gCH7EhtnaMYGnxVHR+8bfisqmKJCaLIlnPfh0enPMFkN6k6xcMLRodLMuUZ79uWBwUZ54nGJ4jHQ3S/74UqlSDQWpbdhP5/IoFGjs4M5xUdqJ/K1yhr3mxpcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f2KnBOaYcJsSLbtQOW+xYQDQmsnToiFn9fb8nG8XCU=;
 b=hvCOlp1Uuy8K0fNLlNsmgh0GI26BIxbswGGbPmYuBDGz4FC2dv32PvK38Ge2PzIIWPYuFxeNyVIObQEojU+bx2eGmL6EPCJRMGxcP7M5ZVttxlqdMbONf5/0T+Imacx4S7MhPrKHub/i/hKqCQ55OK3RfyrKKwdqpMmAey3Pa0Y=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7446.eurprd04.prod.outlook.com (2603:10a6:10:1aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.25; Sat, 20 May
 2023 11:36:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6411.023; Sat, 20 May 2023
 11:36:37 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "aford@beaconembedded.com" <aford@beaconembedded.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
Thread-Topic: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
Thread-Index: AQHZgFRzR+O85HMlCEaA7Jlr0p7F7a9V+/eAgAw/AoCAAOLdQA==
Date:   Sat, 20 May 2023 11:36:37 +0000
Message-ID: <DU0PR04MB941711E347BD513ABF929EEF887D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230506195325.876871-1-aford173@gmail.com>
 <CAHCN7xLfh6Ttoi29d6Vn1Hw75GEA8hd-XGec08ofeC176thkPg@mail.gmail.com>
 <CAHCN7xKHHKQgjtzS+KSHE9w++_udRJ1PRVcse=rD6-tZGVGcdQ@mail.gmail.com>
In-Reply-To: <CAHCN7xKHHKQgjtzS+KSHE9w++_udRJ1PRVcse=rD6-tZGVGcdQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBAPR04MB7446:EE_
x-ms-office365-filtering-correlation-id: 8d144ea2-7159-448b-76a5-08db592678f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UBs2PtlmCyHEuD5Ro6QJPFdSaTJHBqZcHi0UxoRE3Vzs9vglnUf6CeBQ9ZTZEkydlgmQ0ljk+bPUQPxcVNjyaLla1EVPljeGCc+NOEYyZTGtfYpWxCAUTxoiXGX7TqsvBuSTsVENfe4fX91Rp/GvcsTWbhIHnuh9svLtyp4N1OBub8q6/LFLXG89vi74ZRNO/GZ5xMPveIwXyHUkZ/gdAXK+C3fq46gZDvwPujTDtomigke/1a7/WyZWvAIJMJQEwClloVmQOpg6e4K+RQX5u/w/mQd8mMTIVR72Bz6V+Avgpww2zXQXJ/yJ80t64pdvtmynxGKuiw4Tqx/P1dNoVzlbDUpKt4oQ9SNiv2b1g5lmcx43YSCc2D0bC8L1HjV9RcMmFC8BO42ptIuf373cDMbgcql4T2TVSg7WVkDB+MsVbx4NcuFpKfz8c+rxjevs1+kY//+QH7jMbGmsEBussEPdMS6zZydBhKXA6wCmMfml9aOk3cg6BkBMDC+09PJZYxdIatSAh51o4jJmCTR/7E568m8LKEoQTdN2BZOsmMQxjV6I/fEUFGrBEzFD3BocqpgORiHXYKv8wy/k660sZLofJuM9BqPteBoa8CjV/mvCG8W+a17aANHllv0e6RuB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39850400004)(396003)(136003)(346002)(451199021)(86362001)(38070700005)(33656002)(55016003)(2906002)(186003)(53546011)(83380400001)(316002)(71200400001)(66556008)(66946007)(66476007)(76116006)(66446008)(64756008)(4326008)(110136005)(54906003)(478600001)(5660300002)(52536014)(7416002)(8676002)(8936002)(6506007)(26005)(9686003)(44832011)(7696005)(41300700001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGF1YUFhSEJoaXVCanQzMnpIaGdvWHRwZzQzSHc2V0RCaGVEdG5JeDg3dVI2?=
 =?utf-8?B?TENlTzkxdHorZkQ0azNob1RVSkxIZVlMdllzR0hnY3NRWEpQZjJILzExQXJQ?=
 =?utf-8?B?aFhIMXhSd0FCaE1yU3NXb3QyeG1QTXFETDlKOGRDV2sxZTFGT3h5ZDQyQ1Qx?=
 =?utf-8?B?bEFDMFptbTV3Y1FJVUo4c0FCcTZvMlBWdjZBajFWbUdGTDdSL2dUQW8wQy9V?=
 =?utf-8?B?bVZZd093YnRQeEZUU2hGTmJjNy9wTFB1Ym90aHM2bXJjOXdReFlNQnIzZnlq?=
 =?utf-8?B?K3R2MjZaME5Yd0x3S0xhdWptUzdBYmlHK09OblhUczExREpNQngycmthdkZG?=
 =?utf-8?B?Ykk4THRKOVZSVWxQWHduSHRxeGhxTzduVmxvV0VZSFkzTjdYeWdqNTZaamJQ?=
 =?utf-8?B?d3VaQnlMaEljT0VRL1pNT3BLbWg1Vnh1YllrdlBpOGhxeGlud1ZRS2tnY3Nn?=
 =?utf-8?B?S005Um5BL2VYZnZuc3NiMW1CS3F6R0FQaUxRU2g0OU1mVEJTK2FRZGhLUWVh?=
 =?utf-8?B?WERBN3hkZFBKUWZMU3ZERnVsNUVUc0NJa3RjZUYwS05lWEZtY09RWEovaHo2?=
 =?utf-8?B?Ym5RcE9MTUZJSnRtRzRyVUhkUVhtT1BJZWI1OEpmaTVKWDBoZy9TTlZ5cGxm?=
 =?utf-8?B?YVM1VmRvTGVVbG9lYWkrZ0Vwa2JWeWNWeUdqalNBY3o0cmdNOC9ZRkx6WG9a?=
 =?utf-8?B?K0diTVlPZkd2bnpEdmNnQngwSXZYdjh5UzZGRzVscU8rejVpSWUzRkNWRVcy?=
 =?utf-8?B?MmhGT0o2TnBFK053MFRtckI1WWxnMjFQaHhsQkhab1pndHVqQ21KaGVsVVZG?=
 =?utf-8?B?UGN5NVpQUkVsK3FpaDhHUEt5Sk1ubFRFYzFDYnZrWHgxaktRSEtEcWJKYjRS?=
 =?utf-8?B?ZnpEb08rb3ovdWduVDl4N0s5anNNZ2dlb0E5RWtLZWZ2RjlBSVhDZWxoelFn?=
 =?utf-8?B?eVZXekc4VkMvMkllVTJXNzh0U0RmZk1oSEhYdElCbnhGWTBYdFdseU5aMEFq?=
 =?utf-8?B?S2dFUGczYmZTeFdOSmJlYzhMN0UvOGlWdjg3d2pGdkxTS05ocXRtVDE0NElv?=
 =?utf-8?B?UEszOUFSVkYzQjlHWFFFMUl1cldNdmxPMi9xNVlteDMrY3l5NjdCSnJ2d0NT?=
 =?utf-8?B?RFc1RXFLYXBZbmFRQW1JWU1sZDE5VG9heHJxVXlEVmpBVUhTWGNIYlE2NUl6?=
 =?utf-8?B?R0IrZzZiMm11T3pRZzhkc2EwNkpwZXkyd2M4OTRHUHhBbzdtOTdGS01nR2JB?=
 =?utf-8?B?c3dOQk5HWlArWUtFdmRjb2xlUHBnQy8wSngxU0pSbnJDMzNVMC8zS0FyZmdQ?=
 =?utf-8?B?VlN6ZE16bzM0MmlFL0RYZkZvWkVmcWJKWTBBVS9BamFDZzltY2dMVzFDc3hv?=
 =?utf-8?B?RWdUbkhOb3dqbG9IY2VMMWZrNGlZMUs0S0ZBaHF1NVY1WkExR3UxbzZ0MkZW?=
 =?utf-8?B?ZjNxNVBvUWtoTTREZEZNOFRNVDFiTEZPbk5GUDI1M0ZQWE05YkNBN1IyUE9w?=
 =?utf-8?B?MVZTN2wzNG50TTdBbWV5QkxQOVdiU1BPN3o5VnN3OGZCMGFyRERtNTU5UlBE?=
 =?utf-8?B?Z1FESi9sYThiUEE3eC9TM01QZVU0dG5UZG1pejV1b3Z0Wm85R1JROFBsL1JP?=
 =?utf-8?B?amtiRDBMYUNERVdYclpZTi9aTWlYYlVkWjJTOEZ1eTkyRm1pN1JrN3lNeWtl?=
 =?utf-8?B?MXhsZ05LSXRDcUR2VTVPdjNTRm02RVI0WW8rRGsvc3M4TFczZHZvZDBvblUz?=
 =?utf-8?B?ek1vbXdDcXYxT1grQTBxWCtvcDd4QmN4VFRmclh5TlRKbU5SK2x3TFNKdFkw?=
 =?utf-8?B?TUI2K0ZzWHJVNnZ0OTNiTEM2ZDliNDVscElZOC9Bdkg0cUZjWDhkU3FxeldM?=
 =?utf-8?B?Rzd5ZTF6cU96Si9rQXIyTXhGL0dVekY1bmh5UWZEeG1GSkc5azgwK04rcmgy?=
 =?utf-8?B?aXo0VWwvdUdDWXIwWGhHTGY3cmdONllzcjZPSXE3M21FcVp6T2E2Z251a2Jp?=
 =?utf-8?B?ZEloYkx2RStxTDBESVlnN1YrU1E4UG1ka2tabVpQMzljU3lzNmE4RDlxUmFR?=
 =?utf-8?B?RjRSaGVUTW55L1RLcmhMT0I3dWtWTjFnRmdmQ1hMNWtHSDJSdktSdGc5SnZk?=
 =?utf-8?Q?tj9g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d144ea2-7159-448b-76a5-08db592678f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2023 11:36:37.5968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiDFzK6ibIk9GI40nOzICuG1YQMoGOPuwpGDOVV7SpEZ7O7kr+5IhofWAvmaEgaalWra4LCgQi5b+lZGQMO/HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7446
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGlteDogY29tcG9zaXRlLThtOiBBZGQNCj4gaW14
OG1fZGl2aWRlcl9kZXRlcm1pbmVfcmF0ZQ0KPiANCj4gT24gVGh1LCBNYXkgMTEsIDIwMjMgYXQg
MTA6MDPigK9QTSBBZGFtIEZvcmQgPGFmb3JkMTczQGdtYWlsLmNvbT4NCj4gd3JvdGU6DQo+ID4N
Cj4gPiBPbiBTYXQsIE1heSA2LCAyMDIzIGF0IDI6NTPigK9QTSBBZGFtIEZvcmQgPGFmb3JkMTcz
QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gQ3VycmVudGx5LCBjZXJ0YWluIGNsb2Nr
cyBhcmUgZGVycml2ZWQgYXMgYSBkaXZpZGVyIGZyb20gdGhlaXINCj4gPiA+IHBhcmVudCBjbG9j
ay4gIEZvciBzb21lIGNsb2NrcywgZXZlbiB3aGVuIENMS19TRVRfUkFURV9QQVJFTlQgaXMNCj4g
PiA+IHNldCwgdGhlIHBhcmVudCBjbG9jayBpcyBub3QgcHJvcGVybHkgc2V0IHdoaWNoIGNhbiBs
ZWFkIHRvIHNvbWUNCj4gPiA+IHJlbGF0aXZlbHkgaW5hY2N1cmF0ZSBjbG9jayB2YWx1ZXMuDQo+
ID4gPg0KPiA+ID4gVW5saWtlIGlteC9jbGstY29tcG9zaXRlLTkzIGFuZCBpbXgvY2xrLWRpdmlk
ZXItZ2F0ZSwgaXQgY2Fubm90IHJlbHkNCj4gPiA+IG9uIGNhbGxpbmcgYSBzdGFuZGFyZCBkZXRl
cm1pbmVfcmF0ZSBmdW5jdGlvbiwgYmVjYXVzZSB0aGUgOG0NCj4gPiA+IGNvbXBvc2l0ZSBjbG9j
a3MgaGF2ZSBhIHByZS1kaXZpZGVyIGFuZCBwb3N0LWRpdmlkZXIuIEJlY2F1c2Ugb2YNCj4gPiA+
IHRoaXMsIGEgY3VzdG9tIGRldGVybWluZV9yYXRlIGZ1bmN0aW9uIGlzIG5lY2Vzc2FyeSB0byBk
ZXRlcm1pbmUgdGhlDQo+ID4gPiBtYXhpbXVtIGNsb2NrIGRpdmlzaW9uIHdoaWNoIGlzIGVxdWl2
YWxlbnQgdG8gcHJlLWRpdmlkZXIgKiB0aGUNCj4gPiA+IHBvc3QtZGl2aWRlci4NCj4gPiA+DQo+
ID4gPiBXaXRoIHRoaXMgYWRkZWQsIHRoZSBzeXN0ZW0gY2FuIGF0dGVtcHQgdG8gYWRqdXN0IHRo
ZSBwYXJlbnQgcmF0ZQ0KPiA+ID4gd2hlbiB0aGUgcHJvcGVyIGZsYWdzIGFyZSBzZXQgd2hpY2gg
Y2FuIGxlYWQgdG8gYSBtb3JlIHByZWNpc2UgY2xvY2sNCj4gPiA+IHZhbHVlLg0KPiA+ID4NCj4g
PiA+IE9uIHRoZSBpbXg4bXBsdXMsIG5vIGNsb2NrIGNoYW5nZXMgYXJlIHByZXNlbnQuDQo+ID4g
PiBPbiB0aGUgTWluaSBhbmQgTmFubywgdGhpcyBjYW4gaGVscCBhY2hpZXZlIG1vcmUgYWNjdXJh
dGUgbGNkaWYNCj4gPiA+IGNsb2Nrcy4gV2hlbiB0cnlpbmcgdG8gZ2V0IGEgcGl4ZWwgY2xvY2sg
b2YgMzEuNTAwTUh6IG9uIGFuIGlteDhtDQo+ID4gPiBOYW5vLCB0aGUgY2xvY2tzIGRpdmlkZWQg
dGhlIDU5NE1IeiBkb3duLCBidXQgbGVmdCB0aGUgcGFyZW50IHJhdGUNCj4gPiA+IHVudG91Y2hl
ZCB3aGljaCBjYXVzZWQgYSBjYWx1bGF0aW9uIGVycm9yLg0KPiA+ID4NCj4gPiA+IEJlZm9yZToN
Cj4gPiA+IHZpZGVvX3BsbCAgICAgICAgICAgICAgNTk0MDAwMDAwDQo+ID4gPiAgIHZpZGVvX3Bs
bF9ieXBhc3MgICAgIDU5NDAwMDAwMA0KPiA+ID4gICAgIHZpZGVvX3BsbF9vdXQgICAgICA1OTQw
MDAwMDANCj4gPiA+ICAgICAgIGRpc3BfcGl4ZWwgICAgICAgMzEyNjMxNTgNCj4gPiA+ICAgICAg
ICAgZGlzcF9waXhlbF9jbGsgMzEyNjMxNTgNCj4gPiA+DQo+ID4gPiBWYXJpYW5jZSA9IC0yMzY4
NDIgSHoNCj4gPiA+DQo+ID4gPiBBZnRlciB0aGlzIHBhdGNoOg0KPiA+ID4gdmlkZW9fcGxsICAg
ICAgICAgICAgICAgMzE1MDAwMDANCj4gPiA+ICAgdmlkZW9fcGxsX2J5cGFzcyAgICAgIDMxNTAw
MDAwDQo+ID4gPiAgICAgdmlkZW9fcGxsX291dCAgICAgICAzMTUwMDAwMA0KPiA+ID4gICAgICAg
ZGlzcF9waXhlbCAgICAgICAgMzE1MDAwMDANCj4gPiA+ICAgICAgICAgZGlzcF9waXhlbF9jbGsg
IDMxNTAwMDAwDQo+ID4gPg0KPiA+ID4gVmFyaWFuY2UgPSAwIEh6DQo+ID4gPg0KPiA+ID4gQWxs
IG90aGVyIGNsb2NrcyByYXRlcyBhbmQgcGFyZW50IHdlcmUgdGhlIHNhbWUuDQo+ID4gPiBTaW1p
bGFyIHJlc3VsdHMgb24gaW14OG1tIHdlcmUgZm91bmQuDQo+ID4gPg0KPiA+DQo+ID4gUGVuZyAv
IEFiZWwsDQo+ID4NCj4gPiBJIHdhcyBjdXJpb3VzIGlmIGVpdGhlciBvZiB5b3UgbWlnaHQgaGF2
ZSB0aW1lIHRvIHJldmlldyB0aGlzIGF0dGVtcHQNCj4gPiBhdCBlbmFibGluZyBkZXRlcm1pbmVf
cmF0ZSBvbiB0aGUgOG0ncy4gIEkgdGVzdGVkIHRoaXMgb24gdGhlIDhtbSwNCj4gPiA4bW4sIGFu
ZCA4bXAsIGFuZCBmb3VuZCBubyByZWdyZXNzaW9ucy4NCj4gDQo+IEdlbnRsZSBudWRnZS4NCj4g
DQo+IEl0J3MgYmVlbiBzZXZlcmFsIHdlZWtzIHNpbmNlIHRoZSBpbml0aWFsIHBvc3QgYW5kIHRo
ZSBEU0kgZHJpdmVyIGlzIG5vdw0KPiBhdmFpbGFibGUgZm9yIE1pbmkgYW5kIE5hbm8sIHNvIGhh
dmluZyB0aGlzIGluIE1pbmkgYW5kIE5hbm8gd2lsbCByZWFsbHkgaGVscA0KPiBpdCBzeW5jIHZh
cmlvdXMgdmlkZW8gc291cmNlcy4NCg0KU29ycnksIG92ZXJsb29rZWQgdGhpcyBwYXRjaC4gV2ls
bCB0YWtlIGEgbG9vay4NCg0KUmVnYXJkcywNClBlbmcuDQoNCj4gDQo+IHRoYW5rcywNCj4gDQo+
IGFkYW0NCj4gDQo+ID4NCj4gPiBhZGFtDQo+ID4gPiBGaXhlczogNjkwZGNjYzRhMGJmICgiUmV2
ZXJ0ICJjbGs6IGlteDogY29tcG9zaXRlLThtOiBBZGQgc3VwcG9ydCB0bw0KPiA+ID4gZGV0ZXJt
aW5lX3JhdGUiIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFkYW0gRm9yZCA8YWZvcmQxNzNAZ21h
aWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBWMjogIEZpeCBidWlsZCB3YXJuaW5nIGZvdW5kIGJ5
IGJ1aWxkIGJvdCBhbmQgZml4IHByZWRpdl92YWx1ZQ0KPiA+ID4gICAgICBhbmQgZGl2X3ZhbHVl
IGJlY2F1c2UgdGhlIHZhbHVlcyBzdG9yZWQgYXJlIHRoZSBkaXZpc29yIC0gMSwNCj4gPiA+ICAg
ICAgc28gd2UgbmVlZCB0byBhZGQgMSB0byB0aGUgdmFsdWVzIHRvIGJlIGNvcnJlY3QuDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLThtLmMN
Cj4gPiA+IGIvZHJpdmVycy9jbGsvaW14L2Nsay1jb21wb3NpdGUtOG0uYw0KPiA+ID4gaW5kZXgg
Y2JmMGQ3OTU1YTAwLi43YTZlM2NlOTcxMzMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2Ns
ay9pbXgvY2xrLWNvbXBvc2l0ZS04bS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xr
LWNvbXBvc2l0ZS04bS5jDQo+ID4gPiBAQCAtMTE5LDEwICsxMTksNDEgQEAgc3RhdGljIGludA0K
PiBpbXg4bV9jbGtfY29tcG9zaXRlX2RpdmlkZXJfc2V0X3JhdGUoc3RydWN0IGNsa19odyAqaHcs
DQo+ID4gPiAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+ICtzdGF0
aWMgaW50IGlteDhtX2RpdmlkZXJfZGV0ZXJtaW5lX3JhdGUoc3RydWN0IGNsa19odyAqaHcsDQo+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBjbGtfcmF0
ZV9yZXF1ZXN0ICpyZXEpDQo+ID4gPiArew0KPiA+ID4gKyAgICAgICBzdHJ1Y3QgY2xrX2Rpdmlk
ZXIgKmRpdmlkZXIgPSB0b19jbGtfZGl2aWRlcihodyk7DQo+ID4gPiArICAgICAgIGludCBwcmVk
aXZfdmFsdWU7DQo+ID4gPiArICAgICAgIGludCBkaXZfdmFsdWU7DQo+ID4gPiArDQo+ID4gPiAr
ICAgICAgIC8qIGlmIHJlYWQgb25seSwganVzdCByZXR1cm4gY3VycmVudCB2YWx1ZSAqLw0KPiA+
ID4gKyAgICAgICBpZiAoZGl2aWRlci0+ZmxhZ3MgJiBDTEtfRElWSURFUl9SRUFEX09OTFkpIHsN
Cj4gPiA+ICsgICAgICAgICAgICAgICB1MzIgdmFsOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAg
ICAgICAgIHZhbCA9IHJlYWRsKGRpdmlkZXItPnJlZyk7DQo+ID4gPiArICAgICAgICAgICAgICAg
cHJlZGl2X3ZhbHVlID0gdmFsID4+IGRpdmlkZXItPnNoaWZ0Ow0KPiA+ID4gKyAgICAgICAgICAg
ICAgIHByZWRpdl92YWx1ZSAmPSBjbGtfZGl2X21hc2soZGl2aWRlci0+d2lkdGgpOw0KPiA+ID4g
KyAgICAgICAgICAgICAgIHByZWRpdl92YWx1ZSsrOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICAg
ICAgICAgIGRpdl92YWx1ZSA9IHZhbCA+PiBQQ0dfRElWX1NISUZUOw0KPiA+ID4gKyAgICAgICAg
ICAgICAgIGRpdl92YWx1ZSAmPSBjbGtfZGl2X21hc2soUENHX0RJVl9XSURUSCk7DQo+ID4gPiAr
ICAgICAgICAgICAgICAgZGl2X3ZhbHVlKys7DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAg
ICAgcmV0dXJuIGRpdmlkZXJfcm9fZGV0ZXJtaW5lX3JhdGUoaHcsIHJlcSwgZGl2aWRlci0+dGFi
bGUsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgUENHX1BSRURJVl9XSURUSCArIFBDR19ESVZfV0lEVEgsDQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGl2aWRlci0+ZmxhZ3MsIHByZWRp
dl92YWx1ZSAqIGRpdl92YWx1ZSk7DQo+ID4gPiArICAgICAgIH0NCj4gPiA+ICsNCj4gPiA+ICsg
ICAgICAgcmV0dXJuIGRpdmlkZXJfZGV0ZXJtaW5lX3JhdGUoaHcsIHJlcSwgZGl2aWRlci0+dGFi
bGUsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBDR19QUkVE
SVZfV0lEVEggKyBQQ0dfRElWX1dJRFRILA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBkaXZpZGVyLT5mbGFncyk7IH0NCj4gPiA+ICsNCj4gPiA+ICBzdGF0aWMg
Y29uc3Qgc3RydWN0IGNsa19vcHMgaW14OG1fY2xrX2NvbXBvc2l0ZV9kaXZpZGVyX29wcyA9IHsN
Cj4gPiA+ICAgICAgICAgLnJlY2FsY19yYXRlID0gaW14OG1fY2xrX2NvbXBvc2l0ZV9kaXZpZGVy
X3JlY2FsY19yYXRlLA0KPiA+ID4gICAgICAgICAucm91bmRfcmF0ZSA9IGlteDhtX2Nsa19jb21w
b3NpdGVfZGl2aWRlcl9yb3VuZF9yYXRlLA0KPiA+ID4gICAgICAgICAuc2V0X3JhdGUgPSBpbXg4
bV9jbGtfY29tcG9zaXRlX2RpdmlkZXJfc2V0X3JhdGUsDQo+ID4gPiArICAgICAgIC5kZXRlcm1p
bmVfcmF0ZSA9IGlteDhtX2RpdmlkZXJfZGV0ZXJtaW5lX3JhdGUsDQo+ID4gPiAgfTsNCj4gPiA+
DQo+ID4gPiAgc3RhdGljIHU4IGlteDhtX2Nsa19jb21wb3NpdGVfbXV4X2dldF9wYXJlbnQoc3Ry
dWN0IGNsa19odyAqaHcpDQo+ID4gPiAtLQ0KPiA+ID4gMi4zOS4yDQo+ID4gPg0K
