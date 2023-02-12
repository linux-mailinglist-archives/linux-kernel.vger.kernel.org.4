Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09175693663
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 08:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjBLHnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 02:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLHnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 02:43:14 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B0D12589;
        Sat, 11 Feb 2023 23:43:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKiQ5IQ1Y8t7HkiYzAZR1PME17zmog0UOguGimn7kgrvKW0xYA7nR/jN627g7/beYGDdYV+9xhQl/vVWwxpKHQEfYdhl76xdCNE/DpYOjeuIqIbd17u+dQDs2Sk0LHzojTnU8tGGXsaso0Cx7TD04V6A1H+HUI/kFC7QUu5yh18voaVlvs2nnF+NYaoZLLRDYvXrR+ySeMoY8lTtPcFLibkShf7lqZyOvfNtmJ9jf27ZTwf5FpAZvyq34VCWx8IZigTKBsaKZ0YBn1LVl+e7ZE+O76hWuSjvoztPV8TMVaQNL2J29LLQjDzVm8abKjhddabysvxPLdYr40bbl5HTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPfwLj4oSeuOlKuCXHhX+WSqcKddoU6DkYUALnHMCpU=;
 b=cpMySp6aIgQwbAFzgiEyLrTNjHRC/8u+byRGbliFDHa+C+cWQT0WVGibzhJMW8ZJJT7tsOPhLmRtqZAlK6aB1lzS3fC0QajHV9dQW94a70RTnolKYHZwAm9dEujeeldhM+TgXq2HDmC+63EJUgfzIVOjXhbOVVN3QJh3S74Uaq9kaXRimhwZ5uLv6yQ/YnfYBfEBDBWIxGJhsiy2L3aZ7JVwLxzdpmaHfsBLjkosjyobjOrOphm83vkAiEQARvqZSG4tNeIj1pPI5gQtJFgT+vH9uMlswEPKL2QOxCsfMpV98STezFVhMXZMTAwLLEOx1FGwkY4sLbT5e3iHMRJ03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPfwLj4oSeuOlKuCXHhX+WSqcKddoU6DkYUALnHMCpU=;
 b=HF8CzLLyQhmzbuQCJsnxea/WmVsU+zr6lEUSqMO5YD/O6C+5cRwhGk+PWkK2CHo0LvsIY4hlXuhzaiQDSoi2s6ORAtvb3qPZJynYn+WSKiZ+QwfNuGN5YMke4LwXIvbQRpAP50o6kt80YIzOUFUj3anSyHbBej4oIor1VUBklFU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9639.eurprd04.prod.outlook.com (2603:10a6:102:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 07:43:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6086.022; Sun, 12 Feb 2023
 07:43:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
Thread-Topic: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
Thread-Index: AQHZPFDqe3x+XiqXkEGr13W+xYm5Oa7INRGAgAK83VA=
Date:   Sun, 12 Feb 2023 07:43:05 +0000
Message-ID: <DU0PR04MB9417A9B81B86FAC0A477063D88DC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
 <2c4997fa-973c-dee4-9b26-6b38a1ca4540@nxp.com>
In-Reply-To: <2c4997fa-973c-dee4-9b26-6b38a1ca4540@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB9639:EE_
x-ms-office365-filtering-correlation-id: e2666f8c-9f62-48ac-45ca-08db0cccc742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m24l7B8wNBAba7Ke39qEiKZEn2FOjrZJUWzXanwo+RbXdcjuuecb16QetHj3w6Cmm60Y2U3SY12u99HqSM5a8/2ncBUpIkxGfF7czg0lySqniN6iLd1cY7+hcbomQ+t19hSuVEzJTCLdbnZBlBar8LdQ/Mrm0++Db5UFC6PsSPYKC6tBBHrm/fx8i+zuHAvbdS0YdtT3Xp5oKpDMvpktzCGz0bcjrLB+CxJ1P7OP88RryRxa9DqJKgvLYGLRkpD9vKb4iZCVIj9F05gT/a64NIaGe8lIlKwf8sJV77jXix8rCcwdy/yiQB6myYBHZyAplitUaidthQNjr4/NYS/Qx5E5Pzf3RRyPGh7zY5Dsp2zfJ2sNoK4wEBt59KQn878R8gzEhxDWdUHCK1ZF8CcHEvJs4Qx0hIkyCq6f5eFWCcwlq4keDQ2KfxY916NSEzIXf/39gMHFGQa5ONJcYcdil5PDCM7CvmBSO045mZLEXy/HgDN3MRgBQiJJwNQE4tlxLRXdRmVMbtgIfyVVe3A/65y9FpePQG0tZrmGYVte1zL0ZaCfF8RmghANM3bkjLq7HB/1GVXKONSvSPQyp83PjHnO/KIYaXJ7PRuR8XAT+mMKTrBBaupTXEKfV18SlEXUmFQkye2/9BDlIiPI4v8A/QrayaIQfOG/6cH6rdD8ok6XQzQs8UsrNan+yKqqyxmu2BUooUgkaLq/VyXzyOk9hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199018)(2906002)(44832011)(86362001)(83380400001)(55016003)(122000001)(38100700002)(38070700005)(76116006)(110136005)(6636002)(316002)(54906003)(52536014)(66946007)(8936002)(7416002)(5660300002)(4326008)(66446008)(8676002)(64756008)(66476007)(66556008)(41300700001)(53546011)(6506007)(186003)(26005)(9686003)(71200400001)(33656002)(7696005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEpZL3h0WnVpV1VsTmc3alhrTHVxVE5IcmxYMnRHcWw0VXVVTGltbUFSRHlI?=
 =?utf-8?B?NDB3R1BQZjRyVG5PWVJvRjJhV3NNOGJzQUJSQU5ZcVIzeERnSDFudm5Mc3No?=
 =?utf-8?B?aDBLbXZ6ZThveXJ2Nk1nSk44dWZ5OTFsM3Z0NEVOTEVDQ2dmb1l3dHRSWXF3?=
 =?utf-8?B?QUEyNitsYSszcWJiVmViUWhCZHlSY244bFFvRnF0MVBzcFhQUU1XNHQxK3RX?=
 =?utf-8?B?NGc2dkJwN3Q4MmYveFVrK0R6ZlFKZ2dZZElYdmZGWnF4SXhqc1ZqOWR4RWF0?=
 =?utf-8?B?MytNZkNoZlZXOHp0N2JMcGFIV2FZdjJSZXF4OTVPNXA3bU5UT2VHU1pTKzdI?=
 =?utf-8?B?bXVaWGtyQlJmR0tWb2VtQ2MrY3h0SytKNXNQSFJGRVZFc1pRZFMyMkhFSnVh?=
 =?utf-8?B?Z2xqeHpxOHVSMkNjMGpUV1lxRVFLNnpnOXZ5UnFoYzdFOUNRWGtVOEtJYVlj?=
 =?utf-8?B?TFhpYmhENTBxeUZQRXh1eS9PbEtKQ2lMZ0lXUWpwUWFrMlhBNFB4RGtlaXVn?=
 =?utf-8?B?eGF0V2NyRTEwSms2eUF1NkZqQ0lOclVRVnRLN2VIOHcrak1rUGQva3RsOURZ?=
 =?utf-8?B?WVlWeW1HWlhlMmRwM1NXWlEzTlc3d0VuT2xnVm95YytyRXNSbVBYQ080YlF0?=
 =?utf-8?B?MTg5bU01b0xjR2JpOU02NFNBZVZvMUFIZlhkNW8vNWIwWnZGb2hqY3BON2hR?=
 =?utf-8?B?UnVUUm9YWXRCUVVIbHcyQ1I0RnRmbmZDQ3Z0cXgyc0dCamVwMS9jVnkxZTQz?=
 =?utf-8?B?K0hVU1NXbDhiVER6UHRaN2ZXL0VjZ3RITTZiQ0MwRXVsWjRlL2xEZkFZS0dT?=
 =?utf-8?B?bHo2Vkt2UFdYYXU5b1htUVNpUTRFQjNrSlhVNHZIWXcwZFZHemtNZi9lQkoz?=
 =?utf-8?B?N25RaHdzY2JVNC8zVjJBbVk4NEVTKzFuVGN3VWxyNlY0eXVDcDMzRkJFd1Bk?=
 =?utf-8?B?NGNIUnVlT2Vmd0diVmwzOWIvS1FjTlBndzdaV0NKU2h2L0Erc09xNlhoZW1r?=
 =?utf-8?B?RFE2Z1lub2tNQ2plUmVJdDRsc0pzVmUvcmJESDVzTGlaU2hEQTg5MUZaVHJq?=
 =?utf-8?B?bzVlRVhqdStWWnRTYTg0SWpYaUtKWnN2VEl1VjJLYU1Ta0NtT05uaW9ldzRR?=
 =?utf-8?B?bGpvVitObklVZVJmZjV2cXpKSGsvbnNDV1ExMEVoZzlqMWJsSTBCbGtpQXJX?=
 =?utf-8?B?eGFlRHM0QmdBb1BNRkxPTnJZcllJemJPaG85eVo3RitzaVRMUU9YOE1sM2ZU?=
 =?utf-8?B?bjI5TmJ3Wi9nTlIyRVlJZDJGc2dLa1hZR3UvRitRS2YvZnptOGRFWEdiSHBJ?=
 =?utf-8?B?ZmdxUU90TWRuQSthRG1SMjZ0Y3o1ZFRjMFBHSndEVnFycVlzdjJtR3cwVWVR?=
 =?utf-8?B?Y3pTRm15My8xUUMrNUwvMUlDZHd1MHBPVm9GdldCb2E4dzAybmdkODhjMlBn?=
 =?utf-8?B?MGFacDFYRTZpdllrR1NhZ0tELzk3cTl1cU1kRldNTnZDUnNSeGhycDB4aEVE?=
 =?utf-8?B?YVpLL25DUEhQbUJKbC92YjlTdlpVaW13TmhNZWRjR2xnTkJIcXpwRFdkQlM2?=
 =?utf-8?B?dGxSc3p2WkdGd3g2WVZqcUtwOGRLeURMNlhHcU85MnRaRjZBbTBOMUJkYWdO?=
 =?utf-8?B?QUozZHAwVy9McWlqRFd5V0t4amhqdStvalB1UDRrR09mcUU0TzJXazlMOUdu?=
 =?utf-8?B?d3kyN2g1L29zbDZwVE5FTnJXT1FIcmFDZE5YQjg2ekhXaThocFVwRi9uVEJZ?=
 =?utf-8?B?L1NhN29ENUdaUERDdDVRaGUybVYyQllDdU51dlJ3U0dwaTJvUnpYL2ppZHho?=
 =?utf-8?B?U1FhaU1VY1d0MkhrTlFTMmtHMkhQWkpUcFpHQXNKOFoyM293THdUYW41Q1Zn?=
 =?utf-8?B?YzM1djlXTlIwV1dsMkZKMnFtSW1JRHZOdWVZMXYvampXRW9jMGpYNC9USFFn?=
 =?utf-8?B?a1diR1l5Q3NYRWhBMUM5QVpaMjA2WkF6d284S2hLQ2oxdGQrRG5lbHFseFA2?=
 =?utf-8?B?dHJJV1FuVE1CYlJSRHBHVU9PRHhabGRiRlB2R3ZYMHdyNzJxMW8wVE52UG9z?=
 =?utf-8?B?YjdaUnF2a0JMcUFoQllyS0dwVGo2ZVdadXlMQzFUdUhtckY5cThLcktCOTZR?=
 =?utf-8?Q?LAm4c782YjTLGckKBSd/Pl1h6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2666f8c-9f62-48ac-45ca-08db0cccc742
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2023 07:43:05.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZx9XKdkItkllGDUyI6KU3tHVlIPELYd+Qc8qHir1mhWdmHbnEmgPNUgWLejL9Uog4dKSittH+90zFl6jhaa3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9639
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSXVsaWFuYSwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDAvNl0gcmVtb3RlcHJvYzog
aW14X3Jwcm9jOiBzdXBwb3J0IGZpcm13YXJlIGluDQo+IEREUg0KPiANCj4gDQo+IE9uIDIvOS8y
MDIzIDg6MzggQU0sIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVjM6DQo+ID4NCj4gPiAgIERhbmllbCwgSXVsaWFu
YQ0KPiA+DQo+ID4gICAgIFBsZWFzZSBoZWxwIHJldmlldyB0aGlzIHBhdGNoc2V0IHBlciBNYXRo
aWV1J3MgY29tbWVudHMuDQo+ID4NCj4gPiAgIFRoYW5rcywNCj4gPiAgIFBlbmcuDQo+ID4NCj4g
PiAgIE1vdmUgcGF0Y2ggMyBpbiB2MiB0byAxc3QgcGF0Y2ggaW4gdjMgYW5kIGFkZCBGaXhlcyB0
YWcgUGVyIERhbmllbA0KPiA+ICAgSU1YX1JQUk9DX0FOWSBpbiBwYXRjaCAzIFBlciBNYXRoaWV1
DQo+ID4gICBVcGRhdGUgY29tbWVudCBhbmQgY29tbWl0IGxvZyBpbiBwYXRjaCA1LCA2Lg0KPiA+
DQo+ID4gICBOWFAgU0RLIHByb3ZpZGVzICIuaW50ZXJydXB0cyIgc2VjdGlvbiwgYnV0IEkgYW0g
bm90IHN1cmUgaG93IG90aGVycw0KPiA+ICAgYnVpbGQgdGhlIGZpcm13YXJlLiBTbyBJIHN0aWxs
IGtlZXAgcGF0Y2ggNiBhcyB2MiwgcmV0dXJuIGJvb3RhZGRyDQo+ID4gICBpZiB0aGVyZSBpcyBu
byAiLmludGVycnVwdHMiIHNlY3Rpb24uDQo+ID4NCj4gPiBWMjoNCj4gPiAgIHBhdGNoIDQgaXMg
aW50cm9kdWNlZCBmb3Igc3BhcnNlIGNoZWNrIHdhcm5pbmcgZml4DQo+ID4NCj4gPiBUaGlzIHBh
Y2hzZXQgaXMgdG8gc3VwcG9ydCBpLk1YOE0gYW5kIGkuTVg5MyBDb3J0ZXgtTSBjb3JlIGZpcm13
YXJlDQo+ID4gY291bGQgYmUgaW4gRERSLCBub3QganVzdCB0aGUgZGVmYXVsdCBUQ00uDQo+ID4N
Cj4gPiBpLk1YOE0gbmVlZHMgc3RhY2svcGMgdmFsdWUgYmUgc3RvcmVkIGluIFRDTUwgZW50cnkg
YWRkcmVzc1swLDRdLCB0aGUNCj4gPiBpbml0aWFsIHZhbHVlIGNvdWxkIGJlIGdvdCBmcm9tIGZp
cm13YXJlIGZpcnN0IHNlY3Rpb24gIi5pbnRlcnJ1cHRzIi4NCj4gPiBpLk1YOTMgaXMgYSBiaXQg
ZGlmZmVyZW50LCBpdCBqdXN0IG5lZWRzIHRoZSBhZGRyZXNzIG9mIC5pbnRlcnJ1cHRzDQo+ID4g
c2VjdGlvbi4gTlhQIFNESyBhbHdheXMgaGFzIC5pbnRlcnJ1cHRzIHNlY3Rpb24uDQo+ID4NCj4g
PiBTbyBmaXJzdCB3ZSBuZWVkIGZpbmQgdGhlIC5pbnRlcnJ1cHRzIHNlY3Rpb24gZnJvbSBmaXJt
d2FyZSwgc28gcGF0Y2gNCj4gPiAxIGlzIHRvIHJldXNlIHRoZSBjb2RlIG9mIGZpbmRfdGFibGUg
dG8gaW50cm9kdWNlIGEgbmV3IEFQSQ0KPiA+IHJwcm9jX2VsZl9maW5kX3NoZHIgdG8gZmluZCBz
aGRyLCB0aGUgaXQgY291bGQgcmV1c2VkIGJ5IGkuTVggZHJpdmVyLg0KPiA+DQo+ID4gUGF0Y2gg
MiBpcyBpbnRyb2R1Y2UgZGV2dHlwZSBmb3IgaS5NWDhNLzkzDQo+ID4NCj4gPiBBbHRob3VnaCBw
YXRjaCAzIGlzIGNvcnJlY3QgdGhlIG1hcHBpbmcsIGJ1dCB0aGlzIGFyZWEgd2FzIG5ldmVyIHVz
ZWQNCj4gPiBieSBOWFAgU1cgdGVhbSwgd2UgZGlyZWN0bHkgdXNlIHRoZSBERFIgcmVnaW9uLCBu
b3QgdGhlIGFsaWFzIHJlZ2lvbi4NCj4gPiBTaW5jZSB0aGlzIHBhdGNoc2V0IGlzIGZpcnN0IHRv
IHN1cHBvcnQgZmlybXdhcmUgaW4gRERSLCBtYXJrIHRoaXMNCj4gPiBwYXRjaCBhcyBhIGZpeCBk
b2VzIG5vdCBtYWtlIG11Y2ggc2Vuc2UuDQo+ID4NCj4gPiBwYXRjaCA0IGFuZCA1IGlzIHN1cHBv
cnQgaS5NWDhNLzkzIGZpcm13YXJlIGluIEREUiB3aXRoIHBhcnNpbmcNCj4gPiAuaW50ZXJydXB0
cyBzZWN0aW9uLiBEZXRhaWxlZCBpbmZvcm1hdGlvbiBpbiBlYWNoIHBhdGNoIGNvbW1pdCBtZXNz
YWdlLg0KPiA+DQo+ID4gUGF0Y2hlcyB3ZXJlIHRlc3RlZCBvbiBpLk1YOE1RLUVWSyBpLk1YOE1Q
LUVWSyBpLk1YOTMtMTF4MTEtRVZLDQo+IA0KPiBJZiBvbmUgY2FuIGJ1aWxkIHRoZWlyIGZpcm13
YXJlIGFzIHRoZXkgd2FudCwgdGhlbiB0aGUgLmludGVycnVwdCBzZWN0aW9uIGNhbg0KPiBhbHNv
IGJlIGNhbGxlZCBkaWZmZXJlbnRseS4NCj4gSSBkb24ndCB0aGluayBpcyBhIGdvb2QgaWRlYSB0
byBiYXNlIGFsbCB5b3VyIGltcGxlbWVudGF0aW9uIG9uIHRoaXMNCj4gYXNzdW1wdGlvbi4NCj4g
DQo+IEl0J3MgY2xlYXIgdGhlcmUncyBhIGxpbWl0YXRpb24gd2hlbiBsaW5raW5nIGZpcm13YXJl
IGluIEREUiwgc28gdGhpcyBzaG91bGQgYmUNCj4gd2VsbCBkb2N1bWVudGVkIHNvIG9uZSBjYW4g
Y29tcGlsZSB0aGVpciBmaXJtd2FyZSBhbmQgcHV0IHRoZSBuZWVkZWQNCj4gc2VjdGlvbiAoaW50
ZXJydXB0IGFzIHdlIGNhbGwgaXQgaW4gTlhQIFNESykgYWx3YXlzIGluIFRDTUwgLSBpbmRlcGVu
ZGVudGx5DQo+IHdoZXJlIHRoZSBvdGhlciBzZWN0aW9uIGdvLg0KDQpPaywgc28gLmludGVycnVw
dCBzZWN0aW9uIHNob3VsZCBiZSBhIG11c3QgaW4gZWxmIGZpbGUgaWYgSSB1bmRlcnN0YW5kIGNv
cnJlY3RseS4NCg0KSSBjb3VsZCBhZGQgYSBjaGVjayBpbiBWNCB0aGF0IGlmIC5pbnRlcnJ1cHQg
c2VjdGlvbiBpcyBub3QgdGhlcmUsIGRyaXZlciB3aWxsIHJlcG9ydA0KZmFpbHVyZS4NCg0KSG93
IGRvIHlvdSB0aGluaz8NCg0KVGhhbmtzLA0KUGVuZy4NCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBJ
dWxpYQ0KPiANCg0K
