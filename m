Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF8261692D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKBQeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiKBQeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:34:05 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2091.outbound.protection.outlook.com [40.107.113.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321B75F59;
        Wed,  2 Nov 2022 09:29:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4Eh8ehyNZv/+KztMVx5ZNrxTrr+3YEMZUy4OojEnIXGUv/GQNx+nydSB4buzWxUlz0YQVsxCwC2Wp74u74TCSGJX75j2qSlLr0O83ii2SpWTI9OqftB8pCb7Kw37GbdyQC/WS1we+YuqPVfp6gaqjkVLqDtmzyEbUUUN2AWA3R+isK6TYJfxqEQ/6QxZ11NzsPGk65wTd+hGsn649p4Dd9tuZFZ5qHHVwFvAI0AIiIteMR3Z+hE0BQAcBfkfwNtri2aEMQdxXutuQrAWSOIZM2Nf1TQQy5btZ1IJt18c6QBLt/aQi0J01+XxAwtKkA2Q9X1xDQTnWwvF73iZXTbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ujt5XSFLSvAaONwuTOqvOTaMiN4mltRhUCuRgiz9vkA=;
 b=URuE/f1c8VDg+3qA7dxYidi7YgtjzhemR14pGzZtKINbcs6YKpCDJTy8M6TYGZJdzxV7vmp9X1aQ6u6vJoHfnzbZhWN9RqItjuKk/ufcAT/ixog0MqGBhFiWu5Zbe3atN/Iw9lDQjg/WSAeaJt1pIEBswtdjXZLQRSHdsfw8+Q06lmCSOlFNkKXf4yUqvtocAhzb+szaHAsHMmLqvvxBFCCsDSV3L64QB/d4cv7lf+uw9uAoIBj+fbRWcPvXVwunk7vMJ4fCZjHneApVMws2g6++Pm9d4DIZo4LB96JdS4tNRsZ9As3DhzLO9F7MkJOxxHReWyxAhBR3hkEzWzAeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ujt5XSFLSvAaONwuTOqvOTaMiN4mltRhUCuRgiz9vkA=;
 b=CxM6ajJMqbElm4aeet0K1yETmY70bAMOnHVJaDilM4HbPO2SVBxiCtdr58ylqf2OZzGpmC1Yv8B+yl01ma/vOlpEkJIM87GHyGmRNvXjKb1rYvDrXM9QrF10xH4w0pvue3EBIgtgu7reMCKOHBpugWw4+34UYNJOKUOLnXIO4AU=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5843.jpnprd01.prod.outlook.com (2603:1096:604:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 16:29:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 16:29:44 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "sven@svenpeter.dev" <sven@svenpeter.dev>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] pwm: Add Apple PWM controller
Thread-Topic: [PATCH v2 2/4] pwm: Add Apple PWM controller
Thread-Index: AQHY7scaJddHyAtwqkGPO5YDCJjX564rwPswgAAJOYCAAABF0IAAB4MAgAAAYqA=
Date:   Wed, 2 Nov 2022 16:29:44 +0000
Message-ID: <OS0PR01MB5922EC4F1AF0D8501D7CB1BF86399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102141513.49289-1-fnkl.kernel@gmail.com>
 <20221102141513.49289-3-fnkl.kernel@gmail.com>
 <OS0PR01MB59227A9E7B8A471E4D6B665786399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMT+MTT1ptFymwDdOe=OXYzKfOPHdQbAfpx_9LBYn+C9NFhddg@mail.gmail.com>
 <OS0PR01MB592217539BCA46FD8F523C2386399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMT+MTQLJZsDSOtcQqV8e_j0XKfjNm+dVjeo7ocMjcYOPLAPvA@mail.gmail.com>
In-Reply-To: <CAMT+MTQLJZsDSOtcQqV8e_j0XKfjNm+dVjeo7ocMjcYOPLAPvA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS0PR01MB5843:EE_
x-ms-office365-filtering-correlation-id: 3bd8b60b-c028-4f34-adb1-08dabcef733f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tw6WzrkEv2DAjrAS6vQe0FXpzubx5zfRnWsIyn028fwT8e0TIfdbWIjv+/2pOB0N1uK7TMnJTLIKNK4N4G37UMGFGvG1c6h3XTy3oNKBaAO1NwZmFj2cDbBWWXpBQ92oi3zFMYV5j7RgVrilOnpqcp1J15yrRh1YGtbUx1SHxhPMYoAp1IYSNCANs8/Ew4KFP1ClHH5OGQy+FQ2vXfl4j5VKlNI49NeDsAI2640sA+4Mtt1l7UvKHNthdEsEzpljHIik3Q6pttuYCnIsbweoetYgFB6BIuA22gt/mePeIc0+RgR8QCoYpUxBUiJvXgIaxWWtJCSJXa0jp2sOeV4l5H5+ZZQVwVEOUCow1QeuM/RgDYPfV0G4vznCe6Hj2aD3V0CqCaHsNpoAm0PMNe+YVyyJd3pXjX3V1PWZEwWvlevo6gSpvmWdJsJZMrBSkxS+DvzsqKZbiaaPFs/UfiKqOnZ55MqVbMCNENDvYKcsK3ao8349+fgkJnhcwUkujH+e1yr9E2HysCOHj2ZQy+SvcUblqWxBTNUIS6q0BNfyDBc5quli5b7SqTAHniTVAr32YBy0lqUEooYm8xMmmAmy3OyBxSJjeX8CQA2DfIA9UyueMO3C3UHL4MUkTI3601uWJwoRITQq20dTw8XKkaecm+0wmCbPidy0A+cwKt52sdgqvwQSB+dFC/PdwkemknEyWb4TlvDfY9JqEaViYQyCT2VKj05Wgilzw/EchWNAWOwVCWF8ggwsiJUMQZu/61Y/RpIJ/Jk5tow2EHMs41gue/JR0+6eyInFLO6blO+44qo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(47660400002)(451199015)(55016003)(41300700001)(66446008)(66556008)(33656002)(6506007)(4326008)(76116006)(54906003)(6916009)(64756008)(66946007)(66476007)(316002)(38100700002)(83380400001)(7696005)(8676002)(122000001)(52536014)(8936002)(5660300002)(9686003)(86362001)(7416002)(26005)(186003)(2906002)(4744005)(478600001)(71200400001)(38070700005)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V29jOTZuVmhSeTlMbndPZ0l3cE9HcTBWcVBna1RmY3MwZVk3QjNva25SVWJa?=
 =?utf-8?B?Wlg5cDY3R2FOWWpKTmVwVDMrVUNaOW9hb3R2MkVERTlFZlUwcUVwc1VVaTEv?=
 =?utf-8?B?c2J4NWhXejdvUzZiRllzS3BaR2NSRXdja2s2U0lnUVNXZU9SRzRiK0FKcllq?=
 =?utf-8?B?bWtSc0JTeURwVWNndjkvZElOU2I2MkxPS05WMXdrQkdvWUo1Q3pPWEg1UzlU?=
 =?utf-8?B?eEVTRTRDNWpQY0c4ZDRsOXpySDhEOHRZMjc5bXU2RStMdTJzbkQ5d3Y1MXZ6?=
 =?utf-8?B?ZkhyTGZuT1Z3Q3FvUUZPdmhNRkpQM2t3allsZ2hJMnlvNk1YajRTUktqUmQ0?=
 =?utf-8?B?aU1qeVhCS3BtZE91ZkpITm00RUx1Q0JieUlSdVI2QnQvQlJydkcxR2k0eFNM?=
 =?utf-8?B?Qjc3RkdmbVhZcWdMUTNmZlg0VHl0clk3cG9pbDNLRVF5RWRWK2JzQXd1VURY?=
 =?utf-8?B?TlZaUkNGdXJza20wbEM4MkdaREZKSVhCQnBkN2dNTmYyTHR4MXE1MHJSblYw?=
 =?utf-8?B?UW1LS0lzcnpOeUZGZU5CTWFWUDZQQ2tRVGdIeEp6d1YvSnZqQTFaUU16eHF4?=
 =?utf-8?B?OUtqb2dpQmlTb3BaV3RQRXBQck9XT2V3YmozSmdhV2tXOTRwaVVtRjNUc2dm?=
 =?utf-8?B?d0VWK1dTWUNJMFhZNDQ3eGtOTmUreDVvTUVpa3FaQzJDaHovU0VpdTJYNjRM?=
 =?utf-8?B?dTNaaytTS0pWQkMwRTJBWUczRlNJcFNVeitZTUJEbG5FRUN4N04zSWp6ZkQ0?=
 =?utf-8?B?dnoyWkRWRXJrRHhLT1Qya056U2gxZ0p5QWs2MVpKYktMVGZiVXRoSXE5OGFv?=
 =?utf-8?B?Q09oQUc0bFk4bW0xakN6cysyVm5XUjYxTGJHbVpUUzJvalZ6Z081cE44SjBv?=
 =?utf-8?B?cldSN1NNSmlQelRXOHorMFJoR3VDa2FXbDgycWVTb1RhbVFGc3l3bnhPeHBn?=
 =?utf-8?B?WWFwOU5LR2NBd0RJeGJHRVJGSEw1V09FZ0hxTFFzV0J2RHlkcUNCdGhJclBO?=
 =?utf-8?B?UmorTk5CNjdzdXdsNVBTMWRHTUVUN0dBa1REdkRsNXBTdk5Ea3dYQlV5TnZq?=
 =?utf-8?B?NzE2aWtwYmx5YjRSbDFnRml2d0RGOFhSQUdXem1LbUxlaUV4bzdSci9Ham5a?=
 =?utf-8?B?OFZaL3kxTERlLzYwMmI5S3g1K2t4amhqbS9BaHlWTFVrcDlzSk1MUkd3c2pM?=
 =?utf-8?B?SitZQWJMUDRvdjJHT1R1ekFpZFMvV2xIdUppNXI2clZtKytXSVBBd2lsblBH?=
 =?utf-8?B?N09Gb3NlZVZ6UFVnZEhkcHFNQVZZbzBnUlY5NCs2c0FvL01oMDZSWDFNL2FW?=
 =?utf-8?B?NExnUUJuTDRhSVhEcUUyY3FxbHJOdGw3TGVaeTFPMWhEOG9zanY1WkwzRWdk?=
 =?utf-8?B?NkVoWEZxNDc5QUxBNkEySGxjK2QrWUp2bE1TY2twNzdrTExzanlzOEdrSFRo?=
 =?utf-8?B?U21oNDdsc01nL01EQzNhWlVGNXdFZVlUZEZUSXJ0QWp0ZlM4YjZ1Z25wZEMx?=
 =?utf-8?B?N0djYk1lYjBJaHBGREtmeituYkwwVE9jeG04WjFTcnJWc0ZxVUlOUWVxdkJk?=
 =?utf-8?B?alFIdWlTdzJjb01zZkc2OTd4bG90eTJkYVdnTHE2d0cvRFlmYUwwVUhCVU1y?=
 =?utf-8?B?R1JvVTgySktBTTQzUEx0a3lyQ2pTbXRRbTg5QUx0aytRZ25nTVFhTWlWY0RX?=
 =?utf-8?B?ODBaVDNhbUxIS2dIaVQvOVk2MkZwdmhET3lsU3dacmRhSThzZlFUOTVsUnhz?=
 =?utf-8?B?M0dKM0JMU2N1WGxNVjVtNTBWNlVydjBkVHllUXJyVzg0WmdLRTZ2RGJNU3hu?=
 =?utf-8?B?TTFyNy9VT2hQc2xZbWl4QTFjblVPYncrcWdnc3puZk5hc05XM2RVYmJXbnBu?=
 =?utf-8?B?UE9mVjdrRzB4Sm5aSmtXMm9HSCs1VjdIbDJQc2RHSGN0c05FTllXYVZSNmJs?=
 =?utf-8?B?cTJqdzFETjZZOEV5cXpwN2J1d0lUWG1paW5TU05xcjllcDhMRUlIaU5mM3ZG?=
 =?utf-8?B?a3FQWWxMMU1ZOHJjWnc2WFNTRWdvZEdaVUM1ajFCSU1YckRGSEthQVpQS1ZE?=
 =?utf-8?B?SG1HYjF5VmtxNCsrNk5WQkpFVXlWaTN0eGxsWmpVbGVZME42Rm94ZWE0Wnlo?=
 =?utf-8?B?T1R5eXpMaVpUMS9HZWtCUWs5ZDBLYm55ZkcwY0tRdi9SL1dxdzZvNzJoaVd4?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd8b60b-c028-4f34-adb1-08dabcef733f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 16:29:44.2792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1P2nLJjESLZQZOHKURXmAU6F4X3fC44IKi4sP5TDKREdycKpIDt7pq3JYqSb8+t7QBSyU198k4nURVKaT2s78gtlfQEA44ocJ4JPebGxGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5843
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi80XSBwd206IEFkZCBBcHBsZSBQV00gY29udHJv
bGxlcg0KPiANCj4gT24gV2VkLCAyIE5vdiAyMDIyIGF0IDE5OjAyLCBCaWp1IERhcyA8YmlqdS5k
YXMuanpAYnAucmVuZXNhcy5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiBJIGp1c3QgYXNrZWQsIGJl
Y2F1c2UgeW91IGFyZSB1bm5lY2Vzc2FyaWx5IHR1cm5pbmcgb24gdGhlIGNsb2NrIG9yDQo+ID4g
aW5jcmVhc2luZyB0aGUgdXNhZ2UgQ291bnQsIGV2ZW4gaWYgaXQgaXMgbm90IHVzZWQgYnkgYW55
b25lIGR1cmluZw0KPiBwcm9iZS4NCj4gDQo+IEl0IGlzIHVzZWQgdG8gZ2V0IHRoZSBjbG9jayBy
YXRlIHNvIGl0IGNhbiBiZSB1c2VkIHRvIGNvbnZlcnQgYmV0d2Vlbg0KPiBzZWNvbmRzIGFuZCBw
d20gdGlja3MsIGFuZCB0aGUgcHdtIHVzZXMgdGhhdCBjbG9jaywgc28gaXQgaXMga2VwdA0KPiBl
bmFibGVkIHdoaWxlIHRoZSBwd20gaXMgYWN0aXZlLg0KDQpZb3UgZG9uJ3QgbmVlZCB0byBlbmFi
bGUgdGhlIHB3bSBjbG9jayBmb3IgZ2V0dGluZyB0aGUgY2xvY2sgcmF0ZS4NCmRldm1fY2xrX2dl
dCgpIGFuZCB0aGVuIGdldCB0aGUgcmF0ZS4NCg0KVGhlbiBlbmFibGUgdGhlIGNsayB3aGVuZXZl
ciBwd20gaXMgZW5hYmxlZA0KQW5kIGRpc2FibGUgdGhlIGNsayB3aGVuZXZlciBwd20gaXMgZGlz
YWJsZWQuDQoNCkNoZWVycywNCkJpanUNCg==
