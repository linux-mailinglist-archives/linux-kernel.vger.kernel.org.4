Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA21612A88
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 13:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJ3MLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 08:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3MLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 08:11:41 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA8C774;
        Sun, 30 Oct 2022 05:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667131898; x=1698667898;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G8hcwQ2g6/qUXWBpkivPnLcnjFxOkx41QLMTCwkvZbY=;
  b=dPZL7pTbCVXCAfUCNiJqgJ85hAzkS+vDVpXbkqsug9b9am/skU0Z9rxO
   N3WkM2dQYXKVl51+UzS1yg/iawcAk7Wjp56NtyBtg3MzTTi50irWb0tR8
   SJx4Kul2Zu3yJwNKEMSnXHGTd/NayDZzQRR0R/Db1gf6yFjk6ylQ7yngr
   KHPSkVla3V7ICCK0xFWtCbPYuJNGq2JwnpANt1UMA+ModyAfzIgZB/GMb
   b/Xd5AOcJx4X9AvUN9spQIDQbwB70ciATw1juZf9xL8D24GoNNhwb3TTJ
   F1zb3CNtUpXtxslTE0+AmmYfYmN1GOkXJ/bLTwEuPQaJm66iKNnpBG24v
   g==;
X-IronPort-AV: E=Sophos;i="5.95,226,1661788800"; 
   d="scan'208";a="319398936"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2022 20:11:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0uYNhPa+ylTiYJAathyf8gPGuh5MScgzy7QRCLaAKI3BkZYG7eQUsTLwFU4i56RLcy2BwXQ8fKG+MgESFmjFM6qcFPsUCL0roueJ3UbN4TJXeQBSh4GBZO1IZOnjvzXguiUJ+Dk4T7kaWuw1PU9RaqqrVZFRrextEZygX8jPuBS+Tl8qmlyQGrz6zqfQr2LMDhz1TZB6KSuc2f9tP73I7OvtPmlR4LB4DCtNJSaUTsfSoK22nGhDJu5iJyKeufWGLV9/nlUvjE84/ERyFH23z+HsJErcKgrpuxveo+PMM1PnWgoaqMlFbLmo7QzFfnJ6Aa2Oa2dSOMG8G+TLUVkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8hcwQ2g6/qUXWBpkivPnLcnjFxOkx41QLMTCwkvZbY=;
 b=dfAzL3CfMfF/zTYXgIh4Cza88nqGIqI9U6aVOVsPWO297vD+gMUlHN4HqORQLYveyNiaZSkkNHf3CBcLyE430X9KG29MOKALCcWUbRmYRoOAD8VLjgjOD9UcdHrG7OHWQ6YPnHDJJ5uevsp7tRKtwP0g55AURNzTyGAsJTQxAFUlYRKBo2h5VjgSUunhRS62zixYwFyc/JnpE5UKd52FWtcubu+Quhtpn3qZYNmBMDxfGECYEWIHQ1EqfjlhRysMGsmCvQUFvlFLMATknT+Gbc+N5el8I1qzuwyzTKz2dy3bjAJCalS+gXIrkrQZg/sRCrlLiRXri5ofYhdwhdXl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8hcwQ2g6/qUXWBpkivPnLcnjFxOkx41QLMTCwkvZbY=;
 b=huer6qpHd3uFKadPwNosE0oT7DE1EIdJwUQkwoDjDDX6xGSHrp1vYS8RVLK/sIennNzyDy0ZXBgA/qXSA6AV8EL586sAtMLZPQC5s4SxgpqGnD8rEunZsFpSPOPs8QkVvWgIFNY926Gms4fqMCGfQaiDHXM/xZ75z8fqYrkRq2Q=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN4PR0401MB3616.namprd04.prod.outlook.com (2603:10b6:803:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Sun, 30 Oct
 2022 12:11:33 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::28ea:75a7:9653:f151]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::28ea:75a7:9653:f151%4]) with mapi id 15.20.5769.019; Sun, 30 Oct 2022
 12:11:33 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "eddie.huang@mediatek.com" <eddie.huang@mediatek.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 03/17] ufs: core: Introduce Multi-circular queue
 capability
Thread-Topic: [PATCH v3 03/17] ufs: core: Introduce Multi-circular queue
 capability
Thread-Index: AQHY5K6pQbBWCOuMJkKZT6LFvKbXIa4ix4kAgAQftOA=
Date:   Sun, 30 Oct 2022 12:11:33 +0000
Message-ID: <DM6PR04MB65752AAE8DA57C715C5BE3ADFC349@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <1718196085461c37138c194c49146efa5c5503dc.1666288432.git.quic_asutoshd@quicinc.com>
 <14a5925b-df2b-3f84-ed99-b4157c0a1b21@acm.org>
In-Reply-To: <14a5925b-df2b-3f84-ed99-b4157c0a1b21@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SN4PR0401MB3616:EE_
x-ms-office365-filtering-correlation-id: 6ab8a1da-2234-41a4-a829-08daba6fe2d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76GUDEZ9TGkr0Gd14kAlzaBoO73AHVvk4UNo0iw5DT5ipl/wq1PA05IzL19Q1dQ30XGOJL+RLOUzcAv9Uuveaxtsz/zY+KSihBmCxjMPvspRXJBKL39mCrcNcyW+RdTYclK4ajAwf49yr5V8OtIZwsZSvF8uUW7UQTlbjcgxrA/l30cccfXBJDgy3NIc76XY7l6DPS22Lku8AsB+zr1+6QzB8k2TZHDTVoXP3xYy+dTcx58Ky8KSvkNSly+65Om8pXFCJSSDLsYGX/LShnMDOixdqEWTUQEUAMMreOStfdX2xGJ7DSlJ2Igpvy78RtwVZY7ESUxSbHigFt1kw4YBGLlBa8bLd1yIjlR6/RocoDB6raXJ0f9n9YERvjCoxDe+mcvZvbZXSnqafxKOqyDqKPP4VniDh2Aq5nvorTLIsN58nTkyZ0K3IJys+R3/g+KmWFlvZZfyEX7P4N6sAwDwkBZKeH05yh+qhLgQwJEelqYKmGAVVmtColeIiVWYGA1YA+rQmzLLafVnZAAS6RNwcXhmmxLidvr58bv6tAfdWCFFyOp7jSl/Ht9wBfc9mIF0UGP8y9yBsF1aF5ZPsfqwrf8SlDkYFOXOASjMkVXBluvHsbEoS24OqaPmDLBAmqaFr8UmOnBoL/SdgMkhHIg7iTjJfD9gcu0mIxuMhlEBBUfrvOnzvNZeQvGkewweN3K5gPFbSUw7Cg3fhUOFRm/ikAePbW6F1PueXK2gV1Q5XftBjDFzpVvhN6u8TtJAyohL4iagpQ2AddmA0KMr6/Rgrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199015)(7416002)(5660300002)(186003)(26005)(41300700001)(4744005)(8936002)(2906002)(38070700005)(52536014)(9686003)(55016003)(122000001)(86362001)(33656002)(82960400001)(38100700002)(110136005)(54906003)(316002)(71200400001)(53546011)(478600001)(7696005)(6506007)(66476007)(66446008)(66946007)(76116006)(64756008)(66556008)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wnc3MFNyUjQ1d2Zralg2dTVLamcyaEM3c2xrZmxyT1JCS3k5UFRtTjNvRmg1?=
 =?utf-8?B?ZkloUnlIMkEwbkVlYUJic3pxMFk3eUNGdkozb1VOOEo4c08yOGl5ZnQrb2Q0?=
 =?utf-8?B?UC9qVmtDSldDaUJjTEpDZC8wQW1rSlRqd2RCT3FaY2hadHBONG45THdPR2p0?=
 =?utf-8?B?cGJIRmVQSWFDWERsS25ZRTBhaFJUZ3huYi9mbWJuVCtQNHhWVmhuNC8xTFNy?=
 =?utf-8?B?SjcyL1l3NHVUc2lyU1J0RlJxVXQzK2VkS2dHSnhQRXV2ZDBDSUFMNW9oNnYz?=
 =?utf-8?B?QlJXTUFzSFk3b1JaaFhONysxWWZKblJtQWtKa044UTZDaHpwMUZxeHVad2hv?=
 =?utf-8?B?S0YrM0NtUk5qcE1wbHVhTUhoV1RGNHBrSkNrMCsrZ2lLMFZqck1XMU5ucFZX?=
 =?utf-8?B?TG9mK3ljQlRreXFHUTBXRGJNdXRZWmY4amhQYXVOVmR2aUlIYUh4anlaZHdT?=
 =?utf-8?B?dnZ4cXFzaXhUQnhDTUFIWEo0bCtwcWVPVFhRQ1ZYaUp0WThXQ09DbXlPWHN2?=
 =?utf-8?B?Uk50cHRlRFBjV1FPdjYwQmNLQ1gyRUF1MW9WZXlJelVDRTZCZXhYSjAyY2dn?=
 =?utf-8?B?SUU1RWVxSTh2NmlXUWxVTUJXcmZjdWlWK3BxSGcwRkJybmZVMWpjZnQzc3ow?=
 =?utf-8?B?YjZJamk3VnpPV1NDd2FRUnc4VGs1RVE5cUowYVdZTmY2WUtqZXVadHpWV1Bp?=
 =?utf-8?B?ejFOOXJ3M29BOXR2OEtBRW1DWVlMWXdzaU5KdlF5Z3JRbTZleGpRd2F3SlBj?=
 =?utf-8?B?VU5VVkRuYXVCZVd5a2I0M0ZJenR1M1BWZDVSMjlzSmlnbm5iOWlpOHIwcmJj?=
 =?utf-8?B?TVpFaVd0SFhHR1ptNTEvRkVKZ2psaG4zeGtzSGZBSExQT0NSZ1g1NkpFSmN4?=
 =?utf-8?B?dzZXc0xiY1JOQ1hlV3FRTVo1NG1GOFlxUk5pbUJlaFVXRlpTQlFlTUFMM0sx?=
 =?utf-8?B?dXFKVko3eDBwQVVCVDhRNnczdG02QzA0Wjl1NmVXQXJSelZEVm5tMEdXQ3NL?=
 =?utf-8?B?b25zY3pzb2YrNmcrTDJsbTF2VXpETzU0VDdvZzd6WVFXZVFRRzdOWjN1S0l4?=
 =?utf-8?B?K1JzS3dJeWVpekoxc2ZSMUtUUEw2STVPSyswcU1oUEFWUmlPZ2lRcVhzMHky?=
 =?utf-8?B?NGlVVFlaRkRDaUxCQjU1VEMzcHNCNTJldHZiL1BkNGwvUGNuOW9mZktueEFC?=
 =?utf-8?B?VW9rSnBObzBhODJrbi9HL1JPVkNCV0I3emhSdWp1YWxXbzRTRkJEYS9pNzlh?=
 =?utf-8?B?SGZBUVQrOVltRXpCYUw2TkNpa1FPK1dQMFgxekRzNXpUaTR5SXp0RzZ5WjlS?=
 =?utf-8?B?dHJ1N1dLcVRlSXk0SXI5c1RJZ2NjNFF0WDRzT1FQdUdXZnpTWkxMdHhvenNI?=
 =?utf-8?B?S3hYc1dBU0dNOUZpUGtRWlVnVk5HN01aa3Ewd2tDczBQa2lINnBoN05NRGlw?=
 =?utf-8?B?L1JXbWUxNFVGRVQySmEreDFPaVVYVEQ5cm1VbjJnQ1BUbUJ3bDdZL3ZBTnFC?=
 =?utf-8?B?Sjdzek93clhIRWs0b2xwZUx2NlNaVi9JUzE5UTJIeDZYc1FoOExxTHdjOEU0?=
 =?utf-8?B?QTdnbzF4a0VxaElYd0FWdnlYNlBYTVI1N056RWY5dTJtSmdrSXNZMmtzblMw?=
 =?utf-8?B?aW1hcnBRUExYVHRiZnBZNnZoZ29PYXZ3MXpKYUwrMkREd0xxQ0NnckxNMnZK?=
 =?utf-8?B?N1BrenRaTWg5RG9LQ3o3VEJ0S1EwUUNHZGVnMTVUK3N4czI4Y3RXTEZYTDBM?=
 =?utf-8?B?ditzb1Zldkt4V2xEcVI4cEQ1WWcwSW51cjMzcy9SaHQrcGwzenRwdjVGb21N?=
 =?utf-8?B?MWZibVE0a1phNW1aVVRjcU82TUxGOE9rY09FUURvUklwYVZTcWtnQlAwY2FT?=
 =?utf-8?B?Qm5GK2hWQlNLUzNwTHhBd0FDbStXQUZmd1ExTm4wQk9FQ1pFUmhnZ3BjcXU2?=
 =?utf-8?B?ZS9pQ1F4dm1SMmJrWjZRUm45ZWRueUVqU0tTaG9uREo3SHI4VXExamxQMVI3?=
 =?utf-8?B?T0dtdWUyazVMT01DdHl5aEJRbTByTjNLUVFveFBNVm9DMi9Kcm9LbEhiRDN4?=
 =?utf-8?B?dEg4dmEzOUpMS0IzOWF3ZDVRVU9rQTdMdlF2UTl5eEltSTV3VFlkbzRJWEw5?=
 =?utf-8?Q?xxfBBApkYsx9An6ahlLfzs7Rl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab8a1da-2234-41a4-a829-08daba6fe2d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2022 12:11:33.5651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nqNF70AKSVOtiUWmzSISDrEwGo54jtusN0ltx/jpk0Ww2NfcaTMwlfP1TU79bRISOD3VLX2VL8D09XWbcnmxXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3616
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gMTAvMjAvMjIgMTE6MDMsIEFzdXRvc2ggRGFzIHdyb3RlOg0KPiA+ICsNCj4gPiAr
ICAgICAvKg0KPiA+ICsgICAgICAqIFRoaXMgY2FwYWJpbGl0eSBhbGxvd3MgdGhlIGhvc3QgY29u
dHJvbGxlciBkcml2ZXIgdG8gdHVybiBvbi9vZmYNCj4gPiArICAgICAgKiBNQ1EgbW9kZS4gTUNR
IG1vZGUgbWF5IGJlIHVzZWQgdG8gaW5jcmVhc2UgcGVyZm9ybWFuY2UuDQo+ID4gKyAgICAgICov
DQo+ID4gKyAgICAgVUZTSENEX0NBUF9NQ1FfRU4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgPSAxIDw8IDEyLA0KTmVlZHMgcmViYXNlPw0KVUZTSENEX0NBUF9XQl9XSVRIX0NMS19TQ0FM
SU5HIGFscmVhZHkgb2NjdXBpZXMgdGhhdCBiaXQuDQoNClRoYW5rcywNCkF2cmkNCg0KPiA+ICAg
fTsNCj4gDQo+IEkgcHJlZmVyIHRoYXQgdGhlIGFib3ZlIGZsYWcgd291bGQgb25seSBiZSBpbnRy
b2R1Y2VkIGFmdGVyIGEgbmVlZA0KPiBhcHBlYXJzIHRvIGRpc2FibGUgTUNRLCBlLmcuIGRpc2Nv
dmVyeSBvZiBhIGhvc3QgY29udHJvbGxlciB0aGF0IGlzIHRvbw0KPiBicm9rZW4gdG8gZW5hYmxl
IE1DUS4NCj4gDQo+IFNpbmNlIFVGU0hDSSA0LjAgY29udHJvbGxlcnMgbXVzdCBzdXBwb3J0IFVG
U0hDSSAzLjAsIHNob3VsZG4ndCB1c2Vycw0KPiBoYXZlIGEgd2F5IHRvIGRpc2FibGUgTUNRLCBl
LmcuIHZpYSBhIGtlcm5lbCBtb2R1bGUgcGFyYW1ldGVyPw0KPiANCj4gVGhhbmtzLA0KPiANCj4g
QmFydC4NCg==
