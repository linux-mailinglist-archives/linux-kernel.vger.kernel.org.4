Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5CB6E5E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjDRJ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjDRJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:56:24 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E5B7EE2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDAzHZ78JDRe594QxkPBbue+naUGyMF09yeQMlpgZc5W5nOzqYEa2Vqi6yQf7kz+4/6TGgaogUdnajel7K8CwEq6LdId/8mo8towsLiLBjxQblmOr3DISytzxBMvyTpHU+m1vYXsaNzXLF0mKJ8LViTQTrSTCsWfGthK/oufOWJPyfRYbV3yk7QD8MzL8ObdBGTz5JUByVcaj85kwUWwznGyizlT9pygds2joRqKDUg+9P+a4KT8n8r/iBedRoYzuhU53GCgRfdNyjRvdJ7ci9nYeM+LKdCbTwwZwmpKI6WOhgU5bOTJskUXJ73ATas+aIDk6GQP2jYo2XozFjlFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SLDXsHjTaszjcOoA4Ms6FstWZk51FAo+Gc85OxAndI=;
 b=DKHxQS1/C/kSTX5VqiE0OUsUVMe5Cp44R7idL1w9qWEw68b/Z5EW9O7aw2zzASQoVdj4h9r0RdZUrGnzhiCtwcXmYrN19fnStmfdkA4KZMIDJk/R5nhUGgCa2LGFlHA/PR0EGuE92oSKcmExxkoBjawEx6FGbS4hUmX4W7A8vUd2ACyHek/TdLrjncWtDcTgiFXNji+c8O2J0MOfeTtj2/5VuqeSmFyc0T7doQjILW6vlVqj/Ikb+xovK2e1GHx/+qBTX8yOgm8zFYWiCZ22RAwY0aToEVH3XHe1ehuVr1gCkTtmQqYMa2/4NZOLTLLarIdPoQOSuVU/qwMxXFN0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SLDXsHjTaszjcOoA4Ms6FstWZk51FAo+Gc85OxAndI=;
 b=PnQ6Mk2lRtHbcULsTLIlp+2EVlYw+gpa6Ym4s7x+xenFDXvXquXQKQuvXGeVAA9mhOQJq6ONxkewnzar57wchtJ1LpQNqho3UX/DUmKqDQ7LrwstKnukmxEkW4AdLiC1h06Xkb/J2YXtPMZHcmFT1o9roHsasGIYfpl/YttMHq0=
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AM0PR04MB7089.eurprd04.prod.outlook.com (2603:10a6:208:1a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 09:55:38 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::ebb7:2418:4038:925d]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::ebb7:2418:4038:925d%5]) with mapi id 15.20.6298.030; Tue, 18 Apr 2023
 09:55:38 +0000
From:   "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: RE: [RFC PATCH] dma: coherent: respect to device 'dma-coherent'
 property
Thread-Topic: [RFC PATCH] dma: coherent: respect to device 'dma-coherent'
 property
Thread-Index: AQHZbqX64aqH8/sqmEm+RldR8MQMVa8tfJIAgAFAtvCAALVkgIABXOxg
Date:   Tue, 18 Apr 2023 09:55:38 +0000
Message-ID: <DB9PR04MB9236D992207FD9AC47CC1385849D9@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20230414080307.35114-1-Zhiqiang.Hou@nxp.com>
 <20230416063028.GA6276@lst.de>
 <DB9PR04MB9236E1467316DFEE177D5E9E849C9@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <42d401e9-57d2-1178-eb94-68f975be73e8@arm.com>
In-Reply-To: <42d401e9-57d2-1178-eb94-68f975be73e8@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|AM0PR04MB7089:EE_
x-ms-office365-filtering-correlation-id: 57b428d1-c298-45ed-3045-08db3ff31048
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PiJMYic6YLiW1kU4sLFAeEFF+z25dQEHqq2zOXS3V7SsgY4k9Sr6OzLFLSIXmAa5PoMqXAytaj1svdlhb6CUxHVt+xZFi9wdbWVEswMUhKRKiaE6Du+REKp1VRoi7CcHDxXUGNOVGd5HFbLf+t3j6x1skDX091tdcgM7wcPfLnS//lfAM2oOKx/JnEuv0ejEtl1Rchz9+9xwpSflNOqn/ShrTeQ2Ct54vbnuoNDxmr9XJQ1LPRWYusK96mcogYIf4Ec1k2ZfASs6pjtZbWG4UNhedp32wrsgK1hkcD2qOYJcPMBvtb9mxw9t1+peo8zvJRNFfVQCbo+kZQD17azpxE+IcbirJKBfLy2hxlTXqElFZCJyNbgrmMWTtr4KBKXA/cdpaM6JYtK2eg8Al0smWN83q7AOoyLAsVpzVpRrFgRFMctAaqHeyGiMwwQDHl3ol1orjyacXCN5nmAM7YJ4C7nBOqbZ0Hmpsx/OvjGCo4Fi3/4NevBBsbKlrX7o1S6M0WEAsSzQ4l+yhUydsy5JWxtpM1a2hn4Txhs/tOs5JVjN0eZuI6hPGgLCxNWIt+j9JccIGgvlr/5JY/dmS8AGWW29//npW+elYHcRjDbX1hCLqKoCo36Ke+IXOb4CVItg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9236.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(38100700002)(8936002)(8676002)(122000001)(38070700005)(5660300002)(2906002)(33656002)(86362001)(52536014)(55016003)(478600001)(7696005)(71200400001)(54906003)(110136005)(186003)(9686003)(66946007)(53546011)(6506007)(76116006)(66476007)(66446008)(26005)(41300700001)(316002)(83380400001)(4326008)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXlRZXJCTExXUHl6cDZydWRUdVU3c0UwMTAvRnNMSGgyU0NJbk1hTGNBalFU?=
 =?utf-8?B?bjFseWFndWc5TGwwNjRtOS8yOW1OQkFHdlM4WXhhTXFHcEgrdzRqYUgzNVpq?=
 =?utf-8?B?eDJLa1dRQkx4dFM4VG9qODY4aDdaMWdHdHBTTGh2a2lkNVgvVEFEQXVsa01E?=
 =?utf-8?B?OUFuTmRvK3lkWCt1SVlWS3Rkc0tSQUJoQVZwckU0b2FqSDhmWlRKeVJjNGVn?=
 =?utf-8?B?YUZZcXJSS3QvenN0YndETHVkRjl5dlpienVBUE94YzVjZldlQ1hLWXU5bUhs?=
 =?utf-8?B?UHo4M0dDbXpwejdRSSt2Wm51ZVF3aGhxeTJlZmFIUTRFcUxCQll3aW5WQWVG?=
 =?utf-8?B?N00rcmtFUWFDd3hkWDRyaXAvamVrY1FBWk9ZaVJqWkR6eGdKemc0ZFZjRktP?=
 =?utf-8?B?Tnl4K1VveGxFQUlKWk9IaUtydnhzMHdYeHlBVjl1TTBucmM3NVV3K1FjZVFp?=
 =?utf-8?B?YTN0d20zYkNDTWxrMWFrRm9yYVgzcnVaWkh1YUd2cldobGhyVnBraGZSS3NN?=
 =?utf-8?B?OFBtOEhOZ0s0Umg4Q1RTSDV5QWhUdVdhb1BnRkFWaGNUZHhSZ3hNdW1NdEp0?=
 =?utf-8?B?eDAraGlDbHNJSk5uNDFyOStqQTI5QUNMS25PdlRCSFlCbG81ZG1hSitCVHQw?=
 =?utf-8?B?V0V2cjFsYXNZSFlhd3I3eEU2L0Z0bWRGbzlsbWplL3NLY2E2djFXUENiZ1Ux?=
 =?utf-8?B?aHgxbmY2OW43N3hlaWlEb21RNVZCZ0pFT3h1RXlXcW9VODFiZGxBMWozN2pw?=
 =?utf-8?B?aVRKeFduSW9aZkVGRC9WaXBITTFhL05yWldNcC9odW53WVk3NWJBNEZiY0to?=
 =?utf-8?B?NGUyTTRmT2ZCS0lpcVlzYTI1Mzh4Q1FkTWZIbVJ3WkNQYUgxWnBsd0Iyb1Jh?=
 =?utf-8?B?UW9DcHBMUTlYY0RudWV4SVg4Q2xWQ3E4UjVFYzNmYmVVZWNBSDhYV252d1Zs?=
 =?utf-8?B?SHlkWjNwYWNVNTNubU44dUpDZ2JmTkwzM1hONnZ4THFsYlZOYzluWEZaZkw1?=
 =?utf-8?B?Y1RRbk9OdHZxL0x5Uzloc0tITnZpa1pRdXRobGxydXlpZ0JrRUxGazV0NjRZ?=
 =?utf-8?B?SkxpZlI0UWNtUnlvd21WOTI0MFlVNEJMOEVWMUlDdm1Qa0t1MTAvVE11eU5Y?=
 =?utf-8?B?OUxxbkFiSzVpOWJ5SExyZXVVOXIrcXJKY3pJem5YVmVsSU40aVhmVXNGd3Fk?=
 =?utf-8?B?a08zTXl4eCt5QnRNeHM3MkdyZXBxSDJrVEc1a2N0V2swOEthM3g0TGMwYlZp?=
 =?utf-8?B?OUNxUzFhN0l0U3F6NlZNSHlwRHNzOEZNVTVDM1k0NnFoWmNlZWxtc2lOQTgx?=
 =?utf-8?B?ZDJIRjlHQnJaT2tLZ1d5d0lyMUFrUWxpMEFvSVJidytCZkovb2JMa3ZVK3BM?=
 =?utf-8?B?YjF3SXVYZkdoZUdXY1hTeExERXM0TjVzSHVISGhQYWJHM2Y2L25KVGlkUktl?=
 =?utf-8?B?eUJuMzdFWjBZd0NZYTB4Q05ieWF3T3dGdjkzejIweERIWlNBTjFWU2FZRDZr?=
 =?utf-8?B?NTJFYngwZGpiY1dhRXRZNEl0eUN5c2FsVjdqc0sya1RaakRZcjlhLzJIL0tS?=
 =?utf-8?B?bUFIRGxpWVJUQTVqZklKaVVEQWlidjZYREpGckpjUy85bHhGL2hiQkZwMHdi?=
 =?utf-8?B?WWpsNU1XNHhsdi9jdU1sSEdqR2hZSWFLSVJPcTJld2xoN2gzYXlGMFhkVlRu?=
 =?utf-8?B?dlQzVGd2aVF5RDhtQUVaSE05ODBTTUxZbUFYbVdPWHo1VUU0aC9aMWJVeW1Y?=
 =?utf-8?B?SXFmNjlKZVlrTGpFNEZOYm9oa2VQTlhIYzFKdXh2VFRITUZlMDJrU0FXaWNF?=
 =?utf-8?B?WmNFWGtuOERMWVBVNkI1ay8rUXJTT3dUVGtjanVUS1N5QkNJZSswZys3TkRU?=
 =?utf-8?B?akxPQlN5ZkRESC81OHBSZ3pLV2htbnRXaHNEdis0ZkFnaUdOdkpnU0RFRGxk?=
 =?utf-8?B?U2J1V3Z0QXVaTzlHdHlHQkM1bDNKNXViTE84cjJtM0k2UWNLbks2bk1Ba0hp?=
 =?utf-8?B?MTNDbVVIaUpNMm94Yk5Nb29HSnlSQmtUNVhXT0VrY2dZVVMzdHJ2MUpUM2xu?=
 =?utf-8?B?eGpPZk5RcnF4OVhBa3J6dStsTEdmY1lvbkJlOUVlaUQ4TldVL2NSNkR6Q09q?=
 =?utf-8?Q?weQ9pehxFoEkYHTQyKCAfPwkR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b428d1-c298-45ed-3045-08db3ff31048
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 09:55:38.5750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b+fN4WPpTBePbrAbZV6ICAy/E7Rr2H7UN3N6Os+kZORKBl8L7kkU6OtJeuVEIzZqBgS2/yu+qxUMsBG5JTURFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7089
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iaW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4g
TXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogTW9uZGF5LCBBcHJpbCAxNywg
MjAyMyA4OjI4IFBNDQo+IFRvOiBaLlEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+OyBDaHJp
c3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gQ2M6IGlvbW11QGxpc3RzLmxpbnV4LmRldjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbS5zenlwcm93c2tpQHNhbXN1bmcuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIXSBkbWE6IGNvaGVyZW50OiByZXNwZWN0IHRvIGRl
dmljZSAnZG1hLWNvaGVyZW50Jw0KPiBwcm9wZXJ0eQ0KPiANCj4gT24gMjAyMy0wNC0xNyAwMzow
NiwgWi5RLiBIb3Ugd3JvdGU6DQo+ID4gSGkgQ2hyaXN0b3BoLA0KPiA+DQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0
LmRlPg0KPiA+PiBTZW50OiBTdW5kYXksIEFwcmlsIDE2LCAyMDIzIDI6MzAgUE0NCj4gPj4gVG86
IFouUS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gPj4gQ2M6IGlvbW11QGxpc3RzLmxp
bnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaGNoQGxzdC5kZTsNCj4gPj4g
bS5zenlwcm93c2tpQHNhbXN1bmcuY29tOyByb2Jpbi5tdXJwaHlAYXJtLmNvbQ0KPiA+PiBTdWJq
ZWN0OiBSZTogW1JGQyBQQVRDSF0gZG1hOiBjb2hlcmVudDogcmVzcGVjdCB0byBkZXZpY2UgJ2Rt
YS1jb2hlcmVudCcNCj4gPj4gcHJvcGVydHkNCj4gPj4NCj4gPj4gT24gRnJpLCBBcHIgMTQsIDIw
MjMgYXQgMDQ6MDM6MDdQTSArMDgwMCwgWmhpcWlhbmcgSG91IHdyb3RlOg0KPiA+Pj4gRnJvbTog
SG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPj4+DQo+ID4+PiBDdXJyZW50
bHksIHRoZSBjb2hlcmVudCBETUEgbWVtb3J5IGlzIGFsd2F5cyBtYXBwZWQgYXMgd3JpdGVjb21i
aW5lDQo+ID4+PiBhbmQgdW5jYWNoZWQsIGlnbm9yZWQgdGhlICdkbWEtY29oZXJlbnQnIHByb3Bl
cnR5IGluIGRldmljZSBub2RlLA0KPiA+Pj4gdGhpcyBwYXRjaCBpcyB0byBtYXAgdGhlIG1lbW9y
eSBhcyB3cml0ZWJhY2sgYW5kIGNhY2hlZCB3aGVuIHRoZQ0KPiA+Pj4gZGV2aWNlIGhhcyAnZG1h
LWNvaGVyZW50JyBwcm9wZXJ0eS4NCj4gPj4NCj4gPj4gV2hhdCBpcyB0aGUgdXNlIGNhc2UgaGVy
ZT8gVGhlIHNvbWV3aGF0IG1pc25hbWVkIHBlci1kZXZpY2UgY29oZXJlbnQNCj4gPj4gbWVtb3J5
IGlzIGludGVuZGVkIGZvciBzbWFsbCBwZXItZGV2aWNlIHBvb2xzIG9mIHNyYW0gb3Igc3VjaCB1
c2VkDQo+ID4+IGZvciBzdGFnaW5nIG1lbW9yeS4NCj4gPg0KPiA+IEluIG15IGNhc2UsIHRoZXJl
IGFyZSBtdWx0aXBsZSBDb3J0ZXgtQSBjb3JlcyB3aXRoaW4gdGhlIGNsdXN0ZXIsIGluDQo+ID4g
d2hpY2ggaXQgaXMgY2FjaGUgY29oZXJlbnQsIHRoZXkgYXJlIHNwbGl0IGludG8gMiBpc2xhbmQg
Zm9yIHJ1bm5pbmcgTGludXggYW5kDQo+IFJUT1MgcmVzcGVjdGl2ZWx5Lg0KPiA+IEkgY3JlYXRl
ZCBhIHZpcnR1YWwgZGV2aWNlIGZvciBMaW51eCBhbmQgUlRPUyBjb21tdW5pY2F0aW9uIHVzaW5n
IHNoYXJlZA0KPiBtZW1vcnkuDQo+ID4gSW4gTGludXggc2lkZSwgSSBjcmVhdGVkIGEgcGVyLWRl
dmljZSBkbWEgbWVtb3J5IHBvb2wgYW5kIGFkZGVkDQo+ICdkbWEtY29oZXJlbnQnDQo+ID4gZm9y
IHRoZSB2aXJ0dWFsIGRldmljZSwgYnV0IHRoZSBkYXRhIGluIHNoYXJlZCBtZW1vcnkgY2FuJ3Qg
YmUgc3luYw0KPiA+IHVwLCBmaW5hbGx5IGZvdW5kIHRoZSBwZXItZGV2aWNlIGRtYSBwb29sIGlz
IGFsd2F5cyBtYXBwZWQgYXMgdW5jYWNoZWQsIHNvDQo+IHN1Ym1pdHRlZCB0aGlzIGZpeCBwYXRj
aC4NCj4gDQo+IFllcywgaW4gcHJpbmNpcGxlIHRoaXMgc2hvdWxkIGFwcGx5IHNpbWlsYXJseSB0
byByZXN0cmljdGVkIERNQSBvciBjb25maWRlbnRpYWwNCj4gY29tcHV0ZSBWTXMgd2hlcmUgRE1B
IGJ1ZmZlcnMgYXJlIHRvIGJlIGFsbG9jYXRlZCBmcm9tIGEgcHJlZGV0ZXJtaW5lZA0KPiBzaGFy
ZWQgbWVtb3J5IGFyZWEsIGFuZCBhIERUIHJlc2VydmVkLW1lbW9yeSByZWdpb24gaXMgdXNlZCBh
cyBhIGNvaGVyZW50DQo+IHBvb2wgdG8gYWNoaWV2ZSB0aGF0LiBRdWl0ZSBsaWtlbHkgdGhhdCBz
byBmYXIgdGhpcyBoYXMgb25seSBiZWVuIGRvbmUgd2l0aA0KPiBub24tY29oZXJlbnQgaGFyZHdh
cmUgb3IgaW4gc29mdHdhcmUgbW9kZWxzIHdoZXJlIGEgbWlzbWF0Y2ggaW4gbm9taW5hbA0KPiBj
YWNoZWFiaWxpdHkgd2Fzbid0IG5vdGljZWFibGUuDQo+IA0KPiBJdCdzIGEgYml0IG5pY2hlLCBi
dXQgbm90IGVudGlyZWx5IHVucmVhc29uYWJsZS4NCj4gDQoNClVuZGVyc3RhbmQsIHRoaXMgY2hh
bmdlIGRvZXNuJ3QgYWZmZWN0IHRoZSBvbmVzIHdpdGhvdXQgJ2RtYS1jb2hlcmVudCcsIGFuZCBp
dCBjYW4gaW1wcm92ZSB0aGUgcGVyZm9ybWFuY2UgbGV2ZXJhZ2luZyB0aGUgaGFyZHdhcmUgY2Fj
aGUgY29oZXJlbnQgZmVhdHVyZS4NCkFuZCBpbiB0aGUgQ01BLCBpdCBtYXBzIHRoZSBtZW1vcnkg
YXMgY2FjaGVhYmxlIHdoZW4gdGhlIGRldmljZSBub2RlIGhhcyAnZG1hLWNvaGVyZW50Jywgb3Ro
ZXJ3aXNlIG5vbi1jYWNoZWFibGUuDQpTbyB0aGlzIGNoYW5nZSBhbGlnbnMgdGhlIGJlaGF2aW9y
IG9mIHRoZSBwZXItZGV2aWNlIGRtYSBwb29sIHRvIHRoZSBDTUEuDQoNClRoYW5rcywNClpoaXFp
YW5nDQo=
