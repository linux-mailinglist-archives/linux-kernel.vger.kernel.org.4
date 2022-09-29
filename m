Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458CD5EEC68
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiI2DYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiI2DYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:24:46 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8617D11C35;
        Wed, 28 Sep 2022 20:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbldIMSFGyfKJAI3lOwxxOkDwAGET4YNHmOl1em0KI1OwRcD5aGx65gjOV3d4RUxndLhN7CHcYL3tmBNFIR8yZgGR1clsvzwwXdsAgw2//6VkcJagqE33PBLNKBVfMCdcSiuBL5N9nToYYJ/mU19pJ5S9kFkinGEzpp/OR4rt9KgUkhlLNR4QUim5fP+rJeW0Gqc2bb4dNLmj32mI/W3KtUHt0/1NJe0IUPDJcIDPS/WesmVvPLREoFKU6KKyrdWxrcfPkZwWRX5lEw/tpOZZkOqDoYWkZRtJlcWag/u9lQrD80VtSVCRdPIPrYSE59MhvvKlI1kioAK6/7ykgT13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7IT2/atrjOXbyXOy8Brfc4ILx0BVZkxSpyztVPQz8Y=;
 b=cZhDwQGnkRt0oWUjGXCMg4Uh/GEsAwrtvLbNtloNgbGT0YRiEMdU012e84PWFDoNLZ7yJrbVRxrTEnncGkuzHMBKEoluft7xGiErv3hZ5d+t6/sGw5ZbbVtozb3vWW35HxZdqUgdSyn+7Kh7RtgYkyWWN15PxmimVsl6BT8k0f2Zqf5vX8Cc/VnDBj3iIcKglZY1ZOurNmfrP6jk/tM/hTKv+AJqkZcptCLF2kEXU+7FgACtqnrTQhmOvew1YqPcykJFJP0off0ISwEpcskhTS+JywOgMkfRtwyivX5GLYtEBfmhBUBDk99GE6Wn/Gv23tmXa0RFC0R/4Ip4kjrfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.atpinc.com; dmarc=pass action=none
 header.from=us.atpinc.com; dkim=pass header.d=us.atpinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atpglobal.onmicrosoft.com; s=selector2-atpglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7IT2/atrjOXbyXOy8Brfc4ILx0BVZkxSpyztVPQz8Y=;
 b=LJAtiJGxxAkHgG75KfZ3qJkI2mvPgGgaw3FweujGEGNE9E8GB1KzuFO1dFzmPSLnAt+DLdCli+zFTHfUc4PhfuB8tMwotEVw+5KOajYpEP6QV/iWg0tuXNEeGH655zo4guQJ9KR8CB5zFhGyTviBymS+oLSH7BYYf9qU9i0fFh4=
Received: from PUZPR03MB6130.apcprd03.prod.outlook.com (2603:1096:301:b9::11)
 by HK0PR03MB2866.apcprd03.prod.outlook.com (2603:1096:203:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 03:24:35 +0000
Received: from PUZPR03MB6130.apcprd03.prod.outlook.com
 ([fe80::c151:e5f:b16f:3467]) by PUZPR03MB6130.apcprd03.prod.outlook.com
 ([fe80::c151:e5f:b16f:3467%3]) with mapi id 15.20.5676.019; Thu, 29 Sep 2022
 03:24:34 +0000
From:   Mark Kanczak <Markk@us.atpinc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: Fix a typo for ATP mid
Thread-Topic: [PATCH] mmc-utils: Fix a typo for ATP mid
Thread-Index: AQHY0k05TiCvOySvNkS/bLfpMSwAdK3zMYuAgAKPliA=
Date:   Thu, 29 Sep 2022 03:24:34 +0000
Message-ID: <PUZPR03MB6130D6F4ED345631EB0CAAF2E2579@PUZPR03MB6130.apcprd03.prod.outlook.com>
References: <20220927084317.138-1-avri.altman@wdc.com>
 <CAPDyKFpbMQOhANrKR9wkn=Z=KnjodCPpQm4AnTH47T=r8qPuQA@mail.gmail.com>
In-Reply-To: <CAPDyKFpbMQOhANrKR9wkn=Z=KnjodCPpQm4AnTH47T=r8qPuQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=us.atpinc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB6130:EE_|HK0PR03MB2866:EE_
x-ms-office365-filtering-correlation-id: e2f7e667-81eb-433d-a756-08daa1ca21ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c4+vc8ZhXP2yUvBBfd2ETSxYDJXxzfdB+kNGYlQbTg2W8CeoQUtYX0NFbGDNGKG8bEQxceFOozYXU7ppPmYOK4d9Sgf9SELg56vPnKdHILQK513+iqhFyLBezEnyOIab/FpkFedyH/OL63azSZrwr0tjHnZg5IH7ERUO0K8oR/RqhDuNF7NmXyZd99Rhx7UGIb/iMtV3m7Tmf6gpshcql3ZBxZfPf+Hyl8rpw6/uk4SZWF+7JEd4PTq57RsxHpyFbzHOKqnJZ8UVO9hixYKoGYSUBl3WhDJ6j2GtSn34elJ3ySSRSmvOLF9grF5xPtCpeKOtR7U4JTXN3NnDpnOOp7iv/XiSb3FIR0S6Ztdmx3NO1az6BAQpJVPyuhAlAliM0AfM1r+jX9K+BlZ+wuRdcyEwgyW1CflrBaLphDdNnES24v0N8OUki2LnvUJ8OYhXT6VOz81sHf+X949OJVwGXEVKpte/KmC/0nfnPIgjXbXP6EC56QZULLZ5/YTWkpKf5XtzeBNAoAAIFiqEfg+s7tRTOpnwOib9+YLVzBlrygPEArFndFDiXbRbj8ZE9dOs4lyy7mwr6YKBGGTPBvPRWayL9YF12fSxiQXL/0tUa9dnBRzOs4br2KtGUK/cfg86vs2dvsnM2bpgOYX39ZInN3xRk+wXJ3zUTleEJQcrAfN8f4ymlWJQI2xRFz4i9b8ZCGXqmxX/f/yt0UmWS/RG/fr862mvis8PXmlcEK3nMGDJRIwKFYd9UoH0XFWVA2N0Hb/7S3aarJUfRdXPNmoboPBmXXjCETUtXzcl6m27TeE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6130.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(39850400004)(376002)(346002)(451199015)(9686003)(6506007)(53546011)(7696005)(478600001)(71200400001)(26005)(83380400001)(186003)(2906002)(8936002)(55016003)(316002)(54906003)(110136005)(41300700001)(52536014)(5660300002)(4326008)(8676002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(33656002)(38070700005)(38100700002)(122000001)(84970400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3lzSnY2THFVSHNmTUtZUE1xc0pSUEtiNFdtbXQxMHVoSkJnYWl2WWx4SGVl?=
 =?utf-8?B?V202THltenYzVWpUdVlidFlnU3hsWDJTSVZzbkFKb09ZTTBiL3BCS29wNWh5?=
 =?utf-8?B?bFVMS2x0cjZHR2VxT1NBdjZ1blN2L09OdkFQbkpQLzFQY1pMN2IrLzNXejY0?=
 =?utf-8?B?RGp0L3kzS3VNWllPUmpEcE12emVjd3pSQWRnMTB1cDBGUVpSM3Jtd21xd0t6?=
 =?utf-8?B?cmhLc1F6T2VIMlVLa2QzZk5OanZsTzR6Qkpkakp2MDcvRkUwRXMzUWQvcENG?=
 =?utf-8?B?RlBpUkJpbXBxSWRPQzZseVNWRGs1Z1BSODhtM2EwR0hLYmRLRFlkWXYzajhM?=
 =?utf-8?B?QStydVlPYVZ1NTVCNUtGeFhvQkk2ZUYyOVcyczlJK2VhL0c0a3N5MHg2ejZQ?=
 =?utf-8?B?YlBHdmhzcm0zNitLNE0rTkVxTGlldGw1bmZHajVmck5rQzR4TXlJNDVpdmNR?=
 =?utf-8?B?dzBraHZjTE92QTY4TStLR0w3SlgwN1BycDY2M1B5NENtNWs4aEd0SGovRTlr?=
 =?utf-8?B?V3l6WTFrQ2VzY2lpY0IyYmh3NkJmS0htdktiQUlFSnlxbC83dmE2YmRoSzhv?=
 =?utf-8?B?eTI3K3pUVE9oVFc1L0lDT0RlUEZJNU9ZUk50ZmtwVjNBNWlHcW9JY2hZbzJk?=
 =?utf-8?B?Q0FTTlhaZnVMM0JqSVZ0cEM3MUprdHMzMXBBeWtrNHF6SmlOQ0l6bFVRd1Y5?=
 =?utf-8?B?TDBTWFJVcURML1cxOUlsM29xNjc4NVdtTXhKNk5XVTZabnU2NjczbmxhSkty?=
 =?utf-8?B?NzlSZEptaEthSzROMkhhMzRZRTJJaG9SYnB2amo2WlRmOU4xWkFWKy9lT2ZE?=
 =?utf-8?B?WExFWmRaaTY0L1ExLzRGYnlWd09FZFRMRlN4c2tTSDVQZytiWjdXMFAyK2tm?=
 =?utf-8?B?Tk4yWkRKeFJuUFBOc1crVnVZb0t2SFVScFFnUVk4RUh0WEdseWlSbjAwR1Fa?=
 =?utf-8?B?aE9RMGJ4cFNoQ3pBZ3FzREcxbGlYWkhqeUpZRnhEZSswQ3RndmVVV0wyaHhM?=
 =?utf-8?B?M0s3QlFQYjRBY3NYNDhVMFJRYzFhVE05T0czMVNndjdGcVNvS3dMQ3lEYzRV?=
 =?utf-8?B?U0FGUDViQXgxTHRIT2I1OHNmODVPbUMvUlNxSS9qVzU3d2NpWmRiZGgzZ09v?=
 =?utf-8?B?eDR1K3lrU2RoMHJHOUFBUUdIVmVwTklyWVJHNjNKL0FLV3ZJZkx5UCtRRlQ1?=
 =?utf-8?B?Z1F6dlc5Z1BHd0o1VEVKVFh2eUdSbnI3NFU4Tjd5VmFaSUEwaW9pYkg0cjky?=
 =?utf-8?B?M2ZPOUdVaVdXREdEZTN2cnBSNTBJVE5rcFRhUVJFbUIvLytEZHIxMitPSDFq?=
 =?utf-8?B?RUcrOHFRSUJCMThoT3RJS3dtQThEbnk0aXZKVWFLa1JNaTI5b0E1UW9vWUV0?=
 =?utf-8?B?Rzd2VHA1TXF0NW1zYWsvdE5RUlYzN3BFeWEvaXZ2R25yTmJyc3BNbW9GdGpQ?=
 =?utf-8?B?elczSFNOcW14SXV0a2NMN2s2dzU3cWd5R0ppajVPVUc4WVR5R3dKUzhXbi95?=
 =?utf-8?B?MTRQdXpGM1d5VHdGUU11UWhYTGUzTVNWU2hURXFGOWZVSEg1N09MTzN3UkY5?=
 =?utf-8?B?bmJNTkxmSkFxc01TTFJ0NGwwWFFIdHdNdHRxQjJUOC9ad1N4UDBKT2MxeE81?=
 =?utf-8?B?S3U5UysvQlBGWEhjNlVTWGlYdTRyQStkdnZxWWZLczZORE1hN3lNVzFHWStV?=
 =?utf-8?B?R245REpLcXhOc2VDUWRNc08vcm1hbGE5VWtKOFdmWStOVCsxRG1BUGptRi9y?=
 =?utf-8?B?SXAxYThiblVEd0pyZkFOdTFoNWhPaUU2a1Y2QzFzMlV1YWhDbHhBVlF6S05P?=
 =?utf-8?B?VkVJTit6SFp4WVBaZEtMbkU1Z3FncEg3WHMrQ29XNk8ranRmVzZjM0xoWk1t?=
 =?utf-8?B?MUVYUEcvcXFLY2JEeEx3cVdBb3pkUXV1WlltL0hOTC9EZ21nNTQrbFI4dU9v?=
 =?utf-8?B?Zlh4Vkc4L1JQbDV5RHpYVVRmcE5MTUxoMkRoT2pnVnNmWTRjd25DaXgxbEJp?=
 =?utf-8?B?T28xMmhweWZmbUpSODBzTU4wY1g5VkVlUi9sVWo5ZkVNemFWcGtpVmFMVURT?=
 =?utf-8?B?eTk1S3RvMGtPUVNYMlZGUjJwYnNkM1prNzRVang1ZWxUZmc4eERGRWphc3E5?=
 =?utf-8?Q?9QuhWGv5ASYFmaH639T/KIwlr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: us.atpinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6130.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f7e667-81eb-433d-a756-08daa1ca21ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 03:24:34.8691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b8bb5835-7e80-4bcc-9768-df0f42f8880f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2MTnE8fHhxX8LgOQPYtjD3eWOVCDFrmOFsBhlK+pgQELfWu/6WIIPUVzaHS1xrljx/tL3WTGl17hCfyMITkrgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB2866
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciBhbGwgeW91ciBoZWxwIGluIHRoaXMgbWF0dGVyIQ0KDQpDaGVlcnMNCk1hcmsN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFVsZiBIYW5zc29uIDx1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnPg0KU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI3LCAyMDIyIDg6MTcg
QU0NClRvOiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCkNjOiBsaW51eC1tbWNA
dmdlci5rZXJuZWwub3JnOyBNYXJrIEthbmN6YWsgPE1hcmtrQHVzLmF0cGluYy5jb20+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBtbWMtdXRpbHM6
IEZpeCBhIHR5cG8gZm9yIEFUUCBtaWQNCg0KT24gVHVlLCAyNyBTZXB0IDIwMjIgYXQgMTA6NDMs
IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1hbkB3ZGMuY29tPiB3cm90ZToNCj4NCj4gTWFudWZhY3R1
cmVyIGlkIDB4NDQgaXMgYXNzaWduIHRvIEFUUCBieSAzYy1MTEMsIGFuZCBub3QgdG8gU2FuRGlz
ay4NCj4gbW1jLXV0aWxzIGluaGVyaXRlZCB0aGlzIHR5cG8gd2hlbiBsc21tYyBnb3QgbWVyZ2Vk
IGludG8gaXQuDQo+DQo+IGZpeGVzOiA0YWYxNzQ5ZDIzNTAgKG1tYy11dGlsczogTWVyZ2UgdGhl
IGxzbW1jIHRvb2wgaW50byBtbWMtdXRpbHMpDQo+DQo+IFJlcG9ydGVkLWJ5OiBNYXJrIEthbmN6
YWsgPE1hcmtrQHVzLmF0cGluYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEF2cmkgQWx0bWFuIDxh
dnJpLmFsdG1hbkB3ZGMuY29tPg0KDQpBcHBsaWVkIHRvIGdpdC5rZXJuZWwub3JnL3B1Yi9zY20v
L3V0aWxzL21tYy9tbWMtdXRpbHMuZ2l0IG1hc3RlciwgdGhhbmtzIQ0KDQpLaW5kIHJlZ2FyZHMN
ClVmZmUNCg0KPiAtLS0NCj4gIGxzbW1jLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2xzbW1jLmMgYi9s
c21tYy5jDQo+IGluZGV4IDA1ZDU5ZTguLjU1ZGEzYWEgMTAwNjQ0DQo+IC0tLSBhL2xzbW1jLmMN
Cj4gKysrIGIvbHNtbWMuYw0KPiBAQCAtMjM3LDcgKzIzNyw3IEBAIHN0cnVjdCBpZHNfZGF0YWJh
c2UgZGF0YWJhc2VbXSA9IHsNCj4gICAgICAgICB7DQo+ICAgICAgICAgICAgICAgICAudHlwZSA9
ICJtbWMiLA0KPiAgICAgICAgICAgICAgICAgLmlkID0gMHg0NCwNCj4gLSAgICAgICAgICAgICAg
IC5tYW51ZmFjdHVyZXIgPSAiU2FuRGlzayIsDQo+ICsgICAgICAgICAgICAgICAubWFudWZhY3R1
cmVyID0gIkFUUCIsDQo+ICAgICAgICAgfSwNCj4gICAgICAgICB7DQo+ICAgICAgICAgICAgICAg
ICAudHlwZSA9ICJtbWMiLA0KPiAtLQ0KPiAyLjE3LjENCj4NCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQogVGhpcyBlLW1haWwgdHJhbnNtaXNzaW9uIGlzIGludGVuZGVkIG9ubHkg
Zm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwgb3IgZW50aXR5IHRvIHdoaWNoIGl0IGlzIGFk
ZHJlc3NlZCwgYW5kIG1heSBjb250YWluIEFUUCdzIGluZm9ybWF0aW9uIHRoYXQgaXMgcHJvcHJp
ZXRhcnksIHByaXZpbGVnZWQsIGNvbmZpZGVudGlhbCwgb3IgZXhlbXB0ZWQgZnJvbSBkaXNjbG9z
dXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3LiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIHRyYW5z
bWlzc2lvbiBieSBtaXN0YWtlLCBwbGVhc2Ugbm90aWZ5IHVzIGltbWVkaWF0ZWx5IGFuZCBkZWxl
dGUgdGhlIG9yaWdpbmFsIG1lc3NhZ2UuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNp
cGllbnQsIHlvdSBhcmUgaGVyZWJ5IG5vdGlmaWVkIHRoYXQgYW55IGRpc3NlbWluYXRpb24sIGRp
c3RyaWJ1dGlvbiwgZGlzY2xvc3VyZSwgY29weWluZywgb3IgdXNlIG9mIHRoaXMgY29tbXVuaWNh
dGlvbiwgaW5jbHVkaW5nIHRoZSBhdHRhY2hlZCBmaWxlcywgaXMgc3RyaWN0bHkgcHJvaGliaXRl
ZC4gV2Ugc2luY2VyZWx5IGFwcHJlY2lhdGUgeW91ciBjb29wZXJhdGlvbi4NCuacrOS/oeS7tuWD
heaOiOasiuWOn+eZvOS/oeS6uuaMh+WumuS5i+aUtuS/oeS6uuWPlumWseS5i+eUqCzkv6Hku7bk
uK3lj6/og73lkKvmnInoj6/pqLDlnIvpmpvnp5HmioDmiYDmk4HmnInkuYvmqZ/lr4bmgKfos4fo
qIos5aaC5p6c5oKo5Lim6Z2e6KKr5oyH5a6a5LmL5pS25L+h5Lq65oiW5Zyo5Lu75L2V5pyq57aT
5o6I5qyK55qE5oOF5b2i5LmL5LiL5pS25Yiw5pys5L+h5Lu2LCDnhanoq4vmgqjnq4vljbPlkYrn
n6Xljp/nmbzkv6HkurrkuKblsIfmraTkv6Hku7blvp7pm7vohaboiIfntrLot6/kvLrmnI3lmajk
uK3kuojku6XliKrpmaTjgILoq4vms6jmhI/vvJrku7vkvZXmnKrntpPmjojmrIrogIzmk4Xoh6rk
vb/nlKjmraTkv6Hku7bmiYDlkKvkuYvmqZ/lr4bos4foqIrnmoTooYzngrrmmK/ooqvlmrTmoLzn
poHmraLnmoQs6Kyd6Kyd5oKo55qE5ZCI5L2c44CCDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0K
