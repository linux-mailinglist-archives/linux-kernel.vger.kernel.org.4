Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200D06EA57C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjDUICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjDUICd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:02:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B47F76A6;
        Fri, 21 Apr 2023 01:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt9Z5nCIj2zHSggHiG4T2dFPcnVSstXT7Oacw9NMjPCcwk/m6GRUXK71cYpixbX2FL6h0spO5S1h0PoLopaQePnRLCAXy6ISmHRQebrh2pPqwgWBjs+yaBYJQpb5NbP8Iozy2xav7gDLYGpjdn4fcXYYs+vIQBPPbZe32319ZbboWMcs2ytzVRv33TwSZrumjV1ta+bqg87RuCrK/7FJpRAOSNTmwN5k8Qdd9Cv+PQHY4OfuVAZIRqyRriCALRHiZl8Cat4WBzOuIHDvAa/5usS000c60yyCvrjXz6Z9m+53QeKvAdzdPkW/2fHzp8ZklVwFbE+vqJ9hTU/cpsoTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGtedfmPsHADCU9MTQlBuM0xREETWD1GVBbItuoslVc=;
 b=eIe8gFyk+MDLrMyQ6HIRA38CGaEd1NBM1BPqGlHtr4CewVRihkewiAf4CnefPui/HdHnibjksmUpQ1hCHmAlWxZKRsFdcBgS4oreznR5PXT1TbkeKed8btpAFak/7sLD7zwE6iaFD9NkrRECh/CFxMmNJHLY33m6MKsUzUe0CWMmZZuP7mx68Tm8TJzmrQCtWi3/Cb6S0sG4I37VlOYwoOJkp/PiZvq9gUMmlxcxYmAZzhy/WgP8dWIVQUHEEcWJDhufE6sv1kw4XCzvVCnZcpUfy4jjHEseDj3mUfY7L3RZJolIPrhLkb6mWGZYTYjdxeEtsO+Q+GgS0U+B5OrbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGtedfmPsHADCU9MTQlBuM0xREETWD1GVBbItuoslVc=;
 b=JhYZl7Hf9WKr1PtbpogU0nbeBt8noRwlQtKvvPZhdqoAc5cOzVkVE4aSZ2x1MdyENf2AK2SGn77nGAeYTsmozhSVuZbRzrPUcqYr6+wyMkOA5yXmlZz2yx4dE8JhARivjaZgOPR8Ml4QBGtGmWCNbprab6QbRCjf0sxxR6r4wjw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB11944.jpnprd01.prod.outlook.com
 (2603:1096:400:387::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 08:02:28 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 08:02:27 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
CC:     =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?= 
        <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFT v2 3/3] drivers/thermal/rcar_gen3_thermal: add reading
 fuses for Gen4
Thread-Topic: [PATCH RFT v2 3/3] drivers/thermal/rcar_gen3_thermal: add
 reading fuses for Gen4
Thread-Index: AQHZc2mNHjIrJ3cQ6kWxXJn/U7HA4q81Y4AQ
Date:   Fri, 21 Apr 2023 08:02:27 +0000
Message-ID: <TYBPR01MB53413B97CCBAC486C2CF7085D8609@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230420092128.6073-1-wsa+renesas@sang-engineering.com>
 <20230420092128.6073-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230420092128.6073-4-wsa+renesas@sang-engineering.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB11944:EE_
x-ms-office365-filtering-correlation-id: bb344dd4-e297-4456-431b-08db423ebff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zwnCjuzjjaJWlf+oiVBS0/GerY4bLbO8/kTQxS+QSWLe4tFnZzy5sA3lLSwETDzXlWZLaSbx6csiGehO+SGhdGFVNqfPnBIVN9hrBbRrrciZbMp8HBYtqyvobMBqEIa5rljRktW7j0HOsstrx1ZyOROBhgzMOxo3GD/W3VBieGv4mWQ+ZYo1HIys91fpbrfGi6rH1nq6RGyFiL7xTZjXmUPoNle0KToL8ZfK9az9aOdN/+evTkipUEBy87sOSSQzOPDH5Xxd2Ipb/ldJnwRRQSUMxYvL1Otpodnxok7+e9Ww6v8+YElUEO3yvTZAj8YUJUn+t/1aX4Sqb+DOLtR9ZoVXA97Heicx2+JPwvNXrBw/fQoWVZQMDGGK6ZqQCP8dg2k7HVeLqvthbtaDuCCEFcBY/Gk6WcATwkzUdgcCvam5HB6OobuZ0V1gBpZCtRWZQL/kp+5OYqXEYED2VtJoSJsFJI9tMbFSRN8H9exBm+dZOQ2AkQnNB8HU/Q92YY9U+Uj+7uT4w9Ccp7K/OaVRGopc8618k1ocawuC8x05X0NeWAu9+moQF2/V/3SWZgDIFZrEJvHCa/EnAqQ7utR2xZLouWeZCep5apeCiUxayuORaCllcRVUgBqpTvne7HVq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199021)(4326008)(52536014)(5660300002)(7416002)(86362001)(6506007)(83380400001)(186003)(7696005)(9686003)(122000001)(38070700005)(71200400001)(38100700002)(8936002)(8676002)(54906003)(478600001)(110136005)(33656002)(41300700001)(55016003)(316002)(76116006)(66476007)(66556008)(66446008)(64756008)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlRQWEpuS1JvZVJnR1E0KzBOUFBpS1oxRm5uczNVbTZ2cWhzL0k4ZlVQVDBN?=
 =?utf-8?B?dGU0N3ZJMEFWQStIZTQzeW9pNUtqTmVvZFU2Mjd6Z2hFS2EvV2dwcS9JMVJM?=
 =?utf-8?B?NHlsMTBwc2JCY0hhTG9kRldXcm1sMXZ5bEtvcmoza0tlOW0zTE4vS1RvaCtK?=
 =?utf-8?B?TzZuU3psVDhEczVWSE54aWxnOGkvOVZMMzBkYkVwb2RoSVVtcVRzb0xSTXRn?=
 =?utf-8?B?UUJvR3pDcEhha29oaDRMZVNmSEpuZmZmMGx0SkNEQ21jMFI5VG1XRmpJbTlr?=
 =?utf-8?B?NmJPMXlpQzBKTTVjTXZac0xoMmNyYzJKUTRkRVd2RE1KNkh2RGtCcUR4NGpJ?=
 =?utf-8?B?QWpmQkxIWURic1N1TzdMUTV6c0VYUlJxelgzdXQyeTVadXRDSDdSalBSak8z?=
 =?utf-8?B?cmp1Zlk3c2grSXFWWTZwbHkxRnJhV2F6U2VRclc3TmJrSmFhZzZTZFlvczVr?=
 =?utf-8?B?VW5rbkMxd0pHSVhjQm9uL1IrVDRneUNmNFBGK0o1Wi8vNnE4YmlnWUNvOGxr?=
 =?utf-8?B?MTFKcWJpaURmc3VXb2F3OTJXOXRvc0VVU3ZkYnlubTdYb2JSSnY5VC93WjBR?=
 =?utf-8?B?SHBodDh2a3lBY1pNNnloV2tsaUJORkhDWU1tMFZJS0NXQ3grWXI4cWplaU5M?=
 =?utf-8?B?SDQxbHZMVjR0Nnl5dy9RNDV6QnIvOUZQdjV1ajVzUW9ET1lmNGMrN1ZkSHdu?=
 =?utf-8?B?ZFA1cGY0UHVHZENUVGtycEtqOGY0RE43ckY4M2pOTG02Ymd1R0prZC9Ta25N?=
 =?utf-8?B?NHFBS1dDcHcrQTFtVWw5L2xKREtFbVluejl6cm9wT1krWVpqUmtXck94dmZK?=
 =?utf-8?B?N3lWTzZQc3ZYQklQUXRRSi9HZkRna1RKalJoVGNoUVFlQVl0dFNWbFpCQ2h2?=
 =?utf-8?B?WmNRMGVNZUVXZno5TXhON2JGVHE2TjhTRi9XYkFxYTd0K3I5elRoYWN1c2p6?=
 =?utf-8?B?S1lGNWFQSzZ3enlMUG56YkNna2RiMEVDYmVWZjJSK0swU2pONXFHWlFqaVJm?=
 =?utf-8?B?dFhJRXBUTmd1ODlqUDloYkpnVGwyZWdtangxbnZDZ2JrRGlJZHBQWSt2WEpy?=
 =?utf-8?B?RXM5SlJoQ2NQNEh5V2dVOFgvWm0vckMwUHpPSUVCc0x5c2hmT1dYbGN1elh1?=
 =?utf-8?B?UmtiM29SNTVjWXUzb29nT3dtdUt6Y2pYS2xrWnNScENzWjQyME5NTFNON1Rq?=
 =?utf-8?B?dWFVbmFrbDZXTmpBc0laZUc5V25nZjZoRk1sblB6cDJ4ZERWSm9pMnV1Rjhp?=
 =?utf-8?B?bCtGODlDR2tWVlROeVRoWG5qZ1YwcVc2dFJPMmVmWHFoNzVDL0dTVkoxcktq?=
 =?utf-8?B?aU82UGdMdHNOVHlGYis4Z3daUjNBTWxjZ0Y5NlM5a1JIVXRnS0hib2NtNkZw?=
 =?utf-8?B?enhTNUIrNWx1SjRjL2xLMDY3bGIzdGM3eUpTeEE1aS8vSWJFZUxqT0JkcnFH?=
 =?utf-8?B?dTZKeUNEa29TcDhkaVV6L2lvL0d2N21rb3NweDVSU05XbHROVStuL0RVOWZU?=
 =?utf-8?B?WXc1eFpac0wyV2wwUmxuTkFQa2cxNkxjRm5TUGlTS2I5cURtNnJRdVNpNU5Q?=
 =?utf-8?B?YjZjMzFpbUEwSDRiSElmakxsRFN2L3JnVzhHWVpDNG16VTRmZ04wNldKVGZw?=
 =?utf-8?B?WldoWC9UejFvb1VGMUpzeUE5Sk1oTExMRWJhOVFCOWJRVUdhN3BiVmM0eXZx?=
 =?utf-8?B?NmEyRWkzbzdOWUhKTUVWTmpYNGJPbFpBUnpjdGx5Si9CTGMyVUFCS3NxV2FN?=
 =?utf-8?B?QlZ1NEVQY3FoTlFReWp2aGJvbEoxclJ6OGluUS9hTURrcndXZWd1VENYS0tO?=
 =?utf-8?B?bTZuaWk2bGdBTzYyalhlbWl0NkxVOWJFbHBHMGhEZUFqSC9NOUdKdDZoL3FV?=
 =?utf-8?B?akZ6TjZ0OTRjSXZtb214Q1FrRC9xRWN5cEd3YkdObUlESFJPWDlPN2hDMEpt?=
 =?utf-8?B?dEhFUXQraHRRMVptSWh4UnZ2RnhHUFkyaWdOUnM0T3MyOXdIc2ljcisydExq?=
 =?utf-8?B?N1BscWtJZWFRazZ0MHdtSEgzc0VtMmt5bGNBTVFweVAyU2lDVFVtdEhpcnk5?=
 =?utf-8?B?Tno4alVHSGVBd2s0V0FVamlBTDhCSEVCc2ZpdndBaXB1aEJ4NW8zYVp4ejZH?=
 =?utf-8?B?RHVHZm9xS05kVDRjalB0YjZtSlZtbDNCbWlPR2ZGMjZ0bVVNWEhHLzZ0MHhB?=
 =?utf-8?B?SjM3SDN5TUsraUpzVkhVOEdzT3JpcS8zQmh3U3k1d2VET1pFUUZDQ1VqME12?=
 =?utf-8?B?am1YVzAvVXBxMnBiRWRMbWV2S1FBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb344dd4-e297-4456-431b-08db423ebff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 08:02:27.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E7KNo6lWER9oiU1WOcQ9h5qbfy9N+37T7YoCcLI6gzLG038HNfCCifnE+bH1FZe46QIlbtg5Dquj+/4vVUQJkWcvIcrANFCw8CyXsllIAMJ2f9goZtbt6doYSA0XlzOT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11944
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gV29sZnJhbS1zYW4sDQoNCj4gRnJvbTogV29sZnJhbSBTYW5nLCBTZW50OiBUaHVyc2Rh
eSwgQXByaWwgMjAsIDIwMjMgNjoyMSBQTQ0KPiANCj4gVGhlIHJlZ2lzdGVycyBhcmUgZGlmZmVy
ZW50bHkgbmFtZWQgYW5kIGF0IGRpZmZlcmVudCBvZmZzZXRzLCBidXQgdGhlaXINCj4gZnVuY3Rp
b25hbGl0eSBpcyB0aGUgc2FtZSBhcyBmb3IgR2VuMy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdv
bGZyYW0gU2FuZyA8d3NhK3JlbmVzYXNAc2FuZy1lbmdpbmVlcmluZy5jb20+DQo+IFJldmlld2Vk
LWJ5OiBOaWtsYXMgU8O2ZGVybHVuZCA8bmlrbGFzLnNvZGVybHVuZCtyZW5lc2FzQHJhZ25hdGVj
aC5zZT4NCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2ghDQoNCj4gLS0tDQo+ICBkcml2ZXJzL3Ro
ZXJtYWwvcmNhcl9nZW4zX3RoZXJtYWwuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvcmNhcl9nZW4zX3RoZXJtYWwuYyBi
L2RyaXZlcnMvdGhlcm1hbC9yY2FyX2dlbjNfdGhlcm1hbC5jDQo+IGluZGV4IDM5YjM4MmVlMDhj
OC4uZTAxZTI3OTAzZTQ0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvcmNhcl9nZW4z
X3RoZXJtYWwuYw0KPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvcmNhcl9nZW4zX3RoZXJtYWwuYw0K
PiBAQCAtMzUsNiArMzUsMTIgQEANCj4gICNkZWZpbmUgUkVHX0dFTjNfUFRBVDIJCTB4NjANCj4g
ICNkZWZpbmUgUkVHX0dFTjNfUFRBVDMJCTB4NjQNCj4gICNkZWZpbmUgUkVHX0dFTjNfVEhTQ1AJ
CTB4NjgNCj4gKyNkZWZpbmUgUkVHX0dFTjRfVEhTRk1PTjAwCTB4MTgwDQo+ICsjZGVmaW5lIFJF
R19HRU40X1RIU0ZNT04wMQkweDE4NA0KPiArI2RlZmluZSBSRUdfR0VONF9USFNGTU9OMDIJMHgx
ODgNCj4gKyNkZWZpbmUgUkVHX0dFTjRfVEhTRk1PTjE1CTB4MUJDDQo+ICsjZGVmaW5lIFJFR19H
RU40X1RIU0ZNT04xNgkweDFDMA0KPiArI2RlZmluZSBSRUdfR0VONF9USFNGTU9OMTcJMHgxQzQN
Cj4gDQo+ICAvKiBJUlF7U1RSLE1TSyxFTn0gYml0cyAqLw0KPiAgI2RlZmluZSBJUlFfVEVNUDEJ
CUJJVCgwKQ0KPiBAQCAtNTUsNiArNjEsNyBAQA0KPiANCj4gICNkZWZpbmUgTUNFTFNJVVModGVt
cCkJKCh0ZW1wKSAqIDEwMDApDQo+ICAjZGVmaW5lIEdFTjNfRlVTRV9NQVNLCTB4RkZGDQo+ICsj
ZGVmaW5lIEdFTjRfRlVTRV9NQVNLCTB4RkZGDQo+IA0KPiAgI2RlZmluZSBUU0NfTUFYX05VTQk1
DQo+IA0KPiBAQCAtMjcyLDYgKzI3OSwzNCBAQCBzdGF0aWMgdm9pZCByY2FyX2dlbjNfdGhlcm1h
bF9yZWFkX2Z1c2VzX2dlbjMoc3RydWN0IHJjYXJfZ2VuM190aGVybWFsX3ByaXYgKnByaQ0KPiAg
CX0NCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCByY2FyX2dlbjNfdGhlcm1hbF9yZWFkX2Z1c2Vz
X2dlbjQoc3RydWN0IHJjYXJfZ2VuM190aGVybWFsX3ByaXYgKnByaXYpDQo+ICt7DQo+ICsJdW5z
aWduZWQgaW50IGk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFNldCB0aGUgcHNldWRvIGNhbGlicmF0
aW9uIHBvaW50cyB3aXRoIGZ1c2VkIHZhbHVlcy4NCj4gKwkgKiBQVEFUIGlzIHNoYXJlZCBiZXR3
ZWVuIGFsbCBUU0NzIGJ1dCBvbmx5IGZ1c2VkIGZvciB0aGUgZmlyc3QNCj4gKwkgKiBUU0Mgd2hp
bGUgVEhDT0RFcyBhcmUgZnVzZWQgZm9yIGVhY2ggVFNDLg0KPiArCSAqLw0KPiArCXByaXYtPnB0
YXRbMF0gPSByY2FyX2dlbjNfdGhlcm1hbF9yZWFkKHByaXYtPnRzY3NbMF0sIFJFR19HRU40X1RI
U0ZNT04wMSkgJg0KPiArCQlHRU40X0ZVU0VfTUFTSzsNCg0Kcy9SRUdfR0VONF9USFNGTU9OMDEv
UkVHX0dFTjRfVEhTRk1PTjE2Lw0KDQpBY2NvcmRpbmcgdG8gdGhlIHRhYmxlIGluIDEzLjMuMy40
IG9mIFItQ2FyIHtTNCxWNEh9IEhhcmR3YXJlIG1hbnVhbHM6DQoNClBUQVQxCVBUQVRfUEZfVV9T
UjEgYml0cyAob2YgVEhTRk1PTjE2IHJlZ2lzdGVyKQ0KUFRBVDIJUFRBVF9QRl9SX1NSMSBiaXRz
IChvZiBUSFNGTU9OMTcgcmVnaXN0ZXIpDQpQVEFUMwlQVEFUX1BGX0xfU1IxIGJpdHMgKG9mIFRI
U0ZNT04xNSByZWdpc3RlcikNClRIQ09ERTEJVEhDT0RFX1VfU1IxIGJpdHMgKG9mIFRIU0ZNT04w
MSByZWdpc3RlcikNClRIQ09ERTIJVEhDT0RFX1JfU1IxIGJpdHMgKG9mIFRIU0ZNT04wMiByZWdp
c3RlcikNClRIQ09ERTMJVEhDT0RFX0xfU1IxIGJpdHMgKG9mIFRIU0ZNT04wMCByZWdpc3RlcikN
Cg0KT3RoZXJ3aXNlLCBjYWxjdWxhdGVkIHRoZSB0ZW1wZXJhdHVyZSB2YWx1ZSB3YXMgaW5jb3Jy
ZWN0Lg0KDQo+ICsJcHJpdi0+cHRhdFsxXSA9IHJjYXJfZ2VuM190aGVybWFsX3JlYWQocHJpdi0+
dHNjc1swXSwgUkVHX0dFTjRfVEhTRk1PTjAyKSAmDQo+ICsJCUdFTjRfRlVTRV9NQVNLOw0KDQpz
L1JFR19HRU40X1RIU0ZNT04wMi9USFNGTU9OMTcvDQoNCj4gKwlwcml2LT5wdGF0WzJdID0gcmNh
cl9nZW4zX3RoZXJtYWxfcmVhZChwcml2LT50c2NzWzBdLCBSRUdfR0VONF9USFNGTU9OMDApICYN
Cj4gKwkJR0VONF9GVVNFX01BU0s7DQoNCnMvUkVHX0dFTjRfVEhTRk1PTjAwL1RIU0ZNT04xNS8N
Cg0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IHByaXYtPm51bV90c2NzOyBpKyspIHsNCj4gKwkJ
c3RydWN0IHJjYXJfZ2VuM190aGVybWFsX3RzYyAqdHNjID0gcHJpdi0+dHNjc1tpXTsNCj4gKw0K
PiArCQl0c2MtPnRoY29kZVswXSA9IHJjYXJfZ2VuM190aGVybWFsX3JlYWQodHNjLCBSRUdfR0VO
NF9USFNGTU9OMTYpICYNCj4gKwkJCUdFTjRfRlVTRV9NQVNLOw0KDQpzL1JFR19HRU40X1RIU0ZN
T04xNi9USFNGTU9OMDEvDQoNCj4gKwkJdHNjLT50aGNvZGVbMV0gPSByY2FyX2dlbjNfdGhlcm1h
bF9yZWFkKHRzYywgUkVHX0dFTjRfVEhTRk1PTjE3KSAmDQo+ICsJCQlHRU40X0ZVU0VfTUFTSzsN
Cg0Kcy9SRUdfR0VONF9USFNGTU9OMTcvVEhTRk1PTjAyLw0KDQo+ICsJCXRzYy0+dGhjb2RlWzJd
ID0gcmNhcl9nZW4zX3RoZXJtYWxfcmVhZCh0c2MsIFJFR19HRU40X1RIU0ZNT04xNSkgJg0KPiAr
CQkJR0VONF9GVVNFX01BU0s7DQoNCnMvUkVHX0dFTjRfVEhTRk1PTjE1L1RIU0ZNT04wMC8NCg0K
QmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiArCX0NCj4gK30NCj4gKw0KPiAg
c3RhdGljIGJvb2wgcmNhcl9nZW4zX3RoZXJtYWxfcmVhZF9mdXNlcyhzdHJ1Y3QgcmNhcl9nZW4z
X3RoZXJtYWxfcHJpdiAqcHJpdikNCj4gIHsNCj4gIAl1bnNpZ25lZCBpbnQgaTsNCj4gQEAgLTM0
Myw2ICszNzgsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByY2FyX3RoZXJtYWxfaW5mbyByY2Fy
X2dlbjNfdGhlcm1hbF9pbmZvID0gew0KPiAgCS5yZWFkX2Z1c2VzID0gcmNhcl9nZW4zX3RoZXJt
YWxfcmVhZF9mdXNlc19nZW4zLA0KPiAgfTsNCj4gDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHJj
YXJfdGhlcm1hbF9pbmZvIHJjYXJfZ2VuNF90aGVybWFsX2luZm8gPSB7DQo+ICsJLnRoc190al8x
ID0gMTI2LA0KPiArCS5yZWFkX2Z1c2VzID0gcmNhcl9nZW4zX3RoZXJtYWxfcmVhZF9mdXNlc19n
ZW40LA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgcmNh
cl9nZW4zX3RoZXJtYWxfZHRfaWRzW10gPSB7DQo+ICAJew0KPiAgCQkuY29tcGF0aWJsZSA9ICJy
ZW5lc2FzLHI4YTc3NGExLXRoZXJtYWwiLA0KPiBAQCAtMzgyLDExICs0MjIsMTEgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgcmNhcl9nZW4zX3RoZXJtYWxfZHRfaWRzW10gPSB7
DQo+ICAJfSwNCj4gIAl7DQo+ICAJCS5jb21wYXRpYmxlID0gInJlbmVzYXMscjhhNzc5ZjAtdGhl
cm1hbCIsDQo+IC0JCS5kYXRhID0gJnJjYXJfZ2VuM190aGVybWFsX2luZm8sDQo+ICsJCS5kYXRh
ID0gJnJjYXJfZ2VuNF90aGVybWFsX2luZm8sDQo+ICAJfSwNCj4gIAl7DQo+ICAJCS5jb21wYXRp
YmxlID0gInJlbmVzYXMscjhhNzc5ZzAtdGhlcm1hbCIsDQo+IC0JCS5kYXRhID0gJnJjYXJfZ2Vu
M190aGVybWFsX2luZm8sDQo+ICsJCS5kYXRhID0gJnJjYXJfZ2VuNF90aGVybWFsX2luZm8sDQo+
ICAJfSwNCj4gIAl7fSwNCj4gIH07DQo+IC0tDQo+IDIuMzAuMg0KDQo=
