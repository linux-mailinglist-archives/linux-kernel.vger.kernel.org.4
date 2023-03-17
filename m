Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711F06BE793
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCQLGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCQLGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:06:13 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2139.outbound.protection.outlook.com [40.107.6.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FBF591E1;
        Fri, 17 Mar 2023 04:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9MTsYHZoZb1pZRuJQAYn7Zf/gydDNopilR+SNM0bJJWWFzQQNiGEb6uKqWm+VzSWCORdBQgggVFIqiy2QxLFnGlDrUEQjvEsT2Dw/dcTi1Xt6X2gUbYHIZMk6EZ9rlQKoD2j8isFXshM62opb53nQc94RVPje6WPgVeAql5TJHKTOgmkfccEMVBOP1S1zznlfrjZB4XNAfX7B23ro/VQNXZy8mia6mtM+h6xiuEidf19nHwFtjoMsCMsljyx83+o0FyAx2vZs/oanczSoXrgi4BGVCvimmabn5XQqM7JhfNzRK2p25U+jTikFH0eNJnAXIhNnvtqvZOSgv6TrtnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0u0rqsJ6QTSIpbNhgIIHywXnZ38AWAeXTY7xAZ/6uvY=;
 b=hbWVCFXvZAEqih/oWiZomFL+w/CpgU994leTiHKSfm8elUcoh0yX5ssUUENiLdDb/wohsZ+XwGPGO5k2UMQZRRTKRIOVpu7IhCIjZZJArRUe17C1tEeaCSoPsPbFXMzIjAqHUd0XVLb5YKMB7ZX/alSe2STXYHQR1D8n0vlzZhXy6CRpD8eRYHuvUARtyrxWbsLclo93v/Zd8fiBtWsM2ITWfFQxrtX44VR1G4JfEGeYJO1o5nRKCG2gZyacYm/rum3jnQ4BuJRyM5rdlGH4ZULr4nLagbVvtJmKOVGFPq4NnD28s7A5I9aiSRtjGL3I2aobfGesKlp+y4eNtpbi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u0rqsJ6QTSIpbNhgIIHywXnZ38AWAeXTY7xAZ/6uvY=;
 b=PPU3itQz6IMOs3U+ekuZGydIGpQzzpFA4ca+yOowjPTfWTxXdR4Rek3hsu2togbB18Bq9B74LOZ0sCgZ2HCf0qdIQZISTCBIensY4B/iI1JtlzuKMlD7bRUi0hOwi64NQJdxTyf3dGHA+mdizp3OenVXBDyY6yQV9Mbp85GGoSE=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by VI1PR03MB9987.eurprd03.prod.outlook.com (2603:10a6:800:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 11:06:09 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::8fbf:de56:f9fd:ccba]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::8fbf:de56:f9fd:ccba%6]) with mapi id 15.20.6178.030; Fri, 17 Mar 2023
 11:06:09 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] extcon: usbc-tusb320: add accessory detection support
Thread-Topic: [PATCH 1/2] extcon: usbc-tusb320: add accessory detection
 support
Thread-Index: AQHZWL02B0XQ7k2SJECfR72iow48zK7+y8SAgAADtAA=
Date:   Fri, 17 Mar 2023 11:06:09 +0000
Message-ID: <20230317110608.aw67izufvl24h4d4@bang-olufsen.dk>
References: <20230317104229.1392742-1-alvin@pqrs.dk>
 <ZBRGhcAeoyxMRMEP@kuha.fi.intel.com>
In-Reply-To: <ZBRGhcAeoyxMRMEP@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|VI1PR03MB9987:EE_
x-ms-office365-filtering-correlation-id: ac51fb93-2e5d-49f8-5ccf-08db26d79cf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTs6MoFCfUzWN642FkLWbSmNZd2No2oF2/wYOhiUpFXmdN0BAqp2O/IUdah1ykfPmKouGfnL/M7zEniE5hSvrjZHipBwsLf/rm0YaRoL+T449vckNrJ1n4La5lwNyCb88QRz2aOLWBpSdYaxzE7nxOSYJYtLx6b3yW+aOfDo2H7JWyO7k9V6C7+RqPBv4WbVmXwuGUVVt98XdRBV+WDlRk5WWwxDic0PBy8PmhwrLASprv82rjm4WL4tCZE7oc2NFf3zqVoQtd6pMuY7/3KtSphgW0z0DPeR6mfMOMk9a92TY3ZkrQtpsEBss0SNopBZq/QCNLjS36ZEEcVQwRfZsMcNJCLh/ZVlVM3ESM/7V8o4Nuvo7bf6lC04oXSOWue6ofySaPFOSYGaB/73fxX5Df1Mky4bCarZwME3HQ0nnFgs8FIxdiFCoyDvTnWPeKc806Zo0CbN0yZ1fqo44mn6H/qI2/sNCCsRsXhUuaGFpBHtUG8qK0gW69c00nI8IkIbe+1dbvHswVf2E+qsTiIm/MQPAhcBkTdqu+LtMFhfO9X3LwBM23bF7eEwH1y0H3YTKtBp6nU3oP9KJeYUjEJwD6/xayOnsXYUK1d/mysH2Q80UFTLkHZS02BCreWjKFE5qmsZWwixr8HZm0Yix3Up/mc44SDHrDBOZtdOebaL/5FFiQJOa7+wIi7xTpkr1eSAE9teP7ySSYi7yPF50FbXEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39850400004)(136003)(366004)(396003)(451199018)(186003)(66556008)(91956017)(4326008)(2906002)(6916009)(66476007)(64756008)(66446008)(66946007)(8676002)(76116006)(122000001)(2616005)(41300700001)(316002)(1076003)(6506007)(6512007)(26005)(38070700005)(86362001)(478600001)(83380400001)(54906003)(38100700002)(85182001)(85202003)(5660300002)(6486002)(8976002)(8936002)(71200400001)(36756003)(66574015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm1LWTB5dHNWN1dVcTFkZWoyYjJ3T01mckdmc1NMUkZ1YS8rUWhYVDF3cHVq?=
 =?utf-8?B?SjNaOW94Tmw0eUo3akxTWW5oSXpReTdRNmdWc2dMSlB1b0d6bUI4WWdhamdS?=
 =?utf-8?B?L1pRaDRhdlRkeXpmZ000V01yV1hFWW5MY24zN1M3dkJ2Mk1QZ055TDliVkpE?=
 =?utf-8?B?Wlg0VjRvRUEvZXFFRzArMU5Hd2Y4QWg1a2NkNzJzMFJucDJuaG01bFdVOEZ2?=
 =?utf-8?B?U2pObkpZeXFmc1kwdm02SkhHY3lHaFMwMU0xZ05NU3FaVzJKTFRPdHh3N2Vw?=
 =?utf-8?B?NmRxcHYrRVQrR09JbzlkL1JDZ0pqenZzeWN4akY2aitqMnZ4enEwK1k4aXV3?=
 =?utf-8?B?cU5NbGR3NHJKM0c3QjhuTHdPMHMyM0RwaDNMNTJPeFBGSUtFQmorLzVlSlha?=
 =?utf-8?B?TktEMVBLaXBnQ3hQZXdhb0lpdUF1bUpOd0NYU3JyNDVPeXZUTVU1dmZVaXFo?=
 =?utf-8?B?REhOaXZKV2htT3p3TDF5bEdQSDVUK05FbFFOWGsyT2xXajlNTFBKeWF2alVt?=
 =?utf-8?B?aTltMzNxVWFNcitBSGtSWUVFQjhDR01yUEt5bFU4VUFRZzhoYkRYUk44M291?=
 =?utf-8?B?T0l0all5dHNjYVk3RS9ZNlNpanZMd2w2WkthYXBQMUNLei9lZnpPRVZmbVBo?=
 =?utf-8?B?cVN1dHBJOXdXZHZEVlVtNWxocmZJQVZWVFpVUStkdWtnb0RqMElBTnNsRmZ6?=
 =?utf-8?B?MGRSK1VsYkVndVFobE9qay9oRWNnRy90Y1Bxc1R5eEFBSFRZY1c1aGZPb0Zi?=
 =?utf-8?B?V1ArekJTSFZpNkg2RERLTFFNeDVVVzUrd3lVV2NNUzNwZ05KSnBHeGZiU0RI?=
 =?utf-8?B?MFZiRDJPN3F0Uk5rcGlXSzUyVE1LemI1OHZXM2ZlYnJkOTJ4QXdEQmxXQ0tR?=
 =?utf-8?B?RXNyaG9wdVQzTlBDRlMzQWxMTkY3ZnAyUzFPalBBSW5UUEhWMithSVRtd1lt?=
 =?utf-8?B?Rk5KVmVpU2FTclN2dDBFcU82ZjRoTW9jQnZ2K1k3YkxmOVFqR0k3RHA4SW9s?=
 =?utf-8?B?M2h5QmVsa2JhUUpCZTRrbXVYZ3hyYk91VEVMcnhjY1oyaE44TkVRMkxkdGph?=
 =?utf-8?B?TTB0RjZXWWorTjRKTWE2S1RyMUdMV1Vva2p0KzJZZnMzQkZmaTRUKzVTWkkz?=
 =?utf-8?B?a1VhTTZrOThqbStOaVJoMWpLRS9HTEdvTStGY1NwR2haQlVXNU84aEgwVWtX?=
 =?utf-8?B?UGwzNjkxRGJYQlBKaVI1eTZrd2xpOXVwYVpHV1pZZS83Rkx2cnp3WFk3aEhW?=
 =?utf-8?B?ZWMrVnFnVTVSNlA2T3dzVDgyYW0wUDF0d1RmZTAzRlM3NVVNUUhDc0kzNzNH?=
 =?utf-8?B?cUNQNzFlRlBsMXd6NFBqS0hQZUM4c1JHRXlvMjFPdWg1V3E0OGI4M0M4VWMv?=
 =?utf-8?B?cUJvdmpaUFVSZVBBdzBmSXpwaFQ1MkVST0FFa0JiQzh1US9SdEVrTFN3c2dB?=
 =?utf-8?B?YzZoa2JkRW8ycWl0aDhQQkpGWG5XSFErcEpKWTIxU1hxZTB5TnlXK2xFQlZZ?=
 =?utf-8?B?OUx1ajZEQjd0MEFrTG14R0NRbCsxU0svN2FBSTdBazBTTzcvTzF0RkdzM3ZZ?=
 =?utf-8?B?Z1EzYXcrc2VoNEt1VFNmVVdQcVVLM2pHb3ZzbkpxOTd0SitoZm83Qm9wYzNN?=
 =?utf-8?B?OUo2ZmtFTzFDUFhCWE1Rd21VZFZKL0prb3JrWVpPRTRJOUxNcVpZeTliS2px?=
 =?utf-8?B?TXN5cFZ3S29NM3o1RzVUVjNzQVExS2IwOHJ0aEgyaVh4aHBOZVFBNmx3WnVv?=
 =?utf-8?B?M2FiRjJHZjFROThPdWFJNEJQRlBTb3VZTm1pWGZ6WGgyUm1zT2pUdW5Nelcr?=
 =?utf-8?B?THR5SDFOOFBhdEJaZXBSb0thTnljVFgyd1FqYkFDeWJiWmVqWlRqUWtieHBI?=
 =?utf-8?B?SHlHdVRkZ0FLZTdEVVhHREs0dlgwa0ZLc3lpc0tjSU9ScDlDRkI3UWFGYWMy?=
 =?utf-8?B?RDlLTUw5ZElienRqQTIxSFVBYlJxekdzWGE3aUV4dlV4TEVBN1UyMkQvbDVC?=
 =?utf-8?B?ZUxBOGlpY1p4NE9KTitvZzdjZHJjcDJWWE5DNytqdytBQjVGcTZEbG5oYmdT?=
 =?utf-8?B?NlhFRzI1emR5R2hOKzFvRFAvRnEvbGFFU1FoZHVVVzN4bitHd0FiZWIwRmJs?=
 =?utf-8?B?bVUyTmZjUXp2eHZRRUJwejdwc3NrZjlCdWZjRWVablZ6K2ZjQ1pYdzM4YkZB?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E07604382728D84EAA03C640A0FB04CA@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac51fb93-2e5d-49f8-5ccf-08db26d79cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 11:06:09.5672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZItU6K3jNENg0javb5G248eePW96Efz3Ii2DqoCwwNmJ89+xKYMQ0SEUh4EKcIMh5KL33O1OWdkcR3BL/iU/QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB9987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXIgMTcsIDIwMjMgYXQgMTI6NTI6NTNQTSArMDIwMCwgSGVpa2tpIEtyb2dlcnVz
IHdyb3RlOg0KPiBPbiBGcmksIE1hciAxNywgMjAyMyBhdCAxMTo0MjoyN0FNICswMTAwLCBBbHZp
biDFoGlwcmFnYSB3cm90ZToNCj4gPiBGcm9tOiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9s
dWZzZW4uZGs+DQo+ID4gDQo+ID4gVGhlIFRVU0IzMjAgY2FuIGRldGVjdCB0aGUgZm9sbG93aW5n
IHR5cGVzIG9mIGFjY2Vzc29yeToNCj4gPiANCj4gPiAgIC0gQXVkaW8gQWNjZXNzb3J5DQo+ID4g
ICAtIEF1ZGlvIEFjY2Vzc29yeSB3aXRoIGNoYXJnZS10aHJ1DQo+ID4gICAtIERlYnVnIEFjY2Vz
c29yeSAoREZQKQ0KPiA+ICAgLSBEZWJ1ZyBBY2Nlc3NvcnkgKFVGUCkNCj4gPiANCj4gPiBNb3Jl
b3ZlciwgdGhlIHR5cGVjIHN1YnN5c3RlbSBjYW4gYmUgaW5mb3JtZWQgb2YgdGhpcyB0aHJvdWdo
IHRoZQ0KPiA+IHR5cGVjX3NldF9tb2RlKCkgZnVuY3Rpb24uIFRoZSBpbmZvcm1hdGlvbiB3aWxs
IGJlIHByb3BhZ2F0ZWQgdG8gYW55DQo+ID4gbGlua2VkIHR5cGVjIG11eGVzLiBBZGQgdGhlIG5l
Y2Vzc2FyeSBzdXBwb3J0IHRvIHRoZSBkcml2ZXIuDQo+ID4gDQo+ID4gTm90ZSB0aGF0IGZvciB0
aGUgRGVidWcgQWNjZXNzb3J5IG1vZGVzLCBhbiBlZHVjYXRlZCBndWVzcyB3YXMgbWFkZSB0aGF0
DQo+ID4gZm9yIHRoZSBVU0IgZGF0YSByb2xlLCBERlAgaW1wbGllcyBIT1NUIGFuZCBVRlAgaW1w
bGllcyBERVZJQ0UuIEJ1dCB0aGlzDQo+ID4gbWlnaHQgd2FudCB0byBiZSBtYWRlIGNvbmZpZ3Vy
YWJsZSBhdCBhIGxhdGVyIGRhdGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWx2aW4gxaBp
cHJhZ2EgPGFsc2lAYmFuZy1vbHVmc2VuLmRrPg0KPiA+IC0tLQ0KPiA+IHYyOiBubyBjaGFuZ2UN
Cj4gDQo+IE5vdCBhIGJpZyBwcm9ibGVtLCBidXQgeW91IGZvcmdvdCB0byBpbmNsdWRlIHRoZSB2
ZXJzaW9uIGluIHRoZQ0KPiBzdWJqZWN0LiBJbiBhbnkgY2FzZSwgRldJVzoNCg0KWWlrZXMsIHNv
cnJ5IGFib3V0IHRoYXQuLi4gU29tZW9uZSBsZXQgbWUga25vdyBpZiBJIHNob3VsZCByZXNlbmQu
DQoNCj4gDQo+IEFja2VkLWJ5OiBIZWlra2kgS3JvZ2VydXMgPGhlaWtraS5rcm9nZXJ1c0BsaW51
eC5pbnRlbC5jb20+DQoNClRoYW5rIHlvdS4=
