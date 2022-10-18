Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129B7602593
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJRHWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiJRHWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:22:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBA8A220A;
        Tue, 18 Oct 2022 00:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dESwafWAoSZe+hTYxCx69rU6qDCaEERaMPirnfPXgOwpLxa5tgtk48BuSJ1CWUgYzBz5uYSkjw6XRvqDhJJ48XvppObaUZe0Czx2UtQIzyCOuREk6N2tN3fXrEGcjF95dASJdXFmpnwb0nXpe+3QsYC3R5Ub1UT7MggLPyYKDwNmC2ZxMpKR/0peCQqLTkymk3XwPXno81geiju1H4hI7iJw/gEvKqX3C2X+oEPNW/PGaKTKy2znrqoJkRfFK8iIM7dEWp0CW+Xe3RPggwDmno2xeOrW2enTsk9qUpyFn/h8pfxYd9n3nbru0xLJkj7/QxWGE0DjC2mRSyE+hiW+wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ir+aes5wt4snCSatK6TwBg1UVgrFY1NqeskLVLM9qW0=;
 b=BU8OeOwElSmKvmqP9fPN0MjmGCkjvNrWOA03TJ39mBh2FzJBPr+ZQQju0syaqM9j5fWzKgHLPao8ZXFITSgV04sbqvHBLjCdUpOdoqcq7uX88iDy2nlqCpNU9UAYfdox5nY9Xhsu687xppUPPiL72vmM24lhs+PhjnasLLDfy14k5hEBaAIhVv7I+WLDOFHw3ZM02b6xSE+aqSqQ1m/hvjhaKVmJRQcHGK6z9kF1ML8czc3tQv1vQaQRKVw0yb4/ROX7kZt013FlpShpveTXMjFaKVbziajuSTEzOVCV9DTDFnMeiH3fiSynCFgGM/qQFi4CLgR5PU1s2ujE63bYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ir+aes5wt4snCSatK6TwBg1UVgrFY1NqeskLVLM9qW0=;
 b=mbocU/86zIgoiLAC6Y4h9TzNgoJ1VjKCx/VYCX1Ge6QODu5R1dCkQMm1cu8y1YXaTe3Tt6vZ2/kD2U6LfhLEmOnaIwKW5s8myrfPDOVKpbTIAADFTIBfpzOkaK6HH0Opm2zcC49Wlk0SHt7kGeLVNjLlMGT+3w3TYZoQydoY65w=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM9PR04MB8082.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 07:22:04 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27%3]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 07:22:04 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Al Cooper <alcooperx@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: RE: [PATCH 3/5] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
Thread-Topic: [PATCH 3/5] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for CQHCI
Thread-Index: AQHY4qXI4evgK5YQ/UWXfJKB3iYUgq4TvNtw
Date:   Tue, 18 Oct 2022 07:22:04 +0000
Message-ID: <DB7PR04MB40107D412EC0DA5517E6CC4B90289@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221018035724.2061127-1-briannorris@chromium.org>
 <20221017205610.3.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
In-Reply-To: <20221017205610.3.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AM9PR04MB8082:EE_
x-ms-office365-filtering-correlation-id: cb98a607-6949-4e0b-68f7-08dab0d9753f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wU5c+QLLFRcTsNfL3sfnkdTxulHilnYgvrpb0Znxwks+V6EbKYGGoTQaNfFBd3R11SQWeUA6v0bRijsF0CO0C26JELmL2pgpMlndFwoqks9wruDU8qfu2XW9ZIoAw0Kme578torJ1suKykCDPa/nDHpWXSbjtU1gCP+mL1SvAqI0PpzpqJnr4LiVcEI/C31Lm5cpTbnDMKTEv4H2G3DrV18dF6DDX/oDNPKwfTdqJQD1c63oBxjAQNRnJcDTsOLvlb4bLwwejBkbzMqUGmNe98AC+DqdtZDksO0eY/b1UpAFuw4J7yURm0nFXyAkaOWJxzWqd8zC5zqQUZa8XB0tBYRYtCuzhPYm88UJS/SGyKa+Z5EAMPuAlbuauZqWdJACRFZP4rZfcCOGJdQhncyuu0xBBmA73JD7dUv14PeEw/Xj46a/x/YfR6w2PdIZT9mFEZD4p9h51yq7pEU+UOdKtdQJj8BI6mnc44ybCPcZTHJ3WfV/6Qr32+VQE5ZXBgf9X3vbXw3mMXrQ8yHaaO3ZZKzqsKoEwcC3mQBn/P9oWTAg72E3ybk8DklRDnJ94dlcVTmaFnx3c+sXkj+xFM8r2TgY3rlV15/KFfevtdTHkH+nHJLqLDkYivnYSYdZSBLRtVonyegUWelpPaDbQH4+vESRug/kKLzchX6fcp3F5xMKYT0F/j9XdUfMLORLfBDtK4hwQ6sIqntVIrlLXsWHYKFTxHl0B65U9yhcZDgfmU1Ujiu3go+o9g+D0YM1WEuwkr+ZL6BD5uBOCBJ53WOMsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(83380400001)(38070700005)(33656002)(86362001)(38100700002)(122000001)(52536014)(8936002)(5660300002)(66556008)(41300700001)(66946007)(66446008)(8676002)(7416002)(53546011)(4326008)(7696005)(2906002)(76116006)(66476007)(6506007)(110136005)(26005)(9686003)(54906003)(64756008)(316002)(478600001)(186003)(55016003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ajZ2R00vOGhjS1JVdVEzVVpZTWV5WG45M1hHQnIramRlU1ZEUXpKbk9ncnMz?=
 =?gb2312?B?czVSbGpXOXdNV1FXQStOWlg2YmsyallTdUV0WVVDQnd2ZEE1cnlCWWtvRmZE?=
 =?gb2312?B?UnlFWkxKZGdzM2ZBdSt2UTZGMHpYclZGWHJTYTRkSmVnenBmUGFvS3piVmJX?=
 =?gb2312?B?ZVp3Tk1EekhiSnpJdVM5RFdocXJZWEVHM3hMMnFQQ2c1TlJPTEdZc0VJNUNr?=
 =?gb2312?B?Y1pUQ3cyTHhpQmlyVENQTW1VU2J2UTl4TXVZUFZJeTNTY1F3S09xcGE5ODhF?=
 =?gb2312?B?NDVDckJHWkt3ZU9od2V1UjkvdjNVQ1JsaDVId1JlZTZFVkdUTG9JMUl2cXp4?=
 =?gb2312?B?aE1wYUM4czBOdTYranl5RU1TQ0dRWXJqQUk1N2p0UGoyR2k2RDV5TkRHcGkw?=
 =?gb2312?B?aHgxR0xYdEJvTkc1djJQWGpwR0hxTWFqYlphSEN6VDZMNENUQkdoVWhwSjlZ?=
 =?gb2312?B?YmUrVVFoRWpSZnl3OFNKcFl2emhiRUF4bVBOaituWWRTcDZIL0RxdHAzWXc1?=
 =?gb2312?B?eDd0WWZKVko1YUpvK0dUTFNCWi9XODZSaWUrSmswMW1WeXVRTmNoeUxXWVhV?=
 =?gb2312?B?eWdENzV5Q21xazNQWDFSVVYyUDlPcU1rTnFCVWo2em10d2hLbW1kZHN1RWdw?=
 =?gb2312?B?V3BTQzBwNExGdHpjK3pRWVdtSVhvUE1HTXJvWE9ReEhQVHU0SnM4QmVtZXpN?=
 =?gb2312?B?dUQ4cW5NQ3FxQkUrc3g4NjQ5L2EvbXZ4K1NWUzlVNTAvTUdBeHF1bHFsWHNS?=
 =?gb2312?B?NlVjNkZBQUNYZGhLTG51c1Rzckt6SmdlTDA5VEkyTi9ZNVptVlg0ZkRKMlU5?=
 =?gb2312?B?NXJEOFFBMk5wRDRjQnpVblUvRGx5MnVvYWo4c2t1VlVwRDA2em5Vbi9xN0hM?=
 =?gb2312?B?UjRBcWVrbHgwUEFvSnBYT2dtYmdaS0hxbEJkcnovaVRmS1RmdnY3Y1VWaC9t?=
 =?gb2312?B?S1JtN3I0N1RlVndjcHVIaXRkV1I4d3hNeE9VUEZWY1FMMXRwclNSaFQyQVFH?=
 =?gb2312?B?YkM3TDNwd1czNU1NN0M4NVoyWUVCWnNvNy82OG1XYXk3VzBTTEhXSXhYSVR4?=
 =?gb2312?B?SFIwcnp6clNLc1RQTkE1dGFIbUxwZ253bjNxaDRzTHRjeGlrVkNMSjdKL1dn?=
 =?gb2312?B?d0hIK0VLM0M3TmQ1aDA0Nk5yVG5MOSs4U1Z6RDd5cWdyT2hBRlpqQTVGYno1?=
 =?gb2312?B?QzUyb29ERW5scEVSZnBtcmd2ZEtFYW9tZXRzQVFKcm5wKy9tN0hmSmxmOU1B?=
 =?gb2312?B?NkJORUJ0WUFxTmYxRFQ0emtWdS9PMlBMaVpTUUc1cW5Wb0dkMVdlalBSNFhH?=
 =?gb2312?B?VFlWcDgvb3BpK25DeTNVRjMwM1VwL2drUC83OXJhcjBWK0VIT1I1OFFocVBi?=
 =?gb2312?B?VGNmY3ZVK2daVzMwTHI2Y2MvWDl0SU8vWk4zWjlFYUtJR2hNUUtBR08zY0h0?=
 =?gb2312?B?eVE4MlB2OWlHWHJOR2pxZFNjRGlJSGExZWlBM0JaMVpuQzBlOWJEcU9WOStn?=
 =?gb2312?B?RFZUK05ITStCMGo4aHZBV0VIdmxWWHRWUUlGRVVqdmYxeU1LQmFTSktvK05G?=
 =?gb2312?B?a2pMVTd3cGc5YTl0RW4zNlBDc3VDQkhwSnFuZ1dreUhwMGlOZm8rVHNTeVdK?=
 =?gb2312?B?VHRiQUx0aFdPMW1DWnQxSVJGUS9FbDJzYkdYWVVEUjRMeHBIeGNIQW1USlNz?=
 =?gb2312?B?Tk1JOFBhRWdkV0M3R2NvcDZReHZyY0VqMFQvWHlWcDUrTjl5YkplcDA4MGda?=
 =?gb2312?B?ZGdPdGlPWng4VG5xRkVjbFVMdXNYSldBQkluT09WNGpyd1ptRkFRenk5SnJj?=
 =?gb2312?B?bHVDc1M0VU1mbDVYblFRS2NWMWt3L29VZk9aTzBvMzUxSUtoRXkxWHNiTDR5?=
 =?gb2312?B?ZFZlbE1qRFRhYmNRZnRWRGhQTzVDMnVIVW5EWHBwbDFXVmk3RGxnbjNjMENV?=
 =?gb2312?B?L0tWYUdSS0hrNU5weVF1ZDFwcXZ3UkxUTEpBN0RRTTFrVHVMMVdSVEh1Q0Fh?=
 =?gb2312?B?VTZFN3hvcis5SFZXMWpuZW1Kb0x3RHMvYXFEN0lnWGFPSkVDak41dmt1YnF2?=
 =?gb2312?B?T3dLOHZYN2V2MFdtR2J6eFRseGhTTzRWTGR2VzJMbm9wY0hOZk5lOUtQVDJv?=
 =?gb2312?Q?PdU7js8c2Lnp7sv2TpcS0GQdN?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb98a607-6949-4e0b-68f7-08dab0d9753f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 07:22:04.7515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+JhrZOSPpqkqjmT++UJCc8rHfKAJxw2N2U4AbV4kLVlhdsuyZGyeiz3cJsmaCEnBX1CXTi78Gst8j3ygwTkNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmlhbiBOb3JyaXMgPGJyaWFu
bm9ycmlzQGNocm9taXVtLm9yZz4NCj4gU2VudDogMjAyMsTqMTDUwjE4yNUgMTE6NTcNCj4gVG86
IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBDYzogU2hhd24gTGluIDxz
aGF3bi5saW5Acm9jay1jaGlwcy5jb20+OyBBZHJpYW4gSHVudGVyDQo+IDxhZHJpYW4uaHVudGVy
QGludGVsLmNvbT47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IEZhYmlvDQo+IEVz
dGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IEZhaXogQWJiYXMgPGZhaXpfYWJiYXNAdGkuY29t
PjsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEJvdWdoIENoZW4gPGhhaWJv
LmNoZW5AbnhwLmNvbT47IEFsDQo+IENvb3BlciA8YWxjb29wZXJ4QGdtYWlsLmNvbT47IGxpbnV4
LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IFBlbmd1dHJvbml4DQo+IEtlcm5lbCBUZWFtIDxrZXJuZWxA
cGVuZ3V0cm9uaXguZGU+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBGbG9yaWFuDQo+
IEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNvbT47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBw
ZW5ndXRyb25peC5kZT47DQo+IFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0BnbWFpbC5j
b20+OyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPjsgSm9uYXRoYW4g
SHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT47DQo+IFNvd2phbnlhIEtvbWF0aW5lbmkgPHNr
b21hdGluZW5pQG52aWRpYS5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IEJyb2FkY29tIGludGVybmFsIGtlcm5lbCByZXZpZXcgbGlzdA0KPiA8YmNtLWtlcm5l
bC1mZWVkYmFjay1saXN0QGJyb2FkY29tLmNvbT47IEJyaWFuIE5vcnJpcw0KPiA8YnJpYW5ub3Jy
aXNAY2hyb21pdW0ub3JnPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMy81XSBtbXM6IHNkaGNpLWVzZGhj
LWlteDogRml4IFNESENJX1JFU0VUX0FMTCBmb3IgQ1FIQ0kNCj4gDQo+ICBbWyBOT1RFOiB0aGlz
IGlzIGNvbXBsZXRlbHkgdW50ZXN0ZWQgYnkgdGhlIGF1dGhvciwgYnV0IGluY2x1ZGVkIHNvbGVs
eQ0KPiAgICAgYmVjYXVzZSwgYXMgbm90ZWQgaW4gY29tbWl0IGRmNTdkNzMyNzZiOCAoIm1tYzog
c2RoY2ktcGNpOiBGaXgNCj4gICAgIFNESENJX1JFU0VUX0FMTCBmb3IgQ1FIQ0kgZm9yIEludGVs
IEdMSy1iYXNlZCBjb250cm9sbGVycyIpLCAib3RoZXINCj4gICAgIGRyaXZlcnMgdXNpbmcgQ1FI
Q0kgbWlnaHQgYmVuZWZpdCBmcm9tIGEgc2ltaWxhciBjaGFuZ2UsIGlmIHRoZXkNCj4gICAgIGFs
c28gaGF2ZSBDUUhDSSByZXNldCBieSBTREhDSV9SRVNFVF9BTEwuIiBXZSd2ZSBub3cgc2VlbiB0
aGUgc2FtZQ0KPiAgICAgYnVnIG9uIGF0IGxlYXN0IE1TTSwgQXJhc2FuLCBhbmQgSW50ZWwgaGFy
ZHdhcmUuIF1dDQo+IA0KPiBTREhDSV9SRVNFVF9BTEwgcmVzZXRzIHdpbGwgcmVzZXQgdGhlIGhh
cmR3YXJlIENRRSBzdGF0ZSwgYnV0IHdlIGFyZW4ndA0KPiB0cmFja2luZyB0aGF0IHByb3Blcmx5
IGluIHNvZnR3YXJlLiBXaGVuIG91dCBvZiBzeW5jLCB3ZSBtYXkgdHJpZ2dlciB2YXJpb3VzDQo+
IHRpbWVvdXRzLg0KPiANCj4gSXQncyBub3QgdHlwaWNhbCB0byBwZXJmb3JtIHJlc2V0cyB3aGls
ZSBDUUUgaXMgZW5hYmxlZCwgYnV0IHRoaXMgbWF5IG9jY3VyIGluDQo+IHNvbWUgc3VzcGVuZCBv
ciBlcnJvciByZWNvdmVyeSBzY2VuYXJpb3MuDQo+IA0KPiBGaXhlczogYmI2ZTM1ODE2OWJmICgi
bW1jOiBzZGhjaS1lc2RoYy1pbXg6IGFkZCBDTURRIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+IA0KPiAg
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDcgKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhj
LWlteC5jDQo+IGluZGV4IDU1OTgxYjBmMGIxMC4uMjIyYzgzOTI5ZTIwIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ICsrKyBiL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gQEAgLTEyODgsNiArMTI4OCwxMyBAQCBzdGF0aWMg
dm9pZCBlc2RoY19zZXRfdWhzX3NpZ25hbGluZyhzdHJ1Y3QNCj4gc2RoY2lfaG9zdCAqaG9zdCwg
dW5zaWduZWQgdGltaW5nKQ0KPiANCj4gIHN0YXRpYyB2b2lkIGVzZGhjX3Jlc2V0KHN0cnVjdCBz
ZGhjaV9ob3N0ICpob3N0LCB1OCBtYXNrKSAgew0KPiArCXN0cnVjdCBzZGhjaV9wbHRmbV9ob3N0
ICpwbHRmbV9ob3N0ID0gc2RoY2lfcHJpdihob3N0KTsNCj4gKwlzdHJ1Y3QgcGx0Zm1faW14X2Rh
dGEgKmlteF9kYXRhID0gc2RoY2lfcGx0Zm1fcHJpdihwbHRmbV9ob3N0KTsNCj4gKw0KPiArCWlm
ICgoaG9zdC0+bW1jLT5jYXBzMiAmIE1NQ19DQVAyX0NRRSkgJiYgKG1hc2sgJiBTREhDSV9SRVNF
VF9BTEwpDQo+ICYmDQo+ICsJICAgIGlteF9kYXRhLT5zb2NkYXRhLT5mbGFncyAmIEVTREhDX0ZM
QUdfQ1FIQ0kpDQoNCkkgdGhpbmsgd2UgY2FuIHJlbW92ZSB0aGUgY29uZGl0aW9uICIgaW14X2Rh
dGEtPnNvY2RhdGEtPmZsYWdzICYgRVNESENfRkxBR19DUUhDSSIgaGVyZS4NCkFjY29yZGluZyB0
byBjb2RlIGxvZ2ljLCBob3N0LT5tbWMtPmNhcHMyICYgTU1DX0NBUDJfQ1FFIG1lYW5zIGl0IGFs
cmVhZHkgY29udGFpbiBpbXhfZGF0YS0+c29jZGF0YS0+ZmxhZ3MgJiBFU0RIQ19GTEFHX0NRSENJ
DQoNCkJlc3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KDQoNCj4gKwkJY3FoY2lfZGVhY3RpdmF0ZSho
b3N0LT5tbWMpOw0KPiArDQo+ICAJc2RoY2lfcmVzZXQoaG9zdCwgbWFzayk7DQo+IA0KPiAgCXNk
aGNpX3dyaXRlbChob3N0LCBob3N0LT5pZXIsIFNESENJX0lOVF9FTkFCTEUpOw0KPiAtLQ0KPiAy
LjM4LjAuNDEzLmc3NDA0OGU0ZDllLWdvb2cNCg0K
