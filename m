Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3565C623A66
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiKJD1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiKJD1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:27:34 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26C918B2A;
        Wed,  9 Nov 2022 19:27:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tmj1E05dXldXar/HblcfFEmkPHJ7lrxEx2B+CslP816WvedzBn04jS7QwagkNxAy4SsVH40nBsg+ACo1amwey9qB4GvXS2Yb+h4bc/mo4uU6diiAYkzxSASINdL3Fi5QlLxQ9dKomRkMFxxCGnWuN5TvKMECth66BPMOu5Ti5/75Xp/BBz4w7uV8k7tR+cLbv/GlAfaAShKpAVLhXeYC+ADKI28ik4qMLBJ8FMlpvF8eo/F6sLhZ/tcDaHNvfCGtC6jkzH8jTvnUaSc7Y3rrYq9z8+U4OpMs3WjuOmBRhkljFh3x9Qdx20ZuLy1u0AKvJZsyOSQ0cTfNmpIEH3QA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=td40PiSJmEScOclb/gtFg3av0v/ZRQwlOyGMCgBhWfM=;
 b=Mv+GYI8GWxNdr6oo4A4AcA25VW68tmBXqVG0yTHV2Eg6zhm0BURr0yzdO7oJL2yDv8+xdm74gousOZ0/6lhn6/ltmjGDuAf7OytgBBQDlfhL/QsOxEIygFxM21vhl5TtNnscOAx/4SMCiy9TaId52PP+YJs+TxpKgvd504YMYi7e3xzHNBg9ZHg4EEpJgEbc25CRfbz75Y+kDl00X4srwbXT2hvo9EkTj2qbC19IBXis3mmTXxL0SF3slve7tAaIQ+OFPLNIKoWECCZ5/GG1B8133XLokkMl9OdS/IxQPEvvbjbvJKKf7W6M7E8BxehajgK/5cWlGXulpJj6wUPTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td40PiSJmEScOclb/gtFg3av0v/ZRQwlOyGMCgBhWfM=;
 b=o2oWzc5MPY+sfRHiIm4Uet89hiLcQqI9+Fyx+y9kIP1D1EVBM4Q/nfqLYoTylYLkWcNl7M1+JVmAt+hdMm4xCjJL6I1+WKYz1Xxb6eRgK6f3dHVcuNRZY3xEko9yg+NAKbpv3WDRHbllEsmVJo3UReE5db/3nVBrtg30yhnC/SM=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 10 Nov
 2022 03:27:30 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::71f1:f7bb:5039:e55d%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 03:27:30 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] tty: serial: fsl_lpuart: only enable Idle Line
 Interrupt for non-dma case
Thread-Topic: [PATCH 1/2] tty: serial: fsl_lpuart: only enable Idle Line
 Interrupt for non-dma case
Thread-Index: AQHY9CiavEkSsdOUeUKRSpxLxqPu2a42fdgAgAECNzA=
Date:   Thu, 10 Nov 2022 03:27:30 +0000
Message-ID: <AS8PR04MB84048B114EACBBCFA729CA3F92019@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221109104515.17266-1-sherry.sun@nxp.com>
 <20221109104515.17266-2-sherry.sun@nxp.com>
 <154eb2b-9467-e915-f51c-18d616c81d34@linux.intel.com>
In-Reply-To: <154eb2b-9467-e915-f51c-18d616c81d34@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS8PR04MB8657:EE_
x-ms-office365-filtering-correlation-id: 3499f7fd-9a2e-4a9d-e6b2-08dac2cb7ff2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iVw3PtmOnVBww1K6bqZjQCXHIQzNcYLyBSHt0Q3XexL1HysYlfYV0Es/NE5IXtm8J1ZI2oECXjrCKMDOhLuuNAJfMRMwwdjA4L/6WQYwEBJJZPD4FZuH5ngGejGDDkN7h84sove08nKWq2ohHB5jf5exDvcYHpNn0WRYwrvBQquQ8/FfUNZEPjDIM1iWN/5FREDIMOnKSkAMWEZQR86dXriYl4+MedusMv4tMHA7x+0wmeEt8QiAEVA0Nv8ZMXcFhJdJTIOX2djhUwaxMYLG6gAmhtOftAk1icXFygRjHy84lArvMLYdMYTLg3U+idSG7Gr1m4h+X+onq14M8PT5r7OISZ29NO07kyuIXPoLf48PDExb9KgeCTcDvYcTV1lekHYnngvPdgkIj/OR/RGtFNuI272oMe7LIbHyK04s+En5exiozvbW3NXKJe6okUz+sFR1dRCYC1kJRPrn6gMQ3j6ZJvzNpw3yul3w0+4L7F3mzh32WMf9Rf0GkApbpN/n5uqfRc3EKJGrd7Q1XRfu5GFCpnIdlnNJOb1O+lbHYRzE6aye9iLZOTtEf4g+SfVQ4lijwrw3F4+B94y1EPrRfM4n0qPxaVRjMLxe/hkIuB9b9yJfUsqJpT/24UjO4bx4enr1/LvyyvFaXEQEZuaB2IgqVjap4xvUCtVLkwAYT7+DWCXNDGKE3vvojeQVBwrczBXrKq23XeHJem30eMwy6M+RuqOYNRV5hwP5dQmbL11v6xlKoaZHbSGjMLudW93k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(86362001)(33656002)(55016003)(38070700005)(6506007)(83380400001)(186003)(26005)(66574015)(53546011)(9686003)(7696005)(38100700002)(122000001)(52536014)(5660300002)(2906002)(316002)(478600001)(41300700001)(71200400001)(6916009)(54906003)(66946007)(76116006)(64756008)(66556008)(8676002)(66476007)(8936002)(4326008)(66446008)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXM0Wms1Tk9UYU0vWnBjQ3F3VDFpNHQweHNHVVl5bWNnWnZCRWUwOWZpRW8r?=
 =?utf-8?B?NHJTZzRtZlBYNi9kZFVzK0lTWnAvUmVla2dhTkZEeWVoVXBCVllXeExuc1I1?=
 =?utf-8?B?ZW04RGgzVjdIaHN6c3BPbG9XNC9UbS9rZFhYSnhiSUJVajhyYWpvUkRETmlI?=
 =?utf-8?B?VVhOenVrVlF2RlRKRXArN2E1OUVEMUNTVWI0R0d4OVZPdW42QkVaL3V3ZnJG?=
 =?utf-8?B?V3F0ZHhPSnZkaWFDdU5iQ0tjSHF2NmNoWDFyTjJMVnFVcHRNenQ0eHhweEJE?=
 =?utf-8?B?OFZFblZ0bjJESkx2WW5YV0V5WCtKS1RGSGh1QWJLNkNYYStZbUg1THZvekpk?=
 =?utf-8?B?TFZtVk5XazdVb2hRL2JveGI0OTNUZFU2TWs3TTRkWnJrcVQzUTgzU2loOXB6?=
 =?utf-8?B?ZkFhMXEybmZZOEFERDNZSGZVemQvanl4TURqN1JZOHdGZStWdWFVZVVVb2hq?=
 =?utf-8?B?SzR6eU1ST1dQMUxmQ3lwREhya0pPWmNJRDk1NFZzMHdwVXh0MXArL2h6Yllx?=
 =?utf-8?B?UmxWOWEvSzk5c0VLS2hVSm0va3Zoa0FrVjA0V3RQdFpIRWNGTkhYeDNOVkVJ?=
 =?utf-8?B?cUk5U3FFV09pZ2ZGbDJUZ29ZWFJaUjIxYmdlUkhLV3N5cXU3L2kxUnBDSU1W?=
 =?utf-8?B?dFAvUjFuTWdyS0o2TEpMZmdaYUo4TVBVRlUrRTlObHFsSzl1eTlVMC9tTDl1?=
 =?utf-8?B?YjArUjdtL2RCNW13WFc3WXVId0oydHRSN1RMdDY0RWc4RlFtbjFxaFNWY3Va?=
 =?utf-8?B?Z3NaOER6Z2JodlZiTkhLSHY0c3JjcjdMdXB0RFA3aFlxdXp4akFLdythcDl0?=
 =?utf-8?B?L0FZMmNLc1cxT211bUZDVlN3OHh6cGtNYjFHK3dDN0UxRlM3aFkyWlNFYS9j?=
 =?utf-8?B?OHh1aXo2aDBIS2ZQMklvTlJDZkNjWWZWWnU3SjJRVWZEWlA0ZHBsanYyM2RH?=
 =?utf-8?B?K1FCWFBvdlNSM0JiMEFGRzcwc1pjT1N0UVFwZ1dmUXlPUCs0L1V3eFV6VjFR?=
 =?utf-8?B?TnhwdUttTVMyaU5qckNYT2ZWenhIK0Z1SE9UOW9yKzB5OFU4OE5uaitQRGNN?=
 =?utf-8?B?L2RzS3RreDJiZGp4MGV2dHcvYWFGa3ZOTnE1UlBtU214TVdmM0p0UjBkQWpi?=
 =?utf-8?B?Y05ldTZzZW9UT2QwTUZ2TTBwTmlpQ3ZpMDM4aE5xZ00zQ2VTMUZjWDV5b3A3?=
 =?utf-8?B?MWwxUmx3aE9MSjhRN2JRdmRjenlkL3k5RWNkT2lPR2dqTk1oNUpCcmFUUThM?=
 =?utf-8?B?ZUpLS0ZUWGd5a2tCQXBSaHY1UGlaYXpqQ1BMUm5ISkRPZTNGWW9ETk8rVzY3?=
 =?utf-8?B?eXlTM1BjVDBHVFRyMzR2d05wNnh5eUd6UitjQitMOVlHTXFGc05BVDRKQU5u?=
 =?utf-8?B?dUlQekgyRnlZN2t6LzRONk4zY3NobC8vQjNMbVgxWklmaXkwVG9LbnJYTGxB?=
 =?utf-8?B?SCt3Z1dUaWo4c1BYRXpzTXdDakpPaGFnREpiakg3SzZON2puNFdEUTZ4T0h4?=
 =?utf-8?B?K1VXZ3M3bndRWE5iRnpJRUxtMHhBVVhxS21WbnhCTy9yVEpzaStxREkvV242?=
 =?utf-8?B?MUtLeUNhUDBhVklkSlkyVHNsVTIxRC8vdHZtbytKa210dGJLL1JEaGYwaGFu?=
 =?utf-8?B?TjNsUkJHRkRvck5VUmtPUmlqUFMyb1VQbVBOcmQ4Zm1LTGhtSVQ5b05FWm51?=
 =?utf-8?B?WlZVbEYweS9ZVU96QjRZU3BFRk52V1R4WFZOOFJMeDZ2MnVuRm5uMGk3VlI5?=
 =?utf-8?B?UXp3bUZGRmdGR21JUUpOZGZIeE96dkh6WFU2TmNmWmk5VEtqcHdLbE1wOERh?=
 =?utf-8?B?b1V1ZXlXWDF0dEZNNUJWM0J0cXpzaTBtUllmSC95NE5PVkdpNkhwUEV2aFRB?=
 =?utf-8?B?WmlWc1F2THBWc0d1UnBxbEVPMVlTakRxMFNrNHBETUNWNm0vOFdESWVkVjE3?=
 =?utf-8?B?blkrWm1tY1FUQ0w2ZXZvWlM0WkZaUExUSDZLemJYRm9FOTVoZ01sMTR5VzZn?=
 =?utf-8?B?a3hsSU9oQjZZMjI4RDJUTG9CZWFod2IvT2lPaGVFOHdmZzJaVWpXOXljQU9U?=
 =?utf-8?B?QlZOY2pWcHF5RGkrR2lXQ1NQaTlRT3NQZG92QmxBSWVIODlPdWxhUkxzZEhm?=
 =?utf-8?Q?+nw4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3499f7fd-9a2e-4a9d-e6b2-08dac2cb7ff2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2022 03:27:30.6497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0Y48iDSWJkRQ15zDBzAdnIm8WoPoSjnYjRISnJZ0iC1ILC0cE6jbDdGgd8Rlucyzs7AmVTh74KaeL92nkx5aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWxwbyBKw6RydmluZW4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiAyMDIy5bm0MTHmnIg55pel
IDIwOjAyDQo+IFRvOiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENjOiBHcmVn
IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieQ0K
PiA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+OyBsaW51eC1zZXJpYWwgPGxpbnV4LXNlcmlhbEB2Z2Vy
Lmtlcm5lbC5vcmc+OyBMS01MDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJd
IHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBvbmx5IGVuYWJsZSBJZGxlIExpbmUgSW50ZXJydXB0
DQo+IGZvciBub24tZG1hIGNhc2UNCj4gDQo+IE9uIFdlZCwgOSBOb3YgMjAyMiwgU2hlcnJ5IFN1
biB3cm90ZToNCj4gDQo+ID4gRm9yIHRoZSBscHVhcnQgZHJpdmVyLCB0aGUgSWRsZSBMaW5lIElu
dGVycnVwdCBFbmFibGUgbm93IGlzIG9ubHkNCj4gPiBuZWVkZWQgZm9yIHRoZSBDUFUgbW9kZSwg
c28gZW5hYmxlIHRoZSBVQVJUQ1RSTF9JTElFIGF0IHRoZSBjb3JyZWN0DQo+ID4gcGxhY2UsIGFu
ZCBjbGVhciBpdCB3aGVuIHNodXRkb3duLg0KPiA+DQo+ID4gQWxzbyBuZWVkIHRvIGNvbmZpZ3Vy
ZSB0aGUgc3VpdGFibGUgVUFSVENUUkxfSURMRUNGRywgbm93IHRoZSB2YWx1ZSBpcw0KPiA+IDB4
NywgcmVwcmVzZW50IDEyOCBpZGxlIGNoYXJhY3RlcnMgd2lsbCB0cmlnZ2VyIHRoZSBJZGxlIExp
bmUgSW50ZXJydXB0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5
LnN1bkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFy
dC5jIHwgMTMgKysrKysrKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9mc2xfbHB1YXJ0LmMNCj4gPiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMg
aW5kZXggYmQ2ODU0OTFlZWFkLi5mNWEwYTE0ZmEzNjYNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2Vy
aWFsL2ZzbF9scHVhcnQuYw0KPiA+IEBAIC0xNzksNyArMTc5LDcgQEANCj4gPiAgI2RlZmluZSBV
QVJUQ1RSTF9TQksJCTB4MDAwMTAwMDANCj4gPiAgI2RlZmluZSBVQVJUQ1RSTF9NQTFJRQkJMHgw
MDAwODAwMA0KPiA+ICAjZGVmaW5lIFVBUlRDVFJMX01BMklFCQkweDAwMDA0MDAwDQo+ID4gLSNk
ZWZpbmUgVUFSVENUUkxfSURMRUNGRwkweDAwMDAwMTAwDQo+ID4gKyNkZWZpbmUgVUFSVENUUkxf
SURMRUNGR19PRkYgICA4DQo+ID4gICNkZWZpbmUgVUFSVENUUkxfTE9PUFMJCTB4MDAwMDAwODAN
Cj4gPiAgI2RlZmluZSBVQVJUQ1RSTF9ET1pFRU4JCTB4MDAwMDAwNDANCj4gPiAgI2RlZmluZSBV
QVJUQ1RSTF9SU1JDCQkweDAwMDAwMDIwDQo+ID4gQEAgLTIzMCw2ICsyMzAsOCBAQA0KPiA+ICAj
ZGVmaW5lIEdMT0JBTF9SU1RfTUlOX1VTCTIwDQo+ID4gICNkZWZpbmUgR0xPQkFMX1JTVF9NQVhf
VVMJNDANCj4gPg0KPiA+ICsjZGVmaW5lIFVBUlRDVFJMX0lETEVDRkcJMHg3DQo+ID4gKw0KPiAN
Cj4gR0VOX01BU0soKSB0byB0aGUgY29ycmVjdCBiaXRzIGRpcmVjdGx5Pw0KPiANCj4gPiAgLyog
UnggRE1BIHRpbWVvdXQgaW4gbXMsIHdoaWNoIGlzIHVzZWQgdG8gY2FsY3VsYXRlIFJ4IHJpbmcg
YnVmZmVyIHNpemUgKi8NCj4gPiAgI2RlZmluZSBETUFfUlhfVElNRU9VVAkJKDEwKQ0KPiA+DQo+
ID4gQEAgLTE1MDYsNyArMTUwOCw3IEBAIHN0YXRpYyB2b2lkIGxwdWFydDMyX3NldHVwX3dhdGVy
bWFyayhzdHJ1Y3QNCj4gbHB1YXJ0X3BvcnQgKnNwb3J0KQ0KPiA+ICAJY3RybCA9IGxwdWFydDMy
X3JlYWQoJnNwb3J0LT5wb3J0LCBVQVJUQ1RSTCk7DQo+ID4gIAljdHJsX3NhdmVkID0gY3RybDsN
Cj4gPiAgCWN0cmwgJj0gfihVQVJUQ1RSTF9USUUgfCBVQVJUQ1RSTF9UQ0lFIHwgVUFSVENUUkxf
VEUgfA0KPiA+IC0JCQlVQVJUQ1RSTF9SSUUgfCBVQVJUQ1RSTF9SRSk7DQo+ID4gKwkJCVVBUlRD
VFJMX1JJRSB8IFVBUlRDVFJMX1JFIHwgVUFSVENUUkxfSUxJRSk7DQo+ID4gIAlscHVhcnQzMl93
cml0ZSgmc3BvcnQtPnBvcnQsIGN0cmwsIFVBUlRDVFJMKTsNCj4gPg0KPiA+ICAJLyogZW5hYmxl
IEZJRk8gbW9kZSAqLw0KPiA+IEBAIC0xNTMwLDcgKzE1MzIsOCBAQCBzdGF0aWMgdm9pZA0KPiBs
cHVhcnQzMl9zZXR1cF93YXRlcm1hcmtfZW5hYmxlKHN0cnVjdCBscHVhcnRfcG9ydCAqc3BvcnQp
DQo+ID4gIAlscHVhcnQzMl9zZXR1cF93YXRlcm1hcmsoc3BvcnQpOw0KPiA+DQo+ID4gIAl0ZW1w
ID0gbHB1YXJ0MzJfcmVhZCgmc3BvcnQtPnBvcnQsIFVBUlRDVFJMKTsNCj4gPiAtCXRlbXAgfD0g
VUFSVENUUkxfUkUgfCBVQVJUQ1RSTF9URSB8IFVBUlRDVFJMX0lMSUU7DQo+ID4gKwl0ZW1wIHw9
IFVBUlRDVFJMX1JFIHwgVUFSVENUUkxfVEU7DQo+ID4gKwl0ZW1wIHw9IFVBUlRDVFJMX0lETEVD
RkcgPDwgVUFSVENUUkxfSURMRUNGR19PRkY7DQo+IA0KPiBGSUVMRF9QUkVQKCkgd291bGQgcHJv
YmFibHkgYmUgbW9yZSBhcHByb3ByaWF0ZSBmb3IgdGhpcz8gVGhlbiB5b3UgY2FuDQo+IGFsc28g
ZHJvcCB0aGUgc2hpZnQgb2Zmc2V0Lg0KDQpIaSBJbHBvLCB0aGFua3MsIEkgd2lsbCB0cnkgdG8g
dXNlIEZJRUxEX1BSRVAoKSBhbmQgR0VOTUFTSygpLg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJyeQ0K
DQoNCj4gDQo+IC0tDQo+ICBpLg0KPiANCj4gPiAgCWxwdWFydDMyX3dyaXRlKCZzcG9ydC0+cG9y
dCwgdGVtcCwgVUFSVENUUkwpOyAgfQ0KPiA+DQo+ID4gQEAgLTE2NjksNyArMTY3Miw3IEBAIHN0
YXRpYyB2b2lkIGxwdWFydDMyX2NvbmZpZ3VyZShzdHJ1Y3QgbHB1YXJ0X3BvcnQNCj4gKnNwb3J0
KQ0KPiA+ICAJfQ0KPiA+ICAJdGVtcCA9IGxwdWFydDMyX3JlYWQoJnNwb3J0LT5wb3J0LCBVQVJU
Q1RSTCk7DQo+ID4gIAlpZiAoIXNwb3J0LT5scHVhcnRfZG1hX3J4X3VzZSkNCj4gPiAtCQl0ZW1w
IHw9IFVBUlRDVFJMX1JJRTsNCj4gPiArCQl0ZW1wIHw9IFVBUlRDVFJMX1JJRSB8IFVBUlRDVFJM
X0lMSUU7DQo+ID4gIAlpZiAoIXNwb3J0LT5scHVhcnRfZG1hX3R4X3VzZSkNCj4gPiAgCQl0ZW1w
IHw9IFVBUlRDVFJMX1RJRTsNCj4gPiAgCWxwdWFydDMyX3dyaXRlKCZzcG9ydC0+cG9ydCwgdGVt
cCwgVUFSVENUUkwpOyBAQCAtMTc3MCw3DQo+ICsxNzczLDcgQEANCj4gPiBzdGF0aWMgdm9pZCBs
cHVhcnQzMl9zaHV0ZG93bihzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQ0KPiA+DQo+ID4gIAkvKiBk
aXNhYmxlIFJ4L1R4IGFuZCBpbnRlcnJ1cHRzICovDQo+ID4gIAl0ZW1wID0gbHB1YXJ0MzJfcmVh
ZChwb3J0LCBVQVJUQ1RSTCk7DQo+ID4gLQl0ZW1wICY9IH4oVUFSVENUUkxfVEUgfCBVQVJUQ1RS
TF9SRSB8DQo+ID4gKwl0ZW1wICY9IH4oVUFSVENUUkxfVEUgfCBVQVJUQ1RSTF9SRSB8IFVBUlRD
VFJMX0lMSUUgfA0KPiA+ICAJCQlVQVJUQ1RSTF9USUUgfCBVQVJUQ1RSTF9UQ0lFIHwgVUFSVENU
UkxfUklFKTsNCj4gPiAgCWxwdWFydDMyX3dyaXRlKHBvcnQsIHRlbXAsIFVBUlRDVFJMKTsNCj4g
Pg0KPiA+DQoNCg==
